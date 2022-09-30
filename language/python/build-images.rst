.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/language/python/build-images/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/language/python/build-images.md
.. check date: 2022/09/30
.. Commits on Sep 29, 2022 561118ec5b1f1497efad536545c0b39aa8026575
.. -----------------------------------------------------------------------------

.. Build your Python image
.. _build-your-python-image:

========================================
自分の Python イメージを構築
========================================

.. Prerequisites
.. _python-prerequisites:

事前準備
==========

.. Work through the orientation and setup in Get started Part 1 to understand Docker concepts.

Docker の概念を理解するため、導入ガイド :doc:`Part 1 </get-started/index>` での説明を読み、準備をしてください。

.. Enable BuildKit
.. _python-enable-buildkit:

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
.. _python-build-images-overview:

概要
==========

.. Now that we have a good overview of containers and the Docker platform, let’s take a look at building our first image. An image includes everything you need to run an application - the code or binary, runtime, dependencies, and any other file system objects required.

これでコンテナと Docker プラットフォームの概要が分かりましたので、初めてのイメージを構築しましょう。イメージにはアプリケーションの実行に必要な全てを含みます。具体的には、コードやバイナリ、ランタイム、依存関係、必要なその他のファイルシステムです。

.. To complete this tutorial, you need the following:

このチュートリアルを終えるには、以下が必要です。

..  Python version 3.8 or later. Download Python
    Docker running locally: Follow the instructions to download and install Docker.
    An IDE or a text editor to edit files. We recommend using Visual Studio Code.

* Python バージョン 3.8 以上。 `Python のダウンロード <https://www.python.org/downloads/>`_ 
* Docker をローカルで実行： :doc:`Docker のダウンロードとインストール </desktop/index>` の手順に従う
* ファイルを編集するため、 IDE やテキストエディタ： Visual Studio Code の使用を推奨

.. Sample application
.. _python-sample-application:

サンプル アプリケーション
==============================

.. Let’s create a simple Python application using the Flask framework that we’ll use as our example. Create a directory in your local machine named python-docker and follow the steps below to create a simple web server.

例として使える Flask フレームワークを使い、簡単な Python アプリケーションを作りましょう。ローカルマシン内に ``python-docker`` という名前のディレクトリを作成し、簡単なウェブサーバを作成します。

.. code-block:: yaml

   $ cd /path/to/python-docker
   $ pip3 install Flask
   $ pip3 freeze | grep Flask >> requirements.txt
   $ touch app.py

.. Now, let’s add some code to handle simple web requests. Open this working directory in your favorite IDE and enter the following code into the app.py file.

次は、シンプルなウェブリクエストを扱うためのコードをいくつか追加します。この作業ディレクトリを好きな IDE で開き、以下のコードを ``app.py`` ファイルに追加します。

.. code-block:: js

   from flask import Flask
   app = Flask(__name__)
   
   @app.route('/')
   def hello_world():
       return 'Hello, Docker!'

.. Test the application
.. _python-test-the-application:

アプリケーションのテスト
==============================

.. Let’s start our application and make sure it’s running properly. Open your terminal and navigate to the working directory you created.

アプリケーションを起動し、正しく動作するか確認しましょう。ターミナルを開き、作成済みの作業ディレクトリに移動します。

.. code-block:: yaml

   $ python3 -m flask run

.. To test that the application is working properly, open a new browser and navigate to http://localhost:5000.

アプリケーションが正しく動作しているか確認するには、新しいブラウザを開き、 ``http://localhost:5000`` に移動します。

.. Switch back to the terminal where our server is running and you should see the following requests in the server logs. The data and timestamp will be different on your machine.

サーバを実行しているターミナルに切り戻すと、サーバログには以下のリクエストが表示されます。日付とタイムスタンプは、みなさんのマシン上のものとは異なります。

.. code-block:: bash

   127.0.0.1 - - [22/Sep/2020 11:07:41] "GET / HTTP/1.1" 200 -

.. Create a Dockerfile for Python
.. _create-a-dockerfile-for-python:

Python 用の Dockerfile を作成
==============================

.. Now that our application is running properly, let’s take a look at creating a Dockerfile.

これでアプリケーションが正しく動作しましたので、 Dockerfile の作成を見ていきましょう。

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
   
   FROM python:3.8-slim-buster

.. Docker images can be inherited from other images. Therefore, instead of creating our own base image, we’ll use the official Python image that already has all the tools and packages that we need to run a Python application.

Docker イメージは他のイメージを :ruby:`継承 <inherit>` できます。そのため、自分でベースイメージを作成するのではなく、公式の Python イメージを使います。イメージには Python アプリケーションの実行に必要なツールとパッケージが全て入っています。

