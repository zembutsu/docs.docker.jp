.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/docker-for-windows/
   doc version: 19.03
      https://github.com/docker/docker.github.io/blob/master/docker-for-mac/index.md
.. check date: 2020/06/11
.. Commits on Jun 1, 2020 59c3d309caed882e0681a15209adeed803ce7777
.. -----------------------------------------------------------------------------

.. Get started with Docker Desktop for Windows

.. _get-started-with-docker-desktop-for-windows:

========================================
Docker for Windows を始めよう
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Welcome to Docker Desktop!

Docker Desktop へようこそ！

.. The Docker Desktop for Mac section contains information about the Docker Desktop Community Stable release. For information about features available in Edge releases, see the Edge release notes. For information about Docker Desktop Enterprise (DDE) releases, see Docker Desktop Enterprise.

*Docker Desktop  for Mac* のセクションは、Docker Desktop コミュニティ安定版リリース（Community Stable release）に関する情報を扱います。エッジリリース（Edge release）に関する情報は、  :doc:`Edge リリースノート <edge-release-notes>` を御覧ください。Docker デスクトップ・エンタープライズ（DDE）リリースに関する情報は `Docker Desktop Enterprise <https://docs.docker.com/ee/desktop/>`_ を御覧ください。

.. Docker is a full development platform to build, run, and share containerized applications. Docker Desktop is the best way to get started with Docker on Windows.

Docker とは、コンテナ化したアプリケーションを構築・実行・共有するための、全てが揃った開発プラットフォームです。Windows 上で Docker を使い始めるためには、Docker Desktop が最も良い方法です。

.. See Install Docker Desktop for download information, system requirements, and installation instructions.

ダウンロード情報、システム要件、インストール手順については、  :doc:`Docker Desktop のインストール <install>` を御覧ください。

.. Test your installation

.. _win-test-your-installation:

インストールの確認
====================

..    Open a terminal window (Command Prompt or PowerShell, but not PowerShell ISE).

1. ターミナルウインドウを開きます（コマンドプロンプトか PowerShell ですが、PowerShell ISE は除く）。

..    Run docker --version to ensure that you have a supported version of Docker:

2. `docker --version` を実行し、サポート対象の Docker かどうかを確認します。

.. code-block:: bash

   > docker --version
   
   Docker version 19.03.1

..    Pull the hello-world image from Docker Hub and run a container:

3.　`hello-world イメージ <https://hub.docker.com/r/library/hello-world/>`_ を Docker Hub から取得し、コンテナとして実行します。

.. code-block:: bash

   > docker run hello-world
   
   docker : Unable to find image 'hello-world:latest' locally
   latest: Pulling from library/hello-world
   1b930d010525: Pull complete
   Digest: sha256:c3b4ada4687bbaa170745b3e4dd8ac3f194ca95b2d0518b417fb47e5879d9b5f
   Status: Downloaded newer image for hello-world:latest
   
   Hello from Docker!
   This message shows that your installation appears to be working correctly.
   ...

..    List the hello-world image that was downloaded from Docker Hub:

4.　Docker Hub からダウンロードした :code:`hello-world` イメージを、一覧から確認します。

.. code-block:: bash

   > docker image ls

..    List the hello-world container (that exited after displaying “Hello from Docker!”):

5.　:code:`hello-world` コンテナを一覧に表示します（"Hello from Docker!" を表示した後、終了 exited しています）。

.. code-block:: bash

   > docker container ls --all

..    Explore the Docker help pages by running some help commands:

.. code-block:: bash

   > docker --help
   > docker container --help
   > docker container ls --help
   > docker run --help

.. Explore the application

.. _win-explore-the-application:

アプリケーションの探索
==============================

.. In this section, we demonstrate the ease and power of Dockerized applications by running something more complex, such as an OS and a webserver.

このセクションでは、OS やウェブサーバといった複雑なアプリケーションを実行し、Docker 化アプリケーションの簡易さと威力をお見せします。

..    Pull an image of the Ubuntu OS and run an interactive terminal inside the spawned container:

1. `Ubuntu OS <https://hub.docker.com/r/_/ubuntu/>`_ のイメージを取得し、作成したコンテナ内で、双方向（インタラクティブ）のターミナルを実行します。

.. code-block:: bash

   > docker run --interactive --tty ubuntu bash
   
   docker : Unable to find image 'ubuntu:latest' locally
   latest: Pulling from library/ubuntu
   22e816666fd6: Pull complete
   079b6d2a1e53: Pull complete
   11048ebae908: Pull complete
   c58094023a2e: Pull complete
   Digest: sha256:a7b8b7b33e44b123d7f997bd4d3d0a59fafc63e203d17efedf09ff3f6f516152
   Status: Downloaded newer image for ubuntu:latest

..        Do not use PowerShell ISE

..        Interactive terminals do not work in PowerShell ISE (but they do in PowerShell). See docker/for-win/issues/223.

.. note::

   **PowerShell ISE を使用しないでください** 
   双方向ターミナルは PowerShell ISE では動作しません（PowerShell では動作します）。詳細は `docker/for-win/issues/223 <https://github.com/docker/for-win/issues/223>`_ を御覧ください

..    You are in the container. At the root # prompt, check the hostname of the container:

2.　コンテナの中にいます。ルート :code:`#` プロンプト上で、コンテナの :code:`hostname` （ホスト名）を確認します。

.. code-block:: bash

   root@8aea0acb7423:/# hostname
   8aea0acb7423

..    Notice that the hostname is assigned as the container ID (and is also used in the prompt).

ホスト名には、コンテナ ID が割り当てられているのに注目します（プロンプトでもホスト名にコンテナ ID が用いられています）。

..    Exit the shell with the exit command (which also stops the container):

3.　:code:`exit` コマンドでシェルを終了します（また、コンテナも停止します）。

.. code-block:: bash

   root@8aea0acb7423:/# exit
   >

..    List containers with the --all option (because no containers are running).

4.　 :code:`--all` オプションを付けて、コンテナ一覧を表示します（実行中のコンテナが存在しないからです）。

