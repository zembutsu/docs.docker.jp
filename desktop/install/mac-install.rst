.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/desktop/install/mac-install/
   doc version: 19.03
      https://github.com/docker/docker.github.io/blob/master/docker-for-mac/install.md
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/desktop/install/mac-install.md
.. check date: 2022/09/09
.. Commits on Sep 7, 2022 cbbb9f1fac9289c0d2851584010559f8f03846f0
.. -----------------------------------------------------------------------------

.. |whale| image:: ./images/whale-x.png
      :scale: 50%

.. Install Docker Desktop on Mac
.. _install-docker-desktop-on-mac:

=======================================
Mac に Docker Desktop をインストール
=======================================

.. sidebar:: 目次

   .. contents::
       :depth: 3
       :local:

..
    Docker Desktop terms
    Commercial use of Docker Desktop in larger enterprises (more than 250 employees OR more than $10 million USD in annual revenue) requires a paid subscription.

.. note:: **Docker Desktop 利用条件**

   大企業（従業員が 251 人以上、または、年間収入が 1,000 万米ドル以上 ）における Docker Desktop の商用利用には、有料サブスクリプション契約が必要です。

.. Welcome to Docker Desktop for Mac. This page contains information about Docker Desktop for Mac system requirements, download URLs, instructions to install and update Docker Desktop for Mac.

Docker Desktop for Mac へようこそ。このページには、 Docker Desktop for Mac のシステム要件、ダウンロード URL 、Docker Desktop for Mac のインストールと更新の手順の情報を含みます。

.. note::

   **Docker Desktop for Mac のダウンロード**
   
   * `Intel チップの Mac <https://desktop.docker.com/mac/main/amd64/Docker.dmg>`_
   * `Apple チップの Mac <https://desktop.docker.com/mac/main/arm64/Docker.dmg>`_

.. For checksums, see Release notes

チェックサムについては、 :doc:`リリースノート <release-notes>` をご覧ください。

.. System requirements
.. _mac-system-requirements:

システム要件
====================

.. Your Mac must meet the following requirements to install Docker Desktop successfully.

Docker Desktop を正しくインストールするには、Mac が以下の要件を満たす必要があります。

.. Mac with Intel chip
.. _mac-with-intel-chip:
Intel チップの Mac
-------------------

..  macOS must be version 10.15 or newer. That is, Catalina, Big Sur, or Monterey. We recommend upgrading to the latest version of macOS.
    If you experience any issues after upgrading your macOS to version 10.15, you must install the latest version of Docker Desktop to be compatible with this version of macOS.

* **macOS バージョン 10.15 以上が必要です。** すなわち、 Catalina、Big Sur、Monterey です。macOS の最新バージョンへのインストールを私たちは推奨します。

  macOS をバージョン 10.15 に更新後、何らかの問題が起こった場合には、その macOS と互換性がある Docker Desktop 最新版をインストールしてください。

  ..      Note
        Docker supports Docker Desktop on the most recent versions of macOS. That is, the current release of macOS and the previous two releases. As new major versions of macOS are made generally available, Docker stops supporting the oldest version and supports the newest version of macOS (in addition to the previous two releases). Docker Desktop currently supports macOS Catalina, macOS Big Sur, and macOS Monterey.

  .. note::
     Docker は最新版 macOS 上での Docker Desktop をサポートします。言い換えると、macOS の現行リリースと、2つ前のリリースまでです。macOS の新しいメジャーバージョンが一般提供開始になった後、 Docker は古いバージョンのサポートを停止し、最新版 macOS のサポート（2つ前までのリリースを含みます）を開始します。 Docker Desktop が現在サポートしているのは、 macOS Catalina、macOS Big Sur、macOS Monterey です。

..    At least 4 GB of RAM.

* 最小 4GB の :ruby:`メモリ RAM`

..    VirtualBox prior to version 4.3.30 must not be installed as it is not compatible with Docker Desktop.

* Docker Desktop と互換性がないため、 VirtualBox 4.3.30 以上のインストールが必ずされていないこと

.. Mac with Apple silicon
.. _mac_with-applie-silicon:
Applie silicon の Mac
------------------------------

..  Beginning with Docker Desktop 4.3.0, we have removed the hard requirement to install Rosetta 2. There are a few optional command line tools that still require Rosetta 2 when using Darwin/AMD64. See the Known issues section. However, to get the best experience, we recommend that you install Rosetta 2. To install Rosetta 2 manually from the command line, run the following command:

* Docker Desktop 4.3.0 を始めるにあたり、 **Rosetta 2** をインストールするハードウェア要件を削除しました。これは Darwin/AMD64 で Rosetta 2 を使う時に、オプションでいくつかのコマンドラインツールで必要なものです。 :ref:`既知の問題 <apple-silicon-known-issues>` をご覧ください。ですが、最高の体験を得るために、 Rosetta 2 のインストールを推奨します。Roseta 2 を手動でインストールするには、コマンドラインで以下のコマンドを実行します。

  .. code-block:: bash

     $ softwareupdate --install-rosetta

.. For more information, see Docker Desktop for Apple silicon.

詳しい情報は、 :doc:`Applie silicon 用 Docker Desktop </desktop/mac/applie-cilicon>` をご覧ください。

.. Install and run Docker Desktop on Mac
.. _install-and-run-docker-desktop-on-mac:

Mac に Docker Desktop をインストールして動かす
==================================================

.. Install interactively
.. _mac-install-interactively:
対話形式でインストール
------------------------------

..    Double-click Docker.dmg to open the installer, then drag the Docker icon to the Applications folder.

1. ``Docker.dmg`` をダブルクリックし、インストーラを起動したら、アプリケーション フォルダに Docker アイコンをドラッグします。

   ..    Install Docker app

   .. image:: ./images/docker-app-drag-mac.png
      :scale: 60%
      :alt: Docker app のインストール

..    Double-click Docker.app in the Applications folder to start Docker. (In the example below, the Applications folder is in “grid” view mode.)

2. アプリケーション・フォルダ内にある ``Docker.app`` をダブルクリックし、 Docker を起動します（下図では、アプリケーション フォルダは「グリッド」表示モードです）。

   ..    Docker app in Hockeyapp

   .. image:: ./images/docker-app-in-apps-mac.png
      :scale: 60%
      :alt: アプリ一覧での Docker

.. The Docker menu (whale menu) displays the Docker Subscription Service Agreement window. It includes a change to the terms of use for Docker Desktop.

3. Docker メニュー（ |whale| ）は Docker :ruby:`サブスクリプション サービス使用許諾 <Subscription Service Agreement>` ウインドウを表示します。これには Docker Desktop の利用許諾変更の情報が加わっています。

   .. Here’s a summary of the key changes:
    Docker Desktop is free for small businesses (fewer than 250 employees AND less than $10 million in annual revenue), personal use, education, and non-commercial open source projects.
    Otherwise, it requires a paid subscription for professional use.
    Paid subscriptions are also required for government entities.
    The Docker Pro, Team, and Business subscriptions include commercial use of Docker Desktop.


    Our Docker Subscription Service Agreement includes a change to the terms of use for Docker Desktop
    It remains free for small businesses (fewer than 250 employees AND less than $10 million in annual revenue), personal use, education, and non-commercial open source projects.
    It requires a paid subscription for professional use in larger enterprises.
    The effective date of these terms is August 31, 2021. There is a grace period until January 31, 2022 for those that will require a paid subscription to use Docker Desktop.
    The existing Docker Free subscription has been renamed Docker Personal and we have introduced a Docker Business subscription .
    The Docker Pro, Team, and Business subscriptions include commercial use of Docker Desktop.

   要点の概要はこちらです：
   
   * Docker Desktop は、 :ruby:`中小企業 <small businesses>` （従業員 250 人未満、かつ、年間売上高が 1,000 万米ドル未満）、個人利用、教育、非商用オープンソースプロジェクトは無料です。
   * それ以外の場合は、サブスクリプションの支払が必要です。
   * 行政機関もサブスクリプションの支払が必要です。
   * Docker Pro、 Team、Business サブスクリプションには、 Docker Desktop の :ruby:`商業的利用 <commercial use>` を含みます。

.. Select Accept to continue. Docker Desktop starts after you accept the terms.

