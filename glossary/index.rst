.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/glossary/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/glossary.md
.. check date: 2017/06/20
.. -------------------------------------------------------------------


.. Glossary

.. _glossary:

========================================
用語集
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. To see a definition for a term, and all topics in the documentation that have been tagged with that term, click any entry below:

用語の定義や、ドキュメント内でタグ付けされたトピックを参照するには、各項目をクリックしてください。


.. aufs

.. _aufs:

aufs
==========

.. aufs (advanced multi layered unification filesystem) is a Linux filesystem that Docker supports as a storage backend. It implements the union mount for Linux file systems.

aufs （advanced multi layered unification filesystem；複数のレイヤを統合した高度なファイルシステム、の意味）は Linux の ファイルシステム であり、Docker がサポートするストレージ用のバックエンドです。

.. Base image

.. _base-image:

ベース・イメージ（base image）
==============================

.. An image that has no parent is a base image.

親イメージを持たないイメージを、 **ベース・イメージ** と呼びます。

.. boot2docker

.. _glossary-boot2docker:

boot2docker
====================

.. boot2docker is a lightweight Linux distribution made specifically to run Docker containers. The boot2docker management tool for Mac and Windows was deprecated and replaced by docker-machine which you can install with the Docker Toolbox.

`boot2docker <http://boot2docker.io/>`_ （ブート・トゥ・ドッカー）は Docker コンテナの実行に特化した Linux ディストリビューションです。Mac 及び Windows 向けの boot2docker は、Docker Toolbox のインストールに含まれる ``docker-machine`` に置き換えられました。

.. btrfs

btrfs
==========

.. btrfs (B-tree file system) is a Linux filesystem that Docker supports as a storage backend. It is a copy-on-write filesystem.

btrfs （B-tree file system；ビー・ツリー・ファイルシステム、バター・エフエス）は、Docker がストレージ用のバックエンドとしてサポートする Linux の :ref:`ファイルシステム <filesystem>` です。これは :ref:`コピー・オン・ライト <copy-on-write>` のファイルシステムです。

.. build

.. _build:

ビルド（build）
====================

.. build is the process of building Docker images using a Dockerfile. The build uses a Dockerfile and a “context”. The context is the set of files in the directory in which the image is built.

ビルド（build）とは、 :ref:`Dockerfile` を使って Docker イメージを構築する方法です。構築時には Dockerfile と「コンテクスト」（内容物の意味）を使います。コンテクストとは、イメージ構築に必要なファイル群が置かれているディレクトリです。

.. cgroups

.. _cgroups:

cgroups
==========

.. cgroups is a Linux kernel feature that limits, accounts for, and isolates the resource usage (CPU, memory, disk I/O, network, etc.) of a collection of processes. Docker relies on cgroups to control and isolate resource limits.

cgroups （control groups；コントロール・グループ）は Linux カーネルの機能であり、プロセスの集合が使うリソース（CPU、メモリ、ディスク I/O、ネットワーク等）を制限・計算・隔離します。Docker はリソース上限の管理と隔離に cgroups を使います。

.. Also known as : control groups

*cgroups の別名：control groups*

.. Compose

.. _compose:

Compose
==========

.. Compose is a tool for defining and running complex applications with Docker. With compose, you define a multi-container application in a single file, then spin your application up in a single command which does everything that needs to be done to get it running.

:doc:`Compose </compose/index>` （コンポーズ）は、Docker で複雑なアプリケーションの実行と定義をするツールです。Compose を使えば、１つのファイルに複数のコンテナ・アプリケーションを定義しておき、コマンドを１つ実行するだけで、アプリケーションを使うために必要な全てを実行します。

.. Also known as : docker-compose, fig

*Compose の別名： docker-compose、fig*

.. Definition of: copy-on-write

.. _copy-on-write:

コピー・オン・ライト(copy-on-write)
========================================

.. Docker uses a copy-on-write technique and a union file system for both images and containers to optimize resources and speed performance. Multiple copies of an entity share the same instance and each one makes only specific changes to its unique layer.

Docker はイメージとコンテナのリソース最適化とスピード性能のために、 :doc:`コピー・オン・ライト </engine/userguide/storagedriver/imagesandcontainers>` 技術と :ref:`union-file-system` を使います。

