.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/port/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/reference/port.md
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/reference/port.md
.. check date: 2016/04/28
.. Commits on Aug 25, 2015 59d4f304ee3bf4bb20ba0f5e0ad6c4a3ff1568f3
.. -------------------------------------------------------------------

.. port

.. _compose-port:

=======================================
port
=======================================

.. code-block:: bash

   使い方: port [オプション] サービス プライベート_ポート
   
   オプション:
   --protocol=proto  tcp or udp [デフォルトｊ: tcp]
   --index=index     サービスに複数のインスタンスがある場合、コンテナのインデックス数 [デフォルト: 1]

.. Prints the public port for a port binding.

ポートを割り当てる公開用のポートを表示します。

.. seealso:: 

   port
      https://docs.docker.com/compose/reference/port/
