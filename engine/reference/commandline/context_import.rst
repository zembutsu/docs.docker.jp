.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/context_import/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/context_import.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_context_import.yaml
.. check date: 2022/03/18
.. Commits on Aug 22, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker context import

=======================================
docker context import
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _context_import-description:

説明
==========

.. Import a context from a tar or zip file

tar もしくは zip ファイルから context を読み込みます。

.. _context_import-usage:

使い方
==========

.. code-block:: bash

   $ docker context import CONTEXT FILE|-

.. Extended description
.. _context_import-extended-description:

補足説明
==========

.. Imports a context previously exported with docker context export. To import from stdin, use a hyphen (-) as filename.

``docker context export`` で以前に :ruby:`出力済み <export>` の context を :ruby:`読み込み <import>` ます。標準入力から読み込むには、ファイル名としてハイフン（ ``-`` ）を使います。

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

   docker context import
      https://docs.docker.com/engine/reference/commandline/context_import/
