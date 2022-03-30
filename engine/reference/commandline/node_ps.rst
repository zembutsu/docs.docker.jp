.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/node_ps/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/node_ps.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_node_ps.yaml
.. check date: 2022/03/30
.. Commits on Aug 21, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker node ps

=======================================
docker node ps
=======================================


.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _node_promote-description:

説明
==========

.. List tasks running on one or more nodes, defaults to current node

1つまたは複数のノード上で実行しているタスク一覧を表示します。デフォルトは現在のノード上です。

.. API 1.24+
   Open the 1.24 API reference (in a new window)
   The client and daemon API must both be at least 1.24 to use this command. Use the docker version command on the client to check your client and daemon API versions.
   Swarm This command works with the Swarm orchestrator.

【API 1.24+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.24 <https://docs.docker.com/engine/api/v1.24/>`_ の必要があります。クライアントとデーモン API のバージョンを調べるには、 ``docker version`` コマンドを使います。

【Swarm】このコマンドは Swarm オーケストレータで動作します。


.. _node_ps-usage:

使い方
==========

.. code-block:: bash

   $ docker node ps [OPTIONS] [NODE...]

.. Extended description
.. _node_ps-extended-description:

補足説明
==========

.. Lists all the nodes that the Docker Swarm manager knows about. You can filter using the -f or --filter flag. Refer to the filtering section for more information about available filter options.

Docker Swarm マネージャ自身が把握している全ノード一覧を表示します。 ``-f`` か ``--filter`` フラグを使い、フィルタできます。利用可能なフィルタの詳しいオプションについては、 :ref:`フィルタリング <node_ps-filtering>` のセクションをご覧ください。

..    Note
    This is a cluster management command, and must be executed on a swarm manager node. To learn about managers and workers, refer to the Swarm mode section in the documentation.

