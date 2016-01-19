.. -*- coding: utf-8 -*-
.. https://docs.docker.com/compose/reference/build/
.. doc version: 1.9
.. check date: 2016/01/18
.. -----------------------------------------------------------------------------

.. build

.. _compse-build:

=======================================
build
=======================================

.. code-block:: bash

   Usage: build [options] [SERVICE...]
   
   Options:
   --force-rm  Always remove intermediate containers.
   --no-cache  Do not use cache when building the image.
   --pull      Always attempt to pull a newer version of the image.

.. Services are built once and then tagged as project_service, e.g., composetest_db. If you change a service’s Dockerfile or the contents of its build directory, run docker-compose build to rebuild it.

サービスは ``project_サービス`` として構築時にタグ付けられます。例： ``composetest_db`` 。サービスの Dockerfile や構築痔レクトリの内容に変更を加える場合は、 ``docker-compose build`` で再構築を実行します。
