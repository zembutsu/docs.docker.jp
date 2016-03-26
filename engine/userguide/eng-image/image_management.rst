.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/userguide/eng-image/image_management/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/userguide/eng-image/image_management.md
   doc version: 1.10
      https://github.com/docker/docker/commits/master/docs/userguide/eng-image/image_management.md
.. check date: 2016/02/10
.. ---------------------------------------------------------------------------

.. Image management

.. _image-management:

========================================
イメージの管理
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. The Docker Engine provides a client which you can use to create images on the command line or through a build process. You can run these images in a container or publish them for others to use. Storing the images you create, searching for images you might want, or publishing images others might use are all elements of image management.

Docker エンジンにあるクライアントを使い、コマンドライン上でイメージの作成や、構築プロセスに渡すことができます。これらのイメージをコンテナで使ったり、他人が使えるように公開も可能です。作成したイメージの保管や、使いたいイメージの検索、あるいは、他人が公開しているのを使いたい場合、これらは全てイメージ管理に分離されます。

.. This section provides an overview of the major features and products Docker provides for image management.

このセクションでは、イメージ管理に関する Docker の主な機能概要や、ツールについて扱います。

.. Docker Hub

.. _image-docker-hub:

Docker Hub
====================

.. The Docker Hub is responsible for centralizing information about user accounts, images, and public name spaces. It has different components:

`Docker Hub <https://docs.docker.com/docker-hub/>`_ が持っている役割は、ユーザ・アカウント、イメージ、パブリック名前空間などに関する情報の集約です。

..    Web UI
    Meta-data store (comments, stars, list public repositories)
    Authentication service
    Tokenization

* ウェブ UI
* メタ・データの保管（コメント、スター数、公開レポジトリの一覧）
* 認証サービス
* トークン化

.. There is only one instance of the Docker Hub, run and managed by Docker Inc. This public Hub is useful for most individuals and smaller companies.

Docker 社によって運用・管理されているのは Docker Hub だけです。この公開 Hub は、ほとんどの個人や小さな会社にとって便利です。

.. Docker Registry and the Docker Trusted Registry

.. _docker-registry-and-the-docker-trusted-registry:

Docker レジストリと Docker トラステッド・レジストリ
===================================================

.. The Docker Registry is a component of Docker’s ecosystem. A registry is a storage and content delivery system, holding named Docker images, available in different tagged versions. For example, the image distribution/registry, with tags 2.0 and latest. Users interact with a registry by using docker push and pull commands such as, docker pull myregistry.com/stevvooe/batman:voice.

Docker レジストリは Docker エコシステムのコンポーネント（構成要素）です。レジストリは保管とコンテント（content; 内容）の配送システムであり、Docker イメージの名前を保持し、異なったタグのバージョンを利用できます。例えば、イメージ ``distribution/registry`` は、タグ ``2.0`` と ``latest`` を持っています。ユーザは ``docker pull myregistry.com/stevvooe/batman:voice`` のような docker push （送信）と pull （取得）コマンドを使い、レジストリと接続します。

.. The Docker Hub has its own registry which, like the Hub itself, is run and managed by Docker. However, there are other ways to obtain a registry. You can purchase the Docker Trusted Registry product to run on your company’s network. Alternatively, you can use the Docker Registry component to build a private registry. For information about using a registry, see overview for the Docker Registry.

Docker Hub はハブのように自身のレジストリを持ち、Docker 社によって運用・管理されています。しかしながら、レジストリを得るには別の方法があります。 :doc:`Docker トラステッド・レジストリ（Trusted Registry） </docker-trusted-registry/index>` プロダクトを購入すると、自社ネットワーク上で実行できるようになります。あるいは、Docker レジストリのコンポーネントを使い、プライベート・レジストリを構築することもできます。レジストリの使い方についての情報は、 :doc:`Docker レジストリ </registry/index>` をご覧ください。

.. Content Trust

.. _content-trust:

コンテント・トラスト
====================

.. When transferring data among networked systems, trust is a central concern. In particular, when communicating over an untrusted medium such as the internet, it is critical to ensure the integrity and publisher of all of the data a system operates on. You use Docker to push and pull images (data) to a registry. Content trust gives you the ability to both verify the integrity and the publisher of all the data received from a registry over any channel.

ネットワーク・システム上でデータを転送するときは、 *信頼性* が懸念事項の中心です。特にインターネットのような信頼できない環境を経由する時、とりわけ重要なのが、システムが操作する全てのデータの安全性と提供者を保証することです。Docker を使い、イメージ（データ）をレポジトリに送信・受信できます。コンテント・トラストは、レジストリがどの経路をたどっても、全てのデータの安全性と提供者の両方を保証するものです。

.. Content trust is currently only available for users of the public Docker Hub. It is currently not available for the Docker Trusted Registry or for private registries.

:doc:`コンテント・トラスト(Content Trust) </engine/security/trust/index>` は、現時点ではパブリックな Docker Hub の利用者だけが使えます。現時点では Docker トラステッド・レジストリやプライベート・レジストリでは利用できません。

.. seealso:: 

   Image management
      https://docs.docker.com/engine/userguide/eng-image/image_management/

