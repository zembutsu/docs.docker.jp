.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/swarm/swarm-tutorial/rolling-update/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/swarm/swarm-tutorial/rolling-update.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/swarm/swarm-tutorial/rolling-update.md
.. check date: 2016/06/17
.. Commits on Jun 16, 2016 bc033cb706fd22e3934968b0dfdf93da962e36a8
.. -----------------------------------------------------------------------------

.. Apply rolling updates to a service

.. _apply-rolling-updates-to-a-service:

=======================================
Swarm で実行中のサービスを削除
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. In a previous step of the tutorial, you scaled the number of instances of a service. In this part of the tutorial, you deploy a new Redis service and upgrade the service using rolling updates.

チュートリアルの前のステップでは、サービスのインスタンス数を :doc:`スケール <scale-service>` しました。次のチュートリアルは新しい Redis サービスをデプロイし、ローリング・アップデートでサービスを更新します。

..    If you haven't already, open a terminal and ssh into the machine where you run your manager node. For example, the tutorial uses a machine named manager1.

1. 準備がまだであれば、ターミナルを開き、マネージャ・ノードを実行しているマシンに SSH で入ります。たとえば、このチュートリアルでは ``manager1`` という名前のマシンを使います。

..    Deploy Redis 3.0.6 to all nodes in the Swarm and configure the swarm to update one node every 10 seconds:

2. Redis 3.0.6 を Swarm の全てのノードにデプロイします。そして、各ノードの更新を10秒ごとに行うよう Swarm に設定します。

.. code-block:: bash

   $ docker service create --replicas 3 --name redis --update-delay 10s --update-parallelism 1 redis:3.0.6

   8m228injfrhdym2zvzhl9k3l0

..    You configure the rolling update policy at service deployment time.

これはサービスのデプロイ時のローリング・アップデート・ポリシーを設定しました。

..    The --update-parallelism flag configures the number of service tasks to update simultaneously.

``--update-parallelism`` フラグは、同時に実行するサービス・タスク数を指定します。

..    The --update-delay flag configures the time delay between updates to a service task or sets of tasks. You can describe the time T as a combination of the number of seconds Ts, minutes Tm, or hours Th. So 10m30s indicates a 10 minute 30 second delay.

``--update-delay`` フラグは、サービス・タスクやタスク・セットを更新する遅延時間を指定します。時間 ``T`` を、秒数 ``Ts``  、分 ``Tm``  、時 ``Th`` の組み合わせで記述できます。たとえば ``10m30s`` は 10 分 30 秒の遅延です。

..    Inspect the redis service:

3. ``redis`` サービスを調べます。

.. code-block:: bash

   $ docker service inspect redis --pretty
   
   ID:     75kcmhuf8mif4a07738wttmgl
   Name:       redis
   Mode:       REPLICATED
    Scale: 3
   Placement:
    Strategy:  SPREAD
   UpdateConfig:
    Parallelism:   1
    Delay:     10s
   ContainerSpec:
    Image:     redis:3.0.6

..    Now you can update the container image for redis. Swarm applies the update to nodes according to the UpdateConfig policy:

4. ``redis`` 用のコンテナ・イメージを更新します。 Swarm は ``UpdateConfig`` ポリシーに基づいてノード更新を適用します。

.. code-block:: bash

   $ docker service update --image redis:3.0.7 redis
   redis

..    Run docker service inspect --pretty redis to see the new image in the desired state:

5. ``docker service inspect --pretty redis`` を実行し、新しいイメージの期待状態を確認します。

.. code-block:: bash

   docker service inspect --pretty redis
   
   ID:     1yrcci9v8zj6cokua2eishlob
   Name:       redis
   Mode:       REPLICATED
    Scale:     3
   Placement:
    Strategy:  SPREAD
   UpdateConfig:
    Parallelism:   1
    Delay:     10s
   ContainerSpec:
   Image:       redis:3.0.7

..    Run docker service tasks <TASK-ID> to watch the rolling update:

6. ``docker service tasks <タスクID>`` を実行し、ローリング・アップデートを監視します。

.. code-block:: bash

   $ docker service tasks redis
   
   ID                         NAME     SERVICE  IMAGE        DESIRED STATE  LAST STATE          NODE
   5409nu4crb0smamziqwuug67u  redis.1  redis    redis:3.0.7  RUNNING        RUNNING 21 seconds  worker2
   b8ezq58zugcg1trk8k7jrq9ym  redis.2  redis    redis:3.0.7  RUNNING        RUNNING 1 seconds   worker1
   cgdcbipxnzx0y841vysiafb64  redis.3  redis    redis:3.0.7  RUNNING        RUNNING 11 seconds  worker1

..    Before Swarm updates all of the tasks, you can see that some are running redis:3.0.6 while others are running redis:3.0.7. The output above shows the state once the rolling updates are done. You can see that each instances entered the RUNNING state in 10 second increments.

Swarm が全てのタスクを更新するまで、 ``redis:3.0.6`` として実行中のイメージが ``redis:3.0.7`` に切り替わるのが見えるでしょう。先ほどの出力はローリング・アップデートが完了した状態です。各インスタンスが ``RUNNING`` （実行中）の状態になるのに、それぞれ 10 秒ずつ増えているのが分かります。

.. Next, learn about how to drain a node in the Swarm.

次は Swarm から :doc:`ノードを解放 <drain-node>` する方法を学びます。

.. seealso:: 

   Apply rolling updates to a service
      https://docs.docker.com/engine/swarm/swarm-tutorial/rolling-update/
