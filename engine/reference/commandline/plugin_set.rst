.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/plugin_set/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/plugin_set.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_plugin_set.yaml
.. check date: 2022/04/02
.. Commits on Aug 21, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker plugin set

=======================================
docker plugin set
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Change settings for a plugin

プラグインの設定を変更します。

.. API 1.25+
   Open the 1.25 API reference (in a new window)
   The client and daemon API must both be at least 1.25 to use this command. Use the docker version command on the client to check your client and daemon API versions.

【API 1.25+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.25 <https://docs.docker.com/engine/api/v1.25/>`_ の必要があります。クライアントとデーモン API のバージョンを調べるには、 ``docker version`` コマンドを使います。

.. _plugin_set-usage:

使い方
==========

.. code-block:: bash

   $ docker plugin set PLUGIN KEY=VALUE [KEY=VALUE...]

.. Extended description
.. _plugin_set-extended-description:

補足説明
==========

.. Change settings for a plugin. The plugin must be disabled.

プラグインに対する設定を変更します。プラグインを無効化している必要があります。

.. The settings currently supported are:

現時点では、以下の設定をサポートしています。

..    env variables
    source of mounts
    path of devices
    args

* 環境変数
* マウント元
* デバイスのパス
* 引数

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <plugin_set-examples>` をご覧ください。

.. Examples
.. _plugin_set-examples:

使用例
==========

.. Change an environment variable
.. _plugin_set-change-an-environment-variable:
環境変数を変更
--------------------

.. The following example change the env variable DEBUG on the sample-volume-plugin plugin.

以下の例は ``sample-volume-plugin`` プラグイン上の環境変数 ``DEBUG`` を変更します。

.. code-block:: bash

   $ docker plugin inspect -f {{.Settings.Env}} tiborvass/sample-volume-plugin
   [DEBUG=0]
   
   $ docker plugin set tiborvass/sample-volume-plugin DEBUG=1
   
   $ docker plugin inspect -f {{.Settings.Env}} tiborvass/sample-volume-plugin
   [DEBUG=1]

.. Change the source of a mount
.. _plugin_set-change-the-source-of-a-mount:
プラグインのマウント元を変更
------------------------------

.. The following example change the source of the mymount mount on the myplugin plugin.
以下の例は ``myplugin`` プラグインの ``mymount`` マウント元を変更します。

.. code-block:: bash

   $ docker plugin inspect -f '{{with $mount := index .Settings.Mounts 0}}{{$mount.Source}}{{end}}' myplugin
   /foo
   
   $ docker plugins set myplugin mymount.source=/bar
   
   $ docker plugin inspect -f '{{with $mount := index .Settings.Mounts 0}}{{$mount.Source}}{{end}}' myplugin
   /bar

..     Note
    Since only source is settable in mymount, docker plugins set mymount=/bar myplugin would work too.

.. note::

   唯一の ``source`` のみ ``mymount`` に設定できるように、 ``docker plugins set mymount=/bar myplugin`` も同様の挙動です。

.. Change a device path
.. _plugin_set-change-a-device-path:
デバイスのパスを変更
--------------------

.. The following example change the path of the mydevice device on the myplugin plugin.

以下の例は ``myplugin`` プラグイン上の ``mydevice`` デバイスのパスを変更します。

.. code-block:: bash

   $ docker plugin inspect -f '{{with $device := index .Settings.Devices 0}}{{$device.Path}}{{end}}' myplugin
   
   /dev/foo
   
   $ docker plugins set myplugin mydevice.path=/dev/bar
   
   $ docker plugin inspect -f '{{with $device := index .Settings.Devices 0}}{{$device.Path}}{{end}}' myplugin
   
   /dev/bar

.. Note Since only path is settable in mydevice, docker plugins set mydevice=/dev/bar myplugin would work too.

.. note::

   唯一の ``path`` のみ ``mydevice`` に設定できるように、 ``docker plugins set mydevice=/dev/bar myplugi`` も同様の挙動です。

.. Change the source of the arguments
.. _plugin_set-change-the-source-of-the-argument:
引数のソースを変更
--------------------

.. The following example change the value of the args on the myplugin plugin.

以下の例は ``myplugin`` プラグイン上の、引数の値を変更します。

.. code-block:: bash

   $ docker plugin inspect -f '{{.Settings.Args}}' myplugin
   
   ["foo", "bar"]
   
   $ docker plugins set myplugin myargs="foo bar baz"
   
   $ docker plugin inspect -f '{{.Settings.Args}}' myplugin
   
   ["foo", "bar", "baz"]


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

   docker plugin set
      https://docs.docker.com/engine/reference/commandline/plugin_set/

