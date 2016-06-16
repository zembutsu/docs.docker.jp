.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/node_promote/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/node_promote.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/node_promote.md
.. check date: 2016/06/16
.. Commits on Jun 14, 2016 9acf97b72a4d5ff7b1bcad36fb19b53775f01596
.. -------------------------------------------------------------------

.. node promote

=======================================
node promote
=======================================

.. code-block:: bash

   使い方:  docker node promote NODE [NODE...]
   
   swarm 上のノードをマネージャに昇格

.. Promotes a node that is pending a promotion to manager. This command targets a docker engine that is a manager in the swarm cluster.

マネージャへの昇格を保留しているノードを昇格（promote）します。このコマンドは swarm クラスタのマネージャとして動いている docker engine 用です。

.. code-block:: bash

   $ docker node promote <ノード名>

.. Related information

関連情報
----------

* :doc:`node_accept`
* :doc:`node_demote`

.. seealso:: 

   node promote
      https://docs.docker.com/engine/reference/commandline/node_promote/