..    The hello-world container (randomly named, relaxed_sammet) stopped after displaying its message. The ubuntu container (randomly named, laughing_kowalevski) stopped when you exited the container.

:code:`hello-world` コンテナ（ランダムに :code:`relaxed_sammet` と名前付け）は、自身のメッセージを表示した後、停止しました（stopped）。 :code:`ubuntu` コンテナ（ランダムに :code:`laughing_kowalevski` と名前付け）は、コンテナから抜け出た（exit）ので停止しました（stopped）。

.. code-block:: bash

   > docker container ls --all
   
   CONTAINER ID    IMAGE          COMMAND     CREATED          STATUS                      PORTS    NAMES
   8aea0acb7423    ubuntu         "bash"      2 minutes ago    Exited (0) 2 minutes ago             laughing_kowalevski
   45f77eb48e78    hello-world    "/hello"    3 minutes ago    Exited (0) 3 minutes ago             relaxed_sammet

..    Pull and run a Dockerized nginx web server that we name, webserver:

5.　Docker 化した `nginx <https://hub.docker.com/_/nginx/>`_ （エンジンエックス）ウェブ・サーバを取得・実行し、 :code:`webserver` と名付けます。

.. code-block:: bash

   > docker run --detach --publish 80:80 --name webserver nginx
   
   Unable to find image 'nginx:latest' locally
   latest: Pulling from library/nginx
   
   fdd5d7827f33: Pull complete
   a3ed95caeb02: Pull complete
   716f7a5f3082: Pull complete
   7b10f03a0309: Pull complete
   Digest: sha256:f6a001272d5d324c4c9f3f183e1b69e9e0ff12debeb7a092730d638c33e0de3e
   Status: Downloaded newer image for nginx:latest
   dfe13c68b3b86f01951af617df02be4897184cbf7a8b4d5caf1c3c5bd3fc267f

..    Point your web browser at http://localhost to display the nginx start page. (You don’t need to append :80 because you specified the default HTTP port in the docker command.)

6.　ウェブ・ブラウザで :code:`http://localhost` を指定し、nginx のスタートページを開きます（ :code:`:80` を追加する必要はありません。 :code:`docker` コマンドで標準の HTTP ポートを指定したからです）。

..    Run nginx edge

..    List only your running containers:

7.　実行中（ *running* ）のコンテナのみを一覧表示します。

.. code-block:: bash

   > docker container ls
   
   CONTAINER ID    IMAGE    COMMAND                   CREATED          STATUS          PORTS                 NAMES
   0e788d8e4dfd    nginx    "nginx -g 'daemon of…"    2 minutes ago    Up 2 minutes    0.0.0.0:80->80/tcp    webserver

..    Stop the running nginx container by the name we assigned it, webserver:

8.　実行中の nginx コンテナを停止するために、割り当てた :code:`webserver` の名前を使います。

.. code-block:: bash

   >  docker container stop webserver

..    Remove all three containers by their names -- the latter two names will differ for you:

9.　3つのコンテナ全てを、名前で削除します。後ろにある２つの名前は、おそらく皆さんの環境とは異なるでしょう。

.. code-block:: bash

   > docker container rm webserver laughing_kowalevski relaxed_sammet


.. Docker Settings dialog

.. _docker-desktop-for-win-settings:

Docker 設定ダイアログ
==============================

.. The Docker Desktop menu allows you to configure your Docker settings such as installation, updates, version channels, Docker Hub login, and more.

**Docker Desktop のメニュー** から、インストール、アップデート、バージョンチャンネル、Docker Hub へのログインなど、Docker の設定ができます。

.. This section explains the configuration options accessible from the Settings dialog.

このセクションでは、 **Settings** （設定）画面から設定できるオプションについて説明します。

..    Open the Docker Desktop menu by clicking the Docker icon in the Notifications area (or System tray):

1.　Docker Desktop のメニューを開くには、通知エリア（又はシステムトレイ）にある Docker アイコンをクリックします。

..    Showing hidden apps in the taskbar

2.　設定画面から **Settings** （設定）を選びます。

..    Select Settings to open the Settings dialog:

.. General

.. _win-general:

General（一般的な設定）
------------------------------

.. On the General tab, you can configure when to start and update Docker:

設定画面の **General** タブでは、Docker の起動と更新を設定できます。

.. Start Docker when you log in - Automatically start Docker Desktop upon Windows system login.

* **Start Docker when you log in** - Windows システムのログイン時、自動的に Docker Desktop を起動します。

..    Automatically check for updates: By default, Docker Desktop automatically checks for updates and notifies you when an update is available. You can manually check for updates anytime by choosing Check for Updates from the main Docker menu.

* **Automatically check for updates** - デフォルトでは、Docker Desktop は自動的に更新を確認し、更新版が利用可能な場合は通知します。承諾して更新版をインストールするには **OK** をクリックします（あるいは、現在のバージョンを維持する場合は、キャンセルします）。メインの Docker メニューから **Check for Updates** （更新を確認）で、手動での更新ができます。

.. Expose daemon on tcp://localhost:2375 without TLS - Click this option to enable legacy clients to connect to the Docker daemon. You must use this option with caution as exposing the daemon without TLS can result in remote code execution attacks.

* **Expose daemon on tcp://localhost:2357 without TLS** - レガシー（古い）クライアントが Docker デーモンに接続できるようにするには、このオプションを有効化します。このオプションを使う場合は注意が必要です。TLS なしでデーモンを公開する場合は、リモートからのコード実行攻撃をもたらす可能性があるためです。

..    Send usage statistics: Docker Desktop sends diagnostics, crash reports, and usage data. This information helps Docker improve and troubleshoot the application. Clear the check box to opt out.

* **Send usage statics** - デフォルトでは、Docker Desktop は診断情報・クラッシュ報告・利用データを送信します。この情報は、 Docker の改善やアプリケーションの問題解決に役立ちます。止めるにはチェックボックスを空にします。Docker は定期的に更なる情報を訊ねるかもしれません。

