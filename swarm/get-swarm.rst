.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/swarm/get-swarm/
.. SOURCE: https://github.com/docker/swarm/blob/master/docs/get-swarm.md
   doc version: 1.11
      https://github.com/docker/swarm/commits/master/docs/get-swarm.md
.. check date: 2016/04/29
.. Commits on Mar 13, 2016 e7ce927e9da7243adba1bc1618fea3db81659710
.. -------------------------------------------------------------------

.. How to get Docker Swarm

.. _how-to-get-docker-swarm:

==============================
Docker Swarm の入手方法
==============================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. You can create a Docker Swarm cluster using the swarm executable image from a container or using an executable swarm binary you install on your system. This page introduces the two methods and discusses their pros and cons.

Docker Swarm クラスタを作成する方法は、 ``swarm`` が実行可能なイメージをコンテナとして使うか、あるいは、実行可能な ``swarm`` バイナリをシステム上にインストールします。このページは２つの方法を紹介し、それぞれの賛否を議論します。

.. Create a cluster with an interactive container

.. _create-a-cluster-with-an-interactive-container:

インタラクティブなコンテナでクラスタを作成
==================================================

.. You can use the Docker Swarm official image to create a cluster. The image is built by Docker and updated regularly through an automated build. To use the image, you run it a container via the Engine docker run command. The image has multiple options and subcommands you can use to create and manage a Swarm cluster.

クラスタの作成には、Docker Swarm 公式イメージを使えます。イメージは Docker 社が構築したものであり、適切な自動構築を通して定期的に更新しています。イメージを使うには、Docker Engine の ``docker run`` コマンドを通してコンテナを実行します。Swarm クラスタを作成・管理するため、イメージには複数のオプションとサブコマンドがあります。

.. The first time you use any image, Docker Engine checks to see if you already have the image in your environment. By default Docker runs the swarm:latest version but you can also specify a tag other than latest. If you have an image locally but a newer one exists on Docker Hub, Engine downloads it.

イメージを初めて使う時、Docker Engine はイメージが自分の環境に既に存在しているかどうか確認します。Docker はデフォルトで ``swarm:latest`` バージョンを実行しますが、 ``latest`` 以外のタグも指定できます。イメージがローカルにダウンロード済みでも、Docker Hub 上に新しいバージョンが存在していれば、 Docker Engine は新しいイメージをダウンロードします。

.. Run the Swarm image from a container

.. _run-the-swarm-image-from-a-container:

コンテナで Swarm イメージを実行
----------------------------------------

.. Open a terminal on a host running Engine.

1. Docker Engine を実行しているホスト上のターミナルを開きます。

.. If you are using Mac or Windows, then you must make sure you have started an Docker Engine host running and pointed your terminal environment to it with the Docker Machine commands. If you aren’t sure, you can verify:

Mac か Windows を使っている場合は、Docker Machine コマンドで Docker Engine ホストを起動し、ターミナルの環境を対象ホストに向ける必要があります。動作確認は次のようにします。

.. code-block:: bash

   $ docker-machine ls
   NAME      ACTIVE   URL          STATE     URL                         SWARM   DOCKER    ERRORS
   default   *       virtualbox   Running   tcp://192.168.99.100:2376           v1.9.1    

.. This shows an environment running an Engine host on the default instance.

これは Docker Engine ホスト上で動いている ``default`` インスタンス環境を指し示しています。

.. Use the swarm image to execute a command.

2. ``swarm`` イメージを使ってコマンドを実行します。

.. The easiest command is to get the help for the image. This command shows all the options that are available with the image.

最も簡単なコマンドはイメージのヘルプ表示です。次のコマンドはイメージで利用可能なオプションの全てを表示します。

.. code-block:: bash

   $ docker run swarm --help
   Unable to find image 'swarm:latest' locally
   latest: Pulling from library/swarm
   d681c900c6e3: Pull complete
   188de6f24f3f: Pull complete
   90b2ffb8d338: Pull complete
   237af4efea94: Pull complete
   3b3fc6f62107: Pull complete
   7e6c9135b308: Pull complete
   986340ab62f0: Pull complete
   a9975e2cc0a3: Pull complete
   Digest: sha256:c21fd414b0488637b1f05f13a59b032a3f9da5d818d31da1a4ca98a84c0c781b
   Status: Downloaded newer image for swarm:latest
   Usage: swarm [OPTIONS] COMMAND [arg...]
   
   A Docker-native clustering system
   
   Version: 1.0.1 (744e3a3)
   
   Options:
     --debug           debug mode [$DEBUG]
     --log-level, -l "info"    Log level (options: debug, info, warn, error, fatal, panic)
     --help, -h            show help
     --version, -v         print the version
   
   Commands:
     create, c Create a cluster
     list, l   List nodes in a cluster
     manage, m Manage a docker cluster
     join, j   join a docker cluster
     help, h   Shows a list of commands or help for one command
   
   Run 'swarm COMMAND --help' for more information on a command.

