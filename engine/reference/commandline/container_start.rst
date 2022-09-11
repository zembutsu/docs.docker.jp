.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/container_start/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/container_start.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_container_start.yaml
.. check date: 2022/03/13
.. Commits on Mar 23, 2018 cb157b3318eac0a652a629ea002778ca3d8fa703
.. -------------------------------------------------------------------

.. docker container start

=======================================
docker container start
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _container_start-description:

説明
==========

.. Start one or more stopped containers

1つまたは複数のコンテナを :ruby:`開始 <start>` します。

.. _container_start-usage:

使い方
==========

.. code-block:: bash

   $ docker container start [OPTIONS] CONTAINER [CONTAINER...]

.. _container_start-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--attach`` , ``-a``
     - 
     - 標準入力、標準出力、標準エラー出力にアタッチ
   * - ``--checkpoint``
     - 
     - 【experimental (daemon)】チェックポイントから修復
   * - ``--checkpoint-dir``
     - 
     - 【experimental (daemon)】任意のチェックポイント保存ディレクトリを使用
   * - ``--detach-keys``
     - 
     - コンテナをデタッチするキー手順を上書き
   * - ``--interactive`` , ``-i``
     - 
     - コンテナの標準入力にアタッチ



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

   docker container start
      https://docs.docker.com/engine/reference/commandline/container_start/
