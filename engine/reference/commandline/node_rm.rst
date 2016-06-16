.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/node_rm/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/node_rm.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/node_rm.md
.. check date: 2016/06/16
.. Commits on Jun 14, 2016 9acf97b72a4d5ff7b1bcad36fb19b53775f01596
.. -------------------------------------------------------------------

.. Warning: this command is part of the Swarm management feature introduced in Docker 1.12, and might be subject to non backward-compatible changes.

.. warning::

  このコマンドは Docker 1.12 で導入された Swarm 管理機能の一部です。それと、変更は下位互換性を考慮していない可能性があります。

.. node rm

=======================================
node rm
=======================================

.. code-block:: bash

   使い方:  docker node rm NODE [NODE...]
   
   swarm からノードを削除
   
   エイリアス:
     rm, remove
   
   オプション:
         --help   使い方の表示

.. Removes nodes that are specified.

指定したノードを削除します。

.. Example output:

出力例：

.. code-block:: bash

   $ docker node rm swarm-node-02
   Node swarm-node-02 removed from Swarm

.. Related information

関連情報
----------

* :doc:`node_inspect`
* :doc:`node_update`
* :doc:`node_tasks`
* :doc:`node_ls`

.. seearmo:: 

   node rm
      https://docs.docker.com/engine/reference/commandline/node_rm/

