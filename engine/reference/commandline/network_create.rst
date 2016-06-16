.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/network_create/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/network_create.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/network_create.md
.. check date: 2016/06/16
.. Commits on Jun 26, 2016 feabf71dc1cd5757093c5887b463a6cbcdd83cc2
.. -------------------------------------------------------------------

.. network create

=======================================
network create
=======================================

.. code-block:: bash

Usage:  docker network create [OPTIONS]

   ネットワークの作成
   
   オプション:
         --aux-address value    追加 ipv4 または ipv6 アドレスが使うネットワーク・ドライバ (デフォルト map[])
     -d, --driver string        ネットワーク・ブリッジまたはオーバレイを管理するドライバ (デフォルト "bridge")
         --gateway value        マスタ・サブネット用の ipv4 または ipv6 ゲートウェイ (default [])
         --help                 使い方の表示
         --internal             ネットワークから外部へのアクセスを制限
         --ip-range value       サブ・レンジからコンテナの IP アドレスを割り当て (default [])
         --ipam-driver string   IP アドレス管理用ドライバ (デフォルト "default")
         --ipam-opt value        カスタム IPAM ドライバ固有のオプションを指定 (デフォルト map[])
         --ipv6                 IPv6 ネットワーク機能の有効か
         --label value          ネットワークにメタデータを指定 (デフォルト [])
     -o, --opt value            ドライバ用のオプションを指定 (デフォルト map[])
         --subnet value         ネットワーク・セグメントを表すサブネットを CIDR 形式で指定 (default [])

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Creates a new network. The DRIVER accepts bridge or overlay which are the built-in network drivers. If you have installed a third party or your own custom network driver you can specify that DRIVER here also. If you don’t specify the --driver option, the command automatically creates a bridge network for you. When you install Docker Engine it creates a bridge network automatically. This network corresponds to the docker0 bridge that Engine has traditionally relied on. When launch a new container with docker run it automatically connects to this bridge network. You cannot remove this default bridge network but you can create new ones using the network create command.

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

.. It is also a good idea, though not required, that you install Docker Swarm on to manage the cluster that makes up your network. Swarm provides sophisticated discovery and server management that can assist your implementation.

もう１つの良いアイディアとしては、これらの設定を行わなくても、Docker Swarm でネットワークも管理できるクラスタの管理もできます。Swarm は知的なディスカバリとサーバ管理を提供しますので、実装にあたっての手助けとなるでしょう。

.. Once you have prepared the overlay network prerequisites you simply choose a Docker host in the cluster and issue the following to create the network:

``overlay`` ネットワークに必要な準備が整った後は、クラスタ上にあるホストのどれかで次のようなネットワーク作成コマンドを実行します。

.. code-block:: bash

   $ docker network create -d overlay my-multihost-network

.. Network names must be unique. The Docker daemon attempts to identify naming conflicts but this is not guaranteed. It is the user’s responsibility to avoid name conflicts.

ネットワーク名はユニークにする必要があります。Docker デーモンは名前の衝突を避けようとしますが、保証されません。ユーザ・リポジトリも名前の衝突を避けようとします。

.. Connect containers

.. _connect-containers:

コンテナに接続
====================

.. When you start a container use the --net flag to connect it to a network. This adds the busybox container to the mynet network.

コンテナの起動時に ``--net`` フラグを指定したら、ネットワークに接続します。 ``busybox`` コンテナが ``mynet`` ネットワークに接続するには、次のようにします。

.. code-block:: bash

   $ docker run -itd --net=mynet busybox

.. If you want to add a container to a network after the container is already running use the docker network connect subcommand.

既に実行中のコンテナに対してネットワークを接続したい場合は、 ``docker network connect`` サブコマンドを使います。

.. You can connect multiple containers to the same network. Once connected, the containers can communicate using only another container’s IP address or name. For overlay networks or custom plugins that support multi-host connectivity, containers connected to the same multi-host network but launched from different Engines can also communicate in this way.

同じネットワークに複数のコンテナが接続できます。接続したら、コンテナは他のコンテナの IP アドレスか名前で通信できるようになります。 ``overlay`` ネットワークやカスタム・プラグインは、複数のホスト間の接続サポートしていますので、コンテナは同じマルチホスト・ネットワークに接続できるだけでなく、異なった Docker エンジンから起動された環境でも、同様に通信できます。

