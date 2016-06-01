.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/swarm/overview/
.. SOURCE: https://github.com/docker/swarm/blob/master/docs/overview.md
   doc version: 1.11
      https://github.com/docker/swarm/commits/master/docs/overview.md
.. check date: 2016/04/29
.. Commits on Mar 4, 2016 4b8ed91226a9a49c2acb7cb6fb07228b3fe10007
.. -------------------------------------------------------------------

.. Docker Swarm overview

==============================
Docker Swarm 概要
==============================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Docker Swarm is native clustering for Docker. It turns a pool of Docker hosts into a single, virtual Docker host. Because Docker Swarm serves the standard Docker API, any tool that already communicates with a Docker daemon can use Swarm to transparently scale to multiple hosts. Supported tools include, but are not limited to, the following:

Docker Swarm は Docker に対応するネイティブなクラスタリング用ツールです。Docker Swarm は標準 Docker API で操作できます。そのため、Docker ホスト群を集め、１つの仮想 Docker ホストとして扱えます。既に Docker デーモンと通信可能なツールであれば、Swarm を使うだけで、意識せずに複数のホストにスケール可能になります。以下のツールをサポートしていますが、これだけに限りません。

* Dokku
* Docker Compose
* Krane
* Jenkins

.. And of course, the Docker client itself is also supported.

そしてもちろん、swarm は Docker クライアントでの操作もサポートします。

.. Like other Docker projects, Docker Swarm follows the “swap, plug, and play” principle. As initial development settles, an API will develop to enable pluggable backends. This means you can swap out the scheduling backend Docker Swarm uses out-of-the-box with a backend you prefer. Swarm’s swappable design provides a smooth out-of-box experience for most use cases, and allows large-scale production deployments to swap for more powerful backends, like Mesos.

他の Docker プロジェクトと同様に、Docker Swarm は "swap, plug, and play"（交換して、取り付けて、実行）の原理に従います。開発初期においては、API はバックエンドを取り替え可能（pluggable）となるよう開発する方針に落ち着きました。つまり、Docker Swarm が利用するスケジューリングのバックエンドとは、任意に置き換え可能であるのを意味します。Swarm の取り替え可能な設計により、多くの場面でスムーズかつ独創的な体験を提供します。また、Mesos のような、より強力なバックエンドに取り替えれば、大規模なプロダクション（本番環境）へのデプロイも可能となります。

.. Understand Swarm cluster creation

.. _understand-swarm-cluster-creation:

Swarm クラスタ作成を理解
==============================

.. The first step to creating a Swarm cluster on your network is to pull the Docker Swarm image. Then, using Docker, you configure the Swarm manager and all the nodes to run Docker Swarm. This method requires that you:

自分のネットワーク上で Swarm クラスタ（訳注；"Swarm"=群れ、の意味）を形成するには、まず Docker Swarm イメージを取得します。それから Docker で Swarm マネージャを設定し、Docker Swarm を実行したい全てのノードを設定します。この作業には以下の手順が必要です。

..    open a TCP port on each node for communication with the Swarm manager
    install Docker on each node
    create and manage TLS certificates to secure your cluster

* Swarm マネージャと各々のノードと通信ができるよう TCP ポートを開く
* 各々のノードに Docker をインストールする
* クラスタを安全にするため、TLS 証明書を作成・管理する

.. As a starting point, the manual method is best suited for experienced administrators or programmers contributing to Docker Swarm. The alternative is to use docker-machine to install a cluster.

管理者が経験を積むため、あるいはプログラマが Docker Swarm に貢献するために、手動でのインストールは最適な方法です。あるいは、``docker-machine`` を使って Swarm をインストールする方法もあります。

.. Using Docker Machine, you can quickly install a Docker Swarm on cloud providers or inside your own data center. If you have VirtualBox installed on your local machine, you can quickly build and explore Docker Swarm in your local environment. This method automatically generates a certificate to secure your cluster.

Docker Machine を使えば、Docker Swarm をクラウド・プロバイダや自分のデータセンタに素早くインストールできます。ローカルのマシン上に VirtualBox をインストールしていれば、ローカル環境上で Docker Swarm を素早く構築し、試すことができます。Docker Machine はクラスタを安全にするために、証明書を自動生成します。

.. Using Docker Machine is the best method for users getting started with Swarm for the first time. To try the recommended method of getting started, see Get Started with Docker Swarm.

初めて Docker Swarm を使うのであれば、Docker Machine を使う方法が一番です。推奨する方法で進めるには、 :doc:`install-w-machine` をお読みください。

.. If you are interested manually installing or interested in contributing, see Build a Swarm cluster for production.

手動でのインストールや開発に対する貢献に興味があれば、 :doc:`install-manual` をご覧ください。

.. Discovery services

.. _discovery-services:

ディスカバリ・サービス
==============================

.. To dynamically configure and manage the services in your containers, you use a discovery backend with Docker Swarm. For information on which backends are available, see the Discovery service documentation.

コンテナ内のサービスを動的に設定・管理するには、Docker Swarm とディスカバリ用のバックエンドを使います。利用可能なバックエンドに関する情報は、:doc:`ディスカバリ・サービスのドキュメント </swarm/discovery>` をお読みください。

.. Advanced Scheduling

.. _advanced-scheduling:

高度なスケジューリング
==============================

.. To learn more about advanced scheduling, see the strategies and filters documents.

高度なスケジューリングについては、:doc:`strategies（ストラテジ） </swarm/scheduler/strategy>`  と :doc:`filters（フィルタ） </swarm/scheduler/filter>` の各ドキュメントをお読みください。

.. Swarm API

Swarm API
==============================

.. The Docker Swarm API is compatible with the Docker remote API, and extends it with some new endpoints.

:doc:`Docker Swarm API </swarm/swarm-api>` は :doc:`Docker リモート API </engine/reference/api/docker_remote_api>` と互換性があります。そのため、新しいエンドポイントの追加時には、Swarm も同時にエンドポイントを拡張します。

.. Getting help

ヘルプを得るには
====================

.. Docker Swarm is still in its infancy and under active development. If you need help, would like to contribute, or simply want to talk about the project with like-minded individuals, we have a number of open channels for communication.

Docker Swarm はまだ開発途上であり、活発に開発中です。ヘルプが必要な場合、貢献したい場合、あるいはプロジェクトの同志と対話したい場合のため、私たちは多くのコミュニケーションのためのチャンネルを開いています。

..    To report bugs or file feature requests: please use the issue tracker on Github.

* バグ報告や機能リクエストは、 `GitHub の issue トラッカー <https://github.com/docker/swarm/issues>`_ をご利用ください。

..    To talk about the project with people in real time: please join the #docker-swarm channel on IRC.

* プロジェクトのメンバとリアルタイムに会話したければ、IRC の ``#docker-swarm`` チャンネルにご参加ください。

..     To contribute code or documentation changes: please submit a pull request on Github.

* コードやドキュメントの変更に貢献したい場合は、`GitHub でプルリクエスト <https://github.com/docker/swarm/pulls>`_ をお送りください。

.. For more information and resources, please visit the Getting Help project page.

より詳細な情報やリソースについては、私たちの `ヘルプ用ページ <https://docs.docker.com/project/get-help/>`_ をご覧ください。

.. seealso:: 

   Docker Swarm overview
      https://docs.docker.com/swarm/overview/
