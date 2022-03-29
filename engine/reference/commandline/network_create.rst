.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/network_create/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/network_create.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_network_create.yaml
.. check date: 2022/03/28
.. Commits on Aug 22, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker network create

=======================================
docker network create
=======================================


.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _network_create-description:

説明
==========

.. Create a network

ネットワークを作成します。

.. API 1.21+
   Open the 1.21 API reference (in a new window)
   The client and daemon API must both be at least 1.21 to use this command. Use the docker version command on the client to check your client and daemon API versions.

【API 1.21+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.21 <https://docs.docker.com/engine/api/v1.21/>`_ の必要があります。クライアントとデーモン API のバージョンを調べるには、 ``docker version`` コマンドを使いミズ会う。

.. _network_create-usage:

使い方
==========

.. code-block:: bash

   $ docker network create [OPTIONS] NETWORK

.. Extended description
.. _network_create-extended-description:

補足説明
==========

.. Creates a new network. The DRIVER accepts bridge or overlay which are the built-in network drivers. If you have installed a third party or your own custom network driver you can specify that DRIVER here also. If you don’t specify the --driver option, the command automatically creates a bridge network for you. When you install Docker Engine it creates a bridge network automatically. This network corresponds to the docker0 bridge that Engine has traditionally relied on. When you launch a new container with docker run it automatically connects to this bridge network. You cannot remove this default bridge network, but you can create new ones using the network create command.

新しいネットワークを作成します。 ``DRIVER`` には ``bridge`` か ``overlay`` を指定できます。どちらも内蔵のネットワーク・ドライバです。サードパーティー製のドライバをインストールするか、カスタム・ネットワーク・ドライバを組み込むのであれば、同様に ``DRIVER`` で指定できます。 ``--driver`` オプションを指定しなければ、コマンドは自動的に ``bridge`` ネットワークを作成します。Docker エンジンをインストールしたら、 ``bridge`` ネットワークを自動的に構築します。このネットワークは従来の ``docker0`` ブリッジに相当します。新しいコンテナを ``docker run`` で起動したら、自動的にこのブリッジ・ネットワークに接続します。このデフォルト・ブリッジ・ネットワークは削除できませんが、新しいブリッジを ``network create`` コマンドで作成できます。

.. code-block:: bash

   $ docker network create -d bridge my-bridge-network

.. Bridge networks are isolated networks on a single Engine installation. If you want to create a network that spans multiple Docker hosts each running an Engine, you must create an overlay network. Unlike bridge networks overlay networks require some pre-existing conditions before you can create one. These conditions are:

ブリッジ・ネットワークは、単一の Docker エンジン上でネットワークを分離（isolate）します。ネットワークを作成する時、 ``overlay`` （オーバレイ）ネットワークであれば、Docker エンジンが動作する複数のホスト上に渡ることも可能です。 ``bridge`` ネットワークとは異なり、オーバレイ・ネットワークを作成するには、いくつかの条件が必要です。

..    Access to a key-value store. Engine supports Consul, Etcd, and ZooKeeper (Distributed store) key-value stores.
    A cluster of hosts with connectivity to the key-value store.
    A properly configured Engine daemon on each host in the cluster.

* キーバリュー・ストアにアクセスできること。エンジンがサポートしているキーバリュー・ストアは Consul、Etcd、ZooKeeper（分散ストア）です。
* クラスタの各ホストが、キーバリュー・ストアと接続できること。
* 各ホスト上の Docker エンジンの ``daemon`` が、クラスタとしての適切な設定をすること。

.. The dockerd options that support the overlay network are:

``dockerd`` が ``overlay`` ネットワークをサポートするために必要なオプションは、次の通りです。

..    --cluster-store
    --cluster-store-opt
    --cluster-advertise

* ``--cluster-store``
* ``--cluster-store-opt``
* ``--cluster-advertise``

.. To read more about these options and how to configure them, see “Get started with multi-host network“.

各オプションや設定方法の詳細については、 :doc:`マルチホスト・ネットワークを始めましょう </engine/userguide/networking/get-started-overlay>` をご覧ください。

.. Once you have prepared the overlay network prerequisites you simply choose a Docker host in the cluster and issue the following to create the network:

``overlay`` ネットワークに必要な準備が整った後は、クラスタ上にあるホストのどれかで次のようなネットワーク作成コマンドを実行します。

