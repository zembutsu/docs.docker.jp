.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/service_scale/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/service_scale.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/service_scale.md
.. check date: 2016/06/21
.. Commits on Jun 20, 2016 daedbc60d61387cb284b871145b672006da1b6de
.. -------------------------------------------------------------------

.. service scale

.. _reference-service-scale:

=======================================
service scale
=======================================

.. code-block:: bash

   使い方:  docker service scale SERVICE=REPLICAS [SERVICE=REPLICAS...]
   
   １つまたは複数のサービスをスケール
   
   オプション:
         --help   使い方の表示

.. Examples

例
==========

.. Scale a service

サービスのスケール
--------------------

.. If you scale a service, you set the desired number of replicas. Even though the command returns directly, actual scaling of the service may take some time.

サービスをスケールするには、レプリカの期待数（desired number）を指定します。コマンドの反応は直ぐだとしても、サービスを実際にスケールするには時間がかかるでしょう。

.. For example, the following command scales the "frontend" service to 50 tasks.

たとえば、次のコマンドは「frontend」サービスを 50 タスクにスケールします。

.. code-block:: bash

   $ docker service scale frontend=50
   frontend scaled to 50

.. Directly afterwards, run docker service ls, to see the actual number of replicas

実行直後に ``docker service ls`` を実行すると、実際のレプリカ数を表示します。

.. code-block:: bash

   $ docker service ls --filter name=frontend
   
   ID            NAME      REPLICAS  IMAGE         COMMAND
   3pr5mlvu3fh9  frontend  15/50     nginx:alpine

.. You can also scale a service using the docker service update command. The following commands are therefore equivalent:

また ``docker service update`` コマンドを使ってもサービスをスケールできます。次のコマンドはどちらも同じです。

.. code-block:: bash

   $ docker service scale frontend=50
   $ docker service update --replicas=50 frontend

.. Scale multiple services

複数のサービスをスケール
------------------------------

.. The docker service scale command allows you to set the desired number of tasks for multiple services at once. The following example scales both the backend and frontend services:

``docker service scale`` コマンドは一度に複数のサービスの期待数を指定できます。次の例は backend と frontend 両方のサービスをスケールします。

.. code-block:: bash

   $ docker service scale backend=3 frontend=5
   backend scaled to 3
   frontend scaled to 5
   
   $ docker service ls
   ID            NAME      REPLICAS  IMAGE         COMMAND
   3pr5mlvu3fh9  frontend  5/5       nginx:alpine
   74nzcxxjv6fq  backend   3/3       redis:3.0.6


関連情報
----------

* :doc:`service_create`
* :doc:`service_inspect`
* :doc:`service_ls`
* :doc:`service_rm`
* :doc:`service_tasks`
* :doc:`service_update`

.. seealso:: 

   service scale
      https://docs.docker.com/engine/reference/commandline/service_scale/

