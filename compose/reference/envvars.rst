.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/envvars/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/reference/envvars.md
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/reference/envvars.md
.. check date: 2016/04/28
.. Commits on Mar 25, 2016 dcdcf4869b6df77e16e243ace9e49c136d336b78
.. -------------------------------------------------------------------

.. title: Compose CLI environment variables

.. _compose-cli-environment-variables:

=======================================
Compose CLI 環境変数
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Several environment variables are available for you to configure the Docker Compose command-line behaviour.

Docker Compose コマンドラインの動作を設定するものとして、数種類の環境変数が利用できます。

.. Variables starting with `DOCKER_` are the same as those used to configure the
   Docker command-line client. If you're using `docker-machine`, then the `eval "$(docker-machine env my-docker-vm)"` command should set them to their correct values. (In this example, `my-docker-vm` is the name of a machine you created.)

``DOCKER_`` が先頭につく変数は、Docker コマンドラインクライアントの設定に用いられる環境変数と同じです。
``docker-machine`` を利用している場合は、``eval "$(docker-machine env my-docker-vm)"`` コマンドを実行することで、各環境変数に適切な値が設定されます。
（この例では ``my-docker-vm`` が生成されているマシン名です。）

.. > **Note**: Some of these variables can also be provided using an
   > [environment file](/compose/env-file.md)

.. note::

   ここに示す環境変数の中には、:doc:`環境ファイル </compose/env-file>` を用いて設定できるものもあります。


.. ## COMPOSE\_PROJECT\_NAME

.. _compose-project-name:

COMPOSE_PROJECT_NAME
====================

.. Sets the project name. This value is prepended along with the service name to
   the container on start up. For example, if your project name is `myapp` and it
   includes two services `db` and `web` then compose starts containers named
   `myapp_db_1` and `myapp_web_1` respectively.

プロジェクト名を設定します。
この値は、コンテナの起動時にサービス名の先頭につけられます。
たとえばプロジェクト名が ``myapp`` であり、2 つのサービス ``db`` と ``web`` があるとします。
Compose がコンテナを起動したときにつける名前は、それぞれ ``myapp_db_1`` と ``myapp_web_1`` です。

.. Setting this is optional. If you do not set this, the `COMPOSE_PROJECT_NAME`
   defaults to the `basename` of the project directory. See also the `-p`
   [command-line option](overview.md).

この変数を設定するのは任意です。
変数を設定しなかった場合 ``COMPOSE_PROJECT_NAME`` のデフォルトは、プロジェクトディレクトリの ``basename`` となります。
:doc:`コマンドラインオプション <overview>` の ``-p`` も参照してください。

.. ## COMPOSE\_FILE

.. _compose-file:

COMPOSE_FILE
====================

.. Specify the path to a Compose file. If not provided, Compose looks for a file named
   `docker-compose.yml` in the current directory and then each parent directory in
   succession until a file by that name is found.

Compose ファイルへのパスを指定します。
指定されなかった場合、Compose はカレントディレクトリ内の ``docker-compose.yml`` というファイルを探します。
そしてファイルが見つからなければ、この名前のファイルを見つけるまで親ディレクトリを順にたどって探します。

.. This variable supports multiple Compose files separated by a path separator (on
   Linux and macOS the path separator is `:`, on Windows it is `;`). For example:
   `COMPOSE_FILE=docker-compose.yml:docker-compose.prod.yml`. The path separator
   can also be customized using `COMPOSE_PATH_SEPARATOR`.

この変数は複数の Compose ファイルの指定をサポートしています。
複数のパスはセパレータで区切ります（パスセパレータは Linux や macOS では ``:``、Windows では ``;``）。
たとえば ``COMPOSE_FILE=docker-compose.yml:docker-compose.prod.yml`` とします。
パスセパレータは ``COMPOSE_PATH_SEPARATOR`` を使って変更することもできます。

.. See also the `-f` [command-line option](overview.md).

:doc:`コマンドラインオプション <overview>` の ``-f`` も参照してください。

.. ## COMPOSE\_API\_VERSION

.. _compose-api-version:

COMPOSE_API_VERSION
====================

.. The Docker API only supports requests from clients which report a specific
   version. If you receive a `client and server don't have same version` error using
   `docker-compose`, you can workaround this error by setting this environment
   variable. Set the version value to match the server version.

