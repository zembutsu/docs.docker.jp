.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/get-started/02_our_app/
   doc version: 24.0
      https://github.com/docker/docker.github.io/blob/master/get-started/02_our_app.md
.. check date: 2023/07/16
.. Commits on Jun 28, 2023 50ea31a03d158ce12466422856930e4666451a3d
.. -----------------------------------------------------------------------------

.. Containerize an application
.. _containerize-an-application:

========================================
アプリケーションのコンテナ化
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 2
       :local:

.. For the rest of this guide, you’ll be working with a simple todo list manager that runs on Node.js. If you’re not familiar with Node.js, don’t worry. This guide doesn’t require any prior experience with JavaScript.

以降のガイドでは、 Node.js で動作するシンプルな Todo リスト管理を扱います。Node.js に慣れていなくても、心配はいりません。このガイドでは JavaScript の事前経験は要りません。

.. To complete this guide, you’ll need the following:

このガイドを終えるために、以下の項目が必要です：

..  Docker running locally. Follow the instructions to download and install Docker.
    A Git client.
        Note
        If you use Windows and want to use Git Bash to run Docker commands, see Working with Git Bash for syntax differences.
    An IDE or a text editor to edit files. Docker recommends using Visual Studio Code.
    A conceptual understanding of containers and images.

* ローカルで動作する Docker。 :doc:`Docker のダウンロードとインストール </get-docker>` の手順に従ってください。
* `Git クライアント <https://git-scm.com/downloads>`_ 。

   .. note::
   
      Windows を利用中で、Git Bash を使って Docker コマンドを実行したい場合は、構文の違いについて :ref:`desktop-topics-windows-working-with-git-bash` を御覧ください。

* ファイルを編集するための IDE （統合開発環境）やテキストエディタ。Docker は `Visual Studio Code <https://code.visualstudio.com/>`_ の利用を推奨します。
* :ref:`コンテナとイメージ <overview-docker-objects>` の概念を理解。

.. Get the app
.. _get-the-app:

アプリの入手
====================

.. Before you can run the application, you need to get the application source code onto your machine.

アプリケーションを実行する前に、マシン上にアプリケーションのソースコードを入手する必要があります。

.. Clone the getting-started repository using the following command:
    git clone https://github.com/docker/getting-started.git
   View the contents of the cloned repository. Inside the getting-started/app directory you should see package.json and two subdirectories (src and spec).

1. 次のコマンドを使い、 `getting-started リポジトリ <https://github.com/docker/getting-started/tree/master>`_ をクローンします。

   .. code-block:: bash
   
      $ git clone https://github.com/docker/getting-started.git

2. クローンしたリポジトリの内容を表示します。 ``getting-started/app`` ディレクトリ内に、 ``package.json`` と2つのサブディレクトリ（ ``src`` と ``spec`` ）が見えるでしょう。

   .. image:: ./images/ide-screenshot.png
      :width: 60%
      :alt: Virusl Studio Code で 読み込んだアプリのスクリーンショット

.. Build the app’s container image
.. _build-the-apps-container-image:

アプリのコンテナ イメージを :ruby:`構築 <build>`
==================================================

.. To build the container image, you’ll need to use a Dockerfile. A Dockerfile is simply a text-based file with no file extension that contains a script of instructions. Docker uses this script to build a container image.

:ref:`コンテナ イメージ <overview-docker-objects>` を :ruby:`構築 <build>` するには、 ``Dockerfile`` を使う必要があります。Dockerfile とはシンプルな文字情報を主体とするファイルで、ファイルの拡張子がありません。このファイル内に命令のスクリプトが入っています。Docker はコンテナ イメージを構築するために、このスクリプトを使います。

.. In the app directory, the same location as the package.json file, create a file named Dockerfile. You can use the following commands below to create a Dockerfile based on your operating system.

