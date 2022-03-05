.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/builder_prune/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/builder_prune.md
      ソースコードからの自動生成
.. check date: 2022/02/26
.. -------------------------------------------------------------------

.. build

=======================================
docker builder prune
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

説明
==========

.. Remove build cache

構築キャッシュを削除します。

.. API 1.31+  The client and daemon API must both be at least 1.31 to use this command. Use the docker version command on the client to check your client and daemon API versions.

【API 1.31+】このコマンドを使うには、クライアントとデーモンの両方が最小 `1.31 <https://docs.docker.com/engine/api/v1.31/>`_ を使う必要があります。クライアントとデーモン API バージョンを確認するには、クライアント上で ``docker version`` コマンドを実行します。

使い方
==========

.. code-block:: bash

  $ docker builder prune

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--all`` , ``-a``
     - 
     - 未使用の構築キャッシュだけでなく、dangling キャッシュも全て削除
   * - ``--filter``
     - 
     - フィルタの値を指定()例： ``until=24h`` 
   * - ``--force`` , ``-f``
     - 
     - 確認プロンプトを表示しない
   * - ``--keep-storage``
     - 
     - キャッシュ用に確保するディスク容量を、byte単位で指定


親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker builder<builder>`
     - 構築を管理


.. Related commands

関連コマンド
====================

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker builder build<builder_build>`
     - Dockerfile からイメージを構築
   * - :doc:`docker prune build<builder_prune>`
     - 構築キャッシュの削除

.. seealso:: 

   docker builder prune
      https://docs.docker.com/engine/reference/commandline/builder_prune/
