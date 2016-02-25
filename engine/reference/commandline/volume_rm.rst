.. *- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/volume_rm/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/volume_rm.md
   doc version: 1.10
      https://github.com/docker/docker/commits/master/docs/reference/commandline/volume_rm.md
.. check date: 2016/02/25
.. Commits on Feb 10, 2016 910ea8adf6c2c94fdb3748893e5b1e51a6b8c431
.. -------------------------------------------------------------------

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

関連情報
==========

* :doc:`volume_create`
* :doc:`volume_inspect`
* :doc:`volume_ls`
* :doc:`/engine/userguide/containers/dockervolumes`
