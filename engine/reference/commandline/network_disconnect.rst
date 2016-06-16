.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/network_disconnect/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/network_disconnect.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/network_disconnect.md
.. Commits on Jan 14, 2016 b464f1d78cdfa2a4124e083b8f7b0f2353f12de3
.. -------------------------------------------------------------------

.. network disconnect

=======================================
network disconnect
=======================================

.. code-block:: bash

   使い方:  docker network disconnect [オプション] ネットワーク コンテナ
   
   ネットワークからコンテナを切断
   
     -f, --force        ネットワークからコンテナを強制切断
     --help             使い方の表示

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

.. seealso:: 

   network disconnect
      https://docs.docker.com/engine/reference/commandline/network_disconnect/


