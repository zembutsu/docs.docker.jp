.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/machine/reference/active/
.. SOURCE: https://github.com/docker/machine/blob/master/docs/reference/active.md
   doc version: 1.10
      https://github.com/docker/machine/commits/master/docs/reference/active.md
.. check date: 2016/03/09
.. Commits on Jan 20, 2016 cda5d00bd8d898d07d1b41c0a8e8250fd4a34a50
.. ----------------------------------------------------------------------------

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
   staging   *        digitalocean   Running   tcp://203.0.113.81:2376
   $ echo $DOCKER_HOST
   tcp://203.0.113.81:2376
   $ docker-machine active
   staging