.. Multiple containers can share access to the same image, and make container-specific changes on a writable layer which is deleted when the container is removed. This speeds up container start times and performance.

複数のコンテナは同じイメージに共有してアクセスできます。そして、コンテナの書き込み可能なレイヤに対する固有の変更が可能であり、コンテナ削除時にこのレイヤは削除されます。

.. Images are essentially layers of filesystems typically predicated on a base image under a writable layer, and built up with layers of differences from the base image. This minimizes the footprint of the image and enables shared development.

イメージとは実質的にファイルシステムのレイヤであり、一般的には書き込み可能なレイヤの下にはベース・イメージを基礎としています。そして、ベース・イメージとは異なったレイヤを積み上げます。これによりイメージの容量を最小化し、開発環境でイメージを共有できるようになります。

.. For more about copy-on-write in the context of Docker, see Understand images, containers, and storage drivers.

Docker の文脈におけるコピー・オン・ライトの詳細は、 :doc:`/engine/userguide/storagedriver/imagesandcontainers` をご覧ください。


.. container

.. _container:

コンテナ
==========

.. A container is a runtime instance of a docker image.

コンテナ（container）は :ref:`docker イメージ <image>` を実行するときの実体（runtime instance）です。

.. A Docker container consists of

Docker コンテナには、次のものを含みます。

..    A Docker image
    Execution environment
    A standard set of instructions

* Docker イメージ
* 実行環境
* 命令の標準セット

.. The concept is borrowed from Shipping Containers, which define a standard to ship goods globally. Docker defines a standard to ship software.

Docker コンテナの概念は、輸送用のコンテナから拝借したものです。コンテナは物を世界的に輸送するために標準が定義されています。Docker はソフトウェアを送るための標準を定義しています。

.. data volume

.. _data-volume:

.. データ・ボリューム
.. ====================

.. A data volume is a specially-designated directory within one or more containers that bypasses the Union File System. Data volumes are designed to persist data, independent of the container’s life cycle. Docker therefore never automatically delete volumes when you remove a container, nor will it “garbage collect” volumes that are no longer referenced by a container.

.. データ・ボリューム（data volume）は、コンテナ内部でユニオン・ファイル・システムを迂回するため特別に設計されたディレクトリです。データ・ボリュームは長期的なデータ保管のために設計されており、コンテナのライフサイクルからは独立しています。そのため、コンテナを削除してもボリュームが自動的に消されることは有り得ませんし、コンテナから参照されなくなったボリュームが「掃除」（garbage collect）されることもありません。

.. Docker

.. _docker:

Docker
==========

.. The term Docker can refer to

Docker （ドッカー）には次の意味があります。

..    The Docker project as a whole, which is a platform for developers and sysadmins to develop, ship, and run applications
    The docker daemon process running on the host which manages images and containers (also called Docker Engine)

* Docker プロジェクト全体を指す言葉であり、開発者やシステム管理者がアプリケーションを開発・移動・実行するためのプラットフォームです。
* ホスト上で動く docker デーモンのプロセスであり、イメージとコンテナを管理します。Docker Engine（エンジン）とも呼びます。


.. Definition of: Docker Datacenter

.. _docker-datacenter:

Docker Datacenter
====================

.. The Docker Datacenter is subscription-based service enabling enterprises to leverage a platform built by Docker, for Docker. The Docker native tools are integrated to create an on premises CaaS platform, allowing organizations to save time and seamlessly take applications built in dev to production.


Docker Datacenter（データセンタ）は Docker で構築するプラットフォームをエンタープライズに強化するもので、サブスクリプションを基本とする Docker 向けのサービスです。Docker ネイティブのツールが統合されることで、オンプレミスの CaaS プラットフォームを構築でき、組織における時間の接続や、開発からプロダクションへのアプリケーション構築をシームレスに行えます。

.. Definition of: Docker for Mac

.. _docker-for-mac:

Docker for Mac
====================

.. Docker for Mac is an easy-to-install, lightweight Docker development environment designed specifically for the Mac. A native Mac application, Docker for Mac uses the macOS Hypervisor framework, networking, and filesystem. It’s the best solution if you want to build, debug, test, package, and ship Dockerized applications on a Mac. Docker for Mac supersedes Docker Toolbox as state-of-the-art Docker on macOS.