4. **Accept** をクリックすると続きます。使用許諾を承諾した後、 Docker Desktop は起動します。

   .. important::
   
      .. If you do not agree to the terms, the Docker Desktop application will close and you can no longer run Docker Desktop on your machine. You can choose to accept the terms at a later date by opening Docker Desktop.
      
      使用許諾に同意しなければ、 Docker Desktop アプリケーションは終了し、以後マシン上で Docker Dekstop を起動しないようようにします。後日、 Docker Desktop を開いた時、使用許諾を承諾するかどうか選択できます。

   .. For more information, see Docker Desktop Subscription Service Agreement. We recommend that you also read the FAQs.

   .. For more information, see Docker Desktop License Agreement. We recommend that you also read the Blog and FAQs to learn how companies using Docker Desktop may be affected.
   詳しい情報は、 `Docker Desktop Subscription Service Agreement（ Docker Desktop サブスクリプション サービス 使用許諾）`_ をご覧ください。また、 `FAQ <https://www.docker.com/pricing/faq>`_ を読むのもお勧めします。

.. Install from the command line
.. _mac-install-from-the-command-line:
コマンドラインからインストール
------------------------------

.. After downloading Docker.dmg, run the following commands in a terminal to install Docker Desktop in the Applications folder:

``Docker.dmg`` をダウンロード後、 Docker Desktop をインストールするには、アプリケーション フォルダ内のターミナルで、以下のコマンドを実行します。

.. code-block:: bash

   $ sudo hdiutil attach Docker.dmg
   $ sudo /Volumes/Docker/Docker.app/Contents/MacOS/install
   $ sudo hdiutil detach /Volumes/Docker

.. As macOS typically performs security checks the first time an application is used, the install command can take several minutes to run.

macOS では新しいアプリケーションを始めて使う時、たいていセキュリティ確認の処理があるため、 ``install`` コマンドを実行するには数分かかる場合があります。

.. The install command accepts the following flags:

``install`` コマンドは、以下のフラグに対応します。

..  --accept-license: accepts the Docker Subscription Service Agreement now, rather than requiring it to be accepted when the application is first run
    --allowed-org=<org name>: requires the user to sign in and be part of the specified Docker Hub organization when running the application
    --user=<username>: Runs the privileged helper service once during installation, then disables it at runtime. This removes the need for the user to grant root privileges on first run. For more information, see Privileged helper permission requirements. To find the username, enter ls /Users in the CLI.

* ``--accept-license`` ：アプリケーションの初回実行時に `Docker Subscription Service Agreement（ Docker サブスクリプション サービス 使用許諾）`_ の承諾を求めるのではなく、直ちに承諾する
* ``--allowed-org=<org name>`` ：アプリケーションの実行時に、指定した Docker Hub organization に所属するユーザとしてのサインインを必要とする
* ``--user=<username>`` ：インストール時には管理者としてログインしますが、以降の実行時に確認しません。これにより、ユーザが初回実行時だとしても、管理者権限を与える必要がありません。詳しい情報は :doc:`アクセス権の要求 </desktop/mac/permission-requirements>` をご覧ください。ユーザ名をさがすｒには、 CLI 上で ``ls /Users`` を入力します。


.. Updates
.. _mac-updates:
更新（アップデート）
====================

.. When an update is available, Docker Desktop displays an icon on the Docker menu to indicate the availability of a newer version. Additionally, the Software Updates section in Preferences (Settings on Windows) also notifies you of any updates available to Docker Desktop. You can choose to download the update right away, or click the Release Notes option to learn what’s included in the updated version.

更新が利用可能になると、 Docker Desktop は Docker メニューで新しいバージョンが利用可能になったと知らせてくれます。また、 **Preferences** （ Windows 版では **Settings** ）にある **Software Update** の部分からも、Docker Desktop の更新が利用可能だと分かります。直ちに更新をダウンロードするか、あるいは、 **Release Notes** （リリースノート）オプションで更新版で何が導入されたのか分かります。

.. Starting with Docker Desktop 4.2.0, the option to turn off the automatic check for updates is available for users on all Docker subscriptions, including Docker Personal and Docker Pro. For more information, see Software Updates.

Docker Desktop 4.2.0 以降、Docker Professional と Docker Pro を含むすべての Docker サブスクリプション利用者は、自動更新の有効化と無効化を選べるオプションが導入されています。詳しい情報は、 :ref:`ソフトウェア更新 <mac-software-updates>` をご覧ください。

.. Click Download update When you are ready to download the update. This downloads the update in the background. After downloading the update, click Update and restart from the Docker menu. This installs the latest update and restarts Docker Desktop for the changes to take effect.

