.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/envvars/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/reference/envvars.md
   doc version: 1.13
      https://github.com/docker/compose/commits/master/docs/reference/envvars.md
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/compose/reference/envvars.md
.. check date: 2022/04/07
.. Commits on Sep 13, 2021 173d3c65f8e7df2a8c0323594419c18086fc3a30
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

Docker Compose コマンドラインでの挙動を、いくつかの環境変数で設定できます。

.. Variables starting with DOCKER_ are the same as those used to configure the Docker command-line client. If you’re using docker-machine, then the eval "$(docker-machine env my-docker-vm)" command should set them to their correct values. (In this example, my-docker-vm is the name of a machine you created.)

``DOCKER_`` で始まる環境変数は、Docker コマンドラインでの設定に使うだけでなく、 Docker Compose のコマンドラインでも同様に使います。 ``docker-machine`` を使う場合は、 ``eval "$(docker-machine env my-docker-vm)"`` コマンドによって、適切な値を環境変数に指定します（この例では、 ``my-docker-vm`` は作成する仮想マシン名です）。

.. Note: Some of these variables can also be provided using an environment file.

.. note::

   環境変数のいくつかは :doc:`環境ファイル </compose/env-file>` でも設定できます。

.. COMPOSE_PROJECT_NAME
.. _env-project-name:

COMPOSE_PROJECT_NAME
====================

.. Sets the project name. This value is prepended along with the service name to the container on start up. For example, if your project name is myapp and it includes two services db and web, then Compose starts containers named myapp_db_1 and myapp_web_1 respectively.

プロジェクト名を設定します。このプロジェクト名としての値とサービス名が、起動するコンテナの名前に付けられます。たとえば、プロジェクト名は ``myapp`` で、 ``db`` と ``web`` という2つのサービスがあるとすると、Compose は ``myapp_db_1`` と ``myapp_web_1`` という名前のコンテナを個々に起動します。

.. Setting this is optional. If you do not set this, the COMPOSE_PROJECT_NAME defaults to the basename of the project directory. See also the -p command-line option.

この設定はオプションです。 ``COMPOSE_PROJECT_NAME`` の指定が無ければ、デフォルトではプロジェクトがあるディレクトリ名をプロジェクト名として扱います。 ``-p`` :doc:`コマンドラインのオプション <index>` もご覧ください。

.. COMPOSE_FILE
.. _env-compose-file:
COMPOSE_FILE
====================

.. Specify the path to a Compose file. If not provided, Compose looks for a file named docker-compose.yml in the current directory and then each parent directory in succession until a file by that name is found.

Compose ファイルのパスを指定します。指定が無ければ、Compose は現在のディレクトリ内で ``docker-compose.yml`` という名前のファイルを探します。このファイルが見つからなければ、見つかるまで継続して親ディレクトリを探します。

.. This variable supports multiple Compose files separated by a path separator (on Linux and macOS the path separator is :, on Windows it is ;). For example: COMPOSE_FILE=docker-compose.yml:docker-compose.prod.yml. The path separator can also be customized using COMPOSE_PATH_SEPARATOR.

この値には、 :ruby:`パス区切り文字 <path separator>` （ Linux と macOS では ``:`` 、 Windows では ``;`` ）を使って、複数の Compose ファイルを指定できます。たとえば、 ``COMPOSE_FILE=docker-compose.yml:docker-compose.prod.yml`` とします。パス区切り文字は ``COMPOSE_PATH_SEPARATOR`` を使ってカスタマイズもできます。

.. See also the -f command-line option.

 ``-f`` :doc:`コマンドラインのオプション <index>` もご覧ください。

.. COMPOSE_PROFILES
.. _env-compose-profiles:
COMPOSE_PROFILES
====================

.. Specify one or multiple active profiles to enable. Calling docker-compose up with COMPOSE_PROFILES=frontend will start the services with the profile frontend and services without specified profiles.

有効にしたいアクティブなプロファイルを指定します。 ``COMPOSE_PROFILES=frontend`` で ``docker-compose up`` を実行すると、プロファイル ``frontend`` のサービスと、プロファイルの指定がないサービスを起動します。

.. You can specify a list of profiles separated with a comma: COMPOSE_PROFILES=frontend,debug will enable the profiles frontend and debug.

