.. -*- coding: utf-8 -*-
.. Docker-docs-ja documentation master file, created by
   sphinx-quickstart on Sat Nov  7 10:06:34 2015.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.
.. -----------------------------------------------------------------------------
.. URL: https://docs.docker.com/
   doc version: 1.13
      https://github.com/docker/docker.github.io/blob/master/index.md
.. check date: 2017/02/22
.. Commits on Feb 17, 2017 4e870835f7cc3c10a528fb14674d2e25fc755161y
.. -----------------------------------------------------------------------------

.. Welcome to Docker-docs-ja's documentation!

Docker ドキュメント日本語化プロジェクト
==========================================

* :doc:`about` ... はじめての方へ、このサイトや翻訳について
* :doc:`guide`
* :doc:`pdf-download` （バージョンが少し古いです）

.. attention::

  * Docker `1.1`3  向けにドキュメントの改訂作業中です。古いバージョンについては `アーカイブ <http://docs.docker.jp/v1.12/>`_ をご覧ください。
  * Docker のドキュメントは常に変わり続けています。最新の情報については `公式ドキュメント <https://docs.docker.com/>`_ をご覧ください。

.. Docker Documentation

.. _docker-documentation:

Docker ドキュメント
==========================================

.. Docker packages your app with its dependencies, freeing you from worrying about your system configuration, and making your app more portable.

Docker はアプリケーションと依存関係をまとめ、システム設定に対する心配から解放し、アプリケーションをよりポータブルにできます。

.. Learn the basics of Docker

.. _learn-the-basics-of-docker:

Docker の基本を学ぶ
--------------------

.. The basic tutorial introduces Docker concepts, tools, and commands. The examples show you how to build, push, and pull Docker images, and run them as containers. This tutorial stops short of teaching you how to deploy applications.

基本チュートリアルでは、Docker の概念、ツール、コマンドを紹介します。例では、Docker イメージを構築・取得・送信し、コンテナとして実行する方法を紹介します。チュートリアルではアプリケーションのデプロイ方法には触れません。

.. Start the basic tutorial

* :doc:`基本チュートリアルを始める </engine/getstarted> ` 

.. Define and deploy applications

.. _define-and-deploy-applications:

アプリケーションの定義とデプロイ
----------------------------------------

.. The define-and-deploy tutorial shows how to relate containers to each other and define them as services in an application that is ready to deploy at scale in a production environment. Highlights Compose Version 3 new features and swarm mode.

定義とデプロイのチュートリアルでは、コンテナ間をお互いに関連付ける方法と、プロダクション環境にスケールできる準備が整ったアプリケーションをサービスとして定義する方法を紹介します。重要なのは :ref:`Compose バージョン 3 の新機能 <compose-version-3-features-and-compatibility>` と swarm モードです。

.. Start the application tutorial

* :doc:`アプリケーションのチュートリアルを始める </engine/getstarted-voting-app> ` 


.. Components:

.. _components:

構成要素
==========

* :doc:`Docker for Mac </docker-for-mac/index>`

   Mac 上で全ての Docker ツールを実行するために、OS X サンドボックス・セキュリティ・モデルを使うネイティブなアプリケーションです。

* :doc:`Docker for Windows </docker-for-windows/index>`

   Windows コンピュータ上で全ての Docker ツールを実行するためのネイティブ Windows アプリケーションです。

* :doc:`Docker for Linux </engine/installation/linux/index>`

   コンピュータにインストール済みの Linux ディストリビューション上に Docker をインストールします。

* :doc:`Docker Engine （エンジン）</engine/installation/index>`

   Docker イメージを作成し、Docker コンテナを実行します。
   v.1.12.0 以降は、Engine の :doc:`swarm モード </engine/swarm/index>` にコンテナのオーケストレーション機能が含まれます。

* :doc:`Docker Hub （ハブ） </docker-hub/overview>`

   イメージの管理と構築のためのホステッド・レジストリ・サービスです。

* :doc:`Docker Cloud （クラウド） </docker-cloud/overview>`

   ホスト上にDocker イメージの構築、テスト、デプロイするホステッド・サービスです。

* :doc:`Docker Trusted Registry （トラステッド・レジストリ） </docker-trusted-registry/overview>`

   [DTR] でイメージの保管と署名をします。

* :doc:`Docker Universal Control Plane （ユニバーサル・コントロール・プレーン） </ucp/overview>`

   [UCP] はオンプレミス上の Docker ホストのクラスタを１台から管理します。

* :doc:`Docker Machine （マシン） </machine/overview>`

   ネットワークまたはクラウド上へ自動的にコンテナをプロビジョニングします。Windows、mac OS、Linux で使えます。

* :doc:`Docker Compose （コンポーズ） </compose/overview>`

   複数のコンテナを使うアプリケーションを定義します。


----

Doc v1.13 RC 目次
====================

.. toctree::
   :caption: Docker を始めましょう - 導入ガイド
   :maxdepth: 1

   windows/toc.rst
   mac/toc.rst
 
.. toctree::
   :caption: Docker Engine
   :maxdepth: 2

   engine/toc.rst

.. toctree::
   :caption: Docker Compose
   :maxdepth: 2

   compose/toc.rst

.. toctree::
   :caption: Docker Hub
   :maxdepth: 2

   docker-hub/index.rst

.. toctree::
   :caption: Docker Machine
   :maxdepth: 2

   machine/index.rst

.. toctree::
   :caption: Docker Toolbox
   :maxdepth: 2

   Docker Toolbox <toolbox/index.rst>

.. toctree::
   :caption: コンポーネント・プロジェクト
   :maxdepth: 2

   registry/toc.rst
   swarm/toc.rst


About
==============================

.. toctree::
   :maxdepth: 3
   :caption: Docker について

   release-notes.rst
   engine/reference/glossary.rst
   about.rst
   guide.rst
   pdf-download.rst

図版は `GitHub リポジトリ元 <https://github.com/docker/docker.github.io>`_ で Apache License v2 に従って配布されているデータを使っているか、配布されているデータを元に日本語化した素材を使っています。

Docs archive
====================

.. toctree::
   :maxdepth: 1
   :caption: Docs アーカイブ
   
   v1.12 <http://docs.docker.jp/v1.12/>
   v1.11 <http://docs.docker.jp/v1.11/>
   v1.10 <http://docs.docker.jp/v1.10/>
   v1.9 <http://docs.docker.jp/v1.9/>


Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`

