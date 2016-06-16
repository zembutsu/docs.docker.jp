.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/volume_rm/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/volume_rm.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/volume_rm.md
.. check date: 2016/04/28
.. Commits on Jun 14, 2016 8eca8089fa35f652060e86906166dabc42e556f8
.. -------------------------------------------------------------------

.. volume rm

=======================================
volume rm
=======================================

.. code-block:: bash

   使い方: docker volume rm [オプション] ボリューム [ボリューム...]
   
   ボリュームを削除
  
     --help=false       使い方の表示

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

.. seealso:: 

   volume rm
      https://docs.docker.com/engine/reference/commandline/volume_rm/
