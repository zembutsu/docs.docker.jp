.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/logs/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/logs.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/logs.md
.. check date: 2016/06/16
.. Commits on Mar 7, 2016 bd9d14a07b9f1c82625dc8483245caf3fa7fe9e6
.. -------------------------------------------------------------------

.. logs

=======================================
logs
=======================================

.. code-block:: bash

   使い方: docker logs [オプション] コンテナ
   
   コンテナのログを取得
   
     --details                 ログに追加情報を表示
     -f, --follow=false        ログの出力をフォロー（表示し続ける）
     --help                    使い方の表示
     --since=""                タイムスタンプ以降のログを表示
     -t, --timestamps=false    タイムスタンプを表示
     --tail="all"              ログの最後から指定した行数を表示

..     Note: this command is available only for containers with json-file and journald logging drivers.

.. note::

   このコマンドが使えるのは、コンテナが ``json-file`` と ``journald`` ロギング・ドライバを使う時のみです。

.. The docker logs command batch-retrieves logs present at the time of execution.

``docker logs`` コマンドは、コンテナの実行時から現在に至るまでのログを、逐次表示します。

.. The docker logs --follow command will continue streaming the new output from the container’s STDOUT and STDERR.

``docker logs --follow`` および ``docker logs -f`` コマンドは、コンテナの ``STDOUT`` と ``STDERR`` から新しい出力があれば、 表示し続けます。

.. Passing a negative number or a non-integer to --tail is invalid and the value is set to all in that case.

負の値の指定や、 ``--tail`` に値を付けなければ、全てのログを表示します。

.. The docker logs --timestamp commands will add an RFC3339Nano timestamp , for example 2014-09-16T06:17:46.000000000Z, to each log entry. To ensure that the timestamps for are aligned the nano-second part of the timestamp will be padded with zero when necessary.

``docker logs --timestamp`` コマンドは `RFC3339 Nano timestamp <https://golang.org/pkg/time/#pkg-constants>`_ を追加します。例えば ``2014-09-16T06:17:46.000000000Z`` のように、各ログ行に追加されます。タイムスタンプはナノ秒で表示されるため、不要な場合でもゼロが付加されます。

.. The docker logs --details command will add on extra attributes, such as environment variables and labels, provided to --log-opt when creating the container.

``docker logs --details`` コマンドは、コンテナ作成時に ``--log-opt`` で指定した環境変数やラベルなどの追加属性も表示します。

.. The --since option shows only the container logs generated after a given date. You can specify the date as an RFC 3339 date, a UNIX timestamp, or a Go duration string (e.g. 1m30s, 3h). Docker computes the date relative to the client machine’s time. You can combine the --since option with either or both of the --follow or --tail options.

``--since`` オプションは指定した日時以降のログを表示します。指定できる日付は RFC 3339 date、UNIX タイムスタンプ、Go 言語の期間文字（例： ``1m30s`` 、 ``3h`` ）です。Docker はクライアント側のマシン上からの相対時間を計算します。 ``--since`` オプションは ``--follow`` と ``--tail`` と同時に使えます。

.. seealso:: 

   logs
      https://docs.docker.com/engine/reference/commandline/logs/
