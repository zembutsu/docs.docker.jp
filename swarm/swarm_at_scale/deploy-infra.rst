.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/swarm/swarm_at_scale/deploy-infra/
.. SOURCE: https://github.com/docker/swarm/blob/master/docs/swarm_at_scale/deploy-infra.md
   doc version: 1.11
      https://github.com/docker/swarm/commits/master/docs/swarm_at_scale/deploy-infra.md
.. check date: 2016/04/24
.. Commits on Apr 29, 2016 354a71b4cfc675d579430b193aa0910ad4b4911b
.. -------------------------------------------------------------------

.. Deploy your infrastructure

====================
インフラのデプロイ
====================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. In this step, you create several Docker hosts to run your application stack on. Before you continue, make sure you have taken the time to learn the application architecture

このステップでは、複数の Docker ホストを作成し、そこでアプリケーション・スタックを実行します。進める前に、 :doc:`アプリケーション・アーキテクチャを学ぶ <about>` 必要があります。

.. About these instructions

.. _about-these-instructions:

構築手順について
====================

.. This example assumes you are running on a Mac or Windows system and enabling Docker Engine docker commands by provisioning local VirtualBox virtual machines thru Docker Machine. For this evaluation installation, you’ll need 6 (six) VirtualBox VMs.

以降のサンプルを実行する想定システムは、Mac あるいは Windows です。システム上で Docker Machine を経由して VirtualBox 仮想マシンをローカルにプロビジョニングし、Docker Engine の ``docker`` コマンドを使えるようにします。作業は６つの VirtualBox 仮想マシンをインストールします。

.. While this example uses Docker Machine, this is only one example of an infrastructure you can use. You can create the environment design on whatever infrastructure you wish. For example, you could place the application on another public cloud platform such as Azure or DigitalOcean, on premises in your data center, or even in in a test environment on your laptop.

今回のサンプルでは Docker Machine を使いますが、任意のインフラ上で実行できます。希望するインフラ上であれば、どこでも環境を構築できる設計です。例えば、Azure や Digital Ocean などのようなパブリックのクラウド・プラットフォーム上で実行できるだけでなく、データセンタ上のオンプレミスや、ノート PC 上のテスト環境ですら動かせます。

.. Finally, these instructions use some common bash command substituion techniques to resolve some values, for example:

なお、これら手順では複数の値を設定するにあたり、一般的な ``bash`` コマンド代入技術を使います。次のコマンドを例に考えましょう。

.. code-block:: bash

   $ eval $(docker-machine env keystore)

.. In a Windows environment, these substituation fail. If you are running in Windows, replace the substitution $(docker-machine env keystore) with the actual value.

Windows 環境では、このような代入指定に失敗します。Widows 上で実行する場合は、この ``$(docker-machine env keystore)`` を実際の値に置き換えてください。

.. _task1-create-the-keystore-server:

.. Task 1. Create the keystore server

タスク１：keystore （キーストア）サーバの作成
==================================================

.. To enable a Docker container network and Swarm discovery, you must supply deploy a key-value store. As a discovery backend, the keystore maintains an up-to-date list of cluster members and shares that list with the Swarm manager. The Swarm manager uses this list to assign tasks to the nodes.

Docker コンテナ・ネットワークと Swarm ディスカバリを有効化するために、キーバリュー・ストアのデプロイが必要です。キーストアはディスカバリ・バックエンドとして、Swarm マネージャが使うクラスタのメンバ一覧を常に更新し続けます。Swarm マネージャはこの一覧を使い、ノードにタスクを割り当てます。

.. An overlay network requires a key-value store. The key-value store holds information about the network state which includes discovery, networks, endpoints, IP addresses, and more.

オーバレイ・ネットワークはキーバリュー・ストアが必要です。キーバリュー・ストアはネットワーク状態を保持するために使います。ネットワーク状態には、ディスカバリ、ネットワーク、エンドポイント、IP アドレス等を含みます。

.. Several different backends are supported. This example uses Consul container.

様々なバックエンドをサポートしています。今回のサンプルでは `Consul <https://www.consul.io/>`_ コンテナを使います。

..    Create a “machine” named keystore.

