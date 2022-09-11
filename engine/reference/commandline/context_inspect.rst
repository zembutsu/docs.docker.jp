.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/context_inspect/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/context_inspect.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_context_inspect.yaml
.. check date: 2022/03/18
.. Commits on Aug 22, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker context inspect

=======================================
docker context inspect
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _context_inspect-description:

説明
==========

.. Display detailed information on one or more contexts

1つまたは複数 context の情報を表示します。

.. _context_import-usage:

使い方
==========

.. code-block:: bash

   $ docker context inspect [OPTIONS] [CONTEXT] [CONTEXT...]

.. Extended description
.. _context_import-extended-description:

補足説明
==========

.. Inspects one or more contexts.

1つまたは複数 context の情報を表示します。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <context_inspect-examples>` をご覧ください。


.. _context_inspect-options:

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


.. _context_inspect-examples:

使用例
==========

.. Inspect a context by name
.. _inspect-a-context-by-name:

名前で context を調査
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: bash

   $ docker context inspect "local+aks"
   [
     {
       "Name": "local+aks",
       "Metadata": {
         "Description": "Local Docker Engine + Azure AKS endpoint",
         "StackOrchestrator": "kubernetes"
       },
       "Endpoints": {
         "docker": {
           "Host": "npipe:////./pipe/docker_engine",
           "SkipTLSVerify": false
         },
         "kubernetes": {
           "Host": "https://simon-aks-***.hcp.uksouth.azmk8s.io:443",
           "SkipTLSVerify": false,
           "DefaultNamespace": "default"
         }
       },
       "TLSMaterial": {
         "kubernetes": [
           "ca.pem",
           "cert.pem",
           "key.pem"
         ]
       },
       "Storage": {
         "MetadataPath": "C:\\Users\\simon\\.docker\\contexts\\meta\\cb6d08c0a1bfa5fe6f012e61a442788c00bed93f509141daff05f620fc54ddee",
         "TLSPath": "C:\\Users\\simon\\.docker\\contexts\\tls\\cb6d08c0a1bfa5fe6f012e61a442788c00bed93f509141daff05f620fc54ddee"
       }
     }
  ]


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

   docker context inspect
      https://docs.docker.com/engine/reference/commandline/context_inspect/