.. In this example, the swarm image did not exist on the Engine host, so the Engine downloaded it. After it downloaded, the image executed the help subcommand to display the help text. After displaying the help, the swarm image exits and returns you to your terminal command line.

この例では ``swarm`` イメージが Engine ホスト上に存在していないため、Engine はイメージをダウンロードします。ダウンロード後、イメージは ``help`` サブコマンドを実行し、ヘルプ・テキストを表示します。ヘルプを表示した後、 ``swarm`` イメージが終了し、ターミナル上のコマンドラインに戻ります。

.. List the running containers on your Engine host.

3. Engine ホスト上で実行しているコンテナ一覧を表示します。

.. code-block:: bash

   $ docker ps
   CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES

.. Swarm is no longer running. The swarm image exits after you issue it a command.

Swarm は動作していません。 ``swarm`` イメージはコマンドを実行して終了したからです。

.. Why use the image?

なぜイメージを使うのですか？
------------------------------

.. Using a Swarm container has three key benefits over other methods:

Swarm コンテナを使う方法は、他の手法と比べて３つの重要な利点があります。

..    You don’t need to install a binary on the system to use the image.
    The single command docker run command gets and run the most recent version of the image every time.
    The container isolates Swarm from your host environment. You don’t need to perform or maintain shell paths and environments.

* イメージを使えば、システム上にバイナリのインストールが不要。
* ``docker run`` コマンドを実行するだけで、常に最新バージョンのイメージを毎回取得。
* コンテナはホスト環境と Swarm を分離する。シェル上のパスや環境変数の指定・調整が不要。

.. Running the Swarm image is the recommended way to create and manage your Swarm cluster. All of Docker’s documentation and tutorials use this method.

Swarm イメージの実行は Swarm クラスタの作成・管理のために推奨されている方法です。こちらが Docker の全ドキュメントおよびチュートリアルで使われている方法がこちらです。

.. Run a Swarm binary

Swarm バイナリの実行
====================

.. Before you run a Swarm binary directly on a host operating system (OS), you compile the binary from the source code or get a trusted copy from another location. Then you run the Swarm binary.

ホストのオペレーティング・システム（OS）上で直接 Swarm バイナリを実行する前に、ソースコードからバイナリをコンパイルするか、信頼できる別の場所からコピーする必要があります。その作業の後、 Swarm のバイナリを実行します。

.. To compile Swarm from source code, refer to the instructions in CONTRIBUTING.md.

ソースコードから Swarm をコンパイルするには、 `CONTRIBUTING.md <http://github.com/docker/swarm/blob/master/CONTRIBUTING.md>`_ の手順をご覧ください。

.. Why use the binary?

なぜバイナリを使うのですか？
------------------------------

.. Using a Swarm binary this way has one key benefit over other methods: If you are a developer who contributes to the Swarm project, you can test your code changes without “containerizing” the binary before you run it.

他の方法に比べ、Swarm バイナリには利点が１つあります。もしあなたが swarm プロジェクトに貢献している開発者であれば、「コンテナ化」したバイナリを実行しなくても、コードに対する変更をテスト可能です。

.. Running a Swarm binary on the host OS has disadvantages:

ホスト OS 上で Swarm バイナリを実行する場合は、不利な点が３つあります。

..    Compilation from source is a burden.
    The binary doesn’t have the benefits that Docker containers provide, such as isolation.
    Most Docker documentation and tutorials don’t show this method of running swarm.

* ソースからコンパイルする手間。
* Docker コンテナによってもたらされる隔離などの利点は、バイナリには無い。
* 大部分の Docker ドキュメントやチュートリアルは、バイナリで実行する方法では説明していない。

.. Lastly, because the Swarm nodes don’t use Engine, you can’t use Docker-based software tools, such as Docker Engine CLI at the node level.

加えて、Swarm ノードは Engine を使いませんで、ノード上では Docker Engine CLI のような Docker ベースのソフトウェア・ツールで扱えません。

.. Related information

関連情報
==========

..    Docker Swarm official image repository on Docker Hub
    Provision a Swarm with Docker Machine

* Docker Hub 上の `Docker Swarm 公式イメージ <https://hub.docker.com/_/swarm/>`_ リポジトリ
* :doc:`provision-with-machine`

.. seealso:: 

   How to get Docker Swarm
      https://docs.docker.com/swarm/get-swarm/
