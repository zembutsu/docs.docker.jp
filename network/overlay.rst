.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/network/overlay/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/network/overlay.md
   doc version: 19.03
.. check date: 2020/07/14
.. Commits on Apr 8, 2020 dc1f9f7b4d2f656f5de23d3b7ac69571b270ddca
.. ---------------------------------------------------------------------------

.. Use overlay networks

.. _use-overlay-networks:

========================================
オーバレイ・ネットワークの使用
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. The overlay network driver creates a distributed network among multiple Docker daemon hosts. This network sits on top of (overlays) the host-specific networks, allowing containers connected to it (including swarm service containers) to communicate securely when encryption is enabled. Docker transparently handles routing of each packet to and from the correct Docker daemon host and the correct destination container.

``overlay`` ネットワーク・ドライバは複数の Docker デーモンのホスト間に分散ネットワークを作成します。このネットワークは、ホスト固有のネットワーク上に（オーバレイ：覆い被さるように）位置します。そして、暗号化が有効であれば、オーバレイ・ネットワーク上に接続したコンテナ間（swarm サービスのコンテナも含みます）は安全に通信可能になります。正しいDocker デーモンのホストから、正しい送信先コンテナ間とにおいて、 Docker は透過的に各パケットをルーティングする処理を行います。

.. When you initialize a swarm or join a Docker host to an existing swarm, two new networks are created on that Docker host:

swarm の初期化するか、Docker ホストを既存の swarm へ追加すると、その Docker ホスト上に2つの新しいネットワークが作成されます。

..  an overlay network called ingress, which handles control and data traffic related to swarm services. When you create a swarm service and do not connect it to a user-defined overlay network, it connects to the ingress network by default.
    a bridge network called docker_gwbridge, which connects the individual Docker daemon to the other daemons participating in the swarm.

* ``ingress`` と呼ぶオーバレイ・ネットワークは、swarm サービスに関連する制御とデータ転送を扱います。swarm サービスを作成する時、ユーザ定義オーバレイ・ネットワークへ接続しなければ、サービスはデフォルトで ``ingress`` ネットワークに接続します。
* ``docker_gwbridge`` と呼ぶブリッジ・ネットワークは、個々の Docker デーモンが swarm に参加する他のデーモンに接続します。

.. You can create user-defined overlay networks using docker network create, in the same way that you can create user-defined bridge networks. Services or containers can be connected to more than one network at a time. Services or containers can only communicate across networks they are each connected to.

``docker network create`` を使い、ユーザ定義 ``overlay`` ネットワークを作成できます。これはユーザ定義 ``bridge`` ネットワークを作成できるのと同じ方法です。サービスまたはコンテナは同時に1つまたは複数のネットワークに接続可能です。サービスまたはコンテナは、お互いに接続しているネットワークを横断してのみ通信できます。

.. Although you can connect both swarm services and standalone containers to an overlay network, the default behaviors and configuration concerns are different. For that reason, the rest of this topic is divided into operations that apply to all overlay networks, those that apply to swarm service networks, and those that apply to overlay networks used by standalone containers.

swarm サービスとスタンドアロン・コンテナの両方がオーバレイ・ネットワークに接続可能ですが、デフォルトの挙動と設定に関することは異なります。そのため以降のトピックでは、オーバレイ・ネットワーク全体に適用されることと、swarm サービス・ネットワークに適用されること、スタンドアロン・コンテナによって使われるオーバレイ・ネットワークについてを分けて扱います。

.. Operations for all overlay networks

.. _operations-for-all-overlay-networks:

オーバレイ・ネットワーク全体の操作
========================================

.. Create an overlay network

.. _create-an-overlay-network:

オーバレイ・ネットワークの作成
----------------------------------------

.. note::

   ..    Prerequisites:

   **事前準備**

   ..        Firewall rules for Docker daemons using overlay networks
   ..        You need the following ports open to traffic to and from each Docker host participating on an overlay network:
            TCP port 2377 for cluster management communications
            TCP and UDP port 7946 for communication among nodes
            UDP port 4789 for overlay network traffic
   

   * Docker デーモンがオーバレイ・ネットワークを使うためのファイアウォール・ルール
   
      各 Docker ホストがオーバレイ・ネットワークに参加し、トラフィックをやりとりするには、以下ポートの公開が必要です。
      
         * クラスタ管理通信のため、TCP ポート 2377
         * ノード間での通信のため、TCP および UDP ポート 7946
         * オーバレイ・ネットワークのトラフィック用に UDP ポート 4789
   
   ..        Before you can create an overlay network, you need to either initialize your Docker daemon as a swarm manager using docker swarm init or join it to an existing swarm using docker swarm join. Either of these creates the default ingress overlay network which is used by swarm services by default. You need to do this even if you never plan to use swarm services. Afterward, you can create additional user-defined overlay networks.
   
   * オーバレイ・ネットワークを作成する前に、 ``docker swarm init`` を使い Docker デーモンを swarm manager として初期化するか、あるいは、 ``docker swarm join`` を使って既存の swarm に参加するかのいずれかが必要です。

