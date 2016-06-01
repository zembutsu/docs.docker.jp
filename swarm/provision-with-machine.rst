.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/swarm/provision-with-machine/
.. SOURCE: https://github.com/docker/swarm/blob/master/docs/provision-with-machine.md
   doc version: 1.11
      https://github.com/docker/swarm/commits/master/docs/provision-with-machine.md
.. check date: 2016/04/29
.. Commits on Mar 23, 2016 4b0b029ce2b1a69ad14ae48e148b737cd0723d3a
.. -------------------------------------------------------------------

.. Provision a Swarm cluster with Docker Machine

.. _provision-a-swarm-cluster-with-docker-machine:

==================================================
Docker Machine で Swarm クラスタ構築
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. You can use Docker Machine to provision a Docker Swarm cluster. Machine is the Docker provisioning tool. Machine provisions the hosts, installs Docker Engine on them, and then configures the Docker CLI client. With Machine’s Swarm options, you can also quickly configure a Swarm cluster as part of this provisioning.

Docker Machine を使って Docker Swarm クラスタをプロビジョン（自動構築）できます。Docker Machine とは Docker のプロビジョニング・ツールです。Machine はホストをプロビジョンし、そこに Docker Engine をインストールし、Docker CLI クライアント用の設定を行います。Machine で Swarm 用のオプションを指定したら、プロビジョニングの過程で Swarm クラスタ用の設定も迅速に行えます。

.. This page explains the commands you need to provision a basic Swarm cluster on a local Mac or Windows computer using Machine. Once you understand the process, you can use it to setup a Swarm cluster on a cloud provider, or inside your company’s data center.

このページでは、Machine で基本的な Swarm クラスタを構築するために必要なコマンドを紹介します。ローカルの Mac もしくは Windows 上に環境を構築します。流れを理解してしまえば、クラウド・プロバイダ上や、あるいは会社のデータセンタ内にも Swarm クラスタをセットアップできるようになるでしょう。

.. If this is the first time you are creating a Swarm cluster, you should first learn about Swarm and its requirements by installing a Swarm for evaluation or installing a Swarm for production. If this is the first time you have used Machine, you should take some time to understand Machine before continuing.

Swarm クラスタの構築が初めてであれば、まず Swarm について学び、 :doc:`install-w-machine` や :doc:`install-manual` を読んでおく必要があります。Machine を使うのが初めてであれば、 :doc:`Machine を使う前に概要の理解 </machine/overview>` が望ましいでしょう。

.. What you need

.. _waht-you-need:

何が必要ですか？
====================

.. If you are using Mac OS X or Windows and have installed with Docker Toolbox, you should already have Machine installed. If you need to install, see the instructions for Mac OS X or Windows.

Mac OS X や Windows で Docker Toolbox を使ってインストールしていた場合は、既に Docker Machine がインストール済みです。インストールの必要があれば、 :doc:`Mac OS X </engine/installation/mac>` または :doc:`Windows </engine/installation/windows>` のページをご覧ください。

.. Machine supports installing on AWS, Digital Ocean, Google Cloud Platform, IBM Softlayer, Microsoft Azure and Hyper-V, OpenStack, Rackspace, VirtualBox, VMware Fusion®, vCloud® AirTM and vSphere®. In this example, you’ll use VirtualBox to run several VMs based on the boot2docker.iso image. This image is a small-footprint Linux distribution for running Engine.

Machine を使ったインストールをサポートしているのは、AWS 、 Digital Ocean 、 Google Cloud Platform 、 IBM SoftLayer 、 Microsoft Azure 、 Hyper-V 、 OpenStack 、 RackSpace 、 VirtualBox 、 VMware Fusion 、vCloud Air 、 vSphere です。このページの例では VirtualBox 上で ``boot2docker.iso`` イメージを使った仮想マシンをいくつか起動します。このイメージは Docker Engine を実行するための最小ディストリビューションです。

.. The Toolbox installation gives you VirtualBox and the boot2docker.iso image you need. It also gives you the ability provision on all the systems Machine supports.

Toolbox をインストールしたら、 VirtualBox と必要に応じて ``boot2docker.iso`` イメージが用意されます。また、Machine がサポートするあらゆるシステム上へプロビジョン可能です。

