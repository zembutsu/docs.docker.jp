.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/plugin_inspect/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/plugin_inspect.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/plugin_inspect.md
.. check date: 2016/06/16
.. Commits on Jun 15, 2016 e79873c27c2b3f404db02682bb4f11b5a046602e
.. -------------------------------------------------------------------

.. plugin inspect

=======================================
plugin inspect (実験的)
=======================================

.. code-block:: bash

   使い方: docker plugin inspect PLUGIN
   
   プラグインに関する低レベルの情報を返す
   
     --help              使い方の表示
   
..   Returns information about a plugin. By default, this command renders all results in a JSON array.

プラグインに関する情報を返します。デフォルトでは JSON アレイとしてコマンドの実行結果を表示します。

.. Example output:

出力例：

.. code-block:: bash

   $ docker plugin inspect tiborvass/no-remove:latest
   
   {
       "Manifest": {
           "ManifestVersion": "",
           "Description": "A test plugin for Docker",
           "Documentation": "https://docs.docker.com/engine/extend/plugins/",
           "Entrypoint": [
               "plugin-no-remove",
               "/data"
           ],
           "Interface": {
               "Types": [
                   "docker.volumedriver/1.0"
               ],
               "Socket": "plugins.sock"
           },
           "Network": {
               "Type": "host"
           },
           "Capabilities": null,
           "Mounts": [
               {
                   "Name": "",
                   "Description": "",
                   "Settable": false,
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
                   "Settable": false,
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
                   "Settable": false,
                   "Path": null
               }
           ],
           "Env": [
               {
                   "Name": "DEBUG",
                   "Description": "If set, prints debug messages",
                   "Settable": false,
                   "Value": null
               }
           ],
           "Args": [
               {
                   "Name": "arg1",
                   "Description": "a command line argument",
                   "Settable": false,
                   "Value": null
               }
           ]
       },
       "Config": {
           "Mounts": [
               {
                   "Source": "/data",
                   "Destination": "/data",
                   "Type": "bind",
                   "Options": [
                       "shared",
                       "rbind"
                   ]
               },
               {
                   "Source": null,
                   "Destination": "/foobar",
                   "Type": "tmpfs",
                   "Options": null
               }
           ],
           "Env": [],
           "Args": [],
           "Devices": null
       },
       "Active": true,
       "Name": "tiborvass/no-remove",
       "Tag": "latest",
       "ID": "ac9d36b664921d61813254f7e9946f10e3cadbb676346539f1705fcaf039c01f"
   }

 
.. (output formatted for readability)

（読みやすくするため、出力を整形）

関連情報
----------

* :doc:`plugin_ls`
* :doc:`plugin_enable`
* :doc:`plugin_disable`
* :doc:`plugin_install`
* :doc:`plugin_rm`

.. seealso:: 

   plugin inspect
      https://docs.docker.com/engine/reference/commandline/plugin_inspect/

