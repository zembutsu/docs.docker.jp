.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/plugin_enable/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/plugin_enable.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/plugin_enable.md
.. check date: 2016/06/16
.. Commits on Jun 15, 2016 e79873c27c2b3f404db02682bb4f11b5a046602e
.. -------------------------------------------------------------------

.. plugin enable

=======================================
plugin enable (実験的)
=======================================

.. code-block:: bash

   使い方: docker plugin enable PLUGIN
   
   プラグインを有効化
   
     --help             使い方の表示

.. Enables a plugin. The plugin must be installed before it can be enabled, see docker plugin install.

プラグインを有効化します。宇高にするプラグインをインストールしている必要があります。詳しくは :doc:`docker plugin install <plugin_install>` をご覧ください。

.. The following example shows that the no-remove plugin is currently installed, but disabled ("inactive"):

以下の例は ``no-remove`` がインストール済みですが、無効（"inactive"）な状態です。

.. code-block:: bash

   $ docker plugin ls
   NAME                        TAG         ACTIVE
   tiborvass/no-remove     latest      false

.. To enable the plugin, use the following command:

プラグインを有効にするには、次のコマンドを実行します。

.. code-block:: bash

   $ docker plugin enable tiborvass/no-remove:latest

.. After the plugin is enabled, it appears as "inactive" in the list of plugins:

プラグインの有効後は、プラグインの一覧で「active」（動作中）と表示されます。

.. code-block:: bash

   $ docker plugin ls
   NAME            VERSION     ACTIVE
   tiborvass/no-remove latest      true

関連情報
----------

* :doc:`plugin_ls`
* :doc:`plugin_disable`
* :doc:`plugin_inspect`
* :doc:`plugin_install`
* :doc:`plugin_rm`

.. seealso:: 

   plugin enable
      https://docs.docker.com/engine/reference/commandline/plugin_enable/

