.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/network/macvlan/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/network/macvlan.md
   doc version: 20.10
.. check date: 2022/04/29
.. Commits on Aug 7, 2021 4068208b74003075b5db4e9675262652e72b0e32
.. ---------------------------------------------------------------------------

.. Use macvlan  networks

.. _use-macvlan-networks:

========================================
macvlan ネットワークの使用
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Some applications, especially legacy applications or applications which monitor network traffic, expect to be directly connected to the physical network. In this type of situation, you can use the macvlan network driver to assign a MAC address to each container’s virtual network interface, making it appear to be a physical network interface directly connected to the physical network. In this case, you need to designate a physical interface on your Docker host to use for the macvlan, as well as the subnet and gateway of the macvlan. You can even isolate your macvlan networks using different physical network interfaces. Keep the following things in mind:

いくつかのアプリケーション、特にレガシーのアプリケーションや、ネットワーク・トラフィックを監視するアプリケーションでは物理ネットワークへの直接接続するでしょう。この種類の状況では、 ``macvlan`` ネットワーク・ドライバを使うことで、各コンテナの仮想ネットワーク／インターフェースに対して MAC アドレスを割り当て可能になります。これによって現れる物理ネットワーク・インターフェースは、物理ネットワークに直接接続できるようにします。この状況では、 ``macvlan`` のために使う Docker ホスト上の物理インターフェースを割り当てる必要があり、それと同様に、 ``macvlan`` のサブネットとゲートウェイの割り当ても必要です。また、異なる物理ネットワーク・インタフェースを使うことで、 ``macvlan`` ネットワークを隔離できます。以下の点に注意してください。

..    It is very easy to unintentionally damage your network due to IP address exhaustion or to “VLAN spread”, which is a situation in which you have an inappropriately large number of unique MAC addresses in your network.

* 不適切にユニークで大きな番号の MAC アドレスをネットワーク上に配置する状況では、IP アドレスの消耗や「VLAN spread」によって、ネットワークに意図しないダメージを与えるのが非常に簡単です。

..    Your networking equipment needs to be able to handle “promiscuous mode”, where one physical interface can be assigned multiple MAC addresses.

* 1つの物理インターフェースが複数の MAC アドレスを割り当て可能にするため、ネットワーク機器が「プロミスキャス・モード」（ promiscuous mode）機能を備えている必要があります。

..    If your application can work using a bridge (on a single Docker host) or overlay (to communicate across multiple Docker hosts), these solutions may be better in the long term.

* アプリケーションがブリッジ・ネットワーク（単一の Docker ホスト）やオーバレイ・ネットワーク（複数の Docker ホスト上での通信）を使える状況では、そちらのほうが長期間にわたる利用では望ましい場合があります。

.. Create a macvlan network

.. _Create a macvlan network:

macvlan ネットワークの作成
==============================

.. When you create a macvlan network, it can either be in bridge mode or 802.1q trunk bridge mode.

``macvlan`` ネットワークの作成時は、ブリッジ・モードか 802.1q トランク・ブリッジ・モードのどちらかになります。

..    In bridge mode, macvlan traffic goes through a physical device on the host.

* ブリッジ・モードでは、 ``macvlan`` トラフィックはホスト上の物理デバイスを通して出て行きます。

..    In 802.1q trunk bridge mode, traffic goes through an 802.1q sub-interface which Docker creates on the fly. This allows you to control routing and filtering at a more granular level.

* 802.1q トランク・ブリッジ・モードでは、Docker がオン・ザ・フライで作成する 802.1q サブ・インタフェースを通してトラフィックは出て行きます。これにより、より粒度が高いレベルでの、ルーティングやフィルタリングを制御可能です。

.. Bridge mode

ブリッジ・モード
--------------------

.. To create a macvlan network which bridges with a given physical network interface, use --driver macvlan with the docker network create command. You also need to specify the parent, which is the interface the traffic will physically go through on the Docker host.

