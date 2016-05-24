.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/extends/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/extends.md
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/extends.md
.. check date: 2016/04/28
.. Commits on Mar 19, 2016 85c7d3e5ce821c7e8d6a7c85fc0b786f3a60ec93
.. ----------------------------------------------------------------------------

.. Extending Services and Compose files

=======================================
サービスの拡張と Compose ファイル
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Compose supports two methods of sharing common configuration:

Compose は２つのファイル共有方法をサポートしています。

..    Extending an entire Compose file by using multiple Compose files
    Extending individual services with the extends field

1. Compose ファイル全体を :ref:`複数の Compose ファイルを使って <multiple-compose-files>` 拡張する。
2. 個々のサービスを :ref:`\`extends\` フィールド <extending-services>` で拡張する。


.. _multiple-compose-files:

.. Multiple Compose files

複数の Compose ファイル
==============================

.. Using multiple Compose files enables you to customize a Compose application for different environments or different workflows.

デフォルトでは、Compose は２つのファイルを読み込みます。 ``docker-compose.yml`` と、オプションの ``docker-compose.override.yml`` （上書き用）ファイルです。慣例として、``docker-compose.yml`` には基本設定を含みます。上書きファイルとは、その名前が暗に示しているように、既存のサービスを新しいサービスに全て置き換えるものです。

.. If a service is defined in both files Compose merges the configurations using the rules described in Adding and overriding configuration.

もし両方のファイルに定義があれば、Compose は追加された設定の情報でルールを上書きします。

.. To use multiple override files, or an override file with a different name, you can use the -f option to specify the list of files. Compose merges files in the order they’re specified on the command line. See the docker-compose command reference for more information about using -f.

複数の上書きファイルを使いたい場合や、違った名前で上書きしたい場合は、 ``-f`` オプションでファイルの一覧を指定可能です。Compose はコマンドライン上で指定した順番で、ファイルを統合します。詳細は :doc:`docker-compose コマンド・リファレンス </compose/reference/overview>`  の ``-f`` に関する情報をご覧ください。

.. When you use multiple configuration files, you must make sure all paths in the files are relative to the base Compose file (the first Compose file specified with -f). This is required because override files need not be valid Compose files. Override files can contain small fragments of configuration. Tracking which fragment of a service is relative to which path is difficult and confusing, so to keep paths easier to understand, all paths must be defined relative to the base file.

複数の設定ファイルを使う場合、全てのパスはベースになる Compose ファイル（ ``-f`` で１番めに指定したファイル）からの相対パスである必要があります。この指定が必要なのは、上書き用のファイルが適切な Compose ファイル形式でなくても構わないからです。上書きファイルは設定の一部だけでも問題ありません。相対パスで指定されたサービス断片の追跡は、難しく、混乱しがちです。そのため、パスが簡単に分かるようにするため、全てのパスの定義を、ベースファイルからの相対パスにする必要があります。

.. Example use case

使用例
----------

.. In this section are two common use cases for multiple compose files: changing a Compose app for different environments, and running administrative tasks against a Compose app.

このセクションでは、複数の Compose ファイルを使う２つの例をとりあげます。環境の違いにより、構成するアプリを変更する方法。それと、Compose で実行したアプリケーションに対し、管理上のタスクを実行する方法です。

.. Different environments

.. _different-environments:

異なる環境
^^^^^^^^^^^^^^^^^^^^

.. A common use case for multiple files is changing a development Compose app for a production-like environment (which may be production, staging or CI). To support these differences, you can split your Compose configuration into a few different files:

複数のファイルを使う一般的な使用例は、開発環境のアプリ構成を、プロダクション風の環境（プロダクションかもしれませんし、ステージングや CI かもしれません）に変更することです。環境の違いをサポートするには、Compose 設定を複数のファイルに分割します。

.. Start with a base file that defines the canonical configuration for the services.

まず、サービスを正しく定義するベースファイルは次の通りです。

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

例として、開発環境用の設定に、ホスト上の同じポートを使用し、コードをボリュームとしてマウントし、web イメージを構築するものとします。

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

``docker-compose up`` を実行したら、この上書きファイルを自動的に読み込みます。

