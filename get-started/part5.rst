.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/get-started/part5/
   doc version: 17.06
      https://github.com/docker/docker.github.io/blob/master/get-started/part5.md
.. check date: 2017/09/12
.. Commits on Aug 26 2017 4445f27581bd2d190ecd69b6ca31b8dc04b2b9e3
.. -----------------------------------------------------------------------------

.. Get Started, Part 5: Stacks

========================================
Part 5：スタック
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 2
       :local:

.. Prerequisites

必要条件
==========

..    Install Docker version 1.13 or higher.
    Get Docker Compose as described in Part 3 prerequisites.
    Get Docker Machine as described in Part 4 prerequisites.
    Read the orientation in Part 1.
    Learn how to create containers in Part 2.
    Make sure you have published the friendlyhello image you created by pushing it to a registry. We’ll use that shared image here.
    Be sure your image works as a deployed container. Run this command, slotting in your info for username, repo, and tag: docker run -p 80:80 username/repo:tag, then visit http://localhost/.
    Have a copy of your docker-compose.yml from Part 3 handy.
    Make sure that the machines you set up in part 4 are running and ready. Run docker-machine ls to verify this. If the machines are stopped, run docker-machine start myvm1 to boot the manager, followed by docker-machine start myvm2 to boot the worker.
    Have the swarm you created in part 4 running and ready. Run docker-machine ssh myvm1 "docker node ls" to verify this. If the swarm is up, both nodes will report a ready status. If not, reinitialze the swarm and join the worker as described in Set up your swarm.

