.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/config_ls/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/config_ls.md
.. check date: 2022/03/12
.. -------------------------------------------------------------------

.. docker config ls

=======================================
docker config ls
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _config_ls-description:

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

.. _config_ls-usage:

使い方
==========

.. code-block:: bash

   $ docker config ls [OPTIONS]

.. _config_ls-extended-description:

.. Extended description

補足説明
==========

.. Run this command on a manager node to list the configs in the swarm.

swarm の設定一覧を表示するために、manager ノード上でこのコマンドを実行します。

.. For detailed information about using configs, refer to store configuration data using Docker Configs.

設定を使うための詳細情報は、 :doc:`Docker Config を使って設定データを保管 </engine/swarm/configs>` を参照ください。

..    Note
    This is a cluster management command, and must be executed on a swarm manager node. To learn about managers and workers, refer to the Swarm mode section in the documentation.

.. note::

   これはクラスタ管理コマンドであり、 swarm manager ノードで実行する必要があります。manager と worker について学ぶには、ドキュメント内の :doc:`Swarm モードのセクション </engine/swarm/index>` を参照ください。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <config_ls-examples>` をご覧ください。

.. _config_ls-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--filter`` , ``-f``
     - 
     - 指定した状態に基づき出力をフィルタ
   * - ``--format``
     - 
     - 指定した Go テンプレートで出力
   * - ``--quiet``, ``-q``
     - 
     - ID のみ表示

.. _config_ls-examples:

使用例
==========

.. code-block:: bash

   $ docker config ls
   
   ID                          NAME                        CREATED             UPDATED
   6697bflskwj1998km1gnnjr38   q5s5570vtvnimefos1fyeo2u2   6 weeks ago         6 weeks ago
   9u9hk4br2ej0wgngkga6rp4hq   my_config                   5 weeks ago         5 weeks ago
   mem02h8n73mybpgqjf0kfi1n0   test_config                 3 seconds ago       3 seconds ago


.. _config_ls-filtering

フィルタリング
------------------------------

.. The filtering flag (-f or --filter) format is a key=value pair. If there is more than one filter, then pass multiple flags (e.g., --filter "foo=bar" --filter "bif=baz")

フィルタリングのフラグ（ ``-f``, ``--filter`` ）形式は、 ``key=value`` のペアです。複数のフィルタを使いたいバイアは、複数のフラグを使います（例： ``--filter "foo=bar" --filter "bif=baz"`` ）。

.. The currently supported filters are:

現在は以下のフィルタをサポートしています。

..  id (config’s ID)
    label (label=<key> or label=<key>=<value>)
    name (config’s name)

* :ref:`id <config_ls-id>` （config の ID）
* :ref:`label <config_ls-label>` （ ``label=<key>`` または ``label=<key>=<value>`` ）
* :ref:`name <config_ls-name>` （config の名前）

.. _config_ls-id:

id
^^^^^^^^^^

.. The id filter matches all or prefix of a config’s id.

``id`` は、config の ID の前方もしくは全てに一致するフィルタをします。

.. code-block:: bash

   $ docker config ls -f "id=6697bflskwj1998km1gnnjr38"
   
   ID                          NAME                        CREATED             UPDATED
   6697bflskwj1998km1gnnjr38   q5s5570vtvnimefos1fyeo2u2   6 weeks ago         6 weeks ago

.. _config_ls-label:

label
^^^^^^^^^^

.. The label filter matches configs based on the presence of a label alone or a label and a value.

``label`` では、 ``label`` 単独の存在、もしくは ``label`` と値に基づいてフィルタします。

.. The following filter matches all configs with a project label regardless of its value:

以下は、ラベルの値にかかわらず、 ``project`` ラベルに一致する全ての config をフィルタします。

.. code-block:: bash

   $ docker config ls --filter label=project
   
   ID                          NAME                        CREATED             UPDATED
   mem02h8n73mybpgqjf0kfi1n0   test_config                 About an hour ago   About an hour ago

.. The following filter matches only services with the project label with the project-a value.

以下のフィルタに一致するのは、 ラベルが ``project`` で値が ``project-a`` のサービスのみです。

.. code-block:: bash

   $ docker service ls --filter label=project=test
   ID                          NAME                        CREATED             UPDATED
   mem02h8n73mybpgqjf0kfi1n0   test_config                 About an hour ago   About an hour ago

.. _config-ls-name:

.. The name filter matches on all or prefix of a config’s name.

``name`` では、config 名の前方もしくは全体に一致するフィルタをします。

.. The following filter matches config with a name containing a prefix of test.

以下のフィルタは ``test`` で始まる名前の config にマッチします。

.. code-block:: bash

   $ docker config ls --filter name=test_config
   
   ID                          NAME                        CREATED             UPDATED
   mem02h8n73mybpgqjf0kfi1n0   test_config                 About an hour ago   About an hour ago

.. Format the output
.. _config_ls-format-the-output:
出力形式
==========

.. The formatting option (--format) pretty prints configs output using a Go template.

出力形式のオプション（ ``--format`` ）は Go テンプレートを用いて出力を調整し、表示を整えます。

.. Valid placeholders for the Go template are listed below:

有効な Go テンプレートの placeholder は以下の通りです。

.. list-table::
   :header-rows: 1

   * - placeholder
     - 説明
   * - ``.ID``
     - config ID
   * - ``.Name``
     - config 名
   * - ``.CreateAt``
     - config が作成された時間
   * - ``.UpdateAt``
     - config が更新された時間
   * - ``.Labels``
     - config に割り当てられた全てのラベル
   * - ``.Label``
     - この config に対する特定のラベル値。例 ``{{.Label "my-label"}}`` 

.. When using the --format option, the config ls command will either output the data exactly as the template declares or, when using the table directive, will include column headers as well.

``--format`` オプションを使うと、 ``config ls`` コマンドはテンプレート宣言通りに正確にデータを出力するか、 ``table`` ディレクティブによってヘッダ列も同様に表示するかのいずれかです。

.. The following example uses a template without headers and outputs the ID and Name entries separated by a colon (:) for all images:

以下の例では、ヘッダのないテンプレートを使いますが、全てのイメージに対して ``ID`` と ``Name`` の項目をコロン ``:`` で分けて表示します。

.. code-block:: bash

   $ docker config ls --format "{{.ID}}: {{.Name}}"
   
   77af4d6b9913: config-1
   b6fa739cedf5: config-2
   78a85c484f71: config-3

.. To list all configs with their name and created date in a table format you can use:

全ての config に対する名前と作成日を表形式で表示するには、次のようにします。

.. code-block:: bash

   $ docker config ls --format "table {{.ID}}\t{{.Name}}\t{{.CreatedAt}}"
   
   ID                  NAME                      CREATED
   77af4d6b9913        config-1                  5 minutes ago
   b6fa739cedf5        config-2                  3 hours ago
   78a85c484f71        config-3                  10 days ago


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

   docker config ls
      https://docs.docker.com/engine/reference/commandline/config_ls/
