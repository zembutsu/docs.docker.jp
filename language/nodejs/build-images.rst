.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/language/nodejs/build-images/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/language/nodejs/build-images.md
.. check date: 2022/09/23
.. Commits on Jul 15, 2022 2482f8ce04317b2c56301ea9885bb9a947b232d3
.. -----------------------------------------------------------------------------

.. Build your Node image
.. _build-your-node-image:

========================================
自分の Node イメージを構築
========================================

.. Prerequisites
.. _nodejs-prerequisites:

事前準備
==========

.. Work through the orientation and setup in Get started Part 1 to understand Docker concepts.

Docker の概念を理解するため、導入ガイド :doc:`Part 1 </get-started/index>` での説明を読み、準備をしてください。

.. Enable BuildKit
.. _nodejs-enable-buildkit:

BuildKit 有効化
--------------------

.. Before we start building images, ensure you have enabled BuildKit on your machine. BuildKit allows you to build Docker images efficiently. For more information, see Building images with BuildKit.

イメージの構築を始める前に、マシン上で BuildKit を有効化します。 BuildKit があれば Docker イメージを効率的に構築できます。詳しい情報は、 :doc:`/develop/develop-images/build_enhancements` をご覧ください。

.. BuildKit is enabled by default for all users on Docker Desktop. If you have installed Docker Desktop, you don’t have to manually enable BuildKit. If you are running Docker on Linux, you can enable BuildKit either by using an environment variable or by making BuildKit the default setting.

Docker Desktop 上のすべてのユーザは、デフォルトで BuildKit は有効化されています。Docker Desktop をインストール済みの場合、手動で BuildKit を有効化する必要はありません。 Linux 上で Docker を動かしている場合は、 BuildKit を有効化するため、環境変数を設定するか、 BuildKit がデフォルトになるよう設定を変更します。

.. To set the BuildKit environment variable when running the docker build command, run:

``docker build`` コマンドの実行時、 BuildKit 環境編集を設定するには、次のように実行します。

.. code-block:: bash

   $ DOCKER_BUILDKIT=1 docker build .

.. To enable docker BuildKit by default, set daemon configuration in /etc/docker/daemon.json feature to true and restart the daemon. If the daemon.json file doesn’t exist, create new file called daemon.json and then add the following to the file.

Docker で BuildKit をデフォルトで有効化するには、 ``/etc/docker/daemon.json`` のデーモン設定で機能を ``true`` にし、デーモンを再起動します。 ``daemon.json`` ファイルが存在しなければ、 ``daemon.json`` という名前でファイルを作成し、ファイル内に以下を追加します。

.. code-block:: yaml

   {
     "features":{"buildkit" : true}
   }

.. Restart the Docker daemon.

Docker デーモンを再起動します。

.. Overview
.. _nodejs-build-images-overview:

概要
==========

.. Now that we have a good overview of containers and the Docker platform, let’s take a look at building our first image. An image includes everything you need to run an application - the code or binary, runtime, dependencies, and any other file system objects required.

これでコンテナと Docker プラットフォームの概要が分かりましたので、初めてのイメージを構築しましょう。イメージにはアプリケーションの実行に必要な全てを含みます。具体的には、コードやバイナリ、ランタイム、依存関係、必要なその他のファイルシステムです。

.. To complete this tutorial, you need the following:

このチュートリアルを終えるには、以下が必要です。

..  Node.js version 12.18 or later. Download Node.js
    Docker running locally: Follow the instructions to download and install Docker.
    An IDE or a text editor to edit files. We recommend using Visual Studio Code.

* Node.js バージョン 12.18 以上。 `Node.js のダウンロード <https://nodejs.org/ja/>`_ 
* Docker をローカルで実行： :doc:`Docker のダウンロードとインストール </desktop/index>` の手順に従う
* ファイルを編集するため、 IDE やテキストエディタ： Visual Studio Code の使用を推奨

.. Sample application
.. _nodejs-sample-application:

サンプル アプリケーション
==============================

