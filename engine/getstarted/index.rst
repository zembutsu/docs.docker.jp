.. -*- coding: utf-8 -*-
.. https://docs.docker.com/engine/getstarted/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/getstarted/index.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/getstarted/index.md
.. check date: 2016/07/09
.. Commits on Jun 14, 2016 8eca8089fa35f652060e86906166dabc42e556f8
.. -----------------------------------------------------------------------------

.. Get Started with Docker

========================================
Docker 導入ガイド
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. This is written for users of Linux distribution such as Ubuntu. If you are not using Linux, see the Windows or Mac OS X version.

このページは Ubuntu など Linux ディストリビューションの利用者向けです。Linux を使っていなければ :doc:`Windows </windows/index>` や :doc:`Mac OS X </mac/index>` 向けの文章をご覧ください。

.. This getting started is for non-technical users who are interested in learning about Docker. By following this getting started, you’ll learn fundamental Docker features by performing some simple tasks. You’ll learn how to:

この導入ガイドは、専門家でなくとも Docker を学ぶことに興味のある方です。導入ガイドでは、簡単な作業を通して Docker 機能の基本を学びます。導入ガイドで学ぶ内容は、次の通りです。

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

.. Make sure you understand…

ご確認ください
====================

.. This getting started uses Docker Engine CLI commands entered on the commandline of a terminal window. You don’t need to be experienced using a command line, but you should be familiar with how to open one and type commands.

この導入ガイドでは、Docker エンジンのコマンドライン・ツール（CLI）を端末ウインドウ上で使います。コマンドラインを使ったことがなくても構いませんが、コマンドラインの開き方やコマンドの入力方法に慣れておいた方が良いでしょう。

.. Go to the next page to install.

:doc:`次のインストールのページ <step_one>` に移動します。


.. seealso:: 

   Get Started with Docker Engine for Linux
      https://docs.docker.com/linux/