.. To create an overlay network for use with swarm services, use a command like the following:

swarm サービスが使うオーバレイ・ネットワークを作成するには、以下のようなコマンドを使います。

.. code-block:: bash

   $ docker network create -d overlay my-overlay

.. To create an overlay network which can be used by swarm services or standalone containers to communicate with other standalone containers running on other Docker daemons, add the --attachable flag:

swarm サービス **または** スタンドアロン・コンテナが、Docker デーモン上で実行中の他のスタンドアロン・コンテナと通信可能なオーバレイ・ネットワークを作成するには、 ``--attachable`` フラグを追加します。

.. code-block:: bash

   $ docker network create -d overlay --attachable my-attachable-overlay

.. You can specify the IP address range, subnet, gateway, and other options. See docker network create --help for details.

IP アドレス範囲、サブネット、ゲートウェイ、その他のオプションを指定可能です。詳細は ``docker network create --help`` をご覧ください。

.. Encrypt traffic on an overlay network

.. _encrypt-traffic-on-an-overlay-network:

オーバレイ・ネットワーク上でトラフィック暗号化
--------------------------------------------------

.. All swarm service management traffic is encrypted by default, using the AES algorithm in GCM mode. Manager nodes in the swarm rotate the key used to encrypt gossip data every 12 hours.

全ての swarm サービス管理トラフィックは、デフォルトで全て `GCM の AES アルゴリズム <https://ja.wikipedia.org/wiki/Galois/Counter_Mode>`_ で暗号化されています。swarm 内の manager ノードは、暗号化したゴシップ・データを用いて 12 時間ごとに鍵をローテート（更新）します。

.. To encrypt application data as well, add --opt encrypted when creating the overlay network. This enables IPSEC encryption at the level of the vxlan. This encryption imposes a non-negligible performance penalty, so you should test this option before using it in production.

アプリケーション・データも同様に暗号化するには、オーバレイ・ネットワークの作成時に ``--opt encrypted`` を追加します。これにより xvlan レベルにおける IPSEC 暗号化が有効化します。しかし、この暗号化により、無視できない性能上のペナルティを負います。そのため、このオプションをプロダクションで使う前にテストすべきです。

.. When you enable overlay encryption, Docker creates IPSEC tunnels between all the nodes where tasks are scheduled for services attached to the overlay network. These tunnels also use the AES algorithm in GCM mode and manager nodes automatically rotate the keys every 12 hours.

オーバレイ暗号化を有効化する場合、 Docker は IPSEC トンネルを全てのノード間に作成します。そして、ここを通し、タスクはオーバレイネットワークにアタッチするサービスとしてスケジュールされます。このトンネルも GCM の AES アルゴリズムを使い、manager ノードは 12 時間ごとに鍵を自動的にローテートします。

..  Do not attach Windows nodes to encrypted overlay networks.
    Overlay network encryption is not supported on Windows. If a Windows node attempts to connect to an encrypted overlay network, no error is detected but the node cannot communicate.

.. warning::

   **Windows ノードを暗号化オーバレイ・ネットワークに接続しないでください** 
   
   Windows 上ではオーバレイ・ネットワークの暗号化をサポーしていません。もしも Windows ノードが暗号化オーバレイ・ネットワークに接続を試みると、エラーが出ませんが、ノードは通信できなくなります。

.. Swarm mode overlay networks and standalone containers

.. _swarm-mode-overlay-networks-and-standalone-containers:

swarm モードオーバレイ・ネットワークとスタンドアロン・コンテナ
----------------------------------------------------------------------

.. You can use the overlay network feature with both --opt encrypted --attachable and attach unmanaged containers to that network:

オーバレイ・ネットワーク機能では ``--opt encrypted --attachable`` の両方を使うと、そのネットワークに管理外のコンテナが接続可能二なります。

.. code-block:: bash

   $ docker network create --opt encrypted --driver overlay --attachable my-attachable-multi-host-network

