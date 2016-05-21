.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/machine/reference/stop/
.. SOURCE: https://github.com/docker/machine/blob/master/docs/reference/stop.md
   doc version: 1.11
      https://github.com/docker/machine/commits/master/docs/reference/stop.md
.. check date: 2016/04/28
.. Commits on Feb 21, 2016 d7e97d04436601da26d24b199532652abe78770e
.. ----------------------------------------------------------------------------

.. stop

.. _machine-stop:

=======================================
stop
=======================================

.. code-block:: bash

   使い方: docker-machine stop [引数...]
   
   マシンを丁寧に (Gracefully) に停止
   
   説明:
      引数は１つまたは複数のマシン名

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

.. seealso:: 

   stop
      https://docs.docker.com/machine/reference/stop/
