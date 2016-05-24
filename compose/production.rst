.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/production/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/production.md
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/production.md
.. check date: 2016/04/28
.. Commits on Mar 11, 2016 1485a56c758ff77ea5bab07bf9d4b0ac3efb2472
.. ----------------------------------------------------------------------------

.. Using Compose in Production

.. _using-compose-in-production:

=======================================
Compose をプロダクションで使う
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Compose is still primarily aimed at development and testing environments. Compose may be used for smaller production deployments, but is probably not yet suitable for larger deployments.

.. .. note
..   まだ Compose は、主として開発またはテスト環境向けです。Compose は小規模なプロダクションのデプロイに使えるかもしれませんが、まだ大規模なデプロイに適していないかもしれません。

.. When deploying to production, you’ll almost certainly want to make changes to your app configuration that are more appropriate to a live environment. These changes may include:

.. プロダクションへのデプロイ時は、多くの場合、アプリケーションを適切に実行できるようにするために変更を加えるでしょう。変更とは次のようなものです。

.. When you define your app with Compose in development, you can use this definition to run your application in different environments such as CI, staging, and productio

開発環境で Compose を使ってアプリケーションを定義しておけば、その設定を使い、アプリケーションを CI 、ステージング、プロダクションのような異なった環境で実行できます。

..    Removing any volume bindings for application code, so that code stays inside the container and can’t be changed from outside
    Binding to different ports on the host
    Setting environment variables differently (e.g., to decrease the verbosity of logging, or to enable email sending)
    Specifying a restart policy (e.g., restart: always) to avoid downtime
    Adding extra services (e.g., a log aggregator)

.. The easiest way to deploy an application is to run it on a single server, similar to how you would run your development environment. If you want to scale up your application, you can run Compose apps on a Swarm cluster.

アプリケーションをデプロイする最も簡単な方法は、単一サーバ上での実行です。これは開発環境で実行する方法と似ています。アプリケーションをスケールアップしたい場合には、Compose アプリを Swarm クラスタ上で実行できます。

.. Modify your Compose file for production

.. _modify-your-compose-file-for-production:

Compose ファイルをプロダクション向けに書き換え
--------------------------------------------------

.. You’ll almost certainly want to make changes to your app configuration that are more appropriate to a live environment. These changes may include:

アプリケーションの設定を実際の環境に適用するには、ほとんどの場合で書き換えることになるでしょう。以下のような変更が必要になるかもしれません：

* コンテナのコードを外から変更できなくするため、アプリケーション・コード用に割り当てたボリュームを削除する。
* ホストに異なったポートを割り当てる。
* 異なった環境変数を割り当てる（例：冗長なログの出力を減らす、あるいは、メールの送信を有効化）
* 再起動ポリシーを指定し（例： ``restart: always`` ）、停止時間を減らす
* 外部サービスの追加（例：ログ収集）

.. For this reason, you’ll probably want to define an additional Compose file, say production.yml, which specifies production-appropriate configuration. This configuration file only needs to include the changes you’d like to make from the original Compose file. The additional Compose file can be applied over the original docker-compose.yml to create a new configuration.

このような理由のため、``production.yml`` のような追加 Compose ファイルを使い、プロダクションに相応しい設定を定義したくなるでしょう。この設定ファイルには、元になった Compose ファイルからの変更点のみ記述できます。追加の Compose ファイルは、元の ``docker-compose.yml`` の設定を上書きする新しい設定を指定できます。

.. Once you’ve got a second configuration file, tell Compose to use it with the -f option:

２つめの設定ファイルを使うには、Compose で ``-f`` オプションを使います。

.. code-block:: bash

   $ docker-compose -f docker-compose.yml -f production.yml up -d

.. See Using multiple compose files for a more complete example.

詳細は例は :ref:`複数のComposeファイルを使用 <different-environments>` をご覧ください。

.. Deploying changes

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

単一サーバ上でのコンテナ実行
==============================

.. You can use Compose to deploy an app to a remote Docker host by setting the DOCKER_HOST, DOCKER_TLS_VERIFY, and DOCKER_CERT_PATH environment variables appropriately. For tasks like this, Docker Machine makes managing local and remote Docker hosts very easy, and is recommended even if you’re not deploying remotely.

Compose を使い、アプリケーションをリモートの Docker ホスト上にデプロイできます。この時、適切な環境変数 ``DOCKER_HOST`` 、 ``DOCKER_TLS_VERIFY`` 、 ``DOCKER_CERT_PATH`` を使います。このような処理は、 :doc:`Docker Machine </machine/overview>` を使うことで、ローカルやリモートの Docker ホストの管理を非常に簡単にします。リモートにデプロイする必要がなくても、お勧めです。

.. Once you’ve set up your environment variables, all the normal docker-compose commands will work with no further configuration.

環境変数を設定するだけで、追加設定なしに ``docker-compose`` コマンドが普通に使えます。

.. Running Compose on a Swarm cluster

Swarm クラスタで Compose を実行する
----------------------------------------

.. Docker Swarm, a Docker-native clustering system, exposes the same API as a single Docker host, which means you can use Compose against a Swarm instance and run your apps across multiple hosts.

:doc:`Docker Swarm </swarm/overview>` とは、Docker 独自のクラスタリング・システムで、単一の Docker ホスト向けと同じ API を持っています。つまり、Compose を Swarm インスタンスも同様に扱えますので、アプリケーションを複数のホスト上で実行できることを意味します。

.. (v1.10)
.. Compose/Swarm integration is still in the experimental stage, and Swarm is still in beta, but if you’d like to explore and experiment, check out the integration guide.
.. Compose と Swarm の連携は、まだ実験的な段階です。ですが、調べたり使ってみたい場合は :doc:`統合ガイド </compose/swarm>` をお読みください。

.. (v1.11+)
.. Read more about the Compose/Swarm integration in the [integration guide](swarm.md).

Compose と Swarm の連携は、 :doc:`統合ガイド </compose/swarm>` をお読みください。


.. Compose documentation

Compose のドキュメント
==============================

..    Installing Compose
    Command line reference
    Compose file reference

* :doc:`Compose のインストール </compose/install>`
* :doc:`コマンドライン・リファレンス </compose/reference/index>`
* :doc:`Compose ファイル・リファレンス </compose/compose-file>`

.. seealso:: 

   Using Compose in production
      https://docs.docker.com/compose/production/


