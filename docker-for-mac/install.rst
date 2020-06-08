.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/docker-for-mac/install/
   doc version: 19.03
      https://github.com/docker/docker.github.io/blob/master/docker-for-mac/install.md
.. check date: 2020/06/08
.. Commits on May 19, 2020 8b6335e1460893df4a436b326280fead76569524
.. -----------------------------------------------------------------------------

.. Install Docker Desktop on Mac

.. _-nstall-docker-desktop-on-mac:

=======================================
Mac に Docker Desktop をインストール
=======================================

.. sidebar:: 目次

   .. contents::
       :depth: 3
       :local:

.. Docker Desktop for Mac is the Community version of Docker for Mac. You can download Docker Desktop for Mac from Docker Hub.

Docker Desktop for Mac は、Mac 用の Docker `コミュニティ <https://www.docker.com/community-edition>`_ 版です。Docker Desktop for Mac は Docker Hub からダウンロードできます。

.. Download from Docker Hub

* `Docker Hub からダウンロード <https://hub.docker.com/editions/community/docker-ce-desktop-mac/>`_

.. By downloading Docker Desktop, you agree to the terms of the Docker Software End User License Agreement and the Docker Data Processing Agreement.

Docker Desktop のダウンロード中に、 `Docker Software End User License Agreement <https://www.docker.com/legal/docker-software-end-user-license-agreement>`_ と `Docker Data Processing Agreement <https://www.docker.com/legal/data-processing-agreement>`_ に同意ください。

.. What to know before you install

.. _mac-what-to-know-before-you-install:

インストール前に知っておくこと
==============================


..    README FIRST for Docker Toolbox and Docker Machine users
    If you are already running Docker on your machine, first read Docker Desktop for Mac vs. Docker Toolbox to understand the impact of this installation on your existing setup, how to set your environment for Docker Desktop on Mac, and how the two products can coexist.

.. note::

   **Docker Toolbox と Docker Machine ユーザは一番初めにお読みください**

   既にマシン上で Docker を実行中の場合は、最初に :doc:`docker-toolbox` をご覧ください。こちらには、既存の環境にセットアップする時の影響、Docker Desktop on Mac をどのようにセットアップするか、両者を共存する方法があります。

.. Relationship to Docker Machine: Installing Docker Desktop on Mac does not affect machines you created with Docker Machine. You have the option to copy containers and images from your local default machine (if one exists) to the Docker Desktop HyperKit VM. When you are running Docker Desktop, you do not need Docker Machine nodes running locally (or anywhere else). With Docker Desktop, you have a new, native virtualization system running (HyperKit) which takes the place of the VirtualBox system. To learn more, see Docker Desktop for Mac vs. Docker Toolbox.

**Docker Machine への影響** ： Docker desktop を Mac にインストールしても、既に作成している Docker Machine には影響を与えません。オプションで、ローカルの :code:`default` （という名称の） Docker Machine （存在している場合）から、コンテナをイメージを Docker Desktop `HyperKit <https://github.com/docker/HyperKit/>`_ VM にコピーできます。Docker Desktop を起動したら、Docker Machine ノードをローカルで（あるいは、どこでも）実行する必要はありません。Docker Desktop があれば、VirtualBox システムを置き換えるので、新しいネイティブな仮想化システム（HyperKit）を実行します。詳細を学ぶには、  :doc:`docker-toolbox` をご覧ください。

.. System requirements

.. _mac-system-requirements:

システム要件
====================

.. Your Mac must meet the following requirements to successfully install Docker Desktop:

Docker Desktop を正しくインストールするには、Mac が以下の要件を満たす必要があります。

..    Mac hardware must be a 2010 or a newer model, with Intel’s hardware support for memory management unit (MMU) virtualization, including Extended Page Tables (EPT) and Unrestricted Mode. You can check to see if your machine has this support by running the following command in a terminal: sysctl kern.hv_support
..    If your Mac supports the Hypervisor framework, the command prints kern.hv_support: 1.