1. ``keystore`` という名称の「マシン」を作成します。

.. code-block:: bash

   $ docker-machine create -d virtualbox --virtualbox-memory "2000" \
   --engine-opt="label=com.function=consul"  keystore

..    You can set options for the Engine daemon with the --engine-opt flag. You’ll use it to label this Engine instance.

Engine デーモンにオプションを指定するには ``--engine-opt`` フラグを使います。Engine インスタンスをラベル付けするのに使います。

..    Set your local shell to the keystore Docker host.

2. ローカルのシェルを ``keystore`` Docker ホストに接続します。

.. code-block:: bash

   $ eval $(docker-machine env keystore)

..    Run the consul container.

3. ``consul`` `コンテナ <https://hub.docker.com/r/progrium/consul/>`_ を起動します。

.. code-block:: bash

   $ docker run --restart=unless-stopped -d -p 8500:8500 -h consul progrium/consul -server -bootstrap

..    The -p flag publishes port 8500 on the container which is where the Consul server listens. The server also has several other ports exposed which you can see by running docker ps.

``-p`` フラグはコンテナ上のポート 8500 を公開します。これは Consul サーバがリッスンするためです。また、サーバ上では他のポートも公開します。確認するには ``docker ps`` コマンドを使います。

.. code-block:: bash

   $ docker ps
   CONTAINER ID        IMAGE               ...       PORTS                                                                            NAMES
   372ffcbc96ed        progrium/consul     ...       53/tcp, 53/udp, 8300-8302/tcp, 8400/tcp, 8301-8302/udp, 0.0.0.0:8500->8500/tcp   dreamy_ptolemy

..    Use a curl command test the server by listing the nodes.

4. ``curl`` コマンドを使い、ノードが応答するかテストします。

.. code-block:: bash

   $ curl $(docker-machine ip keystore):8500/v1/catalog/nodes
   [{"Node":"consul","Address":"172.17.0.2"}]

.. Task 2. Create the Swarm manager

.. _task2-create-the-swarm-manager:

タスク２：Swarm マネージャの作成
========================================

.. In this step, you create the Swarm manager and connect it to the keystore instance. The Swarm manager container is the heart of your Swarm cluster. It is responsible for receiving all Docker commands sent to the cluster, and for scheduling resources against the cluster. In a real-world production deployment, you should configure additional replica Swarm managers as secondaries for high availability (HA).

このステップでは、Swarm マネージャを作成し、 ``keystore`` インスタンスに接続します。Swarm マネージャ・コンテナは Swarm クラスタの心臓部です。Docker コマンドを受け取り、クラスタに送り、クラスタ間のスケジューリングをする役割を持ちます。実際のプロダクションへのデプロイでは、高可用性(HA)のためにセカンダリの Swarm レプリカ・マネージャを設定すべきでしょう。

.. You’ll use the --eng-opt flag to set the cluster-store and cluster-advertise options to refer to the keystore server. These options support the container network you’ll create later.

``--eng-opt`` フラグを使い ``cluster-store`` と ``cluster-advertise``  オプションが ``keystore`` サーバを参照するようにします。これらのオプションは後にコンテナ・ネットワークの作成時に使います。

..    Create the manager host.

1. ``manager`` ホストを作成します。

.. code-block:: bash

   $ docker-machine create -d virtualbox --virtualbox-memory "2000" \
   --engine-opt="label=com.function=manager" \
   --engine-opt="cluster-store=consul://$(docker-machine ip keystore):8500" \
   --engine-opt="cluster-advertise=eth1:2376" manager

..    You also give the daemon a manager label.

デーモンに対して ``manager`` ラベルも指定します。

..    Set your local shell to the manager Docker host.

2. ローカルのシェルを ``manager`` Docker ホストに向けます。

.. code-block:: bash

   $ eval $(docker-machine env manager)

..    Start the Swarm manager process.

3. Swarm マネージャのプロセスを開始します。

.. code-block:: bash

   $ docker run --restart=unless-stopped -d -p 3376:2375 \
   -v /var/lib/boot2docker:/certs:ro \
   swarm manage --tlsverify \
   --tlscacert=/certs/ca.pem \
   --tlscert=/certs/server.pem \
   --tlskey=/certs/server-key.pem \
   consul://$(docker-machine ip keystore):8500

