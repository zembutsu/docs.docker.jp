.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/userguide/intro/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/userguide/intro.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/userguide/intro.md
.. check date: 2016/06/13
.. Commits on Mar 5, 2016 3b74be8ab7d93a70af3e0ac6418627c1de72228b
.. ----------------------------------------------------------------------------

.. Engine user guide

.. _engine-user-guide:

=======================================
Docker Engine ユーザ・ガイド
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. This guide takes you through the fundamentals of using Docker Engine and integrating it into your environment. You’ll learn how to use Engine to:

当ガイドは皆さんの環境に Docker Engine を導入するための基礎となります。Docker Engine に関する以下の使い方を学びます。

.. 
    Dockerize your applications.
    Run your own containers.
    Build Docker images.
    Share your Docker images with others.
    And a whole lot more!

* アプリケーションの Docker 化 (Dockerize)
* 自分自身でコンテナを実行
* Docker イメージの構築
* Docker イメージを他人と共有
* 他にも多くのことを！

.. This guide is broken into major sections that take you through learning the basics of Docker Engine and the other Docker products that support it.

Docker Engine の基本と Docker がサポートするプロダクトを理解できるようにするため、このガイドは主な章を分けています。


.. Dockerizing applications: A “Hello world”

.. _dockerizing-applications:

アプリケーションの Docker 化：”Hello world”
==============================================

.. How do I run applications inside containers?

「アプリケーションをコンテナの中で実行するには？」

.. Docker Engine offers a containerization platform to power your applications. To learn how to Dockerize applications and run them:

Docker Engine は、アプリケーションを強力にするコンテナ化プラットフォームです。アプリケーションを Docker に対応する方法と実行の仕方を学びます。

.. Go to Dockerizing Applications.

:doc:`アプリケーションの Docker 化 </engine/userguide/containers/dockerizing>` へ移動します。


.. Working with containers

.. _working-with-containers:

コンテナの操作
=============================

.. How do I manage my containers?

「コンテナを管理するには？」

.. Once you get a grip on running your applications in Docker containers, you’ll learn how to manage those containers. To find out about how to inspect, monitor and manage containers:

アプリケーションを Docker コンテナで実行できるようになったら、これらのコンテナの管理方法を学びます。コンテナの調査、監視、管理の仕方を理解します。

.. Go to Working With Containers.

:doc:`コンテナの操作 </engine/userguide/containers/usingdocker>` へ移動します。


.. Working with Docker images

.. _working-with-docker-images:

Docker イメージの操作
=============================

.. How can I access, share and build my own images?

「自分のイメージにアクセス、共有、構築するには？」

.. Once you’ve learnt how to use Docker it’s time to take the next step and learn how to build your own application images with Docker.

Docker の使い方を学んだら、次のステップに進みます。Docker で自分のアプリケーション・イメージを構築する方法を学びます。

.. Go to Working with Docker Images.

:doc:`Docker イメージの操作 </engine/userguide/containers/dockerimages>` へ移動します。


.. Networking containers

.. _networking-containers-intro:

コンテナのネットワーク
=============================

.. Until now we’ve seen how to build individual applications inside Docker containers. Now learn how to build whole application stacks with Docker networking.

これまで Docker コンテナの中に個々のアプリケーションを構築する方法を理解しました。次は Docker ネットワークでアプリケーション・スタックを構築する方法を学びます。

.. Go to Networking Containers.

:doc:`コンテナのネットワーク作成 </engine/userguide/containers/networkingcontainers>` へ移動します。


.. Managing data in containers

.. _managing-data-in-containers:

コンテナ内のデータ管理
=============================

.. Now we know how to link Docker containers together the next step is learning how to manage data, volumes and mounts inside our containers.

Docker コンテナ間を接続する方法を学んだら、次はコンテナの中にあるデータ、ボリューム、マウントに関する管理方法を学びます。

.. Go to Managing Data in Containers.

:doc:`コンテナの内のデータ管理 </engine/userguide/containers/dockervolumes>` へ移動します。


.. Docker products that complement Engine

.. docker-products-that-complement-engine:

Engine を補う Docker プロダクト
===============================

