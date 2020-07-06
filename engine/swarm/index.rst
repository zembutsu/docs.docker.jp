.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/swarm/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/swarm/index.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/swarm/index.md
.. check date: 2016/06/21
.. Commits on Jun 20, 2016 c13c5601961bb5ea30e21c9c8c469dd55a2f17d0
.. -----------------------------------------------------------------------------

.. Swarm mode overview

.. _swam-mode-overview:

=======================================
Swarm モード概要
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. To use Docker in swarm mode, install Docker. See
   [installation instructions](../../get-docker.md) for all operating systems and platforms.

Docker の Swarm モードを利用するには、各種のオペレーティング・システムやプラットフォーム向けの `インストール手順 <../../get-docker.html>`_ に従って Docker をインストールしてください。

.. Current versions of Docker include *swarm mode* for natively managing a cluster
   of Docker Engines called a *swarm*. Use the Docker CLI to create a swarm, deploy
   application services to a swarm, and manage swarm behavior.

最新版の Docker には **Swarm モード** が含まれています。
これは **Swarm** と呼ばれる Docker Engine のクラスターをネイティブに管理するものです。
Docker CLI を使って、Swarm の生成、アプリケーション・サービスの Swarm へのデプロイ、Swarm の制御管理を行います。


.. ## Feature highlights

.. _feature-highlights:

特徴的な機能
==============================

.. * **Cluster management integrated with Docker Engine:** Use the Docker Engine
   CLI to create a swarm of Docker Engines where you can deploy application
   services. You don't need additional orchestration software to create or manage
   a swarm.

* **Docker Engine に統合されたクラスタ管理:**
  Docker Engine CLI を利用して Docker Engine の Swarm を生成します。
  これに対してアプリケーション・サービスをデプロイすることができます。
  Swarm の生成や管理にあたって、オーケストレーション・ソフトウェアを別途必要としません。

.. * **Decentralized design:** Instead of handling differentiation between node
   roles at deployment time, the Docker Engine handles any specialization at
   runtime. You can deploy both kinds of nodes, managers and workers, using the
   Docker Engine. This means you can build an entire swarm from a single disk
   image.

* **分散型設計:**
  Docker Engine は、デプロイの際にはノードの役割別に異なった処理を行わず、実行時に特殊な処理を行います。
  Docker Engine において、デプロイできるノードの種類はマネージャとワーカです。
  Swarm 全体は、単一のディスク・イメージから構築できることを意味します。

.. * **Declarative service model:** Docker Engine uses a declarative approach to
   let you define the desired state of the various services in your application
   stack. For example, you might describe an application comprised of a web front
   end service with message queueing services and a database backend.

* **宣言型サービスモデル:**
  Docker Engine は宣言的なアプローチを採用しており、アプリケーション層の各サービスに対して、必要となる状態を定義するということを行います。
  たとえばアプリケーションの記述として、ウェブ・フロントエンド・サービスがあり、メッセージ・キュー・サービスとデータベース・バックエンドから構成されるという記述を行うことがあります。

.. * **Scaling:** For each service, you can declare the number of tasks you want to
   run. When you scale up or down, the swarm manager automatically adapts by
   adding or removing tasks to maintain the desired state.

* **スケーリング:**
  各サービスに対しては、起動させたいタスク数を指定することができます。
  スケールアップやスケールダウンの際に Swarm マネージャは、タスクの追加または削除を行ない、定義された状態を維持するために自動的な対応を行います。

.. * **Desired state reconciliation:** The swarm manager node constantly monitors
   the cluster state and reconciles any differences between the actual state and your
   expressed desired state. For example, if you set up a service to run 10
   replicas of a container, and a worker machine hosting two of those replicas
   crashes, the manager creates two new replicas to replace the replicas that
   crashed. The swarm manager assigns the new replicas to workers that are
   running and available.

* **定義状態への調整:**
  Swarm マネージャ・ノードはクラスタの状態を常時監視しています。
  そして実際の状態と定義された状態との間に差異があれば調整を行います。
  たとえばコンテナのレプリカを 10 にしてサービス設定を行っていて、そのレプリカ 2 つを受け持つワーカ・マシンがクラッシュしたとします。
  マネージャは新たなレプリカ 2 つを生成し直して、クラッシュしたレプリカを置き換えます。
  Swarm マネージャは、利用可能な起動中のワーカに対して、新たなレプリカを割り当てるものです。

