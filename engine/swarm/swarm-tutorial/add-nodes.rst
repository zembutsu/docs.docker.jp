.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/swarm/swarm-tutorial/add-nodes/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/swarm/swarm-tutorial/add-nodes.md
   doc version: 19.03
.. check date: 2020/07/09
.. Commits on Feb 24, 2017 d4add4ee209378c810d5871ea5f6092704a73dba
.. -----------------------------------------------------------------------------

.. Add nodes to the swarm

.. _add-nodes-to-the-swarm:

=======================================
swarm に他のノードを追加
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Once you've created a swarm with a manager node, you're ready to add worker nodes.

マネージャ・ノードで :doc:`swarm を作成 <create-swarm>` した後は、worker ノードを追加できる状態です。

..    Open a terminal and ssh into the machine where you want to run a worker node. This tutorial uses the name worker1.

1. ターミナルを開き、worker ノードとして動かしたいマシンに SSH で入ります。このチュートリアルでは ``worker1`` という名前のマシンを使います。

.. Run the command produced by the docker swarm init output from the Create a swarm tutorial step to create a worker node joined to the existing swarm:

2. 既存の swarm に参加する worker ノードを作成するには、 :doc:`create-swarm` チュートリアルの ``docker swarm init`` 処理で表示されたコマンドを使います。

    .. code-block:: bash

      $ docker swarm join \
        --token  SWMTKN-1-49nj1cmql0jkz5s954yi3oex3nedyz0fb0xx14ie39trti4wxv-8vxv8rssmk743ojnwacrr2e7c \
        192.168.99.100:2377
      
      This node joined a swarm as a worker.
   
   .. If you don’t have the command available, you can run the following command on a manager node to retrieve the join command for a worker:
   
   実行するコマンドの情報が分からなければ、以下のコマンドを manager ノード上で実行し、worker として参加するコマンドを受け取ります。
   
   .. code-block:: bash
   
      $ docker swarm join-token worker
      
      To add a worker to this swarm, run the following command:
      
          docker swarm join \
          --token SWMTKN-1-49nj1cmql0jkz5s954yi3oex3nedyz0fb0xx14ie39trti4wxv-8vxv8rssmk743ojnwacrr2e7c \
          192.168.99.100:2377

.. Open a terminal and ssh into the machine where you want to run a second worker node. This tutorial uses the name worker2

3. ターミナルを開き、２つめの workker ノードとして動かしたいマシンに SSH で入ります。このチュートリアルでは ``worker2`` を使います。

.. Run the command produced by the docker swarm init output from the Create a swarm tutorial step to create a second worker node joined to the existing swarm:

4. 既存の swarm に参加する２つめの worker ノードを作成するには、 :doc:`create-swarm` チュートリアルの ``docker swarm init`` 処理で表示されたコマンドを使います。

   .. code-block:: bash
   
      $ docker swarm join \
        --token SWMTKN-1-49nj1cmql0jkz5s954yi3oex3nedyz0fb0xx14ie39trti4wxv-8vxv8rssmk743ojnwacrr2e7c \
        192.168.99.100:2377
      
      This node joined a swarm as a worker.

.. Open a terminal and ssh into the machine where the manager node runs and run the docker node ls command to see the worker nodes:

5. ターミナルを開き、manager ノードを実行中のマシンに SSH ログインします。そして ``docker node ls`` コマンドを実行し、worker ノードを確認します。

   .. code-block:: bash
   
      $ docker node ls
      
      ID                           HOSTNAME  STATUS  AVAILABILITY  MANAGER STATUS
      03g1y59jwfg7cf99w4lt0f662    worker2   Ready   Active
      9j68exjopxe7wfl6yuxml7a7j    worker1   Ready   Active
      dxn1zf6l61qsb1josjja83ngz *  manager1  Ready   Active        Leader

   ..    The MANAGER column identifies the manager nodes in the swarm. The empty status in this column for worker1 and worker2 identifies them as worker nodes.

   swarm 上のmanager ノードは ``MANAGER STATUS`` 列で確認できます（ Leader と表示）。 ``worker1`` と ``worker2`` のステータスには何もないため、worker ノードだと分かります。

..    Swarm management commands like docker node ls only work on manager nodes.

なお、``docker node ls`` のような swarm 管理コマンドは、マネージャ・ノード上でのみ実行できます。

.. What's next?

次は何をしますか？
====================

.. Now your swarm consists of a manager and two worker nodes. In the next step of the tutorial, you deploy a service to the swarm.

これで swarm は manger と２つの worker ・ノードで構成されています。チュートリアルの次のステップは、 swarm に :doc:`サービスをデプロイ <deploy-service>` します。

.. seealso:: 

   Add nodes to the swarm
      https://docs.docker.com/engine/swarm/swarm-tutorial/add-nodes/
