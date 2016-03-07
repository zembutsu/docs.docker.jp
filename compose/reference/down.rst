.. *- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/down/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/reference/down.md
   doc version: 1.10
      https://github.com/docker/compose/commits/master/docs/reference/down.md
.. check date: 2016/03/07
.. Commits on Jan 7, 2016 0bca8d9cb39a01736f2ce043f2ea7b6407ffc281
.. -------------------------------------------------------------------

.. down

.. _compse-down:

=======================================
down
=======================================

.. code-block:: bash

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


