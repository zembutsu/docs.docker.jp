.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/glossary/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/_data/glossary.yaml
.. check date: 2021/05/01
.. Commits on Oct 21, 2020 9338de3edee88277adcf32b6743459e50ce64209
.. -----------------------------------------------------------------------------

.. Glossary

.. _glossary:

========================================
用語集
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:


.. _amd64:

amd64
========================================

.. AMD64 is AMD’s 64-bit extension of Intel’s x86 architecture, and is also referred to as x86_64 (or x86-64).

AMD64 とは、インテルの x86 アーキテクチャの AMD による 64 ビット拡張であり、x86_64 （または x86-64） とも呼びます。


.. _glossary-aufs

aufs
========================================

.. aufs (advanced multi layered unification filesystem) is a Linux filesystem that Docker supports as a storage backend. It implements the union mount for Linux file systems.

aufs （advanced multi layered unification filesystem；複数のレイヤを統合した、高度なファイルシステム、の意味）は Linux の :ref:`ファイルシステム <glossary-filesystem>` であり、ストレージ用のバックエンドとして Docker がサポートします。Linux ファイルシステムに対する `ユニオンマウント（Union mount） <https://en.wikipedia.org/wiki/Union_mount>`_  の実装です。

.. _base-image:

:ruby:`ベースイメージ <base image>`
========================================

..  A base image has no parent image specified in its Dockerfile. It is created using a Dockerfile with the FROM scratch directive.

**ベースイメージ**  は Dockerfile で親イメージを指定しないものです。ベースイメージを作成するには、Dockerfile で ``FROM scratch`` 命令を使います。

.. _btrfs:

btrfs
========================================

.. btrfs (B-tree file system) is a Linux filesystem that Docker supports as a storage backend. It is a copy-on-write filesystem.

btrfs （B-tree file system；ビーツリーファイルシステム）は、ストレージ用のバックエンドとして Docker がサポートする Linux の :ref:`ファイルシステム <filesystem>` です。これは :ref:`コピーオンライト <copy-on-write>` のファイルシステムです。

.. _build:

:ruby:`ビルド <build>`
========================================

..  build is the process of building Docker images using a Dockerfile. The build uses a Dockerfile and a “context”. The context is the set of files in the directory in which the image is built.

ビルド（build）とは、 :ref:`Dockerfile` を使って Docker イメージを構築する工程です。構築には、 Dockerfile と「コンテクスト」（内容物の意味）を使います。コンテクストとは、イメージ構築に必要なディレクトリに置いてあるファイル群です

.. _cgroups:

cgroups
========================================

..  cgroups is a Linux kernel feature that limits, accounts for, and isolates the resource usage (CPU, memory, disk I/O, network, etc.) of a collection of processes. Docker relies on cgroups to control and isolate resource limits.

cgroups とは、プロセスの集合が使うリソース（CPU、メモリ、ディスク I/O、ネットワーク等）を制限・計算・隔離（isolate）する Linux カーネルの機能です。リソース上限の管理と隔離をするため、Docker は cgroups に依存します。

*cgroups の別名：control groups*

.. _cluster:

:ruby:`クラスタ <cluster>`
========================================

.. A cluster is a group of machines that work together to run workloads and provide high availability.

クラスタとはマシンのグループであり、ワークロードの実行と高可用性を備えるために連携します。

.. _Compose:

:ruby:`Compose <コンポーズ>`
========================================

.. Compose is a tool for defining and running complex applications with Docker. With Compose, you define a multi-container application in a single file, then spin your application up in a single command which does everything that needs to be done to get it running.

:doc:`Compose </compose/index>` （コンポーズ）は、Docker を使い、複雑なアプリケーションの実行や定義をするツールです。Compose では、１つのファイルに複数のコンテナアプリケーションを定義します。それから、コマンドを１つ実行するだけで、アプリケーションを使うために必要な全てを素早く立ち上げます

.. Also known as : docker-compose, fig

*Compose の別名： docker-compose、fig*


.. Definition of: copy-on-write

.. _copy-on-write:

:ruby:`コピーオンライト <copy-on-write>`
========================================

.. Docker uses a copy-on-write technique and a union file system for both images and containers to optimize resources and speed performance. Multiple copies of an entity share the same instance and each one makes only specific changes to its unique layer.

Docker はイメージとコンテナのリソース最適化とスピード性能のために、 :ref:`コピーオンライト <the-copy-on-write-strategy>` 技術と :ref:`union-file-system` を使います。Docker コンテナや Docker イメージに、複数のコピーが存在するときは、実体である同じイメージレイヤを共有します。また、それぞれのレイヤに対する変更処理は、個々のレイヤにのみ反映します。

