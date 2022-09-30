.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/compose_ps/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/compose_ps.md
.. check date: 2022/03/06
.. ------------------------------------------------------------------

.. docker compose ps

=======================================
docker compose ps
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _compose_ps-description:

説明
==========

.. List containers

コンテナを一覧表示します。

.. _compose_ps-usage:

使い方
==========

.. code-block:: bash

   $ docker compose ps [SERVICE...]

.. Extended description

.. _compose_ps-extended-description:

補足説明
==========

.. Lists containers for a Compose project, with current status and exposed ports.

Compose プロジェクト用のコンテナ一覧を、現在の状態とポートの公開状況と一緒に表示します。

.. code-block:: bash

   $ docker compose ps
   NAME                SERVICE             STATUS              PORTS
   example_foo_1       foo                 running (healthy)   0.0.0.0:8000->80/tcp
   example_bar_1       bar                 exited (1)

.. _compose_ps-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--all`` , ``-a``
     - 
     - 停止しているコンテナ全てを表示（run コマンドによって作成されたコンテナを含む）
   * - ``--filter``
     - 
     - 属性でサービスをフィルタ
   * - ``--format``
     - ``pretty``
     - 出力形式。値： [ ``pretty`` | ``json`` ]
   * - ``--quiet`` , ``-q``
     - 
     - ID のみ表示
   * - ``--services``
     - 
     - サービスを表示
   * - ``--status``
     - 
     - ステータスでサービスをフィルタ


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

   docker compose ps
      https://docs.docker.com/engine/reference/commandline/compose_ps/
