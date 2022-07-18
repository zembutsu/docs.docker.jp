.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/startup-order/
.. SOURCE: 
   doc version: 1.10
      https://github.com/docker/compose/commits/master/docs/startup-order.md
   doc version: v20.10
      https://github.com/docker/docker.github.io/blob/master/compose/startup-order.md
.. check date: 2022/07/18
.. Commits on Jul 6, 2022 541ff04313335ecc62054722ed0819f8f11f7c7c
.. ----------------------------------------------------------------------------

.. Control startup and shutdown order in Compose
.. _control-startup-and-shutdown-order-in-compose:

========================================
Compose における起動順と停止順の制御
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. You can control the order of service startup and shutdown with the depends_on option. Compose always starts and stops containers in dependency order, where dependencies are determined by depends_on, links, volumes_from, and network_mode: "service:...".

:ref:`depends_on <compose-file-v3-depends_on>` オプションの使用で、サービスの起動順番と停止順番を制御できます。Compose は常にコンテナの依存関係の順番で、起動と停止を行います。この依存関係を決めるのは、 ``depends_on`` 、 ``links`` 、 ``volumes_from`` 、 ``network_mode: "service:..."`` です。

.. However, for startup Compose does not wait until a container is “ready” (whatever that means for your particular application) - only until it’s running. There’s a good reason for this.

しかし、Compose の起動とは、コンテナの「準備」が整うまで（個々のアプリケーションによって、意味は異なりますが）待ちません。単にコンテナを実行するだけです。これには相応の理由があります。

.. The problem of waiting for a database (for example) to be ready is really just a subset of a much larger problem of distributed systems. In production, your database could become unavailable or move hosts at any time. Your application needs to be resilient to these types of failures.

（たとえば）データベースの準備が調うまで待機する問題とは、分散システムという大きな問題の一部にすぎません。本番環境では、データベースが利用不可能になったり、常にホストを移動します。アプリケーションは、このような障害に対する :ruby:`回復力 <resilient>` が必要です。

.. To handle this, design your application to attempt to re-establish a connection to the database after a failure. If the application retries the connection, it can eventually connect to the database.

これを扱うため、データベースで障害の発生後に、接続の再確立を試みるようアプリケーションを設計します。アプリケーションが接続を再試行すると、いずれデータベースに接続できるようにします。

.. The best solution is to perform this check in your application code, both at startup and whenever a connection is lost for any reason. However, if you don’t need this level of resilience, you can work around the problem with a wrapper script:

起動時と、何らかの理由で通信が失われた場合の両方で、アプリケーション コード内でこの確認をするのが、一番良い解決策です。しかし、このレベルの回復力を必要としないばあい、 :ruby:`ラッパー スクリプト <wrapper script>` で問題を回避できます。

..  Use a tool such as wait-for-it, dockerize, Wait4X, sh-compatible wait-for, or RelayAndContainers template. These are small wrapper scripts which you can include in your application’s image to poll a given host and port until it’s accepting TCP connections.

* ツールを使います。具体的には `wait-for-it <https://github.com/vishnubob/wait-for-it>`_ 、 `dockerize <https://github.com/powerman/dockerize>`_ 、 `Wait4X <https://github.com/atkrad/wait4x>`_  、 sh 互換の `wait-for <https://github.com/Eficode/wait-for>`_ 、 `ReadyAndContainers <https://github.com/jasonsychau/RelayAndContainers>`_ テンプレートです。

   ..    For example, to use wait-for-it.sh or wait-for to wrap your service’s command:

   たとえば、サービスのコマンドをラップする ``wait-for-it.sh`` や ``wait-for`` を使います。

   .. code-block:: yaml

      version: "2"
      services:
        web:
          build: .
          ports:
            - "80:8000"
          depends_on:
            - "db"
          command: ["./wait-for-it.sh", "db:5432", "--", "python", "app.py"]
        db:
          image: postgres

   ..     Tip
          There are limitations to this first solution. For example, it doesn’t verify when a specific service is really ready. If you add more arguments to the command, use the bash shift command with a loop, as shown in the next example.

   .. tips::
   
      この１つめの解決策には限界があります。たとえば、指定したサービスが本当に準備完了したか確認できません。コマンドに対して更に引数を追加します。 ``bash shift`` コマンドを使ってループさせるのが、次の例です。

    Alternatively, write your own wrapper script to perform a more application-specific health check. For example, you might want to wait until Postgres is ready to accept commands:

* 別の解決策として、自分でラッパースクリプトを書き、よりアプリケーション固有のヘルスチェックを処理できるようにします。たとえば、 Postgres でコマンドを受け付ける準備が調うまで待ちたい場合を考えます。

   .. code-block:: bash

      #!/bin/sh
      # wait-for-postgres.sh
      
      set -e
        
      host="$1"
      shift
        
      until PGPASSWORD=$POSTGRES_PASSWORD psql -h "$host" -U "postgres" -c '\q'; do
        >&2 echo "Postgres is unavailable - sleeping"
        sleep 1
      done
        
      >&2 echo "Postgres is up - executing command"
      exec "$@"

   ..  You can use this as a wrapper script as in the previous example, by setting:
   
   この例にあるラッパースクリプトを使うには、次のように設定します。

   .. code-block:: bash
   
      command: ["./wait-for-postgres.sh", "db", "python", "app.py"]

Compose ドキュメント
====================

..  User guide
    Installing Compose
    Getting Started
    Command line reference
    Compose file reference
    Sample apps with Compose

* :doc:`ユーザガイド <index>`
* :doc:`Compose のインストール <install>`
* :doc:`始めましょう <gettingstarted>`
* :doc:`コマンドライン リファレンス <reference/index>`
* :doc:`Compose ファイル リファレンス <compose-file>`
* :doc:`Compose のサンプルアプリ <samples-for-compose>`


.. seealso:: 

   Control startup and shutdown order in Compose
      https://docs.docker.com/compose/startup-order/

