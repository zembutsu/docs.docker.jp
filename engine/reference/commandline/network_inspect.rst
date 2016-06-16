.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/network_inspect/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/network_inspect.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/network_inspect.md
.. check date: 2016/06/16
.. Commits on Mar 14, 2016 2ef00ba89fc04b0a7571aa050d8a11c06f758d9b
.. -------------------------------------------------------------------

.. network inspect

=======================================
network inspect
=======================================

.. code-block:: bash

   使い方:  docker network inspect [オプション] ネットワーク [ネットワーク..]
   
   ネットワークの詳細情報を表示
   
     -f, --format=       go テンプレートで指定したフォーマットで表示
     --help             使い方の表示

.. Returns information about one or more networks. By default, this command renders all results in a JSON object. For example, if you connect two containers to the default bridge network:

１つまたは複数のネットワークの情報を返します。デフォルトでは、このコマンドは結果を JSON オブジェクト形式で返します。例えば、２つのコンテナをデフォルトの ``bridge`` ネットワークに接続します。

.. code-block:: bash

   $ sudo docker run -itd --name=container1 busybox
   f2870c98fd504370fb86e59f32cd0753b1ac9b69b7d80566ffc7192a82b3ed27
   
   $ sudo docker run -itd --name=container2 busybox
   bda12f8922785d1f160be70736f26c1e331ab8aaf8ed8d56728508f2e2fd4727

.. The network inspect command shows the containers, by id, in its results. For networks backed by multi-host network driver, such as Overlay, this command also shows the container endpoints in other hosts in the cluster. These endpoints are represented as “ep-{endpoint-id}” in the output. You can specify an alternate format to execute a given template for each result. Go’s text/template package describes all the details of the format.

``network inspect`` コマンドで、その結果からコンテナの情報を確認します。ネットワーク・バックエンドが Overlay のようなマルチホスト・ネットワーク・ドライバの場合は、コマンドはクラスタ上の他のホストに対するコンテナのエンドポイントも表示します。これらのエンドポイントは  “ep-{エンドポイント-id}” として表示されます。あるいは、結果表示の時に別のフォーマットも指定できます。フォーマットの詳細は Go 言語の `text/template <http://golang.org/pkg/text/template/>`_ パッケージで指定します。

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

.. seealso:: 

   network inspect
      https://docs.docker.com/engine/reference/commandline/network_inspect/
