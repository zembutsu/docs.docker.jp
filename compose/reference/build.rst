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

   使い方: build [オプション] [--build-arg key=val...] [サービス...]
   
   オプション:
   --force-rm              常に中間コンテナを削除
   --no-cache              構築時にイメージのキャッシュを使わない
   --pull                  常に新しいバージョンのイメージ取得を試みる
   --build-arg key=val     サービスに対してビルド時の変数を設定する

.. Services are built once and then tagged, by default as `project_service`, e.g.,
   `composetest_db`. If the Compose file specifies an
   [image](/compose/compose-file/index.md#image) name, the image will be
   tagged with that name, substituting any variables beforehand. See [variable
   substitution](#variable-substitution)

サービスは ``プロジェクト名_サービス`` として構築時にタグ付けられます。
例えば ``composetest_db`` です。
Compose ファイルが :doc:`イメージ </compose/compose-file>` 名を指定している場合、イメージはその名称によってタグづけされます。変数が用いられている場合は、あらかじめ置換されます。
これについては :doc:`変数置換 </compose/compose-file>` を参照してください。

.. If you change a service's Dockerfile or the contents of its
   build directory, run `docker-compose build` to rebuild it.

サービスの Dockerfile やビルドディレクトリの内容を変更する場合は、``docker-compose build`` を実行して再ビルドします。

.. seealso:: 

   build
      https://docs.docker.com/compose/reference/build/
