.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/create/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/reference/create.md
   doc version: 1.10
      https://github.com/docker/compose/commits/master/docs/reference/create.md
.. check date: 2016/03/07
.. Commits on Jan 7, 2016 0bca8d9cb39a01736f2ce043f2ea7b6407ffc281
.. -------------------------------------------------------------------

.. create

.. _compose-create:

=======================================
create
=======================================

.. code-block:: bash

   create
   
   Usage: create [options] [SERVICE...]
   
   Options:
   --force-recreate       Recreate containers even if their configuration and
                          image haven't changed. Incompatible with --no-recreate.
   --no-recreate          If containers already exist, don't recreate them.
                          Incompatible with --force-recreate.
   --no-build             Don't build an image, even if it's missing

.. Creates containers for a service.

サービス用のコンテナを作成します。

.. seealso:: 

   create
      https://docs.docker.com/compose/reference/create/
