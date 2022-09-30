.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/compose/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/compose.md
.. check date: 2022/03/06
.. -------------------------------------------------------------------

.. docker compose

=======================================
docker compose
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

説明
==========

.. Docker Compose

Docker Compose です。

使い方
==========

.. code-block:: bash

   $ docker compose COMMAND

.. Extended description

補足説明
==========

.. You can use compose subcommand, docker compose [-f <arg>...] [options] [COMMAND] [ARGS...], to build and manage multiple services in Docker containers.

Docker コンテナ内で複数のサービスを構築・管理するため、compose サブコマンドを ``docker compose [-f <arg>...] [options] [COMMAND] [ARGS...]`` ように使えます。

.. Use -f to specify name and path of one or more Compose files

.. _use--f-to-specify-name-and-path-of-one-or-more-compose-files:

``-f`` で Compose ファイルの名前やパスを指定
--------------------------------------------------

.. Use the -f flag to specify the location of a Compose configuration file.

``-f`` フラグを使い、Compose 設定ファイルの場所を指定します。

.. Specifying multiple Compose files

.. _specifying-multiple-compose-files:

複数の Compose ファイルを指定
------------------------------

.. You can supply multiple -f configuration files. When you supply multiple files, Compose combines them into a single configuration. Compose builds the configuration in the order you supply the files. Subsequent files override and add to their predecessors.

複数の ``-f`` 設定ファイルを追加指定できます。複数のファイルを指定すると、 Compose が1つの設定の中にそれらを統合します。指定したファイル順の設定で、 Compose が構築します。後続のファイルは、事前の処理を上書き・追加します。

.. For example, consider this command line:

たとえば、このコマンド行を見てみます。

.. code-block:: bash

   $ docker compose -f docker-compose.yml -f docker-compose.admin.yml run backup_db

.. The docker-compose.yml file might specify a webapp service.

``docker-compose.yaml`` ファイルは、 ``webapp`` サービスを指定しようとします。

.. code-block:: yaml

   services:
     webapp:
       image: examples/web
       ports:
         - "8000:8000"
       volumes:
         - "/data"

.. If the docker-compose.admin.yml also specifies this same service, any matching fields override the previous file. New values, add to the webapp service configuration.

もしも ``docker-compose.admin.yml`` でも同じ名前のサービスを定義すると、以前のファイルで定義されていた同じ名前のフィールドは、すべて上書きされます。

.. code-block:: yaml

   services:
     webapp:
       build: .
       environment:
         - DEBUG=1

.. When you use multiple Compose files, all paths in the files are relative to the first configuration file specified with -f. You can use the --project-directory option to override this base path.

複数の Compose ファイルを使う場合、全てのパスは、 ``-f`` で指定した1番目の設定ファイルからの相対パスになります。この基準となるパスは、 ``--project-directory`` オプションを使って上書きできます。

.. Use a -f with - (dash) as the filename to read the configuration from stdin. When stdin is used all paths in the configuration are relative to the current working directory.

``-f`` にファイル名の代わりに ``-`` （ダッシュ）を使うと、標準入力から設定を読み込みます。標準入力からの設定に含まれる全てのパスは、現在の作業ディレクトリからの相対パスです。

.. The -f flag is optional. If you don’t provide this flag on the command line, Compose traverses the working directory and its parent directories looking for a compose.yaml or docker-compose.yaml file.

``-`` フラグはオプションです。このフラグをコマンドライン上で使わなければ、 Compose は作業ティレクトリと親ディレクトリを行き来し、 ``compose.yaml`` や ``docker-compose.yaml`` ファイルを探します。

.. Specifying a path to a single Compose file

.. _specifying-a-path-to-a-single-compose-file:

Commpose ファイルのパスを指定
------------------------------

``-f`` フラグを使い、Compose ファイルのパスを指定できます。このファイルのパスとは、現在のディレクトリに存在していなくても、コマンドラインでパスを指定するか、あるいはシェル上の ``COMPOSE_FILE`` 環境変数 もしくは environment ファイル内で指定できます。