.. Customize the default ingress network

.. _customize-the-default-ingress-network:

デフォルト ingress ネットワークのカスタマイズ
--------------------------------------------------

.. Most users never need to configure the ingress network, but Docker 17.05 and higher allow you to do so. This can be useful if the automatically-chosen subnet conflicts with one that already exists on your network, or you need to customize other low-level network settings such as the MTU.

ほとんどのユーザは ``ingress`` ネットワークの設定変更が不要ですが、 Docker 17.05 以上では変更が可能です。そのため、自動的に選ばれるサブネットが既存のネットワークと衝突する場合や、MTA のような低水準のカスタマイズが必要な場合に役立ちます。

.. Customizing the ingress network involves removing and recreating it. This is usually done before you create any services in the swarm. If you have existing services which publish ports, those services need to be removed before you can remove the ingress network.

``ingress`` ネットワークのカスタマイズに伴い、このネットワークの削除と再作成を行います。swarm 内にサービスを作成していなければ、通常はそのまま完了します。もしもポートを公開しているサービスが存在している場合は、 ``ingress`` ネットワークを削除する前に、それらサービスの削除が必要です。

.. During the time that no ingress network exists, existing services which do not publish ports continue to function but are not load-balanced. This affects services which publish ports, such as a WordPress service which publishes port 80.

``ingress`` ネットワークが一切存在しなくなれば、既存のサービスがポートを公開していなければ機能し続けますが、負荷分散されません。ポート 80 を公開する WordPress のように、ポートを公開するサービスであれば影響を受けます。

..  Inspect the ingress network using docker network inspect ingress, and remove any services whose containers are connected to it. These are services that publish ports, such as a WordPress service which publishes port 80. If all such services are not stopped, the next step fails.

1. ``docker network inspect ingress`` を使って ``ingress`` ネットワークを調査し、そこに接続しているコンテナのサービスを削除します。ポート 80 を公開している WordPress サービスのように、ポートを公開しているサービスがあります。それら全てのサービスを停止しなければ、次のステップは失敗します。

..    Remove the existing ingress network:

2. 既存の ``ingress`` ネットワークを削除します。

   .. code-block:: bash
   
      $ docker network rm ingress
      
      WARNING! Before removing the routing-mesh network, make sure all the nodes
      in your swarm run the same docker engine version. Otherwise, removal may not
      be effective and functionality of newly created ingress networks will be
      impaired.
      Are you sure you want to continue? [y/N]

..    Create a new overlay network using the --ingress flag, along with the custom options you want to set. This example sets the MTU to 1200, sets the subnet to 10.11.0.0/16, and sets the gateway to 10.11.0.2.

3. ``--ingress`` フラグと設定の必要があればカスタム・オプションを付けて、新しいオーバレイ・ネットワークを作成します。以下の例は MTG を 1200 に設定し、サブネットを ``10.11.0.0/16`` に設定し、ゲートウェイを ``10.11.0.2`` に設定します。

   .. code-block:: bash
   
      $ docker network create \
        --driver overlay \
        --ingress \
        --subnet=10.11.0.0/16 \
        --gateway=10.11.0.2 \
        --opt com.docker.network.driver.mtu=1200 \
        my-ingress

   ..     Note: You can name your ingress network something other than ingress, but you can only have one. An attempt to create a second one fails.

   .. note::
   
      ``ingress`` ネットワークに対しては ``ingress`` 以外の名前を付けられますが、作成できる ``ingress`` ネットワークは1つだけです。2つめのネットワークの作成を試みても失敗します。

..    Restart the services that you stopped in the first step.

4. サービスを再起動し、停止した段階のステップに戻ります。

.. Customize the docker_gwbridge interface

.. _customize-the-docker_gwbridge-interface:

docker_gwbridge インタフェースのカスタマイズ
--------------------------------------------------

.. The docker_gwbridge is a virtual bridge that connects the overlay networks (including the ingress network) to an individual Docker daemon’s physical network. Docker creates it automatically when you initialize a swarm or join a Docker host to a swarm, but it is not a Docker device. It exists in the kernel of the Docker host. If you need to customize its settings, you must do so before joining the Docker host to the swarm, or after temporarily removing the host from the swarm.

``docker_gwbridge`` は仮想ブリッジであり、

..    Stop Docker.

1. Docker を停止します。

..    Delete the existing docker_gwbridge interface.