* :doc:`Docker バージョン 1.13 以上のインストール </engine/installation/index>`
* :doc:`Part 4 <part4>' で扱った :doc:`Docker Machine </machine/overview>` を入手。
* :doc:`Part 1 <index>` の概要を読んでいること
* :doc:`Part 2 <part>` のコンテナの作成方法学んでいること
* 自分で作成した ``friendlyhello`` イメージを :ref:`レジストリに送信 <share-your-image>` して公開済みなのを確認します。ここでは、この共有イメージを使います。
* イメージをコンテナとしてデプロイできるのを確認します。次のコマンドを実行しますが、 ``ユーザ名`` と ``リポジトリ`` ``タグ`` は皆さんのものに置き換えます。コマンドは ``docker run -p 80:80 ユーザ名/リポジトリ:タグ`` です。そして ``http://localhost/`` を表示します。
* :doc:`Part 3 <part3>` で扱った ``docker-compose.yml`` のコピーを持っていること
* :doc:`Part 4 <part4>` でセットアップしたマシンが実行中かつ準備できていること。確認には ``docker-machine ls`` を実行。マシンが停止している場合は、マネージャを ``docker-machine start myvm1`` で起動し、ワーカを ``docker-machine start myvm2`` で起動
* :doc:`Part 4 <part4>` で作成した swarm （クラスタのこと）が実行中かつ準備できていること。確認には ``docker-machine ssh myvm1 "docker node ls"`` を実行。swarm が起動中であれば、いずれのノードも status （状態）は ``ready`` （準備完了）。そうでなければ、swarm を再度初期化し、ワーカを :ref:`swram としてセットアップ <set-up-your-swarm>` します。

.. Introduction

はじめに
==========

.. In part 4, you learned how to set up a swarm, which is a cluster of machines running Docker, and deployed an application to it, with containers running in concert on multiple machines.

:doc:`Part 4 <part4>` では、 swarm のセットアップ方法を学びました。swarm とは Docker を実行しているマシンのクラスタであり、アプリケーションを複数のマシン上へ一斉にデプロイします。

.. Here in part 5, you’ll reach the top of the hierarchy of distributed applications: the stack. A stack is a group of interrelated services that share dependencies, and can be orchestrated and scaled together. A single stack is capable of defining and coordinating the functionality of an entire application (though very complex applications may want to use multiple stacks).

この Part 5 では、 **スタック（stack）** という分散アプリケーション階層の頂上に辿り着きました。スタックは相互関係を持つサービスのグループであり、依存関係を共有します。そして、同時にオーケストレート（訳者注；複数のサーバ上で一斉に挙動する）やスケール（訳者注；サービスの拡大および縮小）します。１つのスタックでアプリケーション全体の能力を定義し、機能全体をコード化します（複雑なアプリケーションであれば、複数のスタックを使うことになるでしょう）

.. Some good news is, you have technically been working with stacks since part 3, when you created a Compose file and used docker stack deploy. But that was a single service stack running on a single host, which is not usually what takes place in production. Here, you will take what you’ve learned, make multiple services relate to each other, and run them on multiple machines.

良いお知らせがあります。スタックに関する技術的な内容は Part 3 で既に学んだとおり、 Compose ファイルを作成し、 ``docker stack deploy`` を実行するだけです。しかし、これまで行ったは１つのホスト上で１つのサービス・スタックを動かしただけであり、プロダクションではあまり見ない環境です。ここでは従来の学びに加え、複数のマシン上で複数の関連サービスをお互いに作成し、実行しましょう。

.. You’re doing great, this is the home stretch!

ここまでおつかれさまでした。あと一息です！

.. Add a new service and redeploy

.. _add-a-new-service-and-redeploy:

新しいサービスの追加と再デプロイ
========================================

.. It’s easy to add services to our docker-compose.yml file. First, let’s add a free visualizer service that lets us look at how our swarm is scheduling containers.

サービスは ``docker-compose.yml`` に追加するだけであり、とても簡単です。まず、swarm でコンテナのスケジューリングを調べるために、自由に使える可視化サービスを追加しましょう。

..    Open up docker-compose.yml in an editor and replace its contents with the following. Be sure to replace username/repo:tag with your image details.

1. エディタで ``docker-compose.yml`` を開き、内容を以下の通りに書き換えます。 ``username/repo:tag`` の部分は、皆さんのイメージにあわせてください。

.. code-block:: yalm

   version: "3"
   services:
     web:
       # username/repo:tag は皆さんの名前とイメージにあわせて書き換えます
       image: username/repo:tag
       deploy:
         replicas: 5
         restart_policy:
           condition: on-failure
         resources:
           limits:
             cpus: "0.1"
             memory: 50M
       ports:
         - "80:80"
       networks:
         - webnet
     visualizer:
       image: dockersamples/visualizer:stable
       ports:
         - "8080:8080"
       volumes:
         - "/var/run/docker.sock:/var/run/docker.sock"
       deploy:
         placement:
           constraints: [node.role == manager]
       networks:
         - webnet
   networks:
     webnet:

..    The only thing new here is the peer service to web, named visualizer. You’ll see two new things here: a volumes key, giving the visualizer access to the host’s socket file for Docker, and a placement key, ensuring that this service only ever runs on a swarm manager – never a worker. That’s because this container, built from an open source project created by Docker, displays Docker services running on a swarm in a diagram.

新しく追加したのは ``visualizer`` という名前の ``web`` と対となるサービスです。そして、ここでは新しい２つのものがあります。１つはキー ``volumes`` であり、ビジュアライザが Docker ホスト側のソケットファイルにアクセスするためです。それと、 ``placement`` キーはサービスが swarm マネージャのみでしか動作しないよう指定しています。ワーカーでは決して動きません。これは `Docker によって作られたオープンソース・プロジェクト <https://github.com/ManoMarks/docker-swarm-visualizer>`_ であり、 swarm 上で実行している Docker サービスを図で表示するものです。

..    We’ll talk more about placement constraints and volumes in a moment.

placment 制限（constraint）とボリュームの詳細は後述します。

..    Copy this new docker-compose.yml file to the swarm manager, myvm1:

2. 新しい ``docker-compose.yml`` を swarm マネージャ ``myvm1`` にコピーします。

.. code-block:: bash

   docker-machine scp docker-compose.yml myvm1:~

..    Re-run the docker stack deploy command on the manager, and whatever services need updating will be updated:

3. マネージャ上で ``docker stack deploy`` コマンドを再度実行し、更新が必要なサービスはアップデートが始まります。

.. code-block:: bash

   $ docker-machine ssh myvm1 "docker stack deploy -c docker-compose.yml getstartedlab"
   Updating service getstartedlab_web (id: angi1bf5e4to03qu9f93trnxm)
   Updating service getstartedlab_visualizer (id: l9mnwkeq2jiononb5ihz9u7a4)

..    Take a look at the visualizer.

