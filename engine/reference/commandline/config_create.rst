.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/config_craete/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/config_create.md
.. check date: 2022/03/06
.. -------------------------------------------------------------------

.. docker config create

=======================================
docker config create
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _config_create-description:

説明
==========

.. Create a config from a file or STDIN

ファイルか STDIN から設定を作成します。

.. API 1.30+
   Open the 1.30 API reference (in a new window)
     The client and daemon API must both be at least 1.30 to use this command. Use the docker version command on the client to check your client and daemon API versions.
   Swarm This command works with the Swarm orchestrator.

- 【API 1.30+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.30 <https://docs.docker.com/engine/api/v1.30/>`_ の必要があります。
- 【Swarm】このコマンドは Swarm オーケストレータと動作します。

.. _config_create-usage:

使い方
==========

.. code-block:: bash

   $ docker config create [OPTIONS] CONFIG file|-

.. _config_create-extended-description:

.. Extended description

補足説明
==========

.. Creates a config using standard input or from a file for the config content.

標準入力、あるいは、config コンテクスト用のファイル形式から設定を作成します。

.. For detailed information about using configs, refer to store configuration data using Docker Configs.

設定を使うための詳細情報は、 :doc:`Docker Config を使って設定データを保管 </engine/swarm/configs>` を参照ください。

..    Note
    This is a cluster management command, and must be executed on a swarm manager node. To learn about managers and workers, refer to the Swarm mode section in the documentation.

.. note::

   これはクラスタ管理コマンドであり、 swarm manager ノードで実行する必要があります。manager と worker について学ぶには、ドキュメント内の :doc:`Swarm モードのセクション </engine/swarm/index>` を参照ください。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <config_create-examples>` をご覧ください。

.. _config_create-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--label`` , ``-l``
     - 
     - ラベルを設定
   * - ``--template-driver``
     - 
     - 【 `API 1.37+ <https://docs.docker.com/engine/api/v1.37/>`_ 】テンプレート・ドライバ


.. _config_create-examples:

使用例
==========

.. Create a config

設定の作成
----------

.. code-block:: bash

   $ printf <config> | docker config create my_config -
   onakdyv307se2tl7nl20anokv
   
   $ docker config ls
   ID                          NAME                CREATED             UPDATED
   onakdyv307se2tl7nl20anokv   my_config           6 seconds ago       6 seconds ago

.. Create a config with a file

ファイルから設定を作成
------------------------------

.. code-block:: bash

   $ docker config create my_config ./config.json
   dg426haahpi5ezmkkj5kyl3sn
   
   $ docker config ls
   ID                          NAME                CREATED             UPDATED
   dg426haahpi5ezmkkj5kyl3sn   my_config           7 seconds ago       7 seconds ago


.. Create a config with labels

ラベルで設定を作成
------------------------------

.. code-block:: bash

   $ docker config create \
       --label env=dev \
       --label rev=20170324 \
       my_config ./config.json'
   
   eo7jnzguqgtpdah3cm5srfb97

.. code-block:: bash

   $ docker config inspect my_config
   
   [
       {
           "ID": "eo7jnzguqgtpdah3cm5srfb97",
           "Version": {
               "Index": 17
           },
           "CreatedAt": "2017-03-24T08:15:09.735271783Z",
           "UpdatedAt": "2017-03-24T08:15:09.735271783Z",
           "Spec": {
               "Name": "my_config",
               "Labels": {
                   "env": "dev",
                   "rev": "20170324"
               },
               "Data": "aGVsbG8K"
           }
       }
   ]




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

   docker config create
      https://docs.docker.com/engine/reference/commandline/config_create/
