.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/swarm/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/swarm/index.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/swarm/index.md
.. check date: 2016/06/21
.. Commits on Jun 20, 2016 c13c5601961bb5ea30e21c9c8c469dd55a2f17d0
.. -----------------------------------------------------------------------------

.. Advisory: The Swarm mode feature included in Docker Engine 1.12 is a release candidate feature and might be subject to non backward-compatible changes. Some functionality may change before the feature becomes generally available. 

.. hint::

   Swarm モード機能を導入した Docker Engine 1.12 はリリース候補（release candidate）機能であり、後方互換を考慮していない可能性があります。一般リリース（generally available）になるまで、いくつかの機能が変わる可能性があります。

.. Swarm mode overview

.. _swam-mode-overview:

=======================================
Swarm モード概要
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. To use Docker Engine in swarm mode, install the Docker Engine v1.12.0-rc1 or later from the Docker releases GitHub repository. Alternatively, install the latest Docker for Mac or Docker for Windows Beta.

Docker Engine を swarm モードで使うには、 `Docker リリース GitHub リポジトリ <https://github.com/docker/docker/releases>`_ から Docker Engine ``v1.12.0-rc1`` 以降をインストールします。あるいは Docker for Mac か Docker for Windows の最新版をインストールします。

.. Docker Engine 1.12 includes swarm mode for natively managing a cluster of Docker Engines called a Swarm. Use the Docker CLI to create a swarm, deploy application services to a swarm, and manage swarm behavior.

Docker Engine 1.12 は swarm モードを取り込んでいます。Swarm は Docker Engine のクラスタをネイティブに（当たり前に）管理します。Docker CLI で swarm（訳者注；「群れ」という意味で、Docker Engine のクラスタを表す）を作成し、swarm にアプリケーション・サービスをデプロイし、swarm の挙動を管理します。

.. If you’re using a Docker version prior to v1.12.0-rc1, see Docker Swarm.

Docker バージョン ``v1.12.0-rc1`` より低いバージョンをお使いであれば、 :doc:`Docker Swarm </swarm/index>` のドキュメントをご覧ください。

.. Feature highlights

.. _swarm-feature-highlights:

Swarm の主な機能
==============================

.. Cluster management integrated with Docker Engine: Use the Docker Engine CLI to create a Swarm of Docker Engines where you can deploy application services. You don't need additional orchestration software to create or manage a Swarm.

* **Docker Engine にクラスタ管理を統合** : Docker Engine CLI を使い Docker Engine の Swarm（群れ）を作成します。ここにアプリケーション・サービスをデプロイできます。Swarm の作成や管理のために、追加のオーケストレーション・ソフトウェアは不要です。

.. Decentralized design: Instead of handling differentiation between node roles at deployment time, the Docker Engine handles any specialization at runtime. You can deploy both kinds of nodes, managers and workers, using the Docker Engine. This means you can build an entire Swarm from a single disk image.

* **分散化の設計** : デプロイ時点ではノードに役割（role）を与えません。Docker Engine は実行時に役割を明確化します。ノードの種類は、マネージャ（manager）とワーカ（worker）です。この両方を Docker Engine でデプロイできます。つまり１つのディスク・イメージから Swarm（のクラスタ）全体を構築できます。

.. Declarative service model: Docker Engine uses a declarative approach to let you define the desired state of the various services in your application stack. For example, you might describe an application comprised of a web front end service with message queueing services and a database backend.

* **宣言型サービス・モデル** : Docker Engine は宣言型の構文を使います。これを使い、アプリケーション・スタックの様々なサービスの期待状態（desired state）を定義できます。たとえば、ウェブ・フロントエンド・サービスを構成するアプリケーションは、メッセージのキューイング・サービスとデータベース・バックエンドを持つと記述できるでしょう。

.. Scaling: For each service, you can declare the number of tasks you want to run. When you scale up or down, the swarm manager automatically adapts by adding or removing tasks to maintain the desired state.

* **スケーリング（scaling）** : サービスごとに実行したいタスク数を宣言できます。スケールアップやスケールダウン時は、swarm マネージャは期待状態を維持するため、自動的にタスクの追加や削除を行います。

..    Desired state reconciliation: Swarm constantly monitors the cluster state and reconciles any differences between the actual state your expressed desired state.

* **期待状態の調整（reconciliation）** : Swarm は絶えずクラスタ状態の監視と調整をします。監視するのは自分が示した望ましい状態であり、少しでも差違があれば調整の処理を行います。

..    Multi-host networking: You can specify an overlay network for your application. Swarm automatically assigns addresses to the containers on the overlay network when it initializes or updates the application.

* **マルチホスト・ネットワーク** : アプリケーション用のオーバレイ・ネットワークを指定できます。アプリケーションの初期化もしくは更新時に、Swarm はオーバレイ・ネットワーク上のコンテナに自動的にアドレスを割り当てます。

..    Service discovery: Swarm assigns each service a unique DNS name and load balances running containers. Each Swarm has an internal DNS server that can query every container in the cluster using DNS.

* **サービス・ディスカバリ（service discovery）** : Swarm は各サービスにユニークな DNS 名を割り当て、実行中のコンテナに対する負荷分散（load balance）をします。各 Swarm は内部 DNS サーバ（internal DNS server）を持ち、クラスタ内の全てのコンテナを DNS で問い合わせ（クエリ）可能です。

..    Load balancing: Using Swarm, you can expose the ports for services to an external load balancer. Internally, Swarm lets you specify how to distribute service containers between nodes.

* **負荷分散（load balancing）** : Swarm を使えば、サービス用のポートを外部のロードバランサへ公開できます。必要なのは、ノード間でどのようにサービス・コンテナを分散するかを Swarm で指定するだけです。

..    Secure by default: Each node in the Swarm enforces TLS mutual authentication and encryption to secure communications between itself and all other nodes. You have the option to use self-signed root certificates or certificates from a custom root CA.

* **デフォルトで安全** : Swarm 上の各ノードは安全に通信できるように、 TLS 相互認証（TLS mutual authentication）と暗号化を自分自身と他の全てのノード間で強制します。

.. Rolling updates: At rollout time you can apply service updates to nodes incrementally. The swarm manager lets you control the delay between service deployment to different sets of nodes. If anything goes wrong, you can roll-back a task to a previous version of the service.

* **ローリング・アップデート** : ロールアウト時に、サービス更新をノード単位で徐々に適用できます。異なるノード群の間にサービスをデプロイ時、swarm マネージャはノードごとの遅延を制御します。何か問題があれば、サービスのタスクを以前の状態にロールバックできます。

.. What's next?

次は何をしますか？
====================

..  Learn Swarm key concepts.
    Get started with the Swarm tutorial.

* Swarm の :doc:`重要な概念 <key-concepts>` を学ぶ
* :doc:`Swarm チュートリアル <swarm-tutorial/index>` を始める
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
