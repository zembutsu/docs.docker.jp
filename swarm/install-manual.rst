.. http://docs.docker.com/swarm/install-manual/
.. doc version: 1.9
.. check date: 2015/11/25

.. Create a swarm for development

==============================
開発用の Swarm クラスタ作成
==============================

.. This section tells you how to create a Docker Swarm on your network to use only for debugging, testing, or development purposes. You can also use this type of installation if you are developing custom applications for Docker Swarm or contributing to 

このページでは、自分のネットワーク上に Docker Swam を作成する方法を紹介します。用途は、デバッグやテストや開発目的のみ対象です。この構築手順は、Docker Swam 向けの何らかのアプリケーション開発や、貢献のためにも使えます。

.. Caution: Only use this set up if your network environment is secured by a firewall or other measures.

.. caution::

   セットアップは、ファイアーウォールや他の手法によって、安全なネットワーク環境上で行ってください。

.. Prerequisites

事前準備
==========

.. You install Docker Swarm on a single system which is known as your Docker Swarm manager. You create the cluster, or swarm, on one or more additional nodes on your network. Each node in your swarm must:

単一システム上に Docker Swarm をインストールします。インストールするのは Docker Swarm マネージャです。これを使い、クラスタの作成や、ネットワーク上の更なるノードを登録を行います。Swram クラスタの各ノードが必要になる環境は、次の通りです。

..    be accessible by the swarm manager across your network
    have Docker Engine 1.6.0+ installed
    open a TCP port to listen for the manager

* Swarm Manager が自分のネットワークにアクセス可能
* Docker エンジン 1.6.0 以上のインストール
* Swarm Manager 向けに TCP ポートをオープン

.. You can run Docker Swarm on Linux 64-bit architectures. You can also install and run it on 64-bit Windows and Max OSX but these architectures are not regularly tested for compatibility.

Docker Swarm は Linux の 64 bit アーキテクチャ上で実行できます。64 bit の Windows や Mac OSX でもインストール・実行可能ですが、いくつかのアーキテクチャ上での互換性は十分に検証されていません。

.. Take a moment and idntify the systems on your network that you intend to use. Ensure each node meets the requirements listed above.

ネットワーク上のシステムによって認識され、利用可能になるまでは、まだ少々の時間がかかります。上記の動作条件を満たしているかどうか、ご確認ください。

.. Pull the swarm image and create a cluster.

Swarm イメージの取得とクラスタ作成
========================================

.. The easiest way to get started with Swarm is to use the official Docker image.

Swarm を使い始めるには、 `公式 Docker イメージ <https://registry.hub.docker.com/_/swarm/>`_ の利用が最も簡単です。

..    Pull the swarm image.

1. Swarm イメージを取得します。

.. code-block:: bash

   $ docker pull swarm

..    Create a Swarm cluster using the docker command.

2. ``docker`` コマンドを使用して Swarm クラスタを作成します。

.. code-block:: bash

   $ docker run --rm swarm create
   6856663cdefdec325839a4b7e1de38e8 # 

..    The create command returns a unique cluster ID (cluster_id). You’ll need this ID when starting the Docker Swarm agent on a node.

``create`` コマンドを実行すると、ユニークなクラスタ ID （ ``cluster_id`` ）を返します。この ID は、ノード上で Docker Swarm エージェントの開始時に使います。

.. Create swarm nodes

Swarm ノードの作成
====================

.. Each Swarm node will run a Swarm node agent. The agent registers the referenced Docker daemon, monitors it, and updates the discovery backend with the node’s status.

各 Swam ノードでは Swam ノードのエージェントを実行します。エージェントは Docker デーモンや監視のために登録され、ノードの状態とディスカバリ・バックエンドを更新します。

.. This example uses the Docker Hub based token discovery service. Log into each node and do the following.

この例では、Docker Hub を使う `` token`` ディスカバリ・サービスを使います。 **各ノード** にログインし、同じ作業を行います。

..    Start the Docker daemon with the -H flag. This ensures that the Docker remote API on Swarm Agents is available over TCP for the Swarm Manager, as well as the standard unix socket which is available in default docker installs.

1. Docker デーモンに ``-H`` フラグを付けて起動します。これにより、 *Swarm エージェント* は *Swarm マネージャ* と TCP を通して通信可能になります。Docker リモート API と同様に、Docker 標準インストール時に利用可能な標準 UNIX ソケットも利用できます。

.. code-block:: bash

   $ docker daemon -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock

..        Note: versions of docker prior to 1.8 used the -d flag instead of the docker daemon subcommand.

.. note::

   Docker 1.8 よりも前のバージョンでは、 ``docker daemon`` サブコマンドの代わりに、 ``-d`` フラグを使います。

.. Register the Swarm agents to the discovery service. The node’s IP must be accessible from the Swarm Manager. Use the following command and replace with the proper node_ip and cluster_id to start an agent:

Swarm エージェントをディスカバリ・サービスに登録します。このノードの IP アドレスは、Swarm マネージャからアクセスできる必要があります。次のコマンドを実行する時は、 ``ノードID`` と ``クラスタ ID``  を適切なものに置き換えてください。

.. code-block:: bash

   docker run -d swarm join --addr=<ノードIP:2375> token://<クラスタID>

..    For example:

実行例：

.. code-block:: bash

   $ docker run -d swarm join --addr=172.31.40.100:2375 token://6856663cdefdec325839a4b7e1de38e8


.. Configure a manager

マネージャの設定
====================

.. Once you have your nodes established, set up a manager to control the swarm.

ノードの準備が完了したら、Swarm を制御するマネージャをセットアップします。

..    Start the Swarm manager on any machine or your laptop.

1. Swarm マネージャを、任意のマシンまたは自分の PC 上で起動します。実行するコマンドは、次の通りです。

..     The following command illustrates how to do this:

.. code-block:: bash

   docker run -d -p <管理用ポート>:2375 swarm manage token://<クラスタID>

..     The manager is exposed and listening on <manager_port>.

マネージャは ``管理用ポート`` で指定したポートの公開とリッスンします。

..    Once the manager is running, check your configuration by running docker info as follows:

2. マネージャを起動後、次のように``docker info`` を実行して、設定を確認します。

.. code-block:: bash

   docker -H tcp://<manager_ip:manager_port> info

..    For example, if you run the manager locally on your machine:

例えば、マネージャをローカルのマシン上で実行している場合は、次のように表示されます。

.. code-block:: bash

   $ docker -H tcp://0.0.0.0:2375 info
   Containers: 0
   Nodes: 3
    agent-2: 172.31.40.102:2375
       └ Containers: 0
       └ Reserved CPUs: 0 / 1
       └ Reserved Memory: 0 B / 514.5 MiB
    agent-1: 172.31.40.101:2375
       └ Containers: 0
       └ Reserved CPUs: 0 / 1
       └ Reserved Memory: 0 B / 514.5 MiB
    agent-0: 172.31.40.100:2375
       └ Containers: 0
       └ Reserved CPUs: 0 / 1
       └ Reserved Memory: 0 B / 514.5 MiB

.. If you are running a test cluster without TLS enabled, you may get an error. In that case, be sure to unset DOCKER_TLS_VERIFY with:

テスト用のクラスタで、TLS を有効にせずに実行しようとしても、エラーが起こるでしょう。このような場合は、環境変数 ``DOCKER_TLS_VERIFY`` を次のように無効化します。

.. code-block:: bash

   $ unset DOCKER_TLS_VERIFY

.. Using the docker CLI

docker CLI を使う
====================

.. You can now use the regular Docker CLI to access your nodes:

通常の Docker CLI を使い、ノードにアクセスできるようになります。

.. code-block:: bash

   docker -H tcp://<manager_ip:manager_port> info
   docker -H tcp://<manager_ip:manager_port> run ...
   docker -H tcp://<manager_ip:manager_port> ps
   docker -H tcp://<manager_ip:manager_port> logs ...

.. List nodes in your cluster

クラスタ上のノード一覧を表示
==============================

.. You can get a list of all your running nodes using the swarm list command:

稼働中のノード一覧を取得するには、 ``swarm list`` コマンドを使います。

.. code-block:: bash

   docker run --rm swarm list token://<クラスタID>
   <ノードIP:2375>

.. For example: 

実行例：

.. code-block:: bash

   $ docker run --rm swarm list token://6856663cdefdec325839a4b7e1de38e8
   172.31.40.100:2375
   172.31.40.101:2375
   172.31.40.102:2375

.. TLS

TLS
====================

.. Swarm supports TLS authentication between the CLI and Swarm but also between Swarm and the Docker nodes. However, all the Docker daemon certificates and client certificates must be signed using the same CA-certificate.

Swam は CLI と Swam 間の TLS 認証をサポートしているだけでなく、Swam と Docker ノード間でもサポートしています。 *しかしながら* 、全ての Docker デーモンと Docker ノードが同じ CA 証明書を使って認証されている **必要があります** 。

.. In order to enable TLS for both client and server, the same command line options as Docker can be specified:

クライアントとサーバいずれも TLS を有効にするには、Docker で指定時と同様のコマンドライン・オプションを使います。

.. code-block:: bash

   swarm manage --tlsverify --tlscacert=<CACERT> --tlscert=<CERT> --tlskey=<KEY> [...]

.. Please refer to the Docker documentation for more information on how to set up TLS authentication on Docker and generating the certificates.

Docker の TLS 認証設定や証明書の生成に関する詳細情報は、 :doc:`Docker のドキュメント </articles/https>` を参照ください。

..     Note: Swarm certificates must be generated with extendedKeyUsage = clientAuth,serverAuth

Swam 証明書の生成には、 ``extendedKeyUsage = clientAuth,serverAuth`` を使う必要があります。

