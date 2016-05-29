.. -*- coding: utf-8 -*-
.. https://docs.docker.com/windows/step_one/
.. doc version: 1.10
.. check date: 2016/4/8
.. -----------------------------------------------------------------------------

.. Install Docker for Windows

.. _install-docker-for-windows:

========================================
Docker for Windows のインストール
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Windows users use Docker Toolbox to install Docker software. Docker Toolbox includes the following Docker tools:

Windows ユーザは Docker ツールボックス（Toolbox）を使い、 Docker のソフトウェアをインストールできます。Docker ツールボックスには、以下の Docker ツール群が入っています。

..    Docker CLI client for running Docker Engine to create images and containers
    Docker Machine so you can run Docker Engine commands from Windows terminals
    Docker Compose for running the docker-compose command
    Kitematic, the Docker GUI
    the Docker QuickStart shell preconfigured for a Docker command-line environment
    Oracle VM VirtualBox

* Docker CLI クライアントは Docker Engine（エンジン）でコンテナやイメージを作成。
* Docker Machine（マシン）は Windows 端末から Docker Engine に命令。
* Docker Compose（コンポーズ）は ``docker-compose`` コマンドを実行。
* Kitematic（カイトマティック）は Docker の GUI。
* Docker QuickStart（クイックスタート）は Docker コマンドライン環境を設定済みのシェル。
* Oracle VM VirtualBox

.. Because the Docker Engine daemon uses Linux-specific kernel features, you can’t run Docker Engine natively in Windows. Instead, you must use the Docker Machine command, docker-machine, to create and attach to a small Linux VM on your machine. This VM hosts Docker Engine for you on your Windows system.

Docker Engine デーモンは Linux 特有の kernel 機能を使います。そのため、Windows では Docker Engine を直接操作できません。その代わりに ``docker-machine`` コマンドで自分のマシン上に小さな Linux 仮想マシンを作成し、そこに接続します。この仮想マシンのホストを使い、  Windows システム上で Docker Engine を動かします。

.. Step 1: Check your version

.. _step1-check-your-version:

ステップ１：バージョンの確認
==============================

.. To run Docker, your machine must have a 64-bit operating system running Windows 7 or higher. Additionally, you must make sure that virtualization is enabled on your machine. To verify your machine meets these requirements, do the following:

Docker を実行するには、Windows 7 以上の 64 bit オペレーティング・システムが必要です。また、マシン上で仮想化機能を有効にする必要もあります。マシンが条件を満たしているかどうかの確認は、次の手順を進めます。

..    Right click the windows message and choose System.

1. Windows アイコンまたはスタートメニュー（画面の左下）を右クリックし、システムを選びます。

..    Which version

.. image:: /engine/installation/images/win_ver.png
   :scale: 60%
   :alt: Windows バージョン

..    If you aren’t using a supported version, you could consider upgrading your operating system.

サポート対象のバージョンでなければ、オペレーティング・システムのアップグレードをご検討ください。

..    Make sure your Windows system supports Hardware Virtualization Technology and that virtualization is enabled.

2. Windows システムがハードウェア仮想化テクノロジをサポートするのを確認します。また、仮想化機能が有効なのも確認します。

..    For Windows 8 or 8.1

Windows 8 または 8.1
--------------------

..    Choose Start > Task Manager and navigate to the Performance tab. Under CPU you should see the following:

スタートメニューからタスク・マネージャを選び、パフォーマンス・タブに移動します。CPU の下にある項目「仮想化」が「有効」になっていることを確かめます。

..    Release page　（画像）

..    If virtualization is not enabled on your system, follow the manufacturer’s instructions for enabling it.

システム上で仮想化が有効でない場合は、製造元の取り扱い説明書をお読みになった後、有効にします。

..    For Windows 7

Windows 7
----------

..    Run the Microsoft® Hardware-Assisted Virtualization Detection Tool and follow the on-screen instructions.

Microsoft の `Hardware-Assisted Virtualization Detection Tool <https://www.microsoft.com/en-us/download/details.aspx?id=592>`_ （ ハードウェア支援仮想化技術検出ツール）を実行し、画面の指示に従います。

..    Verify your Windows OS is 64-bit (x64)

3. Windows OS が 64 ビット（x64）で動いているのを確認します。

.. How you do this verification depends on your Windows version. For details, see the Windows article How to determine whether a computer is running a 32-bit version or 64-bit version of the Windows operating system.

