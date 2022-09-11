.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/volume/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/volume.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_volume.yaml
.. check date: 2022/04/03
.. Commits on Mar 23, 2018 cb157b3318eac0a652a629ea002778ca3d8fa703
.. -------------------------------------------------------------------

.. docker volume

=======================================
docker volume
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _volume-description:

説明
==========

.. Manage volumes

ボリュームを管理します。

.. API 1.21+
   Open the 1.21 API reference (in a new window)
   The client and daemon API must both be at least 1.25 to use this command. Use the docker version command on the client to check your client and daemon API versions.

【API 1.21+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.25 <https://docs.docker.com/engine/api/v1.21/>`_ の必要があります。クライアントとデーモン API のバージョンを調べるには、 ``docker version`` コマンドを使います。


.. _volume-usage:

使い方
==========

.. code-block:: bash

   $ docker volume COMMAND COMMAND

.. Extended description
.. _volume-extended-description:

補足説明
==========

.. Manage volumes. You can use subcommands to create, inspect, list, remove, or prune volumes.

ボリュームを管理します。サブコマンドを使い、ボリュームの作成、調査、一覧、削除、除去が可能です。

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
   * - :doc:`docker volume create<volume_create>`
     - ボリュームの作成
   * - :doc:`docker volume inspect<volume_inspect>`
     - 1つまたは複数ボリュームの詳細情報を表示
   * - :doc:`docker volume ls<volume_ls>`
     - ボリューム一覧表示
   * - :doc:`docker volume prune<volume_prune>`
     - 使用していないローカルボリュームを削除
   * - :doc:`docker volume rm<volume_rm>`
     - 1つまたは複数ボリュームを削除

.. seealso:: 

   docker volume
      https://docs.docker.com/engine/reference/commandline/volume/
