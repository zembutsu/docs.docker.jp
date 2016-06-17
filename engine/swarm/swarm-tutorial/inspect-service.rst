.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/swarm/swarm-tutorial/inspect-service/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/swarm/swarm-tutorial/inspect-service.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/swarm/swarm-tutorial/inspect-service.md
.. check date: 2016/06/17
.. Commits on Jun 16, 2016 bc033cb706fd22e3934968b0dfdf93da962e36a8
.. -----------------------------------------------------------------------------

.. Inspect a service on the Swarm

.. _inspect-a-service-on-the-swarm:

=======================================
Swarm 上のサービスを調べる
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. When you have deployed a service to your Swarm, you can use the Docker CLI to see details about the service running in the Swarm.

Swarm に :doc:`サービスをデプロイ <deploy-service>` したら、Swarm 上で実行している全サービスの詳細を Docker CLI で確認できます。

..    If you haven't already, open a terminal and ssh into the machine where you run your manager node. For example, the tutorial uses a machine named manager1.

1. 準備がまだであれば、ターミナルを開き、マネージャ・ノードを実行しているマシンに SSH で入ります。たとえば、このチュートリアルでは ``manager1`` という名前のマシンを使います。

..    Run docker service inspect --pretty <SERVICE-ID> to display the details about a service in an easily readable format.

2. ``docker service inspect --pretty <サービスID>`` を実行したら、サービスに関する詳細を読みやすい形式で表示します。

..    To see the details on the helloworld service:

``helloworld`` サービスの詳細を観るには、次のようにします。

.. code-block:: bash

   $ docker service inspect --pretty helloworld
   
   ID:     2zs4helqu64f3k3iuwywbk49w
   Name:       helloworld
   Mode:       REPLICATED
    Scale: 1
   Placement:
    Strategy:  SPREAD
   UpdateConfig:
    Parallelism:   1
   ContainerSpec:
    Image:     alpine
    Command:   ping docker.com

..        Tip: To return the service details in json format, run the same command without the --pretty flag.

.. tip::

   サービスの詳細を json 形式で得るには、同じコマンドで ``--pretty`` フラグを使わずに実行します。

.. code-block:: bash

   $ docker service inspect helloworld
   [
   {
       "ID": "2zs4helqu64f3k3iuwywbk49w",
       "Version": {
           "Index": 16264
       },
       "CreatedAt": "2016-06-06T17:41:11.509146705Z",
       "UpdatedAt": "2016-06-06T17:41:11.510426385Z",
       "Spec": {
           "Name": "helloworld",
           "ContainerSpec": {
               "Image": "alpine",
               "Command": [
                   "ping",
                   "docker.com"
               ],
               "Resources": {
                   "Limits": {},
                   "Reservations": {}
               }
           },
           "Mode": {
               "Replicated": {
                   "Instances": 1
               }
           },
           "RestartPolicy": {},
           "Placement": {},
           "UpdateConfig": {
               "Parallelism": 1
           },
           "EndpointSpec": {}
       },
       "Endpoint": {
           "Spec": {}
       }
   }
   ]

..    Run docker service tasks <SERVICE-ID> to see which nodes are running the service:

3. ``docker service tasks <サービスID>`` を実行すると、サービスがどのノードで動作しているのか分かります。

.. code-block:: bash

   $ docker service tasks helloworld
   
   ID                         NAME          SERVICE     IMAGE   DESIRED STATE  LAST STATE          NODE
   1n6wif51j0w840udalgw6hphg  helloworld.1  helloworld  alpine  RUNNING        RUNNING 19 minutes  manager1

..    In this case, the one instance of the helloworld service is running on the manager1 node. Manager nodes in a Swarm can execute tasks just like worker nodes.

この場合は、 ``helloworld`` サービスのインスタンス１つが ``manager1`` ノードで動いています。 Swarm のマネージャ・ノードはワーカーノードのようにタスクを実行できます。

..    Swarm also shows you the DESIRED STATE and LAST STATE of the service task so you can see if tasks are running according to the service definition.

また、Swarm はサービス・タスクの ``DESIRED STATE`` （期待状態）と ``LAST STATE`` （最新状態）を表示します。これでサービス低吟胃従ってタスクを実行しているか確認できます。

..    Run docker ps on the node where the instance of the service is running to see the service container.

4. サービスのインスタンスを実行中のノード上で ``docker ps`` を実行し、サービス・コンテナを確認します。

..        Tip: If helloworld is running on a node other than your manager node, you must ssh to that node.

.. tip::

   ``helloworld`` がマネージャ・ノード以外で実行中の場合は、対象ノードに SSH する必要があります。

.. code-block:: bash

   $docker ps
   
   CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
   a0b6c02868ca        alpine:latest       "ping docker.com"   12 minutes ago      Up 12 minutes                           helloworld.1.1n6wif51j0w840udalgw6hphg

.. What's next?

次は何をしますか？
====================

.. Next, you can change the scale for the service running in the Swarm.

次は、スワーム内で実行するサービスの :doc:`スケールを変更 <scale-service>` できます。

.. seealso:: 

   Inspect a service on the Swarm
      https://docs.docker.com/engine/swarm/swarm-tutorial/inspect-service/
