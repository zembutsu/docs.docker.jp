.. -*- coding: utf-8 -*-
.. https://docs.docker.com/machine/reference/stop/
.. doc version: 1.9
.. check date: 2016/01/28
.. -----------------------------------------------------------------------------

.. stop

.. _machine-stop:

=======================================
stop
=======================================

.. Gracefully stop a machine.

マシンを丁寧に（gracefully）停止します。

.. code-block:: bash

   $ docker-machine ls
   NAME   ACTIVE   DRIVER       STATE     URL
   dev    *        virtualbox   Running   tcp://192.168.99.104:2376
   $ docker-machine stop dev
   $ docker-machine ls
   NAME   ACTIVE   DRIVER       STATE     URL
   dev    *        virtualbox   Stopped

