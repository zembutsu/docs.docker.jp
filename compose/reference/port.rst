.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/port/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/reference/port.md
   doc version: 1.13
      https://github.com/docker/compose/commits/master/docs/reference/port.md
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/compose/reference/port.md
.. check date: 2022/04/08
.. Commits on Jan 28, 2022 b6b19516d0feacd798b485615ebfee410d9b6f86
.. -------------------------------------------------------------------

.. docker-compose port
.. _docker-compose-port:

=======================================
docker-compose port
=======================================

.. code-block:: bash

   使い方: port [オプション] サービス プライベート_ポート
   
   オプション:
   --protocol=proto  tcp or udp [デフォルトｊ: tcp]
   --index=index     サービスに複数のインスタンスがある場合、コンテナのインデックス数 [デフォルト: 1]

.. Prints the public port for a port binding.

ポートを割り当てる公開用のポートを表示します。

.. seealso:: 

   docker-compose port
      https://docs.docker.com/compose/reference/port/
