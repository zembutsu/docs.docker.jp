.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/plugin/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/plugin.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_plugin.yaml
.. check date: 2022/03/29
.. Commits on Mar 22, 2018 cb157b3318eac0a652a629ea002778ca3d8fa703
.. -------------------------------------------------------------------

.. docker plugin

=======================================
docker plugin
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _plugin-description:

説明
==========

.. Manage plugins

プラグインを管理します。

.. API 1.25+
   Open the 1.25 API reference (in a new window)
   The client and daemon API must both be at least 1.25 to use this command. Use the docker version command on the client to check your client and daemon API versions.

【API 1.25+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.25 <https://docs.docker.com/engine/api/v1.25/>`_ の必要があります。クライアントとデーモン API のバージョンを調べるには、 ``docker version`` コマンドを使います。


.. _plugin-usage:

使い方
==========

.. code-block:: bash

   $ docker plugin COMMAND

.. Extended description
.. _plugin-extended-description:

補足説明
==========

.. Manage plugins.

プラグインを管理します。


.. Parent command

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI のベースコマンド。


.. Child commands

子コマンド
==========

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
   * - :doc:`docker plugin push<plugin_push>`
     - プラグインをレジストリに送信
   * - :doc:`docker plugin rm<plugin_rm>`
     - 1つまたは複数プラグインを削除
   * - :doc:`docker plugin set<plugin_set>`
     - プラグインの設定を変更
   * - :doc:`docker plugin upgrade<plugin_upgrade>`
     - 既存のプラグインを更新


.. seealso:: 

   docker plugin
      https://docs.docker.com/engine/reference/commandline/plugin/
