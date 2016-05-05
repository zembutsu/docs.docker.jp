.. -*- coding: utf-8 -*-
.. https://docs.docker.com/linux/
.. doc version: 1.10
.. check date: 2016/4/13
.. -----------------------------------------------------------------------------

.. Get Started with Docker Engine for Linux

========================================
Linux への Docker Engine 導入ガイド
========================================

.. tip::

   導入ガイドの PDF 版は `こちらからダウンロード <http://docker.jp/PDF/docker-getting-started-guide-for-linux.pdf>`_ できます。

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

この導入ガイドでは、Docker エンジンのコマンドライン・ツール（CLI）を Windows 端末上で使います。コマンドラインの利用経験がなくても構いません。ですが、コマンドラインの開き方や、コマンドの入力方法には慣れておいた方が良いでしょう。

.. Make sure you understand…

ご確認ください
====================

.. This getting started uses Docker Engine CLI commands entered on the commandline of a terminal window. You don’t need to be experienced using a command line, but you should be familiar with how to open one and type commands.

この導入ガイドでは、Docker エンジンのコマンドライン・ツール（CLI）を Windows 端末上で使います。コマンドラインを使ったことがなくても構いませんが、コマンドラインの開き方やコマンドの入力方法に慣れておいた方が良いでしょう。

.. Go to the next page to install.

:doc:`次のインストールのページ <step_one>` に移動します。


.. seealso:: 

   Get Started with Docker Engine for Linux
      https://docs.docker.com/linux/
