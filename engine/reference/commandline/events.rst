.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/events/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/events.md
   doc version: 1.11
      https://github.com/docker/docker/commits/master/docs/reference/commandline/events.md
.. check date: 2016/04/26
.. Commits on Feb 19, 2016 cdc7f26715fbf0779a5283354048caf9faa1ec4a
.. -------------------------------------------------------------------

.. events

=======================================
events
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. code-block:: bash

   Usage: docker events [OPTIONS]
   
   Get real time events from the server
   
     -f, --filter=[]    Filter output based on conditions provided
     --help             Print usage
     --since=""         Show all events created since timestamp
     --until=""         Stream events until this timestamp

.. Docker containers report the following events:

Docker コンテナは以下のイベントを報告します。

.. code-block:: bash

   attach, commit, copy, create, destroy, die, exec_create, exec_start, export, kill, oom, pause, rename, resize, restart, start, stop, top, unpause, update

.. Docker images report the following events:

Docker イメージは以下のイベントを報告します。

.. code-block:: bash

   delete, import, pull, push, tag, untag

.. Docker volumes report the following events:

Docker ボリュームは以下のイベントを報告します。

.. code-block:: bash

   create, mount, unmount, destroy

.. Docker networks report the following events:

Docker ネットワークは以下のイベントを報告します。

.. code-block:: bash

   create, connect, disconnect, destroy

.. The --since and --until parameters can be Unix timestamps, RFC3339 dates or Go duration strings (e.g. 10m, 1h30m) computed relative to client machine’s time. If you do not provide the –since option, the command returns only new and/or live events.

``--since`` と ``--until`` パラメータでは、 Unix タイムスタンプ、 RFC 3339 の dates 、Go 言語の期間文字列（例： ``10m`` 、 ``1h30m`` ）をクライアントのマシン時刻から相対的に扱えます。 ``--since`` オプションを指定しなければ、コマンドは新しく追加されたか現在のイベントのみ表示します。

.. Filtering

.. _filtering:

フィルタリング
====================

.. The filtering flag (-f or --filter) format is of “key=value”. If you would like to use multiple filters, pass multiple flags (e.g., --filter "foo=bar" --filter "bif=baz")

フィルタリング・フラグ（ ``-f`` と ``--filter`` ）は ``key=value`` の形式です。複数のフィルタを使いたい場合は、複数回フラグを指定します（例： ``--filter "foo=bar" --filter "bif=baz"`` ）。

.. Using the same filter multiple times will be handled as a OR; for example --filter container=588a23dac085 --filter container=a8f7720b8c22 will display events for container 588a23dac085 OR container a8f7720b8c22

同じフィルタを複数回指定すると、「OR」（または）という条件として処理されます。例えば ``--filter container=588a23dac085 --filter container=a8f7720b8c22`` は、コンテナ 588a23dac085 かコンテナ a8f7720b8c22 のイベントを表示します。

.. Using multiple filters will be handled as a AND; for example --filter container=588a23dac085 --filter event=start will display events for container container 588a23dac085 AND the event type is start

複数のフィルタを使うと、「AND」（および）という条件として処理されます。たとえば、 ``--filter container=588a23dac085 --filter event=start`` は、コンテナ 588a23dac085 のイベントタイプが *start* のイベントのみ表示します。

.. The currently supported filters are:

現時点でサポートされているフィルタは次の通りです。

..    container (container=<name or id>)
    event (event=<event type>)
    image (image=<tag or id>)
    label (label=<key> or label=<key>=<value>)

* コンテナ（ ``container=<名前か ID>`` ）
* イベント（ ``event=<イベント・タイプ>`` ）
* イメージ（ ``image=<タグか ID>`` ）
* ラベル（ ``label=<key>`` または ``label=<key>=<value>`` ）

.. Examples

.. _examples-cli-events:

例
==========

.. You’ll need two shells for this example.

この例には２つのシェルが必要です。

.. Shell 1: Listening for events:

**シェル１：イベント一覧を表示：**

.. code-block:: bash

   $ docker events

.. Shell 2: Start and Stop containers:

**シェル２：コンテナを開始して停止ます**

.. code-block:: bash

   $ docker start 4386fb97867d
   $ docker stop 4386fb97867d
   $ docker stop 7805c1d35632

.. Shell 1: (Again .. now showing events):

**シェル１：（再度実行すると、イベントが表示されます）** 

.. code-block:: bash

   2014-05-10T17:42:14.999999999Z07:00 4386fb97867d: (from ubuntu-1:14.04) start
   2014-05-10T17:42:14.999999999Z07:00 4386fb97867d: (from ubuntu-1:14.04) die
   2014-05-10T17:42:14.999999999Z07:00 4386fb97867d: (from ubuntu-1:14.04) stop
   2014-05-10T17:42:14.999999999Z07:00 7805c1d35632: (from redis:2.8) die
   2014-05-10T17:42:14.999999999Z07:00 7805c1d35632: (from redis:2.8) stop

