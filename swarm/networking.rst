.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/swarm/networking/
.. SOURCE: https://github.com/docker/swarm/blob/master/docs/networking.md
   doc version: 1.11
      https://github.com/docker/swarm/commits/master/docs/networking.md
.. check date: 2016/04/29
.. Commits on Mar 4, 2016 4b8ed91226a9a49c2acb7cb6fb07228b3fe10007
.. -------------------------------------------------------------------

.. Swarm and container networks

.. _swarm-and-container-networks:

==============================
Swarm とコンテナのネットワーク
==============================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Docker Swarm is fully compatible with Docker’s networking features. This includes the multi-host networking feature which allows creation of custom container networks that span multiple Docker hosts.

Docker Swarm は Docker のネットワーク機能と完全な互換性があります。互換性の中には複数のホストに対するマルチホスト・ネットワーク機能も含まれます。これは複数の Docker ホストを横断するカスタム・コンテナ・ネットワークを作成する機能です。

.. Before using Swarm with a custom network, read through the conceptual information in Docker container networking. You should also have walked through the Get started with multi-host networking example.

Swarm をカスタム・ネットワークで使う前に、:doc:`Docker コンテナ・ネットワーク </engine/userguide/networking/dockernetworks>` の概念に関する情報をお読みください。また、 :doc:`/engine/userguide/networking/get-started-overlay` のサンプルも試すべきでしょう。

.. Create a custom network in a Swarm cluster

.. _create-a-custom-network-in-a-swarm-cluster:

Swarm クラスタにカスタム・ネットワークを作成
==================================================

.. Multi-host networks require a key-value store. The key-value store holds information about the network state which includes discovery, networks, endpoints, IP addresses, and more. Through the Docker’s libkv project, Docker supports Consul, Etcd, and ZooKeeper key-value store backends. For details about the supported backends, refer to the libkv project.

マルチホスト・ネットワーク機能を使うにはキーバリュー・ストアが必要です。キーバリュー・ストアはネットワークの情報を保持する場所です。ここにはディスカバリ情報、ネットワーク、エンドポイント、 IP アドレス等が含まれます。Docker の libkv プロジェクトの成果により、Docker は Consul 、Etcd 、ZooKeeper の各キーバリュー・ストア・バックエンドをサポートします。詳細は `libkv プロジェクト <https://github.com/docker/libkv>`_ をご覧ください。

.. To create a custom network, you must choose a key-value store backend and implement it on your network. Then, you configure the Docker Engine daemon to use this store. Two required parameters, --cluster-store and --cluster-advertise, refer to your key-value store server.

カスタム・ネットワークを作成するには、キーバリュー・ストア・バックエンドを選択し、自分のネットワーク上に実装する必要があります。それから、Docker Engine デーモンの設定を変更し、キーバリュー・ストアにデータを保管できるようにします。キーバリュー・ストア用のサーバを参照するには ``--cluster-store`` と ``--cluster-advertise`` という２つのパラメータが必要です。

.. Once you’ve configured and restarted the daemon on each Swarm node, you are ready to create a network.

Swarm の各ノード上にあるデーモンの設定変更・再起動を行えば、ネットワーク作成の準備が整います。

.. List networks

.. _list-networks:

ネットワークの一覧
====================

.. This example assumes there are two nodes node-0 and node-1 in the cluster. From a Swarm node, list the networks:

以下は、クラスタ上に２のノード ``node-0`` と ``node-1`` がある場合の例です。Swarm ノードからネットワーク一覧を表示しています。

.. code-block:: bash

   $ docker network ls
   NETWORK ID          NAME                   DRIVER
   3dd50db9706d        node-0/host            host
   09138343e80e        node-0/bridge          bridge
   8834dbd552e5        node-0/none            null
   45782acfe427        node-1/host            host
   8926accb25fd        node-1/bridge          bridge
   6382abccd23d        node-1/none            null

.. As you can see, each network name is prefixed by the node name.

このように、各ネットワーク名の接頭語がノード名になっていることが分かります。

.. Create a network 

.. _create-a-network:

ネットワークの作成
====================

.. By default, swarm is using the overlay network driver, a global scope driver. A global-scope network driver creates a network across an entire Swarm cluster. When you create an overlay network under Swarm, you can omit the -d option:

デフォルトの Swarm クラスタは、ネットワーク全体を範囲とする ``overlay`` ネットワーク・ドライバを使います。ネットワーク全体を範囲とするドライバを使えば、Swarm クラスタ全体を横断するネットワークを作成できます。Swarm で ``overlay`` ネットワーク作成時は ``-d`` オプションを省略できます。

.. code-block:: bash

   $ docker network create swarm_network
   42131321acab3233ba342443Ba4312
   $ docker network ls
   NETWORK ID          NAME                   DRIVER
   3dd50db9706d        node-0/host            host
   09138343e80e        node-0/bridge          bridge
   8834dbd552e5        node-0/none            null
   42131321acab        node-0/swarm_network   overlay
   45782acfe427        node-1/host            host
   8926accb25fd        node-1/bridge          bridge
   6382abccd23d        node-1/none            null
   42131321acab        node-1/swarm_network   overlay

.. As you can see here, both the node-0/swarm_network and the node-1/swarm_network have the same ID. This is because when you create a network on the cluster, it is accessible from all the nodes.

ここで表示されているように、２つのノード上に ``node-0/swarm_network`` と ``node-1/swarm_network`` という同じ ID を持つネットワークがあります。これはクラスタに作成したネットワークであり、全てのノード上でアクセス可能なものです。

.. If you want to want to create a local scope network (for example with the bridge driver) you should use <node>/<name> otherwise your network will be created on a random node.

ローカルな範囲でネットワークを作成したい場合は（例えば、ブリッジ・ドライバを使いたい時）、 ``<ノード名>/<名前>`` の形式でなければ、ランダムに選んだノード上でネットワークを作成します。

.. code-block:: bash

   $ docker network create node-0/bridge2 -b bridge
   921817fefea521673217123abab223
   $ docker network create node-1/bridge2 -b bridge
   5262bbfe5616fef6627771289aacc2
   $ docker network ls
   NETWORK ID          NAME                   DRIVER
   3dd50db9706d        node-0/host            host
   09138343e80e        node-0/bridge          bridge
   8834dbd552e5        node-0/none            null
   42131321acab        node-0/swarm_network   overlay
   921817fefea5        node-0/bridge2         bridge
   45782acfe427        node-1/host            host
   8926accb25fd        node-1/bridge          bridge
   6382abccd23d        node-1/none            null
   42131321acab        node-1/swarm_network   overlay
   5262bbfe5616        node-1/bridge2         bridge

.. Remove a network

ネットワークの削除
====================

.. To remove a network you can use its ID or its name. If two different network have the same name, use may use <node>/<name>.

ネットワークの削除は、ネットワーク ID か ネットワーク名を使えます。異なる２つのネットワークが同じ名前の場合は、 ``<ノード名>/<名前>`` を使えます。

.. code-block:: bash

   $ docker network rm swarm_network
   42131321acab3233ba342443Ba4312
   $ docker network rm node-0/bridge2
   921817fefea521673217123abab223
   $ docker network ls
   NETWORK ID          NAME                   DRIVER
   3dd50db9706d        node-0/host            host
   09138343e80e        node-0/bridge          bridge
   8834dbd552e5        node-0/none            null
   45782acfe427        node-1/host            host
   8926accb25fd        node-1/bridge          bridge
   6382abccd23d        node-1/none            null
   5262bbfe5616        node-1/bridge2         bridge

.. swarm_network was removed from every node, bridge2 was removed only from node-0.

``swarm_network``  は各ノードから削除されましたが、 ``bridge2`` は ``node-0`` からのみ削除されました。

.. Docker Swarm documentation index

Docker Swarm ドキュメント目次
==============================

.. 
    User guide
    Scheduler strategies
    Scheduler filters
    Swarm API

* :doc:`ユーザ・ガイド </swarm/index>`
* :doc:`スケジュール・ストラテジ </swarm/scheduler/strategy>`
* :doc:`スケジューラ・フィルタ </swarm/scheduler/filter>`
* :doc:`Swarm API </swarm/swarm-api>`

.. seealso:: 

   Swarm and container networks
      https://docs.docker.com/swarm/networking/
