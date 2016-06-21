.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/swarm/key-concepts/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/swarm/key-concepts.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/swarm/key-concepts.md
.. check date: 2016/06/21
.. Commits on Jun 19, 2016 9499d5fd522e2fa31e5d0458c4eb9b420f164096
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

.. Swarm

.. _swarm-concept-swarm:

Swarm
==========

.. The cluster management and orchestration features embedded in the Docker Engine are built using SwarmKit. Engines participating in a cluster are running in swarm mode. You enable swarm mode for the Engine by either initializing a swarm or joining an existing swarm.

クラスタ管理とオーケストレーション機能は、 **SwarmKit** を使って Docker Engine に組み込まれた（内蔵された）ものです。Engine がクラスタに参加するには、 **swarm モード（swarm mode）** で動作します。swarm の初期化だけでなく、既存の swarm に追加する時も、Engine を swarm モードにします。

.. A swarm is a self-organizing cluster of Docker Engines where you deploy services. The Docker Engine CLI includes the commands for swarm management, such as adding and removing nodes. The CLI also includes the commands you need to deploy services to the swarm and manage service orchestration.

**Swarm** は Docker Engine のクラスタであり、 :ref:`サービス <swarm-concept-services-and-tasks>` 群をデプロイする場所です。Docker Engine CLI には、ノードの追加や削除などの swarm 管理コマンドを含みます。また、 CLI にはサービスを swarm にデプロイするために必要なコマンドや、サービス・オーケストレーションの管理のためのコマンドも含みます。

.. When you run Docker Engine outside of swarm mode, you execute container commands. When you run the Engine in swarm mode, you orchestrate services.

Docker Engine を swarm モード以外で実行時は、コンテナに対するコマンドを処理します。Engine を swarm モードで実行時は、サービスをオーケストレートします。

.. Node

.. _swarm-concept-node:

ノード
==========

.. A node is an instance of the Docker Engine participating in the swarm.

**ノード（node）** とは、Swarm 内に参加する  Docker Engine インスタンスです。

.. To deploy your application to a swarm, you submit a service definition to a manager node. The manager node dispatches units of work called tasks to worker nodes.

アプリケーションを swarm にデプロイするには、 **マネージャ・ノード（manager node）** にサービス定義を送信します。マネージャ・ノードはワーカー・ノードへ :ref:`タスク <swarm-concept-services-and-tasks>` と呼ばれる単位を送ります（ディスパッチします）。

.. Manager nodes also perform the orchestration and cluster management functions required to maintain the desired state of the swarm. Manager nodes elect a single leader to conduct orchestration tasks.

また、マネージャ・ノードは swarm の期待状態（desired state）を維持するために、オーケストレーションと管理機能を処理します。マネージャ・ノードはオーケストレーション・タスクを処理するため、単一のリーダーを選出（elect）します。

.. Worker nodes receive and execute tasks dispatched from manager nodes. By default manager nodes are also worker nodes, but you can configure managers to be manager-only nodes. The agent notifies the manager node of the current state of its assigned tasks so the manager can maintain the desired state.

**ワーカ・ノード（worker nodes）** はマネージャ・ノードから送られてきたタスクの受信と処理をします。デフォルトでは、マネージャ・ノードはワーカー・ノードも兼ねますが、マネージャのみのノード（manager-only node）としてもマネージャを設定可能です。エージェントは割り当てられたタスクの現在の状況をマネージャ・ノードに伝えるため、マネージャは期待状態を維持できます。

.. Services and tasks

.. _swarm-concept-services-and-tasks:

サービスとタスク
====================

.. A service is the definition of how to run the various tasks that make up your application. For example, you may create a service that deploys a Redis image in your Swarm.

**サービス（service）** とは、アプリケーションを作り上げるための様々なタスクを、どのように実行するかという定義です。たとえば、Swarm 内で Redis イメージをデプロイするサービスを作成します。

.. When you create a service, you specify which container image to use and which commands to execute inside running containers.

サービスの作成時に指定するのは、どのコンテナ・イメージを使い、コンテナ内でどのようなコマンドを実行するかです。

.. In the replicated services model, the swarm manager distributes a specific number of replica tasks among the nodes based upon the scale you set in the desired state.

**複製サービス（replicated services）** モデルとは、 期待状態の指定に基づき、swarm マネージャがノード間に複製タスク（replica task）を指定した数だけ分散します。

.. For global services, the swarm runs one task for the service on every available node in the cluster.

**グローバル・サービス（global services）** とは、特定のタスクをクラスタ内の全ノード上で利用可能になるように swarm が実行します。

.. A task carries a Docker container and the commands to run inside the container. It is the atomic scheduling unit of swarm. Manager nodes assign tasks to worker nodes according to the number of replicas set in the service scale. Once a task is assigned to a node, it cannot move to another node. It can only run on the assigned node or fail.

**タスク（task）** とは Docker コンテナを運び、コンテナ内でコマンドを実行します。これは Swarm における最小スケジューリング単位です。マネージャ・ノードはワーカ・ノードに対してタスクを割り当てます。割り当てる数はサービスのスケールで設定されたレプリカ数に応じます。タスクがノードに割り当てられれば、他のノードに移動できません。移動できるのはノードに割り当て時か落ちた時だけです。

.. Load balancing

.. _swarm-concept-load-balanicng:

ロード・バランシング（負荷分散）
========================================

.. The swarm manager uses ingress load balancing to expose the services you want to make available externally to the swarm. The swarm manager can automatically assign the service a PublishedPort or you can configure a PublishedPort for the service in the 30000-32767 range.

Swarm の外部で使いたいサービスを公開するため、swarm マネージャは **イングレス・ロード・バランシング（ingress load balancing）** （訳者注：入ってくるトラフィックに対する負荷分散機構）を使います。Swarm はサービスに対して自動的に **PublishedPort （公開用ポート）** を割り当てられます。あるいは、自分でサービス用の PublishedPort を 30000 ～ 32767 の範囲で設定可能です。

.. External components, such as cloud load balancers, can access the service on the PublishedPort of any node in the cluster whether or not the node is currently running the task for the service. All nodes in the swarm cluster route ingress connections to a running task instance.

クラウドのロードバランサのような外部コンポーネントは、クラスタ上のあらゆるノード上の PublishedPort にアクセスできます。たとえ、対象のノード上でサービス用のタスクが（その時点で）動作していなくてもです。swarm クラスタ上にある全てのノードが、タスクを実行しているインスタンスに接続する経路なのです。

.. Swarm mode has an internal DNS component that automatically assigns each service in the swarm DNS entry. The swarm manager uses internal load balancing distribute requests among services within the cluster based upon the DNS name of the service.

Swarm には内部 DNS コンポーネントがあります。これは各サービスを自動的に Swarm DNS エントリに割り当てます。swarm マネージャは **内部ロード・バランシング（internal load balancing）** を使い、クラスタ内におけるサービスの DNS 名に基づき、サービス間でリクエストを分散します。

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
