.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/plugin_install/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/plugin_install.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/plugin_install.md
.. check date: 2016/06/16
.. Commits on Jun 15, 2016 e79873c27c2b3f404db02682bb4f11b5a046602e
.. -------------------------------------------------------------------

.. plugin install

=======================================
plugin install (実験的)
=======================================

.. code-block:: bash

   使い方: docker plugin install PLUGIN
   
   プラグインのインストール
   
     --help             使い方の表示

.. Installs and enables a plugin. Docker looks first for the plugin on your Docker host. If the plugin does not exist locally, then the plugin is pulled from Docker Hub.

プラグインのインストールと有効化をします。Docker は Docker ホスト上のプラグインを第一に探します。プラグインがローカルに存在しなければ、 Docker Hub から取得します。

.. The following example installs no-remove plugin. Install consists of pulling the plugin from Docker Hub, prompting the user to accept the list of privileges that the plugin needs and enabling the plugin.

以下は ``no-remove`` プラグインをインストールする例です。インストールでは、Docker Hub からのプラグインのダウンロードを介在します。プラグインのインストールを有効化のためには、ユーザ特権を必要とします。

.. code-block:: bash

   $ docker plugin install tiborvass/no-remove
   Plugin "tiborvass/no-remove:latest" requested the following privileges:
    - Networking: host
    - Mounting host path: /data
   Do you grant the above permissions? [y/N] y

.. After the plugin is installed, it appears in the list of plugins:

プラグインのインストール後は、プラグイン一覧に表示されます。

.. code-block:: bash

   $ docker plugin ls
   NAME                    VERSION             ACTIVE
   tiborvass/no-remove   latest              true

関連情報
----------

* :doc:`plugin_ls`
* :doc:`plugin_enable`
* :doc:`plugin_disable`
* :doc:`plugin_install`
* :doc:`plugin_rm`

.. seealso:: 

   plugin install
      https://docs.docker.com/engine/reference/commandline/plugin_install/

