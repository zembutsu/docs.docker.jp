.. -*- coding: utf-8 -*-
.. https://docs.docker.com/machine/reference/kill/
.. doc version: 1.9
.. check date: 2016/01/28
.. -----------------------------------------------------------------------------

.. kill

.. _machine-kill:

=======================================
kill
=======================================

.. Kill (abruptly force stop) a machine.

マシンを kill （強制的に即時停止）します。

.. code-block:: bash

   $ docker-machine ls
   NAME   ACTIVE   DRIVER       STATE     URL
   dev    *        virtualbox   Running   tcp://192.168.99.104:2376
   $ docker-machine kill dev
   $ docker-machine ls
   NAME   ACTIVE   DRIVER       STATE     URL
   dev    *        virtualbox   Stopped


