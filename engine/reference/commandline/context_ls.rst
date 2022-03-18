.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/context_ls/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/context_ls.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_context_ls.yaml
.. check date: 2022/03/18
.. Commits on Aug 22, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker context ls

=======================================
docker context ls
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _context_ls-description:

説明
==========

.. List context

context 一覧を表示します。

.. _context_ls-usage:

使い方
==========

.. code-block:: bash

   $ docker context ls [OPTIONS]

.. Extended description
.. _context_ls-extended-description:

補足説明
==========

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <content_ls-examples>` をご覧ください。


.. _context_ls-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--format`` , ``-f``
     - 
     - 指定した Go テンプレートを使って出力を整形
   * - ``--quiet`` , ``-q``
     - 
     - context 名のみ表示


.. _context_ls-examples:

使用例
==========

.. Use docker context ls to print all contexts. The currently active context is indicated with an *:

``docker context ls`` を使うと、全ての context を表示します。現在アクティブ（有効）な contect には ``*`` が表示されます。

.. code-block:: bash

   $ docker context ls
   NAME                DESCRIPTION                               DOCKER ENDPOINT                      KUBERNETES ENDPOINT   ORCHESTRATOR
   default *           Current DOCKER_HOST based configuration   unix:///var/run/docker.sock                                swarm
   production                                                    tcp:///prod.corp.example.com:2376
   staging                                                       tcp:///stage.corp.example.com:2376

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

   docker context ls
      https://docs.docker.com/engine/reference/commandline/context_ls/
