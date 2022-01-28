.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/config/containers/logging/configure/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/config/containers/logging/configure.md
   doc version: 19.03
.. check date: 2020/07/01
.. Commits on Apr 8, 2020 727941ffdd6430562e09314d3199b56f2de666df
.. ---------------------------------------------------------------------------

.. Configure logging drivers

.. _configure-logging-drivers:

=======================================
ロギング・ドライバの設定
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Docker includes multiple logging mechanisms to help you get information from running containers and services. These mechanisms are called logging drivers.

Docker は複数のログ記録（ロギング）機能を含んでおり、 :doc:`実行中のコンテナとサービスから情報を得るには <index>` が役立ちます。これらの仕組みをロギング・ドライバ（logging driver）と呼びます。

.. Each Docker daemon has a default logging driver, which each container uses unless you configure it to use a different logging driver.

各 Docker デーモンにはデフォルトのロギング・ドライバがあり、コンテナに対して何らかの別のロギング・ドライバを指定しない限り、デフォルトでコンテナに対して適用します。

.. In addition to using the logging drivers included with Docker, you can also implement and use logging driver plugins.

Docker に含むロギング・ドライバに加え、 :doc:`ロギング・ドライバ・プラグイン <plugins>` を使った異なる実装も可能です。


.. Configure the default logging driver

.. _configure-the-default-logging-driver:

デフォルトのロギング・ドライバを指定
========================================

.. To configure the Docker daemon to default to a specific logging driver, set the value of log-driver to the name of the logging driver in the daemon.json file, which is located in /etc/docker/ on Linux hosts or C:\ProgramData\docker\config\ on Windows server hosts. The default logging driver is json-file. The following example explicitly sets the default logging driver to syslog:

Docker デーモンに対してデフォルトで何らかのロギング・ドライバを指定するには、 ``daemon.json``  ファイル中の ``log-driver`` にロギング・ドライバ名を書きます。このファイルは Linux ホスト上では ``/etc/docker`` にあり、 Windows サーバ・ホスト上では ``C:\ProgramData\docker\config\`` にあります。デフォルトのロギング・ドライバは ``json-file`` です。以下の例は、デフォルトのロギング・ドライバとして ``syslog`` を明示しています。

.. code-block:: json

   {
     "log-driver": "syslog"
   }

.. If the logging driver has configurable options, you can set them in the daemon.json file as a JSON object with the key log-opts. The following example sets two configurable options on the json-file logging driver:

もしもロギング・ドライバに設定可能なオプションがあれば、 ``daemon.json`` ファイルの中で、 ``log-opts`` をキーとする JSON オブジェクトとして記述できます。以下の例は ``json-file`` ロギング・ドライバ上で2つのオプションを設定しています。

.. code-block:: json

   {
     "log-driver": "json-file",
     "log-opts": {
       "max-size": "10m",
       "max-file": "3",
       "labels": "production_status",
       "env": "os,customer"
     }
   }

