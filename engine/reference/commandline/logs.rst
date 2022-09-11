.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/logs/
.. SOURCE:
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/logs.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_logs.yaml
.. check date: 2022/03/21
.. Commits on Aug 22, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker logs

=======================================
docker logs
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _docker_logs-description:

説明
==========

.. Fetch the logs of a container

コンテナのログを取得します。

.. _docker_logs-usage:

使い方
==========

.. code-block:: bash

   $ docker logs [OPTIONS] CONTAINER

.. Extended description
.. _docker_logs-extended-description:

補足説明
==========

.. The docker logs command batch-retrieves logs present at the time of execution.

``docker logs`` コマンドは、コンテナの実行時から現在に至るまでのログを、逐次表示します。

..     Note: this command is available only for containers with json-file and journald logging drivers.

.. note::

   このコマンドが使えるのは、コンテナが ``json-file`` と ``journald`` ロギング・ドライバを使って起動する場合のみです。

.. For more information about selecting and configuring logging drivers, refer to Configure logging drivers.

ロギング・ドライバの選択や設定に関する詳しい情報は :doc:`ロギング・ドライバの設定 </config/containers/logging/configure>` をご覧ください。

.. The docker logs --follow command will continue streaming the new output from the container’s STDOUT and STDERR.

``docker logs --follow`` および ``docker logs -f`` コマンドは、コンテナの ``STDOUT`` と ``STDERR`` から新しい出力があれば、 表示し続けます。

.. Passing a negative number or a non-integer to --tail is invalid and the value is set to all in that case.

負の値の指定や、 ``--tail`` に値を付けなければ、全てのログを表示します。

.. The docker logs --timestamp commands will add an RFC3339Nano timestamp , for example 2014-09-16T06:17:46.000000000Z, to each log entry. To ensure that the timestamps for are aligned the nano-second part of the timestamp will be padded with zero when necessary.

``docker logs --timestamp`` コマンドは `RFC3339 Nano timestamp <https://golang.org/pkg/time/#pkg-constants>`_ を追加します。例えば ``2014-09-16T06:17:46.000000000Z`` のように、各ログ行に追加されます。タイムスタンプはナノ秒で表示されるため、不要な場合でもゼロが付加されます。

.. The docker logs --details command will add on extra attributes, such as environment variables and labels, provided to --log-opt when creating the container.

``docker logs --details`` コマンドは、コンテナ作成時に ``--log-opt`` で指定した環境変数やラベルなどの追加属性も表示します。

.. The --since option shows only the container logs generated after a given date. You can specify the date as an RFC 3339 date, a UNIX timestamp, or a Go duration string (e.g. 1m30s, 3h). Besides RFC3339 date format you may also use RFC3339Nano, 2006-01-02T15:04:05, 2006-01-02T15:04:05.999999999, 2006-01-02Z07:00, and 2006-01-02. The local timezone on the client will be used if you do not provide either a Z or a +-00:00 timezone offset at the end of the timestamp. When providing Unix timestamps enter seconds[.nanoseconds], where seconds is the number of seconds that have elapsed since January 1, 1970 (midnight UTC/GMT), not counting leap seconds (aka Unix epoch or Unix time), and the optional .nanoseconds field is a fraction of a second no more than nine digits long. You can combine the --since option with either or both of the --follow or --tail options.


``--since`` オプションは指定した日時以降のログを表示します。指定できる日付は RFC 3339 date、UNIX タイムスタンプ、Go 言語の期間文字（例： ``1m30s`` 、 ``3h`` ）です。Docker はクライアント側のマシン上からの相対時間を計算します。日付形式のタイムスタンプがサポートしているのは、RFC3339Nano 、 RFC3339 、 ``2006-01-02T15:04:05`` 、 ``2006-01-02T15:04:05.999999999`` 、 ``2006-01-02Z07:00`` 、 ``2006-01-02`` です。タイムスタンプの最後にタイムゾーンオフセットとして ``Z`` か ``+-00:00`` が指定されなければ、デーモンはローカルのタイムゾーンを使います。Unix タイムスタンプを 秒[.ナノ秒] で指定すると、秒数は 1970 年 1 月 1 日（UTC/GMT 零時）からの経過時間ですが、うるう秒（別名 Unix epoch や Unix time）を含みません。また、オプションで、9桁以上  .ナノ秒 フィールドは省略されます。 ``--since`` オプションは ``--follow`` と ``--tail`` と同時に使えます。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <docker_logs-examples>` をご覧ください。

.. _docker_logs-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--details``
     - 
     - ログに提供する詳細情報を表示
   * - ``--follow`` , ``-f``
     - 
     - 出力をフォローし続ける（表示し続ける）
   * - ``--since``
     - 
     - タイムスタンプ（例： 2013-01-02T13:23:37Z）以降、あるいは相対時刻（例： 42m は 42 分）以降のログを表示
   * - ``--tail`` , ``-n``
     - ``all``
     - ログの最終から数えた行以降を表示
   * - ``--timestamps`` , ``-t``
     - 
     - タイムスタンプを表示
   * - ``--until``
     - 
     - 【API 1.35+】タイムスタンプ（例： 2013-01-02T13:23:37Z）まで、あるいは相対時刻（例： 42m は 42 分）までのログを表示

.. Examples
.. _docker_logs-examples:

使用例
==========

.. Retrieve logs until a specific point in time
.. _docker_logs-retrieve-logs-until-a-specific-point-in-time:
指定時間までのログを表示
------------------------------

.. In order to retrieve logs before a specific point in time, run:

指定した時点までのログを表示するには、次のように実行します。

.. code-block:: bash

    $ docker run --name test -d busybox sh -c "while true; do $(echo date); sleep 1; done"
    $ date
    Tue 14 Nov 2017 16:40:00 CET
    $ docker logs -f --until=2s test
    Tue 14 Nov 2017 16:40:00 CET
    Tue 14 Nov 2017 16:40:01 CET
    Tue 14 Nov 2017 16:40:02 CET

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI の基本コマンド

.. seealso:: 

   docker logs
      https://docs.docker.com/engine/reference/commandline/logs/