.. Multiple containers can share access to the same image, and make container-specific changes on a writable layer which is deleted when the container is removed. This speeds up container start times and performance.

複数のコンテナは、同じイメージへのアクセスを共有できます。そして、特定のコンテナに対する変更とは、書き込み可能なレイヤに対して行いますが、そのコンテナを削除すると（コンテナ用の）レイヤも削除されます。これが、コンテナの開始時間とパフォーマンスの速度を向上します。

.. Images are essentially layers of filesystems typically predicated on a base image under a writable layer, and built up with layers of differences from the base image. This minimizes the footprint of the image and enables shared development.

イメージとは、実質的にファイルシステムのレイヤです。一般的には書き込み可能なレイヤは、その下にベースイメージがあると予測され、ベースイメージとは異なったレイヤを積み上げます。これによりイメージ容量を最小化し、共有しながら開発できるようにします。

.. For more about copy-on-write in the context of Docker, see Understand images, containers, and storage drivers.

Docker の文脈におけるコピーオンライトの詳細は、 :doc:`イメージ、コンテナ、ストレージドライバの理解 </engine/userguide/storagedriver/imagesandcontainers>` をご覧ください。


.. container

.. _container:

:ruby:`コンテナ <container>`
==============================

.. A container is a runtime instance of a docker image.

:ruby:`コンテナ <container>` は :ref:`docker イメージ <image>` で実行する実体（インスタンス）です。

.. A Docker container consists of

Docker コンテナを構成するのは、次のものです。

..    A Docker image
    Execution environment
    A standard set of instructions

* Docker イメージ
* 実行環境
* 命令の標準セット

.. The concept is borrowed from Shipping Containers, which define a standard to ship goods globally. Docker defines a standard to ship software.

Docker コンテナの概念は、輸送用のコンテナから拝借したものです。コンテナとは、全世界へ物資を輸送するために定義された規格です。Docker はソフトウェアを送るための規格を定義しています。

.. Docker

.. _docker:

:ruby:`Docker <ドッカー>`
==============================

.. The term Docker can refer to

用語としての Docker （ドッカー）は、次のことを指します。

..    The Docker project as a whole, which is a platform for developers and sysadmins to develop, ship, and run applications
    The docker daemon process running on the host which manages images and containers (also called Docker Engine)

* Docker プロジェクト全体を指す言葉です。開発者やシステム管理者が、アプリケーションを開発・移動・実行するためのプラットフォームです。
* イメージとコンテナを管理する、ホスト上で動く docker デーモンのプロセスです。 :ruby:`Docker Engine <ドッカーエンジン>` とも呼びます。


.. Docker Desktop for Mac

.. _docker-desktop-for-mac:

Docker Desktop for Mac
==============================

.. Docker Desktop for Mac is an easy-to-install, lightweight Docker development environment designed specifically for the Mac. A native Mac application, Docker Desktop for Mac uses the macOS Hypervisor framework, networking, and filesystem. It’s the best solution if you want to build, debug, test, package, and ship Dockerized applications on a Mac.

:doc:`Docker Desktop for Mac </docker-for-mac/index>` はインストールが簡単で、Mac 向けに特化して設計された、軽量な Docker 開発環境です。Docker Desktop for Mac は Mac 固有のアプリケーションを実行するために、macOS ハイパーバイザーフレームワーク、ネットワーク機能、ファイルシステムを使います。Mac 上で Docker 対応アプリケーションの開発・構築・テスト、パッケージ化、移動するために、ベストな解決作です。


.. _docker-desktop-for-windows:

Docker Desktop for Windows
==============================

.. Docker Desktop for Windows is an easy-to-install, lightweight Docker development environment designed specifically for Windows 10 systems that support Microsoft Hyper-V (Professional, Enterprise and Education). Docker Desktop for Windows uses Hyper-V for virtualization, and runs as a native Windows app. It works with Windows Server 2016, and gives you the ability to set up and run Windows containers as well as the standard Linux containers, with an option to switch between the two. Docker for Windows is the best solution if you want to build, debug, test, package, and ship Dockerized applications from Windows machines.

