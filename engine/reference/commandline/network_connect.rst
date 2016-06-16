.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/network_connect/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/network_connect.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/network_connect.md
.. check date: 2016/06/16
.. Commits on Jun 15, 2016 1c4efb6aa05026efce99a7a5bb7e710c0f1b3002
.. -------------------------------------------------------------------

.. network connect

=======================================
network connect
=======================================

.. code-block:: bash

   使い方:  docker network connect [オプション] ネットワーク コンテナ
   
   コンテナをネットワークに接続
   
     --alias=[]         コンテナ用のネットワーク範囲エイリアスを追加
     --help             使い方の表示
     --ip               IPv4 アドレス
     --ip6              IPv6 アドレス
     --link=[]          他のコンテナに対するリンクを追加
     --link-local-ip=[] IPv4/IPv6 リンク・ローカル・アドレス

.. Connects a container to a network. You can connect a container by name or by ID. Once connected, the container can communicate with other containers in the same network.

コンテナをネットワークに接続（connect）します。コンテナの接続はコンテナ名かコンテナ ID を使います。接続後は、同一ネットワーク上にある他のコンテナと通信可能になります。

.. code-block:: bash

   $ docker network connect multi-host-network container1

.. You can also use the docker run --net=<network-name> option to start a container and immediately connect it to a network.

あるいは、 ``docker run --net=<ネットワーク名>`` オプションを使えば、コンテナ起動時に直ちにネットワークに接続します。

.. code-block:: bash

   $ docker run -itd --net=multi-host-network busybox

.. You can specify the IP address you want to be assigned to the container’s interface.

コンテナのインターフェースに任意の IP アドレスを割り当て可能です。

.. code-block:: bash

   $ docker network connect --ip 10.10.36.122 multi-host-network container2

.. You can use --link option to link another container with a preferred alias

``--link`` オプションを使うことで、他のコンテナを任意のエイリアス名でリンクできます。

.. code-block:: bash

   $ docker network connect --link container1:c1 multi-host-network container2

.. --alias option can be used to resolve the container by another name in the network being connected to.

``--alias`` オプションを使うことで、ネットワークを接続したコンテナ間での名前解決に使う別名を指定できます。

.. code-block:: bash

   $ docker network connect --alias db --alias mysql multi-host-network container2

.. You can pause, restart, and stop containers that are connected to a network. Paused containers remain connected and can be revealed by a network inspect. When the container is stopped, it does not appear on the network until you restart it.

コンテナを中断（pause）・再起動・停止しても、ネットワークに接続したままです。中断したコンテナはネットワークに接続し続けており、 ``network inspect`` で確認できます。コンテナを停止（stop）すると、再起動するまではネットワーク上に表示されません。

.. If specified, the container’s IP address(es) is reapplied when a stopped container is restarted. If the IP address is no longer available, the container fails to start. One way to guarantee that the IP address is available is to specify an --ip-range when creating the network, and choose the static IP address(es) from outside that range. This ensures that the IP address is not given to another container while this container is not on the network.

停止しているコンテナを再起動する時に IP アドレスを指定できます。もしも IP アドレスが使えなければ、コンテナは起動に失敗します。IP アドレスを確実に割り当てるためには、ネットワーク作成時に ``--ip-range`` （IPアドレスの範囲）を指定しておき、その範囲内外にある静的な IP アドレスを割り当てる方法があります。そうしておけば、コンテナが対象のネットワークに所属していない間でも、他のコンテナに IP アドレスを使われる心配はありません。

.. code-block:: bash

   $ docker network create --subnet 172.20.0.0/16 --ip-range 172.20.240.0/20 multi-host-network

.. code-block:: bash

   $ docker network connect --ip 172.20.128.2 multi-host-network container2

.. To verify the container is connected, use the docker network inspect command. Use docker network disconnect to remove a container from the network.

コンテナがどこに接続しているかを確認するには、 ``docker network inspect`` コマンドを使います。 ``docker network disconnect`` はコンテナをネットワークから切り離します。

.. Once connected in network, containers can communicate using only another container’s IP address or name. For overlay networks or custom plugins that support multi-host connectivity, containers connected to the same multi-host network but launched from different Engines can also communicate in this way.

ネットワークに接続したら、コンテナは他のコンテナの IP アドレスや名前を使って通信できるようになります。 ``overlay`` ネットワークやカスタム・プラグインは複数のホスト間の接続性（multi-host connectivity）をサポートしています。コンテナは同じマルチホスト・ネットワーク上で接続できるだけではありません。異なったエンジンによって起動されていたとしても、同様に通信できます。

.. You can connect a container to one or more networks. The networks need not be the same type. For example, you can connect a single container bridge and overlay networks.

コンテナは複数のネットワークにも接続できます。ネットワークは同じ種類でなくても構いません。例えば、コンテナ・ブリッジとオーバレイ・ネットワークの両方に接続できます。

.. Related information

.. _network-connect-related-information:

関連情報
==========

..    network inspect
    network create
    network disconnect
    network ls
    network rm
    Understand Docker container networks

* :doc:`network inspect <network_inspect>`
* :doc:`network create <network_create>`
* :doc:`network disconnect <network_disconnect>`
* :doc:`network ls <network_ls>`
* :doc:`network rm <network_rm>`
* :doc:`Docker コンテナ・ネットワークの理解 </engine/userguide/networking/dockernetworks>`

.. seealso:: 

   network connect
      https://docs.docker.com/engine/reference/commandline/network_connect/
