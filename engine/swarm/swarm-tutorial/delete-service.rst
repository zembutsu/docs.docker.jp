.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/swarm/swarm-tutorial/delete-service/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/swarm/swarm-tutorial/delete-service.md
   doc version: 19.03
.. check date: 2020/07/09
.. Commits on Apr 22, 2017 566af4709cef45e104b552aa14128735b5b4fd73
.. -----------------------------------------------------------------------------

.. Delete the service running on the swarm

.. _delete-the-service-running-on-the-swarm:

=======================================
swarm で実行中のサービスを削除
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. The remaining steps in the tutorial don't use the helloworld service, so now you can delete the service from the swarm.

チュートリアルの以後のステップでは ``helloworld`` サービスを使いませんので、swarm からサービスを削除できます。

..    If you haven't already, open a terminal and ssh into the machine where you run your manager node. For example, the tutorial uses a machine named manager1.

1. 準備がまだであれば、ターミナルを開き、manager ノードを実行しているマシンに SSH で入ります。たとえば、このチュートリアルでは ``manager1`` という名前のマシンを使います。

.. Run docker service rm helloworld to remove the helloworld service.

..    Run docker service remove helloworld to remove the helloworld service.

2. ``docker service rm helloworld`` で ``helloworld`` サービスを削除します。

   .. code-block:: bash
      
      $ docker service rm helloworld
      
      helloworld

..    Run docker service inspect <SERVICE-ID> to veriy that the swarm manager removed the service. The CLI returns a message that the service is not found:

3. ``docker service inspect <サービスID>`` を実行し、swarm manager がサービスを削除したのを確認します。CLI はサービスが見つからないとメッセージを返します。

   .. code-block:: bash
   
      $ docker service inspect helloworld
      []
      Error: no such service or task: helloworld

..    Even though the service no longer exists, the task containers take a few seconds to clean up. You can use docker ps on the nodes to verify when the tasks have been removed.

4. サービスが存在していないだけでなく、タスク・コンテナも数秒でクリーンアップされます。ノード上で ``docker ps`` を使い、タスクも削除されたのも確認します。

   .. code-block:: bash
   
       $ docker ps
   
           CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
           db1651f50347        alpine:latest       "ping docker.com"        44 minutes ago      Up 46 seconds                           helloworld.5.9lkmos2beppihw95vdwxy1j3w
           43bf6e532a92        alpine:latest       "ping docker.com"        44 minutes ago      Up 46 seconds                           helloworld.3.a71i8rp6fua79ad43ycocl4t2
           5a0fb65d8fa7        alpine:latest       "ping docker.com"        44 minutes ago      Up 45 seconds                           helloworld.2.2jpgensh7d935qdc857pxulfr
           afb0ba67076f        alpine:latest       "ping docker.com"        44 minutes ago      Up 46 seconds                           helloworld.4.1c47o7tluz7drve4vkm2m5olx
           688172d3bfaa        alpine:latest       "ping docker.com"        45 minutes ago      Up About a minute                       helloworld.1.74nbhb3fhud8jfrhigd7s29we
   
       $ docker ps
          CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               




.. What's next?

次は何をしますか？
====================

.. In the next step of the tutorial, you set up a new service and and apply a rolling update.

チュートリアルの次のステップは、新しいサービスのセットアップと :doc:`ローリング・アップデート <rolling-update>` を適用します。

.. seealso:: 

   Delete the service running on the swarm
      https://docs.docker.com/engine/swarm/swarm-tutorial/delete-service/
