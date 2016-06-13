.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/admin/ambassador_pattern_linking/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/admin/ambassador_pattern_linking.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/admin/ambassador_pattern_linking.md
.. check date: 2016/06/13
.. Commits on Jan 27, 2016 e310d070f498a2ac494c6d3fde0ec5d6e4479e14
.. ---------------------------------------------------------------------------

.. Link via an ambassador container

=======================================
アンバサダを経由したリンク
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Introduction

はじめに
==========

.. Rather than hardcoding network links between a service consumer and provider, Docker encourages service portability, for example instead of:

サービスの利用者とプロバイダ間をネットワーク・リンクで固定するよりも、サービスのポータビリティを Docker は推奨します。

.. code-block:: bash

   (利用者) --> (redis)

.. Requiring you to restart the consumer to attach it to a different redis service, you can add ambassadors:

``利用者`` が別の ``redis`` サービスに接続するには再起動が必用です。そこで、アンバサダ（「ambassador」＝大使、使節の意味 ）を追加できます。

.. code-block:: bash

   (利用者) --> (redis-ambassador) --> (redis)

.. Or

.. code-block:: bash

    (利用者) --> (redis-ambassador) ---network---> (redis-ambassador) --> (redis)

.. When you need to rewire your consumer to talk to a different Redis server, you can just restart the redis-ambassador container that the consumer is connected to.

利用者が別の Redis サーバに通信するよう書き換える必要がある時、コンテナを接続する ``redis-ambassador`` しか再起動が不要です。

.. This pattern also allows you to transparently move the Redis server to a different docker host from the consumer.

このパターンは利用者を別の docker ホスト上に対し、透過的に移動させるのにも使えます。

.. Using the svendowideit/ambassador container, the link wiring is controlled entirely from the docker run parameters.

``svendowideit/ambassador`` コンテナを使い、 ``docker run`` パラメータで全体を制御するリンクを追加してみましょう。

.. Two host example

２つのホスト例
====================

.. Start actual Redis server on one Docker host

Docker ホスト上で実際の Redis サーバを開始します。

.. code-block:: bash

   big-server $ docker run -d --name redis crosbymichael/redis

.. Then add an ambassador linked to the Redis server, mapping a port to the outside world

それから Redis サーバにリンクしてポートを公開するアンバサダを追加します。

.. code-block:: bash

   big-server $ docker run -d --link redis:redis --name redis_ambassador -p 6379:6379 svendowideit/ambassador

.. On the other host, you can set up another ambassador setting environment variables for each remote port we want to proxy to the big-server

別のホスト上で、更にアンバサダをセットアップできます。ここではプロキシしたい ``big-server`` のリモート・ポートを環境変数に設定します。

.. code-block:: bash

   client-server $ docker run -d --name redis_ambassador --expose 6379 -e REDIS_PORT_6379_TCP=tcp://192.168.1.52:6379 svendowideit/ambassador

.. Then on the client-server host, you can use a Redis client container to talk to the remote Redis server, just by linking to the local Redis ambassador.

それから ``client-server`` ホスト上で Redis クライアント・コンテナがリモートの Redis サーバに通信できるようにするため、ローカルの Redis アンバサダにリンクします。

.. code-block:: bash

   client-server $ docker run -i -t --rm --link redis_ambassador:redis relateiq/redis-cli
   redis 172.17.0.160:6379> ping
   PONG

.. How it works

動作内容
====================

.. The following example shows what the svendowideit/ambassador container does automatically (with a tiny amount of sed)

以下の例で、 ``svendowideit/ambassador`` コンテナが自動的に（多少の ``sed`` の力を使い）何を行っているか見ていきましょう。

.. On the Docker host (192.168.1.52) that Redis will run on:

Docker ホスト（192.168.1.52）上では Redis が実行されています。

.. code-block:: bash

   # 実際の redis サーバを起動
   $ docker run -d --name redis crosbymichael/redis
   
   # 接続テスト用の redis-cli コンテナを取得
   $ docker pull relateiq/redis-cli
   
   # redis サーバと直接通信してテスト
   $ docker run -t -i --rm --link redis:redis relateiq/redis-cli
   redis 172.17.0.136:6379> ping
   PONG
   ^D
   
   # redis アンバサダを追加
   $ docker run -t -i --link redis:redis --name redis_ambassador -p 6379:6379 alpine:3.2 sh

.. In the redis_ambassador container, you can see the linked Redis containers env:

``redis_ambassador`` コンテナ内では、リンクされた ``Redis`` コンテナの状態を ``env`` で確認できます。

