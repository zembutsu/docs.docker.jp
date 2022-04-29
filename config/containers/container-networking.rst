.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/config/containers/container-networking/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/config/containers/container-networking.md
   doc version: 20.10
.. check date: 2022/04/27
.. Commits on Oct 2, 2020 9d75707c3fbf65e55d98866622881ac97c9a42a1
.. ---------------------------------------------------------------------------

.. Container networking
.. _container-networking:

=======================================
コンテナの :ruby:`ネットワーク機能 <networking>`
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. The type of network a container uses, whether it is a bridge, an overlay, a macvlan network, or a custom network plugin, is transparent from within the container. From the container’s point of view, it has a network interface with an IP address, a gateway, a routing table, DNS services, and other networking details (assuming the container is not using the none network driver). This topic is about networking concerns from the point of view of the container.

コンテナが使うネットワークの種類とは、 :doc:`bridge </network/bridge>` 、 :doc:`overlay </network/overlay>` 、 :doc:`macvlan ネットワーク </network/macvlan>` 、あるいは任意のネットワーク プラグインであり、コンテナ内からは見られません（ :ruby:`透過的 <transparent>` ）。コンテナの視点からすると、コンテナにはネットワーク インタフェースがあり、IP アドレス、ゲートウェイ、ルーティング テーブル、DNS サービス、その他のネットワーク機能詳細があるように見えます（コンテナは ``none`` ネットワークを使っていないのを想定）。このトピックでは、コンテナ内の視点からネットワークについて考えます。

.. Published ports
.. _published-port:
:ruby:`公開された <published>` ポート
========================================

.. By default, when you create or run a container using docker create or docker run, it does not publish any of its ports to the outside world. To make a port available to services outside of Docker, or to Docker containers which are not connected to the container’s network, use the --publish or -p flag. This creates a firewall rule which maps a container port to a port on the Docker host to the outside world. Here are some examples.

デフォルトでは、 ``docker create`` や ``docker run`` を使ってコンテナの作成時、コンテナ内のあらゆるポートは外の世界に対して公開されません。Docker の外でサービスに対するポートを有効にするには、あるいは、コンテナのネットワークに接続していない Docker コンテナに接続するには、 ``--publish`` か ``-p`` フラグを使います。これにより、 Docker ホスト上にあるコンテナのポートを、外の世界に :ruby:`割り当てる <map>` ファイアウォールのルールを作成します。


.. list-table::
   :header-rows: 1

   * - フラグの値
     - 説明
   * - ``-p 8080:80``
     - Docker ホスト上のポート 8080 に、コンテナ内の TCP ポート 80 を割り当て
   * - ``-p 192.168.1.100:8080:80``
     - Docker ホスト上のホスト IP 192.168.1.100 に対するポート 8080 に、コンテナ内の TCP ポート 80 を割り当て
   * - ``-p 8080:80/udp``
     - Docker ホスト上のポート 8080 に、コンテナ内の UDP ポート 80 を割り当て
   * - ``-p 8080:80/tcp -p 8080:80/udp``
     - Docker ホスト上の TCP ポート 8080 に、コンテナ内の TCP ポート 80 をわりあて。かつ、Docker ホスト上の UDP ポート 8080 に、コンテナ内の UDP ポート 80 を割り当て

.. IP address and hostname
IP アドレスとホスト名
==============================

.. By default, the container is assigned an IP address for every Docker network it connects to. The IP address is assigned from the pool assigned to the network, so the Docker daemon effectively acts as a DHCP server for each container. Each network also has a default subnet mask and gateway.

デフォルトでは、Docker の各ネットワークに接続するコンテナに対し、 IP アドレスが割り当てられます。割り当てられる IP アドレスとは、ネットワークに割り当てがプール（保持）されているものです。そのため、 Docker デーモンは各コンテナに対する DHCP サーバとして事実上機能します。また、各ネットワークはデフォルトのサブネットマスクとゲートウェイも持ちます。

.. When the container starts, it can only be connected to a single network, using --network. However, you can connect a running container to multiple networks using docker network connect. When you start a container using the --network flag, you can specify the IP address assigned to the container on that network using the --ip or --ip6 flags.

