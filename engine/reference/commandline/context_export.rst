.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/context_export/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/context_export.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_context_export.yaml
.. check date: 2022/03/18
.. Commits on Aug 22, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker context export

=======================================
docker context export
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _context_export-description:

説明
==========

.. Export a context to a tar or kubeconfig file

context を tar もしくは kubeconfig ファイルに出力します。

.. _context_export-usage:

使い方
==========

.. code-block:: bash

   $ docker context export [OPTIONS] CONTEXT [FILE|-]

.. Extended description
.. _context_export-extended-description:

補足説明
==========

.. Exports a context in a file that can then be used with docker context import (or with kubectl if --kubeconfig is set). Default output filename is <CONTEXT>.dockercontext, or <CONTEXT>.kubeconfig if --kubeconfig is set. To export to STDOUT, you can run docker context export my-context -.

context をファイルに書き出すには、 ``docker context import`` を使います（ ``--kubeconfig`` を指定した場合、 ``kubectl`` も使います）。デフォルトの出力ファイル名は ``<CONTEXT>.dockercontext,`` か、 ``--kubeconfig`` を指定した場合は ``<CONTEXT>.kubeconfig`` です。 ``docker context export my-context -`` を実行すると、 ``STDOUT`` に出力できます。

.. _context_export-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--kubernetes``
     - 
     - 【:doc:`deprecated </engine/replicated>`】【kubernetes】kubernetes エンドポイントを指定


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

   docker context export
      https://docs.docker.com/engine/reference/commandline/context_export/
