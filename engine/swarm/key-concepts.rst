.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/swarm/key-concepts/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/swarm/key-concepts.md
   doc version: 1.12
.. check date: 2029/07/06
.. Commits on Apr 8, 2020 777c5d23dafd4b640016f24f92fe416f246ec848
.. -----------------------------------------------------------------------------

.. Swarm mode key concepts

.. swam-mode-key-concepts:

=======================================
Swarm モードの重要な概念
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Building upon the core features of Docker Engine, Docker Swarm enables you to create a Swarm of Docker Engines and orchestrate services to run in the Swarm. This topic describes key concepts to help you begin using Docker Swarm.

.. Docker Engine のコア機能を積み上げることで、Docker Swarm は Docker Engine の Swarm（群れ）を作成し、Swarm（群れ）の中で統合したサービスを実行できるようになりました。Docker Swarm を使い始める手助けとなる重要な概念を、このトピックで説明します。

.. This topic introduces some of the concepts unique to the cluster management and orchestration features of Docker Engine 1.12.

このトピックでは、Docker Engine 1.12 の独特の概念であるクラスタ管理とオーケストレーション機能を紹介します。

.. What is a swarm?

.. _swarm-concept-swarm:

Swarm とは何でしょうか？
==============================

.. The cluster management and orchestration features embedded in the Docker Engine are built using swarmkit. Swarmkit is a separate project which implements Docker’s orchestration layer and is used directly within Docker.

クラスタ管理とオーケストレーション機能は、 **SwarmKit** を使って Docker Engine に組み込まれた（内蔵された）ものです。Swarmkit は Docker のオーケストレーション層を実装する独立したプロジェクトであり、Docker 内で直接使われます。

.. A swarm consists of multiple Docker hosts which run in swarm mode and act as managers (to manage membership and delegation) and workers (which run swarm services). A given Docker host can be a manager, a worker, or perform both roles. When you create a service, you define its optimal state (number of replicas, network and storage resources available to it, ports the service exposes to the outside world, and more). Docker works to maintain that desired state. For instance, if a worker node becomes unavailable, Docker schedules that node’s tasks on other nodes. A task is a running container which is part of a swarm service and managed by a swarm manager, as opposed to a standalone container.

**swarm モード** で動作する複数の Docker ホストにより、 swarm （訳者注：ノードによって構成されるクラスタを意味する「群れ」の表現）を構成し、manager （メンバーと委任の管理）の役割と worker （ :ref:`swarm サービス <swarm-services-and-tasks>` を実行する）の役割があります。Docker ホストには、manager か、 worker か、あるいは両方の役割を与えられます。サービスを作成するとき、最適の状態（optimal state）を定義します（レプリカ数、サービスが利用できるネットワークとストレージのリソース、世界に公開するサービス用ポート、など）。Docker はこの desired state（期待状態）を維持するよう動作します。たとえば、worker ノードが利用不可能になれば、Docker はノードのタスクを他のノード上にスケジュールします。タスク（ `task` ）とは swarm サービスの一部として実行中のコンテナであり、スタンドアロン・コンテナとは異なり swarm manager によって管理されます。

.. One of the key advantages of swarm services over standalone containers is that you can modify a service’s configuration, including the networks and volumes it is connected to, without the need to manually restart the service. Docker will update the configuration, stop the service tasks with the out of date configuration, and create new ones matching the desired configuration.

スタンドアロン・コンテナと比べた swarm サービスの重要な強みの1つは、サービスの設定を変更可能な点です。サービスだけでなく、サービスに接続するネットワークとボリュームも含みます。そして、手動でサービスを再起動する必要はありません。Docker は設定を更新すると、期待する設定に一致するように、無効となったサービス・タスクを停止し、新しいサービス・タスクを作成します。

.. When Docker is running in swarm mode, you can still run standalone containers on any of the Docker hosts participating in the swarm, as well as swarm services. A key difference between standalone containers and swarm services is that only swarm managers can manage a swarm, while standalone containers can be started on any daemon. Docker daemons can participate in a swarm as managers, workers, or both.

