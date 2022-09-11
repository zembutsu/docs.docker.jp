.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/logging/etwlogs/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/admin/logging/etwlogs.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/admin/logging/etwlogs.md
.. check date: 2016/06/13
.. Commits on Jun 1, 2016 a9f6d93099283ee06681caae7fe29bd1b2dd4c77
.. -------------------------------------------------------------------

.. ETW logging driver

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _etw-logging-driver:

=======================================
ETW ロギング・ドライバ
=======================================

.. The ETW logging driver forwards container logs as ETW events. ETW stands for Event Tracing in Windows, and is the common framework for tracing applications in Windows. Each ETW event contains a message with both the log and its context information. A client can then create an ETW listener to listen to these events.

ETW ロギング・ドライバはコンテナのログを ETW イベントとして転送します。ETW は Windows におけるイベント・トレース（追跡）であり、Windows 上のアプリケーションをトレースする共通フレームワークです。各 ETW イベントにはログとコンテクスト情報の両方があります。クライアントは ETW リスナーを通して、これらのイベントを確認できます。

.. The ETW provider that this logging driver registers with Windows, has the GUID identifier of: {a3693192-9ed6-46d2-a981-f8226c8363bd}. A client creates an ETW listener and registers to listen to events from the logging driver’s provider. It does not matter the order in which the provider and listener are created. A client can create their ETW listener and start listening for events from the provider, before the provider has been registered with the system.

ETW はロギング・ドライバを ``{a3693192-9ed6-46d2-a981-f8226c8363bd}`` のような GUID 識別子で Windows に登録します。クライアントは新しい ETW リスナーを作成し、ロギング・ドライバが送信するイベントを受信・登録できます。

.. Usage

.. _etw-usage:

使い方
==========

.. Here is an example of how to listen to these events using the logman utility program included in most installations of Windows:

ここでは大部分の Windows にインストール済みの logman ユーティリティ・プログラムを使い、これらのイベントのリッスン例を扱います。

..    logman start -ets DockerContainerLogs -p {a3693192-9ed6-46d2-a981-f8226c8363bd} 0 0 -o trace.etl
    Run your container(s) with the etwlogs driver, by adding --log-driver=etwlogs to the Docker run command, and generate log messages.
    logman stop -ets DockerContainerLogs
    This will generate an etl file that contains the events. One way to convert this file into human-readable form is to run: tracerpt -y trace.etl.

1. ``logman start -ets DockerContainerLogs -p {a3693192-9ed6-46d2-a981-f8226c8363bd} 0 0 -o trace.etl``
2. コンテナを etwlog ドライバと一緒に起動します。 docker run コマンドに ``--log-driver=etwlogs`` を追加します。
3. ``logman stop -ets DockerContainerLogs``
4. 実行するとイベントを含む etl ファイルを作成します。人間が読める形式に変換する方法の１つが ``tracerpt -y trace.etl`` の実行です。

.. Each ETW event will contain a structured message string in this format:

各 ETW イベントには、次の形式のように構造化されたメッセージを含みます。 

::

   container_name: %s, image_name: %s, container_id: %s, image_id: %s, source: [stdout | stderr], log: %s

.. Details on each item in the message can be found below:

各メッセージの詳細は以下の通りです。

.. Field 	Description
    container_name 	The container name at the time it was started.
   image_name 	The name of the container’s image.
   container_id 	The full 64-character container ID.
   image_id 	The full ID of the container’s image.
   source 	stdout or stderr.
   log 	The container log message.

.. list-table::
   :header-rows: 1
   
   * - **フィールド**
     -  **説明**
   * - ``container_name``
     - 開始のコンテナ名。
   * - ``image_name``
     - コンテナのイメージ名。
   * - ``container_id``
     - 64文字のコンテナ ID。
   * - ``image_id``
     - コンテナ・イメージのフル ID。
   * - ``source``
     - ``stdout`` （標準出力）または ``stderr``  （標準エラー出力）。
   * - ``log``
     - コンテナのログ・メッセージ。

.. Here is an example event message:

以下はイベント・メッセージの例です。

:: 

   container_name: backstabbing_spence, 
   image_name: windowsservercore, 
   container_id: f14bb55aa862d7596b03a33251c1be7dbbec8056bbdead1da8ec5ecebbe29731, 
   image_id: sha256:2f9e19bd998d3565b4f345ac9aaf6e3fc555406239a4fb1b1ba879673713824b, 
   source: stdout, 
   log: Hello world!

.. A client can parse this message string to get both the log message, as well as its context information. Note that the time stamp is also available within the ETW event.

クライアントはこのメッセージ文字列をログメッセージごとにパース可能です。また、コンテクスト情報も同様です。ETW イベント無いのタイムスタンプも利用可能です。

.. Note This ETW provider emits only a message string, and not a specially structured ETW event. Therefore, it is not required to register a manifest file with the system to read and interpret its ETW events.

.. note::

   ETW プロバイダはメッセージ文字列のみ転送するだけであり、特別な ETW イベント構造ではありません。そのため、システムが ETW イベントの読み込み・受信のため、マニフェスト・ファイルを登録する必要がありません。

.. seealso:: 

   ETW logging driver
      https://docs.docker.com/engine/admin/logging/log_tags/
