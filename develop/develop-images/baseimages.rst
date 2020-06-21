.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/develop/develop-images/baseimages/
   doc version: 19.03
      https://github.com/docker/docker.github.io/blob/master/develop/develop-images/multistage-build.md
.. check date: 2020/06/21
.. Commits on Mar 17, 2020 14bbe621e55e9360019f6b3e25be4a25e3f79688
.. -----------------------------------------------------------------------------

.. Create a base image

.. _create-a-base-image:

=======================================
ベース・イメージの作成
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Most Dockerfiles start from a parent image. If you need to completely control the contents of your image, you might need to create a base image instead. Here’s the difference:

ほとんどの Dockerfile は親イメージ（parent image）から始まります。イメージの内容を完全にコントロールする必要があれば、ベース・イメージの代わりになるものを作成する必要があります。これがその違いです：

..    A parent image is the image that your image is based on. It refers to the contents of the FROM directive in the Dockerfile. Each subsequent declaration in the Dockerfile modifies this parent image. Most Dockerfiles start from a parent image, rather than a base image. However, the terms are sometimes used interchangeably.
    A base image has FROM scratch in its Dockerfile.

* :ref:`親イメージ <parent-image>` はイメージの土台（ベース）となるイメージです。 Dockerfile の ``FROM`` 命令で内容を指定します。 Dockerfile で以降に続く命令では、この親イメージに対して変更を加えます。ほとんどの Dockerfile はベース・イメージではなく、何らかの親イメージからスタートします。しかしながら、ほとんどが用途はとして置き換え可能です。
* :ref:`ベース・イメージ <base-image>` は Dockerfile の中で ``FROM scratch`` の指定があります。

.. This topic shows you several ways to create a base image. The specific process will depend heavily on the Linux distribution you want to package. We have some examples below, and you are encouraged to submit pull requests to contribute new ones.

このトピックではベース・イメージの作成方法をいくつか紹介します。特定の手順では、パッケージが必要となるため特定の Linux ディストリビューションに強く依存します。以下でいくつかの例を示しますが、新しい例を pull request を通して貢献いただくことも歓迎します。

.. Create a full image using tar

.. _create-a-full-image-using-tar:

tar を使ってイメージ全体を作成
==============================

.. In general, start with a working machine that is running the distribution you’d like to package as a parent image, though that is not required for some tools like Debian’s Debootstrap, which you can also use to build Ubuntu images.

一般的に、マシンを作り始めるときは、実行したいパッケージを含むディストリビューションが親イメージの中に入っています。そのため、 Debian の `Debootstrap <https://wiki.debian.org/Debootstrap>`_ のようなツールは不要であり、Ubuntu イメージの構築にあたっても同様です。

.. It can be as simple as this to create an Ubuntu parent image:

この Ubuntu 親イメージの作成は、シンプルにできます。

.. code-block:: bash

   $ sudo debootstrap xenial xenial > /dev/null
   $ sudo tar -C xenial -c . | docker import - xenial
   
   a29c15f1bf7a
   
   $ docker run xenial cat /etc/lsb-release
   
   DISTRIB_ID=Ubuntu
   DISTRIB_RELEASE=16.04
   DISTRIB_CODENAME=xenial
   DISTRIB_DESCRIPTION="Ubuntu 16.04 LTS"

.. There are more example scripts for creating parent images in the Docker GitHub Repo:

Docker Github リポジトリには、親イメージを作成するためのサンプルスクリプトがあります。

..  BusyBox
    CentOS / Scientific Linux CERN (SLC) on Debian/Ubuntu or on CentOS/RHEL/SLC/etc.
    Debian / Ubuntu

* `BusyBox <https://github.com/moby/moby/blob/master/contrib/mkimage/busybox-static>`_ 
*  `Debian / Ubuntu 上の <https://github.com/moby/moby/blob/master/contrib/mkimage/rinse>`_ あるいは `CentOS / RHEL / SLC 等での上の <https://github.com/moby/moby/blob/master/contrib/mkimage-yum.sh>`_ CentOS / Scientific Linux CERN (SLC)
*  `Debian / Ubuntu  <https://github.com/moby/moby/blob/master/contrib/mkimage/debootstrap>`_

