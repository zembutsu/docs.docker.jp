.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/samples-for-compose/
.. SOURCE: 
   doc version: v20.10
      https://github.com/docker/docker.github.io/blob/master/compose/samples-for-compose.md
.. check date: 2022/07/18
.. Commits on Jun 3, 2022 d49af6a4495f653ffa40292fd24972b2df5ac0bc
.. -------------------------------------------------------------------

.. Sample apps with Compose
.. _sample-apps-with-compose:
=======================================
Compose のサンプル アプリ
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. The following samples show the various aspects of how to work with Docker Compose. As a prerequisite, be sure to install Docker Compose if you have not already done so.


.. Key concepts these samples cover
.. _compose-key-concepts-these-samples-cover:
各サンプルが扱う主要な概念
==============================

.. The samples should help you to:

各サンプルは、次のように役立つでしょう：

..  define services based on Docker images using Compose files docker-compose.yml and docker-stack.yml files
    understand the relationship between docker-compose.yml and Dockerfiles
    learn how to make calls to your application services from Compose files
    learn how to deploy applications and services to a swarm

* :doc:`Compose ファイル <compose-file>` の ``docker-compose.yml`` と ``docker-stack.yml`` ファイルを使い、 Docker イメージをベースとしたサービスを定義する
* ``docker-compose.yml`` と  :doc:`Dockerfile </engine/reference/builder>` 間との関係性を理解する
* Compose ファイルからアプリケーション サービスを読み出す方法を学ぶ
* :doc:`swarm </engine/swarm/index>` にアプリケーションとサービスをデプロイする方法を学ぶ

.. Samples tailored to demo Compose
.. _samples-tailored-to-demo-compose:
Compose を試すための整った例
========================================

.. These samples focus specifically on Docker Compose:

これらの例は特に Docker Compose に焦点を当てています。

..  Quickstart: Compose and Django - Shows how to use Docker Compose to set up and run a simple Django/PostgreSQL app.
    Quickstart: Compose and Rails - Shows how to use Docker Compose to set up and run a Rails/PostgreSQL app.

    Quickstart: Compose and WordPress - Shows how to use Docker Compose to set up and run WordPress in an isolated environment with Docker containers.

* :doc:`クイックスタート：Compose と Django </samples/django>` - シンプルな Django/PostgreSQL アプリのセットアップと実行に、 Docker Compose を使う方法を示す
* :doc:`クイックスタート：Compose と Rails </samples/rails>` - Rails/PostgreSQL アプリのセットアップと実行に、Docker Compose を使う方法を示す
* :doc:`クイックスタート：Compsoe と WordPress </samples/wordpress>` - Docker コンテナの隔離された環境で、 WordPress のセットアップと実行に Docker Compose を使う例を示す

.. Awesome Compose samples
.. _awesome-compose-samples:
Awesome Compose 例
==============================

.. The Awesome Compose samples provide a starting point on how to integrate different frameworks and technologies using Docker Compose. All samples are available in the Awesome-compose GitHub repo.

Awesome Compose は、異なるフレームワークや技術の統合を Docker Compose ではじめるのに役立つ例を示します。全ての例は `GitHub の Awesome-compose リポジトリ <https://github.com/docker/awesome-compose>`_ にあります。


.. seealso:: 

   Sample apps with Compose
      https://docs.docker.com/compose/samples-for-compose/
