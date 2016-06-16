.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/plugin_ls/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/plugin_ls.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/plugin_ls.md
.. check date: 2016/06/16
.. Commits on Jun 15, 2016 e79873c27c2b3f404db02682bb4f11b5a046602e
.. -------------------------------------------------------------------

.. plugin ls

=======================================
plugin ls (実験的)
=======================================

.. code-block:: bash

   使い方: docker plugin ls
   
   プラグイン一覧
   
     --help   使い方の表示
   
   エイリアス:
     ls, list

.. Lists all the plugins that are currently installed. You can install plugins using the docker plugin install command.

インストール済みの全てのプラグインを表示します。 :doc:`docker plugin install <plugin_install>` コマンドでプラグインをインストールできます。

.. Example output:

出力例：

.. code-block:: bash

   $ docker plugin ls
   NAME                    VERSION             ACTIVE
   tiborvass/no-remove latest              true

関連情報
----------

* :doc:`plugin_enable`
* :doc:`plugin_disable`
* :doc:`plugin_inspect`
* :doc:`plugin_install`
* :doc:`plugin_rm`

.. seealso:: 

   plugin ls
      https://docs.docker.com/engine/reference/commandline/plugin_ls/

