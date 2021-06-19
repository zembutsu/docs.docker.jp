.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/docker-for-windows/wsl/
   doc version: 19.03
      https://github.com/docker/docker.github.io/blob/master/docker-for-windows/wsl.md
.. check date: 2020/06/12
.. Commits on May 14, 2020 8e8fbded0ef1d8e4546388079e99c9b07558ed19
.. -----------------------------------------------------------------------------

.. Docker Desktop WSL 2 backend

.. _docker-desktop-wsl-2-backend:

=======================================
Docker Desktop WSL 2 バックエンド
=======================================

.. sidebar:: 目次

   .. contents::
       :depth: 3
       :local:

.. Windows Subsystem for Linux (WSL) 2 introduces a significant architectural change as it is a full Linux kernel built by Microsoft, allowing Linux containers to run natively without emulation. With Docker Desktop running on WSL 2, users can leverage Linux workspaces and avoid having to maintain both Linux and Windows build scripts. In addition, WSL 2 provides improvements to file system sharing, boot time, and allows access to some cool new features for Docker Desktop users.

新しい Docker Desktop  WSL 2 バックエンドは、Docker Desktop  WSL 2 Tech Preview の後を継ぐものです。WSL2 バックエンド・アーキテクチャは Kubernetes 向けのサポートを導入し、更新版 Docker デーモンの提供、VPN と親和性のあるネットワーク機能や追加機能を提供します。WSL 2 は構造上の著しい変更をもたらします。Microsoft によってビルドされた完全な Linux カーネルによって、エミュレーションではなく、ネイティブに Linux コンテナを実行可能になります。WSL 2 上で Docker Desktop を実行しますと、利用者は Linux ワークスペースを活用できるようになり、また、ビルド用スクリプトは Windows 用と Linux 用との両方を準備する必要がなくなります。

.. Docker Desktop uses the dynamic memory allocation feature in WSL 2 to greatly improve the resource consumption. This means, Docker Desktop only uses the required amount of CPU and memory resources it needs, while enabling CPU and memory-intensive tasks such as building a container to run much faster.

また、Docker Desktop は WSL 2 で導入された動的メモリ割り当て機能も活用できるため、リソースの消費を著しく改善します。つまり、Docker Desktop は、コンテナのビルドのような CPU とメモリを大量に必要とするタスクでも、 CPU とメモリを必要量しか使わないため、より速く実行できます。

.. Additionally, with WSL 2, the time required to start a Docker daemon after a cold start is significantly faster. It takes less than 10 seconds to start the Docker daemon when compared to almost a minute in the previous version of Docker Desktop.

さらに、WSL 2 はDocker デーモンのコールド・スタート後は、起動に必要な時間が著しく早くなります。Docker デーモンの起動に、現在の Docker Desktop のバージョンでは数十秒かかるのと比べ、2秒以下です。

.. Prerequisites

.. _wsl-rerequisites:

動作条件
==============================

.. Before you install the Docker Desktop WSL 2 backend, you must complete the following steps:

Docker Desktop  WSL 2 バックエンドをインストールする前に、以下の手順を完了している必要があります。

..    Install Windows 10, version 2004 or higher.
    Enable WSL 2 feature on Windows. For detailed instructions, refer to the Microsoft documentation.
    Download and install the Linux kernel update package.

1. Windows 10, version 2004 以上をインストール。
2. Windows 上での WSL2 機能の有効化。詳細手順は `マイクロソフトのドキュメント <https://docs.microsoft.com/ja-jp/windows/wsl/wsl2-install>`_ を参照ください。
3. `Linux カーネル更新パッケージ <https://docs.microsoft.com/windows/wsl/wsl2-kernel>`_ のダウンロードとインストール

.. Download

.. _wsl-download:

ダウンロード
==============================

.. Download Docker Desktop Stable 2.3.0.2 or a later release.

`Docker Desktop stable 2.3.0.2 <https://hub.docker.com/editions/community/docker-ce-desktop-windows/>`_ 以上のリリースをダウンロードします。


.. Install

.. _wls-install:

インストール
==============================

.. Ensure you have completed the steps described in the Prerequisites section before installing the Docker Desktop Stable 2.3.0.2 release.

Docker Desktop Stable 2.3.0.2 リリースをインストールする **前に** 、動作条件のセクションで説明した、 :ref:`事前の手順 <wsl-rerequisites>` を必ず終えてください。

..    Follow the usual installation instructions to install Docker Desktop. If you are running a supported system, Docker Desktop prompts you to enable WSL 2 during installation. Read the information displayed on the screen and enable WSL 2 to continue.

