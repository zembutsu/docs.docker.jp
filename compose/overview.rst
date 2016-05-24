.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/overview/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/overview.md
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/overview.md
.. check date: 2016/04/28
.. Commits on Mar 8, 2016 88a719b4b685be62a4bcc354a07f9ecd42e1282f
.. -------------------------------------------------------------------

.. Overview of Docker Compose

.. _overview-of-docker-compose:

=======================================
Docker Compose 概要
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Compose is a tool for defining and running multi-container Docker applications. With Compose, you use a Compose file to configure your application’s services. Then, using a single command, you create and start all the services from your configuration. To learn more about all the features of Compose see the list of features.

Compose とは、複数のコンテナを使う Docker アプリケーションを、定義・実行するツールです。Compose はアプリケーションのサービスの設定に、Compose ファイルを使います。そして、コマンドを１つ実行するだけで、設定した全てのサービスを作成・起動します。Compose の全機能一覧について学ぶには、 :ref:`機能一覧 <compose-features>` をご覧ください。

.. Compose is great for development, testing, and staging environments, as well as CI workflows. You can learn more about each case in Common Use Cases.

Compose は開発環境、テスト、ステージング環境だけでなく、CI ワークフローにも適しています。それぞれの使い方の詳細を学ぶには、 :ref:`一般的な利用例 <compose-common-use-cases>` をご覧ください。

.. Using Compose is basically a three-step process.

Compose を使うには、基本的に３つのステップを踏みます。

..    Define your app’s environment with a Dockerfile so it can be reproduced anywhere.
    Define the services that make up your app in docker-compose.yml so they can be run together in an isolated environment.
    Lastly, run docker-compose up and Compose will start and run your entire app.

1. アプリケーションの環境を ``Dockerfile`` ファイルで定義します。このファイルは、どこでも再利用可能です。
2. アプリケーションを構成する各サービスを ``docker-compose.yml`` ファイルで定義します。そうすることで、独立した環境を一斉に実行できるようにします。
3. 最後に、``docker-compose up`` を実行したら、Compose はアプリケーション全体を起動・実行します。

.. A docker-compose.yml looks like this:

``docker-compose.yml`` は次のように記述します。

.. code-block:: yaml

   version: '2'
   services:
     web:
       build: .
       ports:
        - "5000:5000"
       volumes:
        - .:/code
        - logvolume01:/var/log
       links:
        - redis
     redis:
       image: redis
   volumes:
     logvolume01: {}

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

* :doc:`install`
* :doc:`gettingstarted`
* :doc:`django`
* :doc:`rails`
* :doc:`wordpress`
* :doc:`faq`
* :doc:`reference/index`
* :doc:`compose-file`

.. Features

.. _compose-features:

機能
====================

.. The features of Compose that make it effective are:

Compose には効率的な機能があります。

..    Multiple isolated environments on a single host
    Preserve volume data when containers are created
    Only recreate containers that have changed
    Variables and moving a composition between environments

* :ref:`Multiple-isolated-environments-on-a-single-host`
* :ref:`preserve-volume-data-when-containers-are-created`
* :ref:`only-recreate-containers-that-have-changed`
* :ref:`variables-and-moving-a-composition-between-environments`

.. _Multiple-isolated-environments-on-a-single-host:

単一ホスト上で、複数の環境を分離
----------------------------------------

.. Compose uses a project name to isolate environments from each other. You can use this project name to:

Compose は別々の環境の分離にプロジェクト名を使います。このプロジェクト名は次の用途で使えます。

..    on a dev host, to create multiple copies of a single environment (ex: you want to run a stable copy for each feature branch of a project)
    on a CI server, to keep builds from interfering with each other, you can set the project name to a unique build number
    on a shared host or dev host, to prevent different projects which may use the same service names, from interfering with each other

