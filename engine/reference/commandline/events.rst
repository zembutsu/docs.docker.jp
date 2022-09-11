.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/events/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/events.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_events.yaml
.. check date: 2022/03/20
.. Commits on Oct 11, 2021 ed135fe151ad43ca1093074c8fbf52243402013a
.. -------------------------------------------------------------------

.. docker events

=======================================
docker events
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _docker_events-description:

説明
==========

.. Get real time events from the server

サーバからリアルタイムのイベントを取得します。

.. _docker_events-usage:

使い方
==========

.. code-block:: bash

   $ docker events [OPTIONS]

.. Extended description
.. _docker_cvents-extended-description:

補足説明
==========

.. Use docker events to get real-time events from the server. These events differ per Docker object type. Different event types have different scopes. Local scoped events are only seen on the node they take place on, and swarm scoped events are seen on all managers.

``docker events`` を使うと、サーバからリアルタイムのイベントを取得します。これらのイベントは Docker :ruby:`オブジェクト型 <object type>` ごとに異なります。イベントが異なれば、 :ruby:`範囲 <scope>` も異なります。 :ruby:`ローカル範囲 <local scope>` のイベントは、実行しているノード上のイベントのみ表示します。 :ruby:`swarm 範囲 <swarm scope>` のイベントは、全てのマネージャ上のイベントを表示します。

.. Only the last 1000 log events are returned. You can use filters to further limit the number of events returned.

直近の 1000 イベントのログだけ表示できます。フィルタを使えば、イベントを表示する数を制限できます。

.. Object types
.. _docker_events-object-types:

オブジェクト型
--------------------

.. Containers

コンテナ
^^^^^^^^^^

.. Docker containers report the following events:

Docker コンテナは以下のイベントを報告します。

   * ``attach``
   * ``commit``
   * ``copy``
   * ``create``
   * ``destroy``
   * ``detach``
   * ``die``
   * ``exec_create``
   * ``exec_detach``
   * ``exec_die``
   * ``exec_start``
   * ``export``
   * ``health_status``
   * ``kill``
   * ``oom``
   * ``pause``
   * ``rename``
   * ``resize``
   * ``restart``
   * ``start``
   * ``stop``
   * ``top``
   * ``unpause``
   * ``update``

イメージ
^^^^^^^^^^

.. Docker images report the following events:

Docker イメージは以下のイベントを報告します。

   * ``delete``
   * ``import``
   * ``load``
   * ``pull``
   * ``push``
   * ``save``
   * ``tag``
   * ``untag``

プラグイン
^^^^^^^^^^

.. Docker plugins report the following events:

Docker プラグインは以下のイベントを報告します。

   * ``enable``
   * ``disable``
   * ``install``
   * ``remove``

ボリューム
^^^^^^^^^^

.. Docker volumes report the following events:

Docker ボリュームは以下のイベントを報告します。

   * ``create``
   * ``destroy``
   * ``mount``
   * ``unmount``

ネットワーク
^^^^^^^^^^^^^^^^^^^^

.. Docker networks report the following events:

Docker ネットワークは以下のイベントを報告します。

   * ``create``
   * ``connect``
   * ``destroy``
   * ``disconnect``
   * ``remove``

デーモン
^^^^^^^^^^

.. Docker daemon report the following events:

Docker デーモンは以下のイベントを報告します。

   * ``create``

サービス
^^^^^^^^^^

.. Docker services report the following events:

Docker デーモンは以下のイベントを報告します。

   * ``create``
   * ``remove``
   * ``update``


ノード
^^^^^^^^^^

.. Docker nodes report the following events:

Docker ノードは以下のイベントを報告します。

   * ``create``
   * ``remove``
   * ``update``


シークレット
^^^^^^^^^^^^^^^^^^^^

.. Docker secrets report the following events:

Docker シークレットは以下のイベントを報告します。

   * ``create``
   * ``remove``
   * ``update``

