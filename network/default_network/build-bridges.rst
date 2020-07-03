.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/userguide/networking/default_network/build-bridges/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/userguide/networking/default_network/build-bridges.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/userguide/networking/default_network/build-bridges.md
.. check date: 2016/06/14
.. Commits on Jan 12, 2016 0ba6a128eeee3f1519fa3842a6847402a7eafa05
.. ---------------------------------------------------------------------------

.. Build your own bridge

.. _biuld-your-own-bridge:

========================================
自分でブリッジを作成
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. This section explains how to build your own bridge to replace the Docker default bridge. This is a bridge network named bridge created automatically when you install Docker.

このセクションでは、Docker のデフォルト・ブリッジを自分自身で構築したブリッジに置き換える方法を説明します。``bridge`` という名称の ``ブリッジ`` ネットワークは、Docker インストール時に自動的に作成されるものです。

..    Note: The Docker networks feature allows you to create user-defined networks in addition to the default bridge network.

.. note::

   :doc:`Docker ネットワーク機能 </engine/userguide/networking/dockernetworks>` を使えば、デフォルト・ブリッジ・ネットワークに加え、自分で定義したネットワークも作成できます。

.. You can set up your own bridge before starting Docker and use -b BRIDGE or --bridge=BRIDGE to tell Docker to use your bridge instead. If you already have Docker up and running with its default docker0 still configured, you can directly create your bridge and restart Docker with it or want to begin by stopping the service and removing the interface:

自分自身のブリッジをセットアップするには、Docker を起動する前に Docker に対して ``-b ブリッジ名`` か ``--bridge=ブリッジ名`` を使い、特定のブリッジを指定します。既に Docker を起動している場合は、デフォルトの ``docker0`` がありますが、自分でもブリッジを作成できます。必要があれば、サービスを停止してインターフェースの削除も可能です。

.. code-block:: bash

   # Docker を停止し、docker0 の削除
   
   $ sudo service docker stop
   $ sudo ip link set dev docker0 down
   $ sudo brctl delbr docker0
   $ sudo iptables -t nat -F POSTROUTING

.. Then, before starting the Docker service, create your own bridge and give it whatever configuration you want. Here we will create a simple enough bridge that we really could just have used the options in the previous section to customize docker0, but it will be enough to illustrate the technique.

それから、Docker サービスを開始する前に、自分自身のブリッジを作成し、必要な設定を行います。ここではシンプルながら十分なブリッジを作成します。これまでのセクションで用いてきた ``docker0`` をカスタマイズするだけですが、技術を説明するには十分なものです。

.. code-block:: bash

   # 自分自身でブリッジを作成
   
   $ sudo brctl addbr bridge0
   $ sudo ip addr add 192.168.5.1/24 dev bridge0
   $ sudo ip link set dev bridge0 up
   
   # ブリッジが起動し、実行中なことを確認
   
   $ ip addr show bridge0
   4: bridge0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state UP group default
       inet 192.168.5.1/24 scope global bridge0
          valid_lft forever preferred_lft forever
   
   # Docker にこの情報を登録し、再起動（Ubuntuの場合）
   
   $ echo 'DOCKER_OPTS="-b=bridge0"' >> /etc/default/docker
   $ sudo service docker start
   
   # 新しく外側への NAT マスカレードが作成されたことを確認
   
   $ sudo iptables -t nat -L -n
   ...
   Chain POSTROUTING (policy ACCEPT)
   target     prot opt source               destination
   MASQUERADE  all  --  192.168.5.0/24      0.0.0.0/0

.. The result should be that the Docker server starts successfully and is now prepared to bind containers to the new bridge. After pausing to verify the bridge’s configuration, try creating a container -- you will see that its IP address is in your new IP address range, which Docker will have auto-detected.

この結果、Docker サーバの起動は成功し、コンテナに対して新しいブリッジが割り当てられているでしょう。ブリッジの設定を確認した後、コンテナを作成してみます。Docker は新しい IP アドレスの範囲を自動的に検出し、IP アドレスが割り当てられているのが分かるでしょう。

.. You can use the brctl show command to see Docker add and remove interfaces from the bridge as you start and stop containers, and can run ip addr and ip route inside a container to see that it has been given an address in the bridge’s IP address range and has been told to use the Docker host’s IP address on the bridge as its default gateway to the rest of the Internet.

``brctl show`` コマンドを使えば、コンテナの開始・停止時に Docker がブリッジを追加・削除してるのが分かります。そして、コンテナの中で ``ip addr``  と ``ip route`` を実行したら、IP アドレスがブリッジの IP アドレス範囲内にあることが分かります。そして他のインターネットへのデフォルト・ゲートウェイとして、Docker ホストの IP アドレスをブリッジするのに使われます。

.. seealso:: 

   Build your own bridge
      https://docs.docker.com/engine/userguide/networking/default_network/build-bridges/

