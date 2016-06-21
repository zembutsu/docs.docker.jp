.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/swarm/swarm-tutorial/rolling-update/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/swarm/swarm-tutorial/rolling-update.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/swarm/swarm-tutorial/rolling-update.md
.. check date: 2016/06/21
.. Commits on Jun 19, 2016 9499d5fd522e2fa31e5d0458c4eb9b420f164096
.. -----------------------------------------------------------------------------

.. Apply rolling updates to a service

.. _apply-rolling-updates-to-a-service:

========================================
サービスにローリング・アップデートを適用
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. In a previous step of the tutorial, you scaled the number of instances of a service. In this part of the tutorial, you deploy a service based on the Redis 3.0.6 container image. Then you upgrade the service to use the Redis 3.0.7 container image using rolling updates.

チュートリアルの前のステップでは、サービスのインスタンス数を :doc:`スケール <scale-service>` しました。次のチュートリアルは Redis 3.0.6 コンテナ・イメージをベースとしたサービスをデプロイします。そして、ローリング・アップデートで Redis 3.0.7 コンテナ・イメージを使うサービスに更新します。

..    If you haven't already, open a terminal and ssh into the machine where you run your manager node. For example, the tutorial uses a machine named manager1.

1. 準備がまだであれば、ターミナルを開き、マネージャ・ノードを実行しているマシンに SSH で入ります。たとえば、このチュートリアルでは ``manager1`` という名前のマシンを使います。

..    Deploy Redis 3.0.6 to all nodes in the swarm and configure the swarm to update one node every 10 seconds:

2. Redis 3.0.6 を swarm の全てのノードにデプロイします。そして、各ノードの更新を10秒ごとに行うよう swarm に設定します。

.. code-block:: bash

   $ docker service create --replicas 3 --name redis --update-delay 10s --update-parallelism 1 redis:3.0.6
   
   0u6a4s31ybk7yw2wyvtikmu50

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
   
   ID:     0u6a4s31ybk7yw2wyvtikmu50
   Name:       redis
   Mode:       REPLICATED
    Replicas:      3
   Placement:
    Strategy:  SPREAD
   UpdateConfig:
    Parallelism:   1
    Delay:     10s
   ContainerSpec:
    Image:     redis:3.0.6

..    Now you can update the container image for redis. swarm manager applies the update to nodes according to the UpdateConfig policy:

4. ``redis`` 用のコンテナ・イメージを更新します。 swarm マネージャ は ``UpdateConfig`` ポリシーに基づいてノード更新を適用します。

.. code-block:: bash

   $ docker service update --image redis:3.0.7 redis
   redis

..    Run docker service inspect --pretty redis to see the new image in the desired state:

5. ``docker service inspect --pretty redis`` を実行し、新しいイメージの期待状態を確認します。

.. code-block:: bash

   docker service inspect --pretty redis
   
   ID:     0u6a4s31ybk7yw2wyvtikmu50
   Name:       redis
   Mode:       REPLICATED
    Replicas:      3
   Placement:
    Strategy:  SPREAD
   UpdateConfig:
    Parallelism:   1
    Delay:     10s
   ContainerSpec:
    Image:     redis:3.0.7

..    Run docker service tasks <TASK-ID> to watch the rolling update:

6. ``docker service tasks <タスクID>`` を実行し、ローリング・アップデートを監視します。

.. code-block:: bash

   $ docker service tasks redis
   
   ID                         NAME     SERVICE  IMAGE        LAST STATE              DESIRED STATE  NODE
   dos1zffgeofhagnve8w864fco  redis.1  redis    redis:3.0.7  Running 37 seconds      Running        worker1
   9l3i4j85517skba5o7tn5m8g0  redis.2  redis    redis:3.0.7  Running About a minute  Running        worker2
   egiuiqpzrdbxks3wxgn8qib1g  redis.3  redis    redis:3.0.7  Running 48 seconds      Running        worker1

..    Before Swarm updates all of the tasks, you can see that some are running redis:3.0.6 while others are running redis:3.0.7. The output above shows the state once the rolling updates are done. You can see that each instances entered the RUNNING state in 10 second increments.

Swarm が全てのタスクを更新するまで、 ``redis:3.0.6`` として実行中のイメージが ``redis:3.0.7`` に切り替わるのが見えるでしょう。先ほどの出力はローリング・アップデートが完了した状態です。各インスタンスが ``RUNNING`` （実行中）の状態になるのに、それぞれ約 10 秒ずつ増えているのが分かります。

.. Next, learn about how to drain a node in the Swarm.

次は Swarm から :doc:`ノードを解放 <drain-node>` する方法を学びます。

.. seealso:: 

   Apply rolling updates to a service
      https://docs.docker.com/engine/swarm/swarm-tutorial/rolling-update/
