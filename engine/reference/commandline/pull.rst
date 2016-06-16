.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/pull/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/pull.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/pull.md
.. check date: 2016/06/16
.. Commits on Jun 12, 2016 0c3a4a1fcdbb4b7e14292a871dec4bf6828ae57c
.. -------------------------------------------------------------------

.. pull

=======================================
pull
=======================================

.. code-block:: bash

   使い方: docker pull [オプション] 名前[:タグ] | [レジストリ・ホスト[:レジストリ・ポート]/]名前[:タグ]
   
   レジストリからイメージやリポジトリを取得
   
     -a, --all-tags=false          リポジトリでタグ付けられた全てのイメージをダウンロード
     --disable-content-trust=true  イメージの認証をスキップ
     --help                        使い方の表示

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Most of your images will be created on top of a base image from the Docker Hub registry.

大部分のイメージは、 `Docker Hub <https://hub.docker.com/>`_ レジストリにあるベース・イメージを元に作られています。

.. Docker Hub contains many pre-built images that you can pull and try without needing to define and configure your own.

`Docker Hub <https://hub.docker.com/>`_ には多くの構築済みのイメージがあります。自分で定義や設定をしなくても、イメージを ``pull`` （取得）して試せます。

.. It is also possible to manually specify the path of a registry to pull from. For example, if you have set up a local registry, you can specify its path to pull from it. A repository path is similar to a URL, but does not contain a protocol specifier (https://, for example).

.. また、手動でレジストリのパスを指定し、そこから取得することも可能です。例えば、ローカルにレジストリをセットアップしている場合、そのパスを指定して、そこから pull できます。リポジトリのパスは、 URL に似た形式ですが、プロトコルの指定は含みません（例： ``https://`` ）。

.. To download a particular image, or set of images (i.e., a repository), use docker pull:

特定のイメージやイメージの集まり（例：リポジトリ）をダウンロードするには、 ``docker pull`` を使います。

.. Proxy configuration

.. _pull-proxy-configuration:

プロキシ設定
====================

.. If you are behind an HTTP proxy server, for example in corporate settings, before open a connect to registry, you may need to configure the Docker daemon's proxy settings, using the HTTP_PROXY, HTTPS_PROXY, and NO_PROXY environment variables. To set these environment variables on a host using systemd, refer to the control and configure Docker with systemd for variables configuration.

企業内における設定など HTTP プロキシ・サーバの背後で使う場合には、レジストリに接続する前に、Docker デーモンの設定が必要になるでしょう。設定には環境変数 ``HTTP_PROXY`` 、 ``HTTPS_PROXY`` 、 ``NO_PROXY`` です。これらの環境変数を ``systemd``  上で使う場合には、 :ref:`systemd で Docker の管理と設定 <systemd-http-proxy>` の環境変数についてをご覧ください。

.. Examples

例
==========

.. Pull an image from Docker Hub

.. _pull-an-image-from-docker-hub:

イメージを Docker Hub から取得（pull）
----------------------------------------

.. To download a particular image, or set of images (i.e., a repository), use docker pull. If no tag is provided, Docker Engine uses the :latest tag as a default. This command pulls the debian:latest image:

特定のイメージやイメージ群（例：リポジトリ）をダウンロードするには、 ``docker pull`` を使います。タグを指定しなければ、 Docker Engine はデフォルトで ``:latest`` タグを使います。次のコマンドは ``debian:latest`` イメージを取得します：

.. code-block:: bash

   $ docker pull debian
   
   Using default tag: latest
   latest: Pulling from library/debian
   fdd5d7827f33: Pull complete
   a3ed95caeb02: Pull complete
   Digest: sha256:e7d38b3517548a1c71e41bffe9c8ae6d6d29546ce46bf62159837aad072c90aa
   Status: Downloaded newer image for debian:latest

.. Docker images can consist of multiple layers. In the example above, the image consists of two layers; fdd5d7827f33 and a3ed95caeb02.

Docker イメージは複数のレイヤ（層）で構成されています。上の例では、イメージには ``fdd5d7827f33`` と ``a3ed95caeb02`` の２つのレイヤがあります。

.. Layers can be reused by images. For example, the debian:jessie image shares both layers with debian:latest. Pulling the debian:jessie image therefore only pulls its metadata, but not its layers, because all layers are already present locally:

レイヤはイメージ間で再利用できます。例えば、 ``debian:jessie`` イメージは ``debian:latest`` とレイヤを共有しています。そのため、 ``debian:jessie`` イメージの取得時は、レイヤをダウンロードせずにメタデータのみ取得します。なぜなら全てのレイヤがローカルにダウンロード済みだからです。

.. code-block:: bash

   $ docker pull debian:jessie
   
   jessie: Pulling from library/debian
   fdd5d7827f33: Already exists
   a3ed95caeb02: Already exists
   Digest: sha256:a9c958be96d7d40df920e7041608f2f017af81800ca5ad23e327bc402626b58e
   Status: Downloaded newer image for debian:jessie

.. To see which images are present locally, use the docker images command:

どのようなイメージがローカルにあるかを確認するには ``docker images`` コマンドを使います。

.. code-block:: bash

   $ docker images
   
   REPOSITORY   TAG      IMAGE ID        CREATED      SIZE
   debian       jessie   f50f9524513f    5 days ago   125.1 MB
   debian       latest   f50f9524513f    5 days ago   125.1 MB

.. Docker uses a content-addressable image store, and the image ID is a SHA256 digest covering the image’s configuration and layers. In the example above, debian:jessie and debian:latest have the same image ID because they are actually the same image tagged with different names. Because they are the same image, their layers are stored only once and do not consume extra disk space.

Docker はコンテント・アドレッサブル（content-addressable；内容に対して割り当て可能な）イメージ・ストアを使います。そして、イメージ ID とはイメージの設定とレイヤを扱う SHA256 ダイジェストです。先ほどの例では ``debian:jessie`` と ``debian:latest`` は同じイメージ ID を持っています。イメージ名は違いますが、実際には同じイメージに対してタグ付けしています。どちらも同じイメージのため、レイヤのためのデータを保存するのは１度だけであり、余分なディスク容量は不要です。

.. For more information about images, layers, and the content-addressable store, refer to understand images, containers, and storage drivers.

イメージ、レイヤ、コンテント・アドレッサブル・ストアに関する詳しい情報は、 :doc:`/engine/userguide/storagedriver/imagesandcontainers` をご覧ください。

.. Pull an image by digest (immutable identifier)

.. _pull-an-image-by-digest-immutable-identifier:

ダイジェスト（変わらない識別子）でイメージを取得
--------------------------------------------------

.. So far, you’ve pulled images by their name (and “tag”). Using names and tags is a convenient way to work with images. When using tags, you can docker pull an image again to make sure you have the most up-to-date version of that image. For example, docker pull ubuntu:14.04 pulls the latest version of the Ubuntu 14.04 image.

ここまではイメージを名前（または「タグ」）で取得しました。イメージを扱うのに名前とタグの指定は便利です。イメージに対して ``docker pull`` を実行する時にタグを指定したら、そのイメージの最新バージョンをダウンロードします。例えば ``docker pull ubuntu:14.04`` は Ubuntu 14.04 イメージの最新バージョンを取得します。

.. In some cases you don’t want images to be updated to newer versions, but prefer to use a fixed version of an image. Docker enables you to pull an image by its digest. When pulling an image by digest, you specify exactly which version of an image to pull. Doing so, allows you to “pin” an image to that version, and guarantee that the image you’re using is always the same.

イメージを最新バージョンではなく、特定のバージョンに固定したい場合があるでしょう。そのような場合、Docker はダイジェスト（ *digest* 値）を指定してイメージを取得できます。ダイジェストを指定してイメージを取得しようとしたら、指定したバージョンのイメージを確実にダウンロードします。したらイメージのバージョンを「固定」し、常に同じイメージの使用を保証します。

.. To know the digest of an image, pull the image first. Let’s pull the latest ubuntu:14.04 image from Docker Hub:

イメージのダイジェスト値を知るには、まずイメージを取得します。Docker Hub から最新の ``ubuntu:14.04`` イメージをダウンロードしましょう。

.. code-block:: bash

   $ docker pull ubuntu:14.04
   
   14.04: Pulling from library/ubuntu
   5a132a7e7af1: Pull complete
   fd2731e4c50c: Pull complete
   28a2f68d1120: Pull complete
   a3ed95caeb02: Pull complete
   Digest: sha256:45b23dee08af5e43a7fea6c4cf9c25ccf269ee113168c19722f87876677c5cb2
   Status: Downloaded newer image for ubuntu:14.04

.. Docker prints the digest of the image after the pull has finished. In the example above, the digest of the image is:

Docker はダウンロードが完了したら、イメージのダイジェスト値を表示します。先ほどの例では、イメージのダイジェスト値とは、こちらです。

.. code-block:: bash

   sha256:45b23dee08af5e43a7fea6c4cf9c25ccf269ee113168c19722f87876677c5cb2

.. Docker also prints the digest of an image when pushing to a registry. This may be useful if you want to pin to a version of the image you just pushed.

Docker はイメージを送信（ *push* ）する時のダイジェスト値を表示します。イメージを送信時のバージョンを固定したい場合には便利になるでしょう。

.. A digest takes the place of the tag when pulling an image, for example, to pull the above image by digest, run the following command:

イメージの取得時にダイジェスト値を使うには、タグとして扱います。例えば、イメージをダイジェスト値で取得するには、次のコマンドを実行します。

.. code-block:: bash

   $ docker pull ubuntu@sha256:45b23dee08af5e43a7fea6c4cf9c25ccf269ee113168c19722f87876677c5cb2
   
   sha256:45b23dee08af5e43a7fea6c4cf9c25ccf269ee113168c19722f87876677c5cb2: Pulling from library/ubuntu
   5a132a7e7af1: Already exists
   fd2731e4c50c: Already exists
   28a2f68d1120: Already exists
   a3ed95caeb02: Already exists
   Digest: sha256:45b23dee08af5e43a7fea6c4cf9c25ccf269ee113168c19722f87876677c5cb2
   Status: Downloaded newer image for ubuntu@sha256:45b23dee08af5e43a7fea6c4cf9c25ccf269ee113168c19722f87876677c5cb2

.. Digest can also be used in the FROM of a Dockerfile, for example:

Digest は Dockerfile の ``FROM`` でも指定可能です。以下は例です。

::

   FROM ubuntu@sha256:45b23dee08af5e43a7fea6c4cf9c25ccf269ee113168c19722f87876677c5cb2
   MAINTAINER some maintainer <maintainer@example.com>

..    Note: Using this feature “pins” an image to a specific version in time. Docker will therefore not pull updated versions of an image, which may include security updates. If you want to pull an updated image, you need to change the digest accordingly.

.. note::

   この機能はイメージに対するバージョンを都度「固定」します。そのため Docker はイメージのバージョンを更新しないため、セキュリティの更新もしません。更新版のイメージを取得したい場合は、適時ダイジェスト値を変更する必要があります。

.. Pulling from a different registry

別のレジストリから取得
==============================

.. By default, docker pull pulls images from Docker Hub. It is also possible to manually specify the path of a registry to pull from. For example, if you have set up a local registry, you can specify its path to pull from it. A registry path is similar to a URL, but does not contain a protocol specifier (https://).

``docker pull`` のイメージは `Docker Hub <https://hub.docker.com/>`_ から取得するのがデフォルトです。取得するレジストリの場所は、手動で指定可能です。例えば、ローカルにレジストリをセットアップしておけば、そちらを指定してイメージを取得できます。レジストリのパスは URL と似ていますが、プロトコル指示子（ ``https://`` ）がありません。

.. The following command pulls the testing/test-image image from a local registry listening on port 5000 (myregistry.local:5000):

以下のコマンドは、ポート 5000 を開いているローカルのレジストリ（ ``myregistry.local:5000``  ）から  ``testing/test-image`` イメージを取得するコマンドです。

.. code-block:: bash

   $ docker pull myregistry.local:5000/testing/test-image

.. Registry credentials are managed by docker login.

レジストリの認証情報は :doc:`docker login <login>` で管理します。

.. Docker uses the https:// protocol to communicate with a registry, unless the registry is allowed to be accessed over an insecure connection. Refer to the insecure registries section for more information.

Docker はレジストリとの通信に ``https`` プロトコルを使います。ただし、レジストリが安全ではない接続（insecure connection）を許可している場合は除外します。詳細は :ref:`insecure-registries` をご覧ください。

.. Pull a repository with multiple images

.. _pull-a-repository-with-multiple-images:

リポジトリから複数のイメージを取得
========================================

.. By default, docker pull pulls a single image from the registry. A repository can contain multiple images. To pull all images from a repository, provide the -a (or --all-tags) option when using docker pull.

デフォルトでは、 ``docker pull`` はレジストリから単一のイメージを取得します。リポジトリには複数のイメージがあります。リポジトリから全てのイメージを取得するには ``docker pull`` で ``-a`` （あるいは ``--all-tags`` ）オプションを使います。

.. This command pulls all images from the fedora repository:

次のコマンドは ``fedora`` リポジトリから全てのイメージを取得します。

.. code-block:: bash

   $ docker pull --all-tags fedora
   
   Pulling repository fedora
   ad57ef8d78d7: Download complete
   105182bb5e8b: Download complete
   511136ea3c5a: Download complete
   73bd853d2ea5: Download complete
   ....
   
   Status: Downloaded newer image for fedora

.. After the pull has completed use the docker images command to see the images that were pulled. The example below shows all the fedora images that are present locally:

取得が終わったら、取得した全てのイメージを確認するために ``docker images`` コマンドを使います。次の例はローカルに現在ある全ての ``fedora`` イメージを表示しています。

.. code-block:: bash

   $ docker images fedora
   
   REPOSITORY   TAG         IMAGE ID        CREATED      SIZE
   fedora       rawhide     ad57ef8d78d7    5 days ago   359.3 MB
   fedora       20          105182bb5e8b    5 days ago   372.7 MB
   fedora       heisenbug   105182bb5e8b    5 days ago   372.7 MB
   fedora       latest      105182bb5e8b    5 days ago   372.7 MB

.. Canceling a pull

.. _cancelling-a-pull:

取得を中止
==========

.. Killing the docker pull process, for example by pressing CTRL-c while it is running in a terminal, will terminate the pull operation.

``docker pull`` プロセスを停止するには、ターミナルで実行中に ``CTRL-c`` を押すと、pull 処理を中断します。

.. code-block:: bash

   $ docker pull fedora
   
   Using default tag: latest
   latest: Pulling from library/fedora
   a3ed95caeb02: Pulling fs layer
   236608c7b546: Pulling fs layer
   ^C

..    Note: Technically, the Engine terminates a pull operation when the connection between the Docker Engine daemon and the Docker Engine client initiating the pull is lost. If the connection with the Engine daemon is lost for other reasons than a manual interaction, the pull is also aborted.

.. note::

   技術的に Engine を停止する処理とは、 Docker Engine デーモンと起点となった Docker Engine クライアント間における取得（pull）に対してです。何らかの理由によって Engine デーモンとの通信を切断した場合も、同様に取得処理が中断します。

.. seealso:: 

   pull
      https://docs.docker.com/engine/reference/commandline/pull/
