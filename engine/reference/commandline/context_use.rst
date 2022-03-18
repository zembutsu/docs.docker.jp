.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/context_use/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/context_use.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_context_use.yaml
.. check date: 2022/03/18
.. Commits on Aug 22, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker context use

=======================================
docker context use
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _context_use-description:

説明
==========

.. Set the current docker context

現在の docker context を指定します。

.. _context_use-usage:

使い方
==========

.. code-block:: bash

   $ docker context use CONTEXT

.. Extended description
.. _context_use-extended-description:

補足説明
==========

.. Set the default context to use, when DOCKER_HOST, DOCKER_CONTEXT environment variables and --host, --context global options are not set. To disable usage of contexts, you can use the special default context.

デフォルトの context が使われるのは、 ``DOCKER_HOST`` および ``DOCKER_CONTENT`` の各環境変数と、 ``--host`` および ``--context`` グローバル・オプションが指定されない場合です。context の使用を無効化すると、特別な ``default`` コンテントが使用できます。


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

   docker context use
      https://docs.docker.com/engine/reference/commandline/context_use/
