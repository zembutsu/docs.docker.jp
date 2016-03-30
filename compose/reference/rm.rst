.. *- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/rm/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/reference/rm.md
   doc version: 1.10
      https://github.com/docker/compose/commits/master/docs/reference/rm.md
.. check date: 2016/03/07
.. Commits on Dec 18, 2015 2e9a49b4eb48d7611543bf5cb34130e8f5448dff
.. -------------------------------------------------------------------

.. rm

.. _compose-rm:

=======================================
rm
=======================================

.. code-block:: bash

   Usage: rm [options] [SERVICE...]
   
   Options:
   -f, --force   Don't ask to confirm removal
   -v            Remove volumes associated with containers

.. Removes stopped service containers.

停止済みのサービス・コンテナを削除します。

.. By default, volumes attached to containers will not be removed. You can see all volumes with docker volume ls.

デフォルトでは、コンテナにアタッチしているボリュームは削除されません。全てのボリュームは ``docker volume ls`` で確認できます。

.. Any data which is not in a volume will be lost.

（明示的に削除しなければ）ボリューム内にあるデータは失われません。

.. seealso:: 

   rm
      https://docs.docker.com/compose/reference/rm/