設定はお使いの Windows バージョンによって異なるのでご注意ください。詳細は `コンピューターは、32 ビット版または 64 ビット バージョンの Windows オペレーティングシステムを実行しているかどうかを確認する方法 <https://support.microsoft.com/ja-jp/kb/827218>`_ をご覧ください。

.. Step 2: Install Docker Toolbox

.. _step2-install-docker-toolbox:

ステップ２：Docker Toolbox のインストール
=========================================

.. In this section, you install the Docker Toolbox software and several “helper” applications. The installation adds the following software to your machine:

このセクションでは Docker Toolbox ソフトウェアと、いくつかの「便利な」アプリケーションをインストールします。マシン上に以下のソフトウェアをインストールします。

..    Docker Client for Windows
    Docker Toolbox management tool and ISO
    Oracle VM VirtualBox
    Git MSYS-git UNIX tools

* Windows 用 Docker クライアント
* Docker Toolbox 管理ツールと ISO（マシン・イメージ）
* Oracle VM VirtualBox
* Git MSYS-git UNIX ツール

.. If you have a previous version of VirtualBox installed, do not reinstall it with the Docker Toolbox installer. When prompted, uncheck it.

既に古いバージョンの VirtualBox をインストール済みの場合は、Docker Toolbox インストーラで再インストールしないでください（新しいバージョンをインストールするため、不整合が発生する可能性があります）。インストール画面で選択肢が表示されたら、対象からチェックを外します。

.. If you have Virtual Box running, you must shut it down before running the installer.

VirtualBox を実行中の場合は、インストーラを実行する前に停止しておく必要があります。

..    Go to the Docker Toolbox page.

1. `Docker Toolbox <https://www.docker.com/toolbox>`_ のページに移動します。

..    Click the installer link to download.

2. インストーラのダウンロード先をクリックします。

..    Install Docker Toolbox by double-clicking the installer.

3. インストーラをダブル・クリックし、Docker Toolbox をインストールします。

..    The installer launches the “Setup - Docker Toolbox” dialog.

インストーラは「Setup - Docker Toolbox」ダイアログを起動します。

..    If Windows security dialog prompts you to allow the program to make a change, choose Yes. The system displays the Setup - Docker Toolbox for Windows wizard.

Windows セキュリティのダイアログが表示されたら、プログラムによる変更を許可します。システム上で Windows 用の Docker Toolbox セットアップ用ウィザードが表示されます。

..    Release page

..    Press Next to accept all the defaults and then Install.

4. 全てをデフォルトにするには Next を押し続け、インストールを進めます。

..    Accept all the installer defaults. The installer takes a few minutes to install all the components:

インストーラをデフォルトで実行した場合、全てのインストールが終わるまで数分かかります。

..    When notified by Windows Security the installer will make changes, make sure you allow the installer to make the necessary changes.

5. Windows セキュリティ・ダイアログが変更を加える確認画面を表示したら、インストーラの設定に必要なため、許可をお願いします。

..    When it completes, the installer reports it was successful:

作業後は、インストールが完了したと画面に表示されます。

..    Success..

..    Uncheck “View Shortcuts in File Explorer” and press Finish.

6. 「View Shortcuts in File Explorer」（ファイル・エクスプローラでショートカットを表示）のチェックを外し、Finish を押します。

.. Step 3: Verify your installation

.. _step3-verify-your-installation:

ステップ３：インストールの確認
==============================

.. The installer places Docker Toolbox and VirtualBox in your Applications folder. In this step, you start Docker Toolbox and run a simple Docker command.

インストーラはアプリケーション・フォルダに Docker Toolbox と VirtualBox のショートカットを作成します。このステップでは Docker Toolbox を実行し、簡単な Docker コマンドを実行します。

..    On your Desktop, find the Docker Toolbox icon.

1. デスクトップ上の Docker Toolbox アイコンを探します。

..    Desktop

.. image:: /tutimg/icon_set.png

..    Click the icon to launch a Docker Toolbox terminal.

2. アイコンをクリックし、Docker Toolbox のターミナルを起動します。

..    If the system displays a User Account Control prompt to allow VirtualBox to make changes to your computer. Choose Yes.

システムがユーザ・アカウントの制御に関する画面を表示し、VirtualBox がコンピュータ対する変更を確認してきたら「はい」をクリックします。

..    The terminal does several things to set up Docker Toolbox for you. When it is done, the terminal displays the $ prompt.