config
^^^^^^^^^^

.. Docker configs report the following events:

Docker config は以下のイベントを報告します。

   * ``create``
   * ``remove``
   * ``update``

.. Limiting, filtering, and formatting the output

.. _limiting-filtering,-and-formatting-the-output:

出力の制限、フィルタ、表示形式
------------------------------

.. Limit events by time

.. _limit-events-by-time:

時間によるイベントの制限
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. The --since and --until parameters can be Unix timestamps, date formatted timestamps, or Go duration strings (e.g. 10m, 1h30m) computed relative to the client machine’s time. If you do not provide the --since option, the command returns only new and/or live events. Supported formats for date formatted time stamps include RFC3339Nano, RFC3339, 2006-01-02T15:04:05, 2006-01-02T15:04:05.999999999, 2006-01-02Z07:00, and 2006-01-02. The local timezone on the client will be used if you do not provide either a Z or a +-00:00 timezone offset at the end of the timestamp. When providing Unix timestamps enter seconds[.nanoseconds], where seconds is the number of seconds that have elapsed since January 1, 1970 (midnight UTC/GMT), not counting leap seconds (aka Unix epoch or Unix time), and the optional .nanoseconds field is a fraction of a second no more than nine digits long.

``--since`` と ``--until`` パラメータでは、 Unix タイムスタンプ、 RFC 3339 の dates 、Go 言語の期間文字列（例： ``10m`` 、 ``1h30m`` ）をクライアントのマシン時刻から相対的に扱えます。 ``--since`` オプションを指定しなければ、コマンドは新しく追加されたイベント、あるいは、現在のイベントのみ表示します。日付形式のタイムスタンプがサポートしているのは、RFC3339Nano 、 RFC3339 、 ``2006-01-02T15:04:05`` 、 ``2006-01-02T15:04:05.999999999`` 、 ``2006-01-02Z07:00`` 、 ``2006-01-02`` です。タイムスタンプの最後にタイムゾーンオフセットとして ``Z`` か ``+-00:00`` が指定されなければ、デーモンはローカルのタイムゾーンを使います。Unix タイムスタンプを 秒[.ナノ秒] で指定すると、秒数は 1970 年 1 月 1 日（UTC/GMT 零時）からの経過時間ですが、うるう秒（別名 Unix epoch や Unix time）を含みません。また、オプションで、9桁以上  .ナノ秒 フィールドは省略されます。

.. Only the last 1000 log events are returned. You can use filters to further limit the number of events returned.

直近の 1000 イベントのログだけ表示できます。フィルタを使えば、イベントを表示する数を制限できます。

.. Filtering

.. _docker_events-filtering:

フィルタリング
^^^^^^^^^^^^^^^^^^^^

.. The filtering flag (-f or --filter) format is of “key=value”. If you would like to use multiple filters, pass multiple flags (e.g., --filter "foo=bar" --filter "bif=baz")

フィルタリング・フラグ（ ``-f`` と ``--filter`` ）は ``key=value`` の形式です。複数のフィルタを使いたい場合は、複数回フラグを指定します（例： ``--filter "foo=bar" --filter "bif=baz"`` ）。

.. Using the same filter multiple times will be handled as a OR; for example --filter container=588a23dac085 --filter container=a8f7720b8c22 will display events for container 588a23dac085 OR container a8f7720b8c22

同じフィルタを複数回指定したら、「OR」（または）という条件として処理します。例えば ``--filter container=588a23dac085 --filter container=a8f7720b8c22`` は、コンテナ 588a23dac085 かコンテナ a8f7720b8c22 のイベントを表示します。

.. Using multiple filters will be handled as a AND; for example --filter container=588a23dac085 --filter event=start will display events for container container 588a23dac085 AND the event type is start

複数のフィルタを使えば、「AND」（および）という条件として処理します。例えば ``--filter container=588a23dac085 --filter event=start`` は、コンテナ 588a23dac085 のイベントタイプが *start* のイベントのみ表示します。

