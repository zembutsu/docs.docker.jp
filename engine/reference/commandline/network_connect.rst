.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/network_connect/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/network_connect.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_network_connect.yaml
.. check date: 2022/03/28
.. Commits on Aug 22, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker network connect

=======================================
docker network connect
=======================================


.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _network_connect-description:

説明
==========

.. Connect a container to a network

コンテナをネットワークに接続します。

.. API 1.21+
   Open the 1.21 API reference (in a new window)
   The client and daemon API must both be at least 1.21 to use this command. Use the docker version command on the client to check your client and daemon API versions.

【API 1.21+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.21 <https://docs.docker.com/engine/api/v1.21/>`_ の必要があります。クライアントとデーモン API のバージョンを調べるには、 ``docker version`` コマンドを使います。

.. _network_connect-usage:

使い方
==========

.. code-block:: bash

   $ docker network connect [OPTIONS] NETWORK CONTAINER

.. Extended description
.. _network_connect-extended-description:

補足説明
==========

.. Connects a container to a network. You can connect a container by name or by ID. Once connected, the container can communicate with other containers in the same network.

コンテナをネットワークに接続（connect）します。コンテナの接続はコンテナ名かコンテナ ID を使います。接続後は、同一ネットワーク上にある他のコンテナと通信可能になります。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <network_connect-examples>` をご覧ください。

.. _network_connect-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--alias``
     - 
     - コンテナにネットワーク範囲内の別名を追加
   * - ``--driver-opt``
     - 
     - ネットワークに対するドライバ・オプション
   * - ``--ip``
     - 
     - IPv4 アドレス（例： 172.30.100.104）
   * - ``--ip6``
     - 
     - IPv6 アドレス（例： 2001:db8:33）
   * - ``--link``
     - 
     - 他のコンテナに対するリンクを追加
   * - ``--link-local-ip``
     - 
     - コンテナに対するリンク・ローカル・アドレスを追加


.. Examples
.. _network_connect-examples:

使用例
==========

.. Connect a running container to a network
.. _network_connect-connect-a-running-container-to-a-network:
実行中のコンテナをネットワークに接続
----------------------------------------

.. code-block:: bash

   $ docker network connect multi-host-network container1

.. Connect a container to a network when it starts
.. _network_connect-connect-a-container-to-a-network-when-it-starts:
コンテナ起動時にネットワークへ接続
----------------------------------------

.. You can also use the docker run --net=<network-name> option to start a container and immediately connect it to a network.

``docker run --network=<ネットワーク名>`` オプションを使うと、コンテナ起動時に直ちにネットワークに接続します。

.. code-block:: bash

   $ docker run -itd --network=multi-host-network busybox

.. Specify the IP address a container will use on a given network
.. _network_connect-specify-the-ip-address-a-container-will-use-on-a-given-network:
接続するネットワーク上で使う IP アドレスを指定
--------------------------------------------------

.. You can specify the IP address you want to be assigned to the container’s interface.

コンテナのインターフェースに任意の IP アドレスを割り当て可能です。

.. code-block:: bash

   $ docker network connect --ip 10.10.36.122 multi-host-network container2

.. Use the legacy --link option
.. _network_connect-use-the-legacy-link-option:
レガシーの ``--link`` オプションを使う
----------------------------------------
.. You can use --link option to link another container with a preferred alias

``--link`` オプションを使うことで、他のコンテナを任意のエイリアス名でリンクできます。

.. code-block:: bash

   $ docker network connect --link container1:c1 multi-host-network container2

.. Create a network alias for a container:
.. _network-craete-create-a-network-alias-for-a-container:
コンテナにネットワーク別名を作成
----------------------------------------

.. --alias option can be used to resolve the container by another name in the network being connected to.

``--alias`` オプションを使うことで、ネットワークを接続したコンテナ間での名前解決に使う別名を指定できます。

.. code-block:: bash

   $ docker network connect --alias db --alias mysql multi-host-network container2

.. Network implications of stopping, pausing, or restarting containers
.. _network_connect-network-implications-of-stopping,-pausing,-or-restarting-container:
コンテナの停止・一時停止・再起動とネットワークの関係
------------------------------------------------------------

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

.. Parent command

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker network <network>`
     - ネットワークを管理



.. Related commands

関連コマンド
====================

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker network connect <network_connect>`
     - コンテナをネットワークに接続
   * - :doc:`docker network craete <network_create>`
     - ネットワーク作成
   * - :doc:`docker network disconnect <network_disconnect>`
     - ネットワークからコンテナを切断
   * - :doc:`docker network inspect <network_inspect>`
     - 1つまたは複数ネットワークの情報を表示
   * - :doc:`docker network ls <network_ls>`
     - ネットワーク一覧表示
   * - :doc:`docker network prune <network_prune>`
     - 使用していないネットワークを全て削除
   * - :doc:`docker network rm <network_rm>`
     - 1つまたは複数ネットワークの削除


.. seealso:: 

   docker network connect
      https://docs.docker.com/engine/reference/commandline/network_connect/
