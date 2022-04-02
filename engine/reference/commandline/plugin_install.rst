.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/plugin_install/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/plugin_install.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_plugin_install.yaml
.. check date: 2022/04/02
.. Commits on Aug 21, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker plugin install

=======================================
docker plugin install
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:


.. Install a plugin

プラグインをインストールします。

.. API 1.25+
   Open the 1.25 API reference (in a new window)
   The client and daemon API must both be at least 1.25 to use this command. Use the docker version command on the client to check your client and daemon API versions.

【API 1.25+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.25 <https://docs.docker.com/engine/api/v1.25/>`_ の必要があります。クライアントとデーモン API のバージョンを調べるには、 ``docker version`` コマンドを使います。


.. _plugin_install-usage:

使い方
==========

.. code-block:: bash

   $ docker plugin install [OPTIONS] PLUGIN [KEY=VALUE...]

.. Extended description
.. _plugin_install-extended-description:

補足説明
==========

.. Installs and enables a plugin. Docker looks first for the plugin on your Docker host. If the plugin does not exist locally, then the plugin is pulled from the registry. Note that the minimum required registry version to distribute plugins is 2.3.0

プラグインのインストールと有効化をします。Docker は、まず Docker ホスト上のプラグインを探します。プラグインがローカルに存在しなければ、レジストリから取得します。レジストリの distribute plugins 最小バージョンは、 2.3.0 の必要があります。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <plugin_install-examples>` をご覧ください。

.. Options
.. _plugin_install-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--alias``
     - 
     - プラグインのローカル名
   * - ``--disable``
     - 
     - インストールするプラグインを有効化しない
   * - ``--disable-content-trust``
     - ``true``
     - イメージの検証を省略
   * - ``--grant-all-permissions``
     - 
     - プラグインを実行するために必要な、全ての権限を与える

.. Examples
.. _plugin_inspect-examples:

使用例
==========

.. The following example installs vieus/sshfs plugin and sets its DEBUG environment variable to 1. To install, pull the plugin from Docker Hub and prompt the user to accept the list of privileges that the plugin needs, set the plugin’s parameters and enable the plugin.

以下の例は ``viens/sshfs`` プラグインをインストールし、その ``DEBUG`` 環境変数を ``1`` に :doc:`設定 <plugin_set>` します。インストールするには、Docker Hub からプラグインを ``pull`` し、プラグインが必要とする特権一覧をプロンプトで許可し、プラグインのパラメータを設定し、プラグインを有効化します。

.. code-block:: bash

   $ docker plugin install vieux/sshfs DEBUG=1
   
   Plugin "vieux/sshfs" is requesting the following privileges:
    - network: [host]
    - device: [/dev/fuse]
    - capabilities: [CAP_SYS_ADMIN]
   Do you grant the above permissions? [y/N] y
   vieux/sshfs

.. After the plugin is installed, it appears in the list of plugins:

プラグインをインストールしたら、プラグイン一覧に表示されます。

.. code-block:: bash

   $ docker plugin ls
   
   ID             NAME                  DESCRIPTION                ENABLED
   69553ca1d123   vieux/sshfs:latest    sshFS plugin for Docker    true


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

   docker plugin install
      https://docs.docker.com/engine/reference/commandline/plugin_install/