..    This command uses the TLS certificates created for the boot2docker.iso or the manager. This is key for the manager when it connects to other machines in the cluster.

このコマンドは ``boot2docker.iso`` あるいはマネージャ用の TLS 証明書を作成します。これはクラスタ上の他マシンにマネージャが接続する時に使います。

..    Test your work by using displaying the Docker daemon logs from the host.

4. ホスト上で Docker デーモンのログを参照し、正常に動いているか確認します。

.. code-block:: bash

   $ docker-machine ssh manager
   <-- 出力を省略 -->
   docker@manager:~$ tail /var/lib/boot2docker/docker.log
   time="2016-04-06T23:11:56.481947896Z" level=debug msg="Calling GET /v1.15/version"
   time="2016-04-06T23:11:56.481984742Z" level=debug msg="GET /v1.15/version"
   time="2016-04-06T23:12:13.070231761Z" level=debug msg="Watch triggered with 1 nodes" discovery=consul
   time="2016-04-06T23:12:33.069387215Z" level=debug msg="Watch triggered with 1 nodes" discovery=consul
   time="2016-04-06T23:12:53.069471308Z" level=debug msg="Watch triggered with 1 nodes" discovery=consul
   time="2016-04-06T23:13:13.069512320Z" level=debug msg="Watch triggered with 1 nodes" discovery=consul
   time="2016-04-06T23:13:33.070021418Z" level=debug msg="Watch triggered with 1 nodes" discovery=consul
   time="2016-04-06T23:13:53.069395005Z" level=debug msg="Watch triggered with 1 nodes" discovery=consul
   time="2016-04-06T23:14:13.071417551Z" level=debug msg="Watch triggered with 1 nodes" discovery=consul
   time="2016-04-06T23:14:33.069843647Z" level=debug msg="Watch triggered with 1 nodes" discovery=consul

..    The output indicates that the consul and the manager are communicating correctly.

出力内容から ``consul`` と ``manager`` が正常に通信できているのが分かります。

..    Exit the Docker host.

5. Docker ホストから抜けます。

.. code-block:: bash

   docker@manager:~$ exit

.. Task 3. Add the load balancer

.. _task3-add-the-load-balancer:

タスク３：ロードバランサの追加
==============================

.. The application uses an Interlock and an Nginx as a loadblancer. Before you build the load balancer host, you’ll create the cnofiguration you’ll use for Nginx.

`Interlock <https://github.com/ehazlett/interlock>`_ アプリケーションと Nginx をロードバランサとして使います。ロードバランサ用のホストを作る前に、Nginx で使う設定を作成します。

..    On your local host, create a config diretory.

1. ローカルホスト上に ``config`` ディレクトリを作成します。

..    Change to config directory.

2. ``config`` ディレクトリに変更します。

.. code-block:: bash

   $ cd config

..    Get the IP address of the Swarm manager host.

3. Swarm マネージャ・ホストの IP アドレスを取得します。

..    For example:

例：

.. code-block:: bash

   $ docker-machine ip manager
   192.168.99.101

..    Use your favorte editor to create a config.toml file and add this content to the file:

4. 任意のエディタで ``config.toml`` ファイルを作成し、次の内容をファイルに書き込みます。

.. code-block:: bash

   ListenAddr = ":8080"
   DockerURL = "tcp://SWARM_MANAGER_IP:3376"
   TLSCACert = "/var/lib/boot2docker/ca.pem"
   TLSCert = "/var/lib/boot2docker/server.pem"
   TLSKey = "/var/lib/boot2docker/server-key.pem"
   
   [[Extensions]]
   Name = "nginx"
   ConfigPath = "/etc/conf/nginx.conf"
   PidPath = "/etc/conf/nginx.pid"
   MaxConn = 1024
   Port = 80

..    In the configuration, replace the SWARM_MANAGER_IP with the manager IP you got in Step 4.

5. 設定ファイルにおいて、 ``SWARM_MANAGE_IP`` は手順３で取得した ``manager`` の IP アドレスに書き換えてください。

