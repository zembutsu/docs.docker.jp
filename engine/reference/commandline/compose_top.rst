.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/compose_top/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/compose_top.md
.. check date: 2022/03/06
.. ------------------------------------------------------------------

.. docker compose top

=======================================
docker compose top
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _compose_top-description:

説明
==========

.. Display the running proesses

実行中のプロセスを表示します。

.. _compose_top-usage:

使い方
==========

.. code-block:: bash

   $ docker compose top [SERVICE...]

.. Extended description

.. _compose_top-extended-description:

補足説明
==========

.. Displays the running processes.

実行中のプロセスを表示します。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <compose_top-examples>` をご覧ください。

.. _compose_top-examples:

使用例
==========

.. code-block:: bash

   $ docker compose top
   example_foo_1
   UID    PID      PPID     C    STIME   TTY   TIME       CMD
   root   142353   142331   2    15:33   ?     00:00:00   ping localhost -c 5


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

   docker compose top
      https://docs.docker.com/engine/reference/commandline/compose_top/
