.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/node_accept/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/node_accept.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/node_accept.md
.. check date: 2016/06/16
.. Commits on Jun 15, 2016 c21f8613275ca546b1310999d8714ff2609f33e3
.. -------------------------------------------------------------------

.. node accept

=======================================
node accept
=======================================

.. code-block:: bash

   使い方:  docker node accept NODE [NODE...]
   
   swarm で受け入れるノード

.. Accept a node into the swarm. This command targets a docker engine that is a manager in the swarm cluster.

swarm にノードを受け入れます。このコマンドは swarm クラスタのマネージャとして動いている docker engine 用です。

.. code-block:: bash

   $ docker node accept <node name>

.. Related information

関連情報
----------

* :doc:`node_promote`
* :doc:`node_demote`

.. seealso:: 

   node accept
      https://docs.docker.com/engine/reference/commandline/node_accept/

