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

.. > **Note**: This document only applies if you're using [version 2 or higher of the Compose file format](compose-file.md#versioning). Networking features are not supported for version 1 (legacy) Compose files.

.. note::
   ここに示す内容は Compose ファイルフォーマットの :doc:`バージョン 2 <compose-file/compose-file-v2>` と :doc:`それ以降 <compose-file/>` に適用されます。
   ネットワーク機能は :doc:`（古い）バージョン 1 <compose-file/compose-file-v1>` ではサポートされません。

.. By default Compose sets up a single
   [network](/engine/reference/commandline/network_create/) for your app. Each
   container for a service joins the default network and is both *reachable* by
   other containers on that network, and *discoverable* by them at a hostname
   identical to the container name.

デフォルトで Compose は、アプリ向けに単一の :doc:`ネットワーク </engine/reference/commandline/network_create/>` を設定します。
1 つのサービスを構成する各コンテナは、そのデフォルトのネットワークに参加するので、ネットワーク上の他のコンテナからのアクセスが可能です。
さらにコンテナ名と同等のホスト名を用いてコンテナの識別が可能となります。

.. > **Note**: Your app's network is given a name based on the "project name",
   > which is based on the name of the directory it lives in. You can override the
   > project name with either the [`--project-name`
   > flag](reference/overview.md) or the [`COMPOSE_PROJECT_NAME` environment
   > variable](reference/envvars.md#compose-project-name).

   アプリのネットワークには「プロジェクト名」に基づいた名前がつけられます。
   そしてプロジェクト名はこれが稼動しているディレクトリ名に基づいて定まります。
   プロジェクト名は :doc:`--project-name フラグ </compose/reference/overview>` あるいは :ref:`環境変数 COMPOSE_PROJECT_NAME <compose-project-name>` を使って上書きすることができます。

.. For example, suppose your app is in a directory called `myapp`, and your `docker-compose.yml` looks like this:

たとえばアプリが ``myapp`` というディレクトリにあって、``docker-compose.yml`` が以下のような内容であるとします。

..     version: "3"
       services:
         web:
           build: .
           ports:
             - "8000:8000"
         db:
           image: postgres
           ports:
             - "8001:5432"

.. code-block:: yaml

   version: "3"
   services:
     web:
       build: .
       ports:
         - "8000:8000"
     db:
       image: postgres
       ports:
         - "8001:5432"

.. When you run `docker-compose up`, the following happens:

``docker-compose up`` を実行すると以下の結果になります。

.. 1.  A network called `myapp_default` is created.
   2.  A container is created using `web`'s configuration. It joins the network
       `myapp_default` under the name `web`.
   3.  A container is created using `db`'s configuration. It joins the network
       `myapp_default` under the name `db`.

1.  ``myapp_default`` というネットワークが生成されます。
2.  ``web`` に関する設定に従って 1 つのコンテナが生成されます。
    そしてそのコンテナは ``web`` という名前でネットワーク ``myapp_default`` に参加します。
3.  ``db`` に関する設定に従って 1 つのコンテナが生成されます。
    そしてそのコンテナは ``db`` という名前でネットワーク ``myapp_default`` に参加します。

.. Each container can now look up the hostname `web` or `db` and
   get back the appropriate container's IP address. For example, `web`'s
   application code could connect to the URL `postgres://db:5432` and start
   using the Postgres database.

各コンテナはこれ以降、ホスト名 ``web`` と ``db`` を認識できるようになり、コンテナの IP アドレスも適切に取得できるようになります。
たとえば ``web`` のアプリケーション・コードでは、URL ``postgres://db:5432`` を使ってのアクセスが可能となり、Postgres データベースの利用ができるようになります。

.. It is important to note the distinction between `HOST_PORT` and `CONTAINER_PORT`.
   In the above example, for `db`, the `HOST_PORT` is `8001` and the container port is
   `5432` (postgres default). Networked service-to-service
   communication use the `CONTAINER_PORT`. When `HOST_PORT` is defined,
   the service is accessible outside the swarm as well.

``HOST_PORT`` と ``CONTAINER_PORT`` の違いについては理解しておくことが重要です。
上の例の ``db`` では、``HOST_PORT`` が ``8001``、コンテナ・ポートが ``5432`` （postgres のデフォルト） になっています。
ネットワークにより接続されているサービス間の通信は ``CONTAINER_PORT`` を利用します。
``HOST_PORT`` を定義すると、このサービスはスウォームの外からもアクセスが可能になります。

.. Within the `web` container, your connection string to `db` would look like
   `postgres://db:5432`, and from the host machine, the connection string would
   look like `postgres://{DOCKER_IP}:8001`.

``web`` コンテナ内では、``db`` への接続文字列は ``postgres://db:5432`` といったものになります。
そしてホストマシン上からは、その接続文字列は ``postgres://{DOCKER_IP}:8001`` となります。

.. ## Updating containers

コンテナの更新
===============

.. If you make a configuration change to a service and run `docker-compose up` to update it, the old container will be removed and the new one will join the network under a different IP address but the same name. Running containers will be able to look up that name and connect to the new address, but the old address will stop working.

サービスに対する設定を変更して ``docker-compose up`` により更新を行うと、それまでのコンテナは削除されて新しいコンテナがネットワークに接続されます。
このとき IP アドレスは異なることになりますが、ホスト名は変わりません。
コンテナの実行によってホスト名による名前解決を行い、新たな IP アドレスへ接続します。
それまでの古い IP アドレスは利用できなくなります。

.. If any containers have connections open to the old container, they will be closed. It is a container's responsibility to detect this condition, look up the name again and reconnect.

古いコンテナに対して接続を行っていたコンテナがあれば、その接続は切断されます。
この状況を検出するのは各コンテナの責任であって、ホスト名を探して再接続が行われます。

.. ## Links

links
======

.. Links allow you to define extra aliases by which a service is reachable from another service. They are not required to enable services to communicate - by default, any service can reach any other service at that service's name. In the following example, `db` is reachable from `web` at the hostnames `db` and `database`:

links は自サービスが他のサービスからアクセスできるように、追加でエイリアスを定義するものです。
これはサービス間の通信を行うために必要となるわけではありません。
デフォルトにおいてサービスは、サービス名を使って他サービスにアクセスできます。
以下の例においては、``db`` は ``web`` からアクセス可能であり、ホスト名 ``db`` あるいは ``database`` を使ってアクセスできます。

..  version: "3"
    services:
      
      web:
        build: .
        links:
          - "db:database"
      db:
        image: postgres

.. code-block:: yaml

   version: "3"
   services:
     
     web:
       build: .
       links:
         - "db:database"
     db:
       image: postgres

.. See the [links reference](compose-file.md#links) for more information.

詳細は :ref:`links リファレンス <compose-file-links>` を参照してください。

.. ## Multi-host networking

.. _multi-host-networking:

複数ホストによるネットワーク
==============================

.. > **Note**: The instructions in this section refer to [legacy Docker Swarm](/compose/swarm.md) operations, and will only work when targeting a legacy Swarm cluster. For instructions on deploying a compose project to the newer integrated swarm mode consult the [Docker Stacks](/compose/bundles.md) documentation.

.. note::

   ここに示す手順は、:doc:`かつての Docker Swarm </compose/swarm>` の操作に基づいています。 
   したがってかつてのスウォーム・クラスタを対象とする場合にのみ動作します。
   Compose によるプロジェクトを、最新の統合されたスウォーム・モードにデプロイするには、:doc:`Docker Stacks </compose/bundles>` に示すドキュメントを参照してください。

.. When [deploying a Compose application to a Swarm cluster](swarm.md), you can make use of the built-in `overlay` driver to enable multi-host communication between containers with no changes to your Compose file or application code.

:doc:`Compose アプリケーションをスウォーム・クラスタにデプロイする <swarm>` 際には、ビルトインの ``overlay`` ドライバを利用して、コンテナ間で複数ホストによる通信を行うことが可能です。
Compose ファイルやアプリケーションコードへの変更は必要ありません。

.. Consult the [Getting started with multi-host networking](/engine/userguide/networking/get-started-overlay/) to see how to set up a Swarm cluster. The cluster will use the `overlay` driver by default, but you can specify it explicitly if you prefer - see below for how to do this.

:doc:`複数ホストによるネットワークをはじめよう </engine/userguide/networking/get-started-overlay/>` を参考に、スウォーム・クラスタの構築方法を確認してください。
デフォルトでクラスタは ``overlay`` ドライバを用います。
ただし明示的にこれを指定することもできます。
詳しくは後述します。

.. ## Specifying custom networks

.. _specifying-custom-networks:

独自のネットワーク設定
=======================

.. Instead of just using the default app network, you can specify your own networks with the top-level `networks` key. This lets you create more complex topologies and specify [custom network drivers](/engine/extend/plugins_network/) and options. You can also use it to connect services to externally-created networks which aren't managed by Compose.

デフォルトのアプリ用ネットワークを利用するのではなく、独自のネットワークを指定することができます。
これは最上位の ``networks`` キーを使って行います。
これを使えば、より複雑なネットワーク・トポロジを生成したり、:doc:`独自のネットワーク・ドライバ </engine/extend/plugins_network/>` とそのオプションを設定したりすることができます。
さらには、Compose が管理していない、外部に生成されたネットワークに対してサービスを接続することもできます。

.. Each service can specify what networks to connect to with the *service-level* `networks` key, which is a list of names referencing entries under the *top-level* `networks` key.

サービスレベルの定義となる ``networks`` キーを利用すれば、サービスごとにどのネットワークに接続するかを指定できます。
指定する値はサービス名のリストであり、最上位の ``networks`` キーに指定されている値を参照するものです。

.. Here's an example Compose file defining two custom networks. The `proxy` service is isolated from the `db` service, because they do not share a network in common - only `app` can talk to both.

以下において Compose ファイルは、独自のネットワークを 2 つ定義しています。
``proxy`` サービスは ``db`` サービスから切り離されています。
というのも両者はネットワークを共有しないためです。
そして ``app`` だけがその両者と通信を行います。

..  version: "3"
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

.. code-block:: yaml

   version: "3"
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
       # 独自ドライバーの利用
       driver: custom-driver-1
     backend:
       # 所定のオプションを用いる独自ドライバーの利用
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