:doc:`Docker Desktop for Windows </docker-for-windows/index>` はインストールが簡単で、Microsoft Hyper-V（Professional、Enterprise、Education）をサポートしているWindows 10 システム向けに特化して設計された、軽量な Docker 開発環境です。Docker Desktop  for Windows は Windows 固有のアプリケーションを実行するために、Hyper-V 仮想化を使い、固有の Windows アプリのように動作します。Windows Server 2016 上でも動作し、２つのオプションを切り替えるだけで、標準的な Linux コンテナと同じように、Windows コンテナの迅速なセットアップや実行ができます。Windows マシン上で Docker 対応アプリケーションの開発・構築・テスト・パッケージ・移動をするために、ベストな解決作です。

.. Docker Hub

.. _docker-hub:

:ruby:`Docker Hub <ドッカーハブ>`
========================================

.. The Docker Hub is a centralized resource for working with Docker and its components. It provides the following services:

`Docker Hub <https://hub.docker.com/>`_ とは、 Docker と自身のコンポーネントで動くリソースを集めた場所です。以下のサービスを提供します。

..    Docker image hosting
    User authentication
    Automated image builds and work-flow tools such as build triggers and web hooks
    Integration with GitHub and Bitbucket

* Docker イメージを預かる（ホスティング）
* ユーザ認証
* イメージの自動構築と、 :ruby:`構築トリガ <build triggers>` や :ruby:`ウェブフック <web hook>` のようなワークフローツール
* GitHub 及び Bitbucket との統合

.. Dockerfile

.. _Dockerfile:

:ruby:`Dockerfile <ドッカーファイル>`
========================================

.. A Dockerfile is a text document that contains all the commands you would normally execute manually in order to build a Docker image. Docker can build images automatically by reading the instructions from a Dockerfile.

Dockerfile はテキスト形式のドキュメントであり、このファイルに含むのは、通常は Docker イメージを構築するために、手作業で実行する全ての命令です。Docker は Dockerfile の命令を読み込み、自動的にイメージを構築できます。

.. Definition of: ENTRYPOINT

.. _ENTRYPOINT:

:ruby:`ENTRYPOINT <エントリーポイント>`
========================================

.. In a Dockerfile, an ENTRYPOINT is an optional definition for the first part of the command to be run. If you want your Dockerfile to be runnable without specifying additional arguments to the docker run command, you must specify either ENTRYPOINT, CMD, or both.

Dockerfile において、実行したいコマンドを真っ先に定義するオプションが ``ENTRYPOINT`` です。 ``docker run`` コマンドの実行時、何も引数を指定しなくても実行可能な ``Dockerfile`` を作りたい場合は、 ``ENTRYPOINT`` か ``CMD`` のどちらか、あるいは両方の指定が必要です。

.. ..    If ENTRYPOINT is specified, it is set to a single command. Most official Docker images have an ENTRYPOINT of /bin/sh or /bin/bash. Even if you do not specify ENTRYPOINT, you may inherit it from the base image that you specify using the FROM keyword in your Dockerfile. To override the ENTRYPOINT at runtime, you can use --entrypoint. The following example overrides the entrypoint to be /bin/ls and sets the CMD to -l /tmp.

