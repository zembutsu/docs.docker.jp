.. *- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/pause/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/pause.md
   doc version: 1.10
      https://github.com/docker/docker/commits/master/docs/reference/commandline/pause.md
.. check date: 2016/02/25
.. Commits on Dec 24, 2015 e6115a6c1c02768898b0a47e550e6c67b433c436
.. -------------------------------------------------------------------

.. pause

=======================================
pause
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. code-block:: bash

   Usage: docker pause [OPTIONS] CONTAINER [CONTAINER...]
   
   Pause all processes within a container
   
     --help          Print usage

.. The docker pause command uses the cgroups freezer to suspend all processes in a container. Traditionally, when suspending a process the SIGSTOP signal is used, which is observable by the process being suspended. With the cgroups freezer the process is unaware, and unable to capture, that it is being suspended, and subsequently resumed.

``docker pause`` コマンドは cgroup を凍結（freezer）するもので、コンテナ内の全てのプロセスを一時停止（suspend）します。これまで、プロセスの一時停止には ``SIGSTOP`` シグナルが使われてきました。これはプロセスが一時停止状態に見えるようにするためのものです。cgroup の凍結により、プロセスの状態は分からなくなり、操作できなくなります。再開されるまで、一時停止状態のままです。

.. See the cgroups freezer documentation for further details.

更に詳しい詳細については `cgroup freezer ドキュメント <https://www.kernel.org/doc/Documentation/cgroups/freezer-subsystem.txt>`_ をご覧ください。

.. seealso:: 

   pause
      https://docs.docker.com/engine/reference/commandline/pause/