特定の物理ネットワーク・インタフェースをブリッジする ``macvlan`` ネットワークを作成するには、 ``docker network create`` コマンドで ``--driver macvlan`` を使います。Docker ホスト上で物理的にトラフィックが通過するインターフェースを示す ``parent``  の指定が必要です。

.. code-block:: bash

   $ docker network create -d macvlan \
     --subnet=172.16.86.0/24 \
     --gateway=172.16.86.1 \
     -o parent=eth0 pub_net

.. If you need to exclude IP addresses from being used in the macvlan network, such as when a given IP address is already in use, use --aux-addresses:

指定した IP アドレスが既に利用中の場合など、``macvlan`` ネットワーク内で IP アドレスの除外が必要であれば、 ``--aux-addresses`` を使います　。

.. code-block:: bash

   $ docker network create -d macvlan \
     --subnet=192.168.32.0/24 \
     --ip-range=192.168.32.128/25 \
     --gateway=192.168.32.254 \
     --aux-address="my-router=192.168.32.129" \
     -o parent=eth0 macnet32

.. 802.1q trunk bridge mode

802.1q トランク・ブリッジ・モード
----------------------------------------

.. If you specify a parent interface name with a dot included, such as eth0.50, Docker interprets that as a sub-interface of eth0 and creates the sub-interface automatically.

``eth0.50`` のように、ドットを含む ``parent`` インターフェース名を指定すると、Docker はそれを ``eth0`` のサブインターフェースと解釈し、サブインターフェースを自動作成します。

.. code-block:: bash

   $ docker network create -d macvlan \
       --subnet=192.168.50.0/24 \
       --gateway=192.168.50.1 \
       -o parent=eth0.50 macvlan50

.. Use an ipvlan instead of macvlan

macvlan の代わりに ipvlan を使う
----------------------------------------

.. In the above example, you are still using a L3 bridge. You can use ipvlan instead, and get an L2 bridge. Specify -o ipvlan_mode=l2.

これまでの例では、 L3 ブリッジを使っています。かわりに ``ipvlan`` を使うには、 L2 ブリッジを準備します。 ``-o ipvlan_mode=l2`` を指定します。

.. code-block:: bash

   $ docker network create -d ipvlan \
       --subnet=192.168.210.0/24 \
       --subnet=192.168.212.0/24 \
       --gateway=192.168.210.254 \
       --gateway=192.168.212.254 \
        -o ipvlan_mode=l2 -o parent=eth0  ipvlan210

.. Use IPv6

IPv6 を使う
--------------------

.. If you have configured the Docker daemon to allow IPv6, you can use dual-stack IPv4/IPv6 macvlan networks.

:doc:`Docker デーモンで IPv6 を使う設定 </config/daemon/ipv6>` をしていると、IPv4/IPv6 デュアルスタックの  ``macvlan`` ネットワークが利用できます。

.. code-block:: bash

   $ docker network create -d macvlan \
       --subnet=192.168.216.0/24 --subnet=192.168.218.0/24 \
       --gateway=192.168.216.1 --gateway=192.168.218.1 \
       --subnet=2001:db8:abc8::/64 --gateway=2001:db8:abc8::10 \
        -o parent=eth0.218 \
        -o macvlan_mode=bridge macvlan216

.. Next steps

次のステップ
====================


..  Go through the macvlan networking tutorial
    Learn about networking from the container’s point of view
    Learn about bridge networks
    Learn about overlay networks
    Learn about host networking
    Learn about Macvlan networks

* :doc:`macvlan ・ネットワーク機能のチュートリアル <network-tutorial-macvlan>` に進む
* :doc:`コンテナ視点からのネットワーク機能 </config/containers/container-networking>` について学ぶ
* :doc:`ブリッジ・ネットワーク <bridge>` について学ぶ
* :doc:`オーバレイ・ネットワーク <overlay>` について学ぶ
* :doc:`Macvlan ネットワーク <macvlan>` について学ぶ

.. seealso:: 

   Use host networking
      https://docs.docker.com/network/host/