2. 既存の ``docker_gwbridge`` インターフェースを削除します。

   ::
   
      $ sudo ip link set docker_gwbridge down
   
      $ sudo ip link del dev docker_gwbridge

..    Start Docker. Do not join or initialize the swarm.

3. Docker を起動します。swarm への参加や初期化は行わないでください。

..    Create or re-create the docker_gwbridge bridge manually with your custom settings, using the docker network create command. This example uses the subnet 10.11.0.0/16. For a full list of customizable options, see Bridge driver options.

4. ``docker network create`` コマンドを使って、 ``docker_gwbridge``  ブリッジにカスタム設定を加えて再作成します。

   .. code-block:: bash
   
      $ docker network create \
      --subnet 10.11.0.0/16 \
      --opt com.docker.network.bridge.name=docker_gwbridge \
      --opt com.docker.network.bridge.enable_icc=false \
      --opt com.docker.network.bridge.enable_ip_masquerade=true \
      docker_gwbridge

..    Initialize or join the swarm. Since the bridge already exists, Docker does not create it with automatic settings.

5. swarm へ参加するか初期化します。ブリッジは既に存在していますので、Docker は自動設定に基づく作成を行いません。

.. Operations for swarm services

.. _operations-for-swarm-services:

swarm サービスに対する操作
==============================

.. Publish ports on an overlay network

.. _publish-ports-on-an-overlay-network:

オーバレイ・ネットワーク上にポート公開
----------------------------------------

.. Swarm services connected to the same overlay network effectively expose all ports to each other. For a port to be accessible outside of the service, that port must be published using the -p or --publish flag on docker service create or docker service update. Both the legacy colon-separated syntax and the newer comma-separated value syntax are supported. The longer syntax is preferred because it is somewhat self-documenting.

.. |br| raw:: html

   <br />


.. list-table::
   :header-rows: 1
   
   - * フラグの値
     * 説明
   - * -p 8080:80 あるいは |br| -p published=8080,target=80
     * ルーティング・メッシュ上のポート 8080 に、サービス・ポート上の TCP 80 を割り当て
   - * -p 8080:80/udp あるいは |br| -p published=8080,target=80,protocol=udp
     * ルーティング・メッシュ上のポート 8080 に、サービス・ポート上の UDP 80 を割り当て
   - * -p 8080:80/tcp -p 8080:80/udp あるいは |br| -p published=8080,target=80,protocol=tcp |br| -p published=8080,target=80,protocol=udp
     * ルーティング・メッシュ上のポート 8080 に、サービス・ポート上の TCP 80 を割り当て、かつ、ルーティング・メッシュ上のポート 8080 に、サービス・ポート上の UDP 80 を割り当て

.. Bypass the routing mesh for a swarm service

.. _bypass-the-routing-mesh-for-a-swarm-service:

swarm サービス用のルーティング・メッシュを回避
--------------------------------------------------

.. By default, swarm services which publish ports do so using the routing mesh. When you connect to a published port on any swarm node (whether it is running a given service or not), you are redirected to a worker which is running that service, transparently. Effectively, Docker acts as a load balancer for your swarm services. Services using the routing mesh are running in virtual IP (VIP) mode. Even a service running on each node (by means of the --mode global flag) uses the routing mesh. When using the routing mesh, there is no guarantee about which Docker node services client requests.

デフォルトでは、 swarm サービスはルーティング・メッシュを使って、その上でポートを公開します。swarm ノード（そこで対象サービスが動いているかどうかに関係なく）のいずれかの公開ポートに接続すると、サービスが稼働している worker に対して透過的に転送されます。事実上、Docker は swarm サービスに対する負荷分散として振る舞います。ルーティング・メッシュを使うサービスは仮想 IP （VIP）モードとして動作します。たとえ、各サービス上でサービスが動いていたとしても（つまり ``--mode global`` フラグ）、ルーティング・メッシュを使います。ルーティング・メッシュの使用時、Docker ノードがクライアントからの要求を処理する保証はありません。

.. To bypass the routing mesh, you can start a service using DNS Round Robin (DNSRR) mode, by setting the --endpoint-mode flag to dnsrr. You must run your own load balancer in front of the service. A DNS query for the service name on the Docker host returns a list of IP addresses for the nodes running the service. Configure your load balancer to consume this list and balance the traffic across the nodes.

