.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/swarm/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/swarm.md
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/swarm.md
.. check date: 2016/04/28
.. Commits on Mar 24, 2016 d1ea4d72ac81aa7bda7384ce6ee80a6fc6d62de8
.. -------------------------------------------------------------------

.. Using Compose with Swarm

.. _using-compose-with-swarm:

==============================
Swarm で Compose を使う
==============================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Docker Compose and Docker Swarm aim to have full integration, meaning you can point a Compose app at a Swarm cluster and have it all just work as if you were using a single Docker host.

Docker Compose と :doc:`Docker Swarm </swarm/overview>` は完全な統合を目指しています。つまり、Compose アプリケーションを Swarm クラスタに適用したら、単一の Docker ホスト上で展開するのと同じように動作します。

.. The actual extent of integration depends on which version of the Compose file format you are using:

使用する :ref:`Compose ファイル形式のバージョン <compose-file-versioning>` によって、統合できる範囲が異なります。

..     If you’re using version 1 along with links, your app will work, but Swarm will schedule all containers on one host, because links between containers do not work across hosts with the old networking system.

1. バージョン１で ``links`` （リンク機能）を使う場合、アプリケーションは動作します。しかし、Swarm は全てのコンテナを１つのホスト上にスケジュールします。これは古いネットワーキング・システム上ではホストを横断したコンテナが扱えないためです。

..    If you’re using version 2, your app should work with no changes:

2. バージョン２であれば、アプリケーションを変更しなくても動作するでしょう。

..        subject to the limitations described below,

* 主な :ref:`制限 <compose-limitations>` については以下をご覧ください。

..        as long as the Swarm cluster is configured to use the overlay driver, or a custom driver which supports multi-host networking.

* Swarm では :ref:`オーバレイ・ドライバ <an-overlay-network>` の設定や、マルチホスト・ネットワーク機能をサポートするカスタム・ドライバが利用可能です。

.. Read the Getting started with multi-host networking to see how to set up a Swarm cluster with Docker Machine and the overlay driver. Once you’ve got it running, deploying your app to it should be as simple as:

:doc:`Docker Machine </machine/overview>` で Swarm クラスタやオーバレイ・ドライバをセットアップする方法は、 :doc:`/engine/userguide/networking/get-started-overlay` をご覧ください。セットアップ後にアプリケーションをデプロイするには、次のように非常にシンプルです。

.. code-block:: bash

   $ eval "$(docker-machine env --swarm <name of swarm master machine>)"
   $ docker-compose up

.. Limitations

.. _compose-limitations:

Compose の制限
====================

.. Building images

.. building-images:

イメージ構築
--------------------

.. Swarm can build an image from a Dockerfile just like a single-host Docker instance can, but the resulting image will only live on a single node and won’t be distributed to other nodes.

Dockerfile を使ったイメージ構築は、Swarm 上では単一ホスト上でしか行えません。そのため、構築したイメージは対象のホスト上のみに存在しており、他のノードに配布できません。

.. If you want to use Compose to scale the service in question to multiple nodes, you’ll have to build it yourself, push it to a registry (e.g. the Docker Hub) and reference it from docker-compose.yml:

Compose を複数のノードにスケールさせる課題がある時は、自分自身で構築したレジストリ（例： Docker Hub）にイメージを push し、 ``docker-compose.yml`` で参照させてください。

.. code-block:: bash

   $ docker build -t myusername/web .
   $ docker push myusername/web
   
   $ cat docker-compose.yml
   web:
     image: myusername/web
   
   $ docker-compose up -d
   $ docker-compose scale web=3

.. Multiple dependencies

.. _multiple-dependencies:

複数の依存関係
--------------------

.. If a service has multiple dependencies of the type which force co-scheduling (see Automatic scheduling below), it’s possible that Swarm will schedule the dependencies on different nodes, making the dependent service impossible to schedule. For example, here foo needs to be co-scheduled with bar and baz:

サービスが強制共用スケジューリング（force co-scheduling）型で複数の依存関係がある場合（以下の :ref:`automatic-scheduling` をご覧ください）、 Swarm は異なったノード上でも依存関係を解決できるかもしれません。たとえば、以下の例では ``foo`` が必要とする ``bar`` と ``baz`` を一緒にスケジュールします。

.. code-block:: yaml

   version: "2"
   services:
     foo:
       image: foo
       volumes_from: ["bar"]
       network_mode: "service:baz"
     bar:
       image: bar
     baz:
       image: baz

.. The problem is that Swarm might first schedule bar and baz on different nodes (since they’re not dependent on one another), making it impossible to pick an appropriate node for foo.

問題は、Swarm が最初に ``bar`` と ``baz`` が別のノードにスケジュールしてしまう可能性です（この時点ではお互いの依存性はありません）。そうならないように、 ``foo`` を適切なノードに置く必要があります。

