.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/desktop/opensource/
   doc version: 19.03
      https://github.com/docker/docker.github.io/commits/master/desktop/dashboard.md
.. check date: 2020/06/12
.. Commits on May 1, 2020 ba7819fed679f4f2542c3ccfe15bc9bc2d74ee3d
.. -----------------------------------------------------------------------------

.. Docker Desktop Dashboard

.. _docker-desktop-dashboard:

=======================================
Docker Desktop ダッシュボード
=======================================

.. sidebar:: 目次

   .. contents::
       :depth: 3
       :local:

.. The Docker Desktop Dashboard provides a simple interface that enables you to interact with containers and applications, and manage the lifecycle of your applications directly from your machine. The Dashboard UI shows all running, stopped, and started containers with their status. It provides an intuitive interface to perform common actions to inspect, interact with, and manage your Docker objects including containers and Docker Compose-based applications.

Docker Desktop のダッシュボードは、コンテナやアプリケーションの操作や、マシン上のアプリケーションのライフサイクルを直接管理するための、シンプルなインターフェースを提供します。ダッシュボードのユーザ・インターフェースで、実行中や停止中の前コンテナの稼働状態や、実行中であればその状態を表示します。直感的なインターフェースを通して、コンテナを含む Docker オブジェクトと Docker Compose ベースのアプリケーションに対し、調査、アクション、管理するために共通する処理を行います。

.. The Docker Desktop Dashboard offers the following benefits:

Docker Desktop ダッシュボードは、以下の利点を提供します。

..    A GUI to abstract core information from the CLI
    Access to container logs directly in the UI to search and explore container behavior
    Access to combined Compose logs from the UI to understand Compose applications
    Quick visibility into ports being used by containers
    Monitor container resource utilization

* GUI は CLI がもたらすコアな情報を抽象化します
* コンテナの挙動を検索・調査をするために、UI を通してコンテナのログに直接アクセスします
* Compose アプリケーションを理解するために、 UI を通して連結された Compose ログにアクセスします
* コンテナによって使用しているポートを、素早く見えるようにします
* コンテナのリソース使用状況を監視します

.. In addition, the Dashboard UI allows you to:

加えて、ダッシュボード UI を使って、以下のことを可能にします。

..    Navigate to the Preferences (Settings in Windows) menu to configure Docker Desktop preferences
    Access the Troubleshoot menu to debug and perform restart operations
    Sign into Docker Hub using your Docker ID


* Settings（設定） のメニューから、Docker Desktop 設定を変更します
* Troubleshoot（トラブルシュート） のメニューから、デバッグや再起動処理を行います
* `Docker Hub <https://hub.docker.com/>`_ に自分の Docker ID でサインインします

.. To access the Docker Desktop Dashboard, from the Docker menu, select Dashboard. The Dashboard provides a runtime view of all your containers and applications.

Docker Desktop のダッシュボードにアクセスするには、Docker メニューから **Dashboard** （ダッシュボード）を選択します。ダッシュボードは、全てのコンテナとアプリケーションの一覧を提供します。

.. Docker Desktop Dashboard


.. Explore running containers and applications

.. _dashoboard-explore-running-containers-and-applications:

コンテナとアプリケーションの探索
========================================

.. From the Docker menu, select Dashboard. This lists all your running containers and applications. Note that you must have running containers and applications to see them listed on the Docker Desktop Dashboard.

Docker メニューから、 **Dashboard** を選択します。ここでは実行中のコンテナとアプリケーションの全リストを表示します。Docker Desktop ・ダッシュボード上に表示されているのは、実行中のコンテナとアプリケーションのみなので御注意ください。

.. The following sections guide you through the process of creating a sample Redis container and a sample application to demonstrate the core functionalities in Docker Desktop Dashboard.

以下のセクションでは、サンプルの Redis コンテナとサンプルアプリケーションを作成するプロセスを通して紹介します。ここでは Docker Desktop ダッシュボードの主要な機能を扱います。

.. Start a Redis container

.. _dashboard-start-a-redis-container:

Redis コンテナの開始
--------------------------------------------------

.. To start a Redis container, open your preferred CLI and run the following command:

Redis コンテナを開始するには、任意の CLI を開き、以下のコマンドを実行します。

.. code-block:: bash

   docker run -dt redis

.. This creates a new Redis container. From the Docker menu, select Dashboard to see the new Redis container.

これは、新しい Redis コンテナを作成します。Docker メニューから **Dashboard** を選択し、新しい Redis コンテナを表示します。

