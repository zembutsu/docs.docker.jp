.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/startup-order/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/startup-order.md
   doc version: 1.10
      https://github.com/docker/compose/commits/master/docs/startup-order.md
.. check date: 2016/04/28
.. Commits on Mar 3, 2016 aa7b862f4c7f10337fc0b586d70aae5392b51f6c
.. ----------------------------------------------------------------------------

.. Controlling startup order in Compose

.. _controlling-startup-order-in-compose:

==============================
Compose の起動順番を制御
==============================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. You can control the order of service startup with the depends_on option. Compose always starts containers in dependency order, where dependencies are determined by depends_on, links, volumes_from and network_mode: "service:...".

:ref:`compose-file-depends_on` オプションを使えば、サービスの起動順番を制御できます。Compose は常に依存関係に従ってコンテナを起動しようとします。依存関係とは、 ``depends_on`` 、 ``links`` 、 ``volumes_form`` 、 ``network_mode: "サービス:..."`` を指定している場合です。

.. However, Compose will not wait until a container is “ready” (whatever that means for your particular application) - only until it’s running. There’s a good reason for this.

しかしながら、Compose はコンテナの準備が「整う」まで待ちません（つまり、特定のアプリケーションが利用可能になるまで待ちません）。単に起動するだけです。これには理由があります。

.. The problem of waiting for a database (for example) to be ready is really just a subset of a much larger problem of distributed systems. In production, your database could become unavailable or move hosts at any time. Your application needs to be resilient to these types of failures.

たとえば、データベースの準備が整うまで待つのであれば、そのことが分散システム全体に対する大きな問題になり得ます。プロダクションでは、データベースは利用不可能になったり、あるいは別のホストに移動したりする場合があるでしょう。アプリケーションは、障害発生に対して復旧する必要があるためです。

.. To handle this, your application should attempt to re-establish a connection to the database after a failure. If the application retries the connection, it should eventually be able to connect to the database.

データベースに対する接続が失敗したら、アプリケーションは再接続を試みるように扱わなくてはいけません。アプリケーションは再接続を試みるため、データベースへの接続を定期的に行う必要があるでしょう。

.. The best solution is to perform this check in your application code, both at startup and whenever a connection is lost for any reason. However, if you don’t need this level of resilience, you can work around the problem with a wrapper script:

この問題を解決するベストな方法は、アプリケーションのコード上で解決することです。起動時に、あるいは何らかの理由によって接続できない場合にです。しかしながら、このレベルの復旧が必要なければ、ラッパー用のスクリプトを書くことでも対処できます。

..    Use a tool such as wait-for-it or dockerize. These are small wrapper scripts which you can include in your application’s image and will poll a given host and port until it’s accepting TCP connections.

* `wait-for-it <https://github.com/vishnubob/wait-for-it>`_ や `dockerize <https://github.com/jwilder/dockerize>`_ のようなツールを使います。これらはラッパー用のスクリプトであり、アプリケーションのイメージに含めることができます。また特定のホスト側のポートに対して、TCP 接続を受け入れ可能です。

..    Supposing your application’s image has a CMD set in its Dockerfile, you can wrap it by setting the entrypoint in docker-compose.yml:

アプリケーションのイメージに適用するためには、Dockerfile の ``CMD`` 命令でラップできるように ``docker-compose.yml`` の entrypoint を設定します。

.. code-block:: yaml

   version: "2"
   services:
     web:
       build: .
       ports:
         - "80:8000"
       depends_on:
         - "db"
       entrypoint: ./wait-for-it.sh db:5432
     db:
       image: postgres

..     Write your own wrapper script to perform a more application-specific health check. For example, you might want to wait until Postgres is definitely ready to accept commands:

* アプリケーションが独自にヘルスチェックを行えるよう、スクリプトをラッパーすることも可能です。たとえば、Postgres コマンドが使えるようになるまで待ちたい場合を考えてみましょう。

.. code-block:: bash

   #!/bin/bash
   
   set -e
   
   host="$1"
   shift
   cmd="$@"
   
   until psql -h "$host" -U "postgres" -c '\l'; do
     >&2 echo "Postgres is unavailable - sleeping"
     sleep 1
   done
   
   >&2 echo "Postgres is up - executing command"
   exec $cmd

..     You can use this as a wrapper script as in the previous example, by setting entrypoint: ./wait-for-postgres.sh db.

このラッパー・スクリプトの例を使うには、 ``entrypoint: ./wait-for-postgres.sh db`` と指定します。

.. Compose documentation

Compose ドキュメント
====================

..     Installing Compose
    Get started with Django
    Get started with Rails
    Get started with WordPress
    Command line reference
    Compose file reference

* :doc:`install`
* :doc:`django`
* :doc:`wordpress`
* :doc:`install`
* :doc:`/compose/reference/index`
* :doc:`/compose/compose-file`

.. seealso:: 

   Controlling startup order in Compose
      https://docs.docker.com/compose/startup-order/

