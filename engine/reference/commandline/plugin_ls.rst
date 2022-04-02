.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/plugin_ls/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/plugin_ls.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_plugin_ls.yaml
.. check date: 2022/04/02
.. Commits on Apr 2, 2022 098129a0c12e3a79398b307b38a67198bd3b66fc
.. -------------------------------------------------------------------

.. docker plugin ls

=======================================
docker plugin ls
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:


.. List plugins

プラグインを一覧表示します。

.. API 1.25+
   Open the 1.25 API reference (in a new window)
   The client and daemon API must both be at least 1.25 to use this command. Use the docker version command on the client to check your client and daemon API versions.

【API 1.25+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.25 <https://docs.docker.com/engine/api/v1.25/>`_ の必要があります。クライアントとデーモン API のバージョンを調べるには、 ``docker version`` コマンドを使います。


.. _plugin_ls-usage:

使い方
==========

.. code-block:: bash

   $ docker plugin ls [OPTIONS]

.. Extended description
.. _plugin_ls-extended-description:

補足説明
==========

.. Lists all the plugins that are currently installed. You can install plugins using the docker plugin install command. You can also filter using the -f or --filter flag. Refer to the filtering section for more information about available filter options.

インストール済みの全てのプラグインを表示します。 :doc:`docker plugin install <plugin_install>` コマンドでプラグインをインストールできます。 ``-f`` や ``--filter`` フラグを使ってフィルタもできます。利用可能なフィルタのオプションに関する情報は、 :ref:`フィルタリング <plugin_ls-filtering>` のセクションをご覧ください。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <plugin_ls-examples>` をご覧ください。

.. Options
.. _plugin_ls-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--filter`` , ``-f``
     - 
     - フィルタの値を指定（例： ``enabled=true`` ）
   * - ``--format``
     - 
     - Go テンプレートを使ってプラグインの出力を整形
   * - ``--no-trunc``
     - 
     - 出力を省略しない
   * - ``--quiet`` , ``-q``
     - 
     - プラグイン ID のみ表示

.. Examples
.. _plugin_ls-examples:

使用例
==========

.. code-block:: bash

   $ docker plugin ls
   
   ID            NAME                                    DESCRIPTION                ENABLED
   69553ca1d123  tiborvass/sample-volume-plugin:latest   A test plugin for Docker   true

.. Filtering
.. _plugin_ls-filtering:
フィルタリング
--------------------

.. The filtering flag (-f or --filter) format is of “key=value”. If there is more than one filter, then pass multiple flags (e.g., --filter "foo=bar" --filter "bif=baz")

フィルタリングのフラグ（ ``-f`` か ``--filter`` ）は「key=value」の形式です。複数のフィルタを使うには、複数回フラグを使います（例： ``--filter "foo=bar" --filter "bif=baz"`` ）。

.. The currently supported filters are:

現時点でサポートしているフィルタは、

..  enabled (boolean - true or false, 0 or 1)
    capability (string - currently volumedriver, networkdriver, ipamdriver, logdriver, metricscollector, or authz)

- ``enabled`` （ブール値 - true か false 、0 か 1）
- ``capability`` （文字列 - 現時点では ``volumedriver`` 、 ``networkdriver`` 、 ``ipamdriver`` 、 ``logdriver`` 、 ``metricscollector`` 、 ``authz`` ）

.. enabled
.. _plugin_ls-enabled:
enabled
^^^^^^^^^^

.. The enabled filter matches on plugins enabled or disabled.

``enabled`` フィルタは、有効化か無効化に一致するプラグインを表示します。

.. capability
.. _plugin-ls-capability:
capability
^^^^^^^^^^

.. The capability filter matches on plugin capabilities. One plugin might have multiple capabilities. Currently volumedriver, networkdriver, ipamdriver, logdriver, metricscollector, and authz are supported capabilities.

``capability`` フィルタはプラグインのケーパビリティに一致します。1つのプラグインは、複数のケーパビリティを持ち得ます。現時点でサポートされているケーパビリティは、 ``volumedriver`` 、 ``networkdriver`` 、 ``ipamdriver`` 、 ``logdriver`` 、 ``metricscollector`` 、 ``authz`` です。

.. code-block:: bash

   $ docker plugin install --disable vieux/sshfs
   
   Installed plugin vieux/sshfs
   
   $ docker plugin ls --filter enabled=true
   
   ID                  NAME                DESCRIPTION         ENABLED

.. Formatting
.. _plugin_ls-formatting:
表示形式
----------


.. The formatting option (--format) will pretty-print plugins output using a Go template.

フォーマットのオプション（ ``--format`` ）は Go テンプレートを使いプラグインの出力を整形します。

.. Valid placeholders for the Go template are listed below:

Go テンプレートで置き換え可能な一覧は、次の通りです：

.. list-table::
   
   * - ``.ID``
     - プラグイン ID
   * - ``.Name``
     - プラグイン名とタグ
   * - ``.Description``
     - プラグイン説明
   * - ``.Enabled``
     - プラグインが有効かどうか
   * - ``.PluginReference``
     - レジストリから push または pull のために使うリファレンス

.. When using the --format option, the plugin ls command will either output the data exactly as the template declares or, when using the table directive, includes column headers as well.

``plugin ls`` コマンドに ``--format`` オプションを使えば、テンプレートで指定したデータを出力するだけでなく、 ``table`` 命令を使うとカラム（例）ヘッダも同様に表示します。

.. The following example uses a template without headers and outputs the ID and Name entries separated by a colon (:) for all plugins:

次の例はヘッダを除くテンプレートを使い、実行中の全てのコンテナに対して、 ``ID`` と ``Name`` エントリを句切って出力します。

.. code-block:: bash

   $ docker plugin ls --format "{{.ID}}: {{.Name}}"
   
   4be01827a72e: vieux/sshfs:latest



.. Parent command

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker plugin<plugin>`
     - プラグインを管理

.. Related commands

関連コマンド
====================

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker plugin create<plugin_create>`
     - rootfs と設定からプラグインを作成。プラグインのデータディレクトリには、 config.json と rootfs ディレクトリが必須
   * - :doc:`docker plugin disable<plugin_disable>`
     - プラグインの無効化
   * - :doc:`docker plugin enable<plugin_enable>`
     - プラグインの有効化
   * - :doc:`docker plugin inspect<plugin_inspect>`
     - 1つまたは複数プラグインの詳細情報を表示
   * - :doc:`docker plugin install<plugin_install>`
     - プラグインをインストール
   * - :doc:`docker plugin ls<plugin_ls>`
     - プラグイン一覧表示
   * - :doc:`docker plugin rm<plugin_rm>`
     - 1つまたは複数プラグインを削除
   * - :doc:`docker plugin set<plugin_set>`
     - プラグインの設定を変更
   * - :doc:`docker plugin upgrade<plugin_upgrade>`
     - 既存のプラグインを更新


.. seealso:: 

   docker plugin ls
      https://docs.docker.com/engine/reference/commandline/plugin_ls/