.. Redis container

.. Start a sample application

.. _dashboard-start-a-sample-application:

サンプルアプリケーションの開始
--------------------------------------------------

.. Now, let us start a sample application. You can download the Example voting app from the Docker samples page. The example voting app is a distributed application that runs across multiple Docker containers.

それでは、サンプル・アプリケーションを実行しましょう。Docker サンプル・ページから `サンプル投票アプリ <https://github.com/dockersamples/example-voting-app>`_ をダウンロードできます。サンプル投票アプリは、複数の Docker コンテナを横断する分散アプリケーションです。

.. Example voting app architecture diagram

.. The example voting app contains:

サンプル投票アプリケーションの含むもの：

..    A front-end web app in Python or ASP.NET Core which lets you vote between two options
    A Redis or NATS queue which collects new votes
    A .NET Core, Java or .NET Core 2.1 worker which consumes votes and stores them
    A Postgres or TiDB database backed by a Docker volume
    A Node.js or ASP.NET Core SignalR web app which shows the results of the voting in real time

* `Python <https://docs.docker.com/vote>`_ か `ASP.NET Core <https://docs.docker.com/vote/dotnet>`_ によるフロントエンド・ウェブ・アプリケーションを通して、2つの選択肢から投票できます
* `Redis <https://hub.docker.com/_/redis/>`_ 又は `NATS <https://hub.docker.com/_/nats/>`_ キューは、新しい投票を集めます
* `.NET Core <https://docs.docker.com/worker/src/Worker>`_ 、 `Java <https://docs.docker.com/worker/src/main>`_ 、 `.NET Core 2.1 <https://docs.docker.com/worker/dotnet>`_ ワーカーは、投票を取り込み保存します
* Docker ボリューム上の、 `Postgres <https://hub.docker.com/_/postgres/>`_ か `TiDB <https://hub.docker.com/r/dockersamples/tidb/tags/>`_ データベース
* `Node.js <https://docs.docker.com/result>`_ や `ASP.NET Core SignalR <https://docs.docker.com/result/dotnet>`_ ウェブアプリは、投票結果をリアルタイムで表示します。

.. To start the application, navigate to the directory containing the example voting application in the CLI and run docker-compose up --build.

アプリケーションを開始するには、CLI でサンプル投票アプリケーションを含むディレクトリに移動し、 :code:`docker-compose up --build` を実行します。

.. code-block:: bash

   $ docker-compose up --build
   Creating network "example-voting-app-master_front-tier" with the default driver
   Creating network "example-voting-app-master_back-tier" with the default driver
   Creating volume "example-voting-app-master_db-data" with default driver
   Building vote
   Step 1/7 : FROM python:2.7-alpine
   2.7-alpine: Pulling from library/python
   Digest: sha256:d2cc8451e799d4a75819661329ea6e0d3e13b3dadd56420e25fcb8601ff6ba49
   Status: Downloaded newer image for python:2.7-alpine
    ---> 1bf48bb21060
   Step 2/7 : WORKDIR /app
    ---> Running in 7a6a0c9d8b61
   Removing intermediate container 7a6a0c9d8b61
    ---> b1242f3c6d0c
   Step 3/7 : ADD requirements.txt /app/requirements.txt
    ---> 0f5d69b65243
   Step 4/7 : RUN pip install -r requirements.txt
    ---> Running in 92788dc9d682
   
   ...
   Successfully built 69da1319c6ce
   Successfully tagged example-voting-app-master_worker:latest
   Creating example-voting-app-master_vote_1   ... done
   Creating example-voting-app-master_result_1 ... done
   Creating db                                 ... done
   Creating redis                              ... done
   Creating example-voting-app-master_worker_1 ... done
   Attaching to db, redis, example-voting-app-master_result_1, example-voting-app-master_vote_1, example-voting-app-master_worker_1
   ...

.. When the application successfully starts, from the Docker menu, select Dashboard to see the Example voting application. Expand the application to see the containers running inside the application.

アプリケーションの実行に成功したら、 Docker メニューから **Dashboard** を選択し、サンプル投票アプリケーションを見ましょう。アプリケーションを展開し、アプリケーション内で実行中のコンテナを見ます。

.. Spring Boot application view

.. Now that you can see the list of running containers and applications on the Dashboard, let us explore some of the actions you can perform:

これで、ダッシュボード上で実行中のコンテナとアプリケーションの一覧が見られます。それでは、何ができるか見ていきましょう。

