.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/index.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/index.md
.. check date: 2016/07/09
.. Commits on Feb 3, 2016 c49b6ce4e16d570432941fc686c05939dc888fc9
.. -----------------------------------------------------------------------------

.. About Docker Engine

.. _about-docker-engine:

=======================================
Docker Engine について
=======================================

.. sidebar:: 目次

   .. contents::
       :depth: 3
       :local:

.. Develop, Ship and Run Any Application, Anywhere

**Develop, Ship and Run Any Application, Anywhere ～ あらゆるアプリケーションを、どこでも開発、移動、実行できるように**

.. Docker is a platform for developers and sysadmins to develop, ship, and run applications. Docker lets you quickly assemble applications from components and eliminates the friction that can come when shipping code. Docker lets you get your code tested and deployed into production as fast as possible.

`Docker <https://www.docker.com/>`_ とは、開発者やシステム管理者が、アプリケーションの開発、移動、実行するためのプラットフォームです。Docker は部品（コンポーネント）から迅速にアプリケーションを組み立てるため、コードの移動による摩擦を無くします。Docker はコードのテストやプロダクション（本番環境）に対する迅速な展開をもたらします。

.. Docker consists of:

Docker を構成するのは、次の２つです。

..     The Docker Engine - our lightweight and powerful open source container virtualization technology combined with a work flow for building and containerizing your applications.
..    Docker Hub - our SaaS service for sharing and managing your application stacks.

* Docker Engine （エンジン）… 私たちの軽量かつ強力なオープンソースによるコンテナ仮装化技術であり、アプリケーションの構築からコンテナ化に至るワークフローを連結します。
* `Docker Hub <https://hub.docker.com/>`_ … 皆さんのアプリケーション群を共有・管理する SaaS サービスです。

.. Why Docker?

なぜ Docker なのでしょうか？
==============================

.. Faster delivery of your applications

より速いアプリケーションの配信
----------------------------------------

..    We want your environment to work better. Docker containers, and the work flow that comes with them, help your developers, sysadmins, QA folks, and release engineers work together to get your code into production and make it useful. We’ve created a standard container format that lets developers care about their applications inside containers while sysadmins and operators can work on running the container in your deployment. This separation of duties streamlines and simplifies the management and deployment of code.

* 私たちは皆さんの環境を良くしたいのです。Docker コンテナと、そのワークフローにより、開発者、システム管理者、品質管理担当者、リリース・エンジニアが一緒になり、皆さんのコードをプロダクションに運ぶのを手伝い、使いやすくします。私たちが作成した標準コンテナ形式により、開発者はコンテナの中のアプリケーションに集中し、システム管理者やオペレータはコンテナのデプロイと実行が可能になります。この作業範囲の分割によって、コードの開発と管理を単純化します。

..    We make it easy to build new containers, enable rapid iteration of your applications, and increase the visibility of changes. This helps everyone in your organization understand how an application works and how it is built.

* 私たちは新しいコンテナを簡単に構築できるようにしました。これにより、アプリケーションの迅速な逐次投入や、変更の視認性を高めます。この機能は、皆さんの組織における誰もが、アプリケーションをどのように構築し、どのように動作するのかを理解する手助けとなるでしょう。

..    Docker containers are lightweight and fast! Containers have sub-second launch times, reducing the cycle time of development, testing, and deployment.

* Docker コンテナは軽量かつ高速です！　コンテナの起動時間は数秒であり、開発・テスト・デプロイのサイクルにかかる時間を減らします。

.. Deploy and scale more easily

デプロイやスケールをもっと簡単に
----------------------------------------

..    Docker containers run (almost) everywhere. You can deploy containers on desktops, physical servers, virtual machines, into data centers, and up to public and private clouds.

* Docker コンテナは（ほとんど）どこでも動きます。コンテナのデプロイは、デスクトップでも、物理サーバでも、仮想マシンにもデプロイできます。それだけでなく、あらゆるデータセンタ、パブリック・クラウド、プライベート・クラウドにデプロイできます。

..    Since Docker runs on so many platforms, it’s easy to move your applications around. You can easily move an application from a testing environment into the cloud and back whenever you need.

