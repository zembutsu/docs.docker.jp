.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/networking/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/networking.md
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/networking.md
.. check date: 2016/04/28
.. Commits on Mar 24, 2016 d1ea4d72ac81aa7bda7384ce6ee80a6fc6d62de8
.. ----------------------------------------------------------------------------

.. Networking in Compose

.. _networking-in-compose:

==============================
Compose のネットワーク機能
==============================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Note: This document only applies if you’re using version 2 of the Compose file format. Networking features are not supported for version 1 (legacy) Compose files.

.. note::

   このドキュメントが適用されるのは :ref:`Compose ファイル・フォーマットのバージョン２ <compose-file-versioning>` を使う場合です。ネットワーク機能はバージョン１（過去）の Compose ファイルではサポートされていません。

.. By default Compose sets up a single network for your app. Each container for a service joins the default network and is both reachable by other containers on that network, and discoverable by them at a hostname identical to the container name.

デフォルトでは、Compose はアプリケーションに対して :doc:`ネットワーク </engine/reference/commandline/network_create>` を１つ設定します。各コンテナ上のサービスはデフォルト・ネットワークに参加したら、同一ネットワーク上の他のコンテナから接続できるようになります。また、ホスト名とコンテナ名でも発見可能になります。

.. Note: Your app’s network is given a name based on the “project name”, which is based on the name of the directory it lives in. You can override the project name with either the --project-name flag or the COMPOSE_PROJECT_NAME environment variable.

.. note::

   アプリケーション用のネットワークには、"プロジェクト名" と同じ名前が割り当てられます。プロジェクト名とは、作業している基準の（ベースとなる）ディレクトリ名です。このプロジェクト名は ``--project-name`` :doc:`フラグ </compose/reference/overview>` か ``COMPOSE_PROJECT_NAME`` :ref:`環境変数 <compose-project-name>` で変更できます。

.. For example, suppose your app is in a directory called myapp, and your docker-compose.yml looks like this:

例として、アプリケーションを置いたディレクトリ名を ``myapp`` とし、``docker-compose.yml`` は次のような内容とします。

.. code-block:: yaml

   version: '2'
   
   services:
     web:
       build: .
       ports:
         - "8000:8000"
     db:
       image: postgres

.. When you run docker-compose up, the following happens:

..    A network called myapp_default is created.
    A container is created using web’s configuration. It joins the network myapp_default under the name web.
    A container is created using db’s configuration. It joins the network myapp_default under the name db.

``docker-compose up`` を実行したら、次のように動作します。

1. ``myapp_default`` という名称のネットワークを作成します。
2. ``web`` 設定を使ったコンテナを作成します。これをネットワーク ``myapp_default`` に対して、``web`` という名称で追加します。
3. ``db`` 設定を使ったコンテナを作成します。これをネットワーク ``myapp_default`` に対して、 ``db`` という名称で追加します。

.. Each container can now look up the hostname web or db and get back the appropriate container’s IP address. For example, web’s application code could connect to the URL postgres://db:5432 and start using the Postgres database.

各コンテナは、これでホスト名を ``web`` あるいは ``db`` で名前解決することにより、コンテナに割り当てられた IP アドレスが分かります。たとえば、``web`` アプリケーションのコードが URL  ``postgres://db:5432`` にアクセスできるようになり、PostgreSQL データベースを利用開始します。

.. Because web explicitly maps a port, it’s also accessible from the outside world via port 8000 on your Docker host’s network interface.

``web`` はポートの割り当てを明示しているため、Docker ホスト側のネットワーク・インターフェース上からも、ポート 8000 を通して外からアクセス可能です。

.. Updating containers

コンテナのアップデート
==============================

.. If you make a configuration change to a service and run docker-compose up to update it, the old container will be removed and the new one will join the network under a different IP address but the same name. Running containers will be able to look up that name and connect to the new address, but the old address will stop working.

サービスの設定を変更するには、 ``docker-compose up`` を実行して、古いコンテナの削除と新しいコンテナをネットワーク下で起動します。IP アドレスは異なりますが、ホスト名は同じです。実行中のコンテナはその名前で名前解決が可能になり、新しい IP アドレスで接続できますが、古い IP アドレスは機能しなくなります。

.. If any containers have connections open to the old container, they will be closed. It is a container’s responsibility to detect this condition, look up the name again and reconnect.

もし古いコンテナに対して接続しているコンテナがあれば、切断されます。この状況検知はコンテナ側の責任であり、名前解決を再度行い再接続します。

.. Links

リンク（links）
====================

.. Docker links are a one-way, single-host communication system. They should now be considered deprecated, and you should update your app to use networking instead. In the majority of cases, this will simply involve removing the links sections from your docker-compose.yml.

Docker のリンク（link）は、一方通行の単一ホスト上における通信システムです。この機能は廃止される可能性があり、アプリケーションはネットワーク機能を使うようにアップデートすべきです。多くの場合は、``docker-compose.yml`` で ``link`` セクションを削除するだけです。

.. Links allow you to define extra aliases by which a service is reachable from another service. They are not required to enable services to communicate - by default, any service can reach any other service at that service’s name. In the following example, db is reachable from web at the hostnames db and database:

リンク機能（links）とは、他のサービスから到達可能なエイリアス（別名）を定義するものです。サービス間で通信するために必要ではありません。すなわち、デフォルトでは、あらゆるサービスはサービス名を通して到達できます。以下の例では、 ``web`` から ``db`` に到達するには、ホスト名の ``db`` と（エイリアスの） ``database`` が使えます。

.. code-block:: yaml

   version: '2'
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

.. _multi-host-networking:

マルチホスト・ネットワーキング
==============================

.. When deploying a Compose application to a Swarm cluster, you can make use of the built-in overlay driver to enable multi-host communication between containers with no changes to your Compose file or application code.

:doc:`Compose アプリケーションを Swarm クラスタにデプロイする <swarm>` 時に、ビルトインの ``overlay`` ドライバを使い、複数のホストを通してコンテナ間の通信を可能にできます。そのために
アプリケーションのコードや Compose ファイルを書き換える必要はありません。

.. Consult the Getting started with multi-host networking to see how to set up a Swarm cluster. The cluster will use the overlay driver by default, but you can specify it explicitly if you prefer - see below for how to do this.

Swarm クラスタのセットアップの仕方は、 :doc:`複数のホストでネットワーク機能を使う方法 </engine/userguide/networking/get-started-overlay>` を参考にしてください。デフォルトは ``overlay`` ドライバを使いますが、任意のドライバを指定可能です。詳しくは後述します。

.. Specifying custom networks

.. _specifying-custom-networks:

カスタム・ネットワークの指定
==============================

.. Instead of just using the default app network, you can specify your own networks with the top-level networks key. This lets you create more complex topologies and specify custom network drivers and options. You can also use it to connect services to externally-created networks which aren’t managed by Compose.

デフォルトのアプリケーション用のネットワークを使う代わりに、自分で任意のネットワーク指定が可能です。そのためには、トップレベルの ``networks`` キーを（Composeファイルで）使います。これにより、より複雑なトポロジのネットワーク作成や、 :doc:`カスタム・ネットワーク・ドライバ </engine/extend/plugins_network>` やオプションを指定できます。また、Compose によって管理されない、外部に作成したネットワークにサービスも接続できます。

.. Each service can specify what networks to connect to with the service-level networks key, which is a list of names referencing entries under the top-level networks key.

*サービス・レベル* の ``networks`` キーを使うことで、各サービスがどのネットワークに接続するか定義できます。このキーは *トップ・レベル* の ``networks`` キー直下にあるエントリ一覧から名前を参照するものです。

.. Here’s an example Compose file defining two custom networks. The proxy service is isolated from the db service, because they do not share a network in common - only app can talk to both.

以下の Compose ファイルの例では、２つのカスタム・ネットワークを定義しています。 ``proxy`` サービスと ``db`` サービスは独立しています。これは共通のネットワークに接続していないためです。 ``app`` のみが両方と通信できます。

.. code-block:: yaml

   version: '2'
   
   services:
     proxy:
       build: ./proxy
       networks:
         - front
     app:
       build: ./app
       networks:
         - front
         - back
     db:
       image: postgres
       networks:
         - back
   
   networks:
     front:
       # Use a custom driver
       driver: custom-driver-1
     back:
       # Use a custom driver which takes special options
       driver: custom-driver-2
       driver_opts:
         foo: "1"
         bar: "2"

.. Networks can be configured with static IP addresses by setting the ipv4_address and/or ipv6_address for each attached network.

ネットワークでは、接続したネットワーク上で :ref:`IPv4 アドレスと IPv6 アドレスの両方、またはいずれか <ipv4-address-ipv6-address>` を設定できます。

.. For full details of the network configuration options available, see the following references:

ネットワーク設定オプションに関する詳しい情報は、以下のリファレンスをご覧ください。

..    Top-level networks key
    Service-level networks key

* :ref:`トップ・レベル networks キー <network-configuration-reference>`
* :ref:`サービス・レベル networks キー <compose-file-networks>`

.. Configuring the default network

.. _configuring-the-default-network:

デフォルト・ネットワークの設定
==============================

.. Instead of (or as well as) specifying your own networks, you can also change the settings of the app-wide default network by defining an entry under networks named default:

自分でネットワークを定義する場合、しない場合どちらでも、アプリケーション全体に適用できるデフォルトのネットワークを ``networks`` の直下の ``default`` エントリで定義できます。

.. code-block:: bash

   version: '2'
   
   services:
     web:
       build: .
       ports:
         - "8000:8000"
     db:
       image: postgres
   
   networks:
     default:
       # Use a custom driver
       driver: custom-driver-1

.. Using a pre-existing network

.. _using-a-pre-existing-network:

既存のネットワークを使う
==============================

.. If you want your containers to join a pre-existing network, use the external option:

コンテナを既存のネットワークに接続したい場合は、 ``external`` :ref:`オプション <network-configuration-reference>` を使います。

.. code-block:: yaml

   networks:
     default:
       external:
         name: my-pre-existing-network

.. Instead of attemping to create a network called [projectname]_default, Compose will look for a network called my-pre-existing-network and connect your app’s containers to it.

``[プロジェクト名]_default`` という名称のネットワークを作成しようとしなくても、Compose は ``my-pre-existing-network`` という名称のネットワークを探し出し、コンテナのアプリケーションを接続できます。

.. seealso:: 

   Networking in Compose
      https://docs.docker.com/compose/networking/
