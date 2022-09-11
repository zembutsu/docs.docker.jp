.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/node_ls/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/node_ls.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_node_ls.yaml
.. check date: 2022/03/30
.. Commits on Aug 21, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker node ls

=======================================
docker node ls
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _node_ls-description:

説明
==========

.. List nodes in the swarm

swarm 内のノードを一覧表示します。

.. API 1.24+
   Open the 1.24 API reference (in a new window)
   The client and daemon API must both be at least 1.24 to use this command. Use the docker version command on the client to check your client and daemon API versions.
   Swarm This command works with the Swarm orchestrator.

【API 1.24+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.24 <https://docs.docker.com/engine/api/v1.24/>`_ の必要があります。クライアントとデーモン API のバージョンを調べるには、 ``docker version`` コマンドを使います。

【Swarm】このコマンドは Swarm オーケストレータで動作します。


.. _node_ls-usage:

使い方
==========

.. code-block:: bash

   $ docker node ls [OPTIONS]

.. Extended description
.. _node_ls-extended-description:

補足説明
==========

.. Lists all the nodes that the Docker Swarm manager knows about. You can filter using the -f or --filter flag. Refer to the filtering section for more information about available filter options.

Docker Swarm マネージャ自身が把握している全ノード一覧を表示します。 ``-f`` か ``--filter`` フラグを使い、フィルタできます。利用可能なフィルタの詳しいオプションについては、 :ref:`フィルタリング <node_ls-filter>` のセクションをご覧ください。


..    Note
    This is a cluster management command, and must be executed on a swarm manager node. To learn about managers and workers, refer to the Swarm mode section in the documentation.

