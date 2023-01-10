.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/network/bridge/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/network/bridge.md
   doc version: 20.10
.. check date: 2022/04/29
.. Commits on Dec 28, 2021 5b5a4424d0a182204f9ec5fc9508d50755d25e9c
.. ---------------------------------------------------------------------------

.. Use bridge networks

.. _use-bridge-networks:

========================================
ブリッジ・ネットワークの使用
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. In terms of networking, a bridge network is a Link Layer device which forwards traffic between network segments. A bridge can be a hardware device or a software device running within a host machine’s kernel.

ネットワーク機能（networking）におけるブリッジ・ネットワーク（bridge network）とは、ネットワーク・セグメント間にトラフィックを転送するリンク層の装置（Link Layer device）です。ブリッジとは、ハードウェア装置もしくはホストマシンのカーネル内で稼働するソフトウェア装置です。

.. In terms of Docker, a bridge network uses a software bridge which allows containers connected to the same bridge network to communicate, while providing isolation from containers which are not connected to that bridge network. The Docker bridge driver automatically installs rules in the host machine so that containers on different bridge networks cannot communicate directly with each other.

Docker におけるブリッジ・ネットワークとは、ソフトウェア・ブリッジを使い、同じブリッジ・ネットワークにあるコンテナに接続できるようにします。また、コンテナに対するネットワークの隔離も提供しますので、同じブリッジ・ネットワークに接続していないコンテナとは接続しません。Docker のブリッジ・ドライバはホストマシン上にルールを自動設定しますので、異なるブリッジ・ネットワーク上のコンテナは、相互に直接通信できません。

.. Bridge networks apply to containers running on the same Docker daemon host. For communication among containers running on different Docker daemon hosts, you can either manage routing at the OS level, or you can use an overlay network.

ブリッジ・ネットワークの対象は、 **同じ** Docker デーモンホスト上で動作するコンテナです。異なる Docker デーモンホスト上で動作しているコンテナ間で通信をするには、OS レベルでルーティングを管理するか、 :doc:`オーバレイ・ネットワーク <overlay>` を利用できます。

.. When you start Docker, a default bridge network (also called bridge) is created automatically, and newly-started containers connect to it unless otherwise specified. You can also create user-defined custom bridge networks. User-defined bridge networks are superior to the default bridge network.

Docker を起動すると、 :ref:`デフォルト・ブリッジ・ネットワーク <use-the-default-bridge-network>` （ ``bridge`` とも呼びます）が自動的に作成されます。また、新しく起動するコンテナでネットワークの指定が無ければ、このデフォルト・ブリッジ・ネットワークに接続します。 **このデフォルト ``bridge`` ネットワークよりも、ユーザ定義ブリッジ・ネットワークの方が優先です** 。


.. Differences between user-defined bridges and the default bridge

.. _differences-between-user-defined-bridges-and-the-default-bridge:

ユーザ定義ブリッジとデフォルト・ブリッジとの違い
==================================================

..    User-defined bridges provide automatic DNS resolution between containers.

* **ユーザ定義ブリッジ・ネットワークは、コンテナ間の DNS 名前解決を自動で提供**

   ..    Containers on the default bridge network can only access each other by IP addresses, unless you use the --link option, which is considered legacy. On a user-defined bridge network, containers can resolve each other by name or alias.

   過去の機能（レガシー）と考えられている :doc:`--link オプション <links>` を使わなければ、 デフォルト・ブリッジ・ネットワーク上のコンテナは IP アドレスを使わないとお互いに通信できません。ユーザ定義ブリッジ・ネットワーク上であれば、コンテナはお互いに名前もしくはエイリアス（別名）で名前解決できます。
   
   ..    Imagine an application with a web front-end and a database back-end. If you call your containers web and db, the web container can connect to the db container at db, no matter which Docker host the application stack is running on.
   
   ウェブ・フロントエンドとデータベース・バックエンドのアプリケーションを想定しましょう。コンテナの名前が ``web`` と ``db`` であれば、 ``web`` コンテナは db コンテナに対して ``db`` という名前で接続でき、Docker ホスト上でどのようなアプリケーションが稼働していても気にかける必要がありません。
   
   ..    If you run the same application stack on the default bridge network, you need to manually create links between the containers (using the legacy --link flag). These links need to be created in both directions, so you can see this gets complex with more than two containers which need to communicate. Alternatively, you can manipulate the /etc/hosts files within the containers, but this creates problems that are difficult to debug.
   
   デフォルト・ブリッジ・ネットワーク上で同じアプリケーション・スタックを動かす場合は、コンテナ間のリンクを手動で作成する（過去の機能 ``--link`` フラグを使う）必要があります。このリンクは双方向に作成する必要があるため、2つ以上のコンテナ間で通信が必要になれば、より複雑です。あるいは、コンテナ内の ``/etc/hosts`` ファイルを手で書き換えられますが、デバッグが大変になる問題を生み出します。
   
