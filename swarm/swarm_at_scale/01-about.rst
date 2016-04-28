.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/swarm/swarm_at_scale/01-about/
.. SOURCE: https://github.com/docker/swarm/blob/master/docs/swarm_at_scale/01-about.md
   doc version: 1.10
      https://github.com/docker/swarm/commits/master/docs/swarm_at_scale/01-about.md
.. check date: 2016/03/03
.. Commits on Feb 28, 2016 ec8ceae209c54091065c8f9e50439bd76255b022
.. -------------------------------------------------------------------

.. Learn the application architecture

.. _learn-the-application-architecture:

=======================================
アプリケーションのアーキテクチャを学ぶ
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. On this page, you learn about the Swarm at scale example. Make sure you have read through the introduction to get an idea of the skills and time required first.

このページでは、Swarm をスケールさせるサンプルについて学びます。まず :doc:`導入ページ <index>` を読み、必要となるスキルや時間を検討ください。

.. Learn the example back story

サンプルの背景を学ぶ
====================

.. Your company is a pet food company that has bought a commercial during the Superbowl. The commercial drives viewers to a web survey that asks users to vote – cats or dogs. You are developing the web survey.

あなたの会社はペットフード会社であり、スーパーボウルのコマーシャル枠を購入しようとしています。コマーシャルでは、視聴者に対して調査のために犬か猫かの投票を呼びかけます。あなたはウェブ投票システムを開発します。

.. Your survey must ensure that millions of people can vote concurrently without your website becoming unavailable. You don’t need real-time results, a company press release announces the results. However, you do need confidence that every vote is counted.

この調査では100万人もの人々が投票してもウェブサイトが止まらないようにする必要があります。結果をリアルタイムで知る必要はなく、結果は会社のプレスリリースで公開します。しかし、どれだけ投票されたかは、投票の度に確実に把握する必要があります。

.. Understand the application architecture

.. _understand-the-application-architecture:

アプリケーションのアーキテクチャを理解
========================================

.. The voting application is a dockerized microservice application. It uses a parallel web frontend that sends jobs to asynchronous background workers. The application’s design can accommodate arbitrarily large scale. The diagram below shows the high level architecture of the application.


投票アプリケーションは Docker 化されたマイクロサービス・アプリケーションです。並列なウェブ・フロントエンドを使い、ジョブを非同期のバックグラウンド・ワーカに送ります。アプリケーションは任意に大きくスケール可能な設計です。次の図はアプリケーションのハイレベルなアーキテクチャです。

.. image:: ../images/app-architecture.png
   :scale: 60%

.. The application is fully Dockerized with all services running inside of containers.

このアプリケーションは完全に Docker 化（Dockerized）しており、全てのサービスをコンテナ内で実行します。

.. The frontend consists of an Interlock load balancer with n frontend web servers and associated queues. The load balancer can handle an arbitrary number of web containers behind it (frontend01- frontendN). The web containers run a simple Python Flask application. Each container accepts votes and queues them to a Redis container on the same node. Each web container and Redis queue pair operates independently.

フロントエンドは interlock ロード・バランサと n 台のフロントエンド・ウェブサーバで構成され、クエリを作成します。ロードバランサは任意の数のウェブ・コンテナを背後で扱えます（ ``frontend01`` ～ ``frontendN`` ）。Webコンテナはシンプルな Python Flask アプリケーションです。各コンテナは投票を受け付け、同じノード上の Redis コンテナにキューを渡します。各ウェブ・コンテナと Redis キューのペアは独立して処理されます。

.. The load balancer together with the independent pairs allows the entire application to scale to an arbitrary size as needed to meet demand.

このペアはロードバランサと個別に連係できます。そのため、アプリケーション全体を需要に応じて任意の大きさにスケール可能です。

.. Behind the frontend is a worker tier which runs on separate nodes. This tier:

フロントエンドの背後にはワーカ層があり、別々のノードが動いています。この層は、

..    scans the Redis containers
    dequeues votes
    deduplicates votes to prevent double voting
    commits the results to a Postgres container running on a separate node

* Redis コンテナをスキャン
* 投票のキューを回収
* 重複投票を防ぐために投票結果を複製
* 別のノードにある PostgreSQL が動いているコンテナに結果をコミットする

.. Just like the front end, the worker tier can also scale arbitrarily.

