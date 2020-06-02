.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/bundle/
.. -------------------------------------------------------------------

.. title: docker-compose bundle

.. _docker-compose-bundle:

=======================================
docker-compose bundle
=======================================

.. ```
   Usage: bundle [options]
   
   Options:
       --push-images              Automatically push images for any services
                                  which have a `build` option specified.
   
       -o, --output PATH          Path to write the bundle file to.
                                  Defaults to "<project name>.dab".
   ```
.. code-block:: bash

   利用方法: bundle [オプション]

   オプション:
       --push-images              `build` オプションが指定されているサービス
                                  のイメージをすべて自動的にプッシュします。

       -o, --output PATH          バンドルファイルの出力パスを指定します。


.. Generate a Distributed Application Bundle (DAB) from the Compose file.

Compose ファイルから分散アプリケーションバンドル（Distributed Application Bundle; DAB）を生成します。

.. Images must have digests stored, which requires interaction with a
   Docker registry. If digests aren't stored for all images, you can fetch
   them with `docker-compose pull` or `docker-compose push`. To push images
   automatically when bundling, pass `--push-images`. Only services with
   a `build` option specified have their images pushed.

イメージにはダイジェスト値が保存されていなければなりません。
この値は Docker レジストリとのやり取りにおいて必要になります。
ダイジェスト値がイメージすべてに保存されていないときは、``docker-compose pull`` または ``docker-compose push`` の実行によって取得することができます。
バンドルを生成すると同時に、自動的にイメージをプッシュするには ``--push-images`` を指定してください。
``build`` オプションが指定されているサービスだけが、イメージをプッシュすることができます。

.. seealso:: 

   docker-compose bundle
      https://docs.docker.com/compose/reference/bundle/
