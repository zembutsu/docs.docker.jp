.. -*- coding: utf-8 -*-
.. https://docs.docker.com/mac/step_one/
.. doc version: 1.10
.. check date: 2016/4/13
.. -----------------------------------------------------------------------------

.. Install Docker Toolbox on Mac OS X

.. _install-docker-toolbox-on-macos-x:

==================================================
Mac OS X に Docker Toolbox のインストール
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Mac OS X users use Docker Toolbox to install Docker software. Docker Toolbox includes the following Docker tools:

Mac OS X ユーザは Docker ツールボックス（Toolbox）を使い、Docker のソフトウェアをインストールできます。Docker ツールボックスには、以下の Docker ツール群が入っています。

..    Docker CLI client for running Docker Engine to create images and containers
    Docker Machine so you can run Docker Engine commands from Mac OS X terminals
    Docker Compose for running the docker-compose command
    Kitematic, the Docker GUI
    the Docker QuickStart shell preconfigured for a Docker command-line environment
    Oracle VM VirtualBox

* Docker CLI クライアントは Docker Engine（エンジン）でコンテナやイメージを作成。
* Docker Machine（マシン）は Mac OS X 端末から Docker Engine に命令。
* Docker Compose（コンポーズ）は ``docker-compose`` コマンドを実行。
* Kitematic（カイトマティック）は Docker の GUI。
* Docker QuickStart（クイックスタート）は Docker コマンドライン環境を設定済みのシェル。
* Oracle VM VirtualBox

.. Because the Docker Engine daemon uses Linux-specific kernel features, you can’t run Docker Engine natively in OS X. Instead, you must use the Docker Machine command, docker-machine, to create and attach to a small Linux VM on your machine. This VM hosts Docker Engine for you on your OS X system.

Docker Engine デーモンは LInux 特有の kernel 機能を使います。そのため、Windows では Docker Engine を直接操作できません。その代わりに ``docker-machine`` コマンドで自分のマシン上に小さな Linux 仮想マシンを作成し、そこに接続します。この仮想マシンは Mac システム上で Docker Engine を動かします。

.. Step 1: Check your version

.. _step1-check-your-version-mac:

ステップ１：バージョンの確認
==============================

.. Your Mac must be running OS X 10.8 “Mountain Lion” or newer to run Docker software. To find out what version of the OS you have:

Mac で Docker ソフトウェアを実行するには OS X 10.8 「Mountain Lion」以上のバージョンが必要です。OS のバージョンは次の手順で確認します。

..    Choose About this Mac from the Apple menu.

1. アップルのメニュー（画面左上の林檎マーク）から「この Mac について」をクリックします。

..    The version number appears directly below the words OS X.

画面上にある ``OS X`` の後ろ側にある文字がバージョン番号です。

..    If you have the correct version, go to the next step.

2. 適切なバージョンであれば、次のステップに進みます。

..    If you aren’t using a supported version, you could consider upgrading your operating system.

サポートしているバージョンでなければ、オペレーティング・システムのアップグレードをご検討ください。

.. Step 2: Install Docker Toolbox

.. _step2-install-docker-toolbox-mac:

ステップ２：Docker Toolbox のインストール
=========================================

.. Go to the Docker Toolbox.

1. `Docker Toolbox <https://www.docker.com/toolbox>`_ のページに移動します。

.. Click the installer link to download.

2. インストーラのリンクをクリックし、ダウンロードします。

.. Install Docker Toolbox by double-clicking the package or by right-clicking and choosing “Open” from the pop-up menu.

3. Docker Toolbox をインストールします。パッケージをダブル・クリックするか、右クリックして開いたポップアップ・メニューから「開く」を選びます。

.. The installer launches an introductory dialog, followed by an overview of what’s installed.

インストーラが起動すると、何をインストールするかの概要説明が表示されます。

.. Press Continue to install the toolbox.

4. Contine を押すと Toolbox のインストールに進みます。

.. The installer presents you with options to customize the standard installation.

インストーラ画面には標準インストール対象のカスタマイズが表示されます。

.. By default, the standard Docker Toolbox installation:

デフォルトは、標準的な Docker Toolbox のインストールです。

..    installs binaries for the Docker tools in /usr/local/bin
    makes these binaries available to all users
    updates any existing Virtual Box installation

* Docker ツール群のバイナリを ``/usr/local/bin`` にインストールします。
* これらのバイナリを、全てのユーザで利用可能にします。
* 既存の Virtual Box がインストールされていれば、更新します。

.. For now, don’t change any of the defaults.

現時点では、これらのデフォルトを変更しません。

.. Press Install to perform the standard installation.

5. Install を押して、標準インストールを進めます。

.. The system prompts you for your password.

画面上にはパスワード入力を促す画面が表示されます。

.. Provide your password to continue with the installation.

6. インストールを続けるためにパスワードを入力します。

.. When it completes, the installer provides you with some shortcuts. You can ignore this for now and click Continue.

インストールが終わると、ショートカットの作成を訊ねてきます。ここでは、このまま  Continue （続ける）を押します。

.. Then click Close to finish the installer.

そして Close を押してインストーラを終了します。

.. Step 3: Verify your installation

.. _step3-verify-your-installation-mac:

ステップ３：インストールの確認
==============================

.. To run a Docker container, you:

Docker コンテナを実行するには：

..    create a new (or start an existing) Docker Engine host running
    switch your environment to your new VM
    use the docker client to create, load, and manage containers

* 新しい Docker Engine のホストを作成します（あるいは、既存のホストを起動します）。
* 環境変数を新しい仮想マシンに切り替えます。
* ``docker`` クライアントを使い、コンテナの作成、読み込み、管理を行します。

