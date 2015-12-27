.. -*- coding: utf-8 -*-
.. https://docs.docker.com/engine/reference/commandline/network_inspect/
.. doc version: 1.9
.. check date: 2015/12/27
.. -----------------------------------------------------------------------------

.. network inspect

=======================================
network inspect
=======================================

.. code-block:: bash

   Usage:  docker network inspect [OPTIONS] NETWORK [NETWORK..]
   
   Displays detailed information on a network
   
     --help=false       Print usage

.. Returns information about one or more networks. By default, this command renders all results in a JSON object. For example, if you connect two containers to a network:

１つまたは複数のネットワークの情報を返します。デフォルトでは、このコマンドは結果を JSON オブジェクト形式で返します。例えば、２つのコンテナをネットワークに接続します。

.. code-block:: bash

   $ sudo docker run -itd --name=container1 busybox
   f2870c98fd504370fb86e59f32cd0753b1ac9b69b7d80566ffc7192a82b3ed27
   
   $ sudo docker run -itd --name=container2 busybox
   bda12f8922785d1f160be70736f26c1e331ab8aaf8ed8d56728508f2e2fd4727

.. The network inspect command shows the containers, by id, in its results.

``network inspect`` コマンドで、その結果からコンテナの情報を確認します。

.. code-block:: bash

   $ sudo docker network inspect bridge
   [
     {
         "name": "bridge",
         "id": "7fca4eb8c647e57e9d46c32714271e0c3f8bf8d17d346629e2820547b2d90039",
         "driver": "bridge",
         "containers": {
             "bda12f8922785d1f160be70736f26c1e331ab8aaf8ed8d56728508f2e2fd4727": {
                 "endpoint": "e0ac95934f803d7e36384a2029b8d1eeb56cb88727aa2e8b7edfeebaa6dfd758",
                 "mac_address": "02:42:ac:11:00:03",
                 "ipv4_address": "172.17.0.3/16",
                 "ipv6_address": ""
             },
             "f2870c98fd504370fb86e59f32cd0753b1ac9b69b7d80566ffc7192a82b3ed27": {
                 "endpoint": "31de280881d2a774345bbfb1594159ade4ae4024ebfb1320cb74a30225f6a8ae",
                 "mac_address": "02:42:ac:11:00:02",
                 "ipv4_address": "172.17.0.2/16",
                 "ipv6_address": ""
             }
         }
     }
   ]


.. Related information

.. _network-inspect-related-information:

関連情報
==========

..    network disconnect
    network connect
    network create
    network ls
    network rm
    Understand Docker container networks

* :doc:`network disconnect <network_disconnect>`
* :doc:`network connect <network_connect>`
* :doc:`network create <network_create>`
* :doc:`network ls <network_ls>`
* :doc:`network rm <network_rm>`
* :doc:`Docker コンテナ・ネットワークの理解 </engine/userguide/networking/dockernetworks>`