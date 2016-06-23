.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/swarm/swarm-tutorial/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/swarm/swarm-tutorial/index.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/swarm/swarm-tutorial/index.md
.. check date: 2016/06/21
.. Commits on Jun 19, 2016 9499d5fd522e2fa31e5d0458c4eb9b420f164096
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

チュートリアルは以下の作業を紹介します。

..    initializing a cluster of Docker Engines in swarm mode
    adding nodes to the swarm
    deploying application services to the swarm
    managing the swarm once you have everything running

* Docker Engine の swarm モードでクラスタを初期化
* swarm にノードを追加
* アプリケーション・サービスを swarm にデプロイ
* swarm を使い始めた後の管理

.. This tutorial uses Docker Engine CLI commands entered on the command line of a terminal window. You should be able to install Docker on networked machines and be comfortable running commands in the shell of your choice.

このチュートリアルは、ターミナル・ウインドウのコマンドライン上で Docker Engine CLI コマンドを実行します。ネットワーク上のマシンに Docker をインストールし、コマンドを実行しやすい好みのシェルを選ぶべきでしょう。

.. If you’re brand new to Docker, see About Docker Engine.

Docker を初めて使う場合は、 :doc:`Docker Engine について </engine/index>` をご覧ください。

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

.. The tutorial uses three networked host machines as nodes in the swarm. These can be virtual machines on your PC, in a data center, or on a cloud service provider. This tutorial uses the following machine names:

チュートリアルでは swarm のノードとしてネットワークにつながる３台のマシンを使います。マシンは PC 上の仮想マシン、データセンタ上のマシン、クラウドサービス事業者のマシンのどれでも構いません。このチュートリアルでは次のマシン名を使います。

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

.. Advisory: Some multi-node features may not work for Docker for Mac Beta and Docker for Windows Beta. We're working on the multi-node features for GA.

.. hint::

   マルチ・ノード機能は Docker for Mac Beta と Docker for Windows Beta では動作しない可能性があります。マルチ・ノード機能は一般リリース（GA）に向けて作業中です。

.. Verify that the Docker Engine daemon is running on each of the machines.

各マシン上で Docker Engine デーモンが稼働しているのを確認します。

.. The IP address of the manager machine

.. _the-ip-address-of-the-manager-machine:

マネージャ・マシンの IP アドレス
========================================

.. The IP address must be assigned to an a network interface available to the host operating system. All nodes in the swarm must be able to access the manager at the IP address.

ホスト・オペレーティングシステムで利用可能なネットワーク・インターフェースに対し、 IP アドレスが割り当てられている必要があります。swarm 上の全てのノードは、この IP アドレスを使ってマネージャにアクセスします。

..    Tip: You can run ifconfig on Linux or Mac OS X to see a list of the available network interfaces.

.. tip::

   Linux や Mac OS X 上では ``ifconfig``  を実行したら、利用可能なネットワーク・インターフェースの一覧を表示します。

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

   Docker が推奨するのは、各ノードを同じレイヤ３（IP）サブネット上におき、ノード間で全てのトラフィックを許可する方法です。

.. What's next?

次は何をしますか？
====================

.. After you have set up your environment, you're ready to create a swarm.

環境のセットアップを終えたら、 :doc:`swarm を作成 <create-swarm>` する準備が整いました。


.. seealso:: 

   Getting Started with swarm mode
      https://docs.docker.com/engine/swarm/swarm-tutorial/
