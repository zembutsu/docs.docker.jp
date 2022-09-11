.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/stack_ps/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/stack_ps.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_stack_ps.yaml
.. check date: 2022/04/09
.. Commits on Apr 2, 2022 098129a0c12e3a79398b307b38a67198bd3b66fc
.. -------------------------------------------------------------------

.. docker stack ps

=======================================
docker stack ps
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _stack_ps-description:

説明
==========

.. List the tasks in the stack

スタック内のタスクを一覧表示します。

.. API 1.25+
   Open the 1.25 API reference (in a new window)
   The client and daemon API must both be at least 1.25 to use this command. Use the docker version command on the client to check your client and daemon API versions.

【API 1.25+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.25 <https://docs.docker.com/engine/api/v1.25/>`_ の必要があります。クライアントとデーモン API のバージョンを調べるには、 ``docker version`` コマンドを使います。


.. _stack_ps-usage:

使い方
==========

.. code-block:: bash

   $ docker stack ps [OPTIONS] STACK

.. Extended description
.. _stack_ps-extended-description:

補足説明
==========

.. Lists the tasks that are running as part of the specified stack.

指定したスタックの一部として実行しているタスクを、一覧標示します。

..    Note
    This is a cluster management command, and must be executed on a swarm manager node. To learn about managers and workers, refer to the Swarm mode section in the documentation.

