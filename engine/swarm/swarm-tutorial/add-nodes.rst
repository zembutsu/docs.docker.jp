.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/swarm/swarm-tutorial/add-nodes/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/swarm/swarm-tutorial/add-nodes.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/swarm/swarm-tutorial/add-nodes.md
.. check date: 2016/06/17
.. Commits on Jun 16, 2016 bc033cb706fd22e3934968b0dfdf93da962e36a8
.. -----------------------------------------------------------------------------

.. Add nodes to the Swarm

.. _add-nodes-to-the-swarm:

=======================================
Swarm に他のノードを追加
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Once you've created a Swarm with a manager node, you're ready to add worker nodes.

マネージャ・ノードで :doc:`Swarm を作成 <create-swarm>` した後は、ワーカ・ノードを追加できる状態です。

..    Open a terminal and ssh into the machine where you want to run a worker node. This tutorial uses the name worker1.

1. ターミナルを開き、ワーカ・ノードを実行したいマシンに SSH で入ります。このチュートリアルでは ``worker1`` という名前のマシンを使います。

..    Run the following command to create a worker node joined to the existing Swarm:

2. 既存の Swarm に参加するワーカ・ノードを作成するには、次のコマンドを実行します。

.. code-block:: bash

   docker swarm join <マネージャIP>:<PORT>

..    Replace <MANAGER-IP> with the address of the manager node and <PORT> with the port where the manager listens.

``<マネージャIP>``  をマネージャ・ノードのアドレスに置き換えます。また、 ``PORT`` をマネージャがリッスンするポートに置き換えます。

..    In the tutorial, the following command joins worker1 to the Swarm on manager1:

このチュートリアルでは、次のコマンドは Swarm 上の ``manager1`` に  ``workder1`` を追加します。

.. code-block:: bash

   $ docker swarm join 192.168.99.100:2377
   
   This node joined a Swarm as a worker.

..    Open a terminal and ssh into the machine where you want to run a second worker node. This tutorial uses the name worker2.

3. ターミナルを開き、２つめのワーカ・ノードを実行したいマシンに SSH で入ります。このチュートリアルでは ``worker2`` を使います。

..    Run docker swarm join <MANAGER-IP>:<PORT> to create a worker node joined to the existing Swarm.

4. ``docker swarm join <マネージャIP>:<PORT>`` を実行し、既存の Swarm に参加するワーカ・ノードを作成します。

..    Replace <MANAGER-IP> with the address of the manager node and <PORT> with the port where the manager listens.

``<マネージャIP>``  をマネージャ・ノードのアドレスに置き換えます。また、 ``PORT`` をマネージャがリッスンするポートに置き換えます。

..    Open a terminal and ssh into the machine where the manager node runs and run the docker node ls command to see the worker nodes:

5. ターミナルを開き、マネージャ・ノードを実行中のマシンにログインします。そして ``docker node ls`` コマンドを実行し、ワーカ・ノードを確認します。

.. code-block:: bash

   $ docker node ls
   
   ID              NAME      MEMBERSHIP  STATUS  AVAILABILITY  MANAGER STATUS  LEADER
   09fm6su6c24q *  manager1  Accepted    Ready   Active        Reachable       Yes
   32ljq6xijzb9    worker1   Accepted    Ready   Active
   38fsncz6fal9    worker2   Accepted    Ready   Active

..    The MANAGER column identifies the manager nodes in the Swarm. The empty status in this column for worker1 and worker2 identifies them as worker nodes.

Swarm 上のマネージャ・ノードは ``MANAGER STATUS`` 列で分かります。 ``worker1`` と ``worker2`` のステータスは何もないため、ワーカーノードだと分かります。

..    Swarm management commands like docker node ls only work on manager nodes.

``docker node ls`` のような Swarm 管理コマンドは、マネージャ・ノード上でのみ実行できます。

.. What's next?

次は何をしますか？
====================

.. Now your Swarm consists of a manager and two worker nodes. In the next step of the tutorial, you deploy a service to the Swarm.

これで Swarm はマネージャと２つのワーカ・ノードで構成されています。チュートリアルの次のステップは Swarm に :doc:`サービスをデプロイ <deploy-service>` します。

.. seealso:: 

   Add nodes to the Swarm
      https://docs.docker.com/engine/swarm/swarm-tutorial/add-nodes/
