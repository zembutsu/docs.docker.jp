.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/swarm/how-swarm-mode-works/services/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/engine/swarm/how-swarm-mode-works/services.md
   doc version: 19.03
.. check date: 2020/07/11
.. Commits on Jan 26, 2018 a4f5e3024919b0bbfe294e0a4e65b7b6e09c487e
.. -----------------------------------------------------------------------------

.. How services work

.. _swarm-how-services-work:

=======================================
サービスの挙動
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. To deploy an application image when Docker Engine is in swarm mode, you create a service. Frequently a service is the image for a microservice within the context of some larger application. Examples of services might include an HTTP server, a database, or any other type of executable program that you wish to run in a distributed environment.

Docker Engine が swarm モードで 動作時、アプリケーションのイメージをデプロイするには、サービス（service）を作成します。通常、サービスとは、大きなアプリケーションを構成しているマイクロサービス用のイメージです。サービスの例としては、 HTTP サーバ、データベース、その他あらゆる種類の実行可能なプログラムを含み、必要があれば分散環境で実行します。

.. When you create a service, you specify which container image to use and which commands to execute inside running containers. You also define options for the service including:

サービスの作成時、使用するコンテナイメージの指定と、コンテナ内で実行するコマンドの指定をします。また、サービスに対して以下のオプションを含む定義ができます。

..  the port where the swarm makes the service available outside the swarm
    an overlay network for the service to connect to other services in the swarm
    CPU and memory limits and reservations
    a rolling update policy
    the number of replicas of the image to run in the swarm

* swarm を swarm の外からサービスを利用できるようにするポート
* swarm 内のサービスが、他のサービスと接続するためのオーバレイ・ネットワーク
* CPU とメモリの制限と予約
* ローリング・アップデートのポリシー（方針）
* swarm 内で実行するイメージのレプリカ数

.. Services, tasks, and containers

.. _swarm-services-tasks-and-containers:

サービス、タスク、コンテナ
==============================

.. When you deploy the service to the swarm, the swarm manager accepts your service definition as the desired state for the service. Then it schedules the service on nodes in the swarm as one or more replica tasks. The tasks run independently of each other on nodes in the swarm.

swarm に対してサービスをデプロイ時、 swarm manager はサービスに対する定義を期待状態（desired state）として受け取ります。そして、1つまたは複数のレプリカ・タスクを、 サービスとして swarm 上のノードにスケジュールします。タスクは swarm 上にあるノード上でお互い独立して稼働します。

.. For example, imagine you want to load balance between three instances of an HTTP listener. The diagram below shows an HTTP listener service with three replicas. Each of the three instances of the listener is a task in the swarm.

たとえば、 HTTP リスナーが3つあるインスタンス（実体）間での負荷分散を想定します。下図は HTTP リスナー・サービスとして3つのレプリカがあります。リスナーの3つの実体とは、swarm 上における個々のタスクです。

.. services diagram
.. image:: /engine/swarm/images/services-diagram.png
   :alt: サービスの図

.. A container is an isolated process. In the swarm mode model, each task invokes exactly one container. A task is analogous to a “slot” where the scheduler places a container. Once the container is live, the scheduler recognizes that the task is in a running state. If the container fails health checks or terminates, the task terminates.

コンテナとは隔離されたプロセス（isolated process）です。swarm モードのモデル上では、各タスクは正確に1つのコンテナを呼び出し（invokeし）ます。タスクはコンテナをスケジュールして配置する「スロット（slot）」と似ています。コンテナが稼働したら、スケジューラはタスクが実行中の状態であると認識します。もしもコンテナのヘルスチェックで障害が発生するか終了すると、タスクは終了（terminate）とみなします。

.. Tasks and scheduling

.. _tasks-and-scheduling:

タスクとスケジューリング
==============================

.. A task is the atomic unit of scheduling within a swarm. When you declare a desired service state by creating or updating a service, the orchestrator realizes the desired state by scheduling tasks. For instance, you define a service that instructs the orchestrator to keep three instances of an HTTP listener running at all times. The orchestrator responds by creating three tasks. Each task is a slot that the scheduler fills by spawning a container. The container is the instantiation of the task. If an HTTP listener task subsequently fails its health check or crashes, the orchestrator creates a new replica task that spawns a new container.

タスクとは、swarm においてスケジュールをする最小単位です。サービスの作成や更新によって、期待するサービス状態を宣言するとき、オーケストレータによってスケジューリングするタスクの期待状態（desired state）を認識します。たとえば、オーケストレータは常時 HTTP リスナーを3つ実行し続けなさい、といった命令のサービスを定義できます。オーケストレータは3つのタスクを作成をする反応をします。それぞれのタスクはスロットであり、スケジューラはスロットが起動したコンテナで埋まる（満たされる）ようにします。つまり、タスクを実体化（インスタンス化）したものがコンテナです。もしも HTTP リスナーのタスクが、ヘルスチェックやクラッシュによる障害が起こると、オーケストレータは新しいレプリカタスクを作成、つまり、新しいコンテナを作成します。

.. A task is a one-directional mechanism. It progresses monotonically through a series of states: assigned, prepared, running, etc. If the task fails the orchestrator removes the task and its container and then creates a new task to replace it according to the desired state specified by the service.

タスクとは一方通行の仕組みです。タスクは、割り当て、準備、実行など一連の状態を順々に進行します。もしもタスクで障害が起こると、オーケストレータはタスクとそのコンテナを削除します。それから、サービスを定義する期待状態（desired state）に従って、新しいタスクを作成し、置き換えます。

