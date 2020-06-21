.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/develop/develop-images/image_management/
   doc version: 19.03
      https://github.com/docker/docker.github.io/blob/master/develop/develop-images/multistage-build.md
.. check date: 2020/06/21
.. Commits on Mar 17, 2020 14bbe621e55e9360019f6b3e25be4a25e3f79688
.. -----------------------------------------------------------------------------

.. Manage images

.. _manage-images:

=======================================
イメージの管理
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. The easiest way to make your images available for use by others inside or outside your organization is to use a Docker registry, such as Docker Hub, or by running your own private registry.

あなたの組織の内外でイメージを簡単に利用できるようにする方法が、 :ref:`Docker Hub <image-managemnet-docker-hub>`  のような Docker レジストリを使うか、自分で :ref:`プライベート・レジストリ <image-management-docker-registry>` を動かします。

.. Docker Hub

.. _image-management-docker-hub:

Docker Hub
====================

.. Docker Hub is a public registry managed by Docker, Inc. It centralizes information about organizations, user accounts, and images. It includes a web UI, authentication and authorization using organizations, CLI and API access using commands such as docker login, docker pull, and docker push, comments, stars, search, and more.

:doc:`Docker Hub</docker-hub/toc>` は Docker syが管理している公開（パブリック）レジストリです。これは、組織、ユーザアカウント、イメージをまとめている場所です。さらに、ウェブ UI、認証、組織用の認証、CLI や API で ``docker login`` 、 ``docker pull`` 、 ``docker push`` のようなアクセス、コメント、スター機能などがあります。

.. Docker Registry

.. _image-management-docker-registry:

Docker Registry
====================

.. The Docker Registry is a component of Docker’s ecosystem. A registry is a storage and content delivery system, holding named Docker images, available in different tagged versions. For example, the image distribution/registry, with tags 2.0 and latest. Users interact with a registry by using docker push and pull commands such as docker pull myregistry.com/stevvooe/batman:voice.

Docker Registry は Docker エコシステムのコンポーネントです。レジストリとはストレージ（保管場所）であり、コンテント・デリバリ・システムとして Docker イメージ名を保持し、イメージは異なるタグを付けられたバージョンを利用できます。たとえば、 ``distribution/registry`` イメージには、 ``2.0`` と ``latest`` のタグがあります。 ``docker pull myregistry.com/stevvooe/batman:voice`` のように、ユーザはレジストリで docker push や pull コマンドが利用できます。

.. Docker Hub is an instance of a Docker Registry.

Docker Hub は Dockre Registry 事例の1つです。

.. Content Trust

Content Trust
====================

.. When transferring data among networked systems, trust is a central concern. In particular, when communicating over an untrusted medium such as the internet, it is critical to ensure the integrity and publisher of all of the data a system operates on. You use Docker to push and pull images (data) to a registry. Content trust gives you the ability to both verify the integrity and the publisher of all the data received from a registry over any channel.

ネットワーク上のシステム間でデータを転送時、信用 `trust` が課題の中心です。特に、インターネット上のように信頼できない媒体上で通信する場合、システム操作に関する全データに対し、安全性の確保と提供者を確実なものとする必要があります。 Docker を使えばイメージ（データ）をレジストリに送信/受信できます。コンテント・トラスト（Content trust）を使えば、あらゆるチャンネルを越えたレジストリから受け取る全データの完全性と提供者の両方を認証します。

.. See Content trust for information about configuring and using this feature on Docker clients.

Docker クライアント上で設定・使用に関する情報は、 :doc:`コンテント・トラスト </engine/security/trust>` をご覧ください。

.. seealso:: 

   Manage images
      https://docs.docker.com/develop/develop-images/image_management/
