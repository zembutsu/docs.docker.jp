.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/desktop/
   doc version: 19.03
      https://github.com/docker/docker.github.io/blob/master/desktop/index.md
.. check date: 2020/06/03
.. Commits on May 1, 2020 ba7819fed679f4f2542c3ccfe15bc9bc2d74ee3d
.. -----------------------------------------------------------------------------

.. Docker Desktop overview

.. _docker-desktop-overview:

=======================================
Docker Desktop 概要
=======================================

.. sidebar:: 目次

   .. contents::
       :depth: 3
       :local:

.. Docker Desktop is an easy-to-install application for your Mac or Windows environment that enables you to build and share containerized applications and microservices. Docker Desktop includes Docker Engine, Docker CLI client, Docker Compose, Notary, Kubernetes, and Credential Helper.

Docker Desktop（ドッカー・デスクトップ）は、Mac や Windows 環境において、インストールが簡単なアプリケーションであり、コンテナ化したアプリケーションとマイクロサービスの構築と共有が簡単になります。Docker Desktop には :doc:`Docker Engine </engine/index>`、 Docker CLI クライアント、:doc:`Docker Compose </compose/index>`、:doc:`Notary </notary/getting_started>`、`Kubernetes <https://github.com/kubernetes/kubernetes/>`_、`Credential Helper（資格情報の管理を支援するツール） <https://github.com/docker/docker-credential-helpers/>`_ を含みます。

.. Docker Desktop works with your choice of development tools and languages and gives you access to a vast library of certified images and templates in Docker Hub. This enables development teams to extend their environment to rapidly auto-build, continuously integrate and collaborate using a secure repository.

Docker Desktop は任意の開発ツールや言語と連携しながら、 `Docker Hub <https://hub.docker.com/>`_ 上にある、認定イメージとテンプレートの巨大なライブラリにアクセスできるようにします。これにより、開発チームは環境を拡張したり、素早い自動ビルドをしたり、継続的インテグレーションや、安全なリポジトリを用いた共同作業が可能になります。

.. Some of the key features of Docker Desktop include:

Docker Desktop に含まれる主要な機能は以下の通りです：

..    Ability to containerize and share any application on any cloud platform, in multiple languages and frameworks
    Easy installation and setup of a complete Docker development environment
    Includes the latest version of Kubernetes
    Automatic updates to keep you up to date and secure
    On Windows, the ability to toggle between Linux and Windows Server environments to build applications
    Fast and reliable performance with native Windows Hyper-V virtualization
    Ability to work natively on Linux through WSL 2 on Windows machines
    Volume mounting for code and data, including file change notifications and easy access to running containers on the localhost network
    In-container development and debugging with supported IDEs

* あらゆるクラウド・プラットフォーム上で、あらゆる言語やフレームワークを用いる、あらゆるアプリケーションのコンテナ化と共有を可能にする
* 簡単なインストールで、完全な Docker 開発環境をセットアップする
* Kubernetes の最新バージョンを含む
* 自動更新によって、最新版かつ安全性を保つ
* Windows では、アプリケーション構築のために Linux と Windows Server 環境を相互に切り替え可能
* ネイティブな Windows Hyper-V 仮想化によって、高速かつ信頼できるパフォーマンス
* Windows マシン上の WSL 2 を通し、Linux 上でネイティブに動作する能力
* コードやデータをボリュームでマウントする場合は、ファイル変更の通知を含み、ローカルホスト・ネットワーク上で実行中のコンテナと簡単に接続
* サポートしている統合開発環境を用い、コンテナ内での開発やデバッグ

.. Download and install

.. _desktop-download-and-install:

ダウンロードとインストール
=================================================

.. Docker Desktop is available for Mac and Windows. For download information, system requirements, and installation instructions, see:

Docker Desktop は Mac と Windows で利用できます。ダウンロード情報、システム要件、インストール手順は、以下をご覧ください。

..    Install Docker Desktop on Mac
    Install Docker Desktop on Windows

* :doc:`Mac に Docker Desktop をインストールする </docker-for-mac/index>`
* :doc:`Windows に Docker Desktop をインストールする </docker-for-windows/index>`


