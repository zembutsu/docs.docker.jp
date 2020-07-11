.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/swarm/swarm-tutorial/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/swarm/swarm-tutorial/index.md
   doc version: 19.03
.. check date: 2020/07/07
.. Commits on Apr 8, 2020 777c5d23dafd4b640016f24f92fe416f246ec848
.. -----------------------------------------------------------------------------

.. Getting Started with swarm mode

.. _getting-started-with-swam-mode:

=======================================
swarm モード導入ガイド
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. This tutorial introduces you to the features of Docker Engine Swarm mode. You may want to familiarize yourself with the key concepts before you begin.

このチュートリアルは Docker Engine Swarm モードの機能を紹介します。始める前に、よろしければ :doc:`重要な概念 <../key-concepts>` に慣れておいてください。

.. The tutorial guides you through the following activities:

このチュートリアルは以下の作業を紹介します。

..    initializing a cluster of Docker Engines in swarm mode
    adding nodes to the swarm
    deploying application services to the swarm
    managing the swarm once you have everything running

* Docker Engine の swarm モードでクラスタを初期化
* swarm にノードを追加
* アプリケーション・サービスを swarm にデプロイ
* swarm を使い始めた後の管理

.. This tutorial uses Docker Engine CLI commands entered on the command line of a terminal window.

このチュートリアルは、ターミナル・ウインドウのコマンドライン上で Docker Engine CLI コマンドを実行します。

.. If you’re brand new to Docker, see About Docker Engine.

Docker を初めて使う場合は、 :doc:`Docker Engine について </engine/index>` をご覧ください。

.. Set up

.. _swarm-tutorial-setup:

セットアップ
====================

.. To run this tutorial, you need the following:

チュートリアルを進めるためには、以下の条件が必要です：

..  three Linux hosts which can communicate over a network, with Docker installed
    Docker Engine 1.12 or later installed
    the IP address of the manager machine
    open ports between the hosts

* :ref:`Docker をインストール済みの、ネットワーク上で通信可能な Linux ホスト <three-networked-host-machine>`
* :ref:`Docker Engine 1.12 以上をインストール <docker-engine-112-or-later>`
* :ref:`マネージャ・マシンの IP アドレス <the-ip-address-of-the-manager-machine>`
* :ref:`ホスト間でポートを開く <open-ports-between-the-hosts>`

.. Three networked host machines

.. _three-networked-host-machine:

接続した3台のマシン
==============================

.. This tutorial requires three Linux hosts which have Docker installed and can communicate over a network. These can be physical machines, virtual machines, Amazon EC2 instances, or hosted in some other way. You can even use Docker Machine from a Linux, Mac, or Windows host. Check out Getting started - Swarms for one possible set-up for the hosts.

このチュートリアルでは、 Docker がインストール済みで、ネットワーク上で通信可能な Linux ホストが3台必要です。これらは物理マシン、仮想マシン、Amazon EC2 インスタンスや、何らかの方法でホストされたものであれば構いません。あるいは Linux 、 Mac 、 Windows 上で Docker Machine も使えます。3台のホストをセットアップする手順は、 :doc:`/get-started/swarm-deploy` をご覧ください。

.. One of these machines is a manager (called manager1) and two of them are workers (worker1 and worker2).

各マシンは、1つは manager（ ``manager1`` と呼びます）、2つは worker （ ``worker1`` と ``worker2`` ）です。

.. Note: You can follow many of the tutorial steps to test single-node swarm as well, in which case you need only one host. Multi-node commands do not work, but you can initialize a swarm, create services, and scale them.

.. note::

   チュートリアルの多くの手順は、1つのホストしかないような、単位ノードの swarm 上でも同じようにテストできます。マルチノードのコマンドは動作しませんが、swarm の初期化、サービス作成、サービスのスケールは行えます。

.. Docker Engine 1.12 or later

.. _docker-engine-112-or-later:

Docker Engine 1.12 以上
==============================

.. This tutorial requires Docker Engine 1.12 or newer on each of the host machines. Install Docker Engine and verify that the Docker Engine daemon is running on each of the machines. You can get the latest version of Docker Engine as follows:

このチュートリアルでは、各ホストマシン上に Docker Engine 1.12 以上をインストールする必要があります。Docker Engine をインストールしたら、各マシン上で Docker Engine デーモンが実行中かどうか確認します。Docker の最新版は、以下の方法で入手できます。

..  install Docker Engine on Linux machines
    use Docker Desktop for Mac or Docker Desktop for Windows

* :ref:`swarm-install-docker-engine-on-linux-machines`
* :ref:`swarm-use-docker-desktop-for-mac-or-docker-desktop-for-windows`

.. Install Docker Engine on Linux machines

.. _swarm-install-docker-engine-on-linux-machines:

Linux マシン上に Docker Engine をインストール
------------------------------------------------------------

.. If you are using Linux based physical computers or cloud-provided computers as hosts, simply follow the Linux install instructions for your platform. Spin up the three machines, and you are ready. You can test both single-node and multi-node swarm scenarios on Linux machines.

Linux をベースとする物理コンピュータやクラウドが提供するコンピュータを、ホストとして使用する場合は、シンプルにプラットフォームに対応した :doc:`Linux インストール手順 </engine/install>` に従います。3台のマシンを起動したら、準備完了です。Linux マシン上の単一ノードおよび複数ノードの swarm 両方をテストできます。

.. Use Docker Desktop for Mac or Docker Desktop for Windows

