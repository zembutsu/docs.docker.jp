.. *- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/build/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/reference/build.md
   doc version: 1.10
      https://github.com/docker/compose/commits/master/docs/reference/build.md
.. check date: 2016/03/07
.. Commits on Nov 11, 2015 c5c36d8b006d9694c34b06e434e08bb17b025250
.. -------------------------------------------------------------------

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