.. You can use the -f flag to specify a path to a Compose file that is not located in the current directory, either from the command line or by setting up a COMPOSE_FILE environment variable in your shell or in an environment file.

コマンドライン上で ``-f`` オプションを使う例として、Compose で Rails サンプルの実行を想定します。そして、 ``sandbox/rials`` ディレクトリに ``compose.yaml`` ファイルがあるとします。 ``docker compose pull`` のようなコマンドを使うとき、次のように ``-f`` フラグを使うと、あらゆる場所から db サービスに対する postgres イメージを取得できます。

.. For an example of using the -f option at the command line, suppose you are running the Compose Rails sample, and have a compose.yaml file in a directory called sandbox/rails. You can use a command like docker compose pull to get the postgres image for the db service from anywhere by using the -f flag as follows:

.. code-block:: bash

   $ docker compose -f ~/sandbox/rails/compose.yaml pull db

.. Use -p to specify a project name

.. _use--p-to-specify-a-project-name:

プロジェクト名を ``-p`` を使い指定
----------------------------------------

.. Each configuration has a project name. If you supply a -p flag, you can specify a project name. If you don’t specify the flag, Compose uses the current directory name. Project name can also be set by COMPOSE_PROJECT_NAME environment variable.

各設定ファイルはプロジェクト名を持ちます。 ``-p`` フラグを指定すると、プロジェクト名を指定できます。このフラグを指定しなければ、 Compose は現在のディレクトリ名をプロジェクト名として使います。プロジェクト名は ``COMPOSE_PROJECT_NAME`` 環境変数でも指定できます。

.. Most compose subcommand can be ran without a compose file, just passing project name to retrieve the relevant resources.

大部分の compose サブコマンドは、 compose ファイル無しでは実行できません。ですが、適切なリソースから情報を取得する場合は、プロジェクト名を渡すだけです。

.. code-block:: bash

   $ docker compose -p my_project ps -a
   NAME                 SERVICE    STATUS     PORTS
   my_project_demo_1    demo       running
   
   $ docker compose -p my_project logs
   demo_1  | PING localhost (127.0.0.1): 56 data bytes
   demo_1  | 64 bytes from 127.0.0.1: seq=0 ttl=64 time=0.095 ms

.. Use profiles to enable optional services
.. _use-profiles-to-enable-optional-services:

profile でオプションのサービスを有効化
----------------------------------------

.. Use --profile to specify one or more active profiles Calling docker compose --profile frontend up will start the services with the profile frontend and services without any specified profiles. You can also enable multiple profiles, e.g. with docker compose --profile frontend --profile debug up the profiles frontend and debug will be enabled.

``--profile`` を使い、1つまたは複数のアクティブなプロファイルを指定できます。 ``docker compose --profile frontend up`` を実行すると、 プロファイル ``frontend`` のサービスと、プロファイルを指定していないサービスを開始します。また、複数のプロファイルも指定できます。 ``docker compose --profile frontend --profile debug up`` であれば、 ``frontend`` と ``debug`` が有効になります。

.. Profiles can also be set by COMPOSE_PROFILES environment variable.

プロファイルは ``COMPOSE_PROFILES`` 環境変数でも指定できます。

.. Set up environment variables

.. _set-up-environment-variables:

環境変数でセットアップ
------------------------------

.. You can set environment variables for various docker compose options, including the -f, -p and --profiles flags.

``-f`` 、 ``-p`` 、 ``--profiles`` フラグを含む、様々な docker  compose オプションを環境変数で指定できます。

.. Setting the COMPOSE_FILE environment variable is equivalent to passing the -f flag, COMPOSE_PROJECT_NAME environment variable does the same for to the -p flag, and so does COMPOSE_PROFILES environment variable for to the --profiles flag.

