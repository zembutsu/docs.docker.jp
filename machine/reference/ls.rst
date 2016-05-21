.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/machine/reference/ls/
.. SOURCE: https://github.com/docker/machine/blob/master/docs/reference/ls.md
   doc version: 1.11
      https://github.com/docker/machine/commits/master/docs/reference/ls.md
.. check date: 2016/04/28
.. Commits on Feb 21, 2016 d7e97d04436601da26d24b199532652abe78770e
.. ----------------------------------------------------------------------------

.. ls

.. _machine-ls:

=======================================
ls
=======================================


.. code-block:: bash

   使い方: docker-machine ls [オプション] [引数...]
   
   マシン一覧を表示
   
   オプション:
   
      --quiet, -q                                  静かな (quite) モードを有効化
      --filter [--filter option --filter option]  指定した状況に応じてフィルタを出力
      --timeout, -t "10"                           タイムアウトを秒数で指定。デフォルトは 10 秒
      --format, -f                                 Go テンプレートに一致する内容で表示

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:


.. Timeout

タイムアウト
====================

.. The ls command tries to reach each host in parallel. If a given host does not answer in less than 10 seconds, the ls command will state that this host is in Timeout state. In some circumstances (poor connection, high load, or while troubleshooting), you may want to increase or decrease this value. You can use the -t flag for this purpose with a numerical value in seconds.

``ls`` コマンドは各ホストに対し、到達性を並列に確認します。対象のホストが 10 秒間応答しなければ、 ``ls`` コマンドで対象ホストの情報を ``Timeout`` 状態として表示します。同様の状況（接続が貧弱、高負荷、あるいはその他トラブルシューティング）では、値を上下させたくなるでしょう。 ``-t`` フラグを使い、整数値で秒数を指定できます。

.. Example

例
----------

.. code-block:: bash

   $ docker-machine ls -t 12
   NAME      ACTIVE   DRIVER       STATE     URL                         SWARM   DOCKER   ERRORS
   default   -        virtualbox   Running   tcp://192.168.99.100:2376           v1.9.0

.. Filtering

フィルタリング
====================

.. The filtering flag (--filter) format is a key=value pair. If there is more than one filter, then pass multiple flags (e.g. --filter "foo=bar" --filter "bif=baz")

フィルタリング・フラグ（ ``--filter`` ）の指定は ``key=value`` のペア形式です。複数のフィルタを使う場合は、複数のフラグを使います（例： ``--filter "foo=bar" --filter "bif=baz"`` ）。

.. The currently supported filters are:

現時点でサポートしているフィルタは次の通りです。

..    driver (driver name)
    swarm (swarm master’s name)
    state (Running|Paused|Saved|Stopped|Stopping|Starting|Error)
    name (Machine name returned by driver, supports golang style regular expressions)
    label (Machine created with --engine-label option, can be filtered with label=<key>[=<value>])

* driver（ドライバ名）
* swarm（swarm のマスタ名）
* state （状態： ``Running`` | ``Paused`` | ``Saved`` | ``Stopped`` | ``Stopping`` | ``Starting`` | ``Error`` ）
* name（ドライバが返すマシン名であり、 `Go 言語形式 <https://github.com/google/re2/wiki/Syntax>`_ の正規表現をサポート ）
* label（マシンを ``--engine-label`` オプションで作成すると、 ``label=<key>[=<value>]`` 形式でフィルタできる ）

.. Examples

例
----------

.. code-block:: bash

   $ docker-machine ls
   NAME   ACTIVE   DRIVER       STATE     URL                         SWARM   DOCKER   ERRORS
   dev    -        virtualbox   Stopped
   foo0   -        virtualbox   Running   tcp://192.168.99.105:2376           v1.9.1
   foo1   -        virtualbox   Running   tcp://192.168.99.106:2376           v1.9.1
   foo2   *        virtualbox   Running   tcp://192.168.99.107:2376           v1.9.1
   
   $ docker-machine ls --filter name=foo0
   NAME   ACTIVE   DRIVER       STATE     URL                         SWARM   DOCKER   ERRORS
   foo0   -        virtualbox   Running   tcp://192.168.99.105:2376           v1.9.1
   
   $ docker-machine ls --filter driver=virtualbox --filter state=Stopped
   NAME   ACTIVE   DRIVER       STATE     URL   SWARM   DOCKER   ERRORS
   dev    -        virtualbox   Stopped                 v1.9.1
   
   $ docker-machine ls --filter label=com.class.app=foo1 --filter label=com.class.app=foo2
   NAME   ACTIVE   DRIVER       STATE     URL                         SWARM   DOCKER   ERRORS
   foo1   -        virtualbox   Running   tcp://192.168.99.105:2376           v1.9.1
   foo2   *        virtualbox   Running   tcp://192.168.99.107:2376           v1.9.1


.. Formatting

書式
==========

.. The formatting option (--format) will pretty-print machines using a Go template.

マシンの結果を分かりやすくするため、書式オプション（ ``--format`` ）で Go 言語のテンプレートが使えます。

.. Valid placeholders for the Go template are listed below:

以下の Go テンプレートをプレースホルダに指定可能です。

.. list-table::
   :header-rows: 1
   
   * - プレースホルダ
     - 説明
   * - .Name
     - マシン名
   * - .Active
     - マシンがアクティブか
   * - .ActiveHost
     - マシンがアクティブな Swarm のホストではないか
   * - .ActiveSwarm
     - マシンがアクティブな Swarm マスタか
   * - .DriverName
     - ドライバ名
   * - .State
     - マシンの状態（実行中、停止中など）
   * - .URL
     - マシン URL
   * - .Swarm
     - マシンの Swarm 名
   * - .Error
     - マシンのエラー
   * - .DockerVersion
     - Docker デーモンのバージョン
   * - .ResponseTime
     - ホストの応答時間

.. When using the --format option, the ls command will either output the data exactly as the template declares or, when using the table directive, will include column headers as well.

``ls`` コマンドで ``--format`` オプションを使うと、テンプレートから自分が必要なデータだけ出力できます。また table 命令を使うと、ヘッダ部分も調整可能です。

.. The following example uses a template without headers and outputs the Name and Driver entries separated by a colon for all running machines:

以下の例では ``Name`` と ``Driver``  のエントリをヘッダ情報無しに表示します。

.. code-block:: bash

   $ docker-machine ls --format "{{.Name}}: {{.DriverName}}"
   default: virtualbox
   ec2: amazonec2

.. To list all machine names with their driver in a table format you can use:

全てのマシン名とドライバを表形式（table format）で表示できます。

.. code-block:: bash

   $ docker-machine ls --format "table {{.Name}} {{.DriverName}}"
   NAME     DRIVER
   default  virtualbox
   ec2      amazonec2

.. seealso:: 

   ls
      https://docs.docker.com/machine/reference/ls/
