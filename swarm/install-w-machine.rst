.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/swarm/install-w-machine/
.. SOURCE: https://github.com/docker/swarm/blob/master/docs/install-w-machine.md
   doc version: 1.11
      https://github.com/docker/swarm/commits/master/docs/install-w-machine.md
.. check date: 2016/04/29
.. Commits on Mar 13, 2016 aa70529d3f4bac701818f85d63934f72b62da258
.. -------------------------------------------------------------------

.. Evaluate Swarm in a sandbox

.. _evaluate-swarm-in-a-sandbox:

=======================================
Swarm を検証環境で試すには
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. This getting started example shows you how to create a Docker Swarm, the native clustering tool for Docker.

この導入ガイドでは、Docker Swarm という Docker 用のネイティブなクラスタリング・ツールを使う方法を紹介します。

.. You’ll use Docker Toolbox to install Docker Machine and some other tools on your computer. Then you’ll use Docker Machine to provision a set of Docker Engine hosts. Lastly, you’ll use Docker client to connect to the hosts, where you’ll create a discovery token, create a cluster of one Swarm manager and nodes, and manage the cluster.

作業では、Docker Machine がインストールされた Docker Toolbox と、コンピュータ上の他のツールをいくつか使います。Docker Machine は Docker Engine ホスト群をプロビジョン（自動構築）するために使います。そして、Docker クライアントはホストに接続するために使います。ここでのホストとは、ディスカバリ・トークンを作成する場所であり、Swarm マネージャとノードでクラスタを作成・管理するための場所でもあります。

.. When you finish, you’ll have a Docker Swarm up and running in VirtualBox on your local Mac or Windows computer. You can use this Swarm as personal development sandbox.

準備が完了したら、ローカルの Mac か Windows コンピュータで動く VirtualBox 上で Docker Swarm を起動します。この Swarm 環境は個人的な開発環境（サンドボックス）として使えます。

.. To use Docker Swarm on Linux, see Build a Swarm cluster for production.

Docker Swarm を Linux 上で使う場合は、 :doc:`install-manual` をご覧ください。

.. Install Docker Toolbox

.. _install-docker-toolbox:

Docker Toolbox のインストール
==============================

.. Download and install Docker Toolbox.

`Docker Toolbox <https://www.docker.com/docker-toolbox>`_ のダウンロードとインストールをします。

.. The toolbox installs a handful of tools on your local Windows or Mac OS X computer. In this exercise, you use three of those tools:

Toolbox はローカルの Windows や Mac OS X コンピュータ上に便利なツールをインストールします。この練習では、３つのツールを使います。

..    Docker Machine: To deploy virtual machines that run Docker Engine.
    VirtualBox: To host the virtual machines deployed from Docker Machine.
    Docker Client: To connect from your local computer to the Docker Engines on the VMs and issue docker commands to create the Swarm.

* Docker Machine: Docker Engine を実行する仮想マシンをデプロイします。
* VirtualBox: Docker Machine を使い、仮想マシンのホストをデプロイします。
* Docker クライアント: ローカルのコンピュータから仮想マシン上の Docker Engine に接続します。また、docker コマンドで Swarm クラスタを作成します。

.. The following sections provide more information each of these tools. The rest of the document uses the abbreviation, VM, for virtual machine.

以下のセクションでは各ツールの詳細を説明します。以降は仮想マシン（Virtual Machine）を VM と略します。

.. Create three VMs running Docker Engine

.. _create-three-vms-running-docker-engine:

Docker Engine で３つの VM を作成
========================================

.. Here, you use Docker Machine to provision three VMs running Docker Engine.

ここでは Docker Machine を使い、Docker Engine を動かす３つの VM を作成（プロビジョン）します。

..    Open a terminal on your computer. Use Docker Machine to list any VMs in VirtualBox.

1. 自分のコンピュータ上のターミナルを開きます。Docker Machine で VirtualBox 上の VM 一覧を表示します。

.. code-block:: bash

   $ docker-machine ls
   NAME         ACTIVE   DRIVER       STATE     URL                         SWARM
   default    *        virtualbox   Running   tcp://192.168.99.100:2376

..    Optional: To conserve system resources, stop any virtual machines you are not using. For example, to stop the VM named default, enter:

2. オプション： システム・リソースを節約するために、使っていない仮想マシンを停止します。例えば、 ``default`` という名前の VM を停止するには、次のようにします。

.. code-block:: bash

   $ docker-machine stop default

..    Create and run a VM named manager.

3. ``manager`` （マネージャ）という名前の VM を作成・実行します。

.. code-block:: bash

   $ docker-machine create -d virtualbox manager

..    Create and run a VM named agent1.

4. ``agent1`` （エージェント１）という名前の VM を作成・実行します。

.. code-block:: bash

   $ docker-machine create -d virtualbox agent1

..    Create and run a VM named agent2.

5. ``agent2`` （エージェント２）という名前の VM を作成・実行します。

.. code-block:: bash

   $ docker-machine create -d virtualbox agent2

.. Each create command checks for a local copy of the latest VM image, called boot2docker.iso. If it isn’t available, Docker Machine downloads the image from Docker Hub. Then, Docker Machine uses boot2docker.iso to create a VM that automatically runs Docker Engine.

各 create コマンドの実行時、 boot2docker.iso と呼ばれる VM イメージの *最新版* がローカルにコピーされているかどうか（自動的に）確認します。ファイルが存在しないか最新版でなければ、Docker Machine は Docker Hub からイメージをダウンロードします。それから Docker Machine は boot2docker.iso を使い、Docker Engine を自動的に実行する VM を作成します。

.. Troubleshooting: If your computer or hosts cannot reach Docker Hub, the docker-machine or docker run commands that pull images may fail. In that case, check the Docker Hub status page for service availability. Then, check whether your computer is connected to the Internet. Finally, check whether VirtualBox’s network settings allow your hosts to connect to the Internet.

.. note::

   トラブルシューティング：コンピュータやホストが Docker Hub にアクセスできなければ、 ``docker-machine`` や ``docker run`` コマンドは失敗します。そのような場合、サービスが利用可能かどうか `Docker Hub ステータス・ページ <http://status.docker.com/>`_ を確認します。その次は、自分のコンピュータがインターネットに接続しているか確認します。それから VirtualBox のネットワーク設定で、ホストがインターネット側に接続可能かどうかを確認してください。

.. Create a Swarm discovery token

Swarm ディスカバリ・トークンの作成
========================================

.. Here you use the discovery backend hosted on Docker Hub to create a unique discovery token for your cluster. This discovery backend is only for low-volume development and testing purposes, not for production. Later on, when you run the Swarm manager and nodes, they register with the discovery backend as members of the cluster that’s associated with the unique token. The discovery backend maintains an up-to-date list of cluster members and shares that list with the Swarm manager. The Swarm manager uses this list to assign tasks to the nodes.

ここでは Docker Hub 上にあるディスカバリ・バックエンドを使い、自分のクラスタ用のユニークなディスカバリ・トークンを作成します。このディスカバリ・バックエンドは、小規模の開発環境やテスト目的のためであり、プロダクション向けではありません。Swarm マネージャとノードを起動後、ディスカバリ・バックエンドにノードをクラスタのメンバとして登録します。クラスタとユニークなトークンを結び付けるのが、このバックエンドの役割です。ディスカバリ・バックエンドはクラスタのメンバのリストを最新情報に更新し続け、その情報を Swarm マネージャと共有します。Swarm マネージャはこのリストを使いノードに対してタスクを割り当てます。

..    Connect the Docker Client on your computer to the Docker Engine running on manager.

1. コンピュータ上の Docker クライアントを Docker Engine が動いている ``manager``  に接続します。

.. code-block:: bash

   $ eval $(docker-machine env manager)

..    The client will send the docker commands in the following steps to the Docker Engine on on manager.

以降の手順では、 クライアント側の ``docker`` コマンドは ``manager`` 上の Docker Engine に送信します。

.. Create a unique id for the Swarm cluster.

2. Swarm クラスタに対するユニーク ID を作成します。

.. code-block:: bash

   $ docker run --rm swarm create
   .
   .
   .
   Status: Downloaded newer image for swarm:latest
   0ac50ef75c9739f5bfeeaf00503d4e6e

.. The docker run command gets the latest swarm image and runs it as a container. The create argument makes the Swarm container connect to the Docker Hub discovery service and get a unique Swarm ID, also known as a “discovery token”. The token appears in the output, it is not saved to a file on the host. The --rm option automatically cleans up the container and removes the file system when the container exits.

