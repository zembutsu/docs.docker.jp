.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/index.md
.. check date: 2022/09/30
.. Commits on Sep 26, 2020 6bc02b4c398cae9ee6a9392f313be37d5af1c0e1
.. -----------------------------------------------------------------------------

.. Docker Engine overview
.. _docker-engine-overview:

=======================================
Docker Engine 概要
=======================================

.. sidebar:: 目次

   .. contents::
       :depth: 3
       :local:

.. Docker Engine is an open source containerization technology for building and containerizing your applications. Docker Engine acts as a client-server application with:

:ruby:`Docker Engine <ドッカーエンジン>` は、アプリケーションを構築して :ruby:`コンテナ化 <containerizing>` するためのオープンソースの :ruby:`コンテナ化技術 <containerization technology>` です。

..  A server with a long-running daemon process dockerd.
    APIs which specify interfaces that programs can use to talk to and instruct the Docker daemon.
    A command line interface (CLI) client docker.

* サーバと共に長期間稼動する ``dockerd`` デーモンプロセス
* API は、プログラムがDocker デーモンと対話や命令するために使えるインタフェースを指定する
* コマンドラインインターフェース（CLI）クライアント ``docker`` 

.. The CLI uses Docker APIs to control or interact with the Docker daemon through scripting or direct CLI commands. Many other Docker applications use the underlying API and CLI. The daemon creates and manage Docker objects, such as images, containers, networks, and volumes.

CLI は :doc:`Docker API <api/index>` を使い、スクリプトや直接 CLI コマンドを通して Docker デーモンの制御や対話をします。他の Docker アプリケーションをの多くが、基礎となる API と CLI を使います。デーモンはイメージ、コンテナ、ネットワーク、ボリュームといった Docker オブジェクトの作成と管理をします。

.. For more details, see Docker Architecture.

詳細は :ref:`Docker アーキテクチャ <docker-architecture>` をご覧ください。

.. Docker user guide
.. _docker-user-guide:

Docker ユーザガイド
====================

.. To learn about Docker in more detail and to answer questions about usage and implementation, check out the overview page in “get started”.

Docker の詳細を学ぶには、また、使い方や実装についての疑問を解消するには、 :doc:`導入ガイドの概要ページ </get-started/overview>` をご覧ください。

.. Installation guides
.. _engine-installation-guides:

インストールガイド
====================

.. The installation section shows you how to install Docker on a variety of platforms.


:doc:`インストールのセクション </engine/install/index>` では、さまざまなプラットフォームに Docker をインストール方法を説明します。

.. Release note
.. _engine-release-note:

リリースノート
====================

.. A summary of the changes in each release in the current series can now be found on the separate Release Notes page

各リリースにおける変更点の概要については、 :doc:`リリース ノートの各ページ <release-notes>` をご確認ください。

.. Feature deprecation policy
.. _engine-feature-deprecation-policy:

機能廃止に関する方針
====================

.. As changes are made to Docker there may be times when existing features need to be removed or replaced with newer features. Before an existing feature is removed it is labeled as “deprecated” within the documentation and remains in Docker for at least 3 stable releases unless specified explicitly otherwise. After that time it may be removed.

Docker の機能変更に際しては、既存機能を削除したり新たな機能に置き換えたりする必要があった場合には、時間をおくことが必要になります。既存機能を削除するにあたっては、ドキュメント内に 「deprecated」（廃止予定）とラベル付けするようにします。そして Docker モジュール内には、最低でも３つの安定版がリリースされる間は残すようにします。この期間を過ぎたものは削除されることがあります。

.. Users are expected to take note of the list of deprecated features each release and plan their migration away from those features, and (if applicable) towards the replacement features as soon as possible.

ユーザは最新リリースごとに、廃止予定の機能一覧を注意して見ていく必要があります。最新版への移行にあたっては、廃止予定の機能は使わないようにして、（適用可能であれば）できるだけ早くに代替機能を用いるようにしてください。

.. The complete list of deprecated features can be found on the Deprecated Features page.

廃止予定の機能一覧については、:doc:`廃止予定機能のページ </engine/deprecated>` を確認してください。

.. Licensing
.. _engine-licensing:

ライセンス
====================

.. Docker is licensed under the Apache License, Version 2.0. See LICENSE for the full license text.

Docker のライセンスは Apache License, Version 2.0 です。ライセンス条項の詳細は  `LICENSE <https://github.com/moby/moby/blob/master/LICENSE>`_ を確認してください。

.. seealso::

   Docker Engine overview
      https://docs.docker.com/engine/
