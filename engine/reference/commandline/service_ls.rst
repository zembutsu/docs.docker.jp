.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/service_ls/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/service_ls.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/service_ls.md
.. check date: 2016/06/21
.. Commits on Jun 20, 2016 daedbc60d61387cb284b871145b672006da1b6de
.. -------------------------------------------------------------------

.. service ls

.. _reference-service-ls:

=======================================
service ls
=======================================

.. code-block:: bash
   
   使い方:  docker service ls [オプション]
   
   サービスの一覧表示
   
   エイリアス:
     ls, list
   
   オプション:
     -f, --filter value   指定した状況に応じて出力をフィルタ
         --help           使い方の表示
     -q, --quiet          ID のみ表示

.. This command when run targeting a manager, lists services are running in the swarm.

このコマンドの実行対象はマネージャです。swarm 上で実行中の全サービスを一覧表示します。

.. On a manager node:

マネージャ・ノード上：

.. code-block:: bash

   ID            NAME      REPLICAS  IMAGE         COMMAND
   c8wgl7q4ndfd  frontend  5/5       nginx:alpine
   dmu1ept4cxcf  redis     3/3       redis:3.0.6

.. The REPLICAS column shows both the actual and desired number of tasks for the service.

``REPLICAS`` （レプリカ）列では、サービス用タスクの実際の数と期待数の両方を表示します。

.. Filtering

フィルタリング
====================

.. The filtering flag (-f or --filter) format is of "key=value". If there is more than one filter, then pass multiple flags (e.g., --filter "foo=bar" --filter "bif=baz")

フィルタリング・フラグ（ ``-f`` か ``--filter`` ）は「キー=値」の形式です。複数のフィルタを指定するには、複数回のフラグを指定します（例： ``--filter "foo=bar" --filter "bif=baz"`` ）。

.. The currently supported filters are:

現時点では、次のフィルタをサポートしています。

..    id
    label
    name

* :ref:`id <service_ls-id>`
* :ref:`label <service_ls-label>`
* :ref:`name <service_ls-name>`

.. ID

.. _service_ls-id:

ID
----------

.. The id filter matches all or part of a service's id.

``id`` フィルタはサービス ID の全てまたは一部に一致します。

.. code-block:: bash

   $ docker service ls -f "id=0bcjw"
   ID            NAME   REPLICAS  IMAGE        COMMAND
   0bcjwfh8ychr  redis  1/1       redis:3.0.6

.. Label

.. _service_ls-label:

label
----------

.. The label filter matches services based on the presence of a label alone or a label and a value.

``label`` フィルタは単一の ``label`` もしくは ``label`` の値に一致するサービスでフィルタします。

.. The following filter matches all services with a project label regardless of its value:

次のフィルタは ``project`` ラベルに一致するか、あるいは、そのラベルの値に一致します。

.. code-block:: bash

   $ docker service ls --filter label=project
   ID            NAME       REPLICAS  IMAGE         COMMAND
   01sl1rp6nj5u  frontend2  1/1       nginx:alpine
   36xvvwwauej0  frontend   5/5       nginx:alpine
   74nzcxxjv6fq  backend    3/3       redis:3.0.6

.. The following filter matches only services with the project label with the project-a value.

次のフィルタは ``project`` ラベルと値に ``project-a`` を持つサービスにのみ一致します。

.. code-block:: bash

   $ docker service ls --filter label=project=project-a
   ID            NAME      REPLICAS  IMAGE         COMMAND
   36xvvwwauej0  frontend  5/5       nginx:alpine
   74nzcxxjv6fq  backend   3/3       redis:3.0.6

.. Name

.. _service_ls-name:

名前
----------

.. The name filter matches on all or part of a tasks's name.

``name`` フィルタはタスク名の全てまたは一部に一致します。

.. The following filter matches services with a name containing redis.

次のフィルタはサービス名 ``redis`` に一致します。

.. code-block:: bash

   $ docker service ls --filter name=redis
   ID            NAME   REPLICAS  IMAGE        COMMAND
   0bcjwfh8ychr  redis  1/1       redis:3.0.6

関連情報
----------

* :doc:`service_create`
* :doc:`service_inspect`
* :doc:`service_rm`
* :doc:`service_scale`
* :doc:`service_tasks`
* :doc:`service_update`

.. seealso:: 

   service ls
      https://docs.docker.com/engine/reference/commandline/service_ls/

