.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/swarm/swarm-tutorial/scale-service/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/swarm/swarm-tutorial/scale-service.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/swarm/swarm-tutorial/scale-service.md
.. check date: 2016/06/21
.. Commits on Jun 19, 2016 9499d5fd522e2fa31e5d0458c4eb9b420f164096
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

.. Once you have deployed a service to a swarm, you are ready to use the Docker CLI to scale the number of service tasks in the swarm.

swarm に :doc:`サービスをデプロイ <deploy-service>` したら、Swam 上のサービス・タスクの数を Docker CLI でスケールできる準備が整いました。

..    If you haven't already, open a terminal and ssh into the machine where you run your manager node. For example, the tutorial uses a machine named manager1.

1. ターミナルを開き、マネージャ・ノードを実行中のマシンに SSH で入ります。このチュートリアルでは ``manager1`` という名前のマシンを使います。

..    Run the following command to change the desired state of the service running in the swarm:

2. swarm で実行しているサービスの期待状態を変更するには、次のコマンドを実行します。

.. code-block:: bash

   $ docker service scale <サービスID>=<タスク数>

..    For example:

実行例：

.. code-block:: bash

   $ docker service scale helloworld=5
   helloworld scaled to 5

..    Run docker service tasks <SERVICE-ID> to see the updated task list:

3. ``docker service tasks <サービスID>`` を実行し、更新されたタスク一覧を表示します。

.. code-block:: bash

   $ docker service tasks helloworld
   
   ID                         NAME          SERVICE     IMAGE   LAST STATE          DESIRED STATE  NODE
   8p1vev3fq5zm0mi8g0as41w35  helloworld.1  helloworld  alpine  Running 7 minutes   Running        worker2
   c7a7tcdq5s0uk3qr88mf8xco6  helloworld.2  helloworld  alpine  Running 24 seconds  Running        worker1
   6crl09vdcalvtfehfh69ogfb1  helloworld.3  helloworld  alpine  Running 24 seconds  Running        worker1
   auky6trawmdlcne8ad8phb0f1  helloworld.4  helloworld  alpine  Running 24 seconds  Accepted       manager1
   ba19kca06l18zujfwxyc5lkyn  helloworld.5  helloworld  alpine  Running 24 seconds  Running        worker2

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
