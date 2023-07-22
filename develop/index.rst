.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/develop/
   doc version: 24.0
      https://github.com/docker/docker.github.io/blob/master/develop/index.md
.. check date: 2023/07/21
.. Commits on Dec 20, 2022 21105dd888590c42ac6a9f7a9bfbd0921dadd6b3
.. -----------------------------------------------------------------------------

.. Develop with Docker
.. _develop-with-docker:

========================================
Docker で開発
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 2
       :local:

.. This page contains a list of resources for application developers who would like to build new applications using Docker.

このページで扱うのは、Docker を使って新しいアプリケーションを作ろうと考えている、アプリケーション開発者向けのリソース一覧です。

.. Prerequisites

.. _develop-prerequisites:

事前準備
==========

.. Work through the learning modules in Get started to understand how to build an image and run it as a containerized application.

コンテナ化したアプリケーションのイメージ構築と実行を理解するには、 :doc:`導入ガイド </get-started/index>` にある学習コースを学んでください。

.. Develop new apps on Docker
.. _develop-new-app-on-dokcer:

Docker で新しいアプリを開発
==============================

.. If you’re just getting started developing a brand new app on Docker, check out these resources to understand some of the most common patterns for getting the most benefits from Docker.

ちょうどこれから Docker 上で真新しいアプリケーションの開発を始めようとしているのであれば、Docker を最も活用するための共通パターンを理解するため、以下のリソースを御覧ください。

..  Learn how to build an image using a Dockerfile
    Use multi-stage builds to keep your images lean
    Manage application data using volumes and bind mounts
    Scale your app with Kubernetes
    Scale your app as a Swarm service
    General application development best practices

* Dockerfile を使って :doc:`イメージ構築 </engine/reference/builder>` の仕方を学ぶ
* イメージをスリムにし続けるため、 :doc:`マルチステージ・ビルド </build/building/multi-stage>` を使う
* :doc:`ボリューム </storage/volume>` と :doc:`バインド マウント </storage/bind-mounts>` を使いアプリケーションのデータを管理
* :doc:`Kubernetes でサービスをスケールする </get-started/kube-deploy>`
* :doc:`Swarm サービスとしてアプリケーションをスケールする </get-started/swarm-deploy>`
* :doc:`一般的なアプリケーション開発のベストプラクティス </develop/dev-best-practices>`

.. Learn about language-specific app development with Docker
.. _learn-about-language-specific-app-development-with-docker:

Docker で言語特有のアプリケーション開発を学ぶ
==================================================

..    Docker for Java developers lab
    Port a node.js app to Docker lab
    Ruby on Rails app on Docker lab
    Dockerize a .Net Core application
    Dockerize an ASP.NET Core application with SQL Server on Linux using Docker Compose

* `Docker for Java developers lab <https://github.com/docker/labs/tree/master/developer-tools/java/>`_
* `Port a node.js app to Docker lab <https://github.com/docker/labs/tree/master/developer-tools/nodejs/porting>`_
* `Ruby on Rails app on Docker lab <https://github.com/docker/labs/tree/master/developer-tools/ruby>`_
* `Dockerize a .Net Core application </language/dotnet/index>`_
* Docker Compose を使う `Dockerize an ASP.NET Core application with SQL Server on Linux <https://github.com/docker/awesome-compose/tree/master/aspnet-mssql>`_ 

.. Advanced development with the SDK or API
.. _advanced-development-with-the-sdk-or-api:

SDK や API で高度な開発
==============================

.. After you can write Dockerfiles or Compose files and use Docker CLI, take it to the next level by using Docker Engine SDK for Go/Python or use the HTTP API directly. Visit the Develop with Docker Engine API section to learn more about developing with the Engine API, where to find SDKs for your programming language of choice, and to see some examples.

Dockerfile や Composefile を書けるようになり、Docker CLI を使えるようになったあとは、Docker Engine SDK for Go/Python や HTTP API を直接使い、次のレベルへと進みましょう。 :doc:`Deocker Engine API で開発 </engine/api/overview>` のセクションを開き、自分が選んだプログラミング言語の SDK を見つけ、Engine API の開発を学び、使用例を見ましょう。

.. seealso::

   Develop with Docker
      https://docs.docker.com/develop/


