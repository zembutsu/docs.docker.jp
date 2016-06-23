.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/service_tasks/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/service_tasks.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/service_tasks.md
.. check date: 2016/06/21
.. Commits on Jun 20, 2016 daedbc60d61387cb284b871145b672006da1b6de
.. -------------------------------------------------------------------

.. service tasks

.. _reference-service-tasks:

=======================================
service tasks
=======================================

.. code-block:: bash

   使い方:  docker service tasks [オプション] サービス
   
   サービスのタスク一覧を表示
   
   オプション:
     -a, --all            すべてのタスクを表示
     -f, --filter value   指定した状況に基づき出力をフィルタ
         --help           使い方の表示
     -n, --no-resolve     ID を名前に割り当てない

.. Lists the tasks that are running as part of the specified service. This command has to be run targeting a manager node.

指定したサービスを構成する、実行中タスクの一覧を表示します。このコマンドの実行対象はマネージャ・ノードです。

.. Examples

例
==========

.. Listing the tasks that are part of a service

サービスを構成するタスクを一覧
------------------------------

.. The following command shows all the tasks that are part of the redis service:

次のコマンドは ``redis`` サービスを構成する全てのタスクを表示します。

.. code-block:: bash

   $ docker service tasks redis
   ID                         NAME      SERVICE IMAGE        LAST STATE          DESIRED STATE  NODE
   0qihejybwf1x5vqi8lgzlgnpq  redis.1   redis   redis:3.0.6  Running 8 seconds   Running        manager1
   bk658fpbex0d57cqcwoe3jthu  redis.2   redis   redis:3.0.6  Running 9 seconds   Running        worker2
   5ls5s5fldaqg37s9pwayjecrf  redis.3   redis   redis:3.0.6  Running 9 seconds   Running        worker1
   8ryt076polmclyihzx67zsssj  redis.4   redis   redis:3.0.6  Running 9 seconds   Running        worker1
   1x0v8yomsncd6sbvfn0ph6ogc  redis.5   redis   redis:3.0.6  Running 8 seconds   Running        manager1
   71v7je3el7rrw0osfywzs0lko  redis.6   redis   redis:3.0.6  Running 9 seconds   Running        worker2
   4l3zm9b7tfr7cedaik8roxq6r  redis.7   redis   redis:3.0.6  Running 9 seconds   Running        worker2
   9tfpyixiy2i74ad9uqmzp1q6o  redis.8   redis   redis:3.0.6  Running 9 seconds   Running        worker1
   3w1wu13yuplna8ri3fx47iwad  redis.9   redis   redis:3.0.6  Running 8 seconds   Running        manager1
   8eaxrb2fqpbnv9x30vr06i6vt  redis.10  redis   redis:3.0.6  Running 8 seconds   Running        manager1

.. Filtering

フィルタリング
====================

.. The filtering flag (-f or --filter) format is a key=value pair. If there is more than one filter, then pass multiple flags (e.g. --filter "foo=bar" --filter "bif=baz"). Multiple filter flags are combined as an OR filter. For example, -f type=custom -f type=builtin returns both custom and builtin networks.

フィルタリング・フラグ（ ``-f`` か ``--filter`` ） は ``キー=値`` ペアの形式です。複数のフィルタを使うには、複数のフラグを指定します（例： ``--filter "foo=bar" --filter "bif=baz"`` ）。複数のフィルタは ``or`` （論理和）フィルタとして連結します。たとえば ``-f type=custom -f type=builtin`` は ``custom`` と ``builtin`` ネットワークの両方を返します。

.. The currently supported filters are:

現時点でサポートしているフィルタは、以下の通りです。

..    id
    name

* :ref:`id <service_tasks_id>`
* :ref:`name <service_tasks_name>`

.. _service_tasks_id:

ID
----------

.. The id filter matches on all or a prefix of a task's ID.

``id`` フィルタはタスク ID の全体か冒頭に一致します。

.. code-block:: bash

   $ docker service tasks -f "id=8" redis
   ID                         NAME      SERVICE  IMAGE        LAST STATE         DESIRED STATE  NODE
   8ryt076polmclyihzx67zsssj  redis.4   redis    redis:3.0.6  Running 4 minutes  Running        worker1
   8eaxrb2fqpbnv9x30vr06i6vt  redis.10  redis    redis:3.0.6  Running 4 minutes  Running        manager1

.. Name

.. _service_tasks_name:

名前
----------

.. The name filter matches on task names.

``name`` フィルタはタスク名に一致します。

.. code-block:: bash

   $ docker service tasks -f "name=redis.1" redis
   ID                         NAME      SERVICE  IMAGE        DESIRED STATE  LAST STATE         NODE
   0qihejybwf1x5vqi8lgzlgnpq  redis.1   redis    redis:3.0.6  Running        Running 8 seconds  manager1

関連情報
----------

* :doc:`service_create`
* :doc:`service_inspect`
* :doc:`service_ls`
* :doc:`service_rm`
* :doc:`service_scale`
* :doc:`service_update`

.. seealso:: 

   service tasks
      https://docs.docker.com/engine/reference/commandline/service_tasks/

