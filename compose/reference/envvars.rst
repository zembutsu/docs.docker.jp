.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/envvars/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/reference/envvars.md
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/reference/envvars.md
.. check date: 2016/04/28
.. Commits on Mar 25, 2016 dcdcf4869b6df77e16e243ace9e49c136d336b78
.. -------------------------------------------------------------------

.. CLI Environment Variables

.. _cli-environment-variables:

=======================================
CLI 環境変数
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Several environment variables are available for you to configure the Docker Compose command-line behaviour.

Docker Compose のコマンドラインでの動作を設定するために、複数の環境変数を利用可能です。

.. Variables starting with DOCKER_ are the same as those used to configure the Docker command-line client. If you’re using docker-machine, then the eval "$(docker-machine env my-docker-vm)" command should set them to their correct values. (In this example, my-docker-vm is the name of a machine you created.)

``DOCKER_`` で始まる環境変数は、Docker コマンドライン・クライアントで用いられている設定と同じです。もしも ``docker-machine`` を使っているのであれば、 ``eval "$(docker-machine env my-docker-vm)"`` コマンドで適切な環境変数の値を設定します（この例では、 ``my-docker-vm`` は Docker Machine で作成したマシンの名前です ）。

.. Note: Some of these variables can also be provided using an environment file

.. note::

   :doc:`環境ファイル </compose/env-file>` を使っても変数を指定できます。


.. COMPOSE_PROJECT_NAME

.. _compose-project-name:

COMPOSE_PROJECT_NAME
====================

.. Sets the project name. This value is prepended along with the service name to the container container on start up. For example, if you project name is myapp and it includes two services db and web then compose starts containers named myapp_db_1 and myapp_web_1 respectively.

プロジェクト名を設定します。この値はコンテナの起動時に、コンテナのサービス名の先頭に付けられます。たとえば、２つのサービス ``db`` と ``web`` を持つプロジェクトの名前を ``myapp`` としたら、Compose は ``myapp_db_1`` と ``myapp_web_1`` と名前の付いたコンテナをそれぞれ起動します。

.. Setting this is optional. If you do not set this, the COMPOSE_PROJECT_NAME defaults to the basename of the project directory. See also the -p command-line option.

このプロジェクト名の設定はオプションです。設定をしなければ、 ``COMPOSE_PROJECT_NAME`` （Composeのプロジェクト名）は、デフォルトではプロジェクトのディレクトリを ``ベース名`` にします。詳しくは :doc:`コマンドライン・オプション </compose/reference/overview>` ``-p`` をご覧ください。

.. COMPOSE_FILE

.. _compose-file:

COMPOSE_FILE
====================

.. Specify the file containing the compose configuration. If not provided, Compose looks for a file named docker-compose.yml in the current directory and then each parent directory in succession until a file by that name is found. See also the -f command-line option.

Compose 設定を含むファイルを指定します。指定しなければ、Compose は現在のディレクトリにある ``docker-compose.yml`` という名称のファイルを探します。あるいは、親ディレクトリにあれば、そちらを使います。詳しくは :doc:`コマンドライン・オプション </compose/reference/overview>` ``-f`` をご覧ください。

.. COMPOSE_API_VERSION

.. _compose-api-version:

COMPOSE_API_VERSION
====================

.. The Docker API only supports requests from clients which report a specific version. If you receive a client and server don't have same version error using docker-compose, you can workaround this error by setting this environment variable. Set the version value to match the server version.

Docker API は、明確なバージョンを報告するクライアントに対してのみ応答します。 ``docker-compose`` を使う時、 ``client and server don't have same version error`` というエラーが出る場合は、このエラーを回避するために環境変数を設定します。バージョンの値がサーバのバージョンと一致するように設定します。

.. Setting this variable is intended as a workaround for situations where you need to run temporarily with a mismatch between the client and server version. For example, if you can upgrade the client but need to wait to upgrade the server.

この変数を設定するのは、クライアントとサーバのバージョンが一致しない場合でも、一時的に回避してコマンドを実行したい場合です。たとえば、クライアントをアップグレードしていても、サーバのアップグレードまで待つ必要がある場合です。

.. Running with this variable set and a known mismatch does prevent some Docker features from working properly. The exact features that fail would depend on the Docker client and server versions. For this reason, running with this variable set is only intended as a workaround and it is not officially supported.

この環境変数を設定したら、いくつかの Docker の機能が正常に動作しない可能性があります。実際にどのような挙動になるかは、クライアントとサーバのバージョンによって変わります。そのため、この環境変数を設定するのは、あくまで回避策であって、公式にサポートされている手法ではありません。

.. If you run into problems running with this set, resolve the mismatch through upgrade and remove this setting to see if your problems resolve before notifying support.

もしこの環境変数を設定して何か問題が起きた場合は、サポートに解決策を訊ねる前に、バージョンの差違を解消した後、環境変数を削除してください。

.. DOCKER_HOST

.. _docker-host:

DOCKER_HOST
====================

.. Sets the URL of the docker daemon. As with the Docker client, defaults to unix:///var/run/docker.sock.

``docker`` デーモンの URL を設定します。Docker クライアントのデフォルトは ``unix:///var/run/docker.sock`` です。

DOCKER_TLS_VERIFY
====================

.. When set to anything other than an empty string, enables TLS communication with the docker daemon.

空白以外の何らかの値をセットしたら、 ``docker`` デーモンとの TLS 通信を有効化します。

DOCKER_CERT_PATH
====================

.. Configures the path to the ca.pem, cert.pem, and key.pem files used for TLS verification. Defaults to ~/.docker.

TLS 認証に使う ``ca.pem`` 、 ``cert.pem`` 、``key.pem``  ファイルのパスを設定します。デフォルトは ``~/.docker`` です。

COMPOSE_HTTP_TIMEOUT
====================

.. Configures the time (in seconds) a request to the Docker daemon is allowed to hang before Compose considers it failed. Defaults to 60 seconds.

Compose が Docker デーモンに対する処理が失敗（fail）したとみなす時間（秒単位）を設定します。デフォルトは 60 秒です。

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

