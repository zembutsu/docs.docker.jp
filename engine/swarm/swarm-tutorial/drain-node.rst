.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/swarm/swarm-tutorial/drain-node/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/swarm/swarm-tutorial/drain-node.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/swarm/swarm-tutorial/drain-node.md
.. check date: 2016/06/21
.. Commits on Jun 19, 2016 9499d5fd522e2fa31e5d0458c4eb9b420f164096
.. -----------------------------------------------------------------------------

.. Drain a node on the swarm

.. _drain-a-node-on-the-swarm:

=======================================
swarm からノードをドレイン（解放）
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. In earlier steps of the tutorial, all the nodes have been running with ACTIVE availability. The swarm manager can assign tasks to any ACTIVE node, so up to now all nodes have been available to receive tasks.

チュートリアルのこれまでのステップは、全て ``ACTIVE`` 状態で利用可能なノードでした。swarm マネージャはタスクをあらゆる ``ACTIVE`` ノード上に割り当て可能です。つまり、これまでの全てのノードがタスクを受け取れます。

.. Sometimes, such as planned maintenance times, you need to set a node to DRAIN availability. DRAIN availability prevents a node from receiving new tasks from the swarm manager. It also means the manager stops tasks running on the node and launches replica tasks on a node with ACTIVE availability.

とはいえ、たまにはメンテナンス時間の計画など、 ``DRAIN`` 状態（訳者注；ドレイン＝離脱、解放された状態）の指定が必要になるでしょう。 ``DRAIN`` 状態はノードが swarm マネージャから新しいタスクの受信を拒否します。また、マネージャは対象ノード上のタスクを停止し、レプリカ（複製）タスクを別の ``ACTIVE`` 状態のノードで起動します。

..    If you haven't already, open a terminal and ssh into the machine where you run your manager node. For example, the tutorial uses a machine named manager1.

1. 準備がまだであれば、ターミナルを開き、マネージャ・ノードを実行しているマシンに SSH で入ります。たとえば、このチュートリアルでは ``manager1`` という名前のマシンを使います。

..    Verify that all your nodes are actively available.

2. すべてのノードが利用可能（available）な状態を確認します。

.. code-block:: bash

   $ docker node ls
   
   ID                           NAME      MEMBERSHIP  STATUS  AVAILABILITY     MANAGER STATUS  LEADER
   1bcef6utixb0l0ca7gxuivsj0    worker2   Accepted    Ready   Active
   38ciaotwjuritcdtn9npbnkuz    worker1   Accepted    Ready   Active
   e216jshn25ckzbvmwlnh5jr3g *  manager1  Accepted    Ready   Active        Reachable       Yes

..    If you aren't still running the redis service from the rolling update tutorial, start it now:

3. :doc:`ローリング・アップデート <rolling-update>` チュートリアルの ``redis`` サービスを起動していなければ、今起動します。

.. code-block:: bash

   $ docker service create --replicas 3 --name redis --update-delay 10s --update-parallelism 1 redis:3.0.6
   
   c5uo6kdmzpon37mgj9mwglcfw

..    Run docker service tasks redis to see how the swarm manager assigned the tasks to different nodes:

4. ``docker service tasks redis`` を実行したら、swarm マネージャが別々のノードにタスクを割り当てたのが分かります。

.. code-block:: bash

   $ docker service tasks redis
   
   ID                         NAME     SERVICE  IMAGE        LAST STATE          DESIRED STATE  NODE
   7q92v0nr1hcgts2amcjyqg3pq  redis.1  redis    redis:3.0.6  Running 26 seconds  Running        manager1
   7h2l8h3q3wqy5f66hlv9ddmi6  redis.2  redis    redis:3.0.6  Running 26 seconds  Running        worker1
   9bg7cezvedmkgg6c8yzvbhwsd  redis.3  redis    redis:3.0.6  Running 26 seconds  Running        worker2

..    In this case the swarm manager distributed one task to each node. You may see the tasks distributed differently among the nodes in your environment.

このケースでは swarm マネージャはノードごとに１つのタスクを分散しました。皆さんの環境によっては、別のノードに分散されて見えるかもしれません。

..    Run docker node update --availability drain <NODE-ID> to drain a node that had a task assigned to it:

5. ``docker node update --availability drain <ノードID>`` を実行し、タスクが割り当てられているノードをドレイン（解放）します。

.. code-block:: bash

   docker node update --availability drain worker1
   
   worker1

..    Inspect the node to check its availability:

6. ノードが利用可能かどうか調べます。

.. code-block:: bash

   $ docker node inspect --pretty worker1
   
   ID:         38ciaotwjuritcdtn9npbnkuz
   Hostname:       worker1
   Status:
    State:         Ready
    Availability:      Drain
   ...省略...

..    The drained node shows Drain for AVAILABILITY.

ドレインしたノードの ``AVAILABILITY`` は  ``Drain`` です。

..    Run docker service tasks redis to see how the Swarm manager updated the task assignments for the redis service:

7. ``docker service tasks redis``  を実行し、Swarm マネージャが ``redis`` サービスのタスク割り当てを更新するのを確認します。

.. code-block:: bash

   $ docker service tasks redis
   
   ID                         NAME     SERVICE  IMAGE        LAST STATE              DESIRED STATE  NODE
   7q92v0nr1hcgts2amcjyqg3pq  redis.1  redis    redis:3.0.6  Running 4 minutes       Running        manager1
   b4hovzed7id8irg1to42egue8  redis.2  redis    redis:3.0.6  Running About a minute  Running        worker2
   9bg7cezvedmkgg6c8yzvbhwsd  redis.3  redis    redis:3.0.6  Running 4 minutes       Running        worker2

..    The Swarm manager maintains the desired state by ending the task on a node with Drain availability and creating a new task on a node with Active availability.

swarm マネージャは期待状態を維持するため、 ``Drain`` 状態のノードでタスクを終了したら、 ``Active`` 状態のノードで新しいタスクを作成します。

..    Run docker node update --availability active <NODE-ID> to return the drained node to an active state:

8. ``docker node update --availability active <ノードID>`` を実行し、ドレイン（解放）したノードをアクティブ状態に戻します。

.. code-block:: bash

   $ docker node update --availability active worker1
   
   worker1

..    Inspect the node to see the updated state:

9. ノードを調べ、状態の更新を確認します。

.. code-block:: bash

   $ docker node inspect --pretty worker1
   
   ID:          38ciaotwjuritcdtn9npbnkuz
   Hostname:        worker1
   Status:
   State:          Ready
   Availability:       Active
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

   Drain a node on the swarm
      https://docs.docker.com/engine/swarm/swarm-tutorial/drain-node/
