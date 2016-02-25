.. *- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/pull/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/pull.md
   doc version: 1.10
      https://github.com/docker/docker/commits/master/docs/reference/commandline/pull.md
.. check date: 2016/02/25
.. Commits on Dec 24, 2015 e6115a6c1c02768898b0a47e550e6c67b433c436
.. -------------------------------------------------------------------

.. pull

=======================================
pull
=======================================

.. code-block:: bash

   Usage: docker pull [OPTIONS] NAME[:TAG] | [REGISTRY_HOST[:REGISTRY_PORT]/]NAME[:TAG]
   
   Pull an image or a repository from the registry
   
     -a, --all-tags=false          Download all tagged images in the repository
     --disable-content-trust=true  Skip image verification
     --help                        Print usage

.. Most of your images will be created on top of a base image from the Docker Hub registry.

大部分のイメージは、 `Docker Hub <https://hub.docker.com/>`_ レジストリにあるベース・イメージをもとに作られています。

.. Docker Hub contains many pre-built images that you can pull and try without needing to define and configure your own.

`Docker Hub <https://hub.docker.com/>`_ には多くの構築済みのイメージがあり、 ``pull`` （取得）し、自分や定義や設定をしなくても試せることです。

.. It is also possible to manually specify the path of a registry to pull from. For example, if you have set up a local registry, you can specify its path to pull from it. A repository path is similar to a URL, but does not contain a protocol specifier (https://, for example).

また、手動でレジストリのパスを指定し、そこから取得することも可能です。例えば、ローカルにレジストリをセットアップしている場合、そのパスを指定して、そこから pull できます。レポジトリのパスは、 URL に似た形式ですが、プロトコルの指定は含みません（例： ``https://`` ）。

.. To download a particular image, or set of images (i.e., a repository), use docker pull:

特定のイメージやイメージの集まり（例：レポジトリ）をダウンロードするには、 ``docker pull`` を使います。

.. code-block:: bash

   $ docker pull debian
   # will pull the debian:latest image and its intermediate layers
   $ docker pull debian:testing
   # will pull the image named debian:testing and any intermediate
   # layers it is based on.
   $ docker pull debian@sha256:cbbf2f9a99b47fc460d422812b6a5adff7dfee951d8fa2e4a98caa0382cfbdbf
   # will pull the image from the debian repository with the digest
   # sha256:cbbf2f9a99b47fc460d422812b6a5adff7dfee951d8fa2e4a98caa0382cfbdbf
   # and any intermediate layers it is based on.
   # (Typically the empty `scratch` image, a MAINTAINER layer,
   # and the un-tarred base).
   $ docker pull --all-tags centos
   # will pull all the images from the centos repository
   $ docker pull registry.hub.docker.com/debian
   # manually specifies the path to the default Docker registry. This could
   # be replaced with the path to a local registry to pull from another source.
   # sudo docker pull myhub.com:8080/test-image

.. Killing the docker pull process, for example by pressing CTRL-c while it is running in a terminal, will terminate the pull operation.

``docker pull`` プロセスを停止するには、ターミナルで実行中に ``CTRL-c`` を押すると、pull 処理を中断します。
