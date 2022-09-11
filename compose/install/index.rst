.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/install/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/install.md
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/install.md
   doc version: v20.10
      https://github.com/docker/docker.github.io/blob/master/compose/install/index.md
.. check date: 2022/07/15
.. Commits on Jun 10, 2022 0dd93e250ed1aa2b9f4a18c34d0f39813d3c02ac
.. -------------------------------------------------------------------

.. Install Docker Compose
.. _install-docker-compose:

=======================================
Docker Compose のインストール
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:


.. On this page you can find a summary of the available options for installing Docker Compose.

このページでは、 Docker Compose をインストールするために、利用できる選択肢の概要が分かります。

.. Compose prerequisites
.. _compose-prerequisites:
Compose 動作条件
====================

..  Docker Compose requires Docker Engine.
    Docker Compose plugin requires Docker CLI.

* Docker Compose は Docker Engine が必要です。
* Docker Compose プラグインは Docker CLI が必要です。

.. Compose installation scenarios
.. _compose-installation-scenarios:
Compose インストールのシナリオ
========================================

.. You can run Compose on macOS, Windows, and 64-bit Linux. Check what installation scenario fits your needs.

Compose は macOS、Windows、64 ビット Linux で実行できます。必要に適うインストール手順を確認してください。

.. Are you looking to:

何を目指していますか：

..    Get latest Docker Compose and its prerequisites: Install Docker Desktop for your platform. This is the fastest route and you get Docker Engine and Docker CLI with the Compose plugin. Docker Desktop is available for Mac, Windows and Linux.

* **最新の Docker Compose と動作条件を得る** ： :doc:`自分のプラットフォームに対応した Docker Desktop をインストールします <compose-desktop>` 。これは最も速い手段で、Docker Engine と Compose プラグイン対応の Docker CLI を得られます。Docker Desktop は Mac、Windows、Linux で利用できます。

..    Install Compose plugin:
        (Mac, Win, Linux) Docker Desktop: If you have Desktop installed then you already have the Compose plugin installed.
        Linux systems: To install the Docker CLI’s Compose plugins use one of these methods of installation:
            Using the convenience scripts offered per Linux distro from the Engine install section.
            Setting up Docker’s repository and using it to install the compose plugin package.
            Other scenarios, check the Linux install.
        Windows Server: If you want to run the Docker daemon and client directly on Microsoft Windows Server, follow the Windows Server install instructions.

* **Compose プラグインのインストール** ：

  * **（Mac、Win、Linux）Docker Desktop** ：Desktop がインストール済みの場合、既に Compose プラグインを導入済みです。
  * **Linux システム** ：Docker CLI の Compose プラグインをインストールするには、3つのインストール方法のいずれかを使います：
  
    * Docker Engine インストールのセクションから、 Linux ディストリビューションに対応した :ref:`便利なスクリプト <engine-install-server>` を使う
    * :ref:`Docker のリポジトリをセットアップ <install-using-the-repository>` し、これを使って compose プラグインのパッケージをインストール
    * ほかのシナリオは、 :ref:`Linux インストール <installing-compose-on-linux-systems>` を確認

  * **Windows Server** ：Microsoft Windows Server 上で Docker デーモンとクライアントを直接実行したい場合は、 :ref:`Windows Server インストール手順 <install-compose-on-windows-server>` をご覧ください。


.. Where to go next

次は何を読みますか
==================

.. 
    Getting Started
    Command line reference
    Compose file reference
    Sample apps with Compose

* :doc:`../gettingstarted`
* :doc:`コマンドライン リファレンス </reference/index>`
* :doc:`Compose ファイル リファレンス <../compose-file/index>`
* :doc:`Compose のサンプルアプリ <../samples-for-compose>`

.. seealso:: 

   Install Docker Compose
      https://docs.docker.com/compose/install/
