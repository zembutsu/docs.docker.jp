.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/environment-variables/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/environment-variables.md
.. ----------------------------------------------------------------------------

.. title: Environment variables in Compose

.. _environment-variables-in-compose:

=====================================================
Compose における環境変数
=====================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. There are multiple parts of Compose that deal with environment variables in one sense or another. This page should help you find the information you need.

Compose の複数の場面において環境変数がさまざまに用いられています。
このページでは環境変数について必要となる情報を示します。

.. ## Substituting environment variables in Compose files

.. _substitute-environment-variables-in-compose-files:

Compose ファイル内での環境変数の利用
=====================================

.. It's possible to use environment variables in your shell to populate values inside a Compose file:

シェル内にて環境変数を設定し、その値を Compose ファイルにおいて読み込ませることができます。

::

   web:
     image: "webapp:${TAG}"

.. For more information, see the [Variable substitution](compose-file.md#variable-substitution) section in the Compose file reference.

詳しくは Compose ファイルリファレンスの :doc:`変数の置換 </compose/compose-file>` の項を参照してください。

.. ## Setting environment variables in containers

.. _set-environment-variables-in-containers:

コンテナ内での環境変数の設定
=============================

.. You can set environment variables in a service's containers with the ['environment' key](compose-file.md#environment), just like with `docker run -e VARIABLE=VALUE ...`:

サービスコンテナにおいて、たとえば ``docker run -e VARIABLE=VALUE ...`` のように :doc:`environment キー </compose/compose-file>` を使って、環境変数を設定することができます。

::

   web:
     environment:
       - DEBUG=1

.. ## Passing environment variables through to containers

.. _pass-environment-variables-to-containers:

コンテナへの環境変数の受け渡し
===============================

.. You can pass environment variables from your shell straight through to a service's containers with the ['environment' key](compose-file.md#environment) by not giving them a value, just like with `docker run -e VARIABLE ...`:

シェル内の環境変数を :doc:`environment キー </compose/compose-file>` を使って、直接サービスコンテナに受け渡すことができます。この場合には値を渡すのではなく ``docker run -e 変数名 ...`` のようにできます。

::

   web:
     environment:
       - DEBUG

.. The value of the `DEBUG` variable in the container will be taken from the value for the same variable in the shell in which Compose is run.

コンテナ内の ``DEBUG`` 変数は、シェル内の ``DEBUG`` 変数の値が用いられます。
このシェルとは Compose が起動しているシェルのことです。

.. ## The “env_file” configuration option

.. _the-env_file-configuration-option:

設定オプション ``env_file``
===============================

.. You can pass multiple environment variables from an external file through to a service's containers with the ['env_file' option](compose-file.md#envfile), just like with `docker run --env-file=FILE ...`:

外部ファイルから複数の環境変数をサービスコンテナー受け渡すには :doc:`env_file オプション </compose/compose-file>` を利用することができます。
``docker run --env-file=FILE ...`` のようにすることもできます。

::

   web:
     env_file:
       - web-variables.env

.. ## Setting environment variables with 'docker-compose run'

.. _set-environment-variables-with-docker-compose-run:

``docker-compose run`` 実行時の環境変数の設定
==============================================

.. Just like with `docker run -e`, you can set environment variables on a one-off container with `docker-compose run -e`:

``docker run -e`` と同じように、 ``docker-compose run -e`` の実行によるコンテナに対しても環境変数を設定することができます。

::

   docker-compose run -e DEBUG=1 web python console.py

.. You can also pass a variable through from the shell by not giving it a value:

シェル変数を受け渡す際には、値は直接受け渡さずに以下のようにできます。

::

   docker-compose run -e DEBUG web python console.py

.. The value of the `DEBUG` variable in the container will be taken from the value for the same variable in the shell in which Compose is run.

コンテナ内の ``DEBUG`` 変数は、シェル内の ``DEBUG`` 変数の値が用いられます。
このシェルとは Compose が起動しているシェルのことです。

.. ## The “.env” file

.. _the-env-file:

``.env`` ファイル
=================

.. You can set default values for any environment variables referenced in the Compose file, or used to configure Compose, in an [environment file](env-file.md) named `.env`:

Compose ファイルが参照する環境変数、あるいは Compose の設定に用いられる環境変数のデフォルト値を設定することができます。これは ``.env`` という :doc:`環境ファイル </compose/env-file>` にて行います。

::

   $ cat .env
   TAG=v1.5

   $ cat docker-compose.yml
   version: '3'
   services:
     web:
       image: "webapp:${TAG}"

.. When you run `docker-compose up`, the `web` service defined above uses the image `webapp:v1.5`. You can verify this with the [config command](reference/config.md), which prints your resolved application config to the terminal:

``docker-compose up`` を実行すると、上で定義されている ``web`` サービスは ``webapp:v1.5`` というイメージを利用します。
このことは :doc:`config コマンド <reference/config>` を使って確認できます。
このコマンドは変数を置換した後のアプリケーション設定を端末画面に出力します。

::

   $ docker-compose config
   version: '3'
   services:
     web:
       image: 'webapp:v1.5'

.. Values in the shell take precedence over those specified in the `.env` file. If you set `TAG` to a different value in your shell, the substitution in `image` uses that instead:

シェル内にて設定される値は、 ``.env`` ファイル内のものよりも優先されます。
たとえばシェル上において ``TAG`` を異なる値に設定していたら、それを使って変数置換された ``image`` が用いられることになります。

::

   $ export TAG=v2.0
   $ docker-compose config
   version: '3'
   services:
     web:
       image: 'webapp:v2.0'

.. When values are provided with both with shell `environment` variable and with an `env_file` configuration file, values of environment variables will be taken **from environment key first and then from environment file, then from a `Dockerfile` `ENV`–entry**:

``environment`` と ``env_file`` による設定ファイルの両方にて変数が指定されると、環境変数の値はまずは ``environment`` キーが優先して取得され、次に設定ファイルから取得することになり、その次に ``Dockerfile`` の ``ENV`` エントリとなります。

::

   $ cat ./Docker/api/api.env
   NODE_ENV=test
   
   $ cat docker-compose.yml
   version: '3'
   services:
     api:
       image: 'node:6-alpine'
       env_file:
        - ./Docker/api/api.env
       environment:
        - NODE_ENV=production

.. You can test this with for e.g. a _NodeJS_ container in the CLI:

このことはたとえば *NodeJS* コンテナに対して以下のコマンドにより確認できます。

::

   $ docker-compose exec api node
   > process.env.NODE_ENV
   'production'

.. Having any `ARG` or `ENV` setting in a `Dockerfile` will evaluate only if there is _no_ Docker _Compose_ entry for `environment` or `env_file`.

``Dockerfile`` ファイル内の ``ARG`` や ``ENV`` は、 ``environment`` や ``env_file`` による Docker Compose の設定がある場合は評価されません。

.. _Spcecifics for NodeJS containers:_ If you have a `package.json` entry for `script:start` like `NODE_ENV=test node server.js`, then this will overrule _any_ setting in your `docker-compose.yml` file.

**NodeJS コンテナーの仕様:** ``script:start`` に対して ``package.json`` のエントリを含む場合、たとえば ``NODE_ENV=test node server.js`` のような場合には、 ``docker-compose.yml`` ファイルでの設定よりもこちらの設定が優先されます。

.. ## Configuring Compose using environment variables

.. _configure-compose-using-environment-variables:

環境変数を用いた Compose の設定
================================

.. Several environment variables are available for you to configure the Docker Compose command-line behaviour. They begin with `COMPOSE_` or `DOCKER_`, and are documented in [CLI Environment Variables](reference/envvars.md).

Docker Compose のコマンドラインからの処理設定を行うことができる環境変数がいくつかあります。
そういった変数は先頭が ``COMPOSE_`` や ``DOCKER_`` で始まります。
詳しくは :doc:`CLI 環境変数 <reference/envvars>` を参照してください。

.. ## Environment variables created by links

.. _environment-variables-created-by-links:

リンクから生成される環境変数
=============================

.. When using the ['links' option](compose-file.md#links) in a [v1 Compose file](compose-file.md#version-1), environment variables will be created for each link. They are documented in the [Link environment variables reference](link-env-deprecated.md). Please note, however, that these variables are deprecated - you should just use the link alias as a hostname instead.

:doc:`Compose ファイルバージョン 1 </compose/compose-file>` における :doc:`links オプション </compose/compose-file>` を用いると、各リンクに対する環境変数が生成されます。
このことは :doc:`リンク環境変数リファレンス </compose/link-env-deprecated>` において説明しています。
ただしこの変数は廃止予定となっています。
リンクはホスト名として利用するようにしてください。


.. seealso:: 

   Environment variables in Compose
      https://docs.docker.com/compose/environment-variables/