:doc:`Docker for Mac </docker-for-mac/index>` は、 Mac 向けに特化したインストールが簡単で、軽量な Docker 開発環境として設計されています。ネイティブな Mac アプリケーション実行のため、Docker for Mac は macOS のハイパーバイザ・フレームワーク、ネットワーク機能、ファイルシステムを使います。 Mac 上で Docker 対応アプリケーションの開発・構築・テスト・パッケージ・移動をしたい場合に、ベストな解決策です。macOS 上で Docker を使うにあたり、Docker for Mac は :ref:`Docker Toolbox <toolbox>` の後継としての位置付け です。

.. _docker-for-windows:

Docker for Windows
====================

.. Docker for Windows is an easy-to-install, lightweight Docker development environment designed specifically for Windows 10 systems that support Microsoft Hyper-V (Professional, Enterprise and Education). Docker for Windows uses Hyper-V for virtualization, and runs as a native Windows app. It works with Windows Server 2016, and gives you the ability to set up and run Windows containers as well as the standard Linux containers, with an option to switch between the two. Docker for Windows is the best solution if you want to build, debug, test, package, and ship Dockerized applications from Windows machines. Docker for Windows supersedes Docker Toolbox as state-of-the-art Docker on Windows.

:doc:`Docker for Windows </docker-for-windows/index>` は、Microsoft Hyper-V（Professional、Enterprise、Education）をサポートしているWindows 10 システム向けに特化した、軽量な Docker 開発環境として設計されています。Docker for Windows はネイティブな Windows アプリケーション実行のため、Hyper-V 仮想化を使います。標準的な Linux コンテナと同じように、２つのオプションを切り替えるだけで、Windows コンテナの迅速なセットアップや実行を Windows Server 2016 上でも行えます。Windows マシン上で Docker 対応アプリケーションの開発・構築・テスト・パッケージ・移動をしたい場合に、ベストな解決作です。Windows マシン上で Docker を使うにあたり、Docker for Mac は :ref:`Docker Toolbox <toolbox>` の後継としての位置付け です。

.. Docker Hub

.. _docker-hub:

Docker Hub
==========

.. The Docker Hub is a centralized resource for working with Docker and its components. It provides the following services:

`Docker Hub <https://hub.docker.com/>`_ （ドッカー・ハブ）は Docker とこのコンポーネントで動くリソースを集めた場所です。以下のサービスを提供します。

..    Docker image hosting
    User authentication
    Automated image builds and work-flow tools such as build triggers and web hooks
    Integration with GitHub and Bitbucket

* Docker イメージを預かる（ホスティング）
* ユーザ認証
* イメージの自動構築と、構築トリガ（build triggers）やウェブ・フック（web hooks）のようなワークフロー・ツール
* GitHub 及び Bitbucket との統合

.. Dockerfile

.. _Dockerfile:

Dockerfile
==========

.. A Dockerfile is a text document that contains all the commands you would normally execute manually in order to build a Docker image. Docker can build images automatically by reading the instructions from a Dockerfile.

Dockerfile（ドッカーファイル）はテキスト形式のドキュメントです。通常は、 Docker イメージを構築するために手動で実行が必要な全ての命令を含みます。Docker は Dockerfile の命令を読み込み、自動的にイメージを構築します。

.. Definition of: ENTRYPOINT

.. _ENTRYPOINT:

ENTRYPOINT
==========

.. In a Dockerfile, an ENTRYPOINT is an optional definition for the first part of the command to be run. If you want your Dockerfile to be runnable without specifying additional arguments to the docker run command, you must specify either ENTRYPOINT, CMD, or both.

Dockerfile において、 ``ENTRYPOINT`` は一番初めに実行すべきコマンドのオプション定義です。``docker run`` コマンド実行時、何も引数を追加しなくても実行可能な ``Dockerfile`` を作りたい場合は、 ``ENTRYPOINT`` か ``CMD`` のどちらか、あるいは両方の指定が必要です。

..    If ENTRYPOINT is specified, it is set to a single command. Most official Docker images have an ENTRYPOINT of /bin/sh or /bin/bash. Even if you do not specify ENTRYPOINT, you may inherit it from the base image that you specify using the FROM keyword in your Dockerfile. To override the ENTRYPOINT at runtime, you can use --entrypoint. The following example overrides the entrypoint to be /bin/ls and sets the CMD to -l /tmp.