.. Let’s create a simple Node.js application that we can use as our example. Create a directory in your local machine named node-docker and follow the steps below to create a simple REST API.

例として使える、簡単な Node.js アプリケーションを作りましょう。ローカルマシン内に ``node-docker`` という名前のディレクトリを作成し、簡単な REST API を作成するため、以下の手順を進めます。

.. code-block:: yaml

   $ cd [path to your node-docker directory]
   $ npm init -y
   $ npm install ronin-server ronin-mocks
   $ touch server.js

.. Now, let’s add some code to handle our REST requests. We’ll use a mock server so we can focus on Dockerizing the application.

次は、 REST リクエストを扱うコードをいくつか追加します。Docker 化アプリケーションに集中できるようにするため、モックサーバを使います。

.. Open this working directory in your IDE and add the following code into the server.js file.

この作業ディレクトリを IDE で開き、以下のコードを ``server.js`` に追加します。

.. code-block:: js

   const ronin = require('ronin-server')
   const mocks = require('ronin-mocks')
   
   const server = ronin.server()
   
   server.use('/', mocks.server(server.Router(), false, true))
   server.start()

.. The mocking server is called Ronin.js and will listen on port 8000 by default. You can make POST requests to the root (/) endpoint and any JSON structure you send to the server will be saved in memory. You can also send GET requests to the same endpoint and receive an array of JSON objects that you have previously POSTed.

モック用サーバは ``Ronin.js`` と呼ばれ、デフォルトでポート 8000 をリッスンします。ルート（/）エンドポイントに対して POST リクエストすると、サーバに送信したあらゆる JSON 構造がメモリ内に保存されます。また、同じエンドポイントに GET リクエストを送信すると、先ほど POST 済みの JSON オブジェクトをアレイ形式で受け取ります。

.. Test the application
.. _nodejs-test-the-application:

アプリケーションのテスト
==============================

.. Let’s start our application and make sure it’s running properly. Open your terminal and navigate to your working directory you created.

アプリケーションを起動し、正しく動作するか確認しましょう。ターミナルを開き、作成済みの作業ディレクトリに移動します。

.. code-block:: yaml

   $ node server.js

.. To test that the application is working properly, we’ll first POST some JSON to the API and then make a GET request to see that the data has been saved. Open a new terminal and run the following curl commands:

アプリケーションが正しく動作しているか確認するには、まず何らかの JSON を API に POST し、それから GET リクエストを作成し、保存されたデータを確認します。新しいターミナルを開き、以下の curl コマンドを実行します。

.. code-block:: bash

   $ curl --request POST \
     --url http://localhost:8000/test \
     --header 'content-type: application/json' \
     --data '{"msg": "testing" }'
   {"code":"success","payload":[{"msg":"testing","id":"31f23305-f5d0-4b4f-a16f-6f4c8ec93cf1","createDate":"2020-08-28T21:53:07.157Z"}]}
   
   $ curl http://localhost:8000/test
   {"code":"success","meta":{"total":1,"count":1},"payload":[{"msg":"testing","id":"31f23305-f5d0-4b4f-a16f-6f4c8ec93cf1","createDate":"2020-08-28T21:53:07.157Z"}]}

.. Switch back to the terminal where our server is running. You should now see the following requests in the server logs.

サーバを実行しているターミナルに切り戻します。サーバログには以下のリクエストが表示されます。

.. code-block:: bash

   2020-XX-31T16:35:08:4260  INFO: POST /test
   2020-XX-31T16:35:21:3560  INFO: GET /test

.. Great! We verified that the application works. At this stage, you’ve completed testing the server script locally.

すばらしい！ アプリケーションの動作を確認しました。この段階では、サーバのスクリプトのテストをローカルで行いました。

.. Press CTRL-c from within the terminal session where the server is running to stop it.

サーバを実行中のターミナルセッション内で ``CTRL-c`` を押すと、サーバが停止します。

.. code-block:: bash

   2021-08-06T12:11:33:8930  INFO: POST /test
   2021-08-06T12:11:41:5860  INFO: GET /test
   ^Cshutting down...

