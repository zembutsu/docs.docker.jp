.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/swarm/multi-manager-setup/
.. SOURCE: https://github.com/docker/swarm/blob/master/docs/multi-manager-setup.md
   doc version: 1.11
      https://github.com/docker/swarm/commits/master/docs/multi-manager-setup.md
.. check date: 2016/04/29
.. Commits on Mar 12, 2016 2d7c5942702d7cd383d25ee5cec96314b1d67c0a
.. -------------------------------------------------------------------

.. High availability in Docker Swarm

==============================
Docker Swarm の高可用性
==============================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. In Docker Swarm, the Swarm manager is responsible for the entire cluster and manages the resources of multiple Docker hosts at scale. If the Swarm manager dies, you must create a new one and deal with an interruption of service.

Docker Swarm の **Swarm マネージャ** は、クラスタ全体に対する責任を持ち、スケール時は複数 *Docker ホスト* のリソースを管理します。もし Swarm マネージャが停止したら、新しいマネージャを作成し、サービス中断に対処しなくてはいけません。

.. The *High Availability* feature allow a Docker Swarm to gracefully handle the failover of a manager instance. Using this feature, you can create a single **primary manager** instance and multiple **replica** instances.

*高可用性 (High Availability )* 機能により、Docker Swarm は管理インスタンスのフェイルオーバを丁寧に処理します。この機能を使うには、 **プライマリ・マネージャ (primary manager)** を作成し、複数の **レプリカ (replica)** インスタンスを作成できます。

.. A primary manager is the main point of contact with the Docker Swarm cluster. You can also create and talk to replica instance that will act as backups. Requests issued on a replica are automatically proxied to the primary manager. If the primary manager fails, a replica takes away the lead. In this way, you always keep a point of contact with the cluster.

プライマリ・マネージャは、Docker Swarm クラスタとの主な接点です。また、バックアップに用いるレプリカ・インスタンスの作成・通信もできます。レプリカにリクエストすると、プライマリ・マネージャを自動的にプロキシします。プライマリ・マネージャで障害が起これば、レプリカが主導権を取ります。このような方法で、クラスタと通信し続けられます。

.. Setup primary and replicas

プライマリとレプリカのセットアップ
========================================

.. This section explains how to setup Docker Swarm using multiple **manager**s.

このセクションは、複数の **マネージャ** を使って Docker Swarm をセットアップする方法を説明します。

.. Assumptions

前提条件
----------

.. You need either a ``Consul`` , ``etcd``, or ``Zookeeper`` cluster. This procedure is written assuming a Consul server running on address 192.168.42.10:8500. The sample swam configuration has three machines:

ここでは ``Consul`` 、 ``etcd`` 、``Zookeeper`` クラスタのいずれかが必要です。今回の手順では、 ``Consul`` サーバが ``192.168.42.10:8500`` で動作しているものと想定します。サンプルの Swarm は３台のマシンで構成されているものとします。

* ``manager-1`` は ``192.168.42.200`` 上で動作
* ``manager-2`` は ``192.168.42.201`` 上で動作
* ``manager-3`` は ``192.168.42.202`` 上で動作

.. Create the primary manager

プライマリ・マネージャの作成
------------------------------

.. You use the ``swarm manage`` command with the ``--replication`` and ``--advertise`` flags to create a primary manager.

``swarm manager`` コマンドで ``--replication`` と ``--advertise`` フラグを指定し、プライマリ・マネージャを作成します。

.. code-block:: bash

   user@manager-1 $ swarm manage -H :4000 <tls-config-flags> --replication --advertise 192.168.42.200:4000 consul://192.168.42.10:8500/nodes
   INFO[0000] Listening for HTTP addr=:4000 proto=tcp
   INFO[0000] Cluster leadership acquired
   INFO[0000] New leader elected: 192.168.42.200:4000
   [...]


.. The --replication flag tells Swarm that the manager is part of a multi-manager configuration and that this primary manager competes with other manager instances for the primary role. The primary manager has the authority to manage cluster, replicate logs, and replicate events happening inside the cluster.

``--replication`` フラグは、Swarm に対して複数のマネージャ設定における一部であると伝えます。また、このプライマリ・マネージャは、他のプライマリの役割を持つマネージャ・インスタンスと競合します。プライマリ・マネージャとは、クラスタ管理の権限を持ち、ログを複製し、クラスタ内で発生したイベントを複製します。

