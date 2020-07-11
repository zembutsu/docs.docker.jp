.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/swarm/swarm-tutorial/inspect-service/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/swarm/swarm-tutorial/inspect-service.md
   doc version: 19.03
.. check date: 2020/07/09
.. Commits on May 26, 2020 9c86eaaae23fcaae69202f5c834e514a0fbe968b
.. -----------------------------------------------------------------------------

.. Inspect a service on the swarm

.. _inspect-a-service-on-the-swarm:

=======================================
swarm 上のサービスを調べる
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. When you have deployed a service to your swarm, you can use the Docker CLI to see details about the service running in the swarm.

swarm に :doc:`サービスをデプロイ <deploy-service>` したら、swarm 上で実行している全サービスの詳細を Docker CLI で確認できます。

..    If you haven't already, open a terminal and ssh into the machine where you run your manager node. For example, the tutorial uses a machine named manager1.

1. 準備がまだであれば、ターミナルを開き、manager ノードを実行しているマシンに SSH で入ります。たとえば、このチュートリアルでは ``manager1`` という名前のマシンを使います。

..    Run docker service inspect --pretty <SERVICE-ID> to display the details about a service in an easily readable format.

2. ``docker service inspect --pretty <サービスID>`` を実行したら、サービスに関する詳細を読みやすい形式で表示します。

   ..    To see the details on the helloworld service:
   
   ``helloworld`` サービスの詳細を見るには、次のようにします。

   .. code-block:: bash
   
      [manager1]$ docker service inspect --pretty helloworld
      
      ID:		9uk4639qpg7npwf3fn2aasksr
      Name:		helloworld
      Service Mode:	REPLICATED
       Replicas:		1
      Placement:
      UpdateConfig:
       Parallelism:	1
      ContainerSpec:
       Image:		alpine
       Args:	ping docker.com
      Resources:
      Endpoint Mode:  vip

..        Tip: To return the service details in json format, run the same command without the --pretty flag.

.. tip::

   サービスの詳細を json 形式で得るには、同じコマンドで ``--pretty`` フラグを使わずに実行します。

   .. code-block:: bash
   
      [manager1]$ docker service inspect helloworld
      [
      {
          "ID": "9uk4639qpg7npwf3fn2aasksr",
          "Version": {
              "Index": 418
          },
          "CreatedAt": "2016-06-16T21:57:11.622222327Z",
          "UpdatedAt": "2016-06-16T21:57:11.622222327Z",
          "Spec": {
              "Name": "helloworld",
              "TaskTemplate": {
                  "ContainerSpec": {
                      "Image": "alpine",
                      "Args": [
                          "ping",
                          "docker.com"
                      ]
                  },
                  "Resources": {
                      "Limits": {},
                      "Reservations": {}
                  },
                  "RestartPolicy": {
                      "Condition": "any",
                      "MaxAttempts": 0
                  },
                  "Placement": {}
              },
              "Mode": {
                  "Replicated": {
                      "Replicas": 1
                  }
              },
              "UpdateConfig": {
                  "Parallelism": 1
              },
              "EndpointSpec": {
                  "Mode": "vip"
              }
          },
          "Endpoint": {
              "Spec": {}
          }
      }
      ]



..    Run docker service tasks <SERVICE-ID> to see which nodes are running the service:

3. ``docker service tasks <サービスID>`` を実行すると、サービスがどのノードで動作しているのか分かります。

   .. code-block:: bash
   
      [manager1]$ docker service ps helloworld
      
      NAME                                    IMAGE   NODE     DESIRED STATE  CURRENT STATE           ERROR               PORTS
      helloworld.1.8p1vev3fq5zm0mi8g0as41w35  alpine  worker2  Running        Running 3 minutes

   .. In this case, the one instance of the helloworld service is running on the worker2 node. You may see the service running on your manager node. By default, manager nodes in a Swarm can execute tasks just like worker nodes.

   この場合、 ``helloworld`` サービスは ``worker2`` ノード上で動作しています。 manager ノード上からサービスを実行しているのが確認できます。デフォルトでは、swarm 内の manager ノードは worker ノードのようにタスクを実行可能です。

   ..  Swarm also shows you the DESIRED STATE and CURRENT STATE of the service task so you can see if tasks are running according to the service definition.

   また、swarm はサービス・タスクの ``DESIRED STATE`` （期待状態）と ``CURRENT STATE`` （現在の状態）を表示します。これでサービス定義に従ってタスクを実行しているか確認できます。

.. Run docker ps on the node where the task is running to see details about the container for the task.

4. タスクを実行中のノード上で ``docker ps`` を実行したら、タスク用のコンテナに関する詳細を確認できます。

..        Tip: If helloworld is running on a node other than your manager node, you must ssh to that node.

   .. tip::

      ``helloworld`` がマネージャ・ノード以外で実行中の場合は、対象ノードに SSH する必要があります。

   .. code-block:: bash

      [worker2]$ docker ps
      
      CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
      e609dde94e47        alpine:latest       "ping docker.com"   3 minutes ago       Up 3 minutes                            helloworld.1.8p1vev3fq5zm0mi8g0as41w35

.. What's next?

次は何をしますか？
====================

.. Next, you can change the scale for the service running in the swarm.

次は、swarm 内で実行するサービスの :doc:`スケールを変更 <scale-service>` できます。

.. seealso:: 

   Inspect a service on the swarm
      https://docs.docker.com/engine/swarm/swarm-tutorial/inspect-service/