.. We will now continue to build and run the application in Docker.

続いて、 Docker でアプリケーションの構築と実行をします。


.. Create a Dockerfile for Node.js
.. _create-a-dockerfile-for-nodejs:

Node.js 用の Dockerfile を作成
==============================

.. A Dockerfile is a text document that contains the instructions to assemble a Docker image. When we tell Docker to build our image by executing the docker build command, Docker reads these instructions, executes them, and creates a Docker image as a result.

Dockerfile は Docker イメージを組み立てる命令を含むテキスト文章です。 ``docker build`` コマンドを実行し、 Docker に対してイメージ構築を命令すると、 Docker はこれらの命令を読み込み、命令を実行し、その結果を Docker イメージとして作成します。

.. Let’s walk through the process of creating a Dockerfile for our application. In the root of your project, create a file named Dockerfile and open this file in your text editor.

アプリケーションのために Dockerfile を作成する流れを見ていきましょう。プロジェクトのルートで、 ``Dockerfile`` という名前のファイルを作成し、このファイルをテキストエディタで開きます。

..  What to name your Dockerfile?
    The default filename to use for a Dockerfile is Dockerfile (without a file- extension). Using the default name allows you to run the docker build command without having to specify additional command flags.
    Some projects may need distinct Dockerfiles for specific purposes. A common convention is to name these Dockerfile.<something> or <something>.Dockerfile. Such Dockerfiles can then be used through the --file (or -f shorthand) option on the docker build command. Refer to the “Specify a Dockerfile” section in the docker build reference to learn about the --file option.
    We recommend using the default (Dockerfile) for your project’s primary Dockerfile, which is what we’ll use for most examples in this guide.

.. note::

   **Dockerfile の名前はどうしますか？**
   
   Dockerfile のデフォルトファイル名は ``Dockerfile`` です（拡張子はありません）。デフォルトの名前を使えば、 ``docker build`` コマンドの実行し、コマンドにフラグの追加が不要です。
   
   プロジェクトによっては、特定の目的に対して Dockerfile を分ける必要があるでしょう。一般的な慣習として、名前を ``Dockerfile.<何か>`` や ``<何か>.Dockerfile`` にします。このような Dockerfile は ``docker build`` コマンドで ``--file`` （ や省略形 ``-f``` ）オプションを渡して利用できます。 ``--file`` オプションについて学ぶには、 ``docker build`` リファレンスの :ref:`docker-build-specify-dockerfile` を参照ください。
   
   このガイドの大部分の例でも使われているように、プロジェクトで主となる Dockerfile には、デフォルト（ ``Dockerfile`` ）の利用を推奨します。

.. The first line to add to a Dockerfile is a # syntax parser directive. While optional, this directive instructs the Docker builder what syntax to use when parsing the Dockerfile, and allows older Docker versions with BuildKit enabled to upgrade the parser before starting the build. Parser directives must appear before any other comment, whitespace, or Dockerfile instruction in your Dockerfile, and should be the first line in Dockerfiles.

Dockerfile の1行目に追加するのは、 :ref:`# syntax パーサ ディレクティブ <builder-syntax>` です。この命令は「オプション」ですが、Docker ビルダがどの Dockerfile を使って解釈するかを指定できます。さらに、古い BuildKit が入っている Docker のバージョンで構築する前に、アップグレードをできるようにします。 :ref:`パーサ ディレクティブ <parser-directives>` は、 Dockerfile 内であらゆるコメント、空白、 Dockerfile より前に書く必要があるため、 Dockerfile では1行目に書くべきです。

.. code-block:: dockerfile

   # syntax=docker/dockerfile:1

.. We recommend using docker/dockerfile:1, which always points to the latest release of the version 1 syntax. BuildKit automatically checks for updates of the syntax before building, making sure you are using the most current version.

私たちは ``docker/dockerfile:1`` の指定を推奨します。これは、バージョン1構文の最新リリースを常に示します。 BuildKit は構築前、自動的に構文を確認するため、直近の現行バージョンを使えるようにします。

