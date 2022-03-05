.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/buildx_imagetools_create/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/buildx_imagetools_create.md
.. check date: 2022/03/05
.. -------------------------------------------------------------------

=======================================
docker buildx imagetools create
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

説明
==========

.. Create a new image based on source images

ソース・イメージに基づく新しいイメージを作成します。

使い方
==========

.. code-block:: bash

   $ docker buildx imagetools create [OPTIONS] [SOURCE] [SOURCE...]

.. Extended description

補足説明
==========

.. Imagetools contains commands for working with manifest lists in the registry. These commands are useful for inspecting multi-platform build results.

imagetools は、レジストリ内のマニフェストリストを操作するコマンドを含みます。これらのコマンドはマルチプラットフォームの構築結果の調査に役立ちます。

.. Create a new manifest list based on source manifests. The source manifests can be manifest lists or single platform distribution manifests and must already exist in the registry where the new manifest is created. If only one source is specified, create performs a carbon copy.

ソース・マニフェストに基づき、新しいマニフェストリストを作成します。ソース・マニフェストは、マニフェストリストや特定プラットフォーム用のディストリビューション・マニフェストとすることができ、新しいマニフェストリストの作成時には、レジストリに存在していなくてはいけません。ソースを1つだけ指定する場合は、プラットフォームの複製を作成します。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <buildx_imagetools_create-examples>` をご覧ください。

.. _buildx_create-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--append``
     - 
     - 既存のマニフェストリストに追加
   * - ``--dry-run``
     - 
     - 送信（push）の代わりに最終イメージを表示
   * - ``--file`` , ``-f``
     - 
     - ソースを指定したファイルから読み込む
   * - ``--tag`` , ``-t`  
     - 
     - 新しいイメージの参照を設定
   * - ``--builder``
     - 
     - 設定したビルダインスタンスを上書き

.. _buildx_imagetools_create-examples:

使用例
==========

.. Append new sources to an existing manifest list (--append)

既存のマニフェストリストに新しいソースを追加（--append）
------------------------------------------------------------

.. Use the --append flag to append the new sources to an existing manifest list in the destination.

``--append`` フラグを使い、出力先で既存のマニフェスト・リストに新しいソースを追加します。

.. Override the configured builder instance (--builder)

builder 対象の設定を上書き (--builder)
----------------------------------------

.. Same as buildx --builder.

``buildx --builder`` と同じです。

.. Show final image instead of pushing (--dry-run)

送信の代わりに最終イメージを表示（--dry-run）
--------------------------------------------------

.. Use the --dry-run flag to not push the image, just show it.

``--dry-run`` フラグを使えばイメージを送信せず、単に表示します。

.. Read source descriptor from a file (-f, --file)

ソースを指定したファイルから読み込む（--f, --file）
------------------------------------------------------------

.. code-block:: bash

   -f FILE or --file FILE

.. Reads source from files. A source can be a manifest digest, manifest reference, or a JSON of OCI descriptor object.

ファイルからソースを読み込みます。ソースとして扱えるのは、マニフェストのダイジェスト値、マニフェスト・リファレンス、OCI デスクリプタ・オブジェクトの JSON です。

.. In order to define annotations or additional platform properties like os.version and os.features you need to add them in the OCI descriptor object encoded in JSON.

アノテーションの定義や、 ``os.version`` と ``os.features`` のようなプラットフォームのプロパティを追加するには、それらを JSON でエンコードした OCI デスクリプタ・オブジェクトで追加する必要があります。

.. code-block:: bash

   docker buildx imagetools inspect --raw alpine | jq '.manifests[0] | .platform."os.version"="10.1"' > descr.json
   docker buildx imagetools create -f descr.json myuser/image

.. The descriptor in the file is merged with existing descriptor in the registry if it exists.

レジストリ内に既存のデスクリプタが存在する場合、デスクプリタにファイルを統合します。

.. The supported fields for the descriptor are defined in OCI spec .

デスクリプタとしてサポートしているフィールドは、 `OCI 仕様 <https://github.com/opencontainers/image-spec/blob/master/descriptor.md#properties>`_ で定義されています。

.. Set reference for new image (-t, --tag)

新しいイメージのリファレンスを設定（-t, --tag）
--------------------------------------------------

.. code-block:: bash

   -t IMAGE or --tag IMAGE

.. Use the -t or --tag flag to set the name of the image to be created.

``-t`` か ``--tag`` フラグを使い、作成したイメージに名前を指定します。

.. Examples

使用例
^^^^^^^^^^

.. code-block:: bash

   $ docker buildx imagetools create --dry-run alpine@sha256:5c40b3c27b9f13c873fefb2139765c56ce97fd50230f1f2d5c91e55dec171907 sha256:c4ba6347b0e4258ce6a6de2401619316f982b7bcc529f73d2a410d0097730204
   
   $ docker buildx imagetools create -t tonistiigi/myapp -f image1 -f image2

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

   docker buildx imagetools create
      https://docs.docker.com/engine/reference/commandline/buildx_imagetools_create/
