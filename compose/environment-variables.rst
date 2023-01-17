.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/environment-variables/
.. SOURCE: 
   doc version: 1.11
      https://github.com/docker/compose/blob/master/docs/environment-variables.md
   doc version: v20.10
      https://github.com/docker/docker.github.io/blob/master/compose/environment-variables.md
.. check date: 2022/07/16
.. Commits on Jul 14, 2022 5088f2d82b4701859d403ef4e95a65671147f3ee
.. -------------------------------------------------------------------

.. Environment variables in Compose
.. _environment-variables-in-compose:

=====================================================
Compose 内の環境変数
=====================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. There are multiple parts of Compose that deal with environment variables in one sense or another. This page should help you find the information you need.

様々な用途のために、Compose の複数の場面で環境変数を扱います。このページは必要な情報を探すのに役立つでしょう。

.. Substitute environment variables in Compose files
.. _substitute-environment-variables-in-compose-files:

Compose ファイルで環境変数を展開
========================================

.. It’s possible to use environment variables in your shell to populate values inside a Compose file:

環境変数を使えば、Compose ファイル内にシェル上の環境変数を投入（変数展開）できます。

.. code-block:: yaml

   web:
     image: "webapp:${TAG}"

.. If you have multiple environment variables, you can substitute them by adding them to a default environment variable file named .env or by providing a path to your environment variables file using the --env-file command line option.

複数の環境変数がある場合、デフォルトでは ``.env`` というファイル名で展開したい変数を記述できます。あるいは、 ``--env-file`` コマンドラインのオプションを使って、環境変数ファイルのパスを指定できます。

.. Your configuration options can contain environment variables. Compose uses the variable values from the shell environment in which docker-compose is run. For example, suppose the shell contains POSTGRES_VERSION=9.3 and you supply this configuration:

設定のオプションに、環境変数の値を含められます。Compose は実行時、 ``docker compose`` を実行するシェルの環境変数にある値を使います。たとえば、シェル（の環境変数）に ``POSTGRES_VERSION=9.3`` を含んでいるとすると、これを設定に対応させられます。

.. code-block:: yaml

   db:
     image: "postgres:${POSTGRES_VERSION}"

.. When you run docker-compose up with this configuration, Compose looks for the POSTGRES_VERSION environment variable in the shell and substitutes its value in. For this example, Compose resolves the image to postgres:9.3 before running the configuration.

この設定を ``docker compose up`` で使うと、 Compose はシェル内の ``POSTGRES_VERSION`` 環境変数の値を探し、その値を展開します。この例では、 Compose は設定を使って実行する前に、 ``image`` を ``postgres:9.3`` と解釈します。

.. If an environment variable is not set, Compose substitutes with an empty string. In the example above, if POSTGRES_VERSION is not set, the value for the image option is postgres:.

環境変数の値が無い場合は、 Compose は空の文字列を投入します。先の例では、 ``POSTGRES_VERSION`` の値が設定されていなければ、 ``image`` オプションの値は ``postgres:`` となります。

.. You can set default values for environment variables using a .env file, which Compose automatically looks for in project directory (parent folder of your Compose file). Values set in the shell environment override those set in the .env file.

:doc:`.env ファイル <env-file>` ファイルを使えば、環境変数のデフォルト値を設定できます。この .env ファイルは、 Compose がプロジェクトのディレクトリ内（Compose ファイルがある親ディレクトリ）を自動的に探します。シェル環境変数の値は、 ``.env`` ファイルで設定された値よりも優先されます。

..  Note when using docker stack deploy
    The .env file feature only works when you use the docker-compose up command and does not work with docker stack deploy.

.. warning::

   **docker stack deploy 時の注意** 
   
   ``.env`` ファイル機能が動作するのは ``docker compose up`` コマンドを使った時のみであり、 ``docker stack deploy`` では機能しません。

.. Both $VARIABLE and ${VARIABLE} syntax are supported. Additionally when using the 2.1 file format, it is possible to provide inline default values using typical shell syntax:

``$変数`` と ``${変数}``  構文をサポートしています。加えて、 :ref:`2.1 ファイル形式 <compose-file-version-21>` を使う場合は、典型的なシェル構文を使い、デフォルト値を変数内に展開できます。

