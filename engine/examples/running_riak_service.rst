.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/extend/examples/running_riak_service/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/examples/running_riak_service.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/examples/running_riak_service.md
.. check date: 2016/06/13
.. Commits on Mar 4, 2016 69004ff67eed6525d56a92fdc69466c41606151a
.. ---------------------------------------------------------------

.. Dockerizing a Riak service

.. _dockerizing-a-riak-service:

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

=======================================
Riak の Docker 化
=======================================

.. The goal of this example is to show you how to build a Docker image with Riak pre-installed.

この例は、Riak がインストール済みの Docker イメージを、どのように構築するかを紹介するのが目的です。

.. Creating a Dockerfile

Dockerfile の作成
====================

.. Create an empty file called Dockerfile:

``Dockerfile`` という名称の空ファイルを作成します。

.. code-block:: bash

   $ touch Dockerfile

.. Next, define the parent image you want to use to build your image on top of. We’ll use Ubuntu (tag: trusty), which is available on Docker Hub:

次に、自分のイメージを構築するにあたり、元になる親イメージを定義します。ここでは `Docker Hub <https://hub.docker.com/>`_ で利用可能な `Ubuntu <https://hub.docker.com/_/ubuntu/>`_ （タグ： ``trusty`` ）を使います。

.. code-block:: bash

   # Riak
   #
   # VERSION       0.1.1
   
   # Use the Ubuntu base image provided by dotCloud
   FROM ubuntu:trusty
   MAINTAINER Hector Castro hector@basho.com

.. After that, we install the curl which is used to download the repository setup script and we download the setup script and run it.

次は、 curl をインストールします。curl はリポジトリのセットアップ・スクリプトをダウンロードし、実行するためです。

.. code-block:: bash

   # Install Riak repository before we do apt-get update, so that update happens
   # in a single step
   RUN apt-get install -q -y curl && \
       curl -fsSL https://packagecloud.io/install/repositories/basho/riak/script.deb | sudo bash

.. Then we install and setup a few dependencies:

それから、いくつかの依存関係のインストールとセットアップをします。

..    supervisor is used manage the Riak processes
    riak=2.0.5-1 is the Riak package coded to version 2.0.5

* ``supervisor`` は Riak プロセスの管理に使用
* ``riak-2.0.5-1`` は Riack バージョン 2.0.5 のパッケージ

.. code-block:: bash

   # プロジェクトの依存関係をインストール・セットアップ
   RUN apt-get update && \
       apt-get install -y supervisor riak=2.0.5-1
   
   RUN mkdir -p /var/log/supervisor
   
   RUN locale-gen en_US en_US.UTF-8
   
   COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

.. After that, we modify Riak’s configuration:

それから、Riak の設定を変更します。

.. code-block:: bash

   # Riak が、あらゆるホストから接続できるよう設定
   RUN sed -i "s|listener.http.internal = 127.0.0.1:8098|listener.http.internal = 0.0.0.0:8098|" /etc/riak/riak.conf
   RUN sed -i "s|listener.protobuf.internal = 127.0.0.1:8087|listener.protobuf.internal = 0.0.0.0:8087|" /etc/riak/riak.conf

.. Then, we expose the Riak Protocol Buffers and HTTP interfaces:

それから、Riak プロトコル・バッファ用ポートと HTTP インターフェースを公開します。

.. code-block:: bash

   # Riack プロトコル・バッファと HTTP インターフェースの露出
   EXPOSE 8087 8098

.. Finally, run supervisord so that Riak is started:

最後に ``supervisord`` を実行し、 Riack を開始します。

.. code-block:: bash

   CMD ["/usr/bin/supervisord"]

.. Create a supervisord configuration file

.. _riak-create-a-supervisord-configuration-file:

supervisord 設定ファイルの作成
==============================

.. Create an empty file called supervisord.conf. Make sure it’s at the same directory level as your Dockerfile:

``supervisord.conf`` という空のファイルを作成します。 ``Dockerfile`` がある同じディレクトリかどうか確認してください。

.. code-block:: bash

   touch supervisord.conf

.. Populate it with the following program definitions:

以下のプログラム定義を投入します。

.. code-block:: bash

   [supervisord]
   nodaemon=true
   
   [program:riak]
   command=bash -c "/usr/sbin/riak console"
   numprocs=1
   autostart=true
   autorestart=true
   user=riak
   environment=HOME="/var/lib/riak"
   stdout_logfile=/var/log/supervisor/%(program_name)s.log
   stderr_logfile=/var/log/supervisor/%(program_name)s.log

.. Build the Docker image for Riak

.. _build-the-docker-image-for-riak:

Riak 用の Docker イメージを構築
========================================

.. Now you should be able to build a Docker image for Riak:

これで Riak 用の Docker イメージを構築できます。

.. code-block:: bash

   $ docker build -t "<自分のユーザ名>/riak" .

.. Next steps

次のステップ
====================

.. Riak is a distributed database. Many production deployments consist of at least five nodes. See the docker-riak project details on how to deploy a Riak cluster using Docker and Pipework.

Riak は分散データベースです。多くのプロダクションへのデプロイには、 `少なくとも５ノード <http://basho.com/why-your-riak-cluster-should-have-at-least-five-nodes/>`_ が必要と考えられています。 `docker-riak <https://github.com/hectcastro/docker-riak>`_ プロジェクトに、Docker と Pipework を使った Riak クラスタのデプロイ方法の詳細があります。

.. seealso:: 

   Dockerizing a Riak service
      https://docs.docker.com/engine/examples/running_riak_service/