.. The ``--advertise`` option specifies the primary manager address. Swarm uses this address to advertise to the cluster when the node is elected as the primary. As you see in the command's output, the address you provided now appears to be the one of the elected Primary manager.

``--advertise`` オプションは、プライマリ・マネージャのアドレスを指定します。ノードがプライマリに選ばれた時、Swarm はこのアドレスをクラスタの通知用（advertise）に使います。先ほどのコマンド出力から分かるように、新しく選ばれたプライマリ・マネージャは指定したアドレスを使います。

.. Create two replicas

２つのレプリカ（複製）を作成
------------------------------

.. Now that you have a primary manager, you can create replicates.

プライマリ・マネージャを作ったら、次はレプリカを作成できます。

.. code-block:: bash

   user@manager-2 $ swarm manage -H :4000 <tls-config-flags> --replication --advertise 192.168.42.201:4000 consul://192.168.42.10:8500/nodes
   INFO[0000] Listening for HTTP                            addr=:4000 proto=tcp
   INFO[0000] Cluster leadership lost
   INFO[0000] New leader elected: 192.168.42.200:4000
   [...]

.. This command creates a replica manager on 192.168.42.201:4000 which is looking at 192.168.42.200:4000 as the primary manager.

このコマンドは ``192.168.42.201:4000`` 上にレプリカ・マネージャを作成します。これは ``192.168.42.200:4000`` をプライマリ・マネージャとみなしています。

.. Create an additional, third manager instance:

追加で、 *３つめ* のマネージャ・インスタンスを作成します。

.. code-block:: bash

   user@manager-3 $ swarm manage -H :4000 <tls-config-flags> --replication --advertise 192.168.42.202:4000 consul://192.168.42.10:8500/nodes
   INFO[0000] Listening for HTTP                            addr=:4000 proto=tcp
   INFO[0000] Cluster leadership lost
   INFO[0000] New leader elected: 192.168.42.200:4000
   [...]

.. Once you have established your primary manager and the replicas, create Swarm agents as you normally would.

プライマリ・マネージャとレプリカを構成した後は、通常通りに **Swarm エージェント** を作成できます。

.. List machines in the cluster

クラスタ内のマシン一覧
------------------------------

.. Typing docker info should give you an output similar to the following:

``docker info`` を実行したら、次のような出力が得られます。

.. code-block:: bash

   user@my-machine $ export DOCKER_HOST=192.168.42.200:4000 # manager-1 を指し示す
   user@my-machine $ docker info
   Containers: 0
   Images: 25
   Storage Driver:
   Role: Primary  <--------- manager-1 is the Primary manager
   Primary: 192.168.42.200
   Strategy: spread
   Filters: affinity, health, constraint, port, dependency
   Nodes: 3
    swarm-agent-0: 192.168.42.100:2375
     └ Containers: 0
     └ Reserved CPUs: 0 / 1
     └ Reserved Memory: 0 B / 2.053 GiB
     └ Labels: executiondriver=native-0.2, kernelversion=3.13.0-49-generic, operatingsystem=Ubuntu 14.04.2 LTS, storagedriver=aufs
    swarm-agent-1: 192.168.42.101:2375
     └ Containers: 0
     └ Reserved CPUs: 0 / 1
     └ Reserved Memory: 0 B / 2.053 GiB
     └ Labels: executiondriver=native-0.2, kernelversion=3.13.0-49-generic, operatingsystem=Ubuntu 14.04.2 LTS, storagedriver=aufs
    swarm-agent-2: 192.168.42.102:2375
     └ Containers: 0
     └ Reserved CPUs: 0 / 1
     └ Reserved Memory: 0 B / 2.053 GiB
     └ Labels: executiondriver=native-0.2, kernelversion=3.13.0-49-generic, operatingsystem=Ubuntu 14.04.2 LTS, storagedriver=aufs
   Execution Driver:
   Kernel Version:
   Operating System:
   CPUs: 3
   Total Memory: 6.158 GiB
   Name:
   ID:
   Http Proxy:
   Https Proxy:
   No Proxy:

.. This information shows that manager-1 is the current primary and supplies the address to use to contact this primary.

この情報は ``manager-1`` が現在のプライマリであると示しています。そして、このプライマリへ接続するのに使うアドレスが表示されています。

