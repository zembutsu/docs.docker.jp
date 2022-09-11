.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/swarm/join-nodes/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/engine/swarm/join-nodes.md
   doc version: 20.10
.. check date: 2022/04/29
.. Commits on Aug 7, 2021 3b71231970606bb45fd6f37a8c99522583e7f5a8
.. -----------------------------------------------------------------------------

.. Join nodes to a swarm

.. _join-nodes-to-a-swarm:

==================================================
swarm にノードを参加
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. When you first create a swarm, you place a single Docker Engine into swarm mode. To take full advantage of swarm mode you can add nodes to the swarm:

1つめの swarm を作成した後は、単一の Docker Engine 上に swarm モードが動いています。swarm に対してノードを追加し、swarm モードの利点を完全に活かします。

..  Adding worker nodes increases capacity. When you deploy a service to a swarm, the Engine schedules tasks on available nodes whether they are worker nodes or manager nodes. When you add workers to your swarm, you increase the scale of the swarm to handle tasks without affecting the manager raft consensus.

* worker ノードの追加はキャパシティを増やします。サービスを swarm にデプロイ時、worker ノードか manager ノードかに関わらず、Engine は利用可能なノード上にサービスをデプロイします。swarm に worker ノードを追加すると、manager raft 合意による影響を受けることなく、swarm で処理できるタスクの規模を拡大します。

..  Manager nodes increase fault-tolerance. Manager nodes perform the orchestration and cluster management functions for the swarm. Among manager nodes, a single leader node conducts orchestration tasks. If a leader node goes down, the remaining manager nodes elect a new leader and resume orchestration and maintenance of the swarm state. By default, manager nodes also run tasks.

* manager ノードは耐障害性を向上します。manager ノードが処理するのは、 swarm に対するオーケストレーションとクラスタ管理機能です。manager ノード間では、単一のリーダーノード（leader node）がオーケストレーション・タスクを調整します。もしもリーダーノードがダウンすると、残った manager ノードが新しいリーダーを選出（elect）し、オーケストレーションと swarm 状態の維持を再開します。デフォルトでは、 manager ノードでもタスクを実行します。

.. The Docker Engine joins the swarm depending on the join-token you provide to the docker swarm join command. The node only uses the token at join time. If you subsequently rotate the token, it doesn’t affect existing swarm nodes. Refer to Run Docker Engine in swarm mode.

Docker Engine が swarm に参加するには、 ``docker swarm join`` コマンドで得られる **join-token** （参加トークン）に依存します。ノードはこのトークンを参加時のみ使います。トークンが後ほど更新されてしまうと、既存の swarm ノードに参加できなくなります。 :ref:`view-the-join-command-or-update-a-swarm-join-token` をご覧ください。

.. Join as a worker node

.. _join-as-a-worker-node:

worker ノードとして参加
==============================

.. To retrieve the join command including the join token for worker nodes, run the following command on a manager node:

worker ノードに対する参加トークンを含む join コマンドを取得するには、 manager ノード上で以下のコマンドを実行します。

.. code-block:: bash

   $ docker swarm join-token worker
   
   To add a worker to this swarm, run the following command:
   
       docker swarm join \
       --token SWMTKN-1-49nj1cmql0jkz5s954yi3oex3nedyz0fb0xx14ie39trti4wxv-8vxv8rssmk743ojnwacrr2e7c \
       192.168.99.100:2377

.. Run the command from the output on the worker to join the swarm:

swarm に参加する worker 上で、先ほど出力したコマンドを実行します。

.. code-block:: bash

   $ docker swarm join \
     --token SWMTKN-1-49nj1cmql0jkz5s954yi3oex3nedyz0fb0xx14ie39trti4wxv-8vxv8rssmk743ojnwacrr2e7c \
     192.168.99.100:2377
   
   This node joined a swarm as a worker.

.. The docker swarm join command does the following:

``docker swarm join`` コマンドは以下の処理を行います。

..  switches the Docker Engine on the current node into swarm mode.
    requests a TLS certificate from the manager.
    names the node with the machine hostname
    joins the current node to the swarm at the manager listen address based upon the swarm token.
    sets the current node to Active availability, meaning it can receive tasks from the scheduler.
    extends the ingress overlay network to the current node.

* 現在のノード上の Docker Engine を swarm モードに切り替えます
* manager に対して TLS 証明書をリクエストします
* マシンのホスト名をノード名にします
* swarm トークンに基づいて、 manager がリッスンするアドレスにある swarm に、現在のノードを参加します
* 現在のノードを ``Active`` の availability に設定します。つまり、スケジューラからのタスクを受信可能にします
* 現在のノード上に ``ingress`` オーバレイ・ネットワークを拡張します

.. Join as a manager node

.. _join-as-a-manager-node:

manager ノードとして参加
==============================

.. When you run docker swarm join and pass the manager token, the Docker Engine switches into swarm mode the same as for workers. Manager nodes also participate in the raft consensus. The new nodes should be Reachable, but the existing manager remains the swarm Leader.

``docker swarm join`` の実行時に manager トークンを渡すと、Docker Engine は worker モードと同じように swarm モードに切り替わります。また、manager ノードは raft 合意にも参加します。新しいノードは ``Reachable`` （到達可能）になり、既存の manager ノードは swarm ``Leader`` のままです。

.. Docker recommends three or five manager nodes per cluster to implement high availability. Because swarm mode manager nodes share data using Raft, there must be an odd number of managers. The swarm can continue to function after as long as a quorum of more than half of the manager nodes are available.

高可用性を実現するためには、Docker が推奨するのはクラスタごとに3または5つの manager ノードです。swarm モードの manager ノードは Raft を使ってデータを共有するため、manager の数は奇数である必要があります。swarm では manager ノードの半数が利用可能であれば、クォーラム機能を継続できます。

.. For more detail about swarm managers and administering a swarm, see Administer and maintain a swarm of Docker Engines.

swarm マネージャの詳細や swarm の管理については、 :doc:`admin_guide` をご覧ください。

.. To retrieve the join command including the join token for manager nodes, run the following command on a manager node:

manager ノードとして参加するトークンを含む join コマンドを表示するには、manager ノード上で以下のコマンドを実行します。

.. code-block:: bash

   $ docker swarm join-token manager
   
   To add a manager to this swarm, run the following command:
   
       docker swarm join \
       --token SWMTKN-1-61ztec5kyafptydic6jfc1i33t37flcl4nuipzcusor96k7kby-5vy9t8u35tuqm7vh67lrz9xp6 \
       192.168.99.100:2377

.. Run the command from the output on the new manager node to join it to the swarm:

新しい manager ノード上でコマンドの出力を実行し、swarm に参加します。

.. code-block:: bash

   $ docker swarm join \
     --token SWMTKN-1-61ztec5kyafptydic6jfc1i33t37flcl4nuipzcusor96k7kby-5vy9t8u35tuqm7vh67lrz9xp6 \
     192.168.99.100:2377
   
   This node joined a swarm as a manager.

.. Learn More

詳しく学ぶ
==========

..     swarm join command line reference
    Swarm mode tutorial

* ``swarm join`` :doc:`コマンドライン・リファレンス </engine/reference/commandline/swarm_join>`
* :doc:`swarm-tutorial/index` 

.. seealso:: 

   Join nodes to a swarm
      https://docs.docker.com/engine/swarm/join-nodes/
