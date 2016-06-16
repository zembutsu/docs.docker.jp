.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/node_ls/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/node_ls.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/node_ls.md
.. check date: 2016/06/16
.. Commits on Jun 14, 2016 9acf97b72a4d5ff7b1bcad36fb19b53775f01596
.. -------------------------------------------------------------------

.. Warning: this command is part of the Swarm management feature introduced in Docker 1.12, and might be subject to non backward-compatible changes.

.. warning::

  このコマンドは Docker 1.12 で導入された Swarm 管理機能の一部です。それと、変更は下位互換性を考慮していない可能性があります。

.. node ls

=======================================
node ls
=======================================

.. code-block:: bash

   使い方:  docker node ls [オプション]
   
   swarm ノード一覧を表示
   
   エイリアス:
     ls, list
   
   オプション:
     -f, --filter value   指定した条件で出力をフィルタ
         --help           使い方の表示
     -q, --quiet          ID のみ表示

.. Lists all the nodes that the Docker Swarm manager knows about. You can filter using the -f or --filter flag. Refer to the filtering section for more information about available filter options.

Docker Swarm マネージャ自身が把握している全ノード一覧を表示します。 ``-f`` か ``--filter`` フラグを使い、フィルタできます。利用可能なフィルタの詳しいオプションについては、 :ref:`フィルタリング <node-ls-filter>` のセクションをご覧ください。

.. Example output:

出力例：

.. code-block:: bash

   $ docker node ls
   ID              NAME           STATUS  AVAILABILITY     MANAGER STATUS  LEADER
   0gac67oclbxq    swarm-master   Ready   Active           Reachable       Yes
   0pwvm3ve66q7    swarm-node-02  Ready   Active
   15xwihgw71aw *  swarm-node-01  Ready   Active           Reachable

.. Filtering

.. _node-ls-filter:

フィルタリング
====================

.. The filtering flag (-f or --filter) format is of "key=value". If there is more than one filter, then pass multiple flags (e.g., --filter "foo=bar" --filter "bif=baz")

フィルタリング・フラグ（ ``-f`` か ``--filter`` ）の書式は「キー=値」です。複数のフィルタを指定するには、複数回フラグを指定します（例：  ``--filter "foo=bar" --filter "bif=baz"`` ）。

.. The currently supported filters are:

現時点で次のフィルタをサポートしています：

..    name
    id
    label
    desired_state

* 名前
* id
* ラベル
* 望ましい状態（desired_state）

name
----------

.. The name filter matches on all or part of a tasks's name.

``name`` フィルタは、タスク名の全てもしくは一部に一致します。

.. The following filter matches the node with a name equal to swarm-master string.

以下は ``swarm-master`` 文字列に一致するノードでフィルタします。

.. code-block:: bash

   $ docker node ls -f name=swarm-master
   ID              NAME          STATUS  AVAILABILITY      MANAGER STATUS  LEADER
   0gac67oclbxq *  swarm-master  Ready   Active            Reachable       Yes

id
----------

.. The id filter matches all or part of a node's id.

``id`` フィルタは、ノード ID の全てもしくは一部と一致します。

.. code-block:: bash

   $ docker node ls -f id=0
   ID              NAME           STATUS  AVAILABILITY     MANAGER STATUS  LEADER
   0gac67oclbxq *  swarm-master   Ready   Active           Reachable       Yes
   0pwvm3ve66q7    swarm-node-02  Ready   Active

.. label

label
----------

.. The label filter matches tasks based on the presence of a label alone or a label and a value.

``label`` フィルタは、ラベル単体かラベルと名前に一致するタスクでフィルタします。

.. The following filter matches nodes with the usage label regardless of its value.

以下は何らかのラベルの値に一致するノードでフィルタします。

.. code-block:: bash

   $ docker node ls -f "label=foo"
   ID              NAME           STATUS  AVAILABILITY     MANAGER STATUS  LEADER
   15xwihgw71aw *  swarm-node-01  Ready   Active           Reachable

.. Related information

関連情報
----------

* :doc:`node_inspect`
* :doc:`node_update`
* :doc:`node_tasks`
* :doc:`node_rm`

.. seealso:: 

   node ls
      https://docs.docker.com/engine/reference/commandline/node_ls/

