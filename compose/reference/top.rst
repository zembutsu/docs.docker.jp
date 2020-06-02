.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/top/
.. -------------------------------------------------------------------

.. title: docker-compose top

.. _docker-compose-top:

=======================================
docker-compose top
=======================================

.. ```none
   Usage: top [SERVICE...]

   ```
::

   利用方法: top [SERVICE...]

.. Displays the running processes.

実行中のプロセスを表示します。

.. ```bash
   $ docker-compose top
   compose_service_a_1
   PID    USER   TIME   COMMAND
   ----------------------------
   4060   root   0:00   top

   compose_service_b_1
   PID    USER   TIME   COMMAND
   ----------------------------
   4115   root   0:00   top
   ```

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
