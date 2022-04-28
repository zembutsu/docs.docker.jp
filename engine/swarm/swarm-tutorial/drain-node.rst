.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/swarm/swarm-tutorial/drain-node/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/engine/swarm/swarm-tutorial/drain-node.md
   doc version: 20.10
.. check date: 2022/04/29
.. Commits on Aug 7, 2021 3b71231970606bb45fd6f37a8c99522583e7f5a8
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

.. Important: Setting a node to DRAIN does not remove standalone containers from that node, such as those created with docker run, docker-compose up, or the Docker Engine API. A node’s status, including DRAIN, only affects the node’s ability to schedule swarm service workloads.

.. important::

   ノードに対して ``DRAIN`` を設定しても、ノード上で ``docker run`` や ``docker-compose up`` や他の Docker Engine API で作成したスタンドアロン・コンテナは削除しません。 ``DRAIN`` を含むノードの状態が影響を与えているのは、 swarm サービスのワークロードとしてスケジュールされたものだけです。

..    If you haven't already, open a terminal and ssh into the machine where you run your manager node. For example, the tutorial uses a machine named manager1.

1. 準備がまだであれば、ターミナルを開き、 manager ノードを実行しているマシンに SSH で入ります。たとえば、このチュートリアルでは ``manager1`` という名前のマシンを使います。

..    Verify that all your nodes are actively available.

2. すべてのノードが利用可能（available）な状態を確認します。

   .. code-block:: bash
   
      $ docker node ls
      
      ID                           HOSTNAME  STATUS  AVAILABILITY  MANAGER STATUS
      1bcef6utixb0l0ca7gxuivsj0    worker2   Ready   Active
      38ciaotwjuritcdtn9npbnkuz    worker1   Ready   Active
      e216jshn25ckzbvmwlnh5jr3g *  manager1  Ready   Active        Leader

..    If you aren't still running the redis service from the rolling update tutorial, start it now:

3. :doc:`ローリング・アップデート <rolling-update>` チュートリアルの ``redis`` サービスを起動していなければ、今起動します。

   .. code-block:: bash
   
      $ docker service create --replicas 3 --name redis --update-delay 10s redis:3.0.6
      
      c5uo6kdmzpon37mgj9mwglcfw

..    Run docker service tasks redis to see how the swarm manager assigned the tasks to different nodes:

4. ``docker service tasks redis`` を実行したら、swarm マネージャが別々のノードにタスクを割り当てたのが分かります。

   .. code-block:: bash
   
      $ docker service ps redis
      
      NAME                               IMAGE        NODE     DESIRED STATE  CURRENT STATE
      redis.1.7q92v0nr1hcgts2amcjyqg3pq  redis:3.0.6  manager1 Running        Running 26 seconds
      redis.2.7h2l8h3q3wqy5f66hlv9ddmi6  redis:3.0.6  worker1  Running        Running 26 seconds
      redis.3.9bg7cezvedmkgg6c8yzvbhwsd  redis:3.0.6  worker2  Running        Running 26 seconds

   ..    In this case the swarm manager distributed one task to each node. You may see the tasks distributed differently among the nodes in your environment.

   このケースでは swarm manager はノードごとに１つのタスクを分散しました。皆さんの環境によっては、別のノードに分散されて見えるかもしれません。

..    Run docker node update --availability drain <NODE-ID> to drain a node that had a task assigned to it:

5. ``docker node update --availability drain <ノードID>`` を実行し、タスクが割り当てられているノードをドレイン（解放）します。

   .. code-block:: bash
   
      docker node update --availability drain worker1
      
      worker1

..    Inspect the node to check its availability:

6. ノードが利用可能かどうか調べます。

   .. code-block:: bash
   
      $ docker node inspect --pretty worker1
      
      ID:			38ciaotwjuritcdtn9npbnkuz
      Hostname:		worker1
      Status:
       State:			Ready
       Availability:		Drain
      ...snip...

..    The drained node shows Drain for AVAILABILITY.

ドレインしたノードの ``AVAILABILITY`` は  ``Drain`` です。

.. Run docker service ps redis to see how the swarm manager updated the task assignments for the redis service:

7. ``docker service ps redis``  を実行し、swarm manager が ``redis`` サービスのタスク割り当てを更新するのを確認します。

.. code-block:: bash

   $ docker service ps redis
   
      NAME                                    IMAGE        NODE      DESIRED STATE  CURRENT STATE           ERROR
      redis.1.7q92v0nr1hcgts2amcjyqg3pq       redis:3.0.6  manager1  Running        Running 4 minutes
      redis.2.b4hovzed7id8irg1to42egue8       redis:3.0.6  worker2   Running        Running About a minute
       \_ redis.2.7h2l8h3q3wqy5f66hlv9ddmi6   redis:3.0.6  worker1   Shutdown       Shutdown 2 minutes ago
      redis.3.9bg7cezvedmkgg6c8yzvbhwsd       redis:3.0.6  worker2   Running        Running 4 minutes

.. The swarm manager maintains the desired state by ending the task on a node with Drain availability and creating a new task on a node with Active availability.

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
      
      ID:			38ciaotwjuritcdtn9npbnkuz
      Hostname:		worker1
      Status:
       State:			Ready
       Availability:		Active
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

.. What's next?

次は何をしますか？
====================

.. Learn how to use a swarm mode routing mesh.

:doc:`/engine/swarm/ingress` を学びましょう。


.. seealso:: 

   Drain a node on the swarm
      https://docs.docker.com/engine/swarm/swarm-tutorial/drain-node/
