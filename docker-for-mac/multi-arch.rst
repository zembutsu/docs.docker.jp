.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/docker-for-mac/multi-arch/
   doc version: 19.03
      https://github.com/docker/docker.github.io/blob/master/docker-for-mac/multi-arch.md
.. check date: 2020/06/09
.. Commits on Feb 19, 2020 200f25db82b80c62387d78195694df755c14a11d
.. -----------------------------------------------------------------------------

.. Leverage multi-CPU architecture support

.. _leverage-multi-cpu-architecture-support:

==================================================
マルチ CPU アーキテクチャのサポートを活用
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Docker images can support multiple architectures, which means that a single image may contain variants for different architectures, and sometimes for different operating systems, such as Windows.

Docker イメージはマルチ・アーキテクチャ（multi-architecture）をサポートしています。つまり１つのイメージ内に、異なるアーキテクチャを含んでいたり、稀に Windows のような異なるオペレーティングシステムを含むことがあります。

.. When running an image with multi-architecture support, docker will automatically select an image variant which matches your OS and architecture.

マルチ・アーキテクチャをサポートしているイメージの実行時、 :code:`docker` は自動的に OS とアーキテクチャに一致した、対応しているイメージを選択します。

.. Most of the official images on Docker Hub provide a variety of architectures. For example, the busybox image supports amd64, arm32v5, arm32v6, arm32v7, arm64v8, i386, ppc64le, and s390x. When running this image on an x86_64 / amd64 machine, the x86_64 variant will be pulled and run.

Docker Hub 上の大部分の公式イメージには、 `様々なアーキテクチャ <https://github.com/docker-library/official-images#architectures-other-than-amd64>`_  があります。例えば、 :code:`busybox` イメージがサポートするのは :code:`amd64`  、 :code:`arm32v6`  、 :code:`arm32v7` 、 :code:`arm64v8` 、 :code:`i386` 、 :code:`ppc64le` 、 :code:`s390x`  です。このイメージを :code:`x86_64` / :code:`amd64` マシン上で実行しようとすると、 :code:`x86_64` 対応版を自動的に取得・実行します。

.. Docker Desktop provides binfmt_misc multi-architecture support, which means you can run containers for different Linux architectures such as arm, mips, ppc64le, and even s390x.

**Doker Desktop**  は :code:`binfmt_misc` マルチ・アーキテクチャをサポートします。つまり、 :code:`arm` 、 :code:`mips` 、 :code:`ppc64le`  のような異なる Linux アーキテクチャでコンテナを実行できるだけでなく、 :code:`x390x`  でさえもです。

.. This does not require any special configuration in the container itself as it uses qemu-static from the Docker for Mac VM. Because of this, you can run an ARM container, like the arm32v7 or ppc64le variants of the busybox image.

**Docker for Mac 仮想マシン** が `qemu-static <http://wiki.qemu.org/>`_ を使うので、コンテナ内で特別な設定は不要です。これにより、 busybox イメージの :code:`arm32v7` や :code:`ppc64le`  に対応した ARM コンテナを実行可能です。

.. Buildx (Experimental)

.. _buildx-experimental:

Buildx [実験的機能]
====================

.. Docker is now making it easier than ever to develop containers on, and for Arm servers and devices. Using the standard Docker tooling and processes, you can start to build, push, pull, and run images seamlessly on different compute architectures. Note that you don’t have to make any changes to Dockerfiles or source code to start building for Arm.

現在の Docker は、 Arm サーバやデバイス向けのコンテナ開発が、以前よりも簡単になりました。標準的な Docker ツールや手順を用いて、異なるコンピュータ・アーキテクチャ上のイメージの開発、送信、受信、実行がシームレスに行えます。なお、Arm 向けにビルド開始しようとするとき、Dockerfile やソースコードに一切変更を加える必要はありません。

.. Docker introduces a new CLI command called buildx. You can use the buildx command on Docker Desktop for Mac and Windows to build multi-arch images, link them together with a manifest file, and push them all to a registry using a single command. With the included emulation, you can transparently build more than just native images. Buildx accomplishes this by adding new builder instances based on BuildKit, and leveraging Docker Desktop’s technology stack to run non-native binaries.

