.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/plugin_rm/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/plugin_rm.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/plugin_rm.md
.. check date: 2016/06/16
.. Commits on Jun 15, 2016 e79873c27c2b3f404db02682bb4f11b5a046602e
.. -------------------------------------------------------------------

.. plugin rm

=======================================
plugin rm (実験的)
=======================================

.. code-block:: bash

   使い方: docker plugin rm PLUGIN
   
   プラグイン一覧
   
     --help   使い方の表示
   
   エイリアス:
     rm, remove

.. Removes a plugin. You cannot remove a plugin if it is active, you must disable a plugin using the docker plugin disable before removing it.

プラグインを削除します。アクティブなプラグインは削除できません。プラグインを削除するには、事前に :doc:`docker plugin disable <plugin_disable>` で無効化します。

.. The following example disables and removes the no-remove:latest plugin;

以下は ``no-remove:latest`` プラグインを無効化して、削除する例です。

.. code-block:: bash

   $ docker plugin disable tiborvass/no-remove:latest
   $ docker plugin rm tiborvass/no-remove:latest
   no-remove:latest

関連情報
----------

* :doc:`plugin_ls`
* :doc:`plugin_enable`
* :doc:`plugin_disable`
* :doc:`plugin_inspect`
* :doc:`plugin_install`

.. seealso:: 

   plugin rm
      https://docs.docker.com/engine/reference/commandline/plugin_rm/

