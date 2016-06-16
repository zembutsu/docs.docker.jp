.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/kill/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/kill.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/kill.md
.. check date: 2016/06/16
.. Commits on Dec 24, 2015 e6115a6c1c02768898b0a47e550e6c67b433c436
.. -------------------------------------------------------------------

.. kill

=======================================
kill
=======================================

.. code-block:: bash

   使い方: docker kill [オプション] コンテナ [コンテナ...]
   
   実行中のコンテナを SIGKILL か指定したシグナルで停止
   
     --help                 使い方の表示
     -s, --signal="KILL"    コンテナに送信するシグナル
   
.. The main process inside the container will be sent SIGKILL, or any signal specified with option --signal.

コンテナの中のメイン・プロセス（ PID 1 ）に対して ``SIGKILL`` を送信するか、 ``--signal`` オプションで指定したシグナルを送信します。

..    Note: ENTRYPOINT and CMD in the shell form run as a subcommand of /bin/sh -c, which does not pass signals. This means that the executable is not the container’s PID 1 and does not receive Unix signals.

.. note::

   ``ENTRYPOINT`` と ``CMD`` を *シェル* 形式で実行している場合は、 ``/bin/sh -c`` のサブコマンドとして実行されていますので、シグナルを受け取ることができません。つまり、（シェル形式では）コンテナの PID 1 は Unix シグナルを受け取りません。

.. seealso:: 

   kill
      https://docs.docker.com/engine/reference/commandline/kill/
