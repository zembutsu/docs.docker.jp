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
Compose における起動順の制御
==============================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. You can control the order of service startup with the
   [depends_on](compose-file.md#depends-on) option. Compose always starts
   containers in dependency order, where dependencies are determined by
   `depends_on`, `links`, `volumes_from`, and `network_mode: "service:..."`.

サービスの起動順は、:ref:`compose-file-depends_on` オプションを使って制御することができます。
Compose では必ず依存順に応じて、コンテナーの起動を行いますが、この依存順とは ``depends_on`` 、 ``links`` 、 ``volumes_from`` 、 ``network_mode: "サービス:..."`` によって決定します。

.. However, Compose will not wait until a container is "ready" (whatever that means
   for your particular application) - only until it's running. There's a good
   reason for this.

しかし起動時の場合、Compose はコンテナーが "準備状態" になって初めて制御を待ちます。
（これがアプリケーションにとってどのような意味になるかには無関係です。）
つまり稼動していることが必要です。
これには十分な理由があります。

.. The problem of waiting for a database (for example) to be ready is really just
   a subset of a much larger problem of distributed systems. In production, your
   database could become unavailable or move hosts at any time. Your application
   needs to be resilient to these types of failures.

たとえばデータベースが準備状態になるまで待ち続けたとすると、分散システムにおいては非常に大きな問題となります。
本番環境であれば利用不能となって、すぐにホストを切り替えなければならなくなります。
アプリケーションは、このような状況に柔軟に対応できるものでなくてはなりません。

.. To handle this, your application should attempt to re-establish a connection to
   the database after a failure. If the application retries the connection,
   it should eventually be able to connect to the database.

こういったことを取り扱う際には、データベースへの接続に失敗した後に、接続を再度確立するようにアプリケーションを設計しておくことが必要です。
アプリケーションが再接続を行えば、そのうちデータベースへの接続が成功します。

.. The best solution is to perform this check in your application code, both at
   startup and whenever a connection is lost for any reason. However, if you don't
   need this level of resilience, you can work around the problem with a wrapper
   script:

最適な方法は、再接続をアプリケーションコード内で行うことです。
これは起動時にも行い、さらに何らかの理由で接続が断たれた際にも行います。
もっともそれほどの柔軟性を必要としないのであれば、以下のようなラッパースクリプトを使ってこの問題を回避する方法もあります。

.. -   Use a tool such as [wait-for-it](https://github.com/vishnubob/wait-for-it),
       [dockerize](https://github.com/jwilder/dockerize) or sh-compatible
       [wait-for](https://github.com/Eficode/wait-for). These are small
       wrapper scripts which you can include in your application's image and will
       poll a given host and port until it's accepting TCP connections.

*   `wait-for-it <https://github.com/vishnubob/wait-for-it>`_ 、 `dockerize <https://github.com/jwilder/dockerize>`_ 、あるいはシェル互換の `wait-for <https://github.com/Eficode/wait-for>`_ を利用します。
    これは非常に小さなラッパースクリプトです。
    これをアプリケーションイメージに含めて、指定されたホストが TCP 接続を受け入れるまでの間、指定ポートに問い合わせを行うようにすることができます。

   ..  For example, to use `wait-for-it.sh` or `wait-for` to wrap your service's command:

   たとえば ``wait-for-it.sh`` または ``wait-for`` を使って、サービスコマンドをラップするには以下のようにします。

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

   ..  >**Tip**: There are limitations to this first solution; e.g., it doesn't verify when a specific service is really ready. If you add more arguments to the command, you'll need to use the `bash shift` command with a loop, as shown in the next example.

   .. tip::

      この解決方法には限界があります。
      たとえば指定するサービスが、本当に準備状態であるかどうかは確認できません。
      コマンドにさらに引数を追加して ``bash shift`` を利用し、ループによって対処するのが次の例です。

.. -   Alternatively, write your own wrapper script to perform a more application-specific health
       check. For example, you might want to wait until Postgres is definitely
       ready to accept commands:

*   別の方法として、独自にラッパースクリプトを用意して、アプリケーション特有のヘルスチェックを実現することも考えられます。
    たとえば、Postgres が完全に準備状態になって、コマンドを受け付けるようになるまで待ちたいとするなら、以下のスクリプトを用意します。

   .. code-block:: bash

      #!/bin/bash
      # wait-for-postgres.sh

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

   ..  You can use this as a wrapper script as in the previous example, by setting:

   このラッパースクリプトを先の例において利用するには、以下のように設定します。

   ..  ```none
       command: ["./wait-for-postgres.sh", "db", "python", "app.py"]
       ```

   ::

      command: ["./wait-for-postgres.sh", "db", "python", "app.py"]

.. Compose documentation

Compose ドキュメント
====================

..     Installing Compose
    Get started with Django
    Get started with WordPress
    Get started with Rails
    Command line reference
    Compose file reference

* :doc:`install`
* :doc:`django`
* :doc:`wordpress`
* :doc:`rails`
* :doc:`/compose/reference/index`
* :doc:`/compose/compose-file`

.. seealso:: 

   Controlling startup order in Compose
      https://docs.docker.com/compose/startup-order/