Docker には `buildx` という新しい CLI コマンドライン・ツールを導入しました。Docker Desktop for Mac と Windows では、この `buildx`  コマンドを使うことで、複数のアーキテクチャに対応したイメージを構築し、マニフェスト・ファイルでそれらを一緒にし、コマンド１つでこれら全てを送信できます。エミュレーションを入れておけば、単にネイティブなイメージを作るよりも、透過的に構築できます。Buildx はこれらを行うため、 BuildKit をベースとする新しい構築インスタンスを追加しました。そして、Docker Desktop の技術スタックによって、ネイティブではないバイナリも実行します。

.. For more information about the Buildx CLI command, see Buildx.

Buildx CLI コマンドに関する詳しい情報は :doc:`Buildx </buildx/working-with-buildx>` をご覧ください。

.. Install

.. _buildx-install:

インストール
--------------------

..    Download the latest version of Docker Desktop.

1.　`Docker Desktop <https://hub.docker.com/editions/community/docker-ce-desktop-mac/>`_  の最新バージョンをダウンロードします。

..    Follow the on-screen instructions to complete the installation process. After you have successfully installed Docker Desktop, you will see the Docker icon in your task tray.

2.　画面の指示に従い、インストール手順を完了します。Docker Desktop のインストールに成功したら、タスクトレイ内に Docker のアイコンが見えます。

..    Click About Docker Desktop from the Docker menu and ensure you have installed Docker Desktop version 2.0.4.0 (33772) or higher.

3.　Docker メニューから **About Docker Desktop**  をクリックし、インストールした Docker Desktop のバージョンが 2.0.4.0 (33772) 以上かどうかを確認します。

.. about-docker-desktop-buildx

.. Build and run multi-architecture images

.. _build-and-run-multi-architecture-images:

マルチ・アーキテクチャ・イメージの構築と実行
--------------------------------------------------

.. Run the command docker buildx ls to list the existing builders. This displays the default builder, which is our old builder.

:code:`docker buildx ls` コマンドを実行し、既存のビルダーを一覧表示します。以下で表示しているのは、デフォルトのビルダーです。これは元々ある古いビルダーです。

.. code-block:: bash

   $ docker buildx ls
   
   NAME/NODE DRIVER/ENDPOINT STATUS  PLATFORMS
   default * docker
     default default         running linux/amd64, linux/arm64, linux/arm/v7, linux/arm/v6

.. Create a new builder which gives access to the new multi-architecture features.

マルチ・アーキテクチャ機能を利用できる新しいビルダーを作成します。

.. code-block:: bash

   $ docker buildx create --name mybuilder
   
   mybuilder

.. Alternatively, run docker buildx create --name mybuilder --use to create a new builder and switch to it using a single command.

あるいは、新しいビルダーを作成してコマンド１つで切り替えるには :code:`docker buildx create --name mybuilder --use` を実行します。

.. Switch to the new builder and inspect it.

新しいビルダーに切り替えて調べてみましょう。

.. code-block:: bash

   $ docker buildx use mybuilder
   
   $ docker buildx inspect --bootstrap
   
   [+] Building 2.5s (1/1) FINISHED
    => [internal] booting buildkit                                                   2.5s
    => => pulling image moby/buildkit:master                                         1.3s
    => => creating container buildx_buildkit_mybuilder0                              1.2s
   Name:   mybuilder
   Driver: docker-container
   
   Nodes:
   Name:      mybuilder0
   Endpoint:  unix:///var/run/docker.sock
   Status:    running
   
   Platforms: linux/amd64, linux/arm64, linux/arm/v7, linux/arm/v6

.. Test the workflow to ensure you can build, push, and run multi-architecture images. Create a simple example Dockerfile, build a couple of image variants, and push them to Docker Hub.

マルチ・アーキテクチャ・イメージの構築、送信、実行のワークフローが機能するかどうか調べます。簡単なサンプル Dockerfile を作成し、２つの派生イメージを作成し、それらを Docker Hub に送信します。


.. code-block:: bash

   $ mkdir test && cd test && cat <<EOF > Dockerfile
   
   FROM ubuntu
   RUN apt-get update && apt-get install -y curl
   WORKDIR /src
   COPY . .
   EOF

.. code-block:: bash

   $ docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -t username/demo:latest --push .
   
   [+] Building 6.9s (19/19) FINISHED
   ...
    => => pushing layers                                                             2.7s
    => => pushing manifest for docker.io/username/demo:latest                       2.2

