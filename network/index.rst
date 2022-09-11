.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/network/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/network/index.md
   doc version: 20.10
.. check date: 2022/04/29
.. Commits on Nov 8, 2021 d2673f7458aa07a3b897a8eed141211cb9ebf866
.. ---------------------------------------------------------------------------

.. Networking overview

.. _networking-overview:

==================================================
:ruby:`ネットワーク機能 <networking>` の概要
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. One of the reasons Docker containers and services are so powerful is that you can connect them together, or connect them to non-Docker workloads. Docker containers and services do not even need to be aware that they are deployed on Docker, or whether their peers are also Docker workloads or not. Whether your Docker hosts run Linux, Windows, or a mix of the two, you can use Docker to manage them in a platform-agnostic way.

Docker コンテナとサービスが非常に強力な理由の1つは、コンテナやサービスを一緒に接続したり、あるいは Docker 以外のワークロードと接続できるからです。Docker コンテナとサービスは、 Docker 上にデプロイしていることを気にかける必要が全くありません。また、それらの接続先が Docker かどうかも関係ありません。Docker ホストを Linux や Windows 上で実行しても、あるいはこれら2つを混ぜたとしても、Docker はこれらをプラットフォームに関係無く管理できます。

.. This topic defines some basic Docker networking concepts and prepares you to design and deploy your applications to take full advantage of these capabilities.

このトピックでは、いくつかの基本的な Docker のネットワーク機能についての概要を定義し、これらの機能を最大限に活用するアプリケーション設計およびデプロイの準備をします。

.. Scope of this topic

.. _network-scope-of-this-topic:

このトピックで扱う範囲
==============================

.. This topic does not go into OS-specific details about how Docker networks work, so you will not find information about how Docker manipulates iptables rules on Linux or how it manipulates routing rules on Windows servers, and you will not find detailed information about how Docker forms and encapsulates packets or handles encryption. See Docker and iptables.

このトピックでは Docker ネットワークの挙動について、 OS 固有の詳細は **扱いません** 。そのため、Linux 上で ``iptables`` のルールを Docker がどのように作業しているかや、Windows サーバ上でのルーティング・ルールの扱いや、Docker がどのようにパケットをカプセル化して暗号化を処理するかについて、扱っていません。より深い技術的詳細については、 :doc:`Docker と iptables <iptables>`  をご覧ください。

.. In addition, this topic does not provide any tutorials for how to create, manage, and use Docker networks. Each section includes links to relevant tutorials and command references.

加えて、このトピックではどのようにして Docker ネットワークを作成、管理、使うかについてのチュートリアルはありません。各セクションには関連するチュートリアルやコマンド・リファレンスへのリンクがあります。

.. Network drivers

ネットワーク・ドライバ
==============================

.. Docker’s networking subsystem is pluggable, using drivers. Several drivers exist by default, and provide core networking functionality:

Docker のネットワーク機能（networking）サブシステムとは、ドライバを利用するプラガブル（pluggable：取り付け、取り外しが自由という意味）なものです。複数のドライバがデフォルトで存在し、これらはネットワーク機能群の中核を備えています。

..    bridge: The default network driver. If you don’t specify a driver, this is the type of network you are creating. Bridge networks are usually used when your applications run in standalone containers that need to communicate. See bridge networks.

* ``bridge`` ： デフォルトのネットワーク・ドライバです。ネットワーク作成時にドライバを指定しなければ、このネットワークになります。 **通常、ブリッジ・ネットワークは、アプリケーションがスタンドアロン・コンテナ内で動作する時、このコンテナが通信するために使います** 。詳しくは :doc:`ブリッジ・ネットワーク <bridge>` をご覧ください。

.. host: For standalone containers, remove network isolation between the container and the Docker host, and use the host’s networking directly. See use the host network.

* ``host`` ：スタンドアロン・コンテナ用で、コンテナと Docker ホスト間のネットワーク隔離を解除し、ホスト側のネットワーク機能を直接使います。 :doc:`host ネットワークを使う <host>` をご覧ください。

..    overlay: Overlay networks connect multiple Docker daemons together and enable swarm services to communicate with each other. You can also use overlay networks to facilitate communication between a swarm service and a standalone container, or between two standalone containers on different Docker daemons. This strategy removes the need to do OS-level routing between these containers. See overlay networks.

* ``overlay`` ：オーバレイ・ネットワークは複数の Docker デーモンと同時に接続し、swarm サービスが相互に通信可能にします。また、オーバレイ・ネットワークを使い、swarm サービスとスタンドアロン・コンテナ間での通信を簡単にします。あるいは、異なる Docker デーモン上で動作する2つのスタンドアロン・コンテナ間で通信できるようにします。この方法を使えば、コンテナ間で OS レベルのルーティング設定を不要にします。 :doc:`オーバレイ・ネットワーク <overlay>` をご覧ください。

