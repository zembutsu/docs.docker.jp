.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/build/intro/
   doc version: 24.0
      https://github.com/docker/docs/blob/main/build/guide/intro.md
.. check date: 2023/07/25
.. Commits on Apr 25, 2023 da6586c498f34c0edac3171a48468a0f26aa0182
.. -----------------------------------------------------------------------------

.. Build with Docker
.. _build with Docker:

========================================
Docker で構築
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 2
       :local:　

.. The starting resources for this guide includes a simple Go project and a Dockerfile. From this starting point, the guide illustrates various ways that you can improve how you build the application with Docker.

このガイドでは、シンプルな Go 言語のプロジェクトと Dockerfile を含むリソースから始めます。このガイドの開始時点から、Docker でアプリケーションを構築する方法を改善するための、様々な方法を紹介します。

.. Environment setup
.. _build-environment-setup:

環境のセットアップ
====================

.. To follow this guide:

以下のガイドを終えてください。

..  Install Docker Desktop or Docker Engine
    Clone or create a new repository from the application example on GitHub

1. :doc:`Docker Desktop か Docker Engine </get-docker>` をインストールします。
2. `GitHub 上からサンプルアプリケーションを <https://github.com/dockersamples/buildme>`_ クローン（複製）するか、新しいリポジトリを作成します。

.. The application
.. _build-the-application:

アプリケーション
====================

.. The example project for this guide is a client-server application for translating messages to a fictional language.

このガイドのサンプルプロジェクトは、架空の言語に対して翻訳したメッセージを送信するための、クライアント・サーバ型アプリケーションです。

.. Here’s an overview of the files included in the project:

こちらはプロジェクト内に含まれるファイルの一覧です。

.. code-block:: bash

   .
   ├── Dockerfile
   ├── cmd
   │   ├── client
   │   │   ├── main.go
   │   │   ├── request.go
   │   │   └── ui.go
   │   └── server
   │       ├── main.go
   │       └── translate.go
   ├── go.mod
   └── go.sum


.. The cmd/ directory contains the code for the two application components: client and server. The client is a user interface for writing, sending, and receiving messages. The server receives messages from clients, translates them, and sends them back to the client.

``cmd/`` ディレクトリに含まれるコードは、クライアントとサーバの2つのアプリケーション要素です。クライアントは、メッセージの書き込み、送信、受信のためのユーザインターフェイスです。サーバはクライアントからのメッセージを受け取り、それらを翻訳し、クライアントに送り返します。

.. The Dockerfile
.. _build-the-dockerfile:

Dockerifle
==========

.. A Dockerfile is a text document in which you define the build steps for your application. You write the Dockerfile in a domain-specific language, called the Dockerfile syntax.

Dockerfile はテキスト形式のドキュメントであり、この中にアプリケーションの構築手順を定義します。 Dockerfile には Dockerfile :ruby:`構文 <syntax>` と呼ばれる :ruby:`ドメイン固有言語 <domain-specific language>` を書きます。

.. Here’s the Dockerfile used as the starting point for this guide:

以下は、このガイドで使う現時点の Dockerfile です。

.. code-block:: dockerfile

   # syntax=docker/dockerfile:1
   FROM golang:1.20-alpine
   WORKDIR /src
   COPY . .
   RUN go mod download
   RUN go build -o /bin/client ./cmd/client
   RUN go build -o /bin/server ./cmd/server
   ENTRYPOINT [ "/bin/server" ]

.. Here’s what this Dockerfile does:

以下は、この Dockerfile が何かの説明です。

..    This comment is a Dockerfile parser directive. It specifies which version of the Dockerfile syntax to use. This file uses the dockerfile:1 syntax which is best practice: it ensures that you have access to the latest Docker build features.

1. ``# syntax=docker/dockerfile:1``

   このコメント文は :ref:`Dockerfile パーサ ディレクティブ <parser-directives>` です。これで使用する Dockerfile 構文のバージョンを指定します。このファイルはベストプラクティスである ``dockerfile:1`` 構文を使います。つまり、最新の Docker 構築機能を必ず利用するようにします。

..    The FROM instruction uses version 1.20-alpine of the golang official image.

2. ``FROM golang:1.20-alpine``

   ``FROM`` 命令は、 ``golang`` 公式イメージのバージョン ``1.20-alpine`` を使います。

..    Creates the /src working directory inside the container.

3. ``WORKDIR /src``

   コンテナ内に :ruby:`作業ディレクトリ <working directory>` ``/src`` を作成します。

..    Copies the files in the build context to the working directory in the container.

4. ``COPY . .``

   :ruby:`構築コンテキスト <build context>` 内のファイルを、コンテナ内の作業ディレクトリにコピーします。

