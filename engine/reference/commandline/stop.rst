.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/stop/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/stop.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/stop.md
.. check date: 2016/06/16
.. Commits on Dec 24, 2015 e6115a6c1c02768898b0a47e550e6c67b433c436
.. -------------------------------------------------------------------

.. stop

=======================================
stop
=======================================

.. code-block:: bash

   使い方: docker stop [オプション] コンテナ [コンテナ...]
   
   コンテナに SIGTERM を送信し、一定期間後に SIGKILL を送信
   
     --help             使い方の表示
     -t, --time=10      kill で停止する前に待機する秒数

.. The main process inside the container will receive SIGTERM, and after a grace period, SIGKILL.

コンテナ内のメイン・プロセスは ``SIGTERM`` を受信します。一定期間経過すると、 ``SIGKILL`` を送ります。

.. seealso:: 

   stop
      https://docs.docker.com/engine/reference/commandline/stop/
