.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/get-started/
   doc version: 17.06
      https://github.com/docker/docker.github.io/blob/master/get-started/index.md
.. check date: 2017/07/11
.. Commits on Jun 10, 2017 4c05490babdeb5d9872acf260868e4b90e592b40
.. -----------------------------------------------------------------------------

.. Get Started, Part 1: Orientation and Setup

========================================
Part1：方向性の説明とセットアップ
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 2
       :local:

.. Welcome! We are excited you want to learn how to use Docker.

ようこそ！ 皆さんが Docker の使い方を学ぼうとしており、私たちは嬉しく思います。

.. In this six-part tutorial, you will:

チュートリアルは６つのパートで構成されています。

..    Get set up and oriented, on this page.
    Build and run your first app
    Turn your app into a scaling service
    Span your service across multiple machines
    Add a visitor counter that persists data
    Deploy your swarm to production

1. セットアップと説明を始めましょう。このページです。
2. :doc:`初めてのアプリを構築・実行 <part2>` 
3. :doc:`アプリをスケールするサービスに変える <part3>` 
4. :doc:`複数のマシンにまたがってサービスを展開 <part4>` 
5. :doc:`来訪者カウンタで残しておくデータの追加 <part5>` 
6. :doc:`swarm をプロダクションにデプロイ <part6>` 

.. The application itself is very simple so that you are not too distracted by what the code is doing. After all, the value of Docker is in how it can build, ship, and run applications; it’s totally agnostic as to what your application actually does.

アプリケーションそのものは非常にシンプルですので、コードが何をしているか、あまり気に留める必要はありません。どのみち Docker の価値とは、アプリケーションをどのように構築（build）・移動（ship）・実行（run）するかにあります。言い換えれば、皆さんのアプリケーションが実際にどうなっているどうかに依存しません。

.. Prerequisites

動作条件
==========

.. While we’ll define concepts along the way, it is good for you to understand what Docker is and why you would use Docker before we begin.

概念の定義については、 チュートリアルを進める前に `Docker とは何か？（英語） <https://www.docker.com/what-docker>`_ や `なぜ Docker を使ったら良いのか？（英語） <https://www.docker.com/use-cases>`_ の理解が役立つでしょう。

.. We also need to assume you are familiar with a few concepts before we continue:

また、このまま進むにあたっては、以下の概念について慣れている必要があります。

..    IP Addresses and Ports
    Virtual Machines
    Editing configuration files
    Basic familiarity with the ideas of code dependencies and building
    Machine resource usage terms, like CPU percentages, RAM use in bytes, etc.

* IP アドレスとポート
* 仮想マシン
* 設定ファイルの編集
* コード実行に関する依存関係と構築に関する考えについて、基本の熟知
* CPU 使用率、メモリをバイトで扱うなど、マシン・リソースの使用に関する用語

.. A brief explanation of containers

.. _a-brief-explanation-of-containers:

コンテナの概要を説明
====================

.. An image is a lightweight, stand-alone, executable package that includes everything needed to run a piece of software, including the code, a runtime, libraries, environment variables, and config files.

**イメージ（image）** とは実行可能なパッケージであり、軽量で、単独で動作（stand-alone）します。パッケージにはコード、ランタイム、ライブラリ、環境変数、設定ファイルなど、ソフトウェアの実行に必要な部品すべてを含みます。

.. A container is a runtime instance of an image—what the image becomes in memory when actually executed. It runs completely isolated from the host environment by default, only accessing host files and ports if configured to do so.

**コンテナ（container）**とはイメージのランタイム・インスタンス（runtime instance；実行状態にあるモノ）であり、すなわち、実際の実行時にイメージからメモリ内に展開した何かです。

.. Containers run apps natively on the host machine’s kernel. They have better performance characteristics than virtual machines that only get virtual access to host resources through a hypervisor. Containers can get native access, each one running in a discrete process, taking no more memory than any other executable.

ホストマシンのカーネル上で、コンテナはアプリケーションをネイティブに（訳者注；何らかのプログラムを通さず、直接の意味）実行します。仮想マシンはホスト所のリソースにハイパーバイザを通してしかアクセスできないので、コンテナは仮想マシンよりも性能が良くなります。

.. Containers vs. virtual machines

コンテナと仮想マシン
====================

.. Consider this diagram comparing virtual machines to containers:

以降の図を使い、仮想マシンとコンテナの比較を考察します。

.. Virtual Machine diagram

仮想マシンの図
--------------------

Virtual machine stack example

Virtual machines run guest operating systems—note the OS layer in each box. This is resource intensive, and the resulting disk image and application state is an entanglement of OS settings, system-installed dependencies, OS security patches, and other easy-to-lose, hard-to-replicate ephemera.
Container diagram

Container stack example

Containers can share a single kernel, and the only information that needs to be in a container image is the executable and its package dependencies, which never need to be installed on the host system. These processes run like native processes, and you can manage them individually by running commands like docker ps—just like you would run ps on Linux to see active processes. Finally, because they contain all their dependencies, there is no configuration entanglement; a containerized app “runs anywhere.”
Setup

Before we get started, make sure your system has the latest version of Docker installed.

Install Docker

    Note: version 1.13 or higher is required

You should be able to run docker run hello-world and see a response like this:

$ docker run hello-world

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
...(snipped)...

Now would also be a good time to make sure you are using version 1.13 or higher. Run docker --version to check it out.

$ docker --version
Docker version 17.05.0-ce-rc1, build 2878a85

If you see messages like the ones above, you are ready to begin your journey.
Conclusion

The unit of scale being an individual, portable executable has vast implications. It means CI/CD can push updates to any part of a distributed application, system dependencies are not an issue, and resource density is increased. Orchestration of scaling behavior is a matter of spinning up new executables, not new VM hosts.

We’ll be learning about all of these things, but first let’s learn to walk.


.. seealso::

   Get Started, Part 1: Orientation and Setup | Docker Documentation
      https://docs.docker.com/get-started/