Docker を swarm モードで動かすと、swarm （クラスタの意味）に参加している Docker ホスト上では、swarm サービス同様に、スタンドアロン・コンテナも実行できます。スタンドアロン・コンテナと swarm サービスとの重要な違いとは、swarm manager だけが swarm を管理可能であり、スタンドアロン・コンテナはデーモンだけが起動できます。Docker デーモンは swarm に対して manager か worker か、あるいは両方の役割で参加できます。

.. In the same way that you can use Docker Compose to define and run containers, you can define and run Swarm service stacks.

:doc:`Docker Compose </compose/index>` を使ってコンテナの定義と実行ができるのと同じ方法で、 :doc:`Swarm service <services>` スタックの定義・実行が行えます。

.. Keep reading for details about concepts relating to Docker swarm services, including nodes, services, tasks, and load balancing.

Docker swarm サービスに関連する概念の詳細に含まれるノード、サービス、タスク、負荷分散についての詳細は、このまま読み進めてください。

.. Nodes

.. _swarm-concept-node:


ノード（nodes）
====================

.. A node is an instance of the Docker engine participating in the swarm. You can also think of this as a Docker node. You can run one or more nodes on a single physical computer or cloud server, but production swarm deployments typically include Docker nodes distributed across multiple physical and cloud machines.

.. A node is an instance of the Docker Engine participating in the swarm.

**ノード（node）** とは、swarm （クラスタ）に参加している  Docker Engine のことです。これを Docker ノードと考えることもできます。1つまたは複数のノードを1つの物理コンピュータ上、あるいは、クラウドサーバ上で実行できます。とはいえ、プロダクションで展開する swarm に典型的に含む Docker ノードは、複数の物理またはクラウドマシン上にわたります。

.. To deploy your application to a swarm, you submit a service definition to a manager node. The manager node dispatches units of work called tasks to worker nodes.

アプリケーションを swarm に展開（デプロイ）するには、 **manager ノード（マネージャ・ノード）** にサービス定義を送信します。manager ノード は worker ノードに対し、 :ref:`タスク <swarm-concept-services-and-tasks>` と呼ばれる単位で送信（ディスパッチ）します。

.. Manager nodes also perform the orchestration and cluster management functions required to maintain the desired state of the swarm. Manager nodes elect a single leader to conduct orchestration tasks.

また、manager ノードは swarm の期待状態（desired state）を維持するために、オーケストレーションと管理機能を処理します。 manager ノードはオーケストレーション・タスクを処理するため、単一のリーダーを選出（elect）します。

.. Worker nodes receive and execute tasks dispatched from manager nodes. By default manager nodes also run services as worker nodes, but you can configure them to run manager tasks exclusively and be manager-only nodes. An agent runs on each worker node and reports on the tasks assigned to it. The worker node notifies the manager node of the current state of its assigned tasks so that the manager can maintain the desired state of each worker.

.. Worker nodes receive and execute tasks dispatched from manager nodes. By default manager nodes are also worker nodes, but you can configure managers to be manager-only nodes. The agent notifies the manager node of the current state of its assigned tasks so the manager can maintain the desired state.

**warker ノード（worker nodes）** は、 manager ノードから送られてきたタスクの受信と実行をします。デフォルトでは、 manager ノードは worker ノードも兼ねますが、manager 機能のみを持つノード（manager-only node）としても設定できます。各 worker ノード上で動作するエージェントは、ノードに割り当てられたタスクを manager ノードに通知します。 worker ノードは、自身に割り当てられているタスクに対する、現在の状態を manager ノードに対して通知しますので、manager が各 worker に対する期待状態を維持できます。

.. Services and tasks

.. _swarm-concept-services-and-tasks:

サービスとタスク
====================

.. A service is the definition of the tasks to execute on the manager or worker nodes. It is the central structure of the swarm system and the primary root of user interaction with the swarm.

