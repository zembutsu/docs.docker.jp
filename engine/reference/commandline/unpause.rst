.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/unpause/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/unpause.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/unpause.md
.. check date: 2016/06/16
.. Commits on May 27, 2016 ee7696312580f14ce7b8fe70e9e4cbdc9f83919f
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

より詳細については `cgroups freezer ドキュメント <https://www.kernel.org/doc/Documentation/cgroup-v1/freezer-subsystem.txt>`_ をご覧ください。

.. seealso:: 

   unpause
      https://docs.docker.com/engine/reference/commandline/unpause/
