.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/extend/examples/postgresql_service/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/examples/postgresql_service.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/examples/postgresql_service.md
.. check date: 2016/06/13
.. Commits on Jan 24, 2016 e310d070f498a2ac494c6d3fde0ec5d6e4479e14
.. ---------------------------------------------------------------

.. Dockerizing PostgreSQL

.. _dockerizing-postgresql:

========================================
PostgreSQL の Docker 化
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

..    Note: - If you don’t like sudo then see Giving non-root access

   ``sudo`` が好きでなければ、 :ref:`giving-non-root-access` をご覧ください。

.. Installing PostgreSQL on Docker

.. _installing-postgresql-on-docker:

Docker に PostgreSQL をインストール
===================================

.. Assuming there is no Docker image that suits your needs on the Docker Hub, you can create one yourself.

ここでは `Docker Hub <https://hub.docker.com/>`__ で配布されている Docker イメージを使いますが、自分自身で作成しても構いません。

.. Start by creating a new Dockerfile:

まず、新しい ``Dockerfile`` を作成します。

..    Note: This PostgreSQL setup is for development-only purposes. Refer to the PostgreSQL documentation to fine-tune these settings so that it is suitably secure.

.. note::

   この PostgreSQL のセットアップは、開発用途専用です。より安全にするためには、PostgreSQL のドキュメントを参照し、適切に調整ください。

.. code-block:: bash

   #
   # https://docs.docker.com/examples/postgresql_service/ にあるサンプルの Dockerfile です
   #
   
   FROM ubuntu
   MAINTAINER SvenDowideit@docker.com
   
   # Add the PostgreSQL PGP key to verify their Debian packages.
   # It should be the same key as https://www.postgresql.org/media/keys/ACCC4CF8.asc
   RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8
   
   # Add PostgreSQL's repository. It contains the most recent stable release
   #     of PostgreSQL, ``9.3``.
   RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list
   
   # Install ``python-software-properties``, ``software-properties-common`` and PostgreSQL 9.3
   #  There are some warnings (in red) that show up during the build. You can hide
   #  them by prefixing each apt-get statement with DEBIAN_FRONTEND=noninteractive
   RUN apt-get update && apt-get install -y python-software-properties software-properties-common postgresql-9.3 postgresql-client-9.3 postgresql-contrib-9.3
   
   # Note: The official Debian and Ubuntu images automatically ``apt-get clean``
   # after each ``apt-get``
   
   # Run the rest of the commands as the ``postgres`` user created by the ``postgres-9.3`` package when it was ``apt-get installed``
   USER postgres
   
   # Create a PostgreSQL role named ``docker`` with ``docker`` as the password and
   # then create a database `docker` owned by the ``docker`` role.
   # Note: here we use ``&&\`` to run commands one after the other - the ``\``
   #       allows the RUN command to span multiple lines.
   RUN    /etc/init.d/postgresql start &&\
       psql --command "CREATE USER docker WITH SUPERUSER PASSWORD 'docker';" &&\
       createdb -O docker docker
   
   # Adjust PostgreSQL configuration so that remote connections to the
   # database are possible.
   RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.3/main/pg_hba.conf
   
   # And add ``listen_addresses`` to ``/etc/postgresql/9.3/main/postgresql.conf``
   RUN echo "listen_addresses='*'" >> /etc/postgresql/9.3/main/postgresql.conf
   
   # Expose the PostgreSQL port
   EXPOSE 5432
   
   # Add VOLUMEs to allow backup of config, logs and databases
   VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]
   
   # Set the default command to run when starting the container
   CMD ["/usr/lib/postgresql/9.3/bin/postgres", "-D", "/var/lib/postgresql/9.3/main", "-c", "config_file=/etc/postgresql/9.3/main/postgresql.conf"]

.. Build an image from the Dockerfile assign it a name.

Dockerfile で構築するイメージに名前を割り当てます。

.. code-block:: bash

   $ docker build -t eg_postgresql .

.. And run the PostgreSQL server container (in the foreground):