* Docker は多くのプラットフォームで動作しますので、アプリケーション周辺の移動も簡単です。必要であればテスト環境上のアプリケーションを、クラウド環境でもどこでも簡単に移動できます。

..    Docker’s lightweight containers also make scaling up and down fast and easy. You can quickly launch more containers when needed and then shut them down easily when they’re no longer needed.

* また、Docker の軽量コンテナは、スケールアップやスケールダウンを速く簡単にします。必要であれば迅速に多くのコンテナを起動できますし、必要がなくなれば簡単に停止できます。


.. Get higher density and run more workloads

より高い密度で多くの仕事量を
------------------------------

..    Docker containers don’t need a hypervisor, so you can pack more of them onto your hosts. This means you get more value out of every server and can potentially reduce what you spend on equipment and licenses.

* Docker コンテナはハイパーバイザーが不要なため、ホスト上により多くを集約できます。つまり、各サーバの価値をより高め、機材やライセンスの消費を減らせる可能性があります。

.. Faster deployment makes for easier management

デプロイの高速化による管理の簡易化
----------------------------------------

..    As Docker speeds up your work flow, it gets easier to make lots of small changes instead of huge, big bang updates. Smaller changes mean reduced risk and more uptime.

* Docker がもたらすワークフローの高速化は、小さな変更だけでなく、大規模アップデートに至るまでをも簡単にします。小さな変更とは、更新時におけるリスク（危険性）の減少を意味します。

.. About this guide

このガイドについて
====================

.. The Understanding Docker section will help you:

:doc:`Docker のアーキテクチャ </engine/understanding-docker>` は、次の理解を助けます。

..    See how Docker works at a high level
    Understand the architecture of Docker
    Discover Docker’s features;
    See how Docker compares to virtual machines
    See some common use cases.

* Docker がハイレベルでどのように動作するのか
* Docker アーキテクチャの理解
* Docker の機能確認
* Docker と仮想化の違いを知る
* 一般的な使い方を知る

.. Installation guides

インストールガイド
--------------------

.. The installation section will show you how to install Docker on a variety of platforms.

:doc:`インストールのセクション </engine/installation/index>` では、様々なプラットフォームに対する Docker のインストール方法を理解します。

.. Docker user guide

Docker ユーザガイド
--------------------

.. To learn about Docker in more detail and to answer questions about usage and implementation, check out the Docker User Guide.

Docker の詳細を学び、使い方や実装に関する疑問を解消するには、 :doc:`Docker Engine ユーザガイド </engine/userguide/index>` をご確認ください。


.. Release note

リリースノート
====================

.. A summary of the changes in each release in the current series can now be found on the separate Release Notes page

各リリースにおける変更点の概要については、 `リリース・ノートの各ページ <https://docs.docker.com/release-notes>`_ をご確認ください。

.. Feature deprecation policy

機能廃止ポリシー
====================

.. As changes are made to Docker there may be times when existing features will need to be removed or replaced with newer features. Before an existing feature is removed it will be labeled as “deprecated” within the documentation and will remain in Docker for, usually, at least 2 releases. After that time it may be removed.

Docker の各バージョンにおいて、既存機能の削除や、新しい機能に置き換わる変更が生じる可能性があります。既存の機能を削除する前に、ドキュメントの中で "deprecated"（廃止予定）とラベル付けするようにします。通常、少なくとも２つのリリースがされるまで残し、その後、削除します。

.. Users are expected to take note of the list of deprecated features each release and plan their migration away from those features, and (if applicable) towards the replacement features as soon as possible.

利用者は、廃止予定の機能に関しては、リリースごとに注意をお払いください。機能の変更が分かった場合は、可能な限り速く（適切な）移行をお願いします。

.. The complete list of deprecated features can be found on the Deprecated Features page.

廃止機能の一覧リストについては、:doc:`廃止機能のページ </engine/deprecated>` をご覧ください。

.. Licensing

使用許諾
====================

.. Docker is licensed under the Apache License, Version 2.0. See LICENSE for the full license text.

Docker の使用許諾（ライセンス）は Apache License, Version 2.0 です。使用許諾条項の詳細は  `LICENSE <https://github.com/docker/docker/blob/master/LICENSE>`_ をご覧ください。

.. seealso::

   About Docker Engine
      https://docs.docker.com/engine/
