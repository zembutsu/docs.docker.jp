.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/context_update/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/context_update.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_context_update.yaml
.. check date: 2022/03/18
.. Commits on Aug 22, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker context update

=======================================
docker context update
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _context_update-description:

説明
==========

.. Update a context

context を更新します。

.. _context_update-usage:

使い方
==========

.. code-block:: bash

   $ docker context update [OPTIONS] CONTEXT

.. Extended description
.. _context_update-extended-description:

補足説明
==========

.. Updates an existing context. See context create.

既存の ``context`` を更新します。 :doc:`context create <context_create>` をご覧ください。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <context_create-examples>` をご覧ください。

.. _context_update-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--default-stack-orchestrator``
     - 
     - 【:doc:`deprecated </engine/replicated>`】スタックを操作するデフォルトのオーケストレータとして、この context を使う（ swarm | kubernetes | all ）
   * - ``--description``
     - 
     - context の説明
   * - ``--docker``
     - 
     - docker エンドポイントを指定
   * - ``--from``
     - 
     - :ruby:`名前付き <named>` context から context を作成
   * - ``--kubernetes``
     - 
     - 【:doc:`deprecated </engine/replicated>`】【kubernetes】kubernetes エンドポイントを指定


.. _context_update-examples:

使用例
==========

.. Update an existing context
.. _update-an-existing-context:

既存の context を更新
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: bash

   $ docker context update \
       --description "some description" \
       --docker "host=tcp://myserver:2376,ca=~/ca-file,cert=~/cert-file,key=~/key-file" \
       my-context

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

   docker context update
      https://docs.docker.com/engine/reference/commandline/context_update/
