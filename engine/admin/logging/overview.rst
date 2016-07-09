.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/logging/overview/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/admin/logging/overview.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/admin/logging/overview.md
.. check date: 2016/07/09
.. Commits on Jul 4, 2016 1763474a84770e8af96a065551bc328124222f13
.. -------------------------------------------------------------------

.. Configure logging drivers

=======================================
ロギング・ドライバの設定
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. The container can have a different logging driver than the Docker daemon. Use the --log-driver=VALUE with the docker run command to configure the container’s logging driver. The following options are supported:

コンテナには、 Docker デーモンよりも多い様々なロギング（ログ保存）ドライバがあります。ロギング・ドライバを指定するには、 ``docker run``  コマンドで ``--log-driver=VALUE`` を使います。以下のオプションをサポートしています。

.. none 	Disables any logging for the container. docker logs won’t be available with this driver.
.. json-file 	Default logging driver for Docker. Writes JSON messages to file.
.. syslog 	Syslog logging driver for Docker. Writes log messages to syslog.
.. journald 	Journald logging driver for Docker. Writes log messages to journald.
.. gelf 	Graylog Extended Log Format (GELF) logging driver for Docker. Writes log messages to a GELF endpoint like Graylog or Logstash.
.. fluentd 	Fluentd logging driver for Docker. Writes log messages to fluentd (forward input).
.. awslogs 	Amazon CloudWatch Logs logging driver for Docker. Writes log messages to Amazon CloudWatch Logs.


.. list-table::
   
   * - ``none``
     - コンテナ用のロギング・ドライバを無効化します。このドライバを指定したら ``docker logs`` は無効化されます。
   * - ``json-file``
     - Docker 用のデフォルト・ロギング・ドライバです。JSON メッセージをファイルに記録します。
   * - ``syslog``
     - Docker 用の syslog ロギング・ドライバです。ログ・メッセージを syslog に記録します。
   * - ``journald``
     - Docker 用の journald ロギング・ドライバです。ログ・メッセージを ``journald`` に記録します。
   * - ``gelf``
     - Docker 用の Graylog Extendef ログ・フォーマット（GELF）ロギング・ドライバです。ログ・メッセージを Graylog のエンドポイントや Logstash に記録します。
   * - ``fluentd``
     - Docker 用の fluentd ロギング・ドライバです。ログ・メッセージを ``fluentd`` に記録します（forward input）。
   * - ``awslogs``
     - Docker 用の Amazon CloudWatch Logs ロギング・ドライバです。ログ・メッセージを Amazon CloudWatch Logs に記録します。
   * - ``splunk``
     - Docker 用の Splunk ロギング・ドライバです。HTTP イベント・コレクタを使いログを ``splunk`` に書き込みます。
   * - ``etwlogs``
     - Docker 用の ETW ロギング・ドライバです。ログメッセージを ETW イベントとして書き込みます。
   * - ``gcplogs``
     - Docker 用の Google Cloud ロギング・ドライバです。ログメッセージを Google Cloud Logging に書き込みます。


.. The docker logscommand is available only for the json-file and journald logging drivers.

``docker logs`` コマンドが使えるのは ``json-file`` か ``journald`` ロギング・ドライバ使用時のみです。

.. The labels and env options add additional attributes for use with logging drivers that accept them. Each option takes a comma-separated list of keys. If there is collision between label and env keys, the value of the env takes precedence.

``label`` と ``env`` オプションは、ロギング・ドライバで利用可能な追加属性を加えます。各オプションはキーのリストをカンマで区切ります。 ``label`` と ``env``  キーの間に衝突があれば、 ``env`` を優先します。

.. To use attributes, specify them when you start the Docker daemon.

各種オプションは、Docker デーモン起動時に指定します。

.. code-block:: bash

   docker daemon --log-driver=json-file --log-opt labels=foo --log-opt env=foo,fizz

.. Then, run a container and specify values for the labels or env. For example, you might use this:

それから、 ``label`` や ``env`` の値を指定してコンテナを起動します。例えば、次のように指定するでしょう。

.. code-block:: bash

   docker run --label foo=bar -e fizz=buzz -d -P training/webapp python app.py

.. This adds additional fields to the log depending on the driver, e.g. for json-file that looks like:

これはドライバ上のログに依存する追加フィールドを加えるものです。次の例は ``json-file`` の場合です。

.. code-block:: bash

   "attrs":{"fizz":"buzz","foo":"bar"}

.. json-file options

.. _json-file-options:

JSON ファイルのオプション
==============================

.. The following logging options are supported for the json-file logging driver:

``json-file`` ロギング・ドライバがサポートしているロギング・オプションは以下の通りです。

