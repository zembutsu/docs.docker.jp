.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/glossary/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/glossary.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/glossary.md
.. check date: 2016/06/14
.. Commits on Mar 4, 2016 69004ff67eed6525d56a92fdc69466c41606151a
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

.. A list of terms used around the Docker project.

Docker プロジェクト界隈で使われている用語の一覧です。

.. aufs

.. _aufs:

aufs
==========

.. aufs (advanced multi layered unification filesystem) is a Linux filesystem that Docker supports as a storage backend. It implements the union mount for Linux file systems.

aufs （advanced multi layered unification filesystem；複数のレイヤを統合した高度なファイルシステム、の意味）は、Docker がストレージ用のバックエンドとしてサポートする Linux の :ref:`ファイルシステム <filesystem>` です。

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

btrfs （B-tree file system；ビー・ツリー・ファイルシステム、バター・エフエス）は、Docker がストレージ用のバックエンドとしてサポートする Linux の :ref:`ファイルシステム <filesystem>` です。

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

データ・ボリューム
====================

.. A data volume is a specially-designated directory within one or more containers that bypasses the Union File System. Data volumes are designed to persist data, independent of the container’s life cycle. Docker therefore never automatically delete volumes when you remove a container, nor will it “garbage collect” volumes that are no longer referenced by a container.

データ・ボリューム（data volume）は、コンテナ内部でユニオン・ファイル・システムを迂回するため特別に設計されたディレクトリです。データ・ボリュームは長期的なデータ保管のために設計されており、コンテナのライフサイクルからは独立しています。そのため、コンテナを削除してもボリュームが自動的に消されることは有り得ませんし、コンテナから参照されなくなったボリュームが「掃除」（garbage collect）されることもありません。

.. Docker

.. _docker:

Docker
==========

.. The term Docker can refer to

Docker （ドッカー）には次の意味があります。

..    The Docker project as a whole, which is a platform for developers and sysadmins to develop, ship, and run applications
    The docker daemon process running on the host which manages images and containers

* Docker プロジェクト全体を指す言葉であり、開発者やシステム管理者がアプリケーションを開発・移動・実行するためのプラットフォームです。
* ホスト上で動く docker デーモンプロセスであり、イメージとコンテナを管理します。

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

Dockerfile（ドッカーファイル）はテキスト形式のドキュメントであり、通常 Docker イメージを構築するために手動で実行が必要になる全てのコマンドを含みます。Docker は Dockerfile の命令を読み込み、自動的にイメージを構築します。

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

OverlayFS は、他のファイルシステムに対する `ユニオン・マウント <http://en.wikipedia.org/wiki/Union_mount>`_ を Linux に実装するもので、 :ref:`ファイルシステム <filesystem>` 向けのサービスです。

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

.. Swarm

.. _glossary-swarm:

Swarm
==========

.. Swarm is a native clustering tool for Docker. Swarm pools together several Docker hosts and exposes them as a single virtual Docker host. It serves the standard Docker API, so any tool that already works with Docker can now transparently scale up to multiple hosts.

`Swarm <https://github.com/docker/swarm>`_ （スウォーム）は Docker 用のネイティブなクラスタリング・ツールです。Swarm は複数の Docker ホストを一緒にまとめ（プールする）、１つの仮想的な Docker ホストのように装います。Swarm は標準 Docker API を提供するため、既に Docker で使えるツールであれば、複数のホスト上で透過的にスケールさせることができます。

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

.. Toolbox

.. _Toolbox:

Toolbox
==========

.. Docker Toolbox is the installer for Mac and Windows users.

Docker Toolbox（ツールボックス）は Mac あるいは Windows ユーザ向けのインストーラです。

.. Union file system

.. _union-file-system:

ユニオン・ファイル・システム
==============================

.. Union file systems, or UnionFS, are file systems that operate by creating layers, making them very lightweight and fast. Docker uses union file systems to provide the building blocks for containers.

ユニオン・ファイル・システム（Union file system）や UnionFS は、非常に軽量で高速なレイヤを作成できるファイルシステムです。Docker はコンテナのブロック構築にユニオン・ファイル・システムを使います。

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

.. seealso:: 

   Glossary
      https://docs.docker.com/engine/reference/glossary/