1.  同じ場所に ``package.json`` ファイル等がある ``app`` ディレクトリ内で、 ``Dockerfile`` という名前のファイルを作成します。使っているオペレーティングシステムに応じた Dockerfile を作成するには、以下のコマンドが使えます。

   **Mac / Linux**

      .. In the terminal, run the following commands listed below.
      .. Change directory to the app directory. Replace /path/to/app with the path to your getting-started/app directory.
      
      ターミナル上で、以下に記載してあるコマンドを実行します。
      ディレクトリを ``app`` ディレクトリに変更します。 ``/path/to/app`` を ``getting-started/app`` ディレクトリのパスに置き換えます。
      
      .. code-block:: bash
      
         $ cd /path/to/app
      
      ``Dockerfile`` という名前の空ファイルを作成します。
      
      .. code-block:: bash
      
         $ touch Dockerfile

   **Windows**

      .. In the Windows Command Prompt, run the following commands listed below.
      
      Windows コマンドプロンプト上で、以下に記載してあるコマンドを実行します。
      ディレクトリを ``app`` ディレクトリに変更します。 ``\path\to\app`` を ``getting-started\app`` ディレクトリのパスに置き換えます。
      
      .. code-block:: bash
      
         $ cd \path\to\app
      
      ``Dockerfile`` という名前の空ファイルを作成します。
      
      .. code-block:: bash
      
         $ type nul > Dockerfile


.. Using a text editor or code editor, add the following contents to the Dockerfile:

2. テキストエディタかコードエディタを使い、Dockerfile に以下の内容を追加します。

   .. code-block:: Dockerfile
   
      # syntax=docker/dockerfile:1
      FROM node:18-alpine
      WORKDIR /app
      COPY . .
      RUN yarn install --production
      CMD ["node", "src/index.js"]
      EXPOSE 3000


.. Build the container image using the following commands:

3. 以下のコマンドを使い、コンテナイメージを構築します。

   .. In the terminal, change directory to the getting-started/app directory. Replace /path/to/app with the path to your getting-started/app directory.

   ターミナル上で、ディレクトリを ``getting-started/app`` ディレクトリに変更します。 ``/path/to/app`` のパスは、自分の ``getting-started/app`` ディレクトリに置き換えます。
   
   .. code-block:: bash
   
      $ cd /path/to/app
   
   
   .. Build the container image.
   
   コンテナイメージを構築します。
   
   .. code-block:: bash
   
      $ docker build -t getting-started .
   
   .. The docker build command uses the Dockerfile to build a new container image. You might have noticed that Docker downloaded a lot of “layers”. This is because you instructed the builder that you wanted to start from the node:18-alpine image. But, since you didn’t have that on your machine, Docker needed to download the image.
   
   ``docker build`` コマンドは Dockerfile を使い新しいコンテナイメージを構築します。Docker が多くの「 :ruby:`レイヤー <layer>` 」をダウンロードするのが分かるでしょう。こうなるのは、 :ruby:`構築用プログラム <builder>` に対して ``node:18-alpine`` イメージから始めると命令したからです。ですが、まだマシン上にイメージがないため、 Docker はイメージをダウンロードする必要があります。

   .. After Docker downloaded the image, the instructions from the Dockerfile copied in your application and used yarn to install your application’s dependencies. The CMD directive specifies the default command to run when starting a container from this image.
   
   Docker がイメージをダウンロードした後は、 Dockerfile の命令によってアプリケーションをコピーし、それから、 ``yarn`` を使ってアプリケーションの依存関係をインストールします。 ``CMD`` 命令は、このイメージからコンテナを起動したとき、デフォルトで実行するコマンドを指定します。

   .. Finally, the -t flag tags your image. Think of this simply as a human-readable name for the final image. Since you named the image getting-started, you can refer to that image when you run a container.
   
   最後に ``-t`` フラグでイメージに :ruby:`タグ <tag>` を付けます。タグとは、最終イメージに対して、人間が読める名前を単に付けるためと考えてください。このイメージには ``getting-started`` と名前を付けましたので、このイメージ名を示してコンテナを実行できます。

   .. The . at the end of the docker build command tells Docker that it should look for the Dockerfile in the current directory.

   ``docker build`` コマンドの最後にある ``.`` は、Docker に対して、現在のディレクトリ内にある ``Dockerfile`` を探すべきと命令します。

.. Start an app container
.. _start-an-app-container:

アプリ コンテナの起動
==============================

.. Now that you have an image, you can run the application in a container. To do so, you will use the docker run command.

イメージが手に入りましたので、コンテナ内でアプリケーションを実行できます。そのためには、 ``docker run`` コマンドを使います。

.. Start your container using the docker run command and specify the name of the image you just created:

