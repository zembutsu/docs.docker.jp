.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/buildx_use/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/buildx_use.md
.. check date: 2022/03/05
.. -------------------------------------------------------------------

=======================================
docker buildx use
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

説明
==========

.. Set the current builder instance

現在のビルダ・インスタンスを指定します。

使い方
==========

.. code-block:: bash

   $ docker buildx use [OPTIONS] NAME

.. Extended description

補足説明
==========

.. Switches the current builder instance. Build commands invoked after this command will run on a specified builder. Alternatively, a context name can be used to switch to the default builder of that context.

現在のビルダ・インスタンスを切り替えます。このコマンドを指定後の構築コマンドでは、指定したビルダで実行します。また、デフォルト・ビルダを切り替えるためには、コンテキスト名も利用できます。

.. Removes the specified or current builder. It is a no-op attempting to remove the default builder.

特定のビルダ、もしくは現在のビルダを削除します。デフォルトのビルダを削除しようとしても、操作できません。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <buildx_use-examples>` をご覧ください。

.. _buildx_use-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--default``
     - 
     - 現在のコンテクストに対し、デフォルトのビルダを指定
   * - ``--global``
     - 
     - ビルダ全体に対してコンテキストを変更
   * - ``--builder``
     - 
     - 設定したビルダインスタンスを上書き

.. _buildx_use-examples:

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

   docker buildx use
      https://docs.docker.com/engine/reference/commandline/buildx_use/
