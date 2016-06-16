.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/swarm_leave/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/swarm_leave.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/swarm_leave.md
.. check date: 2016/06/16
.. Commits on Jun 14, 2016 9acf97b72a4d5ff7b1bcad36fb19b53775f01596
.. -------------------------------------------------------------------

.. Warning: this command is part of the Swarm management feature introduced in Docker 1.12, and might be subject to non backward-compatible changes.

.. warning::

  このコマンドは Docker 1.12 で導入された Swarm 管理機能の一部です。それと、変更は下位互換性を考慮していない可能性があります。

.. swarm leave

=======================================
swarm leave
=======================================

.. code-block:: bash

   使い方:  docker swarm leave
   
   Swarm クラスタから離脱
   
   オプション:
         --help                使い方の表示

.. This command causes the node to leave the swarm.

このコマンドは swarm からノードを離脱（leave）します。

.. On a manager node:

マネージャ・ノード上の状態：

.. code-block:: bash

   $ docker node ls
   ID              NAME           STATUS  AVAILABILITY/MEMBERSHIP  MANAGER STATUS  LEADER
   04zm7ue1fd1q    swarm-node-02  READY   ACTIVE                                   
   2fg70txcrde2    swarm-node-01  READY   ACTIVE                   REACHABLE       
   3l1f6uzcuoa3 *  swarm-master   READY   ACTIVE                   REACHABLE       Yes

.. On a worker node:

ワーカ・ノードでコマンド実行：

.. code-block:: bash

   $ docker swarm leave
   Node left the default swarm.

.. On a manager node:

マネージャ・ノード上の表示：

.. code-block:: bash

   $ docker node ls
   ID              NAME           STATUS  AVAILABILITY/MEMBERSHIP  MANAGER STATUS  LEADER
   04zm7ue1fd1q    swarm-node-02  DOWN    ACTIVE                                   
   2fg70txcrde2    swarm-node-01  READY   ACTIVE                   REACHABLE       
   3l1f6uzcuoa3 *  swarm-master   READY   ACTIVE                   REACHABLE       Yes

関連情報
----------

* :doc:`swarm_init`
* :doc:`swarm_join`
* :doc:`swarm_update`

.. seealso:: 

   swarm leave
      https://docs.docker.com/engine/reference/commandline/swarm_leave/