.. note::

   これはクラスタ管理コマンドであり、 swarm manager ノードで実行する必要があります。manager と worker について学ぶには、ドキュメント内の :doc:`Swarm モードのセクション </engine/swarm/index>` を参照ください。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <node_ps-examples>` をご覧ください。

.. _node_ps-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--filter`` , ``-f``
     - 
     - 指定した状況に基づき出力をフィルタ
   * - ``--format``
     - 
     - 指定した Go テンプレートを使って出力を整形
   * - ``--no-resolve``
     - 
     - ID を名前に割り当てない（マップしない）
   * - ``--no-trunk``
     - 
     - 出力を省略しない
   * - ``--quiet`` , ``-q``
     - 
     - ID のみ表示


.. _node_ps-examples:

使用例
==========

.. code-block:: bash

   $ docker node ps swarm-manager1
   
   NAME                                IMAGE        NODE            DESIRED STATE  CURRENT STATE
   redis.1.7q92v0nr1hcgts2amcjyqg3pq   redis:3.0.6  swarm-manager1  Running        Running 5 hours
   redis.6.b465edgho06e318egmgjbqo4o   redis:3.0.6  swarm-manager1  Running        Running 29 seconds
   redis.7.bg8c07zzg87di2mufeq51a2qp   redis:3.0.6  swarm-manager1  Running        Running 5 seconds
   redis.9.dkkual96p4bb3s6b10r7coxxt   redis:3.0.6  swarm-manager1  Running        Running 5 seconds
   redis.10.0tgctg8h8cech4w0k0gwrmr23  redis:3.0.6  swarm-manager1  Running        Running 5 seconds

.. Filtering
.. _node_demote-filter:
フィルタリング
--------------------

.. The filtering flag (-f or --filter) format is of "key=value". If there is more than one filter, then pass multiple flags (e.g., --filter "foo=bar" --filter "bif=baz")

フィルタリング・フラグ（ ``-f`` か ``--filter`` ）の書式は「キー=値」です。複数のフィルタを指定するには、複数回フラグを指定します（例：  ``--filter "foo=bar" --filter "bif=baz"`` ）。

.. The currently supported filters are:

現時点で次のフィルタをサポートしています：

* :ref:`name <node_demote-name>`
* :ref:`id <node_demote-id>`
* :ref:`label <node_demote-label>`
* :ref:`desired-state <node_demote-desired-state>`

.. name
.. _node_demote-name:
name
^^^^^^^^^^

.. The name filter matches on all or part of a task’s name.

``name`` フィルタはタスク名の全てまたは一部に一致します。

.. The following filter matches all tasks with a name containing the redis string.

以下は、名前に ``redis`` 文字を含む全てのタスクでフィルタします。

.. code-block:: bash

   $ docker node ps -f name=redis swarm-manager1
   
   NAME                                IMAGE        NODE            DESIRED STATE  CURRENT STATE
   redis.1.7q92v0nr1hcgts2amcjyqg3pq   redis:3.0.6  swarm-manager1  Running        Running 5 hours
   redis.6.b465edgho06e318egmgjbqo4o   redis:3.0.6  swarm-manager1  Running        Running 29 seconds
   redis.7.bg8c07zzg87di2mufeq51a2qp   redis:3.0.6  swarm-manager1  Running        Running 5 seconds
   redis.9.dkkual96p4bb3s6b10r7coxxt   redis:3.0.6  swarm-manager1  Running        Running 5 seconds
   redis.10.0tgctg8h8cech4w0k0gwrmr23  redis:3.0.6  swarm-manager1  Running        Running 5 seconds

.. id
.. _node_demote-id:
id
^^^^^^^^^^

.. The id filter matches a task’s id.

``id`` フィルタはタスクの ID に一致します。

.. code-block:: bash

   $ docker node ps -f id=bg8c07zzg87di2mufeq51a2qp swarm-manager1
   
   NAME                                IMAGE        NODE            DESIRED STATE  CURRENT STATE
   redis.7.bg8c07zzg87di2mufeq51a2qp   redis:3.0.6  swarm-manager1  Running        Running 5 seconds

.. label
.. _node_demote-label:

.. The label filter matches tasks based on the presence of a label alone or a label and a value.

``label`` フィルタは ``label`` 単独か ``label`` と値のどちらかに現れるタスクに一致します。

.. The following filter matches tasks with the usage label regardless of its value.

以下のフィルタは、値にかかわらず ``usage`` ラベルを持つタスクに一致します。

.. code-block:: bash

   $ docker node ps -f "label=usage"
   
   NAME                               IMAGE        NODE            DESIRED STATE  CURRENT STATE
   redis.6.b465edgho06e318egmgjbqo4o  redis:3.0.6  swarm-manager1  Running        Running 10 minutes
   redis.7.bg8c07zzg87di2mufeq51a2qp  redis:3.0.6  swarm-manager1  Running        Running 9 minutes

.. desired-state
.. _node_demote-desired-state:
desired-state
^^^^^^^^^^^^^^^^^^^^

.. The desired-state filter can take the values running, shutdown, or accepted.

``disired-state`` フィルタの値は ``running`` 、 ``shutdown`` 、 ``accepted`` です。



.. Formatting
.. _node_demote-formatting:
表示形式
----------

.. The formatting options (--format) pretty-prints nodes output using a Go template.

フォーマット・オプション（ ``--format`` ）は Go テンプレートを使いノードの出力を見やすくします。

.. Valid placeholders for the Go template are listed below:

Go テンプレートで有効なプレースホルダは以下の通りです。

.. list-table::
   :header-rows: 1
   
   * - プレースホルダ
     - 説明
   * - ``.ID``
     - タスク ID
   * - ``.Name``
     - タスク名

   * - ``.Image``
     - タスクのイメージ
   * - ``.Node``
     - Node ID
   * - ``.DesiredState``
     - タスクの :ruby:`期待状態 <desired state>` （ ``running`` 、 ``shutdown`` 、 ``accepted`` ）
   * - ``.CurrentState``
     - タスクの現在の状態
   * - ``.Error``
     - エラー
   * - ``.Ports``
     - タスク公開ポート

.. When using the --format option, the node ps command will either output the data exactly as the template declares or, when using the table directive, includes column headers as well.

``--format`` オプションの使用時、 ``node ps`` コマンドはテンプレートで宣言した通りにデータを出力します。あるいは、 ``table`` ディレクティブがあれば列のヘッダも表示するかのどちらかです。

.. The following example uses a template without headers and outputs the Name and Image entries separated by a colon (:) for all tasks:

以下の例は ``Name`` と ``Image`` のエントリをテンプレートで指定します。そして、コロン（ ``:`` ）区切りで全てのタスクを表示します。

.. code-block:: bash

   $ docker node ps --format "{{.Name}}: {{.Image}}"
   
   top.1: busybox
   top.2: busybox
   top.3: busybox


.. Parent command

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker node <node>`
     - Swarm ノードを管理


.. Related commands

関連コマンド
====================

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker node demote<node_demote>`
     - swarm 内の manager から1つまたは複数のノードを :ruby:`降格 <demote>`
   * - :doc:`docker node inspect<node_inspect>`
     - 1つまたは複数ノードの詳細情報を表示
   * - :doc:`docker node ls<node_ls>`
     - swarm 内のノードを一覧表示
   * - :doc:`docker node promote<node_promote>`
     - swarm 内の1つまたは複数のノードを manager に :ruby:`昇格 <promote>`
   * - :doc:`docker node ps<node_ps>`
     - 1つまたは複数のノード上で実行しているタスク一覧を表示。デフォルトは現在のノード上
   * - :doc:`docker node rm<node_rm>`
     - swarm 内の1つまたは複数のノードを削除
   * - :doc:`docker node update<node_update>`
     - ノードを更新


.. seealso:: 

   docker node ps
      https://docs.docker.com/engine/reference/commandline/node_ps/