..  Note
    log-opts configuration options in the daemon.json configuration file must be provided as strings. Boolean and numeric values (such as the value for max-file in the example above) must therefore be enclosed in quotes (").

.. note::

   ``daemon.json`` 設定ファイル中における ``log-opts`` 設定は、文字列として指定する必要があります。そのため、論理型（boolean）や整数値（ ``max-file``の値など ）を使う場合は、引用符（ ``"`` ）で囲む必要があります。

.. If you do not specify a logging driver, the default is json-file. Thus, the default output for commands such as docker inspect <CONTAINER> is JSON.

ロギング・ドライバを指定しなければ、デフォルトは ``json-file`` です。つまり、 ``docker inspect <コンテナ>`` のコマンド出力は、デフォルトで JSON 形式です。

.. To find the current default logging driver for the Docker daemon, run docker info and search for Logging Driver. You can use the following command on Linux, macOS, or PowerShell on Windows:

Docker デーモンにおける現在のデフォルトのロギング・ドライバを調べるには、 ``docker info`` を実行し、 ``Logging Driver`` を探します。Linux や macOS や Windows の PowerShell 上であれば、以下のコマンドも実行できます。

.. code-block:: bash

   $ docker info --format '{{.LoggingDriver}}'
   
   json-file

.. Configure the logging driver for a container

.. _configure-the-logging-driver-for-a-container:

コンテナに対してロギング・ドライバを設定
==================================================

.. nWhen you start a container, you can configure it to use a different logging driver than the Docker daemon’s default, using the --log-driver flag. If the logging driver has configurable options, you can set them using one or more instances of the --log-opt <NAME>=<VALUE> flag. Even if the container uses the default logging driver, it can use different configurable options.

コンテナの起動時に ``--log-driver`` を使えば、Docker デーモンのデフォルト設定とは異なるロギング・ドライバを指定できます。ロギング・ドライガに設定可能なオプションがあれば、1つまたは複数の項目を ``--log-opt <名前>=<値>`` フラグで指定できます。もしもコンテナがデフォルトのロギング・ドライバを使用する場合でも、異なる設定可能なオプションを指定できます。

.. The following example starts an Alpine container with the none logging driver.

以下は Alpine コンテナを ``none`` ロギング・ドライバで起動する例です。

.. code-block:: bash

   $ docker run -it --log-driver none alpine ash

.. To find the current logging driver for a running container, if the daemon is using the json-file logging driver, run the following docker inspect command, substituting the container name or ID for <CONTAINER>:

実行中のコンテナに対して、現在のデフォルトのロギング・ドライバを調べるには、もしもデーモンが ``json-file`` ロギング・ドライバを使う場合、  ``docker inspect`` コマンドを使い、あとには ``<コンテナ>`` の名前または ID を続けます：

.. code-block:: bash

   $ docker inspect -f '{{.HostConfig.LogConfig.Type}}' <CONTAINER>
   
   json-file

.. Configure the delivery mode of log messages from container to log driver

.. _configure-the-delivery-mode-of-log-messages-from-container-to-log-driver:

コンテナからログ・ドライバに対する、ログメッセージの転送モードを設定
======================================================================

.. Docker provides two modes for delivering messages from the container to the log driver:

コンテナからログ・ドライバにメッセージを転送するために、 Docker には2つのモードがあります。

..  (default) direct, blocking delivery from container to driver
    non-blocking delivery that stores log messages in an intermediate per-container ring buffer for consumption by driver

* （デフォルト）コンテナからドライバに対して、直接、ブロッキング・デリバリ（blocking delivery）
* ドライバが消費する中間コンテナごとのリング・バッファに、ログ・メッセージを保管する非ブロッキング・デリバリ（non-blocking delivery）

.. The non-blocking message delivery mode prevents applications from blocking due to logging back pressure. Applications are likely to fail in unexpected ways when STDERR or STDOUT streams block.

``non-blocking`` メッセージ・デリバリ・モードでは、ロギング・バック圧縮（logging back pressure）によって、アプリケーションからのブロッキングを阻止します。アプリケーションは ``STDERR`` や ``STDOUT`` ストリームのブロックにより、予期しない異常のようになるでしょう。

..    WARNING When the buffer is full and a new message is enqueued, the oldest message in memory is dropped. Dropping messages is often preferred to blocking the log-writing process of an application.

.. warning::

   バッファがいっぱいになり、新しいメッセージが待機状態になると、メモリ上の最も古いメッセージは破棄（drop）されます。メッセージの破棄は、アプリケーションのログ記録プロセスのブロッキングよりも優先されます。

.. The mode log option controls whether to use the blocking (default) or non-blocking message delivery.

``mode`` ログオプションは、どこで ``blocking`` （デフォルトでは）、 または ``non-blocking`` メッセージを送信するか制御します。

.. The max-buffer-size log option controls the size of the ring buffer used for intermediate message storage when mode is set to non-blocking. max-buffer-size defaults to 1 megabyte.

``max-buffer-size`` ログオプションは、中間メッセージ・ストレージ用のリング・バッファに使う容量を制御します。 ``mode``  を ``non-blocking`` に設定すると、``max-buffer-size`` はデフォルトで 1 メガバイトになります。

.. The following example starts an Alpine container with log output in non-blocking mode and a 4 megabyte buffer:

以下はログ出力を non-blocking モードかつ 4 メガバイトのバッファで Alpine コンテナを起動する例です。

.. code-block:: bash

   $ docker run -it --log-opt mode=non-blocking --log-opt max-buffer-size=4m alpine ping 127.0.0.1

.. Use environment variables or labels with logging drivers

.. _use-environment-variables-or-labels-with-logging-drivers:

ロギング・ドライバで環境変数やラベルを使う
--------------------------------------------------

.. Some logging drivers add the value of a container’s --env|-e or --label flags to the container’s logs. This example starts a container using the Docker daemon’s default logging driver (let’s assume json-file) but sets the environment variable os=ubuntu.


いくつかのロギング・ドライバは、コンテナの ``--env|-e`` や ``--label`` フラグを使い、コンテナのログに値を追加できます。この例は、Docker デーモンのデフォルトのロギング・ドライバ（ ``json-file`` と仮定します）でコンテナを起動しますが、環境変数を ``os=ubuntu`` に設定します。

.. code-block:: bash

   $ docker run -dit --label production_status=testing -e os=ubuntu alpine sh

.. If the logging driver supports it, this adds additional fields to the logging output. The following output is generated by the json-file logging driver:

ロギング・ドライバがサポートしていれば、ログの出力に追加のフィールドを追加出来ます。以下の出力は ``json-file`` ロギング・ドライバによって生成された出力です。

::

   "attrs":{"production_status":"testing","os":"ubuntu"}


.. Supported logging drivers

.. _supported-logging-drivers:

サポートしているロギング・ドライバ
========================================

.. The following logging drivers are supported. See the link to each driver’s documentation for its configurable options, if applicable. If you are using logging driver plugins, you may see more options.

以下のロギング・ドライバがサポートされています。設定のオプションに関しては、該当する各ドライバのドキュメントへのリンクをご覧ください。 :doc:`ロギング・ドライバ・プラグイン <plugins>` の利用時には、さらにオプションがあるでしょう。

.. Driver 	Description
   none 	No logs are available for the container and docker logs does not return any output.
   local 	Logs are stored in a custom format designed for minimal overhead.
   json-file 	The logs are formatted as JSON. The default logging driver for Docker.
   syslog 	Writes logging messages to the syslog facility. The syslog daemon must be running on the host machine.
   journald 	Writes log messages to journald. The journald daemon must be running on the host machine.
   gelf 	Writes log messages to a Graylog Extended Log Format (GELF) endpoint such as Graylog or Logstash.
   fluentd 	Writes log messages to fluentd (forward input). The fluentd daemon must be running on the host machine.
   awslogs 	Writes log messages to Amazon CloudWatch Logs.
   splunk 	Writes log messages to splunk using the HTTP Event Collector.
   etwlogs 	Writes log messages as Event Tracing for Windows (ETW) events. Only available on Windows platforms.
   gcplogs 	Writes log messages to Google Cloud Platform (GCP) Logging.
   logentries 	Writes log messages to Rapid7 Logentries.

.. list-table::
   :header-rows: 1

   * - ドライバ
     - 説明
   * - ``none`` 
     - コンテナに対するログを記録せず、 ``docker logs`` は何も出力しません。
   * - `local <https://docs.docker.com/config/containers/logging/local/>`_
     - ログは最小のオーバヘッドになるよう設計された、カスタム形式で記録します。
   * - `json-file <https://docs.docker.com/config/containers/logging/json-file/>`_
     - JSON 形式でログを記録します。Docker のデフォルトのロギング・ドライバです。
   * - `syslog <https://docs.docker.com/config/containers/logging/syslog/>`_
     - ``syslog`` ファシリティに対してロギング・メッセージを記録します。ホスト・マシン上で ``syslog`` デーモンの起動が必要です。
   * - `journald <https://docs.docker.com/config/containers/logging/journald/>`_
     - ログメッセージを ``journald`` に記録します。ホスト・マシン上で ``journald`` デーモンの起動が必要です。
   * - `gelf <https://docs.docker.com/config/containers/logging/gelf/>`_
     - ログメッセージを Graylog または Logstach などのような Graylog Extended Log Format (GELF) エンドポイントに記録します。
   * - `fluentd <https://docs.docker.com/config/containers/logging/fluentd/>`_
     - ログメッセージを ``fluentd`` に記録（forward input）します。ホスト・マシン上で ``fluentd`` デーモンの起動が必要です。
   * - `awslogs <https://docs.docker.com/config/containers/logging/awslogs/>`_
     - ログメッセージを Amazon CloudWatch Logs に記録します。
   * - `splunk <https://docs.docker.com/config/containers/logging/splunk/>`_
     - HTTP Event Collector を使い、 ``splunk``  にログメッセージを記録します。
   * - `etwlogs <https://docs.docker.com/config/containers/logging/etwlogs/>`_
     - Event Tracing for Windows (ETW) events としてログメッセージを記録します。Windows プラットフォーム上で利用可能です。
   * - `gcplogs <https://docs.docker.com/config/containers/logging/gcplogs/>`_
     - Google Cloud Platform (GCP) ロギングにログメッセージを記録します。
   * - `logentries <https://docs.docker.com/config/containers/logging/logentries/>`_
     - Rapid7 Logentries に対してログメッセージを記録します。


.. Limitations of logging drivers

.. _limitations-of-logging-drivers:

ロギング・ドライバの制限
==============================

..    Users of Docker Enterprise can make use of “dual logging”, which enables you to use the docker logs command for any logging driver. Refer to reading logs when using remote logging drivers for information about using docker logs to read container logs locally for many third party logging solutions, including:

* Docker Enterprise のユーザは "dual logging" を利用できます。これは ``docker logs``  コマンドであらゆるロギング・ドライバを利用可にします。 ``docker logs``  を使ってローカルでコンテナのログを読むための情報は `reading logs when using remote logging drivers  <https://docs.docker.com/config/containers/logging/dual-logging/>`_ をご覧ください。以下のロギング・ソリューションのほか、サードパーティのものも含みます。

      * ``syslog``
      * ``gelf``
      * ``fluentd``
      * ``awslogs``
      * ``splunk``
      * ``etwlogs``
      * ``gcplogs``
      * ``Logentries``

..     When using Docker Community Engine, the docker logs command is only available on the following drivers:

* Docker Community Engine を使う場合は、 ``docker logs`` コマンドは以下のドライバのみ利用可能です。

      * ``local``
      * ``json-file``
      * ``journald``

..     Reading log information requires decompressing rotated log files, which causes a temporary increase in disk usage (until the log entries from the rotated files are read) and an increased CPU usage while decompressing.
..    The capacity of the host storage where the Docker data directory resides determines the maximum size of the log file information.

* 圧縮されローテートされたログファイルから、ログ情報を読み込む必要がある場合、一時的なディスク使用率が増加（ローテートされたファイルからログエントリを読み込むまで）を引き起こしたり、展開中に CPU 使用率を増加を引き起こします。
* Docker データ・ディレクトリのあるホスト・ストレージの容量によって、最大のログファイル情報が決まります。

.. seealso:: 

   Configure logging drivers
      https://docs.docker.com/config/containers/logging/configure/
