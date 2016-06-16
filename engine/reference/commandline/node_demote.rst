.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/node_demote/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/node_demote.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/node_demote.md
.. check date: 2016/06/16
.. Commits on Jun 15, 2016 c21f8613275ca546b1310999d8714ff2609f33e3
.. -------------------------------------------------------------------

.. node demote

=======================================
node demote
=======================================

.. code-block:: bash

   使い方:  docker node demote NODE [NODE...]
   
   swarm 上のマネージャ・ノードを降格

.. Demotes an existing Manager so that it is no longer a manager. This command targets a docker engine that is a manager in the swarm cluster.

既存のマネージャを降格（demote）しますので、マネージャではなくなります。このコマンドは swarm クラスタのマネージャとして動いている docker engine 用です。

.. code-block:: bash

   $ docker node demote <ノード名>

.. Related information

関連情報
----------

* :doc:`node_accept`
* :doc:`node_promote`

.. seealso:: 

   node demote
      https://docs.docker.com/engine/reference/commandline/node_demote/

