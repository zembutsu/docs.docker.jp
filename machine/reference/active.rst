.. -*- coding: utf-8 -*-
.. https://docs.docker.com/machine/reference/active/
.. doc version: 1.9
.. check date: 2016/01/25
.. -----------------------------------------------------------------------------

.. active

.. _machine-active:

=======================================
active
=======================================

.. See which machine is “active” (a machine is considered active if the DOCKER_HOST environment variable points to it).

どのマシンが「アクティブ」かを表示します（ Docker Machine は ``DOCKER_HOST`` 環境変数が示すところをアクティブとみなします ）。

.. code-block:: bash

   $ docker-machine ls
   NAME      ACTIVE   DRIVER         STATE     URL
   dev       -        virtualbox     Running   tcp://192.168.99.103:2376
   staging   *        digitalocean   Running   tcp://104.236.50.118:2376
   $ echo $DOCKER_HOST
   tcp://104.236.50.118:2376
   $ docker-machine active
   staging