.. You can disconnect a container from a network using the docker network disconnect command.

コンテナをネットワークから切断するには、 ``docker network disconnect`` コマンドを使います。

.. Specifying advanced options

.. _specifying-advanced-options:

高度なオプションの設定
==============================

.. When you create a network, Engine creates a non-overlapping subnetwork for the network by default. This subnetwork is not a subdivision of an existing network. It is purely for ip-addressing purposes. You can override this default and specify subnetwork values directly using the the --subnet option. On a bridge network you can only create a single subnet:

ネットワークの作成時、デフォルトではエンジンはネットワークのサブネットワークが重複しないようにします。サブネットワークは既存のネットワークの下位にはありません。純粋に IP アドレスを割り当てるためです。このデフォルトを上書きするには、 ``--subnet`` オプションを使ってサブネットワークの値を直接指定します。

.. code-block:: bash

   docker network create --driver=bridge --subnet=192.168.0.0/16 br0

.. Additionally, you also specify the --gateway --ip-range and --aux-address options.

更に、他にも ``--gateway`` ``--ip-range`` ``--aux-address`` オプションが利用可能です。

.. code-block:: bash

   $ docker network create \
     --driver=bridge \
     --subnet=172.28.0.0/16 \
     --ip-range=172.28.5.0/24 \
     --gateway=172.28.5.254 \
     br0

.. If you omit the --gateway flag the Engine selects one for you from inside a preferred pool. For overlay networks and for network driver plugins that support it you can create multiple subnetworks.

``--gateway`` フラグを省略したら、エンジンは対象ネットワークの範囲内から１つ選びます。 ``overlay`` ネットワークとネットワーク・ドライバ・プラグインの場合は、複数のサブネットワークの作成をサポートしています。

.. code-block:: bash

   $ docker network create -d overlay \
     --subnet=192.168.0.0/16 \
     --subnet=192.170.0.0/16 \
     --gateway=192.168.0.100 \
     --gateway=192.170.0.100 \
     --ip-range=192.168.1.0/24 \
     --aux-address a=192.168.1.5 --aux-address b=192.168.1.6
     --aux-address a=192.170.1.5 --aux-address b=192.170.1.6
     my-multihost-network

.. Be sure that your subnetworks do not overlap. If they do, the network create fails and Engine returns an error.

サブ・ネットワークが重複しないように気を付けてください。重複したらネットワークの作成に失敗し、エンジンはエラーを表示します。

.. Bridge driver options

.. _bridge-driver-options:

ブリッジ・ドライバのオプション
==============================

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
   * - ``com.docker.network.bridge.mtu``
     - ``--mtu``
     - コンテナのネットワーク MTU を指定

.. The following arguments can be passed to docker network create for any network driver, again with their approximate equivalents to docker daemon.

以下の引数は ``docker network create`` 実行時、あらゆるネットワーク・ドライバで指定できます。ほとんどが ``dockerd`` で指定する項目と同等です。

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

   docker network create -o "com.docker.network.bridge.host_binding_ipv4"="172.19.0.1" simple-network

.. Network internal mode

.. _network-internal-mode:

内部ネットワーク(internal)モード
----------------------------------------

.. By default, when you connect a container to an overlay network, Docker also connects a bridge network to it to provide external connectivity. If you want to create an externally isolated overlay network, you can specify the --internal option.

コンテナを ``overlay`` ネットワークに接続する時、デフォルトでは外部への接続性を提供するためブリッジ・ネットワークにも接続します。外部された隔離された ``overlay`` ネットワークを作成したい場合は、 ``--internal`` オプションを使います。


.. Related information

.. _network-create-related-information:

関連情報
==========

..    network inspect
    network connect
    network disconnect
    network ls
    network rm
    Understand Docker container networks

* :doc:`network inspect <network_inspect>`
* :doc:`network connect <network_connect>`
* :doc:`network disconnect <network_disconnect>`
* :doc:`network ls <network_ls>`
* :doc:`network rm <network_rm>`
* :doc:`Docker コンテナ・ネットワークの理解 </engine/userguide/networking/dockernetworks>`

.. seealso:: 

   network create
      https://docs.docker.com/engine/reference/commandline/network_create/