..  Note
    If you want to learn more about creating your own base images, see Creating base images.

.. note::

   自分でベースイメージを作成する方法についての情報は :doc:`/develop/develop-images/baseimages` をご覧ください。

.. To make things easier when running the rest of our commands, let’s create a working directory. This instructs Docker to use this path as the default location for all subsequent commands. By doing this, we do not have to type out full file paths but can use relative paths based on the working directory.

以降のコマンドを実行しやすくるため、作業ディレクトリを作成しましょう。この命令は、以降すべてのコマンドを実行するデフォルトの場所として、指定したパスを使うよう Docker に対して伝えます。この方法によりフルパスを入力する必要がなくなりますが、その作業ディレクトリを基準とした相対パスで記述する必要があります。

.. code-block:: dockerfile

   WORKDIR /app

.. Usually, the very first thing you do once you’ve downloaded a project written in Python is to install pip packages. This ensures that your application has all its dependencies installed.

通常、 Node.js で書かれたプロジェクトをダウンロードして最初にするのは、 ``pip`` パッケージのインストールです。これにより、アプリケーションが必要とするすべての依存関係がインストールされます。

.. Before we can run pip3 install, we need to get our requirements.txt file into our image. We’ll use the COPY command to do this. The COPY command takes two parameters. The first parameter tells Docker what file(s) you would like to copy into the image. The second parameter tells Docker where you want that file(s) to be copied to. We’ll copy the requirements.txt file into our working directory /app.

``pip3 install`` を実行する前に、 ``requirements.txt`` ファイルをイメージの中に入れる必要があります。そのためには ``COPY`` 命令が使えます。 ``COPY`` 命令は2つのパラメータ、 ``src`` と ``dest`` を使います。1つめのパラメータ ``src`` は、 Docker に対して何のファイル（群）をイメージにコピーするかを伝えます。2つめのパラメータ ``dest`` は、 Docker に対してファイル（群）をどこにコピーしたいか伝えます。作業ディレクトリ内へ ``requirements.txt`` をコピーします。

.. code-block:: dockerfile

    COPY requirements.txt requirements.txt

.. Once we have our requirements.txt file inside the image, we can use the RUN command to execute the command pip3 install. This works exactly the same as if we were running pip3 install locally on our machine, but this time the modules are installed into the image.

既に ``requirements.txt`` ファイルはイメージ内ですので、 ``RUN`` 命令を使って ``pip3 install`` を実行できるようになります。これは、自分のマシン上でローカルに ``pip3 install`` を実行するのと全く同じ挙動です。ですが、今回は各モジュールはイメージ内へインストールされます。

.. code-block:: dockerfile

   RUN pip3 install -r requirements.txt

.. At this point, we have an image that is based on Python version 3.8 and we have installed our dependencies. The next step is to add our source code into the image. We’ll use the COPY command just like we did with our requirements.txt file above.

この時点で、私たちのイメージは Python バージョン 3.8 をベースにし、必要となる依存関係をインストールしました。次に必要なのは、ソースコードをイメージの中に追加します。先ほど ``package.json`` ファイルで行ったように、 ``COPY`` コマンドを使います。

.. code-block:: dockerfile

   COPY . .

.. This COPY command takes all the files located in the current directory and copies them into the image. Now, all we have to do is to tell Docker what command we want to run when our image is executed inside a container. We do this using the CMD command. Note that we need to make the application externally visible (i.e. from outside the container) by specifying --host=0.0.0.0.

この COPY コマンドは、現在のディレクトリ内にある全てのファイルを取得し、すべてをイメージの中にコピーします。次は、イメージの実行時、コンテナ内で実行したいコマンドが何かを Docker に伝える必要があります。これを ``CMD`` 命令で行います。注意点として、アプリケーションを外部から（例：コンテナの外から）見えるようにするため、 ``--host=0.0.0.0`` を指定します。

.. code-block:: dockerfile

   CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]

.. Here’s the complete Dockerfile.

これが完成した Dockerfile です。

.. code-block:: dockerfile

   # syntax=docker/dockerfile:1
   
   FROM python:3.8-slim-buster
   
   WORKDIR /app
   
   COPY requirements.txt requirements.txt
   RUN pip3 install -r requirements.txt
   
   COPY . .
   
   CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]

.. Directory structure
.. _python-build-directory-structure:

ディレクトリ構成
--------------------

.. Just to recap, we created a directory in our local machine called python-docker and created a simple Python application using the Flask framework. We also used the requirements.txt file to gather our requirements, and created a Dockerfile containing the commands to build an image. The Python application directory structure would now look like:

ここまでを振り返ると、ローカルマシン上に ``python-docker`` ディレクトリを作成、Flask フレームワークを使うシンプルな Python アプリケーションを作成しました。また、依存関係を集めるために ``requirements.txt`` を使用し、イメージを構築するための命令を含む Dockerfile を作成しました。Python アプリケーションのディレクトリ構成は、次のようになります。

.. code-block:: bash

   python-docker
   |____ app.py
   |____ requirements.txt
   |____ Dockerfile


.. Build image
.. _python-build-image:

イメージ構築
====================

.. Now that we’ve created our Dockerfile, let’s build our image. To do this, we use the docker build command. The docker build command builds Docker images from a Dockerfile and a “context”. A build’s context is the set of files located in the specified PATH or URL. The Docker build process can access any of the files located in the context.

これで Dockerfile が作成できましたので、イメージを構築しましょう。そのためには ``docker build`` コマンドを使います。 ``docker build`` コマンドは Dockerfile と "コンテクスト" からイメージを構築します。構築コンテクストとは、指定したパスまたは URL 内に置かれているファイル群です。 Docker 構築プロセスは、コンテクスト内に置かれているあらゆるファイルにアクセス可能です。

.. The build command optionally takes a --tag flag. The tag is used to set the name of the image and an optional tag in the format ‘name:tag’. We’ll leave off the optional “tag” for now to help simplify things. If you do not pass a tag, Docker will use “latest” as its default tag. You’ll see this in the last line of the build output.

build コマンドは、オプションで ``--tag`` フラグを付けられます。 :ruby:`タグ <tag>` では、 ``名前:タグ`` の形式でイメージ名とオプションのタグを設定できます。今はオプションの「タグ」を省略し、シンプルにします。タグを渡さなければ、 Docker はデフォルトのタグ「latest」を使います。この様子は、構築時の最後の出力で確認できます。

.. Let’s build our first Docker image.

はじめての Docker イメージを構築しましょう。

.. code-block:: bash

   $ docker build --tag python-docker .
   [+] Building 2.7s (10/10) FINISHED
    => [internal] load build definition from Dockerfile
    => => transferring dockerfile: 203B
    => [internal] load .dockerignore
    => => transferring context: 2B
    => [internal] load metadata for docker.io/library/python:3.8-slim-buster
    => [1/6] FROM docker.io/library/python:3.8-slim-buster
    => [internal] load build context
    => => transferring context: 953B
    => CACHED [2/6] WORKDIR /app
    => [3/6] COPY requirements.txt requirements.txt
    => [4/6] RUN pip3 install -r requirements.txt
    => [5/6] COPY . .
    => [6/6] CMD [ "python3", "-m", "flask", "run", "--host=0.0.0.0"]
    => exporting to image
    => => exporting layers
    => => writing image sha256:8cae92a8fbd6d091ce687b71b31252056944b09760438905b726625831564c4c
    => => naming to docker.io/library/python-docker

.. View local images
.. _python-view-local-images:

ローカルイメージの表示
==============================

.. To see a list of images we have on our local machine, we have two options. One is to use the CLI and the other is to use Docker Desktop. Since we are currently working in the terminal let’s take a look at listing images with the CLI.

ローカルのマシン上にあるイメージを一覧表示するには、2つの方法があります。1つは CLI を使う方法と、もう1つは :doc:`Docker Desktop </desktop/use-desktop/images>` を使う方法です。ここまでターミナル上で作業をしてきましたので、 CLI でイメージ一覧を見てみましょう。

.. To list images, simply run the images command.

イメージを一覧表示するには、シンプルに ``images`` コマンドを実行します。

.. code-block:: bash

   $ docker images
   REPOSITORY      TAG               IMAGE ID       CREATED         SIZE
   python-docker   latest            8cae92a8fbd6   3 minutes ago   123MB

.. You should see at least one image listed, the image we just built python-docker:latest.

リストには少なくとも1つの構築したイメージ ``python-docker:latest`` が見えるでしょう。


.. Tag images
.. _python-tag-images:

イメージにタグ付け
====================

.. As mentioned earlier, an image name is made up of slash-separated name components. Name components may contain lowercase letters, digits and separators. A separator is defined as a period, one or two underscores, or one or more dashes. A name component may not start or end with a separator.

イメージ名は、スラッシュ記号で区切られた名前の要素で構成されます。名前の要素には、小文字の文字列、数字、 :ruby:`セパレータ <separator>` （区切り文字）を含みます。セパレータとして定義されているのは、ピリオド、1つまたは2つのアンダースコア、1つまたは2つのダッシュです。名前の要素では、初めと終わりにセパレータを使えません。