..    You use this value because the load balancer listens on the manager’s event stream.

この値はロードバランサがマネージャのイベント・ストリームを受信するために使います。

..    Save and close the config.toml file.

6. ``config.toml`` ファイルを保存して閉じます。

..    Create a machine for the load balancer.

7. ロードバランサ用にマシンを作成します。

.. code-block:: bash

   $ docker-machine create -d virtualbox --virtualbox-memory "2000" \
   --engine-opt="label=com.function=interlock" loadbalancer

..    Switch the environment to the loadbalancer.

8. 環境を ``loadbalancer`` に切り替えます。

.. code-block:: bash

   $ eval $(docker-machine env loadbalancer)

..   Start an interlock container running.

9. ``interlock`` コンテナを起動します。

.. code-block:: bash

   $ docker run \
       -P \
       -d \
       -ti \
       -v nginx:/etc/conf \
       -v /var/lib/boot2docker:/var/lib/boot2docker:ro \
       -v /var/run/docker.sock:/var/run/docker.sock \
       -v $(pwd)/config.toml:/etc/config.toml \
       --name interlock \
       ehazlett/interlock:1.0.1 \
       -D run -c /etc/config.toml

..    This command relies on the config.toml file being in the current directory. After running the command, confirm the image is runing:

このコマンドは現在のディレクトリにある ``config.toml`` ファイルを読み込みます。コマンド実行後、イメージを実行しているのを確認します。

.. code-block:: bash

   $ docker ps
   CONTAINER ID        IMAGE                      COMMAND                  CREATED             STATUS              PORTS                     NAMES
   d846b801a978        ehazlett/interlock:1.0.1   "/bin/interlock -D ru"   2 minutes ago       Up 2 minutes        0.0.0.0:32770->8080/tcp   interlock

..    If you don’t see the image runing, use docker ps -a to list all images to make sure the system attempted to start the image. Then, get the logs to see why the container failed to start.

イメージが実行中でなければ、 ``docker ps -a`` を実行してシステム上で起動した全てのイメージを表示します。そして、コンテナが起動に失敗していれば、ログを取得できます。

.. code-block:: bash

   $ docker logs interlock
   INFO[0000] interlock 1.0.1 (000291d)
   DEBU[0000] loading config from: /etc/config.toml
   FATA[0000] read /etc/config.toml: is a directory

..    This error usually means you weren’t starting the docker run from the same config directory where the config.toml fie is. If you run the coammand and get a Conflict error such as:

このエラーであれば、通常は ``config.toml`` ファイルがある同じ ``config`` ディレクトリ内で ``docker run`` を実行したのが原因でしょう。コマンドを実行し、次のような衝突が表示する場合があります。

.. code-block:: bash

   docker: Error response from daemon: Conflict. The name "/interlock" is already in use by container d846b801a978c76979d46a839bb05c26d2ab949ff9f4f740b06b5e2564bae958. You have to remove (or rename) that container to be able to reuse that name.

..    Remove the interlock container with the docker rm interlock and try again.

このような時は、 ``docker rm interlock`` で interlock コンテナを削除し、再度試みてください。

..    Start an nginx container on the load balancer.

10. ロードバランサ上で ``nginx`` コンテナを起動します。

.. code-block:: bash

   $ docker run -ti -d \
     -p 80:80 \
     --label interlock.ext.name=nginx \
     --link=interlock:interlock \
     -v nginx:/etc/conf \
     --name nginx \
     nginx nginx -g "daemon off;" -c /etc/conf/nginx.conf

.. Task 4. Create the other Swarm nodes

.. _task4-create-the-other-swarm-nodes:

タスク４：他の Swarm ノードを作成
========================================

.. A host in a Swarm cluster is called a node. You’ve already created the manager node. Here, the task is to create each virtual host for each node. There are three commands required:

Swarm クラスタのホストを「ノード」と呼びます。既にマネージャ・ノードを作成しました。ここでの作業は、各ノード用の仮想ホストを作成します。３つのコマンドが必要です。

..    create the host with Docker Machine
    point the local environmnet to the new host
    join the host to the Swarm cluster

