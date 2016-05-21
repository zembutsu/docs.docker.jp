.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/machine/reference/config/
.. SOURCE: https://github.com/docker/machine/blob/master/docs/reference/config.md
   doc version: 1.11
      https://github.com/docker/machine/commits/master/docs/reference/config.md
.. check date: 2016/04/28
.. Commits on Feb 21, 2016 d7e97d04436601da26d24b199532652abe78770e
.. ----------------------------------------------------------------------------

.. config

.. _machine-config:

=======================================
config
=======================================

.. Show the Docker client configuration for a machine.

対象マシンに対する Docker クライアントの設定を表示します。

.. code-block:: bash

   使い方: docker-machine config [オプション] [引数...]
   
   マシンに接続する設定を表示
   
   説明:
      引数はマシン名。
   
   オプション:
   
      --swarm      Docker デーモンの代わりに Swarm 設定を表示

実行例：

.. code-block:: bash

   $ docker-machine config dev
   --tlsverify
   --tlscacert="/Users/ehazlett/.docker/machines/dev/ca.pem"
   --tlscert="/Users/ehazlett/.docker/machines/dev/cert.pem"
   --tlskey="/Users/ehazlett/.docker/machines/dev/key.pem"
   -H tcp://192.168.99.103:2376

.. seealso:: 

   config
      https://docs.docker.com/machine/reference/config/
