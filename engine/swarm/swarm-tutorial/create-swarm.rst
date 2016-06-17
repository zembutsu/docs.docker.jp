.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/swarm/swarm-tutorial/create-swarm/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/swarm/swarm-tutorial/create-swarm.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/swarm/swarm-tutorial/create-swarm.md
.. check date: 2016/06/17
.. Commits on Jun 16, 2016 bc033cb706fd22e3934968b0dfdf93da962e36a8
.. -----------------------------------------------------------------------------

.. Create a Swarm

.. _create-a-swam:

=======================================
Swarm （群れ）の作成
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. After you complete the tutorial setup steps, you're ready to create a Swarm. Make sure the Docker Engine daemon is started on the host machines.

:doc:`チュートリアルのセットアップ <index>` ステップを終えたら、 Swarm （群れ；クラスタの意味）を作成する準備が整いました。ホストマシン上で Docker Engine デーモンが起動しているか確認してください。

..    Open a terminal and ssh into the machine where you want to run your manager node. For example, the tutorial uses a machine named manager1.

1. ターミナルを開き、マネージャ・ノードにしたいマシンに SSH で入ります。たとえば、このチュートリアルでは ``manager1`` という名前のマシンを使います。

..    Run the following command to create a new Swarm:

2. 新しい Swarm を作成するために、次のコマンドを実行します。

.. code-block:: bash

   docker swarm init --listen-addr <MANAGER-IP>:<PORT>

..    In the tutorial, the following command creates a Swarm on the manager1 machine:

このチュートリアルでは、 ``manager1`` マシン上で次の Swarm 作成コマンドを実行します。

.. code-block:: bash

   $ docker swarm init --listen-addr 192.168.99.100:2377
   Swarm initialized: current node (09fm6su6c24qn) is now a manager.

..    The --listen-addr flag configures the manager node to listen on port 2377. The other nodes in the Swarm must be able to access the manager at the IP address.

``--listen-addr`` フラグは、マネージャ・ノードでポート ``2377`` をリッスンする設定です。Swarm における他のノードは、この IP アドレスでマネージャに接続できます。

..    Run docker info to view the current state of the Swarm:

3. ``docker info`` を実行し、現在の Swarm の状況を表示します。

.. code-block:: bash

    $ docker info
   
    Containers: 2
     Running: 0
     Paused: 0
     Stopped: 2
    ...省略...
    Swarm:
     NodeID: 09fm6su6c24qn
     IsManager: YES
     Managers: 1
     Nodes: 1
    ...省略...

..     Run the docker node ls command to view information about nodes:

4. ``docker node ls`` コマンドを実行し、ノードに関する情報を表示します。

.. code-block:: bash

   $ docker node ls
   
   ID              NAME      MEMBERSHIP  STATUS  AVAILABILITY  MANAGER STATUS  LEADER
   09fm6su6c24q *  manager1  Accepted    Ready   Active        Reachable       Yes

..    The * next to the node id, indicates that you're currently connected on this node.

ノード ID の横にある ``*`` 印は、現在接続中のノードを表します。

..    Docker Swarm automatically names the node for the machine host name. The tutorial covers other columns in later steps.

Docker Swarm はノードに対して、マシンのホスト名を自動的に付けます。他の列については、後半のステップで扱います。

.. What's next?

次は何をしますか？
====================

.. In the next section of the tutorial, we'll add two more nodes to the cluster.

チュートリアルの次のセクションで、クラスタに :doc:`さらに２つのノーdを追加 <add-nodes>` します。

.. seealso:: 

   Create a Swarm
      https://docs.docker.com/engine/swarm/swarm-tutorial/create-swarm/
