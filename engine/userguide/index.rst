.. http://docs.docker.com/engine/userguide/

.. Welcome to the Docker user guide

=======================================
Docker ユーザ・ガイドへようこそ
=======================================

.. In the Introduction you got a taste of what Docker is and how it works. This guide takes you through the fundamentals of using Docker and integrating it into your environment. You’ll learn how to use Docker to:

:doc:`イントロダクション（はじめに） </engine/misc>` で は Docker とは何か、Docker がどのように動くのかを見てきました。こちらのガイドは、Docker 利用の基礎を通して、皆さんの環境に取り込むことを目指します。次のような Docker の使い方を学びます：

.. 
    Dockerize your applications.
    Run your own containers.
    Build Docker images.
    Share your Docker images with others.
    And a whole lot more!

* アプリケーションの Docker 化 (Dockerize)
* 自分自信のコンテナを実行
* Docker イメージの構築
* Docker イメージを他人と共有
* そして、その他の多くのことを！

.. This guide is broken into major sections that take you through the Docker life cycle:

このガイドは Docker のライフサイクルにあわせて、主なセクションを分割しました。

.. Getting started with Docker Hub

Docker Hub 入門
=============================

.. How do I use Docker Hub?

*Docker Hub をどのように使うのでしょうか？*

.. Docker Hub is the central hub for Docker. It hosts public Docker images and provides services to help you build and manage your Docker environment. To learn more:

Docker Hub は Docker の中心となる場所 (ハブ) です。公開用の Docker イメージを提供し、Docker 環境の構築と管理の手助けとなるサービスを提供します。

.. Go to Using Docker Hub.

:doc:`Docker Hub の利用 </docker-hub/index>` へ移動します。


.. Dockerizing applications: A “Hello world”

アプリケーションの Docker 化：”Hello world”
==============================================

.. How do I run applications inside containers?

*アプリケーションをコンテナの中で実行するには？*

.. Docker offers a container-based virtualization platform to power your applications. To learn how to Dockerize applications and run them:

Docker はコンテナを基盤とした仮想化プラットフォームにより、アプリケーションに力をもたらします。アプリケーションの Docker 化の方法と実行方法を学びます。

.. Go to Dockerizing Applications.

:doc:`アプリケーションの Docker 化 </engine/userguide/dockerizing>` へ移動します。


.. Working with containers

コンテナの操作
=============================

.. How do I manage my containers?

*コンテナを管理するには？*

.. Once you get a grip on running your applications in Docker containers we’re going to show you how to manage those containers. To find out about how to inspect, monitor and manage containers:

アプリケーションを Docker コンテナで実行できるようになったら、これらのコンテナの管理方法を紹介します。コンテナの調査、監視、管理の仕方を見ていきます。

.. Go to Working With Containers.

:doc:`コンテナの操作 </engine/userguide/usingdocker>` へ移動します。


.. Working with Docker images

Docker イメージの操作
=============================

.. How can I access, share and build my own images?

*自分のイメージにアクセス、共有、構築するには？*

.. Once you’ve learnt how to use Docker it’s time to take the next step and learn how to build your own application images with Docker.

Docker の使い方を学んだら、次のステップに進む時です。Docker で自分のアプリケーション・イメージを構築する方法を学びます。

.. Go to Working with Docker Images.

:doc:`Docker イメージの操作 </engine/userguide/dockerimages>` へ移動します。

.. Networking containers

コンテナのネットワーク
=============================

.. Until now we’ve seen how to build individual applications inside Docker containers. Now learn how to build whole application stacks with Docker networking.

これまで Docker コンテナの中に個々のアプリケーション構築方法をみてきました。次は Docker ネットワークでアプリケーション・スタックの構築方法を学びます。

.. Go to Networking Containers.

:doc:`コンテナのネットワーク作成 </engine/userguide/networkingcontainers>` へ移動します。


.. Managing data in containers

コンテナ内のデータ管理
=============================

.. Now we know how to link Docker containers together the next step is learning how to manage data, volumes and mounts inside our containers.

Docker コンテナ間を接続する方法を学びました。次はコンテナの中にあるデータ、ボリューム、マウントに関する管理方法を学びます。

.. Go to Managing Data in Containers.

:doc:`コンテナの内のデータ管理 </engine/userguide/dockervolumes>` へ移動します。



.. Working with Docker Hub

Docker Hub の操作
=============================

.. Now we’ve learned a bit more about how to use Docker we’re going to see how to combine Docker with the services available on Docker Hub including Trusted Builds and private repositories.

Docker のより詳細な使い方を学びました。次は Docker と Docker Hub で利用可能なサービスを連携し、信頼できる構築方法とプライベート・レポジトリを学びます。

.. Go to Working with Docker Hub.

:doc:`Docker Hub の操作 </engine/userguide/dockerrepos>` へ移動します。


.. Docker Compose

Docker Compose
=============================

.. Docker Compose allows you to define a application’s components – their containers, configuration, links and volumes – in a single file. Then a single command will set everything up and start your application running.

Docker Compose はアプリケーションの構成を定義します。コンテナと設定、リンク、ボリュームについて、１つのファイルに記述します。コマンド１つ実行するだけで、全てを起動し、アプリケーションを実行します。

.. Go to Docker Compose user guide.

:doc:`Docker Compose ユーザ・ガイド </compose/index>` へ移動します。



.. Docker Machine

Docker Machine
=============================

.. Docker Machine helps you get Docker Engines up and running quickly. Machine can set up hosts for Docker Engines on your computer, on cloud providers, and/or in your data center, and then configure your Docker client to securely talk to them.

Docker Machine は Docker Engine を起動し、迅速に実行する手助けをします。Machine が Docker Engine をセットアップできるのは、自分のコンピュータや、クラウド事業者だけではありません。データセンタでもセットアップできます。その後、Docker クライアントが安全に通信できるよう設定します。

.. Go to Docker Machine user guide.

:doc:`Docker Machine ユーザ・ガイド </machine/index>` へ移動します。


.. Docker Swarm

Docker Swarm
=============================

.. Docker Swarm pools several Docker Engines together and exposes them as a single virtual Docker Engine. It serves the standard Docker API, so any tool that already works with Docker can now transparently scale up to multiple hosts.

Docker Swarm は複数の Docker Engine をまとめて、１つの仮想的な Docker Engine のように見せます。標準 Docker API を持っているため、既に Docker で利用可能なツールを使い、複数のホスト上で透過的なスケールアップが可能です。

.. Go to Docker Swarm user guide.

:doc:`Docker Swarm ユーザ・ガイド </swarm/index>` へ移動します。


.. Getting help

ヘルプを得るには
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
* :doc:`Docker 導入ガイド <mac/started.rst>`
* `Docker メーリングリスト <https://groups.google.com/forum/#!forum/docker-user>`_
* IRC 上の Docker：irc.freenode.net 上の #docker チャンネル
* `Twitter の Docker アカウント <https://twitter.com/docker>`_
* StackOverflow の `Docker help <https://stackoverflow.com/search?q=docker>`_
* `Docker.com <https://www.docker.com/>`_