ダウンロードと更新の準備が整っていれば、 **Download update** （更新のダウンロード）をクリックします。このダウンロードと更新はバックグラウンドで行います。更新のダウンロードが終われば、 Docker メニューから **Update and Restart** （更新と再起動）をクリックします。これで最新の更新版がインストールされ、Docker の再起動で変更が有効になります。

.. When Docker Desktop starts, it displays the Docker Subscription Service Agreement window. Read the information presented on the screen to understand how the changes impact you. Click the checkbox to indicate that you accept the updated terms and then click Accept to continue.

Docker Desktop を起動したら、Docker Subscription Service Agreement ウインドウが開きます。画面上に表示された情報を読み、どのような影響を受けるか確認します。更新された使用許諾を承諾する場合は、チェックボックスにクリックし、それから続けるには **Accept** をクリックします。

..  Important
    If you do not agree to the terms, the Docker Desktop application will close and you can no longer run Docker Desktop on your machine. You can choose to accept the terms at a later date by opening Docker Desktop.

.. important::

   使用許諾に同意しなければ、 Docker Desktop アプリケーションは終了し、以後マシン上で Docker Dekstop を起動しないようようにします。後日、 Docker Desktop を開いた時、使用許諾を承諾するかどうか選択できます。

.. Docker Desktop starts after you accept the terms.

使用許諾を承諾した後、 Docker Desktop が起動します。

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


.. Uninstall Docker Desktop from the command line

.. note::

   **コマンドラインから Docker Desktop をアンインストール** 

   .. To uninstall Docker Desktop from a terminal, run: <DockerforMacPath> --uninstall. If your instance is installed in the default location, this command provides a clean uninstall:
   ターミナルから Docker Desktop をアンインストールするには、 ``<DockerforMacのPath> --uninstall`` を実行します。実体がデフォルトの場所にインストールされていれば、次のコマンドでクリーンインストールできます。
   
   .. code-block:: bash
   
      $ /Applications/Docker.app/Contents/MacOS/Docker --uninstall
      Docker is running, exiting...
      Docker uninstalled successfully. You can move the Docker application to the trash.

   .. You might want to use the command-line uninstall if, for example, you find that the app is non-functional, and you cannot uninstall it from the menu.
   アプリケーションが機能しなくなり、メニューからアンインストールできなくなった場合に、コマンドラインでのアンインストールが必要になるでしょう。

.. Uninstalling Docker Desktop destroys Docker containers, images, volumes, and other Docker related data local to the machine, and removes the files generated by the application. Refer to the back up and restore data section to learn how to preserve important data before uninstalling.

.. note::

   Docker Desktop のアンインストールは、ローカルのマシンにある Docker コンテナ、イメージ、ボリューム、 Docker 関連のデータ破棄し、アプリケーションによって作成された全てのファイルも破棄します。アンインストール前に重要なデータを保持する方法については、 :doc:`バックアップと修復 </desktop/backup-and-restore>` を参照ください。


.. Where to go next

次はどこへ行きますか
==============================

..    Docker Desktop for Apple silicon for detailed information about Docker Desktop for Apple silicon.
    Troubleshooting describes common problems, workarounds, how to run and submit diagnostics, and submit issues.
    FAQs provide answers to frequently asked questions.
    Release notes lists component updates, new features, and improvements associated with Docker Desktop releases.
    Get started with Docker provides a general Docker tutorial.
    Back up and restore data provides instructions on backing up and restoring data related to Docker.

* :doc:`Docker Desktop for Apple silicon </desktop/mac/apple-silicon>` は、Apple silicon 用 Docker Desktop に関する詳細情報です。
* :doc:`トラブルシューティング </desktop/troubleshoot/overview>` は一般的な問題、回避方法、統計情報の送信方法、問題報告の仕方があります。
* :doc:`FAQs </desktop/faqs/general>` は、よく見受けられる質問と回答があります。
* :doc:`リリースノート </desktop/release-notes>` は Docker Desktop  リリースに関連する更新コンポーネント、新機能、改良の一覧があります。
* :doc:`Docker の始め方 </get-started/index>` は一般的な Docker チュートリアルです。
* :doc:`バックアップと修復 </desktop/backup-and-restore>` は Docker 関連データのバックアップと修復手順です。

.. seealso::

   Install Docker Desktop on Mac
      https://docs.docker.com/desktop/mac/install/
