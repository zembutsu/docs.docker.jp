.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/secret_ls/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/secret_ls.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_secret_ls.yaml
.. check date: 2022/04/02
.. Commits on Apr 2, 2022 098129a0c12e3a79398b307b38a67198bd3b66fc
.. -------------------------------------------------------------------

.. docker secret ls

=======================================
docker secret ls
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _secret_ls-description:

説明
==========

.. List secrets

シークレット一覧を表示します。

.. API 1.25+
   Open the 1.25 API reference (in a new window)
   The client and daemon API must both be at least 1.25 to use this command. Use the docker version command on the client to check your client and daemon API versions.
   Swarm This command works with the Swarm orchestrator.


- 【API 1.25+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.25 <https://docs.docker.com/engine/api/v1.25/>`_ の必要があります。クライアントとデーモン API のバージョンを調べるには、 ``docker version`` コマンドを使います。
- 【Swarm】このコマンドは Swarm オーケストレータと動作します。


.. _secret_ls-usage:

使い方
==========

.. code-block:: bash

   $ docker secret ls [OPTIONS]

.. Extended description
.. _secret_ls-extended-description:

補足説明
==========

.. Run this command on a manager node to list the secrets in the swarm.

swarm 内のシークレット一覧を表示するには、このコマンドを manager ノード上で実行します。

.. For detailed information about using secrets, refer to manage sensitive data with Docker secrets.

シークレットの利用に関する詳細情報は、 :doc:`Docker シークレットで機微データを管理 </engine/swarm/secrets>` をご覧ください。

..    Note
    This is a cluster management command, and must be executed on a swarm manager node. To learn about managers and workers, refer to the Swarm mode section in the documentation.

