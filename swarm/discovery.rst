.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/swarm/discovery/
.. SOURCE: https://github.com/docker/swarm/blob/master/docs/discovery.md
   doc version: 1.11
      https://github.com/docker/swarm/commits/master/docs/discovery.md
.. check date: 2016/04/29
.. Commits on Mar 4, 2016 4b8ed91226a9a49c2acb7cb6fb07228b3fe10007
.. -------------------------------------------------------------------

.. Docker Swarm Discovery

.. _docker-swarm-discovery:

==============================
Docker Swarm ディスカバリ
==============================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Docker Swarm comes with multiple discovery backends. You use a hosted discovery service with Docker Swarm. The service maintains a list of IPs in your cluster. This page describes the different types of hosted discovery available to you. These are:

Docker Swarm は複数のディスカバリ・バックエンドに対応しています。Docker Swarm はホステット・ディスカバリ・サービス（hosted discovery service）が利用可能です。このサービスは クラスタ上の IP アドレスの一覧を保持します。このページでは利用可能な様々なホステット・ディスカバリを紹介します。

.. Using a distributed key/value store

.. _using-a-distributed-key-value-store:

分散キーバリュー・ストアの利用
==============================

.. The recommended way to do node discovery in Swarm is Docker’s libkv project. The libkv project is an abstraction layer over existing distributed key/value stores. As of this writing, the project supports:

Swarm でノードをディスカバリ（発見）するのに推奨される方法は、Docker による libkv プロジェクトの利用です。libkv プロジェクトとは既存の分散キーバリュー・ストア上の抽象化レイヤです。この原稿を書いている時点で、プロジェクトがサポートしているのは次の通りです。

..    Consul 0.5.1 or higher
    Etcd 2.0 or higher
    ZooKeeper 3.4.5 or higher

* Consul 0.5.1 以上
* Etcd 2.0 以上
* ZooKeeper 3.4.5 以上

.. For details about libkv and a detailed technical overview of the supported backends, refer to the libkv project.

libkv についてやサポートしているバックエンドに対する技術的な詳細は、 `libkv プロジェクト <https://github.com/docker/libkv>`_ をご覧ください。

.. Using a hosted discovery key store

.. _using-a-hosted-discovery-key-store:

ホステット・ディスカバリ・キーストアを使用
--------------------------------------------------

..    On each node, start the Swarm agent.

1. 各ノードで Swarm エージェントを起動します。

..    The node IP address doesn’t have to be public as long as the Swarm manager can access it. In a large cluster, the nodes joining swarm may trigger request spikes to discovery. For example, a large number of nodes are added by a script, or recovered from a network partition. This may result in discovery failure. You can use --delay option to specify a delay limit. Swarm join will add a random delay less than this limit to reduce pressure to discovery.

ノード の IP アドレスは Swarm マネージャがアクセス可能であれば十分であり、パブリックな IP アドレスを持つ必要はありません。大きなクラスタになれば、Swarm に対するノードの参加が、ディスカバリ時に過負荷となる可能性があります。例えば、沢山のノードをスクリプトで登録する場合や、ネットワーク障害から復旧する時です。この影響によりディスカバリが失敗するかもしれません。そのような場合は、 ``--delay`` オプションで遅延上限を指定できます。そうすると、Swarm への登録がランダムに遅延して行われますが、指定した時間を上回ることはありません。

**Etcd:**

.. code-block:: bash

   swarm join --advertise=<node_ip:2375> etcd://<etcd_addr1>,<etcd_addr2>/<optional path prefix>

**Consul:**

.. code-block:: bash

   swarm join --advertise=<node_ip:2375> consul://<consul_addr>/<optional path prefix>

**ZooKeeper:**

.. code-block:: bash

   swarm join --advertise=<node_ip:2375> zk://<zookeeper_addr1>,<zookeeper_addr2>/<optional path prefix>

.. Start the Swarm manager on any machine or your laptop.

2. Swarm マネージャをサーバもしくはノート PC 上で起動します。

**Etcd:**

.. code-block:: bash

   swarm manage -H tcp://<swarm_ip:swarm_port> etcd://<etcd_addr1>,<etcd_addr2>/<optional path prefix>

**Consul:**

.. code-block:: bash

   swarm manage -H tcp://<swarm_ip:swarm_port> consul://<consul_addr>/<optional path prefix>

**ZooKeeper:**

.. code-block:: bash

   swarm manage -H tcp://<swarm_ip:swarm_port> zk://<zookeeper_addr1>,<zookeeper_addr2>/<optional path prefix>

.. Use the regular Docker commands.

3. 通常の Docker コマンドを実行します。

