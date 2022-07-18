.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/production/
.. SOURCE: 
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/production.md
   doc version: v20.10
      https://github.com/docker/docker.github.io/blob/master/compose/production.md
.. check date: 2022/07/18
.. Commits on Jun 3, 2022 d49af6a4495f653ffa40292fd24972b2df5ac0bc
.. ----------------------------------------------------------------------------

.. Using Compose in Production
.. _using-compose-in-production:
==================================================
Compose を :ruby:`本番環境 <production>` で使う
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. When you define your app with Compose in development, you can use this definition to run your application in different environments such as CI, staging, and production.

開発環境で Compose を使ってアプリケーションを定義しておけば、その設定を使い、アプリケーションを CI 、ステージング、本番環境のように異なる環境で実行できます。

.. The easiest way to deploy an application is to run it on a single server, similar to how you would run your development environment. If you want to scale up your application, you can run Compose apps on a Swarm cluster.

アプリケーションをデプロイする最も簡単な方法は、単一サーバ上での実行です。これは開発環境で実行する方法と似ています。アプリケーションをスケールアップしたい場合には、Compose アプリを Swarm クラスタ上で実行できます。

.. Modify your Compose file for production
.. _modify-your-compose-file-for-production:

Compose ファイルを本番環境向けに書き換え
--------------------------------------------------

.. You probably need to make changes to your app configuration to make it ready for production. These changes may include:

アプリケーションの設定を本番環境に適用するには、おそらく書き換えが必要でしょう。以下のような変更が必要になるかもしれません：

..   Removing any volume bindings for application code, so that code stays inside the container and can’t be changed from outside
    Binding to different ports on the host
    Setting environment variables differently, such as reducing the verbosity of logging, or to specify settings for external services such as an email server
    Specifying a restart policy like restart: always to avoid downtime
    Adding extra services such as a log aggregator

* アプリケーションのコードに :ruby:`結び付けている <bind>` ボリュームを削除する。そのため、コードはコンテナ内に残り続けるため、外から変更できなくなる。
* ホスト上では異なるポートに割り当てる
* 


* コンテナのコードを外から変更できなくするため、アプリケーション・コード用に割り当てたボリュームを削除する。
* ホストに異なったポートを割り当てる。
* 異なった環境変数を割り当てる。たとえば、冗長なログの出力を減らす、あるいは、メールサーバのような外部サービスへの設定を指定する。
* 再起動ポリシーを指定し（例： ``restart: always`` ）、停止時間を減らす
* 外部サービスの追加（例：ログ収集）

.. For this reason, you’ll probably want to define an additional Compose file, say production.yml, which specifies production-appropriate configuration. This configuration file only needs to include the changes you’d like to make from the original Compose file. The additional Compose file can be applied over the original docker-compose.yml to create a new configuration.

このような理由のため、``production.yml`` のような追加 Compose ファイルを使い、プロダクションに相応しい設定を定義したくなるでしょう。この設定ファイルには、元になった Compose ファイルからの変更点のみ記述できます。追加の Compose ファイルは、元の ``docker-compose.yml`` の設定を上書きする新しい設定を指定できます。

.. Once you’ve got a second configuration file, tell Compose to use it with the -f option:

２つめの設定ファイルを使うには、Compose で ``-f`` オプションを使います。

.. code-block:: bash

   $ docker-compose -f docker-compose.yml -f production.yml up -d

.. See Using multiple compose files for a more complete example.

詳細は例は :ref:`複数のComposeファイルを使用 <extends-different-environements>` をご覧ください。

.. Deploying changes
.. _compose-deploying-changes:
変更のデプロイ
--------------------

.. When you make changes to your app code, you’ll need to rebuild your image and recreate your app’s containers. To redeploy a service called web, you would use:

アプリケーションのコードを変更した時は、イメージを再構築し、アプリケーションのコンテナを作り直す必要があります。``web`` という名称のサービスを再デプロイするには、次のように実行します。

.. code-block:: bash

   $ docker-compose build web
   $ docker-compose up --no-deps -d web

.. This will first rebuild the image for web and then stop, destroy, and recreate just the web service. The --no-deps flag prevents Compose from also recreating any services which web depends on.

これは、まず ``web`` イメージを再構築するために（コンテナを）停止・破棄します。それから ``web`` サービス *のみ* 再作成します。``--no-deps`` フラグを使うことで、Compose が ``web`` に依存するサービスを再作成しないようにします。

.. Running Compose on a single server
.. _compose-running-compose-on-a-single-server
単一サーバ上でのコンテナ実行
------------------------------

.. You can use Compose to deploy an app to a remote Docker host by setting the DOCKER_HOST, DOCKER_TLS_VERIFY, and DOCKER_CERT_PATH environment variables appropriately.

Compose を使い、アプリケーションをリモートの Docker ホスト上にデプロイできます。この時、適切な環境変数 ``DOCKER_HOST`` 、 ``DOCKER_TLS_VERIFY`` 、 ``DOCKER_CERT_PATH`` を使います。

.. Once you’ve set up your environment variables, all the normal docker-compose commands will work with no further configuration.

環境変数を設定するだけで、追加設定なしに ``docker-compose`` コマンドが普通に使えます。

.. Compose documentation
Compose のドキュメント
==============================

..  User guide
    Installing Compose
    Getting Started
    Command line reference
    Compose file reference
    Sample apps with Compose

* :doc:`ユーザガイド <index>`
* :doc:`Compose のインストール <install>`
* :doc:`始めましょう <gettingstarted>`
* :doc:`コマンドライン リファレンス <reference/index>`
* :doc:`Compose ファイル リファレンス <compose-file>`
* :doc:`Compose のサンプルアプリ <samples-for-compose>`

.. seealso:: 

   Using Compose in production
      https://docs.docker.com/compose/production/


