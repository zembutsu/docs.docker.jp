.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/machine/reference/ip/
.. SOURCE: https://github.com/docker/machine/blob/master/docs/reference/ip.md
   doc version: 1.10
      https://github.com/docker/machine/commits/master/docs/reference/ip.md
.. check date: 2016/03/09
.. Commits on Nov 27, 2015 68e6e3f905856bc1d93cb5c1e99cc3b3ac900022
.. ----------------------------------------------------------------------------

.. ip

.. _machine-ip:

=======================================
ip
=======================================

.. Get the IP address of one or more machines.

１つまたは複数マシンの IP アドレスを表示します。

.. code-block:: bash

   $ docker-machine ip dev
   192.168.99.104
   $ docker-machine ip dev dev2
   192.168.99.104
   192.168.99.105

.. seealso:: 

   ip
      https://docs.docker.com/machine/reference/ip/

