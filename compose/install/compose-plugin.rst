.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/install/compose-plugin/
.. SOURCE: 
   doc version: v20.10
      https://github.com/docker/docker.github.io/blob/master/compose/install/compose-plugin.md
.. check date: 2022/07/15
.. Commits on Jul 13, 2022 38fec0d159134a9af7e8a3c226057a114b0622be
.. -------------------------------------------------------------------

.. Install Docker Compose CLI plugin
.. _install-docker-compose-cli-plugin:

==================================================
Docker Compose CLI プラグインのインストール
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. On this page you can find instructions on how to install the Compose plugin for Docker CLI on Linux and Windows Server operating systems.

このページでは、Linux と Windows Server オペレーティングシステム上に、Docker CLI の Compose プラグインをインストールするための手順が分かります。

..    Note that installing Docker Compose as a plugin requires Docker CLI.

.. note::

   Docker Compose をプラグインとしてインストールするには、 Docker CLI が必要です。

.. Installation methods
.. _compose-installation-methods:

インストール方法
====================

..    Installing Docker Desktop for Linux is the easiest and recommended installation route. Check the Desktop for Linux supported platforms page to verify the supported Linux distributions and architectures.

* :doc:`Docker Desktop for Linux </desktop/install/linux-install>` のインストールが、最速かつ推奨する手順です。サポートしている Linux ディストリビューションとアーキテクチャを確認するには、 :ref:`サポートしているプラットフォーム <linux-install-supported-platform>` のページをご覧ください。

.. The following other methods are possible:

以下にある他の方法も利用できます：

..    Using the automated convenience scripts (for testing and development environments). These scripts install Docker Engine and Docker CLI with the Compose plugin. For this route, go to the Docker Engine install page and follow the provided instructions. After installing Desktop for Linux, this is the recommended route.
    Setting up Docker’s repository and using it to install Docker CLI Compose plugin. See the Install using the repository section on this page. This is the second best route.
    Installing the Docker CLI Compose plugin manually. See the Install the plugin manually section on this page. Note that this option requires you to manage upgrades manually as well.

* （テストと開発環境向けでは） **便利な自動化スクリプトを使います** 。これらのスクリプトは、Docker Engine と Compose プラグインが入った Docker CLI をインストールします。この方法については、 :doc:`Docker Engine インストール </engine/install/index>` のページに移動し、示された手順に従います。 *Desktop for Linux をインストールした後は、これが推奨される方法です* 。
* **Docker のリポジトリをセットアップ** し、これを使って Docker CLI Compose プラグインをインストールします。このページ上にある :ref:`リポジトリを使ってインストール <compose-install-using-the-repository>` をご覧ください。 *これは2番目に良い方法です。*
* **Docker CLI Compose プラグインを手動でインストールします** 。このページ上の :ref:`プラグインを手動でインストール <compose-install-the-plugin-manually>` をご覧ください。 *この手法を使う場合、アップグレードも同様に手動で行う必要がありますので、ご注意ください。* 

.. Install using the repository
.. _compose-install-using-the-repository:

リポジトリを使ってインストール
==============================

..  Note
    These instructions assume you already have Docker Engine and Docker CLI installed and now want to install the Compose plugin. For other Linux installation methods see this summary.

.. note::

   これらの手順は、既に Docker Engine と Docker CLI をインストール済みで、次に Compose プラグインをインストールしようとしている状態を想定しています。他の Linux インストール方法については、 :ref:`こちらの概要 <compose-installation-methods>` をご覧ください。

..    To run Compose as a non-root user, see Manage Docker as a non-root user.

.. note::

   Compose を root 以外のユーザで実行するには、 :doc:`root 以外のユーザとして Docker を管理 </engine/install/linux-postinstall>` をご覧ください。

.. If you have already set up the Docker repository jump to step 2.

既に Docker リポジトリをセットアップ済みの場合は、ステップ 2 に飛んでください。

..  Set up the repository. Go to the “Set up the repository” section of the chosen Linux distribution. found on the Docker Engine installation pages to check the instructions.
    Update the apt package index, and install the latest version of Docker Compose:
        Or, if using a different distro, use the equivalent package manager instructions.