.. The underlying logic of Docker swarm mode is a general purpose scheduler and orchestrator. The service and task abstractions themselves are unaware of the containers they implement. Hypothetically, you could implement other types of tasks such as virtual machine tasks or non-containerized process tasks. The scheduler and orchestrator are agnostic about the type of task. However, the current version of Docker only supports container tasks.

Docker swarm モードの根底となる仕組み（ロジック）は、一般的なスケジューラとオーケストレータを目的としています。コンテナを意識しなくてもいいように、サービスとタスクで抽象化するような実装をしています。仮定ではありますが、仮想マシンのタスクや、コンテナ化していないプロセスのタスクの実装もできるでしょう。スケジューラとオーケストレータは、タスクがどのような種類なのかを認識しません。しかしながら、Docker の現行バージョンのみがコンテナ・タスクをサポートしています。

.. The diagram below shows how swarm mode accepts service create requests and schedules tasks to worker nodes.

下図は、どのようにして swarm mode がサービス作成要求を受け取り、worker ノードに対してタスクをスケジュールするかを説明します。

.. services flow
.. image:: /engine/swarm/images/service-lifecycle.png
   :alt: サービス・フロー

.. Pending services

.. _pending-services:

サービスの保留（pending）
------------------------------

.. A service may be configured in such a way that no node currently in the swarm can run its tasks. In this case, the service remains in state pending. Here are a few examples of when a service might remain in state pending.

サービスを設定したくても、その時点では swarm 上でタスクを実行するノードがない状態もあるでしょう。その場合、サービスの状態は ``penging`` になります。サービスが ``pending`` 状態が続いてしまう、いくつかのケースを取り上げます。

..    Note: If your only intention is to prevent a service from being deployed, scale the service to 0 instead of trying to configure it in such a way that it remains in pending.

.. note::

   目的がデプロイ済みのサービスを抑制したいだけであれば、ここで挙げる ``pending`` 状態にする方法を試みるかわりに、サービスを 0 にスケールします。

..    If all nodes are paused or drained, and you create a service, it is pending until a node becomes available. In reality, the first node to become available gets all of the tasks, so this is not a good thing to do in a production environment.

* サービス作成を試みる時、全てのノードが一次停止もしくはドレイン状態であれば、ノードが利用可能になるまで待機中（pending）になります。ところが、1つめのノードが利用可能になれば、全てのタスク実行をその段階で試みます。そのため、プロダクション環境では望ましくありません。

..    You can reserve a specific amount of memory for a service. If no node in the swarm has the required amount of memory, the service remains in a pending state until a node is available which can run its tasks. If you specify a very large value, such as 500 GB, the task stays pending forever, unless you really have a node which can satisfy it.

* サービスに対してメモリ使用量の予約が可能です。必要なメモリを割り当て可能なノードが swarm になければ、サービスがタスクを実行可能なノードが利用可能になるまで待機中になります。もしも 500GB のような非常に大きなメモリを指定した場合は、本当に要件を満たすノードが現れるまで、タスクは永久に待機中のままになります。

..    You can impose placement constraints on the service, and the constraints may not be able to be honored at a given time.

* サービスを実行する場所に制約（constraint）をつけられます。しかし、場合によっては制約を適用できない可能性があります。

.. This behavior illustrates that the requirements and configuration of your tasks are not tightly tied to the current state of the swarm. As the administrator of a swarm, you declare the desired state of your swarm, and the manager works with the nodes in the swarm to create that state. You do not need to micro-manage the tasks on the swarm.

この挙動について説明すると、タスクの要件と設定は、その時点における swarm の状態と強く結びつきません。あなたが swarm の管理者であれば、 swarm に対して期待する状態を宣言すると、 manager が swarm 内の node において、その状態になるような動作を始めます。あなたが swarm 上のタスクについて細かく管理する必要はありません

.. Replicated and global services

.. _replicated-and-global-services:

複製とグローバル・サービス
==============================

.. There are two types of service deployments, replicated and global.

サービスのデプロイ形式（deployment）は、複製（replicated）とグローバル（global）の2種類です。

.. For a replicated service, you specify the number of identical tasks you want to run. For example, you decide to deploy an HTTP service with three replicas, each serving the same content.

複製サービス（replicated service）とは、実行したいタスクに対して個々の数を指定します。たとえば、3つのレプリカを持つ HTTP サービスをデプロイすると決めると、各レプリカは同じ内容で稼働します。

.. A global service is a service that runs one task on every node. There is no pre-specified number of tasks. Each time you add a node to the swarm, the orchestrator creates a task and the scheduler assigns the task to the new node. Good candidates for global services are monitoring agents, an anti-virus scanners or other types of containers that you want to run on every node in the swarm.

グローバル・サービス（global service）とは、全ノード上でそれぞれ1つのタスクを実行します。タスクの数を事前に指定する必要はありません。swarm に対してノードを追加する度に、オーケストレータはタスクを作成し、スケジューラはこの新しいノードにタスクを割り当てます。グローバル・サービスが適しているのは監視用エージェント、アンチウイルス・スキャナー、その他のタイプのコンテナなど、swarm の各ノード上で実行させたいものです。

.. The diagram below shows a three-service replica in yellow and a global service in gray.

下図では、3つのサービス複製が黄色で、グローバル・サービスが灰色です。

.. global vs replicated services
.. image:: /engine/swarm/images/replicated-vs-global.png
   :alt: グローバル vs レプリカ・サービス



.. Learn more

さらに学ぶ
==========

..  Read about how swarm mode nodes work.
    Learn how PKI works in swarm mode.

* swarm モードの :doc:`ノード <nodes>` の挙動について読む
* swarm モードでの :doc:`PKI <pki>` 挙動について学ぶ


.. seealso:: 

   How services work
      https://docs.docker.com/engine/swarm/how-swarm-mode-works/services/
