.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/desktop/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/desktop/index.md
.. check date: 2022/09/09
.. Commits on Sep 9, 2022 da7436400ba700835c6cfe808c3a74364ac08fe6
.. -----------------------------------------------------------------------------

.. Docker Desktop
.. _docker-desktop:

=======================================
Docker Desktop 概要
=======================================

..
    Docker Desktop terms
    Commercial use of Docker Desktop in larger enterprises (more than 250 employees OR more than $10 million USD in annual revenue) requires a paid subscription.

.. note:: **Docker Desktop 利用条件**

   大企業（従業員が 251 人以上、または、年間収入が 1,000 万米ドル以上 ）における Docker Desktop の商用利用には、有料サブスクリプション契約が必要です。

.. Docker Desktop is an easy-to-install application for your Mac, Linux, or Windows environment that enables you to build and share containerized applications and microservices.

:ruby:`Docker Desktop <ドッカー デスクトップ>` は、Mac や Linux や Windows 環境において、インストールが簡単なアプリケーションであり、コンテナ化したアプリケーションとマイクロサービスの構築と共有が簡単になります。

.. It provides a simple interface that enables you to manage your containers, applications, and images directly from your machine without having to use the CLI to perform core actions.

Docker Desktop は、CLI を使って主要な処理を行わなくても、コンテナ、アプリケーション、イメージをマシン上から直接管理できる、シンプルなインターフェース（訳者注：プログラム間を接続する、橋渡しのような機能）を提供します。

   .. What's included in Docker Desktop?
   Docker Desktop に何が含まれますか？

      * :doc:`Docker Engine </engine/index>`
      * Docker CLI クライアント
      * :doc:`Docker Compose </compose/index>`
      * :doc:`Docker Content Trust </engine/security/trust/index>`
      * `Kubernetes <https://github.com/kubernetes/kubernetes/>`_
      * `Credential Helper <https://github.com/docker/docker-credential-helpers/>`_

   .. What are the key features of Docker Desktop?
   Docker Desktop の主な機能は何ですか？

..    Ability to containerize and share any application on any cloud platform, in multiple languages and frameworks
    Easy installation and setup of a complete Docker development environment
    Includes the latest version of Kubernetes
    On Windows, the ability to toggle between Linux and Windows Server environments to build applications
    Fast and reliable performance with native Windows Hyper-V virtualization
    Ability to work natively on Linux through WSL 2 on Windows machines
    Volume mounting for code and data, including file change notifications and easy access to running containers on the localhost network

      * あらゆるクラウド・プラットフォーム上で、あらゆる言語やフレームワークを用いる、あらゆるアプリケーションのコンテナ化と共有を可能にする
      * 簡単なインストールで、完全な Docker 開発環境をセットアップする
      * Kubernetes の最新バージョンを含む
      * Windows では、アプリケーション構築のために Linux と Windows Server 環境を相互に切り替え可能
      * ネイティブな Windows Hyper-V 仮想化によって、高速かつ信頼できるパフォーマンス
      * Windows マシン上の WSL 2 を通し、Linux 上でネイティブに動作する能力
      * コードやデータをボリュームでマウントする場合は、ファイル変更の通知を含み、ローカルホスト・ネットワーク上で実行中のコンテナと簡単に接続する

.. Docker Desktop works with your choice of development tools and languages and gives you access to a vast library of certified images and templates in Docker Hub. This enables development teams to extend their environment to rapidly auto-build, continuously integrate and collaborate using a secure repository.

Docker Desktop は任意の開発ツールや言語と連携しながら、 `Docker Hub <https://hub.docker.com/>`_ 上にある、認定イメージとテンプレートの巨大なライブラリにアクセスできるようにします。これにより、開発チームは環境を拡張したり、素早い自動ビルドをしたり、継続的インテグレーションや、安全なリポジトリを用いた共同作業が可能になります。


* :doc:`Docker Desktop のインストール <install>`

   * :doc:`Mac <install/mac-install>`
   * :doc:`Windows <install/windows-install>`
   * :doc:`Linux <install/linux-install>`

* :doc:`Docker Desktop を探る <use-desktop>`

   * Docker Desktop を操作し、主要な機能について学びます。

* :doc:`リリースノートの表示` 

   * 新機能、改良点、バグ修正を調べます。

* :doc:`一般的な FAQ を閲覧 <faq/general>` 

   * 一般的な FAQ や特定のプラットフォームに対する FAQ を表示します。

* :doc:`追加リソースを見つける <kubernetes>`

   * ネットワーク機能や Kubernetes 上へのデプロイ等の情報を見つけます。

* :doc:`フィードバックする <feedback>`

   * Docker Desktop や Docker Desktop 機能へのフィードバックをします。

.. seealso::

   Docker Desktop
      https://docs.docker.com/desktop/
