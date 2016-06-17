.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/swarm/swarm-tutorial/deploy-service/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/swarm/swarm-tutorial/deploy-service.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/swarm/swarm-tutorial/deploy-service.md
.. check date: 2016/06/17
.. Commits on Jun 16, 2016 bc033cb706fd22e3934968b0dfdf93da962e36a8
.. -----------------------------------------------------------------------------

.. Deploy a service to the Swarm

.. _deploy-service-to-the-swarm:

=======================================
Swarm にサービスをデプロイ
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. After you create a Swarm, you can deploy a service to the Swarm. For this tutorial, you also added worker nodes, but that is not a requirement to deploy a service.

:doc:`Swarm を作成 <create-swarm>` したら、Swarm にサービスをデプロイできます。このチュートリアルでは :doc:`ワーカーノードも追加 <add-nodes>` しましたが、サービスのデプロイには必須ではありません。

..    Open a terminal and ssh into the machine where you run your manager node. For example, the tutorial uses a machine named manager1.

1. ターミナルを開き、マネージャ・ノードを実行中のマシンに SSH で入ります。このチュートリアルでは ``manager1`` という名前のマシンを使います。

..    Run the the following command:

2. 次のコマンドを実行します。

.. code-block:: bash

   $ docker service create --replicas 1 --name helloworld alpine ping docker.com
   
   2zs4helqu64f3k3iuwywbk49w

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
   
   ID            NAME        REPLICAS  IMAGE   COMMAND
   2zs4helqu64f  helloworld  1         alpine  ping docker.com


.. What's next?

次は何をしますか？
====================

.. Now you've deployed a service to the Swarm, you're ready to inspect the service.

Swarm にサービスをデプロイしましたので、 :doc:`サービスを調べる <inspect-service>` 準備が整いました。

.. seealso:: 

   Deploy a service to the Swarm
      https://docs.docker.com/engine/swarm/swarm-tutorial/deploy-service/