..    macOS must be version 10.13 or newer. That is, Catalina, Mojave, or High Sierra. We recommend upgrading to the latest version of macOS.
..    If you experience any issues after upgrading your macOS to version 10.15, you must install the latest version of Docker Desktop to be compatible with this version of macOS.

..    Note: Docker supports Docker Desktop on the most recent versions of macOS. That is, the current release of macOS and the previous two releases. Docker Desktop currently supports macOS Catalina, macOS Mojave, and macOS High Sierra.

..    As new major versions of macOS are made generally available, Docker stops supporting the oldest version and support the newest version of macOS (in addition to the previous two releases).

..    At least 4 GB of RAM.

..    VirtualBox prior to version 4.3.30 must not be installed as it is not compatible with Docker Desktop.

* **Mac ハードウェアは 2010 年モデルか、それ以降の必要があります** 。ハードウェアには、インテルのメモリ管理ユニット（MMU）仮想化のハードウェアサポート、EPT（Extended Page Tables）、Unrestricted モードを含みます。マシンがこれらをサポートしているかどうか調べたいときは、ターミナル上で以下のコマンドを実行して確認できます：:code:`sysctl kern.hv_support` 。  もしも Mac がハイパーバイザ・フレームワークをサポートしていれば、コマンドの実行結果に :code:`kern.hv_support: 1` が表示されます。
* **macOS は 10.13 または、それ以降の必要があります** 。つまり Catalina、Mojave、High Sierra です。私たちは macOS の最新版へのアップグレードを推奨します。  macOS をバージョン 10.05 にアップグレードして何らかの問題が出るようであれば、その macOS のバージョンと互換性がある最新の Docker Desktop のインストールが必要です。  **メモ**： Docker がサポートしている Docker Desktop は、最新バージョンの macOS です。言い換えれば、現在リリースされている macOS と、直前の2つのリリースです。Docker Desktop が現在サポートするのは、 macOS Catalina、macOS Mojave、macOS High Sierra です。  macOS の新しいメジャーバージョンが利用可能になれば、 Docker は最も古いバージョンのサポートを終了し、最も新しいバージョンの macOS （と、直近の2つのリリース）をサポートします。
* 最小 4GB の RAM
* VirtualBox バージョン 4.3.3 以前は、Docker Desktop と互換性がないのでインストールしてはいけません。

.. What’s included in the installer

.. _mac-whats-included-in-the-installer:

インストーラに含まれるもの
==============================

.. The Docker Desktop installation includes Docker Engine, Docker CLI client, Docker Compose, Notary, Kubernetes, and Credential Helper.

Docker Desktop のインストールに含まれるのは、 :doc:`Docker Engine </install>`  、 Docker CLI クライアント、  :doc:`Docker Compose </compose/overview>` 、  :doc:`Notary <https://docs.docker.com/notary/getting_started/>` 、  `Kubernetes <https://github.com/kubernetes/kubernetes/>`_  、`Credential Helper <https://github.com/docker/docker-credential-helpers/>`_ です。

.. Install and run Docker Desktop on Mac

.. _install-and-run-docker-desktop-on-mac:

Mac に Docker Desktop をインストールして動かす
==================================================

..    Double-click Docker.dmg to open the installer, then drag the Docker icon to the Applications folder.

1.　:code:`Docker.dmg` をダブルクリックし、インストーラを起動したら、アプリケーション・フォルダに Docker アイコンをドラッグします。

..    Install Docker app

..    Double-click Docker.app in the Applications folder to start Docker. (In the example below, the Applications folder is in “grid” view mode.)

2.　アプリケーション・フォルダ内にある `Docker.app` をダブルクリックし、 Docker を起動します（下図では、アプリケーション・フォルダは「グリッド」表示モードです）。

..    Docker app in Hockeyapp

