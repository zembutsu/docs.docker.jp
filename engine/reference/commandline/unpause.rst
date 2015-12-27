.. -*- coding: utf-8 -*-
.. https://docs.docker.com/engine/reference/commandline/unpause/
.. doc version: 1.9
.. check date: 2015/12/27
.. -----------------------------------------------------------------------------

.. unpause

=======================================
unpause
=======================================

.. code-block:: bash

   Usage: docker unpause [OPTIONS] CONTAINER [CONTAINER...]
   
   Unpause all processes within a container
   
     --help=false    Print usage

.. The docker unpause command uses the cgroups freezer to un-suspend all processes in a container.

``docker unpause`` コマンドは、 cgroup freezer を使ってコンテナ内で一時停止している全てのプロセスを再開します。

.. See the cgroups freezer documentation for further details.

より詳細については `cgroups freezer ドキュメント <https://www.kernel.org/doc/Documentation/cgroups/freezer-subsystem.txt>`_ をご覧ください。

