.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/swarm/swarm-tutorial/delete-service/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/swarm/swarm-tutorial/delete-service.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/swarm/swarm-tutorial/delete-service.md
.. check date: 2016/06/17
.. Commits on Jun 16, 2016 bc033cb706fd22e3934968b0dfdf93da962e36a8
.. -----------------------------------------------------------------------------

.. Delete the service running on the Swarm

.. _delete-the-service-running-on-the-swarm:

=======================================
Swarm で実行中のサービスを削除
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. The remaining steps in the tutorial don't use the helloworld service, so now you can delete the service from the Swarm.

チュートリアルの以後のステップでは ``helloworld`` サービスを使いませんので、Swarm からサービスを削除できます。

..    If you haven't already, open a terminal and ssh into the machine where you run your manager node. For example, the tutorial uses a machine named manager1.

1. 準備がまだであれば、ターミナルを開き、マネージャ・ノードを実行しているマシンに SSH で入ります。たとえば、このチュートリアルでは ``manager1`` という名前のマシンを使います。

..    Run docker service remove helloworld to remove the helloworld service.

2. ``docker service remove helloworld`` で ``helloworld`` サービスを削除します。

.. code-block:: bash

   $ docker service rm helloworld
   helloworld

..    Run docker service inspect <SERVICE-ID> to veriy that Swarm removed the service. The CLI returns a message that the service is not found:

3. ``docker service inspect <サービスID>`` を実行し、Swarm からサービスが削除されたのを確認します。CLI はサービスが見つからないとメッセージを返します。

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

   Delete the service running on the Swarm
      https://docs.docker.com/engine/swarm/swarm-tutorial/delete-service/