.. An image is made up of a manifest and a list of layers. Do not worry too much about manifests and layers at this point other than a “tag” points to a combination of these artifacts. You can have multiple tags for an image. Let’s create a second tag for the image we built and take a look at its layers.

イメージは :ruby:`マニフェスト <manifest>` と一連のレイヤによって構成されます。簡単に言うと、「タグ」が示すのは、これら :ruby:`アーティファクト <artifact>` （訳者注：完成したイメージのこと。成果物）の組み合わせを示します。イメージは複数のタグを持てます。構築済みのイメージに2つめのタグを作成し、レイヤをみてみましょう。

.. To create a new tag for the image we’ve built above, run the following command.

先ほど構築したイメージに新しいタグを作成するには、以下のコマンドを実行します。

.. code-block:: bash

   $ docker tag python-docker:latest python-docker:v1.0.0

.. The docker tag command creates a new tag for an image. It does not create a new image. The tag points to the same image and is just another way to reference the image.

``docker tag`` コマンドはイメージに新しいタグを作成しますが、新しいイメージは作成しません。タグが示すのは同じイメージであり、そのイメージを別の方法で参照しているだけです。

.. Now run the docker images command to see a list of our local images.

次は ``docker images`` コマンド実行し、ローカルにあるイメージの一覧を表示します。

.. code-block:: bash

   $ docker images
   REPOSITORY      TAG               IMAGE ID       CREATED         SIZE
   python-docker   latest            8cae92a8fbd6   4 minutes ago   123MB
   python-docker   v1.0.0            8cae92a8fbd6   4 minutes ago   123MB
   python          3.8-slim-buster   be5d294735c6   9 days ago      113MB

.. You can see that we have two images that start with python-docker. We know they are the same image because if you take a look at the IMAGE ID column, you can see that the values are the same for the two images.

``python-docker`` から始まる2つのイメージが表示されています。 IMAGE ID 列を見ると、2つのイメージの値は同じに見えますので、どちらも同じイメージだと分かります。

.. Let’s remove the tag that we just created. To do this, we’ll use the rmi command. The rmi command stands for “remove image”.

先ほど作成したタグを消しましょう。そのためには、 rmi コマンドを使います。rmi コマンドは「 :ruby:`イメージ削除 <remove image>` を表します。」 

.. code-block:: bash

   $ docker rmi python-docker:v1.0.0
   Untagged: python-docker:v1.0.0

.. Note that the response from Docker tells us that the image has not been removed but only “untagged”. You can check this by running the docker images command.

Docker の応答から分かるのは、イメージは削除しておらず、単に「 :ruby:`タグを削除済み <untagged>` 」です。 ``docker images`` コマンドを実行して、これを確認しましょう。

.. code-block:: bash

   $ docker images
   REPOSITORY      TAG               IMAGE ID       CREATED         SIZE
   python-docker   latest            8cae92a8fbd6   6 minutes ago   123MB
   python          3.8-slim-buster   be5d294735c6   9 days ago      113MB

.. Our image that was tagged with :v1.0.0 has been removed, but we still have the python-docker:latest tag available on our machine.

私たちのイメージは、タグ ``:v1.0.0`` が削除されたものの、まだ ``python-docker:latest`` タグはマシン上で利用可能です。

.. Next steps
.. _python-build-next-steps:

次のステップ
====================

.. In this module, we took a look at setting up our example Python application that we will use for the rest of the tutorial. We also created a Dockerfile that we used to build our Docker image. Then, we took a look at tagging our images and removing images. In the next module we’ll take a look at how to

この章では、以降のチュートリアルで使うサンプル Python アプリケーションの設定方法を説明しました。また、Docker イメージ構築に使う Dockerfile を作成しました。それから、イメージにタグをつけ、イメージからタグを削除する方法を説明しました。次の章では、コンテナとしてイメージを実行する方法を説明します。

.. Run your image as a container

* :doc:`コンテナとしてイメージを実行 <run-containers>`

.. Feedback
.. _python-build-feedback:

フィードバック
====================

.. Help us improve this topic by providing your feedback. Let us know what you think by creating an issue in the Docker Docs GitHub repository. Alternatively, create a PR to suggest updates.

フィードバックを通し、このトピックの改善を支援ください。考えがあれば、 `Docker Docs <https://github.com/docker/docs/issues/new?title=[Python%20docs%20feedback]>`_ GitHub リポジトリに issue を作成して教えてください。あるいは、更新の提案のために `RP を作成 <https://github.com/docker/docs/pulls>`_ してください。

.. seealso::

   Build your Python image
      https://docs.docker.com/language/python/build-images/