コンテナの起動時、コンテナは ``--network`` で指定した1つのネットワークに接続します。一方、実行中のコンテナは ``docker network connect`` を使えば、複数のネットワークに接続可能です。コンテナ起動時に ``--network`` フラグを使う場合は、 ``--ip`` か ``--ipv6`` フラグを使い、コンテナがネットワークに接続する IP アドレスを指定できます。

.. When you connect an existing container to a different network using docker network connect, you can use the --ip or --ip6 flags on that command to specify the container’s IP address on the additional network.

既存のコンテナが、 ``docker network connect`` を使った別のネットワークに接続する場合は、 ``--ip`` か ``--ipv6`` フラグを使うと、追加ネットワークに対するコンテナの IP アドレスを指定する命令になります。

.. In the same way, a container’s hostname defaults to be the container’s ID in Docker. You can override the hostname using --hostname. When connecting to an existing network using docker network connect, you can use the --alias flag to specify an additional network alias for the container on that network.

同様に、コンテナのホスト名は、デフォルトでは Docker のコンテナ ID です。これは ``--hostname`` を使えば上書きできます。 ``docker network connect`` を使った既存のネットワークに接続する場合は、 ``--alias`` フラグを使い、そのネットワーク上でコンテナに対する追加のネットワーク エイリアス（別名）を指定できます。

.. DNS services
.. _dns-service:
DNS サービス
====================

.. By default, a container inherits the DNS settings of the host, as defined in the /etc/resolv.conf configuration file. Containers that use the default bridge network get a copy of this file, whereas containers that use a custom network use Docker’s embedded DNS server, which forwards external DNS lookups to the DNS servers configured on the host.

デフォルトでは、コンテナはホスト上の ``/etc/resolv.con`` で定義された DNS 設定を継承します。コンテナがデフォルトで使う ``bridge`` ネットワークでは、このファイルのコピーを取得します。一方で、 :ruby:`カスタム ネットワーク <use-user-defined-bridge-networks>` を使うコンテナは Docker 内蔵 DNS サーバを使い、これは、ホスト上で設定された DNS サーバを使い、外部の DNS へ問い合わせを転送します。

.. Custom hosts defined in /etc/hosts are not inherited. To pass additional hosts into your container, refer to add entries to container hosts file in the docker run reference documentation. You can override these settings on a per-container basis.

``/etc/hosts`` で定義されたカスタム ホストは継承されません。コンテナに追加のホストを渡したい場合は、 ``docker run`` リファレンス ドキュメントの :ref:`docker_run-add-entries-to-container-hosts-file` をご覧ください。これらの設定は、コンテナごとに基づいて上書き可能です。

.. list-table::
   :header-rows: 1

   * - フラグの値
     - 説明
   * - ``--dns``
     - DNS サーバの IP アドレス。複数の DNS サーバを指定するには、 ``--dns`` フラグを複数回使用する。もしもコンテナが指定した IP アドレスのいずれにも到達できなければ、Google の DNS サーバ ``8.8.8.8`` が追加され、インターネットのドメインの名前解決が可能になる。
   * - ``--dns-search``
     - ドメイン名が省略されているホスト名を検索するための、 DNS 検索ドメイン名を指定。複数の DNS 検索プレフィックスを指定するには、複数の ``--dns-search`` フラグを使う。
   * - ``--dns-opt``
     - キーバリューのペアは、 DNS オプションとその値。有効なオプションは、各オペレーティングシステムの ``resolv.conf`` に関するドキュメントを参照。
   * - ``--hostname``
     - コンテナが自身で使うホスト名。指定しなければ、デフォルトはコンテナ ID 。

.. Proxy server
プロキシ サーバ
====================

.. If your container needs to use a proxy server, see Use a proxy server.

コンテナでプロキシサーバを使う必要がある場合は、 :doc:`プロキシサーバの使用 <proxy>` をご覧ください。

.. seealso:: 

   Container networking
      https://docs.docker.com/config/containers/container-networking/
