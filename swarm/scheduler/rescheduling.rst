.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/swarm/discovery/
.. SOURCE: https://github.com/docker/swarm/blob/master/docs/discovery.md
   doc version: 1.11
      https://github.com/docker/swarm/commits/master/docs/discovery.md
.. check date: 2016/04/29
.. Commits on Mar 4, 2016 4b8ed91226a9a49c2acb7cb6fb07228b3fe10007
.. -------------------------------------------------------------------

.. Swarm Rescheduling

.. _swarm-re-scheduling:

===================================
Swarm の再スケジュール・ポリシー
===================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. You can set recheduling policies with Docker Swarm. A rescheduling policy determines what the Swarm scheduler does for containers when the nodes they are running on fail.

Docker Swarm で再スケジュール・ポリシーを設定できます。再スケジュール・ポリシーとは、コンテナを実行中のノードが落ちた時、再起動するかどうかを決めます。


.. Rescheduling policies

.. _rescheduling-policies:

再スケジュール・ポリシー
==============================

.. You set the reschedule policy when you start a container. You can do this with the reschedule environment variable or the com.docker.swarm.reschedule-policy label. If you don’t specify a policy, the default rescheduling policy is off which means that Swarm does not restart a container when a node fails.

コンテナ起動時に再スケジュール・ポリシー（reschedule policy）を設定できます。設定をするには ``reschedule`` 環境変数を指定するか、 ``com.docker.swarm.reschedule-policy`` ラベルを指定します。ポリシーを指定しなければ、再スケジュール・ポリシーは ``off`` になります。つまり、ノードで障害が発生しても Swarm はコンテナを再スケジュールしません（再起動しません）。

.. To set the on-node-failure policy with a reschedule environment variable:

``on-node-failure`` ポリシーを環境変数 ``reschedule`` で設定するには、

.. code-block:: bash

   $ docker run -d -e reschedule:on-node-failure redis

.. To set the same policy with a com.docker.swarm.reschedule-policy label:

``com.docker.swarm.reschedule-policy`` ラベルで同じポリシーを設定するには、

.. code-block:: bash

   $ docker run -d -l 'com.docker.swarm.reschedule-policy=["on-node-failure"]' redis

.. Review reschedule logs

.. _review-reschedule-logs:

再スケジュール・ログの確認
==============================

.. You can use the docker logs command to review the rescheduled container actions. To do this, use the following command syntax:

``docker logs`` コマンドを使って再スケジュールしたコンテナの動作を確認できます。確認するには、次の構文を使います。

.. code-block:: bash

   docker logs SWARMマネージャのコンテナID

.. When a container is successfully rescheduled, it generates a message similar to the following:

コンテナの再スケジュールに成功したら、次のようなメッセージを表示します。

.. code-block:: bash

   Rescheduled container 2536adb23 from node-1 to node-2 as 2362901cb213da321
   Container 2536adb23 was running, starting container 2362901cb213da321

.. If for some reason, the new container fails to start on the new node, the log contains:

同様に、新しいノード上で新しいコンテナの起動に失敗したら、ログには次のように表示します。

.. code-block:: bash

   Failed to start rescheduled container 2362901cb213da321

.. Related information

関連情報
====================

..    Apply custom metadata
    Environment variables with run

* :doc:`/engine/userguide/labels-custom-metadata`
* :ref:`run-env`


.. seealso:: 

   Swarm Rescheduling
      https://docs.docker.com/swarm/scheduler/rescheduling/