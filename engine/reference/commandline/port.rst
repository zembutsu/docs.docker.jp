.. *- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/port/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/port.md
   doc version: 1.10
      https://github.com/docker/docker/commits/master/docs/reference/commandline/port.md
.. check date: 2016/02/25
.. Commits on Jan 21, 2016 c2b59b03df364901ce51ee485d60fce7e7aaa955
.. -------------------------------------------------------------------

.. port

=======================================
port
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. code-block:: bash

   Usage: docker port [OPTIONS] CONTAINER [PRIVATE_PORT[/PROTO]]
   
   List port mappings for the CONTAINER, or lookup the public-facing port that is
   NAT-ed to the PRIVATE_PORT
   
     --help          Print usage

.. You can find out all the ports mapped by not specifying a PRIVATE_PORT, or just a specific mapping:

``PRIVATE_PORT`` や、特定の割り当て状況を指定しなければ、全てのポートの割り当て状況（マッピング）を確認できます。

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