.. Next, we need to add a line in our Dockerfile that tells Docker what base image we would like to use for our application.

次は、Docker にアプリケーションが何のベースイメージを使うかを伝えるため、 Dockerfile に行を追加する必要があります。

.. code-block:: dockerfile

   # syntax=docker/dockerfile:1
   
   FROM node:12.18.1

.. Docker images can be inherited from other images. Therefore, instead of creating our own base image, we’ll use the official Node.js image that already has all the tools and packages that we need to run a Node.js application. You can think of this in the same way you would think about class inheritance in object oriented programming. For example, if we were able to create Docker images in JavaScript, we might write something like the following.

Docker イメージは他のイメージを :ruby:`継承 <inherit>` できます。そのため、自分でベースイメージを作成するのではなく、公式の Node.js イメージを使います。イメージには Node.js アプリケーションの実行に必要なツールとパッケージが全て入っています。これはオブジェクト指向プログラミング言語における、クラス継承と同じように考えられます。たとえば、 JavaScript で Docker イメージを作成できるならば、書き方は以下のようになります。

``class MyImage extends NodeBaseImage {}``

.. This would create a class called MyImage that inherited functionality from the base class NodeBaseImage.

これは ``MyImage`` と呼ぶクラスと作成し、基底クラス ``NodeBaseImage`` の機能性を継承します。

.. In the same way, when we use the FROM command, we tell Docker to include in our image all the functionality from the node:12.18.1 image.

同じような手法で、 ``FROM`` コマンドのしようとは、私たちのイメージの全機能が ``node:12.18.1`` イメージに入っていると Docker に伝えます。

..  Note
    If you want to learn more about creating your own base images, see Creating base images.

.. note::

   自分でベースイメージを作成する方法についての情報は :doc:`/develop/develop-images/baseimages` をご覧ください。

.. The NODE_ENV environment variable specifies the environment in which an application is running (usually, development or production). One of the simplest things you can do to improve performance is to set NODE_ENV to production.

``NODE_DEV`` 環境変数は、アプリケーションの動作環境を指定します（通常は、 development か production）。パフォーマンス改善にもっとも簡単な方法は、 ``NODE_ENV`` を ``production`` に指定します。

.. code-block:: dockerfile

   ENV NODE_ENV=production

.. To make things easier when running the rest of our commands, let’s create a working directory. This instructs Docker to use this path as the default location for all subsequent commands. This way we do not have to type out full file paths but can use relative paths based on the working directory.

以降のコマンドを実行しやすくるため、作業ディレクトリを作成しましょう。この命令は、以降すべてのコマンドを実行するデフォルトの場所として、指定したパスを使うよう Docker に対して伝えます。この方法によりフルパスを入力する必要がなくなりますが、その作業ディレクトリを基準とした相対パスで記述する必要があります。

.. code-block:: dockerfile

   WORKDIR /app

.. Usually the very first thing you do once you’ve downloaded a project written in Node.js is to install npm packages. This ensures that your application has all its dependencies installed into the node_modules directory where the Node runtime will be able to find them.

通常、 Node.js で書かれたプロジェクトをダウンロードして最初にするのは、 npm パッケージのインストールです。これにより、アプリケーションのすべての依存関係が ``node_modules`` ディレクトリにインストールされ、 Node ランタイムがそれらを見つけられるようになります。

.. Before we can run npm install, we need to get our package.json and package-lock.json files into our images. We use the COPY command to do this. The COPY command takes two parameters: src and dest. The first parameter src tells Docker what file(s) you would like to copy into the image. The second parameter dest tells Docker where you want that file(s) to be copied to. For example:

``npm install`` を実行する前に、 ``package.json`` と ``package-lock.json`` ファイルをイメージの中に入れる必要があります。そのためには ``COPY`` 命令が使えます。 ``COPY`` 命令は2つのパラメータ、 ``src`` と ``dest`` を使います。1つめのパラメータ ``src`` は、 Docker に対して何のファイル（群）をイメージにコピーするかを伝えます。2つめのパラメータ ``dest`` は、 Docker に対してファイル（群）をどこにコピーしたいか伝えます。以下は例です。