.. * **Multi-host networking:** You can specify an overlay network for your
   services. The swarm manager automatically assigns addresses to the containers
   on the overlay network when it initializes or updates the application.

* **マルチホスト・ネットワーク:**
  サービスに対してオーバレイ・ネットワークを設定することができます。
  Swarm マネージャは、アプリケーションの初期化や更新を行う際に、オーバレイ・ネットワーク上のコンテナに対して、アドレスを自動的に割り当てます。

.. * **Service discovery:** Swarm manager nodes assign each service in the swarm a
   unique DNS name and load balances running containers. You can query every
   container running in the swarm through a DNS server embedded in the swarm.

* **サービス検出:**
  Swarm マネージャーノードは、Swarm 内の各サービスに対して固有の DNS 名を割り当てます。
  そして実行コンテナの負荷分散を行います。
  Swarm 内で稼動するコンテナはすべて、Swarm 内に埋め込まれている DNS サーバを通じて問い合わせることが可能です。

.. * **Load balancing:** You can expose the ports for services to an
   external load balancer. Internally, the swarm lets you specify how to distribute
   service containers between nodes.

* **負荷分散:**
  各サービスのポートを外部のロード・バランサへ公開することができます。
  内部的に言えば Swarm は、ノード間においてサービス・コンテナをどのように分散するかを指定できるものです。

.. * **Secure by default:** Each node in the swarm enforces TLS mutual
   authentication and encryption to secure communications between itself and all
   other nodes. You have the option to use self-signed root certificates or
   certificates from a custom root CA.

* **デフォルトで安全:**
  Swarm 内の各ノードでは TLS 相互認証や暗号化が行われるものになっていて、そのノードそのものを含めた全ノード間でのセキュアな通信が行われます。
  自己署名ルート証明書や、カスタムルート CA に基づいた証明書を利用することもできます。

.. * **Rolling updates:** At rollout time you can apply service updates to nodes
   incrementally. The swarm manager lets you control the delay between service
   deployment to different sets of nodes. If anything goes wrong, you can
   roll back to a previous version of the service.

* **ローリング・アップデート:** 
  運用開始時には、ノードに対するサービス・アップデートを追加的に適用していくことができます。
  さまざまなノード・グループにおいてサービス・デプロイのタイミングに差異があっても、Swarm マネージャが管理してくれます。
  仮に何か問題が発生したときには、サービス・バージョンを元に戻すことができます。

.. What's next?

次は何をしますか？
====================

.. ### Swarm mode key concepts and tutorial

.. _swarm-mode-key-concepts-and-tutorial:

Swarm モードの重要な考え方とチュートリアル
-------------------------------------------

.. * Learn swarm mode [key concepts](key-concepts.md).

* Swarm モードの :doc:`重要な考え方 <key-concepts>` について学ぶ。

.. * Get started with the [Swarm mode tutorial](swarm-tutorial/index.md).

* :doc:`Swarm モード・チュートリアル <swarm-tutorial/index>` をはじめる。

.. ### Swarm mode CLI commands

.. _swarm-mode-cli-commands:

Swarm モード CLI コマンド
-------------------------------------------

* swarm モード CLI コマンドを調べる

  * :doc:`swarm init </engine/reference/commandline/swarm_init>`
  * :doc:`swarm join </engine/reference/commandline/swarm_join>`
  * :doc:`swarm create </engine/reference/commandline/swarm_create>`
  * :doc:`swarm inspect</engine/reference/commandline/swarm_inspect>`
  * :doc:`swarm ls</engine/reference/commandline/swarm_ls>`
  * :doc:`swarm rm</engine/reference/commandline/swarm_rm>`
  * :doc:`swarm scale</engine/reference/commandline/swarm_scale>`
  * :doc:`swarm tasks</engine/reference/commandline/swarm_tasks>`
  * :doc:`swarm update</engine/reference/commandline/swarm_update>`


.. seealso:: 

   Swarm mode overview
      https://docs.docker.com/engine/swarm/