.. code-block:: bash

   --log-opt max-size=[0-9+][k|m|g]
   --log-opt max-file=[0-9+]
   --log-opt labels=label1,label2
   --log-opt env=env1,env2

.. Logs that reach max-size are rolled over. You can set the size in kilobytes(k), megabytes(m), or gigabytes(g). eg --log-opt max-size=50m. If max-size is not set, then logs are not rolled over.

ログが ``max-size`` に到達したら、ロールオーバされます（別のファイルに繰り出されます）。設定できるサイズは、キロバイト(k)、メガバイト(m)、ギガバイト(g) です。例えば、 ``--log-opt max-size=50m`` のように指定します。もし ``max-size`` を設定しなければ、ログはロールオーバされません。

.. max-file specifies the maximum number of files that a log is rolled over before being discarded. eg --log-opt max-file=100. If max-size is not set, then max-file is not honored.

``max-file`` で指定するのは、ログが何回ロールオーバされたら破棄するかです。例えば ``--log-opt max-file=100`` のように指定します。もしも ``max-size`` を設定しなければ、 ``max-file`` は無効です。

.. If max-size and max-file are set, docker logs only returns the log lines from the newest log file.

``max-size`` と ``max-file`` をセットしたら、 ``docker logs`` は直近のログファイルのログ行だけ表示します。

.. syslog options

.. _syslog-options:

syslog のオプション
====================

.. The following logging options are supported for the syslog logging driver:

``syslog`` ロギング・ドライバがサポートしているロギング・オプションは以下の通りです。

.. code-block:: bash

   --log-opt syslog-address=[tcp|udp|tcp+tls]://host:port
   --log-opt syslog-address=unix://path
   --log-opt syslog-address=unixgram://path
   --log-opt syslog-facility=daemon
   --log-opt syslog-tls-ca-cert=/etc/ca-certificates/custom/ca.pem
   --log-opt syslog-tls-cert=/etc/ca-certificates/custom/cert.pem
   --log-opt syslog-tls-key=/etc/ca-certificates/custom/key.pem
   --log-opt syslog-tls-skip-verify=true
   --log-opt tag="mailer"
   --log-opt syslog-format=[rfc5424rfc6424micro||rfc3164] 
   --log-opt env=ENV1,ENV2,ENV3
   --log-opt labels=label1,label2,label3

.. syslog-address specifies the remote syslog server address where the driver connects to. If not specified it defaults to the local unix socket of the running system. If transport is either tcp or udp and port is not specified it defaults to 514 The following example shows how to have the syslog driver connect to a syslog remote server at 192.168.0.42 on port 123

``syslog-address`` は、ドライバが接続するリモートの syslog サーバのアドレスを指定します。指定しなければ、デフォルトでは実行中システム上にあるローカルの unix ソケットを使います。 ``tcp`` や ``udp`` で ``port`` を指定しなければ、デフォルトは ``514`` になります。以下の例は ``syslog`` ドライバを使い、リモートの ``192.168.0.42`` サーバ上のポート ``123`` に接続する方法です。

.. code-block:: bash

   $ docker run --log-driver=syslog --log-opt syslog-address=tcp://192.168.0.42:123

.. The syslog-facility option configures the syslog facility. By default, the system uses the daemon value. To override this behavior, you can provide an integer of 0 to 23 or any of the following named facilities:

``syslog-facility`` オプションは syslog のファシリティを設定します。デフォルトでは、システムは ``daemon`` 値を使います。これを上書きするには、 0 から 23 までの整数か、以下のファシリティ名を指定します。

* ``kern``
* ``user``
* ``mail``
* ``daemon``
* ``auth``
* ``syslog``
* ``lpr``
* ``news``
* ``uucp``
* ``cron``
* ``authpriv``
* ``ftp``
* ``local0``
* ``local1``
* ``local2``
* ``local3``
* ``local4``
* ``local5``
* ``local6``
* ``local7``

.. syslog-tls-ca-cert specifies the absolute path to the trust certificates signed by the CA. This option is ignored if the address protocol is not tcp+tls.

認証局（CA）によって署名済みの、信頼できる証明書への絶対パスを ``syslog-tls-ca-cert`` で指定します。このオプションは ``tcp+tls`` 以外のプロトコルを使う場合は無視されます。

.. syslog-tls-cert specifies the absolute path to the TLS certificate file. This option is ignored if the address protocol is not tcp+tls.

``syslog-tls-cert`` は TLS 証明書用ファイルに対する絶対パスです。このオプションは ``tcp+tls`` 以外のプロトコルを使う場合は無視されます。

.. syslog-tls-key specifies the absolute path to the TLS key file. This option is ignored if the address protocol is not tcp+tls.

``syslog-tls-key`` は TLS 鍵ファイルに対する絶対パスを指定します。このオプションは ``tcp+tls`` 以外のプロトコルを使う場合は無視されます。

