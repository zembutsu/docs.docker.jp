.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/create/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/reference/create.md
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/reference/create.md
.. check date: 2016/04/28
.. Commits on Mar 3, 2016 e1b87d7be0aa11f5f87762635a9e24d4e8849e77
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
       --no-build             Don't build an image, even if it's missing.
       --build                Build images before creating containers.

.. Creates containers for a service.

サービス用のコンテナを作成します。

.. seealso:: 

   create
      https://docs.docker.com/compose/reference/create/
