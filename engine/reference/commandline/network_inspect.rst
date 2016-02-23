.. *- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/network_inspect/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/network_inspect.md
   doc version: 1.10
      https://github.com/docker/docker/commits/master/docs/reference/commandline/network_inspect.md
.. check date: 2016/02/23
.. Commits on Jan 15, 2016 c199506b59f60ac456cb0448ddd86e6dec92bc0a
.. -------------------------------------------------------------------

.. network inspect

=======================================
network inspect
=======================================

.. code-block:: bash

   Usage:  docker network inspect [OPTIONS] NETWORK [NETWORK..]
   
   Displays detailed information on a network
   
     -f, --format=       Format the output using the given go template.
     --help             Print usage

.. Returns information about one or more networks. By default, this command renders all results in a JSON object. For example, if you connect two containers to the default bridge network:

１つまたは複数のネットワークの情報を返します。デフォルトでは、このコマンドは結果を JSON オブジェクト形式で返します。例えば、２つのコンテナをデフォルトの ``bridge`` ネットワークに接続します。

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
           "Name": "bridge",
           "Id": "b2b1a2cba717161d984383fd68218cf70bbbd17d328496885f7c921333228b0f",
           "Scope": "local",
           "Driver": "bridge",
           "IPAM": {
               "Driver": "default",
               "Config": [
                   {
                       "Subnet": "172.17.42.1/16",
                       "Gateway": "172.17.42.1"
                   }
               ]
           },
           "Internal": false,
           "Containers": {
               "bda12f8922785d1f160be70736f26c1e331ab8aaf8ed8d56728508f2e2fd4727": {
                   "Name": "container2",
                   "EndpointID": "0aebb8fcd2b282abe1365979536f21ee4ceaf3ed56177c628eae9f706e00e019",
                   "MacAddress": "02:42:ac:11:00:02",
                   "IPv4Address": "172.17.0.2/16",
                   "IPv6Address": ""
               },
               "f2870c98fd504370fb86e59f32cd0753b1ac9b69b7d80566ffc7192a82b3ed27": {
                   "Name": "container1",
                   "EndpointID": "a00676d9c91a96bbe5bcfb34f705387a33d7cc365bac1a29e4e9728df92d10ad",
                   "MacAddress": "02:42:ac:11:00:01",
                   "IPv4Address": "172.17.0.1/16",
                   "IPv6Address": ""
               }
           },
           "Options": {
               "com.docker.network.bridge.default_bridge": "true",
               "com.docker.network.bridge.enable_icc": "true",
               "com.docker.network.bridge.enable_ip_masquerade": "true",
               "com.docker.network.bridge.host_binding_ipv4": "0.0.0.0",
               "com.docker.network.bridge.name": "docker0",
               "com.docker.network.driver.mtu": "1500"
           }
       }
   ]

.. Returns the information about the user-defined network:

ユーザ定義ネットワークに関する詳細情報を返します。

.. code-block:: bash

   $ docker network create simple-network
   69568e6336d8c96bbf57869030919f7c69524f71183b44d80948bd3927c87f6a
   $ docker network inspect simple-network
   [
       {
           "Name": "simple-network",
           "Id": "69568e6336d8c96bbf57869030919f7c69524f71183b44d80948bd3927c87f6a",
           "Scope": "local",
           "Driver": "bridge",
           "IPAM": {
               "Driver": "default",
               "Config": [
                   {
                       "Subnet": "172.22.0.0/16",
                       "Gateway": "172.22.0.1/16"
                   }
               ]
           },
           "Containers": {},
           "Options": {}
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