- ``ENTRYPOINT`` を指定すると、単一のコマンドとしての指定になります。公式 Docker イメージの大部分は ``/bin/sh`` または ``/bin/bash`` を ``ENTRYPOINT``` に指定しています。 ``ENTRYPOINT`` を指定しなければ、Dockerfile の ``FROM`` キーワード指定されているベース・イメージの指定を継承します。実行時に ``ENTRYPOINT`` を上書きしたい場合は、 ``--entrypoint`` を使えます。次の例はエントリーポイントを ``/bin/ls`` に置き換え、 ``CMD`` を ``-l /tmp`` に指定します。

   .. code-block:: bash

      $ docker run --entrypoint=/bin/ls ubuntu -l /tmp

..    CMD is appended to the ENTRYPOINT. The CMD can be any arbitrary string that is valid in terms of the ENTRYPOINT, which allows you to pass multiple commands or flags at once. To override the CMD at runtime, just add it after the container name or ID. In the following example, the CMD is overridden to be /bin/ls -l /tmp.

- ``CMD`` は ``ENTRYPOINT`` に追加されます。 ``ENTRYPOINT`` で利用可能な文字列であれば、複数のコマンドやフラグ１つなど、どのようなものでも ``CMD`` に書けます。実行時に ``CMD`` を上書きするには、コンテナ名や ID のあとに追加するだけです。次の例は ``CMD`` を ``/bin/ls -l /tmp`` に上書きします。

   .. code-block:: bash

      $ docker run ubuntu /bin/ls -l /tmp

.. In practice, ENTRYPOINT is not often overridden. However, specifying the ENTRYPOINT can make your images more fiexible and easier to reuse.

実際には、 ``ENTRYPOINT`` を頻繁に上書きしません。しかしながら、 ``ENTRYPOINT``  の指定によってイメージをより柔軟かつ再利用しやすくします。


.. filesystem

.. _filesystem:

ファイルシステム
====================

.. A file system is the method an operating system uses to name files and assign them locations for efficient storage and retrieval.

ファイルシステムとは、オペレーティング・システムがファイルに名前を付け、かつ、効率的な保管と修正のためにファイルに場所を割り当てます。

.. Examples :

例：

* Linux : ext4, aufs, btrfs, zfs
* Windows : NTFS
* OS X : HFS+

.. image

.. _image:

イメージ
==========

.. Docker images are the basis of containers. An Image is an ordered collection of root filesystem changes and the corresponding execution parameters for use within a container runtime. An image typically contains a union of layered filesystems stacked on top of each other. An image does not have state and it never changes.

Docker イメージは :ref:`コンテナ <container>` の元です。イメージとはルート・ファイルシステムに対する変更を並べ集めたもので、コンテナを実行する間に使われる実行パラメータに相当します。典型的なイメージはユニオン・ファイル・システムの層（スタック）がお互いに積み重なっています。イメージは状態を保持せず、変更もできません。

.. _Kitematic:

Kitematic
==========

.. A legacy GUI, bundled with Docker Toolbox, for managing Docker containers. We recommend upgrading to Docker for Mac or Docker for Windows, which have superseded Kitematic.

以前からある Docker コンテナ管理用 GUI であり、 `Docker Toolbox <https://docs.docker.com/glossary/?term=toolbox>`_ に同梱されていました。Kitematic に代わる `Docker for Mac <https://docs.docker.com/glossary/?term=docker-for-mac>`_  か `Docker for Windows <https://docs.docker.com/glossary/?term=docker-for-windows/>`_ への更新を推奨します。

.. _layter:

レイヤ
==========

.. In an image, a layer is modification to the image, represented by an instruction in the Dockerfile. Layers are applied in sequence to the base image to create the final image. When an image is updated or rebuilt, only layers that change need to be updated, and unchanged layers are cached locally. This is part of why Docker images are so fast and lightweight. The sizes of each layer add up to equal the size of the final image.

イメージ内部において、イメージに対する変更がレイヤです。これらは Dockerfile 内における命令を意味します。ベース・イメージから最終的なイメージを作成するまで、レイヤは順番に重なります。イメージの更新や再構築時は、更新が必要となるレイヤのみを変更し、変更のないレイヤはローカルでキャッシュします。これが Docker イメージはなぜ高速かつ軽量なのかという理由の１つです。各レイヤの容量の合計が、最終的なイメージの容量と同じです。



