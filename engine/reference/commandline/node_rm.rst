.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/node_rm/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/node_rm.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_node_rm.yaml
.. check date: 2022/03/31
.. Commits on Aug 21, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker node rm

=======================================
docker node rm
=======================================


.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _node_rm-description:

説明
==========

.. Remove one or more nodes from the swarm

swarm 内の1つまたは複数のノードを削除します。

.. API 1.24+
   Open the 1.24 API reference (in a new window)
   The client and daemon API must both be at least 1.24 to use this command. Use the docker version command on the client to check your client and daemon API versions.
   Swarm This command works with the Swarm orchestrator.

【API 1.24+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.24 <https://docs.docker.com/engine/api/v1.24/>`_ の必要があります。クライアントとデーモン API のバージョンを調べるには、 ``docker version`` コマンドを使います。

【Swarm】このコマンドは Swarm オーケストレータで動作します。


.. _node_rm-usage:

使い方
==========

.. code-block:: bash

   $ docker node rm [OPTIONS] NODE [NODE...]

.. Extended description
.. _node_rm-extended-description:

補足説明
==========

.. Remove one or more nodes from the swarm.

swarm 内の1つまたは複数のノードを削除します。

..    Note
    This is a cluster management command, and must be executed on a swarm manager node. To learn about managers and workers, refer to the Swarm mode section in the documentation.

.. note::

   これはクラスタ管理コマンドであり、 swarm manager ノードで実行する必要があります。manager と worker について学ぶには、ドキュメント内の :doc:`Swarm モードのセクション </engine/swarm/index>` を参照ください。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <node_rm-examples>` をご覧ください。

.. _node_rm-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--force`` , ``-f``
     - 
     - swarm からノードを強制削除


.. _node_rm-examples:

使用例
==========

.. Remove a stopped node from the swarm
.. _node_rm-remove-a-stopped-node-from-the-swarm:
swarm から停止したノードを削除
------------------------------

.. code-block:: bash

   $ docker node rm swarm-node-02
   
   Node swarm-node-02 removed from swarm

.. Attempt to remove a running node from a swarm
.. _node_rm-attempt-to-remove-a-running-node-from-a-swarm:
swarm から実行中ノードの削除を試みる
--------------------------------------------------

.. Removes the specified nodes from the swarm, but only if the nodes are in the down state. If you attempt to remove an active node you will receive an error:

swarm から指定したノードを削除できるのは、ノードが :ruby:`停止状態 <down>` の場合のみです。アクティブなノードの削除を試みても、次のようにエラーが戻ります。

.. code-block:: bash

   $ docker node rm swarm-node-03
   
   Error response from daemon: rpc error: code = 9 desc = node swarm-node-03 is not
   down and can't be removed

.. Forcibly remove an inaccessible node from a swarm
.. _node_rm-forcibly-remove-an-inaccessible-node-from-a-swarm:
swarm から到達できないノードを強制削除
----------------------------------------

.. If you lose access to a worker node or need to shut it down because it has been compromised or is not behaving as expected, you can use the --force option. This may cause transient errors or interruptions, depending on the type of task being run on the node.

worker ノードとの通信が失われた場合、あるいは、障害や予期しない挙動の発生によって worker ノードを停止する必要が出てきた場合には、 ``--force`` オプションが使えます。これにより、一時的なエラーや中断が発生するかもしれませんが、ノード上で実行しているタスクの種類に依存します。


.. code-block:: bash

   $ docker node rm --force swarm-node-03
   
   Node swarm-node-03 removed from swarm

.. A manager node must be demoted to a worker node (using docker node demote) before you can remove it from the swarm.

manager ノードを swarm から削除する前に、 worker ノードに :ruby:`降格する <demote>` 必要があります（ ``docker node demote`` を使用）。

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

   docker node rm
      https://docs.docker.com/engine/reference/commandline/node_rm/

