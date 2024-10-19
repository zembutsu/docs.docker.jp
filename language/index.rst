.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/language/
   doc version: 24.0
      https://github.com/docker/docker.github.io/blob/master/language/index.md
.. check date: 2023/07/20
.. Commits on Jun 30, 2023 4523221101c35de82a0d6f4263615dabe514c0a6
.. -----------------------------------------------------------------------------

.. Overview

========================================
概要
========================================

.. The language-specific getting started guides walk you through the process of setting up your development environment and start containerizing language-specific applications using Docker. The learning modules contain best practices and guidelines that explain how to create a new Dockerfile in your preferred language, what to include in the Docker image, how to develop and run your Docker image, set up a CI/CD pipeline, and finally provides information on how to push the application you’ve developed to the cloud.

言語別の導入ガイドでは、開発環境を準備し、特定の言語を使ったアプリケーションを Docker を使ってコンテナ化する流れを説明します。学習の章では、ベストプラクティスとガイドラインを含みます。ここで説明するのは、好きな言語で新しい Dockerfile を作成する方法、 Docker イメージに何を含むか、 Docker イメージを使ってどのように開発・実行するか、CI/CD パイプラインの設定方法、そして最終的に、クラウドに開発したアプリケーションを送信するための情報を提供します。

.. In addition to the language-specific modules, Docker documentation also provides guidelines to build and efficiently manage your development environment. You can find information on the best practices for writing Dockerfiles, building and managing images efficiently, gaining performance improvements by building images using BuildKit, etc. You can also find specific instructions on how to keep your images small, and how to persist application data, how to use multi-stage builds, etc.

Docker のドキュメントでは、言語別の章に加え、開発環境の構築とイメージの効率的な管理に関するガイドラインも提供しています。Dockerfile の書き方のベストプラクティス、イメージの効率的な構築と管理、BuildKit を使ったイメージ構築のパフォーマンス改善を得る方法等についての情報を得られます。また、イメージを小さく保つ方法、アプリケーションデータの保持、マルチステージ ビルドの使い方に関する情報も提供しています。

.. For more information, refer to the following topics:

詳しい情報は、以下のトピックをご覧ください。

..  Best practices for writing Dockerfiles
    Docker development best practices
    Build images with BuildKit

* :doc:`/develop/develop-images/dockerfile_best-practices`
* :doc:`/develop/dev-best-practices`
* :doc:`/build/buidkit`

.. Language-specific getting started guides
.. _language-specific-getting-started-guides:

言語別導入ガイド
====================

.. Learn how to set up your Docker environment and start containerizing your applications. Choose a language below to get started.

Docker 環境の準備とアプリケーションのコンテナ化を始めるための方法を学びましょう。始めるには、以下の言語を選択してください。

* :doc:`Node.js <nodejs/index>`
* :doc:`Python <python/index>`
* :doc:`Java <java/index>`
* :doc:`Go <go/index>`
* :doc:`C# (.NET) <dotnet/index>`
* :doc:`Rust <rust/index>`

.. seealso::

   Overview
      https://docs.docker.com/language/


