.. http://docs.docker.com/compose/

.. _compose:

.. Overview of Docker Compose

=======================================
Docker Compose 概要
=======================================

.. Compose is a tool for defining and running multi-container Docker applications. With Compose, you use a Compose file to configure your application’s services. Then, using a single command, you create and start all the services from your configuration. To learn more about all the features of Compose see the list of features.

Compose とは、複数のコンテナを使う Docker アプリケーションを、定義・実行するツールです。Compose はアプリケーションのサービスを設定に、Compose ファイルを使います。そして、コマンドを１つ実行するだけで、設定した全てのサービスを作成・起動します。Compose の全ての機能一覧について学ぶには、 :ref:`機能一覧 <features>` をご覧ください。

.. Compose is great for development, testing, and staging environments, as well as CI workflows. You can learn more about each case in Common Use Cases.

Compose は開発環境、テスト、ステージング環境だけでなく、CI ワークフローにも適しています。それぞれの使い方の詳細を学ぶには、 :ref:`一般的な利用例 <common-use-cases>` をご覧ください。

.. Using Compose is basically a three-step process.

Compose を使うには、基本的に３つのステップをを踏みます。

..    Define your app’s environment with a Dockerfile so it can be reproduced anywhere.
    Define the services that make up your app in docker-compose.yml so they can be run together in an isolated environment.
    Lastly, run docker-compose up and Compose will start and run your entire app.

1. アプリケーションの環境を ``Dockerfile`` ファイルで定義します。このファイルは、どこでも再利用可能です。
2. アプリケーションを構成する各サービスを ``docker-compose.yml`` ファイルで定義します。そうすることで、独立した環境を一斉に実行できるようにします。
3. 最後に、``docker-compose up`` を実行すると、Compose はアプリケーション全体を起動・実行します。

.. A docker-compose.yml looks like this:

``docker-compose.yml`` は次のようなものです。

.. code-block:: yaml
   web:
     build: .
     ports:
      - "5000:5000"
     volumes:
      - .:/code
     links:
      - redis
   redis:
     image: redis

.. For more information about the Compose file, see the Compose file reference

Compose に関する更に詳しい情報は、 :doc:`Compose ファイル・リファレンス </compose/compose-file>` をご覧ください。

.. Compose has commands for managing the whole lifecycle of your application:

Compose には、アプリケーションのライフサイクルを管理するコマンドがあります。

..    Start, stop and rebuild services
    View the status of running services
    Stream the log output of running services
    Run a one-off command on a service

* サービスの開始、停止、再構築
* 実行中のサービスの状態を表示
* 実行中のサービスのストリーム・ログ出力
* サービス上で１回限りのコマンドを実行

.. Compose documentation

Compose のドキュメント
==============================

..    Installing Compose
    Getting Started
    Get started with Django
    Get started with Rails
    Get started with WordPress
    Command line reference
    Compose file reference

* :doc:`Composeのインストール </compose/install>`
* :doc:`始めましょう </compose/gettingstarted>`
* :doc:`Django の始め方 </compose/django>`
* :doc:`Rails の始め方 </compose/rails>`
* :doc:`WordPress の始め方 </compose/wordpress>`
* :doc:`コマンドライン・リファレンス </compose/reference>`
* :doc:`Compose ファイル・リファレンス </compose/compose-file>`

.. Features

.. _features

機能
====================

.. The features of Compose that make it effective are:

Compose には効率的な機能があります。

..    Multiple isolated environments on a single host
    Preserve volume data when containers are created
    Only recreate containers that have changed
    Variables and moving a composition between environments

* :ref:` <>`
* :ref:` <>`
* :ref:` <>`
* :ref:` <>`