それから PostgreSQL サーバコンテナを（フォアグラウンドで）実行します。

.. code-block:: bash

   $ docker run --rm -P --name pg_test eg_postgresql

.. There are 2 ways to connect to the PostgreSQL server. We can use Link Containers, or we can access it from our host (or the network).

PostgreSQL サーバに接続するには２つの方法があります。 :doc:`コンテナをリンク </engine/userguide/networking/default_network/dockerlinks>` するか、ホスト側（あるいはネットワーク側）から接続できます。

..     Note: The --rm removes the container and its image when the container exits successfully.

.. note::

   ``--rm`` はコンテナが正常終了したら、コンテナのイメージを自動削除します。

.. Using container linking

.. _postgresql-using-container-linking:

コンテナのリンク機能を使う
------------------------------

.. Containers can be linked to another container’s ports directly using -link remote_name:local_alias in the client’s docker run. This will set a number of environment variables that can then be used to connect:

クライアントの ``docker run`` 時に ``-link リモート名:ローカル・エイリアス`` を指定時、コンテナが他のコンテナのポートに直接接続できるようになります。これは接続のために使える複数の環境変数を作成します。

.. code-block:: bash

   $ docker run --rm -t -i --link pg_test:pg eg_postgresql bash
   
   postgres@7ef98b1b7243:/$ psql -h $PG_PORT_5432_TCP_ADDR -p $PG_PORT_5432_TCP_PORT -d docker -U docker --password

.. Connecting from your host system

.. _postgresql-connecting-from-your-host-system:

ホストシステムから接続
------------------------------

.. Assuming you have the postgresql-client installed, you can use the host-mapped port to test as well. You need to use docker ps to find out what local host port the container is mapped to first:

postgresql クライアントがインストールされていれば、ホスト側に割り当てられたポートに対しても、同様にテストできます。 ``docker ps`` でコンテナがどこのポートに割り当てられているか確認します。

.. code-block:: bash

   $ docker ps
   CONTAINER ID        IMAGE                  COMMAND                CREATED             STATUS              PORTS                                      NAMES
   5e24362f27f6        eg_postgresql:latest   /usr/lib/postgresql/   About an hour ago   Up About an hour    0.0.0.0:49153->5432/tcp                    pg_test
   $ psql -h localhost -p 49153 -d docker -U docker --password

.. Testing the database

.. _postgresql-testing-the-database:

データベースのテスト
------------------------------

.. Once you have authenticated and have a docker =# prompt, you can create a table and populate it.

認証すると ``docker =#`` プロンプトが表示され、テーブル作成を処理できます。

.. code-block:: bash

   psql (9.3.1)
   Type "help" for help.
   
   $ docker=# CREATE TABLE cities (
   docker(#     name            varchar(80),
   docker(#     location        point
   docker(# );
   CREATE TABLE
   $ docker=# INSERT INTO cities VALUES ('San Francisco', '(-194.0, 53.0)');
   INSERT 0 1
   $ docker=# select * from cities;
        name      | location
   ---------------+-----------
    San Francisco | (-194,53)
   (1 row)

.. Using the container volumes

.. _postgresql-using-the-container-volumes:

コンテナ・ボリュームを使う
------------------------------

.. You can use the defined volumes to inspect the PostgreSQL log files and to backup your configuration and data:

PostgreSQL のログファイル調査や、設定やデータのバックアップのために、ボリュームを定義できます。

.. code-block:: bash

   $ docker run --rm --volumes-from pg_test -t -i busybox sh
   
   / # ls
   bin      etc      lib      linuxrc  mnt      proc     run      sys      usr
   dev      home     lib64    media    opt      root     sbin     tmp      var
   / # ls /etc/postgresql/9.3/main/
   environment      pg_hba.conf      postgresql.conf
   pg_ctl.conf      pg_ident.conf    start.conf
   /tmp # ls /var/log
   ldconfig    postgresql

.. seealso:: 

   Dockerizing PostgreSQL
      https://docs.docker.com/engine/examples/postgresql_service/
