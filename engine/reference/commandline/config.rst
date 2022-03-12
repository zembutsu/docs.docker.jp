.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/config/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/config.md
.. check date: 2022/03/06
.. -------------------------------------------------------------------

.. docker config

=======================================
docker config
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _config-description:

説明
==========

.. Manage Docker configs

Docker config （設定）を管理します。

.. API 1.30+
   Open the 1.30 API reference (in a new window)
     The client and daemon API must both be at least 1.30 to use this command. Use the docker version command on the client to check your client and daemon API versions.
   Swarm This command works with the Swarm orchestrator.

【API 1.30+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.30 <https://docs.docker.com/engine/api/v1.30/>`_ の必要があります。
【Swarm】このコマンドは Swarm オーケストレータと動作します。

.. _config-usage:

使い方
==========

.. code-block:: bash

   $ docker config COMMAND

.. _config-extended-description:

.. Extended description

補足説明
==========

config を管理します。


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
   * - :doc:`docker compose <config_create>`
     - ファイルか STDIN から設定を作成
   * - :doc:`docker compose <config_inspect>`
     - 1つもしくは複数の設定情報を詳細表示
   * - :doc:`docker compose <config_ls>`
     - 設定一覧
   * - :doc:`docker compose <config_rm>`
     - 1つもしくは複数の設定を削除


詳細情報
==========

:doc:`Docker Config を使って設定データを保管 </engine/swarm/configs>`


.. seealso:: 

   docker config
      https://docs.docker.com/engine/reference/commandline/config/
