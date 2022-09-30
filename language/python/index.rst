.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/language/python/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/language/python/index.md
.. check date: 2022/09/28
.. Commits on Jul 15, 2022 2482f8ce04317b2c56301ea9885bb9a947b232d3
.. -----------------------------------------------------------------------------

.. What will you learn in this module?

========================================
この章で何を学びますか？
========================================

.. The Python getting started guide teaches you how to create a containerized Python application using Docker. In this guide, you’ll learn how to:

Python 導入ガイドでは、 Docker を使ってコンテナ化した Python アプリケーションの作成方法を学びます。このガイドでは、以下の方法を学びます。

..  Create a sample Python application
    Create a new Dockerfile which contains instructions required to build a Python image
    Build an image and run the newly built image as a container
    Set up volumes and networking
    Orchestrate containers using Compose
    Use containers for development
    Configure a CI/CD pipeline for your application using GitHub Actions
    Deploy your application to the cloud

* 簡単な Python アプリケーションの作成
* Python イメージ構築に必要な手順を含む、新しい Dockerfile の作成
* 直近で構築したイメージをコンテナとして実行
* ボリュームとコンテナのセットアップ
* Compose を使ってコンテナをオーケストレート
* コンテナを使ったアプリケーション開発
* GItHub Actions を使ってアプリケーションをの CI/CD パイプラインを設定
* アプリケーションをクラウドにデプロイ

.. After completing the Python getting started modules, you should be able to containerize your own Python application based on the examples and instructions provided in this guide.

Python 導入ガイドの章が終われば、このガイドの例や手順を元に、自分の Python アプリケーションをコンテナ化できるようになります。

.. Let’s get started!

さあ始めましょう！

.. Build your Python image

* :doc:`Python イメージを構築 <build-images>` 

.. seealso::

   What will you learn in this module?
      https://docs.docker.com/language/python/