.. Create a simple parent image using scratch

.. _Create a simple parent image using scratch:

scratch を使ってシンプルな親イメージを作成
==================================================

.. You can use Docker’s reserved, minimal image, scratch, as a starting point for building containers. Using the scratch “image” signals to the build process that you want the next command in the Dockerfile to be the first filesystem layer in your image.

コンテナ構築用のスタート地点ととして、Docker で確保している最小イメージ、 ``scratch`` を利用できます。 ``scratch`` 「イメージ」を使うと、構築プロセスは ``Dockerfile`` の次の命令から始まることとなり、これがイメージの１番目のファイルシステム・レイヤになります。

.. While scratch appears in Docker’s repository on the hub, you can’t pull it, run it, or tag any image with the name scratch. Instead, you can refer to it in your Dockerfile. For example, to create a minimal container using scratch:

Docker Hub の Docker リポジトリに ``scratch`` 命令が出てきても、 ``scratch`` という名前でイメージの取得・送信・実行・タグ付けはできません。そのかわり、 ``Dockerifle`` の中から酸素茹で来ます。たとえば、最も小さなコンテナを ``scratch`` をｔ使って作成するには、次のようになります。

::

   FROM scratch
   ADD hello /
   CMD ["/hello"]

.. Assuming you built the “hello” executable example by following the instructions at https://github.com/docker-library/hello-world/, and you compiled it with the -static flag, you can build this Docker image using this docker build command:

https://github.com/docker-library/hello-world/ にある命令を使って、「hello」を実行する例を考えましょう。この時、 ``-static`` フラグを付けてコンパイルしているとします。これを使って Docker イメージを構築する ``docker build`` は、次のようになります。

.. code-block:: bash

   docker build --tag hello .

.. Don’t forget the . character at the end, which sets the build context to the current directory.

最後に ``.`` 記号を付けるのを忘れないでください。これは、現在のディレクトリをビルド・コンテクストとして指定します。

..    Note: Because Docker Desktop for Mac and Docker Desktop for Windows use a Linux VM, you need a Linux binary, rather than a Mac or Windows binary. You can use a Docker container to build it:

.. note::

   Docker Desktop for Mac と Docker Desktop for Windows は Linux 仮想マシンを使いますので、Linux バイナリが必要です。Mac や Windows に対応したバイナリではありません。Docker コンテナを使って、次のようにして構築できます。

   .. code-block:: bash
   
      $ docker run --rm -it -v $PWD:/build ubuntu:16.04
      
      container# apt-get update && apt-get install build-essential
      container# cd /build
      container# gcc -o hello -static -nostartfiles hello.c

.. To run your new image, use the docker run command:

新しいイメージを実行するには、 ``docker run`` コマンドを実行します。

.. code-block:: bash

   docker run --rm hello

.. This example creates the hello-world image used in the tutorials. If you want to test it out, you can clone the image repo.

この例ではチュートリアルにある hello-world イメージから作成したものです。自分自身で検証したい場合は、 `イメージのリポジトリ <https://github.com/docker-library/hello-world>`_ をクローンできます。

.. More resources

更なる情報
==========

.. There are lots of resources available to help you write your Dockerfile.

``Dockerifle`` を書くのに役立つ沢山の情報があります。

..  There’s a complete guide to all the instructions available for use in a Dockerfile in the reference section.
    To help you write a clear, readable, maintainable Dockerfile, we’ve also written a Dockerfile best practices guide.
    If your goal is to create a new Official Image, be sure to read up on Docker’s Official Images.

* ``Dockerfile`` のリファレンス・セクションでは、 :doc:`全ての命令に対する完全なガイド </engine/reference/builder>` があります。
* 明確で読みやすくメンテナンスのしやすい ``Dockerfile`` を書くには、こちらにある :doc:`ベストプラクティス・ガイド <dockerfile_best-practices>` が役立つでしょう。
* あなたの目標が何らかの新しい公式イメージの作成であれば、 Docker の :doc:`公式イメージ </docker-hub/official_images>` にある記述をご覧ください。

.. seealso:: 

   Create a base image
      https://docs.docker.com/develop/develop-images/baseimages/
