.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/extends/
.. SOURCE: 
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/extends.md
   doc version: v20.10
      https://github.com/docker/docker.github.io/blob/master/compose/extends.md
.. check date: 2022/07/17
.. Commits on Jun 3, 2022 d49af6a4495f653ffa40292fd24972b2df5ac0bc
.. ----------------------------------------------------------------------------

.. Share Compose configurations between files and projects
.. _share-compose-configurations-between-files-and-projects:

==================================================
Compose 設定をファイルとプロジェクト間で共有
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Compose supports two methods of sharing common configuration:

共通する設定を共有するため、 Compose は２つの方法をサポートしています。

..  Extending an entire Compose file by using multiple Compose files
    Extending individual services with the extends field (for Compose file versions up to 2.1)

1. :ref:`複数の Compose ファイルを使い <extends-multiple-compose-files>` 、Compose ファイル全体を拡張
2. :ref:`「extends」 フィールド <extends-extending-services>` で個々のサービスを拡張（Compose ファイルバージョン 2.1 以上）

.. Multiple Compose files
.. _extends-multiple-compose-files:

複数の Compose ファイル
==============================

.. Using multiple Compose files enables you to customize a Compose application for different environments or different workflows.

複数の Compose ファイルを使えば、異なる環境や異なるワークフローごとに、 Compose アプリケーションをカスタマイズできます。


.. Understanding multiple Compose files
.. _understanding-multiple-compose-files:

複数の Compose ファイルを理解
------------------------------

.. By default, Compose reads two files, a docker-compose.yml and an optional docker-compose.override.yml file. By convention, the docker-compose.yml contains your base configuration. The override file, as its name implies, can contain configuration overrides for existing services or entirely new services.

デフォルトでは、 Compose は２つのファイルを読み込みます。１つは ``docker-compose.yml`` で、もう１つはオプションで ``docker-compose.override.yml`` ファイルです。習慣として、 ``docker-compose.yml`` に基本となる設定を入れます。 :ruby:`上書き <override>` ファイルは、その名前が意味する通り、既存のサービスや新しいサービス全体の設定を上書きする設定を含められます。

.. If a service is defined in both files, Compose merges the configurations using the rules described in Adding and overriding configuration.

両方のファイルでサービスが定義されると、 Compose は :ref:`設定の追加と上書き <extends-adding-and-overriding-configuration>` に記述してある規則を使い、設定を統合します。

.. To use multiple override files, or an override file with a different name, you can use the -f option to specify the list of files. Compose merges files in the order they’re specified on the command line. See the docker-compose command reference for more information about using -f.

複数の上書きファイルを使う場合や、異なる名前の上書きファイルを使う場合は、 ``-f`` オプションを使ってリストやファイルを指定できます。コマンドライン上で指定した順番で、Compose はそれらのファイルを統合します。 ``-f`` を使う詳しい情報は :ref:`docker-compose コマンドリファレンス </compose/reference/index>` をご覧ください。

.. When you use multiple configuration files, you must make sure all paths in the files are relative to the base Compose file (the first Compose file specified with -f). This is required because override files need not be valid Compose files. Override files can contain small fragments of configuration. Tracking which fragment of a service is relative to which path is difficult and confusing, so to keep paths easier to understand, all paths must be defined relative to the base file.

複数の設定ファイルを使う場合、全ファイルのパスが基本となる Compose ファイル（ ``-f`` で１番目に指定した Compose ファイル）からの相対パスになるので、注意が必要です。注意が要るのは、上書きするファイルは正しい Compose ファイルである必要がないためです。サービスの一部を追跡するにあたり、相対パスは複雑で混乱するため、パスを分かりやすくするためには、全てのパスを基本ファイルからの相対パスとして指定すべきです。


.. Example use case
.. _extends-example-use-case:

使用例
-----------

.. In this section, there are two common use cases for multiple Compose files: changing a Compose app for different environments, and running administrative tasks against a Compose app.

このセクションには、複数の Compose ファイルを使う一般的な使用例が２つあります。異なる環境で Compose アプリを変えるものと、Compose アプリに対して管理用タスクを実行するものです。

.. Different environments
.. _extends-different-environements:

異なる環境
^^^^^^^^^^

.. A common use case for multiple files is changing a development Compose app for a production-like environment (which may be production, staging or CI). To support these differences, you can split your Compose configuration into a few different files:

複数のファイルを使う一般的な利用例は、開発用 Compose アプリを本番のような環境用（本番や、ステージングや、CI など）に変える場合です。環境の違いに対応するには、 Compose 設定を複数の異なるファイルに分割できます。

.. Start with a base file that defines the canonical configuration for the services.

各サービスに対する標準的な設定を定義する :ruby:`ベースファイル <base file>` から始めましょう。

**docker-compose.yml**

.. code-block:: yaml

   web:
     image: example/my_web_app:latest
     depends_on:
       - db
       - cache
   
   db:
     image: postgres:latest
   
   cache:
     image: redis:latest

.. In this example the development configuration exposes some ports to the host, mounts our code as a volume, and builds the web image.

この例にある開発用の設定では、ホスト上のいくつかのポートを公開し、ボリュームとしてコードをマウントし、web イメージを構築します。

**docker-compose.override.yml**

.. code-block:: bash

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

.. When you run docker-compose up it reads the overrides automatically.

``docker-compose up`` を実行すると、上書きファイルを自動的に読み込みます。

.. Now, it would be nice to use this Compose app in a production environment. So, create another override file (which might be stored in a different git repo or managed by a different team).

これで、この Compose アプリを本番環境でも使えるようになりました。あとは、他の上書きファイル（異なる git リポジトリに保管されるかもしれませんし、他のチームによって管理されるかもしれません）を作成します。

**docker-compose.prod.yml**

.. code-block:: bash

   web:
     ports:
       - 80:80
     environment:
       PRODUCTION: 'true'
   
   cache:
     environment:
       TTL: '500'

.. To deploy with this production Compose file you can run

この本番用 Compose ファイルでデプロイするには、次のように実行します。

.. code-block:: bash

   $ docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d

.. This deploys all three services using the configuration in docker-compose.yml and docker-compose.prod.yml (but not the dev configuration in docker-compose.override.yml).

これは ``docker-compose.yml`` と ``docker-compose.prod.yml`` （開発用の設定 ``docker-compose.override.yml`` ではありません）の設定を使い、設定された３つのサービスすべてをデプロイします。

.. See production for more information about Compose in production.

Compose を本番環境で使うための情報は :doc:`本番環境 <production>` をご覧ください。

.. Administrative tasks
.. _extends-administrative-tasks:

管理用タスク
^^^^^^^^^^^^^^^^^^^^

.. Another common use case is running adhoc or administrative tasks against one or more services in a Compose app. This example demonstrates running a database backup.

他の一般的な利用例は、 Compose アプリ内のサービスに対して、一時的または管理的なタスクを１つまたは複数実行する場合です。

.. Start with a docker-compose.yml.

**docker-compose.yml** から始めます。

.. code-block:: yaml

   web:
     image: example/my_web_app:latest
     depends_on:
       - db
   
   db:
     image: postgres:latest

.. In a docker-compose.admin.yml add a new service to run the database export or backup.

**docker-compose.admin.yml** には、データベースの :ruby:`出力 <export>` やバックアップを実行する新しいサービスを追加します。

.. code-block:: bash

       dbadmin:
         build: database_admin/
         depends_on:
           - db

.. To start a normal environment run docker-compose up -d. To run a database backup, include the docker-compose.admin.yml as well.

``docker-compose up -d`` を実行して、通常の環境を起動します。データベースのバックアップを実行するには、 ``docker-compose.admin.yaml`` も同様に含めます。

.. code-block:: bash

   $ docker-compose -f docker-compose.yml -f docker-compose.admin.yml \
     run dbadmin db-backup

.. Extending services
.. _extending-services:

サービスの :ruby:`拡張 <extends>`
========================================

..  Note
    The extends keyword is supported in earlier Compose file formats up to Compose file version 2.1 (see extends in v2), but is not supported in Compose version 3.x. See the Version 3 summary of keys added and removed, along with information on how to upgrade. See moby/moby#31101 to follow the discussion thread on the possibility of adding support for extends in some form in future versions. The extends keyword has been included in docker-compose versions 1.27 and higher.

