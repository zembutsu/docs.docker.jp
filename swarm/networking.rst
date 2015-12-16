.. https://docs.docker.com/swarm/networking/
.. doc version: 1.9
.. check date: 2015/12/16

.. Networking

==============================
ネットワーキング
==============================

.. Docker Swarm is fully compatible for the new networking model added in docker 1.9

Docker Swarm は Docker 1.9 で追加された新しいネットワーキング・モデルと完全に互換性があります。

.. Setup

セットアップ
====================

.. To use multi-host networking you need to start your docker engines with --cluster-store and --cluster-advertise as indicated in the docker engine docs.

マルチホスト・ネットワーキングを使うには、Docker エンジンを ``--cluster-store``  と ``--cluster-advertise`` のオプションをドキュメントが示すように付けて起動する必要があります。

.. List networks

ネットワークの一覧
--------------------

.. This example assumes there are two nodes node-0 and node-1 in the cluster.

次の例は、クラスタ上に２のノード ``node-1`` と ``node-1`` があるものとします。

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

このように、各ネットワーク名の接頭語がノード名になっています。

.. Create a network 

ネットワークの作成
====================

.. By default, swarm is using the overlay network driver, a global scope driver.

デフォルトでは、Swarm はネットワーク全体を範囲とする ``overlay`` ネットワーク・ドライバを使います。

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


.. As you can see here, the ID is the same on the two nodes, because it’s the same network.

ここで表示されているように、２つのノード上に同じ ID があります。これは同じネットワークだからです。

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
   921817fefea5        node-0/bridge2         brige
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
* :doc:`Swarm API </swarm/api/swarm-api>`