ルーティング・メッシュを回避するには、 ``--endpoint-mode`` を ``dnsrr`` に指定子、DNS ラウンド・ロビン（DNSRR）モードを使ってサービスを起動します。サービスの手前に、自身でロードバランサを置く必要があります。Docker ホスト上のサービス名に対する DNS 問い合わせ（クエリ）が返すのは、サービスを実行しているノードの IP アドレスの一覧です。このリストを使って負荷分散し、ノードを全体にトラフィックを分散するように設定します。

.. Separate control and data traffic

.. _separate-control-and-data-traffic:

制御とデータのトラフィックを分離
----------------------------------------

.. By default, control traffic relating to swarm management and traffic to and from your applications runs over the same network, though the swarm control traffic is encrypted. You can configure Docker to use separate network interfaces for handling the two different types of traffic. When you initialize or join the swarm, specify --advertise-addr and --datapath-addr separately. You must do this for each node joining the swarm.

デフォルトでは、swarm 管理に関連する管理トラフィックと、実行しているアプリケーションからのトラフィックは、同じネットワーク上を通り、swarm はトラフィックの暗号化を制御します。Docker は、この2種類のトラフィクの扱うネットワーク・インターフェースを分けて使えます。swarm の初期化もしくは追加時に、 ``--advertise-addr`` と ``--datapath-addr`` を別々に指定します。これは swarm のノードを参加する度に必須です。

.. Operations for standalone containers on overlay networks

.. _operations-for-standalone-containers-on-overlay-networks:

オーバレイ・ネットワーク上でスタンドアロン・コンテナ用の操作
============================================================

.. Attach a standalone container to an overlay network

.. _attach-a-standalone-container-to-an-overlay-network:

オーバレイ・ネットワークにスタンドアロン・コンテナを接続
------------------------------------------------------------

.. The ingress network is created without the --attachable flag, which means that only swarm services can use it, and not standalone containers. You can connect standalone containers to user-defined overlay networks which are created with the --attachable flag. This gives standalone containers running on different Docker daemons the ability to communicate without the need to set up routing on the individual Docker daemon hosts.

``--attachable`` フラグを付けずに作成する ``ingress`` ネットワークは、swarm サービスしか使えないことを意味し、スタンドアロン・コンテナは利用できません。スタンドアロン・コンテナをユーザ定義オーバレイ・ネットワークに接続するには、ネットワークの作成時に ``--attachable`` フラグを付けて利用可能になります。これにより、異なる Docker ホスト上で動作しているスタンドアロン・コンテナが、個々の Docker デーモン・ホスト上でのルーティング設定を行わずに通信が可能となります。

.. Publish ports

公開ポート
----------


.. list-table::
   :header-rows: 1
   
   - * フラグの値
     * 説明
   - * -p 8080:80
     * オーバレイ・ネットワーク上のポート 8080 に、サービス・ポート上の TCP 80 を割り当て
   - * -p 8080:80/udp 
     * オーバレイ・ネットワーク上のポート 8080 に、サービス・ポート上の UDP 80 を割り当て
   - * -p 8080:80/sctp
     * オーバレイ・ネットワーク上のポート 8080 に、サービス・ポート上の SCTP 80 を割り当て
   - * -p 8080:80/tcp -p 8080:80/udp
     * オーバレイ・ネットワーク上のポート 8080 に、サービス・ポート上の TCP 80 を割り当て、かつ、オーバレイ・ネットワーク上のポート 8080 に、サービス・ポート上の UDP 80 を割り当て

.. _container-discovery:

コンテナ・ディスカバリ
------------------------------

.. For most situations, you should connect to the service name, which is load-balanced and handled by all containers (“tasks”) backing the service. To get a list of all tasks backing the service, do a DNS lookup for tasks.<service-name>.

多くの状況において、サービス名を使って、負荷分散や全てのコンテナ（「tasks」）の背後にあるサービスを扱います。サービスの背後にある全てのタスク一覧を取得するには、 ``tasks.<サービス名>`` に対する DNS 問い合わせをします。

.. Next steps

次のステップ
--------------------

..  Go through the overlay networking tutorial
    Learn about networking from the container’s point of view
    Learn about standalone bridge networks
    Learn about Macvlan networks

* :doc:`オーバレイ・ネットワーク・チュートリアル <network-tutorial-overlay>` に進む
* :doc:`コンテナのポートとして見えるネットワーク機能 </config/containers/container-networking>` について学ぶ
* :doc:`スタンドアロン・ブリッジ・ネットワーク <bridge>` について学ぶ
* :doc:`macvlan ネットワーク <macvlan>` について学ぶ


.. seealso:: 

   Use overlay networks
      https://docs.docker.com/network/overlay/