.. -*- coding: utf-8 -*-
.. https://docs.docker.com/engine/userguide/networking/work-with-networks/
.. doc version: 1.9
.. check date: 2016/01/03

.. Work with network commands

========================================
network コマンドを使う
========================================

.. This article provides examples of the network subcommands you can use to interact with Docker networks and the containers in them. The commands are available through the Docker Engine CLI. These commands are:

この記事ではネットワーク・サブコマンドの例を扱います。このサブコマンドはDocket ネットワークを相互に扱い、コンテナをネットワークに配置します。コマンドは Docker エンジン CLI を通して利用可能です。コマンドとは以下の通りです。

* ``docker network create``
* ``docker network connect``
* ``docker network ls``
* ``docker network rm``
* ``docker network disconnect``
* ``docker network inspect``

.. While not required, it is a good idea to read Understanding Docker network before trying the examples in this section. The examples for the rely on a bridge network so that you can try them immediately. If you would prefer to experiment with an overlay network see the Getting started with multi-host networks instead.

必要としなくても、このセクションの例に取り組む前に、 :doc:`Docker ネットワークの理解 <dockernetworks>` を読むのは良い考えです。例では ``bridge`` ネットワークを使用するため、すぐに試せられます。 ``overlay`` ネットワークを試したいのであれば、 :doc:`マルチホスト・ネットワーキングを始める <https://docs.docker.com/engine/userguide/networking/get-started-overlay/>` をご覧ください。

.. Create networks

.. _create-networks:

ネットワークの作成
====================

.. Docker Engine creates a bridge network automatically when you install Engine. This network corresponds to the docker0 bridge that Engine has traditionally relied on. In addition to this network, you can create your own bridge or overlay network.

Docker エンジンをインストールすると、Docker エンジンは自動的に ``bridge`` ネットワークを作成します。このネットワークは、エンジンが従来使ってきた ``docker0`` ブリッジに相当します。このネットワークに対して付け加えておくと、自分自身で ``bridge`` （ブリッジ）や ``overlay`` （オーバレイ）ネットワークを作成可能です。

.. A bridge network resides on a single host running an instance of Docker Engine. An overlay network can span multiple hosts running their own engines. If you run docker network create and supply only a network name, it creates a bridge network for you.

``bridge`` ネットワークは Docker エンジンの実行ホスト環境上に存在します。 ``overlay`` ネットワークは、複数のホスト上で動くエンジンをまたがっています。 ``docker network create`` を実行する時、ネットワーク名だけ指定すると、ブリッジ・ネットワークを作成します。

.. code-block:: bash

   $ docker network create simple-network
   de792b8258895cf5dc3b43835e9d61a9803500b991654dacb1f4f0546b1c88f8
   $ docker network inspect simple-network
   [
       {
           "Name": "simple-network",
           "Id": "de792b8258895cf5dc3b43835e9d61a9803500b991654dacb1f4f0546b1c88f8",
           "Scope": "local",
           "Driver": "bridge",
           "IPAM": {
               "Driver": "default",
               "Config": [
                   {}
               ]
           },
           "Containers": {},
           "Options": {}
       }
   ]

.. Unlike bridge networks, overlay networks require some pre-existing conditions before you can create one. These conditions are:

ブリッジ・ネットワークとは異なり、 ``overlay`` ネットワークの場合は、作成前に事前準備がいくつか必要です。事前準備とは、次の通りです。

..    Access to a key-value store. Engine supports Consul Etcd, and ZooKeeper (Distributed store) key-value stores.
    A cluster of hosts with connectivity to the key-value store.
    A properly configured Engine daemon on each host in the swarm.

* キーバリュー・ストアへのアクセス。エンジンがサポートするキーバリュー・ストアは Consul、Etcd、ZooKeeper（分散ストア）です。
* ホストのクラスタが、キーバリュー・ストアへ接続できること。
* 各ホスト上のエンジン ``daemon`` に、 Swarm クラスタとしての適切な設定をすること。

.. The docker daemon options that support the overlay network are:

``overlay`` ネットワークがサポートする ``docker daemon`` のオプションは、次の通りです。

