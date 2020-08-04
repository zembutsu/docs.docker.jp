.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/docker-for-windows/install-windows-home/
   doc version: 19.03
      https://github.com/docker/docker.github.io/blob/master/docker-for-mac/install.md
.. check date: 2020/06/11
.. Commits on Jun 9, 2020 32dc3b761857f445763b1732e1f6064f231ef180
.. -----------------------------------------------------------------------------

.. Install Docker Desktop on Windows Home

.. _install-docker-desktop-on-windows-home:

==================================================
Windows Home に Docker Desktop をインストール
==================================================

.. sidebar:: 目次

   .. contents::
       :depth: 3
       :local:

.. You can now install Docker Desktop on Windows Home machines using the WSL 2 backend. Docker Desktop on Windows Home is a full version of Docker Desktop for Linux container development.

Windows Home マシンで WSL2 バックエンドを使うと、Docker Desktop をインストールできます。Docker Desktop on Windows Home は、Linux コンテナ開発用の Docker Desktop の完全なバージョンです。

.. This page contains information on installing Docker Desktop on Windows 10 Home. If you are looking for information about installing Docker Desktop on Windows 10 Pro, Enterprise, or Education, see Install Docker Desktop on Windows.

.. This page contains information on installing Docker Desktop on Windows 10 Pro, Enterprise, and Education. If you are looking for information about installing Docker Desktop on Windows 10 Home, see Install Docker Desktop on Windows Home.

このページは、Docker Desktop を Windows 10 Home  にインストールするための情報です。Docker Desktop を Windows 10 Pro、Enterprise、Education  にインストールする情報をお探しであれば、 :doc:`install` をご覧ください。

.. Download from Docker Hub

* `Docker Hub からダウンロード <https://hub.docker.com/editions/community/docker-ce-desktop-windows/>`_

.. Docker Desktop on Windows Home offers the following benefits:

Docker Desktop on Windows Home を使えば、以下の利点があります：

..    Latest version of Docker on your Windows Home machine
    Install Kubernetes in one click on Windows Home
    Integrated UI to view and manage your running containers
    Start Docker Desktop in less than ten seconds
    Use Linux Workspaces
    Dynamic resource and memory allocation
    Networking stack, support for http proxy settings, and trusted CA synchronization

* Windows Home マシン上で、最新版の Docker が使える
* Windows Home 上で、1回クリックするだけで Kubernetes をインストールする
* 統合 UI によって、実行中コンテナの表示・管理
* 10 秒もかからず Docker Desktop を起動
* Linux ワークスペースの使用
* リソースとメモリの動的な割り当て
* ネットワーク・スタックにより、http プロキ設定や信頼できる CA 同期のサポート

.. For detailed information about WSL 2, see Docker Desktop WSL 2 backend

WSL 2 に関する詳細は、 :doc:`wsl` をご覧ください。

.. What to know before you install

.. _win-what-to-know-before-you-install:

インストール前に知っておくこと
==================================================

.. System Requirements

.. _win-system-requirements:

システム要件
--------------------------------------------------

.. Windows 10 Home machines must meet the following requirements to install Docker Desktop:

Windows 10 Home マシンで Docker Desktop を実行するには、以下の要件が必要です。

..    Install Windows 10, version 2004 or higher.
    Enable the WSL 2 feature on Windows. For detailed instructions, refer to the Microsoft documentation.
    The following hardware prerequisites are required to successfully run WSL 2 on Windows 10 Home:
        64 bit processor with Second Level Address Translation (SLAT)
        4GB system RAM
        BIOS-level hardware virtualization support must be enabled in the BIOS settings. For more information, see Virtualization.
    Download and install the Linux kernel update package.