.. libcontainer

.. _libcontainer:

libcontainer
====================

.. libcontainer provides a native Go implementation for creating containers with namespaces, cgroups, capabilities, and filesystem access controls. It allows you to manage the lifecycle of the container performing additional operations after the container is created.

libcontainer（リブコンテナ）は Go 言語のネイティブな実装であり、名前空間・cgroup・機能・ファイルシステムへのアクセス管理を持つコンテナを作成します。コンテナを作成後、コンテナに対してライフサイクル上の追加操作を可能にします。

.. libnetwork

.. _libnetwork:

libnetwork
==========

.. libnetwork provides a native Go implementation for creating and managing container network namespaces and other network resources. It manage the networking lifecycle of the container performing additional operations after the container is created.

libnetwork（リブネットワーク）は Go 言語のネイティブな実装であり、コンテナのネットワーク名前空間や他のネットワーク・リソースを作成・管理します。コンテナを作成後、コンテナに対してライフサイクル上の追加操作を可能にします。

.. link

.. _link:

リンク機能（link）
====================

.. links provide a legacy interface to connect Docker containers running on the same host to each other without exposing the hosts’ network ports. Use the Docker networks feature instead.

リンク機能は同じホスト上で実行している Docker コンテナ間を接続するための、レガシーな（古い）インターフェースです。リンク機能を使うと、ホスト側のネットワーク・ポートを開く必要がありません。現在は、この機能の替わりに Docker ネットワーク機能を使います。

.. Machine

.. _glossary-machine:

Machine
==========

.. Machine is a Docker tool which makes it really easy to create Docker hosts on your computer, on cloud providers and inside your own data center. It creates servers, installs Docker on them, then configures the Docker client to talk to them.

`Machine <https://github.com/docker/machine>`_ （マシン）は Docker ホストを簡単に作成できるようにするツールであり、クラウド・プロバイダ上やデータセンタでも利用できます。Machine はサーバを作成し、そこに Docker をインストールし、Docker クライアントで通信できるように設定します。

.. Also known as : docker-machine

*別名： docker-machine*

.. _namespace:

名前空間（namespace）
==============================

.. A Linux namespace is a Linux kernel feature that isolates and vitualizes system resources. Processes which restricted to a namespace can only interact with resources or processes that are part of the same namespace. Namespaces are an important part of Docker’s isolation model. Namespaces exist for each type of resource, including net (networking), mnt (storage), pid (processes), uts (hostname control), and user (UID mapping). For more information about namespaces, see Docker run reference and Introduction to user namespaces.
Glossary terms

`Linux 名前空間（namespace；ネームスペース） <http://man7.org/linux/man-pages/man7/namespaces.7.html>`_ は  Linux カーネルの分離（isolate）と仮想システム・リソース機能です。名前空間によって制限されたプロセスは、お味名前空間内のリソースやプロセスとしかやりとりできません。名前空間は Docker の分離モデルにおける重要な部分です。名前空間は各リソース・タイプごとに存在しています。リソース・タイプとは ``net`` （ネットワーク機能）、 ``mnt`` （ストレージ）、 ``pid`` （プロセス）、 ``uts`` （ホスト名の制御）、 ``user`` （UID 割り当て）です。名前空間に関する詳しい情報は、 :doc:`Docker run リファレンス </engine/reference/run>` と `ユーザ名前空間入門（英語） <https://success.docker.com/KBase/Introduction_to_User_Namespaces_in_Docker_Engine>`_ をご覧ください。


.. _node:

ノード
==========

.. A node is a physical or virtual machine running an instance of the Docker Engine in swarm mode.

:doc:`ノード </engine/swarm/how-swarm-mode-works/nodes>` とは、swarm モード上における Docker Engine が動作している物理または仮想マシンを指します。

.. Manager nodes perform swarm management and orchestration duties. By default manager nodes are also worker nodes.

**マネージャ・ノード（Manager node）** は swarm（クラスタ）管理とオーケストレーションの責務を処理します。デフォルトでは、マネージャ・ノードはワーカ・ノードも兼ねます。

.. Worker nodes execute tasks.

**ワーカ・ノード（Worker node）** はタスクを実行します。


.. overlay network driver