.. _swarm-use-docker-desktop-for-mac-or-docker-desktop-for-windows:

Docker desktop for mac か Docker Desktop for Windows を使う
------------------------------------------------------------

.. Alternatively, install the latest Docker Desktop for Mac or Docker Desktop for Windows application on one computer. You can test both single-node and multi-node swarm from this computer, but you need to use Docker Machine to test the multi-node scenarios.

別の方法として、 :doc:`Docker Desktop for Mac </docker-for-mac/index>` や :doc:`Docker Desktop for Windows </docker-for-windows/index>` アプリケーションをコンピュータ上にインストールします。そのコンピュータ上で単一ノードと複数ノード swarmの両方をテストできます。しかし、複数ノードのシナリオをテストするには Docker Machine が必要です。

..    You can use Docker Desktop for Mac or Windows to test single-node features of swarm mode, including initializing a swarm with a single node, creating services, and scaling services. Docker “Moby” on Hyperkit (Mac) or Hyper-V (Windows) serve as the single swarm node.

* Docker Desktop for Mac や Windows では、swarm モードの単一ノード機能のテストを行えます。この中には、単一ノードの swarm 初期化、サービスの作成、サービスのスケールを含みます。 Hyperkit (Mac) や Hyper-V (Windows) 上の Docker "Moby" が提供するのは、単一の swarm ノードです。

..  Currently, you cannot use Docker Desktop for Mac or Docker Desktop for Windows alone to test a multi-node swarm. However, you can use the included version of Docker Machine to create the swarm nodes (see Get started with Docker Machine and a local VM), then follow the tutorial for all multi-node features. For this scenario, you run commands from a Docker Desktop for Mac or Docker Desktop for Windows host, but that Docker host itself is not participating in the swarm. After you create the nodes, you can run all swarm commands as shown from the Mac terminal or Windows PowerShell with Docker Desktop for Mac or Docker Desktop for Windows running.

* 現時点では、 Docker Desktop for Mac や Docker Desktop for Windows 単独では、複数ノード swarm のテストを行えません。しかしながら、 :doc:`Docker Machine </machine/overview>` に含まれるバージョンであれば、swarm ノードを作成し（ :doc:`/machine/get-started` をご覧ください）、以降すべての複数ノード機能のチュートリアルを行えます。この場合、Docker Desktop for Mac や Docker Desktop for Windows ホスト上でコマンドを実行しますが、Docker ホスト自身は swarm に参加しません。ノードを作成したあとは、Docker Desktop for Mac や Docker Desktop for Windows を実行している Mac ターミナルや Windows PowerShell を通し、すべての swarm コマンドを実行可能です。

.. The IP address of the manager machine

.. _the-ip-address-of-the-manager-machine:

manager マシンの IP アドレス
==============================

.. The IP address must be assigned to a network interface available to the host operating system. All nodes in the swarm need to connect to the manager at the IP address.

IP アドレスはホスト・オペレーティングシステム上で利用可能なネットワーク・インターフェースに対して割り当てる必要があります。swarm 上の全てのノードが、その IP アドレスに対して manager が接続するために必要です。

.. Because other nodes contact the manager node on its IP address, you should use a fixed IP address.

そのため、他のノードが manager ノードに通信するには、manager ノードの IP アドレスが必要になるため、この IP アドレスは固定しておくべきでしょう。

.. You can run ifconfig on Linux or macOS to see a list of the available network interfaces.

Linux や macOS では ``ifconfig`` を実行し、利用可能なネットワーク・インターフェースの一覧を表示します。

.. If you are using Docker Machine, you can get the manager IP with either docker-machine ls or docker-machine ip <MACHINE-NAME> — for example, docker-machine ip manager1.

Docker Machine を使っている場合は、マネージャの IP アドレスの取得は ``docker-machine ls`` や ``docker-machine ip <MACHINE-NAME>``  、たとえば ``docker-machine ip manager1`` のようにの、どちらかで行えます。

.. The tutorial uses manager1 : 192.168.99.100.

チュートリアルでは ``manager`` は ``192.168.99.100`` です。

.. Open protocols and ports between the hosts

.. _open-protocols-and-ports-between-the-hosts:

ホスト間で開くプロトコルとポート
========================================

.. The following ports must be available. On some systems, these ports are open by default.

以下のポートの利用が必須です。いくつかのシステム上では、各ポートがデフォルトで開いています。

..  TCP port 2377 for cluster management communications
    TCP and UDP port 7946 for communication among nodes
    UDP port 4789 for overlay network traffic

* **TCP port 2377**  は、クラスタ管理通信のため
* **TCP** と **UDP**  の **port 7946** は、ノード間の通信のため
* **UDP port 4789** はオーバレイ・ネットワーク・トラフィックのため

.. If you plan on creating an overlay network with encryption (--opt encrypted), you also need to ensure ip protocol 50 (ESP) traffic is allowed.

暗号化したオーバレイ・ネットワーク（ ``--opt encrypted`` ）の利用を計画中であれば、 **ip プロトコル 50 (ESP)**  トラフィックの許可も必要です。


.. What's next?

次は何をしますか？
====================

.. After you have set up your environment, you are ready to create a swarm.

環境のセットアップを終えたら、 :doc:`swarm を作成 <create-swarm>` する準備が整いました。


.. seealso:: 

   Getting Started with swarm mode
      https://docs.docker.com/engine/swarm/swarm-tutorial/