..  ${VARIABLE:-default} evaluates to default if VARIABLE is unset or empty in the environment.
    ${VARIABLE-default} evaluates to default only if VARIABLE is unset in the environment.

* ``${変数:-default}`` は、 ``変数`` が設定されていないか、環境変数の値が空の場合、 ``defaule`` の値とする
* ``${変数-default}`` は、環境変数内で ``変数`` が設定されていない場合のみ、 ``default`` の値とする

.. Similarly, the following syntax allows you to specify mandatory variables:

同様に、以下の構文を使えば、特定の値を :ruby:`必須に <mandatory>` できます。

..  ${VARIABLE:?err} exits with an error message containing err if VARIABLE is unset or empty in the environment.
    ${VARIABLE?err} exits with an error message containing err if VARIABLE is unset in the environment.


* ``${変数:?err}`` は、 ``変数`` が設定されていないか、環境変数の値が空の場合、 ``err`` を含むエラーメッセージと共に終了する
* ``${変数?err}`` は、環境変数内で ``変数`` が設定されていない場合に、 ``err`` を含むエラーメッセージと共に終了する

.. Other extended shell-style features, such as ${VARIABLE/foo/bar}, are not supported.

ただし、``${変数/foo/bar}`` のような、他のシェル形式の拡張はサポートしていません。

.. You can use a $$ (double-dollar sign) when your configuration needs a literal dollar sign. This also prevents Compose from interpolating a value, so a $$ allows you to refer to environment variables that you don’t want processed by Compose.

設定上で文字列としてのドル記号が必要な場合は、 ``$$`` （二重ドル記号）を使います。これはまた、Compose による値の補完を防止するため、Compose で処理したくない環境変数を ``$$`` によって参照できます。

.. code-block:: yaml

   web:
     build: .
     command: "$$VAR_NOT_INTERPOLATED_BY_COMPOSE"

.. If you forget and use a single dollar sign ($), Compose interprets the value as an environment variable and warns you:

これを忘れてしまいドル記号（ ``$`` ）を使った場合、 Compose は環境変数の値だと解釈し、警告を表示します。

.. code-block:: bash

   The VAR_NOT_INTERPOLATED_BY_COMPOSE is not set. Substituting an empty string.

.. The “.env” file
.. _compose-the-env-file:

``.env`` ファイル
--------------------

.. You can set default values for any environment variables referenced in the Compose file, or used to configure Compose, in an environment file named .env. The .env file path is as follows:

あらゆる環境変数から参照できるデフォルト値を設定できます。そのためには、 Compose ファイル内で、または、 ``.env`` という名前の :doc:`環境設定ファイル <env-file>` 内の設定を使います。 ``.env`` ファイルのパスは、以下のように扱います。

..  Starting with +v1.28, .env file is placed at the base of the project directory
    Project directory can be explicitly defined with the --file option or COMPOSE_FILE environment variable. Otherwise, it is the current working directory where the docker compose command is executed (+1.28).
    For previous versions, it might have trouble resolving .env file with --file or COMPOSE_FILE. To work around it, it is recommended to use --project-directory, which overrides the path for the .env file. This inconsistency is addressed in +v1.28 by limiting the filepath to the project directory.

* ``v1.28`` 以上は、 ``.env`` ファイルはプロジェクトがあるディレクトリのベースにあります。
* プロジェクト ディレクトリは、 ``--file`` オプションや ``COMPOSE_FILE`` 環境変数の値で明示できます。明示されなければ、 ``docker compose`` コマンドを実行する現在の作業ディレクトリとみなします（ ``v1.28`` 以上）。
* 以前のバージョンでは、 ``.env`` ファイルと ``--file`` や ``COMPOSE_FILE`` を使うと問題が起こる可能性があります。正しく動かすためには、 ``--project-directory`` を使い、 ``.env`` ファイルのパスを上書きを推奨します。この矛盾は ``v1.28`` で対処され、プロジェクト ディレクトリのファイルパスを制限しています。

.. code-block:: bash

   $ cat .env
   TAG=v1.5
   
   $ cat docker-compose.yml
   version: '3'
   services:
     web:
       image: "webapp:${TAG}"

