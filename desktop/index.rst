.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/desktop/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/desktop/index.md
.. check date: 2022/05/04
.. Commits on Apr 13, 2022 ec5dc89d85debe81c04d5d84a10d881391c6824c
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

.. 
    Update to the Docker Desktop terms
    Commercial use of Docker Desktop in larger enterprises (more than 250 employees OR more than $10 million USD in annual revenue) now requires a paid subscription. The grace period for those that will require a paid subscription ends on January 31, 2022. Learn more.

.. important:: **Docker Desktop の利用条件変更**

   現在、大企業（従業員が 251 人以上、または、年間収入が 1,000 万米ドル以上 ）における Docker Desktop の商用利用には、有料サブスクリプション契約が必要です。必要な有料サブスクリプションの支払猶予は 2022 年 1 月 31 日に終了しました。 `詳細はこちらです。 <https://www.docker.com/blog/the-grace-period-for-the-docker-subscription-service-agreement-ends-soon-heres-what-you-need-to-know/>`_

.. Docker Desktop is an easy-to-install application for your Mac or Windows environment that enables you to build and share containerized applications and microservices. Docker Desktop includes Docker Engine, Docker CLI client, Docker Compose, Docker Content Trust, Kubernetes, and Credential Helper.

:ruby:`Docker Desktop <ドッカー デスクトップ>` は、Mac や Windows 環境において、インストールが簡単なアプリケーションであり、コンテナ化したアプリケーションとマイクロサービスの構築と共有が簡単になります。Docker Desktop には :doc:`Docker Engine </engine/index>`、 Docker CLI クライアント、:doc:`Docker Compose </compose/index>`、:doc:`Docker コンテント トラスト </engine/security/trust>`、`Kubernetes <https://github.com/kubernetes/kubernetes/>`_、`Credential Helper（資格情報の管理を支援するツール） <https://github.com/docker/docker-credential-helpers/>`_ を含みます。

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

* :doc:`Mac に Docker Desktop をインストールする </desktop/mac/install>`
* :doc:`Windows に Docker Desktop をインストールする </desktop/windows/install>`

.. For information about Docker Desktop licensing, see Docker Desktop License Agreement.

Docker Desktop のライセンスに関する情報は、 :ref:`Docker Desktop License Agreement（使用許諾契約） <docker-desktop-license-agreement>` をご覧ください。

.. Sign in to Docker Desktop
.. _sign-in-to-docker-desktop:
Docker Desktop にサインイン
==============================

.. After you’ve successfully installed and started Docker Desktop, we recommend that you authenticate using the Sign in/Create ID option from the Docker menu.

Docker Desktop のインストールと起動に成功したあとは、Docker メニューにある **Sign in/Create ID** （サインイン/ID作成）を使った認証を推奨します。

.. Authenticated users get a higher pull rate limit compared to anonymous users. For example, if you are authenticated, you get 200 pulls per 6 hour period, compared to 100 pulls per 6 hour period per IP address for anonymous users. For more information, see Download rate limit.

認証済みの利用者は、匿名利用者に比べて :ruby:`pull 率制限 <pull rate limit>` が高くなります。たとえば、認証済みであれば、６時間あたり 200 回の pull を実行できます。一方の匿名利用者であれば、 IP アドレスごとに６時間あたり 100 回の pull です。詳しい情報は :doc:`ダウンロード率制限 </docker-hub/download-rate-limit>` をご覧ください。

.. In large enterprises where admin access is restricted, administrators can create a registry.json file and deploy it to the developers’ machines using a device management software as part of the Docker Desktop installation process. Enforcing developers to authenticate through Docker Desktop also allows administrators to set up guardrails using features such as Image Access Management which allows team members to only have access to Trusted Content on Docker Hub, and pull only from the specified categories of images. For more information, see Configure registry.json to enforce sign in.

大きな企業で管理者がアクセスを制限している場合は、管理者が ``registry.json`` ファイルを作成しておき、 Docker Desktop のインストール手順の一部として、デバイス管理ソフトウェア使い、開発者のマシンにそのファイルをデプロイできます。開発者に Docker Desktop を通した認証を強制すると、 :doc:`イメージアクセス管理（Image Access Management） </docker-hub/image-access-management>` のような機能を使い、ガードレールをセットアップできます。これは、チームメンバのみが Docker Hub 上の信頼できるコンテンツにアクセスできるようにし、指定されたカテゴリのイメージのみ取得できるようにします。詳しい情報は、 :doc:`registry.json の設定でサインインを強制 </docker-hub/configure-sign-in>` をご覧ください。

.. Configure Docker Desktop
.. _configure-docker-desktop:
Docker Desktop の設定変更
==============================

.. To learn about the various UI options and their usage, see:

様々な UI オプションや使い方を学ぶには、以下をご覧ください。

..  Docker Desktop for Mac user manual
    Docker Desktop for Windows user manual

* :doc:`Docker Desktop for Mac 利用者マニュアル </desktop/mac/index>`
* :doc:`Docker Desktop for Windows 利用者マニュアル </desktop/windows/index>`

.. Release notes

.. _desktop-release-notes:

リリースノート
===================

.. For information about new features, improvements, and bug fixes in Docker Desktop releases, see:

Docker Desktop リリースの新機能、改善、バグ修正に関する情報は、こちらをご覧ください。

..    Docker Desktop for Mac Stable Release notes
    Docker Desktop for Windows Stable Release notes

* :doc:`Docker Desktop for Mac リリースノート </desktop/mac/release-notes>`
* :doc:`Docker Desktop for Windows リリースノート </desktop/windows/release-notes>`

.. seealso::

   Docker Desktop overview
      https://docs.docker.com/desktop/