..    User-defined bridges provide better isolation.

* **隔離のためには、ユーザ定義ブリッジがより望ましい**

   ..    All containers without a --network specified, are attached to the default bridge network. This can be a risk, as unrelated stacks/services/containers are then able to communicate.

   コンテナに ``--network`` を指定しなければ、コンテナはデフォルト・ブリッジ・ネットワークに接続（attach）します。これは関係のないスタックや、サービス、コンテナと通信可能になるため、リスクを引き起こします。

   ..    Using a user-defined network provides a scoped network in which only containers attached to that network are able to communicate.

   ユーザ定義ネットワークを利用するのであれば、コンテナが通信できるネットワークは、そのコンテナが接続しているユーザ定義ネットワーク範囲内にとどまります。

..    Containers can be attached and detached from user-defined networks on the fly.

* **ユーザ定義ネットワークであれば、コンテナの接続・切断を直ちに行えます**

   ..    During a container’s lifetime, you can connect or disconnect it from user-defined networks on the fly. To remove a container from the default bridge network, you need to stop the container and recreate it with different network options.

   コンテナが稼働中であれば、ユーザ定義ネットワークへの接続や切断を直ちに行えます。ただし、デフォルト・ブリッジ・ネットワークからコンテナを削除するには、コンテナの停止が必要であり、さらに異なるネットワーク・オプションでコンテナを再作成する必要があります。

..    Each user-defined network creates a configurable bridge.

* **それぞれのユーザ定義ネットワークは、設定可能なブリッジを作成**

   ..    If your containers use the default bridge network, you can configure it, but all the containers use the same settings, such as MTU and iptables rules. In addition, configuring the default bridge network happens outside of Docker itself, and requires a restart of Docker.

   コンテナがデフォルト・ブリッジ・ネットワークを使う場合、設定は可能ですが、 MTU や ``iptables`` ルールなど、全てのコンテナで同じ設定を使います。付け加えておくと、デフォルト・ブリッジ・ネットワークの設定は Docker 外での処理のため、Docker の再起動が必要です。

   ..    User-defined bridge networks are created and configured using docker network create. If different groups of applications have different network requirements, you can configure each user-defined bridge separately, as you create it.

   ユーザ定義ブリッジ・ネットワークは ``docker network create`` を使って作成と設定ができます。アプリケーションのグループごとに異なるネットワーク要件があれば、それぞれ別々にユーザ定義ネットワークを作成し、設定ができます。

..    Linked containers on the default bridge network share environment variables.

* **デフォルト・ブリッジ・ネットワーク上でリンクしたコンテナ間では、環境変数を共有します**

   ..    Originally, the only way to share environment variables between two containers was to link them using the --link flag. This type of variable sharing is not possible with user-defined networks. However, there are superior ways to share environment variables. A few ideas:

   当初、2つのコンテナ間で環境変数を共有するには :doc:`--link フラグ <links>` を使い、コンテナ間をリンクする方法しかありませんでした。ユーザ定義ネットワークであれば、このような変数共有は不可能です。しかしながら、環境変数を共有するよりも優れた方法がいくつかあります。

   ..        Multiple containers can mount a file or directory containing the shared information, using a Docker volume.

   * Docker ボリュームを使い、複数のコンテナで共有情報を含むファイルやディレクトリを共有。

   ..        Multiple containers can be started together using docker-compose and the compose file can define the shared variables.

   * ``docker-compose`` を使い複数のコンテナを同時に起動し、 compose ファイルで共有変数を定義する。

   ..        You can use swarm services instead of standalone containers, and take advantage of shared secrets and configs.

   * スタンドアロン・コンテナではなく、 swarm サービスを使えば、 :doc:`シークレット </engine/swarm/secrets>` や :doc:`コンフィグ <ɇ/engin/swarm/configs>` を利用できる。

.. Containers connected to the same user-defined bridge network effectively expose all ports to each other. For a port to be accessible to containers or non-Docker hosts on different networks, that port must be published using the -p or --publish flag.

同じユーザ定義ブリッジ・ネットワーク上に接続するコンテナは、事実上すべてのポートをお互いに公開しています。異なるネットワーク上のコンテナや Docker 外のホストからポートにアクセスできるようにするには、 ``-p`` か ``--publish`` フラグを使ってポートの公開（ `published` ）が必須です。

.. Manage a user-defined bridge

.. _manage-a-user-defined-bridge:

ユーザ定義ブリッジの管理
==============================

.. Use the docker network create command to create a user-defined bridge network.

ユーザ定義ブリッジ・ネットワークの作成には、 ``docker network create`` コマンドを使います。

.. code-block:: bash

   $ docker network create my-net

.. You can specify the subnet, the IP address range, the gateway, and other options. See the docker network create reference or the output of docker network create --help for details.

