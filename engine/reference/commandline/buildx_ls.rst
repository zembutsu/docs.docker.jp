.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/buildx_ls/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/buildx_ls.md
.. check date: 2022/03/05
.. -------------------------------------------------------------------

=======================================
docker buildx ls
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

説明
==========

.. List builder instances

ビルダー・インスタンスを一覧表示。

使い方
==========

.. code-block:: dockerfile

   $ docker buildx ls

.. Extended description

補足説明
==========

.. Lists all builder instances and the nodes for each instance

すべてのビルド・インスタンスと、各インスタンス用のノードを一覧表示します。

使用例
----------

.. code-block:: bash

   $ docker buildx ls
   
   NAME/NODE       DRIVER/ENDPOINT             STATUS  PLATFORMS
   elated_tesla *  docker-container
     elated_tesla0 unix:///var/run/docker.sock running linux/amd64
     elated_tesla1 ssh://ubuntu@1.2.3.4        running linux/arm64, linux/arm/v7, linux/arm/v6
   default         docker
     default       default                     running linux/amd64

.. Each builder has one or more nodes associated with it. The current builder’s name is marked with a *.

各ビルダには1つまたは複数のノードが関連付けられています。現在のビルダ名は ``*`` の印が付いています。

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

   docker buildx ls
      https://docs.docker.com/engine/reference/commandline/buildx_ls/
