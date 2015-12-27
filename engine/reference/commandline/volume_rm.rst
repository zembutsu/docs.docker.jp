.. -*- coding: utf-8 -*-
.. https://docs.docker.com/engine/reference/commandline/volume_rm/
.. doc version: 1.9
.. check date: 2015/12/27
.. -----------------------------------------------------------------------------

.. volume rm

=======================================
volume rm
=======================================

.. code-block:: bash

   Usage: docker volume rm [OPTIONS] VOLUME [VOLUME...]
   
   Remove a volume
   
     --help=false       Print usage

.. Removes one or more volumes. You cannot remove a volume that is in use by a container.

１つまたは複数のボリュームを削除できます。コンテナが使用中のボリュームは削除できません。

.. code-block:: bash

   $ docker volume rm hello
   hello