* 開発ホスト上では、１つの環境に対して複数のコピー作成に使います（例：プロジェクトの機能ブランチごとに、安定版のコピーを実行したい場合）。
* CI サーバ上では、お互いのビルドが干渉しないようにするため、プロジェクト名にユニークなビルド番号をセットできます。
* 共有ホストまたは開発ホスト上では、異なるプロジェクトが同じサービス名を使わないようにし、お互いを干渉しないようにします。

.. The default project name is the basename of the project directory. You can set a custom project name by using the -p command line option or the COMPOSE_PROJECT_NAME environment variable.

標準のプロジェクト名は、プロジェクトが存在するディレクトリ名です。プロジェクト名を変更するには、 :doc:`コマンドラインのオプション </compose/reference/overview>` で ``-p`` を指定するか、 :ref:`環境変数 <compose-project-name>` の ``COMPOSE_PROJECT_NAME`` を指定します。

.. _preserve-volume-data-when-containers-are-created:

コンテナ作成時にボリューム・データの保持
------------------------------------------------------------

.. Compose preserves all volumes used by your services. When docker-compose up runs, if it finds any containers from previous runs, it copies the volumes from the old container to the new container. This process ensures that any data you’ve created in volumes isn’t lost.

Compose はサービスが使う全てのボリュームを保持（preserve）します。 ``docker-compose up`` を実行時、以前に実行済みのコンテナが見つかれば、古いコンテナから新しいコンテナにボリュームをコピーします。この処理により、ボリューム内で作成したデータを失わないように守ります。

.. _only-recreate-containers-that-have-changed:

変更のあったコンテナのみ再作成
------------------------------

.. Compose caches the configuration used to create a container. When you restart a service that has not changed, Compose re-uses the existing containers. Re-using containers means that you can make changes to your environment very quickly.

Compose はコンテナ作成時に使う設定情報をキャッシュします。サービスの再起動時に、内容に変更がなければ、Compose は既存のコンテナを再利用します。コンテナの再利用とは、環境をとても速く作り直せるのを意味します。

.. _variables-and-moving-a-composition-between-environments:

環境間で変数の共有
------------------------------

.. Compose supports variables in the Compose file. You can use these variables to customize your composition for different environments, or different users. See Variable substitution for more details.

Compose は Compose ファイル中で、変数の使用をサポートしています。環境変数を使い、別々の環境や別々のユーザ向けに構成をカスタマイズできます。詳細は :ref:`環境変数 <compose-file-variable-substitution>` をご覧ください。

.. You can extend a Compose file using the extends field or by creating multiple Compose files. See extends for more details.

Compose ファイルは ``extends`` フィールドを使うことで、複数の Compose ファイルを作成できるように拡張できます。詳細は :doc:`extends <extends>` をご覧ください。

.. Common Use Cases

.. _compose-common-use-cases:

一般的な利用例
====================

.. Compose can be used in many different ways. Some common use cases are outlined below.

Compose は様々な使い方があります。一般的な利用例は、以下の通りです。

.. Development environments

開発環境
--------------------

.. When you’re developing software, the ability to run an application in an isolated environment and interact with it is crucial. The Compose command line tool can be used to create the environment and interact with it.

ソフトウェアの開発時であれば、アプリケーションを別々の環境で相互にやりとりするのは重要です。Compose のコマンドライン・ツールは環境の作成と、相互のやりとりのために使えます。

.. The Compose file provides a way to document and configure all of the application’s service dependencies (databases, queues, caches, web service APIs, etc). Using the Compose command line tool you can create and start one or more containers for each dependency with a single command (docker-compose up).

:doc:`Compose ファイル <compose-file>` は、文章化と、アプリケーション全ての依存関係（データベース、キュー、キャッシュ、ウェブ・サービス、API 等）を設定するものです。Compose コマンドライン・ツールを使えば、コマンドを１つ（ ``docker-compose up`` ）実行するだけで、各依存関係に応じて１つまたは複数のコンテナを作成します。