.. Note:These examples assume you are using Mac OS X or Windows, if you like you can also install Docker Machine directly on a Linux system.

.. note::

   この例では Mac OS X もしくは Windows の利用を想定していますが、 :doc:`Docker Machine は Linux システム上に直接インストール可能です </machine/install-machine>` 。

.. Provision a host to generate a Swarm token

.. _provision-a-host-to-generate-a-swam-token:

Swarm トークンをホスト上で生成
==============================

.. Before you can configure a Swarm, you start by provisioning a host with Engine. Open a terminal on the host where you installed Machine. Then, to provision a host called local, do the following:

Swarm の設定を始める前に、Docker Engine の動くホストをプロビジョニングする必要があります。Machine をインストールしたホスト上のターミナルを開きます。それから ``local`` という名称のホストをプロビジョニングするため、次のように実行します。

.. code-block:: bash

   docker-machine create -d virtualbox local

.. This examples uses VirtualBox but it could easily be DigitalOcean or a host on your data center. The local value is the host name. Once you create it, configure your terminal’s shell environment to interact with the local host.

この例では VirtualBox を指定していますが、DigitalOcean やデータセンタ内のホストでも簡単に作成できます。 ``local`` の値はホスト名です。作成したら、自分のターミナル上で ``local`` ホストと通信できるように、環境変数を指定します。

.. code-block:: bash

   eval "$(docker-machine env local)"

.. Each Swarm host has a token installed into its Engine configuration. The token allows the Swarm discovery backend to recognize a node as belonging to a particular Swarm cluster. Create the token for your cluster by running the swarm image:

各 Swarm ホストでは、 Engine の設定時にトークンも指定します。このトークンは Swarm ディスカバリ・バックエンドが Swarm クラスタの適切なノードであることを認識するために必要です。クラスタ用のトークンを作成するには、 ``swarm`` イメージを実行します。

.. code-block:: bash

   docker run swarm create
   Unable to find image 'swarm' locally
   1.1.0-rc2: Pulling from library/swarm
   892cb307750a: Pull complete
   fe3c9860e6d5: Pull complete
   cc01ef3f1fbc: Pull complete
   b7e14a9c9c72: Pull complete
   3ec746117013: Pull complete
   703cb7acfce6: Pull complete
   d4f6bb678158: Pull complete
   2ad500e1bf96: Pull complete
   Digest: sha256:f02993cd1afd86b399f35dc7ca0240969e971c92b0232a8839cf17a37d6e7009
   Status: Downloaded newer image for swarm
   0de84fa62a1d9e9cc2156111f63ac31f

.. The output of the swarm create command is a cluster token. Copy the token to a safe place you will remember. Once you have the token, you can provision the Swarm nodes and join them to the cluster_id. The rest of this documentation, refers to this token as the SWARM_CLUSTER_TOKEN.

``swarm create`` コマンドの出力結果がクラスタ用のトークンです。このトークンを安全な場所にコピーして覚えておきます。このトークンは、Swarm ノードのプロビジョニング時や、そのノードをクラスタに追加する時のクラスタ ID として使います。トークンはこの後で環境変数 ``SWARM_CLUSTER_TOKEN`` として参照します。

.. Provision Swarm nodes

.. _provision-swam-nodes:

Swarm ノードのプロビジョン
==============================

.. All Swarm nodes in a cluster must have Engine installed. With Machine and the SWARM_CLUSTER_TOKEN you can provision a host with Engine and configure it as a Swarm node with one Machine command. To create a Swarm manager node on a new VM called swarm-manager, you do the following:

クラスタの全てのノードは Engine をインストールしている必要があります。Machine で ``SWARM_CLUSTER_TOKEN`` を使えば、Machine でコマンドを１つ実行するだけで、Engine のホストをプロビジョニングし、Swarm のノードとして設定された状態にします。新しい仮想マシンを Swarm マネージャ・ノードの ``swarm-manager`` として作成します。

.. code-block:: bash

   docker-machine create \
       -d virtualbox \
       --swarm \
       --swarm-master \
       --swarm-discovery token://SWARM_CLUSTER_TOKEN \
       swarm-manager

