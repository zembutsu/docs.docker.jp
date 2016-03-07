.. *- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/port/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/reference/port.md
   doc version: 1.10
      https://github.com/docker/compose/commits/master/docs/reference/port.md
.. check date: 2016/03/07
.. Commits on Aug 25, 2015 59d4f304ee3bf4bb20ba0f5e0ad6c4a3ff1568f3
.. -------------------------------------------------------------------

.. port

.. _compse-port:

=======================================
port
=======================================

.. code-block:: bash

   Usage: port [options] SERVICE PRIVATE_PORT
   
   Options:
   --protocol=proto  tcp or udp [default: tcp]
   --index=index     index of the container if there are multiple
                     instances of a service [default: 1]

.. Prints the public port for a port binding.

ポートを割り当てる公開用のポートを表示します。

