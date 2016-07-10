.. -*- coding: utf-8 -*-
.. https://docs.docker.com/engine/getstarted/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/getstarted/index.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/getstarted/index.md
.. check date: 2016/07/09
.. Commits on Jun 28, 2016 4060eb02ef84a0faef4407bf9796db1a2afc42f5
.. -----------------------------------------------------------------------------

.. Get Started with Docker

========================================
Docker 導入ガイド
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. This tutorial is a for non-technical users who are interested in learning more about Docker. By following these steps, you'll learn fundamental Docker features while working through some simple tasks.

このチュートリアルは、専門家でなくとも Docker を学ぶことに興味のある方です。以降では簡単な作業を通し、 Docker 機能の基本を学びます。

.. Depending on how you got here, you may or may not have already downloaded Docker for your platform and installed it.

ここからは、Docker をまだダウンロードしていないか、あるいは既にダウンロードとインストール済みかどうかによって、作業手順が異なります。

.. Got Docker?

.. _got-docker:

Docker が入っていますか？
==============================

.. If you haven't yet downloaded Docker for your platform or installed it, go to Get Docker.

まだ環境に対応した Docker をダウンロードしていなければ、 :ref:`Docker の入手 <step-1-get-docker>` に移動しましょう。


.. Ready to start working with Docker?

.. _ready-to-start-working-with-docker:

Docker を使う準備が整っていますか？
========================================

.. If you have already downloaded and installed Docker, you are ready to run Docker commands! Go to Verify your installation.

既にDocker をダウンロードかつインストール済みであれば、もう Docker コマンドを実行する準備が整っています！ :ref:`インストールの確認 <step-3-verify-your-installation>` に移動しましょう。

.. What you'll learn and do

これから学び、作業する内容
------------------------------

..    install Docker Engine
    use Docker Engine to run a software image in a container
    browse for an image on Docker Hub
    create your own image and run it in a container
    create a Docker Hub account and an image repository
    create an image of your own
    push your image to Docker Hub for others to use

* Docker ツールボックスを使い、 Docker ソフトウェアをインストール。
* Docker エンジンを使い、コンテナ内でイメージを実行。
* Docker Hub 上でイメージを探す。
* イメージを取得し、コンテナとして実行。
* Docker Hub アカウントとイメージ・リポジトリを作成。
* イメージの作成。
* 誰でも使えるように Docker Hub にイメージを送信。

.. The getting started was user tested to reduce the chance of users having problems. For the best chance of success, follow the steps as written the first time before exploring on your own. It takes approximately 45 minutes to complete.

進める上で発生する問題が減るように、この導入ガイドは利用者テストを経ています。個人で色々試すよりも、導入ガイドを進める方が、最も成功に至るチャンスです。なお、ガイドを終えるまでにかかる時間は約45分です。

.. Flavors of Docker

.. _flavors-of-docker:

Docker の操作にあたって
==============================

.. This tutorial is designed as a getting started with Docker, and works the same whether you are using Docker for Mac, Docker for Windows, Docker on Linux, or Docker Toolbox (for older Mac and Windows systems).

チュートリアルを通して Docker を使い始められるようにしています。どこでもチュートリアルを進められます。Docker for Mac、Docker for WIndows、Linux 上での Docker、あるいは Docker Toolbox （古い Mac や Windows 環境向け）で進めましょう。

.. If you are using Docker Toolbox, you can use the Docker Quickstart Terminal to run Docker commands in a pre-configured environment instead of opening a command line terminal.

Docker Toolbox を使う場合は、皆さんの環境のコマンドライン・ターミナルを使わずに、Docker Quickstart Terminal（クイックスタート・ターミナル）を使います。

.. If you are using Docker for Mac, Docker for Windows, or Docker on Linux, you will have Docker running in the background, and your standard command line terminal is already set up to run Docker commands.

Docker for Mac や Docker for Windows 、Linux 上で Docker を使う場合は、Docker がバックグラウンドで動作します。通常のコマンドライン・ターミナル上で Docker コマンドが使えるようになっています。


.. How much command line savvy do I need?

コマンドラインの知識はどの程度必要？
========================================

.. This getting started uses Docker Engine CLI commands entered on the commandline of a terminal window. You don’t need to be experienced using a command line, but you should be familiar with how to open one and type commands.

この導入ガイドでは、Docker エンジンのコマンドライン・ツール（CLI）を端末ウインドウ上で使います。コマンドラインを使ったことがなくても構いませんが、コマンドラインの開き方やコマンドの入力方法に慣れておいた方が良いでしょう。

.. Go to the next page to install.

:doc:`次のインストールのページ <step_one>` に移動します。


.. seealso:: 

   Get Started with Docker Engine for Linux
      https://docs.docker.com/linux/
