.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/buildx_stop/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/buildx_stop.md
.. check date: 2022/03/05
.. -------------------------------------------------------------------

=======================================
docker buildx stop
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

説明
==========

.. Stop builder instance

ビルダ・インスタンスを停止します。

使い方
==========

.. code-block:: bash

   $ docker buildx stop [NAME]

.. Extended description

補足説明
==========

.. Stops the specified or current builder. This will not prevent buildx build to restart the builder. The implementation of stop depends on the driver.

特定のビルダ、もしくは現在のビルダを停止します。これは buildx buid によってビルダの再起動を防ぐものではありません。停止の実装は各ドライバに依存します。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <buildx_stop-examples>` をご覧ください。

.. _buildx_stop-examples:

使用例
==========

.. Override the configured builder instance (--builder)

builder 対象の設定を上書き (--builder)
----------------------------------------

.. Same as buildx --builder.

``buildx --builder`` と同じです。

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

   docker buildx stop
      https://docs.docker.com/engine/reference/commandline/buildx_stop/
