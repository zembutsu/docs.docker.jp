.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/plugin_disable/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/plugin_disable.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/plugin_disable.md
.. check date: 2016/06/16
.. Commits on Jun 15, 2016 e79873c27c2b3f404db02682bb4f11b5a046602e
.. -------------------------------------------------------------------

.. plugin disable

=======================================
plugin disable (実験的)
=======================================

.. code-block:: bash

   使い方: docker plugin disable PLUGIN
   
   プラグインを無効化
   
     --help             使い方の表示

.. Disables a plugin. The plugin must be installed before it can be disabled, see docker plugin install.

プラグインを無効化します。無効にするプラグインをインストールしている必要があります。詳しくは :doc:`docker plugin install <plugin_install>` をご覧ください。

.. The following example shows that the no-remove plugin is currently installed and active:

以下の例は ``no-remove`` がインストール済みかつアクティブな状態を表します。

.. code-block:: bash

   $ docker plugin ls
   NAME                        TAG         ACTIVE
   tiborvass/no-remove     latest      true

.. To disable the plugin, use the following command:

プラグインを無効化するには、次のコマンドを実行します。

.. code-block:: bash

   $ docker plugin disable tiborvass/no-remove:latest

.. After the plugin is disabled, it appears as "inactive" in the list of plugins:

プラグインの無効後は、プラグインの一覧で「inactive」（動作していない）と表示されます。

.. code-block:: bash

   $ docker plugin ls
   NAME            VERSION     ACTIVE
   tiborvass/no-remove latest      false

関連情報
----------

* :doc:`plugin_ls`
* :doc:`plugin_enable`
* :doc:`plugin_inspect`
* :doc:`plugin_install`
* :doc:`plugin_rm`

.. seealso:: 

   plugin disable
      https://docs.docker.com/engine/reference/commandline/plugin_disable/