.. note::

   ``extends`` （拡張）キーワードは、初期の Compose ファイル形式から Compose ファイルバージョン 2.1 （ :ref:`v2 の extends <compose-file-extends>` を参照 ）までサポートされていましたが、Compose バージョン 3.x ではサポートされていません。 :ref:`バージョン 3 概要 <compose-file-version-3>` でのキー追加と削除に加え、 :ref:`アップグレードの仕方 <compose-file-upgrading>` をご覧ください。将来の形式で同じように ``extends`` をサポートする可能性についての議論は、 `moby/moby#31101 <https://github.com/moby/moby/issues/31101>`_ をご覧ください。 ``extends`` キーワードは、 docker-compose バージョン 1.27 以上から含まれるようになりました。

.. Docker Compose’s extends keyword enables the sharing of common configurations among different files, or even different projects entirely. Extending services is useful if you have several services that reuse a common set of configuration options. Using extends you can define a common set of service options in one place and refer to it from anywhere.

Docker Compose の ``extends`` キーワードは、共通の設定を異なるファイル間で共有できます。また、全く異なるプロジェクトでさえも共有できます。サービスの :ruby:`拡張 <extends>` は、共通する設定オプション群を持つ、複数のサービスがある場合に役立ちます。 ``extends`` を使えば、１箇所で共通するサービスのオプション群を設定できますし、どこからでも参照できます。

.. Keep in mind that volumes_from and depends_on are never shared between services using extends. These exceptions exist to avoid implicit dependencies; you always define volumes_from locally. This ensures dependencies between services are clearly visible when reading the current file. Defining these locally also ensures that changes to the referenced file don’t break anything.

注意点として、 ``volumes_from`` と ``depends_on`` は、 ``extends`` を使うサービス間で決して共有されません。これは潜在的な依存関係を防ぐために、例外終了します。つまり、 ``volumes_from`` は常にローカルで定義しなくてはいけません。これにより、現在のファイルを読み込む時に、サービスの依存関係が明確に表示されます。また、これら（ボリューム）をローカルで定義するため、参照しているファイルを変更したとても、一切影響がありません。

.. Understand the extends configuration
.. _understand-the-extends-configuration:

extends 設定の理解
--------------------

.. When defining any service in docker-compose.yml, you can declare that you are extending another service like this:

``docker-compose.yml`` であらゆるサービスを定義する時に、次のように、他のサービスを拡張するよう宣言できます。

.. code-block:: yaml

   services:
     web:
       extends:
         file: common-services.yml
         service: webapp

.. This instructs Compose to re-use the configuration for the webapp service defined in the common-services.yml file. Suppose that common-services.yml looks like this:

これは Compose に対し、 ``common-services.yml`` ファイル内で定義された ``webapp`` サービスの設定を再利用するように命令します。 ``common-services.yml`` は、このような内容を想定しています。

.. code-block:: yaml

   services:
     webapp:
       build: .
       ports:
         - "8000:8000"
       volumes:
         - "/data"

.. In this case, you get exactly the same result as if you wrote docker-compose.yml with the same build, ports and volumes configuration values defined directly under web.

このようにすると、 ``docker-compose.yml`` 内の ``web`` 以下で、同じ ``build`` 、 ``ports`` 、 ``volumes`` 設定を定義した場合と結果が完全に同じになります。

.. You can go further and define (or re-define) configuration locally in docker-compose.yml:

``docker-compose.yml`` 内では、さらに続けてローカルの設定を定義（あるいは再定義）できます。

.. code-block:: yaml

   services:
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

また、 他のサービスを記述し、 ``web`` サービスに対してサービスをリンクできます。

.. code-block:: yaml

   services:
     web:
       extends:
         file: common-services.yml
         service: webapp
       environment:
         - DEBUG=1
       cpu_shares: 5
       depends_on:
         - db
     db:
       image: postgres

.. Example use case
利用例
----------

.. Extending an individual service is useful when you have multiple services that have a common configuration. The example below is a Compose app with two services: a web application and a queue worker. Both services use the same codebase and share many configuration options.

複数のサービスが共通の設定を持つ場合、個々のサービスを拡張するのが便利です。以下の例にある Compose アプリは、 :ruby:`ウェブ <web>` アプリケーションと :ruby:`キュー ワーカ <queue worker>` という、２つのサービスがあります。どちらのサービスも、同じコードベースを使い、多くの設定オプションを共有します。

.. In a common.yml we define the common configuration:

**common.yml** 内には、共通する設定を定義します。

