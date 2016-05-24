.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/overview/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/reference/overview.md
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/reference/overview.md
.. check date: 2016/04/28
.. Commits on Mar 24, 2016 8282bb1b24cc0f51210ffd94a55edf8876bcb814
.. -------------------------------------------------------------------

.. Overview of docker-compose CLI

.. _overview-of-docker-compose-cli:

=======================================
docker-compose コマンド概要
=======================================

.. This page provides the usage information for the docker-compose Command. You can also see this information by running docker-compose --help from the command line.

このページは ``docker-compose`` コマンドの使い方に関する情報を提供します。この情報はコマンドライン上で ``docker-compose --help`` を使っても確認できます。

.. code-block:: bash

   Docker で使う複数コンテナ・アプリケーションの定義と実行
   
   使い方:
     docker-compose [-f=<引数>...] [オプション] [コマンド] [引数...]
     docker-compose -h|--help
   
   オプション:
     -f, --file FILE             別の compose ファイルを指定 (デフォルト: docker-compose.yml)
     -p, --project-name NAME     別のプロジェクト名を指定 (デフォルト: directory name)
     --verbose                   詳細情報を表示
     -v, --version               バージョンを表示して終了
     -H, --host HOST             接続先のデーモン・ソケット
   
     --tls                       TLS を使う;--tlsverify の指定も含む
     --tlscacert CA_PATH         この CA で署名した証明書のみ信頼
     --tlscert CLIENT_CERT_PATH  TLS 証明書ファイルへのパス
     --tlskey TLS_KEY_PATH       TLS 鍵ファイルへのパス
     --tlsverify                 TLS を使いリモートを認証
     --skip-hostname-check       クライアントの証明書で指定されたデーモンのホスト名を確認しない。
                                 （たとえば、docker ホストが IP アドレスの場合）
   
   コマンド:
     build              サービスの構築または再構築
     config             compose ファイルの確認と表示
     create             サービスの作成
     down               コンテナ・ネットワーク・イメージ・ボリュームの停止と削除
     events             コンテナからリアルタイムにイベントを受信
     help               コマンド上でヘルプを表示
     kill               コンテナを kill (強制停止)
     logs               コンテナの出力を表示
     pause              サービスを一時停止
     port               ポートに割り当てる公開用ポートを表示
     ps                 コンテナ一覧
     pull               サービス用イメージの取得
     restart            サービスの再起動
     rm                 停止中のコンテナを削除
     run                １度だけコマンドを実行
     scale              サービス用コンテナの数を指定
     start              サービスの開始
     stop               サービスの停止
     unpause            サービスの再開
     up                 コンテナの作成と開始
     version            Docker Compose のバージョン情報を表示

.. The Docker Compose binary. You use this command to build and manage multiple services in Docker containers.

``docker-compose`` は Docker Compose のバイナリです。このコマンドを使い Docker コンテナ上の複数のサービスを管理します。

.. Use the -f flag to specify the location of a Compose configuration file. You can supply multiple -f configuration files. When you supply multiple files, Compose combines them into a single configuration. Compose builds the configuration in the order you supply the files. Subsequent files override and add to their successors.

Compose 設定ファイルの場所を指定するには、 ``-f`` フラグを使います。複数の ``-f`` 設定ファイルを指定できます。複数のファイルをシチエしたら、Compose は１つの設定ファイルに連結します。Compose はファイルを指定した順番で構築します。後に続くファイルは、既に実行したものを上書き・追加します。

.. For example, consider this command line:

たとえば、次のようなコマンドラインを考えます。

.. code-block:: bash

   $ docker-compose -f docker-compose.yml -f docker-compose.admin.yml run backup_db`

.. The docker-compose.yml file might specify a webapp service.

``docker-compose.yml`` ファイルは ``webapp`` サービスを指定しています。

.. code-block:: yaml

   webapp:
     image: examples/web
     ports:
       - "8000:8000"
     volumes:
       - "/data"

.. If the docker-compose.admin.yml also specifies this same service, any matching fields will override the previous file. New values, add to the webapp service configuration.

また、 ``docker-compose.admin.yml`` ファイルで同じサービスを指定したら、以前のファイルで指定した同じフィールドの項目があれば、それを上書きします。新しい値があれば、 ``webapp`` サービスの設定に追加します。

.. code-block:: yaml

   webapp:
     build: .
     environment:
       - DEBUG=1

.. Use a -f with - (dash) as the filename to read the configuration from stdin. When stdin is used all paths in the configuration are relative to the current working directory.

``-f`` に ``-`` （ダッシュ）をファイル名として指定したら、標準入力から設定を読み込みます。設定に標準入力を使う場合のパスは、現在の作業用ディレクトリからの相対パスとなります。

.. The -f flag is optional. If you don’t provide this flag on the command line, Compose traverses the working directory and its subdirectories looking for a docker-compose.yml and a docker-compose.override.yml file. You must supply at least the docker-compose.yml file. If both files are present, Compose combines the two files into a single configuration. The configuration in the docker-compose.override.yml file is applied over and in addition to the values in the docker-compose.yml file.

``-f`` フラグはオプションです。コマンドラインでこのフラグを指定しなければ、Compose は現在の作業用ディレクトリと ``docker-compose.yml`` ファイルと ``docker-compose.override.yml`` ファイルのサブディレクトリを探します。もし、２つのファイルを指定したら、１つの設定ファイルに連結します。 この時、 ``docker-compose.yml`` ファイルにある値は、 ``docker-compose.override.yml`` ファイルで設定し値で上書きします。

.. See also the COMPOSE_FILE environment variable.

詳しくは ``COMPOSE`` :ref:`環境変数 <compose-file>` をご覧ください。

.. Each configuration has a project name. If you supply a -p flag, you can specify a project name. If you don’t specify the flag, Compose uses the current directory name. See also the COMPOSE_PROJECT_NAME environment variable

各設定ファイルはプロジェクト名を持っています。 ``-p`` フラグでプロジェクト名を指定できます。フラグを指定しなければ、Compose は現在のディレクトリの名前を使います。詳細は ``COMPOSE_PROJECT`` :ref:`環境変数 <compose-project-name>` をご覧ください。

.. Where to go next

次はどこへ
==========

..    CLI environment variables
    Command line reference

* :doc:`CLI 環境変数 </compose/reference/envvars>`

.. seealso:: 

   Overview of docker-compose CLI
      https://docs.docker.com/compose/reference/overview/
