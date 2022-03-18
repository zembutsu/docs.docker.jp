.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/context/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/context.md
.. check date: 2022/03/18
.. -------------------------------------------------------------------

.. docker context

=======================================
docker context
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

説明
==========

.. Manage contexts

context を管理

使い方
==========

.. code-block:: bash

   $ docker context COMMAND


.. Parent command

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
   * - :doc:`docker context create<context_create>`
     - context を作成
   * - :doc:`docker context export<context_export>`
     - context を tar もしくは kubeconfig ファイルに出力
   * - :doc:`docker context import<context_import>`
     - tar もしくは zip ファイルから context を読み込み
   * - :doc:`docker context inspect<context_inspect>`
     - 1つまたは複数 context の情報を表示
   * - :doc:`docker context ls<context_ls>`
     - context 一覧表示
   * - :doc:`docker context rm<context_rm>`
     - 1つまたは複数 context を削除
   * - :doc:`docker context update<context_update>`
     - context の更新
   * - :doc:`docker context use<context_use>`
     - 現在の docker context を指定


.. seealso:: 

   docker context
      https://docs.docker.com/engine/reference/commandline/context/