.. Once you create a machine, you can reuse it as often as you like. Like any Virtual Box VM, it maintains its configuration between uses.

マシンを作成後は、必要な時に何度でも再利用できます。これは Virtual Box の仮想マシンと同様で、共通の設定を使います。

..    Open the Launchpad and locate the Docker Quickstart Terminal icon.

1. Launchpad を起動し、Docker Quickstart Terminal（クイックスタート・ターミナル）のアイコンを探します。

..    Click the icon to launch a Docker Quickstart  Terminal windows.

2. アイコンをクリックし、Docker Quickstart  ターミナル・ウインドウを起動します。

.. The terminal does a number of things to set up Docker Quickstart Terminal for you.

ターミナルでは、Docker ツールボックスがセットアップに関する様々な情報を表示します。

.. code-block:: bash

   Last login: Sat Jul 11 20:09:45 on ttys002
   bash '/Applications/Docker Quickstart Terminal.app/Contents/Resources/Scripts/start.sh'
   Get http:///var/run/docker.sock/v1.19/images/json?all=1&filters=%7B%22dangling%22%3A%5B%22true%22%5D%7D: dial unix /var/run/docker.sock: no such file or directory. Are you trying to connect to a TLS-enabled daemon without TLS?
   Get http:///var/run/docker.sock/v1.19/images/json?all=1: dial unix /var/run/docker.sock: no such file or directory. Are you trying to connect to a TLS-enabled daemon without TLS?
   -bash: lolcat: command not found
   
   mary at meepers in ~
   $ bash '/Applications/Docker Quickstart Terminal.app/Contents/Resources/Scripts/start.sh'
   Creating Machine dev...
   Creating VirtualBox VM...
   Creating SSH key...
   Starting VirtualBox VM...
   Starting VM...
   To see how to connect Docker to this machine, run: docker-machine env dev
   Starting machine dev...
   Setting environment variables for machine dev...
   
                           ##         .
                     ## ## ##        ==
                  ## ## ## ## ##    ===
              /"""""""""""""""""\___/ ===
         ~~~ {~~ ~~~~ ~~~ ~~~~ ~~~ ~ /  ===- ~~~
              \______ o           __/
                \    \         __/
                 \____\_______/
   
   The Docker Quick Start Terminal is configured to use Docker with the “default” VM.

.. Click your mouse in the terminal window to make it active.

3. ターミナル・ウインドウをマウスでクリックし、アクティブにします。

.. If you aren’t familiar with a terminal window, here are some quick tips.

..    If you aren’t familiar with a terminal window, here are some quick tips.

ターミナル画面に不慣れでしたら、ここで便利な使い方を紹介します。

..    The prompt is traditionally a $ dollar sign. You type commands into the command line which is the area after the prompt. Your cursor is indicated by a highlighted area or a | that appears in the command line. After typing a command, always press RETURN.

プロンプトとは一般的に ``$`` ドル記号です。このプロンプトの後にあるコマンドライン上でコマンドを入力します。コマンドライン上ではカーソルは ``|`` として表示されます。コマンドを入力した後は、常にリターン・キーを押します。

..    Type the docker run hello-world command and press RETURN.

4. ``docker run hello-world`` コマンドを実行し、リターン・キーを押します。

..    The command does some work for you, if everything runs well, the command’s output looks like this:

以下のコマンドは、何らかの処理を行うものです。正常に実行すると、画面には次のように表示されます。

.. code-block:: bash

   $ docker run hello-world
   Unable to find image 'hello-world:latest' locally
   latest: Pulling from library/hello-world
   535020c3e8ad: Pull complete
   af340544ed62: Pull complete
   Digest: sha256:a68868bfe696c00866942e8f5ca39e3e31b79c1e50feaee4ce5e28df2f051d5c
   Status: Downloaded newer image for hello-world:latest
   
   Hello from Docker.
   This message shows that your installation appears to be working correctly.
   
   To generate this message, Docker took the following steps:
   1. The Docker Engine CLI client contacted the Docker Engine daemon.
   2. The Docker Engine daemon pulled the "hello-world" image from the Docker Hub.
   3. The Docker Engine daemon created a new container from that image which runs the
      executable that produces the output you are currently reading.
   4. The Docker Engine daemon streamed that output to the Docker Engine CLI client, which sent it
      to your terminal.
   
   To try something more ambitious, you can run an Ubuntu container with:
   $ docker run -it ubuntu bash
   
   Share images, automate workflows, and more with a free Docker Hub account:
   https://hub.docker.com
   
   For more examples and ideas, visit:
   https://docs.docker.com/userguide/

.. Looking for troubleshooting help?

問題解決のヘルプをお探しですか？
========================================

.. Typically, the above steps work out-of-the-box, but some scenarios can cause problems. If your docker run hello-world didn’t work and resulted in errors, check out Troubleshooting for quick fixes to common problems.

通常、これらの手順は特に何も考えなくても実行できますが、もしかしたら問題が発生する場合があるかもしれません。 ``docker run hello-world`` が実行できずエラーになる場合は、一般的な問題を解決するための :doc:`トラブルシューティング </toolbox/troubleshoot>` をご覧ください。


.. Where to go next

次は何をしますか
====================

.. At this point, you have successfully installed the Docker software. Leave the Docker Quickstart Terminal window open. Now, go to the next page to read a very short introduction Docker images and containers.

以上で Docker ソフトウェアのインストールが完了しました。Docker Quickstart ターミナル画面は開いたままにします。次は :doc:`step_two` に進みます。

.. seealso:: 

   Install Docker for Windows
      https://docs.docker.com/mac/step_one/
