.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/network/none/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/network/none.md
   doc version: 19.03
.. check date: 2020/07/19
.. Commits on Jun 18, 2020 2693610fc7d40653b3f693aabfbf29fc213d188a
.. ---------------------------------------------------------------------------

.. Disable networking for a container

.. _disable-networking-for-a-container:

========================================
macvlan ネットワークの使用
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. If you want to completely disable the networking stack on a container, you can use the --network none flag when starting the container. Within the container, only the loopback device is created. The following example illustrates this.

コンテナ上でネットワーク機能スタックを完全に無効にしたい場合は、コンテナの起動時に ``--network none`` フラグを使います。コンテナ内では、ループバック・デバイスのみが作成されます。これを説明するのが以下の例です。

..    Create the container.

1. コンテナを作成します。

   .. code-block:: bash
   
      $ docker run --rm -dit \
        --network none \
        --name no-net-alpine \
        alpine:latest \
        ash

..    Check the container’s network stack, by executing some common networking commands within the container. Notice that no eth0 was created.

2. コンテナのネットワーク・スタックを確認し、コンテナ内で一般的なネットワークに関するコマンドをいくつか実行します。 ``eth0`` が作成されていない点に注目します。

   .. code-block:: bash
   
      $ docker exec no-net-alpine ip link show
      
      1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN qlen 1
          link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
      2: tunl0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN qlen 1
          link/ipip 0.0.0.0 brd 0.0.0.0
      3: ip6tnl0@NONE: <NOARP> mtu 1452 qdisc noop state DOWN qlen 1
          link/tunnel6 00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00 brd 00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00
   
   .. code-block:: bash
   
      $ docker exec no-net-alpine ip route

   ..  The second command returns empty because there is no routing table.

   2つめのコマンドが何も返さないのは、ルーティング・テーブルが存在しないからです。

..     Stop the container. It is removed automatically because it was created with the --rm flag.

3. コンテナを停止すると、自動的にコンテナは削除されます。これは作成時に ``--rm`` フラグを指定しているからです。

   .. code-block:: bash
   
      $ docker stop no-net-alpine

.. Next steps

次のステップ
====================

..  Go through the host networking tutorial
    Learn about networking from the container’s point of view
    Learn about bridge networks
    Learn about overlay networks
    Learn about Macvlan networks

* :doc:`ホスト・ネットワーク機能のチュートリアル <network-tutorial-host>` に進む
* :doc:`コンテナ視点からのネットワーク機能 </config/containers/container-networking>` について学ぶ
* :doc:`ブリッジ・ネットワーク <bridge>` について学ぶ
* :doc:`オーバレイ・ネットワーク <overlay>` について学ぶ
* :doc:`Macvlan ネットワーク <macvlan>` について学ぶ

.. seealso:: 

   Disable networking for a container
      https://docs.docker.com/network/host/