``docker run`` コマンドは最新（latest）の ``swarm`` を取得し、コンテナとして実行します。引数 ``create`` は Swarm コンテナを Docker Hub ディスカバリ・サービスに接続し、ユニークな Swarm ID を取得します。この ID を「ディスカバリ・トークン」（discovery token）と呼びます。トークンは出力（アウトプット）されるだけであり、ホスト上のファイルには保管されません。 ``--rm`` オプションは自動的にコンテナを削除するものです。コンテナが終了したら、コンテナのファイルシステムを自動的に削除します。

.. The discovery service keeps unused tokens for approximately one week.

トークンを利用しなければ、およそ一週間後にディスカバリ・サービスによって削除されます。

.. Copy the discovery token from the last line of the previous output to a safe place.

3. 先ほどの出力されたディスカバリ・トークンを安全な場所にコピーします。

.. Create the Swarm manager and nodes

Swarm マネージャとノードの作成
==============================

.. Here, you connect to each of the hosts and create a Swarm manager or node.

ここでは、各ホストに接続し、Swarm マネージャまたはノードを作成します。

..    Get the IP addresses of the three VMs. For example:

1. ３つの VM の IP アドレスを取得します。例：

.. code-block:: bash

   $ docker-machine ls
   NAME      ACTIVE   DRIVER       STATE     URL                         SWARM   DOCKER   ERRORS
   agent1    -        virtualbox   Running   tcp://192.168.99.102:2376           v1.9.1
   agent2    -        virtualbox   Running   tcp://192.168.99.103:2376           v1.9.1
   manager   *        virtualbox   Running   tcp://192.168.99.100:2376           v1.9.1

..    Your client should still be pointing to Docker Engine on manager. Use the following syntax to run a Swarm container as the primary Swarm manager on manager.

2. クライアントは ``manager`` を実行する Docker Engine を指し示しているままでしょう。次の構文は ``manager`` 上で Swarm コンテナをプライマリ Swarm マネージャとして実行します。

.. code-block:: bash

   $ docker run -d -p <your_selected_port>:3376 -t -v /var/lib/boot2docker:/certs:ro swarm manage -H 0.0.0.0:3376 --tlsverify --tlscacert=/certs/ca.pem --tlscert=/certs/server.pem --tlskey=/certs/server-key.pem token://<cluster_id>

.. For example:

例：

.. code-block:: bash

   $ docker run -d -p 3376:3376 -t -v /var/lib/boot2docker:/certs:ro swarm manage -H 0.0.0.0:3376 --tlsverify --tlscacert=/certs/ca.pem --tlscert=/certs/server.pem --tlskey=/certs/server-key.pem token://0ac50ef75c9739f5bfeeaf00503d4e6e

.. The -p option maps a port 3376 on the container to port 3376 on the host. The -v option mounts the directory containing TLS certificates (/var/lib/boot2docker for the manager VM) into the container running Swarm manager in read-only mode.

``-p`` オプションは、コンテナのポート 3376 をホスト上の 3376 に割り当てています。 ``-v`` オプションは TLS 証明書が入っているディレクトリ（ ``manager`` VM 上の ``/var/lib/boot2docker`` ）をマウントします。これは Swarm マネージャの中では読み込み専用（read-only）モードで扱われます。

.. Connect Docker Client to agent1.

3. Docker クライアントを ``agent1`` に接続します。

.. code-block:: bash

   $ eval $(docker-machine env agent1)

.. Use the following syntax to run a Swarm container as an agent on agent1. Replace with the IP address of the VM.

4. 次の構文は  ``agent1`` 上で Swarm コンテナをエージェントとして起動します。IP アドレスは VM のものに書き換えます。

.. code-block:: bash

   $ docker run -d swarm join --addr=<node_ip>:<node_port> token://<cluster_id>

..     For example:

例：

.. code-block:: bash

   $ docker run -d swarm join --addr=192.168.99.102:2376 token://0ac50ef75c9739f5bfeeaf00503d4e6e

..    Connect Docker Client to agent2.

5. Docker クライアントを ``agent2`` に接続します。

.. code-block:: bash

   $ eval $(docker-machine env agent2)

