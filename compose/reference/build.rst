.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/build/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/reference/build.md
   doc version: 1.13
      https://github.com/docker/compose/commits/master/docs/reference/build.md
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/compose/reference/build.md
.. check date: 2022/04/08
.. Commits on Jan 28, 2022 b6b19516d0feacd798b485615ebfee410d9b6f86
.. -------------------------------------------------------------------

.. build

.. _compose-build:

=======================================
docker-compose build
=======================================

.. code-block:: bash

   使い方: docker-compose build [オプション] [--build-arg key=val...] [サービス...]
   
   オプション:
       --build-arg key=val     サービスに対し、構築時の変数を指定
       --compress              構築コンテクストを gzip で圧縮
       --force-rm              中間コンテナを常に削除
       -m, --memory MEM        構築コンテナのメモリ制限を指定
       --no-cache              イメージの構築時、キャッシュを使用しない
       --no-rm                 構築に成功しても、中間コンテナは削除しない
       --parallel              並列にイメージを構築
       --progress string       進捗の出力形式を指定 (`auto`, `plain`, `tty`).
       --pull                  常に新しいバージョンのイメージ取得を試みる
       -q, --quiet             標準出力に何も表示しない

.. Services are built once and then tagged, by default as project_service. For example, composetest_db. If the Compose file specifies an image name, the image is tagged with that name, substituting any variables beforehand. See variable substitution.

サービスは構築後、タグ付けされます。タグのデフォルトは ``project_service`` です。たとえば、 ``composetest_db`` です。Compose ファイルで :ref:`イメージ名 <compose-file-v3-image>` を指定している場合、イメージはその名前でタグ付けされ、事前に設定していた変数を置換します。詳しくは :ref:`変数の置き換え <compose-file-v3-variable-substitution>` をご覧ください。

.. If you change a service's Dockerfile or the contents of its build directory, run docker-compose build to rebuild it.

サービスの Dockerfile や、構築コンテクストがあるディレクトリに変更を加えると、 ``docker-compose build`` の実行時にイメージを再構築します。

.. Native build using the docker CLI
.. _native-build-using-the-docker-cli:
docker CLI を使った :ruby:`ネイティブ <native>` ビルド
==================================================

.. Compose by default uses the docker CLI to perform builds (also known as "native build"). By using the docker CLI, Compose can take advantage of features such as BuildKit, which are not supported by Compose itself. BuildKit is enabled by default on Docker Desktop, but requires the DOCKER_BUILDKIT=1 environment variable to be set on other platforms.

Compose は構築処理に、デフォルトで ``docker`` CLI を使います（ :ruby:`ネイティブ ビルド <native build>` としても知られています）。 ``docker`` CLI を使うので、Compose は自身がサポートしていない :doc:`BuildKit </develop/develop-images/build_enhancements>` のような機能を活用できます。Docker Desktop では BuildKit がデフォルトで有効ですが、その他のプラットフォームでは環境変数 ``DOCKER_BUILDKIT=1`` の指定が必要です。

.. Refer to the Compose CLI environment variables section to learn how to switch between "native build" and "compose build".

「ネイティブ ビルド」と「compose ビルド」を切り替える方法を学ぶには、 :ref:`Compose CLI 環境変数 <env-compose_docker_cli_build>` のセクションをご覧ください。

.. seealso:: 

   docker-compose build
      https://docs.docker.com/compose/reference/build/
