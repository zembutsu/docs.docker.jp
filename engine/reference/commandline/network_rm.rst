.. -*- coding: utf-8 -*-
.. https://docs.docker.com/engine/reference/commandline/network_rm/
.. doc version: 1.9
.. check date: 2015/12/27
.. -----------------------------------------------------------------------------

.. network ls

=======================================
network rm
=======================================

.. code-block:: bash

   Usage:  docker network rm [OPTIONS] NAME | ID
   
   Deletes a network
   
     --help=false       Print usage

.. Removes a network by name or identifier. To remove a network, you must first disconnect any containers connected to it.

ネットワーク名か ID を指定して削除します。ネットワークを削除するには、接続中の全てのコンテナとの接続を切断しなくてはいけません。

.. code-block:: bash

   $ docker network rm my-network


.. Related information

.. _network-rm-related-information:

関連情報
==========

..    network disconnect
    network connect
    network create
    network ls
    network inspect
    Understand Docker container networks

* :doc:`network disconnect <network_disconnect>`
* :doc:`network connect <network_connect>`
* :doc:`network create <network_create>`
* :doc:`network ls <network_ls>`
* :doc:`network inspect <network_inspect>`
* :doc:`Docker コンテナ・ネットワークの理解 </engine/userguide/networking/dockernetworks>`