- ``ENTRYPOINT`` の指定があれば、これを単独のコマンドとして設定します。多くの公式 Docker イメージは、 ``ENTRYPOINT``` に ``/bin/sh`` または ``/bin/bash`` を指定しています。 ``ENTRYPOINT`` を指定しなければ、Dockerfile の ``FROM`` キーワード指定されているベースイメージの設定を継承します。実行時に ``ENTRYPOINT`` を上書きしたい場合は、 ``--entrypoint`` を使えます。次の例はエントリーポイントを ``/bin/ls`` に置き換え、 ``CMD`` を ``-l /tmp`` に指定します。

   .. code-block:: bash

      $ docker run --entrypoint=/bin/ls ubuntu -l /tmp

..    CMD is appended to the ENTRYPOINT. The CMD can be any arbitrary string that is valid in terms of the ENTRYPOINT, which allows you to pass multiple commands or flags at once. To override the CMD at runtime, just add it after the container name or ID. In the following example, the CMD is overridden to be /bin/ls -l /tmp.

- ``CMD`` は ``ENTRYPOINT`` に追加されます。 ``ENTRYPOINT`` で利用可能な文字列であれば、複数のコマンドやフラグ１つなど、どのようなものでも ``CMD`` に書けます。実行時に ``CMD`` を上書きするには、コンテナ名や ID のあとにコマンドを追加するだけです。次の例は ``CMD`` の指定を ``/bin/ls -l /tmp`` で上書きします。

   .. code-block:: bash

      $ docker run ubuntu /bin/ls -l /tmp

.. In practice, ENTRYPOINT is not often overridden. However, specifying the ENTRYPOINT can make your images more fiexible and easier to reuse.

実際には、 ``ENTRYPOINT`` で頻繁に上書きしません。しかしながら、 ``ENTRYPOINT``  の指定によって、イメージをより柔軟かつ再利用しやすくします。


.. filesystem

.. _filesystem:

:ruby:`ファイルシステム <filesystem>`
========================================

.. A file system is the method an operating system uses to name files and assign them locations for efficient storage and retrieval.

ファイルシステムとは、オペレーティングシステムがファイルに名前を付け、かつ、ファイルを効率的に保存・修正するため、保存場所を割り当てる手法です。

.. Examples :

例：

* Linux : ext4, aufs, btrfs, zfs
* Windows : NTFS
* OS X : HFS+

.. image

.. _image:

:ruby:`イメージ <image>`
==============================

.. Docker images are the basis of containers. An Image is an ordered collection of root filesystem changes and the corresponding execution parameters for use within a container runtime. An image typically contains a union of layered filesystems stacked on top of each other. An image does not have state and it never changes.

Docker イメージは :ref:`コンテナ <container>` の基礎（土台）です。イメージとは、ルートファイルシステムに対する変更と、コンテナ実行時に使う実行パラメータに相当するものを並べ集めたものです。一般的にイメージには、ファイルシステムをレイヤー化した集合が、お互いに積み重なって入っています。イメージは状態を保持せず、変更もできません。

.. _layter:

:ruby:`レイヤ <layer>`
==============================

.. In an image, a layer is modification to the image, represented by an instruction in the Dockerfile. Layers are applied in sequence to the base image to create the final image. When an image is updated or rebuilt, only layers that change need to be updated, and unchanged layers are cached locally. This is part of why Docker images are so fast and lightweight. The sizes of each layer add up to equal the size of the final image.

イメージ内部において、イメージに対する変更箇所がレイヤであり、つまり Dockerfile 内における命令を意味します。ベースイメージから最終的なイメージを作成するまで、レイヤは順番に重なります。イメージの更新や再構築をする場合には、更新が必要なレイヤのみを変更し、ローカルでキャッシュ済みのレイヤは変更しません。これが Docker イメージはなぜ高速かつ軽量なのかという理由の１つです。各レイヤの容量の合計が、最終的なイメージの容量と同じです。

.. libcontainer

.. _libcontainer:

:ruby:`libcontainer <リブコンテナ>`
========================================

.. libcontainer provides a native Go implementation for creating containers with namespaces, cgroups, capabilities, and filesystem access controls. It allows you to manage the lifecycle of the container performing additional operations after the container is created.

libcontainer は Go 言語のネイティブな実装であり、名前空間・cgroup・機能・ファイルシステムへのアクセス管理を持つコンテナを作成します。コンテナを作成後、コンテナに対してライフサイクル上の追加操作を可能にします。

.. libnetwork

.. _libnetwork:

:ruby:`libnetwork <リブネットワーク>`
========================================

.. libnetwork provides a native Go implementation for creating and managing container network namespaces and other network resources. It manage the networking lifecycle of the container performing additional operations after the container is created.

libnetworkは Go 言語のネイティブな実装であり、コンテナのネットワーク名前空間や他のネットワーク・リソースを作成・管理します。コンテナを作成後、コンテナに対してライフサイクル上の追加操作を可能にします。

.. link

.. _link:

:ruby:`リンク機能 <link>`
==============================

.. links provide a legacy interface to connect Docker containers running on the same host to each other without exposing the hosts’ network ports. Use the Docker networks feature instead.

リンク機能は同じホスト上で実行している Docker コンテナ間を接続するための、レガシーな（古い）インターフェースです。リンク機能を使うと、ホスト側のネットワークポートを開く必要がありません。現在は、この機能の替わりに Docker ネットワーク機能を使います。

.. Machine

.. _glossary-machine:

:ruby:`Machine <マシン>`
==============================

.. Machine is a Docker tool which makes it really easy to create Docker hosts on your computer, on cloud providers and inside your own data center. It creates servers, installs Docker on them, then configures the Docker client to talk to them.

:doc:`Machine </machine/index>` は Docker ホストを簡単に作成できるようにするツールであり、クラウドプロバイダ上やデータセンタでも利用できます。Machine はサーバを作成し、そこに Docker をインストールし、Docker クライアントで通信できるように設定します。

.. Also known as : docker-machine

*別名： docker-machine*

.. _namespace:

:ruby:`名前空間 <namespace>`
==============================
.. A Linux namespace is a Linux kernel feature that isolates and virtualizes system resources. Processes which are restricted to a namespace can only interact with resources or processes that are part of the same namespace. Namespaces are an important part of Docker’s isolation model. Namespaces exist for each type of resource, including net (networking), mnt (storage), pid (processes), uts (hostname control), and user (UID mapping). For more information about namespaces, see Docker run reference and Isolate containers with a user namespace.

.. A Linux namespace is a Linux kernel feature that isolates and vitualizes system resources. Processes which restricted to a namespace can only interact with resources or processes that are part of the same namespace. Namespaces are an important part of Docker’s isolation model. Namespaces exist for each type of resource, including net (networking), mnt (storage), pid (processes), uts (hostname control), and user (UID mapping). For more information about namespaces, see Docker run reference and Introduction to user namespaces.

`Linux 名前空間（namespace；ネームスペース） <http://man7.org/linux/man-pages/man7/namespaces.7.html>`_ は  Linux カーネルの :ruby:`分離 <isolate>` と仮想システム・リソース機能です。名前空間によって制限されたプロセスは、同じ名前空間内のリソースやプロセスとしかやりとりできません。名前空間は Docker の分離モデルにおける重要な部分です。名前空間は各リソース・タイプごとに存在しています。リソース・タイプとは ``net`` （ネットワーク機能）、 ``mnt`` （ストレージ）、 ``pid`` （プロセス）、 ``uts`` （ホスト名の制御）、 ``user`` （UID 割り当て）です。名前空間に関する詳しい情報は、 :doc:`Docker run リファレンス </engine/reference/run>` と :doc:`ユーザ名前空間でコンテナ隔離 </engine/security/userns-remap>` をご覧ください。