**サービス（service）** とは、 manager ノードや worker ノード上で実行するタスクについての定義です。これは swarm システムにおける中心となる構造であり、ユーザが swarm と相互にやりとりする主要なものです。

.. When you create a service, you specify which container image to use and which commands to execute inside running containers.

サービスの作成時に指定するのは、どのコンテナ・イメージを使い、コンテナ内でどのようなコマンドを実行するかです。

.. In the replicated services model, the swarm manager distributes a specific number of replica tasks among the nodes based upon the scale you set in the desired state.

**replicated （複製）サービス** モデルとは、 期待状態の指定に基づき、swarm manager は複製タスク（replica task）を指定した数だけ、ノード間で分散します。

.. For global services, the swarm runs one task for the service on every available node in the cluster.

**グローバル・サービス（global services）** とは、特定のタスクをクラスタ内の全ノード上で利用可能になるように swarm が実行します。

.. A task carries a Docker container and the commands to run inside the container. It is the atomic scheduling unit of swarm. Manager nodes assign tasks to worker nodes according to the number of replicas set in the service scale. Once a task is assigned to a node, it cannot move to another node. It can only run on the assigned node or fail.

**タスク（task）** は Docker コンテナを運ぶもので、そのコンテナ内でコマンドを実行します。これは Swarm における最小スケジューリング単位です。manager ノードは worker ノードに対して、サービスのスケール（訳者注：service scale サブコマンドなどで指定）を設定したレプリカ数に応じて、タスクを割り当てます。タスクがノードに割り当てられれば、他のノードに移動できません。タスクが移動できるのは、ノードへの割り当て時か障害発生時のみです。

.. Load balancing

.. _swarm-concept-load-balanicng:

ロード・バランシング（負荷分散）
========================================

.. The swarm manager uses ingress load balancing to expose the services you want to make available externally to the swarm. The swarm manager can automatically assign the service a PublishedPort or you can configure a PublishedPort for the service. You can specify any unused port. If you do not specify a port, the swarm manager assigns the service a port in the 30000-32767 range.

swarm マネージャは **イングレス・ロード・バランシング（ingress load balancing）** （訳者注：入ってくるトラフィックに対する負荷分散するしくみ）を使い、swarm の外から利用可能にしたいポートを公開できます。swarm manager はサービスに対し、自動的に **PublishedPort （公開用ポート）** を割り当て可能です。また、自分で未使用ポートも割り当てられます。ポートの指定が無ければ、 swarm manager が 30000 ～ 32767 の範囲でポートを割り当てます。

.. External components, such as cloud load balancers, can access the service on the PublishedPort of any node in the cluster whether or not the node is currently running the task for the service. All nodes in the swarm route ingress connections to a running task instance.

クラウドのロードバランサのような外部コンポーネントは、クラスタ上のあらゆるノード上の PublishedPort にアクセスできます。たとえ、対象のノード上でサービス用のタスクが（その時点で）動作していなくてもです。swarm クラスタ上にある全てのノードが、タスクを実行している実体に接続するための径路になります。

.. Swarm mode has an internal DNS component that automatically assigns each service in the swarm a DNS entry. The swarm manager uses internal load balancing to distribute requests among services within the cluster based upon the DNS name of the service.


Swarm mode には内部 DNS コンポーネントがあります。これは swarm 内の各サービスに対して、自動的に DNS エントリに割り当てます。swarm マネージャは **内部ロード・バランシング（internal load balancing）** を使い、クラスタ内におけるサービスの DNS 名に基づき、サービス間でリクエストを分散します。

次はどうしますか？
====================

.. 
    Read the swarm mode overview.
    Get started with the swarm mode tutorial.

* :doc:`swarm モード概要 <index>` を読む
* :doc:`swarm モード・チュートリアル <swarm-tutorial/index>` を始める

.. seealso:: 

   Docker Swarm key concepts
      https://docs.docker.com/engine/swarm/key-concepts/