..    Click Port to open the port exposed by the container in a browser.
    Click CLI to open a terminal and run commands on the container.
    Click Stop, Start, Restart, or Delete to perform lifecycle operations on the container.


* **Port** をクリックし、コンテナによって公開されているポートをブラウザで開きます
* **CLI** をクリックし、コンテナ上にターミナルを開き、コマンドを実行します
* **Stop** 、 **Start** 、 **Restart** 、 **Delete** をクリックし、コンテナのライフサイクルを処理します

.. Use the Search option to search for a specific object. You can also sort your containers and applications using various options. Click the Sort by drop-down to see a list of available options.

**Search** オプションを使い、特定のオブジェクトを検索します。また、様々なオプションでコンテナやアプリケーションを並び替えできます。 **Sort by** ドロップ・ダウンで、利用可能なオプションの一覧を表示します。

.. Interact with containers and applications

.. _dashboard-Interact-with-containers-and-applications:

コンテナやアプリケーションの操作
==================================================

.. From the Docker Desktop Dashboard, select the example voting application we started earlier.

Docker Desktop ・ダッシュボードから、先ほど起動したサンプル投票アプリケーションを選択します。

.. The application view lists all the containers running on the application and contains a detailed logs view. It also allows you to start, stop, or delete the application.

**application view** 一覧から、実行している全アプリケーションのコンテナ一覧と、詳細なログ表示を行います。また、アプリケーションの起動、停止、削除も行えます。

.. Hover over the containers to see some of the core actions you can perform. Use the Search option at the bottom to search the application logs for specific events, or select the Copy icon to copy the logs to your clipboard.

コンテナ名の上にマウスを移動すると、主要な操作可能な機能を表示します。特定のイベントに対するアプリケーションのログを検索するには、下の方にある **Search** オプションを使います。あるいは、クリップボードにログをコピーするには **Copy** を選択します。

.. Application view

.. Click on a specific container for detailed information about the container. The container view displays Logs, Inspect, and Stats tabs and provides quick action buttons to perform various actions.

特定のコンテナに対する詳細情報を指定するには、クリックします。 **container view** には **Logs** 、 **Inspect** 、 **Stats** タブが表示され、ボタンのクリックで様々なアクションを処理できます。

.. Explore the app

..    Select Logs to see logs from the container. You can also search the logs for specific events and copy the logs to your clipboard.

..    Select Inspect to view low-level information about the container. You can see the local path, version number of the image, SHA-256, port mapping, and other details.

..    Select Stats to view information about the container resource utilization. You can see the amount of CPU, disk I/O, memory, and network I/O used by the container.


* **Logs** を選択し、コンテナからのログを表示します。また、任意のイベントをログから検索したり、クリップボードにログをコピーしたりできます。
* **Inspect** を選択し、コンテナに対するローレベルな情報を表示します。また、ローカルのパスや、イメージのバージョン番号、 SHA-256 、ポート割り当て（マッピング）、その他詳細を確認できます。
* **Stats** をクリックし、コンテナのリソース使用率に関する情報を表示します。コンテナによって、たくさんの CPU 、ディスクI/O 、メモリ、ネットワーク I/O が使われているのが見えます。

.. You can also use the quick action buttons on the top bar to perform common actions such as opening a CLI to run commands in a container, and perform lifecycle operations such as stop, start, restart, or delete your container.

また、トップバー上にある quick action（クイック・アクション）ボタンを使っても、CLI を開いてコンテナ内でコマンドを実行するような共通操作を行えます。また、コンテナに対する停止、起動、再起動、削除のようなライフサイクルの操作も行えます。

.. Click Port to open the port exposed by the container in a browser.

**Port** をクリックし、コンテナが公開（露出）しているポートをブラウザで開きます。

.. Spring app browser view

.. Feedback

.. _dashboard-feedback:

フィードバック
====================

.. We would like to hear from you about the new Dashboard UI. Let us know your feedback by creating an issue in the docker/for-mac or docker/for-win GitHub repository.

新しいダッシュボードのユーザーインターフェースについて、皆さんから伺いたいです。あなたのフィードバックをお知らせいただくには、`docker/for-mac <https://github.com/docker/for-mac/issues>`_ や `docker/for-win GitHub <https://github.com/docker/for-win/issues>`_ リポジトリで issue を作成ください。

.. seealso::

   Docker Desktop Dashboard
      https://docs.docker.com/desktop/dashboard