.. _node:

:ruby:`ノード <node>`
==============================

.. A node is a physical or virtual machine running an instance of the Docker Engine in swarm mode.

:doc:`ノード </engine/swarm/how-swarm-mode-works/nodes>` とは、 :ref:`swarm モード <swarm-mode>` 上における Docker Engine が動作している物理または仮想マシンで動作する実体（インスタンス）を指します。

.. Manager nodes perform swarm management and orchestration duties. By default manager nodes are also worker nodes.

**Manager ノード（マネージャ node）** は swarm（クラスタ）管理とオーケストレーションの責務を処理します。デフォルトでは、managerノードは worker ノードも兼ねます。

.. Worker nodes execute tasks.

**Worker ノード（ワーカ node）** はタスクを実行します。


.. overlay network driver

.. _overlay-network-driver:

overlay :ruby:`ネットワークドライバ <network driver>`
=====================================================

.. Overlay network driver provides out of the box multi-host network connectivity for docker containers in a cluster.

overlay ネットワークドライバは、クラスタ内の Docker コンテナに対して、複数ホスト間で、簡単なネットワーク接続性を提供します。

.. overlay storage driver

.. _overlay-storage-driver:

overlay :ruby:`ストレージドライバ <storage driver>`
============================================================

.. OverlayFS is a filesystem service for Linux which implements a union mount for other file systems. It is supported by the Docker daemon as a storage driver.

OverlayFS は、他のファイルシステムに対する `ユニオンマウント <http://en.wikipedia.org/wiki/Union_mount>`__ を Linux に実装するもので、 :ref:`ファイルシステム <filesystem>` 向けのサービスです。


.. _parent-image:

:ruby:`親イメージ <parent image>`
========================================

.. An image’s parent image is the image designated in the FROM directive in the image’s Dockerfile. All subsequent commands are based on this parent image. A Dockerfile with the FROM scratch directive uses no parent image, and creates a base image.

イメージの **親イメージ** とは、対象イメージの Dockerfile 中にある ``FROM`` 命令で指定したイメージです。以降に続く全てのコマンドは、この親イメージに基づきます。Dockerfile で ``FROM scratch`` 命令を使うと、親イメージを持たない  **ベースイメージ（base image）** を作成します。

.. _persistent-storage:

:ruby:`持続的ストレージ <persistent storage>`
==================================================

.. Persistent storage or volume storage provides a way for a user to add a persistent layer to the running container’s file system. This persistent layer could live on the container host or an external device. The lifecycle of this persistent layer is not connected to the lifecycle of the container, allowing a user to retain state.

