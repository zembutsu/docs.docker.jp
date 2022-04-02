.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/plugin_disable/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/plugin_disable.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_plugin_disable.yaml
.. check date: 2022/03/29
.. Commits on Aug 21, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker plugin disable

=======================================
docker plugin disable
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:


.. Disable plugin

プラグインを無効化します。

.. API 1.25+
   Open the 1.25 API reference (in a new window)
   The client and daemon API must both be at least 1.25 to use this command. Use the docker version command on the client to check your client and daemon API versions.

【API 1.25+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.25 <https://docs.docker.com/engine/api/v1.25/>`_ の必要があります。クライアントとデーモン API のバージョンを調べるには、 ``docker version`` コマンドを使います。


.. _plugin_disable-usage:

使い方
==========

.. code-block:: bash

   $ docker plugin disable [OPTIONS] PLUGINｌ

.. Extended description
.. _plugin_disable-extended-description:

補足説明
==========

.. Disables a plugin. The plugin must be installed before it can be disabled, see docker plugin install. Without the -f option, a plugin that has references (e.g., volumes, networks) cannot be disabled.

プラグインを無効化します。プラグインは無効化する前にインストールされている必要があります。 :doc:`docker plugin install <plugin_install>` をご覧ください。 ``-f`` オプションを付けない場合、プラグインを参照しているもの（例：ボリューム、ネットワーク）があれば、無効化できません。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <plugin_disable-examples>` をご覧ください。

.. Options
.. _plugin_disable-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--force`` , ``-f``
     - 
     - アクティブなプラグインを強制的に無効化

.. Examples
.. _plugin_disable-examples:

使用例
==========

.. The following example shows that the sample-volume-plugin plugin is installed and enabled:


.. The following example shows that the no-remove plugin is currently installed and active:

	以下の例は ``sample-volume-plugin`` プラグインがインストール済みで、かつ、有効化されています。

.. code-block:: bash

   $ docker plugin ls
   
   ID            NAME                                    DESCRIPTION                ENABLED
   69553ca1d123  tiborvass/sample-volume-plugin:latest   A test plugin for Docker   true


.. To disable the plugin, use the following command:

このプラグインを無効化するには、次のコマンドを実行します。

.. code-block:: bash

   $ docker plugin disable tiborvass/sample-volume-plugin
   
   tiborvass/sample-volume-plugin
   
   $ docker plugin ls
   
   ID            NAME                                    DESCRIPTION                ENABLED
   69553ca1d123  tiborvass/sample-volume-plugin:latest   A test plugin for Docker   false

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

   docker plugin disable
      https://docs.docker.com/engine/reference/commandline/plugin_disable/