* Windows 10, version 2004 またはそれ以上のインストール
* Windows 上で WSL2 機能の有効化。詳細な手順は `マイクロソフトのドキュメント <https://docs.microsoft.com/en-us/windows/wsl/install-win10>`_ をご覧ください。
* 以下は、Windows 10 以上で Hyper-V クライアントを問題なく実行するために必要なハードウェア要件
   *  64 ビット [SLAT `Second Level Address Translation <http://en.wikipedia.org/wiki/Second_Level_Address_Translation>`_ 対応プロセッサ
   * 4GB システムメモリ
   * BIOS レベルでのハードウェア仮想化が、BIOS 設定で有効にする必要。詳細な情報は `仮想化 <https://qiita.com/zembutsu/items/0a66e9a3fb078e1c90ae#%E4%BB%AE%E6%83%B3%E5%8C%96>`_ を参照
* `Linux カーネル更新パッケージ <https://docs.microsoft.com/windows/wsl/wsl2-kernel>`_ のダウンロードとインストール

..    Note: Docker supports Docker Desktop on Windows based on Microsoft’s support lifecycle for Windows 10 operating system. For more information, see the Windows lifecycle fact sheet.

.. note::

   Docker による Windows 用 Docker Desktop のサポートは、Microsoft の Windows 10 オペレーティングシステムに対するサポート・ライフサイクルに基づきます。詳細な情報は `Windows ライフサイクル・ファクトシート <https://support.microsoft.com/en-us/help/13853/windows-lifecycle-fact-sheet>`_ を御覧ください。

.. What’s included in the installer

.. _win-whats-included-in-the-installer:

インストーラに含まれるもの
--------------------------------------------------


.. The Docker Desktop installation includes Docker Engine, Docker CLI client, Docker Compose, Notary, Kubernetes, and Credential Helper.

Docker Desktop のインストールに含まれるのは、 :doc:`Docker Engine </install>`  、 Docker CLI クライアント、  :doc:`Docker Compose </compose/overview>` 、  :doc:`Notary <https://docs.docker.com/notary/getting_started/>` 、  `Kubernetes <https://github.com/kubernetes/kubernetes/>`_  、`Credential Helper <https://github.com/docker/docker-credential-helpers/>`_ です。

.. Containers and images created with Docker Desktop are shared between all user accounts on machines where it is installed. This is because all Windows accounts use the same VM to build and run containers. Note that it is not possible to share containers and images between user accounts when using the Docker Desktop WSL 2 backend.

Docker Desktop で作成したコンテナやイメージは、インストールしたマシン上の全ユーザ間で共有です。これは、すべての Windows アカウントが同じ仮想マシンでコンテナを構築・実行するからです。ただし、Docker Desktop WSL2 バックエンドを使用する場合は、ユーザ間でコンテナやイメージの共有ができないのでご注意ください。

.. Nested virtualization scenarios, such as running Docker Desktop on a VMWare or Parallels instance might work, but there are no guarantees. For more information, see Running Docker Desktop in nested virtualization scenarios.

VMware や Parralles インスタンス上で Docker Desktop を実行するような、ネストした仮想化でも動くでしょうが、無保証です。詳しい情報は :ref:`win-running-docker-desktop-for-windows-in-nested-virtualization-scenarios` をご覧ください。


.. Install Docker Desktop on Windows 10 Home

.. _install-docker-desktop-on-windows-10-home:

Windows 10 Home に Docker Desktop をインストール
==================================================

..    Double-click Docker Desktop Installer.exe to run the installer.

1.　**Docker Desktop Installer.exe** をダブルクリックし、インストーラを起動します。

..    If you haven’t already downloaded the installer (Docker Desktop Installer.exe), you can get it from Docker Hub. It typically downloads to your Downloads folder, or you can run it from the recent downloads bar at the bottom of your web browser.

もしもまだインストーラ（ :code:`Docker Desktop Installer.exe` ）をダウンロードしていなければ、 `Docker Hub <https://hub.docker.com/?overlay=onboarding>`_ から取得できます。ダウンロードは通常「ダウンロード」フォルダ内か、ウェブブラウザ上のダウンロード・バーに表示される最近ダウンロードした場所です。

.. When prompted, ensure the Enable WSL 2 Features option is selected on the Configuration page.

2.　確認画面が出たら、 **Enable WSL 2 Features** （WSL 2 機能を有効にする）のオプションが、設定ページで選択されているかどうかを確認します。

..    Follow the instructions on the installation wizard to authorize the installer and proceed with the install.

3.　インストール・ウィザードの指示に従い、利用規約（ライセンス）を承諾し、インストーラに権限を与えてインストールを進めます。

..    When the installation is successful, click Close to complete the installation process.

4.　インストールに成功したら、 **Close** （閉じる）をクリックしてインストールを終了します。

.. Start Docker Desktop

.. _win-start-docker-desktop-home:

Docker Desktop のスタート
==================================================

.. Docker Desktop does not start automatically after installation. To start Docker Desktop, search for Docker, and select Docker Desktop in the search results.

インストール後の Docker Desktop は、自動的に起動できません。Docker Desktop を開始するには Docker を検索し、検索結果にある **Docker Desktop** を選択します。

.. search for Docker app

.. When the whale icon in the status bar stays steady, Docker Desktop is up-and-running, and is accessible from any terminal window.

ステータス・バーに鯨のアイコンが表示されれば、 Docker Desktop は起動・実行中であり、あらゆる端末ウインドウからアクセスできます。

.. whale on taskbar

.. If the whale icon is hidden in the Notifications area, click the up arrow on the taskbar to show it. To learn more, see Docker Settings.

もしも鯨アイコンが通知エリアから隠れている場合は、タスクバーで「上」を向いた矢印をクリックして表示します。詳しく知るには :ref:`Docker の設定 <win-docker-settings-dialog>` を御覧ください。

.. When the initialization is complete, Docker Desktop launches the onboarding tutorial. The tutorial includes a simple exercise to build an example Docker image, run it as a container, push and save the image to Docker Hub.

初期化が完了すると、Docker Desktop は開始チュートリアルを起動します。チュートリアルには  Docker イメージを構築、実行し、Docker Hub にイメージを送信するまでの例を含みます。

.. Docker Quick Start tutorial

.. Congratulations! You are now successfully running Docker Desktop on Windows.

おめでとうございます！ Windows 版 Docker Desktop の実行に成功しました。

.. If you would like to rerun the tutorial, go to the Docker Desktop menu and select Learn.

チュートリアルに戻りたければ、 Docker Desktop のメニューから **Learn** （学ぶ）をクリックします。

.. Uninstall Docker Desktop

.. _win-uninstall-docker-desktop-home:

Docker Desktop のアンインストール
==================================================

.. To uninstall Docker Desktop from your Windows machine:

Windows マシンから Docker Desktop をアンインストールするには、

..    From the Windows Start menu, select Settings > Apps > Apps & features.
    Select Docker Desktop from the Apps & features list and then select Uninstall.
    Click Uninstall to confirm your selection.

1. Windows の **スタート** メニューから、 **設定** > **アプリ** > **アプリと機能** を選びます。
2. **アプリと機能** の一覧から **Docker Desktop**  を選択し、 **アンインストール** をクリックします。
3. 選択したのを確認の後、 **アンインストール** をクリックします。

..    Note: Uninstalling Docker Desktop will destroy Docker containers and images local to the machine and remove the files generated by the application.

.. note::

   Docker Desktop のアンインストールは、ローカルのマシンにある Docker コンテナのイメージを破棄し、アプリケーションによって作成された全てのファイルも破棄します。

.. Switch between Stable and Edge versions

.. _win-switch-between-stable-and-edge-version-home:

Stable と Edge バージョンの切り替え
==================================================

.. Docker Desktop allows you to switch between Stable and Edge releases. However, you can only have one version of Docker Desktop installed at a time. Switching between Stable and Edge versions can destabilize your development environment, particularly in cases where you switch from a newer (Edge) channel to an older (Stable) channel.

Docker Desktop は、自分で Stable （安定版）リリースと Edge （最新）リリースを切り替え可能です。しかしながら、 **Docker Desktop を一度にインストールできるのは、1つのバージョンのみ** です。Stable と Edge 版のリリース切り替えるは、開発環境の安定性を損なう可能性があります。特に、新しい（Edge）チャンネルを古い（Stable）チャンネルに切り替える場合です。

.. For example, containers created with a newer Edge version of Docker Desktop may not work after you switch back to Stable because they may have been created using Edge features that aren’t in Stable yet. Keep this in mind as you create and work with Edge containers, perhaps in the spirit of a playground space where you are prepared to troubleshoot or start over.

例えば、 Docker Desktop の新しい Edge バージョンでコンテナを作成する場合、Stable に切り戻すと動作しなくなる可能性があります。これは、Edge の機能を使って作成したコンテナには、まだ Stable には反映されていない機能が用いられている場合があるからです。Edge コンテナで作成したり作業したりする場合には、留意し続けてください。

.. To safely switch between Edge and Stable versions, ensure you save images and export the containers you need, then uninstall the current version before installing another. For more information, see the section Save and Restore data below.

Edge と Stable バージョン間を安全に切り替えるには、必要に応じてイメージの保存（save）やコンテナの出力（export）を確実に行い、他のバージョンをインストールする前に、既存のバージョンをアンインストールします。詳しい情報については、以下にあるデータの保存と修復を御覧ください。

.. Save and restore data

.. _win-save-and-restore-data-home:

データの保存と修復
--------------------------------------------------

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

..    Use docker import -i myContainer1.tar to create a file system image corresponding to the previously exported containers. See import in the Docker Engine.

5. :code:`docker import -i myContainer1.tar` を使い、以前にエクスポートしたコンテナに対応するファイルシステム・イメージを作成します。Docker Engine の   :doc:`import </engine/reference/commandline/import>` を御覧ください。

.. For information on how to back up and restore data volumes, see Backup, restore, or migrate data volumes.

データ・ボリュームのバックアップと修復の仕方に関する情報は、 :ref:`backup-restore-or-migrate-data-volumes` を御覧ください。

.. Where to go next

.. _win-install-where-to-go-next-home:

次はどこへ行きますか
==================================================


..    Getting started introduces Docker Desktop for Windows.
    Get started with Docker is a tutorial that teaches you how to deploy a multi-service stack.
    Troubleshooting describes common problems, workarounds, and how to get support.
    FAQs provides answers to frequently asked questions.
    Stable Release Notes or Edge Release Notes.

* :doc:`/docker-for-windows/index`  は Docker Desktop for Windows の導入です。
* :doc:`Docker の始め方 </get-started/index>` は一般的な Docker チュートリアルです。
* :doc:`troubleshoot` は一般的な問題、回避方法、統計情報の送信方法、問題報告の仕方があります。
* :doc:`faq` は、よく見受けられる質問と回答があります。
* :doc:`Stable リリースノート <release-notes>` または :doc:`Edge リリースノート <edge-release-note>` 。

.. seealso::

   Install Docker Desktop on Windows Home
      https://docs.docker.com/docker-for-windows/install-windows-home/
