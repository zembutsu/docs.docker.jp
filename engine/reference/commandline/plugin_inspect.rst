.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/plugin_inspect/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/plugin_inspect.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_plugin_inspect.yaml
.. check date: 2022/04/02
.. Commits on Aug 21, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker plugin inspect

=======================================
docker plugin inspect
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Display detailed information on one or more plugins

1つまたは複数プラグインの詳細情報を表示します。

.. API 1.25+
   Open the 1.25 API reference (in a new window)
   The client and daemon API must both be at least 1.25 to use this command. Use the docker version command on the client to check your client and daemon API versions.

【API 1.25+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.25 <https://docs.docker.com/engine/api/v1.25/>`_ の必要があります。クライアントとデーモン API のバージョンを調べるには、 ``docker version`` コマンドを使います。


.. _plugin_inspect-usage:

使い方
==========

.. code-block:: bash

   $ docker plugin enable [OPTIONS] PLUGINｌ

.. Extended description
.. _plugin_inspect-extended-description:

補足説明
==========

..   Returns information about a plugin. By default, this command renders all results in a JSON array.

プラグインに関する情報を返します。デフォルトでは JSON アレイとしてコマンドの実行結果を表示します。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <plugin_inspect-examples>` をご覧ください。

.. Options
.. _plugin_inspect-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--format`` , ``-f``
     - 
     - 指定した Go テンプレートを使って出力を整形

.. Examples
.. _plugin_inspect-examples:

使用例
==========

.. Inspect a plugin
.. _plugin_inspect-inspect-a-plugin:
プラグインを調査
--------------------

.. The following example example inspects the tiborvass/sample-volume-plugin plugin:

以下は ``tiborvass/sample-volume-plugin`` プラグインを調査する例です。

.. code-block:: bash

   $ docker plugin inspect tiborvass/sample-volume-plugin:latest

.. Output is in JSON format (output below is formatted for readability):

出力は JSON 形式です（以下の出力は読みやすいように整形）。

.. code-block:: json

   {
     "Id": "8c74c978c434745c3ade82f1bc0acf38d04990eaf494fa507c16d9f1daa99c21",
     "Name": "tiborvass/sample-volume-plugin:latest",
     "PluginReference": "tiborvas/sample-volume-plugin:latest",
     "Enabled": true,
     "Config": {
       "Mounts": [
         {
           "Name": "",
           "Description": "",
           "Settable": null,
           "Source": "/data",
           "Destination": "/data",
           "Type": "bind",
           "Options": [
             "shared",
             "rbind"
           ]
         },
         {
           "Name": "",
           "Description": "",
           "Settable": null,
           "Source": null,
           "Destination": "/foobar",
           "Type": "tmpfs",
           "Options": null
         }
       ],
       "Env": [
         "DEBUG=1"
       ],
       "Args": null,
       "Devices": null
     },
     "Manifest": {
       "ManifestVersion": "v0",
       "Description": "A test plugin for Docker",
       "Documentation": "https://docs.docker.com/engine/extend/plugins/",
       "Interface": {
         "Types": [
           "docker.volumedriver/1.0"
         ],
         "Socket": "plugins.sock"
       },
       "Entrypoint": [
         "plugin-sample-volume-plugin",
         "/data"
       ],
       "Workdir": "",
       "User": {
       },
       "Network": {
         "Type": "host"
       },
       "Capabilities": null,
       "Mounts": [
         {
           "Name": "",
           "Description": "",
           "Settable": null,
           "Source": "/data",
           "Destination": "/data",
           "Type": "bind",
           "Options": [
             "shared",
             "rbind"
           ]
         },
         {
           "Name": "",
           "Description": "",
           "Settable": null,
           "Source": null,
           "Destination": "/foobar",
           "Type": "tmpfs",
           "Options": null
         }
       ],
       "Devices": [
         {
           "Name": "device",
           "Description": "a host device to mount",
           "Settable": null,
           "Path": "/dev/cpu_dma_latency"
         }
       ],
       "Env": [
         {
           "Name": "DEBUG",
           "Description": "If set, prints debug messages",
           "Settable": null,
           "Value": "1"
         }
       ],
       "Args": {
         "Name": "args",
         "Description": "command line arguments",
         "Settable": null,
         "Value": [
         ]
       }
     }
   }


.. Formatting the output
.. _plugin_inspect-formatting-the-output:
出力の整形
----------

.. code-block:: bash

   $ docker plugin inspect -f '{{.Id}}' tiborvass/sample-volume-plugin:latest
   
   8c74c978c434745c3ade82f1bc0acf38d04990eaf494fa507c16d9f1daa99c21

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

   docker plugin inspect
      https://docs.docker.com/engine/reference/commandline/plugin_inspect/