.. code-block:: bash

   docker -H tcp://<swarm_ip:swarm_port> info
   docker -H tcp://<swarm_ip:swarm_port> run ...
   docker -H tcp://<swarm_ip:swarm_port> ps
   docker -H tcp://<swarm_ip:swarm_port> logs ...
   ...

.. Try listing the nodes in your cluster.

4. クラスタ上のノード一覧を表示します。

**Etcd:**

.. code-block:: bash

   swarm list etcd://<etcd_addr1>,<etcd_addr2>/<optional path prefix>
   <node_ip:2375>

**Consul:**

.. code-block:: bash

   swarm list consul://<consul_addr>/<optional path prefix>
   <node_ip:2375>

**ZooKeeper:**

.. code-block:: bash

   swarm list zk://<zookeeper_addr1>,<zookeeper_addr2>/<optional path prefix>
   <node_ip:2375>

.. Use TLS with distributed key/value discovery

.. _use-tls-with-distributed-key-value-discovery:

分散キーバリュー・ディスカバリに TLS を使う
--------------------------------------------------

.. You can securely talk to the distributed k/v store using TLS. To connect securely to the store, you must generate the certificates for a node when you join it to the swarm. You can only use with Consul and Etcd. The following example illustrates this with Consul:

分散キーバリュー・ストアと安全に通信できるようにするため、TLS を利用できます。ストアへ安全に接続するには、Swarm クラスタにノードが ``join`` （参加）する時に使う証明書を生成しなくてはいけません。証明書に対応しているのは Consul と Etcd のみです。以下は Consul を使う例です。

.. code-block:: bash

   swarm join \
       --advertise=<node_ip:2375> \
       --discovery-opt kv.cacertfile=/path/to/mycacert.pem \
       --discovery-opt kv.certfile=/path/to/mycert.pem \
       --discovery-opt kv.keyfile=/path/to/mykey.pem \
       consul://<consul_addr>/<optional path prefix>

.. This works the same way for the Swarm manage and list commands.

これは Swarm の ``manage`` と ``list`` コマンドを使う場合も同様です。

.. A static file or list of node

.. _a-static-file-or-list-of-node:

静的なファイルまたはノード・リスト
========================================

.. You can use a static file or list of nodes for your discovery backend. The file must be stored on a host that is accessible from the Swarm manager. You can also pass a node list as an option when you start Swarm.

ディスカバリ・バックエンドとして静的なファイルもしくはノードのリストを使えます。このファイルは Swarm マネージャがアクセス可能なホスト上に置く必要があります。あるいは、Swarm 起動時にオプションでノードのリストを指定することもできます。

.. Both the static file and the nodes option support a IP address ranges. To specify a range supply a pattern, for example, 10.0.0.[10:200] refers to nodes starting from 10.0.0.10 to 10.0.0.200. For example for the file discovery method.

静的なファイルあるいは ``nodes`` オプションは IP アドレスの範囲指定をサポートしています。特定のパターンで範囲を指定するには、例えば ``10.0.0.[10:200]`` を指定したら、 ``10.0.0.10`` から ``10.0.0.200`` までのノードを探そうとします。以下は ``file（ファイル）`` ディスカバリ手法を使う例です。

.. code-block:: bash

   $ echo "10.0.0.[11:100]:2375"   >> /tmp/my_cluster
   $ echo "10.0.1.[15:20]:2375"    >> /tmp/my_cluster
   $ echo "192.168.1.2:[2:20]375"  >> /tmp/my_cluster

.. Or with node discovery:

あるいはノードの直接指定でディスカバリするには、次のように実行します。

.. code-block:: bash

   swarm manage -H <swarm_ip:swarm_port> "nodes://10.0.0.[10:200]:2375,10.0.1.[2:250]:2375"

.. To create a file

.. _to-create-a-file:

ファイルを作成する場合
------------------------------

.. Edit the file and add line for each of your nodes.

1. ファイルを編集し、各行にノードの情報を追加します。

::

   echo <node_ip1:2375> >> /opt/my_cluster
   echo <node_ip2:2375> >> /opt/my_cluster
   echo <node_ip3:2375> >> /opt/my_cluster

.. This example creates a file named /tmp/my_cluster. You can use any name you like.

この例では ``/opt/my_cluster`` というファイルを作成しています。任意のファイル名を指定できます。

.. Start the Swarm manager on any machine.

2. Swarm マネージャを何らかのマシン上で実行します。

.. code-block:: bash

   swarm manage -H tcp://<swarm_ip:swarm_port> file:///tmp/my_cluster

.. Use the regular Docker commands.

3. 通常の Docker コマンドを使います。

.. code-block:: bash

   docker -H tcp://<swarm_ip:swarm_port> info
   docker -H tcp://<swarm_ip:swarm_port> run ...
   docker -H tcp://<swarm_ip:swarm_port> ps
   docker -H tcp://<swarm_ip:swarm_port> logs ...
   ...

