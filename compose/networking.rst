.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/networking/
.. SOURCE: 
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/networking.md
   doc version: v20.10
      https://github.com/docker/docker.github.io/blob/master/compose/networking.md
.. check date: 2022/07/18
.. Commits on May 30, 2022 4f3bfc3715111ed88b2d7ce2d05da199df80c25d
.. ----------------------------------------------------------------------------

.. Networking in Compose
.. _networking-in-compose:
==================================================
Compose の :ruby:`ネットワーク機能 <networking>`
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. This page applies to Compose file formats version 2 and higher. Networking features are not supported for Compose file version 1 (deprecated).

.. note::

   このページの内容が適用されるのは、 Compose ファイルフォーマットの :doc:`バージョン 2 <compose-file/compose-file-v2>` と :doc:`それ以降 <compose-file>` です。
   ネットワーク機能は :doc:`バージョン 1 <compose-file/compose-file-v1>` ではサポートされません（非推奨）。

.. By default Compose sets up a single network for your app. Each container for a service joins the default network and is both reachable by other containers on that network, and discoverable by them at a hostname identical to the container name.

デフォルトで Compose はアプリに対して１つの :doc:`ネットワーク </engine/reference/commandline/network_create>` を作成します。サービス用の各コンテナはデフォルトのネットワークに接続し、そのネットワーク上で他のコンテナと相互に「 :ruby:`接続可能 <reachable>` 」になります。そして、コンテナ名と同じホスト名として、お互いが「 :ruby:`発見可能 <discoverable>` 」になります。

..  Note
    Your app’s network is given a name based on the “project name”, which is based on the name of the directory it lives in. You can override the project name with either the --project-name flag or the COMPOSE_PROJECT_NAME environment variable.

.. note::

   アプリのネットワークは「プロジェクト名」に基づき作成されます。これは、その場所にいるディレクトリ名が元になります。プロジェクト名は :doc:`--project-name フラグ <reference/index>` や :ref:`COMPOSE_PROJECT_NAME 環境変数 <envvars-compose_project_name>` で上書きできます。

.. For example, suppose your app is in a directory called myapp, and your docker-compose.yml looks like this:

たとえば、 ``myapp`` という名前のディレクトリ内にアプリがあり、 ``docker-compose.yml`` は次のようなものだと想定します。

.. code-block:: yaml

   version: "3.9"
   services:
     web:
       build: .
       ports:
         - "8000:8000"
     db:
       image: postgres
       ports:
         - "8001:5432"

.. When you run docker-compose up, the following happens:

``docker-compose up`` を実行すると、以下の処理が行われます。

..  A network called myapp_default is created.
    A container is created using web’s configuration. It joins the network myapp_default under the name web.
    A container is created using db’s configuration. It joins the network myapp_default under the name db.

1. ``myapp_default`` という名前のネットワークが作成される。
2. ``web`` の設定を使うコンテナが作成される。これは ``myapp_default`` ネットワークに ``web`` という名前で接続する。
3. ``db`` の設置を使うコンテナが作成される。これは ``myapp_default`` ネットワークに ``db`` という名前で接続する。

..    In v2.1+, overlay networks are always attachable
    Starting in Compose file format 2.1, overlay networks are always created as attachable, and this is not configurable. This means that standalone containers can connect to overlay networks.
    In Compose file format 3.x, you can optionally set the attachable property to false.

.. note::

   **v2.1 以上では、オーバレイ ネットワークは常に「attachable」** 
   
   Compose ファイル形式 2.1 からは、オーバレイ ネットワークは常に ``attachable`` として作成され、これは変更できません。つまり、スタンドアロン コンテナはオーバレイ ネットワークに接続できません。
   
   Compose ファイル形式 3.x からは、オプションで ``attachable`` 属性を ``false`` に設定できます。

.. Each container can now look up the hostname web or db and get back the appropriate container’s IP address. For example, web’s application code could connect to the URL postgres://db:5432 and start using the Postgres database.

これで各コンテナはホスト名 ``web`` や ``db`` で探せるようになり、適切なコンテナの IP アドレスが帰ってきます。たとえば、 ``web`` アプリケーションのコードが URL ``postgres://db:5432`` に接続すると、Postgres データベースを使用開始します。