4. ビジュアライザを確認します。

..    You saw in the Compose file that visualizer runs on port 8080. Get the IP address of one of your nodes by running docker-machine ls. Go to either IP address at port 8080 and you will see the visualizer running:

Compose ファイルにあった ``visualizer`` はポート 8080 で動作します。 ``docker-machine ls`` を実行して、実行中のノードの IP アドレス１つを確認します。いずれかの IP アドレスの１つのポート 8080 を開くと、ビジュアライザの動作を確認できます。

..    Visualizer screenshot

（スクリーンショット；todo）

..    The single copy of visualizer is running on the manager as you expect, and the 5 instances of web are spread out across the swarm. You can corroborate this visualization by running docker stack ps <stack>:

期待した通り、マネージャ上では ``visualizer`` のコピーが動作し、 ``web`` の５つのインスタンスは swarm 全体に展開しています。図の内容が正しいかどうかを確認するには、 ``docker stack ps <stack>`` を実行します。

.. code-block:: bash

   docker-machine ssh myvm1 "docker stack ps getstartedlab"

..    The visualizer is a standalone service that can run in any app that includes it in the stack. It doesn’t depend on anything else. Now let’s create a service that does have a dependency: the Redis service that will provide a visitor counter.

ビジュアライザはスタンドアローンのサービスのため、スタック上のあらゆるサービスと実行できます。また、その他のものと依存関係はありません。次は依存関係を *持つ* サービスを作成しましょう。Redis サービスは来訪者カウンタ機能を提供します。

.. Persist the data

.. _persist-the-data:

データの保持
====================

.. Let’s go through the same workflow once more to add a Redis database for storing app data.

同じワークフローを通して、今度はアプリのデータを保管する Redis データベースを追加しましょう。

..    Save this new docker-compose.yml file, which finally adds a Redis service. Be sure to replace username/repo:tag with your image details.

1. 末尾に Redis サービスを追加した、新しい ``docker-compose.yml`` ファイルを保存します。ただし、 ``username/repo:tag`` は皆さんのイメージに置き換えてください。

.. code-block:: yalm

   version: "3"
   services:
     web:
       # username/repo:tag は皆さんの名前とイメージに置き換えてください
       image: username/repo:tag
       deploy:
         replicas: 5
         restart_policy:
           condition: on-failure
         resources:
           limits:
             cpus: "0.1"
             memory: 50M
       ports:
         - "80:80"
       networks:
         - webnet
     visualizer:
       image: dockersamples/visualizer:stable
       ports:
         - "8080:8080"
       volumes:
         - "/var/run/docker.sock:/var/run/docker.sock"
       deploy:
         placement:
           constraints: [node.role == manager]
       networks:
         - webnet
     redis:
       image: redis
       ports:
         - "6379:6379"
       volumes:
         - ./data:/data
       deploy:
         placement:
           constraints: [node.role == manager]
       networks:
         - webnet
   networks:
     webnet:


..     Redis has an official image in the Docker library and has been granted the short image name of just redis, so no username/repo notation here. The Redis port, 6379, has been pre-configured by Redis to be exposed from the container to the host, and here in our Compose file we expose it from the host to the world, so you can actually enter the IP for any of your nodes into Redis Desktop Manager and manage this Redis instance, if you so choose.

Redis は Docker ライブラリ内に公式イメージがあるため、 ``image`` 名にあたる部分は ``redis`` のみに省略できます。そのため、ここでは ``ユーザ名/リポジトリ名`` を明示する必要はありません。Redis では予め Redis 用にホスト側のポート 6379 をコンテナに対して公開するよう指定済みです。そのため、この Compose ファイルでは、クラスタ上のどこかのホスト上でポートを公開するのを指定するだけです。そのため、 Redis Desktop Manager で Redis インスタンスを管理するには、実際にはノード上のいずれかの IP アドレスを指定するだけで構いません。

..    Most importantly, there are a couple of things in the redis specification that make data persist between deployments of this stack:

最も重要なのは、このスタックに ``redis`` をデプロイするにあたり、データの保存を指定している箇所が２つあります。

..        redis always runs on the manager, so it’s always using the same filesystem.
        redis accesses an arbitrary directory in the host’s file system as /data inside the container, which is where Redis stores data.

