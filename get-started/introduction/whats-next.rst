.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/get-started/introduction/whats-next/
   doc version: 27.0
      https://github.com/docker/docs/blob/main/content/get-started/introduction/whats-next.md
.. check date: 2025/01/09
.. Commits on Aug 20, 2024 abd030c3fe2b5db526fb7a16d6d9892d46d678e5
.. -----------------------------------------------------------------------------

.. What's next
.. _introduction-whats-next:

========================================
次に進む
========================================

.. The following sections provide step-by-step guides to help you understand core Docker concepts, building images, and running containers.

以下のセクションでは、Docker の中心となる概念、イメージ構築、コンテナ実行を理解するのに役立つ、段階的なガイドを提供します。

.. The basics
.. _introduction-the-basics:

基本
==========

.. Get started learning the core concepts of containers, images, registries, and Docker Compose.

重要な概念であるコンテナ、イメージ、レジストリ、Docker Compose を学び始めましょう。

.. grid:: 3

    .. grid-item-card:: コンテナとは？
        :link: /get-started/docker-concepts/the-basics/what-is-a-container
        :link-type: doc

        初めてのコンテナ実行方法を学びましょう。

    .. grid-item-card:: イメージとは？
        :link: /get-started/docker-concepts/the-basics/what-is-an-image
        :link-type: doc

        イメージレイヤの基礎を学びましょう。

    .. grid-item-card:: レジストリとは？
        :link: /get-started/docker-concepts/the-basics/what-is-a-registry
        :link-type: doc

        コンテナレジストリを学び、互換性を調べ、レジストリをやりとりしましょう。

.. grid:: 3

    .. grid-item-card:: Docker Compose とは？
        :link: /get-started/docker-concepts/the-basics/what-is-docker-compose
        :link-type: doc

        Docker Copose の理解を深めましょう。


.. Building images
.. _introduction-building-images:

イメージ構築
====================

.. Craft optimized container images with Dockerfiles, build cache, and multi-stage builds.

Dockerfile 、ビルドキャッシュ、マルチステージビルド で最適化されたコンテナイメージを作りましょう。

.. grid:: 3

    .. grid-item-card:: イメージレイヤーの理解
        :link: /get-started/docker-concepts/building-images/understanding-image-layers
        :link-type: doc

        コンテナイメージのレイヤーいついて学びましょう。

    .. grid-item-card:: Dockerfile を書く
        :link: /get-started/docker-concepts/building-images/writing-a-dockerfile
        :link-type: doc

        Dockerfile を使ってイメージを作る方法を学びましょう。

    .. grid-item-card:: イメージの構築、タグ付け、送信
        :link: /get-started/docker-concepts/building-images/build-tag-and-publish-an-image
        :link-type: doc

        構築、タグ付けの仕方や、Docker Hub や他のレジストリへの送信方法を学びましょう。


.. grid:: 3

    .. grid-item-card:: ビルドキャッシュの利用
        :link: /get-started/docker-concepts/building-images/using-the-build-cache
        :link-type: doc

        ビルドキャッシュについてや、キャッシュ無しとの違い、効率的なビルドキャッシュの使い方を学びましょう。

    .. grid-item-card:: マルチステージビルド
        :link: /get-started/docker-concepts/building-images/multi-stage-builds
        :link-type: doc

        マルチステージビルドや利点について詳しく学びましょう。


.. Running containers
.. _introduction-running-containers:

コンテナ実行
====================

.. Master essential techniques for exposing ports, overriding defaults, persisting data, sharing files, and managing multi-container applications.

必要不可欠な技術をマスターし、複数のコンテナアプリケーションを管理しましょう。


.. grid:: 3

    .. grid-item-card:: ポートの公開
        :link: /get-started/docker-concepts/running-containers/publishing-ports
        :link-type: doc

        Docker でポートの露出（expose）と公開（publish）がなぜ重要なのか理解しましょう。

    .. grid-item-card:: コンテナのデフォルトを上書き
        :link: /get-started/docker-concepts/running-containers/overriding-container-defaults
        :link-type: doc

        ``docker run`` コマンドの使用時、コンテナのデフォルトの挙動を上書きする方法を学びましょう。

    .. grid-item-card:: コンテナデータの保持
        :link: /get-started/docker-concepts/running-containers/persisting-container-data
        :link-type: doc

        Docker でデータを保持する重要性を学びましょう。


.. grid:: 3

    .. grid-item-card:: ローカルファイルをコンテナと共有
        :link: /get-started/docker-concepts/running-containers/sharing-local-files
        :link-type: doc

        Docker で利用できるストレージの種類と、一般的な使い方を学びましょう。

    .. grid-item-card:: 複数コンテナのアプリケーション
        :link: /get-started/docker-concepts/running-containers/multi-container-applications
        :link-type: doc

        複数コンテナを使うアプリケーションの重要性と、1つのコンテナアプリケーションとの違いを学びましょう。


|

.. seealso::


   What's next | Docker Docs
      https://docs.docker.com/get-started/introduction/whats-next/