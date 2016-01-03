.. http://docs.docker.com/compose/networking/
.. doc version: 1.9
.. check date: 2015/11/22

.. Networking in Compose

==============================
Compose のネットワーク機能
==============================

.. Note: Compose’s networking support is experimental, and must be explicitly enabled with the docker-compose --x-networking flag.

.. note::

   Compose のネットワーク機能のサポートは実験的であり、利用するためには ``docker-compose --x-networking`` フラグで明示する必要があります。

.. Compose sets up a single default network for your app. Each container for a service joins the default network and is both reachable by other containers on that network, and discoverable by them at a hostname identical to the container name.

Compose はアプリケーションに対して、デフォルト・ :doc:`ネットワーク </engine/reference/commandline/network_create>` を１つ設定します。各コンテナ上のサービスはデオフォルト・ネットワークに参加し、そのネットワーク上の他のコンテナとは *通信可能* です。しかしコンテナ名はホスト名とは独立しているため、*名前では発見できません* 。

..     Note: Your app’s network is given the same name as the “project name”, which is based on the name of the directory it lives in. See the Command line overview for how to override it.

.. note::

   アプリケーション用のネットワークには、"プロジェクト名" と同じ名前が割り当てられます。プロジェクト名とは、作業している基準の（ベースとなる）ディレクトリ名です。変更方法は :doc:`コマンドラインの概要 </compose/reference/docker-compose>` をご覧ください。

.. For example, suppose your app is in a directory called myapp, and your docker-compose.yml looks like this:

例として、アプリケーションを置いたディレクトリ名を ``myapp`` とし、``docker-compose.yml`` は次のような内容とします。

.. code-block:: yaml

   web:
     build: .
     ports:
       - "8000:8000"
   db:
     image: postgres

.. When you run docker-compose --x-networking up, the following happens:

``docker-compose --x-networking up`` を実行すると、次の動作します。

..     A network called myapp is created.
    A container is created using web’s configuration. It joins the network myapp under the name myapp_web_1.
    A container is created using db’s configuration. It joins the network myapp under the name myapp_db_1.

1. ``myapp`` という名称のネットワークを作成します。
2. ``web`` 設定を使ったコンテナを作成します。これをネットワーク ``myapp`` に対して、``myapp_web_1`` という名称で追加します。
3. ``db`` 設定を使ったコンテナを作成します。これをネットワーク ``myapp`` に対して ``myapp_db_1`` という名称で追加します。

.. Each container can now look up the hostname myapp_web_1 or myapp_db_1 and get back the appropriate container’s IP address. For example, web’s application code could connect to the URL postgres://myapp_db_1:5432 and start using the Postgres database.

各コンテナは、これでホスト名を ``myapp_web_1`` あるいは ``myapp_db_1`` で名前解決することにより、コンテナに割り当てられた IP アドレスが分かります。例えば、``web`` アプリケーションのコードが URL  ``postgres://myapp_db_1:5432`` にアクセスできるようになり、PostgreSQL データベースを利用開始します。

.. Because web explicitly maps a port, it’s also accessible from the outside world via port 8000 on your Docker host’s network interface.

``web`` はポートの割り当てを明示しているため、Docker ホスト側のネットワーク・インターフェース上からも、ポート 8000 を通して外からアクセス可能です。

.. Note: in the next release there will be additional aliases for the container, including a short name without the project name and container index. The full container name will remain as one of the alias for backwards compatibility.

.. note::

   次のリリースでは、コンテナに対する追加エイリアスを追加します。これはプロジェクト名とコンテナのインデックス（一覧）が不要な短い名前です。コンテナの完全名は、後方互換性のためにエイリアスの１つとして残し続けます。

.. Updating containers

コンテナのアップデート
==============================

.. If you make a configuration change to a service and run docker-compose up to update it, the old container will be removed and the new one will join the network under a different IP address but the same name. Running containers will be able to look up that name and connect to the new address, but the old address will stop working.