持続的ストレージやボリュームストレージは、実行中コンテナのファイスシステム上で、持続的なレイヤ（persistent layer）をユーザに対して提供します。持続的なレイヤは、コンテナのホスト上や外部デバイスに残り続けます。この持続的なレイヤのライフサイクルは、コンテナのライフサイクルとはつながっておらず、ユーザは状態を維持できます。

.. registry

.. _registry:

:ruby:`レジストリ <registry>`
==============================

.. A Registry is a hosted service containing repositories of images which responds to the Registry API.

レジストリとは :ref:`イメージ <image>` を保管する :ref:`リポジトリ <repository>` を預かるサービス（ホステッドサービス）であり、レジストリ API に応答します。

.. The default registry can be accessed using a browser at Docker Hub or using the docker search command.

デフォルトのレジストリにアクセスするには、ブラウザで :ref:`Docker Hub <docker-hub>` を開くか、 ``docker search`` コマンドを使います。

.. repository

.. _repository:

:ruby:`リポジトリ <repository>`
========================================

.. A repository is a set of Docker images. A repository can be shared by pushing it to a registry server. The different images in the repository can be labeled using tags.

リポジトリとは Docker イメージの集まりです。リポジトリは :ref:`レジストリ <registry>` サーバに送信すると、共有されるようにできます。リポジトリの中では、イメージの違いを :ref:`タグ <tag>` でラベル付けします。

.. Here is an example of the shared nginx repository and its tags

共有 `Nginx リポジトリ <https://hub.docker.com/_/nginx/>`_ と `タグ <https://hub.docker.com/r/library/nginx/tags>`_ の例です。

.. _SSH:

SSH
==========

.. SSH (secure shell) is a secure protocol for accessing remote machines and applications. It provides authentication and encrypts data communication over insecure networks such as the Internet. SSH uses public/private key pairs to authenticate logins.

SSH（secure shell；安全なシェル）はリモート・マシンやアプリケーションに接続するための安全なプロトコルです。インターネットのような安全ではないネットワーク越しに、認証や暗号データ通信を行います。SSH はログイン認証にあたって公開鍵/秘密鍵のペアを使います。

.. _service:

:ruby:`サービス <service>`
==============================

.. A service is the definition of how you want to run your application containers in a swarm. At the most basic level a service defines which container image to run in the swarm and which commands to run in the container. For orchestration purposes, the service defines the “desired state”, meaning how many containers to run as tasks and constraints for deploying the containers.

.. :doc:`サービス </engine/swarm/how-swarm-mode-works/services>` は、 swarm 上でアプリケーション・コンテナをどのように実行するかの定義です。最も基本的なレベルのサービス定義とは、swarm 上でどのコンテナ・イメージを実行するか、そして、どのコマンドをコンテナで実行するかです。オーケストレーションの目的は「望ましい状態（desired state）」としてサービスを定義することです。つまり、いくつのコンテナをタスクとして実行するか、コンテナをデプロイする条件（constraint）を指します。

サービスは、 swarm 上でアプリケーション・コンテナをどのように実行するかの定義です。最も基本的なレベルのサービス定義とは、swarm 上でどのコンテナ・イメージを実行するか、そして、どのコマンドをコンテナで実行するかです。オーケストレーションの目的は :ruby:`望ましい状態 <desired state>` 」としてサービスを定義することです。つまり、いくつのコンテナをタスクとして実行するか、コンテナをデプロイする :ruby:`条件 <constraint>` を指します。


.. Frequently a service is a microservice within the context of some larger application. Examples of services might include an HTTP server, a database, or any other type of executable program that you wish to run in a distributed environment.

時々、巨大なアプリケーションという文脈において、マイクロサービスのことをサービスとも呼びます。サービスとは HTTP サーバやデータベースかもしれません。これは、分散環境において実行したい、あらゆる種類の実行可能なプログラムです。


.. _service-discovery:

:ruby:`サービスディスカバリ <service discovery>`
==================================================

.. Swarm mode service discovery is a DNS component internal to the swarm that automatically assigns each service on an overlay network in the swarm a VIP and DNS entry. Containers on the network share DNS mappings for the service via gossip so any container on the network can access the service via its service name.

Swarm モードの :ref:`サービス・ディスカバリ <use-swarm-mode-service-discovery>` は、swarm クラスタ内部における DNS コンポーネントです。これは、オーバレイ・ネットワーク上の各サービスに対し、VIP と DNS エントリを自動的に割り当てます。ネットワーク上のコンテナは :ruby:`ゴシップ <gossip>` （訳者注；分散環境における通信プロトコルの一種です）を経由し、各サービス向けに割り当てられた DNS を共有します。そのため、ネットワーク上における全てのコンテナ上にあるサービスに対し、サービス名でアクセスできます。

