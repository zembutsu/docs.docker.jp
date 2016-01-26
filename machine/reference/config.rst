.. -*- coding: utf-8 -*-
.. https://docs.docker.com/machine/reference/config/
.. doc version: 1.9
.. check date: 2016/01/25
.. -----------------------------------------------------------------------------

.. config

.. _machine-config:

=======================================
config
=======================================

.. Show the Docker client configuration for a machine.

対象マシンに対する Docker クライアントの設定を表示します。

.. code-block:: bash

   $ docker-machine config dev
   --tlsverify
   --tlscacert="/Users/ehazlett/.docker/machines/dev/ca.pem"
   --tlscert="/Users/ehazlett/.docker/machines/dev/cert.pem"
   --tlskey="/Users/ehazlett/.docker/machines/dev/key.pem"
   -H tcp://192.168.99.103:2376