.. Show events in the past from a specified time:

**時間を指定すると、過去のイベントを表示：**

.. code-block:: bash

   $ docker events --since 1378216169
   2014-03-10T17:42:14.999999999Z07:00 4386fb97867d: (from ubuntu-1:14.04) die
   2014-05-10T17:42:14.999999999Z07:00 4386fb97867d: (from ubuntu-1:14.04) stop
   2014-05-10T17:42:14.999999999Z07:00 7805c1d35632: (from redis:2.8) die
   2014-03-10T17:42:14.999999999Z07:00 7805c1d35632: (from redis:2.8) stop
   
   $ docker events --since '2013-09-03'
   2014-09-03T17:42:14.999999999Z07:00 4386fb97867d: (from ubuntu-1:14.04) start
   2014-09-03T17:42:14.999999999Z07:00 4386fb97867d: (from ubuntu-1:14.04) die
   2014-05-10T17:42:14.999999999Z07:00 4386fb97867d: (from ubuntu-1:14.04) stop
   2014-05-10T17:42:14.999999999Z07:00 7805c1d35632: (from redis:2.8) die
   2014-09-03T17:42:14.999999999Z07:00 7805c1d35632: (from redis:2.8) stop
   
   $ docker events --since '2013-09-03T15:49:29'
   2014-09-03T15:49:29.999999999Z07:00 4386fb97867d: (from ubuntu-1:14.04) die
   2014-05-10T17:42:14.999999999Z07:00 4386fb97867d: (from ubuntu-1:14.04) stop
   2014-05-10T17:42:14.999999999Z07:00 7805c1d35632: (from redis:2.8) die
   2014-09-03T15:49:29.999999999Z07:00 7805c1d35632: (from redis:2.8) stop

.. This example outputs all events that were generated in the last 3 minutes, relative to the current time on the client machine:

この例では、過去３分間に発生した全イベントを表示しています。クライアント側のマシン上からの相対的な時間です。

.. code-block:: bash

   $ docker events --since '3m'
   2015-05-12T11:51:30.999999999Z07:00 4386fb97867d: (from ubuntu-1:14.04) die
   2015-05-12T15:52:12.999999999Z07:00 4 4386fb97867d: (from ubuntu-1:14.04) stop
   2015-05-12T15:53:45.999999999Z07:00  7805c1d35632: (from redis:2.8) die
   2015-05-12T15:54:03.999999999Z07:00  7805c1d35632: (from redis:2.8) stop

.. Filter events:

**イベントをフィルタします：**

.. code-block:: bash

   $ docker events --filter 'event=stop'
   2014-05-10T17:42:14.999999999Z07:00 4386fb97867d: (from ubuntu-1:14.04) stop
   2014-09-03T17:42:14.999999999Z07:00 7805c1d35632: (from redis:2.8) stop
   
   $ docker events --filter 'image=ubuntu-1:14.04'
   2014-05-10T17:42:14.999999999Z07:00 4386fb97867d: (from ubuntu-1:14.04) start
   2014-05-10T17:42:14.999999999Z07:00 4386fb97867d: (from ubuntu-1:14.04) die
   2014-05-10T17:42:14.999999999Z07:00 4386fb97867d: (from ubuntu-1:14.04) stop
   
   $ docker events --filter 'container=7805c1d35632'
   2014-05-10T17:42:14.999999999Z07:00 7805c1d35632: (from redis:2.8) die
   2014-09-03T15:49:29.999999999Z07:00 7805c1d35632: (from redis:2.8) stop
   
   $ docker events --filter 'container=7805c1d35632' --filter 'container=4386fb97867d'
   2014-09-03T15:49:29.999999999Z07:00 4386fb97867d: (from ubuntu-1:14.04) die
   2014-05-10T17:42:14.999999999Z07:00 4386fb97867d: (from ubuntu-1:14.04) stop
   2014-05-10T17:42:14.999999999Z07:00 7805c1d35632: (from redis:2.8) die
   2014-09-03T15:49:29.999999999Z07:00 7805c1d35632: (from redis:2.8) stop
   
   $ docker events --filter 'container=7805c1d35632' --filter 'event=stop'
   2014-09-03T15:49:29.999999999Z07:00 7805c1d35632: (from redis:2.8) stop
   
   $ docker events --filter 'container=container_1' --filter 'container=container_2'
   2014-09-03T15:49:29.999999999Z07:00 4386fb97867d: (from ubuntu-1:14.04) die
   2014-05-10T17:42:14.999999999Z07:00 4386fb97867d: (from ubuntu-1:14.04) stop
   2014-05-10T17:42:14.999999999Z07:00 7805c1d35632: (from redis:2.8) die
   2014-09-03T15:49:29.999999999Z07:00 7805c1d35632: (from redis:2.8) stop

.. seealso:: 

   events
      https://docs.docker.com/engine/reference/commandline/events/