..    Click Switch to the Edge version to learn more about Docker Desktop Edge releases.

**Switch to the Edge version** （Edge バージョンの切り替え）をクリックすると、Docker Desktop Edge リリースに関する情報を学べます。

.. Resources:

.. _win-resources:

Resources（リソース）
------------------------------

.. The Resources tab allows you to configure CPU, memory, disk, proxies, network, and other resources.

.. Advanced

.. _win-resources-advanced:

ADVANCED（高度な設定）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. Use the Advanced tab to limit resources available to Docker.

**Advanced** タブでは、 Docker が利用できるリソースに制限をかけます。

.. Advanced settings are:

Advanced 設定とは、

.. CPUs: By default, Docker Desktop is set to use half the number of processors available on the host machine. To increase processing power, set this to a higher number; to decrease, lower the number.

- **CPUs** （CPU）: デフォルトでは、 ホスト・マシン上で利用可能なプロセッサ数の半分を、Docker Desktop が使います。処理能力を向上するには、この値を高くします。減らすには、数値を低くします。

.. Memory: By default, Docker Desktop is set to use 2 GB runtime memory, allocated from the total available memory on your Mac. To increase the RAM, set this to a higher number. To decrease it, lower the number.

- **Memory** （メモリ）: デフォルトでは、 マシン上で利用可能な全メモリから `2` GB の実行メモリを使用する設定です。RAM を増やすには、この値を高くします。減らすには、値を低くします。

.. Swap: Configure swap file size as needed. The default is 1 GB.

- **Swap** （スワップ）: 必要になるスワップ・ファイル容量を設定します。デフォルトは 1 GB です。

.. Disk image size: Specify the size of the disk image.

- **Disk image size** （ディスク・イメージ容量）: ディスク・イメージの容量を指定します。

.. Disk image location: Specify the location of the Linux volume where containers and images are stored.

- **Disk image location** （ディスク・イメージの場所）: Linux ボリュームの場所を指定します。ここにコンテナとイメージを置きます。

.. You can also move the disk image to a different location. If you attempt to move a disk image to a location that already has one, you get a prompt asking if you want to use the existing image or replace it.

また、ディスク・イメージは別の場所に移動できます。ディスク・イメージの指定先に既にイメージがある場合は、既存のイメージを使うか置き換えるか訊ねる画面を表示します。

.. FILE SHARING

.. _win-preferences-file-sharing:

FILE SHARING（ファイル共有）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. Use File sharing to allow local drives on Windows to be shared with Linux containers. This is especially useful for editing source code in an IDE on the host while running and testing the code in a container. Note that configuring file sharing is not necessary for Windows containers, only Linux containers. If a drive is not shared with a Linux container you may get file not found or cannot start service errors at runtime. See Volume mounting requires shared drives for Linux containers.

Linux コンテナと共有したいローカルのディレクトリを選択します。ファイル共有は Linux コンテナ内でボリュームをマウントするために必要であり、Windows コンテナ用ではありません。 :ref:`Linux コンテナ <switch-between-windows-and-linux-containers>`では、Dockerfile とボリュームを保管するための場所として、ドライブの共有が必要です。指定がなければ、実行時に :code:`file not found` （ファイルが見つかりません）や :code:`cannot start service` （サービスを開始できません）のエラーが出ます。詳しくは :ref:`volume-mounting-requires-shared-drives-for-linux-containers` を御覧ください。

.. Apply & Restart makes the drives available to containers using Docker’s bind mount (-v) feature.

コンテナに共有したいローカル・ドライブを指定したら、 Docker Desktop は Windows システム（ドメイン）のユーザ名とパスワードの入力を求めます。認証情報を入力の後、 **Apply & Restart** （適用と再起動）をクリックします。

..    Tips on shared drives, permissions, and volume mounts

**共有ドライブ、権限、ボリューム・マウントに役立つ情報**

..        Shared drives are designed to allow application code to be edited on the host while being executed in containers. For non-code items such as cache directories or databases, the performance will be much better if they are stored in the Linux VM, using a data volume (named volume) or data container.

* Shared drive（共有ドライブ）とはコンテナの実行時、ホスト上にあるアプリケーションのコードを編集できるようにするための設計です。キャッシュ・ディレクトリやデータベースのようなコード以外のものは、 :doc:`データ・ボリューム </storage/volume>` （名前付きボリューム）や :doc:`データ・コンテナ </storage/volume>`を使う場合に、 Linux 仮想マシンに保管するよりもパフォーマンスは向上するでしょう。

..        Docker Desktop sets permissions to read/write/execute for users, groups and others 0777 or a+rwx. This is not configurable. See Permissions errors on data directories for shared volumes.

* Docker Desktop はユーザ、グループ、その他に対する読み込み／書き込み／実行権限を `0777 あるいは a+rwx <http://permissions-calculator.org/decode/0777/>`_  に設定します。これは調整できません。詳細は :ref:`win-permissions-errors-on-data-directories-for-shared-volumes` を御覧ください。

..        Windows presents a case-insensitive view of the filesystem to applications while Linux is case-sensitive. On Linux it is possible to create 2 separate files: test and Test, while on Windows these filenames would actually refer to the same underlying file. This can lead to problems where an app works correctly on a developer Windows machine (where the file contents are shared) but fails when run in Linux in production (where the file contents are distinct). To avoid this, Docker Desktop insists that all shared files are accessed as their original case. Therefore if a file is created called test, it must be opened as test. Attempts to open Test will fail with “No such file or directory”. Similarly once a file called test is created, attempts to create a second file called Test will fail.