1. 通常の Docker Desktop のインストール手順に従い、インストールを行います。もしサポートしているシステムであれば、 Docker Desktop のインストール中に、 WSL 2 を有効化するかどうか訊ねる画面が出ます。続けるには、画面に表示される文字を読み、WSL 2 を有効化します。

..    Start Docker Desktop from the Windows Start menu.

2. Windows スタート・メニューから Docker Desktop をスタートします。

..    From the Docker menu, select Settings > General.

3. Docker メニューから、 **Settings > General** を選択します。

..    Enable WSL 2

..    Select the Use WSL 2 based engine check box.

4.  **User WSL 2 based engine** （WSL2 対応エンジンを使う） のチェックボックスを選択します。

..    If you have installed Docker Desktop on a system that supports WSL 2, this option will be enabled by default.

WSL 2 をサポートしているシステム上に Docker Desktop をインストールした場合は、デフォルトでこのオプションが有効化されています。

..    Click Apply & Restart.

5.  ***Apply & Restart** （適用と再起動）をクリックします。

..    Ensure the distribution runs in WSL 2 mode. WSL can run distributions in both v1 or v2 mode.

6. ディストリビューションが WSL2 モードで動作しているかどうかを確認します。WSL はディストリビューションの v1 と v2 モードのどちらでも動作します。

..    To check the WSL mode, run

WSL モードの確認は、次のように実行します。

.. code-block:: bash

   wsl -l -v

..    To upgrade your existing Linux distro to v2, run:

v2 にアップグレードするには、次のように実行します。

.. code-block:: bash

   wsl --set-version (distro name) 2

..    To set v2 as the default version for future installations, run:

以後のインストールで v2 をデフォルトのバージョンにセットするには、次のように実行します。

.. code-block:: bash

   wsl --set-default-version 2

..    When Docker Desktop restarts, go to Settings > Resources > WSL Integration.

7.　Docker Desktop を再起動したら、 **Settings > Resources > WSL Integration** に移動し、Docker でアクセスしたい WSL 2 ディストリビューションを選択します。

..    WSL Integration will be enabled on your default WSL distribution. To change your default WSL distro, run wsl --set-default <distro name>.

WSL 統合によって、デフォルトの WSL ディストリビューションが有効化されます。このデフォルトの WSL ディストリビューションを変更するには :code:`wsl --set-default <ディストリビューション名>` を実行します。

..    For example, to set Ubuntu as your default WSL distro, run wsl --set-default ubuntu.

たとえば、デフォルト WSL ディストリビューションを Ubuntu に設定するには、 :code:`wsl --set-default ubuntu` を実行します。

..    Optionally, select any additional distributions you would like to enable WSL 2 on.

オプションの項目から、WSL 2 上で有効化したい追加ディストリビューションを選択できます。

..    WSL 2 Choose Linux distro

..    Click Apply & Restart.

8.　変更を有効にするには **Apply & Restart** をクリックします。


.. Develop with Docker and WSL 2

.. _develop-with-docker-and-wsl-2:

Docker と WSL 2 で開発する
========================================

.. The following section describes how to start developing your applications using Docker and WSL 2. We recommend that you have your code in your default Linux distribution for the best development experience using Docker and WSL 2. After you have enabled WSL 2 on Docker Desktop, you can start working with your code inside the Linux distro and ideally with your IDE still in Windows. This workflow can be pretty straightforward if you are using VSCode.

以下のセクションでは、Docker と WSL 2 を用いたアプリケーション開発のはじめかた説明します。私たちの推奨は、皆さんのデフォルト Linux ディストリビューションにコードを入れる方法が、Docker と WSL 2 バックエンドを用いた開発体験にベストです。Docker Desktop で WSL 2 を有効化した後は、Linux ディストリビューションの中でコードが動き始めるので、Windows 上でありながら理想的な IDE（統合開発環境）となるでしょう。 `VSCode <https://code.visualstudio.com/download>`_ を使えば、 このワークフローはより洗練されるでしょう。

..    Open VSCode and install the Remote - WSL extension. This extension allows you to work with a remote server in the Linux distro and your IDE client still on Windows.

1.　VSCode を開き、 `Remote - WSL <https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl>`_ エクステンションをインストールします。この拡張機能によって、Windows 上にある Linux ディストリビューションをリモート・サーバとして動かすことができ、Windows 上の IDE クライアントになります。

..    Now, you can start working in VSCode remotely. To do this, open your terminal and type:

2.　次に、VSCode をリモートで動作するようにします。そのためには、ターミナルを開き、次のように実行します。

.. code-block:: bash

   wsl
   
   code .

..    This opens a new VSCode connected remotely to your default Linux distro which you can check in the bottom corner of the screen.

これにより新しい VSCode のリモート接続先が、スクリーン上で下の端でチェックしている、デフォルトの Linux ディストリビューションになります。

..    Alternatively, you can type the name of your default Linux distro in your Start menu, open it, and then run code .

あるいは、スタートメニューからデフォルトの Linux ディストリビューション名を入力し、開き、 :code:`code` を実行します。

..    When you are in VSCode, you can use the terminal in VSCode to pull your code and start working natively from your Windows machine.

3.　VSCode 内であれば、VSCode のターミナルを使って、Windows マシンからコードを取得し、ネイティブに動かせられます。

.. Best practices

.. _wsl-bestpractices:

ベストプラクティス
====================

..     To get the best out of the file system performance when bind-mounting files:
        Store source code and other data that is bind-mounted into Linux containers (i.e., with docker run -v <host-path>:<container-path>) in the Linux filesystem, rather than the Windows filesystem.
        Linux containers only receive file change events (“inotify events”) if the original files are stored in the Linux filesystem.
        Performance is much higher when files are bind-mounted from the Linux filesystem, rather than remoted from the Windows host. Therefore avoid docker run -v /mnt/c/users:/users (where /mnt/c is mounted from Windows).
        Instead, from a Linux shell use a command like docker run -v ~/my-project:/sources <my-image> where ~ is expanded by the Linux shell to $HOME.
    If you have concerns about the size of the docker-desktop-data VHDX, or need to change it, take a look at the WSL tooling built into Windows.
    If you have concerns about CPU or memory usage, you can configure limits on the memory, CPU, Swap size allocated to the WSL 2 utility VM.
    To avoid any potential conflicts with using WSL 2 on Docker Desktop, you must uninstall any previous versions of Docker Engine and CLI installed directly through Linux distributions before installing Docker Desktop.

* ファイルのマウント（bind-mount）時に最高のシステムパフォーマンスを得るために：
   * Linux コンテナ内にソースコードや他のデータを入れるには、Windows ファイルシステムよりも、Linux ファイルシステムでバインド・マウント（bind-mount）を使う（例、 :code:`docker run -v <ホスト側パス>:<コンテナ側パス>`）。
   * オリジナルのファイルが Linux ファイルシステム内にあれば、Linux コンテナはファイル変更イベント（ "inotify events" ）のみ受け取る
   * Windows ホストからリモート操作するより、Linux ファイルシステム上でファイルをバインド・マウントするほうが、パフォーマンスがより優れる。つまり :code:`docker run -v /mnt/c/users:/users` を避ける（ :code:`/mnt/c` は Windows からマウントしている場所 ）。
   * そのかわりに、 コマンドラインで :code:`docker run -v ~/my-project:/sources <自分のイメージ>` のようなコマンドをシェルで用いると、 :code:`~` にあたる場所は Linux シェルによって :code:`$HOME` に展開される。
* docker-desktop-data VHDX の容量についての懸念や、変更の必要があれば、 `Windows に組み込まれた WSL ツール <https://docs.microsoft.com/ja-jp/windows/wsl/compare-versions#understanding-wsl-2-uses-a-vhd-and-what-to-do-if-you-reach-its-max-size>`_ を参照
* CPU やメモリ使用量に関する懸念があれば、 `WSL 2 ユーティリティ VM <https://docs.microsoft.com/ja-jp/windows/wsl/release-notes#build-18945>`_ に割り当て可能な メモリ、CPU 、スワップサイズにし制限を設ける
* Docker Desktop 上の WSL 2 を用いることで、競合する可能性を避けるためには、Docker Desktop を通して Linux ディストリビューションを直接インストールする前に、古いバージョンの Docker Engine および CLI のアンインストールが必須

.. Feedback

.. _wsl-feedback:

フィードバック
==============================

.. Your feedback is very important to us. Please let us know your feedback by creating an issue in the Docker Desktop for Windows GitHub repository and adding the WSL 2 label.

皆さんからのフィードバックが私たちとって重要です。皆さんのフィードバックをお伝えいただくには、 `Docker Desktop for Windows GitHub <https://github.com/docker/for-win/issues>`_ リポジトリで、 **WSL 2** ラベルを追加ください。

.. seealso::

   Docker Desktop WSL 2 backend
      https://docs.docker.com/docker-for-windows/wsl/