.. ipvlan: IPvlan networks give users total control over both IPv4 and IPv6 addressing. The VLAN driver builds on top of that in giving operators complete control of layer 2 VLAN tagging and even IPvlan L3 routing for users interested in underlay network integration. See IPvlan networks.

* ``ipvlan`` ： IPvlan ネットワークは、IPv4 と IPv6 の両 :ruby:`IP アドレス割り当て <addressing>` を、ユーザがまとめてコントロール可能にします。ネットワーク統合に興味があるユーザに対し、レイヤー2 VLAN タギングや、 IPvlan L3 ルーティングも完全に操作可能になるよう VLAN ドライバは構築されています。 :doc:`IPvlan ネットワーク <ipvlan>` をご覧ください。

..    macvlan: Macvlan networks allow you to assign a MAC address to a container, making it appear as a physical device on your network. The Docker daemon routes traffic to containers by their MAC addresses. Using the macvlan driver is sometimes the best choice when dealing with legacy applications that expect to be directly connected to the physical network, rather than routed through the Docker host’s network stack. See Macvlan networks.

* ``macvlan`` ：macvlan ネットワークは、コンテナに対して MAC アドレスを割り当て可能にし、ネットワーク上の物理デバイスとして見えるようにします。Docker デーモンはコンテナの Mac アドレスに従い、トラフィックをコンテナに対して転送します。 ``macvlan`` ドライバの利用は、レガシーなアプリケーションとのやりとり時にベストな選択肢となるでしょう。たとえば、Docker ホストのネットワーク・スタックを使って転送するのではなく、物理ネットワークに対する直接接続を想定している場合です。 :doc:`macvlan ネットワーク <macvlan>` をご覧ください。

..    none: For this container, disable all networking. Usually used in conjunction with a custom network driver. none is not available for swarm services. See disable container networking.

* ``none`` ：コンテナに指定すると、全てのネットワーク機能を無効化します。通常はカスタム・ネットワーク・ドライバとの競合を避けるために掴ます。 ``none`` は swarm サービスでは利用できません。 :doc:`コンテナ・ネットワーク機能の無効化 <none>` をご覧ください。

..     Network plugins: You can install and use third-party network plugins with Docker. These plugins are available from Docker Hub or from third-party vendors. See the vendor’s documentation for installing and using a given network plugin.

* :doc:`ネットワーク・プラグイン </engine/extend/plugins_services>` ：Docker にサードパーティ製のネットワーク・プラグインをインストールして利用できます。これらのプラグインは `Docker Hub <https://hub.docker.com/search?category=network&q=&type=plugin>`_ 上もしくはサードパーティ・ベンダによって提供されています。対象となるネットワーク・プラグインのインストールや利用にあたっては、ベンダのドキュメントをご覧ください。

.. Network driver summary

.. _network-driver-summary:

ネットワーク・ドライバまとめ
------------------------------

..    User-defined bridge networks are best when you need multiple containers to communicate on the same Docker host.
    Host networks are best when the network stack should not be isolated from the Docker host, but you want other aspects of the container to be isolated.
    Overlay networks are best when you need containers running on different Docker hosts to communicate, or when multiple applications work together using swarm services.
    Macvlan networks are best when you are migrating from a VM setup or need your containers to look like physical hosts on your network, each with a unique MAC address.
    Third-party network plugins allow you to integrate Docker with specialized network stacks.

* **ユーザ定義ブリッジ・ネットワーク（user-defined bridge network）** は、同じ Docker ホスト上で、複数のコンテナ間で通信が必要な場合にベストです。
* **ホスト・ネットワーク（host network）** は、Docker ホスト上でネットワーク・スタックを隔離したくないものの、隔離されたコンテナとの通信も必要な場合にベストです。
* **オーバレイ・ネットワーク（overlay network）** は、異なる Docker ホスト上で実行しているコンテナ間で通信が必要な場合や、swarm サービスを使った複数のアプリケーションを同時に動かす場合にベストです。
* **macvlan ネットワーク（macvlan network）** は、仮想マシンのセットアップからの移行や、コンテナがネットワーク上の物理等のホストに接続が必要であれば、それぞれでユニークな MAC アドレスが必要な場合にベストです。
* **サードパーティ・ネットワーク・プラグイン** は、特別なネットワーク・スタックと Docker を統合できます。

.. Networking tutorials

.. _networking-tutorials:

ネットワーク機能チュートリアル
==============================

.. Now that you understand the basics about Docker networks, deepen your understanding using the following tutorials:

以上で、Docker ネットワークの基礎について理解しました。理解を深めるために、以下のチュートリアルをご利用ください。

..    Standalone networking tutorial
    Host networking tutorial
    Overlay networking tutorial
    Macvlan networking tutorial

* :doc:`network-tutorial-standalone`
* :doc:`network-tutorial-host`
* :doc:`network-tutorial-overlay`
* :doc:`network-tutorial-macvlan`


.. seealso:: 

   Networking overview
      https://docs.docker.com/network/