.. To work around this, use manual scheduling to ensure that all three services end up on the same node:

正常に行うためには、 :ref:`manual-scheduling` で、３つのサービスを同じノード上で確実に起動します。

.. code-block:: bash

   version: "2"
   services:
     foo:
       image: foo
       volumes_from: ["bar"]
       network_mode: "service:baz"
       environment:
         - "constraint:node==node-1"
     bar:
       image: bar
       environment:
         - "constraint:node==node-1"
     baz:
       image: baz
       environment:
         - "constraint:node==node-1"

.. Host ports and recreating containers

.. _host-ports-and-creating-containers:

ホスト側のポートとコンテナの再作成
----------------------------------------

.. If a service maps a port from the host, e.g. 80:8000, then you may get an error like this when running docker-compose up on it after the first time:

サービスがホスト側のポートを ``80:8000`` のように割り当てる（マップする）場合があります。それが ``docker-compose up`` の初回実行時であればエラーが出るかもしれません。

.. code-block:: bash

   docker: Error response from daemon: unable to find a node that satisfies
   container==6ab2dfe36615ae786ef3fc35d641a260e3ea9663d6e69c5b70ce0ca6cb373c02.

.. The usual cause of this error is that the container has a volume (defined either in its image or in the Compose file) without an explicit mapping, and so in order to preserve its data, Compose has directed Swarm to schedule the new container on the same node as the old container. This results in a port clash.

エラーが発生する一般的なケースは、明確な割り当てのない（ イメージや Compose ファイルで定義されていない）ボリュームを持つコンテナを作成する場合です。その場合はデータ領域を予約するために、Compose は Swarm に対して、前に起動したコンテナと同じノード上に新しいコンテナをスケジュールします。この結果、ポートが衝突してしまう可能性があります。

.. There are two viable workarounds for this problem:

この問題に対処する２つの解決策があります。

..    Specify a named volume, and use a volume driver which is capable of mounting the volume into the container regardless of what node it’s scheduled on.

* コンテナがボリュームをマウントできるボリューム・ドライバを使えば、ボリュームに名前を指定することで、コンテナがどのノードにスケジュールされても適切にマウントします。

..    Compose does not give Swarm any specific scheduling instructions if a service uses only named volumes.

Compose でサービスのボリュームに名前を付けるだけでは、Swarm に対してスケジューリングの指示を出しません。

.. code-block:: yaml

   version: "2"
   
   services:
     web:
       build: .
       ports:
         - "80:8000"
       volumes:
         - web-logs:/var/log/web
   
   volumes:
     web-logs:
       driver: custom-volume-driver

..     Remove the old container before creating the new one. You will lose any data in the volume.

* 新しいコンテナを作成する前に、古いコンテナを削除したら、ボリュームの中のデータが失われます。

.. code-block:: bash

   $ docker-compose stop web
   $ docker-compose rm -f web
   $ docker-compose up web

.. Scheduling containers

.. _compose-scheduling-containers:

コンテナのスケジューリング
==============================

.. Automatic scheduling

.. _automatic-scheduling:

自動スケジューリング
------------------------------

.. Some configuration options will result in containers being automatically scheduled on the same Swarm node to ensure that they work correctly. These are:

コンテナを同じ Swarm ノード上に確実にスケジュールするための、複数のオプションがあります。オプションは次の通りです。

..    network_mode: "service:..." and network_mode: "container:..." (and net: "container:..." in the version 1 file format).

* ``network_mode: "service:..."`` と、 ``network_mode: "container:..."`` （と、バージョン１のフォーマットであれば ``net: "container:..."`` ）

..    volumes_from

* ``volumes_from``

..    links

* ``links``

.. Manual scheduling

.. _manual-scheduling:

手動スケジューリング
--------------------

.. Swarm offers a rich set of scheduling and affinity hints, enabling you to control where containers are located. They are specified via container environment variables, so you can use Compose’s environment option to set them.

Swarm にはコンテナをどこに配置するかを制御できるようにするための、豊富なスケジューリング群と親和性の示唆（affinity hint；アフィニティ・ヒント）があります。これらはコンテナの環境を通して指定可能です。Compose では ``environment`` オプションを使って設定できます。

.. code-block:: yaml

   # 特定のノードにコンテナをスケジュールする
   environment:
     - "constraint:node==node-1"
   
   # 「storage」ラベルに「ssd」が設定されているノードにコンテナをスケジュールする
   environment:
     - "constraint:storage==ssd"
   
   # 「redis」イメージをダウンロード済みのコンテナにスケジュールする
   environment:
     - "affinity:image==redis"
   
.. For the full set of available filters and expressions, see the Swarm documentation.

利用可能なフィルタと表現については、:doc:`Swarm のドキュメント </swarm/scheduler/filter>` をご覧ください。

.. seealso:: 

   Using Compose with Swarm
      https://docs.docker.com/compose/swarm/