.. It is important to note the distinction between HOST_PORT and CONTAINER_PORT. In the above example, for db, the HOST_PORT is 8001 and the container port is 5432 (postgres default). Networked service-to-service communication uses the CONTAINER_PORT. When HOST_PORT is defined, the service is accessible outside the swarm as well.

重要な注意点として、 ``HOST_PORT`` と ``CONTAINER_PORT`` は区別が必要です。先述の例では、 ``db`` の場合、 ``HOST_PORT`` は ``8001`` で、コンテナのポートは ``5432`` です（postgres のデフォルト）。ネットワーク内のサービス間通信で使うのは ``CONTAINER_PORT`` です。 ``HOST_PORT`` を定義した場合、サービスは swam （クラスタ）外からも同様にアクセスできるようになります。

.. Within the web container, your connection string to db would look like postgres://db:5432, and from the host machine, the connection string would look like postgres://{DOCKER_IP}:8001.

``web`` コンテナ内では、 ``db`` に接続する文字列は ``postgres://db:5432`` のようになります。ホストマシン上から接続する文字列は ``postgres://{DOCKER_IP}:8001`` のようになります。

.. Update containers
.. _compose-upate-containers:
コンテナの更新
====================

.. If you make a configuration change to a service and run docker-compose up to update it, the old container is removed and the new one joins the network under a different IP address but the same name. Running containers can look up that name and connect to the new address, but the old address stops working.

サービスの設定情報に変更を加え、 ``docker-compose up`` を実行すると、設定情報は更新されるため、古いコンテナは削除され、新しいコンテナがネットワークに接続します。この時、ネットワーク上の名前は同じですが IP アドレスは異なります。実行中のコンテナは名前で名前解決できますので、新しい IP アドレスに接続できます。その一方、古い IP アドレスは動作を停止します。

.. If any containers have connections open to the old container, they are closed. It is a container’s responsibility to detect this condition, look up the name again and reconnect.

古いコンテナに対して接続していたあらゆるコンテナは、接続が閉じられます。コンテナはこの状況を検出する役割があり、再び同じ名前で名前解決し、再接続します。

.. Links
.. _compose-links:
links
==========

.. Links allow you to define extra aliases by which a service is reachable from another service. They are not required to enable services to communicate - by default, any service can reach any other service at that service’s name. In the following example, db is reachable from web at the hostnames db and database:

あるサービスに対して他のサービスから接続するために、 links によって追加の :ruby:`別名 <alias>` を定義できます。通信するサービスに対し、必ずしも設定する必要はありません。デフォルトでは、あらゆるサービスは、サービス名を使って他のサービスに到達できます。以下の例では、 ``db`` は ``web`` からホスト名 ``db`` と ``database`` で到達できます。

.. code-block:: yaml

   version: "3.9"
   services:
   
     web:
       build: .
       links:
         - "db:database"
     db:
       image: postgres

.. See the links reference for more information.

詳しい情報は :ref:`links リファレンス <compose-file-links>` をご覧ください。

.. Multi-host networking
.. _compose-multi-host-networking:
:ruby:`複数ホスト間 <multi-host>` でのネットワーク機能
============================================================

.. When deploying a Compose application on a Docker Engine with Swarm mode enabled, you can make use of the built-in overlay driver to enable multi-host communication.

:doc:`Swarm モードを有効化 </engine/swarm/index>` した Docker Engine で Compose アプリケーションをデプロイする場合、内蔵の ``overlay`` ドライバを使い、複数のホスト間で通信が可能です。

.. Consult the Swarm mode section, to see how to set up a Swarm cluster, and the Getting started with multi-host networking to learn about multi-host overlay networks.

:doc:`Swarm モードのセクション </engine/swarm/index>` を参考にし、 Swarm クラスタのセットアップ方法を確認し、複数ホストでのオーバレイ ネットワークについて学ぶには :doc:`複数ホストのネットワーク機能を始めましょう </network/network-tutorial-overlay>` をご覧ください。

.. Specify custom networks
.. _compose-speficy-custom-netowrks:
任意のネットワークを指定
==============================

.. Instead of just using the default app network, you can specify your own networks with the top-level networks key. This lets you create more complex topologies and specify custom network drivers and options. You can also use it to connect services to externally-created networks which aren’t managed by Compose.

