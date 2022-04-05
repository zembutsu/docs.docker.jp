.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/secret/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/secret.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_secret.yaml
.. check date: 2022/04/02
.. Commits on Mar 22, 2018 cb157b3318eac0a652a629ea002778ca3d8fa703
.. -------------------------------------------------------------------

.. docker secret

=======================================
docker secret
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _secret-description:

説明
==========

.. Manage Docker secrets

Docker :ruby:`シークレット <secret>` を管理します。

.. API 1.25+
   Open the 1.25 API reference (in a new window)
   The client and daemon API must both be at least 1.25 to use this command. Use the docker version command on the client to check your client and daemon API versions.
   Swarm This command works with the Swarm orchestrator.

- 【API 1.25+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.25 <https://docs.docker.com/engine/api/v1.25/>`_ の必要があります。クライアントとデーモン API のバージョンを調べるには、 ``docker version`` コマンドを使います。
- 【Swarm】このコマンドは Swarm オーケストレータと動作します。


.. _secret-usage:

使い方
==========

.. code-block:: bash

   $ docker secret COMMAND

.. Extended description
.. _secret-extended-description:

補足説明
==========

.. Manage secrets.

:ruby:`シークレット <secret>` を管理します。


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
   * - :doc:`docker secret create<secret_create>`
     - ファイルもしくは STDIN（標準入力）を内容としてシークレットを作成
   * - :doc:`docker secret inspect<secret_inspect>`
     - 1つまたは複数シークレットの詳細情報を表示
   * - :doc:`docker secret ls<secret_ls>`
     - シークレット一覧
   * - :doc:`docker secret rm<secret_rm>`
     - 1つまたは複数のシークレットを削除


.. seealso:: 

   docker secret
      https://docs.docker.com/engine/reference/commandline/secret/