サブネット、IP アドレスの範囲、ゲートウェイ、その他のオプションを指定できます。詳細は :ref:`docker network create <network_create-specify-advanced-options>` リファレンスか、 ``docker network create --help`` の出力をご覧ください。

.. Use the docker network rm command to remove a user-defined bridge network. If containers are currently connected to the network, disconnect them first.

ユーザ定義ブリッジ・ネットワークを削除するには、 ``docker network rm`` コマンドを使います。コンテナがその時点でネットワークに接続中であれば、まず :ref:`ネットワークからの切断 <disconnect-a-container-from-a-user-defined-bridge>` をします。

.. code-block:: bash

   $ docker network rm my-net

..    What’s really happening?
    When you create or remove a user-defined bridge or connect or disconnect a container from a user-defined bridge, Docker uses tools specific to the operating system to manage the underlying network infrastructure (such as adding or removing bridge devices or configuring iptables rules on Linux). These details should be considered implementation details. Let Docker manage your user-defined networks for you.

.. hint::

   実際には何が起こっているのですか？
   
   ユーザ定義ブリッジの作成や削除時、あるいは、ユーザ定義ブリッジへのコンテナの接続や切断時、Docker はオペレーティングシステムに特化したツールを使い、土台とするネットワーク基盤（Linux 上であればブリッジ・デバイスの追加や削除、 ``iptables`` のルール設定など）を管理します。これらの詳細は、実装上の詳細にあたります。自分用のユーザ定義ネットワークは、Docker を使って管理しましょう。


.. Connect a container to a user-defined bridge

.. _connect-a-container-to-a-user-defined-bridge:

ユーザ定義ネットワークにコンテナを接続
========================================

.. When you create a new container, you can specify one or more --network flags. This example connects a Nginx container to the my-net network. It also publishes port 80 in the container to port 8080 on the Docker host, so external clients can access that port. Any other container connected to the my-net network has access to all ports on the my-nginx container, and vice versa.

新しいコンテナの作成時、1つまたは複数の ``--network`` フラグを指定できます。例として Nginx コンテナが ``my-net`` ネットワークに接続するものとします。また、外部のクライアントがポートに接続できるようにするため、コンテナ内のポート 80 を、Docker ホスト上のポート 8080 に公開します。 ``my-net`` ネットワークに接続するあらゆるコンテナは、 ``my-nginx`` コンテナ上の全てのポートに対してアクセス可能ですし、その逆もまた同様です。

.. code-block:: bash

   $ docker create --name my-nginx \
     --network my-net \
     --publish 8080:80 \
     nginx:latest

.. To connect a running container to an existing user-defined bridge, use the docker network connect command. The following command connects an already-running my-nginx container to an already-existing my-net network:

**実行中** のコンテナを既存のユーザ定義ブリッジに接続するには、 ``docker network connect`` コマンドを使います。以下のコマンドは、既に実行している ``my-nginx`` コンテナが稼働している既存の ``my-net`` ネットワークに接続します。

.. code-block:: bash

   $ docker network connect my-net my-nginx

.. Disconnect a container from a user-defined bridge

.. _disconnect-a-container-from-a-user-defined-bridge:

ユーザ定義ネットワークからコンテナを切断
========================================

.. To disconnect a running container from a user-defined bridge, use the docker network disconnect command. The following command disconnects the my-nginx container from the my-net network.

ユーザ定義ブリッジ・ネットワークで実行中のコンテナを切断するには、 ``docker network disconnect`` コマンドを使います。以下のコマンドは ``my-net`` ネットワークから ``my-nginx`` コンテナを切断します。

.. code-block:: bash

  $ docker network disconnect my-net my-nginx


.. Use IPv6

.. _bridge-use-ipv6:

IPv6 を使う
====================

.. If you need IPv6 support for Docker containers, you need to enable the option on the Docker daemon and reload its configuration, before creating any IPv6 networks or assigning containers IPv6 addresses.

Docker コンテナで IPv6 のサポートが必要であれば、IPv6 ネットワークの作成やコンテナに IPv6 アドレスを割り当てる前に、 Docker デーモンで :doc:`有効化するオプション </config/daemon/ipv6>` と、その設定の再読込が必要です。

.. When you create your network, you can specify the --ipv6 flag to enable IPv6. You can’t selectively disable IPv6 support on the default bridge network.

ネットワークの作成時、 IPv6 を有効化するには ``--ipv6`` フラグを使います。デフォルトの ``bridge`` ネットワークでは IPv6 サポートの無効化を選択できません。

.. Enable forwarding from Docker containers to the outside world

.. _enable-forwarding-from-docker-containers-to-the-outside-world:

Docker コンテナから外の世界への転送を有効化
==================================================

