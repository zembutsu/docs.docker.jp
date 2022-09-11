.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/stack_rm/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/stack_rm.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_stack_rm.yaml
.. check date: 2022/04/09
.. Commits on Apr 2, 2022 098129a0c12e3a79398b307b38a67198bd3b66fc
.. -------------------------------------------------------------------

.. docker stack rm

=======================================
docker stack rm
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _stack_rm-description:

説明
==========

.. Remove one or more stacks

1つまたは複数スタックを削除します。

.. API 1.25+
   Open the 1.25 API reference (in a new window)
   The client and daemon API must both be at least 1.25 to use this command. Use the docker version command on the client to check your client and daemon API versions.

【API 1.25+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.25 <https://docs.docker.com/engine/api/v1.25/>`_ の必要があります。クライアントとデーモン API のバージョンを調べるには、 ``docker version`` コマンドを使います。


.. _stack_rm-usage:

使い方
==========

.. code-block:: bash

   $ docker stack rm [OPTIONS] STACK [STACK...]

.. Extended description
.. _stack_rm-extended-description:

補足説明
==========

.. Remove the stack from the swarm.

swarm からスタックを削除します。

..    Note
    This is a cluster management command, and must be executed on a swarm manager node. To learn about managers and workers, refer to the Swarm mode section in the documentation.

.. note::

   これはクラスタ管理コマンドであり、 swarm manager ノードで実行する必要があります。manager と worker について学ぶには、ドキュメント内の :doc:`Swarm モードのセクション </engine/swarm/index>` を参照ください。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <stack_rm-examples>` をご覧ください。

.. _stack_rm-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
    * - ``--namespaces``
     - 
     - 【deprecated】【Kubernetes】使用する Kubernetes 名前空間
   * - ``--kubeconfig``
     - 
     - 【非推奨】【Kubernetes】Kubernetes 設定ファイル
   * - ``--orchestrator``
     - 
     - 【非推奨】使用するオーケストレータ（ swarm | kubernetes | all）

.. _stack_rm-examples:

使用例
==========

.. Remove a stack
.. _stack_rm-remove-a-stack:

.. This will remove the stack with the name myapp. Services, networks, and secrets associated with the stack will be removed.

以下の例は ``myapp`` という名前のスタックを削除します。スタックに関連付けられたサービス、ネットワーク、シークレットも削除されます。

.. code-block:: bash

   $ docker stack rm myapp
   
   Removing service myapp_redis
   Removing service myapp_web
   Removing service myapp_lb
   Removing network myapp_default
   Removing network myapp_frontend

.. Remove multiple stacks
.. _stack_rm-remove-mutiple-stacks:
複数のスタックを削除
--------------------

.. This will remove all the specified stacks, myapp and vossibility. Services, networks, and secrets associated with all the specified stacks will be removed.

以下の例は指定した全てのタスク、 ``myapp`` と ``vossibility`` を削除します。指定したタスクに関連付けられたサービス、ネットワーク、シークレットも削除されます。

.. code-block:: bash

   $ docker stack rm myapp vossibility
   
   Removing service myapp_redis
   Removing service myapp_web
   Removing service myapp_lb
   Removing network myapp_default
   Removing network myapp_frontend
   Removing service vossibility_nsqd
   Removing service vossibility_logstash
   Removing service vossibility_elasticsearch
   Removing service vossibility_kibana
   Removing service vossibility_ghollector
   Removing service vossibility_lookupd
   Removing network vossibility_default
   Removing network vossibility_vossibility


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

   docker stack rm
      https://docs.docker.com/engine/reference/commandline/stack_rm/
