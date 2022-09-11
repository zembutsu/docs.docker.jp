.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/node_promote/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/node_promote.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_node_promote.yaml
.. check date: 2022/03/30
.. Commits on Aug 21, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker node promote

=======================================
docker node promote
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _node_promote-description:

説明
==========

.. Promote one or more nodes to manager in the swarm

swarm 内の1つまたは複数のノードを manager に :ruby:`昇格 <promote>` します。

.. API 1.24+
   Open the 1.24 API reference (in a new window)
   The client and daemon API must both be at least 1.24 to use this command. Use the docker version command on the client to check your client and daemon API versions.
   Swarm This command works with the Swarm orchestrator.

【API 1.24+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.24 <https://docs.docker.com/engine/api/v1.24/>`_ の必要があります。クライアントとデーモン API のバージョンを調べるには、 ``docker version`` コマンドを使います。

【Swarm】このコマンドは Swarm オーケストレータで動作します。


.. _node_promote-usage:

使い方
==========

.. code-block:: bash

   $ docker node promote NODE [NODE...]

.. Extended description
.. _node_promote-extended-description:

補足説明
==========

.. Promotes a node that is pending a promotion to manager. This command targets a docker engine that is a manager in the swarm cluster.

マネージャへの昇格を保留しているノードを昇格（promote）します。このコマンドは swarm クラスタのマネージャとして動いている docker engine 用です。

..    Note
    This is a cluster management command, and must be executed on a swarm manager node. To learn about managers and workers, refer to the Swarm mode section in the documentation.

.. note::

   これはクラスタ管理コマンドであり、 swarm manager ノードで実行する必要があります。manager と worker について学ぶには、ドキュメント内の :doc:`Swarm モードのセクション </engine/swarm/index>` を参照ください。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <node_promote-examples>` をご覧ください。

.. _node_promote-examples:

使用例
==========

.. code-block:: bash

   $ docker node promote <node name>


.. Parent command

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker node <node>`
     - Swarm ノードを管理


.. Related commands

関連コマンド
====================

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker node demote<node_demote>`
     - swarm 内の manager から1つまたは複数のノードを :ruby:`降格 <demote>`
   * - :doc:`docker node inspect<node_inspect>`
     - 1つまたは複数ノードの詳細情報を表示
   * - :doc:`docker node ls<node_ls>`
     - swarm 内のノードを一覧表示
   * - :doc:`docker node promote<node_promote>`
     - swarm 内の1つまたは複数のノードを manager に :ruby:`昇格 <promote>`
   * - :doc:`docker node ps<node_ps>`
     - 1つまたは複数のノード上で実行しているタスク一覧を表示。デフォルトは現在のノード上
   * - :doc:`docker node rm<node_rm>`
     - swarm 内の1つまたは複数のノードを削除
   * - :doc:`docker node update<node_update>`
     - ノードを更新

.. seealso:: 

   docker node promote
      https://docs.docker.com/engine/reference/commandline/node_promote/

