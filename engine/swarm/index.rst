.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/swarm/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/swarm/index.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/swarm/index.md
.. check date: 2016/06/16
.. Commits on Jun 14, 2016 ea4fef2d875de39044ca7570c35365b75086e8a5
.. -----------------------------------------------------------------------------

.. Docker Swarm overview

.. _docker-swam-overview:

=======================================
Docker Swarm 概要
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. To use this version of Swarm, install the Docker Engine v1.12.0-rc1 or later from the Docker releases GitHub repository. Alternatively, install the latest Docker for Mac or Docker for Windows Beta.

このバージョンの Swarm を使うには、 `Docker リリース GitHub リポジトリ <https://github.com/docker/docker/releases>`_ から Docker Engine ``v1.12.0-rc1`` 以降をインストールします。あるいは Docker for Mac か Docker for Windows の最新版をインストールします。

.. Docker Engine 1.12 includes Docker Swarm for natively managing a cluster of Docker Engines called a Swarm. Use the Docker CLI to create a Swarm, deploy application services to the Swarm, and manage the Swarm behavior.

Docker Engine 1.12 は Docker Swarm を Swarm として取り込んでいます。Swarm は Docker Engine のクラスタをネイティブに（当たり前に）管理します。Docker CLI で Swarm（訳者注；「群れ」という意味で、Docker Engine のクラスタを表す）を作成し、Swarm にアプリケーション・サービスをデプロイし、Swarm の挙動を管理します。

.. If you’re using a Docker version prior to v1.12.0-rc1, see Docker Swarm.

Docker バージョン ``v1.12.0-rc1`` より低いバージョンをお使いであれば、 :doc:`Docker Swarm </swarm/index>` のドキュメントをご覧ください。

.. Feature highlights

.. _swarm-feature-highlights:

Swarm 機能のハイライト
==============================

..    Cluster management integrated with Docker Engine: Use the Docker Engine CLI to create a Swarm of Docker Engines where you can deploy application services. You don't need additional orchestration software to create or manage a Swarm.

* **Docker Engine にクラスタ管理を統合** : Docker Engine CLI を使い Docker Engine の Swarm（群れ）を作成します。ここにアプリケーション・サービスをデプロイできます。Swarm の作成や管理のために、追加のオーケストレーション・ソフトウェアは不要です。

..    Decentralized design: Instead of handling differentiation between node roles at deployment time, Swarm handles any specialization at runtime. You can deploy both kinds of nodes, managers and workers, using the Docker Engine. This means you can build an entire Swarm from a single disk image.

* **分散化した設計** : デプロイ時点ではノードに役割（role）を与えません。Swarm は実行時に役割を明確化します。ノードの種類は、マネージャ（manager）とワーカ（worker）です。この両方を Docker Engine でデプロイできます。つまり１つのディスク・イメージから Swarm（のクラスタ）全体を構築できます。

..    Declarative service model: Swarm uses a declarative syntax to let you define the desired state of the various services in your application stack. For example, you might describe an application comprised of a web front end service with message queueing services and a database backend.

* **宣言型サービス・モデル** : Swarm は宣言型の構文を使います。これを使い、アプリケーション・スタックの様々なサービスの望ましい状態（desired state）を定義できます。たとえば、ウェブ・フロントエンド・サービスを構成するアプリケーションは、メッセージのキューイング・サービスとデータベース・バックエンドを持つと記述できるでしょう。

..    Desired state reconciliation: Swarm constantly monitors the cluster state and reconciles any differences between the actual state your expressed desired state.

* **望ましい状態の調整（reconciliation）** : Swarm は絶えずクラスタ状態の監視と調整をします。監視するのは自分が示した望ましい状態であり、少しでも差違があれば調整の処理を行います

..    Multi-host networking: You can specify an overlay network for your application. Swarm automatically assigns addresses to the containers on the overlay network when it initializes or updates the application.

* **マルチホスト・ネットワーク** : 

..    Service discovery: Swarm assigns each service a unique DNS name and load balances running containers. Each Swarm has an internal DNS server that can query every container in the cluster using DNS.

* **** : 

..    Load balancing: Using Swarm, you can expose the ports for services to an external load balancer. Internally, Swarm lets you specify how to distribute service containers between nodes.

* **** : 

..    Secure by default: Each node in the Swarm enforces TLS mutual authentication and encryption to secure communications between itself and all other nodes. You have the option to use self-signed root certificates or certificates from a custom root CA.

* **** : 

..    Scaling: For each service, you can declare the number of instances you want to run. When you scale up or down, Swarm automatically adapts by adding or removing instances of the service to maintain the desired state.

* **** : 

..    Rolling updates: At rollout time you can apply service updates to nodes incrementally. Swarm lets you control the delay between service deployment to different sets of nodes. If anything goes wrong, you can roll-back an instance of a service.

* **** : 

.. What's next?

次は何をしますか？
====================

..  Learn Swarm key concepts.
    Get started with the Swarm tutorial.

* Swarm の :doc:`重要な概念 <key-concepts>` を学ぶ
* :doc:`Swarm チュートリアル <swarm-tutorial/index>` を始める


.. seealso:: 

   Docker Swarm overview
      https://docs.docker.com/engine/swarm/