.. Together, these features provide a convenient way for developers to get started on a project. Compose can reduce a multi-page “developer getting started guide” to a single machine readable Compose file and a few commands.

同時に、開発者がプロジェクトを開始する時に役立つ機能を提供します。Compose は、複数のページにわたる「開発者向け導入手順書」を減らします。それをマシンが読み込み可能な Compose ファイルと、いくつかのコマンドで実現します。

.. Automated testing environments

自動テスト環境
--------------------

.. An important part of any Continuous Deployment or Continuous Integration process is the automated test suite. Automated end-to-end testing requires an environment in which to run tests. Compose provides a convenient way to create and destroy isolated testing environments for your test suite. By defining the full environment in a Compose file you can create and destroy these environments in just a few commands:

継続的デプロイや継続的インテグレーションのプロセスにおいて重要な部分は、自動テストの実装です。自動的なエンド間（end-to-end）のテストは、テストを行う環境が必要になります。テスト実装にあたり、Compose は個々のテスト環境の作成と破棄を便利に行う手法を提供します。 :doc:`Compose ファイル </compose/compose-file>` で定義した全ての環境は、いくつかのコマンドを実行するだけで作成・破棄できます。

.. code-block:: bash

   $ docker-compose up -d
   $ ./run_tests
   $ docker-compose stop
   $ docker-compose rm -f

.. Single host deployment

単一ホストへのデプロイ
------------------------------

.. Compose has traditionally been focused on development and testing workflows, but with each release we’re making progress on more production-oriented features. You can use Compose to deploy to a remote Docker Engine. The Docker Engine may be a single instance provisioned with Docker Machine or an entire Docker Swarm cluster.

これまでの Compose は、開発やテストにおけるワークフローに注力してきました。しかしリリースごとに、私たちはプロダクションに対応した機能を実装し続けています。Compose をリモートの Docker Engine におけるデプロイにも利用できます。Docker Engine とは、 :doc:`Docker Machine </machine/index>` で自動作成された単一のマシンかもしれませんし、 :doc:`Docker Swarm </swarm/index>`  クラスタかもしれません。

.. For details on using production-oriented features, see compose in production in this documentation.

プロダクション向け機能の詳細な使い方は、 :doc:`プロダクションの構成 </compose/production>` をご覧ください。

.. Release Notes

リリースノート
====================

.. To see a detailed list of changes for past and current releases of Docker Compose, please refer to the CHANGELOG.

Docker Compose の過去から現在に至るまでの詳細な変更一覧は、 `CHANGELOG <https://github.com/docker/compose/blob/master/CHANGELOG.md>`_ をご覧ください。

.. Getting help

ヘルプを得るには
====================

.. Docker Compose is under active development. If you need help, would like to contribute, or simply want to talk about the project with like-minded individuals, we have a number of open channels for communication.

Docker Compose は活発に開発中です。ヘルプが必要な場合、貢献したい場合、あるいはプロジェクトの同志と対話したい場合、私たちは多くのコミュニケーションのためのチャンネルを開いています。

..     To report bugs or file feature requests: please use the issue tracker on Github.
..     To talk about the project with people in real time: please join the #docker-compose channel on freenode IRC.
..     To contribute code or documentation changes: please submit a pull request on Github.

* バグ報告や機能リクエストは、 `GitHub の issue トラッカー <https://github.com/docker/compose/issues>`_ をご利用ください。
* プロジェクトのメンバーとリアルタイムに会話したければ、IRC の ``#docker-compose`` チャンネルにご参加ください。
* コードやドキュメントの変更に貢献したい場合は、`GitHub にプルリクエスト <https://github.com/docker/compose/pulls>`_ をお送りください。

.. For more information and resources, please visit the Getting Help project page.

より詳細な情報やリソースについては、私たちの `ヘルプ用ページ（英語） <https://docs.docker.com/project/get-help/>`_ をご覧ください。

.. seealso:: 

   Overview of Docker Compose
      https://docs.docker.com/compose/overview/