* Docker Machine でホストを作成
* ローカル環境から新しい環境に切り替え
* ホストを Swarm クラスタに追加

.. If you were building this in a non-Mac/Windows environment, you’d only need to run the join command to add node to Swarm and registers it with the Consul discovery service. When you create a node, you’ll label it also, for example:

Mac あるいは Windows 以外で構築している場合、swarm ノードに追加するには ``join`` コマンドを実行するだけです。それだけで Consul ディスカバリ・サービスに登録します。また、ノードの作成時には次の例のようにラベルを付けます。

.. code-block:: bash

    --engine-opt="label=com.function=frontend01"

.. You’ll use these labels later when starting application containers. In the commands below, notice the label you are applying to each node.

これらのラベルはアプリケーション・コンテナを開始した後に使います。以降のコマンドで、各ノードに対してラベルを適用します。

..    Create the frontend01 host and add it to the Swarm cluster.

1. ``frontend01`` ホストを作成し、Swarm クラスタに追加します。

.. code-block:: bash

   $ docker-machine create -d virtualbox --virtualbox-memory "2000" \
   --engine-opt="label=com.function=frontend01" \
   --engine-opt="cluster-store=consul://$(docker-machine ip keystore):8500" \
   --engine-opt="cluster-advertise=eth1:2376" frontend01
   $ eval $(docker-machine env frontend01)
   $ docker run -d swarm join --addr=$(docker-machine ip frontend01):2376 consul://$(docker-machine ip keystore):8500

..    Create the frontend02 VM.

2. ``frontend02`` 仮想マシンを作成します。

.. code-block:: bash

   $ docker-machine create -d virtualbox --virtualbox-memory "2000" \
   --engine-opt="label=com.function=frontend02" \
   --engine-opt="cluster-store=consul://$(docker-machine ip keystore):8500" \
   --engine-opt="cluster-advertise=eth1:2376" frontend02
   $ eval $(docker-machine env frontend02)
   $ docker run -d swarm join --addr=$(docker-machine ip frontend02):2376 consul://$(docker-machine ip keystore):8500

..    Create the worker01 VM.

3. ``worker01`` 仮想マシンを作成します。

.. code-block:: bash

   $ docker-machine create -d virtualbox --virtualbox-memory "2000" \
   --engine-opt="label=com.function=worker01" \
   --engine-opt="cluster-store=consul://$(docker-machine ip keystore):8500" \
   --engine-opt="cluster-advertise=eth1:2376" worker01
   $ eval $(docker-machine env worker01)
   $ docker run -d swarm join --addr=$(docker-machine ip worker01):2376 consul://$(docker-machine ip keystore):8500

..    Create the dbstore VM.

4. ``dbstore`` 仮想マシンを作成します。

.. code-block:: bash

   $ docker-machine create -d virtualbox --virtualbox-memory "2000" \
   --engine-opt="label=com.function=dbstore" \
   --engine-opt="cluster-store=consul://$(docker-machine ip keystore):8500" \
   --engine-opt="cluster-advertise=eth1:2376" dbstore
   $ eval $(docker-machine env dbstore)
   $ docker run -d swarm join --addr=$(docker-machine ip dbstore):2376 consul://$(docker-machine ip keystore):8500

..    Check your work.

5. 動作確認をします。

..    At this point, you have deployed on the infrastructure you need to run the application. Test this now by listing the running machines:

この時点では、アプリケーションが必要なインフラをデプロイ完了しました。テストは、次のようにマシンが実行しているか一覧表示します。

.. code-block:: bash

   $ docker-machine ls
   NAME           ACTIVE   DRIVER       STATE     URL                         SWARM   DOCKER    ERRORS
   dbstore        -        virtualbox   Running   tcp://192.168.99.111:2376           v1.10.3
   frontend01     -        virtualbox   Running   tcp://192.168.99.108:2376           v1.10.3
   frontend02     -        virtualbox   Running   tcp://192.168.99.109:2376           v1.10.3
   keystore       -        virtualbox   Running   tcp://192.168.99.100:2376           v1.10.3
   loadbalancer   -        virtualbox   Running   tcp://192.168.99.107:2376           v1.10.3
   manager        -        virtualbox   Running   tcp://192.168.99.101:2376           v1.10.3
   worker01       *        virtualbox   Running   tcp://192.168.99.110:2376           v1.10.3

