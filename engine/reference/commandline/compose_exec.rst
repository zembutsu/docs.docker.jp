.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/compose_exec/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/compose_exec.md
.. check date: 2022/03/06
.. -------------------------------------------------------------------

.. docker compose exec

=======================================
docker compose exec
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _compose_exec-description:

説明
==========

.. Execute a command in a running container.

実行中のコンテナ内でコマンドを実行します。

.. _compose_exec-usage:

使い方
==========

.. code-block:: bash

   $ docker compose exec [options] [-e KEY=VAL...] [--] SERVICE COMMAND [ARGS...]

.. Extended description

.. _compose_exec-extended-description:

補足説明
==========

.. This is the equivalent of docker exec targeting a Compose service.

Compose サービスを対象にする ``docker exec`` を実行するのと同じです。

.. With this subcommand you can run arbitrary commands in your services. Commands are by default allocating a TTY, so you can use a command such as docker compose exec web sh to get an interactive prompt.

このサブコマンドにより、サービスに対して任意のコマンドを実行できます。デフォルトでは、コマンドは TTY に割り当てられますので、 ``docker compose exec web sh`` のようなコマンドでは、双方向のプロンプトを扱えます。

.. _compose_exec-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--detach`` , ``-d``
     - 
     - :ruby:`デタッチド・モード <detached mode>` ：バックグラウンドでコマンドを実行
   * - ``--env`` , ``-e``
     - 
     - 環境変数を指定
   * - ``--index``
     - ``1``
     - サービスにインスタンスが複数ある場合の、コンテナのインデックス（デフォルト： 1 ）
   * - ``--no-TTY`` , ``-T``
     - 
     - :ruby:`疑似 TTY <pseudo-TTY>` 割り当てを無効化。デフォルトは ``docker compose exec`` に TTY を割り当て
   * - ``--privileged``
     - 
     - 対象プロセスに対して拡張特権をあたえる
   * - ``--user`` , ``-u``
     - 
     - 指定ユーザとしてコマンドを実行
   * - ``--workdir`` , ``-w``
     - 
     - このコマンドを実行する作業ディレクトリのパス


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

   docker compose exec
      https://docs.docker.com/engine/reference/commandline/compose_exec/