..     Downloads the necessary Go modules to the container. Go modules is the dependency management tool for the Go programming language, similar to npm install for JavaScript, or pip install for Python.

5. ``RUN go mod download``

   必要な Go モジュールをコンテナにダウンロードします。Go モジュールとは Go プログラミング言語用の依存関係管理ツールであり、 JavaScript 用の ``npm install`` や Python 用の ``pip install`` と似ています。

..    Builds the client binary, used to send messages to be translated, into the /bin directory.

6. ``RUN go build -o /bin/client ./cmd/client``

   ``/bin`` ディレクトリ内に ``client`` バイナリを構築し、これを翻訳されたメッセージの送信用に使います。

..    Builds the server binary, which listens for client translation requests, into the /bin directory.

7. ``RUN go build -o /bin/server ./cmd/server``

   ``/bin`` ディレクトリ内に ``server`` バイナリを構築し、これをクライアントが翻訳したリクエストの受信に使います。

..    Specifies a command to run when the container starts. Starts the server process.

8. ``ENTRYPOINT [ "/bin/server" ]``

   コンテナを起動時に実行するコマンドを指定します。サーバのプロセスを起動します。

.. Build the image
.. _build-build-the-image:

イメージの構築
====================

.. To build an image using a Dockerfile, you use the docker command-line tool. The command for building an image is docker build.

Dockerfile を使ってイメージを構築するには、 ``docker`` コマンドラインツールを使います。イメージを構築するコマンドは ``docker build`` です。

.. Run the following command to build the image.

イメージを構築するには以下のコマンドを実行します。

.. code-block:: bash

   $ docker build --tag=buildme .

.. This creates an image with the tag buildme. An image tag is the name of the image.

この作成されたイメージには :ruby:`タグ <tag>` ``buildme`` があります。イメージのタグがイメージ名にあたります。


.. Run the container
.. _build-run-the-container:

コンテナの実行
====================

.. The image you just built contains two binaries, one for the server and one for the client. To see the translation service in action, run a container that hosts the server component, and then run another container that invokes the client.

今構築したイメージには2つのバイナリが入っています。1つはサーバで、もう1つはクライアントです。翻訳サービスが動作するの確認するには、サーバ部分をホスト（保持）するコンテナの起動と、次にクライアントを呼び出す別のコンテナを起動します。

.. To run a container, you use the docker run command.

コンテナを実行するには ``docker run`` コマンドを使います。

..    Run a container from the image in detached mode.

1. コンテナをイメージから :ruby:`デタッチドモード <detached mode>` で起動します。

   .. code-block:: bash
   
      $ docker run --name=buildme --rm --detach buildme

   .. This starts a container named buildme.

   これは ``buildme`` という名前のコンテナを起動します。

.. Run a new command in the buildme container that invokes the client binary.

2. この ``buildme`` コンテナ内で、クライアントバイナリを呼び出すための新しいコマンドを実行します。

   .. code-block:: bash

      $ docker exec -it buildme /bin/client

.. The docker exec command opens a terminal user interface where you can submit messages for the backend (server) process to translate.

翻訳用のバックエンド（サーバ）プロセスにメッセージを送信できる場所として、ターミナルのユーザインターフェイスを ``docker exec`` コマンドで開きます。

.. When you’re done testing, you can stop the container:

.. code-block:: bash

   $ docker stop buildme

.. Summary

まとめ
==========

.. This section gave you an overview of the example application used in this guide, an introduction to Dockerfiles and building. You’ve successfully built a container image and created a container from it.

このセクションでは、本ガイドで使うサンプルアプリケーションの概要、Dockerfile と構築の導入を示しました。コンテナイメージを構築し、そのイメージからコンテナを作成するのに成功しました。

.. Related information:

関連情報：

..  Dockerfile reference
    docker build CLI reference
    docker run CLI reference

* :doc:`Dockerfile リファレンス </engine/reference/builder>`
* :doc:`docker build コマンドリファレンス </engine/reference/commandline/build>`
* :doc:`docker run コマンドリファレンス </engine/reference/commandline/run>`

次のステップ
====================

.. The next section explores how you can use layer cache to improve build speed.

次のセクションでは、構築速度を改善するために、レイヤのキャッシュをどのようにして使うかを探ります。

.. raw:: html

   <div style="overflow: hidden; margin-bottom:20px;">
      <a href="layers.html" class="btn btn-neutral float-left">レイヤ <span class="fa fa-arrow-circle-right"></span></a>
   </div>


----

.. seealso::

   Introduction
      https://docs.docker.com/build/guide/intro/