* ``redis`` は常にマネージャ上で動作し、常に同じファイルシステムを使用する
* ``redis`` は Redis のデータ保管用に、ホスト側ファイルシステム上の外部ディレクトリを、コンテナ内から ``/data`` としてアクセスする

..    Together, this is creating a “source of truth” in your host’s physical filesystem for the Redis data. Without this, Redis would store its data in /data inside the container’s filesystem, which would get wiped out if that container were ever redeployed.

同時に、ここで Redis データを「実際に保存」するのは、ホスト側の物理ファイルシステム上です。この指定がなければ、Redis はコンテナのファイルシステム内にある ``/data`` へデータを保管しようとするため、データを取り出すことができず、コンテナの再デプロイを行えなくなってしまいます。

..    This source of truth has two components:

実際のデータ保管には２つのコンポーネントが関わります。

..        The placement constraint you put on the Redis service, ensuring that it always uses the same host.
        The volume you created that lets the container access ./data (on the host) as /data (inside the Redis container). While containers come and go, the files stored on ./data on the specified host will persist, enabling continuity.

* Redis サービスを置く場所は、同一ホスト上を用いる制約を設けます
* 作成したボリュームには、コンテナは（ホスト上の） ``./data`` を（Redis コンテナ内では） ``/data`` としてアクセスします。コンテナが稼働後は、ホスト上に指定した ``./data`` にファイルが保管され続けます。

..    You are ready to deploy your new Redis-using stack.

これで Redis を使う新しいスタックをデプロイする準備が整いました。

..    Create a ./data directory on the manager:

2. マネージャ上で ``./data`` ディレクトリを作成

.. code-block:: bash

   $ docker-machine ssh myvm1 "mkdir ./data"

..    Copy over the new docker-compose.yml file with docker-machine scp:

3. ``docker-machine scp`` で新しい ``docker-compose.yml`` ファイルをコピー

.. code-block:: bash

   $ docker-machine scp docker-compose.yml myvm1:~

..    Run docker stack deploy one more time.

4. ``docker stack deploy`` をもう一度実行

.. code-block:: bash

   $ docker-machine ssh myvm1 "docker stack deploy -c docker-compose.yml getstartedlab"

..    Check the web page at one of your nodes (e.g. http://192.168.99.101) and you’ll see the results of the visitor counter, which is now live and storing information on Redis.

5. ノードいずれかのウェブページを確認し（例： ``http://192.168.99.101`` ）、来訪者カウンタの動作を確認します。ここで表示されるデータは Redis で保管されたものです。

..    Hello World in browser with Redis

（Todo；図、ブラウザで Redis 対応 Hello World を確認）


..    Also, check the visualizer at port 8080 on either node’s IP address, and you’ll see the redis service running along with the web and visualizer services.

また、他のノードの IP アドレスでポート 8080 を開き、ビジュアライザを確認します。そうしますと、 ``web`` と ``visualizer`` サービスと同様に、 `redis``` サービスが動いているのが分かります。

..    Visualizer with redis screenshot

（ToDo;VirualizerでRedisを確認するスクリーンショット）


.. On to Part 6 »

* :doc:`Part 6 へ <part6>`

.. Recap (optional)

まとめ（オプション）
====================

.. Here’s a terminal recording of what was covered on this page:

`このページで扱ったターミナルの録画 <https://asciinema.org/a/113840>`_ がこちらです。

.. You learned that stacks are inter-related services all running in concert, and that – surprise! – you’ve been using stacks since part three of this tutorial. You learned that to add more services to your stack, you insert them in your Compose file. Finally, you learned that by using a combination of placement constraints and volumes you can create a permanent home for persisting data, so that your app’s data survives when the container is torn down and redeployed.

以上、スタックとは内部で連携するサービスがすべて協調動作するものと学びました。皆さんは既にチュートリアルの Part 3 からスタックを使っていたのです。つまり「すごーい！」　スタック上へのサービス追加とは Compose ファイルへの追加と学んでいます。そして、どこで動かすのかという制約（constraint）と、作成したデータを保存し続ける場所としてのボリュームについて学びました。ですから、コンテナが停止して再デプロイしたとしても、アプリのデータは残り続けるのです。

