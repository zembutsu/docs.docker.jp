.. Docker-docs-ja documentation master file, created by
   sphinx-quickstart on Sat Nov  7 10:06:34 2015.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

.. doc version: 1.10
.. check date: 2016/02/08
.. -----------------------------------------------------------------------------

.. Welcome to Docker-docs-ja's documentation!

Docker ドキュメント日本語化プロジェクト
==========================================

* :doc:`about`
* :doc:`guide`

----

.. Welcome Friends to the Docker Docs!

Docker ドキュメントへようこそ！
==========================================

.. Docker Engine or “Docker” creates and runs Docker containers. Install Docker on Ubuntu, Mac OS X, or Windows. Or use the Install menu to choose from others. 

.. Docker Engine provides the core functions you need to create Docker images and run Docker containers. Install Engine on Ubuntu or see the full list of others to choose from. 

**Docker Engine (エンジン)** は、Docker イメージの作成と Docker コンテナの実行に必要なコア機能を提供します。Engine を :doc:`Ubuntu </engine/installation/linux/ubuntulinux>` にインストールする方法や、 :doc:`その他の一覧リスト </engine/installation/index>` をご覧ください。

.. Docker Toolbox delivers all the Docker tools such as Engine, Machine, Compose, and Kitematic to your Mac OS X or Windows desktop. 

**Docker Toolbox (ツールボックス)** は :doc:`Mac OS X </engine/installation/mac>` や :doc:`Windows </engine/installation/windows>` デスクトップ上に Docker Engine 、Machine、Compose 、 :doc:`Kitematic </kitematic/index>` のような Docker ツールを提供します。

.. Docker Hub is our hosted registry service for managing your images. There is nothing to install. You just sign up!

**Docker Hub (ハブ)** はイメージを管理するためのホステッド・レジストリ・サービス [#f1]_ です。インストール不要です。`サインアップ <https://hub.docker.com/>`_ するだけです。

.. Docker Trusted Registry (DTR) supplies a private dedicated image registry. To learn about DTR for your team, see the overview.

**Docker Trusted Registry (トラステッド・レジストリ)** (DTR) はプライベートな専用イメージ・レジストリを提供します。チームでの DTR の使い方を学ぶには、:doc:`概要 <docker-trusted-registry/index>` をご覧ください。

.. Docker Machine automates container provisioning on your network or in the cloud. Install machine on Windows, Mac OS X, or Linux.

**Docker Machine (マシン)** は自分のネットワークやクラウド上に、自動的にコンテナをデプロイします。Machine を :doc:`Windows、Mac OS X、Windows<machine/install-machine>`  にインストールできます。

.. Docker Swarm is used to host clustering and container scheduling. Deploy your own “swarm” today in just a few short steps.

**Docker Swarm (スウォーム)** はホストのクラスタリングとコンテナのスケジューリングに使われます。 :doc:`"swarm" をデプロイする <swarm/get-swarm>` から、いくつかの短いステップで今日から使えます。

.. Docker Compose defines multi-container applications. You can install Docker Compose on Ubuntu, Mac OS X, and other systems.

**Docker Compose (コンポーズ)** は複数のコンテナを使うアプリケーションを定義します。Docker Compose を :doc:`Ubuntu、Mac OS X や、その他のシステム </compose/install>` にインストールできます。

.. Docker Registry provides open source Docker image distribution. See the registry deployment documentation for more information. 

**Docker Registry (レジストリ)** はオープンソースの Docker イメージ配布を提供します。詳細な情報は :doc:`レジストリのデプロイ </registry/deploying>` をご覧ください。

.. New Navigation!

新しいナビゲーション
====================

.. You’ll notice we have a new arrangement of the documentation navigation, it is now organized by Docker product. This is a step toward more changes to our docs look-and-feel coming soon in the near future. If you have comments good or bad, please email the feedback to us, we will be happy to hear from you.

ドキュメントのナビゲーションを Docker のプロダクトごとに新しく編成しなおしました。これは、近いうちにドキュメントの見た目と雰囲気を改善するステップの１つです。良いか悪いかコメントがあれば、私たちまで `メール <https://twitter.com/dankoromochi>`_ をいただければ、皆さんの意見を伺えて嬉しいです。

.. rubric:: 脚注

.. [#f1] 訳者注：ホステッドとは、Docker社が提供するという意味です。

----

Doc v1.10 目次
====================

.. toctree::
   :caption: Docker を始めましょう - 導入ガイド
   :hidden:

   linux/toc.rst
   windows/toc.rst
   mac/toc.rst
 
.. toctree::
   :caption: Docker Engine
   :hidden:

   engine/toc.rst

.. toctree::
   :caption: Docker Swarm
   :hidden:

   swarm/toc.rst

.. toctree::
   :caption: Docker Compose
   :hidden:

   compose/toc.rst

.. toctree::
   :caption: Docker Hub
   :hidden:

   docker-hub/index.rst

.. toctree::
   :caption: Docker Machine
   :hidden:

   machine/index.rst

.. toctree::
   :caption: Docker Toolbox
   :hidden:

   Docker Toolbox <toolbox/index.rst>

.. toctree::
   :caption: コンポーネント・プロジェクト
   :hidden:

   registry/toc.rst


About
==============================

.. toctree::
   :maxdepth: 3
   :caption: Docker について

   release-notes.rst
   engine/reference/glossary.rst
   about.rst
   guide.rst


Docs archive
====================

.. toctree::
   :maxdepth: 1
   :caption: Docs アーカイブ
   
   v1.9 <http://docs.docker.jp/v1.9/>


Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`

