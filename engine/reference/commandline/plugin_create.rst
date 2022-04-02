.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/plugin_create/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/plugin_create.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_plugin_create.yaml
.. check date: 2022/03/29
.. Commits on Aug 21, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker plugin create

=======================================
docker plugin create
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _plugin_create-description:

説明
==========

.. Create a plugin from a rootfs and configuration. Plugin data directory must contain config.json and rootfs directory.

rootfs （ルート・ファイルシステム）と設定からプラグインを作成します。プラグインのデータディレクトリには、 config.json と rootfs ディレクトリが必須です。

.. API 1.25+
   Open the 1.25 API reference (in a new window)
   The client and daemon API must both be at least 1.25 to use this command. Use the docker version command on the client to check your client and daemon API versions.

【API 1.25+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.25 <https://docs.docker.com/engine/api/v1.25/>`_ の必要があります。クライアントとデーモン API のバージョンを調べるには、 ``docker version`` コマンドを使います。


.. _plugin_create-usage:

使い方
==========

.. code-block:: bash

   $ docker plugin create [OPTIONS] PLUGIN PLUGIN-DATA-DIR

.. Extended description
.. _plugin_create-extended-description:

補足説明
==========

.. Creates a plugin. Before creating the plugin, prepare the plugin’s root filesystem as well as the config.json

プラグインを作成します。プラグインを作成する前に、プラグインのルート・ファイルシステムだけでなく、 :doc:`config.json </engine/extend/config>` の準備も必要です。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <plugin_create-examples>` をご覧ください。

.. Options
.. _plugin_create-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--compress``
     - 
     - コンテクストを gzip で圧縮

.. Examples
.. _plugin_create-examples:

使用例
==========

.. The following example shows how to create a sample plugin.

以下の例は、サンプル ``plugin`` を作成する方法を示します。

.. code-block:: bash

   $ ls -ls /home/pluginDir
   
   total 4
   4 -rw-r--r--  1 root root 431 Nov  7 01:40 config.json
   0 drwxr-xr-x 19 root root 420 Nov  7 01:40 rootfs
   
   $ docker plugin create plugin /home/pluginDir
   
   plugin
   
   $ docker plugin ls
   
   ID              NAME            DESCRIPTION                  ENABLED
   672d8144ec02    plugin:latest   A sample plugin for Docker   false

.. The plugin can subsequently be enabled for local use or pushed to the public registry.

以降は、プラグインをローカルで有効化したり、パブリック・レジストリに送信可能になります。

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

   docker plugin create
      https://docs.docker.com/engine/reference/commandline/plugin_create/