デフォルトのアプリ用ネットワークを使う代わりに、トップレベルの ``networks`` キーを使い、自身のネットワークを指定できます。これにより、より複雑なトポロジーの作成や、 :doc:`任意のネットワーク ドライバ </engine/extend/plugins_network>` とそのオプションが指定できるようになります。また、Compose によって管理されていない外部ネットワークに対し、サービスの接続もできます。

.. Each service can specify what networks to connect to with the service-level networks key, which is a list of names referencing entries under the top-level networks key.

各サービスでは、「 :ruby:`サービス レベル <service-level>` 」の ``networks`` キーを使い、接続するネットワークを指定できます。これは、トップレベルの ``networks`` キー以下のエントリを参照する、名前のリストです。

.. Here’s an example Compose file defining two custom networks. The proxy service is isolated from the db service, because they do not share a network in common - only app can talk to both.

以下にある Compose ファイル例は、2つの任意ネットワークを定義しています。この ``proxy`` サービスは ``db`` サービスから分離されます。これは、どちらも共通するネットワークを共有しないためです。 ``app`` サービスのみが両サービスと通信できます。

.. code-block:: yaml

   version: "3.9"
   
   services:
     proxy:
       build: ./proxy
       networks:
         - frontend
     app:
       build: ./app
       networks:
         - frontend
         - backend
     db:
       image: postgres
       networks:
         - backend
   
   networks:
     frontend:
       # Use a custom driver
       driver: custom-driver-1
     backend:
       # Use a custom driver which takes special options
       driver: custom-driver-2
       driver_opts:
         foo: "1"
         bar: "2"

.. Networks can be configured with static IP addresses by setting the ipv4_address and/or ipv6_address for each attached network.

networks では、接続するネットワークごとに :ref:`ipv4_address か ipv6_address の両方、またはいずれか <ipv4-address-ipv6-address>` を指定し、 :ruby:`固定 <static>` IP アドレスを設定できます。

.. Networks can also be given a custom name (since version 3.5):

また、 networks では :ref:`任意の名前 <compose-file-v3-network-configuration-reference>` も指定できます（バージョン 3.5 以降）。

.. code-block:: yaml

   version: "3.9"
   services:
     # ...
   networks:
     frontend:
       name: custom_frontend
       driver: custom-driver-1

.. For full details of the network configuration options available, see the following references:

利用可能なネットワークのオプション詳細は、以下のリファレンスをご覧ください。

..  Top-level networks key
    Service-level networks key

* :ref:`トップレベルの networks キー <network-configuration-reference>`
* :ref:`サービスレベルの networks キー <compose-file-networks>`

.. Configure the default network
.. _compose-configure-the-default-network:
デフォルト ネットワークの設定
==============================

.. Instead of (or as well as) specifying your own networks, you can also change the settings of the app-wide default network by defining an entry under networks named default:

自身のネットワークを指定する代わりに（あるいは指定するように）、アプリケーション全体のデフォルトネットワークの設定を、 ``networks`` 以下の ``default`` エントリの定義によって行えます。

.. code-block:: yaml

   version: "3.9"
   services:
     web:
       build: .
       ports:
         - "8000:8000"
     db:
       image: postgres
   
   networks:
     default:
       # 任意のドライバを使う
       driver: custom-driver-1

.. Use a pre-existing network
.. _comopse-use-a-pre-existing-network:
既存のネットワークを使う
==============================

.. If you want your containers to join a pre-existing network, use the external option:

コンテナを既存のネットワークに対して接続したい場合は、 :ref:`external オプション <network-configuration-reference>` を使います。

.. code-block:: bash

   services:
     # ...
   networks:
     default:
       name: my-pre-existing-network
       external: true

.. Instead of attempting to create a network called [projectname]_default, Compose looks for a network called my-pre-existing-network and connect your app’s containers to it.

``[プロジェクト名]_default`` という名前でネットワーク作成を試みるのに代わり、 Compose は ``my-pre-existing-network`` という名前のネットワークを探し、そこへアプリのコンテナを接続します。

.. seealso:: 

   Networking in Compose
      https://docs.docker.com/compose/networking/
