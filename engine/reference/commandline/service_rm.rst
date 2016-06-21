.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/service_rm/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/service_rm.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/service_rm.md
.. check date: 2016/06/21
.. Commits on Jun 20, 2016 daedbc60d61387cb284b871145b672006da1b6de
.. -------------------------------------------------------------------

.. service rm

.. _reference-service-rm:

=======================================
service rm
=======================================

.. code-block:: bash

   使い方:  docker service rm [オプション] サービス
   
   サービスの削除（remove）
   
   エイリアス:
     rm, remove
   
   オプション:
         --help   使い方の表示

.. Removes the specified services from the swarm. This command has to be run targeting a manager node.

swarm から指定したサービスを削除します。このコマンドの実行対象はマネージャ・ノードです。

.. For example, to remove the redis service:

例えば redis サービスを削除します。

.. code-block:: bash

   $ docker service rm redis
   redis
   $ docker service ls
   ID            NAME   SCALE  IMAGE        COMMAND

..    Warning: Unlike docker rm, this command does not ask for confirmation before removing a running service.

.. warning::

   ``docker rm`` とは異なり、このコマンドは実行中のサービスを停止しようとしても、確認を訊ねません。


関連情報
----------

* :doc:`service_create`
* :doc:`service_inspect`
* :doc:`service_ls`
* :doc:`service_scale`
* :doc:`service_tasks`
* :doc:`service_update`

.. seealso:: 

   service rm
      https://docs.docker.com/engine/reference/commandline/service_rm/

