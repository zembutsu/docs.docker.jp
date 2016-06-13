.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/logging/fluentd/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/admin/logging/fluentd.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/admin/logging/fluentd.md
.. check date: 2016/06/13
.. Commits on Jun 2, 2016 c1be45fa38e82054dcad606d71446a662524f2d5
.. ---------------------------------------------------------------------------

.. Fluentd logging driver

=======================================
Fluentd ロギング・ドライバ
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. The fluentd logging driver sends container logs to the Fluentd collector as structured log data. Then, users can use any of the various output plugins of Fluentd to write these logs to various destinations.

``fluentd`` ロギング・ドライバは、コンテナのログを `Fluentd <http://www.fluentd.org/>`_ コレクタに構造化したログ・データとして送信します。それから、ユーザは `Fluentd の様々な出力プラグイン <http://www.fluentd.org/plugins>`_ を使い、ログを様々な送信先に送れます。

.. In addition to the log message itself, the fluentd log driver sends the following metadata in the structured log message:

ログ・メッセージ自身に加え、  ``fluent`` ログ・ドライバは以下のメタデータを構造化ログ・メッセージの中に入れて送信できます。

.. Field 	Description
.. container_id 	The full 64-character container ID.
.. container_name 	The container name at the time it was started. If you use docker rename to rename a container, the new name is not reflected in the journal entries.
.. source 	stdout or stderr

.. list-table::
   :header-rows: 1
   
   * - フィールド
     - 説明
   * - ``container_id``
     - 64 文字の完全コンテナ ID
   * - ``container_name``
     - 開始時のコンテナ名。 ``docker rename`` でコンテナの名称を変えても、新しい名前は journal エントリに反映されない
   * - ``source``
     - ``stdout`` か ``stderr``

.. The docker logs command is not available for this logging driver.

このロギング・ドライバの使用時は、 ``docker logs`` コマンドを利用できません。

.. Usage

.. _fluentd-usage:

使い方
==========

.. Some options are supported by specifying --log-opt as many times as needed:

必要であれば、同じ ``--log-opt`` オプションを何度も指定可能です。

..    fluentd-address: specify host:port to connect localhost:24224
    tag: specify tag for fluentd message, which interpret some markup, ex {{.ID}}, {{.FullID}} or {{.Name}} docker.{{.ID}}

* ``fluentd-address`` ： ``localhost:24224`` に接続する ``host:port`` を指定します。
* ``tag`` ： fluentd メッセージに送るタグを指定します。 ``{{.ID}}`` 、 ``{{.FullID}}`` 、 ``{{.Name}}`` 、 ``docker.{{.ID}}`` のようなマークアップ形式です。

.. Configure the default logging driver by passing the --log-driver option to the Docker daemon:

デフォルトのロギング・ドライバを設定するには、Docker デーモンに ``--log-driver`` オプションを使います。

.. code-block:: bash

   docker daemon --log-driver=fluentd

.. To set the logging driver for a specific container, pass the --log-driver option to docker run:

特定のコンテナに対してロギング・ドライバを指定する場合は、 ``docker run`` に ``--log-driver`` オプションを指定します。

.. code-block:: bash

   docker run --log-driver=fluentd ...

.. Before using this logging driver, launch a Fluentd daemon. The logging driver connects to this daemon through localhost:24224 by default. Use the fluentd-address option to connect to a different address.

このロギング・ドライバを使う前に、Fluentd デーモンを起動します。ロギング・ドライバは、デフォルトで ``localhost:24224`` のデーモンに接続を試みます。 ``fluentd-address`` オプションを使えば、異なったアドレスに接続できます。

.. code-block:: bash

   docker run --log-driver=fluentd --log-opt fluentd-address=myhost.local:24224

.. If container cannot connect to the Fluentd daemon, the container stops immediately.

コンテナが Fluentd デーモンに接続できなければ、コンテナは直ちに停止します。

.. Options