.. You don’t need to expose service-specific ports to make the service available to other services on the same overlay network. The swarm’s internal load balancer automatically distributes requests to the service VIP among the active tasks.

サービスごとにポートを公開する必要がないため、同じオーバレイ・ネットワーク上で他のサービスが動いているかどうかを確認する必要はありません。アクティブなタスクごとサービス用の VIP を持ち、swarm の内部ロードバランサはリクエストごとにアクセスを分散します。


.. swarm

.. _glossary-swarm:

swarm
==========

.. A swarm is a cluster of one or more Docker Engines running in swarm mode.

:doc:`swarm </engine/swarm/index>` とは :ref:`swarm モード <glossary-swarm-mode>` で動作する Docker Engine のクラスタのことです。


.. Docker Swarm

.. _glossary-docker-swarm:

Docker Swarm
====================

.. Do not confuse Docker Swarm with the swarm mode features in Docker Engine.

Docker Swarm と Docker Engine の swarm モードを混同しないでください。

.. Docker Swarm is the name of a standalone native clustering tool for Docker. Docker Swarm pools together several Docker hosts and exposes them as a single virtual Docker host. It serves the standard Docker API, so any tool that already works with Docker can now transparently scale up to multiple hosts.

Docker Swarm は Docker 用に独立したネイティブなクラスタリング・ツールです。Docker Swarm は複数の Dcker ホストを一緒にまとめ（プールし）、１つの仮想的な Docker ホストのように装います。Swarm は標準 Docker API を提供するため、既に Docker で使えるツールであれば、複数のホスト上で透過的にスケールさせることができます。

.. Also known as : docker-swarm

*別名：docker-swarm*


.. _glossary-swarm-mode:

swarm モード
====================

.. Swarm mode refers to cluster management and orchestration features embedded in Docker Engine. When you initialize a new swarm (cluster) or join nodes to a swarm, the Docker Engine runs in swarm mode.

:doc:`Swarm モード </engine/swarm/index>` とは、 Docker Engine 内蔵で、クラスタ管理とオーケストレーション機能拡張を指します。新しい swarm（クラスタ）を初期化するか、あるいはノードが swarm に加わると、Docker Engine は swarm モードで稼働します。


.. tag

.. _tag:

:ruby:`タグ <tag>`
==================

.. A tag is a label applied to a Docker image in a repository. tags are how various images in a repository are distinguished from each other.

タグ（tag）は :ref:`リポジトリ <repository>` 上の Docker イメージに割り当てるラベルです。タグを使い、リポジトリ上のイメージを互いに識別します。

.. Note : This label is not related to the key=value labels set for docker daemon

.. note::

   ここでのラベルとは、docker デーモン用のキー・バリューで設定するラベルとは関係がありません。

.. _task:

:ruby:`タスク <task>`
=====================

.. A task is the atomic unit of scheduling within a swarm. A task carries a Docker container and the commands to run inside the container. Manager nodes assign tasks to worker nodes according to the number of replicas set in the service scale.

.. :ref:`タスク <tasks-and-scheduling>` は swarm 内でスケジューリングする最小単位です。タスクは Docker コンテナを運び、コンテナ内部にあるコンテナを実行します。ノードへのタスク管理を管理し、サービスをスケールするために、ワーカ・ノードに複数のレプリカを割り当てます。

タスクは swarm 内でスケジューリングする最小単位です。タスクは Docker コンテナを運び、コンテナ内部にあるコンテナを実行します。ノードへのタスク管理を管理し、サービスをスケールするために、ワーカ・ノードに複数のレプリカを割り当てます。


.. The diagram below illustrates the relationship of services to tasks and containers.

下図はサービスにおけるタスクとコンテナの関係性を示します。

.. image:: /engine/images/services-diagram.png

.. Union file system

.. _union-file-system:

:ruby:`ユニオンファイルシステム <union file system>`
============================================================

.. Union file systems implement a union mount and operate by creating layers. Docker uses union file systems in conjunction with copy-on-write techniques to provide the building blocks for containers, making them very lightweight and fast.

ユニオン・ファイル・システム（Union file system）は `ユニオン・マウント <https://en.wikipedia.org/wiki/Union_mount>`_ の実装であり、レイヤ作成時に処理するものです。Docker はユニオン・ファイル・システムで結語するために :ref:`copy-on-write` 技術を使い、非常に軽量かつ高速なコンテナ用のブロックを構築します。

