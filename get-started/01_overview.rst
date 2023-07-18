.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/get-started/
   doc version: 24.0
      https://github.com/docker/docker.github.io/blob/master/get-started/index.md
.. check date: 2023/07/18
.. Commits on Mar 1, 2023 5f613c757a31ffbe1585e63491d19093afbde7a2
.. -----------------------------------------------------------------------------

.. Overview
.. _get-started-overview:

========================================
概要
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 2
       :local:

.. Welcome! We are excited that you want to learn Docker.

ようこそ！ あなたが Docker を学ぼうとしているので、私たちはとてもうれしいです。

.. This guide contains step-by-step instructions on how to get started with Docker. Some of the things you’ll learn and do in this guide are:

このガイドでは順を追った手順に従い、Docker の始め方を学びます。このガイドで学び、できるようになるのは以下の項目です。

..
    Build and run an image as a container
    Share images using Docker Hub
    Deploy Docker applications using multiple containers with a database
    Run applications using Docker Compose

* イメージをコンテナとして構築と実行
* Docker Hub を使ったイメージ共有
* データベースを持つ複数のコンテナを使う Docker アプリケーションのデプロイ
* Docker Compose を使ってアプリケーションを実行

.. Before you get to the hands on part of the guide, you should learn about containers and images.

ガイドに進む前に、コンテナとイメージについて学ぶべきです。

.. What is a container?
.. _what-is-a-container:

コンテナとは何？
====================

.. Simply put, a container is a sandboxed process on your machine that is isolated from all other processes on the host machine. That isolation leverages kernel namespaces and cgroups, features that have been in Linux for a long time. Docker has worked to make these capabilities approachable and easy to use. To summarize, a container:

簡単に言えば、 :ruby:`コンテナ <container>` とはマシン上でサンドボックス化したプロセスであり、ホストマシン上にある他すべてのプロセスから :ruby:`隔離 <isolate>` されています。この隔離とは `カーネルの名前空間と cgroup <https://medium.com/@saschagrunert/demystifying-containers-part-i-kernel-space-2c53d6979504>`_ の活用であり、長らく Linux に存在する機能です。Docker はこれらの :ruby:`能力 <capability>` を、分かりやすく簡単に使えます。コンテナについてまとめますと、次のようになります：

..    is a runnable instance of an image. You can create, start, stop, move, or delete a container using the DockerAPI or CLI.
    can be run on local machines, virtual machines or deployed to the cloud.
    is portable (can be run on any OS)
    is isolated from other containers and runs its own software, binaries, and configurations.

* イメージの実行可能な :ruby:`実体（インスタンス） <instance>` 。Docker API や CLI を使い、コンテナの作成、開始、停止、移動、削除ができます。
* ローカルマシン上や仮想マシン上で実行できるのに加え、クラウドにもデプロイできます。
* :ruby:`可搬性（ポータビリティ） <portability>` があります（多くの OS で実行できます）。
* コンテナはお互いに隔離され、実行にはそれぞれが自身のソフトウェア、バイナリ、設定を使います。

.. What is a container image?
.. _what-is-a-container-image:

コンテナ イメージとは何でしょうか？
========================================

.. When running a container, it uses an isolated filesystem. This custom filesystem is provided by a container image. Since the image contains the container’s filesystem, it must contain everything needed to run an application - all dependencies, configurations, scripts, binaries, etc. The image also contains other configuration for the container, such as environment variables, a default command to run, and other metadata.

コンテナを実行したら、コンテナは隔離されたファイルシステムを使います。この特別なファイルシステムは :ruby:`コンテナ イメージ <container image>` によって提供されます。イメージにはコンテナのファイルシステムが含まれており、アプリケーションの実行に必要な全てを含む必要があります。例えば、全ての（アプリケーションを実行するために必要なパッケージ等の）依存関係、設定ファイル、スクリプト、バイナリ等です。また、このイメージには環境変数、デフォルトで実行するコマンド、メタデータのような他の設定も含みます。

.. We’ll dive deeper into images later on, covering topics such as layering, best practices, and more.

イメージに関して、このガイドの後のレイヤ化、ベストプラクティス等のトピックで深掘りします。

..    Info
    If you’re familiar with chroot, think of a container as an extended version of chroot. The filesystem is simply coming from the image. But, a container adds additional isolation not available when simply using chroot.

.. note::

   ``chroot`` を熟知していれば、コンテナとは ``chroot`` の拡張バージョンと考えてみましょう。ファイルシステムとは、単にイメージから由来します。ですが、コンテナの場合は、単純に chroot の使用ではできない付加的な隔離を追加します。


.. Next steps
次のステップ
====================

.. In this section, you learned about containers and images.

このセクションでは、コンテナとイメージについて学びました。

.. In the next section, you’ll containerize your first application.

次のセクションでは、アプリケーションをコンテナ化しましょう。

- :doc:`アプリケーションのコンテナ化 <02_our_app>` 


.. seealso::

   Orientation and setup
      https://docs.docker.com/get-started/


