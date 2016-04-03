.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/registry/osx-setup-guide/
.. SOURCE: 
   doc version: 1.10
.. check date: 2016/03/30
.. -------------------------------------------------------------------

.. OS X Setup Guide

==============================
OS X セットアップ・ガイド
==============================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

使用例
==========

.. This is useful if you intend to run a registry server natively on OS X.

レジストリ・サーバを OS X 上でネイティブに実行したい場合に役立ちます。

あるいは
----------

.. You can start a VM on OS X, and deploy your registry normally as a container using Docker inside that VM.

OS X 上で仮想マシンを起動します。仮想マシンの中で Docker を使い、通常のコンテナとしてレジストリをデプロイします。

.. The simplest road to get there is traditionally to use the docker Toolbox, or docker-machine, which usually relies on the boot2docker iso inside a VirtualBox VM.

VirtualBox 仮想マシンの中で `boot2docker <http://boot2docker.io/>`_ を使う方法よりも、 `Docker Toolbox <https://www.docker.com/toolbox>`_ や :doc:`docker-machine </machine/overview>` を使う方が簡単です。

解決策
----------

.. Using the method described here, you install and compile your own from the git repository and run it as an OS X agent.

ここで説明する手法は git リポジトリから取得してコンパイルおよびインストールする方法であり、 OS X 上でエージェントとして実行します。

捕捉
----------

.. Production services operation on OS X is out of scope of this document. Be sure you understand well these aspects before considering going to production with this.

OS X 上でプロダクションのサービスを扱う内容は、本ドキュメントの対象外です。プロダクションでの利用を検討する前に、特性についてご理解ください。

.. Setup golang on your machine

.. _setup-golang-on-your-machine:

マシン環境上に Go 言語をセットアップ
========================================

.. If you know, safely skip to the next section.

既に知っていれば、次のセクションにスキップしてください。

.. If you don’t, the TLDR is:

知らなければ、次のように実行します。

.. code-block:: bash

   bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
   source ~/.gvm/scripts/gvm
   gvm install go1.4.2
   gvm use go1.4.2

.. If you want to understand, you should read How to Write Go Code.

何を行ったか理解したい場合は、 `Goコードの書き方（英語） <https://golang.org/doc/code.html>`_ を読んだ方が良いでしょう。

.. Checkout the Docker Distribution source tree

.. _checkout-the-docker-distribution-source-tree:

Docker Distribution のソース・ツリーをチェックアウト
============================================================

.. code-block:: bash

   mkdir -p $GOPATH/src/github.com/docker
   git clone https://github.com/docker/distribution.git $GOPATH/src/github.com/docker/distribution
   cd $GOPATH/src/github.com/docker/distribution

.. Build the binary

.. _build-the-registry-binary:

バイナリをビルド
====================

.. code-block:: bash

   GOPATH=$(PWD)/Godeps/_workspace:$GOPATH make binaries
   sudo cp bin/registry /usr/local/libexec/registry

.. Setup

.. _setup-registry:

セットアップ
====================

.. Copy the registry configuration file in place:

レジストリの設定ファイルを置きます：

.. code-block:: bash

   mkdir /Users/Shared/Registry
   cp docs/osx/config.yml /Users/Shared/Registry/config.yml

.. Running the Docker Registry under launchd

.. _running-the-docker-registry-under-launched:

Docker Registry を起動
==============================

.. Copy the Docker registry plist into place:

Docker Registry の plist をコピーします：

.. code-block:: bash

   plutil -lint docs/osx/com.docker.registry.plist
   cp docs/osx/com.docker.registry.plist ~/Library/LaunchAgents/
   chmod 644 ~/Library/LaunchAgents/com.docker.registry.plist

.. Start the Docker registry:

Docker Registry を起動します：

.. code-block:: bash

   launchctl load ~/Library/LaunchAgents/com.docker.registry.plist

.. Restarting the docker registry service

.. _restarting-the-docker-registry-service:

Docker Registry サービスの再起動
----------------------------------------

.. code-block:: bash

   launchctl stop com.docker.registry
   launchctl start com.docker.registry

.. Unloading the docker registry service

Docker Registry サービスの除外
----------------------------------------

.. code-block:: bash

   launchctl unload ~/Library/LaunchAgents/com.docker.registry.plist


.. seealso:: 

   OS X Setup Guide
      https://docs.docker.com/registry/osx-setup-guide/
