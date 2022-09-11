.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/container_prune/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/container_prune.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_container_prune.yaml
.. check date: 2022/03/15
.. Commits on Aug 22, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker container prune

=======================================
docker container prune
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _container_prune-description:

説明
==========

.. Remove all stopped containers

すべての停止中のコンテナを削除します。

.. API 1.25+  The client and daemon API must both be at least 1.25 to use this command. Use the docker version command on the client to check your client and daemon API versions.

【API 1.25+】 このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.30 <https://docs.docker.com/engine/api/v1.30/>`_ の必要があります。クライアントとデーモンの API バージョンを調べるには、クライアント上で ``docker version`` コマンドを使います。

.. _container_prune-usage:

使い方
==========

.. code-block:: bash

   $ docker container prune [OPTIONS]

.. Extended description
.. _container_prune-extended-description:

補足説明
==========

.. Removes all stopped containers.

停止中のコンテナを全て削除します。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <container_prune-examples>` をご覧ください。


.. _container_cp-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--filter``
     - 
     - フィルタ値を指定（例 ``until=<タイムスタンプ>`` ）
   * - ``--force``, ``-f``
     - 
     - 確認のプロンプトを表示しない

.. _container_prune-examples:

使用例
==========

.. Prune containers

不要なコンテナの :ruby:`削除 <prune>`
----------------------------------------
 
 .. code-block:: bash
 
   $ docker container prune
   WARNING! This will remove all stopped containers.
   Are you sure you want to continue? [y/N] y
   Deleted Containers:
   4a7f7eebae0f63178aff7eb0aa39cd3f0627a203ab2df258c1a00b456cf20063
   f98f9c2aa1eaf727e4ec9c0283bc7d4aa4762fbdba7f26191f26c97f64090360
 
   Total reclaimed space: 212 B

.. Filtering
.. _container_prune-filtering:
フィルタリング
--------------------

.. The filtering flag (--filter) format is of “key=value”. If there is more than one filter, then pass multiple flags (e.g., --filter "foo=bar" --filter "bif=baz")

フィルタリングのフラグ（ ``--filter`` ）書式は「key=value」です。複数のフィルタがある場合は、フラグを複数回渡します（例 ``--filter "foo=bar" --filter "bif=baz"`` ）。

.. The currently supported filters are:

現在サポートしているフィルタは、こちらです。

..  until (<timestamp>) - only remove containers created before given timestamp
    label (label=<key>, label=<key>=<value>, label!=<key>, or label!=<key>=<value>) - only remove containers with (or without, in case label!=... is used) the specified labels.

* until （ ``<timestamp>`` まで ） - 指定したタイムスタンプより前に作成したコンテナのみ削除します。
* label （ ``label=<key>`` 、  ``label=<key>=<value>`` 、 ``label!=<key>`` 、 ``label!=<key>=<value>`` ） - 指定したラベルのコンテナのみ削除します（または、 ``label!=...`` が使われる場合は、ラベルがない場合 ）

.. The until filter can be Unix timestamps, date formatted timestamps, or Go duration strings (e.g. 10m, 1h30m) computed relative to the daemon machine’s time. Supported formats for date formatted time stamps include RFC3339Nano, RFC3339, 2006-01-02T15:04:05, 2006-01-02T15:04:05.999999999, 2006-01-02Z07:00, and 2006-01-02. The local timezone on the daemon will be used if you do not provide either a Z or a +-00:00 timezone offset at the end of the timestamp. When providing Unix timestamps enter seconds[.nanoseconds], where seconds is the number of seconds that have elapsed since January 1, 1970 (midnight UTC/GMT), not counting leap seconds (aka Unix epoch or Unix time), and the optional .nanoseconds field is a fraction of a second no more than nine digits long.

``until`` でフィルタできるのは Unix タイムスタンプ、日付形式のタイムスタンプ、あるいはデーモンが動作しているマシン上の時刻からの相対時間を、 Go duration 文字列（例： ``10m`` 、 ``1h3-m`` ）で計算します。日付形式のタイムスタンプがサポートしているのは、RFC3339Nano 、 RFC3339 、 ``2006-01-02T15:04:05`` 、 ``2006-01-02T15:04:05.999999999`` 、 ``2006-01-02Z07:00`` 、 ``2006-01-02`` です。タイムスタンプの最後にタイムゾーンオフセットとして ``Z`` か ``+-00:00`` が指定されなければ、デーモンはローカルのタイムゾーンを使います。Unix タイムスタンプを 秒[.ナノ秒] で指定すると、秒数は 1970 年 1 月 1 日（UTC/GMT 零時）からの経過時間ですが、うるう秒（別名 Unix epoch や Unix time）を含みません。また、オプションで、9桁以上  .ナノ秒 フィールドは省略されます。

.. The label filter accepts two formats. One is the label=... (label=<key> or label=<key>=<value>), which removes containers with the specified labels. The other format is the label!=... (label!=<key> or label!=<key>=<value>), which removes containers without the specified labels.

``label`` フィルタは2つの形式に対応します。1つは ``label=...`` （ ``label=<key>`` または ``label=<key>=<value>`` ）であり、指定したラベルを持つコンテナを削除します。もう1つの形式は ``label!=...`` （ ``label!=<key>`` または ``label!=<key>=<value>`` ）であり、指定たラベルがないコンテナを削除します。

.. The following removes containers created more than 5 minutes ago

以下は5分以上前に作成されたコンテナを削除します。


.. code-block:: bash
 
   $ docker ps -a --format 'table {{.ID}}\t{{.Image}}\t{{.Command}}\t{{.CreatedAt}}\t{{.Status}}'
   
   CONTAINER ID        IMAGE               COMMAND             CREATED AT                      STATUS
   61b9efa71024        busybox             "sh"                2017-01-04 13:23:33 -0800 PST   Exited (0) 41 seconds ago
   53a9bc23a516        busybox             "sh"                2017-01-04 13:11:59 -0800 PST   Exited (0) 12 minutes ago
   
   $ docker container prune --force --filter "until=5m"
   
   Deleted Containers:
   53a9bc23a5168b6caa2bfbefddf1b30f93c7ad57f3dec271fd32707497cb9369
   
   Total reclaimed space: 25 B
   
   $ docker ps -a --format 'table {{.ID}}\t{{.Image}}\t{{.Command}}\t{{.CreatedAt}}\t{{.Status}}'
   
   CONTAINER ID        IMAGE               COMMAND             CREATED AT                      STATUS
   61b9efa71024        busybox             "sh"                2017-01-04 13:23:33 -0800 PST   Exited (0) 44 seconds ago

..   The following removes containers created before `2017-01-04T13:10:00`:

以下は、 ``2017-01-04T13:10:00`` の前に作成されたコンテナを削除します。

.. code-block:: bash

   $ docker ps -a --format 'table {{.ID}}\t{{.Image}}\t{{.Command}}\t{{.CreatedAt}}\t{{.Status}}'
   
   CONTAINER ID        IMAGE               COMMAND             CREATED AT                      STATUS
   53a9bc23a516        busybox             "sh"                2017-01-04 13:11:59 -0800 PST   Exited (0) 7 minutes ago
   4a75091a6d61        busybox             "sh"                2017-01-04 13:09:53 -0800 PST   Exited (0) 9 minutes ago
   
   $ docker container prune --force --filter "until=2017-01-04T13:10:00"
   
   Deleted Containers:
   4a75091a6d618526fcd8b33ccd6e5928ca2a64415466f768a6180004b0c72c6c
   
   Total reclaimed space: 27 B
   
   $ docker ps -a --format 'table {{.ID}}\t{{.Image}}\t{{.Command}}\t{{.CreatedAt}}\t{{.Status}}'
   
   CONTAINER ID        IMAGE               COMMAND             CREATED AT                      STATUS
   53a9bc23a516        busybox             "sh"                2017-01-04 13:11:59 -0800 PST   Exited (0) 9 minutes ago

.. Parent command

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI のベースコマンド。


.. Related commands

関連コマンド
====================

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker container attach<container_attach>`
     - ローカルの標準入出、標準出力、標準エラーのストリームに、実行中のコンテナを :ruby:`接続 <attach>`
   * - :doc:`docker container commit<container_commit>`
     - コンテナの変更から新しいイメージを作成
   * - :doc:`docker container cp<container_cp>`
     - コンテナとローカルファイルシステム間で、ファイルやフォルダを :ruby:`コピー <copy>`
   * - :doc:`docker container create<container_create>`
     - 新しいコンテナを :ruby:`作成 <create>`
   * - :doc:`docker container diff<container_diff>`
     - コンテナのファイルシステム上で、ファイルやディレクトリの変更を調査
   * - :doc:`docker container exec<container_exec>`
     - 実行中のコンテナ内でコマンドを実行
   * - :doc:`docker container export<container_export>`
     - コンテナのファイルシステムを tar アーカイブとして :ruby:`出力 <export>`
   * - :doc:`docker container inspect<container_inspect>`
     - 1つまたは複数コンテナの情報を表示
   * - :doc:`docker container kill<container_kill>`
     - 1つまたは複数の実行中コンテナを :ruby:`強制停止 <kill>`
   * - :doc:`docker container logs<container_logs>`
     - コンテナのログを取得
   * - :doc:`docker container ls<container_ls>`
     - コンテナ一覧
   * - :doc:`docker container pause<container_pause>`
     - 1つまたは複数コンテナ内の全てのプロセスを :ruby:`一時停止 <pause>`
   * - :doc:`docker container port<container_port>`
     - ポート :ruby:`割り当て <mapping>` の一覧か、特定のコンテナに対する :ruby:`割り当て <mapping>`
   * - :doc:`docker container prune<container_prune>`
     - すべての停止中のコンテナを削除
   * - :doc:`docker container rename<container_rename>`
     - コンテナの :ruby:`名前変更 <rename>`
   * - :doc:`docker container restart<container_restart>`
     - 1つまたは複数のコンテナを再起動
   * - :doc:`docker container rm<container_rm>`
     - 1つまたは複数のコンテナを :ruby:`削除 <remove>`
   * - :doc:`docker container run<container_run>`
     - 新しいコンテナでコマンドを :ruby:`実行 <run>`
   * - :doc:`docker container start<container_start>`
     - 1つまたは複数のコンテナを :ruby:`開始 <start>`
   * - :doc:`docker container stats<container_stats>`
     - コンテナのリソース使用統計情報をライブストリームで表示
   * - :doc:`docker container stop<container_stop>`
     - 1つまたは複数の実行中コンテナを :ruby:`停止 <stop>`
   * - :doc:`docker container top<container_top>`
     - コンテナで実行中のプロセスを表示
   * - :doc:`docker container unpause<container_unpause>`
     - 1つまたは複数コンテナの :ruby:`一時停止を解除 <unpause>`
   * - :doc:`docker container update<container_update>`
     - 1つまたは複数コンテナの設定を :ruby:`更新 <update>`
   * - :doc:`docker container wait<container_wait>`
     - 1つまたは複数コンテナが停止するまでブロックし、終了コードを表示

.. seealso:: 

   docker container prune
      https://docs.docker.com/engine/reference/commandline/container_prune/