..    Make sure the Swarm manager sees all your nodes.

6. Swarm マネージャが全てのノードを一覧表示するのを確認します。

.. code-block:: bash

   $ docker -H $(docker-machine ip manager):3376 info
   Containers: 4
    Running: 4
    Paused: 0
    Stopped: 0
   Images: 3
   Server Version: swarm/1.1.3
   Role: primary
   Strategy: spread
   Filters: health, port, dependency, affinity, constraint
   Nodes: 4
    dbstore: 192.168.99.111:2376
     └ Status: Healthy
     └ Containers: 1
     └ Reserved CPUs: 0 / 1
     └ Reserved Memory: 0 B / 2.004 GiB
     └ Labels: com.function=dbstore, executiondriver=native-0.2, kernelversion=4.1.19-boot2docker, operatingsystem=Boot2Docker 1.10.3 (TCL 6.4.1); master : 625117e - Thu Mar 10 22:09:02 UTC 2016, provider=virtualbox, storagedriver=aufs
     └ Error: (none)
     └ UpdatedAt: 2016-04-07T18:25:37Z
    frontend01: 192.168.99.108:2376
     └ Status: Healthy
     └ Containers: 1
     └ Reserved CPUs: 0 / 1
     └ Reserved Memory: 0 B / 2.004 GiB
     └ Labels: com.function=frontend01, executiondriver=native-0.2, kernelversion=4.1.19-boot2docker, operatingsystem=Boot2Docker 1.10.3 (TCL 6.4.1); master : 625117e - Thu Mar 10 22:09:02 UTC 2016, provider=virtualbox, storagedriver=aufs
     └ Error: (none)
     └ UpdatedAt: 2016-04-07T18:26:10Z
    frontend02: 192.168.99.109:2376
     └ Status: Healthy
     └ Containers: 1
     └ Reserved CPUs: 0 / 1
     └ Reserved Memory: 0 B / 2.004 GiB
     └ Labels: com.function=frontend02, executiondriver=native-0.2, kernelversion=4.1.19-boot2docker, operatingsystem=Boot2Docker 1.10.3 (TCL 6.4.1); master : 625117e - Thu Mar 10 22:09:02 UTC 2016, provider=virtualbox, storagedriver=aufs
     └ Error: (none)
     └ UpdatedAt: 2016-04-07T18:25:43Z
    worker01: 192.168.99.110:2376
     └ Status: Healthy
     └ Containers: 1
     └ Reserved CPUs: 0 / 1
     └ Reserved Memory: 0 B / 2.004 GiB
     └ Labels: com.function=worker01, executiondriver=native-0.2, kernelversion=4.1.19-boot2docker, operatingsystem=Boot2Docker 1.10.3 (TCL 6.4.1); master : 625117e - Thu Mar 10 22:09:02 UTC 2016, provider=virtualbox, storagedriver=aufs
     └ Error: (none)
     └ UpdatedAt: 2016-04-07T18:25:56Z
   Plugins:
    Volume:
    Network:
   Kernel Version: 4.1.19-boot2docker
   Operating System: linux
   Architecture: amd64
   CPUs: 4
   Total Memory: 8.017 GiB
   Name: bb13b7cf80e8

..    The command is acting on the Swarm port, so it returns information about the entire cluster. You have a manager and no nodes.

このコマンドは Swarm ポートに対して処理しているため、クラスタ全体の情報を返します。操作対象Swarm マネージャあり、ノードではありません。

.. Next Step

次のステップ
====================

.. Your key-store, load balancer, and Swarm cluster infrastructure is up. You are ready to build and run the voting application on it.

キーストア、ロードバランサ、Swarm クラスタのインフラが動きました。これで :doc:`投票アプリケーションの構築と実行 <deploy-app>` ができます。

.. seealso:: 

   Deploy your infrastructure
      https://docs.docker.com/swarm/swarm_at_scale/deploy-infra/
