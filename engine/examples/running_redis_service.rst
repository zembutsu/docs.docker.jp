.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/extend/examples/running_redis_service/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/examples/running_redis_service.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/examples/running_redis_service.md
.. check date: 2016/06/13
.. Commits on Jun 2, 2016 c1be45fa38e82054dcad606d71446a662524f2d5
.. ---------------------------------------------------------------

.. Dockerizing a Redis service

.. _dockerizing-a-redis-service:

========================================
Redis サービスの Docker 化
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Very simple, no frills, Redis service attached to a web application using a link.

非常にシンプルで飾り気のない Redis サービスを、リンク機能を使ってウェブ・アプリケーションにアタッチします。

.. Create a Docker container for Redis

.. _create-a-docker-container-for-redis:

Redis 用の Docker コンテナを作成
========================================

.. Firstly, we create a Dockerfile for our new Redis image.

まず、新しい Redis イメージ用の ``Dockerfile`` を作成します。

.. code-block:: bash

   FROM        ubuntu:14.04
   RUN         apt-get update && apt-get install -y redis-server
   EXPOSE      6379
   ENTRYPOINT  ["/usr/bin/redis-server"]

.. Next we build an image from our Dockerfile. Replace <your username> with your own user name.

次に、 ``Dockerfile`` からイメージを構築します。 ``<自分のユーザ前>`` の場所は、自分自身のリポジトリ名に置き換えてください。

.. code-block:: bash

   $ docker build -t <自分のユーザ名>/redis .

.. Run the service

サービスの実行
====================

.. Use the image we’ve just created and name your container redis.

先ほど作成したイメージを使い、コンテナ名を ``redis`` とします。

.. Running the service with -d runs the container in detached mode, leaving the container running in the background.

コンテナに ``-d`` を付けて実行すると、デタッチド・モードとして実行され、コンテナはバックグラウンドで動作します。

.. Importantly, we’re not exposing any ports on our container. Instead we’re going to use a container link to provide access to our Redis database.

重要なのは、コンテナ内のポートを全く公開していない点です。そのかわり、Redis データベースに接続するには、コンテナに対するリンク機能を使います。

.. code-block:: bash

   $ docker run --name redis -d <自分の名前>/redis

.. Create your web application container

.. _redis-create-your-web-application-container:

ウェブ・アプリケーションのコンテナを作成
========================================

.. Next we can create a container for our application. We’re going to use the -link flag to create a link to the redis container we’ve just created with an alias of db. This will create a secure tunnel to the redis container and expose the Redis instance running inside that container to only this container.

次にアプリケーションのコンテナを作成します。 ``--link`` フラグを使い、 ``redis`` コンテナに対するリンクを作成します。ここでは ``db`` というエイリアス（別名）で作成します。これにより、 ``redis`` コンテナと安全なトンネルが作成されます。Redis インスタンスが公開しているコンテナ内のポートには、ここで指定したコンテナだけ接続できるようになります。

.. code-block:: bash

   $ docker run --link redis:db -i -t ubuntu:14.04 /bin/bash

.. Once inside our freshly created container we need to install Redis to get the redis-cli binary to test our connection.

新しく作成したコンテナの中では、接続をテストするために ``redis-cli`` バイナリの取得・インストールが必要です。

.. code-block:: bash

   $ sudo apt-get update
   $ sudo apt-get install redis-server
   $ sudo service redis-server stop

.. As we’ve used the --link redis:db option, Docker has created some environment variables in our web application container.

それから ``--link redis:db`` オプションを使い、Docker がウェブ・アプリケーションのコンテナ内で利用可能な環境変数を作成します。

.. code-block:: bash

   $ env | grep DB_
   
   # Should return something similar to this with your values
   DB_NAME=/violet_wolf/db
   DB_PORT_6379_TCP_PORT=6379
   DB_PORT=tcp://172.17.0.33:6379
   DB_PORT_6379_TCP=tcp://172.17.0.33:6379
   DB_PORT_6379_TCP_ADDR=172.17.0.33
   DB_PORT_6379_TCP_PROTO=tcp

.. We can see that we’ve got a small list of environment variables prefixed with DB. The DB comes from the link alias specified when we launched the container. Let’s use the DB_PORT_6379_TCP_ADDR variable to connect to our Redis container.

ここでは ``DB`` が接頭語となっている複数の環境変数が見えます。 ``DB`` とはコンテナ起動時に指定した、リンクのエイリアスです。 ``DB_PORT_6379_TCP_ADDR`` を使って Redis コンテナに接続してみましょう。

.. code-block:: bash

   $ redis-cli -h $DB_PORT_6379_TCP_ADDR
   $ redis 172.17.0.33:6379>
   $ redis 172.17.0.33:6379> set docker awesome
   OK
   $ redis 172.17.0.33:6379> get docker
   "awesome"
   $ redis 172.17.0.33:6379> exit

.. We could easily use this or other environment variables in our web application to make a connection to our redis container.

ウェブ・アプリケーションが ``redis`` コンテナに接続するために、この環境変数や他の環境変数を利用できます。

.. seealso:: 

   Dockerizing a Redis service
      https://docs.docker.com/engine/examples/running_redis_service/
