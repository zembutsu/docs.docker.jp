.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/stop/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/stop.md
   doc version: 1.10
      https://github.com/docker/docker/commits/master/docs/reference/commandline/stop.md
.. check date: 2016/02/25
.. Commits on Dec 24, 2015 e6115a6c1c02768898b0a47e550e6c67b433c436
.. -------------------------------------------------------------------

.. stop

=======================================
stop
=======================================

.. code-block:: bash

   Usage: docker stop [OPTIONS] CONTAINER [CONTAINER...]
   
   Stop a container by sending SIGTERM and then SIGKILL after a
   grace period
   
     --help             Print usage
     -t, --time=10      Seconds to wait for stop before killing it

.. The main process inside the container will receive SIGTERM, and after a grace period, SIGKILL.

コンテナ内のメイン・プロセスは ``SIGTERM`` を受信します。一定期間経過すると、 ``SIGKILL`` を送ります。

.. seealso:: 

   stop
      https://docs.docker.com/engine/reference/commandline/stop/
