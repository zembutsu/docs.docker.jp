.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/swarm/how-swarm-mode-works/nodes/
.. SOURCE: https://github.com/docker/docker.github.io/commits/master/engine/swarm/how-swarm-mode-works/nodes.md
   doc version: 19.03
.. check date: 2020/07/11
.. Commits on Apr 23, 2020 777c5d23dafd4b640016f24f92fe416f246ec848
.. -----------------------------------------------------------------------------

.. How nodes work

.. _swarm-how-nodes-work:

=======================================
ノードの挙動
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Docker Engine 1.12 introduces swarm mode that enables you to create a cluster of one or more Docker Engines called a swarm. A swarm consists of one or more nodes: physical or virtual machines running Docker Engine 1.12 or later in swarm mode.

Docker 1.12 で swarm mode（スウォーム・モード）を導入しました。これは1つまたは複数の Docker エンジン上に、 swarm （訳者注：「群れ」の意味。swarm mode）と呼ぶクラスタを作成できます。1つまはた複数のノードでswarm を構成します。つまり、swarm モードは Docker Engine 1.12 以降の物理または仮想マシン上で動作します。

.. hint::

   訳者注： Docker のドキュメントで「swarm」という言葉が出てくる場合は、ソフトウェア名称としての「swarm」ではなく、Docker Engine のノードで構成する「クラスタ」の意味で用いられるのが大半です。たとえば、「swarm を作成する」という表現は「swarm クラスタを作成する」と置き換えて読む必要があります。

.. There are two types of nodes: managers and workers.

ノードは :ref:`manager <swarm-manager-nodes>` と :ref:`worker <swarm-worker-nodes>` の2種類です。

.. Swarm mode cluster
.. image:: /engine/swarm/images/swarm-diagram.png
   :alt: Swarm モードのクラスタ

.. If you haven’t already, read through the swarm mode overview and key concepts.

もしも :doc:`/engine/swarm/index` や :doc:`/engine/swarm/key-concepts` を未読であれば、ご覧ください。


.. Manager nodes

.. _swarm-manager-nodes:

manager ノード
====================

.. Manager nodes handle cluster management tasks:

manager ノードはクラスタ管理タスクを扱います：

..  maintaining cluster state
    scheduling services
    serving swarm mode HTTP API endpoints

* クラスタの状態を維持
* サービスのスケジューリング
* swarm モードの `HTTP API エンドポイント <https://docs.docker.com/engine/api/>`_ を提供

.. Using a Raft implementation, the managers maintain a consistent internal state of the entire swarm and all the services running on it. For testing purposes it is OK to run a swarm with a single manager. If the manager in a single-manager swarm fails, your services continue to run, but you need to create a new cluster to recover.

swarm 全体の内部状態と swarm 上で稼働している全サービスの一貫性を、manager が `Raft <https://raft.github.io/raft.pdf>`_ の実装を使って維持します。swarm 上で 単一の manager しか実行しないのは、テスト用途であれば構いません。しかし、一つしかない swarm のマスタで障害が発生すると、サービスは動き続けるものの、復旧のためには新しいクラスタの作成が必要です。

.. To take advantage of swarm mode’s fault-tolerance features, Docker recommends you implement an odd number of nodes according to your organization’s high-availability requirements. When you have multiple managers you can recover from the failure of a manager node without downtime.

swarm モードの耐障害性（fault-tolerance）機能を活かすために Docker が推奨するのは、組織における高可用性の要件に応じ、ノード数を奇数にすることです。複数の manager があれば、manager で障害が発生したとしても、停止時間なく復旧可能です。

..  A three-manager swarm tolerates a maximum loss of one manager.
    A five-manager swarm tolerates a maximum simultaneous loss of two manager nodes.
    An N manager cluster tolerates the loss of at most (N-1)/2 managers.
    Docker recommends a maximum of seven manager nodes for a swarm.

* 3 つのマネージャ がある swarm では、1つの manager の障害に耐えます
* 5 つのマネージャ がある swarm では、最大で 2 つの manager ノードの同時障害に耐えます
* ``N`` つの manager クラスタは、最大で ``(N-1)/2`` manager の障害に耐えます


* Docker が推奨するのは、 swarm に対して最大 7 つの manager ノードです

..        Important Note: Adding more managers does NOT mean increased scalability or higher performance. In general, the opposite is true.

.. important::

   manger を増やすことが、スケーラビリティや性能の向上を意味「しません」。通常は全く逆です。


.. Worker nodes

.. _swarm-worker-nodes:

worker ノード
====================

.. Worker nodes are also instances of Docker Engine whose sole purpose is to execute containers. Worker nodes don’t participate in the Raft distributed state, make scheduling decisions, or serve the swarm mode HTTP API.

worker ノードもまた Docker Engine のインスタンスであり、コンテナの実行を唯一の目的とします。worker ノードは Raft 分散状態、スケジューリングの決定、swarm モード HTTP API の提供を行いません。

.. You can create a swarm of one manager node, but you cannot have a worker node without at least one manager node. By default, all managers are also workers. In a single manager node cluster, you can run commands like docker service create and the scheduler places all tasks on the local Engine.

単一の manager ノード上で swarm を作成できますが、全く manager ノードがない worker ノードだけで swarm を作成できません。単一 の manager ノードクラスタであれば、 ``docker service create`` のようなコマンドを実行し、ローカルの Engine 上で全てのタスクをスケジュール可能です。

.. To prevent the scheduler from placing tasks on a manager node in a multi-node swarm, set the availability for the manager node to Drain. The scheduler gracefully stops tasks on nodes in Drain mode and schedules the tasks on an Active node. The scheduler does not assign new tasks to nodes with Drain availability.

複数のノードがある swarm で、manager ノード上にタスクがスケジュールされるのを防ぐには、 manager ノードに対して ``Drain`` （排出）という可用性を指定できます。 ``Drain`` モードでは、スケジューラはノード上のタスクを丁寧に停止し、他の ``Active`` なノード上にタスクをスケジュールします。 スケジューラは、``Drain`` 可用性の指定があるノード上に新しいタスクを割り当てません。

.. Refer to the docker node update command line reference to see how to change node availability.

ノードの可用性を変える方法は、 :doc:`docker node update </engine/reference/commandline/node_update>` コマンドライン・リファレンスをご覧ください。

.. Change roles

.. _swarm-change-roles:

役割の変更
==========

.. You can promote a worker node to be a manager by running docker node promote. For example, you may want to promote a worker node when you take a manager node offline for maintenance. See node promote.

``docker node promote`` の実行によって、worker ノードを manager へと昇格（promote）できます。たとえば、メンテナンスによって manager ノードがオフラインになるとき、worker ノードを昇格したい場合に使えます。 :doc:`node promote </engine/reference/commandline/node_promote>` をご覧ください。

.. You can also demote a manager node to a worker node. See node demote.

manager ノードを worker ノードに降格（demote）も可能です。 :doc:`node demote </engine/reference/commandline/node_demote>` をご覧ください。

.. Learn more

さらに学ぶ
==========

.  Read about how swarm mode services work.
    Learn how PKI works in swarm mode.

* swarm モードの :doc:`サービス <services>` の動作について読む
* swarm モードでの :doc:`PKI <pki>` 挙動について学ぶ


.. seealso:: 

   How nodes work
      https://docs.docker.com/engine/swarm/how-swarm-mode-works/nodes/