.. Get started

.. _desktop-get-started:


使い始めよう
===================

.. For information on how to get to get started with Docker Desktop and to learn about various UI options and their usage, see:

Docker Desktop の始め方と、様々なユーザーインターフェースのオプションや使い方について学ぶには、こちらをご覧ください。

..    Get started with Docker Desktop on Mac
    Get started with Docker Desktop on Windows

* :doc:`Mac で Docker Desktop を使い始める </docker-for-mac/index>`
* :doc:`Windows で Docker Desktop を使い始める </docker-for-windows/index>`


.. _desktop-stable-and-edge-versions:

.. Stable and Edge versions

Stable と Edge バージョン
=============================

.. Docker Desktop offers Stable and Edge download channels.

Docker Desktop には Stable（安定版）と Edge（エッジ）というダウンロードのチャンネル（選択肢）があります。

.. The Stable release provides a general availability release-ready installer for a fully baked and tested, more reliable app. The Stable version of Docker Desktop includes the latest released version of Docker Engine. The release schedule is synced every three months for major releases, with patch releases to fix minor issues, and to stay up to date with Docker Engine as required. You can choose to opt out of the usage statistics and telemetry data on the Stable channel.

Stable リリースは、一般的に利用可能に達したリリースのインストーラを提供しており、多くのアプリケーションが動作するよう、テスト済みかつ完成したものです。Docker Desktop の Stable バージョンには Docker Engine の最新リリース版を含みます。リリース期間は3ヶ月ごとにメジャーリリースがあり、Docker Engine を最新版に保つために必要な、小さな問題を解決するパッチリリースを含みます。Stable チャンネルでは、利用統計情報や遠隔情報の免除（オプトアウト）を選択できます。

.. Docker Desktop Edge release is our preview version. It offers an installer with the latest features and comes with the experimental features turned on. When using the Edge release, bugs, crashes, and issues can occur as the new features may not be fully tested. However, you get a chance to preview new functionality, experiment, and provide feedback as Docker Desktop evolves. Edge releases are typically more frequent than Stable releases. Telemetry data and usage statistics are sent by default on the Edge version.

Docker Desktop Edge リリースは、私たちのプレビュー版です。ほとんどの場合、インストーラに含むのは、最新機能や将来に向けた実験的な機能を有効化したものです。Edge リリースの利用にあたっては、新機能が完全にはテストされていないため、バグ、クラッシュ、何らかの問題を引き起こす可能性があります。しかしながら、新しい機能や体験をプレビューする機会が得られ、Docker Desktop の改善に向けたフィードバックも提供できます。Edge リリースは一般的に Stable リリースよりも頻繁です。Edge バージョンでは、デフォルトで遠隔情報と利用統計情報が送信されます。

.. Release notes

.. _desktop-release-notes:

リリースノート
===================

.. For information about new features, improvements, and bug fixes in Docker Desktop Stable releases, see:

Docker Desktop Stable リリースの新機能、改善、バグ修正に関する情報は、こちらをご覧ください：

..    Docker Desktop for Mac Stable Release notes
    Docker Desktop for Windows Stable Release notes

* `Docker Desktop for Mac Stable リリースノート（英語） <https://docs.docker.com/docker-for-mac/release-notes/>`_
* `Docker Desktop for Windows Stable リリースノート（英語） <https://docs.docker.com/docker-for-windows/release-notes/>`_

.. For information about new features, improvements, and bug fixes in Docker Desktop Edge releases, see:

Docker Desktop Edge リリースの新機能、改善、バグ修正に関する情報は、こちらをご覧ください：

..    Docker Desktop for Mac Edge Release notes
    Docker Desktop for Windows Edge Release notes

* `Docker Desktop for Mac Edge リリースノート（英語） <https://docs.docker.com/docker-for-mac/edge-release-notes/>`_
* `Docker Desktop for Windows Edge リリースノート（英語） <https://docs.docker.com/docker-for-windows/edge-release-notes/>`_

.. seealso::

   Docker Desktop overview
      https://docs.docker.com/desktop/
