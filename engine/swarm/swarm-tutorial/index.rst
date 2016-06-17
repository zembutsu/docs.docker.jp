.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/swarm/swarm-tutorial/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/swarm/swarm-tutorial/index.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/swarm/swarm-tutorial/index.md
.. check date: 2016/06/17
.. Commits on Jun 16, 2016 bc033cb706fd22e3934968b0dfdf93da962e36a8
.. -----------------------------------------------------------------------------

.. Getting Started with Docker Swarm

.. _getting-started-with-docker-swam:

=======================================
Docker Swarm 導入ガイド
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. This tutorial introduces you to the key features of Docker Swarm. It guides you through the following activities:

このチュートリアルは Docker Swarm の主要機能を紹介します。チュートリアルでは以下の作業を案内します。

..    initializing a cluster of Docker Engines called a Swarm
    adding nodes to the Swarm
    deploying application services to the Swarm
    managing the Swarm once you have everything running

* Swarm と呼ぶ Docker Engine のクラスタを初期化
* Swarm にノードを追加
* アプリケーション・サービスを Swarm にデプロイ
* Swarm で使い始めた後の管理

.. This tutorial uses Docker Engine CLI commands entered on the command line of a terminal window. You should be able to install Docker on networked machines and be comfortable running commands in the shell of your choice.

このチュートリアルは、ターミナル・ウインドウのコマンドライン上で Docker Engine CLI コマンドを実行します。ネットワーク上のマシンに Docker をインストールし、コマンドを実行しやすい好みのシェルを選ぶべきでしょう。

.. If you’re brand new to Docker, see About Docker Engine.

Docker を初めて使う場合は、 :doc:`Docker Engine について </index>` をご覧ください。

.. Set up

.. _swarm-tutorial-setup:

セットアップ
====================

.. To run this tutorial, you need the following:

チュートリアルを進めるためには、以下の条件が必要です：

..    three networked host machines
    Docker Engine 1.12 or later installed
    the IP address of the manager machine
    open ports between the hosts

* :ref:`３台のネットワーク上のマシン <three-networked-host-machine>`
* :ref:`Docker Engine 1.12 以上をインストール <docker-engine-112-or-later>`
* :ref:`マネージャ・マシンの IP アドレス <the-ip-address-of-the-manager-machine>`
* :ref:`ホスト間でポートを開く <open-ports-between-the-hosts>`

.. Three networked host machines

.. _three-networked-host-machine:

３台のネットワーク上のマシン
==============================

.. The tutorial uses three networked host machines as nodes in the Swarm. These can be virtual machines on your PC, in a data center, or on a cloud service provider. This tutorial uses the following machine names:

チュートリアルでは Swarm のノードとしてネットワークにつながる３台のマシンを使います。マシンは PC 上の仮想マシン、データセンタ上のマシン、クラウドサービス事業者のマシンのどれでも構いません。このチュートリアルでは次のマシン名を使います。

..    manager1
    worker1
    worker2

* manager1
* worker1
* worker2

.. Docker Engine 1.12 or later

.. _docker-engine-112-or-later:

Docker Engine 1.12 以上
==============================

.. You must install Docker Engine on each one of the host machines. To use this version of Swarm, install the Docker Engine v1.12.0-rc1 or later from the Docker releases GitHub repository. Alternatively, install the latest Docker for Mac or Docker for Windows Beta.

各ホスト上に Docker Engine をインストールする必要があります。対象となるバージョンの Swarm を使うには、 `Docker releases GitHub リポジトリ <https://github.com/docker/docker/releases>`_ から Docker Engine ``v1.12.0-rc1`` もしくは以降のバージョンをインストールします。あるいは、最新の Docker for Mac か Docker for Windows Beta を使います。

.. Verify that the Docker Engine daemon is running on each of the machines.

各マシン上で Docker Engine デーモンが稼働しているのを確認します。

.. The IP address of the manager machine

.. _the-ip-address-of-the-manager-machine:

マネージャ・マシンの IP アドレス
========================================

.. The IP address must be assigned to an a network interface available to the host operating system. All nodes in the Swarm must be able to access the manager at the IP address.

ホスト・オペレーティングシステムで利用可能なネットワーク・インターフェースに対し、 IP アドレスが割り当てられている必要があります。Swarm 上の全てのノードは、この IP アドレスを使ってマネージャにアクセスします。

..    Tip: You can run ifconfig on Linux or Mac OSX to see a list of the available network interfaces.

.. tip::

   Linux や Mac OSX 上では ``ifconfig``  を実行したら、利用可能なネットワーク・インターフェースの一覧を表示します。

.. The tutorial uses manager1 : 192.168.99.100.

このチュートリアルでは ``manager1``  を ``192.168.99.100`` とします。

.. Open ports between the hosts

.. _open-ports-between-the-hosts:

ホスト間のポートを開く
==============================

..    TCP port 2377 for cluster management communications
    TCP and UDP port 7946 for communication among nodes
    TCP and UDP port 4789 for overlay network traffic

* **TCP ポート 2377** はクラスタ管理通信用
* **TCP・UDP ポート 7946** はノード間の通信
* **TCP・UDP ポート 4789** はオーバレイ・ネットワークの通信

..    Tip: Docker recommends that every node in the cluster be on the same layer 3 (IP) subnet with all traffic permitted between nodes.

.. tip::

   Docker が推奨のは、各ノードを同じレイヤ３（IP）サブネット上におき、ノード間で全てのトラフィックを許可する方法です。

.. What's next?

次は何をしますか？
====================

.. After you have set up your environment, you're ready to create a Swarm.

環境のセットアップを終えたら、 :doc:`Swarm を作成 <create-swarm>` する準備が整いました。


.. seealso:: 

   Getting Started with Docker Swarm
      https://docs.docker.com/engine/swarm/swarm-tutorial/