.. Test the failover mechanism

フェイルオーバ動作のテスト
==============================

.. To test the failover mechanism, you shut down the designated primary manager. Issue a Ctrl-C or kill the current primary manager (manager-1) to shut it down.

フェイルオーバ動作をテストするには、特定のプライマリ・マネージャを停止します。 ``Ctrl-C`` や ``kill`` を実行したら、現在のプライマリ・マネージャ（ ``manager-1`` ）は停止します。

.. Wait for automated failover

自動フェイルオーバを待つ
------------------------------

.. After a short time, the other instances detect the failure and a replica takes the lead to become the primary manager.

直後に、他のインスタンスが障害を検出し、レプリカがプライマリ・マネージャの主導権を得ます。

.. For example, look at manager-2’s logs:

例えば、 ``manager-2`` のログを確認します。

.. code-block:: bash

   user@manager-2 $ swarm manage -H :4000 <tls-config-flags> --replication --advertise 192.168.42.201:4000 consul://192.168.42.10:8500/nodes
   INFO[0000] Listening for HTTP                            addr=:4000 proto=tcp
   INFO[0000] Cluster leadership lost
   INFO[0000] New leader elected: 192.168.42.200:4000
   INFO[0038] New leader elected: 192.168.42.201:4000
   INFO[0038] Cluster leadership acquired               <--- 新しいプライマリ・マネージャに選出された
   [...]

.. Because the primary manager, manager-1, failed right after it was elected, the replica with the address 192.168.42.201:4000, manager-2, recognized the failure and attempted to take away the lead. Because manager-2 was fast enough, the process was effectively elected as the primary manager. As a result, manager-2 became the primary manager of the cluster.

これはプライマリ・マネージャ ``manager-1`` で障害が発生しました。その後、 ``192.168.42.201:4000`` のアドレスを持つ ``manager-2`` のレプリカが障害を検出したため、主導権を（manager-1から）取り上げてリーダーに選出されました。理由は ``manager-2`` は十分な速さで、プライマリ・マネージャとして選出手続きを実質的に行ったからです。その結果、 ``manager-2`` がクラスタ上のプライマリ・マネージャになりました。

.. If we take a look at manager-3 we should see those logs:

``manager-3`` を見れば、次のような ログが表示されるでしょう。

.. code-block:: bash

   user@manager-3 $ swarm manage -H :4000 <tls-config-flags> --replication --advertise 192.168.42.202:4000 consul://192.168.42.10:8500/nodes
   INFO[0000] Listening for HTTP                            addr=:4000 proto=tcp
   INFO[0000] Cluster leadership lost
   INFO[0000] New leader elected: 192.168.42.200:4000
   INFO[0036] New leader elected: 192.168.42.201:4000   <--- manager-2 が新しいプライマリ・マネージャに
   [...]

.. At this point, we need to export the new DOCKER_HOST value.

この時点で、新しい ``DOCKER_HOST`` の値を指定する必要があります。

.. Switch the primary

プライマリに切り替え
------------------------------

.. To switch the DOCKER_HOST to use manager-2 as the primary, you do the following:

``DOCKER_HOST`` をプライマリとしての ``manager-2`` に切り替えるには、次のようにします。

.. code-block:: bash

   user@my-machine $ export DOCKER_HOST=192.168.42.201:4000 # manager-2 を指定
   user@my-machine $ docker info
   Containers: 0
   Images: 25
   Storage Driver:
   Role: Replica  <--------- manager-2 はレプリカ
   Primary: 192.168.42.200
   Strategy: spread
   Filters: affinity, health, constraint, port, dependency
   Nodes: 3

.. You can use the docker command on any Docker Swarm primary manager or any replica.

``docker`` コマンドは Docker Swarm プライマリ・マネージャ、あるいは、あらゆるレプリカ上で実行できます。

.. If you like, you can use custom mechanisms to always point DOCKER_HOST to the current primary manager. Then, you never lose contact with your Docker Swarm in the event of a failover.

好みによって、 何らかの仕組みを使うことにより、``DOCKER_HOST`` が現在のプライマリ・マネージャを常に示すよう にも可能です。そうしておけば、フェイルオーバ発生の度に、Docker Swarm に対する接続を失うことは無いでしょう。

.. seealso:: 

   High availability in Docker Swarm
      https://docs.docker.com/swarm/multi-manager-setup/

