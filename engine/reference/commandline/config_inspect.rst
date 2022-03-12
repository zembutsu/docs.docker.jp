.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/config_inspect/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/config_inspect.md
.. check date: 2022/03/06
.. -------------------------------------------------------------------

.. docker config inspect

=======================================
docker config inspect
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _config_inspect-description:

説明
==========

.. Display detailed information on one or more configs

1つもしくは複数の設定情報を詳細に表示します。

.. API 1.30+
   Open the 1.30 API reference (in a new window)
     The client and daemon API must both be at least 1.30 to use this command. Use the docker version command on the client to check your client and daemon API versions.
   Swarm This command works with the Swarm orchestrator.

- 【API 1.30+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.30 <https://docs.docker.com/engine/api/v1.30/>`_ の必要があります。
- 【Swarm】このコマンドは Swarm オーケストレータと動作します。

.. _config_inspect-usage:

使い方
==========

.. code-block:: bash

   $ docker config inspect [OPTIONS] CONFIG [CONFIG...]

.. _config_inspect-extended-description:

.. Extended description

補足説明
==========

.. Inspects the specified config.

指定した設定を調べます。

.. By default, this renders all results in a JSON array. If a format is specified, the given template will be executed for each result.

デフォルトでは、JSON アレイ形式で結果を表示します。フォーマットを指定すると、指定のテンプレートでそれぞれの結果を表示します。

.. Go’s text/template package describes all the details of the format.

Go 言語の `text/template <https://golang.org/pkg/text/template/>`_ パッケージに、フォーマットの詳細全てがあります。

.. For detailed information about using configs, refer to store configuration data using Docker Configs.

設定を使うための詳細情報は、 :doc:`Docker Config を使って設定データを保管 </engine/swarm/configs>` を参照ください。

..    Note
    This is a cluster management command, and must be executed on a swarm manager node. To learn about managers and workers, refer to the Swarm mode section in the documentation.

.. note::

   これはクラスタ管理コマンドであり、 swarm manager ノードで実行する必要があります。manager と worker について学ぶには、ドキュメント内の :doc:`Swarm モードのセクション </engine/swarm/index>` を参照ください。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <config_inspect-examples>` をご覧ください。

.. _config_inspect-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--format`` , ``-f``
     - 
     - 指定した Go テンプレートで出力
   * - ``--pretty``
     - 
     - 人間が見やすい形式で情報を表示

.. _config_inspect-examples:

使用例
==========

.. Inspect a config by name or ID

.. _inspect-a-config-by-name-or-id:

名前か ID で設定を調査
------------------------------

.. You can inspect a config, either by its name, or ID

設定情報を名前もしくは ID のどちらかで調べられます。

.. For example, given the following config:

例えば、次のような設定があるとします。

.. code-block:: bash

    $ docker config ls
    
    ID                          NAME                CREATED             UPDATED
   eo7jnzguqgtpdah3cm5srfb97   my_config           3 minutes ago       3 minutes ago

.. code-block:: bash

   $ docker config inspect config.json

.. The output is in JSON format, for example:

.. code-block:: yaml

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

.. Formatting

.. _config_inspect-formatting:

書式
==========

.. You can use the --format option to obtain specific information about a config. The following example command outputs the creation time of the config.

--format オプションを使い、特定の設定情報を取得できます。以下のコマンド例は、作成時間の情報を出力します。

.. code-block:: bash

   $ docker config inspect --format='{{.CreatedAt}}' eo7jnzguqgtpdah3cm5srfb97
   2017-03-24 08:15:09.735271783 +0000 UTC



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

   docker config inspect
      https://docs.docker.com/engine/reference/commandline/config_inspect/