* ``--cluster-store``
* ``--cluster-store-opt``
* ``--cluster-advertise``

.. It is also a good idea, though not required, that you install Docker Swarm to manage the cluster. Swarm provides sophisticated discovery and server management that can assist your implementation.

また、必要がなくても Docker Swarm をクラスタ管理用にインストールするのも良い考えでしょう。Swarm はクラスタの設定を手助けするために、洗練されたディスカバリとサーバ管理機能を持っています。

.. When you create a network, Engine creates a non-overlapping subnetwork for the network by default. You can override this default and specify a subnetwork directly using the the --subnet option. On a bridge network you can only create a single subnet. An overlay network supports multiple subnets.

デフォルトではネットワーク作成時、エンジンはサブネットが重複しないネットワークを作成します。このデフォルトの挙動は変更できます。特定のサブネットワークを直接指定するには ``--subnet`` オプションを使います。 ``bridge`` ネットワーク上では１つだけサブネットを作成できます。 ``overlay`` ネットワークでは、複数のサブネットをサポートしています。

.. In addition to the --subnetwork option, you also specify the --gateway --ip-range and --aux-address options.

``--subnetwork`` オプションの他にも、 ``--gateway`` ``--ip-range`` ``--aux-address`` オプションが指定可能です。

.. code-block:: bash

   $ docker network create -d overlay
     --subnet=192.168.0.0/16 --subnet=192.170.0.0/16
     --gateway=192.168.0.100 --gateway=192.170.0.100
     --ip-range=192.168.1.0/24
     --aux-address a=192.168.1.5 --aux-address b=192.168.1.6
     --aux-address a=192.170.1.5 --aux-address b=192.170.1.6
     my-multihost-network

.. Be sure that your subnetworks do not overlap. If they do, the network create fails and Engine returns an error.

サブネットワークが重複しないように注意してください。重複すると、ネットワーク作成が失敗し、エンジンはエラーを返します。

.. Connect containers

.. _connect-containers-network:

コンテナに接続
====================

.. You can connect containers dynamically to one or more networks. These networks can be backed the same or different network drivers. Once connected, the containers can communicate using another container’s IP address or name.

コンテナは１つまたは複数のネットワークに対して、動的に接続できます。これらのネットワークは、同じバックエンドの場合もあれば、異なったネットワーク・ドライバの場合もあります。接続すると、コンテナは他のコンテナの IP アドレスか名前で通信できるようになります。

.. For overlay networks or custom plugins that support multi-host connectivity, containers connected to the same multi-host network but launched from different hosts can also communicate in this way.

``overlay`` ネットワークやカスタム・プラグインの場合は、複数のホストへの接続性をサポートしており、コンテナは同一ホストで作成されたマルチホスト・ネットワークだけでなく、異なったホスト上で作成された環境とも同様に通信可能です。

.. Create two containers for this example:

ここでは例として、２つのコンテナを作成します。

.. code-block:: bash

   $ docker run -itd --name=container1 busybox
   18c062ef45ac0c026ee48a83afa39d25635ee5f02b58de4abc8f467bcaa28731
   
   $ docker run -itd --name=container2 busybox
   498eaaaf328e1018042c04b2de04036fc04719a6e39a097a4f4866043a2c2152

.. Then create a isolated, bridge network to test with.

それから、分離するための ``bridge`` ネットワークを作成します。

.. code-block:: bash

   $ docker network create -d bridge isolated_nw
   f836c8deb6282ee614eade9d2f42d590e603d0b1efa0d99bd88b88c503e6ba7a

.. Connect container2 to the network and then inspect the network to verify the connection:

このネットワークに ``container2`` を追加し、ネットワークへの接続性を調査（ ``inspect`` ）します。

