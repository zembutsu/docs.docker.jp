.. -*- coding: utf-8 -*-
.. Docker-docs-ja documentation master file, created by
   sphinx-quickstart on Sat Nov  7 10:06:34 2015.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.
.. -----------------------------------------------------------------------------
.. URL: https://docs.docker.com/
   doc version: 18.03
.. check date: 2018/05/01
.. -----------------------------------------------------------------------------

.. Welcome to Docker-docs-ja's documentation!

Docker ドキュメント日本語化プロジェクト
==========================================

* :doc:`about` ... はじめての方へ、このサイトや翻訳について
* :doc:`guide`
* :doc:`pdf-download` （古いバージョン向けです）

.. attention::

  * Docker `18.03`  向けにドキュメントの改訂作業中です(2018年5月現在)。一部古い場合がありますので、ご注意ください。
  * Docker のドキュメントは常に変わり続けています。最新の情報については `公式ドキュメント <https://docs.docker.com/>`_ をご覧ください。
  * 本プロジェクトは有志による翻訳プロジェクトです。お気づきの点がございましたら、 `issue <https://github.com/zembutsu/docs.docker.jp/issues>`_ や `Pull Request <https://github.com/zembutsu/docs.docker.jp/pulls>`_ でお知らせ願います。

.. Docker Documentation

.. _docker-documentation:

Docker ドキュメント
==========================================

.. Get started with Docker

.. _get-started-with-docker:

Docker を始めましょう
------------------------------

.. Try our new multi-part walkthrough that goes from writing your first app, data storage, networking, and swarms, ending with your app running on production servers in the cloud. Total reading time is less than an hour!

複数のパートにわたる新しい手引きを試しましょう。手引きでは初めてのアプリケーションを書き、データ保存、ネットワーク機能、クラスタの各機能を通し、最終的にはクラウド上のプロダクション・サーバ上でアプリケーションを実行します。すべてを読むのに１時間もかかりません！

.. Get started with Docker

* :doc:`Docker を始めましょう </get-started/index>`


.. Try Docker Enterprise Edition

.. _try-docker-enterprise-edition:

Docker Enterprise Edition を試しましょう
----------------------------------------

.. Run your solution in production with Docker Enterprise Edition to get a management dashboard, security scanning, LDAP integration, content signing, multi-cloud support, and more. Click below to test-drive a running instance of Docker EE without installing anything.

プロダクションで皆さんのソリューションを実行するにあたり、Docker Enterprise Edition があれば管理ダッシュボード、セキュリティ・スキャン、LDAP 統合、コンテント署名、マルチクラウド・サポート等が得られます。以下をクリックすると、何もインストールしなくても Docker EE をお試しで操作できます。

`Docker Enterprise Edition を試しましょう <https://dockertrial.com/>`_ 


.. Docker Editions

.. _docker-editions:

Docker のエディションについて
------------------------------

.. Docker Community Edition

Docker コミュニティ・エディション
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. Get started with Docker and experimenting with container-based apps. Docker CE is available on many platforms, from desktop to cloud to server. Build and share containers and automate the development pipeline from a single environment. Choose the Edge channel to get fast access to the latest features, or the Stable channel for more predictability.

Docker を使い、コンテナをベースとしたアプリケーションを体験しましょう。Docker CE はデスクトップからクラウドのサーバに至るまで、多くのプラットフォームで利用可能です。単一の環境から自動デプロイ・パイプラインを通し、コンテナを構築・共有します。最新機能をいち早く得たい場合は Edge（エッジ）チャンネルをお選びください。あるいは、（挙動が）より予測可能な Stable（ステーブル；安定）チャンネルをお選び下さい。

.. Learn more about Docker CE

* :ref:`Docker CE について学ぶ <platform-support-matrix>`

.. Docker Enterprise Edition

.. _docker-enterprise-edition:

Docker エンタープライズ・エディション
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. Designed for enterprise development and IT teams who build, ship, and run business critical applications in production at scale. Integrated, certified, and supported to provide enterprises with the most secure container platform in the industry to modernize all applications. Docker EE Advanced comes with enterprise add-ons like UCP and DTR.

ビジネスにおいて重要なアプリケーションを構築、移動、そして本番環境でスケールさせるような、エンタープライズの開発と IT チームのために設計されています。統合、認証された、エンタープライズが提供するサポートを受け、全てのアプリケーションを現代化するため、業界における最も安全なコンテナ・プラットフォームです。Docker EE は UCP と DTR のようなエンタープライズ向け `アドオン <https://docs.docker.com/#docker-ee-add-ons>`_ を備えています。

.. Learn more about Docker EE

* :ref:`Docker EE について学ぶ <platform-support-matrix>`

.. Run Docker anywhere
.. _run-docker-anywhere:

Docker をいろいろな場所で動かしましょう
----------------------------------------

* :doc:`Docker for Mac <./docker-for-mac/index>`

.. A native application using the macOS sandbox security model which delivers all Docker tools to your Mac.

Mac 向けの Docker ツールを全て提供する、macOS サンドボックス・セキュリティ・モデルを使うネイティブナ・アプリケーションです。

* :doc:`Docker for Windows <./docker-for-windows/index>`

.. A native Windows application which delivers all Docker tools to your Windows computer.

Windows コンピュータ向けの Docker ツールを全て提供する、ネイティブ・Windows アプリケーションです。

* :doc:`Docker for Linux <./install/linux/ubuntu/index>`

Linux ディストリビューションがインストールされた既にお持ちのコンピュータに Docker をインストールします。

----

.. _components:

構成要素
==========

* :doc:`Docker for Mac </docker-for-mac/index>`

   Mac 上で全ての Docker ツールを実行するために、OS X サンドボックス・セキュリティ・モデルを使うネイティブなアプリケーションです。

* :doc:`Docker for Windows </docker-for-windows/overview>`

   Windows コンピュータ上で全ての Docker ツールを実行するためのネイティブ Windows アプリケーションです。

* Docker for Linux

   コンピュータにインストール済みの Linux ディストリビューション上に Docker をインストールします。

* :doc:`Docker Engine （エンジン）</engine/installation/index>`

   Docker イメージを作成し、Docker コンテナを実行します。
   v.1.12.0 以降は、Engine の :doc:`swarm モード </engine/swarm/index>` にコンテナのオーケストレーション機能が含まれます。

* :doc:`Docker Hub （ハブ） </docker-hub/overview>`

   イメージの管理と構築のためのホステッド・レジストリ・サービスです。

* Docker Cloud （クラウド）

   ホスト上にDocker イメージの構築、テスト、デプロイするホステッド・サービスです。

* Docker Trusted Registry （トラステッド・レジストリ）

   [DTR] でイメージの保管と署名をします。

* Docker Universal Control Plane （ユニバーサル・コントロール・プレーン）

   [UCP] はオンプレミス上の Docker ホストのクラスタを１台から管理します。

* :doc:`Docker Machine （マシン） </machine/overview>`

   ネットワークまたはクラウド上へ自動的にコンテナをプロビジョニングします。Windows、mac OS、Linux で使えます。

* :doc:`Docker Compose （コンポーズ） </compose/overview>`

   複数のコンテナを使うアプリケーションを定義します。


----

Doc v18.03 目次
====================

.. toctree::
   :caption: Glossary - 用語集
   :maxdepth: 1

   glossary.rst

.. toctree::
   :caption: Guide - ガイド
   :maxdepth: 1

   engine/installation/toc.rst
   get-started/toc.rst
   ユーザガイド <engine/toc.rst>

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
   glossary.rst
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
