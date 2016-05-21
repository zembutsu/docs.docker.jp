.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/machine/reference/kill/
.. SOURCE: https://github.com/docker/machine/blob/master/docs/reference/kill.md
   doc version: 1.11
      https://github.com/docker/machine/commits/master/docs/reference/kill.md
.. check date: 2016/04/28
.. Commits on Feb 21, 2016 d7e97d04436601da26d24b199532652abe78770e
.. ----------------------------------------------------------------------------

.. kill

.. _machine-kill:

=======================================
kill
=======================================

.. code-block:: bash

   使い方: docker-machine kill [引数...]
   
   マシンを KILL (強制停止)する。
   
   説明:
      引数は１つまたは複数のマシン名

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

.. seealso:: 

   kill
      https://docs.docker.com/machine/reference/kill/