..    The Docker menu in the top status bar indicates that Docker Desktop is running, and accessible from a terminal.

トップステータスバーにある Docker メニューで、Docker Desktop が実行中で、ターミナルからアクセスできるのが分かります。

..    Whale in menu bar

..    If you’ve just installed the app, Docker Desktop launches the onboarding tutorial. The tutorial includes a simple exercise to build an example Docker image, run it as a container, push and save the image to Docker Hub.

アプリのインストールが完了したら、Docker Desktop はオンボーディング（導入）・チュートリアルを開始します。チュートリアルには  Docker イメージを構築、実行し、Docker Hub にイメージを送信するまでの例を含みます。

..    Docker Quick Start tutorial

..    Click the Docker menu (whale menu) to see Preferences and other options.

3.　Docker メニュー（鯨のアイコン）をクリックし、 **Preferences**  （設定）と他のオプションをご覧ください。

..    Select About Docker to verify that you have the latest version.

4.　**About Docker**  （Docker について）を選択し、最新バージョンであることを確認します。

.. Congratulations! You are now successfully running Docker Desktop.

おめでとうございます！ 新しい Docker Desktop の実行に成功しました。

.. If you would like to rerun the tutorial, go to the Docker Desktop menu and select Learn.

チュートリアルに戻りたければ、 Docker Desktop のメニューから **Learn** （学ぶ）をクリックします。

.. Uninstall Docker Desktop

.. _mac-uninstall-docker-desktop:

Docker Desktop のアンインストール
========================================

.. To unistall Docker Desktop from your Mac:

Mac マシンから Docker Desktop をアンインストールするには、

..    From the Docker menu, select Troubleshoot and then select Uninstall.
    Click Uninstall to confirm your selection.

1. Docker メニューから **Troubleshoot** （トラブルシュート）を選択し、 **Uninstall** （アンインストール）を選択します。
2. 確認画面で、**Uninstall**  をクリックします。

..    Note: Uninstalling Docker Desktop will destroy Docker containers and images local to the machine and remove the files generated by the application.

.. note::

   Docker Desktop のアンインストールは、ローカルのマシンにある Docker コンテナのイメージを破棄し、アプリケーションによって作成された全てのファイルも破棄します。

.. Switch between Stable and Edge versions

.. _mac-switch-between-stable-and-edge-versions:

Stable と Edge バージョンの切り替え
========================================

.. Docker Desktop allows you to switch between Stable and Edge releases. However, you can only have one version of Docker Desktop installed at a time. Switching between Stable and Edge versions can destabilize your development environment, particularly in cases where you switch from a newer (Edge) channel to an older (Stable) channel.

Docker Desktop は、自分で Stable （安定版）リリースと Edge （最新）リリースを切り替え可能です。しかしながら、 **Docker Desktop を一度にインストールできるのは、1つのバージョンのみ** です。Stable と Edge 版のリリース切り替えるは、開発環境の安定性を損なう可能性があります。特に、新しい（Edge）チャンネルを古い（Stable）チャンネルに切り替える場合です。

.. For example, containers created with a newer Edge version of Docker Desktop may not work after you switch back to Stable because they may have been created using Edge features that aren’t in Stable yet. Keep this in mind as you create and work with Edge containers, perhaps in the spirit of a playground space where you are prepared to troubleshoot or start over.

例えば、 Docker Desktop の新しい Edge バージョンでコンテナを作成する場合、Stable に切り戻すと動作しなくなる可能性があります。これは、Edge の機能を使って作成したコンテナには、まだ Stable には反映されていない機能が用いられている場合があるからです。Edge コンテナで作成したり作業したりする場合には、留意し続けてください。

.. To safely switch between Edge and Stable versions, ensure you save images and export the containers you need, then uninstall the current version before installing another. For more information, see the section Save and Restore data below.

