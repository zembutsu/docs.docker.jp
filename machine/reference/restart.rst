.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/machine/reference/restart/
.. SOURCE: https://github.com/docker/machine/blob/master/docs/reference/restart.md
   doc version: 1.11
      https://github.com/docker/machine/commits/master/docs/reference/restart.md
.. check date: 2016/04/28
.. Commits on Feb 21, 2016 d7e97d04436601da26d24b199532652abe78770e
.. ----------------------------------------------------------------------------

.. restart

.. _machine-restart:

=======================================
restart
=======================================

.. code-block:: bash

   使い方: docker-machine restart [引数...]
   
   マシンを再起動
   
   説明:
      引数は１つまたは複数のマシン名

.. Restart a machine. Oftentimes this is equivalent to docker-machine stop; docker-machine start.

マシンを再起動します。これは ``docker-machine stop; docker-machine start`` の実行と同等です。

.. code-block:: bash

   $ docker-machine restart dev
   Waiting for VM to start...

.. seealso:: 

   restart
      https://docs.docker.com/machine/reference/restart/
