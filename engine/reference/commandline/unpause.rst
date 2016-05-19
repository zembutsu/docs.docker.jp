.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/unpause/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/unpause.md
   doc version: 1.11
      https://github.com/docker/docker/commits/master/docs/reference/commandline/unpause.md
.. check date: 2016/04/28
.. Commits on Dec 24, 2015 e6115a6c1c02768898b0a47e550e6c67b433c436
.. -------------------------------------------------------------------

.. unpause

=======================================
unpause
=======================================

.. code-block:: bash

   使い方: docker unpause [オプション] コンテナ [コンテナ...]
   
   コンテナ内の全てのプロセスに対し、一時停止を解除
   
     --help         使い方の表示

.. The docker unpause command uses the cgroups freezer to un-suspend all processes in a container.

``docker unpause`` コマンドは、 cgroup freezer を使ってコンテナ内で一時停止している全プロセスを再開します。

.. See the cgroups freezer documentation for further details.

より詳細については `cgroups freezer ドキュメント <https://www.kernel.org/doc/Documentation/cgroups/freezer-subsystem.txt>`_ をご覧ください。

.. seealso:: 

   unpause
      https://docs.docker.com/engine/reference/commandline/unpause/
