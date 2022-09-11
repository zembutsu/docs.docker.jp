.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/swarm/how-swarm-mode-works/swarm-task-states/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/engine/swarm/how-swarm-mode-works/swarm-task-states.md
   doc version: 20.10
.. check date: 2022/04/29
.. Commits on Aug 7, 2021 3b71231970606bb45fd6f37a8c99522583e7f5a8
.. -----------------------------------------------------------------------------

.. Swarm task states

.. _swarm-task-states:

==================================================
swarm タスクの状態
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Docker lets you create services, which can start tasks. A service is a description of a desired state, and a task does the work. Work is scheduled on swarm nodes in this sequence:

Docker でサービスを作成すると、タスクを開始します。サービスは期待状態（desired state）として記述されており、タスクはそれを動かします。動かすとは、以下の手順で swarm ノード上にスケジュールします。

..  Create a service by using docker service create.
    The request goes to a Docker manager node.
    The Docker manager node schedules the service to run on particular nodes.
    Each service can start multiple tasks.
    Each task has a life cycle, with states like NEW, PENDING, and COMPLETE.

1. ``docker service create`` を使ってサービスを作成
2. Docker manager ノードにリクエストが渡る
3. Docker manager ノードは適切なノード上でサービスを実行するようスケジュールする
4. 各サービスは複数のタスクを開始できる
5. タスク毎にライフサイクルと状態を持ち、状態とは ``NEW`` 、 ``PENDING`` 、 ``COMPLETE`` のようなもの

.. Tasks are execution units that run once to completion. When a task stops, it isn’t executed again, but a new task may take its place.

タスクとは、実行が完了するまでの実行を指す単位です。タスクが停止すると再び実行しませんが、新しいタスクがその場所に配置されます。

.. Tasks advance through a number of states until they complete or fail. Tasks are initialized in the NEW state. The task progresses forward through a number of states, and its state doesn’t go backward. For example, a task never goes from COMPLETE to RUNNING.

タスクの利点とは、完了や失敗に至るまで数々の状態を持ちます。タスクの進行には数々の状態がありますが、状態は巻き戻りません。たとえば、 ``COMPLETE`` のタスクは決して ``RUNNING`` になりません。

.. Tasks go through the states in the following order:

タスクの状態は、以下の順番で遷移します。

.. list-table::
   :header-rows: 1
   
   - * タスク状態
     * 説明
   - * ``NEW`` （新規）
     * タスクの初期化
   - * ``PENDING`` （保留）
     * タスクに対するリソースが割り当てられた
   - * ``ASSIGNED`` （割り当て）
     * Docker がノードにタスクを割り当てた
   - * ``ACCEPTED`` （承認）
     * タスクが worker ノードによって承認（受け入れ）。worker ノードがタスクを拒否すると、状態は ``REJECT`` に遷移
   - * ``PREPARING`` （準備中）
     * Docker はタスクを準備中
   - * ``STARTING`` （開始中）
     * Docker はタスクの開始中
   - * ``RUNNING`` （実行中）
     * タスクが実行中
   - * ``COMPLETE`` （完了）
     * タスクがエラーコード無く終了
   - * ``FAILED`` （障害）
     * タスクがエラーコードと共に終了
   - * ``SHUTDOWN`` （停止）
     * Docker がタスクの停止を供給
   - * ``REJECTED`` （拒否）
     * worker ノードがタスクを拒否
   - * ``ORPHANED`` （孤立）
     * 長期間にわたりノードが停止
   - * ``REMOVE`` （削除）
     * タスクは停止していないものの、関連するサービスが削除されたかスケールダウン

.. View task state

.. _view-task-state:

タスク状態の表示
====================

.. Run docker service ps <service-name> to get the state of a task. The CURRENT STATE field shows the task’s state and how long it’s been there.

タスクの状態を取得するには ``docker service ps <サービス名>`` を実行します。 ``CURRENT STATE`` 列でタスクの状態と、どれだけ存在しているかが分かります。

.. code-block:: bash

   $ docker service ps webserver
   ID             NAME              IMAGE    NODE        DESIRED STATE  CURRENT STATE            ERROR                              PORTS
   owsz0yp6z375   webserver.1       nginx    UbuntuVM    Running        Running 44 seconds ago
   j91iahr8s74p    \_ webserver.1   nginx    UbuntuVM    Shutdown       Failed 50 seconds ago    "No such container: webserver.…"
   7dyaszg13mw2    \_ webserver.1   nginx    UbuntuVM    Shutdown       Failed 5 hours ago       "No such container: webserver.…"

.. Where to go next

次はどこへ
====================

..    Learn about swarm tasks

* `swarm のタスク設計を学ぶ（英語） <https://github.com/docker/swarmkit/blob/master/design/task_model.md>`_ 


.. seealso:: 

   Swarm task states
      https://docs.docker.com/engine/swarm/how-swarm-mode-works/pki/
