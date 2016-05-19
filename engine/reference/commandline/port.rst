.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/port/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/port.md
   doc version: 1.11
      https://github.com/docker/docker/commits/master/docs/reference/commandline/port.md
.. check date: 2016/04/28
.. Commits on Jan 21, 2016 c2b59b03df364901ce51ee485d60fce7e7aaa955
.. -------------------------------------------------------------------

.. port

=======================================
port
=======================================

.. code-block:: bash

   使い方: docker port [オプション] コンテナ [プライベート・ポート[/プロトコル]]
   
   コンテナに対するマッピング（割り当て）を一覧表示。
   あるいは NAT されたプライベート・ポートを探して表示。
   
     --help          使い方の表示

.. You can find out all the ports mapped by not specifying a PRIVATE_PORT, or just a specific mapping:

``プライベート・ポート`` や、特定の割り当て状況を指定しなければ、全てのポートの割り当て状況（マッピング）を確認できます。

.. code-block:: bash

   $ docker ps
   CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS                                            NAMES
   b650456536c7        busybox:latest      top                 54 minutes ago      Up 54 minutes       0.0.0.0:1234->9876/tcp, 0.0.0.0:4321->7890/tcp   test
   $ docker port test
   7890/tcp -> 0.0.0.0:4321
   9876/tcp -> 0.0.0.0:1234
   $ docker port test 7890/tcp
   0.0.0.0:4321
   $ docker port test 7890/udp
   2014/06/24 11:53:36 Error: No public port '7890/udp' published for test
   $ docker port test 7890
   0.0.0.0:4321

.. seealso:: 

   port
      https://docs.docker.com/engine/reference/commandline/port/