.. note::

   これはクラスタ管理コマンドであり、 swarm manager ノードで実行する必要があります。manager と worker について学ぶには、ドキュメント内の :doc:`Swarm モードのセクション </engine/swarm/index>` を参照ください。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <secret_ls-examples>` をご覧ください。


.. _secret_ls-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--filter`` , ``-f``
     - 
     - フィルタの値を指定（例： ``driver=bridge`` ）
   * - ``--format``
     - 
     - Go テンプレートを使ってコンテナの出力を整形
   * - ``--quiet`` , ``-q``
     - 
     - ID のみ表示

.. _secret_ls-examples:

使用例
==========

.. code-block:: bash

   $ docker secret ls
   
   ID                          NAME                        CREATED             UPDATED
   6697bflskwj1998km1gnnjr38   q5s5570vtvnimefos1fyeo2u2   6 weeks ago         6 weeks ago
   9u9hk4br2ej0wgngkga6rp4hq   my_secret                   5 weeks ago         5 weeks ago
   mem02h8n73mybpgqjf0kfi1n0   test_secret                 3 seconds ago       3 seconds ago


.. Filtering
.. _secret_ls-filtering:

フィルタリング
--------------------

The filtering flag (-f or --filter) format is a key=value pair. If there is more than one filter, then pass multiple flags (e.g., --filter "foo=bar" --filter "bif=baz")

フィルタリング・フラグ（ ``-f`` または ``--filter`` ）の書式は ``key=value`` のペアです。フィルタを何回もしたい場合は、複数のフラグを使います（例： ``-filter "foo=bar" --filter "bif=baz"`` ）。

.. The currently supported filters are:

現時点でサポートしているフィルタは、次の通りです。

* :ref:`id <secret_ls-id>` （ネットワークID）
* :ref:`label <secret_ls-label>` （ ``label=<キー>`` または ``label=<キー>=<値>`` ）
* :ref:`name <secret_name-label>` （シークレット名）

.. ID
.. _secret_ls-id:
id
^^^^^^^^^^

.. The id filter matches on all or part of a secret’s ID.

``id`` フィルタはシークレット ID の一部もしくは全体と一致します。

.. code-block:: bash

   $ docker secret ls -f "id=6697bflskwj1998km1gnnjr38"
   
   ID                          NAME                        CREATED             UPDATED
   6697bflskwj1998km1gnnjr38   q5s5570vtvnimefos1fyeo2u2   6 weeks ago         6 weeks ago

.. Label
.. _secret_ls-label:
label
^^^^^^^^^^

.. The label filter matches secrets based on the presence of a label alone or a label and a value.

``label`` フィルタは ``label`` だけ、あるいは ``label`` と値に一致する条件のシークレットでフィルタします。

.. The following filter matches secrets with the usage label regardless of its value.

以下のフィルタはラベルの値が ``usage`` に一致するシークレットを表示します。

.. code-block:: bash

   $ docker secret ls --filter label=project
   
   ID                          NAME                        CREATED             UPDATED
   mem02h8n73mybpgqjf0kfi1n0   test_secret                 About an hour ago   About an hour ago


.. code-block:: bash

.. The following filter matches only services with the project label with the project-a value.

以下のフィルタは ``project`` ラベルの値が ``project-a`` の値に一致するネットワークを表示します。

.. code-block:: bash

   $ docker service ls --filter label=project=test
   
   ID                          NAME                        CREATED             UPDATED
   mem02h8n73mybpgqjf0kfi1n0   test_secret                 About an hour ago   About an hour ago

.. Label
.. _secret_ls-name:
name
^^^^^^^^^^

.. The name filter matches on all or part of a secret’s name.

``name`` フィルタはシークレット名の一部もしくは全体に一致します。

.. The following filter matches secret with a name containing a prefix of test.

以下のフィルタは先頭に ``test`` 文字列を含むシークレットでフィルタします。

.. code-block:: bash

   $ docker secret ls --filter name=test_secret
   
   ID                          NAME                        CREATED             UPDATED
   mem02h8n73mybpgqjf0kfi1n0   test_secret                 About an hour ago   About an hour ago

.. _secret_ls-formatting:
表示形式
----------

.. The formatting options (--format) pretty-prints secret output using a Go template.

表示形式のオプション（ ``--format`` ）は、Go テンプレートを使ってシークレット出力を整形します。

.. Valid placeholders for the Go template are listed below:

Go テンプレートで有効なプレースホルダは以下の通りです。


.. list-table::
   :header-rows: 1

   * - placeholder
     - 説明
   * - ``.ID``
     - シークレット ID
   * - ``.Name``
     - ネットワーク名
   * - ``.CreatedAt``
     - シークレットが作成された時刻
   * - ``.UpdatedAt``
     - シークレットが更新された時刻
   * - ``.Labels``
     - シークレットに割り当てられた全てのラベル
   * - ``.Label``
     - シークレットで指定したラベルの値。例 ``{{.Label "secret.ssh.key"}}``

.. When using the --format option, the secret ls command will either output the data exactly as the template declares or, when using the table directive, will include column headers as well.

``--format`` オプションを指定すると、 ``secret ls`` コマンドはテンプレートで宣言した通りにデータを出力するか、 ``table`` 命令を使えばカラム列も同様に表示するかのどちらかです。

.. The following example uses a template without headers and outputs the ID and Name entries separated by a colon (:) for all images:

以下の例はヘッダ無しのテンプレートを使い、全てのシークレットに対する ``ID`` と ``Name`` のエントリをコロン（ ``:`` ）で区切って出力します。

.. code-block:: bash

   $ docker secret ls --format "{{.ID}}: {{.Name}}"
   
   77af4d6b9913: secret-1
   b6fa739cedf5: secret-2
   78a85c484f71: secret-3

.. To list all secrets with their name and created date in a table format you can use:

全てのシークレット名と作成日時を表形式で表示するには、次のようにします。

.. code-block:: bash

   $ docker secret ls --format "table {{.ID}}\t{{.Name}}\t{{ .CreatedAt}}"
   
   ID                  NAME                      CREATED
   77af4d6b9913        secret-1                  5 minutes ago
   b6fa739cedf5        secret-2                  3 hours ago
   78a85c484f71        secret-3                  10 days ago


.. Parent command

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker secret <secret>`
     - Docker シークレットを管理


.. Related commands

関連コマンド
====================

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

   docker secret ls
      https://docs.docker.com/engine/reference/commandline/secret_ls/
