.. -*- coding: utf-8 -*-
.. https://docs.docker.com/machine/reference/ls/
.. doc version: 1.9
.. check date: 2016/01/28
.. -----------------------------------------------------------------------------

.. ls

.. _machine-ls:

=======================================
ls
=======================================

.. code-block:: bash

   Usage: docker-machine ls [OPTIONS] [arg...]
   
   List machines
   
   Options:
   
      --quiet, -q                                  Enable quiet mode
      --filter [--filter option --filter option]   Filter output based on conditions provided
      --timeout, -t                                Timeout in seconds, default to 10s

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

.. The filtering flag (-f or --filter) format is a key=value pair. If there is more than one filter, then pass multiple flags (e.g. --filter "foo=bar" --filter "bif=baz")

フィルタリング・フラグ（ ``-f`` か ``--filter`` ）の形式は ``key=value`` のペアです。複数のフィルタを使う場合は、複数のフラグを使います（例： ``--filter "foo=bar" --filter "bif=baz"`` ）。

.. The currently supported filters are:

現時点でサポートしているフィルタは次の通りです。

..    driver (driver name)
    swarm (swarm master’s name)
    state (Running|Paused|Saved|Stopped|Stopping|Starting|Error)
    name (Machine name returned by driver, supports golang style regular expressions)
    label (Machine created with --engine-label option, can be filtered with label=<key>[=<value>])

* driver（ドライバ名）
* swarm（swarm のマスタ名）
* state （状態： ``Running`` | ``Paused`` | ``Saved`` | ``Stopped`` | ``Stopping`` | ``Starting`` |``Error`` ）
* name（ドライバが返すマシン名であり、 `Go 言語形式 <https://github.com/google/re2/wiki/Syntax>`_ の正規表現をサポート ）
* label（マシンを ``--engine-label`` オプションで作成すると、 ``label=<key>[=<value>]`` 形式でフィルタできる ）

.. Examples

例
----------

.. code-block:: bash

   $ docker-machine ls
   NAME   ACTIVE   DRIVER       STATE     URL
   dev    -        virtualbox   Stopped
   foo0   -        virtualbox   Running   tcp://192.168.99.105:2376
   foo1   -        virtualbox   Running   tcp://192.168.99.106:2376
   foo2   *        virtualbox   Running   tcp://192.168.99.107:2376
   
   $ docker-machine ls --filter driver=virtualbox --filter state=Stopped
   NAME   ACTIVE   DRIVER       STATE     URL   SWARM
   dev    -        virtualbox   Stopped
   
   $ docker-machine ls --filter label=com.class.app=foo1 --filter label=com.class.app=foo2
   NAME   ACTIVE   DRIVER       STATE     URL
   foo1   -        virtualbox   Running   tcp://192.168.99.105:2376
   foo2   *        virtualbox   Running   tcp://192.168.99.107:2376

