.. -*- coding: utf-8 -*-
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/network_disconnect.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_network_disconnect.yaml
.. check date: 2022/03/28
.. Commits on Aug 22, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker network disconnect

=======================================
docker network disconnect
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _network_disconnect-description:

説明
==========

.. Disconnect a container from a network

ネットワークからコンテナを切断します。

.. API 1.21+
   Open the 1.21 API reference (in a new window)
   The client and daemon API must both be at least 1.21 to use this command. Use the docker version command on the client to check your client and daemon API versions.

【API 1.21+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.21 <https://docs.docker.com/engine/api/v1.21/>`_ の必要があります。クライアントとデーモン API のバージョンを調べるには、 ``docker version`` コマンドを使います。

.. _network_disconnect-usage:

使い方
==========

.. code-block:: bash

   $ docker network disconnect [OPTIONS] NETWORK CONTAINER

.. Extended description
.. _network_disconnect-extended-description:

補足説明
==========

.. Disconnects a container from a network. The container must be running to disconnect it from the network.

コンテナをネットワークから切り離します（disconnect）。ネットワークから切り離すためには、コンテナを実行している必要があります。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <network_disconnect-examples>` をご覧ください。

.. _network_create-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--force`` , ``-f``
     - 
     - ネットワークからコンテナを強制切断

.. Examples
.. _network_disconnect-examples:

使用例
==========

.. code-block:: bash

   $ docker network disconnect multi-host-network container1

.. Parent command

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker network <network>`
     - ネットワークを管理



.. Related commands

関連コマンド
====================

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

   docker network disconnect
      https://docs.docker.com/engine/reference/commandline/network_disconnect/


