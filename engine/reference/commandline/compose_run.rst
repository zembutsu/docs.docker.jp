.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/compose_run/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/compose_run.md
.. check date: 2022/03/06
.. ------------------------------------------------------------------

.. docker compose run

=======================================
docker compose run
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _compose_run-description:

説明
==========

.. Run a one-off command on a service.

サービスを一度限りのコマンドとして実行します。

.. _compose_run-usage:

使い方
==========

.. code-block:: bash

   $ docker compose run [options] [-v VOLUME...] [-p PORT...] [-e KEY=VAL...] [-l KEY=VALUE...] SERVICE [COMMAND] [ARGS...]

.. Extended description

.. _compose_run-extended-description:

補足説明
==========

.. Runs a one-time command against a service.

サービスを一度限りのコマンド実行します。

.. the following command starts the web service and runs bash as its command:

以下のコマンドは、 ``web`` サービスを開始し、コマンドとしての ``bash`` を実行します。

.. code-block:: bash

   $ docker compose run web bash

.. Commands you use with run start in new containers with configuration defined by that of the service, including volumes, links, and other details. However, there are two important differences:

新しいコンテナ内で実行されるコマンドは、設定によって定義されたサービス、ボリューム、リンク、その他と共に起動します。しかしながら、2つの重要な点が異なります。

.. First, the command passed by run overrides the command defined in the service configuration. For example, if the web service configuration is started with bash, then docker compose run web python app.py overrides it with python app.py.

第1に、 ``run`` を指定すると、サービス設定で定義済みのコマンドを上書きします。たとえば、 ``web`` サービスの起動が ``bash`` に設定されていても、 ``docker compose run web python app.py`` によって ``python app.py`` に上書きされます。

.. The second difference is that the docker compose run command does not create any of the ports specified in the service configuration. This prevents port collisions with already-open ports. If you do want the service’s ports to be created and mapped to the host, specify the --service-ports

第2の違いは、 ``docker compose run`` コマンドではサービス設定で定義したポートを作成しません。これにより、既に開いているポートとの衝突を防ぎます。もしもサービス用のポートを作成し、ホストにマッピングしたければ、 ``--service-ports`` を指定します。

.. code-block:: bash

   $ docker compose run --service-ports web python manage.py shell

あるいは、docker run を使う時に ``--publish`` か ``-p`` オプションを指定し、手動でポートの割り当てもできます。

.. code-block:: bash

   $ docker compose run --publish 8080:80 -p 2022:22 -p 127.0.0.1:2021:21 web python manage.py shell

.. If you start a service configured with links, the run command first checks to see if the linked service is running and starts the service if it is stopped. Once all the linked services are running, the run executes the command you passed it. For example, you could run:

リンク設定があるサービスを起動する場合には、run 命令は、まずリンクしたサービスが実行中かどうかを確認し、サービスが停止中の場合は起動します。リンクしているサービスがすべて実行中になれば、指定したコマンドの処理を実行します。以下の例のように実行できます。

.. code-block:: bash

   $ docker compose run db psql -h db -U docker

.. This opens an interactive PostgreSQL shell for the linked db container.

これは、 ``db`` コンテナにリンクしているインタラクティブな PostgreSQL シェルを開きます。

.. If you do not want the run command to start linked containers, use the --no-deps flag:

リンクしたコンテナを開始せずに run 命令を実行したい場合は、 ``--no-deps`` フラグを使います。

.. code-block:: bash

   $ docker compose run --no-deps web python manage.py shell

.. If you want to remove the container after running while overriding the container’s restart policy, use the --rm flag:

コンテナの再起動ポリシーを上書きし、実行後にコンテナを削除したい場合は、 ``--rm`` フラグを使います。

.. code-block:: bash

   $ docker compose run --rm web python manage.py db upgrade

.. This runs a database upgrade script, and removes the container when finished running, even if a restart policy is specified in the service configuration.

サービス設定で再起動ポリシーが定義されていても、これはデータベース更新スクリプトを実行し、処理完了後にコンテナを削除します。

.. _compose_run-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--detach`` , ``-d``
     - 
     - コンテナをバックグランドで実行し、コンテナ ID を表示
   * - ``--entrypoint``
     - 
     - イメージの entrypoint を上書き
   * - ``--env`` , ``-e``
     - 
     - 環境変数を設定
   * - ``--labels`` , ``-l``
     - 
     - ラベルを追加もしくは上書き
   * - ``--name``
     - 
     - コンテナに名前を割り当て
   * - ``--no-TTY`` , ``-T``
     - 
     - 疑似 TTY の割当を無効化。デフォルトの docker compose run は TTY を割り当て
   * - ``--no-deps``
     - 
     - リンクしたサービスを起動しない
   * - ``--publish`` , ``-p``
     - 
     - ホスト上にコンテナのポートを公開
   * - ``--rm``
     - 
     - 終了時、対象のコンテナを自動削除
   * - ``--use-aliases``
     - 
     - コンテナが接続するネットワークに、サービスのネットワーク useAliases を使用
   * - ``--user`` , ``-u``
     - 
     - 指定したユーザ名や uid で実行
   * - ``--volume`` , ``-v``
     - 
     - ボリュームをバインド・マウントする
   * - ``--workdir`` , ``-w``
     - 
     - コンテナ内の作業ディレクトリ



親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI のベースコマンド。


.. Related commands

関連コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker compose biuld<compose_build>`
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

   docker compose run
      https://docs.docker.com/engine/reference/commandline/compose_run/
