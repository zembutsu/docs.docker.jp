.. -*- coding: utf-8 -*-
.. https://docs.docker.com/engine/reference/commandline/network_disconnect/
.. doc version: 1.9
.. check date: 2015/12/27
.. -----------------------------------------------------------------------------

.. network disconnect

=======================================
network disconnect
=======================================

.. code-block:: bash

   Usage:  docker network disconnect [OPTIONS] NETWORK CONTAINER
   
   Disconnects a container from a network
   
     --help=false       Print usage

.. Disconnects a container from a network. The container must be running to disconnect it from the network.

コンテナをネットワークから切り離します（disconnect）。ネットワークから切り離すためには、コンテナを実行している必要があります。

.. code-block:: bash

   $ docker network disconnect multi-host-network container1

.. Related information

.. _network-disconnect-related-information:

関連情報
==========

..    network inspect
    network connect
    network create
    network ls
    network rm
    Understand Docker container networks

* :doc:`network inspect <network_inspect>`
* :doc:`network connect <network_connect>`
* :doc:`network create <network_create>`
* :doc:`network ls <network_ls>`
* :doc:`network rm <network_rm>`
* :doc:`Docker コンテナ・ネットワークの理解 </engine/userguide/networking/dockernetworks>`