.. Where, username is a valid Docker username.

:code:`username` の場所には、有効な Docker ユーザ名を入れます。


..    Notes:

..        The --platform flag informs buildx to generate Linux images for AMD 64-bit, Arm 64-bit, and Armv7 architectures.
        The --push flag generates a multi-arch manifest and pushes all the images to Docker Hub.

.. note::

   * :code:`--platform` フラグは、buildx に対して AMD 64-bit 、 Arm 64-bit、Armv7 アーキテクチャに対応する Linux イメージを生成するように伝えます。
   * :code:`--push` フラグは、生成したマルチ・アーキテクチャ対応マニフェストを生成し、全てのイメージを Docker Hub に送信します。

.. Inspect the image sing imagetools.

イメージの調査には :code:`imagetools` を使います。


.. code-block:: bash

   $ docker buildx imagetools inspect username/demo:latest
   
   Name:      docker.io/username/demo:latest
   MediaType: application/vnd.docker.distribution.manifest.list.v2+json
   Digest:    sha256:2a2769e4a50db6ac4fa39cf7fb300fa26680aba6ae30f241bb3b6225858eab76
   
   Manifests:
     Name:      docker.io/username/demo:latest@sha256:8f77afbf7c1268aab1ee7f6ce169bb0d96b86f585587d259583a10d5cd56edca
     MediaType: application/vnd.docker.distribution.manifest.v2+json
     Platform:  linux/amd64
   
     Name:      docker.io/username/demo:latest@sha256:2b77acdfea5dc5baa489ffab2a0b4a387666d1d526490e31845eb64e3e73ed20
     MediaType: application/vnd.docker.distribution.manifest.v2+json
     Platform:  linux/arm64
   
     Name:      docker.io/username/demo:latest@sha256:723c22f366ae44e419d12706453a544ae92711ae52f510e226f6467d8228d191
     MediaType: application/vnd.docker.distribution.manifest.v2+json
     Platform:  linux/arm/v7

.. The image is now available on Docker Hub with the tag username/demo:latest. You can use this image to run a container on Intel laptops, Amazon EC2 A1 instances, Raspberry Pis, and on other architectures. Docker pulls the correct image for the current architecture, so Raspberry Pis run the 32-bit Arm version and EC2 A1 instances run 64-bit Arm. The SHA tags identify a fully qualified image variant. You can also run images targeted for a different architecture on Docker Desktop.

このイメージは Docker Hub 上で :code:`username/demo:latest` というタグで利用可能になりました。このイメージを使って、Intel ノート PC 上や、 Amazon EC2 A1 インスタンス上や、Raspberry Pis や、その他のアーキテクチャ上でコンテナを実行できます。Docker はイメージ取得時、各々のアーキテクチャに対応したものをダウンロードします。そのため、 Raspberry Pi では 32-bit Arm バージョンを実行し、EC2 A1 インスタンスでは 64-bit Arm を実行します。 SHA タグの識別は、イメージ派生ごとに保持します。また、Docker Desktop 上では異なるアーキテクチャとしてタグ付けされたイメージを実行可能です。

.. You can run the images using the SHA tag, and verify the architecture. For example, when you run the following on a macOS:

イメージの実行には SHA タグを使えますし、アーキテクチャの確認もできます。例えば、以下のコマンドを macOS 上で実行します：

.. code-block:: bash

   $ docker run --rm docker.io/username/demo:latest@sha256:2b77acdfea5dc5baa489ffab2a0b4a387666d1d526490e31845eb64e3e73ed20 uname -m
   aarch64

.. code-block:: bash

   $ docker run --rm docker.io/username/demo:latest@sha256:723c22f366ae44e419d12706453a544ae92711ae52f510e226f6467d8228d191 uname -m
   armv7l

.. In the above example, uname -m returns aarch64 and armv7l as expected, even when running the commands on a native macOS developer machine.

この例では、 :code:`uname -a` の実行結果が :code:`aarch64` と :code:`armv7l` になっているだけでなく、各コマンドが macOS 開発マシン上でネイティブに実行しています。


.. seealso:: 

   Leverage multi-CPU architecture support
      https://docs.docker.com/docker-for-mac/networking/
