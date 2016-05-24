.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/build/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/reference/build.md
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/reference/build.md
.. check date: 2016/04/28
.. Commits on Nov 11, 2015 c5c36d8b006d9694c34b06e434e08bb17b025250
.. -------------------------------------------------------------------

.. build

.. _compose-build:

=======================================
build
=======================================

.. code-block:: bash

   使い方: build [オプション] [サービス...]
   
   オプション:
   --force-rm  常に中間コンテナを削除
   --no-cache  構築時にイメージのキャッシュを使わない
   --pull      常に新しいバージョンのイメージ取得を試みる

.. Services are built once and then tagged as project_service, e.g., composetest_db. If you change a service’s Dockerfile or the contents of its build directory, run docker-compose build to rebuild it.

サービスは ``プロジェクト名_サービス`` として構築時にタグ付けられます。例： ``composetest_db`` 。サービスの Dockerfile や構築ディレクトリの内容に変更を加える場合は、 ``docker-compose build`` で再構築を実行します。

.. seealso:: 

   build
      https://docs.docker.com/compose/reference/build/