.. For more on Docker and union file systems, see Docker and AUFS in practice, Docker and Btrfs in practice, and Docker and OverlayFS in practice.

Docker 及びユニオン・ファイル・システムの詳細は、 :doc:`/storage/storagedriver/aufs-driver` 、:doc:`/storage/storagedriver/btrfs-driver` 、 :doc:`/storage/storagedriver/overlayfs-driver` をご覧ください。

.. Example implementations of union file systems are UnionFS, AUFS, and Btrfs.

ユニオン・ファイル・システムの実装例は `UnionFS <https://en.wikipedia.org/wiki/UnionFS>`_ 、`AUFS <https://en.wikipedia.org/wiki/Aufs>`_ 、 `Btrfs <https://btrfs.wiki.kernel.org/index.php/Main_Page>`_ です。

.. Virtual Machine

.. _virtual-machine:

:ruby:`仮想マシン <virtual machine>`
========================================
.. 
.. A Virtual Machine is a program that emulates a complete computer and imitates dedicated hardware. It shares physical hardware resources with other users but isolates the operating system. The end user has the same experience on a Virtual Machine as they would have on dedicated hardware.

仮想マシン（Virtual Machine）とは、コンピュータと疑似専用ハードウェアの全体をエミュレートするプログラムです。他のユーザと物理ハードウェアのリソースを共有しますが、オペレーティングシステムからは隔離されています。エンドユーザは専用ハードウェアと同じように仮想マシンを操作できます。

.. Compared to to containers, a Virtual Machine is heavier to run, provides more isolation, gets its own set of resources and does minimal sharing.

コンテナと比べると、仮想マシンの実行は重たいものですが、更なる隔離を提供し、自身でリソースを持っており、共有は最低限です。

.. Also known as : VM

*別名：VM*

.. _volume:

:ruby:`ボリューム <volume>`
==============================

.. A volume is a specially-designated directory within one or more containers that bypasses the Union File System. Volumes are designed to persist data, independent of the container’s life cycle. Docker therefore never automatically delete volumes when you remove a container, nor will it “garbage collect” volumes that are no longer referenced by a container. Also known as: data volume

ボリュームとは、複数のコンテナ内で用いる特別なディレクトリのことであり、ユニオンファイルシステムを通して利用します。ボリュームはデータを保持する目的で設計されており、コンテナのライフサイクルには影響されません。したがって、コンテナを削除したとしても、Docker はボリュームを自動的に削除しません。たとえコンテナから参照されなくなったボリュームであっても、「ガベージコレクト」により失われることもありません。これは :ruby:`データボリューム <data volume>` とも呼ばれます。

.. There are three types of volumes: host, anonymous, and named:

ボリュームには、 :ruby:`ホスト <host>` 、 :ruby:`匿名 <anonymous>` 、:ruby:`名前付き <named>` という３種類のタイプがあります。

..    A host volume lives on the Docker host’s filesystem and can be accessed from within the container.
..    A named volume is a volume which Docker manages where on disk the volume is created, but it is given a name.
..    An anonymous volume is similar to a named volume, however, it can be difficult, to refer to the same volume over time when it is an anonymous volumes. Docker handle where the files are stored.

   * **host ボリューム（host volume；ホストボリューム）** は Docker ホストのファイルシステム上に存在し、コンテナ内部からもアクセスできます。
   * **named ボリューム（named volume；名前付きボリューム）** は、Docker が管理するボリュームであり、ディスク上に生成されます。そこには名前がつけられます。
   * **anonymous ボリューム（anonymous volume；匿名ボリューム）**  は名前付きボリュームと似ています。ただし複雑な仕組みにより、匿名ボリュームである間も一意のボリュームとして参照されます。Docker はファイルを保存する場所として取り扱います。

.. _x86_64:

x86_64
==========

.. x86_64 (or x86-64) refers to a 64-bit instruction set invented by AMD as an extension of Intel’s x86 architecture. AMD calls its x86_64 architecture, AMD64, and Intel calls its implementation, Intel 64.

x86_64 (または x86-64) は、インテルの x86 アーキテクチャの AMD による 64 ビット拡張命令のセットです。AMD は自身のアーキレクチャを x86_64 アーキテクチャ、 AMD64 と呼び、インテルはこの実装を Intel 64 と呼びます。


.. seealso:: 

   Docker Glosary.rst
     https://docs.docker.com/glossary/
