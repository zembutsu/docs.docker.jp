.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/get-started/part3/
   doc version: 17.06
      https://github.com/docker/docker.github.io/blob/master/get-started/part3.md
.. check date: 2017/09/03
.. Commits on Aug 30 2017 9a1330e96612fd72ee0ca7c40a289d7c2ce87504
.. -----------------------------------------------------------------------------

.. Get Started, Part 3: Services

========================================
Part3：サービス
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 2
       :local:

.. Prerequisites

動作条件
==========

..    Install Docker version 1.13 or higher.
    Get Docker Compose. On Docker for Mac and Docker for Windows it’s pre-installed, so you’re good-to-go. On Linux systems you will need to install it directly. On pre Windows 10 systems without Hyper-V, use Docker Toolbox.
    Read the orientation in Part 1.
    Learn how to create containers in Part 2.
    Make sure you have published the friendlyhello image you created by pushing it to a registry. We’ll use that shared image here.
    Be sure your image works as a deployed container. Run this command, slotting in your info for username, repo, and tag: docker run -p 80:80 username/repo:tag, then visit http://localhost/.

* :doc:`Docker バージョン 1.13 以上のインストール </engine/installation/index>`
* :doc:`Docker Compose </compose/overview>` を入手。 Docker for Mac と Docker for Windows ではインストール済みなので、このまま読み進めてください。Linux システムでは `直接インストール <https://github.com/docker/compose/releases>`_ が必要です。Widows 10 システム上で Hyper-V が入っていなければ、 :doc:`Docker Toolbox </toolbox/overview>` をお使い下さい。
* :doc:`Part 1 <index>` の概要を読んでいること
* :doc:`Part 2 <part>` のコンテナの作成方法学んでいること
* 自分で作成した ``friendlyhello`` イメージを :ref:`レジストリに送信 <share-your-image>` して公開済みなのを確認します。ここでは、この共有イメージを使います。
* イメージをコンテナとしてデプロイできるのを確認します。次のコマンドを実行しますが、 ``ユーザ名`` と ``リポジトリ`` ``タグ`` は皆さんのものに置き換えます。コマンドは ``docker run -p 80:80 ユーザ名/リポジトリ:タグ`` です。そして ``http://localhost/`` を表示します。

.. Introduction

はじめに
==========

