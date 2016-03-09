.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/machine/reference/config/
.. SOURCE: https://github.com/docker/machine/blob/master/docs/reference/config.md
   doc version: 1.10
      https://github.com/docker/machine/commits/master/docs/reference/config.md
.. check date: 2016/03/09
.. Commits on Feb 21, 2016 d7e97d04436601da26d24b199532652abe78770e
.. ----------------------------------------------------------------------------

.. config

.. _machine-config:

=======================================
config
=======================================

.. Show the Docker client configuration for a machine.

対象マシンに対する Docker クライアントの設定を表示します。

.. code-block:: bash

   Usage: docker-machine config [OPTIONS] [arg...]
   
   Print the connection config for machine
   
   Description:
      Argument is a machine name.
   
   Options:
   
      --swarm      Display the Swarm config instead of the Docker daemon

実行例：

.. code-block:: bash

   $ docker-machine config dev
   --tlsverify
   --tlscacert="/Users/ehazlett/.docker/machines/dev/ca.pem"
   --tlscert="/Users/ehazlett/.docker/machines/dev/cert.pem"
   --tlskey="/Users/ehazlett/.docker/machines/dev/key.pem"
   -H tcp://192.168.99.103:2376
