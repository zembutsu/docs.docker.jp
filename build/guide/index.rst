.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/build/guide/
   doc version: 24.0
      https://github.com/docker/docs/blob/main/build/guide/index.md
.. check date: 2023/07/25
.. Commits on Apr 25, 2023 da6586c498f34c0edac3171a48468a0f26aa0182
.. -----------------------------------------------------------------------------

.. Build with Docker
.. _build with Docker:

========================================
Docker で構築
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 2
       :local:　

.. Welcome! This guide is an introduction and deep-dive into building software with Docker.

ようこそ！ このガイドは Docker でソフトウェアを構築するための手引きと深い掘り下げです。

.. Whether you’re just getting started, or you’re already an advanced Docker user, this guide aims to provide useful pointers into the possibilities and best practices of Docker’s build features.

ちょうどこれから始めようとしている方だけでなく、既に高度な Docker ユーザだとしても、 Docker の構築機能についての可能性やベストプラクティスについて役立つ指針を、このガイドでは提供します。

.. Topics covered in this guide include:

このガイドで扱うトピックには、以下の項目が含まれます。

..  Introduction to build concepts
    Image size optimization
    Build speed performance improvements
    Building and exporting binaries
    Cache mounts and bind mounts
    Software testing
    Multi-platform builds

* 構築（ビルド）概念の導入
* イメージ容量の最適化
* 構築スピード性能の改善
* バイナリの構築と出力
* キャッシュマウントとバインドマウント
* ソフトウェアの試験
* マルチプラットフォーム構築

.. Throughout this guide, an example application written in Go is used to illustrate how the build features work. You don’t need to know the Go programming language to follow this guide.

このガイドを通し、Go 言語で書かれたアプリケーション例を使い、構築機能がどのように動作するかを説明します。このガイドを読み進めるために Go 言語の知識は不要です。

.. The guide starts off with a simple Dockerfile example, and builds from there. Some of the later sections in this guide describe advanced concepts and workflows. You don’t need to complete this entire guide from start to finish. Follow the sections that seem relevant to you, and save the advanced sections at the end for later, when you need them.

このガイドはシンプルな Dockerfile 例から始まり、次に、それを使って構築します。このガイドは後半の幾つかで、概念とワークフローの詳細を扱います。このガイドを始めから最後まで完全に学ぶ必要はありません。自分に関係ありそうなセクションを読み進めてください。そして、途中から最後までの高度なセクションは、いつか必要になったときのために残しておきます。

.. raw:: html

   <div style="overflow: hidden; margin-bottom:20px;">
      <a href="intro.html" class="btn btn-neutral float-left">始めましょう <span class="fa fa-arrow-circle-right"></span></a>
   </div>


----

.. seealso::

    Build with Docker | Docker Documentation
        https://docs.docker.com/build/guide/