..    Run a Swarm container as an agent on agent2. For example:

6. ``agent2`` 上で Swarm コンテナをエージェントとして起動します。

.. code-block:: bash

   $ docker run -d swarm join --addr=192.168.99.103:2376 token://0ac50ef75c9739f5bfeeaf00503d4e6e

.. Manage your Swarm

Swarm クラスタを管理
====================

.. Here, you connect to the cluster and review information about the Swarm manager and nodes. You tell the Swarm to run a container and check which node did the work.

ここではクラスタに接続し、Swarm マネージャとノードの情報を見ていきます。Swarm に対してコンテナ実行を命令し、どのノードで動作しているかを確認します。

..     Connect the Docker Client to the Swarm by updating the DOCKER_HOST environment variable.

1. Docker クライアントを Swarm に接続するため、 ``DOCKER_HOST`` 環境変数を更新します。

.. code-block:: bash

   $ DOCKER_HOST=<manager_ip>:<your_selected_port>

..     For the current example, the manager has IP address 192.168.99.100 and we selected port 3376 for the Swarm manager.

この例では ``manager`` の IP アドレスは ``192.168.99.100`` です。Swarm マネージャ用のポートは 3376 を選びました。

.. code-block:: bash

   $ DOCKER_HOST=192.168.99.100:3376

..    Because Docker Swarm uses the standard Docker API, you can connect to it using Docker Client and other tools such as Docker Compose, Dokku, Jenkins, and Krane, among others.

Docker Swarm は標準 Docker API を使うため、Docker クライアントで接続できます。他にも Docker Compose や、Dokku、Jenkins、Krane などのツールが利用できます。

.. Get information about the Swarm.

2. Swarm に関する情報を取得します。

.. code-block:: bash

   $ docker info

.. As you can see, the output displays information about the two agent nodes and the one manager node in the Swarm.

実行したら、Swarm 上にあるマネージャ１つと、エージェント・ノード２つの情報を表示します。

.. Check the images currently running on your Swarm.

3. Swarm 上で実行中のイメージを確認します。

.. code-block:: bash

   $ docker ps

.. Run a container on the Swarm.

4. Swarm 上でコンテナを実行します。

.. code-block:: bash

   $ docker run hello-world
   Hello from Docker.
   .
   .
   .

.. Use the docker ps command to find out which node the container ran on. For example:

5. ``docker ps`` コマンドを使い、どのノードでコンテナが実行されているかを確認します。実行例：

.. code-block:: bash

   $ docker ps -a
   CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                      PORTS               NAMES
   0b0628349187        hello-world         "/hello"                 20 minutes ago      Exited (0) 20 minutes ago                       agent1
   .
   .
   .

.. In this case, the Swarm ran ‘hello-world’ on the ‘swarm1’.

この例では、 ``swarm1`` 上で ``hello-world`` が動いていました。

.. By default, Docker Swarm uses the “spread” strategy to choose which node runs a container. When you run multiple containers, the spread strategy assigns each container to the node with the fewest containers.

Docker Swarm がコンテナをどのノードで実行するかを決めるには、デフォルトでは「spread」（スプレッド）ストラテジを使います。複数のコンテナを実行する場合、スプレッド・ストラテジはコンテナの実行数が最も少ないノードに対してコンテナを割り当てます。

.. Where to go next

更に詳しく
====================

.. At this point, you’ve done the following: - Created a Swarm discovery token. - Created Swarm nodes using Docker Machine. - Managed a Swarm and run containers on it. - Learned Swarm-related concepts and terminology.

ここまでは次の作業を行いました。

* Swarm ディスカバリ・トークンの作成
* Docker Machine を使って Swarm ノードを作成
* Swarm を使ってコンテナを実行
* Swarm に関連する概念と技術を学んだ

.. However, Docker Swarm has many other aspects and capabilities. For more information, visit the Swarm landing page or read the Swarm documentation.

この他にもDocker Swarm には多くの特徴や能力があります。より詳しい情報は、 `Swarm のランディング・ページ（英語） <https://www.docker.com/docker-swarm>`_ や :doc:`Swarm ドキュメント </swarm/index>` をご覧ください。

.. seealso:: 

   Evaluate Swarm in a sandbox
      https://docs.docker.com/swarm/install-w-machine/
