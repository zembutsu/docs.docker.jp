.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/compose_up/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/compose_up.md
.. check date: 2022/03/06
.. ------------------------------------------------------------------

.. docker compose up

=======================================
docker compose up
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _compose_up-description:

説明
==========

.. Create and start contianers

コンテナを作成し、開始します。

.. _compose_up-usage:

使い方
==========

.. code-block:: bash

   $ docker compose up [SERVICE...]

.. Extended description

.. _compose_up-extended-description:

補足説明
==========

.. Builds, (re)creates, starts, and attaches to containers for a service.

サービス用のコンテナを構築、（再）作成、開始、アタッチします。

.. Unless they are already running, this command also starts any linked services.

このサービスにリンクしているサービスが実行中でなければ、それらも開始します。

.. The docker compose up command aggregates the output of each container (liked docker compose logs --follow does). When the command exits, all containers are stopped. Running docker compose up --detach starts the containers in the background and leaves them running.

``docker compose up`` コマンドは各コンテナの出力を統合します（ ``docker compose logs --follow`` のような挙動 ）。コマンドが終了すると、全てのコンテナが停止します。 ``docker compose up --detach`` でコンテナを開始すると、バックグラウンドで動作し、離れても実行し続けます。

.. If there are existing containers for a service, and the service’s configuration or image was changed after the container’s creation, docker compose up picks up the changes by stopping and recreating the containers (preserving mounted volumes). To prevent Compose from picking up changes, use the --no-recreate flag.

サービスに対するコンテナが存在し、コンテナの作成後にサービス設定やイメージが変更された場合は、 ``docker compose up`` の実行によって対象コンテナの停止と再作成が行われます（マウントしているボリュームは保持します）。変更が Compose に適用されるのを防ぐには、 ``--no-recreate`` フラグを使います。

.. If you want to force Compose to stop and recreate all containers, use the --force-recreate flag.

Compose で強制的に停止と再起動をしたい場合は、 ``--force-recreate`` フラグを使います。

.. If the process encounters an error, the exit code for this command is 1. If the process is interrupted using SIGINT (ctrl + C) or SIGTERM, the containers are stopped, and the exit code is 0.

プロセスでエラーが発生した場合、このコマンドの終了コードは ``1`` になります。もしもプロセスが ``SIGINT`` （ctrl + C） や ``SIGTERM`` で中断した場合、コンテナは停止させられ、終了コードは ``0`` になります。

.. _compose_up-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--abort-on-container-exit``
     - 
     - コンテナが1つ停止した場合、全てのコンテナを指定。-d とは両立しない
   * - ``--always-recreate-deps``
     - 
     - 依存関係のあるコンテナを再作成。 --no-recreate とは両立しない
   * - ``--attach``
     - 
     - サービスの出力にアタッチする
   * - ``--attach-dependencies``
     - 
     - 依存関係のあるコンテナにアタッチする
   * - ``--build``
     - 
     - コンテナの開始前にイメージを構築
   * - ``--detach`` , ``-d``
     - 
     - デタッチド・モード：バックグラウンドでコンテナを実行
   * - ``--environment`` , ``-e``
     - 
     - 環境変数
   * - ``--exit-code-from``
     - 
     - 選択したサービス・コンテナの終了コードを返す。 --abort-on-container-exit を意味する
   * - ``--force-recreate``
     - 
     - コンテナのサービスやイメージに変更が無くても、コンテナを再作成する
   * - ``--no-build``
     - 
     - イメージが存在しなくても、イメージを構築しない
   * - ``--no-color``
     - 
     - 白黒の出力にする
   * - ``--no-deps``
     - 
     - リンクしたサービスを起動しない
   * - ``--no-log-prefix``
     - 
     - ログの行頭を表示しない
   * - ``--no-recreate``
     - 
     - コンテナが既に存在している場合、再作成しない。 --force-recreate と両立しない
   * - ``--no-start``
     - 
     - サービスを作成しても起動しない
   * - ``--quiet-pull``
     - 
     - 進捗情報を表示せずに取得
   * - ``--remove-orphans``
     - 
     - Compose ファイルで定義されていないサービス用コンテナを削除
   * - ``-renew-anon-volumes-`` , ``-v``
     - 
     - 以前に作成したコンテナからデータを受け取らず、匿名ボリュームを再作成する
   * - ``--scale``
     - 
     - サービスをスケールするインスタンス数。Compose ファイルに ``scale`` 設定があれば上書きする
   * - ``--timeout`` , ``-t``
     - ``10``
     - 停止（シャットダウン）のタイムアウト秒を指定


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

   docker compose up
      https://docs.docker.com/engine/reference/commandline/compose_up/
