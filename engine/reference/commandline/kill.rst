.. -*- coding: utf-8 -*-
.. https://docs.docker.com/engine/reference/commandline/kill/
.. doc version: 1.9
.. check date: 2015/12/26
.. -----------------------------------------------------------------------------

.. kill

=======================================
kill
=======================================

.. code-block:: bash

   Usage: docker kill [OPTIONS] CONTAINER [CONTAINER...]
   
   Kill a running container using SIGKILL or a specified signal
   
     --help=false           Print usage
     -s, --signal="KILL"    Signal to send to the container
   
.. The main process inside the container will be sent SIGKILL, or any signal specified with option --signal.

コンテナの中のメイン・プロセス（ PID 1 ）に対して ``SIGKILL`` を送信するか、 ``--signal`` オプションで指定したシグナルを送信します。

..    Note: ENTRYPOINT and CMD in the shell form run as a subcommand of /bin/sh -c, which does not pass signals. This means that the executable is not the container’s PID 1 and does not receive Unix signals.

.. note::

   ``ENTRYPOINT`` と ``CMD`` を *シェル *形式で実行している場合は、 ``/bin/sh -c`` のサブコマンドとして実行されていますので、シグナルを受け取ることができません。つまり、（シェル軽視気では）コンテナの PID 1 は Unix シグナルを受け取りません。
