.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/buildx_imagetools_inspect/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/buildx_imagetools_inspect.md
.. check date: 2022/03/05
.. -------------------------------------------------------------------

=======================================
docker buildx imagetools inspect
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

説明
==========

.. Show details of image in the registry

レジストリ内のイメージ詳細を表示します。

使い方
==========

.. code-block:: bash

   $ docker buildx imagetools inspect [OPTIONS] NAME

.. Extended description

補足説明
==========

.. Show details of image in the registry.

レジストリ内のイメージ詳細を表示します。

.. Example:

使用例：

.. code-block:: bash

   $ docker buildx imagetools inspect alpine
   
   Name:      docker.io/library/alpine:latest
   MediaType: application/vnd.docker.distribution.manifest.list.v2+json
   Digest:    sha256:28ef97b8686a0b5399129e9b763d5b7e5ff03576aa5580d6f4182a49c5fe1913
   
   Manifests:
     Name:      docker.io/library/alpine:latest@sha256:5c40b3c27b9f13c873fefb2139765c56ce97fd50230f1f2d5c91e55dec171907
     MediaType: application/vnd.docker.distribution.manifest.v2+json
     Platform:  linux/amd64
   
     Name:      docker.io/library/alpine:latest@sha256:c4ba6347b0e4258ce6a6de2401619316f982b7bcc529f73d2a410d0097730204
     MediaType: application/vnd.docker.distribution.manifest.v2+json
     Platform:  linux/arm/v6
     ...

コマンドの使用例は、以下の :ref:`使用例のセクション <buildx_imagetools_inspect-examples>` をご覧ください。

.. _buildx_create-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--raw``
     - 
     - オリジナルの JSON マニフェストを表示
   * - ``--builder``
     - 
     - 設定したビルダインスタンスを上書き

.. _buildx_imagetools_inspect-examples:

使用例
==========

.. Override the configured builder instance (--builder)

builder 対象の設定を上書き (--builder)
----------------------------------------

.. Same as buildx --builder.

``buildx --builder`` と同じです。

.. Show original, unformatted JSON manifest (--raw)

オリジナルの未フォーマット JSON マニフェストを表示（--raw）
------------------------------------------------------------

.. Use the --raw option to print the original JSON bytes instead of the formatted output.

``--raw`` オプション使い、フォーマット済みの出力ではなく、オリジナルの JSON を表示します。

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker buildx imagetools<buildx_imagetools>`
     - レジストリにあるイメージを操作するコマンド


.. Related commands

関連コマンド
====================

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`buildx_imagetools_create`
     - ソース・イメージを元に新しいイメージを作成
   * - :doc:`buildx_imagetools_inspect`
     - レジストリ内のイメージ詳細を表示


.. seealso:: 

   docker buildx imagetools inspect
      https://docs.docker.com/engine/reference/commandline/buildx_imagetools_inspect/
