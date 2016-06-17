.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/swarm/key-concepts/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/swarm/key-concepts.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/swarm/key-concepts.md
.. check date: 2016/06/16
.. Commits on Jun 15, 2016 7b0c3066e30d721fb9efbac74e9675e1baeb019a
.. -----------------------------------------------------------------------------

.. Docker Swarm key concepts

.. _docker-swam-key-concepts:

=======================================
Docker Swarm の重要な概念
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Building upon the core features of Docker Engine, Docker Swarm enables you to create a Swarm of Docker Engines and orchestrate services to run in the Swarm. This topic describes key concepts to help you begin using Docker Swarm.

Docker Engine のコア機能を積み上げることで、Docker Swarm は Docker Engine の Swarm（群れ）を作成し、Swarm（群れ）の中で統合したサービスを実行できるようになりました。Docker Swarm を使い始める手助けとなる重要な概念を、このトピックで説明します。

.. Swarm

.. _swarm-concept-swarm:

Swarm
==========

.. Docker Swarm is the name for the cluster management and orchestration features embedded in the Docker Engine. Engines that are participating in a cluster are running in Swarm mode.

**Docker Swarm** はクラスタ管理とオーケストレーション機能の名前であり、Docker Engine に組み込まれています。クラスタに参加している Engine は **Swarm ノード（Swarm node）** として動作しています。

.. A Swarm is a cluster of Docker Engines where you deploy a set of application services. When you deploy an application to a Swarm, you specify the desired state of the services, such as which services to run and how many instances of those services. The Swarm takes care of all orchestration duties required to keep the services running in the desired state.

**Swarm** は Docker Engine のクラスタであり、アプリケーション・サービス群をデプロイする場所です。アプリケーションを Swarm にデプロイ時、サービスの期待状態（desired state）を指定します。例えば、あるサービスを実行するために、どれだけのインスタンスが必要なのかです。サービスが期待状態を維持したまま稼働できるように、Swarm は全てのオーケストレーションを管理する義務があります。

.. Node

.. _swarm-concept-node:

ノード
==========

.. A node is an active instance of the Docker Engine in the Swarm.

**ノード（node）** は Swarm 内のアクティブな  Docker Engine インスタンスです。

.. When you deploy your application to a Swarm, manager nodes accept the service definition that describes the Swarm's desired state. Manager nodes also perform the orchestration and cluster management functions required to maintain the desired state of the Swarm. For example, when a manager node receives notice to deploy a web server, it dispatches the service tasks to worker nodes.

Swarm にアプリケーションのデプロイする時、 **マネージャ・ノード（manager node）** がサービスの定義を受け付けます。定義とは Swarm の期待状態です。また、マネージャ・ノードが処理するのはオーケストレーションとクラスタ管理機能です。これは  Swarm の期待状態を維持するために必要です。たとえば、マネージャ・ノードがウェブ・サーバのデプロイ通知を受信すると、サービス・タスクをワーカ・ノード（worker node）に伝えます。

.. By default the Docker Engine starts one manager node for a Swarm, but as you scale you can add more managers to make the cluster more fault-tolerant. If you require high availability Swarm management, Docker recommends three or five Managers in your cluster.

デフォルトでは Docker Engine は１つのマネージャ・ノードを Swarm 用に起動します。ですが、クラスタの耐障害性（フォールト・トレラント）を高めるため、マネージャを追加してスケールすることもできます。高い可用性の Swarm 管理が必要であれば、クラスタ上に３または５つのマネージャ設置を Docker は推奨します。

.. Because Swarm manager nodes share data using Raft, there must be an odd number of managers. The Swarm cluster can continue functioning in the face of up to N/2 failures where N is the number of manager nodes. More than five managers is likely to degrade cluster performance and is not recommended.

Swarm マネージャ・ノードは Raft を使ってデータを共有します。そのため、奇数のマネージャが必要です。Swarm クラスタのマネージャ・ノード数が ``N`` であれば、 ``N/2`` が障害に直面するまで機能を継続できます。

.. Worker nodes receive and execute tasks dispatched from manager nodes. By default manager nodes are also worker nodes, but you can configure managers to be manager-only nodes.

**ワーカ・ノード（worker node）** はマネージャ・ノードから送り出されたタスクを、受信・実行します。デフォルトでは、マネージャ・ノードはワーカ・ノードも兼ねますが、設定によってマネージャ・ノードのみにもできます。

.. Services and tasks

.. _swarm-concept-services-and-tasks:

サービスとタスク
====================

.. A service is the definition of how to run the various tasks that make up your application. For example, you may create a service that deploys a Redis image in your Swarm.

**サービス（service）** とは、アプリケーションを作り上げるための様々なタスクを、どのように実行するかという定義です。たとえば、Swarm 内で Redis イメージをデプロイするサービスを作成します。

.. A task is the atomic scheduling unit of Swarm. For example a task may be to schedule a Redis container to run on a worker node.

**タスク（task）** は Swarm の最小スケジューリング単位（scheduling unit）です。たとえば、タスクで Redis コンテナをワーカ・ノード上で実行するようにスケジュールします。

.. Service types

.. _swarm-concept-service-types:

サービス・タイプ
====================

.. For replicated services, Swarm deploys a specific number of replica tasks based upon the scale you set in the desired state.

**複製されたサービス（replicated services）** とは、Swarm がレプリカ（複製）タスクを一定数デプロイしたサービスです。これは、あらかじめ指定された期待状態に基づきスケールするためです。

.. For global services, Swarm runs one task for the service on every available node in the cluster.

**グローバル・サービス（global services）** とは、あるタスクがクラスタ内の全てのノード上で利用可能なサービスです。

.. Load balancing

.. _swarm-concept-load-balanicng:

ロード・バランシング（負荷分散）
========================================

.. Swarm uses ingress load balancing to expose the services you want to make available externally to the Swarm. Swarm can automatically assign the service a PublishedPort or you can configure a PublishedPort for the service in the 30000-32767 range. External components, such as cloud load balancers, can access the service on the PublishedPort of any node in the cluster, even if the node is not currently running the service.

Swarm の外部で使いたいサービスを公開するため、Swarm は **イングレス・ロード・バランシング（ingress load balancing）** （訳者注：入ってくるトラフィックに対する負荷分散機構）を使います。Swarm はサービスに対して自動的に **PublishedPort （公開用ポート）** を割り当てられます。あるいは、自分でサービス用の PublishedPort を 30000 ～ 32767 の範囲で設定可能です。クラウドのロードバランサのような外部コンポーネントは、クラスタ上のあらゆるノード上の PublishedPort にアクセスできます。たとえ、対象のノード上でサービスが（その時点で）動作していなくてもです。

.. Swarm has an internal DNS component that automatically assigns each service in the Swarm DNS entry. Swarm uses internal load balancing distribute requests among services within the cluster based upon the services' DNS name.

Swarm には内部 DNS コンポーネントがあります。これは各サービスを自動的に Swarm DNS エントリに割り当てます。Swarm は **内部ロード・バランシング（internal load balancing）** を使い、クラスタ内におけるサービスの DNS 名に基づき、サービス間でリクエストを分散します。


.. seealso:: 

   Docker Swarm key concepts
      https://docs.docker.com/engine/swarm/key-concepts/