Edge と Stable バージョン間を安全に切り替えるには、必要に応じてイメージの保存（save）やコンテナの出力（export）を確実に行い、他のバージョンをインストールする前に、既存のバージョンをアンインストールします。詳しい情報については、以下にあるデータの保存と修復を御覧ください。

.. Save and restore data

.. _mac-save-and-restore-data:

データの保存と修復
--------------------

.. You can use the following procedure to save and restore images and container data. For example, if you want to switch between Edge and Stable, or to reset your VM disk:

以下の手順を用いて、イメージとコンテナのデータを保存・修復できます。例えば、Edge と Stable を切り替えたいときや、仮想マシンのディスクをリセットしたいときに用います。

..    Use docker save -o images.tar image1 [image2 ...] to save any images you want to keep. See save in the Docker Engine command line reference.

1.  :code:`docker save -o images.tar image1 [image2 ....]` を使い、保持したい全てのイメージを保存します。Docker Engine コマンドライン・リファレンスの :doc:`save </engine/reference/commandline/save>` セクションを御覧ください。

..    Use docker export -o myContainner1.tar container1 to export containers you want to keep. See export in the Docker Engine command line reference.

2.  :code:`docker export -o myContainer1.tar container` を使い、保持したい全てのコンテナをエクスポート（出力）します。Docker Engine コマンドライン・リファレンスの :doc:`export </engine/reference/commandline/export>` セクションを御覧ください。

..    Uninstall the current version of Docker Desktop and install a different version (Stable or Edge), or reset your VM disk.

3. 現在のバージョンの Docker Desktop をアンインストールし、異なるバージョン（Stable 又は Edge）をインストールし、仮想マシン・ディスクをリセットします。

..    Use docker load -i images.tar to reload previously saved images. See load in the Docker Engine.

4. :code:`docker load -i images.tar` を使い、以前に保存したイメージを再読み込みします。Docker Engine の  :doc:`load </engine/reference/commandline/load>` を御覧ください。

..    Use docker import -i myContainer1.tar to create a filesystem image corresponding to the previously exported containers. See import in the Docker Engine.

5. :code:`docker import -i myContainer1.tar` を使い、以前にエクスポートしたコンテナに対応するファイルシステム・イメージを作成します。Docker Engine の   :doc:`import </engine/reference/commandline/import>` を御覧ください。

.. For information on how to back up and restore data volumes, see Backup, restore, or migrate data volumes.

データ・ボリュームのバックアップと修復の仕方に関する情報は、 :ref:`backup-restore-or-migrate-data-volumes` を御覧ください。

.. Where to go next

次はどこへ行きますか
==============================

..    Getting started provides an overview of Docker Desktop on Mac, basic Docker command examples, how to get help or give feedback, and links to other topics about Docker Desktop on Mac.
    Troubleshooting describes common problems, workarounds, how to run and submit diagnostics, and submit issues.
    FAQs provide answers to frequently asked questions.
    Release notes lists component updates, new features, and improvements associated with Stable releases. For information about Edge releases, see Edge release notes.
    Get started with Docker provides a general Docker tutorial.

* :doc:`/docker-for-mac/index`  は Docker Desktop on Mac の概要と、基本的な Docker コマンドの例、ヘルプを得る方法やフィードバックの仕方、その他の Docker Desktop on Mac に関する記事があります。
* :doc:`troubleshoot` は一般的な問題、回避方法、統計情報の送信方法、問題報告の仕方があります。
* :doc:`faq` は、よく見受けられる質問と回答があります。
* :doc:`リリースノート <release-notes>` は Stable リリースに関連する更新コンポーネント、新機能、改良の一覧があります。Edge リリースに関する情報は :doc:`Edge リリースノート <edge-release-note>` をご覧ください。
* :doc:`Docker の始め方 </get-started/index>` は一般的な Docker チュートリアルです。



.. seealso::

   Install Docker Desktop on Mac
      https://docs.docker.com/docker-for-mac/install/
