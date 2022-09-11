.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/buildx/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/buildx.md
.. check date: 2022/02/26
.. -------------------------------------------------------------------

.. build

=======================================
docker buildx
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

説明
==========

.. Docker Buildx

Docker Buildx です。

.. Extended description

補足説明
==========

.. Extended build capabilities with BuildKit

構築機能を BuildKit で拡張します。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <buildx-examples>` をご覧ください。

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--builder``
     - 
     - builder 対象の設定を上書き

.. _buildx-examples:

使用例
==========

.. Override the configured builder instance (--builder)

builder 対象の設定を上書き (--builder)
----------------------------------------

.. You can also use the BUILDX_BUILDER environment variable.

``BUILDX_BUILDER`` 環境変数でも指定できます。

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI のベースコマンド。


.. Child commands

子コマンド
==========

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
   * - :doc:`docker buildx stop<buildx_top>`
     - ビルダー・インスタンスの停止
   * - :doc:`docker buildx use<buildx_use>`
     - 現在のビルダー・インスタンスを設定
   * - :doc:`docker buildx version<buildx_version>`
     - buildx バージョン情報を表示



.. seealso:: 

   docker buildx
      https://docs.docker.com/engine/reference/commandline/buildx/
