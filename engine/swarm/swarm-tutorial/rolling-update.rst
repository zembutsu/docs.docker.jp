.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/swarm/swarm-tutorial/rolling-update/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/engine/swarm/swarm-tutorial/rolling-update.md
   doc version: 20.10
.. check date: 2022/04/29
.. Commits on Apr 12, 2022 461c6935c4745e50d2ca9f479b225157897c0f45
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

1. 準備がまだであれば、ターミナルを開き、manager ノードを実行しているマシンに SSH で入ります。たとえば、このチュートリアルでは ``manager1`` という名前のマシンを使います。

.. Deploy your Redis tag to the swarm and configure the swarm with a 10 second update delay. Note that the following example shows an older Redis tag:

..    Deploy Redis 3.0.6 to all nodes in the swarm and configure the swarm to update one node every 10 seconds:

2. Redis のタグを swarm にデプロイし、swarm 上での更新遅延（update delay）を 10 秒に設定します。以下の例では古い Redis タグを使っているので注意してください。

   .. code-block:: bash
   
      $ docker service create \
        --replicas 3 \
        --name redis \
        --update-delay 10s \
        redis:3.0.6
      
      0u6a4s31ybk7yw2wyvtikmu50

   ..    You configure the rolling update policy at service deployment time.

   これはサービスのデプロイ時のローリング・アップデート・ポリシーを設定しました。

   ..    The --update-delay flag configures the time delay between updates to a service task or sets of tasks. You can describe the time T as a combination of the number of seconds Ts, minutes Tm, or hours Th. So 10m30s indicates a 10 minute 30 second delay.

   ``--update-delay`` フラグは、サービス・タスクやタスク・セットを更新する遅延時間を指定します。時間 ``T`` を、秒数 ``Ts``  、分 ``Tm``  、時 ``Th`` の組み合わせで記述できます。たとえば ``10m30s`` は 10 分 30 秒の遅延です。

   .. By default the scheduler updates 1 task at a time. You can pass the --update-parallelism flag to configure the maximum number of service tasks that the scheduler updates simultaneously.

   デフォルトでは、スケジューラは1度に1つのタスクを更新します。 ``--update-parallelism`` フラグを指定することで、スケジューラが同時に更新するサービス・タスクの最大数を調整できます。

   .. By default, when an update to an individual task returns a state of RUNNING, the scheduler schedules another task to update until all tasks are updated. If, at any time during an update a task returns FAILED, the scheduler pauses the update. You can control the behavior using the --update-failure-action flag for docker service create or docker service update

   デフォルトでは、アップデート時に個々のタスクが ``RUNNING`` （実行中）の状態を返したら、スケジューラは他の全てのタスク更新が完了するまでスケジュールします。もしもタスクの更新中に ``FAILED``  の応答があれば、スケジューラは更新を中止します。この挙動は ``docker service create`` や ``docker service update`` で ``--update-failure-action`` のフラグを使って制御できます。

..    Inspect the redis service:

3. ``redis`` サービスを調べます。

   .. code-block:: bash
   
      $ docker service inspect --pretty redis
      
      ID:             0u6a4s31ybk7yw2wyvtikmu50
      Name:           redis
      Service Mode:   Replicated
       Replicas:      3
      Placement:
       Strategy:	    Spread
      UpdateConfig:
       Parallelism:   1
       Delay:         10s
      ContainerSpec:
       Image:         redis:3.0.6
      Resources:

.. Now you can update the container image for redis. The swarm manager applies the update to nodes according to the UpdateConfig policy:

4. ``redis`` 用のコンテナ・イメージを更新します。 swarm マネージャ は ``UpdateConfig`` ポリシーに基づいてノード更新を適用します。

   .. code-block:: bash
   
      $ docker service update --image redis:3.0.7 redis
      redis

   .. The scheduler applies rolling updates as follows by default:

   スケジューラが適用するローリング・アップデートは、以下がデフォルトです。

   ..  Stop the first task.
       Schedule update for the stopped task.
       Start the container for the updated task.
       If the update to a task returns RUNNING, wait for the specified delay period then start the next task.
       If, at any time during the update, a task returns FAILED, pause the update.

   * 1つめのタスクを停止
   * 停止したタスクの更新をスケジュール
   * 更新したタスク用コンテナの起動
   * 更新したタスクが ``RUNNING`` を返したら、指定した遅延期間を待機した後、次のタスクを開始
   * 更新中のあらゆる期間で ``FAILED`` が帰ってきたら、更新を停止

..    Run docker service inspect --pretty redis to see the new image in the desired state:

5. ``docker service inspect --pretty redis`` を実行し、新しいイメージの期待状態を確認します。

   .. code-block:: bash
   
      $ docker service inspect --pretty redis
      
      ID:             0u6a4s31ybk7yw2wyvtikmu50
      Name:           redis
      Service Mode:   Replicated
       Replicas:      3
      Placement:
       Strategy:	    Spread
      UpdateConfig:
       Parallelism:   1
       Delay:         10s
      ContainerSpec:
       Image:         redis:3.0.7
      Resources:
      Endpoint Mode:  vip

   .. The output of service inspect shows if your update paused due to failure:

   ``service inspect`` の出力から、更新の失敗によって一時停止しているのが分かります。

   .. code-block:: bash
   
      $ docker service inspect --pretty redis
      
      ID:             0u6a4s31ybk7yw2wyvtikmu50
      Name:           redis
      ...snip...
      Update status:
       State:      paused
       Started:    11 seconds ago
       Message:    update paused due to failure or early termination of task 9p7ith557h8ndf0ui9s0q951b
      ...snip...

   .. To restart a paused update run docker service update <SERVICE-ID>. For example:

   一時停止した更新を再開するには、 ``docker service update <サービス ID>`` を実行します。実行例：

   .. code-block:: bash
   
      docker service update redis

   .. To avoid repeating certain update failures, you may need to reconfigure the service by passing flags to docker service update.

   更新失敗が続く状態を停止するには、 ``docker service update`` にフラグを追加し、サービスの状態を調整する必要があるでしょう。

.. Run docker service ps <SERVICE-ID> to watch the rolling update:

6. ``docker service ps <タスクID>`` を実行し、ローリング・アップデートを監視します。

   .. code-block:: bash
   
      $ docker service ps redis
      
      NAME                                   IMAGE        NODE       DESIRED STATE  CURRENT STATE            ERROR
      redis.1.dos1zffgeofhagnve8w864fco      redis:3.0.7  worker1    Running        Running 37 seconds
       \_ redis.1.88rdo6pa52ki8oqx6dogf04fh  redis:3.0.6  worker2    Shutdown       Shutdown 56 seconds ago
      redis.2.9l3i4j85517skba5o7tn5m8g0      redis:3.0.7  worker2    Running        Running About a minute
       \_ redis.2.66k185wilg8ele7ntu8f6nj6i  redis:3.0.6  worker1    Shutdown       Shutdown 2 minutes ago
      redis.3.egiuiqpzrdbxks3wxgn8qib1g      redis:3.0.7  worker1    Running        Running 48 seconds
       \_ redis.3.ctzktfddb2tepkr45qcmqln04  redis:3.0.6  mmanager1  Shutdown       Shutdown 2 minutes ago

.. Before Swarm updates all of the tasks, you can see that some are running redis:3.0.6 while others are running redis:3.0.7. The output above shows the state once the rolling updates are done.

Swarm が全てのタスクを更新するまで、 ``redis:3.0.6`` として実行中のイメージが ``redis:3.0.7`` に切り替わるのが見えるでしょう。先ほどの出力はローリング・アップデートが完了した状態です。

.. Next, learn about how to drain a node in the swarm.

次は swarm から :doc:`ノードを解放 <drain-node>` する方法を学びます。

.. seealso:: 

   Apply rolling updates to a service
      https://docs.docker.com/engine/swarm/swarm-tutorial/rolling-update/
