.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/plugin_rm/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/plugin_rm.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_plugin_rm.yaml
.. check date: 2022/04/02
.. Commits on Aug 21, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker plugin rm

=======================================
docker plugin rm
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Remove one or more plugins

 1つまたは複数のプラグインを削除します。

.. API 1.25+
   Open the 1.25 API reference (in a new window)
   The client and daemon API must both be at least 1.25 to use this command. Use the docker version command on the client to check your client and daemon API versions.

【API 1.25+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.25 <https://docs.docker.com/engine/api/v1.25/>`_ の必要があります。クライアントとデーモン API のバージョンを調べるには、 ``docker version`` コマンドを使います。

.. _plugin_rm-usage:

使い方
==========

.. code-block:: bash

   $ docker plugin rm [OPTIONS] PLUGIN [PLUGIN...]

.. Extended description
.. _plugin_rm-extended-description:

補足説明
==========

.. Removes a plugin. You cannot remove a plugin if it is enabled, you must disable a plugin using the docker plugin disable before removing it (or use --force, use of force is not recommended, since it can affect functioning of running containers using the plugin).

.. Removes a plugin. You cannot remove a plugin if it is active, you must disable a plugin using the docker plugin disable before removing it.

プラグインを削除します。アクティブなプラグインは削除できません。プラグインを削除するには、事前に :doc:`docker plugin disable <plugin_disable>` で無効化します（あるいは ``--force`` を使えますが推奨されていません。実行後、対象のプラグインを使用している実行中のコンテナに影響が出るためです ）。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <plugin_rm-examples>` をご覧ください。

.. Options
.. _plugin_rm-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--force`` , ``-f``
     - 
     - アクティブなプラグインを強制的に削除

.. Examples
.. _plugin_rm-examples:

使用例
==========

The following example disables and removes the sample-volume-plugin:latest plugin:

以下は ``sample-volume-plugin:latest`` プラグインを無効化して、削除する例です。

.. code-block:: bash

   $ docker plugin disable tiborvass/sample-volume-plugin
   
   tiborvass/sample-volume-plugin
   
   $ docker plugin rm tiborvass/sample-volume-plugin:latest
   
   tiborvass/sample-volume-plugin



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

   docker plugin rm
      https://docs.docker.com/engine/reference/commandline/plugin_rm/