.. The currently supported filters are:

現時点でサポートされているフィルタは次の通りです。

..    config (config=<name or id>)
    container (container=<name or id>)
    daemon (daemon=<name or id>)
    event (event=<event action>)
    image (image=<repository or tag>)
    label (label=<key> or label=<key>=<value>)
    network (network=<name or id>)
    node (node=<id>)
    plugin (plugin=<name or id>)
    scope (scope=<local or swarm>)
    secret (secret=<name or id>)
    service (service=<name or id>)
    type (type=<container or image or volume or network or daemon or plugin or service or node or secret or config>)
    volume (volume=<name>)

* 設定情報（ ``config=<名前または ID>`` ）
* コンテナ（ ``container=<名前または ID>`` ）
* デーモン（ ``daemon=<名前または ID>`` ）
* イベント（ ``event=<イベント・アクション>`` ）
* イメージ（ ``image=<リポジトリまたはタグ>`` ）
* ラベル（ ``label=<key>`` または ``label=<key>=<value>`` ）
* ネットワーク（ ``network=<名前または ID>`` ）
* ノード（ ``node=<ID>`` ）
* プラグイン（ ``plugin=<名前または ID>`` ）
* 範囲（ ``scope=<名前または ID>`` ）
* シークレット（ ``secret=<名前または ID>`` ）
* サービス（ ``service=<名前または ID>`` ）
* タイプ （ ``type=<container or image or volume or network or daemon or plugin or service or node or secret or config>`` ）
* ボリューム（ ``volume=<名前　またはID>`` ）

.. Format

.. _docker_events-format:

表示形式
^^^^^^^^^^

.. If a format (--format) is specified, the given template will be executed instead of the default format. Go’s text/template package describes all the details of the format.

表示形式（ ``--format`` ）を指定すると、デフォルトの表示形式にかわり、指定したテンプレートが適用されます。Go 言語の `text/template <https://golang.org/pkg/text/template/>`_ パッケージに、フォーマットの詳細全てがあります。

.. If a format is set to {{json .}}, the events are streamed as valid JSON Lines. For information about JSON Lines, please refer to https://jsonlines.org/.

