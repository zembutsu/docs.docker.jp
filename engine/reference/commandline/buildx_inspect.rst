.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/buildx_inspect/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/buildx_inspect.md
.. check date: 2022/03/05
.. -------------------------------------------------------------------

=======================================
docker buildx inspect
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

説明
==========

.. Inspect current builder instance

現在のビルダー・インスタンスを調査します。

使い方
==========

.. code-block:: dockerfile

   $ docker buildx inspect [NAME]

.. Extended description

補足説明
==========

.. Shows information about the current or specified builder.

現在の、または特定のビルダに関する情報を表示します。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <buildx_inspect-examples>` をご覧ください。

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--bootstrap``
     - 
     - 調査前にビルダの起動を確認
   * - ``--builder``
     - 
     - ビルダー・インスタンスの設定を上書き

.. _buildx_inspect-examples:

使用例
==========

.. Ensure that the builder is running before inspecting (--bootstrap)

調査前にビルダが実行中かどうか確認（--bootstrap）
--------------------------------------------------

.. Use the --bootstrap option to ensure that the builder is running before inspecting it. If the driver is docker-container, then --bootstrap starts the buildkit container and waits until it is operational. Bootstrapping is automatically done during build, and therefore not necessary. The same BuildKit container is used during the lifetime of the associated builder node (as displayed in buildx ls).

``--bootstrap`` オプションを使い、ビルダ対象を調査する前に、実行チュかどうかを確認します。もしもドライバが ``docker-container`` の場合は、 ``--bootstrap`` は buildkit コンテナを起動し、処理を始めるまで待機します。構築にあたり、起動処理は自動的に行われますので、必須ではありません。関連するビルダ・ノードが動作している間（ ``buildx ls`` で表示）、同じ BuildKit コンテナが使われます。

.. Override the configured builder instance (--builder)

builder 対象の設定を上書き (--builder)
----------------------------------------

.. Same as buildx --builder.

``buildx --builder`` と同じです。

.. Get information about a builder instance

ビルダ・インスタンスの情報を取得
----------------------------------------

.. By default, inspect shows information about the current builder. Specify the name of the builder to inspect to get information about that builder. The following example shows information about a builder instance named elated_tesla:

デフォルトでは、 ``inspect`` は現在のビルダに関する情報を表示します。指定したビルダ名に関する情報を取得し、表示します。以下の例は、 ``elated_tesla`` という名前のビルダー・インスタンスの情報を表示します。

.. code-block:: bash

   $  docker buildx inspect elated_tesla
   Name:   elated_tesla
   Driver: docker-container
   
   Nodes:
   Name:      elated_tesla0
   Endpoint:  unix:///var/run/docker.sock
   Status:    running
   Platforms: linux/amd64
   
   Name:      elated_tesla1
   Endpoint:  ssh://ubuntu@1.2.3.4
   Status:    running
   Platforms: linux/arm64, linux/arm/v7, linux/arm/v6

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`buildx`
     - Docker Buildx

子コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`buildx_inspect_create`
     - ソース・イメージを元に新しいイメージを作成
   * - :doc:`buildx_inspect_inspect`
     - レジストリ内のイメージ詳細を表示


.. Related commands

関連コマンド
====================

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker buildx bake<buildx_bake>`
     - ファイルから構築
   * - :doc:`docker buildx build<buildx_build>`
     - 構築開始
   * - :doc:`docker buildx create<buildx_create>`
     - 新しいビルダー・インスタンスを作成
   * - :doc:`docker buildx du<buildx_du>`
     - ディスク使用量
   * - :doc:`docker buildx imagetools<buildx_imagetools>`
     - レジストリにあるイメージを操作するコマンド
   * - :doc:`docker buildx inspect<buildx_inspect>`
     - 現在のビルダー・インスタンスを調査
   * - :doc:`docker buildx ls<buildx_ls>`
     - ビルダー・インスタンス一覧
   * - :doc:`docker buildx prune<buildx_prune>`
     - 構築キャッシュの削除
   * - :doc:`docker buildx rm<buildx_rm>`
     - ビルダー・インスタンスの削除
   * - :doc:`docker buildx stop<buildx_stop>`
     - ビルダー・インスタンスの停止
   * - :doc:`docker buildx use<buildx_use>`
     - 現在のビルダー・インスタンスを設定
   * - :doc:`docker buildx version<buildx_version>`
     - buildx バージョン情報を表示



.. seealso:: 

   docker buildx inspect
      https://docs.docker.com/engine/reference/commandline/buildx_inspect/