.. code-block:: bash

   $ docker network connect isolated_nw container2
   $ docker network inspect isolated_nw
   [[
       {
           "Name": "isolated_nw",
           "Id": "f836c8deb6282ee614eade9d2f42d590e603d0b1efa0d99bd88b88c503e6ba7a",
           "Scope": "local",
           "Driver": "bridge",
           "IPAM": {
               "Driver": "default",
               "Config": [
                   {}
               ]
           },
           "Containers": {
               "498eaaaf328e1018042c04b2de04036fc04719a6e39a097a4f4866043a2c2152": {
                   "EndpointID": "0e24479cfaafb029104999b4e120858a07b19b1b6d956ae56811033e45d68ad9",
                   "MacAddress": "02:42:ac:15:00:02",
                   "IPv4Address": "172.21.0.2/16",
                   "IPv6Address": ""
               }
           },
           "Options": {}
       }
   ]

.. You can see that the Engine automatically assigns an IP address to container2. If you had specified a --subnetwork when creating your network, the network would have used that addressing. Now, start a third container and connect it to the network on launch using the docker run command’s --net option:

エンジンが自動的に ``container2`` に IP アドレスを割り当てているのが分かります。もしもネットワーク作成時に ``--subnetwork`` を指定しているのであれば、そのネットワーク体系から割り当てられます。次は３つめのコンテナを起動し、ネットワークに接続するために、 ``docker run`` コマンドに ``--net`` オプションを使います。
 
.. code-block:: bash

   $ docker run --net=isolated_nw -itd --name=container3 busybox
   c282ca437ee7e926a7303a64fc04109740208d2c20e442366139322211a6481c

.. Now, inspect the network resources used by container3.

次は、 ``container3`` に対するネットワークのリソースを調査します。

.. code-block:: bash

   $ docker inspect --format='{{json .NetworkSettings.Networks}}'  container3
   {"isolated_nw":{"EndpointID":"e5d077f9712a69c6929fdd890df5e7c1c649771a50df5b422f7e68f0ae61e847","Gateway":"172.21.0.1","IPAddress":"172.21.0.3","IPPrefixLen":16,"IPv6Gateway":"","GlobalIPv6Address":"","GlobalIPv6PrefixLen":0,"MacAddress":"02:42:ac:15:00:03"}}

.. Repeat this command for container2. If you have Python installed, you can pretty print the output.

このコマンドを ``container2`` にも繰り返します。Python をインストール済みであれば、次のように表示を分かりやすくできるでしょう。

.. code-block:: bash

   $ docker inspect --format='{{json .NetworkSettings.Networks}}'  container2 | python -m json.tool
   {
       "bridge": {
           "EndpointID": "281b5ead415cf48a6a84fd1a6504342c76e9091fe09b4fdbcc4a01c30b0d3c5b",
           "Gateway": "172.17.0.1",
           "GlobalIPv6Address": "",
           "GlobalIPv6PrefixLen": 0,
           "IPAddress": "172.17.0.3",
           "IPPrefixLen": 16,
           "IPv6Gateway": "",
           "MacAddress": "02:42:ac:11:00:03"
       },
       "isolated_nw": {
           "EndpointID": "0e24479cfaafb029104999b4e120858a07b19b1b6d956ae56811033e45d68ad9",
           "Gateway": "172.21.0.1",
           "GlobalIPv6Address": "",
           "GlobalIPv6PrefixLen": 0,
           "IPAddress": "172.21.0.2",
           "IPPrefixLen": 16,
           "IPv6Gateway": "",
           "MacAddress": "02:42:ac:15:00:02"
       }
   }

.. You should find container2 belongs to two networks. The bridge network which it joined by default when you launched it and the isolated_nw which you later connected it to.

``container2`` は２つのネットワークに所属しているのが分かるでしょう。 ``bridge`` ネットワークは起動時にデフォルトで参加したネットワークであり、 ``isolated_nw`` ネットワークは後から自分で接続したものです。

.. image:: ./images/working.png
   :scale: 60%
   :alt: Docker のネットワーク

.. In the case of container3, you connected it through docker run to the isolated_nw so that container is not connected to bridge.

``container3`` の場合、 ``docker run`` で ``isolated_nw`` に接続したので、このコンテナは ``bridge`` に接続していません。

.. Use the docker attach command to connect to the running container2 and examine its networking stack:

``docker attach`` コマンドで実行中の ``container2`` に接続詞、ネットワーク・スタックを確認しましょう。

.. code-block:: bash

   $ docker attach container2

.. If you look a the container’s network stack you should see two Ethernet interfaces, one for the default bridge network and one for the isolated_nw network.

コンテナのネットワーク・スタックを確認すると、２つのイーサネット・インターフェースが見えます。１つはデフォルトの bridge ネットワークであり、もう１つは ``isolated_nw`` ネットワークです。

.. code-block:: bash

   / # ifconfig
   eth0      Link encap:Ethernet  HWaddr 02:42:AC:11:00:03  
             inet addr:172.17.0.3  Bcast:0.0.0.0  Mask:255.255.0.0
             inet6 addr: fe80::42:acff:fe11:3/64 Scope:Link
             UP BROADCAST RUNNING MULTICAST  MTU:9001  Metric:1
             RX packets:8 errors:0 dropped:0 overruns:0 frame:0
             TX packets:8 errors:0 dropped:0 overruns:0 carrier:0
             collisions:0 txqueuelen:0
             RX bytes:648 (648.0 B)  TX bytes:648 (648.0 B)
   
   eth1      Link encap:Ethernet  HWaddr 02:42:AC:15:00:02  
             inet addr:172.21.0.2  Bcast:0.0.0.0  Mask:255.255.0.0
             inet6 addr: fe80::42:acff:fe15:2/64 Scope:Link
             UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
             RX packets:8 errors:0 dropped:0 overruns:0 frame:0
             TX packets:8 errors:0 dropped:0 overruns:0 carrier:0
             collisions:0 txqueuelen:0
             RX bytes:648 (648.0 B)  TX bytes:648 (648.0 B)
   
   lo        Link encap:Local Loopback  
             inet addr:127.0.0.1  Mask:255.0.0.0
             inet6 addr: ::1/128 Scope:Host
             UP LOOPBACK RUNNING  MTU:65536  Metric:1
             RX packets:0 errors:0 dropped:0 overruns:0 frame:0
             TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
             collisions:0 txqueuelen:0
             RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

.. Display the container’s etc/hosts file:

コンテナの ``etc/hosts`` ファイルを表示します。

.. code-block:: bash

   / # cat /etc/hosts
   172.17.0.3	498eaaaf328e
   127.0.0.1	localhost
   ::1	localhost ip6-localhost ip6-loopback
   fe00::0	ip6-localnet
   ff00::0	ip6-mcastprefix
   ff02::1	ip6-allnodes
   ff02::2	ip6-allrouters
   172.21.0.3	container3
   172.21.0.3	container3.isolated_nw

.. On the isolated_nw which was user defined, the Docker network feature updated the /etc/hosts with the proper name resolution. Inside of container2 it is possible to ping container3 by name.

``isolated_nw`` はユーザによって定義されたものであり、Docker ネットワーク機能が ``/etc/hosts`` を更新し、適切な名前解決を行います。 ``container2`` の内部では、 ``container3`` に対して名前で ping できるでしょう。

.. code-block:: bash

   / # ping -w 4 container3
   PING container3 (172.21.0.3): 56 data bytes
   64 bytes from 172.21.0.3: seq=0 ttl=64 time=0.070 ms
   64 bytes from 172.21.0.3: seq=1 ttl=64 time=0.080 ms
   64 bytes from 172.21.0.3: seq=2 ttl=64 time=0.080 ms
   64 bytes from 172.21.0.3: seq=3 ttl=64 time=0.097 ms
   
   --- container3 ping statistics ---
   4 packets transmitted, 4 packets received, 0% packet loss
   round-trip min/avg/max = 0.070/0.081/0.097 ms

.. This isn’t the case for the default bridge network. Both container2 and container1 are connected to the default bridge network. Docker does not support automatic service discovery on this network. For this reason, pinging container1 by name fails as you would expect based on the /etc/hosts file:

デフォルトのブリッジ・ネットワークを使っている場合、この名前解決機能を利用できません。 ``containe2`` と ``container1`` は、どちらもデフォルトのブリッジ・ネットワークに接続しています。このデフォルトのネットワーク上では、Docker は自動サービス・ディスカバリをサポートしません。そのため、 ``container1`` に対して名前で ping をしても、 ``/etc/hosts`` ファイルには記述がないため失敗するでしょう。

.. code-block:: bash

   / # ping -w 4 container1
   ping: bad address 'container1'

.. A ping using the container1 IP address does succeed though:

``container1`` の IP アドレスであれば、次のように処理できます。

.. code-block:: bash

   / # ping -w 4 172.17.0.2
   PING 172.17.0.2 (172.17.0.2): 56 data bytes
   64 bytes from 172.17.0.2: seq=0 ttl=64 time=0.095 ms
   64 bytes from 172.17.0.2: seq=1 ttl=64 time=0.075 ms
   64 bytes from 172.17.0.2: seq=2 ttl=64 time=0.072 ms
   64 bytes from 172.17.0.2: seq=3 ttl=64 time=0.101 ms
   
   --- 172.17.0.2 ping statistics ---
   4 packets transmitted, 4 packets received, 0% packet loss
   round-trip min/avg/max = 0.072/0.085/0.101 ms

.. If you wanted you could connect container1 to container2 with the docker run --link command and that would enable the two containers to interact by name as well as IP.

``container1`` と ``container2`` を接続したい場合は、 ``docker run --link`` コマンドを使い、２つのコンテナが相互に IP アドレスだけでなく、名前で通信できるようになります。

.. Detach from a container2 and leave it running using CTRL-p CTRL-q.

``container2`` からデタッチして離れるには、 ``CTRL-p CTRL-q`` を実行します。

.. In this example, container2 is attached to both networks and so can talk to container1 and container3. But container3 and container1 are not in the same network and cannot communicate. Test, this now by attaching to container3 and attempting to ping container1 by IP address.

この例では、 ``container2`` は両方のネットワークにアタッチしているため、 ``container1`` と ``container3`` の両方と通信できます。しかし、 ``container3`` と ``container1`` は同じネットワーク上に存在していないため、お互いに通信出来ません。確認のため、 ``container3`` にアタッチし、 ``container1`` の IP アドレスに対して ping を試みましょう。

.. code-block:: bash

   $ docker attach container3
   / # ping 172.17.0.2
   PING 172.17.0.2 (172.17.0.2): 56 data bytes
   ^C
   --- 172.17.0.2 ping statistics ---
   10 packets transmitted, 0 packets received, 100% packet loss

.. To connect a container to a network, the container must be running. If you stop a container and inspect a network it belongs to, you won’t see that container. The docker network inspect command only shows running containers.

コンテナのネットワークに接続するとき、コンテナは実行中の必要があります。コンテナを停止して確認（ inspect ）すると、ネットワークには所属したままですが、コンテナの情報が見えなくなるでしょう。 ``docker network inspect`` コマンドは、実行中のコンテナのみ表示します。

.. Disconnecting containers

.. _disconnecting-containers:

コンテナの切断
====================

.. You can disconnect a container from a network using the docker network disconnect command.

コンテナをネットワークから切断するには ``docker network disconnect`` コマンドを使います。

.. code-block:: bash

   $ docker network disconnect isolated_nw container2
   
   docker inspect --format='{{json .NetworkSettings.Networks}}'  container2 | python -m json.tool
   {
       "bridge": {
           "EndpointID": "9e4575f7f61c0f9d69317b7a4b92eefc133347836dd83ef65deffa16b9985dc0",
           "Gateway": "172.17.0.1",
           "GlobalIPv6Address": "",
           "GlobalIPv6PrefixLen": 0,
           "IPAddress": "172.17.0.3",
           "IPPrefixLen": 16,
           "IPv6Gateway": "",
           "MacAddress": "02:42:ac:11:00:03"
       }
   }
   
   
   $ docker network inspect isolated_nw
   [[
       {
           "Name": "isolated_nw",
           "Id": "f836c8deb6282ee614eade9d2f42d590e603d0b1efa0d99bd88b88c503e6ba7a",
           "Scope": "local",
           "Driver": "bridge",
           "IPAM": {
               "Driver": "default",
               "Config": [
                   {}
               ]
           },
           "Containers": {
               "c282ca437ee7e926a7303a64fc04109740208d2c20e442366139322211a6481c": {
                   "EndpointID": "e5d077f9712a69c6929fdd890df5e7c1c649771a50df5b422f7e68f0ae61e847",
                   "MacAddress": "02:42:ac:15:00:03",
                   "IPv4Address": "172.21.0.3/16",
                   "IPv6Address": ""
               }
           },
           "Options": {}
       }
   ]

.. Once a container is disconnected from a network, it cannot communicate with other containers connected to that network. In this example, container2 can no longer talk to container3 on the isolated_nw network.

コンテナがネットワークから切断されると、対象ネットワーク上で接続していたコンテナと通信できなくなります。この例では、 ``container2`` は ``isolated_nw`` ネットワーク上の ``container3`` とは通信できなくなります。

.. code-block:: bash

   $ docker attach container2
   
   / # ifconfig
   eth0      Link encap:Ethernet  HWaddr 02:42:AC:11:00:03  
             inet addr:172.17.0.3  Bcast:0.0.0.0  Mask:255.255.0.0
             inet6 addr: fe80::42:acff:fe11:3/64 Scope:Link
             UP BROADCAST RUNNING MULTICAST  MTU:9001  Metric:1
             RX packets:8 errors:0 dropped:0 overruns:0 frame:0
             TX packets:8 errors:0 dropped:0 overruns:0 carrier:0
             collisions:0 txqueuelen:0
             RX bytes:648 (648.0 B)  TX bytes:648 (648.0 B)
   
   lo        Link encap:Local Loopback  
             inet addr:127.0.0.1  Mask:255.0.0.0
             inet6 addr: ::1/128 Scope:Host
             UP LOOPBACK RUNNING  MTU:65536  Metric:1
             RX packets:0 errors:0 dropped:0 overruns:0 frame:0
             TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
             collisions:0 txqueuelen:0
             RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
   
   / # ping container3
   PING container3 (172.20.0.1): 56 data bytes
   ^C
   --- container3 ping statistics ---
   2 packets transmitted, 0 packets received, 100% packet loss

.. The container2 still has full connectivity to the bridge network

``container2`` は、ブリッジ・ネットワークに対する接続性をまだ維持しています。

.. code-block:: bash

   / # ping container1
   PING container1 (172.17.0.2): 56 data bytes
   64 bytes from 172.17.0.2: seq=0 ttl=64 time=0.119 ms
   64 bytes from 172.17.0.2: seq=1 ttl=64 time=0.174 ms
   ^C
   --- container1 ping statistics ---
   2 packets transmitted, 2 packets received, 0% packet loss
   round-trip min/avg/max = 0.119/0.146/0.174 ms
   / #

.. Remove a network

.. _remove-a-network:

ネットワークの削除

.. When all the containers in a network are stopped or disconnected, you can remove a network.

ネットワーク上の全てのコンテナが停止するか切断すると、ネットワークを削除できます。

.. code-block:: bash

   $ docker network disconnect isolated_nw container3

.. code-block:: bash

   docker network inspect isolated_nw
   [
       {
           "Name": "isolated_nw",
           "Id": "f836c8deb6282ee614eade9d2f42d590e603d0b1efa0d99bd88b88c503e6ba7a",
           "Scope": "local",
           "Driver": "bridge",
           "IPAM": {
               "Driver": "default",
               "Config": [
                   {}
               ]
           },
           "Containers": {},
           "Options": {}
       }
   ]
   
   $ docker network rm isolated_nw

.. List all your networks to verify the isolated_nw was removed:

すべてのネットワーク情報を確認すると、 ``isolated_nw`` が削除されています。

.. code-block:: bash

   $ docker network ls
   NETWORK ID          NAME                DRIVER
   72314fa53006        host                host                
   f7ab26d71dbd        bridge              bridge              
   0f32e83e61ac        none                null  

.. Related information

関連情報
==========

* :doc:`network create </engine/reference/commandline/network_create>`
* :doc:`network inspect </engine/reference/commandline/network_inspect>`
* :doc:`network connect </engine/reference/commandline/network_connect>`
* :doc:`network disconnect </engine/reference/commandline/network_disconnect>`
* :doc:`network ls </engine/reference/commandline/network_ls>`
* :doc:`network rm </engine/reference/commandline/network_rm>`