.. code-block:: bash

   / # env
   REDIS_PORT=tcp://172.17.0.136:6379
   REDIS_PORT_6379_TCP_ADDR=172.17.0.136
   REDIS_NAME=/redis_ambassador/redis
   HOSTNAME=19d7adf4705e
   SHLVL=1
   HOME=/root
   REDIS_PORT_6379_TCP_PORT=6379
   REDIS_PORT_6379_TCP_PROTO=tcp
   REDIS_PORT_6379_TCP=tcp://172.17.0.136:6379
   TERM=xterm
   PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   PWD=/
   / # exit

.. This environment is used by the ambassador socat script to expose Redis to the world (via the -p 6379:6379 port mapping):

この環境変数は、アンバサダの ``socat`` スクリプトが Redis を公開するために使います（ ``-p 6379:6369`` でポートを割り当てます ）。

.. code-block:: bash

   $ docker rm redis_ambassador
   $ CMD="apk update && apk add socat && sh"
   $ docker run -t -i --link redis:redis --name redis_ambassador -p 6379:6379 alpine:3.2 sh -c "$CMD"
   [...]
   / # socat -t 100000000 TCP4-LISTEN:6379,fork,reuseaddr TCP4:172.17.0.136:6379

.. Now ping the Redis server via the ambassador:

次は Redis サーバにアンバサダ経由で ping します。

.. Now go to a different server:

次は別のサーバに移動します。

.. code-block:: bash

   $ CMD="apk update && apk add socat && sh"
   $ docker run -t -i --expose 6379 --name redis_ambassador alpine:3.2 sh -c "$CMD"
   [...]
   / # socat -t 100000000 TCP4-LISTEN:6379,fork,reuseaddr TCP4:192.168.1.52:6379

.. And get the redis-cli image so we can talk over the ambassador bridge.

``redis-cli`` イメージを取得し、アンバサダ・ブリッジを経由して通信します。

.. code-block:: bash

   $ docker pull relateiq/redis-cli
   $ docker run -i -t --rm --link redis_ambassador:redis relateiq/redis-cli
   redis 172.17.0.160:6379> ping
   PONG

.. The svendowideit/ambassador Dockerfile

svendowideit/ambassador Dockerfile
========================================

.. The svendowideit/ambassador image is based on the alpine:3.2 image with socat installed. When you start the container, it uses a small sed script to parse out the (possibly multiple) link environment variables to set up the port forwarding. On the remote host, you need to set the variable using the -e command line option.

``svendowideit/ambassador`` イメージは ``socat`` がインストールされた ``alpine:3.2`` イメージをベースとしています。コンテナを実行すると、小さな ``sed`` スクリプトが（利用可能な複数の）リンク環境変数をポート転送用に使います。リモートホストであれば、コマンドラインのオプション実行に ``-e`` で環境変数を指定する必要があります。

.. code-block:: bash

   --expose 1234 -e REDIS_PORT_1234_TCP=tcp://192.168.1.52:6379

.. Will forward the local 1234 port to the remote IP and port, in this case 192.168.1.52:6379.

ローカルの ``1234`` ポートをリモートの IP とポートに転送します。この例では ``192.168.1.52:6379`` です。

.. code-block:: bash

   #
   # do
   #   docker build -t svendowideit/ambassador .
   # then to run it (on the host that has the real backend on it)
   #   docker run -t -i -link redis:redis -name redis_ambassador -p 6379:6379 svendowideit/ambassador
   # on the remote host, you can set up another ambassador
   #    docker run -t -i -name redis_ambassador -expose 6379 -e REDIS_PORT_6379_TCP=tcp://192.168.1.52:6379 svendowideit/ambassador sh
   # you can read more about this process at https://docs.docker.com/articles/ambassador_pattern_linking/
   
   # use alpine because its a minimal image with a package manager.
   # prettymuch all that is needed is a container that has a functioning env and socat (or equivalent)
   FROM    alpine:3.2
   MAINTAINER  SvenDowideit@home.org.au
   
   RUN apk update && \
       apk add socat && \
       rm -r /var/cache/
   
   CMD env | grep _TCP= | sed 's/.*_PORT_\([0-9]*\)_TCP=tcp:\/\/\(.*\):\(.*\)/socat -t 100000000 TCP4-LISTEN:\1,fork,reuseaddr TCP4:\2:\3 \&/' && echo wait) | sh

.. seealso:: 

   Link via an ambassador container
      https://docs.docker.com/engine/admin/ambassador_pattern_linking/
