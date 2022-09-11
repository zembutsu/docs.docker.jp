.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/stack/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/stack.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_stack.yaml
.. check date: 2022/04/09
.. Commits on Jul 2, 2021 590463d6ce75c5ad02358998efee34a9fd358f6b
.. -------------------------------------------------------------------

.. docker stack

=======================================
docker stack
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _stack-description:

説明
==========

.. Manage Docker stack

Docker :ruby:`スタック <stack>` を管理します。

.. API 1.25+
   Open the 1.25 API reference (in a new window)
   The client and daemon API must both be at least 1.25 to use this command. Use the docker version command on the client to check your client and daemon API versions.

【API 1.25+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.25 <https://docs.docker.com/engine/api/v1.25/>`_ の必要があります。クライアントとデーモン API のバージョンを調べるには、 ``docker version`` コマンドを使います。


.. _stack-usage:

使い方
==========

.. code-block:: bash

   $ docker stack [OPTIONS] COMMAND

.. Extended description
.. _stack-extended-description:

補足説明
==========

.. Manage stacks.

:ruby:`スタック <stack>` を管理します。

.. _stack-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--kubeconfig``
     - 
     - 【非推奨】【Kubernetes】Kubernetes 設定ファイル
   * - ``--orchestrator``
     - 
     - 【非推奨】使用するオーケストレータ（ swarm | kubernetes | all）



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

   docker stack
      https://docs.docker.com/engine/reference/commandline/stack/
