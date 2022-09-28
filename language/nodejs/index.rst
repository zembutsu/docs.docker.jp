.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/language/nodejs/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/language/nodejs/index.md
.. check date: 2022/09/23
.. Commits on Jul 15, 2022 2482f8ce04317b2c56301ea9885bb9a947b232d3
.. -----------------------------------------------------------------------------

.. What will you learn in this module?

========================================
この章で何を学びますか？
========================================

.. The Node.js getting started guide teaches you how to create a containerized Node.js application using Docker. In this guide, you’ll learn how to:

Node.js 導入ガイドでは、 Docker を使ってコンテナ化した Node.js アプリケーションの作成方法を学びます。このガイドでは、以下の方法を学びます。

..  Create a simple Node.js application
    Create a new Dockerfile which contains instructions required to build a Node.js image
    Run the newly built image as a container
    Set up a local development environment to connect a database to the container
    Use Docker Compose to run the Node.js application
    Configure a CI/CD pipeline for your application using GitHub Actions.

* 簡単な Node.js アプリケーションの作成
* Node.js イメージ構築に必要な手順を含む、新しい Dockerfile の作成
* 直近で構築したイメージをコンテナとして実行
* コンテナをデータベースに接続するため、ローカルな開発環境のセットアップ
* Docker Compose を使って Node.js アプリケーションを実行
* GItHub Actions を使って CI/CD パイプラインの設定

.. After completing the Node.js getting started modules, you should be able to containerize your own Node.js application based on the examples and instructions provided in this guide.

Node.js 導入ガイドの章が終われば、このガイドの例や手順を元に、自分の Node.js アプリケーションをコンテナ化できるようになります。

.. Let’s get started!

さあ始めましょう！

.. Build your Node.js image

* :doc:`Node.js イメージを構築 <build-images>` 

.. seealso::

   What will you learn in this module? | Docker Documentation
      https://docs.docker.com/language/nodejs/


