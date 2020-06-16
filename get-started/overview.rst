.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/get-started/overview/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/get-started/overview.md
   doc version: 19.03
.. check date: 2020/06/15
.. Commits on Apr 23, 2029 eb948508c1a6b7b48261711c639d1b3f15a74886
.. -----------------------------------------------------------------------------

.. Docker Overview

.. _docker-overview:

=======================================
Docker 概要
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Docker is an open platform for developing, shipping, and running applications. Docker enables you to separate your applications from your infrastructure so you can deliver software quickly. With Docker, you can manage your infrastructure in the same ways you manage your applications. By taking advantage of Docker’s methodologies for shipping, testing, and deploying code quickly, you can significantly reduce the delay between writing code and running it in production.

Docker はアプリケーションの開発、導入、実行を行うためのオープンなプラットフォームです。Docker を使えば、アプリケーションをインフラストラクチャーから切り離すことができるため、ソフトウエアをすばやく提供することができます。Docker であれば、アプリケーションを管理する手法をそのまま、インフラストラクチャーの管理にも適用できます。Docker が採用する方法を最大限利用して、アプリケーションの導入、テスト、コードデプロイをすばやく行うことは、つまりコーディングと実稼動の合間を大きく軽減できることを意味します。

.. The Docker platform

.. _the-docker-platform:

Docker プラットフォーム
==============================

.. Docker provides the ability to package and run an application in a loosely isolated environment called a container. The isolation and security allow you to run many containers simultaneously on a given host. Containers are lightweight because they don’t need the extra load of a hypervisor, but run directly within the host machine’s kernel. This means you can run more containers on a given hardware combination than if you were using virtual machines. You can even run Docker containers within host machines that are actually virtual machines!