.. code-block:: bash

   $ docker network create -d overlay my-multihost-network

.. Network names must be unique. The Docker daemon attempts to identify naming conflicts but this is not guaranteed. It is the user’s responsibility to avoid name conflicts.

ネットワーク名はユニークにする必要があります。Docker デーモンは名前の衝突を避けようとしますが、保証されません。ユーザ・リポジトリも名前の衝突を避けようとします。

.. Overlay network limitations
.. _network_create-overlay-network-limitations:
オーバレイ・ネットワークの制限
------------------------------

.. You should create overlay networks with /24 blocks (the default), which limits you to 256 IP addresses, when you create networks using the default VIP-based endpoint-mode. This recommendation addresses limitations with swarm mode. If you need more than 256 IP addresses, do not increase the IP block size. You can either use dnsrr endpoint mode with an external load balancer, or use multiple smaller overlay networks. See Configure service discovery for more information about different endpoint modes.

オーバレイ・ネットワークは ``/24`` ブロック（これがデフォルトです）で作成すべきです。デフォルトの VIP をベースとしたエンドポイント・モードを使用するネットワークの作成時、 IP アドレスは 256 が上限となります。こちらを推奨する理由は `swarm mode での制限（英語） <https://github.com/moby/moby/issues/30820>`_ で説明しています。 256 よりも多い IP アドレスが必要な場合は、 IP ブロックのサイズを増やさないでください。外部のロードバランサを使う ``dnsrr`` エンドポイントか、複数の小さなオーバレイ・ネットワークか、どちらかを利用できます。異なるエンドポイント・モードについての情報は :ref:`サービスディスカバリの設定 <configure-service-discovery>` をご覧ください。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <network_connect-examples>` をご覧ください。

.. _network_create-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--attachable``
     - 
     - 【API 1.25+】手動でのコンテナのアタッチを有効化
   * - ``--aux-address``
     - 
     - ネットワーク・ドライバが使う :ruby:`補助の <auxiliary>` IPv4 または IPv6 アドレス
   * - ``--config-from``
     - 
     - 【API 1.30+】設定をコピーするネットワーク
   * - ``--config-only``
     - 
     - 【API 1.30+】設定情報のみのネットワークを作成
   * - ``--driver`` , ``-d``
     - ``bridge``
     - 対象ネットワークを管理するドライバ
   * - ``--gateway``
     - 
     - マスタ・サブネットに対する IPv4 または IPv6 ゲートウェイ
   * - ``--ingress``
     - 
     - 【API 1.29+】swarm ルーティング・メッシュ・ネットワークを作成
   * - ``--internal``
     - 
     - 外部からのアクセスを制限するネットワーク
   * - ``--ipam-driver``
     - 
     - IP アドレス管理ドライバ
   * - ``--ipam-opt``
     - 
     - IPAM ドライバ固有のオプションを指定
   * - ``--ipv6``
     - 
     - IPv6 ネットワーク機能を有効化
   * - ``--label``
     - 
     - ネットワークにメタデータを設定
   * - ``--opt`` , ``-o``
     - 
     - ドライバ固有のオプションを指定
   * - ``--scope``
     - 
     - 【API 1.30+】ネットワーク範囲の制御
   * - ``--subnet``
     - 
     - ネットワーク・セグメントを表す CIDR 形式のサブネット


.. Examples
.. _network_create-examples:

使用例
==========

.. Connect containers
.. _connect-containers:

コンテナに接続
--------------------

.. When you start a container use the --net flag to connect it to a network. This adds the busybox container to the mynet network.

コンテナの起動時に ``--net`` フラグを指定したら、ネットワークに接続します。 ``busybox`` コンテナが ``mynet`` ネットワークに接続するには、次のようにします。

.. code-block:: bash

   $ docker run -itd --network=mynet busybox

.. If you want to add a container to a network after the container is already running use the docker network connect subcommand.

既に実行中のコンテナに対してネットワークを接続したい場合は、 ``docker network connect`` サブコマンドを使います。

.. You can connect multiple containers to the same network. Once connected, the containers can communicate using only another container’s IP address or name. For overlay networks or custom plugins that support multi-host connectivity, containers connected to the same multi-host network but launched from different Engines can also communicate in this way.

同じネットワークに複数のコンテナが接続できます。接続したら、コンテナは他のコンテナの IP アドレスか名前で通信できるようになります。 ``overlay`` ネットワークやカスタム・プラグインは、複数のホスト間の接続サポートしていますので、コンテナは同じマルチホスト・ネットワークに接続できるだけでなく、異なった Docker エンジンから起動された環境でも、同様に通信できます。

.. You can disconnect a container from a network using the docker network disconnect command.

コンテナをネットワークから切断するには、 ``docker network disconnect`` コマンドを使います。

.. Specifying advanced options
.. _specifying-advanced-options:

高度なオプションの設定
------------------------------

.. When you create a network, Engine creates a non-overlapping subnetwork for the network by default. This subnetwork is not a subdivision of an existing network. It is purely for ip-addressing purposes. You can override this default and specify subnetwork values directly using the the --subnet option. On a bridge network you can only create a single subnet:

ネットワークの作成時、デフォルトではエンジンはネットワークのサブネットワークが重複しないようにします。サブネットワークは既存のネットワークの下位にはありません。純粋に IP アドレスを割り当てるためです。このデフォルトを上書きするには、 ``--subnet`` オプションを使ってサブネットワークの値を直接指定します。

.. code-block:: bash

   $ docker network create --driver=bridge --subnet=192.168.0.0/16 br0

.. Additionally, you also specify the --gateway --ip-range and --aux-address options.

更に、他にも ``--gateway`` ``--ip-range`` ``--aux-address`` オプションが利用可能です。

.. code-block:: bash

   $ docker network create \
     --driver=bridge \
     --subnet=172.28.0.0/16 \
     --ip-range=172.28.5.0/24 \
     --gateway=172.28.5.254 \
     br0

.. If you omit the --gateway flag the Engine selects one for you from inside a preferred pool. For overlay networks and for network driver plugins that support it you can create multiple subnetworks. This example uses two /25 subnet mask to adhere to the current guidance of not having more than 256 IPs in a single overlay network. Each of the subnetworks has 126 usable addresses.

.. If you omit the --gateway flag the Engine selects one for you from inside a preferred pool. For overlay networks and for network driver plugins that support it you can create multiple subnetworks.

``--gateway`` フラグを省略したら、エンジンは対象ネットワークの範囲内から１つ選びます。 ``overlay`` ネットワークとネットワーク・ドライバ・プラグインの場合は、複数のサブネットワークの作成をサポートしています。この例では、1つのオーバレイ・ネットワークで 256 の IP アドレスを持たないようにという、現時点のガイダンスを守るため、2つの ``/25`` サブネット・マスクを使用します。各サブネットワークでは 126 の利用可能なアドレスがあります。

.. code-block:: bash

   $ docker network create -d overlay \
     --subnet=192.168.10.0/25 \
     --subnet=192.168.20.0/25 \
     --gateway=192.168.10.100 \
     --gateway=192.168.20.100 \
     --aux-address="my-router=192.168.10.5" --aux-address="my-switch=192.168.10.6" \
     --aux-address="my-printer=192.168.20.5" --aux-address="my-nas=192.168.20.6" \
     my-multihost-network

.. Be sure that your subnetworks do not overlap. If they do, the network create fails and Engine returns an error.

サブ・ネットワークが重複しないように気を付けてください。重複したらネットワークの作成に失敗し、エンジンはエラーを表示します。

.. Bridge driver options
.. _bridge-driver-options:
ブリッジ・ドライバのオプション
------------------------------

.. When creating a custom network, the default network driver (i.e. bridge) has additional options that can be passed. The following are those options and the equivalent docker daemon flags used for docker0 bridge:

カスタム・ネットワークの作成時、デフォルトのネットワーク・ドライバ（例： ``bridge`` ）では追加のオプションを指定できます。以下のオプション指定は、 docker デーモンで docker0 ブリッジ用のフラグを指定するのと同等です。

.. list-table::
   :header-rows: 1
   
   * - オプション
     -  同等
     - 説明
   * - ``com.docker.network.bridge.name``
     - －
     - Linux ブリッジを作成する時に使うブリッジ名
   * - ``com.docker.network.bridge.enable_ip_masquerade``
     - ``--ip-masq``
     - IP マスカレードの有効化
   * - ``com.docker.network.bridge.enable_icc``
     - ``--icc``
     - 内部におけるコンテナの接続性を、有効化または無効化
   * - ``com.docker.network.bridge.host_binding_ipv4``
     - ``--ip``
     - コンテナのポートをバインドする時の、デフォルト IP アドレスを指定
   * - ``com.docker.network.driver.mtu``
     - ``--mtu``
     - コンテナのネットワーク MTU を指定
   * - ``com.docker.network.container_iface_prefix``
     - -
     - コンテナのインターフェースに対し任意のプレフィクスを指定

.. The following arguments can be passed to docker network create for any network driver, again with their approximate equivalents to docker daemon.

以下の引数は ``docker network create`` 実行時、あらゆるネットワーク・ドライバで指定できます。ほとんどが ``docker daemon`` で指定する項目と同等です。

.. list-table::
   :header-rows: 1
   
   * - オプション
     -  同等
     - 説明

   * - ``--geteway``
     - ―
     - マスタ・サブネットに対する IPv4 または IPv6 ゲートウェイ
   * - ``--ip-range``
     - ``--fixed-cidr``
     - 範囲内で割り当てる IP アドレス
   * - ``--internal``
     - ―
     - 外部ネットワークに対する接続を制限
   * - ``--ipv6``
     - ``--ipv6``
     - IPv6 ネットワーク機能を有効化
   * - ``--subnet``
     - ``--bip``
     - ネットワーク用のサブネット

.. For example, let’s use -o or --opt options to specify an IP address binding when publishing ports:

例えば、ポート公開用に使う IP アドレスを割り当てるには、 ``-o`` か ``--opt`` オプションを使います。

.. code-block:: bash

   $ docker network create \
       -o "com.docker.network.bridge.host_binding_ipv4"="172.19.0.1" \
       simple-network

.. Network internal mode
.. _network-internal-mode:
ネットワーク内部(internal)モード
----------------------------------------

.. By default, when you connect a container to an overlay network, Docker also connects a bridge network to it to provide external connectivity. If you want to create an externally isolated overlay network, you can specify the --internal option.

コンテナを ``overlay`` ネットワークに接続する時、デフォルトでは外部への接続性を提供するためブリッジ・ネットワークにも接続します。外部された隔離された ``overlay`` ネットワークを作成したい場合は、 ``--internal`` オプションを使います。

.. Network ingress mode
.. _network-ingress-mode:
ネットワーク ingress モード
------------------------------

.. You can create the network which will be used to provide the routing-mesh in the swarm cluster. You do so by specifying --ingress when creating the network. Only one ingress network can be created at the time. The network can be removed only if no services depend on it. Any option available when creating an overlay network is also available when creating the ingress network, besides the --attachable option.

swarm クラスタ内で、ルーティング・メッシュを利用可能にするネットワークを作成可能です。そのためには、ネットワークの作成時に ``--ingress`` を指定します。1度に作成できる ingress ネットワークは 1 つだけです。ネットワーク上にサービスが存在しない場合のみ、このネットワーク削除できます。 ingress ネットワークの作成時に、 overlay ネットワークで利用可能なオプションを指定できるのに加え、さらに ``--atachable`` オプションも利用できます。

.. code-block:: bash

   $ docker network create -d overlay \
     --subnet=10.11.0.0/16 \
     --ingress \
     --opt com.docker.network.driver.mtu=9216 \
     --opt encrypted=true \
     my-ingress-network

レイ・ネットワークの両方に接続できます。

.. Parent command

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker network <network>`
     - ネットワークを管理



.. Related commands

関連コマンド
====================

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker network connect <network_connect>`
     - コンテナをネットワークに接続
   * - :doc:`docker network craete <network_create>`
     - ネットワーク作成
   * - :doc:`docker network disconnect <network_disconnect>`
     - ネットワークからコンテナを切断
   * - :doc:`docker network inspect <network_inspect>`
     - 1つまたは複数ネットワークの情報を表示
   * - :doc:`docker network ls <network_ls>`
     - ネットワーク一覧表示
   * - :doc:`docker network prune <network_prune>`
     - 使用していないネットワークを全て削除
   * - :doc:`docker network rm <network_rm>`
     - 1つまたは複数ネットワークの削除


.. seealso:: 

   docker network create
      https://docs.docker.com/engine/reference/commandline/network_create/
