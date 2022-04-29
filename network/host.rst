.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/network/host/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/network/host.md
   doc version: 20.10
.. check date: 2022/04/29
.. Commits on Aug 16, 2021 15836782038638a20f4e214af6e92bdd01624726
.. ---------------------------------------------------------------------------

.. Use host  networking

.. _use-host-networking:

========================================
ホスト・ネットワークの使用
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. If you use the host network mode for a container, that container’s network stack is not isolated from the Docker host (the container shares the host’s networking namespace), and the container does not get its own IP-address allocated. For instance, if you run a container which binds to port 80 and you use host networking, the container’s application is available on port 80 on the host’s IP address.

コンテナに対して ``host`` ネットワーク・モードを使うと、コンテナのネットワーク・スタックは Docker ホストから隔離されません（コンテナはホスト側のネットワーク名前空間を共有します）。また、コンテナは自身に対して IP アドレスを割り当てません。たとえば、コンテナがポート 80 をバインドして ``host``  ネットワークを使うと、コンテナのアプリケーションはホスト IP アドレス上のポート 80 で利用可能です。

..    Note: Given that the container does not have its own IP-address when using host mode networking, port-mapping does not take effect, and the -p, --publish, -P, and --publish-all option are ignored, producing a warning instead:

.. note::

   ``host`` モードを使うネットワーク機能では、コンテナ自身に対する IP アドレスを持ちません。また、ポートの割当は無効となり、 ``p`` 、 ``--publish`` 、 ``-P`` 、 ``--publish-all`` オプションは無視され、代わりに次のようなエラーが出ます。
   
   ::
   
      WARNING: Published ports are discarded when using host network mode

.. Host mode networking can be useful to optimize performance, and in situations where a container needs to handle a large range of ports, as it does not require network address translation (NAT), and no “userland-proxy” is created for each port.

ホスト・モードのネットワーク機能は性能の最適化に役立ちます。また、コンテナが広範囲のポートを扱う状況でも役立つのは、ネットワークアドレス変換（NAT）を必要とせず、また、各ポートに対するユーザランド・プロキシを作成する必要がないからです。

.. The host networking driver only works on Linux hosts, and is not supported on Docker Desktop for Mac, Docker Desktop for Windows, or Docker EE for Windows Server.

ホスト・ネットワーク機能ドライバが動作するのは Linux ホスト上のみです。そして、 Docker Desktop for Mac や Docker Desktop for Windows や、 Docker EE for Windows Server ではサポートしていません。

.. You can also use a host network for a swarm service, by passing --network host to the docker service create command. In this case, control traffic (traffic related to managing the swarm and the service) is still sent across an overlay network, but the individual swarm service containers send data using the Docker daemon’s host network and ports. This creates some extra limitations. For instance, if a service container binds to port 80, only one service container can run on a given swarm node.

また、swarm サービスでも ``docker service create`` コマンドで ``--network host`` を渡すことで、 ``host`` ネットワークが利用可能です。この場合、管理トラフィック（swarm とサービスの管理に関連するトラフィック）はオーバレイ・ネットワーク上を渡りますが、個々のサービス・コンテナがデータの送信には、各 Docker デーモンのホスト上のネットワークとポートを使用します。swarm サービス上での作成では、追加の制限があります。たとえば、サービス・コンテナがポート 80 をバインドしても、対象となる swarm ノード上で実行しているコンテナのサービスのみが対象です。

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

   Use host networking
      https://docs.docker.com/network/host/