1. コンテナを起動するには、 ``docker run`` コマンドを使い、先ほど作成したイメージ名を指定します。

   .. code-block:: bash
   
      $ docker run -dp 127.0.0.1:3000:3000 getting-started

   .. The -d flag (short for --detach) runs the container in the background. The -p flag (short for --publish) creates a port mapping between the host and the container. The -p flag take a string value in the format of HOST:CONTAINER, where HOST is the address on the host, and CONTAINER is the port on the container. The command shown here publishes the container’s port 3000 to 127.0.0.1:3000 (localhost:3000) on the host. Without the port mapping, you wouldn’t be able to access the application from the host.
   
   ``--d`` フラグ（ ``--detach`` の省略）は、コンテナをバックグラウンドで実行します。 ``-p`` フラグ（ ``--publish`` の省略）は、ホストとコンテナ間でポートの関連付け（ :ruby:`ポート マッピング <port mapping>` ）を作成します。 ``-p`` フラグは ``HOST:CONTAINER`` という書式の文字列値です。 ``HOST`` はホスト上のアドレスにあたり、 ``CONTAINER`` はコンテナ上で対象となるポートです。このコマンドが示すのは、コンテナのポート 3000 をホスト上の ``127.0.0.1:3000`` （ ``localhost:3000`` ）へ公開します。ポート割り当ての指定がなければ、ホスト上からアプリケーションに接続できません。

.. After a few seconds, open your web browser to http://localhost:3000. You should see your app.

2. 数秒後、自分のウェブ ブラウザで http://localhost:3000  を開きます。そうしたら、私たちのアプリが見えるでしょう。

   .. image:: ./images/todo-list-empty.png
      :width: 60%
      :alt: まだ何も入っていない ToDo List

.. Go ahead and add an item or two and see that it works as you expect. You can mark items as complete and remove them. Your frontend is successfully storing items in the backend.

3. あとはアイテムを1つ2つと追加したら、期待通りに動作するでしょう。完了したアイテムに印を付けると、アイテムを削除できます。このように、フロントエンドはバックエンドへのアイテム保存に成功しています。

.. At this point, you should have a running todo list manager with a few items, all built by you.

この時点で、全て自分で構築した todo リストマネージャは実行中で、複数のアイテムが入っています。

.. If you take a quick look at your containers, you should see at least one container running that is using the getting-started image and on port 3000. To see your containers, you can use the CLI or Docker Desktop’s graphical interface.

ここでコンテナをちょっと調べると、 ``getting-started`` イメージを使い、ポート ``3000`` を使っている実行中のコンテナが、少なくとも1つ見えるでしょう。コンテナを調べるには、 CLI か Docker Desktop のグラフィカルインターフェースが使えます。

**CLI**

   .. Run the following docker ps command in a terminal to list your containers.
   コンテナ一覧を表示するには、ターミナル上で以下の ``docker ps`` コマンドを実行します。
   
   .. code-block:: bash
   
      $ docker ps


   .. Output similar to the following should appear.
   次のような出力が表示されます。
   
   .. code-block:: bash
   
      CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                      NAMES
      df784548666d        getting-started     "docker-entrypoint.s…"   2 minutes ago       Up 2 minutes        127.0.0.1:3000->3000/tcp   priceless_mcclintock


**Docker Desktop**

   .. In Docker Desktop, select the Containers tab to see a list of your containers.
   Docker Desktop では、コンテナ一覧を表示するには **Containers** タブを選びます。


   .. image:: ./images/dashboard-two-containers.png
      :alt: Docker ダッシュボードにはチュートリアルとアプリ用コンテナが実行中

.. Next steps
.. _part2-next-steps:

次のステップ
====================

.. In this short section, you learned the basics about creating a Dockerfile to build a container image. Once you built an image, you started a container and saw the running app.

この短いセクションでは、コンテナ イメージを構築するための、 Dockerfile を作成する基本を学びました。イメージを構築した後、コンテナを実行し、アプリケーションが動作しているのが見えます。

.. Next, you’re going to make a modification to your app and learn how to update your running application with a new image. Along the way, you’ll learn a few other useful commands.

次はアプリに変更を加え、実行中のアプリケーションを新しいイメージに更新する方法を学びます。その途中で、幾つかの便利なコマンドも学びます。

.. raw:: html

   <div style="overflow: hidden; margin-bottom:20px;">
      <a href="03_updating_app.html" class="btn btn-neutral float-left">アプリケーションの更新 <span class="fa fa-arrow-circle-right"></span></a>
   </div>


.. seealso::

   Containerize an application
      https://docs.docker.com/get-started/02_our_app



