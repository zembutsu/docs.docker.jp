.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/understanding-docker/
   -> https://docs.docker.com/engine/docker-overview/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/understanding-docker.md
   doc version: 17.06
      https://github.com/docker/docker.github.io/blob/master/engine/docker-overview.md
.. check date: 2017/09/23
.. Commits on Sep 12, 2017 4c0a508a41534c2f8b8c50ab41f54625a7c7a26c
.. -----------------------------------------------------------------------------

.. sidebar:: 目次

   .. contents:: 
       :depth: 2
       :local:

.. Docker Overview

.. _docker-overview:

=======================================
Docker 概要
=======================================

.. Docker is an open platform for developing, shipping, and running applications.
   Docker enables you to separate your applications from your infrastructure so
   you can deliver software quickly. With Docker, you can manage your infrastructure
   in the same ways you manage your applications. By taking advantage of Docker's
   methodologies for shipping, testing, and deploying code quickly, you can
   significantly reduce the delay between writing code and running it in production.

Docker はアプリケーションの開発、導入、実行を行うためのオープンなプラットフォームです。
Docker を使えば、アプリケーションをインフラストラクチャーから切り離すことができるため、ソフトウエアをすばやく提供することができます。
Docker であれば、アプリケーションを管理する手法をそのまま、インフラストラクチャーの管理にも適用できます。
Docker が採用する方法を最大限利用して、アプリケーションの導入、テスト、コードデプロイをすばやく行うことは、つまりコーディングと実稼動の合間を大きく軽減できることを意味します。

.. The Docker platform

.. _the-docker-platform:

Docker プラットフォーム
==============================

.. Docker provides the ability to package and run an application in a loosely isolated
   environment called a container. The isolation and security allow you to run many
   containers simultaneously on a given host. Containers are lightweight because
   they don’t need the extra load of a hypervisor, but run directly within the host
   machine’s kernel. This means you can run more containers on a given hardware
   combination than if you were using virtual machines. You can even run Docker
   containers within host machines that are actually virtual machines!

