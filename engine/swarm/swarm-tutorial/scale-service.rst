.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/swarm/swarm-tutorial/scale-service/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/swarm/swarm-tutorial/scale-service.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/swarm/swarm-tutorial/scale-service.md
.. check date: 2016/06/17
.. Commits on Jun 16, 2016 bc033cb706fd22e3934968b0dfdf93da962e36a8
.. -----------------------------------------------------------------------------

.. Scale the service in the Swarm

.. _scale-the-service-in-the-swarm:

=======================================
Swarm でサービスをスケール
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Once you have deployed a service to a Swarm, you are ready to use the Docker CLI to scale the number of service tasks in the Swarm.

Swarm に :doc:`サービスをデプロイ <deploy-service>` したら、Swam 上のサービス・タスクの数を Docker CLI でスケールできる準備が整いました。

..    If you haven't already, open a terminal and ssh into the machine where you run your manager node. For example, the tutorial uses a machine named manager1.

1. ターミナルを開き、マネージャ・ノードを実行中のマシンに SSH で入ります。このチュートリアルでは ``manager1`` という名前のマシンを使います。

..    Run the following command to change the desired state of the service runing in the Swarm:

2. Swarm で実行しているサービスの期待状態を変更するには、次のコマンドを実行します。

.. code-block:: bash

   $ docker service update --replicas <タスク数> <サービスID>

..    The --replicas flag indicates the number of tasks you want in the new desired state. For example:

``--replicas`` フラグは、新しい期待状態が必要なタスク数を表します。たとえば、次のように実行します。

.. code-block:: bash

   $ docker service update --replicas 5 helloworld
   helloworld

..    Run docker service tasks <SERVICE-ID> to see the updated task list:

3. ``docker service tasks <サービスID>`` を実行し、更新されたタスク一覧を表示します。

.. code-block:: bash

   $ docker service tasks helloworld
   
   ID                         NAME          SERVICE     IMAGE   DESIRED STATE  LAST STATE          NODE
   1n6wif51j0w840udalgw6hphg  helloworld.1  helloworld  alpine  RUNNING        RUNNING 2 minutes   manager1
   dfhsosk00wxfb7j0cazp3fmhy  helloworld.2  helloworld  alpine  RUNNING        RUNNING 15 seconds  worker2
   6cbedbeywo076zn54fnwc667a  helloworld.3  helloworld  alpine  RUNNING        RUNNING 15 seconds  worker1
   7w80cafrry7asls96lm2tmwkz  helloworld.4  helloworld  alpine  RUNNING        RUNNING 10 seconds  worker1
   bn67kh76crn6du22ve2enqg5j  helloworld.5  helloworld  alpine  RUNNING        RUNNING 10 seconds  manager1

..    You can see that Swarm has created 4 new tasks to scale to a total of 5 running instances of Alpine Linux. The tasks are distributed between the three nodes of the Swarm. Two are running on manager1.

Swarm は４つの新しいタスクを作成し、Alpine Linux のインスタンスが合計５つになったのが分かります。タスクは Swarm の３つのノード間で分散されています。２つは ``manager1`` 上で実行中です。

..    Run docker ps to see the containers running on the node where you're connected. The following example shows the tasks running on manager1:

4. ``docker ps`` を実行し、接続中のノード上で実行中のコンテナを確認できます。次の例は ``manager1`` 上で実行中のタスクを表示しています。

.. code-block:: bash

   $ docker ps
   
   CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
   910669d5e188        alpine:latest       "ping docker.com"   10 seconds ago      Up 10 seconds                           helloworld.5.bn67kh76crn6du22ve2enqg5j
   a0b6c02868ca        alpine:latest       "ping docker.com"   2 minutes  ago      Up 2 minutes                            helloworld.1.1n6wif51j0w840udalgw6hphg

..    If you want to see the containers running on other nodes, you can ssh into those nodes and run the docker ps command.

他のノードで実行中のコンテナを確認したい場合は、各ノードに SSH で入り ``docker ps`` コマンドで確認できます。

.. What's next?

次は何をしますか？
====================

.. At this point in the tutorial, you're finished with the helloworld service. The next step shows how to delete the service.

このチュートリアルでは ``helloworld`` サービスは終わりです。次のステップでは :doc:`サービスの削除 <delete-service>` 方法を理解します。

.. seealso:: 

   Scale the service in the Swarm
      https://docs.docker.com/engine/swarm/swarm-tutorial/scale-service/