.. code-block:: dockerfile

    COPY ["<src>", "<dest>"]

.. You can specify multiple src resources seperated by a comma. For example, COPY ["<src1>", "<src2>",..., "<dest>"]. We’ll copy the package.json and the package-lock.json file into our working directory /app.

複数の ``src`` リソースをカンマで区切りで指定でいます。たとえば、 ``COPY ["<src1>", "<src2>",..., "<dest>"]`` です。ここでは ``package.json`` と ``package-lock.json`` ファイルを、作業ディレクトリ ``/app`` にコピーします。

.. code-block:: dockerfile

   COPY ["package.json", "package-lock.json*", "./"]

.. Note that, rather than copying the entire working directory, we are only copying the package.json file. This allows us to take advantage of cached Docker layers. Once we have our files inside the image, we can use the RUN command to execute the command npm install. This works exactly the same as if we were running npm install locally on our machine, but this time these Node modules will be installed into the node_modules directory inside our image.

注意として、作業ディレクトリ全体をコピーするのではなく、 package.json ファイルのみコピーします。これにより、 Docker レイヤのキャッシュを活用できます。イメージ内にファイルが入ってしまえば、 ``RUN`` 命令を使って npm install コマンドを実行できるようになります。これは、自分のマシン上でローカルに npm install を実行するのと全く同じ挙動です。ですが、今回は各 Node モジュールはイメージ内の ``node_modules`` ディレクトリ内へインストールされます。

.. code-block:: dockerfile

   RUN npm install --production

.. At this point, we have an image that is based on node version 12.18.1 and we have installed our dependencies. The next thing we need to do is to add our source code into the image. We’ll use the COPY command just like we did with our package.json files above.

この時点で、私たちのイメージは node バージョン 12.18.1 をベースにし、必要となる依存関係をインストールしました。次に必要なのは、ソースコードをイメージの中に追加します。先ほど ``package.json`` ファイルで行ったように、 ``COPY`` コマンドを使います。

.. code-block:: dockerfile

   COPY . .

.. The COPY command takes all the files located in the current directory and copies them into the image. Now, all we have to do is to tell Docker what command we want to run when our image is run inside of a container. We do this with the CMD command.

この COPY コマンドは、現在のディレクトリ内にある全てのファイルを取得し、すべてをイメージの中にコピーします。次は、イメージの実行時、コンテナ内で実行したいコマンドが何かを Docker に伝える必要があります。これを ``CMD`` 命令で行います。

.. code-block:: dockerfile

   CMD [ "node", "server.js" ]

.. Here’s the complete Dockerfile.

これが完成した Dockerfile です。

.. code-block:: dockerfile

   # syntax=docker/dockerfile:1
   
   FROM node:12.18.1
   ENV NODE_ENV=production
   
   WORKDIR /app
   
   COPY ["package.json", "package-lock.json*", "./"]
   
   RUN npm install --production
   
   COPY . .
   
   CMD [ "node", "server.js" ]

.. Create a .dockerignore file
.. _nodejs-create-a-dockerignore-file:

.dockerignore ファイルの作成
==============================

.. To use a file in the build context, the Dockerfile refers to the file specified in an instruction, for example, a COPY instruction. To increase the build’s performance, exclude files and directories by adding a .dockerignore file to the context directory. To improve the context load time create a .dockerignore file and add node_modules directory in it.

構築コンテクスト（訳者注：docker build で指定したディレクトリ内に含まれる、ファイルなどの中身のこと）内でファイルを使うために、 Dockerfile は COPY 命令のような命令で指定されたファイルを参照します。構築時のパフォーマンスを上げるには、、ファイルやディレクトリを除外するため、コンテクストがあるディクトリに .dockerignore ファイルを追加します。コンテクストの読み込み時間を減らすため、 ``.dockerignore`` ファイルを追加し、その中に ``node_module`` ディレクトリを追記します。

.. code-block:: dockerfile

   node_modules