.. note::

   これはクラスタ管理コマンドであり、 swarm manager ノードで実行する必要があります。manager と worker について学ぶには、ドキュメント内の :doc:`Swarm モードのセクション </engine/swarm/index>` を参照ください。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <stack_ps-examples>` をご覧ください。

.. _stack_ps-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--filter`` , ``-f``
     - 
     - 指定した状況に基づき出力を整形
  * - ``--format``
     - 
     - Go テンプレートを使ってスタックの出力を整形
    * - ``--namespaces``
     - 
     - 【deprecated】【Kubernetes】使用する Kubernetes 名前空間
  * - ``--no-resolve``
     - 
     - IP アドレスを名前の対応付けをしない
  * - ``--no-trunc``
     - 
     - 出力を省略しない
  * - ``--quiet`` , ``-q``
     - 
     - タスク ID のみ表示
   * - ``--kubeconfig``
     - 
     - 【非推奨】【Kubernetes】Kubernetes 設定ファイル
   * - ``--orchestrator``
     - 
     - 【非推奨】使用するオーケストレータ（ swarm | kubernetes | all）

.. _stack_ps-examples:

使用例
==========

.. List the tasks that are part of a stack
.. _scack_ps-list the tasks that are part of a stack:
スタックを構成するタスクの一覧標示
----------------------------------------

.. The following command shows all the tasks that are part of the voting stack:

以下のコマンドは、 ``voting`` スタックを構成する全てのタスクを表示します。

.. code-block:: bash

   $ docker stack ps voting
   
   ID                  NAME                  IMAGE                                          NODE   DESIRED STATE  CURRENT STATE          ERROR  PORTS
   xim5bcqtgk1b        voting_worker.1       dockersamples/examplevotingapp_worker:latest   node2  Running        Running 2 minutes ago
   q7yik0ks1in6        voting_result.1       dockersamples/examplevotingapp_result:before   node1  Running        Running 2 minutes ago
   rx5yo0866nfx        voting_vote.1         dockersamples/examplevotingapp_vote:before     node3  Running        Running 2 minutes ago
   tz6j82jnwrx7        voting_db.1           postgres:9.4                                   node1  Running        Running 2 minutes ago
   w48spazhbmxc        voting_redis.1        redis:alpine                                   node2  Running        Running 3 minutes ago
   6jj1m02freg1        voting_visualizer.1   dockersamples/visualizer:stable                node1  Running        Running 2 minutes ago
   kqgdmededccb        voting_vote.2         dockersamples/examplevotingapp_vote:before     node2  Running        Running 2 minutes ago
   t72q3z038jeh        voting_redis.2        redis:alpine                                   node3  Running        Running 3 minutes ago

.. _stack_ps-filtering

フィルタリング
------------------------------

.. The filtering flag (-f or --filter) format is a key=value pair. If there is more than one filter, then pass multiple flags (e.g. --filter "foo=bar" --filter "bif=baz"). Multiple filter flags are combined as an OR filter. For example, -f name=redis.1 -f name=redis.7 returns both redis.1 and redis.7 tasks.

フィルタリング・フラグ（ ``-f`` または ``--filter`` ）の書式は ``key=value`` のペアです。フィルタを何回もしたい場合は、複数のフラグを使います（例： ``-filter "foo=bar" --filter "bif=baz"`` ）。複数のフィルタを指定したら、 ``OR`` （同一条件）フィルタとして連結されます。例えば、 ``-f name=redis.1 -f name=redis.7`` は ``redis.1`` と ``redis.7``  の両タスクを返します。


.. The currently supported filters are:

現時点でサポートしているフィルタは、次の通りです。

* :ref:`id <stack_ps-id>`
* :ref:`name <stack_ps-name>`
* :ref:`node <stack_ps-node>`
* :ref:`desired-state <stack_ps-state>`


.. id
.. _stack_ps-id:
id
^^^^^^^^^^

.. The id filter matches on all or a prefix of a task’s ID.

``id`` フィルタはタスク ID の一部もしくは全体と一致します。

.. code-block:: bash

   $ docker stack ps -f "id=t" voting
   
   ID                  NAME                IMAGE               NODE         DESIRED STATE       CURRENTSTATE            ERROR  PORTS
   tz6j82jnwrx7        voting_db.1         postgres:9.4        node1        Running             Running 14 minutes ago
   t72q3z038jeh        voting_redis.2      redis:alpine        node3        Running             Running 14 minutes ago


.. node
.. _stack_ps-node:
node
^^^^^^^^^^

.. The node filter matches on a node name or a node ID.

``node`` フィルタは、ノード名もしくは ノード ID と一致します。

.. code-block:: bash

   $ docker stack ps -f "name=voting_redis" voting
   
   ID                  NAME                IMAGE               NODE         DESIRED STATE       CURRENTSTATE            ERROR  PORTS
   w48spazhbmxc        voting_redis.1      redis:alpine        node2        Running             Running 17 minutes ago
   t72q3z038jeh        voting_redis.2      redis:alpine        node3        Running             Running 17 minutes ago

.. node
.. _stack_ps-desired-state:
desired-state
^^^^^^^^^^^^^^^^^^^^

.. The desired-state filter can take the values running, shutdown, ready or accepted.

``disired-state`` フィルタで使える値は ``running`` 、 ``shutdown`` 、 ``ready`` 、 ``accepted`` です。

.. code-block:: bash

   $ docker stack ps -f "node=node1" voting
   
   ID                  NAME                  IMAGE                                          NODE   DESIRED STATE  CURRENT STATE          ERROR  PORTS
   q7yik0ks1in6        voting_result.1       dockersamples/examplevotingapp_result:before   node1  Running        Running 18 minutes ago
   tz6j82jnwrx7        voting_db.1           postgres:9.4                                   node1  Running        Running 18 minutes ago
   6jj1m02freg1        voting_visualizer.1   dockersamples/visualizer:stable                node1  Running        Running 18 minutes ago


.. _task_ps-formatting:
表示形式
----------

.. The formatting options (--format) pretty-prints tasks output using a Go template.

表示形式のオプション（ ``--format`` ）は、Go テンプレートを使ってタスクの出力を整形します。

.. Valid placeholders for the Go template are listed below:

Go テンプレートで有効なプレースホルダは以下の通りです。


.. list-table::
   :header-rows: 1

   * - placeholder
     - 説明
   * - ``.ID``
     - タスク ID
   * - ``.Name``
     - タスク名
   * - ``.Image``
     - タスクイメージ
   * - ``.Node``
     - ノード ID
   * - ``.DesiredState``
     - タスクの :ruby:`期待状態 <desired state>` （ ``running``, ``shutdown``, ``accepted`` ）
   * - ``.Currentstate``
     - タスクの現在の状態
   * - ``.Error``
     - エラー
   * - ``.Ports``
     - タスク公開ポート

.. When using the --format option, the stack command will either output the data exactly as the template declares or, when using the table directive, will include column headers as well.

``--format`` オプションを指定すると、 ``stack ps`` コマンドはテンプレートで宣言した通りにデータを出力するか、 ``table`` 命令を使えばカラム列も同様に表示するかのどちらかです。

.. The following example uses a template without headers and outputs the ID and Name entries separated by a colon (:) for all images:

以下の例はヘッダ無しのテンプレートを使い、全てのシークレットに対する ``Name`` と ``Image`` のエントリをコロン（ ``:`` ）で区切って出力します。

.. code-block:: bash

   $ docker stack ps --format "{{.Name}}: {{.Image}}" voting
   
   voting_worker.1: dockersamples/examplevotingapp_worker:latest
   voting_result.1: dockersamples/examplevotingapp_result:before
   voting_vote.1: dockersamples/examplevotingapp_vote:before
   voting_db.1: postgres:9.4
   voting_redis.1: redis:alpine
   voting_visualizer.1: dockersamples/visualizer:stable
   voting_vote.2: dockersamples/examplevotingapp_vote:before
   voting_redis.2: redis:alpine

.. Do not map IDs to Names
.. _stack_ps-do-not-map-ids-to-names:
ID と名前の対応をしない
------------------------------

.. The --no-resolve option shows IDs for task name, without mapping IDs to Names.

``--no-resolve`` オプションはタスク名の ID を表示しますが、ID から名前への対応付け（マッピング）を行いません。

.. code-block:: bash

   $ docker stack ps --no-resolve voting
   
   ID                  NAME                          IMAGE                                          NODE                        DESIRED STATE  CURRENT STATE            ERROR  PORTS
   xim5bcqtgk1b        10z9fjfqzsxnezo4hb81p8mqg.1   dockersamples/examplevotingapp_worker:latest   qaqt4nrzo775jrx6detglho01   Running        Running 30 minutes ago
   q7yik0ks1in6        hbxltua1na7mgqjnidldv5m65.1   dockersamples/examplevotingapp_result:before   mxpaef1tlh23s052erw88a4w5   Running        Running 30 minutes ago
   rx5yo0866nfx        qyprtqw1g5nrki557i974ou1d.1   dockersamples/examplevotingapp_vote:before     kanqcxfajd1r16wlnqcblobmm   Running        Running 31 minutes ago
   tz6j82jnwrx7        122f0xxngg17z52be7xspa72x.1   postgres:9.4                                   mxpaef1tlh23s052erw88a4w5   Running        Running 31 minutes ago
   w48spazhbmxc        tg61x8myx563ueo3urmn1ic6m.1   redis:alpine                                   qaqt4nrzo775jrx6detglho01   Running        Running 31 minutes ago
   6jj1m02freg1        8cqlyi444kzd3panjb7edh26v.1   dockersamples/visualizer:stable                mxpaef1tlh23s052erw88a4w5   Running        Running 31 minutes ago
   kqgdmededccb        qyprtqw1g5nrki557i974ou1d.2   dockersamples/examplevotingapp_vote:before     qaqt4nrzo775jrx6detglho01   Running        Running 31 minutes ago
   t72q3z038jeh        tg61x8myx563ueo3urmn1ic6m.2   redis:alpine                                   kanqcxfajd1r16wlnqcblobmm   Running        Running 31 minutes ago

.. Do not truncate output
.. _stack_ps-do-not-truncate-output:
出力を省略しない
--------------------

.. When deploying a service, docker resolves the digest for the service’s image, and pins the service to that digest. The digest is not shown by default, but is printed if --no-trunc is used. The --no-trunc option also shows the non-truncated task IDs, and error-messages, as can be seen below:

サービスのデプロイ時、docker はサービス用イメージのダイジェスト値を確認し、それからダイジェスト値をサービスに固定します。デフォルトではダイジェスト値は表示されませんが、 ``--no-trunc`` を使うと表示します。また、 ``--no-trunc`` オプションはタスク ID とエラーメッセージも、以下のように省略しません。

.. code-block:: bash

   $ docker stack ps --no-trunc voting
   
   ID                          NAME                  IMAGE                                                                                                                 NODE   DESIRED STATE  CURREN STATE           ERROR  PORTS
   xim5bcqtgk1bxqz91jzo4a1s5   voting_worker.1       dockersamples/examplevotingapp_worker:latest@sha256:3e4ddf59c15f432280a2c0679c4fc5a2ee5a797023c8ef0d3baf7b1385e9fed   node2  Running        Runnin 32 minutes ago
   q7yik0ks1in6kv32gg6y6yjf7   voting_result.1       dockersamples/examplevotingapp_result:before@sha256:83b56996e930c292a6ae5187fda84dd6568a19d97cdb933720be15c757b7463   node1  Running        Runnin 32 minutes ago
   rx5yo0866nfxc58zf4irsss6n   voting_vote.1         dockersamples/examplevotingapp_vote:before@sha256:8e64b182c87de902f2b72321c89b4af4e2b942d76d0b772532ff27ec4c6ebf6     node3  Running        Runnin 32 minutes ago
   tz6j82jnwrx7n2offljp3mn03   voting_db.1           postgres:9.4@sha256:6046af499eae34d2074c0b53f9a8b404716d415e4a03e68bc1d2f8064f2b027                                   node1  Running        Runnin 32 minutes ago
   w48spazhbmxcmbjfi54gs7x90   voting_redis.1        redis:alpine@sha256:9cd405cd1ec1410eaab064a1383d0d8854d1ef74a54e1e4a92fb4ec7bdc3ee7                                   node2  Running        Runnin 32 minutes ago
   6jj1m02freg1n3z9n1evrzsbl   voting_visualizer.1   dockersamples/visualizer:stable@sha256:f924ad66c8e94b10baaf7bdb9cd491ef4e982a1d048a56a17e02bf5945401e5                node1  Running        Runnin 32 minutes ago
   kqgdmededccbhz2wuc0e9hx7g   voting_vote.2         dockersamples/examplevotingapp_vote:before@sha256:8e64b182c87de902f2b72321c89b4af4e2b942d76d0b772532ff27ec4c6ebf6     node2  Running        Runnin 32 minutes ago
   t72q3z038jehe1wbh9gdum076   voting_redis.2        redis:alpine@sha256:9cd405cd1ec1410eaab064a1383d0d8854d1ef74a54e1e4a92fb4ec7bdc3ee7                                   node3  Running        Runnin 32 minutes ago

.. Only display task IDs
.. _stack_ps-only-display-task-ids:
タスク ID のみ表示
--------------------

.. The -q or --quiet option only shows IDs of the tasks in the stack. This example outputs all task IDs of the “voting” stack;

``-q`` または ``--quiet`` オプションはスタック内のタスク ID のみ表示します。以下の例は "voting" スタックのタスク ID すべてを表示します。

.. code-block:: bash

   $ docker stack ps -q voting
   xim5bcqtgk1b
   q7yik0ks1in6
   rx5yo0866nfx
   tz6j82jnwrx7
   w48spazhbmxc
   6jj1m02freg1
   kqgdmededccb
   t72q3z038jeh

.. This option can be used to perform batch operations. For example, you can use the task IDs as input for other commands, such as docker inspect. The following example inspects all tasks of the “voting” stack;

このオプションはバッチ操作を処理するために使えます。たとえば、タスク ID を ``docker inspect`` のような他のコマンドの入力に使います。以下の例は "voting" スタックの全タスクを調べます。

.. code-block:: bash

   $ docker inspect $(docker stack ps -q voting)
   
   [
       {
           "ID": "xim5bcqtgk1b1gk0krq1",
           "Version": {
   <...>


.. Parent command

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker stack <stack>`
     - Docker stack を管理

.. Related commands

関連コマンド
====================

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker stack deploy<stack_deploy>`
     - 新しいスタックをデプロイするか、既存のスタックを更新
   * - :doc:`docker stack ls<stack_ls>`
     - スタックを一覧表示
   * - :doc:`docker stack ps<stack_ps>`
     - スタック内のタスクを一覧表示
   * - :doc:`docker stack rm<stack_rm>`
     - 1つまたは複数スタックを削除
   * - :doc:`docker stack services<stack_services>`
     - タスク内のサービスを一覧表示


.. seealso:: 

   docker stack ps
      https://docs.docker.com/engine/reference/commandline/stack_ps/