Docker はアプリケーションをパッケージ化して実行するために、ほぼ分離された環境 [#f1]_ となるコンテナというものを提供します。
隔離してセキュリティを保つことから、実行するホスト上に複数のコンテナを同時に実行することができます。
コンテナは非常に軽量なものとなります。
なぜならハイパーバイザーを別途ロードする必要などなく、ホストマシンのカーネルを使って動作するからです。
このことは手元にあるハードウェアの中から、必要なものを使ってより多くのコンテナが実行できることを意味します。
それは仮想マシンを使う以上のことです。
さらに Docker コンテナを動作させるホストマシンは、それ自体が仮想マシンであっても構わないのです。

.. Docker provides tooling and a platform to manage the lifecycle of your containers:

Docker が提供するのは、コンテナのライフサイクルを管理するツールとプラットフォームです。

.. * Develop your application and its supporting components using containers.
   * The container becomes the unit for distributing and testing your application.
   * When you're ready, deploy your application into your production environment,
     as a container or an orchestrated service. This works the same whether your
     production environment is a local data center, a cloud provider, or a hybrid
     of the two.

* コンテナを利用して、アプリケーションとそれをサポートするコンポーネント [#f2]_ を開発します。
* コンテナは、アプリケーションの配布とテストを行う１つの単位となります。
* 準備ができたら本番環境に向けてアプリケーションをデプロイします。デプロイの単位は、１つのコンテナか、あるいはオーケストレーション（orchestrated [#f3]_ ）された１つのサービスです。その本番環境があたかも手元のデータセンタ上であったり、クラウドプロバイダ上であったりするのと同様に動作します。

.. rubric:: 訳者注

.. [#f1] 隔離された環境とは "isolated environment" の訳。隔離されて離された環境というよりも、部屋の中を仕切るようなイメージが近いです
.. [#f2] このコンポーネントとは、Docker をとりまく各種ツール群やサービスです
.. [#f3] 原文は "orchestrated service" 。複数台のサーバ上で、サービスを一斉かつ自動的に制御する動作です

Docker Engine
==============================

.. Docker Engine is a client-server application with these major components:

Docker Engine は、主に以下の３つのコンポーネントからなるクライアントサーバ型アプリケーションです。

.. * A server which is a type of long-running program called a daemon process (the
     `dockerd` command).
    * A REST API which specifies interfaces that programs can use to talk to the
     daemon and instruct it what to do.
   * A command line interface (CLI) client (the `docker` command).

* サーバ。長時間稼動する種類のプログラムでありデーモン・プロセスと呼ばれる（ ``dockerd`` コマンド）。
* REST API。プログラムとデーモンとの間での通信方法を定義し、何をなすべきかを指示する。
* コマンドライン・インターフェース（command line interface; CLI）クライアント（ ``docker`` コマンド）。

.. Docker Engine Components Flow

.. image:: /engine/article-img/engine-components-flow.png
   :scale: 60%
   :alt: Docker Engine コンポーネント図

.. The CLI uses the Docker REST API to control or interact with the Docker daemon
   through scripting or direct CLI commands. Many other Docker applications use the
   underlying API and CLI.

CLI は Docker REST API を通じて、スクリプトや直接のコマンド実行により Docker デーモンを制御したり入出力を行ったりします。
Docker アプリケーションの多くが、基本的なところで API や CLI を利用しています。

.. The daemon creates and manages Docker objects, such as images, containers, networks, and volumes.

デーモンは Docker オブジェクトを作成・管理します。Docker オブジェクトとは、イメージ、コンテナ、ネットワーク、データ・ボリューム等です。

..    Note: Docker is licensed under the open source Apache 2.0 license.

.. note::

   Docker のライセンスは、オープンソース Apache 2.0 ライセンスの下で供与されています。

Docker の詳細についれは、 :ref:`docker-architecture` をお読みください。


.. What can I use Docker for?

.. _what-can-i-use-docker-for:

何のために Docker を使うのですか？
========================================

.. Fast, consistent delivery of your applications
.. _fast-consistent-delivery-of-your-applications:

速く、一貫性のあるアプリケーションのデリバリ
--------------------------------------------------

.. Docker streamlines the development lifecycle by allowing developers to work in standardized environments using local containers which provide your applications and services. Containers are great for continuous integration and continuous development (CI/CD) workflows.

Docker の開発ライフサイクルが効率的なのは、開発者がローカルなコンテナが提供するアプリケーションやサービスを通し、標準的な環境で作業できるからです。コンテナは継続的インテグレーションと継続できデプロイメント（CI/CD）ワークフローに最適です。

.. Consider the following example scenario:

以下のシナリオ例が考えられます：

..    Your developers write code locally and share their work with their colleagues using Docker containers.
    They use Docker to push their applications into a test environment and execute automated and manual tests.
    When developers find bugs, they can fix them in the development environment and redeploy them to the test environment for testing and validation.
    When testing is complete, getting the fix to the customer is as simple as pushing the updated image to the production environment.

* 開発者がローカルでコードを書き、同僚と作業時に共有するために Docker コンテナを使う
* アプリケーションをテスト環境への送信や、自動実行、手動テストのために Docker を使う
* 開発者がバグを発見したら、開発環境で問題を修正し、テストと確認のためにテスト環境に再デプロイする
* テストが完了したら、プロダクション環境に単純に送信し、イメージを入れ替えるだけで、利用者は修正版を利用できる

.. Responsive deployment and scaling
.. _responsive-deployment-and-scaling:

即応性のあるデプロイとスケーリング
----------------------------------------

.. Docker’s container-based platform allows for highly portable workloads. Docker containers can run on a developer’s local laptop, on physical or virtual machines in a data center, on cloud providers, or in a mixture of environments.

Docker はコンテナをベースとしたプラットフォームのため、移動性の高い処理（highly portable workloads）を行えます。Docker コンテナは開発者のローカル PC 上で実行できるだけでなく、データセンタの物理あるいは仮想マシン、クラウドプロバイダ、あるいは様々な環境の組み合わせにおいても実行可能です。

.. Docker’s portability and lightweight nature also make it easy to dynamically manage workloads, scaling up or tearing down applications and services as business needs dictate, in near real time.

また、Docker の移動性と軽量な特性により、ビジネスにおける必要性に応じ、ほぼリアルタイムでアプリケーションやサービスをスケールアップ（拡張）やティアダウン（解体）するといった、動的な処理の管理を行いやすくします。


.. Running more workloads on the same hardware
.. _running-more-workloads-on-the-same-hardware:

同じハードウェア上でより多くの処理を実行
----------------------------------------

.. Docker is lightweight and fast. It provides a viable, cost-effective alternative to hypervisor-based virtual machines, so you can use more of your compute capacity to achieve your business goals. Docker is perfect for high density environments and for small and medium deployments where you need to do more with fewer resources.

Docker は軽量かつ高速です。これはハイパーバイザーをベースとした仮想化マシンよりも、費用対効果を高くします。そのため、皆さんの計算能力を、ビジネスにおけるゴールに到達するために利用できるのです。Docker が最適なのは、高密度の環境や、より少ないリソースを必要とする中小規模のデプロイです。


.. Docker architecture
.. _docker-architecture:

Docker のアーキテクチャ
==============================

.. Docker uses a client-server architecture. The Docker client talks to the Docker daemon, which does the heavy lifting of building, running, and distributing your Docker containers. The Docker client and daemon can run on the same system, or you can connect a Docker client to a remote Docker daemon. The Docker client and daemon communicate using a REST API, over UNIX sockets or a network interface.

Docker はクライアント・サーバ型のアーキテクチャです。Docker *クライアント* が Docker コンテナの構築・実行・配布といった力仕事をするには、 Docker *デーモン* と通信します。 Docker クライアントとデーモンは、どちらも同じシステム上で実行できます。また、Docker クライアントはリモートの Docker デーモンにも接続できます。Docker クライアントとデーモンは、お互いに UNIX ソケットやネットワーク・インターフェースを通し、 RESTful API を使って通信します。

.. image:: ./article-img/architecture.png
   :scale: 60%
   :alt: Docker アーキテクチャ図

.. The Docker daemon

Docker デーモン
--------------------

.. The Docker daemon (dockerd) listens for Docker API requests and manages Docker objects such as images, containers, networks, and volumes. A daemon can also communicate with other daemons to manage Docker services.

Docker デーモン（ ``dockerd`` ）は Docker API リクエストを受け付け、イメージ、コンテナ、ネットワーク、ボリュームといった Docker オブジェクトを管理します。また、Docker サービスを管理するため、デーモンは他のデーモンと通信できます。

.. The Docker client

Docker クライアント
--------------------

.. The Docker client (docker) is the primary way that many Docker users interact with Docker. When you use commands such as docker run, the client sends these commands to dockerd, which carries them out. The docker command uses the Docker API. The Docker client can communicate with more than one daemon.

Docker クライアント（ ``docker`` ）は多くの Docker 利用者が Docker を操作する主な手法です。 ``docker run`` のようなコマンドを用いると、クライアントは ``dockerd`` に命令（コマンド）を送り届けます。 ``dockerd`` コマンドは Docker API を用います。Docker クライアントは複数のデーモンと通信できます。

.. _docker-registries:

Docker レジストリ
--------------------

.. A Docker registry stores Docker images. Docker Hub and Docker Cloud are public registries that anyone can use, and Docker is configured to look for images on Docker Hub by default. You can even run your own private registry. If you use Docker Datacenter (DDC), it includes Docker Trusted Registry (DTR).

Docker レジストリ（ *registry* ）は Docker イメージを保管します。Docker Hub と Docker Cloud は公開レジストリであり、誰でも利用可能です。また、 Docker はデフォルトで Docker Hub のイメージを探すよう設定されています。それだけでなく、自分のプライベート・レジストリも使えます。もし Docker データセンタ（DDC）を利用するのであれば、Docker トラステッド・レジストリ（DTR）が含まれています。

.. When you use the docker pull or docker run commands, the required images are pulled from your configured registry. When you use the docker push command, your image is pushed to your configured registry.

``docker pull`` や ``docker run`` コマンドを使うと、設定されたレジストリから必要なイメージを取得します。 ``docker push`` コマンドを使えば、イメージを指定したレジストリに送信します。

.. Docker store allows you to buy and sell Docker images or distribute them for free. For instance, you can buy a Docker image containing an application or service from a software vendor and use the image to deploy the application into your testing, staging, and production environments. You can upgrade the application by pulling the new version of the image and redeploying the containers.

`Docker ストア <http://store.docker.com/>`_ で Docker イメージの売買や、自由な配布ができます。たとえば、ソフトウェア・ベンダのアプリケーションやサービスを含む Docker イメージの購入や、そのイメージを使ってアプリケーションをテスト、ステージング、プロダクション環境に展開（デプロイ）できます。アプリケーションを更新するには、イメージの新しいバージョンを取得し、コンテナの再展開によって可能です。

Docker オブジェクト
--------------------

.. When you use Docker, you are creating and using images, containers, networks, volumes, plugins, and other objects. This section is a brief overview of some of those objects.

Docker の利用時は、イメージ、コンテナ、ネットワーク、ボリューム、プラグインや、その他のオブジェクトを作成・利用します。このセクションは各オブジェクトの概要を説明します。

.. Images

イメージ
^^^^^^^^^^

.. An image is a read-only template with instructions for creating a Docker container. Often, an image is based on another image, with some additional customization. For example, you may build an image which is based on the ubuntu image, but installs the Apache web server and your application, as well as the configuration details needed to make your application run.

イメージ（ ``image`` ）とは、Docker コンテナを作成する命令が入った読み込み専用のテンプレートです。通常、イメージは、他のイメージを元（ベース）にして何らかのカスタマイズを追加したものです。例えば、 ``ubuntu`` イメージを元にして、Apache ウェブサーバやアプリケーションのインストールだけでなく、アプリケーションの実行に必要な設定詳細も含めたイメージを構築できます。

.. You might create your own images or you might only use those created by others and published in a registry. To build your own image, you create a Dockerfile with a simple syntax for defining the steps needed to create the image and run it. Each instruction in a Dockerfile creates a layer in the image. When you change the Dockerfile and rebuild the image, only those layers which have changed are rebuilt. This is part of what makes images so lightweight, small, and fast, when compared to other virtualization technologies.

イメージは自分で作成できますし、あるいはレジストリに公開されている他人が作ったイメージも利用できます。自分でイメージを構築するには、イメージを作成するために必要なステップを簡単な構文で定義する ``Dockerfile`` を作成し、実行します。Dockerfile の命令ごとに、イメージのレイヤ（layer）を作成します。Dockerfile を変更してイメージを再構築しても、変更のあったレイヤのみを再構築します。他の仮想化技術と比較した時に、この部分こそが、イメージの何が軽量で、小さく、速いのかにあたります。

コンテナ
^^^^^^^^^^

.. A container is a runnable instance of an image. You can create, run, stop, move, or delete a container using the Docker API or CLI. You can connect a container to one or more networks, attach storage to it, or even create a new image based on its current state.

コンテナ（container）とは、イメージの実行可能なインスタンス（訳者注；実体の意味）です。Docker API や CLI を使い、コンテナの作成、実行、停止、移動、削除を行えます。コンテナはネットワークに接続可能であり、ストレージもアタッチできます。あるいは、現在の状態を元にして新しいイメージの作成もできます。

.. By default, a container is relatively well isolated from other containers and its host machine. You can control how isolated a container’s network, storage, or other underlying subsystems are from other containers or from the host machine.

デフォルトでは、コンテナは他のコンテナやホストマシンとの間で、相対的に分離（isolated）されています。コンテナのネットワークやストレージ、他のサブシステムを、その他のコンテナやホストマシンからどのように分離するかを制御できます。

.. A container is defined by its image as well as any configuration options you provide to it when you create or run it. When a container is removed, any changes to its state that are not stored in persistent storage disappear.

コンテナはイメージによってデフォルトで定義されている設定だけでなく、コンテナを作成して実行する時にオプションの指定も可能です。コンテナを削除しますと、永続ストレージに保存していない変更や状態は消滅します。

.. Example docker run command

**``docker run`` コマンドの例**

.. The following command runs an ubuntu container, attaches interactively to your local command-line session, and runs /bin/bash.

次のコンテナは ``ubuntu`` コンテナを実行し、ローカルのコマンドライン・セッションと双方向（インタラクティブ）に接続（アタッチ）し、 ``/bin/bash`` を実行します。

.. code-block:: bash

    $ docker run -i -t ubuntu /bin/bash

.. When you run this command, the following happens (assuming you are using the default registry configuration):

このコマンドを実行し、以下の処理が発生します（デフォルトのレジストリ設定を用いているものと想定）。

..    If you do not have the ubuntu image locally, Docker pulls it from your configured registry, as though you had run docker pull ubuntu manually.
    Docker creates a new container, as though you had run a docker create command manually.
    Docker allocates a read-write filesystem to the container, as its final layer. This allows a running container to create or modify files and directories in its local filesystem.
    Docker creates a network interface to connect the container to the default network, since you did not specify any networking options. This includes assigning an IP address to the container. By default, containers can connect to external networks using the host machine’s network connection.
    Docker starts the container and executes /bin/bash. Because the container is run interactively and attached to your terminal (due to the -i and -t) flags, you can provide input using your keyboard and output is logged to your terminal.
    When you type exit to terminate the /bin/bash command, the container stops but is not removed. You can start it again or remove it.

1. ``ubuntu`` イメージがローカルになければ、Docker は特定のレジストリからイメージを取得（pull）します。この操作は手動で ``docker pull ubuntu`` を実行するのと同じです。
2. Docker は新しいコンテナを作成します。こちらは手動で ``docker create`` コマンドを実行するのと同じです。
3. 読み書き可能なファイルシステムを、Docker はコンテナに新しいレイヤとして割り当てます。
4. Docker はネットワーク・インターフェースを作成し、ネットワークのオプション指定がなければ、コンテナをデフォルト・ネットワークに接続します。この時、コンテナに IP アドレスを割り当てます。ホストマシンのネットワークと接続するネットワークを使わなければ、コンテナはデフォルトで外部のネットワークと接続できません。
5. Docker はコンテナを起動し、 ``/bin/bash`` を実行します。コンテナを双方向（interactive）かつターミナル（terminal）に接続する設定（ ``-i`` と ``-t`` のフラグによる）で実行しているため、キーボードを使っての入力や、出力をターミナルに表示できます。
6. ``exit`` を入力すると、 ``/bin/bash`` コマンドは終了し、コンテナは停止状態となりますが、削除はされていません。コンテナを再起動するか、削除できます。

サービス
^^^^^^^^^^

.. Services allow you to scale containers across multiple Docker daemons, which all work together as a swarm with multiple managers and workers. Each member of a swarm is a Docker daemon, and the daemons all communicate using the Docker API. A service allows you to define the desired state, such as the number of replicas of the service that must be available at any given time. By default, the service is load-balanced across all worker nodes. To the consumer, the Docker service appears to be a single application. Docker Engine supports swarm mode in Docker 1.12 and higher.

サービス（services）とは、複数の Docker デーモンを横断してコンテナをスケールできます。複数の Docker デーモンは複数のマネージャ（ `manager` ）とワーカ（ `worker` ）が `swarm` （スウォーム、訳者注；Docker用語で複数の Docker デーモンで構成する「クラスタ」を意味）として協調動作します。swarm を構成するのは Docker デーモンであり、デーモンは全て Docker API を使って通信します。サービスは、サービスのレプリカ数など期待状態（desired state）を常に定義する必要があります。デフォルトでは、サービスは全てのワーカ・ノードを横断して負荷部産します。利用者からすると、 Docker サービスは１つのアプリケーションのように見えます。Docker 1.12 以上で Docker Engine は swarm mode をサポートしました。

.. The underlying technology

基礎技術
==========

.. Docker is written in Go and makes use of several kernel features to deliver the functionality we’ve seen.

Docker は `Go 言語 <https://golang.org/>`_ で書かれており、これまで見てきた機能は、カーネルが持つ複数の機能を利用しています。

.. Namespaces

名前空間（namespaces）
------------------------------

.. Docker takes advantage of a technology called namespaces to provide the isolated workspace we call the container. When you run a container, Docker creates a set of namespaces for that container.

.. Docker uses a technology called namespaces to provide the isolated workspace called the container. When you run a container, Docker creates a set of namespaces for that container.

Docker は名前空間（ネームスペース）と呼ばれる技術を利用し、*コンテナ （container）* と呼ぶワークスペース（作業空間）の分離をもたらします。コンテナの実行時、Docker はコンテナに *名前空間* の集まりを作成します。

.. These namespaces provide a layer of isolation. Each aspect of a container runs in a separate namespace and its access is limited to that namespace.

名前空間はレイヤの分離ををもたらします。コンテナを実行した状態では、それぞれの名前空間は隔てられており、名前空間へのアクセスが制限されます。

.. Docker Engine uses namespaces such as the following on Linux:

Docker Engine が使う Linux 上の名前空間は、次の通りです。

..    The pid namespace: Process isolation (PID: Process ID).
    The net namespace: Managing network interfaces (NET: Networking).
    The ipc namespace: Managing access to IPC resources (IPC: InterProcess Communication).
    The mnt namespace: Managing filesystem mount points (MNT: Mount).
    The uts namespace: Isolating kernel and version identifiers. (UTS: Unix Timesharing System).

* **pid 名前区間** ：プロセスの分離に使います（PID：プロセス ID）
* **net 名前区間** ：ネットワーク・インターフェースの管理に使います（NET：ネットワーキング）
* **ipc 名前区間** ：IPC リソースに対するアクセス管理に使います（IPC：InterProcess Communication、内部プロセスの通信）
* **mnt 名前区間** ：マウント・ポイントの管理に使います（MNT：マウント）
* **uts 名前区間** ：カーネルとバージョン認識の隔離に使います（UTS：Unix  Timesharing System、Unix タイムシェアリング・システム）

.. Control groups

コントロール・グループ (Control groups)
----------------------------------------

.. Docker Engine on Linux also relies on another technology called control groups (cgroups). A cgroup limits an application to a specific set of resources. Control groups allow Docker Engine to share available hardware resources to containers and optionally enforce limits and constraints. For example, you can limit the memory available to a specific container.

Linux の Docker Engine はコントロール・グループ（ ``ctroups`` ）という他の技術も依存します。アプリケーションに対するリソース指定は cgroup で制限します。コントロール・グループにより、 Docker Engine のコンテナに対するハードウェア・リソース共有を可能とします。また、オプションでリソース上限や制限（constraint）も強制できます。たとえば、特定のコンテナに対する利用可能なメモリを制限できます。

.. Union file systems

ユニオン・ファイル・システム
------------------------------

.. Union file systems, or UnionFS, are file systems that operate by creating layers, making them very lightweight and fast. Docker Engine uses UnionFS to provide the building blocks for containers. Docker Engine can use multiple UnionFS variants, including AUFS, btrfs, vfs, and DeviceMapper.

ユニオン・ファイル・システム、あるいは UnionFS はファイルシステムです。これは作成したレイヤを操作しますので、非常に軽量かつ高速です。Docker Engine はコンテナごとブロックを構築するため、ユニオン・ファイル・システムを使います。Docker は AUFS、btrfs、vfs、DeviceMapper を含む複数のユニオン・ファイル・システムの派生を利用できます。

.. Container format

コンテナの形式（フォーマット）
------------------------------

.. Docker Engine combines the namespaces, control groups, and UnionFS into a wrapper called a container format. The default container format is libcontainer. In the future, Docker may support other container formats by integrating with technologies such as BSD Jails or Solaris Zones.

Docker Engine は名前空間、コントロールグループ、UnionFS を連結し、包み込んでいます。これをコンテナ形式（フォーマット）と呼びます。デフォルトのコンテナ形式は ``libcontainer`` と呼ばれています。いずれ、Docker は他のコンテナ形式、例えば BSD Jail や Solaris Zone との統合をサポートするかもしれません。

.. Next steps

次のステップ
====================

..    Read about installing Docker.
    Get hands-on experience with the Getting started with Docker tutorial.
    Check out examples and deep dive topics in the Docker Engine user guide.

* :doc:`/engine/installation` を読む
* :doc:`チュートリアル </get-started/index>` で手を動かす
* :doc:`Docker Engine ユーザ・ガイド </engine/userguide/index>` で例や詳細トピックを確認


.. seealso:: 
   Docker overview | Docker Documentation
     https://docs.docker.com/engine/docker-overview/