.. Build image
.. _nodejs-build-image:

イメージ構築
====================

.. Now that we’ve created our Dockerfile, let’s build our image. To do this, we use the docker build command. The docker build command builds Docker images from a Dockerfile and a “context”. A build’s context is the set of files located in the specified PATH or URL. The Docker build process can access any of the files located in the context.

これで Dockerfile が作成できましたので、イメージを構築しましょう。そのためには ``docker build`` コマンドを使います。 ``docker build`` コマンドは Dockerfile と "コンテクスト" からイメージを構築します。構築コンテクストとは、指定したパスまたは URL 内に置かれているファイル群です。 Docker 構築プロセスは、コンテクスト内に置かれているあらゆるファイルにアクセス可能です。

.. The build command optionally takes a --tag flag. The tag is used to set the name of the image and an optional tag in the format ‘name:tag’. We’ll leave off the optional “tag” for now to help simplify things. If you do not pass a tag, Docker will use “latest” as its default tag. You’ll see this in the last line of the build output.

build コマンドは、オプションで ``--tag`` フラグを付けられます。 :ruby:`タグ <tag>` では、 ``名前:タグ`` の形式でイメージ名とオプションのタグを設定できます。今はオプションの「タグ」を省略し、シンプルにします。タグを渡さなければ、 Docker はデフォルトのタグ「latest」を使います。この様子は、構築時の最後の出力で確認できます。

.. Let’s build our first Docker image.

はじめての Docker イメージを構築しましょう。

.. code-block:: bash

   $ docker build --tag node-docker .
   
   [+] Building 93.8s (11/11) FINISHED
    => [internal] load build definition from dockerfile                                          0.1s
    => => transferring dockerfile: 617B                                                          0.0s
    => [internal] load .dockerignore                                                             0.0s
    ...
    => [2/5] WORKDIR /app                                                                        0.4s
    => [3/5] COPY [package.json, package-lock.json*, ./]                                         0.2s
    => [4/5] RUN npm install --production                                                        9.8s
    => [5/5] COPY . .

.. View local images
.. _nodejs-view-local-images:

ローカルイメージの表示
==============================

.. To see a list of images we have on our local machine, we have two options. One is to use the CLI and the other is to use Docker Desktop. Since we are currently working in the terminal let’s take a look at listing images with the CLI.

ローカルのマシン上にあるイメージを一覧表示するには、2つの方法があります。1つは CLI を使う方法と、もう1つは Docker Desktop を使う方法です。ここまでターミナル上で作業をしてきましたので、 CLI でイメージ一覧を見てみましょう。

.. To list images, simply run the images command.

イメージを一覧表示するには、シンプルに ``images`` コマンドを実行します。

.. code-block:: bash

   $ docker images
   REPOSITORY          TAG                 IMAGE ID            CREATED              SIZE
   node-docker         latest              3809733582bc        About a minute ago   945MB

.. Your exact output may vary, but you should see the image we just built node-docker:latest with the latest tag.

実際の出力は様々ですが、イメージの一覧には先ほど構築した ``node-docker:latest`` と、 ``latest`` タグのあるイメージが確認できるでしょう。

.. Tag images
.. _nodejs-tag-images:

イメージにタグ付け
====================

.. An image name is made up of slash-separated name components. Name components may contain lowercase letters, digits and separators. A separator is defined as a period, one or two underscores, or one or more dashes. A name component may not start or end with a separator.

イメージ名は、スラッシュ記号で区切られた名前の要素で構成されます。名前の要素には、小文字の文字列、数字、 :ruby:`セパレータ <separator>` （区切り文字）を含みます。セパレータとして定義されているのは、ピリオド、1つまたは2つのアンダースコア、1つまたは2つのダッシュです。名前の要素では、初めと終わりにセパレータを使えません。

.. An image is made up of a manifest and a list of layers. In simple terms, a “tag” points to a combination of these artifacts. You can have multiple tags for an image. Let’s create a second tag for the image we built and take a look at its layers.

