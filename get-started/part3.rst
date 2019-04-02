.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/get-started/part3/
   doc version: 17.06
      https://github.com/docker/docker.github.io/blob/master/get-started/part3.md
.. check date: 2017/09/09
.. Commits on Aug 30 2017 9a1330e96612fd72ee0ca7c40a289d7c2ce87504
.. -----------------------------------------------------------------------------

.. Get Started, Part 3: Services

========================================
Part 3：サービス
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 2
       :local:

.. Prerequisites

必要条件
==========

..    Install Docker version 1.13 or higher.
    Get Docker Compose. On Docker for Mac and Docker for Windows it’s pre-installed, so you’re good-to-go. On Linux systems you will need to install it directly. On pre Windows 10 systems without Hyper-V, use Docker Toolbox.
    Read the orientation in Part 1.
    Learn how to create containers in Part 2.
    Make sure you have published the friendlyhello image you created by pushing it to a registry. We’ll use that shared image here.
    Be sure your image works as a deployed container. Run this command, slotting in your info for username, repo, and tag: docker run -p 80:80 username/repo:tag, then visit http://localhost/.

* :doc:`Docker バージョン 1.13 またはそれ以上をインストールすること。</engine/installation/index>`
.. ↓実際の手順では不要なため、コメントアウト
.. * :doc:`Docker Compose </compose/overview>` を入手。 Docker for Mac と Docker for Windows ではインストール済みなので、このまま読み進めてください。Linux システムでは `直接インストール <https://github.com/docker/compose/releases>`_ が必要です。Widows 10 システム上で Hyper-V が入っていなければ、 :doc:`Docker Toolbox </toolbox/overview>` をお使い下さい。
* :doc:`Part 1 <index>` の概要説明を読んでいること。
* :doc:`Part 2 <part>` のコンテナの作成方法を学んでいること。
* :ref:`レジストリに送信 <share-your-image>` して作成した ``friendlyhello`` イメージが共有可能であることを確認します。ここではその共有イメージを使います。
* デプロイしたコンテナとしてイメージが動作することを確認します。以下のコマンドを実行してください。`docker run -p 80:80 username/repo:tag`  ここで username、repo、tag の部分は各環境に合わせて書き換えてください。そして ``http://localhost/`` にアクセスします。

.. Introduction

はじめに
==========

.. In part 3, we scale our application and enable load-balancing. To do this, we must go one level up in the hierarchy of a distributed application: the service.

Part 3では、アプリケーションをスケールアップして、負荷分散（ロード・バランシング）を有効にします。こうするためには、分散アプリケーションのレベルを一段あげる必要があります。**サービス化** するということです。

..    Stack
    Services (ここにいます)
    Container 

* スタック
* サービス ``Services`` （今ここにいます）
* コンテナ（ :doc:`part 2 <part2>` で扱いました）

.. _aobut-services:

.. About services

サービスとは
====================

.. In a distributed application, different pieces of the app are called “services.” For example, if you imagine a video sharing site, it probably includes a service for storing application data in a database, a service for video transcoding in the background after a user uploads something, a service for the front-end, and so on.

分散アプリケーションにおいては、その中に他の要素とは性格が異なる「サービス」と呼ばれるものがあります。例えば動画共有サイトを考えてみてください。おそらくはアプリケーションデータをデータベースに保存するためのサービスがあり、ユーザがデータをアップロードしたときにバックグラウンドでビデオ変換するサービスがあり、フロントエンドのサービスもあるでしょう。

.. Services are really just “containers in production.” A service only runs one image, but it codifies the way that image runs—what ports it should use, how many replicas of the container should run so the service has the capacity it needs, and so on. Scaling a service changes the number of container instances running that piece of software, assigning more computing resources to the service in the process.

サービスとは正に「稼動するコンテナ」なのです。どのサービスも実行するイメージはただ一つですが、そこにはイメージの動作方法がコーディングされています。ポートは何番を使うか、サービスが持つべき性能を発揮するにはレプリカをいくつ用いればよいか、などです。サービスの規模を大きくすると、このソフトウエアを実行するコンテナ・インスタンスの数が変わります。またプロセス内で実行されるこのサービスへのコンピュータ・リソース割り当てが増えます。

