.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/config_rm/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/config_rm.md
.. check date: 2022/03/12
.. -------------------------------------------------------------------

.. docker config rm

=======================================
docker config rm
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _config_rm-description:

説明
==========

.. Remove one or more configs

1つもしくは複数の設定情報を削除します。

.. API 1.30+
   Open the 1.30 API reference (in a new window)
     The client and daemon API must both be at least 1.30 to use this command. Use the docker version command on the client to check your client and daemon API versions.
   Swarm This command works with the Swarm orchestrator.

- 【API 1.30+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.30 <https://docs.docker.com/engine/api/v1.30/>`_ の必要があります。
- 【Swarm】このコマンドは Swarm オーケストレータと動作します。

.. _config_rm-usage:

使い方
==========

.. code-block:: bash

   $ docker config rm CONFIG [CONFIG...]

.. _config_rm-extended-description:

.. Extended description

補足説明
==========

.. Removes the specified configs from the swarm.

swarm から指定した config を削除します。

.. For detailed information about using configs, refer to store configuration data using Docker Configs.

設定を使うための詳細情報は、 :doc:`Docker Config を使って設定データを保管 </engine/swarm/configs>` を参照ください。

..    Note
    This is a cluster management command, and must be executed on a swarm manager node. To learn about managers and workers, refer to the Swarm mode section in the documentation.

.. note::

   これはクラスタ管理コマンドであり、 swarm manager ノードで実行する必要があります。manager と worker について学ぶには、ドキュメント内の :doc:`Swarm モードのセクション </engine/swarm/index>` を参照ください。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <config_rm-examples>` をご覧ください。

.. _config_rm-options:

使用例
==========

.. This example removes a config:

こちらの例は config を削除します。

.. code-block:: bash

   $ docker config rm my_config
   sapth4csdo5b6wz2p5uimh5xg

..  Warning
    Unlike docker rm, this command does not ask for confirmation before removing a config.

.. warning::

   ``docker rm`` とは異なり、このコマンドは config を削除する前の確認がありません。

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker config<config>`
     - Docker 設定を管理


.. Related commands

関連コマンド
====================

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


.. seealso:: 

   docker config rm
      https://docs.docker.com/engine/reference/commandline/config_rm/
