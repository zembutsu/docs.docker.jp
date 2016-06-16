.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/node_tasks/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/node_tasks.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/node_tasks.md
.. check date: 2016/06/16
.. Commits on Jun 14, 2016 9acf97b72a4d5ff7b1bcad36fb19b53775f01596
.. -------------------------------------------------------------------

.. Warning: this command is part of the Swarm management feature introduced in Docker 1.12, and might be subject to non backward-compatible changes.

.. warning::

  このコマンドは Docker 1.12 で導入された Swarm 管理機能の一部です。それと、変更は下位互換性を考慮していない可能性があります。

.. node tasks

=======================================
node tasks
=======================================

.. code-block:: bash

   使い方:  docker node tasks [オプション] NODE
   
   ノード上で実行中のタスクを一覧表示
   
   オプション:
     -a, --all            全てのタスクを表示
     -f, --filter value   指定した条件をもとに出力をフィルタ
     --help           使い方の表示
     -n, --no-resolve     ID を名前に割り当てない（マップしない）


.. Lists all the nodes that the Docker Swarm manager knows about. You can filter using the -f or --filter flag. Refer to the filtering section for more information about available filter options.

Docker Swarm マネージャ自身が把握している全ノード一覧を表示します。 ``-f`` か ``--filter`` フラグを使い、フィルタできます。利用可能なフィルタの詳しいオプションについては、 :ref:`フィルタリング <node-tasks-filter>` のセクションをご覧ください。

.. Example output:

出力例：

.. code-block:: bash

   $ docker node tasks swarm-master
   ID                         NAME     SERVICE  IMAGE        DESIRED STATE  LAST STATE       NODE
   dx2g0fe3zsdb6y6q453f8dqw2  redis.1  redis    redis:3.0.6  RUNNING        RUNNING 2 hours  swarm-master
   f33pcf8lwhs4c1t4kq8szwzta  redis.4  redis    redis:3.0.6  RUNNING        RUNNING 2 hours  swarm-master
   5v26yzixl3one3ptjyqqbd0ro  redis.5  redis    redis:3.0.6  RUNNING        RUNNING 2 hours  swarm-master
   adcaphlhsfr30d47lby6walg6  redis.8  redis    redis:3.0.6  RUNNING        RUNNING 2 hours  swarm-master
   chancjvk9tex6768uzzacslq2  redis.9  redis    redis:3.0.6  RUNNING        RUNNING 2 hours  swarm-master

.. Filtering

.. _node-tasks-filter:

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

.. The following filter matches all tasks with a name containing the redis string.

以下は名前で ``ridis`` 文字列が一致する全てのタスクをフィルタします。

.. code-block:: bash

   $ docker node tasks -f name=redis swarm-master
   ID                         NAME     SERVICE  IMAGE        DESIRED STATE  LAST STATE       NODE
   dx2g0fe3zsdb6y6q453f8dqw2  redis.1  redis    redis:3.0.6  RUNNING        RUNNING 2 hours  swarm-master
   f33pcf8lwhs4c1t4kq8szwzta  redis.4  redis    redis:3.0.6  RUNNING        RUNNING 2 hours  swarm-master
   5v26yzixl3one3ptjyqqbd0ro  redis.5  redis    redis:3.0.6  RUNNING        RUNNING 2 hours  swarm-master
   adcaphlhsfr30d47lby6walg6  redis.8  redis    redis:3.0.6  RUNNING        RUNNING 2 hours  swarm-master
   chancjvk9tex6768uzzacslq2  redis.9  redis    redis:3.0.6  RUNNING        RUNNING 2 hours  swarm-master

id
----------

.. The id filter matches a task's id.

``id`` フィルタは、タスク id と一致します。

.. code-block:: bash

   $ docker node tasks -f id=f33pcf8lwhs4c1t4kq8szwzta swarm-master
   ID                         NAME     SERVICE  IMAGE        DESIRED STATE  LAST STATE       NODE
   f33pcf8lwhs4c1t4kq8szwzta  redis.4  redis    redis:3.0.6  RUNNING        RUNNING 2 hours  swarm-master

.. label

label
----------

.. The label filter matches tasks based on the presence of a label alone or a label and a value.

``label`` フィルタは、ラベル単体かラベルと名前に一致するタスクでフィルタします。

.. The following filter matches nodes with the usage label regardless of its value.

以下は何らかのラベルの値に一致するタスクでフィルタします。

.. code-block:: bash

   $ docker node tasks -f "label=usage"
   ID                         NAME     SERVICE  IMAGE        DESIRED STATE  LAST STATE       NODE
   dx2g0fe3zsdb6y6q453f8dqw2  redis.1  redis    redis:3.0.6  RUNNING        RUNNING 2 hours  swarm-master
   f33pcf8lwhs4c1t4kq8szwzta  redis.4  redis    redis:3.0.6  RUNNING        RUNNING 2 hours  swarm-master

.. Related information

関連情報
----------

* :doc:`node_inspect`
* :doc:`node_update`
* :doc:`node_tasks`
* :doc:`node_rm`

.. seealso:: 

   node tasks
      https://docs.docker.com/engine/reference/commandline/node_tasks/