Docker API は、クライアントが特定のバージョンを返す場合に限って、クライアントからのリクエストに応じます。
``docker-compose`` を利用する際に ``client and server don't have same version`` （クライアントとサーバのバージョンが一致しません）というエラーが発生した場合は、その回避策として、本環境変数を設定する方法があります。
サーバのバージョンに合致するようなバージョン値をこの変数に設定することです。

.. Setting this variable is intended as a workaround for situations where you need
   to run temporarily with a mismatch between the client and server version. For
   example, if you can upgrade the client but need to wait to upgrade the server.

クライアントとサーバのバージョンが一致しないときであっても、実行が必要になる状況があります。
この変数を用いるのは、そういった状況を一時的に解決するためです。
具体的には、クライアントをアップグレードしたものの、サーバをまだアップグレードしていないような状況です。

.. Running with this variable set and a known mismatch does prevent some Docker
   features from working properly. The exact features that fail would depend on the
   Docker client and server versions. For this reason, running with this variable
   set is only intended as a workaround and it is not officially supported.

この変数を設定したとしても、既知のバージョン不一致に該当していれば、Docker の機能が正常に動作しないことがあります。
動作しない機能は、Docker クライアントやサーバのバージョンによって異なります。
このことから、本変数を設定して実行するのはあくまで一時的な回避策であり、公式にサポートされるものではありません。

.. If you run into problems running with this set, resolve the mismatch through
   upgrade and remove this setting to see if your problems resolve before notifying
   support.

本変数を設定することで問題が発生する場合は、アップグレードを行ってバージョンの不一致を解消してください。
そしてこの変数の定義を行わなかったらどうなるかを確認してください。
それでも問題が解決しない場合はサポートに問い合わせてください。
。

.. ## DOCKER\_HOST

.. _docker-host:

DOCKER_HOST
====================

.. Sets the URL of the `docker` daemon. As with the Docker client, defaults to `unix:///var/run/docker.sock`.

``docker`` デーモンの URL を設定します。
Docker クライアントと同じように、このデフォルト値は ``unix:///var/run/docker.sock`` です。

.. ## DOCKER\_TLS\_VERIFY

.. _docker_tls_verify:

DOCKER_TLS_VERIFY
====================

.. When set to anything other than an empty string, enables TLS communication with
   the `docker` daemon.

この変数が空文字以外であれば、``docker`` デーモンとの TLS 通信を有効にします。

.. ## DOCKER\_CERT\_PATH

.. _docker_cert_path:

DOCKER_CERT_PATH
====================

.. Configures the path to the `ca.pem`, `cert.pem`, and `key.pem` files used for TLS verification. Defaults to `~/.docker`.

TLS 検証に用いられる各種ファイル、``ca.pem``, ``cert.pem``, ``key.pem`` のパスを設定します。
デフォルトは ``~/.docker`` です。

.. ## COMPOSE\_HTTP\_TIMEOUT

.. _compose_http_timeout:

COMPOSE_HTTP_TIMEOUT
====================

.. Configures the time (in seconds) a request to the Docker daemon is allowed to hang before Compose considers
   it failed. Defaults to 60 seconds.

Docker デーモンへの処理要求にあたって、Compose の処理は失敗していなくても、デーモンをハングアップさせる所要時間を（秒単位で）指定します。
デフォルトは 60 秒です。

.. ## COMPOSE\_TLS\_VERSION

.. _compose_tls_version:

COMPOSE_TLS_VERSION
====================

.. Configure which TLS version is used for TLS communication with the `docker`
   daemon. Defaults to `TLSv1`.
   Supported values are: `TLSv1`, `TLSv1_1`, `TLSv1_2`.

``docker`` デーモンとの TLS 通信に用いられる TLS バージョンを指定します。
デフォルトは ``TLSv1`` です。
また対応している値は ``TLSv1``, ``TLSv1_1``, ``TLSv1_2`` です。

.. Related Information

関連情報
==========

..    User guide
    Installing Compose
    Compose file reference

* :doc:`ユーザ・ガイド </compose/index>`
* :doc:`Compose のインストール </compose/install>`
* :doc:`Compose ファイルのリファレンス </compose/compose-file>`
* :doc:`/compose/env-file`

.. seealso:: 

   CLI Environment Variables
      https://docs.docker.com/compose/reference/envvars/