.. Often, one powerful technology spawns many other inventions that make that easier to get to, easier to use, and more powerful. These spawned things share one common characteristic: they augment the central technology. The following Docker products expand on the core Docker Engine functions.

多くの場合、ある強力な技術は更なる技術を生み出します。何かをより簡単に入手できるように、より簡単に使えるように、より強力にするように、等です。生み出されたものは共有されるという特徴があります。つまり、結果として中心にある技術を補強するのです。以下の Docker プロダクトは、中心となる Docker Engine の機能を拡張します。

.. Docker Hub

.. _intro-docker-hub:

Docker Hub
----------

.. Docker Hub is the central hub for Docker. It hosts public Docker images and provides services to help you build and manage your Docker environment. To learn more:

Docker Hub は Docker の中心となる場所（ハブ）です。公開用の Docker イメージを提供し、Docker 環境の構築と管理の手助けとなるサービスを提供します。

.. Go to Using Docker Hub.

:doc:`Docker Hub の利用 </docker-hub/index>` へ移動します。


.. Docker Machine

Docker Machine
--------------------

.. Docker Machine helps you get Docker Engines up and running quickly. Machine can set up hosts for Docker Engines on your computer, on cloud providers, and/or in your data center, and then configure your Docker client to securely talk to them.

Docker Machine は Docker Engine を起動し、迅速に実行する手助けをします。Machine で Docker Engine をセットアップできるのは、自分のコンピュータ上や、クラウド事業者上だけではありません。データセンタでもセットアップできます。セットアップ後は Docker クライアントが安全に通信できるように設定します。

.. Go to Docker Machine user guide.

:doc:`Docker Machine ユーザ・ガイド </machine/index>` へ移動します。


.. Docker Compose

.. _intro-docker-compose:

Docker Compose
--------------------

.. Docker Compose allows you to define an application’s components -- their containers, configuration, links and volumes -- in a single file. Then a single command will set everything up and start your application running.

Docker Compose はアプリケーションの構成を定義します。コンテナと設定、リンク、ボリュームに関する情報を、１つのファイル上で記述します。コマンド１つ実行するだけで、全てのをセットアップし、アプリケーションを実行します。

.. Go to Docker Compose user guide.

:doc:`Docker Compose ユーザ・ガイド </compose/index>` へ移動します。


.. Docker Swarm

.. _intro-docker-swarm:

Docker Swarm
--------------------

.. Docker Swarm pools several Docker Engines together and exposes them as a single virtual Docker Engine. It serves the standard Docker API, so any tool that already works with Docker can now transparently scale up to multiple hosts.

Docker Swarm は複数の Docker Engine をまとめて、１つの仮想的な Docker Engine のように振る舞います。標準 Docker API に対応しているため、Docker で利用可能なツールであれば、複数のホスト上に透過的なスケールアップが可能です。

.. Go to Docker Swarm user guide.

:doc:`Docker Swarm ユーザ・ガイド </swarm/index>` へ移動します。


.. Getting help

助けを得る
=============================

.. 
    Docker homepage
    Docker Hub
    Docker blog
    Docker documentation
    Docker Getting Started Guide
    Docker code on GitHub
    Docker mailing list
    Docker on IRC: irc.freenode.net and channel #docker
    Docker on Twitter
    Get Docker help on StackOverflow
    Docker.com

* `Docker ホームページ <https://www.docker.com/>`_
* `Docker Hub <https://hub.docker.com/>`_
* `Docker ブログ <https://blog.docker.com/>`_
* `Docker ドキュメント（英語） <https://docs.docker.com/>`_
* `GitHub 上の Docker コード <https://github.com/docker/docker>`_
* `Docker メーリングリスト <https://groups.google.com/forum/#!forum/docker-user>`_
* IRC 上の Docker：irc.freenode.net 上の #docker チャンネル
* `Twitter の Docker アカウント <https://twitter.com/docker>`_
* StackOverflow の `Docker help <https://stackoverflow.com/search?q=docker>`_
* `Docker.com <https://www.docker.com/>`_

.. seealso:: 

   Engine user guide
      https://docs.docker.com/engine/userguide/intro/