* Linux が大文字小文字を区別している場合に限り、Windows はアプリケーションが見えるファイルシステムで大文字小文字を区別できるように表示します。Linux 上では :code:`test` と :code:`Test` という2つの異なるファイルを作成できますが、Windows 上では各ファイルは実際には同じファイルが基になります。これは開発者の Windows マシン上では（コンテンツを共有している場合に）アプリケーションの動作に問題を引き起こす可能性がある程度です。しかし、プロダクションにおける Linux では問題が発生するでしょう（ファイルが明確に識別されるため）。これを避けるためには、Docker Desktop に対して全ての共有ファイルをオリジナル通りにアクセスするよう要求します。つまり、 :code:`test` というファイルを作成したら、必ず :code:`test`  で開くようにします。 :code:`Test`  というファイルを開こうとしても、 "No such file or directry" となり失敗します。似たようなものつぃて、 :code:`test` というファイルを作成したら、次に :code:`Test` ファイルを作成しようとしても失敗します。

.. Shared drives on demand

.. _win-shared-drives-on-demand:

SHARED DRIVES ON DEMAND（オンデマンド共有ドライブ）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. You can share a drive “on demand” the first time a particular mount is requested.

個々のマウントが必要な場合、初回に "オンデマンド" でドライブを共有できます。

.. If you run a Docker command from a shell with a volume mount (as shown in the example below) or kick off a Compose file that includes volume mounts, you get a popup asking if you want to share the specified drive.

シェルでボリューム・マウント（以下に例があります）する Docker コマンドの実行時や、Compose ファイルで立ち上げ時にボリューム・マウントがあれば、特定のドライブを共有するかどうか訊ねるポップアップが現れます。

.. You can select to Share it, in which case it is added your Docker Desktop Shared Drives list and available to containers. Alternatively, you can opt not to share it by selecting Cancel.

**Share it** （共有する）を選択でき、Docker Desktop の「共有ドライブ一覧」にあるいずれかを、コンテナで利用可能になります。あるいは、共有したくない場合には **Cancel** （中止）を選べます。

.. Shared drive on demand

.. PROXIES

.. _win-preferences-proxies:

PROXIES（プロキシ）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. Docker Desktop lets you configure HTTP/HTTPS Proxy Settings and automatically propagates these to Docker and to your containers. For example, if you set your proxy settings to http://proxy.example.com, Docker uses this proxy when pulling containers.

Docker Desktop は、HTTP/HTTPS プロキシ設定を調整し、自動的に Docker とコンテナに対して情報を伝達（propagate）します。例えば、 `http://proxy.example.com` に対してプロキシ設定をすると、Docker はコンテナの取得時にこのプロキシを使います。

.. When you start a container, your proxy settings propagate into the containers. For example:

コンテナが実行中であれば、コンテナ内にプロキシ設定が伝わっているかどうか確認できます。例：

.. code-block:: bash

   $ docker run -it alpine env
   PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   HOSTNAME=b7edf988b2b5
   TERM=xterm
   HOME=/root
   HTTP_PROXY=http://proxy.example.com:3128
   http_proxy=http://proxy.example.com:3128
   no_proxy=*.local, 169.254/16

.. In the output above, the HTTP_PROXY, http_proxy, and no_proxy environment variables are set. When your proxy configuration changes, Docker restarts automatically to pick up the new settings. If you have containers that you wish to keep running across restarts, you should consider using restart policies.

こちらの結果では、 `HTTP_PROXY` 、 `http_proxy`  、 `no_proxy` 環境変数が設定されているのが分かります。プロキシ設定を変更した場合は、新しい設定を適用するために、Docker は自動的に再起動します。再起動後もコンテナを実行し続けたい場合には、 :ref:`再起動ポリシー <restart-policies-restart>` の利用を検討すべきでしょう。

.. Network

.. _win-preferences-network:

NETWORK （ネットワーク）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. You can configure Docker Desktop networking to work on a virtual private network (VPN). Specify a network address translation (NAT) prefix and subnet mask to enable Internet connectivity.

Docker Desktop のネットワーク機能を、仮想プライベート・ネットワーク（VPN）でも機能するように設定できます。インターネットとの疎通を有効にするには、ネットワーク・アドレス変換（NAT）プリフィックスとサブネットマスクを設定します。

.. DNS Server: You can configure the DNS server to use dynamic or static IP addressing.

**DNS Server** （DNS サーバ） : DNS サーバには、動的 IP アドレスか固定 IP アドレスを設定できます。

..    Note: Some users reported problems connecting to Docker Hub on Docker Desktop Stable version. This would manifest as an error when trying to run docker commands that pull images from Docker Hub that are not already downloaded, such as a first time run of docker run hello-world. If you encounter this, reset the DNS server to use the Google DNS fixed address: 8.8.8.8. For more information, see Networking issues in Troubleshooting.

.. note::

   何人かの利用者から、 Docker Desktop の安定バージョンで Docker Hub との通信問題が報告されています。これは `docker` コマンドの実行を試みるとき、Docker Hub からイメージを未ダウンロードであれば、エラーが確実に発生します。例えば、 `docker run hello-world` の初回実行時です。このような現象になれば、DNS サーバをリセットし、Google DNS の固定アドレス `8.8.8.8`  を指定します。詳しい情報は「ネットワーク機能の問題」にあるトラブルシューティングを御覧ください。

.. Updating these settings requires a reconfiguration and reboot of the Linux VM.

以上の情報の更新するには、設定の変更と Linux 仮想マシンの再起動が必要です。

.. Docker Engine

.. _win-docker-engine:

Docker Engine （Docker エンジン）
----------------------------------------

.. The Docker Engine page allows you to configure the Docker daemon to determine how your containers run.

Docker Engine のページでは、Docker デーモンの設定や、どのようにしてコンテナを実行するかを決められます。

.. Type a JSON configuration file in the box to configure the daemon settings. For a full list of options, see the Docker Engine dockerd commandline reference.

デーモンの設定をするには、テキストボックス内に JSON 形式の設定ファイルとして入力します。オプションの一覧については、 Docker Engine の :doc:`dockerd コマンドライン・リファレンス </engine/reference/commandline/dockerd>` を御覧ください。

.. Click Apply & Restart to save your settings and restart Docker Desktop.

**Apply & Restart** （適用と再起動）をクリックし、設定を保存して Docker Desktop を再起動します。

.. Command Line

.. _win-command-line:

Command Line （コマンドライン）
----------------------------------------

