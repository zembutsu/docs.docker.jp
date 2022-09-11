.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/service/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/service.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_service.yaml
.. check date: 2022/04/02
.. Commits on Apr 20, 2020 82092fe8794e76c74b206e0fc55438b6869506e4
.. -------------------------------------------------------------------

.. docker service

=======================================
docker service
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _service-description:

説明
==========

.. Manage Services

サービスを管理します。

.. API 1.24+
   Open the 1.24 API reference (in a new window)
   The client and daemon API must both be at least 1.25 to use this command. Use the docker version command on the client to check your client and daemon API versions.
   Swarm This command works with the Swarm orchestrator.

- 【API 1.24+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.25 <https://docs.docker.com/engine/api/v1.25/>`_ の必要があります。クライアントとデーモン API のバージョンを調べるには、 ``docker version`` コマンドを使います。
- 【Swarm】このコマンドは Swarm オーケストレータと動作します。


.. _service-usage:

使い方
==========

.. code-block:: bash

   $ docker service COMMAND

.. Extended description
.. _service-extended-description:

補足説明
==========

.. Manage services.

サービスを管理します。

..    Note
    This is a cluster management command, and must be executed on a swarm manager node. To learn about managers and workers, refer to the Swarm mode section in the documentation.

.. note::

   これはクラスタ管理コマンドであり、 swarm manager ノードで実行する必要があります。manager と worker について学ぶには、ドキュメント内の :doc:`Swarm モードのセクション </engine/swarm/index>` を参照ください。


.. Parent command

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
   * - :doc:`docker service create<service_create>`
     - 新しいサービスを作成
   * - :doc:`docker service inspect<service_inspect>`
     - 1つまたは複数サービスの詳細情報を表示
   * - :doc:`docker service logs<service_logs>`
     - サービスかタスクのログを取得
   * - :doc:`docker service ls<service_ls>`
     - サービス一覧表示
   * - :doc:`docker service ps<service_ps>`
     - 1つまたは複数タスクの一覧表示
   * - :doc:`docker service rm<service_rm>`
     - 1つまたは複数サービスの削除
   * - :doc:`docker service rollback<service_rollback>`
     - サービス設定の変更を :ruby:`復帰 <rollback>`
   * - :doc:`docker service scale<service_scale>`
     - 1つまたは複数サービスを :ruby:`スケール <scale>`
   * - :doc:`docker service update<service_update>`
     - サービスの更新


.. seealso:: 

   docker service
      https://docs.docker.com/engine/reference/commandline/service/
