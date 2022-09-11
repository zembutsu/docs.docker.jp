.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/buildx_rm/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/buildx_rm.md
.. check date: 2022/03/05
.. -------------------------------------------------------------------

=======================================
docker buildx rm
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

説明
==========

.. Remove a builder instance

ビルダ・インスタンスを削除します。

使い方
==========

.. code-block:: bash

   $ docker buildx rm [NAME]

.. Extended description

補足説明
==========

.. Removes the specified or current builder. It is a no-op attempting to remove the default builder.

特定のビルダ、もしくは現在のビルダを削除します。デフォルトのビルダを削除しようとしても、操作できません。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <buildx_rm-examples>` をご覧ください。

.. _buildx_rm-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--keep-state``
     - 
     - BuildKit の状態を維持する
   * - ``--builder``
     - 
     - 設定したビルダインスタンスを上書き

.. _buildx_rm-examples:

使用例
==========

.. Override the configured builder instance (--builder)

builder 対象の設定を上書き (--builder)
----------------------------------------

.. Same as buildx --builder.

``buildx --builder`` と同じです。

.. Keep BuildKit state (--keep-state)

BuildKit の状態を維持（--keep-state）
----------------------------------------

.. Keep BuildKit state, so it can be reused by a new builder with the same name. Currently, only supported by the docker-container driver.

BuildKit の状態を維持します。そのため、新しいビルダは同じ名前で再利用できます。現在サポートしているのは :ref:`docker-container ドライバ <buildx_create-driver>` のみです。

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`buildx`
     - Docker Buildx


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

   docker buildx rm
      https://docs.docker.com/engine/reference/commandline/buildx_rm/
