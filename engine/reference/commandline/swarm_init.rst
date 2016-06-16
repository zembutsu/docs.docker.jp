.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/swarm_init/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/swarm_init.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/swarm_init.md
.. check date: 2016/06/16
.. Commits on Jun 14, 2016 9acf97b72a4d5ff7b1bcad36fb19b53775f01596
.. -------------------------------------------------------------------

.. Warning: this command is part of the Swarm management feature introduced in Docker 1.12, and might be subject to non backward-compatible changes.

.. warning::

  このコマンドは Docker 1.12 で導入された Swarm 管理機能の一部です。それと、変更は下位互換性を考慮していない可能性があります。

.. swarm init

=======================================
swarm init
=======================================

.. code-block:: bash

   使い方:  docker swarm init [オプション]
   
   Swarm を初期化
   
   オプション:
         --auto-accept value   受け入れ可能なポリシー (デフォルト [worker,manager])
         --force-new-cluster   現状で、強制的に新しいクラスタを作成
         --help                使い方の表示
         --listen-addr value   リッスンするアドレス (デフォルト 0.0.0.0:2377)
         --secret string       ノードがクラスタ参加時に必要なシークレット値を設定

.. Initialize a Swarm cluster. The docker engine targeted by this command becomes a manager in the newly created one node Swarm cluster.

Swarm クラスタを初期化します。このコマンドを実行する Docker Engine は、直近に作成した Swarm クラスタ上のマネージャ（manager）になります。

.. code-block:: bash

   $ docker swarm init --listen-addr 192.168.99.121:2377
   Initializing a new swarm
   $ docker node ls
   ID              NAME          STATUS  AVAILABILITY/MEMBERSHIP  MANAGER STATUS  LEADER
   3l1f6uzcuoa3 *  swarm-master  READY   ACTIVE                   REACHABLE       Yes

``--auto-accept`` 値
------------------------------

.. This flag controls node acceptance into the cluster. By default, both worker and manager nodes are auto accepted by the cluster. This can be changed by specifing what kinds of nodes can be auto-accepted into the cluster. If auto-accept is not turned on, then node accept can be used to explicitly accept a node into the cluster.

このフラグはクラスタに受け入れるノードを制御します。デフォルトではクラスタが自動的にノードを受け入れる ``worker`` と ``manager`` ノードです。クラスタでどのようなノードを自動的に受け入れるかは、変更可能です。自動受け入れを有効にした場合は、それ以外のノードをクラスタに追加するために :doc:`node accept <node_accept>` を使います。

.. For example, the following initializes a cluster with auto-acceptance of workers, but not managers

次の例は、 worker を自動受け入れしますが manager は受け入れないようクラスタを初期化します。

.. code-block:: bash

   $ docker swarm init --listen-addr 192.168.99.121:2377 --auto-accept worker
   Initializing a new swarm

``--force-new-cluster``
------------------------------

.. This flag forces an existing node that was part of a quorum that was lost to restart as a single node Manager without losing its data

このフラグは既存のノードでクォーラムを強制的に構成します。１つのノード・マネージャがデータを持っていたとしても、再構成によってデータを失います。

``--listen-addr value``
------------------------------

.. The node listens for inbound Swarm manager traffic on this IP:PORT

Swarm マネージャからのインバウンド通信をリッスンするための、ノードの IP:PORT を指定します。

``--secret string``
--------------------

.. Secret value needed to accept nodes into the Swarm

ノードが Swarm に受け入れられるために必要なシークレット値です。


関連情報
----------

* :doc:`swarm_join`
* :doc:`swarm_leave`
* :doc:`swarm_update`

.. seealso:: 

   swarm init
      https://docs.docker.com/engine/reference/commandline/swarm_init/