.. syslog-tls-skip-verify configures the TLS verification. This verification is enabled by default, but it can be overridden by setting this option to true. This option is ignored if the address protocol is not tcp+tls.

``syslog-tls-skip-verify`` は TLS 認証を設定します。デフォルトでは認証が有効ですが、オプションの値を ``true`` に指定したら、この設定を上書きします。このオプションは ``tcp+tls`` 以外のプロトコルを使う場合は無視されます。

.. `tag` configures a string that is appended to the APP-NAME in the syslog message.

``tag`` 設定は syslog メッセージに APP-NAME の文字列を追加します。

.. By default, Docker uses the first 12 characters of the container ID to tag log messages. Refer to the log tag option documentation for customizing the log tag format.

デフォルトでは、Docker はコンテナ ID の冒頭 12 文字だけログ・メッセージにタグ付けします。タグ・フォーマットの記録方式をカスタマイズするには、 :doc:`log tag オプションのドキュメント <log_tags>` をご覧ください。

.. syslog-format specifies syslog message format to use when logging. If not specified it defaults to the local unix syslog format without hostname specification. Specify rfc3164 to perform logging in RFC-3164 compatible format. Specify rfc5424 to perform logging in RFC-5424 compatible format. Specify rfc5424micro to perform logging in RFC-5424 compatible format with microsecond timestamp resolution.

``syslog-format`` は syslog メッセージを書き込み時の書式を指定します。何も指定しなければ、デフォルトではホスト名を指定しないローカルの unix syslog 形式です。rfc3164 を指定したら、RFC-3164 互換形式でログを記録します。rfc5424 を指定したら、 RFC-5424 互換形式で記録します。 rfc5424micro を指定したら、RFC-5424 互換形式のタイムスタンプをミリ秒で記録します。

.. `env` should be a comma-separated list of keys of environment variables. Used for advanced [log tag options](log_tags.md).

``env`` は環境変数をカンマ区切りで指定します。高度な :doc:`log tag オプション <log_tags>` を使います。

.. `labels` should be a comma-separated list of keys of labels. Used for advanced [log tag options](log_tags.md).

``label`` はキーのラベルをカンマ区切りで指定します。高度な :doc:`log tag オプション <log_tags>` を使います。

.. journald options

.. _journald-options:

journald オプション
====================

.. The journald logging driver stores the container id in the journal’s CONTAINER_ID field. For detailed information on working with this logging driver, see the journald logging driver reference documentation.

``journald`` ロギング・ドライバは journal の ``CONTAINER_ID`` フィールドにコンテナ ID を記録します。ロギング・ドライバの詳細な動作については、 :doc:`journald ロギング・ドライバ <journald>` リファレンス・ドキュメントをご覧ください。

.. gelf options

.. _gelf-options:

gelf オプション
====================

.. The GELF logging driver supports the following options:

GELF ロギングドライバは以下のオプションをサポートしています。

.. code-block:: bash

   --log-opt gelf-address=udp://host:port
   --log-opt tag="database"
   --log-opt labels=label1,label2
   --log-opt env=env1,env2

.. The gelf-address option specifies the remote GELF server address that the driver connects to. Currently, only udp is supported as the transport and you must specify a port value. The following example shows how to connect the gelf driver to a GELF remote server at 192.168.0.42 on port 12201

``gelf-address`` オプションは、接続先のリモート GELF サーバのアドレスを指定します。現時点では ``udp`` が転送用にサポートされており、利用時に ``port`` を指定する必要があります。次の例は ``gelf`` ドライバで GELF リモートサーバ ``192.168.0.42`` のポート ``12201`` に接続します。

.. code-block:: bash

   $ docker run --log-driver=gelf --log-opt gelf-address=udp://192.168.0.42:12201

.. By default, Docker uses the first 12 characters of the container ID to tag log messages. Refer to the log tag option documentation for customizing the log tag format.

デフォルトでは、Docker はコンテナ ID の冒頭 12 文字のみログ・メッセージにタグ付けします。タグ・フォーマットの記録方式をカスタマイズするには、 :doc:`log tag オプションのドキュメント <log_tags>` をご覧ください。

.. The labels and env options are supported by the gelf logging driver. It adds additional key on the extra fields, prefixed by an underscore (_).

``label`` と ``env`` オプションが gelf ロギング・ドライバでサポートされています。これは ``extra`` フィールドに、冒頭がアンダースコア ( ``_`` ) で始まるキーを追加するものです。

.. code-block:: bash

   // […]
   "_foo": "bar",
   "_fizz": "buzz",
   // […]

.. The gelf-compression-type option can be used to change how the GELF driver compresses each log message. The accepted values are gzip, zlib and none. gzip is chosen by default.