.. By default, traffic from containers connected to the default bridge network is not forwarded to the outside world. To enable forwarding, you need to change two settings. These are not Docker commands and they affect the Docker host’s kernel.

デフォルトでは、デフォルト・ブリッジ・ネットワークに接続したコンテナからのトラフィックは、外の世界のネットワークに対して転送 **されません** 。転送を有効にするには、2つの設定を変更する必要があります。これらは Docker コマンドではなく、Docker ホスト上のカーネルに対して影響を与えます。

..    Configure the Linux kernel to allow IP forwarding.

1. Linux カーネルが IP フォワーディングを有効化する設定にします。

   .. code-block:: bash

       $ sysctl net.ipv4.conf.all.forwarding=1

..    Change the policy for the iptables FORWARD policy from DROP to ACCEPT.

2. ``iptables`` に対するポリシーを変更します。 ``FORWARD``ポリシーを ``DROP`` から ``ACCEPT`` にします。

   .. code-block:: bash

       $ sudo iptables -P FORWARD ACCEPT

.. These settings do not persist across a reboot, so you may need to add them to a start-up script.

この設定は再起動後は有効ではありませんので、スタートアップスクリプトに追加する必要があるでしょう。


.. Use the default bridge network

.. _use-the-default-bridge-network:

デフォルト・ブリッジ・ネットワークを使う
========================================

.. The default bridge network is considered a legacy detail of Docker and is not recommended for production use. Configuring it is a manual operation, and it has technical shortcomings.

デフォルトの ``bridge`` ネットワークは Docker にとって過去の機能（レガシー）と考えられており、プロダクションでの利用は推奨されていません。なぜなら、設定は手動で行う必要がありますし、 :ref:`技術的な欠点 <differences-between-user-defined-bridges-and-the-default-bridge>` があります。

.. Connect a container to the default bridge network

.. _connect-a-container-to-the-default-bridge-network:

デフォルト・ブリッジ・ネットワークへコンテナを接続
--------------------------------------------------

.. If you do not specify a network using the --network flag, and you do specify a network driver, your container is connected to the default bridge network by default. Containers connected to the default bridge network can communicate, but only by IP address, unless they are linked using the legacy --link flag.

もしも ``--network`` フラグを使ってネットワークを指定せず、ネットワークドライバの指定がなければ、コンテナはデフォルトの ``bridge`` ネットワークに接続するのがデフォルトの挙動です。デフォルト ``bridge`` ネットワークに接続したコンテナは通信可能ですが、 :doc:`古い機能の --link フラグ <links>` でリンクしていない限り、 IP アドレスのみです。

.. Configure the default bridge network

.. _configure-the-default-bridge-network:

デフォルト・ブリッジ・ネットワークの設定
----------------------------------------

.. To configure the default bridge network, you specify options in daemon.json. Here is an example daemon.json with several options specified. Only specify the settings you need to customize.

デフォルト ``bridge`` ネットワークの設定を変更するには、 ``daemon.json``  のオプション指定が必要です。以下はいくつかのオプションを指定した ``daemon.json`` の例です。設定に必要なオプションのみ指定ください。

.. code-block:: bash

   {
     "bip": "192.168.1.1/24",
     "fixed-cidr": "192.168.1.1/25",
     "fixed-cidr-v6": "2001:db8::/64",
     "mtu": 1500,
     "default-gateway": "192.168.1.254",
     "default-gateway-v6": "2001:db8:abcd::89",
     "dns": ["10.20.1.2","10.20.1.3"]
   }

.. Restart Docker for the changes to take effect.

Docker の再起動後、設定が有効になります。

.. Use IPv6 with the default bridge network

デフォルト・ブリッジ・ネットワークで IPv6 を使う
--------------------------------------------------

.. If you configure Docker for IPv6 support (see Use IPv6), the default bridge network is also configured for IPv6 automatically. Unlike user-defined bridges, you can’t selectively disable IPv6 on the default bridge.

Docker で IPv6 サポートを使う設定をしたら（ :ref:`bridge-use-ipv6` をご覧ください）、デフォルト・ブリッジ・ネットワークもまた IPv6 を自動的に設定します。ユーザ定義ブリッジとは異なり、デフォルト・ブリッジ上では IPv6 の無効化を選択できません。

.. Next steps

次のステップ
====================

..  Go through the standalone networking tutorial
    Learn about networking from the container’s point of view
    Learn about overlay networks
    Learn about Macvlan networks

* :doc:`スタンドアロン・ネットワーク機能のチュートリアル <network-tutorial-standalone>`
* :doc:`コンテナ観点からのネットワーク機能 </config/containers/container-networking>` 
* :doc:`オーバレイ・ネットワーク <overlay>` を学ぶ
* :doc:`macvlan ネットワーク <macvlan>` を学ぶ


.. seealso:: 

   Use bridge networks
      https://docs.docker.com/network/bridge/