.. List the nodes in your cluster.

4. クラスタ上のノード一覧を表示します。

   $ swarm list file:///tmp/my_cluster
   <node_ip1:2375>
   <node_ip2:2375>
   <node_ip3:2375>

.. To use a node list

ノード・リストを指定する場合
------------------------------

.. Start the manager on any machine or your laptop.

1. マシンもしくはノート PC 上でマネージャを起動します。

.. code-block:: bash

   swarm manage -H <swarm_ip:swarm_port> nodes://<node_ip1:2375>,<node_ip2:2375>

.. or

あるいは

.. code-block:: bash

   swarm manage -H <swarm_ip:swarm_port> <node_ip1:2375>,<node_ip2:2375>

.. Use the regular Docker commands.

2. 通常の Docker コマンドを実行します。

.. code-block:: bash

   docker -H <swarm_ip:swarm_port> info
   docker -H <swarm_ip:swarm_port> run ...
   docker -H <swarm_ip:swarm_port> ps
   docker -H <swarm_ip:swarm_port> logs ...

.. List the nodes in your cluster.

3. クラスタ上のノード一覧を表示します。

.. code-block:: bash

   $ swarm list file:///tmp/my_cluster
   <node_ip1:2375>
   <node_ip2:2375>
   <node_ip3:2375>

.. Warning: The Docker Hub Hosted Discovery Service is not recommended for production use. It’s intended to be used for testing/development. See the discovery backends for production use.

.. warning::

   Docker Hub ホステット・ディスカバリ・サービスはプロダクションでの利用が **推奨されていません** 。これはテストや開発環境での利用を想定しています。プロダクション環境においては、ディスカバリ・バックエンドの項目をご覧ください。

.. Hosted Discovery with Docker Hub

Docker Hub のホステッド・ディスカバリ
----------------------------------------

.. This example uses the hosted discovery service on Docker Hub. Using Docker Hub’s hosted discovery service requires that each node in the swarm is connected to the internet. To create your swarm:

この例は Docker Hub のホステッド・ディスカバリ・サービスを使います。Docker Hub のホステッド・ディスカバリ・サービスを使うには、インターネットに接続している必要があります。次のようにして Swarm クラスタを作成します。

.. Create a cluster.

1. まずクラスタを作成します。

.. code-block:: bash

   # クラスタを作成
   $ swarm create
   6856663cdefdec325839a4b7e1de38e8 # <- これが各自の <クラスタID> です

.. Create each node and join them to the cluster.

2. 各ノードを作成し、クラスタに追加します。

.. On each of your nodes, start the swarm agent. The doesn’t have to be public (eg. 192.168.0.X) but the the swarm manager must be able to access it.

各ノードで Swarm エージェントを起動します。Swarm Manager がアクセス可能であれば、<node_ip> はパブリックである必要はありません（例：192.168.0.x）。

.. code-block:: bash

   $ swarm join --advertise=<node_ip:2375> token://<cluster_id>

.. Start the Swarm manager.

3. Swarm マネージャを起動します。

.. This can be on any machine or even your laptop.

これはあらゆるマシン上だけでなく、自分のノート PC 上でも実行できます。

.. code-block:: bash

   $ swarm manage -H tcp://<swarm_ip:swarm_port> token://<cluster_id>

.. Use regular Docker commands to interact with your cluster.

4. 通常の Docker コマンドでクラスタと通信します。

.. code-block:: bash

   docker -H tcp://<swarm_ip:swarm_port> info
   docker -H tcp://<swarm_ip:swarm_port> run ...
   docker -H tcp://<swarm_ip:swarm_port> ps
   docker -H tcp://<swarm_ip:swarm_port> logs ...
   ...

.. List the nodes in your cluster.

5. クラスタのノード情報一覧を表示します。

.. code-block:: bash

   swarm list token://<cluster_id>
   <node_ip:2375>


.. Contributing a new discovery backend

新しいディスカバリ・バックエンドに貢献
========================================

.. You can contribute a new discovery backend to Swarm. For information on how to do this, see our discovery README in the Docker Swarm repository.

あなたも Swarm 向けに新しいディスカバリ・バックエンドに貢献できます。どのようにするかは、 `Docker Swarm リポジトリにある discovery README <https://github.com/docker/swarm/blob/master/discovery/README.md>`_ をお読みください。

.. Docker Swarm documentation index

Docker Swarm ドキュメント目次
==============================

..    Docker Swarm overview
    Scheduler strategies
    Scheduler filters
    Swarm API

* :doc:`overview`
* :doc:`scheduler/strategy`
* :doc:`scheduler/filter`
* :doc:`swarm-api`

.. seealso:: 

   Docker Swarm Discovery
      https://docs.docker.com/swarm/discovery/

