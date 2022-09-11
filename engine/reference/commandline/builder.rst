.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/builder/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/builder.md
      ソースコードからの自動生成
.. check date: 2022/02/26
.. -------------------------------------------------------------------

.. build

=======================================
docker builder
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

説明
==========

.. Manage builds

構築を管理。

.. API 1.31+  The client and daemon API must both be at least 1.31 to use this command. Use the docker version command on the client to check your client and daemon API versions.

【API 1.31+】このコマンドを使うには、クライアントとデーモンの両方が最小 `1.31 <https://docs.docker.com/engine/api/v1.31/>`_ を使う必要があります。クライアントとデーモン API バージョンを確認するには、クライアント上で ``docker version`` コマンドを実行します。

使い方
==========

.. code-block:: bash

  $ docker builder [コマンド]

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
   * - :doc:`docker builder build<builder_build>`
     - Dockerfile からイメージを構築
   * - :doc:`docker prune build<builder_prune>`
     - 構築キャッシュの削除

.. seealso:: 

   docker builder
      https://docs.docker.com/engine/reference/commandline/builder/