.. Luckily it’s very easy to define, run, and scale services with the Docker platform – just write a docker-compose.yml file.

うれしいことに Docker では簡単にサービスの定義、実行、規模変更を行うことができます。ただ ``docker-compose.yml`` ファイルを書くだけです。

.. Your first docker-compose.yml file

.. _your-first-docker-compose-yml-file:

初めての ``docker-compose.yml`` ファイル
==================================================

.. A docker-compose.yml file is a YAML file that defines how Docker containers should behave in production.

``docker-compose.yml`` ファイルは YAML ファイルであり、Docker コンテナがどのように動作するかを定義します。

``docker-compose.yml``

.. Save this file as docker-compose.yml wherever you want. Be sure you have pushed the image you created in Part 2 to a registry, and update this .yml by replacing username/repo:tag with your image details.

以下の内容を任意の場所に ``docker-commpose.yml`` として保存します。 :doc:`Part 2 <part2>` でレジストリに :ref:`送信したイメージ <share-your-image>` を確認し、 ``.yml`` ファイルの ``username/repo:tag`` の部分を皆さんのイメージのものへ書き換えます。

.. code-block:: yamo

   version: "3"
   services:
     web:
       # username/repo:tag を皆さんの名前とイメージに置き換えます
       image: username/repository:tag
       deploy:
         replicas: 5
         resources:
           limits:
             cpus: "0.1"
             memory: 50M
         restart_policy:
           condition: on-failure
       ports:
         - "80:80"
       networks:
         - webnet
   networks:
     webnet:

.. This docker-compose.yml file tells Docker to do the following:

この ``docker-compose.yml`` ファイルが Docker に対して以下の指示を行います:

..    Pull the image we uploaded in step 2 from the registry.
    Run 5 instances of that image as a service called web, limiting each one to use, at most, 10% of the CPU (across all cores), and 50MB of RAM.
    Immediately restart containers if one fails.
    Map port 80 on the host to web’s port 80.
    Instruct web’s containers to share port 80 via a load-balanced network called webnet. (Internally, the containers themselves will publish to web’s port 80 at an ephemeral port.)
    Define the webnet network with the default settings (which is a load-balanced overlay network).

* :doc:`Step 2 でアップロードしたイメージ` をレジストリから取得。
* イメージのインスタンスを５つ実行し ``web`` という名前のサービスとして実行。それぞれのインスタンスは（全てのコアを通じて）最大で CPU の 10% の利用までに制限し、RAM は 50MB とする。
* コンテナが停止したときは、すぐに再起動。
* ホスト側のポート 80 を ``web`` のポート 80 に割り当て。
* ``web`` のコンテナに対し、 ``webnet`` という名前の負荷分散ネットワークを経由してポート 80 を共有するよう命令（内部では、コンテナ自身の一時的なポートとして、 ``web`` のポート 80 を公開 ）
* デフォルトの設定として ``webnet`` ネットワークを定義（負荷分散されるオーバレイ・ネットワーク）

..    Wondering about Compose file versions, names, and commands?
..    Notice that we set the Compose file to version: "3". This essentially makes it swarm mode compatible. We can make use of the deploy key (only available on Compose file formats version 3.x and up) and its sub-options to load balance and optimize performance for each service (e.g., web). We can run the file with the docker stack deploy command (also only supported on Compose files version 3.x and up). You could use docker-compose up to run version 3 files with non swarm configurations, but we are focusing on a stack deployment since we are building up to a swarm example.
..    You can name the Compose file anything you want to make it logically meaningful to you; docker-compose.yml is simply a standard name. We could just as easily have called this file docker-stack.yml or something more specific to our project.

.. hint::

   Compose ファイルのバージョン、名前、コマンドの疑問について。
   Compose ファイルに ``version: "3"`` とあるのにご注意ください。こちらは :doc:`swarm mode </engine/swarm/index>` 互換を意味します。これは :ref:`deploy キー <compose-file-deploy>` を使うためであり（ :doc:`Compose ファイル・フォーマット・バージョン 3.x </compose/compose-file/toc>` 以上のみ対応）、サブオプションとして各サービスごと（例： ``web`` ）の負荷分散とパフォーマンスを最適化します。ファイルを ``docker stack deploy`` コマンドで実行可能です（こちらもサポート対象は Compose ファイルがバージョン 3.x 以上のみ）。 swarm 設定のないバージョン３のファイルは ``docker-compose up`` でも実行可能ですが、これから構築する swarm のサンプルでは、stack を使ったデプロイにフォーカスします。