イメージは :ruby:`マニフェスト <manifest>` と一連のレイヤによって構成されます。簡単に言うと、「タグ」が示すのは、これら :ruby:`アーティファクト <artifact>` （訳者注：完成したイメージのこと。成果物）の組み合わせを示します。イメージは複数のタグを持てます。構築済みのイメージに2つめのタグを作成し、レイヤをみてみましょう。

.. To create a new tag for the image we built above, run the following command.

先ほど構築したイメージに新しいタグを作成するには、以下のコマンドを実行します。

.. code-block:: bash

   $ docker tag node-docker:latest node-docker:v1.0.0

.. The Docker tag command creates a new tag for an image. It does not create a new image. The tag points to the same image and is just another way to reference the image.

``docker tag`` コマンドはイメージに新しいタグを作成しますが、新しいイメージは作成しません。タグが示すのは同じイメージであり、そのイメージを別の方法で参照しているだけです。

.. Now run the docker images command to see a list of our local images.

次は ``docker images`` コマンド実行し、ローカルにあるイメージの一覧を表示します。

.. code-block:: bash

   $ docker images
   REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
   node-docker         latest              3809733582bc        24 minutes ago      945MB
   node-docker         v1.0.0              3809733582bc        24 minutes ago      945MB

.. You can see that we have two images that start with node-docker. We know they are the same image because if you look at the IMAGE ID column, you can see that the values are the same for the two images.

``node-docker`` から始まる2つのイメージが表示されています。 IMAGE ID 列を見ると、2つのイメージの値は同じに見えますので、どちらも同じイメージだと分かります。

.. Let’s remove the tag that we just created. To do this, we’ll use the rmi command. The rmi command stands for “remove image”.

先ほど作成したタグを消しましょう。そのためには、 rmi コマンドを使います。rmi コマンドは「 :ruby:`イメージ削除 <remove image>` を表します。」 

.. code-block:: bash

   $ docker rmi node-docker:v1.0.0
   Untagged: node-docker:v1.0.0

.. Notice that the response from Docker tells us that the image has not been removed but only “untagged”. Verify this by running the images command.

Docker の応答から分かるのは、イメージは削除しておらず、単に「 :ruby:`タグを削除済み <untagged>` 」です。 images コマンドを実行して、これを確認しましょう。

.. code-block:: bash

   $ docker images
   REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
   node-docker         latest              3809733582bc        32 minutes ago      945MB

.. Our image that was tagged with :v1.0.0 has been removed but we still have the node-docker:latest tag available on our machine.

私たちのイメージは、タグ ``:v1.0.0`` が削除されたものの、まだ ``node-docker:latest`` タグはマシン上で利用可能です。

.. Next steps
.. _nodejs-next-steps:

次のステップ
====================

.. In this module, we took a look at setting up our example Node application that we will use for the rest of the tutorial. We also created a Dockerfile that we used to build our Docker image. Then, we took a look at tagging our images and removing images. In the next module, we’ll take a look at how to:

この章では、以降のチュートリアルで使うサンプル Node アプリケーションの設定方法を説明しました。また、Docker イメージ構築に使う Dockerfile を作成しました。それから、イメージにタグをつけ、イメージからタグを削除する方法を説明しました。次の章では、コンテナとしてイメージを実行する方法を説明します。

.. Run your image as a container

* :doc:`コンテナとしてイメージを実行 <run-containers>`

.. Feedback
.. _nodejs-feedback:

フィードバック
====================

.. Help us improve this topic by providing your feedback. Let us know what you think by creating an issue in the Docker Docs GitHub repository. Alternatively, create a PR to suggest updates.

フィードバックを通し、このトピックの改善を支援ください。考えがあれば、 `Docker Docs <https://github.com/docker/docker.github.io/issues/new?title=[Node.js%20docs%20feedback]>`_ GitHub リポジトリに issue を作成して教えてください。あるいは、更新の提案のために `RP を作成 <https://github.com/docker/docker.github.io/pulls>`_ してください。

.. seealso::

   Build your Node image
      https://docs.docker.com/language/nodejs/build-images/