.. note::

   これはクラスタ管理コマンドであり、 swarm manager ノードで実行する必要があります。manager と worker について学ぶには、ドキュメント内の :doc:`Swarm モードのセクション </engine/swarm/index>` を参照ください。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <node_ls-examples>` をご覧ください。

.. _node_ls-options:

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
   * - ``--quiet`` , ``-q``
     - 
     - ID のみ表示


.. _node_ls-examples:

使用例
==========


.. code-block:: bash

   $ docker node ls
   
   ID                           HOSTNAME        STATUS  AVAILABILITY  MANAGER STATUS
   1bcef6utixb0l0ca7gxuivsj0    swarm-worker2   Ready   Active
   38ciaotwjuritcdtn9npbnkuz    swarm-worker1   Ready   Active
   e216jshn25ckzbvmwlnh5jr3g *  swarm-manager1  Ready   Active        Leader

.. Note
  In the above example output, there is a hidden column of .Self that indicates if the node is the same node as the current docker daemon. A * (e.g., e216jshn25ckzbvmwlnh5jr3g *) means this node is the current docker daemon.

.. note::

   上の出力例には、ノードが現在の docker デーモンと同じノードかどうかを示す、表示されていない ``.Self`` 列があります。 ``*`` （例 ``e216jshn25ckzbvmwlnh5jr3g *`` ）は、このノードが現在の docker デーモンだと示します。


.. Filtering
.. _node_ls-filter:
フィルタリング
--------------------

.. The filtering flag (-f or --filter) format is of "key=value". If there is more than one filter, then pass multiple flags (e.g., --filter "foo=bar" --filter "bif=baz")

フィルタリング・フラグ（ ``-f`` か ``--filter`` ）の書式は「キー=値」です。複数のフィルタを指定するには、複数回フラグを指定します（例：  ``--filter "foo=bar" --filter "bif=baz"`` ）。

.. The currently supported filters are:

現時点で次のフィルタをサポートしています：

* :ref:`id <node_ls-id>`
* :ref:`label <node_ls-label>`
* :ref:`node.label <node_ls-node.label>`
* :ref:`membership <node_ls-membership>`
* :ref:`name <node_ls-name>`
* :ref:`role <node_ls-role>`

.. _node_ls-id:
id
^^^^^^^^^^

.. The id filter matches all or part of a node's id.

``id`` フィルタは、ノード ID の全てもしくは一部と一致します。

.. code-block:: bash

   $ docker node ls -f id=1
   
   ID                         HOSTNAME       STATUS  AVAILABILITY  MANAGER STATUS
   1bcef6utixb0l0ca7gxuivsj0  swarm-worker2  Ready   Active

.. label
.. _node_ls-label:
label
^^^^^^^^^^

.. The label filter matches nodes based on engine labels and on the presence of a label alone or a label and a value. Engine labels are configured in the daemon configuration. To filter on Swarm node labels, use node.label instead.

``label`` フィルタで一致するのは、 engine 上のラベルと、 ``label`` 単体か ``label`` の値に対してです。 engine のラベルとは :ruby:`daemon 設定 <daemon-configuration-file>` で設定します。 Swarm ``node`` のラベルでフィルタをするには、 :ruby:`代わりに node.label <node_ls_nodelabel>` を使います。

.. The following filter matches nodes with the foo label regardless of its value.

以下のフィルタは、値にかかわらず ``foo`` のラベルを持つノードに一致します。

.. code-block:: bash

   $ docker node ls -f "label=foo"
   
   ID                         HOSTNAME       STATUS  AVAILABILITY  MANAGER STATUS
   1bcef6utixb0l0ca7gxuivsj0  swarm-worker2  Ready   Active

.. node.label
.. _node_ls-nodelabel:
node.label
^^^^^^^^^^

.. The node.label filter matches nodes based on node labels and on the presence of a node.label alone or a node.label and a value.

``node.label`` フィルタで一致するのは、ノード上のラベルと、 ``node.label`` 単体か ``node.label`` の値に対してです。

.. The following filter updates nodes to have a region node label:

以下のフィルタは、 ``region`` ノード・ラベルを持つノードを更新します。

.. code-block:: bash

   $ docker node update --label-add region=region-a swarm-test-01
   $ docker node update --label-add region=region-a swarm-test-02
   $ docker node update --label-add region=region-b swarm-test-03
   $ docker node update --label-add region=region-b swarm-test-04

.. Show all nodes that have a region node label set:

``region`` ノード・ラベルが設定されている全てのノードを表示します。

.. code-block:: bash

   $ docker node ls --filter node.label=region
   
   ID                            HOSTNAME        STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
   yg550ettvsjn6g6t840iaiwgb *   swarm-test-01   Ready     Active         Leader           20.10.2
   2lm9w9kbepgvkzkkeyku40e65     swarm-test-02   Ready     Active         Reachable        20.10.2
   hc0pu7ntc7s4uvj4pv7z7pz15     swarm-test-03   Ready     Active         Reachable        20.10.2
   n41b2cijmhifxxvz56vwrs12q     swarm-test-04   Ready     Active                          20.10.2

.. Show all nodes that have a region node label, with value region-a:

``region`` ノード・ラベルの値が ``region-a`` に設定されている全てのノードを表示します。

.. code-block:: bash

   $ docker node ls --filter node.label=region=region-a
   
   ID                            HOSTNAME        STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
   yg550ettvsjn6g6t840iaiwgb *   swarm-test-01   Ready     Active         Leader           20.10.2
   2lm9w9kbepgvkzkkeyku40e65     swarm-test-02   Ready     Active         Reachable        20.10.2

.. membership
.. _node_ls-membership:
membership
^^^^^^^^^^

.. The membership filter matches nodes based on the presence of a membership and a value accepted or pending.

``membership`` フィルタで一致するのは、ノード上のラベルに ``membership`` があり、値が ``accepted`` もしくは ``pending`` に対してです。

.. The following filter matches nodes with the membership of accepted.

以下のフィルタは、 ``membership`` が ``accepted`` に一致するノードです。

.. code-block:: bash

   $ docker node ls -f "membership=accepted"
   
   ID                           HOSTNAME        STATUS  AVAILABILITY  MANAGER STATUS
   1bcef6utixb0l0ca7gxuivsj0    swarm-worker2   Ready   Active
   38ciaotwjuritcdtn9npbnkuz    swarm-worker1   Ready   Active


.. name
.. _node_ls-name;
name
^^^^^^^^^^

.. The name filter matches on all or part of a tasks's name.

``name`` フィルタは、タスク名の全てもしくは一部に一致します。

.. The following filter matches the node with a name equal to swarm-master string.

以下は ``swarm-master`` 文字列に一致するノードでフィルタします。

.. code-block:: bash

   $ docker node ls -f name=swarm-manager1
   
   ID                           HOSTNAME        STATUS  AVAILABILITY  MANAGER STATUS
   e216jshn25ckzbvmwlnh5jr3g *  swarm-manager1  Ready   Active        Leader

.. role
.. _node_ls-role:
role
^^^^^^^^^^

.. The role filter matches nodes based on the presence of a role and a value worker or manager.

``role`` フィルタで一致するのは、ノード上のラベルに ``role`` があり、値が ``worker`` もしくは ``manager`` に対してです。

.. The following filter matches nodes with the manager role.

以下のフィルタは、 ``manager`` ロールに一致するノードです。

.. code-block:: bash

   $ docker node ls -f "role=manager"
   
   ID                           HOSTNAME        STATUS  AVAILABILITY  MANAGER STATUS
   e216jshn25ckzbvmwlnh5jr3g *  swarm-manager1  Ready   Active        Leader

.. Formatting
.. _node_ls-formatting:
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
     - ノード ID
   * - ``.Self``
     - デーモンのノード（ ``true`` か ``false`` 、 ``true`` は現在の docker デーモンと対象ノードが位置しているのを示す）
   * - ``.Hostname``
     - ノードのホスト名
   * - ``.Status``
     - ノード状態
   * - ``.Availability``
     - ノードの利用状況（ ``active`` , ``pause`` , ``drain`` ）
   * - ``.ManagerStatus``
     - ノードの manager 状態
   * - ``.TLSStatus``
     - ノードの TLS ステータス（ ``Ready`` か、古い CA で TLS 証明書に署名している場合は ``Needs Rotation`` ）
   * - ``.EngineVersion``
     - Engine のバージョン

.. When using the --format option, the node ls command will either output the data exactly as the template declares or, when using the table directive, includes column headers as well.

``--format`` オプションの使用時、 ``node ls`` コマンドはテンプレートで宣言した通りにデータを出力します。あるいは、 ``table`` ディレクティブがあれば列のヘッダも表示するかのどちらかです。

.. The following example uses a template without headers and outputs the ID, Hostname, and TLS Status entries separated by a colon (:) for all nodes:

以下の例は ``ID`` と ``Hostname`` と ``TLS Status`` のエントリをテンプレートで指定します。そして、コロン（ ``:`` ）区切りで全てのイメージを表示します。

.. code-block:: bash

   $ docker node ls --format "{{.ID}}: {{.Hostname}} {{.TLSStatus}}"
   
   e216jshn25ckzbvmwlnh5jr3g: swarm-manager1 Ready
   35o6tiywb700jesrt3dmllaza: swarm-worker1 Needs Rotation


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

   docker node ls
      https://docs.docker.com/engine/reference/commandline/node_ls/