Docker はアプリケーションをパッケージ化して実行するために、ほぼ分離された環境 [#f1]_ となるコンテナというものを提供します。隔離してセキュリティを保つことから、実行するホスト上に複数のコンテナを同時に実行することができます。コンテナは非常に軽量なものとなります。なぜならハイパーバイザーを別途ロードする必要などなく、ホストマシンのカーネルを使って動作するからです。このことは手元にあるハードウェアの中から、必要なものを使ってより多くのコンテナが実行できることを意味します。それは仮想マシンを使う以上のことです。さらに Docker コンテナを動作させるホストマシンは、それ自体が仮想マシンであっても構わないのです。

.. Docker provides tooling and a platform to manage the lifecycle of your containers:

Docker が提供するのは、コンテナのライフサイクルを管理するツールとプラットフォームです。

.. 
    Develop your application and its supporting components using containers.
    The container becomes the unit for distributing and testing your application.
    When you’re ready, deploy your application into your production environment, as a container or an orchestrated service. This works the same whether your production environment is a local data center, a cloud provider, or a hybrid of the two.

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

.. 
    A server which is a type of long-running program called a daemon process (the dockerd command).
    A REST API which specifies interfaces that programs can use to talk to the daemon and instruct it what to do.
    A command line interface (CLI) client (the docker command).

* サーバ。長時間稼動する種類のプログラムでありデーモン・プロセスと呼ばれる（ ``dockerd`` コマンド）。
* REST API。プログラムとデーモンとの間での通信方法を定義し、何をなすべきかを指示する。
* コマンドライン・インターフェース（command line interface; CLI）クライアント（ ``docker`` コマンド）。

.. Docker Engine Components Flow

.. image:: /engine/article-img/engine-components-flow.png
   :scale: 60%
   :alt: Docker Engine コンポーネント図

.. The CLI uses the Docker REST API to control or interact with the Docker daemon through scripting or direct CLI commands. Many other Docker applications use the underlying API and CLI.

CLI は Docker REST API を通じて、スクリプトや直接のコマンド実行により Docker デーモンを制御したり入出力を行ったりします。Docker アプリケーションの多くが、基本的なところで API や CLI を利用しています。

.. The daemon creates and manages Docker objects, such as images, containers, networks, and volumes.

デーモンは Docker オブジェクトを作成、管理します。Docker オブジェクトとは、イメージ、コンテナ、ネットワーク、データ・ボリュームなどです。

.. > **Note**: Docker is licensed under the open source Apache 2.0 license.

.. note::

   Docker は、オープンソース Apache 2.0 ライセンスのもとで提供されています。

.. For more details, see [Docker Architecture](#docker-architecture) below.

Docker の詳細については、 :ref:`docker-architecture` を参照してください。

.. What can I use Docker for?

.. _what-can-i-use-docker-for:

何のために Docker を使うのか？
========================================

.. Fast, consistent delivery of your applications
.. _fast-consistent-delivery-of-your-applications:

アプリケーションの配信をすばやく一貫性を保って
--------------------------------------------------

.. Docker streamlines the development lifecycle by allowing developers to work in standardized environments using local containers which provide your applications and services. Containers are great for continuous integration and continuous delivery (CI/CD) workflows.

Docker は開発のライフサイクルを効率化します。開発するアプリケーションやサービスがローカルなコンテナ内に実現でき、開発者は標準化された環境により作業が進められるからです。コンテナを使った開発は、継続的インテグレーション (continuous integration; CI) や継続的開発 (continuous delivery; CD) のワークフローに適しています。

.. Consider the following example scenario:

以下のようなシナリオ例を考えてみてください。

..  Your developers write code locally and share their work with their colleagues using Docker containers.
    They use Docker to push their applications into a test environment and execute automated and manual tests.
    When developers find bugs, they can fix them in the development environment and redeploy them to the test environment for testing and validation.
    When testing is complete, getting the fix to the customer is as simple as pushing the updated image to the production environment.

* 開発者がローカルでコードを書き、仲間とその作業を共有するために Docker コンテナを使います。
* Docker によりアプリケーションをテスト環境に投入し、自動および手動のテストを実行します。
* 開発者がバグを発見したら、開発環境においてこれを修正して、アプリケーションをテスト環境に再デプロイし、テスト確認を行ないます。
* テストが完了します。この後にユーザが修正版を利用できるようにすることは、更新済イメージを本番環境へ投入することと同じく容易なことです。

.. Responsive deployment and scaling
.. _responsive-deployment-and-scaling:

迅速なデプロイとスケーリング
----------------------------------------

.. Docker’s container-based platform allows for highly portable workloads. Docker containers can run on a developer’s local laptop, on physical or virtual machines in a data center, on cloud providers, or in a mixture of environments.

Docker によるコンテナベースのプラットフォームは、処理負荷の高度な分散を考慮しています。Docker コンテナは、開発者のノートパソコン上で実行できるだけでなく、データセンタの物理マシンや仮想マシン、クラウドプロバイダ、そしてさまざまな環境の組み合わせにおいて実行可能です。

.. Docker’s portability and lightweight nature also make it easy to dynamically manage workloads, scaling up or tearing down applications and services as business needs dictate, in near real time.

Docker の可搬性と軽量な特性は、以下のようなことを容易に実現します。それは処理負荷を動的に管理できること、ビジネスシーンでの要求に応じてアプリケーションのスケールアップや提供終了を簡単に、しかもほぼリアルタイムで行うことができます。

.. **Running more workloads on the same hardware**
.. _running-more-workloads-on-the-same-hardware:

同一ハードウェア上にて負荷の高い処理を実行
----------------------------------------

.. Docker is lightweight and fast. It provides a viable, cost-effective alternative to hypervisor-based virtual machines, so you can use more of your compute capacity to achieve your business goals. Docker is perfect for high density environments and for small and medium deployments where you need to do more with fewer resources.

Docker は軽量かつ高速です。ハイパーバイザ・ベースの仮想マシンに取って変わる、実用的で費用対効果の高いものです。したがってコンピュータ性能をフルに活用してビジネス目標を達成できます。Docker は高度に処理集中する環境に適しており、さらには中小規模の、より少ないリソースの中でのシステム構築にも適しています。

.. Docker architecture
.. _docker-architecture:

Docker のアーキテクチャ
==============================

.. Docker uses a client-server architecture. The Docker client talks to the Docker daemon, which does the heavy lifting of building, running, and distributing your Docker containers. The Docker client and daemon can run on the same system, or you can connect a Docker client to a remote Docker daemon. The Docker client and daemon communicate using a REST API, over UNIX sockets or a network interface.

Docker はクライアント・サーバ型のアーキテクチャを採用しています。Docker *クライアント* は Docker デーモンに処理を依頼します。このデーモンは、Docker コンテナの構築、実行、配布という複雑な仕事をこなします。Docker クライアントとデーモンは同一システム上で動かすことも *可能* ですが、別のシステム上であっても、Docker クライアントからリモートにある Docker デーモンへのアクセスが可能です。Docker クライアントとデーモンの間の通信には REST API が利用され、UNIX ソケットまたはネット・ワークインターフェイスを介して行われます。

.. image:: /engine/article-img/architecture.png
   :scale: 60%
   :alt: Docker アーキテクチャ図

.. The Docker daemon

Docker デーモン
--------------------

.. The Docker daemon (dockerd) listens for Docker API requests and manages Docker objects such as images, containers, networks, and volumes. A daemon can also communicate with other daemons to manage Docker services.

Docker デーモン（ ``dockerd`` ）は Docker API リクエストを受け付け、イメージ、コンテナ、ネットワーク、ボリュームといった Docker オブジェクトを管理します。また、Docker サービスを管理するため、他のデーモンとも通信を行います。

.. The Docker client

Docker クライアント
--------------------

.. The Docker client (docker) is the primary way that many Docker users interact with Docker. When you use commands such as docker run, the client sends these commands to dockerd, which carries them out. The docker command uses the Docker API. The Docker client can communicate with more than one daemon.

Docker クライアント（ ``docker`` ）は Docker とのやりとりを行うために、たいていのユーザが利用するものです。``docker run`` のようなコマンドが実行されると、Docker クライアントは ``dockerd`` にそのコマンドを伝えます。そして ``dockerd`` はその内容を実現します。``docker`` コマンドは Docker API を利用しています。Docker クライアントは複数のデーモンと通信することができます。

.. _docker-registries:

Docker レジストリ
--------------------

.. A Docker registry stores Docker images. Docker Hub is a public registry that anyone can use, and Docker is configured to look for images on Docker Hub by default. You can even run your own private registry. If you use Docker Datacenter (DDC), it includes Docker Trusted Registry (DTR).

Docker レジストリは Docker イメージを保管します。Docker Hub は公開レジストリであり、誰でも利用可能です。また  Docker はデフォルトで Docker Hub のイメージを探すよう設定されています。独自にプライベート・レジストリを運用することもできます。もし Docker データセンタ（Docker Datacenter; DDC）を利用するのであれば、Docker トラステッド・レジストリ（Docker Trusted Registry; DTR）が含まれています。

.. When you use the docker pull or docker run commands, the required images are pulled from your configured registry. When you use the docker push command, your image is pushed to your configured registry.

``docker pull`` や ``docker run`` コマンドを使うと、設定されたレジストリから必要なイメージを取得します。 ``docker push`` コマンドを使えば、イメージを指定したレジストリに送信します。

Docker オブジェクト
--------------------

.. When you use Docker, you are creating and using images, containers, networks, volumes, plugins, and other objects. This section is a brief overview of some of those objects.

Docker の利用時は、イメージ、コンテナ、ネットワーク、ボリューム、プラグインや、その他のオブジェクトを作成・利用します。このセクションは各オブジェクトの概要を説明します。

.. Images

イメージ
^^^^^^^^^^

.. An image is a read-only template with instructions for creating a Docker container. Often, an image is based on another image, with some additional customization. For example, you may build an image which is based on the ubuntu image, but installs the Apache web server and your application, as well as the configuration details needed to make your application run.

イメージ（ ``image`` ）とは、Docker コンテナを作成する命令が入った読み込み専用のテンプレートです。通常イメージは、他のイメージをベースにしてそれをカスタマイズして利用します。たとえば ``ubuntu`` イメージをベースとするイメージを作ったとします。そこには Apache ウェブ・サーバや自開発したアプリケーションといったものをインストールするかもしれません。さらにアプリケーション実行に必要となる詳細な設定も加えることにもなるでしょう。

.. You might create your own images or you might only use those created by others and published in a registry. To build your own image, you create a Dockerfile with a simple syntax for defining the steps needed to create the image and run it. Each instruction in a Dockerfile creates a layer in the image. When you change the Dockerfile and rebuild the image, only those layers which have changed are rebuilt. This is part of what makes images so lightweight, small, and fast, when compared to other virtualization technologies.

イメージは作ろうと思えば作ることができ、他の方が作ってレジストリに公開されているイメージを使うということもできます。イメージを自分で作る場合は Dockerfile というファイルを生成します。このファイルの文法は単純なものであり、そこにはイメージを生成して実行するまでの手順が定義されます。Dockerfile 内の個々の命令ごとに、イメージ内にはレイヤというものが生成されます。Dockerfile の内容を書き換えたことでイメージが再構築されるときには、変更がかかったレイヤのみが再生成されます。他の仮想化技術に比べて Dockerイメージというものが軽量、小さい、早いを実現できているのも、そういった部分があるからです。

コンテナ
^^^^^^^^^^

.. A container is a runnable instance of an image. You can create, start, stop, move, or delete a container using the Docker API or CLI. You can connect a container to one or more networks, attach storage to it, or even create a new image based on its current state.

コンテナとは、イメージが実行状態となったインスタンスのことです。コンテナに対する生成、開始、停止、移動、削除は Docker API や CLI を使って行われます。コンテナは、複数のネットワークへの接続、ストレージの追加を行うことができ、さらには現時点の状態にもとづいた新たなイメージを生成することもできます。

.. By default, a container is relatively well isolated from other containers and its host machine. You can control how isolated a container’s network, storage, or other underlying subsystems are from other containers or from the host machine.

デフォルトでは、コンテナは他のコンテナやホストマシンとは、程よく分離されています。コンテナに属するネットワーク、ストレージ、基盤となるサブシステムなどを、いかにして他のコンテナやホストマシンから切り離すか、その程度は制御することが可能です。

.. A container is defined by its image as well as any configuration options you provide to it when you create or start it. When a container is removed, any changes to its state that are not stored in persistent storage disappear.

コンテナはイメージによって定義されるものです。またこれを生成、実行するために設定したオプションによっても定義されます。コンテナを削除すると、その時点での状態に対して変更がかかっていたとしても、永続的なストレージに保存されていないものは消失します。

.. Example docker run command

**``docker run`` コマンドの例**

.. The following command runs an ubuntu container, attaches interactively to your local command-line session, and runs /bin/bash.

次のコマンドは ``ubuntu`` コンテナを実行し、ローカルのコマンドライン処理のセッションを結びつけます。そして ``/bin/bash`` を実行します。

.. code-block:: bash

    $ docker run -i -t ubuntu /bin/bash

.. When you run this command, the following happens (assuming you are using the default registry configuration):

このコマンドを実行すると、以下が発生します（レジストリから入手した際のデフォルトの設定を使用しているものとします）。

..  If you do not have the ubuntu image locally, Docker pulls it from your configured registry, as though you had run docker pull ubuntu manually.
    Docker creates a new container, as though you had run a docker container create command manually.
    Docker allocates a read-write filesystem to the container, as its final layer. This allows a running container to create or modify files and directories in its local filesystem.
    Docker creates a network interface to connect the container to the default network, since you did not specify any networking options. This includes assigning an IP address to the container. By default, containers can connect to external networks using the host machine’s network connection.
    Docker starts the container and executes /bin/bash. Because the container is running interactively and attached to your terminal (due to the -i and -t flags), you can provide input using your keyboard while the output is logged to your terminal.
    When you type exit to terminate the /bin/bash command, the container stops but is not removed. You can start it again or remove it.

1. ``ubuntu`` イメージがローカルになければ、Docker は設定されているレジストリからイメージを取得します。この動作は手動で ``docker pull ubuntu`` を実行するのと同じです。
2. Docker は新しいコンテナを生成します。これは手動で ``docker create`` コマンドを実行することと同じです。
3. Docker はコンテナに対して読み書きが可能なファイルシステムを割り当てます。これが最終的にレイヤとなります。このことによりコンテナの稼動中に、ローカルなファイルシステム内でのファイルやディレクトリの生成や変更などが実現されます。
4. Docker はネットワーク・インターフェースを生成し、コンテナをデフォルト・ネットワークに接続します。ここではネットワーク・オプションを指定していないものとしているためです。このときには、コンテナに対しての IP アドレスの割り当ても行われます。デフォルトでコンテナは、ホストマシンのネットワーク接続を利用して、外部ネットワークに接続します。
5. Docker はコンテナを起動し、 ``/bin/bash`` を実行します。（ ``-i`` と ``-t`` のフラグにより）対話的に、かつターミナル画面に接続するようにして実行しているため、手元のキーボードを使って入力することができ、ターミナル画面に出力が行われるようになります。
6. ``exit`` を入力すると、 ``/bin/bash`` コマンドは終了します。コンテナは停止状態となりますが、削除はされません。コンテナを再起動したり削除することもできます。

サービス
^^^^^^^^^^

.. Services allow you to scale containers across multiple Docker daemons, which all work together as a swarm with multiple managers and workers. Each member of a swarm is a Docker daemon, and all the daemons communicate using the Docker API. A service allows you to define the desired state, such as the number of replicas of the service that must be available at any given time. By default, the service is load-balanced across all worker nodes. To the consumer, the Docker service appears to be a single application. Docker Engine supports swarm mode in Docker 1.12 and higher.

サービスは、複数の Docker デーモンにわたって、コンテナのスケール変更ができるようにします。複数のデーモンはスォームと呼ばれるものとして扱われ、複数のマネージャ、ワーカとともに動作します。そしてすべてのデーモンが Docker API を利用して通信します。サービスは必要となる状態を定義することが可能であり、たとえばサービスのレプリカ数を、指定した時間においてどれだけ作り出すかを定義できます。デフォルトでは、すべてのワーカ・ノードにわたって負荷分散が行われます。利用者からすると、Docker サービスは１つのアプリケーションとして見えます。Docker Engine がスウォームモードをサポートするのは Docker バージョン 1.12 またはそれ以上です。

.. ## The underlying technology

基盤とする技術
==============

.. Docker is written in Go and takes advantage of several features of the Linux kernel to deliver its functionality.

Docker は `Go 言語 <https://golang.org/>`_ で書かれており、Linux カーネルの機能をうまく活用して、さまざまな機能性を実現しています。

.. Namespaces

名前空間
------------------------------

.. Docker uses a technology called namespaces to provide the isolated workspace called the container. When you run a container, Docker creates a set of namespaces for that container.

Docker は名前空間という技術を利用して *コンテナ* と呼ぶ作業空間を分離して提供します。コンテナが実行されたとき、Docker はそのコンテナに対して複数の *名前空間* を生成します。

.. These namespaces provide a layer of isolation. Each aspect of a container runs in a separate namespace and its access is limited to that namespace.

名前空間はいくつもの分離状態を作り出します。コンテナ内のさまざまな処理は、分離された名前空間内にて実行され、それぞれへのアクセスはその名前空間内に限定されます。

.. Docker Engine uses namespaces such as the following on Linux:

Docker Engine が取り扱う名前空間は、Linux 上で言えば以下のようなものです。

..  The pid namespace: Process isolation (PID: Process ID).
    The net namespace: Managing network interfaces (NET: Networking).
    The ipc namespace: Managing access to IPC resources (IPC: InterProcess Communication).
    The mnt namespace: Managing filesystem mount points (MNT: Mount).
    The uts namespace: Isolating kernel and version identifiers. (UTS: Unix Timesharing System).

* **pid 名前空間** ：プロセスの分離。（PID：プロセス ID）
* **net 名前空間** ：ネットワーク・インターフェースの管理。（NET：ネットワーキング）
* **ipc 名前空間** ：IPC リソースに対するアクセス管理。（IPC：InterProcess Communication、内部プロセスの通信）
* **mnt 名前空間** ：ファイルシステムのマウント・ポイントの管理。（MNT：マウント）
* **uts 名前空間** ：カーネルとバージョンの分離。（UTS：Unix  Timesharing System、Unix タイムシェアリング・システム）

.. ### Control groups

コントロール・グループ (Control groups)
----------------------------------------

.. Docker Engine on Linux also relies on another technology called control groups (cgroups). A cgroup limits an application to a specific set of resources. Control groups allow Docker Engine to share available hardware resources to containers and optionally enforce limits and constraints. For example, you can limit the memory available to a specific container.

Linux 上で動作する Docker Engine には、さらに *コントール・グループ* （``cgroups``; control groups）と呼ばれる技術も併用されます。cgroup は、アプリケーションが利用するリソースを特定のものに限定します。つまりコントロール・グループは、Docker Engine が利用可能なハードウェア・リソースをコンテナ間で共有するようにし、必要に応じて利用上限や制約をつけることも行います。たとえば特定のコンテナが利用するメモリの上限を設定することもできます。

.. Union file systems

ユニオン・ファイル・システム
------------------------------

.. Union file systems, or UnionFS, are file systems that operate by creating layers, making them very lightweight and fast. Docker Engine uses UnionFS to provide the building blocks for containers. Docker Engine can use multiple UnionFS variants, including AUFS, btrfs, vfs, and DeviceMapper.

ユニオン・ファイル・システムは UnionFS というものであり、レイヤが作り出され、軽量かつ高速に処理が行われるファイルシステムのことです。Docker Engine は UnionFS を利用して、コンテナにおけるブロックを構築します。Docker Engine では AUFS、btrfs、vfs、DeviceMapper などの UnionFS 系のファイルシステムも利用できます。

.. Container format

コンテナ・フォーマット
------------------------------

.. Docker Engine combines the namespaces, control groups, and UnionFS into a wrapper called a container format. The default container format is libcontainer. In the future, Docker may support other container formats by integrating with technologies such as BSD Jails or Solaris Zones.

名前空間、コントロール・グループ、UnionFS は Docker Engine により、コンテナ・フォーマットと呼ばれるラッパーとして構成されます。このコンテナ・フォーマットのデフォルトが ``libcontainer`` です。いずれ BSD Jail や Solaris Zone などを技術統合した新たなコンテナ・フォーマットがサポートされることになるかもしれません。

.. Next steps

次のステップ
====================

.. 
    Read about installing Docker.
    Get hands-on experience with the Getting started with Docker tutorial.

* :doc:`/get-docker` に進む。
* ハンズオンで :doc:`Docker を使い始める </get-started/index>` ためのチュートリアルを試す。

.. seealso:: 
   Docker overview
     https://docs.docker.com/get-started/overview/


