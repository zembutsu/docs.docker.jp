.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/down/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/reference/down.md
   doc version: 1.10
      https://github.com/docker/compose/commits/master/docs/reference/down.md
.. check date: 2016/03/07
.. Commits on Feb 3, 2016 a713447e0b746838ebaed192cadd4cbd3caba2af
.. -------------------------------------------------------------------

.. down

.. _compose-down:

=======================================
down
=======================================

.. Stop containers and remove containers, networks, volumes, and images
.. created by `up`. Only containers and networks are removed by default.

コンテナを停止し、 ``up`` で作成されたコンテナ・ネットワーク・ボリューム・イメージを削除します。デフォルトではコンテナとネットワークのみ削除します。


.. code-block:: bash

   Usage: down [options]
   
   Options:
       --rmi type      Remove images, type may be one of: 'all' to remove
                       all images, or 'local' to remove only images that
                       don't have an custom name set by the `image` field
       -v, --volumes   Remove data volumes

.. seealso:: 

   down
      https://docs.docker.com/compose/reference/down/