.. code-block:: bash

   services:
     app:
       build: .
       environment:
         CONFIG_FILE_PATH: /code/config
         API_KEY: xxxyyy
       cpu_shares: 5

.. In a docker-compose.yml we define the concrete services which use the common configuration:

**docker-compose.yml** 内には、共通する設定を使う具体的なサービスを定義します。

.. code-block:: bash

   services:
     webapp:
       extends:
         file: common.yml
         service: app
       command: /code/run_web_app
       ports:
         - 8080:8080
       depends_on:
         - queue
         - db
   
     queue_worker:
       extends:
         file: common.yml
         service: app
       command: /code/run_worker
       depends_on:
         - queue

.. Adding and overriding configuration
.. _adding-and-overriding-configuration:

設定情報の追加と上書き
==============================

.. Compose copies configurations from the original service over to the local one. If a configuration option is defined in both the original service and the local service, the local value replaces or extends the original value.

Compose はオリジナルのサービスにある設定情報を、ローカルの設定情報へとコピーします。設定情報のオプションがオリジナル サービスとローカル サービスの両方で定義されている場合、ローカルの値は「 :ruby:`置き換え <replaces>` 」られるか、オリジナルの値が「 :ruby:`拡張 <extends>` 」されます。

.. For single-value options like image, command or mem_limit, the new value replaces the old value.

``image`` 、 ``command`` 、 ``mem_limit`` のようにオプションが単一の値を持つ場合、古い値を新しい値で置き換えます。

.. original service:

オリジナル サービス：

.. code-block:: yaml

   services:
     myservice:
       # ...
       command: python app.py

.. local service:

ローカル サービス：

.. code-block:: yaml

   services:
     myservice:
       # ...
       command: python otherapp.py

.. result:

結果：

.. code-block:: yaml

   services:
     myservice:
       # ...
       command: python otherapp.py

.. For the multi-value options ports, expose, external_links, dns, dns_search, and tmpfs, Compose concatenates both sets of values:

``ports`` 、 ``expose`` 、 ``external_links`` 、 ``dns`` 、 ``dns_search`` 、 ``tmpfs`` のような **複数の値を持つオプション** では、Compose は両方の値を連結します。

.. original service:

.. code-block:: yaml

   services:
     myservice:
       # ...
       expose:
         - "3000"

.. local service:
ローカル サービス：

.. code-block:: yaml

   services:
     myservice:
       # ...
       expose:
         - "4000"
         - "5000"

.. result:

結果：

.. code-block:: yaml

   services:
     myservice:
       # ...
       expose:
         - "3000"
         - "4000"
         - "5000"

.. In the case of environment, labels, volumes, and devices, Compose “merges” entries together with locally-defined values taking precedence. For environment and labels, the environment variable or label name determines which value is used:

``environment`` 、 ``labels`` 、 ``volumes`` 、 ``devices`` では、 Compose はローカルで定義した値を優先しながら、全体を「 :ruby:`統合 <merge>` 」します。 ``environment`` と ``labels`` では、環境変数の値やラベル名で明示された値が使われます。

.. original service:

オリジナル サービス：

.. code-block:: yaml

   services:
     myservice:
       # ...
       environment:
         - FOO=original
         - BAR=original

.. local service:
ローカル サービス：

.. code-block:: yaml

   services:
     myservice:
       # ...
       environment:
         - BAR=local
         - BAZ=local

.. result
結果：

.. code-block:: yaml

   services:
     myservice:
       # ...
       environment:
         - FOO=original
         - BAR=local
         - BAZ=local

.. Entries for volumes and devices are merged using the mount path in the container:

``volumes`` と ``devices`` のエントリは、コンテナ内にマウントするパスを使う場合に :ruby:`統合 <merge>` されます。

.. original service:

オリジナル サービス：

.. code-block:: yaml

   services:
     myservice:
       # ...
       volumes:
         - ./original:/foo
         - ./original:/bar

.. local service:
ローカル サービス：

.. code-block:: yaml

   services:
     myservice:
       # ...
       volumes:
         - ./local:/bar
         - ./local:/baz

.. result:
結果：

.. code-block:: yaml

   services:
     myservice:
       # ...
       volumes:
         - ./original:/foo
         - ./local:/bar
         - ./local:/baz

Compose ドキュメント
====================

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

   Share Compose configurations between files and projects
      https://docs.docker.com/compose/extends/