.. _overlay-network-driver:

オーバレイ・ネットワーク・ドライバ
========================================

.. Overlay network driver provides out of the box multi-host network connectivity for docker containers in a cluster.

オーバレイ・ネットワーク・ドライバ（overlay network driver）は、クラスタ上の Docker コンテナに対して、複数ホスト間のネットワーク接続性を簡単に提供します。

.. overlay storage driver

.. _overlay-storage-driver:

オーバレイ・ストレージ・ドライバ
========================================

.. OverlayFS is a filesystem service for Linux which implements a union mount for other file systems. It is supported by the Docker daemon as a storage driver.

OverlayFS は、他のファイルシステムに対する `ユニオン・マウント <http://en.wikipedia.org/wiki/Union_mount>`__ を Linux に実装するもので、 :ref:`ファイルシステム <filesystem>` 向けのサービスです。

.. registry

.. _registry:

レジストリ（registry）
==============================

.. A Registry is a hosted service containing repositories of images which responds to the Registry API.

レジストリ（registry）とは :ref:`イメージ <image>` を持つ :ref:`リポジトリ <repository>` を預かるサービス（ホステッド・サービス）であり、レジストリ API に応答します。

.. The default registry can be accessed using a browser at Docker Hub or using the docker search command.

デフォルトのレジストリにアクセスするには、ブラウザで :ref:`Docker Hub <docker-hub>` を開くか、 ``docker search`` コマンドを使います。

.. repository

.. _repository:

リポジトリ（repository）
==============================

.. A repository is a set of Docker images. A repository can be shared by pushing it to a registry server. The different images in the repository can be labeled using tags.

リポジトリ（repository）とは Docker イメージの集まりです。リポジトリは :ref:`レジストリ <registry>` サーバに送信すると、共有されるようにできます。リポジトリの中では、イメージの違いを :ref:`タグ <tag>` でラベル付けします。

.. Here is an example of the shared nginx repository and its tags

共有 `Nginx リポジトリ <https://hub.docker.com/r/library/nginx/tags>`_ と `タグ <https://hub.docker.com/r/library/nginx/tags>`_ の例です。

.. _SSH:

SSH
==========

.. SSH (secure shell) is a secure protocol for accessing remote machines and applications. It provides authentication and encrypts data communication over insecure networks such as the Internet. SSH uses public/private key pairs to authenticate logins.

SSH（secure shell；安全なシェル）はリモート・マシンやアプリケーションに接続するための安全なプロトコルです。インターネットのような安全ではないネットワーク越しに、認証や暗号データ通信を行います。SSH はログイン認証にあたって公開鍵/秘密鍵のペアを使います。

.. _service:

サービス
==========

.. A service is the definition of how you want to run your application containers in a swarm. At the most basic level a service defines which container image to run in the swarm and which commands to run in the container. For orchestration purposes, the service defines the “desired state”, meaning how many containers to run as tasks and constraints for deploying the containers.

:doc:`サービス </engine/swarm/how-swarm-mode-works/services>` は、 swarm 上でアプリケーション・コンテナをどのように実行するかの定義です。最も基本的なレベルのサービス定義とは、swarm 上でどのコンテナ・イメージを実行するか、そして、どのコマンドをコンテナで実行するかです。オーケストレーションの目的は「望ましい状態（desired state）」としてサービスを定義することです。つまり、いくつのコンテナをタスクとして実行するか、コンテナをデプロイする条件（constraint）を指します。

.. Frequently a service is a microservice within the context of some larger application. Examples of services might include an HTTP server, a database, or any other type of executable program that you wish to run in a distributed environment.

時々、巨大なアプリケーションという文脈において、マイクロサービスのことをサービスとも呼びます。サービスとは HTTP サーバやデータベースかもしれません。これは、分散環境において実行したい、あらゆる種類の実行可能なプログラムです。


.. _service-discovery:

サービス・ディスカバリ
==============================

.. Swarm mode service discovery is a DNS component internal to the swarm that automatically assigns each service on an overlay network in the swarm a VIP and DNS entry. Containers on the network share DNS mappings for the service via gossip so any container on the network can access the service via its service name.