1. リポジトリをセットアップします。選択した :ref:`Linux ディストリビューション <install-server>` のページに異動し、Docker Engine のインストールページにある「リポジトリをセットアップ」セクションの手順を確認します。

2. ``apt`` パッケージのインデックスを更新し、Docker Compose の最新版をインストールします。

   .. note::
   
     あるいは、他のディストリビューションを使っている場合、同様のパッケージマネージャに対応した手順を使います。

   .. code-block:: bash
   
      $ sudo apt-get update
      $ sudo apt-get install docker-compose-plugin

   .. Alternatively, to install a specific version of Compose CLI plugin:
   あるいは、バージョンを特定して Compose CLI プラグインをインストールします。

   .. a. List the versions available in your repo:
   
   a. リポジトリで利用可能なバージョンを一覧標示します：
   
   .. code-block:: bash
   
      $ apt-cache madison docker-compose-plugin
        docker-compose-plugin | 2.3.3~ubuntu-focal | https://download.docker.com/linux/ubuntu focal/stable arm64 Packages

   .. b. From the list obtained use the version string you can in the second column to specify the version you wish to install.
   b. 得られた結果の2行目以降の列から、インストールしたいバージョンを指定する文字列を確認します。。

   .. c. Install the selected version:
   c. 指定したバージョンをインストールします。
   
   .. code-block:: bash
   
      $ sudo apt-get install docker-compose-plugin=<バージョン文字>

   .. where <VERSION_STRING> is, for example,2.3.3~ubuntu-focal.
   
   ``<バージョン文字>`` の場所は、 ``2.3.3~ubuntu-focal`` のようなものです。

.. Verify that Docker Compose is installed correctly by checking the version.

3. バージョンを確認し、Docker Compose が正しくインストールされたかを確認します。

.. code-block:: bash

   $ docker compose version
   Docker Compose version v2.3.3


.. Install the plugin manually
.. _compose-install-the-plugin-manually:

プラグインを手動でインストール
------------------------------

..  Note
    These instructions assume you already have Docker Engine and Docker CLI installed and now want to install the Compose plugin.
    Note as well this option requires you to manage upgrades manually. Whenever possible we recommend any of the other installation methods listed. For other Linux installation methods see this summary.

.. note::

   これらの手順は、既に Docker Engine と Docker CLI をインストール済みで、次に Compose プラグインをインストールしようとしている状態を想定しています。
   
   また、この手法には手動でアップグレードを管理する必要がありますのでご注意ください。可能であれば、他のインストール手順を推奨します。他の Linux インストール方法については、 :ref:`こちらの概要 <compose-installation-methods>` をご覧ください。

..    To run Compose as a non-root user, see Manage Docker as a non-root user.

.. note::

   Compose を root 以外のユーザで実行するには、 :doc:`root 以外のユーザとして Docker を管理 </engine/install/linux-postinstall>` をご覧ください。

..     To download and install the Compose CLI plugin, run:
1. Compose CLI プラグインのダウンロードとインストールには、次のコマンドを実行します。

   .. code-block:: bash
      $ DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
      $ mkdir -p $DOCKER_CONFIG/cli-plugins
      $ curl -SL https://github.com/docker/compose/releases/download/v2.6.1/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose

   .. This command downloads the latest release of Docker Compose (from the Compose releases repository) and installs Compose for the active user under $HOME directory.

   このコマンドは Docker Compose の最新リリースを（Compose リリース リポジトリから）ダウンロードします。それから、Compose をアクティブ ユーザの ``$HOME`` ディレクトリ以下にインストールします。

..    To install:
        Docker Compose for all users on your system, replace ~/.docker/cli-plugins with /usr/local/lib/docker/cli-plugins.
        A different version of Compose, substitute v2.6.1 with the version of Compose you want to use.

   .. note:: インストール方法：
   
      * システム上の *全てのユーザ* に対して Docker Compose が使えるようにするには、 ``~/.docker/cli-plugins`` を ``/usr/local/lib/docker/cli-plugins`` に置き換えます。
      * Compose のバージョンが違う場合、 ``v2.6.1`` の部分を使いたい Compose のバージョンに入れ替えます。

.. Apply executable permissions to the binary:

2. バイナリに対して実行可能なパーミッションを適用します：

   .. code-block:: bash
   
      $ chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose

..   or, if you chose to install Compose for all users:

   または、全てのユーザに対して Compose をインストールする場合は、このようにします：

   .. code-block:: bash
   
      $ sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

.. Test the installation.

3. インストールを確認します。

   .. code-block:: bash

      $ docker compose version
      Docker Compose version v2.6.1

..  Note
    Compose standalone: If you need to use Compose without installing the Docker CLI, the instructions for the standalone scenario are similar. Note the target folder for the binary’s installation is different as well as the compose syntax used with the plugin (space compose) or the standalone version (dash compose).

.. note::

   **スタンドアロン（独立した）Comose** ：Docker CLI をインストールせず、Compose を使いたい場合、スタンドアロンの手順も似たようなものです。バイナリのインストール先フォルダでは、プラグイン版（スペース compose）とスタンドアロン版（ダッシュ dompose） の compose 構文が異なるのでご注意ください。

..    To download and install Compose standalone, run:

1. Compose スタンドアロンのダウンロードとインストールは、次のようにします：

   .. code-block:: bash

      $ curl -SL https://github.com/docker/compose/releases/download/v2.6.1/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose

..  Apply executable permissions to the standalone binary in the target path for the installation.

2. インストール先パスにあるスタンドアロンのバイナリに、実行可能なパーミッションを適用します。

..  Test and execute compose commands using docker-compose.

3. ``docker-compose`` コマンドを使って compose コマンドの実行をテストします。

..  Note
    If the command docker-compose fails after installation, check your path. You can also create a symbolic link to /usr/bin or any other directory in your path. For example:

.. note::

   インストール後に ``docker-compose`` コマンドに失敗する場合、パスを確認します。また、シンボリックリンクを ``/usr/bin`` やパス上にある他のディレクトリに作成します。例：
   
   .. code-block:: bash
   
      $ sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

.. Install Compose on Windows Server
.. _compose-install-compose-on-windows-server:

Windows Server 上に Compose をインストール
==================================================

.. Follow these instructions if you are running the Docker daemon and client directly on Microsoft Windows Server and want to install Docker Compose.

以下の手順は、Microsoft Windows Server 上で Docker デーモンを実行し、Docker Compose をクライアントから直接インストールする場合のものです。

..    Run a PowerShell as an administrator. When asked if you want to allow this app to make changes to your device, click Yes in order to proceed with the installation.

1. 管理者として PowerShell を実行します。アプリがデバイスに対して変更を加えたいと許可を求める場合、インストールを続けるには「 **はい** 」をクリックします。

..    GitHub now requires TLS1.2. In PowerShell, run the following:

2. GitHub は現在 TLS1.2 が必要です。PowerShell から以下のコマンドを実行します。

   .. code-block:: bash
      [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

..    Run the following command to download the latest release of Compose (v2.6.1):

3. Compose の最新リリース（v2.6.1.）をダウンロードするには、以下のコマンドを実行します。

   .. code-block:: bash

      Invoke-WebRequest "https://github.com/docker/compose/releases/download/v2.6.1/docker-compose-Windows-x86_64.exe" -UseBasicParsing -OutFile $Env:ProgramFiles\Docker\docker-compose.exe

..      Note
        On Windows Server 2019 you can add the Compose executable to $Env:ProgramFiles\Docker. Because this directory is registered in the system PATH, you can run the docker-compose --version command on the subsequent step with no additional configuration.
        To install a different version of Compose, substitute v2.6.1 with the version of Compose you want to use.

   .. note::
   
      Windows Server 2019 上では、Compose のバイナリは ``$Env:ProgramFiles\Docker`` に追加されます。このディレクトリとは、システムの ``PATH`` 上に登録されているため、以降に続くステップで追加設定を行わなくても、 ``docker-compose --version`` を実行できます。

   .. note::
   
      Compose の異なるバージョンをインストールするには、 ``v2.6.1`` の文字列を使いたい Compose のバージョンに入れ替えます。

..    Test the installation.

4. インストールをテストします。

   .. code-block:: bash
   
      $ docker compose version
      Docker Compose version v2.6.1


.. seealso:: 

   Install Docker Compose CLI plugin
      https://docs.docker.com/compose/install/compose-plugin/

