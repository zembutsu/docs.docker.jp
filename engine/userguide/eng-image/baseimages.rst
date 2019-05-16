.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/userguide/eng-image/baseimages/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/userguide/eng-image/baseimages.md
   doc version: 1.11
      https://github.com/docker/docker/commits/master/docs/userguide/eng-image/baseimages.md
.. check date: 2016/04/16
.. Commits on Jan 27, 2016 e310d070f498a2ac494c6d3fde0ec5d6e4479e14
.. ---------------------------------------------------------------------------

.. Create a base image

.. _create-a-base-image:

=======================================
ベース・イメージの作成
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Most Dockerfiles start from a parent image. If you need to completely control
   the contents of your image, you might need to create a base image instead.
   Here's the difference:

Dockerfile は普通は親イメージから作り始めます。
イメージ内容を完全にコントロールする場合は、ベース・イメージを作り出すこともあります。
その違いは以下のとおりです。

.. - A [parent image](/reference/glossary.md#parent-image) is the image that your
     image is based on. It refers to the contents of the `FROM` directive in the
     Dockerfile. Each subsequent declaration in the Dockerfile modifies this parent
     image. Most Dockerfiles start from a parent image, rather than a base image.
     However, the terms are sometimes used interchangeably.

- 親イメージは基準とするイメージのことです。
  Dockerfile 内の ``FROM`` ディレクティブによって指定されます。
  Dockerfile 内のこれに続く定義は、その親イメージを修正指示するものとなります。
  Dockerfile は普通は親イメージから作り始め、ベース・イメージから作るのはまれです。
  ただしこの用語は混同されて用いられることもあります。

.. - A [base image](/reference/glossary.md#base-image) either has no `FROM` line
     in its Dockerfile, or has `FROM scratch`.

- ベース・イメージは Dockerfile において ``FROM`` 行がないか、あるいは ``FROM scratch`` が記述されます。

.. This topic shows you several ways to create a base image. The specific process
   will depend heavily on the Linux distribution you want to package. We have some
   examples below, and you are encouraged to submit pull requests to contribute new
   ones.

ここではベースイメージの生成方法をいくつか示します。
パッケージ化しようとしている Linux ディストリビューションに大きく依存する処理操作もあります。
以下に例をあげていきます。
新たなイメージを提供して頂ける場合は、プルリクエストをあげることをお願いします。

.. ## Create a full image using tar

tar を使ったフルイメージの生成
==============================

.. In general, you'll want to start with a working machine that is running
   the distribution you'd like to package as a parent image, though that is
   not required for some tools like Debian's
   [Debootstrap](https://wiki.debian.org/Debootstrap), which you can also
   use to build Ubuntu images.

通常であれば、作業マシン上に稼動するディストリビューションを使い、これを親イメージとしてビルドしていくことになります。
しかし Debian の `Debootstrap <https://wiki.debian.org/Debootstrap>`_ のようなツールを使えば作業マシンは不要であり、ここから Ubuntu イメージを作ることもできます。

.. It can be as simple as this to create an Ubuntu parent image:

Ubuntu の親イメージを作るのは、以下のように簡単にできます。

.. code-block:: bash

   $ sudo debootstrap raring raring > /dev/null
   $ sudo tar -C raring -c . | docker import - raring
   a29c15f1bf7a
   $ docker run raring cat /etc/lsb-release
   DISTRIB_ID=Ubuntu
   DISTRIB_RELEASE=13.04
   DISTRIB_CODENAME=raring
   DISTRIB_DESCRIPTION="Ubuntu 13.04"

.. There are more example scripts for creating parent images in the Docker
   GitHub Repo:

Docker GitHub レポジトリには、親イメージを生成するスクリプトの例がいろいろとあります。

..  - [BusyBox](https://github.com/moby/moby/blob/master/contrib/mkimage/busybox-static)
    - CentOS / Scientific Linux CERN (SLC) [on Debian/Ubuntu](
      https://github.com/moby/moby/blob/master/contrib/mkimage/rinse) or
      [on CentOS/RHEL/SLC/etc.](
      https://github.com/moby/moby/blob/master/contrib/mkimage-yum.sh)
    - [Debian / Ubuntu](
      https://github.com/moby/moby/blob/master/contrib/mkimage/debootstrap)

* `BusyBox <https://github.com/moby/moby/blob/master/contrib/mkimage/busybox-static>`_
* CentOS / Scientific Linux CERN (SLC) （ `Debian/Ubuntu 向け <https://github.com/moby/moby/blob/master/contrib/mkimage/rinse>`_ または `CentOS/RHEL/SLC など向け <https://github.com/moby/moby/blob/master/contrib/mkimage-yum.sh>`_ ）
* `Debian / Ubuntu <https://github.com/moby/moby/blob/master/contrib/mkimage/debootstrap>`_

.. ## Create a simple parent image using scratch

単純な親イメージを一から生成
============================

.. You can use Docker's reserved, minimal image, `scratch`, as a starting point for building containers. Using the `scratch` "image" signals to the build process that you want the next command in the `Dockerfile` to be the first filesystem layer in your image.

Docker が規定する最小イメージ ``scratch`` は、コンテナを構築するベース・イメージとして利用できます。
``scratch`` を利用すると「イメージ」は、``Dockerfile` `内の次に実行したいコマンドの構築プロセスに対して、最初のファイルシステムレイヤとなるように指示を出します。

.. While `scratch` appears in Docker's repository on the hub, you can't pull it, run it, or tag any image with the name `scratch`. Instead, you can refer to it in your `Dockerfile`. For example, to create a minimal container using `scratch`:

Docker Hub 上の Docker リポジトリとして ``scratch`` が登場したことにより、``scratch`` という名前を使ったイメージのアップロード、実行、タグづけはできなくなりました。
そのかわり ``Dockerfile`` 内での参照のみが可能です。
たとえば ``scratch`` を利用した最小コンテナの生成は以下のようになります。

.. code-block:: dockerfile

   FROM scratch
   ADD hello /
   CMD ["/hello"]

.. This example creates the hello-world image used in the tutorials. If you want to test it out, you can clone the image repo

これはチュートリアルで使用する hello-world イメージを作成する例です。テストしたい場合は、 この `イメージ・リポジトリ <https://github.com/docker-library/hello-world>`_ から複製できます。


.. More resources

更なる詳細について
===================

.. There are lots more resources available to help you write your ‘Dockerfile`.

``Dockerfile`` を書くにあたり、多くの情報が手助けになるでしょう。

..    There’s a complete guide to all the instructions available for use in a Dockerfile in the reference section.
    To help you write a clear, readable, maintainable Dockerfile, we’ve also written a Dockerfile Best Practices guide.
    If your goal is to create a new Official Repository, be sure to read up on Docker’s Official Repositories.

* ``Dockerfile`` リファレンス・セクションには、 :doc:`利用可能な命令の全ガイド </engine/reference/builder>` があります。
* 作成した ``Dockerfile`` を、より綺麗に、読みやすく、メンテナンスしやすいように、 :doc:`ベスト・プラクティス・ガイド <dockerfile_best-practice>` が役立ちます。
* もし自分で新しい公式リポジトリを作成するのが目標であれば、Docker の :doc:`公式リポジトリについて </docker-hub/official_repos/>` をお読みください。


.. seealso:: 

   Create a base image
      https://docs.docker.com/engine/userguide/eng-image/baseimages/