``COMPOSE_FILE`` 環境変数の設定は、 ``-f``` フラグを渡すのと同じです。 ``COMPOSE_PROJECT_NAME`` 環境変数は、 ``-p`` フラグを渡すのと同じです。さらに ``COMPOSE_PROFILES`` 環境変数は、 ``--profiles`` フラグを渡すのと同じです。

.. If flags are explicitly set on command line, associated environment variable is ignored

フラグが明示的に指定される場合は、関連する環境変数は無視されます。

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--ansi``
     - ``auto``
     - ANSI 制御文字の表示を制御（ ``never`` | ``always`` | ``auto`` ）
   * - ``--env-file``
     - 
     - 別の環境設定ファイルを指定
   * - ``--file`` , ``-f``
     - 
     - Compose 設定ファイル
   * - ``--no-ansi``
     - 
     - ANSI 制御文字を表示しません（非推奨）
   * - ``--profile``
     - 
     - 有効にするプロファイルを指定
   * - ``--project-directory``
     - 
     - 別の作業ディレクトリを指定（デフォルト：Compose ファイルが存在するパス）
   * - ``--project-name`` , ``-p``
     - 
     - プロジェクト名
   * - ``--verbose``
     - 
     - 詳細な出力
   * - ``--workdir``
     - 
     - 非推奨！ かわりに --project-directory を使う。別の作業ディレクトリを指定（デフォルト：Compose ファイルが存在するパス）


親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI のベースコマンド。


.. Child commands

子コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker compose build<compose_build>`
     - サービスの構築もしくは再構築
   * - :doc:`docker compose convert<compose_convert>`
     - compose ファイルをプラットフォーム固有の形式に変換
   * - :doc:`docker compose cp<compose_cp>`
     - サービス・コンテナとローカル・ファイルシステム間でファイルやフォルダをコピー
   * - :doc:`docker compose create<compose_create>`
     - サービス用のコンテナを作成
   * - :doc:`docker compose down<compose_down>`
     - コンテナやネットワークの停止と削除
   * - :doc:`docker compose events<compose_events>`
     - コンテナからリアルタイムにイベントを受信
   * - :doc:`docker compose exec<compose_exec>`
     - 実行中のコンテナ内でコマンドを実行
   * - :doc:`docker compose images<compose_images>`
     - 作成したコンテナが使っているイメージを一覧表示
   * - :doc:`docker compose kill<compose_kill>`
     - サービスコンテナを強制停止
   * - :doc:`docker compose logs<compose_logs>`
     - コンテナからの出力を表示
   * - :doc:`docker compose ls<compose_ls>`
     - 実行中の compose プロジェクトを一覧表示
   * - :doc:`docker compose pause<compose_pause>`
     - サービスの一時停止
   * - :doc:`docker compose port<compose_port>`
     - ポートを確保している公開ポートを表示
   * - :doc:`docker compose ps<compose_ps>`
     - コンテナを一覧表示
   * - :doc:`docker compose pull<compose_pull>`
     - サービスのイメージを取得
   * - :doc:`docker compose push<compose_push>`
     - サービスのイメージを送信
   * - :doc:`docker compose restart<compose_restart>`
     - コンテナの再起動
   * - :doc:`docker compose rm<compose_rm>`
     - 停止済みのサービス・コンテナを削除
   * - :doc:`docker compose run<compose_run>`
     - サービスを一度限りのコマンドとして実行
   * - :doc:`docker compose start<compose_start>`
     - サービスの開始
   * - :doc:`docker compose stop<compose_stop>`
     - サービスの停止
   * - :doc:`docker compose top<compose_top>`
     - 実行中のプロセスを表示
   * - :doc:`docker compose unpause<compose_unpause>`
     - サービスの一時停止を解除
   * - :doc:`docker compose up<compose_up>`
     - コンテナの作成と開始


.. seealso:: 

   docker compose
      https://docs.docker.com/engine/reference/commandline/compose/