ターミナルでは、Docker ツールボックスがセットアップに関する情報を表示します。作業が終わればターミナル上に ``$`` プロンプトが表示されます。

..    Desktop

.. image:: /tutimg/terminal.png

..    The terminal runs a special bash environment instead of the standard Windows command prompt. The bash environment is required by Docker.

標準の  Windows コマンドライン・プロンプトにかわり、特別な ``bash`` 環境をターミナル上で実行します。Docker には ``bash`` 環境が必要です。

..    Make the terminal active by click your mouse next to the $ prompt.

3. ターミナル上にある ``$`` プロンプトの横をマウスでクリックします。

..    If you aren’t familiar with a terminal window, here are some quick tips.

ターミナル画面に不慣れでしたら、ここで便利な使い方を紹介します。

..    The prompt is traditionally a $ dollar sign. You type commands into the command line which is the area after the prompt. Your cursor is indicated by a highlighted area or a | that appears in the command line. After typing a command, always press RETURN.

プロンプトとは一般的に ``$`` ドル記号です。このプロンプトの後にあるコマンドライン上でコマンドを入力します。コマンドライン上ではカーソルは ``|`` として表示されます。コマンドを入力した後は、常にリターン・キーを押します。

..    Type the docker run hello-world command and press RETURN.

4. ``docker run hello-world`` コマンドを実行し、リターン・キーを押します。

..    The command does some work for you, if everything runs well, the command’s output looks like this:

以下のコマンドは、何らかの処理を行うものです。正常に終われば、画面には次のように表示されます。

.. code-block:: bash

   $ docker run hello-world
   Unable to find image 'hello-world:latest' locally
   Pulling repository hello-world
   91c95931e552: Download complete
   a8219747be10: Download complete
   Status: Downloaded newer image for hello-world:latest
   Hello from Docker.
   This message shows that your installation appears to be working correctly.
   
   To generate this message, Docker took the following steps:
    1. The Docker Engine CLI client contacted the Docker Engine daemon.
    2. The Docker Engine daemon pulled the "hello-world" image from the Docker Hub.
       (Assuming it was not already locally available.)
    3. The Docker Engine daemon created a new container from that image which runs the
       executable that produces the output you are currently reading.
    4. The Docker Engine daemon streamed that output to the Docker Engine CLI client, which sent it
       to your terminal.
   
   To try something more ambitious, you can run an Ubuntu container with:
    $ docker run -it ubuntu bash
   
   For more examples and ideas, visit:
    https://docs.docker.com/userguide/

.. Looking for troubleshooting help?

問題解決のヘルプをお探しですか？
========================================

.. Typically, the above steps work out-of-the-box, but some scenarios can cause problems. If your docker run hello-world didn’t work and resulted in errors, check out Troubleshooting for quick fixes to common problems.

通常、これらの手順は特に何も考えなくても実行できますが、もしかしたら問題が発生する場合があるかもしれません。 ``docker run hello-world`` が実行できずエラーになる場合は、一般的な問題を解決するための :doc:`トラブルシューティング </toolbox/troubleshoot>` をご覧ください。

.. A Windows specific problem you might encounter has to do with the NDIS6 host network filter driver, which is known to cause issues on some Windows versions. For Windows Vista systems and newer, VirtualBox installs NDIS6 driver by default. Issues can range from system slowdowns to networking problems for the virtual machine (VM). If you notice problems, re-run the Docker Toolbox installer, and select the option to install VirtualBox with the NDIS5 driver.

NDIS6 ホスト・ネットワーク・フィルタ・ドライバの使用時は、Windows 固有の問題に遭遇するかもしれません。これは特定 Windows バージョンでの発生が判明しています。Windows Vista 以上のバージョンでは、VirtualBox が NDIS6 ドライバをデフォルトでインストールします。問題が発生する範囲は、仮想マシンの停止時に、ネットワークで問題が発生するかもしれません。もし問題が発生したら、Docker Toolbox インストーラを再実行し、VirtualBox を NDIS6 ドライバを一緒にインストールするようオプションをお選びください。

.. Where to go next

次は何をしますか
====================

.. At this point, you have successfully installed the Docker software. Leave the Docker Quickstart Terminal window open. Now, go to the next page to read a very short introduction Docker images and containers.

以上で Docker ソフトウェアのインストールが完了しました。Docker Quickstart ターミナル画面は開いたままにします。次は :doc:`step_two` に進みます。

.. seealso:: 

   Install Docker for Windows
      https://docs.docker.com/windows/step_one/
