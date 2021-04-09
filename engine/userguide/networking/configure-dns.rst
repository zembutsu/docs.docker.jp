.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/userguide/networking/configure-dns/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/userguide/networking/configure-dns.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/userguide/networking/configure-dns.md
.. check date: 2016/06/14
.. Commits on Mar 1, 2016 9f8f28684f196ff3790ff1c738e81743821fc860
.. ---------------------------------------------------------------------------

.. Embedded DNS server in user-defined networks

.. _embedded-dns-server-in-user-defined-networks:

===================================================
ユーザ定義ネットワーク用の内部 DNS サーバ
===================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. The information in this section covers the embedded DNS server operation for containers in user-defined networks. DNS lookup for containers connected to user-defined networks works differently compared to the containers connected to default bridge network.

このセクションで扱う情報は、内部 DNS サーバ（embedded DNS server）をユーザ定義ネットワーク上で操作する方法です。ユーザ定義ネットワークに接続したコンテナは、 DNS の名前解決の仕方がデフォルトの ``bridge`` ネットワークとは異なります。

..    Note: In order to maintain backward compatibility, the DNS configuration in default bridge network is retained with no behavioral change. Please refer to the DNS in default bridge network for more information on DNS configuration in the default bridge network.

.. note::

   後方互換性を維持するため、デフォルトの ``bridge`` ネットワークにおける DNS 設定方法は何も変わりません。デフォルトの ``bridge`` ネットワークにおける DNS 設定に関する詳しい情報は :doc:`default_network/configure-dns` をご覧ください。

.. As of Docker 1.10, the docker daemon implements an embedded DNS server which provides built-in service discovery for any container created with a valid name or net-alias or aliased by link. The exact details of how Docker manages the DNS configurations inside the container can change from one Docker version to the next. So you should not assume the way the files such as /etc/hosts, /etc/resolv.conf are managed inside the containers and leave the files alone and use the following Docker options instead.

Docker 1.10 では、docker デーモンに内蔵 DNS サーバを実装しました。これはコンテナ作成時の有効な ``名前 (name)`` もしくは ``ネット・エイリアス (net-alias)`` または ``リンク (link)`` の別名を元にしたサービス・ディスカバリを提供します。Docker がコンテナ内で DNS 設定を管理する手法は、以降の Docker バージョンでは変わります。そのため、コンテナ内にある ``/etc/hosts`` と ``/etc/resolv.conf`` のようなファイルを考慮する必要はなくなり、これらのファイルはそのままにし、以下で挙げる Docker のオプションが指定できます。

.. Various container options that affect container domain name services.

複数のコンテナに対するオプションは、コンテナのドメインネーム・サービス（DNS）に影響を与えます。

* ``--name=コンテナ名`` …  ``--name`` で設定するコンテナ名は、ユーザ定義 Docker ネットワーク内でディスカバリ用に使われます。内部 DNS サーバは、このコンテナ名と（コンテナが接続するネットワーク上の） IP アドレスに対応し続けます。
* ``--net-alias=エイリアス名`` …  ユーザ定義ネットワーク内では、コンテナを見つける（ディスカバリする）ためには、この上にある ``--name`` に加えて１つまたは複数の ``--net-alias`` を指定できます（あるいは、 ``docker network connect`` コマンドで ``--alias`` を使います）。内部 DNS サーバは、指定したユーザ定義ネットワーク内において、全てのコンテナ・エイリアス名（別名）と IP アドレスを対応し続けます。 ``docker network connect`` コマンドで ``--alias`` を使うことで、ネットワークごとに別々のエイリアス名が利用できます。
* ``--link=コンテナ名:エイリアス名`` …  このオプションをコンテナの ``run`` （実行）時に指定したら、内部 DNS は ``エイリアス`` 名の追加エントリを指定します。これは ``コンテナ名`` を指定したコンテナの IP アドレスに対して、別の名前でアクセスできるようにします。内蔵 DNS では ``--link`` が指定されたら、 ``--link`` が指定されたコンテナの中から、唯一の結果のみ返します。これにより、内部のプロセスがコンテナの名前や IP アドレスを知らなかくても、新しいコンテナに接続できるようにします。
* ``--dns=[IPアドレス...]`` … コンテナから名前解決のリクエストがあっても、内部 DNS サーバが名前解決できない時、DNS クエリを ``--dns`` オプションで指定した IP アドレスに転送します。 ``--dns`` の IP アドレスは内部 DNS サーバによって管理されるため、コンテナ内の ``/etc/resolv.conf`` ファイルを変更しません。
* ``--dns-search=ドメイン名...`` …  コンテナ内部で使うホスト名にドメイン名が含まれていない時に、検索用に使うドメイン名を指定します。 ``--dns-search`` オプションは内部 DNS サーバによって管理されるため、コンテナ内の ``/etc/resolv.conf`` ファイルを変更しません。
* ``--dns-opt=オプション...`` … DNS リゾルバが使うオプションを設定します。これらオプションは内部 DNS サーバによって管理されるため、コンテナ内の ``/etc/resolv.conf`` ファイルを編集しません。利用可能なオプションについては、 ``resolv.conf`` のドキュメントをご覧ください。

.. In the absence of the --dns=IP_ADDRESS..., --dns-search=DOMAIN..., or --dns-opt=OPTION... options, Docker uses the /etc/resolv.conf of the host machine (where the docker daemon runs). While doing so the daemon filters out all localhost IP address nameserver entries from the host’s original file.

``--dns=IPアドレス...`` 、 ``--dns-search=ドメイン名...`` 、 ``--dns-opt=オプション...`` の指定がなければ、 Docker はホストマシン上（ ``docker`` デーモンの実行環境 ）の ``/etc/resolv.conf`` を使います。この時、Docker デーモンは、ホスト上のオリジナル・ファイル上にある ``nameserver`` のエントリ、ここにある localhost の IP アドレス全てをフィルタします。

.. Filtering is necessary because all localhost addresses on the host are unreachable from the container’s network. After this filtering, if there are no more nameserver entries left in the container’s /etc/resolv.conf file, the daemon adds public Google DNS nameservers (8.8.8.8 and 8.8.4.4) to the container’s DNS configuration. If IPv6 is enabled on the daemon, the public IPv6 Google DNS nameservers will also be added (2001:4860:4860::8888 and 2001:4860:4860::8844).

フィルタリングが必要なのは、コンテナのネットワークから、ホスト上の localhost のアドレス全てに到達できるとは限らないためです。フィルタリング後は、コンテナ内の ``/etc/resolv.conf`` ファイルに ``nameserver`` のエントリが一切なくなります。そしてデーモンはコンテナの DNS 設定として、パブリックな Google DNS ネームサーバ（ 8.8.8.8 と 8.8.4.4 ）を追加します。デーモンで IPv6 が有効であれば、パブリックな Google の IPv6 DNS ネームサーバ（ 2001:4860:4860::8888 と 2001:4860:4860::8844 ）を追加します。

..    Note: If you need access to a host’s localhost resolver, you must modify your DNS service on the host to listen on a non-localhost address that is reachable from within the container.

.. note::

   ホスト側のローカルホストにあるリゾルバにアクセスするには、コンテナ内から DNS サーバに到達可能になるように、ローカルホスト以外からも接続可能になるよう、リッスンする必要があります。

.. seealso:: 

   Embedded DNS server in user-defined networks
      https://docs.docker.com/engine/userguide/networking/configure-dns/