次は、Compose を使ったアプリケーションをプロダクション環境で使えるようにします。そのために別の上書きファイルを作成します（このファイルは、異なる git リポジトリに保管されているか、あるいは異なるチームによって管理されているかもしれません）。

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

このプロダクション向け Compose ファイルを使ってデプロイするには、次のように実行します。

.. code-block:: bash

   docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d

.. This deploys all three services using the configuration in docker-compose.yml and docker-compose.prod.yml (but not the dev configuration in docker-compose.override.yml).

３つの全サービスがデプロイに使う設定が `docker-compose.yml` と `docker-compose.prod.yml` に含まれています（ `docker-compose.override.yml` に含まれる開発環境はありません）。

.. See production for more information about Compose in production.

Compose をプロダクションで使うための詳細情報は :doc:`プロダクション </compose/production>` をご覧ください。

.. Administrative tasks

管理タスク
^^^^^^^^^^^^^^^^^^^^

.. Another common use case is running adhoc or administrative tasks against one or more services in a Compose app. This example demonstrates running a database backup.

他の一般的な使い方は、アドホックの実行や、構成アプリの１つまたは複数のサービスに対する管理タスクの実行です。ここでの例は、データベースのバックアップ実行をデモするものです。

.. Start with a docker-compose.yml.

**docker-compose.yml** を次のようにします。

.. code-block:: yaml

   web:
     image: example/my_web_app:latest
     links:
       - db
   
   db:
     image: postgres:latest

**docker-compose.admin.yml**  に、データベースをエクスポートかバックアップする新しいサービスを追加します。

.. code-block:: yaml

   dbadmin:
     build: database_admin/
     links:
       - db

.. To start a normal environment run docker-compose up -d. To run a database backup, include the docker-compose.admin.yml as well.

通常の環境を開始するには ``docker-compose up -d`` を実行します。データベースのバックアップを行うには、``docker-compose.admin.yml`` も使います。

.. code-block:: bash

   docker-compose -f docker-compose.yml -f docker-compose.admin.yml \
       run dbadmin db-backup


.. _extending-services:

サービスの拡張
====================

.. Docker Compose’s extends keyword enables sharing of common configurations among different files, or even different projects entirely. Extending services is useful if you have several services that reuse a common set of configuration options. Using extends you can define a common set of service options in one place and refer to it from anywhere.

Docker Compose の ``extends`` （拡張）キーワードは、異なったファイル間で設定を共有できるだけでなく、異なったプロジェクトでも利用可能です。拡張サービスは複数のサービスを持っている場合、一般的な設定オプションの再利用に便利です。 ``extends`` を使えば、１箇所だけでなく、どこでも利用可能なサービス・オプションの共通セットを定義できます。

.. Note: links, volumes_from, and depends_on are never shared between services using >extends. These exceptions exist to avoid implicit dependencies—you always define links and volumes_from locally. This ensures dependencies between services are clearly visible when reading the current file. Defining these locally also ensures changes to the referenced file don’t result in breakage.

.. note::

   ``extends`` を使っても ``links`` と ``volumes_form`` はサービスを共有しません。このような例外が存在しているのは、依存性が暗黙の内に発生しないようにするためです。 ``links`` と ``volumes_from`` は常にローカルで定義すべきです。そうすると、現在のファイルを読み込む時に、依存関係を明確化します。また、参照するファイルを変更したとしても、ローカルで定義する場合は壊れないようにします。

.. Understand the extends configuration

extends 設定の理解
--------------------

.. When defining any service in docker-compose.yml, you can declare that you are extending another service like this:

``docker-compose.yml`` で定義したあらゆるサービスは、次のようにして他のサービスからの拡張（extend）を宣言を宣言できます。

.. code-block:: yaml

   web:
     extends:
       file: common-services.yml
       service: webapp

.. This instructs Compose to re-use the configuration for the webapp service defined in the common-services.yml file. Suppose that common-services.yml looks like this:

これは ``common-services.yml`` ファイルで定義した ``webapp`` サービスの設定を、Compose に再利用するよう命令しています。ここでの ``common-services.yml`` は、次のようなものと仮定します。