カンマ記号を区切りに使い、複数のプロファイルを指定できます。つまり、 ``COMPOSE_PROFILES=frontend,debug`` とは、 ``frontend`` と ``debug`` のプロファイルを有効化します。

.. See also Using profiles with Compose and the --profile command-line option.
:doc:`compose/profile` と、 ``--profile`` :doc:`コマンドラインのオプション <index>` もご覧ください。

.. COMPOSE_API_VERSION
.. _env-compose_api_version:
COMPOSE_API_VERSION
====================

.. The Docker API only supports requests from clients which report a specific version. If you receive a client and server don't have same version error using docker-compose, you can workaround this error by setting this environment variable. Set the version value to match the server version.

Docker API のリクエストをサポートしているのは、特定のバージョンを報告するクライアントだけです。 ``docker-compose`` を使う時に ``client and server don't have same version`` のエラーが出た場合は、この環境変数を使って回避できます。バージョンの値を、サーバのバージョンと一致するように指定します。

.. Setting this variable is intended as a workaround for situations where you need to run temporarily with a mismatch between the client and server version. For example, if you can upgrade the client but need to wait to upgrade the server.

この値の設定が想定している場面とは、クライアントとサーバ間のバージョンが一致しなくても、一時的に実行が必要な場合に、その回避策として使うためです。たとえば、クライアントは更新したとしても、サーバの更新は後回しにしたい場合です。

.. Running with this variable set and a known mismatch does prevent some Docker features from working properly. The exact features that fail would depend on the Docker client and server versions. For this reason, running with this variable set is only intended as a workaround and it is not officially supported.

この変数を設定して実行すると、適切な Docker 機能の妨げとなる不整合が分かっています。 Docker クライアントとサーバのバージョンに依存する機能は、確実に失敗します。そのため、この変数を使った実行とは、回避策としてのみの実行を意図したものであり、公式にサポートされません。

.. If you run into problems running with this set, resolve the mismatch through upgrade and remove this setting to see if your problems resolve before notifying support.

これを指定して実行中に問題が発生した場合は、サポートに問い合わせる前に、（クライアントやサーバのバージョンを）更新して設定を削除した後でも、問題が解決しないかどうかをご確認ください。

.. DOCKER_HOST
.. _env-docker_host:
DOCKER_HOST
====================

.. Sets the URL of the docker daemon. As with the Docker client, defaults to unix:///var/run/docker.sock.

``docker`` デーモンの URL を指定します。Docker クライアントでは、デフォルトは ``unix:///var/run/docker.sock`` です。


.. DOCKER_TLS_VERIFY
.. _env-docker_tls_verify:
DOCKER_TLS_VERIFY
====================

.. When set to anything other than an empty string, enables TLS communication with the docker daemon.

空の文字列以外で何かを指定した場合、 ``docker`` デーモンとの TLS 通信を有効にします。

.. DOCKER_CERT_PATH
.. _env-docker_cert_path:
DOCKER_CERT_PATH
====================

.. Configures the path to the ca.pem, cert.pem, and key.pem files used for TLS verification. Defaults to ~/.docker.

TLS 認証で使う設定ファイル ``ca.pem`` 、 ``cert.pem`` 、 ``key.pem`` のパスを指定します。デフォルトは ``~/.docker`` です。


.. COMPOSE_HTTP_TIMEOUT
.. _env-compose_http_timeout:
COMPOSE_HTTP_TIMEOUT
====================

.. Configures the time (in seconds) a request to the Docker daemon is allowed to hang before Compose considers it failed. Defaults to 60 seconds.

Docker デーモンに対するリクエストが固まった（ :ruby:`ハング <hang>` した）と Compose が判断する時間（秒）を指定します。デフォルトは 60 秒です。


.. COMPOSE_TLS_VERSION
.. _env-compose_tls_version:
COMPOSE_TLS_VERSION
====================

.. Configure which TLS version is used for TLS communication with the docker daemon. Defaults to TLSv1. Supported values are: TLSv1, TLSv1_1, TLSv1_2.

``docker`` デーモンとの TLS 通信に使う TLS バージョンを設定します。サポートしている値は ``TLSv1`` 、 ``TLSv1_1`` 、 ``TLSv1_2`` です。