.. When you run docker compose up, the web service defined above uses the image webapp:v1.5. You can verify this with the convert command, which prints your resolved application config to the terminal:

``docker compose up`` の実行時、前述のとおり定義した ``web`` サービスが使うイメージは ``webapp:v1.5`` になります。これを確認するには :doc:`convert コマンド </engine/reference/commandline/compose_convert>` が利用でき、アプリケーションが解釈した設定をターミナル上に表示します。

.. code-block:: bash

   $ docker compose convert
   
   version: '3'
   services:
     web:
       image: 'webapp:v1.5'

.. Values in the shell take precedence over those specified in the .env file.

それぞれの ``.env`` ファイル内で指定された値よりも、シェル上の値が優先されます。

.. If you set TAG to a different value in your shell, the substitution in image uses that instead:

``TAG`` に対してシェル上で異なる値を指定すると、 ``image`` は代わりにこちらを展開します。

.. code-block:: bash

   $ export TAG=v2.0
   $ docker compose convert
   
   version: '3'
   services:
     web:
       image: 'webapp:v2.0'

.. You can override the environment file path using a command line argument --env-file.

コマンドラインで引数 ``--env-file`` を使い、環境変数ファイルのパスを上書きできます。

.. Using the “--env-file” option
.. _using-the-env-file-option:

``--env-file`` オプションを使う
----------------------------------------

.. By passing the file as an argument, you can store it anywhere and name it appropriately, for example, .env.ci, .env.dev, .env.prod. Passing the file path is done using the --env-file option:

引数としてファイルのパスを指定できるため、環境変数のファイルをどこにでも置けますし、適切な名前を付けられます。たとえば、 ``.env.ci`` 、 ``.env.dev`` 、 ``.env.prod`` です。ファイルのパスを渡すには、 ``--env-file`` オプションを使います。

.. code-block:: bash

   $ docker compose --env-file ./config/.env.dev up 

.. This file path is relative to the current working directory where the Docker Compose command is executed.

このファイルは、Docker Compose コマンドを実行する現在の作業ディレクトリからの相対パスになります。

.. code-block:: bash

   $ cat .env
   TAG=v1.5
   
   $ cat ./config/.env.dev
   TAG=v1.6
   
   
   $ cat docker-compose.yml
   version: '3'
   services:
     web:
       image: "webapp:${TAG}"

.. The .env file is loaded by default:

``.env`` ファイルはデフォルトで読み込まれます。

.. code-block:: bash

   $ docker compose convert 
   version: '3'
   services:
     web:
       image: 'webapp:v1.5'

.. Passing the --env-file argument overrides the default file path:

``--env-file`` 引数を渡すと、デフォルトのパスを上書きします。

.. code-block:: bash

   $ docker compose --env-file ./config/.env.dev config 
   version: '3'
   services:
     web:
       image: 'webapp:v1.6'

.. When an invalid file path is being passed as --env-file argument, Compose returns an error:

``--env-file`` 引数に無効なパスを渡した場合、 Compose はエラーを返します。

.. code-block:: bash

   $ docker compose --env-file ./doesnotexist/.env.dev  config
   ERROR: Couldn't find env file: /home/user/./doesnotexist/.env.dev

詳しい情報は、 Compose ファイルリファレンス内の :ref:`変数の置き換え <compose-file-v3-variable-substitution>` をご覧ください。

.. Set environment variables in containers
.. _set-environment-variables-in-containers:

コンテナ内での環境変数を指定
==============================

.. You can set environment variables in a service’s containers with the ‘environment’ key, just like with docker run -e VARIABLE=VALUE ...:

サービス用のコンテナ内での環境変数は :ref:`'environment' キー <compose-file-v3-environment>` で設定できます。これは ``docker run -e VARIABLE=VALUE ...`` のようなものです。

.. code-block:: yaml

   web:
     environment:
       - DEBUG=1

.. Pass environment variables to containers
.. _pass-environment-variables-to-containers:

環境変数をコンテナ内に通す
==============================

.. You can pass environment variables from your shell straight through to a service’s containers with the ‘environment’ key by not giving them a value, just like with docker run -e VARIABLE ...:

シェル上の環境変数をサービス用のコンテナに対して直接通すには、 :ref:`'environment' キー <compose-file-v3-environment>` で値を指定せずに使います。これは ``docker run -e VARIABLE ...`` のようなものです。

.. code-block:: yaml

   web:
     environment:
       - DEBUG

.. The value of the DEBUG variable in the container is taken from the value for the same variable in the shell in which Compose is run.

コンテナ内での ``DEBUG`` 変数の値は、Compose を実行したシェル上における、同じ環境変数の値をとります。

``env_file`` 設定オプション
==============================

.. You can pass multiple environment variables from an external file through to a service’s containers with the ‘env_file’ option, just like with docker run --env-file=FILE ...:

サービス用のコンテナに対して :ref:`'env_file' オプション <compose-file-v3-env_file>` を使えば、外部ファイルを通して複数の環境変数を渡せます。これは、 ``docker run --env-file=FILE ...`` のようなものです。

.. code-block:: yaml

   web:
     env_file:
       - web-variables.env

.. Set environment variables with ‘docker compose run’
.. _Set-environment-variables-with-docker-compose-run:

``docker compose run`` の環境変数を設定
========================================

.. Similar to docker run -e, you can set environment variables on a one-off container with docker compose run -e:

``docker run -e`` のように、 ``docker compose run -e`` で一度だけ実行するコンテナの環境変数を指定できます。

.. code-block:: bash

   $ docker compose run -e DEBUG=1 web python console.py

.. You can also pass a variable from the shell by not giving it a value:

また、シェルの環境変数は値を指定しなければ、（コンテナの中に環境変数）渡せます。

.. code-block:: bash

   $ docker compose run -e DEBUG web python console.py

.. The value of the DEBUG variable in the container is taken from the value for the same variable in the shell in which Compose is run.

コンテナ内での ``DEBUG`` 変数の値は、 Compose を実行したシェル上での、同じ変数の値になります。

.. When you set the same environment variable in multiple files, here’s the priority used by Compose to choose which value to use:

複数のファイルで同じ環境変数がある場合、Compose は使用する値を選ぶため、以下の優先度で使います。

..  Compose file
    Shell environment variables
    Environment file
    Dockerfile
    Variable is not defined

1. Compose ファイル
2. シェル環境変数
3. 環境変数ファイル
4. Dockerfile
5. 変数が定義されていない

.. In the example below, we set the same environment variable on an Environment file, and the Compose file:

以下の例では、環境設定ファイル上と Compose ファイルで同じ環境変数があります。

.. code-block:: bash

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

.. When you run the container, the environment variable defined in the Compose file takes precedence.

コンテナを実行する時、 Compose ファイル内で定義された環境変数の値が優先されます。


.. code-block:: bash

   $ docker compose exec api node
   
   > process.env.NODE_ENV
   'production'

.. Having any ARG or ENV setting in a Dockerfile evaluates only if there is no Docker Compose entry for environment or env_file.

``Dockerfile`` での ``ARG`` と ``ENV`` が処理されるのは、 Docker Compose の ``environement`` や ``env_file`` での指定が無い場合のみです。

..  Specifics for NodeJS containers
    If you have a package.json entry for script:start like NODE_ENV=test node server.js, then this overrules any setting in your docker-compose.yml file.

.. note::

   **NodeJS コンテナに対する指定**
   
 ``package.json`` で、 ``NODE_ENV=test node server.js`` のような ``script:start`` エントリがある場合、 ``docker-compose.yml`` ファイルでのあらゆる設定が無効になります。

.. Configure Compose using environment variables
.. _configure-compose-using-environment-variables:

Compose が使う環境変数の設定
==============================

.. Several environment variables are available for you to configure the Docker Compose command-line behavior. They begin with COMPOSE_ or DOCKER_, and are documented in CLI Environment Variables.

Docker Compose のコマドラインでの挙動を設定するため、いくつかの環境変数があります。それらは ``COMPOSE_`` や ``DOCKER_`` で始まるもので、 :doc:`CLI 環境変数 <envvars>` で文書化しています。

.. seealso:: 

   Environment variables in Compose
      https://docs.docker.com/compose/environment-variables/

