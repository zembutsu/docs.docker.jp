.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/container_logs/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/container_logs.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_container_logs.yaml
.. check date: 2022/03/18
.. Commits on Mar 23, 2018 cb157b3318eac0a652a629ea002778ca3d8fa703
.. -------------------------------------------------------------------

.. docker container logs

=======================================
docker container logs
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _container_logs-description:

説明
==========

.. Fetch the logs of a container

コンテナのログを取得します。

.. _container_logs-usage:

使い方
==========

.. code-block:: bash

   $ docker container logs [OPTIONS] CONTAINER

.. _container_logs-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--details``
     -
     - ログが追加で提供している詳細を表示
   * - ``--follow`` , ''-f''
     -
     - ログを出力をし続ける
   * - ``--since``
     -
     - タイムスタンプ（(例： 2013-01-02T13:23:37Z）または相対値（例：42m は 42 分）で指定した時間以降のログを表示 
   * - ``--tail`` , ``-n``
     - ``all``
     - ログの最後から表示する行数を指定
   * - ``--timestamps`` , ``-t``
     -
     - タイムスタンプを表示 
   * - ``--until``
     -
     - 【API 1.35+】タイムスタンプ（(例： 2013-01-02T13:23:37Z）または相対値（例：42m は 42 分）で指定した時間までのログを表示

.. Parent command

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
====================

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker container attach<container_attach>`
     - ローカルの標準入出、標準出力、標準エラーのストリームに、実行中のコンテナを :ruby:`接続 <attach>`
   * - :doc:`docker container commit<container_commit>`
     - コンテナの変更から新しいイメージを作成
   * - :doc:`docker container cp<container_cp>`
     - コンテナとローカルファイルシステム間で、ファイルやフォルダを :ruby:`コピー <copy>`
   * - :doc:`docker container create<container_create>`
     - 新しいコンテナを :ruby:`作成 <create>`
   * - :doc:`docker container diff<container_diff>`
     - コンテナのファイルシステム上で、ファイルやディレクトリの変更を調査
   * - :doc:`docker container exec<container_exec>`
     - 実行中のコンテナ内でコマンドを実行
   * - :doc:`docker container export<container_export>`
     - コンテナのファイルシステムを tar アーカイブとして :ruby:`出力 <export>`
   * - :doc:`docker container inspect<container_inspect>`
     - 1つまたは複数コンテナの情報を表示
   * - :doc:`docker container kill<container_kill>`
     - 1つまたは複数の実行中コンテナを :ruby:`強制停止 <kill>`
   * - :doc:`docker container logs<container_logs>`
     - コンテナのログを取得
   * - :doc:`docker container ls<container_ls>`
     - コンテナ一覧
   * - :doc:`docker container pause<container_pause>`
     - 1つまたは複数コンテナ内の全てのプロセスを :ruby:`一時停止 <pause>`
   * - :doc:`docker container port<container_port>`
     - ポート :ruby:`割り当て <mapping>` の一覧か、特定のコンテナに対する :ruby:`割り当て <mapping>`
   * - :doc:`docker container prune<container_prune>`
     - すべての停止中のコンテナを削除
   * - :doc:`docker container rename<container_rename>`
     - コンテナの :ruby:`名前変更 <rename>`
   * - :doc:`docker container restart<container_restart>`
     - 1つまたは複数のコンテナを再起動
   * - :doc:`docker container rm<container_rm>`
     - 1つまたは複数のコンテナを :ruby:`削除 <remove>`
   * - :doc:`docker container run<container_run>`
     - 新しいコンテナでコマンドを :ruby:`実行 <run>`
   * - :doc:`docker container start<container_start>`
     - 1つまたは複数のコンテナを :ruby:`開始 <start>`
   * - :doc:`docker container stats<container_stats>`
     - コンテナのリソース使用統計情報をライブストリームで表示
   * - :doc:`docker container stop<container_stop>`
     - 1つまたは複数の実行中コンテナを :ruby:`停止 <stop>`
   * - :doc:`docker container top<container_top>`
     - コンテナで実行中のプロセスを表示
   * - :doc:`docker container unpause<container_unpause>`
     - 1つまたは複数コンテナの :ruby:`一時停止を解除 <unpause>`
   * - :doc:`docker container update<container_update>`
     - 1つまたは複数コンテナの設定を :ruby:`更新 <update>`
   * - :doc:`docker container wait<container_wait>`
     - 1つまたは複数コンテナが停止するまでブロックし、終了コードを表示

.. seealso:: 

   docker container logs
      https://docs.docker.com/engine/reference/commandline/container_logs/