.. code-block:: yaml

   webapp:
     build: .
     ports:
       - "8000:8000"
     volumes:
       - "/data"

.. In this case, you’ll get exactly the same result as if you wrote docker-compose.yml with the same build, ports and volumes configuration values defined directly under web.

この例のように、同様の ``docker-compose.yml`` の記述を行えば、``web`` サービスに対する ``build`` 、 ``ports`` 、 ``volumes`` 設定が常に同じになります。

.. You can go further and define (or re-define) configuration locally in docker-compose.yml:

更に ``docker-compose.yml`` でローカル環境の設定（再設定）も行えます。

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

.. You can also write other services and link your web service to them:

あるいは、他のサービスから ``web`` サービスにリンクも可能です。

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


.. Example use case

使用例
----------

.. Extending an individual service is useful when you have multiple services that have a common configuration. The example below is a Compose app with two services: a web application and a queue worker. Both services use the same codebase and share many configuration options.

個々のサービス拡張は、複数のサービスが共通の設定を持っている場合に役立ちます。以下の例では、Compose アプリはウェブ・アプリケーションとキュー・ワーカー（queue worker）の、２つのサービスを持ちます。いずれのサービスも同じコードベースを使い、多くの設定オプションを共有します。

.. In a common.yml we define the common configuration:

**common.yml** ファイルでは、共通設定を定義します。

.. code-block:: bash

   app:
     build: .
     environment:
       CONFIG_FILE_PATH: /code/config
       API_KEY: xxxyyy
     cpu_shares: 5

**docker-compose.yml** では、共通設定を用いる具体的なサービスを定義します。

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

.. Adding and overriding configuration

.. _adding-and-overriding-configuration:

設定の追加と上書き
====================

.. Compose copies configurations from the original service over to the local one. If a configuration option is defined in both the original service the local service, the local value replaces or extends the original value.

Compose は本来のサービス設定を、（訳者注：extends を使う時や、複数ファイルの読み込み時に）各所に対してコピー（引き継ぎ）します。もしも、設定オプションが元のサービスと、ローカル（直近の設定）のサービスの両方で定義された場合、ローカルの値は置き換えられるか、元の値を拡張します。

.. For single-value options like image, command or mem_limit, the new value replaces the old value.

``image`` 、``command`` 、 ``mem_limit`` のような単一値のオプションは、古い値が新しい値に置き換わります。

.. code-block:: yaml

   # 元のサービス
   command: python app.py
   
   # ローカルのサービス
   command: python otherapp.py
   
   # 結果
   command: python otherapp.py

.. In the case of build and image, using one in the local service causes Compose to discard the other, if it was defined in the original service.

``build`` と ``image`` の場合、ローカルでサービスの指定があれば、Compose は一方を破棄します。一方がオリジナルのサービスとして定義されている場合でもです。

.. Example of image replacing build:

image が build を置き換える例：

.. code-block:: yaml

   # 元のサービス
   build: .
   
   # ローカルのサービス
   image: redis
   
   # 結果
   image: redis

build がイメージを置き換える例：

.. code-block:: yaml

   # 元のサービス
   image: redis
   
   # ローカルのサービス
   build: .
   
   # 結果
   build: .

.. For the multi-value options ports, expose, external_links, dns and dns_search, and tmpfs, Compose concatenates both sets of values:

**複数の値を持つオプション**、``ports`` 、 ``expose`` 、 ``external_links`` 、 ``dns`` 、 ``dns_search`` 、 ``tmpfs`` の場合、Compose は両方の値を連結します。

.. code-block:: yaml

   # 元のサービス
   expose:
     - "3000"
   
   # ローカルのサービス
   expose:
     - "4000"
     - "5000"
   
   # 結果
   expose:
     - "3000"
     - "4000"
     - "5000"

.. In the case of environment, labels, volumes and devices, Compose “merges” entries together with locally-defined values taking precedence:

``environment`` 、 ``label`` 、``volumes`` 、 ``devices`` の場合、Compose はローカルで定義している値を優先して統合します。

.. code-block:: yaml

   # 元のサービス
   environment:
     - FOO=original
     - BAR=original
   
   # ローカルのサービス
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