.. On the Command Line page, you can specify whether or not to enable experimental features.

コマンドラインのページでは、experimental features（実験的機能）を有効にするかどうかを指定できます。

.. On both Docker Desktop Edge and Stable releases, you can toggle the experimental features on and off. If you toggle the experimental features off, Docker Desktop uses the current generally available release of Docker Engine.

Docker Desktop  Edge と Stable リリースのいずれでも、実験的機能の有効化と無効化を切り替えできます。実験的機能を無効化すると、Docker Desktop は現時点の Docker エンジン安定版リリースを使います。

.. Experimental features

.. _win-desktop-experimental-features:

EXPERIMENTAL FEATURES
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. Docker Desktop Edge releases have the experimental version of Docker Engine enabled by default, described in the Docker Experimental Features README on GitHub.

Docker Desktop  Edge リリースは、デフォルトで Docker エンジンの実験的なバージョンが有効です。詳細は Git Hub 上の [Docker 実験的機能 README（英語）](https://github.com/docker/cli/blob/master/experimental/README.md) を御覧ください。

.. Experimental features provide early access to future product functionality. These features are intended for testing and feedback only as they may change between releases without warning or can be removed entirely from a future release. Experimental features must not be used in production environments. Docker does not offer support for experimental features.

実験的機能は、今後提供する機能を先行利用できます。各機能は、テストやフィードバックを意図した、参考程度のものです。そのため、リリース時までに警告が出たり、今後のリリースでは削除されたりする場合があります。本番向けの環境では、実験的機能を決して使わないでください。Docker は実験的機能に対するサポートを提供していません。

..    To enable experimental features in the Docker CLI, edit the config.json file and set experimental to enabled.
    To enable experimental features from the Docker Desktop menu, click Settings (Preferences on macOS) > Command Line and then turn on the Enable experimental features toggle. Click Apply & Restart.

.. attention::

   Docker コマンドラインツールで実験的機能を有効にするには、 :code:`config.json` ファイルを編集し、 :code:`experimental` を有効化するよう指定します。

   Docker Desktop のメニューから実験的機能を有効にするには、 **Settings** （設定） → **Command Line**  （コマンドライン）をクリックし、 **Enable experimental features** （実験的機能の有効化）ボタンを押します。 **Apply & Restart** （適用と再起動）をクリックします。

.. For a list of current experimental features in the Docker CLI, see Docker CLI Experimental features.

Docker Desktop  Edge リリースは、デフォルトで Docker エンジンの実験的なバージョンが有効です。詳細は Git Hub 上の `Docker 実験的機能 README（英語） <https://github.com/docker/cli/blob/master/experimental/README.md>`_ を御覧ください。

.. Run docker version to verify whether you have enabled experimental features. Experimental mode is listed under Server data. If Experimental is true, then Docker is running in experimental mode, as shown here:

実験的機能が有効かどうかを確認するには、 :code:`docker version` を実行します。実験的モードは :code:`Server` データ下の一覧に状態があります。もしも以下のように :code:`Experimental` （実験的）が :code:`true` （真）であれば、Docker は実験的モードで動作しています。（  :code:`false` であれば、実験的機能なオフです）

.. code-block:: bash

   > docker version
   
   Client: Docker Engine - Community
    Version:           19.03.1
    API version:       1.40
    Go version:        go1.12.5
    Git commit:        74b1e89
    Built:             Thu Jul 25 21:18:17 2019
    OS/Arch:           darwin/amd64
    Experimental:      true
   
   Server: Docker Engine - Community
    Engine:
     Version:          19.03.1
     API version:      1.40 (minimum version 1.12)
     Go version:       go1.12.5
     Git commit:       74b1e89
     Built:            Thu Jul 25 21:17:52 2019
     OS/Arch:          linux/amd64
     Experimental:     true
    containerd:
     Version:          v1.2.6
     GitCommit:        894b81a4b802e4eb2a91d1ce216b8817763c29fb
    runc:
     Version:          1.0.0-rc8
     GitCommit:        425e105d5a03fabd737a126ad93d62a9eeede87f
    docker-init:
     Version:          0.18.0
     GitCommit:        fec3683

.. Kubernetes

.. _win-kubernetes:

Kubernetes
--------------------

.. Docker Desktop includes a standalone Kubernetes server that runs on your Mac, so that you can test deploying your Docker workloads on Kubernetes.

Docker Desktop には単独の Kubernetes サーバを含みます。Kubernetes は Mac ホスト上で実行できますので、Kubernetes 上に Docker ワークロードを試験的にデプロイできます。

.. The Kubernetes client command, kubectl, is included and configured to connect to the local Kubernetes server. If you have kubectl already installed and pointing to some other environment, such as minikube or a GKE cluster, be sure to change context so that kubectl is pointing to docker-desktop:

Kubernetes クライアント・コマンドの `kubectl` が組み込まれており、ローカルの Kubernetes サーバに接続するよう設定済みです。もしも既に :code:`kubectl` をインストール済みで、 :code:`minikube`  や GKE クラスタのような他の環境を向いている場合は、 :code:`kubectl` が  :code:`docker-for-desktop` を指し示すように切り替わっているかどうか確認します。

.. code-block:: bash

   $ kubectl config get-contexts
   $ kubectl config use-context docker-desktop

.. If you installed kubectl with Homebrew, or by some other method, and experience conflicts, remove /usr/local/bin/kubectl.

もしも :code:kubectl` を Homebrew でインストールする場合や、他の手法を使うかして、何らかの競合が発生する場合は :code:`/usr/local/bin/kubectl` を削除します。

..     To enable Kubernetes support and install a standalone instance of Kubernetes running as a Docker container, select Enable Kubernetes. To set Kubernetes as the default orchestrator, select Deploy Docker Stacks to Kubernetes by default.

* Kubernetes サポートを有効化し、Kubernetes の独立したインスタンスを Docker コンテナとしてインストールするには、 **Enable Kubernetes** （Kubernetes 有効化）をクリックします。Kubernetes を :ref:`デフォルトのオーケストレータ <win-override-default-orchestrator>` に指定するには、 **Deploy Docker Stack to Kubernetes by default** を選択します。

.. By default, Kubernetes containers are hidden from commands like docker service ls, because managing them manually is not supported. To make them visible, select Show system containers (advanced). Most users do not need this option.

デフォルトで、Kubernetes コンテナは :code:`docker service ls` のようなコマンドで非表示です。この理由は、手動での（Kubernetes）管理がサポートされていないからです。これらを表示するには **Show system containers (advances)** （システムコンテナの表示〔高度〕）を選びます。多くの利用者には不要なオプションです。

..    Click Apply & Restart to save the settings. This instantiates images required to run the Kubernetes server as containers, and installs the /usr/local/bin/kubectl command on your Mac.

**Apply & Restart** （適用と再起動）をクリックし、設定を保存します。 Kubernetes サーバをコンテナとして実行するために必要なイメージが実体化（インスタンス化）され、 `/usr/local/bin/kubectl` コマンドが Mac 上にインストールされます。

.. When Kubernetes is enabled and running, an additional status bar item displays at the bottom right of the Docker Desktop Settings dialog. The status of Kubernetes shows in the Docker menu and the context points to docker-desktop.

* Kubernetes を有効化して実行している場合は、Docker Desktop 設定ダイアログの右横に、ステータス・バーの追加アイテムを表示します。Docker メニューの Kubernetes のステータスは、作業対象を `docker-desktop` と表示します。

.. To disable Kubernetes support at any time, clear the Enable Kubernetes check box. The Kubernetes containers are stopped and removed, and the /usr/local/bin/kubectl command is removed.

* **Enable Kubernetes** （Kubernetes 有効化）のチェックボックスをクリアしたら、Kubernetes サポートはいつでも無効にできます。無効により、この Kubernetes コンテナを停止及び削除し、 `/usr/local/bin/kubectl` コマンドも削除します。

.. To delete all stacks and Kubernetes resources, select Reset Kubernetes Cluster.

* 全てのスタックと Kubernetes リソースを削除するには、 **Reset Kubernetes Cluster** （Kubernetes クラスタのリセット）を選びます。

.. If you installed kubectl by another method, and experience conflicts, remove it.

* 他の方法で `kubectl` をインストールした場合は、競合が発生し、削除されます。

..    For more about using the Kubernetes integration with Docker Desktop, see Deploy on Kubernetes.

Docker Desktop で Kubernetes 統合機能を使う詳しい情報は、 :doc:`Kubernetes 上にデプロイ <kubernetes>` をご覧ください。

.. Reset

.. _win-preference-reset:

リセット
--------------------

..    Reset and Restart options
..    On Docker Desktop Mac, the Restart Docker Desktop, Reset to factory defaults, and other reset options are available from the Troubleshoot menu.

.. note::

   **リセットと再起動オプション** 
   
   Docker Desktop Mac では、 **Troubleshoot** （トラブルシュート）のメニュー上から、 **Restart Docker Desktop** （Dockerデスクトップの再起動）と **Reset to factory defaults** （初期値にリセットする）オプションを利用できます。

.. For information about the reset options, see Logs and Troubleshooting.

詳しい情報は :doc:`troubleshoot` を御覧ください。

.. Troubleshoot

.. _win-desktop-troubleshoot:

トラブルシュート
^^^^^^^^^^^^^^^^^^^^

.. Visit our Logs and Troubleshooting guide for more details.

詳細は:doc:`troubleshoo`: ガイドを御覧ください。

.. Log on to our Docker Desktop for Windows forum to get help from the community, review current user topics, or join a discussion.

`Docker Desktop  for Windows フォーラム（英語） <https://forums.docker.com/c/docker-for-windows>`_ にログオンしたら、コミュニティからの手助けを得たり、利用者のトピックを参照したり、議論に参加できます。

.. Log on to Docker Desktop for Windows issues on GitHub to report bugs or problems and review community reported issues.

`GitHub 上の Docker Desktop for Windows issues（英語） <https://github.com/docker/for-win/issues>_ にログオンし、バグや問題の報告や、コミュニティに報告された問題を参照できます。

.. For information about providing feedback on the documentation or update it yourself, see Contribute to documentation.

ドキュメントに対するフィードバックの仕方や自分で更新するには `ドキュメント貢献（英語） <https://docs.docker.com/opensource/>_ を御覧ください。

.. Switch between Windows and Linux containers

.. _switch-between-windows-and-linux-containers:

Windows と Linux コンテナとの切り替え
========================================

.. From the Docker Desktop menu, you can toggle which daemon (Linux or Windows) the Docker CLI talks to. Select Switch to Windows containers to use Windows containers, or select Switch to Linux containers to use Linux containers (the default).

Docker Desktop のメニューから、Docker CLI が通信するデーモン（Linux か Windows）を切り替えできます。 **Switch to Windows containers** （Windows コンテナへ切り替え）を選ぶと Windows コンテナを使います。又は、 **Switch to Linux containers** （Linux コンテナへ切り替え）を選ぶと Linux コンテナを使います（こちらがデフォルト）。

.. For more information on Windows containers, refer to the following documentation:

Windows コンテナに関する詳しい情報は、以下のドキュメントを参照ください（※リンク先はいずれも英語）。

..    Microsoft documentation on Windows containers.

* `Windows containers <https://docs.microsoft.com/en-us/virtualization/windowscontainers/about/index>`_ にあるマイクロソフトのドキュメント

..    Build and Run Your First Windows Server Container (Blog Post) gives a quick tour of how to build and run native Docker Windows containers on Windows 10 and Windows Server 2016 evaluation releases.

* `Build and Run Your First Windows Server Container (ブログ投稿）  <https://blog.docker.com/2016/09/build-your-first-docker-windows-server-container/`_ では、Windows 10 と Windows Server 2016 evaluation リリースで、ネイティブな Docker Windows コンテナを構築・実行するクイック・ツアーを提供しています。

..    Getting Started with Windows Containers (Lab) shows you how to use the MusicStore application with Windows containers. The MusicStore is a standard .NET application and, forked here to use containers, is a good example of a multi-container application.

* `Getting Start with Windows Containers(Lab)（英語） <https://github.com/docker/labs/blob/master/windows/windows-containers/README.md>_ では、 `MusicStore <https://github.com/aspnet/MusicStore/blob/dev/README.md>`_ の Windows コンテナ アプリケーションの使い方を紹介します。MusicStore は標準的な .NET アプリケーションであり、  `コンテナを使うものをコチラからフォーク <https://github.com/friism/MusicStore>`_ できます。これは複数コンテナ・アプリケーションの良い例です。

..    To understand how to connect to Windows containers from the local host, see Limitations of Windows containers for localhost and published ports

* ローカルホストから Windows コンテナに対して接続する方法を理解するには、 :ref:`limitations-of-windows-containers-for-localhost-and-published-ports` をご覧ください。

..    Settings dialog changes with Windows containers

..    When you switch to Windows containers, the Settings dialog only shows those tabs that are active and apply to your Windows containers:

..    General
    Proxies
    Daemon
    Reset

.. tips::

   **Windows コンテナでの設定ダイアログ変更について** 。Windows コンテナに切り替えると、設定ダイアログは WIndows コンテナに対して適用できる、以下のタブのみ表示します。
   
   * General
   * Proxies
   * Daemon
   * Reset

.. If you set proxies or daemon configuration in Windows containers mode, these apply only on Windows containers. If you switch back to Linux containers, proxies and daemon configurations return to what you had set for Linux containers. Your Windows container settings are retained and become available again when you switch back.

Windows コンテナモードでプロキシやデーモンの設定を行っても、それらが適用されるのは Windows コンテナに対してのみです。Linux コンテナに設定を切り戻すと、プロキシとデーモンの設定は Linux コンテナ用に設定していたものに戻ります。Windows コンテナの設定は保持されていますので、再び切り替えると Windows コンテナ向けの設定で利用できます。

.. Dashboard

.. _win-dashboard:

ダッシュボード
====================

.. The Docker Desktop Dashboard enables you to interact with containers and applications and manage the lifecycle of your applications directly from your machine. The Dashboard UI shows all running, stopped, and started containers with their state. It provides an intuitive interface to perform common actions to inspect and manage containers and existing Docker Compose applications. For more information, see Docker Desktop Dashboard.

Docker Desktop ダッシュボードを通して、マシン上にあるコンテナとアプリケーションを用いる、アプリケーションのライフサイクルと管理をやりとりできます。ダッシュボードの UI を通して見えるのは、全ての実行中、停止中、開始中のコンテナと状態です。直感的なインターフェースを通して、コンテナや Docker Compose アプリケーションに対する調査と管理といった共通動作が行えます。より詳しい情報は、 :doc:`Docker Desktop ダッシュボード </desktop/dashboard/>` をご覧ください。

.. Docker Hub

.. _win-docker-hub:

Docker Hub
====================

.. Select Sign in /Create Docker ID from the Docker Desktop menu to access your Docker Hub account. Once logged in, you can access your Docker Hub repositories and organizations directly from the Docker Desktop menu.

自分の `Docker Hub <https://hub.docker.com/>`_  アカウントでアクセスするには、Docker Desktop のメニューから **Sing in/Create Docker ID ** （サインイン/Docker ID 作成）を選びます。一度ログインしておけば、Docker Desktop のメニューから Docker Hub リポジトリに直接アクセス可能になります。

.. For more information, refer to the following Docker Hub topics:

詳しい情報は、以下の :doc:`Docker Hub 記事 </docker-hub/toc) をご覧ください。

..    Organizations and Teams in Docker Hub
    Builds

* :doc:`/docker-hub/orgs`
* :doc:`/docker-hub/builds`

.. Two-factor authentication

.. _win-two-factor-authentication:

二要素認証
--------------------

.. Docker Desktop enables you to sign into Docker Hub using two-factor authentication. Two-factor authentication provides an extra layer of security when accessing your Docker Hub account.

Docker Desktop では、Docker Hub へのログインに二要素認証（Two-factor authentication）を有効化できます。二要素認証は Docker Hub アカウントにアクセスするとき、追加のセキュリティ段階を提供します。

.. You must enable two-factor authentication in Docker Hub before signing into your Docker Hub account through Docker Desktop. For instructions, see Enable two-factor authentication for Docker Hub.

Docker Hub での二要素認証を有効化する前に、Docker Desktop を通して Docker Hub アカウントにサインインする必要があります。手順は :doc:`Docker Hub で二要素認証を有効にする </docker-hub/2fa>` をご覧ください。

.. After you have enabled two-factor authentication:

二要素認証を有効化した後、

..   Go to the Docker Desktop menu and then select Sign in / Create Docker ID.

1. Docker Desktop のメニューから「 **Sign in / Create Docker ID** 」を選択。

..    Enter your Docker ID and password and click Sign in.

2. Docker ID とパスワードを入力し、 **Sign in** （サインイン）をクリック。

..    After you have successfully signed in, Docker Desktop prompts you to enter the authentication code. Enter the six-digit code from your phone and then click Verify.

3. サインインに成功した後、 Docker Desktop で認証コード（authentication code）の入力を求める画面が開きます。電話に届いた6桁のコードを入力し、 **Verify** （確認）をクリックします。

.. Docker Desktop 2FA

.. After you have successfully authenticated, you can access your organizations and repositories directly from the Docker Desktop menu.

認証に成功したら、Docker Desktop のメニューから organization やリポジトリにアクセス可能になります。

.. Add TLS certificates

.. _win-add-tls-certificates:

TLS 証明書の追加
====================

.. You can add trusted Certificate Authorities (CAs) to your Docker daemon to verify registry server certificates, and client certificates, to authenticate to registries. For more information, see How do I add custom CA certificates? and How do I add client certificates? in the FAQs.

Docker デーモンが、レジストリ・サーバ証明書と **クライアント証明書** の検証用に、信頼できる **認証局(CA; Certificate Authorities)** を追加してレジストリを認証できます。詳しい情報は :ref:`win-how-do-i-add-custom-ca-certificates` と :ref:`win-how-do-i-add-client-certificates` をご覧ください。

.. Add custom CA certificates (server side)

.. _win-add-custom-ca-certificates-server-side:

どのようにしてカスタム CA 証明書を追加できますか？
--------------------------------------------------

.. Docker Desktop supports all trusted Certificate Authorities (CAs) (root or intermediate). Docker recognizes certs stored under Trust Root Certification Authorities or Intermediate Certification Authorities.

Docker Desktop は全ての信頼できうる（ルート及び中間）証明局（CA）をサポートしています。証明書が信頼できるルート認証局や中間認証局の配下にあるかどうか、Docker は識別します。

.. Docker Desktop creates a certificate bundle of all user-trusted CAs based on the Windows certificate store, and appends it to Moby trusted certificates. Therefore, if an enterprise SSL certificate is trusted by the user on the host, it is trusted by Docker Desktop.

Docker Desktop は Windows 証明局ストアに基づき、全てのユーザが信頼する CAの証明書バンドルを作成します。また、Moby の信頼できる証明書にも適用します。そのため、エンタープライズ SSL 証明書がホスト上のユーザによって信頼されている場合は、Docker Desktop からも信頼されます。

.. To learn more about how to install a CA root certificate for the registry, see Verify repository client with certificates in the Docker Engine topics.

レジストリに対する CA ルート証明書のインストール方法について学ぶには、Docker エンジン記事の :doc:`証明書でリポジトリ・クライアントを認証する </engine/security/certificates>` を御覧ください。


.. Add client certificates

.. _win-add-client-certificates:

どのようにしてクライアント証明書を追加しますか？
--------------------------------------------------

.. You can put your client certificates in ~/.docker/certs.d/<MyRegistry>:<Port>/client.cert and ~/.docker/certs.d/<MyRegistry>:<Port>/client.key.

自分のクライアント証明書を :code:`~/.docker/certs.d/<MyRegistry>:<Port>/client.cert` と :code:`~/.docker/certs.d/<MyRegistry>:<Port>/client.key` に追加できます。

.. When the Docker Desktop application starts, it copies the ~/.docker/certs.d folder on your Windows system to the /etc/docker/certs.d directory on Moby (the Docker Desktop virtual machine running on Hyper-V).

Docker Desktop ・アプリケーションの開始時に、 Windows システム上の :code:`~/.docker/certs.d` フォルダを Moby 上（Docker Desktop が稼働する Hyper-V 上の仮想マシン）の `/etc/docker/certs.d` ディレクトリにコピーします。

.. You need to restart Docker Desktop after making any changes to the keychain or to the ~/.docker/certs.d directory in order for the changes to take effect.

キーチェーンに対する何らかの変更をするか、 :code:`~/.docker/certs.d` ディレクトリ内の変更を有効にするには、 Docker Desktop の再起動が必要です。

.. The registry cannot be listed as an insecure registry (see Docker Daemon). Docker Desktop ignores certificates listed under insecure registries, and does not send client certificates. Commands like docker run that attempt to pull from the registry produce error messages on the command line, as well as on the registry.

レジストリは *insecure* （安全ではない）レジストリとして表示されません（ :ref:`win-docker-engine` をご覧ください ）。Docker Desktop は安全ではないレジストリにある証明書を無視します。そして、クライアント証明書も送信しません。 :code:`docker run` のようなレジストリから取得するコマンドは、コマンドライン上でもレジストリでもエラーになるメッセージが出ます。

.. To learn more about how to set the client TLS certificate for verification, see Verify repository client with certificates in the Docker Engine topics.

認証用にクライアント TLS 証明書を設定する方法を学ぶには、Docker エンジンの記事 :doc:`証明書でリポジトリ・クライアントを確認する </engine/security/certificates>` を御覧ください。



.. Give feedback and get help

.. _win-give-feedback-and-get-help:

フィードバックやヘルプを得るには
========================================

.. To get help from the community, review current user topics, join or start a discussion, log on to our Docker Desktop for Mac forum.

コミュニティからのヘルプを得たり、現在のユーザートピックを見たり、ディスカッションに参加・開始するには `Docker Desktop for Mac forum <https://forums.docker.com/c/docker-for-mac>`_ にログオンください。

.. To report bugs or problems, log on to Docker Desktop for Mac issues on GitHub, where you can review community reported issues, and file new ones. See Logs and Troubleshooting for more details.

バグや問題の報告をするには、 `GitHub の Mac issues <https://github.com/docker/for-mac/issues>`_  にログオンし、そこでコミュニティに報告された報告を見たり、新しい課題を追加できます。詳細は [ログとトラブルシューティング] をご覧ください。

.. For information about providing feedback on the documentation or update it yourself, see Contribute to documentation.

ドキュメントのに対するフェイードバックの提供や、自分自身で更新する方法は、 :doc:`コントリビュート </opensource/toc>` のドキュメントをご覧ください。


.. Where to go next

次は何をしますか
====================

..    Try out the walkthrough at Get Started.

* :doc:`始めましょう </get-started/index>` を一通り試しましょう。

..    Dig in deeper with Docker Labs example walkthroughs and source code.

* `Docker Labs <https://github.com/docker/labs/>`_  の例を通したりソースコードを深く掘り下げましょう。

..    For a summary of Docker command line interface (CLI) commands, see Docker CLI Reference Guide.

* Docker コマンドライン・インターフェース（CLI）コマンドのまとめについては、 :doc:`Docker CLI リファレンスガイド </engine/api>` をご覧ください。

..    Check out the blog post, What’s New in Docker 17.06 Community Edition (CE).

* `What's New in Docker 17.06 Community Edition (CE) <https://blog.docker.com/2017/07/whats-new-docker-17-06-community-edition-ce/>`_ のブログ記事をご覧ください。


.. seealso:: 

   Get Started with Docker for Windows
      https://docs.docker.com/docker-for-windows/
