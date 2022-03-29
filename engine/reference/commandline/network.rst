.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/network/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/network.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_network.yaml
.. check date: 2022/03/28
.. Commits on Jun 1, 2019 ffe8ffd1e8137160aa342b0552ce8c8d58aaad5b
.. -------------------------------------------------------------------

.. docker network

=======================================
docker network
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _network-description:

説明
==========

.. Manage networks

ネットワークを管理します。

.. API 1.21+
   Open the 1.21 API reference (in a new window)
   The client and daemon API must both be at least 1.21 to use this command. Use the docker version command on the client to check your client and daemon API versions.

【API 1.21+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.21 <https://docs.docker.com/engine/api/v1.21/>`_ の必要があります。クライアントとデーモン API のバージョンを調べるには、 ``docker version`` コマンドを使います。

.. _network-usage:

使い方
==========

.. code-block:: bash

   $ docker network COMMAND

.. Extended description
.. _network-extended-description:

補足説明
==========

.. Manage networks. You can use subcommands to create, inspect, list, remove, prune, connect, and disconnect networks.

ネットワークを管理します。 ネットワークのサブコマンド create、inspect、list、remove、prune、connect、disconnet が利用できます。



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
   * - :doc:`docker network connect <network_connect>`
     - コンテナをネットワークに接続
   * - :doc:`docker network craete <network_create>`
     - ネットワーク作成
   * - :doc:`docker network disconnect <network_disconnect>`
     - ネットワークからコンテナを切断
   * - :doc:`docker network inspect <network_inspect>`
     - 1つまたは複数ネットワークの情報を表示
   * - :doc:`docker network ls <network_ls>`
     - ネットワーク一覧表示
   * - :doc:`docker network prune <network_prune>`
     - 使用していないネットワークを全て削除
   * - :doc:`docker network rm <network_rm>`
     - 1つまたは複数ネットワークの削除


.. seealso:: 

   docker network
      https://docs.docker.com/engine/reference/commandline/network/