.. Then, provision an additional node. You must supply the SWARM_CLUSTER_TOKEN and a unique name for each host node, HOST_NODE_NAME.

次に追加用のノードをプロビジョニングします。ここでも ``SWARM_CLUSTER_TOKEN`` を指定する必要があります。そして、各ホストには ``HOST_NODE_NAME`` でユニークな名前を付ける必要があります。

.. code-block:: bash

   docker-machine create \
       -d virtualbox \
       --swarm \
       --swarm-discovery token://SWARM_CLUSTER_TOKEN \
       HOST_NODE_NAME

.. For example, you might use node-01 as the HOST_NODE_NAME in the previous example.

例えば、 ``HOST_NODE_NAME`` には ``node-01`` のような名前を指定するでしょう。

..    Note: These command rely on Docker Swarm’s hosted discovery service, Docker Hub. If Docker Hub or your network is having issues, these commands may fail. Check the Docker Hub status page for service availability. If the problem Docker Hub, you can wait for it to recover or configure other types of discovery backends.

.. note::

   ここまで実行したコマンドは Docker Hub が提供している Docker Swarm のホステッド・ディスカバリ・サービスに依存しています。もしも Docker Hub あるいはネットワークに問題があれば、これらのコマンド実行に失敗するでしょう。サービスが利用可能かどうか、 `Docker Hub ステータス・ページ <http://status.docker.com/>`_ をご確認ください。Docker Hub で問題がある場合は復旧まで待つか、あるいは、別のディスカバリ・バックエンドの設定をご検討ください。


.. Connect node environments with Machine

.. _connect-node-environments-with-machine:

Machine でノード環境に接続
==============================

.. If you are connecting to typical host environment with Machine, you use the env subcommand, like this:

Machine 接続先のホストを環境変数で指定するには、 ``env`` サブコマンドの利用が一般的です。

.. code-block:: bash

   eval "$(docker-machine env local)"

.. Docker Machine provides a special --swarm flag with its env command to connect to Swarm nodes.

Docker Machine には、 ``env`` コマンドで Swarm ノードに接続するための、特別な ``--swarm`` フラグがあります。

.. code-block:: bash

   docker-machine env --swarm HOST_NODE_NAME
   export DOCKER_TLS_VERIFY="1"
   export DOCKER_HOST="tcp://192.168.99.101:3376"
   export DOCKER_CERT_PATH="/Users/mary/.docker/machine/machines/swarm-manager"
   export DOCKER_MACHINE_NAME="swarm-manager"
   # Run this command to configure your shell:
   # eval $(docker-machine env --swarm HOST_NODE_NAME)

.. To set your SHELL connect to a Swarm node called swarm-manager, you would do this:

シェル上の操作を ``swarm-manager`` という名称の Swarm ノードに切り替えるには、次のように実行します。

.. code-block:: bash

   eval "$(docker-machine env --swarm swarm-manager)"

.. Now, you can use the Docker CLI to query and interact with your cluster.

これで Docker CLI を使ってクラスタと相互に通信できるようになりました。

.. code-block:: bash

   docker info
   Containers: 2
   Images: 1
   Role: primary
   Strategy: spread
   Filters: health, port, dependency, affinity, constraint
   Nodes: 1
    swarm-manager: 192.168.99.101:2376
     └ Status: Healthy
     └ Containers: 2
     └ Reserved CPUs: 0 / 1
     └ Reserved Memory: 0 B / 1.021 GiB
     └ Labels: executiondriver=native-0.2, kernelversion=4.1.13-boot2docker, operatingsystem=Boot2Docker 1.9.1 (TCL 6.4.1); master : cef800b - Fri Nov 20 19:33:59 UTC 2015, provider=virtualbox, storagedriver=aufs
   CPUs: 1
   Total Memory: 1.021 GiB
   Name: swarm-manager

.. Related information

関連情報
==========

..    Evaluate Swarm in a sandbox
    Build a Swarm cluster for production
    Swarm Discovery
    Docker Machine documentation

* :doc:`install-w-machine`
* :doc:`install-manual`
* :doc:`discovery`
* :doc:`Docker Machine </machine/index>` ドキュメント

.. seealso:: 

   Provision a Swarm cluster with Docker Machine
      https://docs.docker.com/swarm/provision-with-machine/
