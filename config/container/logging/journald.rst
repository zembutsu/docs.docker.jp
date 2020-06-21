.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/logging/journald/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/admin/logging/journald.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/admin/logging/journald.md
.. check date: 2016/06/13
.. Commits on Jun 1, 2016 a9f6d93099283ee06681caae7fe29bd1b2dd4c77
.. -------------------------------------------------------------------

.. Journald logging driver

=======================================
Journald ロギング・ドライバ
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. The journald logging driver sends container logs to the systemd journal. Log entries can be retrieved using the journalctl command, through use of the journal API, or using the docker logs command.

``journald`` ロギング・ドライバは、コンテナログを `systemd journal <http://www.freedesktop.org/software/systemd/man/systemd-journald.service.html>`_ に送信します。ログエントリは、 ``journalctl`` コマンドを使ってログエントリを確認できます。使うには journal API か ``docker logs`` コマンドを通します。

.. In addition to the text of the log message itself, the journald log driver stores the following metadata in the journal with each message:

ログメッセージ自身の文字列に加え、 ``journald`` ログドライバは各メッセージの journal に以下のメタデータを保管できます。

.. Field 	Description
   CONTAINER_ID 	The container ID truncated to 12 characters.
   CONTAINER_ID_FULL 	The full 64-character container ID.
   CONTAINER_NAME 	The container name at the time it was started. If you use docker rename to rename a container, the new name is not reflected in the journal entries.

.. list-table::
   :header-rows: 1
   
   * - フィールド
     - 説明
   * - ``CONTAINER_ID``
     - コンテナ ID の先頭から 12 文字。
   * - ``CONTAINER_ID_FULL``
     - 64 文字の完全なコンテナ ID。
   * - ``CONTAINER_NAME``
     - 開始時のコンテナ名。 ``docker rename`` でコンテナの名称を変えても、新しい名前は journal エントリに反映されない。
   * - ``CONTAINER_TAG``
     - コンテナのタグ（ :doc:`ログのタグに関するドキュメント <log_tags>` ）

.. Usage

.. _journald-usage:

使い方
==========

.. You can configure the default logging driver by passing the --log-driver option to the Docker daemon:

デフォルトのロギング・ドライバを設定するには、Docker デーモンに ``--log-driver`` オプションを使います。

.. code-block:: bash

   docker daemon --log-driver=journald

.. You can set the logging driver for a specific container by using the --log-driver option to docker run:

特定のコンテナに対してロギング・ドライバを指定する場合は、 ``docker run`` に ``--log-driver`` オプションを指定します。

.. code-block:: bash

   docker run --log-driver=journald ...

.. Options

.. _journald-option:

オプション
==========

.. Users can use the --log-opt NAME=VALUE flag to specify additional journald logging driver options.

``--log-opt NAME=VALUE`` フラグで journald ロギング・ドライバのオプションを追加できます。

.. tag

タグ
----------

.. Specify template to set CONTAINER_TAG value in journald logs. Refer to log tag option documentation for customizing the log tag forma

journald のログに ``CONTAINER_TAG`` 値でテンプレートを指定します。ログのタグ形式をカスタマイズするには :doc:`ログ用タグのオプションについてのドキュメント <log_tags>` をご覧ください。


.. labels and env

label と env
--------------------

.. The labels and env options each take a comma-separated list of keys. If there is collision between label and env keys, the value of the env takes precedence. Both options add additional metadata in the journal with each message.

``label`` と ``env`` オプションは、どちらもカンマ区切りでキーを指定できます。 ``label`` と ``env`` キーが重複する場合は、 ``env`` の値が優先されます。どちらのオプションもロギング・メッセージの特別属性（extra attributes）に追加フィールドを加えます。

.. Note regarding container names

.. _note-regarding-container-names:

コンテナ名に関する考慮点
==============================

.. The value logged in the CONTAINER_NAME field is the container name that was set at startup. If you use docker rename to rename a container, the new name will not be reflected in the journal entries. Journal entries will continue to use the original name.

``CONTAINER_NAME`` フィールドに記録される値は、起動時のコンテナ名が使われます。 ``docker rename`` でコンテナの名前を変更しても、 journal エントリの名前には反映されません。journal のエントリはオリジナルの名前を表示し続けます。

.. Retrieving log messages with journalctl

.. _retrieving-log-messages-with-journalctl:

journalctl でログメッセージを表示
========================================

.. You can use the journalctl command to retrieve log messages. You can apply filter expressions to limit the retrieved messages to a specific container. For example, to retrieve all log messages from a container referenced by name:

``journalctl`` コマンドを使って、ログメッセージを表示できます。フィルタ表現を追加することで、特定のコンテナに関するメッセージしか表示しないようにできます。例えば、特定のコンテナ名に関する全てのメッセージを表示するには、次のようにします。

.. code-block:: bash

   # journalctl CONTAINER_NAME=webserver

.. You can make use of additional filters to further limit the messages retrieved. For example, to see just those messages generated since the system last booted:

メッセージの制限だけでなく、他のフィルタも利用できます。例えば、システムが直近でリブートした以降のメッセージを生成するには、次のように実行します。

.. code-block:: bash

   # journalctl -b CONTAINER_NAME=webserver

.. Or to retrieve log messages in JSON format with complete metadata:

あるいは、全てのメタデータを含む JSON 形式でメッセージを表示するには、次のようにします。

.. code-block:: bash

   # journalctl -o json CONTAINER_NAME=webserver

.. Retrieving log messages with the journal API

.. _retrieving-log-messages-wiht-the-journal-api:

journal API でログメッセージを表示
========================================

.. This example uses the systemd Python module to retrieve container logs:

この例は ``systemd`` Python モジュールを使い、コンテナのログを取得しています。

.. code-block:: bash

   import systemd.journal
   
   reader = systemd.journal.Reader()
   reader.add_match('CONTAINER_NAME=web')
   
   for msg in reader:
     print '{CONTAINER_ID_FULL}: {MESSAGE}'.format(**msg)

.. seealso:: 

   Journald logging driver
      https://docs.docker.com/engine/admin/logging/journald/