.. _fluentd-logging-options:

オプション
==========

.. Users can use the --log-opt NAME=VALUE flag to specify additional Fluentd logging driver options.

``--log-opt NAME=VALUE`` フラグで Fluentd ロギング・ドライバのオプションを追加できます。

.. fluentd-address

fluentd-address
--------------------

.. By default, the logging driver connects to localhost:24224. Supply the fluentd-address option to connect to a different address.

デフォルトでは、ロギング・ドライバは ``localhost:24224`` に接続します。 ``fluentd-address`` オプションを指定すると、異なったアドレスに接続します。

.. code-block:: bash

    docker run --log-driver=fluentd --log-opt fluentd-address=myhost.local:24224

.. tag

tag
----------

.. By default, Docker uses the first 12 characters of the container ID to tag log messages. Refer to the log tag option documentation for customizing the log tag format.

デフォルトでは、Docker はコンテナ ID の冒頭 12 文字を tag log メッセージで使います。このログフォーマットをカスタマイズするには、 :doc:`log tag オプションのドキュメント <log_tags>` をご覧ください。

.. labels and env

label と env
--------------------

.. The labels and env options each take a comma-separated list of keys. If there is collision between label and env keys, the value of the env takes precedence. Both options add additional fields to the extra attributes of a logging message.

``label`` と ``env`` オプションは、どちらもカンマ区切りでキーを指定できます。 ``label`` と ``env`` キーが重複する場合は、 ``env`` の値が優先されます。どちらのオプションもロギング・メッセージの特別属性（extra attributes）に追加フィールドを加えます。

.. fluentd-async-connect

.. Docker connects to Fluentd in the background. Messages are buffered until the connection is established.

fluentd-acync-connect
------------------------------

Docker は Fluentd にバックグラウンドで接続します。接続が確立できるまでメッセージはバッファされます。

.. Fluentd daemon management with Docker

.. _fluentd-daemon-management-with-docker:

Docker と Fluentd デーモンの管理
========================================

.. About Fluentd itself, see the project webpage and its documents.

``Fluentd`` そのものについては、 `プロジェクトのウェブページ <http://www.fluentd.org/>`_ と `ドキュメント <http://docs.fluentd.org/>`_ をご覧ください。

.. To use this logging driver, start the fluentd daemon on a host. We recommend that you use the Fluentd docker image. This image is especially useful if you want to aggregate multiple container logs on each host then, later, transfer the logs to another Fluentd node to create an aggregate store.

このロギング・ドライバを使うには、ホスト上に ``fluentd`` デーモンを起動します。私たちは `Fluentd docker イメージ <https://registry.hub.docker.com/u/fluent/fluentd/>`_ の利用を推奨します。このイメージが特に役立つのは、各ホスト上にある複数のコンテナのログを統合する場合です。そして、ログはデータを統合する用途として作成した、別の Fluentd ノードに転送できます。

.. Testing container loggers

.. _testing-container-loggers:

コンテナのログ記録をテスト
------------------------------

..    Write a configuration file (test.conf) to dump input logs:

1. 設定ファイル ( ``test.conf`` ) に入力ログをダンプするよう記述します。

.. code-block:: bash

   <source>
     @type forward
   </source>
   
   
   <match docker.**>
     @type stdout
   </match>

..     Launch Fluentd container with this configuration file:

2. Fluentd コンテナを、この設定を使って起動します。

.. code-block:: bash

   $ docker run -it -p 24224:24224 -v /path/to/conf/test.conf:/fluentd/etc -e FLUENTD_CONF=test.conf fluent/fluentd:latest

..    Start one or more containers with the fluentd logging driver:

3. ``fluentd`` ロギング・ドライバを使うコンテナを更に起動します。

.. code-block:: bash

   $ docker run --log-driver=fluentd your/application

.. seealso:: 

   Fluentd logging driver
      https://docs.docker.com/engine/admin/logging/fluentd/

