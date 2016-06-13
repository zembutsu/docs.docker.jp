.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/extend/examples/mongodb/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/examples/mongodb.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/examples/mongodb.md
.. check date: 2016/06/13
.. Commits on Mar 4, 2016 e310d070f498a2ac494c6d3fde0ec5d6e4479e14
.. ---------------------------------------------------------------

.. Dockerizing MongoDB

.. _dockerizing-mongodb:

========================================
MongoDB の Docker 化
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. In this example, we are going to learn how to build a Docker image with MongoDB pre-installed. We’ll also see how to push that image to the Docker Hub registry and share it with others!

この例では、MongoDB がインストール済みの Docker イメージを、どのようにして構築するかを学びます。また、イメージを `Docker Hub レジストリ <https://hub.docker.com/>`_ に ``送信`` して、他人と共有する方法も理解します。

..    Note: This guide will show the mechanics of building a MongoDB container, but you will probably want to use the official image on Docker Hub

.. note::

   このガイドでは MongoDB コンテナを構築する仕組みを紹介しますが、 `Docker Hub <https://hub.docker.com/_/mongo/>`__ の公式イメージを使っても構いません。

.. Using Docker and containers for deploying MongoDB instances will bring several benefits, such as:

Docker を使い `MongoDB <https://www.mongodb.org/>`_ インスタンスをデプロイしたら、次のメリットがあります。

..    Easy to maintain, highly configurable MongoDB instances;
    Ready to run and start working within milliseconds;
    Based on globally accessible and shareable images.

* 簡単なメンテナンス、MongoDB インスタンスの高い設定性
* ミリ秒以内で実行と開始
* どこからでも接続可能で共有できるイメージに基づく

..    Note:
..    If you do not like sudo, you might want to check out: Giving non-root access.

.. note::

   ``sudo`` が好きでなければ、 :ref:`giving-non-root-access` をご覧ください。

.. Creating a Dockerfile for MongoDB

.. _creating-a-dockerfile-for-mongodb:

MongoDB 用の Dockerfile を作成
==============================

.. Let’s create our Dockerfile and start building it:

構築用の ``Dockerfile`` を作成しましょう。

.. code-block:: bash

   $ nano Dockerfile

.. Although optional, it is handy to have comments at the beginning of a Dockerfile explaining its purpose:

オプションですが、 ``Dockerfile`` の冒頭に自身の役割などをコメントしておくと便利です。

.. code-block:: bash

   # MongoDB の Docker化：MongoDB イメージを構築する Dockerfile
   # ubuntu:latest をベースとし、MongoDB は以下の手順でインストール：
   # http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/

..    Tip: Dockerfiles are flexible. However, they need to follow a certain format. The first item to be defined is the name of an image, which becomes the parent of your Dockerized MongoDB image.

.. tip::

   ``Dockerfile`` は柔軟性がありますが、特定の書式に従う必要があります。最初に必要になるのは、これから作成する *MongoDB を Docker 化* したイメージの親にあたるイメージ名の定義です。

.. We will build our image using the latest version of Ubuntu from the Docker Hub Ubuntu repository.

`Docker Hub Ubuntu <https://hub.docker.com/_/ubuntu/>`_ リポジトリにある Ubuntu の最新（latest）バージョンを使い、イメージを構築します。

.. code-block:: bash

   # 書式：FROM    リポジトリ[:バージョン]
   FROM       ubuntu:latest

.. Continuing, we will declare the MAINTAINER of the Dockerfile:

続けて、 ``Dockerfile`` の ``MAINTAINER`` （メンテナ／担当者）を宣言します。

.. code-block:: bash

   # 書式：MAINTAINER 名前  <email@addr.ess>
   MAINTAINER M.Y. Name <myname@addr.ess>

..    Note: Although Ubuntu systems have MongoDB packages, they are likely to be outdated. Therefore in this example, we will use the official MongoDB packages.

.. note::

   Ubuntu システムにも MongoDB パッケージがありますが、作成日が古いものです。そのため、この例では公式の MongoDB パッケージを使います。

.. We will begin with importing the MongoDB public GPG key. We will also create a MongoDB repository file for the package manager.

MongoDB 公開 GPG 鍵を取り込みます。また、パッケージ・マネージャ用に MongoDB リポジトリ・ファイルも作成します。

.. code-block:: bash

   # インストール：
   # MongoDB 公開 GPG 鍵を取り込み、MongoDB リストファイルを作成
   RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
   RUN echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.0.list

.. After this initial preparation we can update our packages and install MongoDB.

この初期準備が終われば、パッケージを更新し、MongoDB をインストールできます。

.. code-block:: bash

   # apt-get ソースを更新し、MongoDB をインストール
   RUN apt-get update && apt-get install -y mongodb-org

..    Tip: You can install a specific version of MongoDB by using a list of required packages with versions, e.g.:

.. tip::

   MongoDB のバージョンを指定したインストールもできます。そのためには、次の例のようにパッケージのバージョン番号のリストが必要です。

.. code-block:: bash

   RUN apt-get update && apt-get install -y mongodb-org=3.0.1 mongodb-org-server=3.0.1 mongodb-org-shell=3.0.1 mongodb-org-mongos=3.0.1 mongodb-org-tools=3.0.1

.. MongoDB requires a data directory. Let’s create it as the final step of our installation instructions.

