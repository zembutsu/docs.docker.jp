.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/userguide/networking/default_network/custom-docker0/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/userguide/networking/default_network/custom-docker0.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/userguide/networking/default_network/custom-docker0.md
.. check date: 2016/06/14
.. Commits on Dec 11, 2015 76de01c13833e42c89afa7e46d97bb4864a9be9b
.. ---------------------------------------------------------------------------

.. Customize the docker0 bridge

.. _customize-the-docker0-bridge:

========================================
Docker0 ブリッジのカスタマイズ
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. The information in this section explains how to customize the Docker default bridge. This is a bridge network named bridge created automatically when you install Docker.

このセクションでは Docker のデフォルト・ブリッジをどのようにカスタマイズするか説明します。``bridge`` という名称の ``bridge`` ネットワークは、Docker インストール時に自動的に作成されるものです。

.. Note: The Docker networks feature allows you to create user-defined networks in addition to the default bridge network.

.. note::

   :doc:`Docker ネットワーク機能 </engine/userguide/networking/dockernetworks>` を使えば、デフォルト・ブリッジ・ネットワークに加え、自分で定義したネットワークも作成できます。

.. By default, the Docker server creates and configures the host system’s docker0 interface as an Ethernet bridge inside the Linux kernel that can pass packets back and forth between other physical or virtual network interfaces so that they behave as a single Ethernet network.

デフォルトでは、Docker サーバはホスト・システム上の ``docker0``  インターフェースを Linux カーネル内部の *イーサネット・ブリッジ （Ethernet bridge）* として設定・作成します。１つのイーサネット・ネットワークとして振る舞い、パケットの送受信や、別の物理ないし仮想ネットワーク・インターフェースに転送します。

.. Docker configures docker0 with an IP address, netmask and IP allocation range. The host machine can both receive and send packets to containers connected to the bridge, and gives it an MTU -- the maximum transmission unit or largest packet length that the interface will allow -- of either 1,500 bytes or else a more specific value copied from the Docker host’s interface that supports its default route. These options are configurable at server startup: - --bip=CIDR -- supply a specific IP address and netmask for the docker0 bridge, using standard CIDR notation like 192.168.1.5/24.

Docker は ``docker0`` の IP アドレス、ネットマスク、IP 割り当て範囲（レンジ）を設定します。ホストマシンはブリッジに接続したコンテナに対して、パケットの送受信が可能です。そして、 MTU （ *maximum transmission unit* ）の指定値や、インターフェースが扱えるパケット値の超過を指定する値は、Docker ホスト上のデフォルトでルーティングされるインターフェース値からコピーされます。これらのオプションはサーバ起動時に設定可能です。例えば、 ``--bip-CIDER`` は ``bridge0`` ブリッジに対して特定の IP アドレスとネットマスクを指定、ここでは ``192.168.1.5/24`` のような通常の CIDR で指定します。

..    --fixed-cidr=CIDR -- restrict the IP range from the docker0 subnet, using the standard CIDR notation like 172.167.1.0/28. This range must be an IPv4 range for fixed IPs (ex: 10.20.0.0/16) and must be a subset of the bridge IP range (docker0 or set using --bridge). For example with --fixed-cidr=192.168.1.0/25, IPs for your containers will be chosen from the first half of 192.168.1.0/24 subnet.

* ``--fixed-cidr=CIDR`` ： ``docker0`` サブネットが使う IP 範囲を、 ``172.167.1.0/28`` のような標準的な CIDR 形式で指定します。この範囲は IPv4 で固定する（例： 10.20.0.0/16 ）必要があり、ブリッジの IP 範囲（ ``docker0`` あるいは ``--bridge`` で指定 ）のサブセットである必要もあります。例えば ``--fixed-cidr=192.168.1.0/25`` を指定したら、コンテナの IP アドレスは前半の ``192.168.1.0/24`` サブネットから割り当てられます。

..    --mtu=BYTES -- override the maximum packet length on docker0.

* ``--mtu=バイト数`` ： ``docker0`` 上の最大パケット長を上書きします。

.. Once you have one or more containers up and running, you can confirm that Docker has properly connected them to the docker0 bridge by running the brctl command on the host machine and looking at the interfaces column of the output. Here is a host with two different containers connected:

１つまたは複数のコンテナを実行し、ホストマシン上で ``brctl`` コマンドを実行したら、出力の ``interfaces`` 列から、 Docker が ``docker0`` ブリッジに適切に接続しているのが分かります。次の例は、ホスト上で２つの異なったコンテナが接続しています。

.. # Display bridge info

.. code-block:: bash

   # ブリッジ情報の表示
   
   $ sudo brctl show
   bridge name     bridge id               STP enabled     interfaces
   docker0         8000.3a1d7362b4ee       no              veth65f9
                                                           vethdda6

.. If the brctl command is not installed on your Docker host, then on Ubuntu you should be able to run sudo apt-get install bridge-utils to install it.

``brctl`` コマンドが Docker ホスト上にインストールされていなければ、Ubuntu であれば ``sudo apt-get install bridge-utils`` でインストール可能です。

.. Finally, the docker0 Ethernet bridge settings are used every time you create a new container. Docker selects a free IP address from the range available on the bridge each time you docker run a new container, and configures the container’s eth0 interface with that IP address and the bridge’s netmask. The Docker host’s own IP address on the bridge is used as the default gateway by which each container reaches the rest of the Internet.

最後に、 ``docker0`` イーサネット・ブリッジの設定は新しいコンテナを作成する度に行われます。Docker は ``docker run`` で新しいコンテナを実行時、ブリッジは毎回利用可能な範囲にある空き IP アドレスを探します。それから、コンテナの ``eth0`` インターフェースにその IP アドレスとブリッジのネットマスクを設定します。Docker ホスト自身が IP アドレスをブリッジする設定の場合は、ブリッジにデフォルト・ゲートウェイが用いられ、各コンテナが他のインターネット環境と接続できるようになります。

.. code-block:: bash

   # コンテナから見えるネットワーク
   
   $ docker run -i -t --rm base /bin/bash
   
   $$ ip addr show eth0
   24: eth0: <BROADCAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
       link/ether 32:6f:e0:35:57:91 brd ff:ff:ff:ff:ff:ff
       inet 172.17.0.3/16 scope global eth0
          valid_lft forever preferred_lft forever
       inet6 fe80::306f:e0ff:fe35:5791/64 scope link
          valid_lft forever preferred_lft forever
   
   $$ ip route
   default via 172.17.42.1 dev eth0
   172.17.0.0/16 dev eth0  proto kernel  scope link  src 172.17.0.3
   
   $$ exit

.. Remember that the Docker host will not be willing to forward container packets out on to the Internet unless its ip_forward system setting is 1 -- see the section above on Communication between containers for details

Docker はホスト側の ``ip_forward`` システム設定が ``1`` でなければ、Docker ホストはコンテナのパケットをインターネット側に転送できないのでご注意ください。詳細については :ref:`communicating-to-the-outside-world` をご覧ください。

.. seealso:: 

   Customize the docker0 bridge
      https://docs.docker.com/engine/userguide/networking/default_network/custom-docker0/
