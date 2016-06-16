.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/swarm_join/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/swarm_join.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/swarm_join.md
.. check date: 2016/06/16
.. Commits on Jun 14, 2016 9acf97b72a4d5ff7b1bcad36fb19b53775f01596
.. -------------------------------------------------------------------

.. Warning: this command is part of the Swarm management feature introduced in Docker 1.12, and might be subject to non backward-compatible changes.

.. warning::

  このコマンドは Docker 1.12 で導入された Swarm 管理機能の一部です。それと、変更は下位互換性を考慮していない可能性があります。

.. swarm join

=======================================
swarm join
=======================================

.. code-block:: bash

   使い方:  docker swarm join [オプション]
   
   Swarm にノードかつ/またはマネージャで参加
   
   オプション:
         --help                使い方の表示
         --listen-addr value   リッスンするアドレス (デフォルト 0.0.0.0:2377)
         --manager             マネージャでの参加を試みる
         --secret string       ノードがクラスタ参加時に必要なシークレット値を設定

.. Join a node to a Swarm cluster. If the --manager flag is specified, the docker engine targeted by this command becomes a manager. If it is not specified, it becomes a worker.

ノードを Swarm クラスタに追加します。 ``--manager`` フラグを指定すると、このコマンドを実行した Docker Engine は ``manager`` （マネージャ）になります。指定しなければ、 ``worker`` （ワーカ）になります。

.. Join a node to swarm as a manager

ノードをマネージャとして swarm に追加
========================================

.. code-block:: bash

   $ docker swarm join --manager --listen-addr 192.168.99.122:2377 192.168.99.121:2377
   This node is attempting to join a Swarm as a manager.
   $ docker node ls
   ID              NAME           STATUS  AVAILABILITY/MEMBERSHIP  MANAGER STATUS  LEADER
   2fg70txcrde2    swarm-node-01  READY   ACTIVE                   REACHABLE       
   3l1f6uzcuoa3 *  swarm-master   READY   ACTIVE                   REACHABLE       Yes

.. Join a node to swarm as a worker

ノードをワーカとして swarm に追加
========================================

.. code-block:: bash

   $ docker swarm join --listen-addr 192.168.99.123:2377 192.168.99.121:2377
   This node is attempting to join a Swarm.
   $ docker node ls
   ID              NAME           STATUS  AVAILABILITY/MEMBERSHIP  MANAGER STATUS  LEADER
   04zm7ue1fd1q    swarm-node-02  READY   ACTIVE                                   
   2fg70txcrde2    swarm-node-01  READY   ACTIVE                   REACHABLE       
   3l1f6uzcuoa3 *  swarm-master   READY   ACTIVE                   REACHABLE       Yes

``--manager``
====================

.. Joins the node as a manager

マネージャとしてノードを追加します。


``--listen-addr 値``
====================

.. The node listens for inbound Swarm manager traffic on this IP:PORT

Swarm マネージャからのインバウンド通信をリッスンするための、ノードの IP:PORT を指定します。


``--secret string``
====================

.. Secret value needed to accept nodes into the Swarm

ノードが Swarm に受け入れられるために必要なシークレット値です。


関連情報
----------

* :doc:`swarm_init`
* :doc:`swarm_leave`
* :doc:`swarm_update`

.. seealso:: 

   swarm join
      https://docs.docker.com/engine/reference/commandline/swarm_join/

