.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/swarm/swarm-tutorial/deploy-service/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/engine/swarm/swarm-tutorial/deploy-service.md
   doc version: 20.10
.. check date: 2022/04/29
.. Commits on Aug 7, 2021 3b71231970606bb45fd6f37a8c99522583e7f5a8
.. -----------------------------------------------------------------------------

.. Deploy a service to the swarm

.. _deploy-service-to-the-swarm:

=======================================
swarm にサービスをデプロイ
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. After you create a swarm, you can deploy a service to the swarm. For this tutorial, you also added worker nodes, but that is not a requirement to deploy a service.

:doc:`swarm を作成 <create-swarm>` したら、swarm にサービスをデプロイできます。このチュートリアルでは :doc:`worker ノードも追加 <add-nodes>` しましたが、サービスのデプロイには必須ではありません。

..    Open a terminal and ssh into the machine where you run your manager node. For example, the tutorial uses a machine named manager1.

1. ターミナルを開き、manager ノードを実行中のマシンに SSH で入ります。このチュートリアルでは ``manager1`` という名前のマシンを使います。

..    Run the the following command:

2. 次のコマンドを実行します。

   .. code-block:: bash
   
      $ docker service create --replicas 1 --name helloworld alpine ping docker.com
      
      9uk4639qpg7npwf3fn2aasksr

..     The docker service create command creates the service.
        The --name flag names the service helloworld.
        The --replicas flag specifies the desired state of 1 running instance.
        The arguments alpine ping docker.com define the service as an Alpine Linux container that executes the command ping docker.com.

   * ``docker service create`` コマンドはサービスを作成します。
   * ``--name`` フラグはサービスに ``helloworld`` と名前を付けます。
   * ``--replicas`` フラグは実行インスタンスの期待状態を１と定義します。
   * 引数 ``alpine ping docker.com`` はサービスの定義です。Alpine Linux container で ``ping docker.com`` を実行するサービスです。

..    Run docker service ls to see the list of running services:

3. ``docker service ls`` で実行中のサービスを確認できます。

   .. code-block:: bash
   
      $ docker service ls
      
      ID            NAME        SCALE  IMAGE   COMMAND
      9uk4639qpg7n  helloworld  1/1    alpine  ping docker.com

.. What's next?

次は何をしますか？
====================

.. Now you've deployed a service to the swarm, you're ready to inspect the service.

swarm にサービスをデプロイしましたので、 :doc:`サービスを調べる <inspect-service>` 準備が整いました。

.. seealso:: 

   Deploy a service to the swarm
      https://docs.docker.com/engine/swarm/swarm-tutorial/deploy-service/