MongoDB はデータ・ディレクトリが必要です。インストールの最終ステップで作成を命令しましょう。

.. code-block:: bash

   # MongoDB データ・ディレクトリの作成
   RUN mkdir -p /data/db

.. Lastly we set the ENTRYPOINT which will tell Docker to run mongod inside the containers launched from our MongoDB image. And for ports, we will use the EXPOSE instruction.

最後に ``ENTRYPOINT`` を設定します。これは Docker に対して MongoDB イメージでコンテナを起動する時、コンテナ内で ``mongod`` を実行するよう命令します。そして、ポートを公開するために ``EXPOSE`` 命令を使います。

.. code-block:: bash

   # コンテナのポート 27017 をホスト側に露出（EXPOSE)
   EXPOSE 27017
   
   # usr/bin/mongod を Docker 化アプリケーションのエントリ・ポイントに設定
   ENTRYPOINT ["/usr/bin/mongod"]

.. Now save the file and let’s build our image.

ファイルを保存したら、イメージを構築しましょう。

..    Note:
..    The full version of this Dockerfile can be found here.

この ``Dockerfile`` の完成版は `こちら <https://github.com/docker/docker/blob/master/docs/examples/mongodb/Dockerfile>`_ をご覧ください。

.. Building the MongoDB Docker image

.. _building-the-mongodb-docker-image:

MongoDB Docker イメージの構築
==============================

.. With our Dockerfile, we can now build the MongoDB image using Docker. Unless experimenting, it is always a good practice to tag Docker images by passing the --tag option to docker build command.

作成した ``Dockerfile`` を使い、新しい MongoDB イメージを Docker で構築できます。テスト用でない限り、 ``docker build`` コマンドに ``--tag`` オプションを通して Docker イメージをタグ付けするのが良い手法です。

.. code-block:: bash

   # 書式：docker build --tag/-t <ユーザ名>/<リポジトリ>
   # 例
   $ docker build --tag my/repo .

.. Once this command is issued, Docker will go through the Dockerfile and build the image. The final image will be tagged my/repo.

コマンドを実行したら、 Docker は ``Dockerfile`` を処理してイメージを構築します。イメージは最終的に ``my/repo`` とタグ付けされます。

.. Pushing the MongoDB image to Docker Hub

.. _pushing-the-mongodb-image-to-docker-hub:

MongoDB イメージを Docker Hub に送信
========================================

.. All Docker image repositories can be hosted and shared on Docker Hub with the docker push command. For this, you need to be logged-in.

全ての Docker イメージ・リポジトリを `Docker Hub <https://hub.docker.com/>`_ で保管・共有できるようにするには、 ``docker push`` コマンドを使います。送信するためには、ログインの必要があります。

.. code-block:: bash

   # ログイン
   $ docker login
   Username:
   ..
   
   # イメージを送信
   # 書式：docker push <ユーザ名>/<リポジトリ>
   $ docker push my/repo
   The push refers to a repository [my/repo] (len: 1)
   Sending image list
   Pushing repository my/repo (1 tags)
   ..

.. Using the MongoDB image

.. _using-the-mongodb-image:

MongoDB イメージを使う
==============================

.. Using the MongoDB image we created, we can run one or more MongoDB instances as daemon process(es).

作成した MongoDB イメージを使い、他の MongoDB インスタンスをデーモン・プロセスとして実行できます。

.. code-block:: bash

   # 基本的な方法
   # 使い方：docker run --name <コンテナ名> -d <ユーザ名>/<リポジトリ>
   $ docker run -p 27017:27017 --name mongo_instance_001 -d my/repo
   
   # Docker 化した Mongo DB 、学び理解しました！
   # 使い方：docker run --name <コンテナ名> -d <ユーザ名>/<リポジトリ> --noprealloc --smallfiles
   $ docker run -p 27017:27017 --name mongo_instance_001 -d my/repo --smallfiles
   
   # MongoDB コンテナのログを確認
   # 使い方：docker logs <コンテナ名>
   $ docker logs mongo_instance_001
   
   # MongoDB を使う
   # 使い方：mongo --port <`docker ps` で得られるポート>
   $ mongo --port 27017
   
   # If using docker-machine
   # docker-machine を使う場合
   # 使い方：mongo --port <`docker ps` で得られるポート> --host <`docker-machine ip VM名`の IP アドレス>
   $ mongo --port 27017 --host 192.168.59.103

..    Tip: If you want to run two containers on the same engine, then you will need to map the exposed port to two different ports on the host

.. tip::

   もし同じエンジン上で２つのコンテナを実行したい場合、ホスト側は２つの異なったポートを各コンテナに割り当てる必要があります。

.. code-block:: bash

   # ２つのコンテナを起動し、ポートを割り当て
   $ docker run -p 28001:27017 --name mongo_instance_001 -d my/repo
   $ docker run -p 28002:27017 --name mongo_instance_002 -d my/repo
   
   # 各 MongoDB インスタンスのポートに接続できる
   $ mongo --port 28001
   $ mongo --port 28002

..    Linking containers
    Cross-host linking containers
    Creating an Automated Build

* :doc:`/engine/userguide/networking/default_network/dockerlinks`
* :doc:`/engine/admin/ambassador_pattern_linking`
* :doc:`/docker-hub/builds`

.. seealso:: 

   Dockerizing MongoDB Introduction
      https://docs.docker.com/engine/examples/mongodb/