``gelf-compression-type`` オプションは各ログ・メッセージの GELF ドライバ圧縮の仕方を調整します。指定可能な値は ``gzip`` 、 ``zlib`` 、``none`` です。デフォルトは ``gzip`` です。

.. The gelf-compression-level option can be used to change the level of compresssion when gzip or zlib is selected as gelf-compression-type. Accepted value must be from from -1 to 9 (BestCompression). Higher levels typically run slower but compress more. Default value is 1 (BestSpeed).

``gelf-compression-level`` オプションは ``gelf-compression-type`` に ``gzip`` または ``zlib`` を選択時の圧縮率を変更します。設定可能な値は -1 から 9 （最高圧縮）です。高いレベルの圧縮は、一般的に実行が遅くなります。デフォルト値は１（最高速度）です。

.. fluentd options

.. _fluentd-options:

fluentd オプション
====================

.. You can use the --log-opt NAME=VALUE flag to specify these additional Fluentd logging driver options.

``--log-opt NAME=VALUE`` フラグを使い、以下の Fluentd ロギング・ドライバのオプションを追加できます。

..    fluentd-address: specify host:port to connect [localhost:24224]
    tag: specify tag for fluentd message,


* ``fluentd-address`` ： 接続先を ``host:port`` の形式で指定。[localhost:24224]
* ``tag`` ： ``fluentd`` メッセージのタグを指定。
* ``fluentd-buffer-limit`` ： fluentd ログバッファの最大サイズを指定します。 [8MB]
* ``fluentd-retry-wait`` ： 接続リトライ前の初回遅延時間です（以降は指数関数的に増えます） [1000ms]　
* ``fluentd-max-retries`` ： docker で不意の障害が発生時、最大のリトライ数を指定します。 [1073741824]
* ``fluentd-async-connect`` ： 初期接続をブロックするかどうかを指定します。 [false]

.. For example, to specify both additional options:

例えば、両方のオプションを指定したら、次のようになります。

.. code-block:: bash

   docker run --log-driver=fluentd --log-opt fluentd-address=localhost:24224 --log-opt tag=docker.{{.Name}}

.. If container cannot connect to the Fluentd daemon on the specified address, the container stops immediately. For detailed information on working with this logging driver, see the fluentd logging driver

コンテナは指定した場所にある Fluentd デーモンに接続できなければ、コンテナは直ちに停止します。このロギング・ドライバの動作に関する詳細情報は :doc:`fluentd ロギング・ドライバ <fluentd>` をご覧ください。

.. Specify Amazon CloudWatch Logs options

.. _specify-amazon-cloudwatch-logs-options:

Amazon CloudWatch Logs オプションの指定
========================================

.. The Amazon CloudWatch Logs logging driver supports the following options:

Amazon CloudWatch ロギングドライバは、以下のオプションをサポートしています。

.. code-block:: bash

   --log-opt awslogs-region=<aws_region>
   --log-opt awslogs-group=<log_group_name>
   --log-opt awslogs-stream=<log_stream_name>

.. For detailed information on working with this logging driver, see the awslogs logging driver reference documentation.

このロギング・ドライバの動作に関する詳細情報は :doc:`awslogs ロギング・ドライバ <awslogs>` をご覧ください。

.. ETW logging driver options

.. _etw-logging-driver-options:

ETW ロギング・ドライバのオプション
========================================

.. The etwlogs logging driver does not require any options to be specified. This logging driver will forward each log message as an ETW event. An ETW listener can then be created to listen for these events.

etwlogs ロギング・ドライバには必須のオプションはありません。このロギング・ドライバは各ログメッセージを ETW イベントとして転送します。ETW 受信側（リスナー）は受信したイベントを作成できます。

.. For detailed information on working with this logging driver, see the ETW logging driver reference documentation.

このロギング・ドライバの動作に関する詳細情報は :doc:`ETW ロギング・ドライバ <etwlogs>` をご覧ください。

.. Google Cloud Logging

.. _google-cloud-logging:

Google Cloud ロギング
==============================

.. The Google Cloud Logging driver supports the following options:

Google Cloud ロギング・ドライバはいかのオプションをサポートしています。

.. code-block:: bash

   --log-opt gcp-project=<gcp_projext>
   --log-opt labels=<label1>,<label2>
   --log-opt env=<envvar1>,<envvar2>
   --log-opt log-cmd=true

.. For detailed information about working with this logging driver, see the Google Cloud Logging driver. reference documentation.

このロギング・ドライバの動作に関する詳細情報は :doc:`Google Cloud ロギング・ドライバ <gcplogs>` をご覧ください。


.. seealso:: 

   Configuring Logging Drivers
      https://docs.docker.com/engine/admin/logging/overview/