Swarm モードの :ref:`サービス・ディスカバリ <use-swarm-mode-service-discovery>` は、swarm クラスタ内部における DNS コンポーネントです。これは、オーバレイ・ネットワーク上の各サービスに対し、VIP と DNS エントリを自動的に割り当てます。ネットワーク上のコンテナはゴシップ（訳者注；分散環境における通信プロトコルの一種です）を経由し、各サービス向けに割り当てられた DNS を共有します。そのため、ネットワーク上における全てのコンテナ上にあるサービスに対し、サービス名でアクセスできます。

.. You don’t need to expose service-specific ports to make the service available to other services on the same overlay network. The swarm’s internal load balancer automatically distributes requests to the service VIP among the active tasks.

サービスごとにポートを公開する必要がないため、同じオーバレイ・ネットワーク上で他のサービスが動いているかどうかを確認する必要はありません。アクティブなタスクごとサービス用の VIP を持ち、swarm の内部ロードランサはリクエストごとにアクセスを分散します。


.. Swarm

.. _glossary-swarm:

Swarm
==========

.. A swarm is a cluster of one or more Docker Engines running in swarm mode.

:doc:`swarm </engine/swarm/index>` とは swarm モードで動作する Docker Engine のクラスタのことです。


.. Docker Swarm

.. _glossary-docker-swarm:

Docker Swarm
====================

.. Do not confuse Docker Swarm with the swarm mode features in Docker Engine.

Docker Swarm と Docker Engine の swarm モードを混同しないでください。

.. Docker Swarm is the name of a standalone native clustering tool for Docker. Docker Swarm pools together several Docker hosts and exposes them as a single virtual Docker host. It serves the standard Docker API, so any tool that already works with Docker can now transparently scale up to multiple hosts.

Docker Swarm は Docker 用に独立したネイティブなクラスタリング・ツールです。Docker Swarm は複数の DOcker ホストを一緒にまとめ（プールし）、１つの仮想的な Docker ホストのように装います。Swarm は標準 Docker API を提供するため、既に Docker で使えるツールであれば、複数のホスト上で透過的にスケールさせることができます。

.. Also known as : docker-swarm

*別名：docker-swarm*

.. tag

.. _tag:

タグ
==========

.. A tag is a label applied to a Docker image in a repository. tags are how various images in a repository are distinguished from each other.

タグ（tag）は :ref:`リポジトリ <repository>` 上の Docker イメージに割り当てるラベルです。タグを使い、リポジトリ上のイメージを互いに識別します。

.. Note : This label is not related to the key=value labels set for docker daemon

.. note::

   ここでのラベルとは、docker デーモン用のキー・バリューで設定するラベルとは関係がありません。

.. _task:

タスク
==========

.. A task is the atomic unit of scheduling within a swarm. A task carries a Docker container and the commands to run inside the container. Manager nodes assign tasks to worker nodes according to the number of replicas set in the service scale.

:ref:`タスク <tasks-and-scheduling>` は swarm 内でスケジューリングする最小単位です。タスクは Docker コンテナを運び、コンテナ内部にあるコンテナを実行します。ノードへのタスク管理を管理し、サービスをスケールするために、ワーカ・ノードに複数のレプリカを割り当てます。

.. The diagram below illustrates the relationship of services to tasks and containers.

下図はサービスにおけるタスクとコンテナの関係性を示します。

.. image:: /engine/images/services-diagram.png


.. Toolbox

.. _Toolbox:

Toolbox
==========

.. Docker Toolbox is a legacy installer for Mac and Windows users. It uses Oracle VirtualBox for virtualization.

:doc:`Docker Toolbox </toolbox/overview>` は Mac と Windows に対応した過去のインストーラです。こちらは Oracle VirtualBox 仮想化を使います。

.. For Macs running OS X El Capitan 10.11 and newer macOS releases, Docker for Mac is the better solution.

Mac で OS X EI Capitan 10.11 か、これよりも新しい macOS リリースをお使いであれば、 :doc:`Docker for mac </docker-for-mac/index.>` のほうが良いソリューションです。

.. For Windows 10 systems that support Microsoft Hyper-V (Professional, Enterprise and Education), Docker for Windows is the better solution.

Windows 10 で Microsoft Hyper-V のサポートがあれば（Professional、Enterprise、Education）、 :doc:`Docker for Windows </docker-for-windows/index>`  のほうが良いソリューションです。


.. Union file system

.. _union-file-system:

ユニオン・ファイル・システム
==============================

.. Union file systems implement a union mount and operate by creating layers. Docker uses union file systems in conjunction with copy-on-write techniques to provide the building blocks for containers, making them very lightweight and fast.

ユニオン・ファイル・システム（Union file system）は `ユニオン・マウント <https://en.wikipedia.org/wiki/Union_mount>`_ の実装であり、レイヤ作成時に処理するものです。Docker はユニオン・ファイル・システムで結語するために :ref:`copy-on-write` 技術を使い、非常に軽量勝つ高速なコンテナ用のブロックを構築します。

.. For more on Docker and union file systems, see Docker and AUFS in practice, Docker and Btrfs in practice, and Docker and OverlayFS in practice.

Docker 及びユニオン・ファイル・システムの詳細は、 :doc:`/engine/userguide/storagedriver/aufs-driver` 、:doc:`/engine/userguide/storagedriver/btrfs-driver` 、 :doc:`/engine/userguide/storagedriver/overlayfs-driver` をご覧ください。

.. Example implementations of union file systems are UnionFS, AUFS, and Btrfs.

ユニオン・ファイル・システムの実装例は `UnionFS <https://en.wikipedia.org/wiki/UnionFS>`_ 、`AUFS <https://en.wikipedia.org/wiki/Aufs>`_ 、 `Btrfs <https://btrfs.wiki.kernel.org/index.php/Main_Page>`_ です。

.. Virtual Machine

.. _virtual-machine:

仮想マシン
==========

.. A Virtual Machine is a program that emulates a complete computer and imitates dedicated hardware. It shares physical hardware resources with other users but isolates the operating system. The end user has the same experience on a Virtual Machine as they would have on dedicated hardware.

仮想マシン（Virtual Machine）とは、コンピュータと疑似専用ハードウェアの全体をエミュレートするプログラムです。他のユーザと物理ハードウェアのリソースを共有しますが、オペレーティング・システムからは隔離されています。エンドユーザは専用ハードウェアと同じように仮想マシンを操作できます。

.. Compared to to containers, a Virtual Machine is heavier to run, provides more isolation, gets its own set of resources and does minimal sharing.

コンテナと比べると、仮想マシンの実行は重たいものですが、更なる隔離を提供し、自身でリソースを持っており、共有は最低限です。

.. Also known as : VM

*別名：VM*

.. _volume:

ボリューム
==========

.. A volume is a specially-designated directory within one or more containers that bypasses the Union File System. Volumes are designed to persist data, independent of the container’s life cycle. Docker therefore never automatically delete volumes when you remove a container, nor will it “garbage collect” volumes that are no longer referenced by a container. Also known as: data volume

ボリュームとは特別に設計されたディレクトリであり、ユニオン・ファイル・システムを迂回し、複数のコンテナ内で使えます。ボリュームは永続的なデータを保管するために設計されており、コンテナのライフサイクルとは独立しています。そのため、Docker はコンテナの削除時に、ボリュームを決して自動的に削除しません。そればかりか「ガベージ・コレクト」（ゴミ収集；garbage collect）ボリュームとして、コンテナからは参照できないようにもできます。これは *データ・ボリューム（data volume）* とも呼ばれます。

.. There are three types of volumes: host, anonymous, and named:

ボリュームは、ホスト（*host*）、匿名（*anonymous*）、名前付き（*named*）の3種類です。

..    A host volume lives on the Docker host’s filesystem and can be accessed from within the container.
..    A named volume is a volume which Docker manages where on disk the volume is created, but it is given a name.
..    An anonymous volume is similar to a named volume, however, it can be difficult, to refer to the same volume over time when it is an anonymous volumes. Docker handle where the files are stored.

   * **ホスト・ボリューム（host volume）** は Docker ホストのファイルシステム上に存在し、コンテナ内部からもアクセスできます。
   * **名前付きボリューム（named volume）** は Docker が管理するディスク上に作成されたボリュームであり、名前を指定しています。
   * **匿名ボリューム（anonymous volume）**  は名前付きボリュームと似ていますが、匿名ボリュームとして作成すると対象となるボリュームを特定するのが大変で、時間がかかります。Docker がファイルをどこに保管するか処理します。


.. seealso:: 

   Docker Glosary.rst
     https://docs.docker.com/glossary/