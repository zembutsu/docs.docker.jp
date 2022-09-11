.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/swarm/swarm-tutorial/create-swarm/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/engine/swarm/swarm-tutorial/create-swarm.md
   doc version: 20.10
.. check date: 2022/04/29
.. Commits on Aug 7, 2021 3b71231970606bb45fd6f37a8c99522583e7f5a8
.. -----------------------------------------------------------------------------

.. Create a swarm

.. _create-a-swam:

=======================================
swarm （クラスタ）の作成
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. After you complete the tutorial setup steps, you're ready to create a swarm. Make sure the Docker Engine daemon is started on the host machines.

:doc:`チュートリアルのセットアップ <index>` ステップを終えたら、 sarm （訳者注：「群れ」の意味ですが、swarm mode における「クラスタ」を意味する概念）を作成する準備が整いました。ホストマシン上で Docker Engine デーモンが起動しているか確認してください。

.. Open a terminal and ssh into the machine where you want to run your manager node. This tutorial uses a machine named manager1. If you use Docker Machine, you can connect to it via SSH using the following command:

1. ターミナルを開き、マネージャ・ノードにしたいマシンに SSH で入ります。たとえば、このチュートリアルでは ``manager1`` という名前のマシンを使います。Docker Machine を使っている場合は、以下のコマンドを使い、 SSH 経由で接続できます。

   .. code-block:: bash
   
      $ docker-machine ssh manager1

..    Run the following command to create a new swarm:

2. 新しい swarm を作成するために、次のコマンドを実行します。

   .. code-block:: bash
   
      $ docker swarm init --advertise-addr <MANAGER-IP>

   .. note::
   
      Docker Desktop for Mac や Docker Desktop for Windows を使っている場合は、単一ノード swarm をテストするために、引数を付けずに単純に ``docker swarm init`` を実行します。今回の例では ``--advertise-addr`` を指定する必要はありません。詳しく学ぶには、Swarm で :ref:`Docker Desktop for Mac や Docker Desktop for Windows を使う <use-docker-desktop-for-mac-or-docker-desktop-for-windows>` をご覧ください。

   ..    In the tutorial, the following command creates a swarm on the manager1 machine:

   このチュートリアルでは、 ``manager1`` マシン上で次の swarm 作成コマンドを実行します。

   .. code-block:: bash
   
      $ docker swarm init --advertise-addr 192.168.99.100
      Swarm initialized: current node (dxn1zf6l61qsb1josjja83ngz) is now a manager.
      
      To add a worker to this swarm, run the following command:
      
          docker swarm join \
          --token SWMTKN-1-49nj1cmql0jkz5s954yi3oex3nedyz0fb0xx14ie39trti4wxv-8vxv8rssmk743ojnwacrr2e7c \
          192.168.99.100:2377
      
      To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.

   .. The --advertise-addr flag configures the manager node to publish its address as 192.168.99.100. The other nodes in the swarm must be able to access the manager at the IP address.

   ``--advertise-addr`` フラグは、 manager ノードで自身を ``192.168.99.100`` として公開する設定です。swarm における他のノードは、この IP アドレスを使い、manager に対して接続する必要があります。

   .. The output includes the commands to join new nodes to the swarm. Nodes will join as managers or workers depending on the value for the --token flag.

   出力には、swarm に新しいノードを追加するコマンドも含みます。 ``--token`` フラグの値によって、ノードは manager あるいは worker として参加します。

..    Run docker info to view the current state of the swarm:

3. ``docker info`` を実行し、現在の swarm の状況を表示します。

   .. code-block:: bash
   
       $ docker info
      
       Containers: 2
        Running: 0
        Paused: 0
        Stopped: 2
       ...省略...
       Swarm: active
        NodeID: dxn1zf6l61qsb1josjja83ngz
        IsManager: Yes
        Managers: 1
        Nodes: 1
        CACertHash: sha256:b7986d3baeff2f5664dfe350eec32e2383539ec1a802ba541c4eb829056b5f61
       ...省略...

..     Run the docker node ls command to view information about nodes:

4. ``docker node ls`` コマンドを実行し、ノードに関する情報を表示します。

   .. code-block:: bash
   
      $ docker node ls
      
      ID                           NAME      MEMBERSHIP  STATUS  AVAILABILITY  MANAGER STATUS  LEADER
      dxn1zf6l61qsb1josjja83ngz *  manager1  Accepted    Ready   Active        Reachable       Yes
   
   ..    The * next to the node id, indicates that you're currently connected on this node.

   ノード ID の横にある ``*`` 印は、現在接続中のノードを表します。

   .. Docker Engine swarm mode automatically names the node for the machine host name. The tutorial covers other columns in later steps.

   Docker Engine swarm モードは、ノードに対してマシンのホスト名を自動的に付けます。他の列については、以降のステップで扱います。


.. What's next?

次は何をしますか？
====================

.. In the next section of the tutorial, we'll add two more nodes to the cluster.

チュートリアルの次のセクションで、クラスタに :doc:`さらに２つのノードを追加 <add-nodes>` します。

.. seealso:: 

   Create a swarm
      https://docs.docker.com/engine/swarm/swarm-tutorial/create-swarm/
