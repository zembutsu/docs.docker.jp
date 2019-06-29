.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/extends/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/extends.md
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/extends.md
.. check date: 2016/04/28
.. Commits on Mar 19, 2016 85c7d3e5ce821c7e8d6a7c85fc0b786f3a60ec93
.. ----------------------------------------------------------------------------

.. title: Share Compose configurations between files and projects

==================================================
ファイル間、プロジェクト間での Compose 設定の共有
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Compose supports two methods of sharing common configuration:

Compose がサポートする設定共有には 2 つの方法があります。

.. 1. Extending an entire Compose file by
      [using multiple Compose files](extends.md#multiple-compose-files)
   2. Extending individual services with [the `extends` field](extends.md#extending-services)

1. Compose ファイル全体を :ref:`複数の Compose ファイルの利用 <multiple-compose-files>` により拡張します。
2. 個々のサービスを :ref:`extends フィールド <extending-services>` を使って拡張します。


.. ## Multiple Compose files

.. _multiple-compose-files:

複数の Compose ファイルの利用
==============================

.. Using multiple Compose files enables you to customize a Compose application
   for different environments or different workflows.

Compose ファイルを複数利用することにすれば、Compose によるアプリケーションを異なる環境、異なる作業フローに合わせてカスタマイズできます。

.. ### Understanding multiple Compose files

.. _understanding-multiple-compose-files:

Compose ファイルが複数ある意味
-------------------------------

.. By default, Compose reads two files, a `docker-compose.yml` and an optional
   `docker-compose.override.yml` file. By convention, the `docker-compose.yml`
   contains your base configuration. The override file, as its name implies, can
   contain configuration overrides for existing services or entirely new
   services.

デフォルトにおいて Compose は 2 つのファイルを読み込みます。
``docker-compose.yml`` と、必要に応じて編集する ``docker-compose.override.yml`` です。
慣習として ``docker-compose.yml`` には基本的な設定を含めます。
``docker-compose.override.yml`` ファイルは、オーバーライドという表現が含まれていることから分かるように、既存のサービスあるいは新たに起動する全サービスに対しての上書き設定を行うものです。

.. If a service is defined in both files, Compose merges the configurations using
   the rules described in [Adding and overriding
   configuration](extends.md#adding-and-overriding-configuration).

サービスの定義が両方のファイルに存在した場合、Compose は :ref:`設定の追加と上書き <adding-and-overriding-configuration>` に示すルールに従って定義設定をマージします。

.. To use multiple override files, or an override file with a different name, you
   can use the `-f` option to specify the list of files. Compose merges files in
   the order they're specified on the command line. See the [`docker-compose`
   command reference](/compose/reference/overview.md) for more information about
   using `-f`.

複数の上書きファイルがある場合、あるいは上書きファイルが 1 つであってもその名前を別にしている場合、``-f`` オプションを使って、ファイル名を列記して指定することができます。
Compose はコマンドライン上に指定された順に、設定ファイルをマージします。
詳細は :doc:`docker-compose コマンドリファレンス </compose/reference/overview>` の ``-f`` オプションに関する情報を参照してください。

.. When you use multiple configuration files, you must make sure all paths in the
   files are relative to the base Compose file (the first Compose file specified
   with `-f`). This is required because override files need not be valid
   Compose files. Override files can contain small fragments of configuration.
   Tracking which fragment of a service is relative to which path is difficult and
   confusing, so to keep paths easier to understand, all paths must be defined
   relative to the base file.

複数の設定ファイルを利用する場合、各ファイルに記述されるパスは、基準となる Compose ファイル（1 つめの ``-f`` により指定された Compose ファイル）からの相対パスである必要があります。
これは上書きするファイルが Compose ファイルとして有効である必要がないからです。
上書きファイル内は、設定項目が部分的に含まれているだけで構いません。
サービスに対する定義部分がどのパスからの相対パスとして定義されているのかといったことを追っていくのは、なかなか難しく理解しづらくなります。
そこでパスを理解しやすくするために、パス指定はすべて、ベースとなるファイルからの相対パスとして定義するものとしています。

.. ### Example use case

利用例
----------

.. In this section are two common use cases for multiple compose files: changing a
   Compose app for different environments, and running administrative tasks
   against a Compose app.

この節では複数の Compose ファイルを利用する標準的な例を 2 つ示します。
1 つは Compose アプリを異なる環境向けに切り替えるもの。
もう 1 つは Compose アプリに対して管理タスクを実行するものです。

.. #### Different environments

.. _different-environments:

異なる環境向けの例
^^^^^^^^^^^^^^^^^^^^

.. A common use case for multiple files is changing a development Compose app
   for a production-like environment (which may be production, staging or CI).
   To support these differences, you can split your Compose configuration into
   a few different files:

複数の設定ファイルを利用する例としてよくあるのは、開発環境向けの Compose アプリを、本番環境向けなど（本番環境、ステージング環境、CI 環境など）に切り替える場合です。
こういった環境の違いに対応するには、Compose 設定ファイルをいくつかの設定ファイルに切り分けて行います。

.. Start with a base file that defines the canonical configuration for the
   services.

まずはサービスの標準設定を行うベースファイルから始めます。

..  web:
      image: example/my_web_app:latest
      links:
        - db
        - cache

    db:
      image: postgres:latest

    cache:
      image: redis:latest

.. code-block:: yaml
   :caption: **docker-compose.yml**

   web:
     image: example/my_web_app:latest
     links:
       - db
       - cache

   db:
     image: postgres:latest

   cache:
     image: redis:latest

.. In this example the development configuration exposes some ports to the
   host, mounts our code as a volume, and builds the web image.

この開発環境向け設定の例では、ホストに対してポートをいくつか公開し、ソースコードをボリュームとしてマウントした上で、ウェブイメージをビルドしています。

.. **docker-compose.override.yml**

..  web:
      build: .
      volumes:
        - '.:/code'
      ports:
        - 8883:80
      environment:
        DEBUG: 'true'

    db:
      command: '-d'
      ports:
        - 5432:5432

    cache:
      ports:
        - 6379:6379

.. code-block:: yaml
   :caption: **docker-compose.override.yml**

   web:
     build: .
     volumes:
       - '.:/code'
     ports:
       - 8883:80
     environment:
       DEBUG: 'true'

   db:
     command: '-d'
     ports:
       - 5432:5432

   cache:
     ports:
       - 6379:6379

.. When you run `docker-compose up` it reads the overrides automatically.

``docker-compose up`` を実行すると、上書き用の設定ファイルが自動的に読み込まれます。

.. Now, it would be nice to use this Compose app in a production environment. So,
   create another override file (which might be stored in a different git
   repo or managed by a different team).

この Compose アプリは、このままでも十分に本番環境向けとすることができます。
ただここでは、別の上書きファイルを生成します（このファイルは別の git リポジトリに含まれているとか、別の開発チームが管理するものであるかもしれません）。

.. **docker-compose.prod.yml**

..  web:
      ports:
        - 80:80
      environment:
        PRODUCTION: 'true'

    cache:
      environment:
        TTL: '500'

.. code-block:: yaml
   :caption: **docker-compose.prod.yml**

   web:
     ports:
       - 80:80
     environment:
       PRODUCTION: 'true'

   cache:
     environment:
       TTL: '500'

.. To deploy with this production Compose file you can run

この本番環境向け Compose ファイルをデプロイするために、以下を実行します。

..  docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d

.. code-block:: bash

   docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d

.. This deploys all three services using the configuration in
   `docker-compose.yml` and `docker-compose.prod.yml` (but not the
   dev configuration in `docker-compose.override.yml`).

これによって 3 つのサービスすべてがデプロイされますが、利用される設定は ``docker-compose.yml`` と ``docker-compose.prod.yml`` から読み込まれたものです。
（``docker-compose.override.yml`` 内の開発環境向け設定は利用されません。）

.. See [production](production.md) for more information about Compose in
   production.

本番環境での Compose 利用に関する情報は、:doc:`本番環境での Compose の利用 <production>` を参照してください。

.. #### Administrative tasks

管理タスクの例
^^^^^^^^^^^^^^^^^^^^

.. Another common use case is running adhoc or administrative tasks against one
   or more services in a Compose app. This example demonstrates running a
   database backup.

よく行われるもう 1 つの例は、Compose アプリにおけるサービスに対して、特別なタスクあるいは管理タスクを実行する場合です。
ここでは、データベースバックアップを実行する例を示します。

.. Start with a **docker-compose.yml**.

**docker-compose.yml** から始めます。

..  web:
      image: example/my_web_app:latest
      links:
        - db

    db:
      image: postgres:latest

.. code-block:: yaml

   web:
     image: example/my_web_app:latest
     links:
       - db

   db:
     image: postgres:latest

.. In a **docker-compose.admin.yml** add a new service to run the database
   export or backup.

**docker-compose.admin.yml** において、新しいサービスを追加して、データベースのエクスポートまたはバックアップを行うようにします。

..  dbadmin:
      build: database_admin/
      links:
        - db

.. code-block:: yaml

   dbadmin:
     build: database_admin/
     links:
       - db

.. To start a normal environment run `docker-compose up -d`. To run a database
   backup, include the `docker-compose.admin.yml` as well.

通常の環境を起動するときは ``docker-compose up -d`` を実行します。
またデータベースバックアップを実行するときは、``docker-compose.admin.yml`` も含めるようにして実行します。

..  docker-compose -f docker-compose.yml -f docker-compose.admin.yml \
        run dbadmin db-backup

.. code-block:: yaml

   docker-compose -f docker-compose.yml -f docker-compose.admin.yml \
       run dbadmin db-backup


.. ## Extending services

.. _extending-services:

サービスの拡張
====================

.. > **Note**: The `extends` keyword is supported in earlier Compose file formats
   up to Compose file version 2.1 (see [extends in
   v1](/compose/compose-file/compose-file-v1.md#extends) and [extends in
   v2](/compose/compose-file/compose-file-v2.md#extends)), but is not supported in
   Compose version 3.x. See the [Version 3
   summary](/compose/compose-file/compose-versioning.md#version-3) of keys added
   and removed, along with information on [how to
   upgrade](/compose/compose-file/compose-versioning.md#upgrading). See
   [moby/moby#31101](https://github.com/moby/moby/issues/31101) to follow the
   discussion thread on possibility of adding support for `extends` in some form in
   future versions.

.. note::

   キーワード ``extends`` は、かつての Compose ファイルフォーマットバージョン 2.1 までにおいてサポートされます。
   （:ref:`バージョン 1 における extends </compose/compose-file/compose-file-v1-extends>` と :ref:`バージョン 2 における extends </compose/compose-file/compose-file-v2-extends>` を参照のこと。）
   これは Compose バージョン 3.x ではサポートされていません。
   キーワードの追加、削除に関しては :ref:`バージョン 3 のまとめ <compose-versioning-version-3>` や :ref:`アップグレード方法 </compose/compose-file/compose-versioning-upgrading>` を参照してください。
   また `moby/moby#31101 <https://github.com/moby/moby/issues/31101)>`_ では、将来のバージョンにおいて、何らかの形式で ``extends`` をサポートする可能性について議論するスレッドがありますので、確認してみてください。

.. Docker Compose's `extends` keyword enables sharing of common configurations
   among different files, or even different projects entirely. Extending services
   is useful if you have several services that reuse a common set of configuration
   options. Using `extends` you can define a common set of service options in one
   place and refer to it from anywhere.

Docker Compose の ``extends`` キーワードを使うと、さまざまな設定ファイルに共通する内容を共有することができます。
それはまったく別のプロジェクト間でも可能です。
ごく標準的な設定オプションを再利用しているサービスがいくつもある場合に、このサービス拡張機能を活用することができます。
``extends`` を使って標準的なサービスオプションを 1 箇所に定義しておけば、それをどこからでも参照することができます。

.. Keep in mind that `links`, `volumes_from`, and `depends_on` are never shared
   between services using `extends`. These exceptions exist to avoid implicit
   dependencies; you always define `links` and `volumes_from` locally. This ensures
   dependencies between services are clearly visible when reading the current file.
   Defining these locally also ensures that changes to the referenced file don't
   break anything.

``links``、``volumes_from``、``depends_on`` は、``extends`` を利用したサービス間での共有はされません。
これらが例外となっているのは、気づかないうちに依存関係が発生してしまうことを避けるためです。
``links`` や ``volumes_from`` はいつもローカルな定義に利用するものです。
こうしているからこそ、そのときの設定ファイルを読めば、サービス間の依存関係がはっきりわかることになります。
ローカルに定義しておくのは、参照されている側のファイルに変更が加わっても、影響がなく済むことにもつながります。

.. ### Understand the extends configuration

extends 設定の理解
--------------------

.. When defining any service in `docker-compose.yml`, you can declare that you are
   extending another service like this:

``docker-compose.yml`` 内にサービスを定義するときには、どのようなサービスであっても、別のサービスを拡張するように宣言できます。
たとえば以下のとおりです。

..  web:
      extends:
        file: common-services.yml
        service: webapp

.. code-block:: yaml

   web:
     extends:
       file: common-services.yml
       service: webapp

.. This instructs Compose to re-use the configuration for the `webapp` service
   defined in the `common-services.yml` file. Suppose that `common-services.yml`
   looks like this:

上の設定は Compose に対して、``common-services.yml`` ファイル内に定義されている ``webapp`` サービスの設定を再利用することを指示しています。
``common-services.yml`` は以下のようになっているとします。

..  webapp:
      build: .
      ports:
        - "8000:8000"
      volumes:
        - "/data"

.. code-block:: yaml

   webapp:
     build: .
     ports:
       - "8000:8000"
     volumes:
       - "/data"

.. In this case, you'll get exactly the same result as if you wrote
   `docker-compose.yml` with the same `build`, `ports` and `volumes` configuration
   values defined directly under `web`.

この例では、``docker-compose.yml`` ファイル内の ``web`` の直下に、``build``、``ports``、``volumes`` の設定を行った場合と同じ結果を得ることができます。

.. You can go further and define (or re-define) configuration locally in
   `docker-compose.yml`:

さらに ``docker-compose.yml`` 内には、ローカルでの設定内容を定義あるいは再定義することができます。

..  web:
      extends:
        file: common-services.yml
        service: webapp
      environment:
        - DEBUG=1
      cpu_shares: 5

    important_web:
      extends: web
      cpu_shares: 10

.. code-block:: yaml

   web:
     extends:
       file: common-services.yml
       service: webapp
     environment:
       - DEBUG=1
     cpu_shares: 5

   important_web:
     extends: web
     cpu_shares: 10

.. You can also write other services and link your `web` service to them:

また他のサービスを記述して、``web`` サービスからそのサービスへリンクすることも可能です。

..  web:
      extends:
        file: common-services.yml
        service: webapp
      environment:
        - DEBUG=1
      cpu_shares: 5
      links:
        - db
    db:
      image: postgres

.. code-block:: yaml

   web:
     extends:
       file: common-services.yml
       service: webapp
     environment:
       - DEBUG=1
     cpu_shares: 5
     links:
       - db
   db:
     image: postgres


.. ### Example use case

利用例
----------

.. Extending an individual service is useful when you have multiple services that
   have a common configuration.  The example below is a Compose app with
   two services: a web application and a queue worker. Both services use the same
   codebase and share many configuration options.

複数のサービスを利用していてそこに共通設定が存在する場合に、単独のサービスを拡張することができるかもしれません。
以下の例では Compose アプリにおいて 2 つのサービスがあります。
ウェブアプリケーションとキューワーカー（queue worker）です。
この 2 つのサービスは同一のコードを用いるものであり、多くの設定オプションを共有します。

.. In a **common.yml** we define the common configuration:

**common.yml** では共通する設定を定義します。

..  app:
      build: .
      environment:
        CONFIG_FILE_PATH: /code/config
        API_KEY: xxxyyy
      cpu_shares: 5

.. code-block:: yaml

   app:
     build: .
     environment:
       CONFIG_FILE_PATH: /code/config
       API_KEY: xxxyyy
     cpu_shares: 5

.. In a **docker-compose.yml** we define the concrete services which use the
   common configuration:

**docker-compose.yml** では、上の共通設定を利用する具体的なサービスを定義します。

..  webapp:
      extends:
        file: common.yml
        service: app
      command: /code/run_web_app
      ports:
        - 8080:8080
      links:
        - queue
        - db

    queue_worker:
      extends:
        file: common.yml
        service: app
      command: /code/run_worker
      links:
        - queue

.. code-block:: yaml

   webapp:
     extends:
       file: common.yml
       service: app
     command: /code/run_web_app
     ports:
       - 8080:8080
     links:
       - queue
       - db

   queue_worker:
     extends:
       file: common.yml
       service: app
     command: /code/run_worker
     links:
       - queue

.. ## Adding and overriding configuration

.. _adding-and-overriding-configuration:

設定の追加と上書き
====================

.. Compose copies configurations from the original service over to the local one.
   If a configuration option is defined in both the original service and the local
   service, the local value *replaces* or *extends* the original value.

Compose では、元からあったサービスの定義を、ローカルのサービス定義に向けてコピーします。
設定オプションが元々のサービスとローカルのサービスの両方にて定義されていた場合は、元のサービスの値はローカルの値によって **置き換えられる** か、あるいは **拡張されます** 。

.. For single-value options like `image`, `command` or `mem_limit`, the new value
   replaces the old value.

1 つの値しか持たないオプション、たとえば ``image``、``command``、``mem_limit`` のようなものは、古い値が新しい値に置き換えられます。

..  # original service
    command: python app.py

    # local service
    command: python otherapp.py

    # result
    command: python otherapp.py

.. code-block:: yaml

   # 元からのサービス
   command: python app.py

   # ローカル定義のサービス
   command: python otherapp.py

   # 結果
   command: python otherapp.py

.. >  `build` and `image` in Compose file version 1
   >
   > In the case of `build` and `image`, when using
   > [version 1 of the Compose file format](compose-file.md#version-1), using one
   > option in the local service causes Compose to discard the other option if it
   > was defined in the original service.
   >
   > For example, if the original service defines `image: webapp` and the
   > local service defines `build: .` then the resulting service will have
   > `build: .` and no `image` option.
   >
   > This is because `build` and `image` cannot be used together in a version 1
   > file.

.. note::
   Compose ファイルバージョン 1 における ``build`` と ``image``
     :doc:`Compose ファイルフォーマットバージョン 1 </compose/compose-file/compose-file-v1>` における ``build`` と ``image`` の 2 つについて、ローカル定義に一方を用いた場合に、他方が元々のサービスに定義されていたとすると、その他方のオプションは無視されます。
     
     たとえば元のサービスに ``image: webapp`` が定義されていて、ローカルサービスでは ``build: .`` が定義されているとします。
     このときの結果は ``build: .`` となり、``image`` オプションはなくなります。
     
     これはファイルフォーマットバージョン 1 においては、``build`` と ``image`` を同時に用いることができないためです。

.. For the **multi-value options** `ports`, `expose`, `external_links`, `dns`,
   `dns_search`, and `tmpfs`, Compose concatenates both sets of values:

**複数の値を持つオプション**、つまり ``ports``、 ``expose``、 ``external_links``、 ``dns``、 ``dns_search``、 ``tmpfs`` では、両者の設定をつなぎ合わせます。

..  # original service
    expose:
      - "3000"

    # local service
    expose:
      - "4000"
      - "5000"

    # result
    expose:
      - "3000"
      - "4000"
      - "5000"

.. code-block:: yaml

   # 元からのサービス
   expose:
     - "3000"

   # ローカル定義のサービス
   expose:
     - "4000"
     - "5000"

   # 結果
   expose:
     - "3000"
     - "4000"
     - "5000"

.. In the case of `environment`, `labels`, `volumes` and `devices`, Compose
   "merges" entries together with locally-defined values taking precedence:

``environment``、 ``labels``、 ``volumes``、 ``devices`` の場合、Compose は設定内容を "マージ" して、ローカル定義の値が優先するようにします。

..  # original service
    environment:
      - FOO=original
      - BAR=original

    # local service
    environment:
      - BAR=local
      - BAZ=local

    # result
    environment:
      - FOO=original
      - BAR=local
      - BAZ=local

.. code-block:: yaml

   # 元からのサービス
   environment:
     - FOO=original
     - BAR=original

   # ローカル定義のサービス
   environment:
     - BAR=local
     - BAZ=local

   # 結果
   environment:
     - FOO=original
     - BAR=local
     - BAZ=local


.. Compose documentation

Compose のドキュメント
==============================

..
    User guide
    Installing Compose
    Getting Started
    Get started with Django
    Get started with Rails
    Get started with WordPress
    Command line reference
    Compose file reference

* :doc:`ユーザガイド </index>`
* :doc:`/compose/gettingstarted`
* :doc:`/compose/django`
* :doc:`/compose/rails`
* :doc:`/compose/wordpress`
* :doc:`/compose/reference/index`
* :doc:`/compose/compose-file`

.. seealso:: 

   Extending services and Compose files
      https://docs.docker.com/compose/extends/

