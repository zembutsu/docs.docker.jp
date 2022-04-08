.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/top/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/compose/reference/top.md
.. check date: 2022/04/09
.. Commits on Jan 28, 2022 b6b19516d0feacd798b485615ebfee410d9b6f86
.. -------------------------------------------------------------------

.. docker-compose top
.. _docker-compose-top:

=======================================
docker-compose top
=======================================

.. code-block:: bash

   使い方: docker-compose top [SERVICE...]

.. Displays the running processes.

実行中のプロセスを表示します。

.. code-block:: bash

   $ docker-compose top
   compose_service_a_1
   PID    USER   TIME   COMMAND
   ----------------------------
   4060   root   0:00   top

   compose_service_b_1
   PID    USER   TIME   COMMAND
   ----------------------------
   4115   root   0:00   top

.. seealso:: 

   docker-compose top
      https://docs.docker.com/compose/reference/top/