.. _run-your-new-load-balanced-app:

.. Run your new load-balanced app

新しい負荷分散アプリケーションの実行
========================================

.. Before we can use the docker stack deploy command we’ll first run:


``docker stack deploy`` コマンドを実行する前に、以下を実行します：

.. code-block:: bash

   docker swarm init

..    Note: We’ll get into the meaning of that command in part 4. If you don’t run docker swarm init you’ll get an error that “this node is not a swarm manager.”

.. note::

   このコマンドの意味については :doc:`Part 4 <part4>` で説明します。もしも ``docker swarm init`` コマンドを実行しなければ、 "this node is not a swarm manager." （このノードは swarm マネージャではありません）とエラーが出ることになります。

.. Now let’s run it. You have to give your app a name. Here, it is set to getstartedlab:

次のコマンドを実行します。アプリには名前を付ける必要があります。ここでは ``getstartedlab`` と指定します：

.. code-block:: bash

   docker stack deploy -c docker-compose.yml getstartedlab

.. Our single service stack is running 5 container instances of our deployed image on one host. Let’s investigate.

サービス・スタックでは、ホスト上にデプロイしたイメージを使った５つのコンテナインスタンスが実行中です。詳細を調べましょう。

.. Get the service ID for the one service in our application:

アプリケーションのサービスが持つサービス ID を取得します。

.. code-block:: bash

   docker service ls

.. Docker swarms run tasks that spawn containers. Tasks have state and their own IDs:

Docker swarm（クラスタ）は作成したコンテナを、タスクとして実行します。タスクは状態（state）と各々が自身の ID を持ちます。

.. code-block:: bash

   docker service ps <service>

..    Note: Docker’s support for swarms is built using a project called SwarmKit. SwarmKit tasks do not need to be containers, but Docker swarm tasks are defined to spawn them.

.. note::

   Docker が swarm クラスタをサポートするにあたって、 SwarmKit と呼ばれるプロジェクトを構築に用いています。SwarmKit のタスクにコンテナは必須ではありませんが、Docker swarm のタスクにはコンテナの作成が定義されています。

.. Let’s inspect one task and limit the ouput to container ID:

それでは、タスクを調べ、コンテナ ID の出力を確認しましょう。

.. code-block:: bash

   docker inspect --format='{{.Status.ContainerStatus.ContainerID}}' <task>

.. Vice versa, inspect the container ID, and extract the task ID:

同様に、コンテナ ID を調べ、タスク ID を展開しましょう。

.. code-block:: bash

   docker inspect --format="{{index .Config.Labels \"com.docker.swarm.task.id\"}}" <container>

.. Now list all 5 containers:

ここでは５つのコンテナ全てを一覧表示します。

.. code-block:: bash

   docker container ls -q

.. You can run curl http://localhost several times in a row, or go to that URL in your browser and hit refresh a few times. Either way, you’ll see the container ID change, demonstrating the load-balancing; with each request, one of the 5 replicas is chosen, in a round-robin fashion, to respond.

``curl http://localhost`` コマンドを何度も実行するか、ブラウザで URL を何度か再読み込みします。そうしますと、アクセスごとにコンテナ ID の表示が変わり、負荷分散が動作しているのがわかります。つまり、５つのレプリカのうち１つが選ばれる、ラウンドロビン方式で応答します。

..    Note: At this stage, it may take up to 30 seconds for the containers to respond to HTTP requests. This is not indicative of Docker or swarm performance, but rather an unmet Redis dependency that we will address later in the tutorial.

.. note::

   この段階では、コンテナが HTTP リクエストに応答するまで 30 秒ほどかかります。これは Docker や swarm の性能によるものではなく、Redis の依存関係による影響です。本件についてはチュートリアルの後半で扱います。

.. Scale the app

アプリのスケール
====================

.. You can scale the app by changing the replicas value in docker-compose.yml, saving the change, and re-running the docker stack deploy command:

``docker-compose.yml`` の ``replicas`` 値の変更し、アプリをスケールできます。変更を保存したら、 ``docker stack deploy`` コマンドを再度実行します。

.. code-block:: bash

   docker stack deploy -c docker-compose.yml getstartedlab

.. Docker will do an in-place update, no need to tear the stack down first or kill any containers.

Docker は現状のまま更新を行いますので、スタックの停止やコンテナを停止する必要はありません。

.. Now, re-run docker container ls -q to see the deployed instances reconfigured. If you scaled up the replicas, more tasks, and hence, more containers, are started.

次は ``docker container ls -q`` を再度実行しますと、指定したインスタンスのデプロイを確認できます。レプリカをスケールアップしていれば、より多くのタスクが起動しますので、より多くのコンテナが起動します。

.. Take down the app and the swarm

.. _tkae-down-the-app-and-the-swarm:

アプリと swarm の解体（停止）
==============================

.. Take the app down with docker stack rm:

``docker stack rm`` でアプリケーションを停止します。

.. code-block:: bash

   docker stack rm getstartedlab

.. This removes the app, but our one-node swarm is still up and running (as shown by docker node ls). Take down the swarm with docker swarm leave --force.

これはアプリケーションを削除（remove）しますが、１つの swarm ノードは起動および実行したままです（ ``docker node ls`` で表示します）。swarm （クラスタ）を停止するには ``docker swarm leave --force`` を実行します。

.. It’s as easy as that to stand up and scale your app with Docker. You’ve taken a huge step towards learning how to run containers in production. Up next, you will learn how to run this app as a bonafide swarm on a cluster of Docker machines.

Docker はアプリケーションの起動だけでなくスケールも非常に簡単です。コンテナをプロダクションで動かす方法を学ぶのに、大きな前進です。次は、Docker マシンのクラスタ上で動作する swarm で、このアプリを動かす方法を学びましょう。

..    Note: Compose files like this are used to define applications with Docker, and can be uploaded to cloud providers using Docker Cloud, or on any hardware or cloud provider you choose with Docker Enterprise Edition.

.. note::

   Docker では今回使ったような Compose ファイルでアプリケーションを定義します。そして、 :doc:`Docker Cloud </docker-cloud/index>` を用いたクラウド・プロバイダへのアップロードや、 `Docker Enterprise エディション <https://www.docker.com/enterprise-edition>`_ で任意のハードウェアやクラウド・プロバイダを利用できます。

.. On to “Part 4” »

* :doc:`Part 4へ進む <part4>`

.. Recap and cheat sheet (optional)

まとめとチート・シート（オプション）
========================================

.. Here’s a terminal recording of what was covered on this page:

`このページで扱ったターミナルの録画 <https://asciinema.org/a/b5gai4rnflh7r0kie01fx6lip>`_ がこちらです。

.. To recap, while typing docker run is simple enough, the true implementation of a container in production is running it as a service. Services codify a container’s behavior in a Compose file, and this file can be used to scale, limit, and redeploy our app. Changes to the service can be applied in place, as it runs, using the same command that launched the service: docker stack deploy.

復習として ``docker run`` を実行するだけで、コンテナをプロダクションにおけるサービスとして正に実装されているのが分かるでしょう。コンテナの挙動をサービスとして Compose ファイルでコード化し、これを使ったアプリのスケール、制限、再デプロイに用いられます。サービスに対するする変更とは、変更箇所を書き換えての適用であり、サービスを起動するときと同じコマンド ``docker stack deploy`` を実行するだけです。

.. Some commands to explore at this stage:

現時点における複数のコマンドを見てみましょう。

.. code-block:: bash

   docker stack ls                                          # スタックやアプリ一覧
   docker stack deploy -c <composefile> <appname>  # 特定の Compose ファイルを実行
   docker service ls                          # アプリに関係ある実行中サービス一覧
   docker service ps <service>                        # アプリに関係あるタスク一覧
   docker inspect <task or container>                 # タスクまたはコンテナの調査
   docker container ls -q                                     # コンテナ ID の一覧
   docker stack rm <appname>                                # アプリケーションの解体

.. seealso::

   Get Started, Part 3: Services | Docker Documentation
      https://docs.docker.com/get-started/part3/

