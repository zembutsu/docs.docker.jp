.. -*- coding: utf-8 -*-
.. https://docs.docker.com/compose/reference/port/
.. doc version: 1.9
.. check date: 2016/01/25
.. -----------------------------------------------------------------------------

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

