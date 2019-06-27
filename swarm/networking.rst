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

.. Docker Swarm is fully compatible with Docker's networking features. This
   includes the multi-host networking feature which allows creation of custom
   container networks that span multiple Docker hosts.

Docker Swarm は Docker のネットワーク機能と完全に互換性があります。
マルチホストによるネットワーク機能も含みます。
これは複数の Docker ホストにわたっての独自のコンテナ・ネットワークを生成できるものです。

.. Before using Swarm with a custom network, read through the conceptual
   information in [Docker container
   networking](/engine/userguide/networking/).
   You should also have walked through the [Get started with multi-host
   networking](/engine/userguide/networking/get-started-overlay/)
   example.

独自のネットワークに対して Swarm を使うには、:doc:`Docker コンテナのネットワーク </engine/userguide/networking/index>` についての概念を一通り読んでおいてください。
また :doc:`マルチホストネットワークをはじめよう </engine/userguide/networking/get-started-overlay>` の例を試しておくことも必要でしょう。

.. ## Create a custom network in a Swarm cluster

.. _create-a-custom-network-in-a-swarm-cluster:

Swarm クラスタにおける独自ネットワークの生成
==================================================

.. Multi-host networks require a key-value store. The key-value store holds
   information about the network state which includes discovery, networks,
   endpoints, IP addresses, and more. Through the Docker's libkv project, Docker
   supports Consul, Etcd, and ZooKeeper key-value store backends. For details about
   the supported backends, refer to the [libkv
   project](https://github.com/docker/libkv).

マルチホストネットワークでは、キーバリューを保存するストア（store）が必要になります。
このキーバリューストアは、ネットワークの状態を表わす情報を保持するものであり、ネットワーク検出、ネットワーク自体の情報、エンドポイント、IP アドレスなどの情報があります。
Docker の libkv プロジェクトを通じて、Docker では Consul、Etcd、ZooKeeper といったキーバリューストアバックエンドがサポートされます。
サポートしているこのバックエンドの詳細は `libkv プロジェクト <https://github.com/docker/libkv>`_ を参照してください。

.. To create a custom network, you must choose a key-value store backend and
   implement it on your network. Then, you configure the Docker Engine daemon to
   use this store. Two required parameters,  `--cluster-store` and
   `--cluster-advertise`, refer to your key-value store server.

独自のネットワークを生成するには、キーバリューストアバックエンドを 1 つ選んで、ネットワーク上に実装する必要があります。
そして Docker Engine デーモンにおいて、このストアを利用する設定を行います。
設定の際には 2 つのパラメータ、``--cluster-store``, ``--cluster-advertise`` を使って、キーバリューストアの存在するサーバを指定します。

.. Once you've configured and restarted the daemon on each Swarm node, you are
   ready to create a network.

Swarm の各ノード上にてデーモンの設定と再起動を行えば、ネットワークを生成できるようになります。

.. ## List networks

.. _list-networks:

ネットワークの一覧確認
=======================

.. This example assumes there are two nodes `node-0` and `node-1` in the cluster.
   From a Swarm node, list the networks:

以下の例では、クラスタ内に 2 つのノード ``node-0``、``node-1`` があるとします。
Swarm ノードからネットワーク一覧を確認します。

.. ```bash
   $ docker network ls
   NETWORK ID          NAME                   DRIVER
   3dd50db9706d        node-0/host            host
   09138343e80e        node-0/bridge          bridge
   8834dbd552e5        node-0/none            null
   45782acfe427        node-1/host            host
   8926accb25fd        node-1/bridge          bridge
   6382abccd23d        node-1/none            null
   ```

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

上に示すように、各ネットワーク名の先頭にはノード名がつきます。

.. ## Create a network

.. _create-a-network:

ネットワークの作成
====================

.. By default, Swarm is using the `overlay` network driver, a global-scope network
   driver. A global-scope network driver creates a network across an entire Swarm cluster.
   When you create an `overlay` network under Swarm, you can omit the `-d` option:

デフォルトで Swarm は、グローバルなスコープを持つネットワークドライバ ``overlay`` を用います。
グローバルスコープのネットワークドライバは、Swarm クラスタ全体にわたるネットワークを生成します。
Swarm のもとで ``overlay`` ネットワークを生成する場合、``-d`` オプションは省略できます。

.. ```bash
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
   ```

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

.. As you can see here, both the `node-0/swarm_network` and the
   `node-1/swarm_network` have the same ID.  This is because when you create a
   network on the cluster, it is accessible from all the nodes.

上に示されるように ``node-0/swarm_network`` と ``node-1/swarm_network`` は同じ ID を持ちます。
クラスタ上にネットワークを生成すると、ノードすべてがアクセス可能になるわけです。

.. To create a local scope network (for example with the `bridge` network driver) you
   should use `<node>/<name>` otherwise your network is created on a random node.

ローカルなスコープのネットワークを（たとえば ``bridge`` ネットワークドライバを利用して）生成する場合は、``<node>/<name>`` という記述を行う必要があります。
こうしないと、ネットワークがランダムに選び出されたノード上に生成されてしまいます。

.. ```bash
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
   ```

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

.. `--opt encrypted` is a feature only available in Docker Swarm mode. It's not supported in Swarm standalone.
   Network encryption requires key management, which is outside the scope of Swarm.

``--opt encrypted`` は Docker Swarm モードにおいてのみ利用可能な機能です。
これはスタンドアロンの Swarm ではサポートされていません。
ネットワークの暗号化には鍵の管理機能が必要で、これは Swarm の機能範囲には含まれません。

.. ## Remove a network

ネットワークの削除
====================

.. To remove a network you can use its ID or its name. If two different networks
   have the same name, include the `<node>` value:

ネットワークを削除するときは、ネットワーク ID かネットワーク名を用いた指定を行います。
2 つの異なるネットワークが同一名である場合は、``<node>`` の記述を含めてください。

.. ```bash
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
   ```

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

.. The `swarm_network` was removed from every node. The `bridge2` was removed only
   from `node-0`.

``swarm_network`` が全ノードから削除されました。
また ``bridge2`` は ``node-0`` からのみ削除されました。

.. ## Docker Swarm documentation index

Docker Swarm ドキュメントの例
==============================

.. - [Docker Swarm overview](index.md)
   - [Scheduler strategies](scheduler/strategy.md)
   - [Scheduler filters](scheduler/filter.md)
   - [Swarm API](swarm-api.md)

* :doc:`Docker Swarm 概要 <index>`
* :doc:`スケジュール・ストラテジ <scheduler/strategy>`
* :doc:`スケジュール・フィルタ <scheduler/filter>`
* :doc:`Swarm API <swarm-api>`

.. seealso:: 

   Swarm and container networks
      https://docs.docker.com/swarm/networking/
