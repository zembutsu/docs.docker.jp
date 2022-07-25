.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/profiles/
.. SOURCE: 
   doc version: v20.10
      https://github.com/docker/docker.github.io/blob/master/compose/profiles.md
.. check date: 2022/07/17
.. Commits on Jun 3, 2022 d49af6a4495f653ffa40292fd24972b2df5ac0bc
.. ----------------------------------------------------------------------------

.. Using profiles with Compose
.. _using-profiles-with-compose:

=====================================================
Compose で :ruby:`プロフィール <profile>` を使う
=====================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Profiles allow adjusting the Compose application model for various usages and environments by selectively enabling services. This is achieved by assigning each service to zero or more profiles. If unassigned, the service is always started but if assigned, it is only started if the profile is activated.

:ruby:`プロフィール <profile>` によって、有効化するサービスを選択できるようになるため、様々な使い方や環境にあわせて Compose アプリケーション モデルを調整できます。そのためには、各サービスに対してプロフィールを割り当てないか、あるいは複数のプロフィールを割り当てます。割り当てなければサービスは「常に」起動します。一方、（プロフィールの）割り当てがあれば、そのプロフィールが有効な場合のみ起動します。

.. This allows one to define additional services in a single docker-compose.yml file that should only be started in specific scenarios, e.g. for debugging or development tasks.

これにより、１つの ``docker-compose.yml`` ファイルで、たとえばデバッグ用や開発タスクといった、特定の場面でのみ起動する追加サービスを定義できます。

.. Assigning profiles to services
サービスにプロフィールを割り当てる
==============================

.. Services are associated with profiles through the profiles attribute which takes an array of profile names:

サービスにプロフィールを割り当てるには、 :ref:`profiles 属性 <compose-file-v3-profiles>` にプロフィール名を :ruby:`配列 <array>` で記述します。

.. code-block:: yaml

   version: "3.9"
   services:
     frontend:
       image: frontend
       profiles: ["frontend"]
   
     phpmyadmin:
       image: phpmyadmin
       depends_on:
         - db
       profiles:
         - debug
   
     backend:
       image: backend
   
     db:
       image: mysql

.. Here the services frontend and phpmyadmin are assigned to the profiles frontend and debug respectively and as such are only started when their respective profiles are enabled.

こちらにあるサービス ``frontend`` と ``phpmyadmin`` は、プロフィール ``frontend`` と ``debug`` にそれぞれ割り当てられ、それぞれ対応するプロフィールが有効な時にのみ起動します。

.. Services without a profiles attribute will always be enabled, i.e. in this case running docker-compose up would only start backend and db.

``profiles`` 属性がないサービスは「常に」有効です。たとえば、この例では ``docker compose up`` によって ``backend`` と ``db`` のみ起動します。

.. Valid profile names follow the regex format of [a-zA-Z0-9][a-zA-Z0-9_.-]+.

有効なプロフィール名は、正規表現 ``[a-zA-Z0-9][a-zA-Z0-9_.-]+`` の形式です。

..    Note
    The core services of your application should not be assigned profiles so they will always be enabled and automatically started.

.. note::

   アプリケーションの中心となるサービスは、常に有効かつ自動的に起動するよう、 ``profiles`` を割り当てるべきではありません。

.. Enabling profiles
.. _enabling-profiles:

プロフィールの有効化
====================

.. To enable a profile supply the --profile command-line option or use the COMPOSE_PROFILES environment variable:

プロフィールを有効にするには、 :doc:`コマンドラインのオプション <reference/index>` で ``--profile`` を追加するか、 :doc:`COMPOSE_PROFILE 環境変数 <envvers-compose_profiles>` を使います。

.. code-block:: bash

   $ docker-compose --profile debug up
   $ COMPOSE_PROFILES=debug docker-compose up

.. The above command would both start your application with the debug profile enabled. Using the docker-compose.yml file above, this would start the services backend, db and phpmyadmin.

このコマンドは、どちらも ``debug`` プロフィールを有効にしてアプリケーションを起動します。先述の ``docker-compose.yml`` ファイルを使えば、これによってサービス ``backend`` 、 ``db`` 、 ``phpmyadmin`` が起動します。

.. Multiple profiles can be specified by passing multiple --profile flags or a comma-separated list for the COMPOSE_PROFILES environment variable:

複数のプロフィールを指定するには、複数の ``--profiles`` フラグを使うか、 ``COMPOSE_PROFILE`` 環境変数でカンマ区切りのリストを渡します。

.. code-block:: bash

   $ docker-compose --profile frontend --profile debug up
   $ COMPOSE_PROFILES=frontend,debug docker-compose up

.. Auto-enabling profiles and dependency resolution
.. _auto-enabling-profiles-and-dependency-resolution:

プロフィールの自動有効化と依存関係の解決
========================================

.. When a service with assigned profiles is explicitly targeted on the command line its profiles will be enabled automatically so you don’t need to enable them manually. This can be used for one-off services and debugging tools. As an example consider this configuration:

コマンドライン上で対象となるサービスに対して明示的に ``profiles`` を割り当てる場合、このプロフィールは自動的に有効化されるため、手動で有効化する必要はありません。これは一度だけの実行やデバッグツールに役立ちます。次の設定例で考えましょう。

.. code-block:: yaml

   version: "3.9"
   services:
     backend:
       image: backend
   
     db:
       image: mysql
   
     db-migrations:
       image: backend
       command: myapp migrate
       depends_on:
         - db
       profiles:
         - tools

.. code-block:: bash

   # backend と db のみ起動
   $ docker-compose up -d
   
   # こちらは db-migrations を実行（必要となる db も起動）するにあたり、
   # プロフィール `tools` を自動的に有効化
   $ docker-compose run db-migrations

.. But keep in mind that docker-compose will only automatically enable the profiles of the services on the command line and not of any dependencies. This means that all services the targeted service depends_on must have a common profile with it, be always enabled (by omitting profiles) or have a matching profile enabled explicitly:

ただし ``docker-compose`` は、コマンドライン上でサービスのプロフィールを自動的に有効化しますが、依存関係のプロフィールは有効化しないのを覚えておいてください。つまり、対象とするサービスにある ``depends_on``で指定された（依存関係のある）サービスは、共通のプロフィールを持つ必要があり、常に有効化される（ ``profiles`` は無視されます）か、明示的に一致するプロフィールを有効化する必要があります。


.. code-block:: yaml

   version: "3.9"
   services:
     web:
       image: web
   
     mock-backend:
       image: backend
       profiles: ["dev"]
       depends_on:
         - db
   
     db:
       image: mysql
       profiles: ["dev"]
   
     phpmyadmin:
       image: phpmyadmin
       profiles: ["debug"]
       depends_on:
         - db

.. code-block:: bash

   # これは「web」だけ起動
   $ docker-compose up -d
   
   # これは mock-backend を起動し（必要となる db も起動）、
   # 自動的にプロフィール「dev」を有効化
   $ docker-compose up -d mock-backend
   
   # これはプロフィール「dev」が無効化されているので起動失敗
   $ docker-compose up phpmyadmin

.. Although targeting phpmyadmin will automatically enable its profiles - i.e. debug - it will not automatically enable the profile(s) required by db - i.e. dev. To fix this you either have to add the debug profile to the db service:

対象が ``phpmyadmin`` の場合、そのプロフィール、ここでは ``debug`` が自動的に有効化されますが、 ``db`` が必要とするプロフィール、ここでは ``db`` は自動的に有効化されません。この問題を解決するには、 ``db`` サービスに ``debug`` プロフィールを追加するか、

.. code-block:: yaml

   db:
     image: mysql
     profiles: ["debug", "dev"]

.. or enable a profile of db explicitly:

あるいは ``db`` のプロフィールを明示します。

.. code-block:: bash

   # プロフィール「debug」は対象の phpmyadmin によって自動的に有効化
   $ docker-compose --profile dev up phpmyadmin
   $ COMPOSE_PROFILES=dev docker-compose up phpmyadmin

.. More Compose documentation
ほかの Compose ドキュメント
==============================

..  User guide
    Installing Compose
    Getting Started
    Command line reference
    Compose file reference
    Sample apps with Compose

* :doc:`ユーザガイド <index>`
* :doc:`Compose のインストール <install>`
* :doc:`始めましょう <gettingstarted>`
* :doc:`コマンドライン リファレンス <reference/index>`
* :doc:`Compose ファイル リファレンス <compose-file>`
* :doc:`Compose のサンプルアプリ <samples-for-compose>`


.. seealso:: 

   Using profiles with Compose | Docker Documentation
      https://docs.docker.com/compose/profiles/

