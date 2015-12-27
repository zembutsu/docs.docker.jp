.. -*- coding: utf-8 -*-
.. https://docs.docker.com/engine/reference/commandline/stop/
.. doc version: 1.9
.. check date: 2015/12/27
.. -----------------------------------------------------------------------------

.. stop

=======================================
stop
=======================================

.. code-block:: bash

   Usage: docker stop [OPTIONS] CONTAINER [CONTAINER...]
   
   Stop a container by sending SIGTERM and then SIGKILL after a
   grace period
   
     --help=false       Print usage
     -t, --time=10      Seconds to wait for stop before killing it

.. The main process inside the container will receive SIGTERM, and after a grace period, SIGKILL.

コンテナ内のメイン・プロセスは ``SIGTERM`` を受信します。一定期間経過すると、 ``SIGKILL`` を送ります。
