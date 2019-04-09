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

Compose とは、複数のコンテナを定義し実行する Docker アプリケーションのためのツールです。Compose においては YAML ファイルを使ってアプリケーションサービスの設定を行います。コマンドを１つ実行するだけで、設定内容に基づいたアプリケーションサービスの生成、起動を行います。Compose の機能一覧については、 :ref:`機能一覧 <compose-features>` をご覧ください。

.. Compose works in all environments: production, staging, development, testing, as well as CI workflows. You can learn more about each case in Common Use Cases.

Compose は本番環境、ステージング環境、開発環境において動作し、CI ワークフローとしても利用することができます。それぞれの使い方については、 :ref:`一般的な利用例 <compose-common-use-cases>` を確認してください。

.. Using Compose is basically a three-step process.

Compose を使うには、基本的に３つのステップを踏みます。

..    Define your app’s environment with a Dockerfile so it can be reproduced anywhere.
    Define the services that make up your app in docker-compose.yml so they can be run together in an isolated environment.
    Lastly, run docker-compose up and Compose will start and run your entire app.

1. アプリケーション環境を ``Dockerfile`` に定義します。こうしてその環境は再構築が可能となります。
2. アプリケーションを構成するサービスを ``docker-compose.yml`` ファイル内に定義します。こうすることで、各サービスは独立した環境において起動することになります。
3. 最後に、``docker-compose up`` を実行したら、Compose はアプリケーション全体を起動・実行します。

.. A docker-compose.yml looks like this:

``docker-compose.yml`` は次のように記述します。

.. code-block:: yaml

   version: '3'
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

Compose ファイルに関するさらに詳しい情報は、 :doc:`Compose ファイル・リファレンス </compose/compose-file>` をご覧ください。

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

Compose には特徴的な以下の機能があります。

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

Compose はプロジェクト名というものを用いて各環境を分離します。このプロジェクト名はさまざまに異なる用途に利用することができます。

..    on a dev host, to create multiple copies of a single environment (ex: you want to run a stable copy for each feature branch of a project)
    on a CI server, to keep builds from interfering with each other, you can set the project name to a unique build number
    on a shared host or dev host, to prevent different projects which may use the same service names, from interfering with each other

* 開発ホスト上では、１つの環境に対して複数のコピー作成に使います（例：プロジェクトの機能ブランチごとに、安定版のコピーを実行したい場合）。
* CI サーバ上では、お互いのビルドが干渉しないようにするため、プロジェクト名にユニークなビルド番号をセットできます。
* 共有ホストまたは開発ホスト上では、異なるプロジェクトが同じサービス名を使わないようにし、お互いを干渉しないようにします。

.. The default project name is the basename of the project directory. You can set a custom project name by using the -p command line option or the COMPOSE_PROJECT_NAME environment variable.

プロジェクト名はデフォルトでは、プロジェクトが存在するディレクトリ名となります。プロジェクト名を指定するには、 :doc:`コマンドラインのオプション </compose/reference/overview>` の ``-p`` を指定するか、 :ref:`環境変数 <compose-project-name>` の ``COMPOSE_PROJECT_NAME`` を使って指定します。

.. _preserve-volume-data-when-containers-are-created:

コンテナ作成時にボリューム・データの保持
------------------------------------------------------------

.. Compose preserves all volumes used by your services. When docker-compose up runs, if it finds any containers from previous runs, it copies the volumes from the old container to the new container. This process ensures that any data you’ve created in volumes isn’t lost.

Compose は、サービスによって利用されているボリュームをすべて保護します。``docker-compose up`` が実行されたときに、コンテナがそれ以前に実行されていたものであれば、以前のコンテナから現在のコンテナに向けてボリュームをコピーします。この処理において、ボリューム内に作り出されていたデータは失われることはありません。

.. If you use docker-compose on a Windows machine, see Environment variables and adjust the necessary environment variables for your specific needs.

Windows 上において docker-compose を利用している場合には、:doc:`環境変数 </reference/envvars>`_ を参考にし、状況に応じて必要となる環境変数を定めてください。

.. _only-recreate-containers-that-have-changed:

変更のあったコンテナのみ再作成
------------------------------

.. Compose caches the configuration used to create a container. When you restart a service that has not changed, Compose re-uses the existing containers. Re-using containers means that you can make changes to your environment very quickly.

Compose はコンテナが生成されたときの設定情報をキャッシュに保存します。設定内容に変更のないサービスが再起動された場合、Compose はすでにあるサービスを再利用します。再利用されるということは、全体として環境への変更がすばやくできることを意味します。

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

ソフトウェアを開発する上で、アプリケーションを分離された環境内にて実行させ、しかも正しくアクセスできるようにすることが極めて重要です。Compose のコマンドラインツールを用いることで、環境生成と環境へのアクセスを行うことができます。

.. The Compose file provides a way to document and configure all of the application’s service dependencies (databases, queues, caches, web service APIs, etc). Using the Compose command line tool you can create and start one or more containers for each dependency with a single command (docker-compose up).

:doc:`Compose ファイル <compose-file>` は、アプリケーションにおけるサービスの依存関係（データベース、キュー、キャッシュ、ウェブ・サービス API など）を設定するものです。Compose コマンドライン・ツールを使うと、いくつでもコンテナを生成、起動でき、しかもコマンド（ ``docker-compose up`` ）を１つ実行するだけで、依存関係も正しく考慮してくれます。

.. Together, these features provide a convenient way for developers to get started on a project. Compose can reduce a multi-page “developer getting started guide” to a single machine readable Compose file and a few commands.

さらにこういった機能は、プロジェクトに取りかかろうとしている開発者にとっても便利なものです。Compose は、分厚く仕上がっている「開発者向け導入手順書」のページ数を減らすものになり、ただ１つの Compose ファイルと数えるほどのコマンドだけになります。

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