フロントエンドと同様に、ワーカー層も任意にスケールできます。

.. Swarm Cluster Architecture

.. _swarm-cluster-architecture:

Swarm クラスタのアーキテクチャ
------------------------------

.. To support the application the design calls for a Swarm cluster that with a single Swarm manager and 4 nodes as shown below.

アプリケーションの設計をサポートするのが、１つの Swarm マネージャと４つのノードで構成される Swarm クラスタです。

.. image:: ../images/swarm-cluster-arch.png
   :scale: 60%

.. All four nodes in the cluster are running the Docker daemon, as is the Swarm manager and the Interlock load balancer. The Swarm manager exists on a Docker host that is not part of the cluster and is considered out of band for the application. The Interlock load balancer could be placed inside of the cluster, but for this demonstration it is not.

クラスタの４つのノードすべてで Docker デーモンが動作します。Swarm マネージャと interlock ロードバランサも同様です。Swarm マネージャは Docker ホスト上に存在します。これはクラスタの一部ではなく、アプリケーションの外にあるものと考えます。Interlock ロードバランサはクラスタ内に設置可能ですが、今回のサンプルでは扱いません。

.. The diagram below shows the application architecture overlayed on top of the Swarm cluster architecture. After completing the example and deploying your application, this is what your environment should look like.

以下の図は Swarm クラスタのアーキテクチャ上に、アプリケーションのアプリケーションを重ねています。このサンプルを終え、アプリケーションをデプロイすると、次のような環境が整います。

.. image:: ../images/final-result.png
   :scale: 60%


.. As the previous diagram shows, each node in the cluster runs the following containers:

この図にあるように、クラスタの各ノードでは次のコンテナを実行します。

..    frontend01:
        Container: Pyhton flask web app (frontend01)
        Container: Redis (redis01)
    frontend02:
        Container: Python flask web app (frontend02)
        Container: Redis (redis02)
    worker01: vote worker app (worker01)
    store:
        Container: Postgres (pg)
        Container: results app (results-app)

* ``frontend01`` ：

  * コンテナ：Python flask ウェブアプリ（frontend01）
  * コンテナ：Redis（redis01）

* ``frontend02`` ：

  * コンテナ：Python flask ウェブアプリ（frontend02）
  * コンテナ：Redis（redis02）

* ``worker01`` ：投票ワーカーアプリ（worker01）
* ``store`` ：

  * コンテナ：Postgres（pg）
  * コンテナ：results アプリ（results-app）

.. After you deploy the application, you’ll configure your local system so that you can test the application from your local browser. In production, of course, this step wouldn’t be needed.

アプリケーションをデプロイするとき、ローカル・システムを設定するとローカルのブラウザ上でアプリケーションをテスト可能です。プロダクションでは、もちろんこの手順は不要です。

.. The network infrastructure

.. _the-network-infrastructure:

ネットワーク・インフラ
==============================

.. The example assumes you are deploying the application to a Docker Swarm cluster running on top of Amazon Web Services (AWS). AWS is an example only. There is nothing about this application or deployment that requires it. You could deploy the application to a Docker Swarm cluster running on; a different cloud provider such as Microsoft Azure, on premises in your own physical data center, or in a development environment on your laptop.

このサンプルではアプリケーションを Amazon Web Services (AWS) 上の Swarm クラスタにデプロイします。AWS を使うのは単なる例です。このアプリケーションやデプロイに必要なだけです。皆さん自身で、任意のプラットフォーム上で環境設計を再現可能です。例えば、 Digital Ocean のような別のパブリック・クラウド・プラットフォームや、データセンタ内のオンプレミス上や、ノート PC 上のテスト環境にもアプリケーションをデプロイできます。

.. Next step

次のステップ
====================

.. Now that you understand the application architecture, you need to deploy a network configuration that can support it. In the next step, you use AWS to deploy network infrastructure for use in this sample.

これでアプリケーションのアーキテクチャを理解しましたの。デプロイするにあたり、どのようなネットワーク設定をサポートする必要があるのか分かったと思います。次のステップでは、このサンプルを使って AWS 上に :doc:`ネットワーク・インフラをデプロイ <02-deploy-infra>` します。

.. seealso:: 

   Learn the application architecture
      https://docs.docker.com/swarm/swarm_at_scale/01-about/