サービスの設定を変更するには、 ``docker-compose up`` を実行して、古いコンテナの削除と新しいコンテナをネットワーク下で起動します。IP アドレスは異なりますが、ホスト名は同じです。実行中のコンテナはその名前で名前解決が可能になり、新しい IP アドレスで接続できますが、古い IP アドレスは機能しなくなります。

.. If any containers have connections open to the old container, they will be closed. It is a container’s responsibility to detect this condition, look up the name again and reconnect.

もし古いコンテナに対して接続しているコンテナがあれば、切断されます。この状況検知はコンテナ側の責任であり、名前解決を再度行い再接続します。

.. Configure how services are published

サービス公開方法の設定
==============================

.. By default, containers for each service are published on the network with the container name. If you want to change the name, or stop containers from being discoverable at all, you can use the container_name option:

デフォルトでは、コンテナの各サービスは、コンテナ名を使ってネットワーク上に公開されます。コンテナの名前を変更するには、``container_name`` オプションを使います。

.. code-block:: yaml

   web:
     build: .
     container_name: "my-web-application"


.. Links

リンク
==========

.. Docker links are a one-way, single-host communication system. They should now be considered deprecated, and you should update your app to use networking instead. In the majority of cases, this will simply involve removing the links sections from your docker-compose.yml.

Docker のリンク（link）は、一方通行の単一ホスト上における通信システムです。この機能は廃止される可能性があり、アプリケーションはネットワーク機能を使うようにアップデートすべきです。多くの場合は、``docker-compose.yml`` で ``link`` セクションを削除するだけです。

.. Specifying the network driver

ネットワークドライバの指定
==============================

.. By default, Compose uses the bridge driver when creating the app’s network. The Docker Engine provides one other driver out-of-the-box: overlay, which implements secure communication between containers on different hosts (see the next section for how to set up and use the overlay driver). Docker also allows you to install custom network drivers.

アプリケーションがネットワークを作成するとき、Compose は ``bridge`` ドライバをデフォルトで使います。Docker Engine は、他にも革新的な ``overlay``  ドライバを提供します。このドライバは異なったホスト上のコンテナ間で、安全な通信を実装するものです（``overlay`` ドライバのセットアップ方法や使い方は次のセクションをご覧ください）。他にも Docker は :doc:`カスタム・ネットワーク・ドライバ </engine/extend/plugins_network>` のインストールも可能です。

.. You can specify which one to use with the --x-network-driver flag:

これを使うには、``--x-network-driver`` フラグを指定します。


.. code-block:: bash

   $ docker-compose --x-networking --x-network-driver=overlay up

.. Multi-host networking

マルチホスト・ネットワーキング
==============================

.. (TODO: talk about Swarm and the overlay driver)

(TODO: Swarm とオーバレイ・ドライバについて記述)

.. Custom container network modes

コンテナのネットワーク・モードを変更
========================================

.. Compose allows you to specify a custom network mode for a service with the net option - for example, net: "host" specifies that its containers should use the same network namespace as the Docker host, and net: "none" specifies that they should have no networking capabilities.

Compose は ``net`` オプションを指定し、カスタム・ネットワーク・モードを指定できます。例えば、 ``net: "host"`` を指定すると、コンテナは Docker ホストと同じネットワーク名前空間を使います。 ``net: "none"`` を指定すると、ネットワーク機能を持ちません。

.. If a service specifies the net option, its containers will not join the app’s network and will not be able to communicate with other services in the app.

サービスに対して ``net`` オプションを指定すると、そのコンテナはアプリケーションのネットワークには接続 *せず* 、アプリケーション内の他のサービスと通信できなくなります。

.. If all services in an app specify the net option, a network will not be created at all.

アプリケーションにおける全てのサービスで ``net`` オプションを指定すると、ネットワークを作成しません。


