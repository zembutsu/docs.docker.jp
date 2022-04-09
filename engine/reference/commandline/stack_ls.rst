.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/stack_ls/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/stack_ls.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_stack_ls.yaml
.. check date: 2022/04/09
.. Commits on Apr 2, 2022 098129a0c12e3a79398b307b38a67198bd3b66fc
.. -------------------------------------------------------------------

.. docker stack ls

=======================================
docker stack ls
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _stack_ls-description:

説明
==========

.. List stacks

スタックを一覧表示します。

.. API 1.25+
   Open the 1.25 API reference (in a new window)
   The client and daemon API must both be at least 1.25 to use this command. Use the docker version command on the client to check your client and daemon API versions.

【API 1.25+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.25 <https://docs.docker.com/engine/api/v1.25/>`_ の必要があります。クライアントとデーモン API のバージョンを調べるには、 ``docker version`` コマンドを使います。


.. _stack_ls-usage:

使い方
==========

.. code-block:: bash

   $ docker stack ls [OPTIONS]

.. Extended description
.. _stack_ls-extended-description:

補足説明
==========

.. Lists the stacks.

スタックを一覧表示します。

..    Note
    This is a cluster management command, and must be executed on a swarm manager node. To learn about managers and workers, refer to the Swarm mode section in the documentation.

.. note::

   これはクラスタ管理コマンドであり、 swarm manager ノードで実行する必要があります。manager と worker について学ぶには、ドキュメント内の :doc:`Swarm モードのセクション </engine/swarm/index>` を参照ください。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <stack_ls-examples>` をご覧ください。

.. _stack_ls-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--all-namespaces``
     - 
     - 【deprecated】【Kubernetes】全ての Kubernetes 名前空間のスタック一覧
  * - ``--format``
     - 
     - Go テンプレートを使ってスタックの出力を整形
    * - ``--namespaces``
     - 
     - 【deprecated】【Kubernetes】使用する Kubernetes 名前空間
   * - ``--kubeconfig``
     - 
     - 【非推奨】【Kubernetes】Kubernetes 設定ファイル
   * - ``--orchestrator``
     - 
     - 【非推奨】使用するオーケストレータ（ swarm | kubernetes | all）

.. _stack_ls-examples:

使用例
==========

.. The following command shows all stacks and some additional information:

以下のコマンドは、全てのスタックと追加情報を表示します。

.. code-block:: bash

   $ docker stack ls
   
   ID                 SERVICES            ORCHESTRATOR
   myapp              2                   Kubernetes
   vossibility-stack  6                   Swarm


.. Formatting
.. _stack_ls-formatting:
表示形式
----------

.. The formatting option (--format) pretty prints configs output using a Go template.

出力形式のオプション（ ``--format`` ）は Go テンプレートを用いて出力を調整し、表示を整えます。

.. Valid placeholders for the Go template are listed below:

有効な Go テンプレートの placeholder は以下の通りです。

.. list-table::
   :header-rows: 1

   * - placeholder
     - 説明
   * - ``.Name``
     - スタック名
   * - ``.services``
     - サービス数
   * - ``.Orchestrator``
     - オーケストレータ名
   * - ``.Namespace``
     - 名前空間

.. When using the --format option, the stack ls command either outputs the data exactly as the template declares or, when using the table directive, includes column headers as well.

``--format`` オプションを使うと、 ``stack ls`` コマンドはテンプレート宣言通りに正確にデータを出力するか、 ``table`` ディレクティブによってヘッダ列も同様に表示するかのいずれかです。

.. The following example uses a template without headers and outputs the Name and Services entries separated by a colon (:) for all stacks:

以下の例では、ヘッダのないテンプレートを使いますが、全てのイメージに対して ``Name`` と ``Services`` の項目をコロン ``:`` で分けて表示します。

.. code-block:: bash

   $ docker stack ls --format "{{.Name}}: {{.Services}}"
   web-server: 1
   web-cache: 4



.. Parent command

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker stack <stack>`
     - Docker stack を管理

.. Related commands

関連コマンド
====================

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker stack deploy<stack_deploy>`
     - 新しいスタックをデプロイするか、既存のスタックを更新
   * - :doc:`docker stack ls<stack_ls>`
     - スタックを一覧表示
   * - :doc:`docker stack ps<stack_ps>`
     - スタック内のタスクを一覧表示
   * - :doc:`docker stack rm<stack_rm>`
     - 1つまたは複数スタックを削除
   * - :doc:`docker stack services<stack_services>`
     - タスク内のサービスを一覧表示


.. seealso:: 

   docker stack ls
      https://docs.docker.com/engine/reference/commandline/stack_ls/
