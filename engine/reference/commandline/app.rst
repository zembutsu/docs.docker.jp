.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/docker/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/docker.md
.. check date: 2022/02/12
.. -------------------------------------------------------------------

.. docker app

.. _docker-app

=======================================
docker app
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Description

説明
==========

.. Docker Application

Docker :ruby:`アプリケーション <application>`

.. warning::

   **非推奨のコマンド**
   
   今後の Docker バージョンでは削除される可能性があります。詳しい情報は `Docker Roadmap <https://github.com/docker/roadmap/issues/209>`_ をご覧ください

.. Extended description

詳細説明
====================

.. A tool to build and manage Docker Applications.

Docker アプリケーションを構築・管理するツールです。

.. Parent command

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - 


.. Child commands

子コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker app bundle<app_bundle>`
     - アプリケーションの CNAB invocation イメージと ``bundle.json`` を作成
   * - :doc:`docker app completion<app_completion>`
     - 指定したシェル（bash か zsh）向けの補完スクリプトを作成
   * - :doc:`docker app init<app_init>`
     - Docker アプリケーション定義を初期化
   * - :doc:`docker app inspect<app_inspect>`
     - 対象アプリケーションのメタデータ、パラメータ、Ccompose ファイルの概要を表示
   * - :doc:`docker app install<app_install>`
     - アプリケーションのインストルメンテーションでよいのでしょうか？
   * - :doc:`docker app list<app_list>`
     - インストールの一覧と、直近のインストール結果の一覧表示
   * - :doc:`docker app pull<app_pull>`
     - レジストリからアプリケーション・パッケージを取得
   * - :doc:`docker app push<app_push>`
     - レジストリにアプリケーション・パッケージの送信
   * - :doc:`docker app render<app_render>`
     - アプリケーション・パッケージに対する Compose ファイルを生成
   * - :doc:`docker app status<app_status>`
     - アプリケーションのインストール状況を取得
   * - :doc:`docker app uninstall<app_uninstall>`
     - アプリケーションのアンインストール
   * - :doc:`docker app upgrade<app_upgrade>`
     - インストール済みアプリケーションの更新
   * - :doc:`docker app validate<app_validate>`
     - アプリケーションを生成する構文が正しいかどうか確認
   * - :doc:`docker app version<app_version>`
     - バージョン情報を表示

概要
==========

.. Docker App is a CLI plug-in that introduces a top-level docker app command to bring the container experience to applications. The following table compares Docker containers with Docker applications.

Docker App は、トップレベルの ``docker app`` コマンドの導入によって、アプリケーションに対するコンテナ体験をもたらす CLI プラグインです。以下の表は Docker コンテナと Docker アプリケーションの比較です。

.. list-table::
   :header-rows: 1

   * - オブジェクト
     - 設定ファイル
     - 構築方法
     - 実行方法
     - 共有方法
   * - コンテナ
     - Dockerfile
     - docker image build
     - docker container run
     - docker image push
   * - App
     - App Package
     - docker app bumdle
     - docker app install
     - docker app push

.. With Docker App, entire applications can now be managed as easily as images and containers. For example, Docker App lets you build, validate and deploy applications with the docker app command. You can even leverage secure supply-chain features such as signed push and pull operations.

docker app により、イメージやコンテナを管理するのと同じくらい簡単に、アプリケーション全体を管理できるようにします。たとえば、 Docker App は ``docker app`` コマンドの実行で、構築、検証、アプリケーションをデプロイできます。また、 書名済み ``push`` と ``pull`` 操作のように、安全なサプライチェーン機能も活用できます。

.. NOTE: docker app works with Docker 19.03 or higher.

.. note::

   ``docker app`` は ``Docker 19.03`` 以上で動作します。

.. This guide walks you through two scenarios:

このガイドでは2つのシナリオを見ていきます。

..    Initialize and deploy a new Docker App project from scratch.
    Convert an existing Compose app into a Docker App project (added later in the beta process).

1. 新規の Docker App プロジェクトを、ゼロから初期化およびデプロイする。
2. 既存の Compose アプリを Docker app プロジェクトに変換する（ベータ段階のため、後ほど追加）

.. The first scenario describes basic components of a Docker App with tools and workflow.

1つめのシナリオは、Docker App のツールとワークフローによる基本的なコマンドを説明します。

（以下TBD）


.. seealso:: 

   docker app
      https://docs.docker.com/engine/reference/commandline/app/