表示形式に ``{{json .}}`` を指定すると、イベントは有効な JSON 行としてストリーミングされます。JSON 行についての情報は `https://jsonlines.org/ <https://jsonlines.org/>`_ を参照ください。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <docker_events-examples>` をご覧ください。


.. _docker_events-options:

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
     - 指定した Go テンプレートを使って出力を形成
   * - ``--since``
     - 
     - タイムスタンプ以降に作成されたイベントを全て表示
   * - ``--until``
     - 
     - タイムスタンプまでのイベントを表示


.. Examples

.. _docker_events-examples:

使用例
==========

.. Basic example
.. _docker_events-basic-examples:

基本的な例
----------

.. You’ll need two shells for this example.

この例には２つのシェルが必要です。

.. Shell 1: Listening for events:

**シェル１：イベント一覧を表示：**

.. code-block:: bash

   $ docker events

.. Shell 2: Start and Stop containers:

**シェル２：コンテナを開始して停止**

.. code-block:: bash

   $ docker create --name test alpine:latest top
   $ docker start test
   $ docker stop test


.. Shell 1: (Again .. now showing events):

**シェル１：（再び戻ります。実行したら、イベントを表示）** 

.. code-block:: bash

   2017-01-05T00:35:58.859401177+08:00 container create 0fdb48addc82871eb34eb23a847cfd033dedd1a0a37bef2e6d9eb3870fc7ff37 (image=alpine:latest, name=test)
   2017-01-05T00:36:04.703631903+08:00 network connect e2e1f5ceda09d4300f3a846f0acfaa9a8bb0d89e775eb744c5acecd60e0529e2 (container=0fdb...ff37, name=bridge, type=bridge)
   2017-01-05T00:36:04.795031609+08:00 container start 0fdb...ff37 (image=alpine:latest, name=test)
   2017-01-05T00:36:09.830268747+08:00 container kill 0fdb...ff37 (image=alpine:latest, name=test, signal=15)
   2017-01-05T00:36:09.840186338+08:00 container die 0fdb...ff37 (exitCode=143, image=alpine:latest, name=test)
   2017-01-05T00:36:09.880113663+08:00 network disconnect e2e...29e2 (container=0fdb...ff37, name=bridge, type=bridge)
   2017-01-05T00:36:09.890214053+08:00 container stop 0fdb...ff37 (image=alpine:latest, name=test)

.. To exit the docker events command, use CTRL+C.

``docker events`` コマンドを終了するには、 ``CTRL+C`` を使います。

.. Filter events by time
.. _docker_events-filter-events-by-time:

時間でイベントをフィルタ
------------------------------

.. You can filter the output by an absolute timestamp or relative time on the host machine, using the following different time syntaxes:

ホストマシン上のタイムスタンプ絶対値、もしくは、相対時間で出力をフィルタできます。次のように、様々な時間の構文が扱えます。

.. code-block:: bash

    $ docker events --since 1483283804
    2017-01-05T00:35:41.241772953+08:00 volume create testVol (driver=local)
    2017-01-05T00:35:58.859401177+08:00 container create d9cd...4d70 (image=alpine:latest, name=test)
    2017-01-05T00:36:04.703631903+08:00 network connect e2e1...29e2 (container=0fdb...ff37, name=bridge, type=bridge)
    2017-01-05T00:36:04.795031609+08:00 container start 0fdb...ff37 (image=alpine:latest, name=test)
    2017-01-05T00:36:09.830268747+08:00 container kill 0fdb...ff37 (image=alpine:latest, name=test, signal=15)
    2017-01-05T00:36:09.840186338+08:00 container die 0fdb...ff37 (exitCode=143, image=alpine:latest, name=test)
    2017-01-05T00:36:09.880113663+08:00 network disconnect e2e...29e2 (container=0fdb...ff37, name=bridge, type=bridge)
    2017-01-05T00:36:09.890214053+08:00 container stop 0fdb...ff37 (image=alpine:latest, name=test)
    $ docker events --since '2017-01-05'
    2017-01-05T00:35:41.241772953+08:00 volume create testVol (driver=local)
    2017-01-05T00:35:58.859401177+08:00 container create d9cd...4d70 (image=alpine:latest, name=test)
    2017-01-05T00:36:04.703631903+08:00 network connect e2e1...29e2 (container=0fdb...ff37, name=bridge, type=bridge)
    2017-01-05T00:36:04.795031609+08:00 container start 0fdb...ff37 (image=alpine:latest, name=test)
    2017-01-05T00:36:09.830268747+08:00 container kill 0fdb...ff37 (image=alpine:latest, name=test, signal=15)
    2017-01-05T00:36:09.840186338+08:00 container die 0fdb...ff37 (exitCode=143, image=alpine:latest, name=test)
    2017-01-05T00:36:09.880113663+08:00 network disconnect e2e...29e2 (container=0fdb...ff37, name=bridge, type=bridge)
    2017-01-05T00:36:09.890214053+08:00 container stop 0fdb...ff37 (image=alpine:latest, name=test)
    $ docker events --since '2013-09-03T15:49:29'
    2017-01-05T00:35:41.241772953+08:00 volume create testVol (driver=local)
    2017-01-05T00:35:58.859401177+08:00 container create d9cd...4d70 (image=alpine:latest, name=test)
    2017-01-05T00:36:04.703631903+08:00 network connect e2e1...29e2 (container=0fdb...ff37, name=bridge, type=bridge)
    2017-01-05T00:36:04.795031609+08:00 container start 0fdb...ff37 (image=alpine:latest, name=test)
    2017-01-05T00:36:09.830268747+08:00 container kill 0fdb...ff37 (image=alpine:latest, name=test, signal=15)
    2017-01-05T00:36:09.840186338+08:00 container die 0fdb...ff37 (exitCode=143, image=alpine:latest, name=test)
    2017-01-05T00:36:09.880113663+08:00 network disconnect e2e...29e2 (container=0fdb...ff37, name=bridge, type=bridge)
    2017-01-05T00:36:09.890214053+08:00 container stop 0fdb...ff37 (image=alpine:latest, name=test)
    $ docker events --since '10m'
    2017-01-05T00:35:41.241772953+08:00 volume create testVol (driver=local)
    2017-01-05T00:35:58.859401177+08:00 container create d9cd...4d70 (image=alpine:latest, name=test)
    2017-01-05T00:36:04.703631903+08:00 network connect e2e1...29e2 (container=0fdb...ff37, name=bridge, type=bridge)
    2017-01-05T00:36:04.795031609+08:00 container start 0fdb...ff37 (image=alpine:latest, name=test)
    2017-01-05T00:36:09.830268747+08:00 container kill 0fdb...ff37 (image=alpine:latest, name=test, signal=15)
    2017-01-05T00:36:09.840186338+08:00 container die 0fdb...ff37 (exitCode=143, image=alpine:latest, name=test)
    2017-01-05T00:36:09.880113663+08:00 network disconnect e2e...29e2 (container=0fdb...ff37, name=bridge, type=bridge)
    2017-01-05T00:36:09.890214053+08:00 container stop 0fdb...ff37 (image=alpine:latest, name=test)
    $ docker events --since '2017-01-05T00:35:30' --until '2017-01-05T00:36:05'
    2017-01-05T00:35:41.241772953+08:00 volume create testVol (driver=local)
    2017-01-05T00:35:58.859401177+08:00 container create d9cd...4d70 (image=alpine:latest, name=test)
    2017-01-05T00:36:04.703631903+08:00 network connect e2e1...29e2 (container=0fdb...ff37, name=bridge, type=bridge)
    2017-01-05T00:36:04.795031609+08:00 container start 0fdb...ff37 (image=alpine:latest, name=test)

.. Filter events by criteria
.. _docker_events-filter-events-by-criteria:

:ruby:`状況 <criteria>` でイベントをフィルタ
--------------------------------------------------

.. The following commands show several different ways to filter the docker event output.

次のコマンドは、``docker event`` の出力を様々な方法でフィルタします。

.. code-block:: bash

    $ docker events --filter 'event=stop'
    2017-01-05T00:40:22.880175420+08:00 container stop 0fdb...ff37 (image=alpine:latest, name=test)
    2017-01-05T00:41:17.888104182+08:00 container stop 2a8f...4e78 (image=alpine, name=kickass_brattain)
    $ docker events --filter 'image=alpine'
    2017-01-05T00:41:55.784240236+08:00 container create d9cd...4d70 (image=alpine, name=happy_meitner)
    2017-01-05T00:41:55.913156783+08:00 container start d9cd...4d70 (image=alpine, name=happy_meitner)
    2017-01-05T00:42:01.106875249+08:00 container kill d9cd...4d70 (image=alpine, name=happy_meitner, signal=15)
    2017-01-05T00:42:11.111934041+08:00 container kill d9cd...4d70 (image=alpine, name=happy_meitner, signal=9)
    2017-01-05T00:42:11.119578204+08:00 container die d9cd...4d70 (exitCode=137, image=alpine, name=happy_meitner)
    2017-01-05T00:42:11.173276611+08:00 container stop d9cd...4d70 (image=alpine, name=happy_meitner)
    $ docker events --filter 'container=test'
    2017-01-05T00:43:00.139719934+08:00 container start 0fdb...ff37 (image=alpine:latest, name=test)
    2017-01-05T00:43:09.259951086+08:00 container kill 0fdb...ff37 (image=alpine:latest, name=test, signal=15)
    2017-01-05T00:43:09.270102715+08:00 container die 0fdb...ff37 (exitCode=143, image=alpine:latest, name=test)
    2017-01-05T00:43:09.312556440+08:00 container stop 0fdb...ff37 (image=alpine:latest, name=test)
    $ docker events --filter 'container=test' --filter 'container=d9cdb1525ea8'
    2017-01-05T00:44:11.517071981+08:00 container start 0fdb...ff37 (image=alpine:latest, name=test)
    2017-01-05T00:44:17.685870901+08:00 container start d9cd...4d70 (image=alpine, name=happy_meitner)
    2017-01-05T00:44:29.757658470+08:00 container kill 0fdb...ff37 (image=alpine:latest, name=test, signal=9)
    2017-01-05T00:44:29.767718510+08:00 container die 0fdb...ff37 (exitCode=137, image=alpine:latest, name=test)
    2017-01-05T00:44:29.815798344+08:00 container destroy 0fdb...ff37 (image=alpine:latest, name=test)
    $ docker events --filter 'container=test' --filter 'event=stop'
    2017-01-05T00:46:13.664099505+08:00 container stop a9d1...e130 (image=alpine, name=test)
    $ docker events --filter 'type=volume'
    2015-12-23T21:05:28.136212689Z volume create test-event-volume-local (driver=local)
    2015-12-23T21:05:28.383462717Z volume mount test-event-volume-local (read/write=true, container=562f...5025, destination=/foo, driver=local, propagation=rprivate)
    2015-12-23T21:05:28.650314265Z volume unmount test-event-volume-local (container=562f...5025, driver=local)
    2015-12-23T21:05:28.716218405Z volume destroy test-event-volume-local (driver=local)
    $ docker events --filter 'type=network'
    2015-12-23T21:38:24.705709133Z network create 8b11...2c5b (name=test-event-network-local, type=bridge)
    2015-12-23T21:38:25.119625123Z network connect 8b11...2c5b (name=test-event-network-local, container=b4be...c54e, type=bridge)
    $ docker events --filter 'container=container_1' --filter 'container=container_2'
    2014-09-03T15:49:29.999999999Z07:00 container die 4386fb97867d (image=ubuntu-1:14.04)
    2014-05-10T17:42:14.999999999Z07:00 container stop 4386fb97867d (image=ubuntu-1:14.04)
    2014-05-10T17:42:14.999999999Z07:00 container die 7805c1d35632 (imager=redis:2.8)
    2014-09-03T15:49:29.999999999Z07:00 container stop 7805c1d35632 (image=redis:2.8)
    $ docker events --filter 'type=volume'
    2015-12-23T21:05:28.136212689Z volume create test-event-volume-local (driver=local)
    2015-12-23T21:05:28.383462717Z volume mount test-event-volume-local (read/write=true, container=562fe10671e9273da25eed36cdce26159085ac7ee6707105fd534866340a5025, destination=/foo, driver=local, propagation=rprivate)
    2015-12-23T21:05:28.650314265Z volume unmount test-event-volume-local (container=562fe10671e9273da25eed36cdce26159085ac7ee6707105fd534866340a5025, driver=local)
    2015-12-23T21:05:28.716218405Z volume destroy test-event-volume-local (driver=local)
    $ docker events --filter 'type=network'
    2015-12-23T21:38:24.705709133Z network create 8b111217944ba0ba844a65b13efcd57dc494932ee2527577758f939315ba2c5b (name=test-event-network-local, type=bridge)
    2015-12-23T21:38:25.119625123Z network connect 8b111217944ba0ba844a65b13efcd57dc494932ee2527577758f939315ba2c5b (name=test-event-network-local, container=b4be644031a3d90b400f88ab3d4bdf4dc23adb250e696b6328b85441abe2c54e, type=bridge)
    $ docker events --filter 'type=plugin'
    2016-07-25T17:30:14.825557616Z plugin pull ec7b87f2ce84330fe076e666f17dfc049d2d7ae0b8190763de94e1f2d105993f (name=tiborvass/sample-volume-plugin:latest)
    2016-07-25T17:30:14.888127370Z plugin enable ec7b87f2ce84330fe076e666f17dfc049d2d7ae0b8190763de94e1f2d105993f (name=tiborvass/sample-volume-plugin:latest)
    $ docker events -f type=service
    2017-07-12T06:34:07.999446625Z service create wj64st89fzgchxnhiqpn8p4oj (name=reverent_albattani)
    2017-07-12T06:34:21.405496207Z service remove wj64st89fzgchxnhiqpn8p4oj (name=reverent_albattani)
    $ docker events -f type=node
    2017-07-12T06:21:51.951586759Z node update 3xyz5ttp1a253q74z1thwywk9 (name=ip-172-31-23-42, state.new=ready, state.old=unknown)
    $ docker events -f type=secret
    2017-07-12T06:32:13.915704367Z secret create s8o6tmlnndrgzbmdilyy5ymju (name=new_secret)
    2017-07-12T06:32:37.052647783Z secret remove s8o6tmlnndrgzbmdilyy5ymju (name=new_secret)
    $  docker events -f type=config
    2017-07-12T06:44:13.349037127Z config create u96zlvzdfsyb9sg4mhyxfh3rl (name=abc)
    2017-07-12T06:44:36.327694184Z config remove u96zlvzdfsyb9sg4mhyxfh3rl (name=abc)
    $ docker events --filter 'scope=swarm'
    2017-07-10T07:46:50.250024503Z service create m8qcxu8081woyof7w3jaax6gk (name=affectionate_wilson)
    2017-07-10T07:47:31.093797134Z secret create 6g5pufzsv438p9tbvl9j94od4 (name=new_secret)

.. Format the output
.. _docker_events-format-the-output:

出力形式
--------------------------------------------------

.. code-block:: bash

    $ docker events --filter 'type=container' --format 'Type={{.Type}}  Status={{.Status}}  ID={{.ID}}'
    Type=container  Status=create  ID=2ee349dac409e97974ce8d01b70d250b85e0ba8189299c126a87812311951e26
    Type=container  Status=attach  ID=2ee349dac409e97974ce8d01b70d250b85e0ba8189299c126a87812311951e26
    Type=container  Status=start  ID=2ee349dac409e97974ce8d01b70d250b85e0ba8189299c126a87812311951e26
    Type=container  Status=resize  ID=2ee349dac409e97974ce8d01b70d250b85e0ba8189299c126a87812311951e26
    Type=container  Status=die  ID=2ee349dac409e97974ce8d01b70d250b85e0ba8189299c126a87812311951e26
    Type=container  Status=destroy  ID=2ee349dac409e97974ce8d01b70d250b85e0ba8189299c126a87812311951e26

.. Format as JSON
.. _docker_events-format-as-json:
JSON 形式
^^^^^^^^^^

.. code-block:: bash

    $ docker events --format '{{json .}}'
    {"status":"create","id":"196016a57679bf42424484918746a9474cd905dd993c4d0f4..
    {"status":"attach","id":"196016a57679bf42424484918746a9474cd905dd993c4d0f4..
    {"Type":"network","Action":"connect","Actor":{"ID":"1b50a5bf755f6021dfa78e..
    {"status":"start","id":"196016a57679bf42424484918746a9474cd905dd993c4d0f42..
    {"status":"resize","id":"196016a57679bf42424484918746a9474cd905dd993c4d0f4..



親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI の基本コマンド


.. seealso:: 

   docker events
      https://docs.docker.com/engine/reference/commandline/events/