.. COMPOSE_CONVERT_WINDOWS_PATHS
.. _env-compose_convert_windows_paths:
COMPOSE_CONVERT_WINDOWS_PATHS
==============================

.. Enable path conversion from Windows-style to Unix-style in volume definitions. Users of Docker Machine on Windows should always set this. Defaults to 0. Supported values: true or 1 to enable, false or 0 to disable.

ボリュームの定義でのパス指定を、 Windows 風から Unix 風に転換します。Windows 版の Docker Machine を使うユーザは、常に設定すべきでしょう。デフォルトは ``0`` です。サポートしている値は、有効化が ``true`` か ``1`` 、無効化は ``false`` か ``0`` です。

.. COMPOSE_PATH_SEPARATOR
.. _env-compose_path_separator:
COMPOSE_PATH_SEPARATOR
==============================

.. If set, the value of the COMPOSE_FILE environment variable is separated using this character as path separator.

設定すると、この値を ``COMPOSE_FILE`` 環境変数でのパス区切り文字として使います。

.. COMPOSE_FORCE_WINDOWS_HOST
.. _env-compose_force_windows_host:
COMPOSE_FORCE_WINDOWS_HOST
==============================

.. If set, volume declarations using the short syntax are parsed assuming the host path is a Windows path, even if Compose is running on a UNIX-based system. Supported values: true or 1 to enable, false or 0 to disable.

設定すると、ボリューム定義に :ref:`compose-file-v3-volumes-short-syntax` を使う場合、UNIX ベースのシステム上で Compose を実行していたとしても、ホスト上のパスは Windows のパスとして想定します。サポートしている値は、有効化が ``true`` か ``1`` 、無効化は ``false`` か ``0`` です。


.. COMPOSE_IGNORE_ORPHANS
.. _env-compose_ignore_orphans:
COMPOSE_IGNORE_ORPHANS
==============================

.. If set, Compose doesn’t try to detect orphaned containers for the project. Supported values: true or 1 to enable, false or 0 to disable.
設定すると、プロジェクト用に孤立したコンテナを検出しません。サポートしている値は、有効化が ``true`` か ``1`` 、無効化は ``false`` か ``0`` です。

.. COMPOSE_PARALLEL_LIMIT
.. _env-compose_parallel_limit:
COMPOSE_PARALLEL_LIMIT
==============================

.. Sets a limit for the number of operations Compose can execute in parallel. The default value is 64, and may not be set lower than 2.

Compose が並列に実行できる処理数の上限を指定します。デフォルトの値は ``64`` です。 ``2`` 未満は指定できません。

.. COMPOSE_INTERACTIVE_NO_CLI
.. _env-compose_interactive_no_cli:
COMPOSE_INTERACTIVE_NO_CLI
==============================

.. If set, Compose doesn’t attempt to use the Docker CLI for interactive run and exec operations. This option is not available on Windows where the CLI is required for the aforementioned operations. Supported: true or 1 to enable, false or 0 to disable.

設定すると、Compose は Docker CLI を使っての双方向な ``run`` と ``exec`` 操作を試みません。Windows 上の CLI で先述の処理が必要だとしても、このオプションは使えません。

.. COMPOSE_DOCKER_CLI_BUILD
.. _env-compose_docker_cli_build:
COMPOSE_DOCKER_CLI_BUILD
==============================

.. Configure whether to use the Compose python client for building images or the native docker cli. By default, Compose uses the docker CLI to perform builds, which allows you to use BuildKit to perform builds.

イメージ構築に使う Compose の Python クライアントか、ネイティブな docker CLI の場所を市営します。デフォルトは、構築に ``docker`` CLI を使うので、構築の処理には  :ref:`BuildKit <to-enable-buildkit-builds>` が使えます。

.. Set COMPOSE_DOCKER_CLI_BUILD=0 to disable native builds, and to use the built-in python client.

``COMPOSE_DOCKER_CLI_BUILD=0`` と指定すると、ネイティブな構築を無効化するため、内蔵の Python クライアントを使って構築します。

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

   Compose CLI environment variables
      https://docs.docker.com/compose/reference/envvars/

