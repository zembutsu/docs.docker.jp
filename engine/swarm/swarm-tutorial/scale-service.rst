.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/swarm/swarm-tutorial/scale-service/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/swarm/swarm-tutorial/scale-service.md
   doc version: 19.03
.. check date: 2020/07/09
.. Commits on Apr 26, 2017 dbf16812acb9bd5551e423f5411659347a0debf0
.. -----------------------------------------------------------------------------

.. Scale the service in the swarm

.. _scale-the-service-in-the-swarm:

=======================================
swarm でサービスをスケール
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Once you have deployed a service to a swarm, you are ready to use the Docker CLI to scale the number of containers in the service. Containers running in a service are called “tasks.”

.. Once you have deployed a service to a swarm, you are ready to use the Docker CLI to scale the number of service tasks in the swarm.

swarm に :doc:`サービスをデプロイ <deploy-service>` したら、sarm  上のサービス・タスクの数を Docker CLI でスケールできる準備が整いました。サービス内で実行中のコンテナを「タスク」（task）と呼びます。

..    If you haven't already, open a terminal and ssh into the machine where you run your manager node. For example, the tutorial uses a machine named manager1.

1. ターミナルを開き、manager ノードを実行中のマシンに SSH で入ります。このチュートリアルでは ``manager1`` という名前のマシンを使います。

..    Run the following command to change the desired state of the service running in the swarm:

2. swarm で実行しているサービスの期待状態を変更するには、次のコマンドを実行します。

   .. code-block:: bash

      $ docker service scale <サービスID>=<タスク数>

   ..    For example:

   実行例：

   .. code-block:: bash

      $ docker service scale helloworld=5
      
      helloworld scaled to 5

.. Run docker service ps <SERVICE-ID> to see the updated task list:

3. ``docker service ps <サービスID>`` を実行し、更新されたタスク一覧を表示します。

   .. code-block:: bash
   
      $ docker service ps helloworld
      
      NAME                                    IMAGE   NODE      DESIRED STATE  CURRENT STATE
      helloworld.1.8p1vev3fq5zm0mi8g0as41w35  alpine  worker2   Running        Running 7 minutes
      helloworld.2.c7a7tcdq5s0uk3qr88mf8xco6  alpine  worker1   Running        Running 24 seconds
      helloworld.3.6crl09vdcalvtfehfh69ogfb1  alpine  worker1   Running        Running 24 seconds
      helloworld.4.auky6trawmdlcne8ad8phb0f1  alpine  manager1  Running        Running 24 seconds
      helloworld.5.ba19kca06l18zujfwxyc5lkyn  alpine  worker2   Running        Running 24 seconds

..    You can see that swarm has created 4 new tasks to scale to a total of 5 running instances of Alpine Linux. The tasks are distributed between the three nodes of the swarm. Two are running on manager1.

swarm は４つの新しいタスクを作成し、Alpine Linux のインスタンスが合計５つになったのが分かります。タスクは swarm の３つのノード間で分散されています。２つは ``manager1`` 上で実行中です。

..    Run docker ps to see the containers running on the node where you're connected. The following example shows the tasks running on manager1:

4. ``docker ps`` を実行し、接続中のノード上で実行中のコンテナを確認できます。次の例は ``manager1`` 上で実行中のタスクを表示しています。

   .. code-block:: bash
   
      $ docker ps
      
      CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
      528d68040f95        alpine:latest       "ping docker.com"   About a minute ago   Up About a minute                       helloworld.4.auky6trawmdlcne8ad8phb0f1


   ..    If you want to see the containers running on other nodes, you can ssh into those nodes and run the docker ps command.

   他のノードで実行中のコンテナを確認したい場合は、各ノードに SSH で入り ``docker ps`` コマンドで確認できます。

.. What's next?

次は何をしますか？
====================

.. At this point in the tutorial, you're finished with the helloworld service. The next step shows how to delete the service.

このチュートリアルでは ``helloworld`` サービスは終わりです。次のステップでは :doc:`サービスの削除 <delete-service>` 方法を理解します。

.. seealso:: 

   Scale the service in the swarm
      https://docs.docker.com/engine/swarm/swarm-tutorial/scale-service/
