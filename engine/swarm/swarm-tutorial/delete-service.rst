.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/swarm/swarm-tutorial/delete-service/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/swarm/swarm-tutorial/delete-service.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/swarm/swarm-tutorial/delete-service.md
.. check date: 2016/06/21
.. Commits on Jun 19, 2016 9499d5fd522e2fa31e5d0458c4eb9b420f164096
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

1. 準備がまだであれば、ターミナルを開き、マネージャ・ノードを実行しているマシンに SSH で入ります。たとえば、このチュートリアルでは ``manager1`` という名前のマシンを使います。

..    Run docker service remove helloworld to remove the helloworld service.

2. ``docker service remove helloworld`` で ``helloworld`` サービスを削除します。

.. code-block:: bash

   $ docker service rm helloworld
   helloworld

..    Run docker service inspect <SERVICE-ID> to veriy that the swarm manager removed the service. The CLI returns a message that the service is not found:

3. ``docker service inspect <サービスID>`` を実行し、swarm マネージャがサービスを削除したのを確認します。CLI はサービスが見つからないとメッセージを返します。

.. code-block:: bash

   $ docker service inspect helloworld
   []
   Error: no such service or task: helloworld

.. What's next?

次は何をしますか？
====================

.. In the next step of the tutorial, you set up a new service and and apply a rolling update.

チュートリアルの次のステップは、新しいサービスのセットアップと :doc:`ローリング・アップデート <rolling-update>` を適用します。

.. seealso:: 

   Delete the service running on the swarm
      https://docs.docker.com/engine/swarm/swarm-tutorial/delete-service/
