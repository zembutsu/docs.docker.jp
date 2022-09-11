.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/develop/develop-images/baseimages/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/develop/develop-images/baseimages.md
.. check date: 2022/04/25
.. Commits on Dec 20, 2021 df6a3281b958a4224889342d82c026000c43fc8d
.. -----------------------------------------------------------------------------

.. Create a base image
.. _create-a-base-image:

=======================================
ベース イメージの作成
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Most Dockerfiles start from a parent image. If you need to completely control the contents of your image, you might need to create a base image instead. Here’s the difference:

ほとんどの Dockerfile は :ruby:`親イメージ <parent image>` を元にしています。イメージの内容を完全に管理する必要があれば、:ruby:`ベース イメージ <base image>` の代わりになるものを作成する必要があります。これがその違いです：

..    A parent image is the image that your image is based on. It refers to the contents of the FROM directive in the Dockerfile. Each subsequent declaration in the Dockerfile modifies this parent image. Most Dockerfiles start from a parent image, rather than a base image. However, the terms are sometimes used interchangeably.
    A base image has FROM scratch in its Dockerfile.

* :ref:`親イメージ <parent-image>` はイメージの土台（ベース）となるイメージです。 Dockerfile の ``FROM`` 命令で内容を指定します。 Dockerfile で以降に続く命令では、この親イメージに対して変更を加えます。ほとんどの Dockerfile はベース イメージではなく、何らかの親イメージからスタートします。しかしながら、ほとんどが用途はとして置き換え可能です。
* :ref:`ベース イメージ <base-image>` は Dockerfile の中で ``FROM scratch`` の指定があります。

.. This topic shows you several ways to create a base image. The specific process will depend heavily on the Linux distribution you want to package. We have some examples below, and you are encouraged to submit pull requests to contribute new ones.

このトピックではベース イメージの作成方法をいくつか紹介します。特定の手順では、パッケージが必要となるため特定の Linux ディストリビューションに強く依存します。以下でいくつかの例を示しますが、新しい例を pull request を通して貢献いただくことも歓迎します。

.. Create a full image using tar
.. _create-a-full-image-using-tar:

tar を使ってイメージ全体を作成
==============================

.. In general, start with a working machine that is running the distribution you’d like to package as a parent image, though that is not required for some tools like Debian’s Debootstrap, which you can also use to build Ubuntu images.

一般的に、マシンを作り始めるときは、実行したいパッケージを含むディストリビューションが親イメージの中に入っています。そのため、 Debian の `Debootstrap <https://wiki.debian.org/Debootstrap>`_ のようなツールは不要であり、Ubuntu イメージの構築にあたっても同様です。

.. It can be as simple as this to create an Ubuntu parent image:

この Ubuntu 親イメージの作成は、シンプルにできます。

.. code-block:: bash

   $ sudo debootstrap focal focal > /dev/null
   $ sudo tar -C focal -c . | docker import - focal
   
   sha256:81ec9a55a92a5618161f68ae691d092bf14d700129093158297b3d01593f4ee3
   
   $ docker run focal cat /etc/lsb-release
   
   DISTRIB_ID=Ubuntu
   DISTRIB_RELEASE=20.04
   DISTRIB_CODENAME=focal
   DISTRIB_DESCRIPTION="Ubuntu 20.04 LTS"

.. There are more example scripts for creating parent images in the Docker GitHub Repo:

`Docker Github リポジトリ <https://github.com/docker/docker/blob/master/contrib>`_ には、親イメージを作成するためのサンプルスクリプトがあります。

.. Create a simple parent image using scratch
.. _Create a simple parent image using scratch:

scratch を使ってシンプルな親イメージを作成
==================================================

.. You can use Docker’s reserved, minimal image, scratch, as a starting point for building containers. Using the scratch “image” signals to the build process that you want the next command in the Dockerfile to be the first filesystem layer in your image.

コンテナ構築用のスタート地点ととして、Docker で確保している最小イメージ、 ``scratch`` を利用できます。 ``scratch`` 「イメージ」を使うと、構築プロセスは ``Dockerfile`` の次の命令から始まることとなり、これがイメージの１番目のファイルシステム・レイヤーになります。

.. While scratch appears in Docker’s repository on the hub, you can’t pull it, run it, or tag any image with the name scratch. Instead, you can refer to it in your Dockerfile. For example, to create a minimal container using scratch:

Docker Hub の Docker リポジトリに ``scratch`` 命令が出てきても、 ``scratch`` という名前でイメージの取得・送信・実行・タグ付けはできません。そのかわり、 ``Dockerfile`` の中から参照できるものです。たとえば、最も小さなコンテナを ``scratch`` を使って作成するには、次のようになります。

::

   # syntax=docker/dockerfile:1
   FROM scratch
   ADD hello /
   CMD ["/hello"]

.. Assuming you built the “hello” executable example by following the instructions at https://github.com/docker-library/hello-world/, and you compiled it with the -static flag, you can build this Docker image using this docker build command:

https://github.com/docker-library/hello-world/ にある命令を使って、「hello」を実行する例を考えましょう。この時、 ``-static`` フラグを付けてコンパイルしているとします。これを使って Docker イメージを構築する ``docker build`` は、次のようになります。

.. code-block:: bash

   docker build --tag hello .

.. Don’t forget the . character at the end, which sets the build context to the current directory.

最後に ``.`` 記号を付けるのを忘れないでください。これは、現在のディレクトリを :ruby:`構築コンテクスト <build context>` として指定します。

..    Note: Because Docker Desktop for Mac and Docker Desktop for Windows use a Linux VM, you need a Linux binary, rather than a Mac or Windows binary. You can use a Docker container to build it:

.. note::

   Docker Desktop for Mac と Docker Desktop for Windows は Linux 仮想マシンを使いますので、Linux バイナリが必要です。Mac や Windows に対応したバイナリではありません。Docker コンテナを使って、次のようにして構築できます。

   .. code-block:: bash
   
      $ docker run --rm -it -v $PWD:/build ubuntu:20.04
      
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

``Dockerfile`` を書くのに役立つ沢山の情報があります。

..  There’s a complete guide to all the instructions available for use in a Dockerfile in the reference section.
    To help you write a clear, readable, maintainable Dockerfile, we’ve also written a Dockerfile best practices guide.
    If your goal is to create a new Official Image, be sure to read up on Docker’s Official Images.

* ``Dockerfile`` のリファレンス・セクションでは、 :doc:`全ての命令に対する完全なガイド </engine/reference/builder>` があります。
* 明確で読みやすくメンテナンスのしやすい ``Dockerfile`` を書くには、こちらにある :doc:`ベストプラクティス・ガイド <dockerfile_best-practices>` が役立つでしょう。
* あなたの目標が何らかの新しい公式イメージの作成であれば、 Docker の :doc:`公式イメージ </docker-hub/official_images>` にある記述をご覧ください。

.. seealso:: 

   Create a base image
      https://docs.docker.com/develop/develop-images/baseimages/
