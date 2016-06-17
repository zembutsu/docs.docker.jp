.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/swarm/swarm-tutorial/drain-node/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/swarm/swarm-tutorial/drain-node.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/swarm/swarm-tutorial/drain-node.md
.. check date: 2016/06/17
.. Commits on Jun 16, 2016 bc033cb706fd22e3934968b0dfdf93da962e36a8
.. -----------------------------------------------------------------------------

.. Drain a node on the Swarm

.. _drain-a-node-on-the-swarm:

=======================================
Swarm からノードをドレイン（解放）
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. In earlier steps of the tutorial, all the nodes have been running with ACTIVE availability. The Swarm manager can assign tasks to any ACTIVE node, so all nodes have been available to receive tasks.

チュートリアルのこれまでのステップは、全て ``ACTIVE`` 状態で利用可能なノードでした。Swarm マネージャはタスクをあらゆる ``ACTIVE`` ノード上に割り当て可能です。つまり、全てのノードはタスクを受け取れます。

.. Sometimes, such as planned maintenance times, you need to set a node to DRAIN availabilty. DRAIN availabilty prevents a node from receiving new tasks from the Swarm manager. It also means the manager stops tasks running on the node and launches replica tasks on a node with ACTIVE availability.

とはいえ、たまにはメンテナンス時間の計画など、 ``DRAIN`` 状態（訳者注；ドレイン＝離脱、解放された状態）の指定が必要になるでしょう。 ``DRAIN`` 状態はノードが Swarm マネージャから新しいタスクの受信を拒否します。また、マネージャは対象ノード上のタスクを停止し、レプリカ（複製）タスクを別の ``ACTIVE`` 状態のノードで起動します。

..    If you haven't already, open a terminal and ssh into the machine where you run your manager node. For example, the tutorial uses a machine named manager1.

1. 準備がまだであれば、ターミナルを開き、マネージャ・ノードを実行しているマシンに SSH で入ります。たとえば、このチュートリアルでは ``manager1`` という名前のマシンを使います。

..    Verify that all your nodes are actively available.

2. すべてのノードが利用可能（available）な状態を確認します。

.. code-block:: bash

   $ docker node ls
   
   ID               NAME      MEMBERSHIP  STATUS  AVAILABILITY  MANAGER STATUS  LEADER
   1x2bldyhie1cj    worker1   Accepted    Ready   Active
   1y3zuia1z224i    worker2   Accepted    Ready   Active
   2p5bfd34mx4op *  manager1  Accepted    Ready   Active        Reachable       Yes

..    If you aren't still running the redis service from the rolling update tutorial, start it now:

2. :doc:`ローリング・アップデート <rolling-update>` チュートリアルの ``redis`` サービスを起動していなければ、今起動します。

.. code-block:: bash

   $ docker service create --replicas 3 --name redis --update-delay 10s --update-parallelism 1 redis:3.0.6
   
   69uh57k8o03jtqj9uvmteodbb

..    Run docker service tasks redis to see how the Swarm manager assigned the tasks to different nodes:

4. ``docker service tasks redis`` を実行したら、Swarm マネージャが別々のノードにタスクを割り当てたのが分かります。

.. code-block:: bash

   $ docker service tasks redis
   
   ID                         NAME     SERVICE  IMAGE        LAST STATE          DESIRED STATE  NODE
   3wfqsgxecktpwoyj2zjcrcn4r  redis.1  redis    redis:3.0.6  RUNNING 13 minutes  RUNNING        worker2
   8lcm041z3v80w0gdkczbot0gg  redis.2  redis    redis:3.0.6  RUNNING 13 minutes  RUNNING        worker1
   d48skceeph9lkz4nbttig1z4a  redis.3  redis    redis:3.0.6  RUNNING 12 minutes  RUNNING        manager1

..    In this case the Swarm manager distributed one task to each node. You may see the tasks distributed differently among the nodes in your environment.

このケースでは Swarm マネージャはノードごとに１つのタスクを分散しました。皆さんの環境によっては、別のノードに分散されて見えるかもしれません。

..    Run docker node update --availability drain <NODE-ID> to drain a node that had a task assigned to it:

5. ``docker node update --availability drain <ノードID>`` を実行し、タスクが割り当てられているノードをドレイン（解放）します。

.. code-block:: bash

   docker node update --availability drain worker1
   worker1

..    Inspect the node to check its availability:

6. ノードが利用可能かどうか調べます。

.. code-block:: bash

   $ docker node inspect --pretty worker1
   ID:         1x2bldyhie1cj
   Hostname:       worker1
   Status:
    State:         READY
    Availability:      DRAIN
   ...省略...

..    The drained node shows Drain for AVAILABILITY.

ドレインしたノードの ``AVAILABILITY`` は  ``Drain`` です。

..    Run docker service tasks redis to see how the Swarm manager updated the task assignments for the redis service:

7. ``docker service tasks redis``  を実行し、Swarm マネージャが ``redis`` サービスのタスク割り当てを更新するのを確認します。

.. code-block:: bash

   ID                         NAME     SERVICE  IMAGE        LAST STATE          DESIRED STATE  NODE
   3wfqsgxecktpwoyj2zjcrcn4r  redis.1  redis    redis:3.0.6  RUNNING 26 minutes  RUNNING        worker2
   ah7o4u5upostw3up1ns9vbqtc  redis.2  redis    redis:3.0.6  RUNNING 9 minutes   RUNNING        manager1
   d48skceeph9lkz4nbttig1z4a  redis.3  redis    redis:3.0.6  RUNNING 26 minutes  RUNNING        manager1

..    The Swarm manager maintains the desired state by ending the task on a node with Drain availability and creating a new task on a node with Active availability.

Swarm マネージャは期待状態を維持するため、 ``Drain`` 状態のノードでタスクを終了したら、 ``Active`` 状態のノードで新しいタスクを作成します。

..    Run docker node update --availability active <NODE-ID> to return the drained node to an active state:

8. ``docker node update --availability active <ノードID>`` を実行し、ドレイン（解放）したノードをアクティブ状態に戻します。

.. code-block:: bash

   $ docker node update --availability active worker1
   worker1

..    Inspect the node to see the updated state:

9. ノードを調べ、状態の更新を確認します。

.. code-block:: bash

   $ docker node inspect --pretty worker1
   ID:          1x2bldyhie1cj
   Hostname:        worker1
   Status:
   State:          READY
   Availability:       ACTIVE
   ...省略...

..    When you set the node back to Active availability, it can receive new tasks:
        during a service update to scale up
        during a rolling update
        when you set another node to Drain availability
        when a task fails on another active node

ノードが ``Active`` 状態に戻れば、新しいタスクを受信できます。

* サービスの更新をスケールアップするため
* ローリング・アップデートするため
* 他のノードを ``Drain``  状態にした場合
* 他のアクティブ・ノードでタスクに失敗した場合

.. seealso:: 

   Apply rolling updates to a service
      https://docs.docker.com/engine/swarm/swarm-tutorial/drain-node/
