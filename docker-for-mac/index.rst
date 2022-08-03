.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/docker-for-mac/
   doc version: 19.03
      https://github.com/docker/docker.github.io/blob/master/docker-for-mac/index.md
.. check date: 2020/06/09
.. Commits on Jun 1, 2020 59c3d309caed882e0681a15209adeed803ce7777
.. -----------------------------------------------------------------------------

.. Get started with Docker Desktop for Mac

.. _get-started-with-docker-desktop-for-mac:

========================================
Docker for Mac を始めよう
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Welcome to Docker Desktop!

Docker Desktop へようこそ！

.. The Docker Desktop for Mac section contains information about the Docker Desktop Community Stable release. For information about features available in Edge releases, see the Edge release notes. For information about Docker Desktop Enterprise (DDE) releases, see Docker Desktop Enterprise.

*Docker Desktop  for Mac* のセクションは、Docker Desktop コミュニティ安定版リリース（Community Stable release）に関する情報を扱います。エッジリリース（Edge release）に関する情報は、  :doc:`Edge リリースノート <edge-release-notes>` を御覧ください。Docker デスクトップ・エンタープライズ（DDE）リリースに関する情報は `Docker Desktop Enterprise <https://docs.docker.com/ee/desktop/>`_ を御覧ください。

.. Docker is a full development platform to build, run, and share containerized applications. Docker Desktop is the best way to get started with Docker on Mac.

Docker とは、コンテナ化したアプリケーションを構築・実行・共有するための、全てが揃った開発プラットフォームです。Mac 上で Docker を使い始めるためには、Docker Desktop が最も良い方法です。

.. See Install Docker Desktop for download information, system requirements, and installation instructions.

ダウンロード情報、システム要件、インストール手順については、  :doc:`Docker Desktop のインストール <install>` を御覧ください。

.. Check versions

.. _mac-check-versions:

バージョンの確認
====================

.. Ensure your versions of docker and docker-compose are up-to-date and compatible with Docker.app. Your output may differ if you are running different versions.

`docker` と `docker-compose`  が更新され、 `Docker.app`  と互換性があるバージョンかどうか確認しましょう。異なるバージョンを実行していれば、以下のような表示とは異なるでしょう。

.. code-block:: bash

   $ docker --version
   Docker version 19.03, build c97c6d6

.. Explore the application

.. _mac-explore-the-application:

アプリケーションの探索
==============================

..    Open a command-line terminal and test that your installation works by running the simple Docker image, hello-world:

1.　コマンドライン・ターミナルを開き、シンプルな Docker イメージ `hello-world <https://hub.docker.com/r/library/hello-world/>`_ を実行し、インストールが正常に終わったかどうかを確認します。

.. code-block:: bash

   $ docker run hello-world
   
   Unable to find image 'hello-world:latest' locally
   latest: Pulling from library/hello-world
   ca4f61b1923c: Pull complete
   Digest: sha256:ca0eeb6fb05351dfc8759c20733c91def84cb8007aa89a5bf606bc8b315b9fc7
   Status: Downloaded newer image for hello-world:latest
   
   Hello from Docker!
   This message shows that your installation appears to be working correctly.
   ...

..    Start a Dockerized web server. Like the hello-world image above, if the image is not found locally, Docker pulls it from Docker Hub.

2.　Docker 化したウェブサーバを開始します。先ほどの `hello-world`イメージのように、もしもイメージがローカルで見つからなければ、Docker は Docker Hub から取得します。

.. code-block:: bash

   $ docker run --detach --publish=80:80 --name=webserver nginx

..    In a web browser, go to http://localhost/ to view the nginx homepage. Because we specified the default HTTP port, it isn’t necessary to append :80 at the end of the URL.

3.　ウェブ・ブラウザで :code:`http://localhost` を指定し、nginx のスタートページを開きます（ :code:`:80` を追加する必要はありません。 :code:`docker` コマンドで標準の HTTP ポートを指定したからです）。

..    nginx home page

..        Early beta releases used docker as the hostname to build the URL. Now, ports are exposed on the private IP addresses of the VM and forwarded to localhost with no other host name set.

.. info::

   初期のベータ・リリースでは `docker` をビルドした URL のホストとして利用できました。現在では、ポートは仮想マシンのプライベートな IP アドレス上に公開され、 `localhost` に対して転送されるもので、その他のホスト名は使いません。

..    View the details on the container while your web server is running (with docker container ls or docker ps):

4.　詳細を確認（ :code:`docker container ls` または :code:`docker ps` ）すると、ウェブサーバが実行中（ *running* ）と分かります。

.. code-block:: bash

   $ docker container ls
   CONTAINER ID   IMAGE   COMMAND                  CREATED              STATUS              PORTS                         NAMES
   56f433965490   nginx   "nginx -g 'daemon off"   About a minute ago   Up About a minute   0.0.0.0:80->80/tcp, 443/tcp   webserver

..    Stop and remove containers and images with the following commands. Use the “all” flag (--all or -a) to view stopped containers.

5.　以下のコマンドを実行し、コンテナの停止とイメージを削除します。停止したコンテナを確認するには、 "all" （すべて）フラグ（ :code:`--all` または :code:`-a`）を使います。

.. code-block:: bash

   $ docker container ls
   $ docker container stop webserver
   $ docker container ls -a
   $ docker container rm webserver
   $ docker image ls
   $ docker image rm nginx

.. Preferences

.. _docker-desktop-for-mac-preferences:

Preferences （設定）
==============================

.. Choose the Docker menu whale menu > Preferences from the menu bar and configure the runtime options described below.

メニューバーの Docker メニュー（鯨アイコン） > **Preference** （設定）を選択すると、以下で説明している実行時のオプションを調整できます。

.. Docker context menu


.. General🔗

.. _mac-general:

General（一般的な設定）
------------------------------

.. On the General tab, you can configure when to start and update Docker:

設定画面の **General** タブでは、Docker の起動と更新を設定できます。

..    Start Docker Desktop when you log in: Automatically starts Docker Desktop when you open your session.

* **Start Docker when you log in** - セッションの開始時、自動的に Docker Desktop を起動します。

..    Automatically check for updates: By default, Docker Desktop automatically checks for updates and notifies you when an update is available. You can manually check for updates anytime by choosing Check for Updates from the main Docker menu.

* **Automatically check for updates** - デフォルトでは、Docker Desktop は自動的に更新を確認し、更新版が利用可能な場合は通知します。承諾して更新版をインストールするには **OK** をクリックします（あるいは、現在のバージョンを維持する場合は、キャンセルします）。メインの Docker メニューから **Check for Updates** （更新を確認）で、手動での更新ができます。

..    Include VM in Time Machine backups: Select this option to back up the Docker Desktop virtual machine. This option is disabled by default.

* **Include VM in Time Machine backups** （タイムマシン・バックアップに仮想マシンを含める） - このオプションを選択すると、Docker Desktop 仮想マシンをバックアップします。このオプションは、デフォルトでは無効です。

..    Securely store Docker logins in macOS keychain: Docker Desktop stores your Docker login credentials in macOS keychain by default.

* **Securely store Docker logins in macOS keychain** （macOS キーチェーンに Docker ログイン情報を安全に保管） - Docker Desktop は、Docker login 認証情報を macOS キーチェーンにデフォルトで保存します。

..    Send usage statistics: Docker Desktop sends diagnostics, crash reports, and usage data. This information helps Docker improve and troubleshoot the application. Clear the check box to opt out.

* **Send usage statics** - デフォルトでは、Docker Desktop は診断情報・クラッシュ報告・利用データを送信します。この情報は、 Docker の改善やアプリケーションの問題解決に役立ちます。止めるにはチェックボックスを空にします。Docker は定期的に更なる情報を訊ねるかもしれません。

..    Click Switch to the Edge version to learn more about Docker Desktop Edge releases.

**Switch to the Edge version** （Edge バージョンの切り替え）をクリックすると、Docker Desktop Edge リリースに関する情報を学べます。

.. Resources:

.. _mac-resources:

Resources（リソース）
------------------------------

.. The Resources tab allows you to configure CPU, memory, disk, proxies, network, and other resources.

.. Advanced

.. _mac-resources-advanced:

ADVANCED（高度な設定）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. On the Advanced tab, you can limit resources available to Docker.

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

.. _mac-preferences-file-sharing:

FILE SHARING（ファイル共有）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. Use File sharing to allow local directories on the Mac to be shared with Linux containers. This is especially useful for editing source code in an IDE on the host while running and testing the code in a container. By default the /Users, /Volume, /private, /tmp and /var/folders directory are shared. If your project is outside this directory then it must be added to the list. Otherwise you may get Mounts denied or cannot start service errors at runtime.

Linux コンテナと共有したいローカルのディレクトリを選択します。これはホスト上の IDE を用い、コンテナ内でコードの実行やテストをしている場合、ソースコードの編集に特に役立ちます。デフォルトでは `/Users` 、 `/Volume` 、`/private` 、 `/tmp` 、`/var/folders`  ディレクトリが共有されます。プロジェクトがこのディレクトリ外であれば、必ずこのリストに追加する必要があります。そうしなければ、 `Mounts denied` （マウント拒否）や `cannot start serice`  （サービスを開始できない）エラーが実行時に出るでしょう。

.. File share settings are:

ファイル共有を設定するには：

..    Add a Directory: Click + and navigate to the directory you want to add.

* **Add a Directory（ディレクトリの追加）** : `+` をクリックし、追加したいディレクトリを選択します。

..    Apply & Restart makes the directory available to containers using Docker’s bind mount (-v) feature.

* **Apply & Restart** （適用と再起動）によって、対象ディレクトリが Docker のバインド・マウント（ `-v` ）機能で利用できるようになります。

..    There are some limitations on the directories that can be shared:
        The directory must not exist inside of Docker.

   共有可能なディレクトリ上では、いくつかの制限があります：
   
   * ディレクトリは Docker の内部に存在していてはいけません。

.. For more information, see:

詳しい情報は、こちらをご覧ください。

..    Namespaces in the topic on osxfs file system sharing.
    Volume mounting requires file sharing for any project directories outside of /Users.)

- :doc:`osxfs ファイルシステム共有 <osxfs>` の :ref:`Namespaces <osxfs-namespaces>` のトピック内
- :ref:`mac-volume-mounting-requires-file-sharing-for-any-project-directories-outside-of-users`

.. PROXIES

.. _mac-preferences-proxies:

PROXIES（プロキシ）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. Docker Desktop detects HTTP/HTTPS Proxy Settings from macOS and automatically propagates these to Docker and to your containers. For example, if you set your proxy settings to http://proxy.example.com, Docker uses this proxy when pulling containers.

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

.. You can see from the above output that the HTTP_PROXY, http_proxy, and no_proxy environment variables are set. When your proxy configuration changes, Docker restarts automatically to pick up the new settings. If you have any containers that you would like to keep running across restarts, you should consider using restart policies.

こちらの結果では、 `HTTP_PROXY` 、 `http_proxy`  、 `no_proxy` 環境変数が設定されているのが分かります。プロキシ設定を変更した場合は、新しい設定を適用するために、Docker は自動的に再起動します。再起動後もコンテナを実行し続けたい場合には、 :ref:`再起動ポリシー <restart-policies-restart>` の利用を検討すべきでしょう。

.. Network

.. _mac-preferences-network:

NETWORK （ネットワーク）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. You can configure Docker Desktop networking to work on a virtual private network (VPN). Specify a network address translation (NAT) prefix and subnet mask to enable Internet connectivity.

Docker Desktop のネットワーク機能を、仮想プライベート・ネットワーク（VPN）でも機能するように設定できます。インターネットとの疎通を有効にするには、ネットワーク・アドレス変換（NAT）プリフィックスとサブネットマスクを設定します。

.. Docker Engine

.. _mac-docker-engine:

Docker Engine （Docker エンジン）
----------------------------------------

.. The Docker Engine page allows you to configure the Docker daemon to determine how your containers run.

Docker Engine のページでは、Docker デーモンの設定や、どのようにしてコンテナを実行するかを決められます。

.. Type a JSON configuration file in the box to configure the daemon settings. For a full list of options, see the Docker Engine dockerd commandline reference.

デーモンの設定をするには、テキストボックス内に JSON 形式の設定ファイルとして入力します。オプションの一覧については、 Docker Engine の :doc:`dockerd コマンドライン・リファレンス </engine/reference/commandline/dockerd>` を御覧ください。

.. Click Apply & Restart to save your settings and restart Docker Desktop.

**Apply & Restart** （適用と再起動）をクリックし、設定を保存して Docker Desktop を再起動します。

.. Command Line

.. _mac-command-line:

Command Line （コマンドライン）
----------------------------------------

.. On the Command Line page, you can specify whether or not to enable experimental features.

コマンドラインのページでは、experimental features（実験的機能）を有効にするかどうかを指定できます。

.. Experimental features provide early access to future product functionality. These features are intended for testing and feedback only as they may change between releases without warning or can be removed entirely from a future release. Experimental features must not be used in production environments. Docker does not offer support for experimental features.

実験的機能は、今後提供する機能を先行利用できます。各機能は、テストやフィードバックを意図した、参考程度のものです。そのため、リリース時までに警告が出たり、今後のリリースでは削除されたりする場合があります。本番向けの環境では、実験的機能を決して使わないでください。Docker は実験的機能に対するサポートを提供していません。


..    To enable experimental features in the Docker CLI, edit the config.json file and set experimental to enabled.
    To enable experimental features from the Docker Desktop menu, click Settings (Preferences on macOS) > Command Line and then turn on the Enable experimental features toggle. Click Apply & Restart.

.. attention::

   Docker コマンドラインツールで実験的機能を有効にするには、 :code:`config.json` ファイルを編集し、 :code:`experimental` を有効化するよう指定します。

   Docker Desktop のメニューから実験的機能を有効にするには、 **Settings** （設定） → **Command Line**  （コマンドライン）をクリックし、 **Enable experimental features** （実験的機能の有効化）ボタンを押します。 **Apply & Restart** （適用と再起動）をクリックします。

.. For a list of current experimental features in the Docker CLI, see Docker CLI Experimental features.

Docker Desktop  Edge リリースは、デフォルトで Docker エンジンの実験的なバージョンが有効です。詳細は Git Hub 上の `Docker 実験的機能 README（英語） <https://github.com/docker/cli/blob/master/experimental/README.md>`_ を御覧ください。

.. On both Docker Desktop Edge and Stable releases, you can toggle the experimental features on and off. If you toggle the experimental features off, Docker Desktop uses the current generally available release of Docker Engine.

Docker Desktop  Edge と Stable リリースのいずれでも、実験的機能の有効化と無効化を切り替えできます。実験的機能を無効化すると、Docker Desktop は現時点の Docker エンジン安定版リリースを使います。

.. You can see whether you are running experimental mode at the command line. If Experimental is true, then Docker is running in experimental mode, as shown here. (If false, Experimental mode is off.)

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

.. _mac-kubernetes:

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

* Kubernetes サポートを有効化し、Kubernetes の独立したインスタンスを Docker コンテナとしてインストールするには、 **Enable Kubernetes** （Kubernetes 有効化）をクリックします。Kubernetes を :ref:`デフォルトのオーケストレータ <mac-override-default-orchestrator>` に指定するには、 **Deploy Docker Stack to Kubernetes by default** を選択します。

..    Click Apply & Restart to save the settings. This instantiates images required to run the Kubernetes server as containers, and installs the /usr/local/bin/kubectl command on your Mac.

**Apply & Restart** （適用と再起動）をクリックし、設定を保存します。 Kubernetes サーバをコンテナとして実行するために必要なイメージが実体化（インスタンス化）され、 `/usr/local/bin/kubectl` コマンドが Mac 上にインストールされます。

..    Enable Kubernetes

..    When Kubernetes is enabled and running, an additional status bar item displays at the bottom right of the Docker Desktop Settings dialog.

Kubernetes を有効化して実行している場合は、Docker Desktop 設定ダイアログの右横に、ステータス・バーの追加アイテムを表示します。

..    The status of Kubernetes shows in the Docker menu and the context points to docker-desktop.

Docker メニューの Kubernetes のステータスは、作業対象を `docker-desktop` と表示します。

..    Docker Menu with Kubernetes

..    By default, Kubernetes containers are hidden from commands like docker service ls, because managing them manually is not supported. To make them visible, select Show system containers (advanced) and click Apply and Restart. Most users do not need this option.

* デフォルトで、Kubernetes コンテナは `docker service ls` のようなコマンドで非表示です。この理由は、手動での（Kubernetes）管理がサポートされていないからです。これらを表示するには **Show system containers (advances)** （システムコンテナの表示〔高度〕）を選びます。多くの利用者には不要なオプションです。

..    To disable Kubernetes support at any time, clear the Enable Kubernetes check box. The Kubernetes containers are stopped and removed, and the /usr/local/bin/kubectl command is removed.

* **Enable Kubernetes** （Kubernetes 有効化）のチェックボックスをクリアしたら、Kubernetes サポートはいつでも無効にできます。無効により、この Kubernetes コンテナを停止及び削除し、 `/usr/local/bin/kubectl` コマンドも削除します。

..    For more about using the Kubernetes integration with Docker Desktop, see Deploy on Kubernetes.

Docker Desktop で Kubernetes 統合機能を使う詳しい情報は、 :doc:`Kubernetes 上にデプロイ <kubernetes>` をご覧ください。

.. Reset

.. mac-preference-reset:

リセット
--------------------

..    Reset and Restart options
..    On Docker Desktop Mac, the Restart Docker Desktop, Reset to factory defaults, and other reset options are available from the Troubleshoot menu.

.. note::

   **リセットと再起動オプション** 
   
   Docker Desktop Mac では、 **Troubleshoot** （トラブルシュート）のメニュー上から、 **Restart Docker Desktop** （Dockerデスクトップの再起動）と **Reset to factory defaults** （初期値にリセットする）オプションを利用できます。

.. For information about the reset options, see Logs and Troubleshooting.

詳しい情報は :doc:`troubleshoot` を御覧ください。

.. Dashboard

.. _mac-dashboard:

ダッシュボード
====================

.. The Docker Desktop Dashboard enables you to interact with containers and applications and manage the lifecycle of your applications directly from your machine. The Dashboard UI shows all running, stopped, and started containers with their state. It provides an intuitive interface to perform common actions to inspect and manage containers and existing Docker Compose applications. For more information, see Docker Desktop Dashboard.

Docker Desktop ダッシュボードを通して、マシン上にあるコンテナとアプリケーションを用いる、アプリケーションのライフサイクルと管理をやりとりできます。ダッシュボードの UI を通して見えるのは、全ての実行中、停止中、開始中のコンテナと状態です。直感的なインターフェースを通して、コンテナや Docker Compose アプリケーションに対する調査と管理といった共通動作が行えます。より詳しい情報は、 :doc:`Docker Desktop ダッシュボード </desktop/dashboard/>` をご覧ください。

.. Add TLS certificates

.. _mac-add-tls-certificates:

TLS 証明書の追加
====================

.. You can add trusted Certificate Authorities (CAs) (used to verify registry server certificates) and client certificates (used to authenticate to registries) to your Docker daemon.

Docker デーモンが、レジストリ・サーバ証明書と **クライアント証明書** の検証用に、信頼できる **認証局(CA; Certificate Authorities)** を追加してレジストリを認証できます。

.. Add custom CA certificates (server side)

.. _mac-add-custom-ca-certificates-server-side:

カスタム CA 証明書の追加（サーバ側）
----------------------------------------

.. All trusted CAs (root or intermediate) are supported. Docker Desktop creates a certificate bundle of all user-trusted CAs based on the Mac Keychain, and appends it to Moby trusted certificates. So if an enterprise SSL certificate is trusted by the user on the host, it is trusted by Docker Desktop.

全ての信頼できうる（ルート及び中間）証明局（CA）をサポートしています。Docker Desktop は Mac キーチェーン上にある全ての信頼できうる証明局の情報に基づき、全てのユーザが信頼する CAの証明書バンドルを作成します。また、Moby の信頼できる証明書にも適用します。そのため、エンタープライズ SSL 証明書がホスト上のユーザによって信頼されている場合は、Docker Desktop からも信頼されます。

.. To manually add a custom, self-signed certificate, start by adding the certificate to the macOS keychain, which is picked up by Docker Desktop. Here is an example:

任意の、自己証明した証明書を主導で追加するには、macOS キーチェン上に証明書を追加し、Docker Desktop が扱えるようにします。以下は例です：


.. code-block:: bash

   $ sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain ca.crt

.. Or, if you prefer to add the certificate to your own local keychain only (rather than for all users), run this command instead:

あるいは、（全てのユーザに対してではなく）自身のローカルキーチェーンのみ追加したい場合は、代わりにこちらのコマンドを実行します。

.. code-block:: bash

   $ security add-trusted-cert -d -r trustRoot -k ~/Library/Keychains/login.keychain ca.crt

.. See also, Directory structures for certificates.

また、 :ref:`mac-directory-structures-for-certificates` もご覧ください。

..    Note: You need to restart Docker Desktop after making any changes to the keychain or to the ~/.docker/certs.d directory in order for the changes to take effect.

.. note::

   キーチェーンに対する何らかの変更をするか、 :code:`~/.docker/certs.d` ディレクトリ内の変更を有効にするには、 Docker Desktop の再起動が必要です。

.. For a complete explanation of how to do this, see the blog post Adding Self-signed Registry Certs to Docker & Docker Desktop for Mac.

以上の設定方法に関する完全な説明は `Adding Self-signed Registry Certs to Docker & Docker Desktop for Mac <http://container-solutions.com/adding-self-signed-registry-certs-docker-mac/>`_ のブログ投稿をご覧ください。

.. Add client certificates

.. _mac-add-client-certificates:

クライアント証明書の追加
------------------------------

.. You can put your client certificates in ~/.docker/certs.d/<MyRegistry>:<Port>/client.cert and ~/.docker/certs.d/<MyRegistry>:<Port>/client.key.

自分のクライアント証明書を :code:`~/.docker/certs.d/<MyRegistry>:<Port>/client.cert` と :code:`~/.docker/certs.d/<MyRegistry>:<Port>/client.key` に追加できます。

.. When the Docker Desktop application starts, it copies the ~/.docker/certs.d folder on your Mac to the /etc/docker/certs.d directory on Moby (the Docker Desktop xhyve virtual machine).

Docker Desktop ・アプリケーションの開始時に、 Mac システム上の :code:`~/.docker/certs.d` フォルダを Moby 上（Docker Desktop が稼働する :code:`xhyve` 上の仮想マシン）の `/etc/docker/certs.d` ディレクトリにコピーします。

..        You need to restart Docker Desktop after making any changes to the keychain or to the ~/.docker/certs.d directory in order for the changes to take effect.
..        The registry cannot be listed as an insecure registry (see Docker Engine. Docker Desktop ignores certificates listed under insecure registries, and does not send client certificates. Commands like docker run that attempt to pull from the registry produce error messages on the command line, as well as on the registry.

.. hint::

   * キーチェーンに対する何らかの変更をするか、 :code:`~/.docker/certs.d` ディレクトリ内の変更を有効にするには、 Docker Desktop の再起動が必要です。
   * レジストリは *insecure* （安全ではない）レジストリとして表示されません（ :ref:`mac-docker-engine` をご覧ください ）。Docker Desktop は安全ではないレジストリにある証明書を無視します。そして、クライアント証明書も送信しません。 :code:`docker run` のようなレジストリから取得するコマンドは、コマンドライン上でもレジストリでもエラーになるメッセージが出ます。

.. Directory structures for certificates

.. _mac-directory-structures-for-cerficates:

認証情報のディレクトリ構造
------------------------------

.. If you have this directory structure, you do not need to manually add the CA certificate to your Mac OS system login:

次のディレクトリ構造の場合、Mac OS システムログインのため、CA 証明書を手動で追加する必要はありません。

.. code-block:: bash

   /Users/<user>/.docker/certs.d/
   └── <MyRegistry>:<Port>
      ├── ca.crt
      ├── client.cert
      └── client.key

.. The following further illustrates and explains a configuration with custom certificates:

以下は、カスタム証明書を設定例と説明を追加したものです：

.. code-block:: bash

   /etc/docker/certs.d/        <-- Certificate directory
   └── localhost:5000          <-- Hostname:port
      ├── client.cert          <-- Client certificate
      ├── client.key           <-- Client key
      └── ca.crt               <-- Certificate authority that signed
                                   the registry certificate

.. You can also have this directory structure, as long as the CA certificate is also in your keychain.

あるいは、CA 証明書が自分のキーチェンにあれば、次のようなディレクトリ構造にもできます。

.. code-block:: bash

   /Users/<user>/.docker/certs.d/
   └── <MyRegistry>:<Port>
       ├── client.cert
       └── client.key

.. To learn more about how to install a CA root certificate for the registry and how to set the client TLS certificate for verification, see Verify repository client with certificates in the Docker Engine topics.

認証用にクライアント TLS 証明書を設定する方法を学ぶには、Docker エンジンの記事 :doc:`証明書でリポジトリ・クライアントを確認する </engine/security/certificates>`_ を御覧ください。

.. Install shell completion

.. _mac-install-shell-completion:

シェル補完のインストール
==============================

.. Docker Desktop comes with scripts to enable completion for the docker and docker-compose commands. The completion scripts may be found inside Docker.app, in the Contents/Resources/etc/ directory and can be installed both in Bash and Zsh.

Docker Desktop には、 :code:`docker` と :code:`docker-compose`  のコマンド補完を有効化するスクリプトがあります。補完スクリプトは  :code:`Docker.app` 内の :code:`Contents/Resources/etc` ディレクトリ内にあり、 Bash と Zsh の両方にインストールできます。


.. Bash

Bash
----------

.. _mac-bash:

.. Bash has built-in support for completion To activate completion for Docker commands, these files need to be copied or symlinked to your bash_completion.d/ directory. For example, if you installed bash via Homebrew:

Bash は `補完のサポートを内蔵 <https://www.debian-administration.org/article/316/An_introduction_to_bash_completion_part_1`_ しています。Docker コマンドの補完をできるようにするには、 :code:`bash_completion.d/` ディレクトリ内に各ファイルをコピーしたり symlink を作成必要があります。たとえば、 `Homebrew <http://brew.sh/`_ 経由で bash をインストールするには、以下のようにします。

.. code-block:: bash

   etc=/Applications/Docker.app/Contents/Resources/etc
   ln -s $etc/docker.bash-completion $(brew --prefix)/etc/bash_completion.d/docker
   ln -s $etc/docker-compose.bash-completion $(brew --prefix)/etc/bash_completion.d/docker-compose

.. Add the following to your ~/.bash_profile:

以下を自分の :code:`~/.bash_profile` に追加します：

.. code-block:: bash

   [ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

.. OR

あるいは

.. code-block:: bash

   if [ -f $(brew --prefix)/etc/bash_completion ]; then
   . $(brew --prefix)/etc/bash_completion
   fi

.. Zsh

.. _mac-zsh:

Zsh
----------

.. In Zsh, the completion system takes care of things. To activate completion for Docker commands, these files need to be copied or symlinked to your Zsh site-functions/ directory. For example, if you installed Zsh via Homebrew:

Zsh では、 `補完システム <http://zsh.sourceforge.net/Doc/Release/Completion-System.html>`_ の管理が必要です。Docker コマンドに対する補完を有効化するには、自分の Zsh :code:`site-functions/` ディレクトリに各ファイルをコピーするか symlink する必要があります。以下は `Homebrew <http://brew.sh/>`_  を経由して Zsh をインストールします：

.. code-block:: bash

   etc=/Applications/Docker.app/Contents/Resources/etc
   ln -s $etc/docker.zsh-completion /usr/local/share/zsh/site-functions/_docker
   ln -s $etc/docker-compose.zsh-completion /usr/local/share/zsh/site-functions/_docker-compose

.. Fish-Shell

.. _mac-fish-shell:

Fish-Shell
----------

.. Fish-shell also supports tab completion completion system. To activate completion for Docker commands, these files need to be copied or symlinked to your Fish-shell completions/ directory.

Fish-shell もまた、タブ補完による `補完システム <https://fishshell.com/docs/current/#tab-completion>`_ をサポートしています。Docker コマンドに対する補完を有効化するには、各ファイルを自分の Fish-shell の :code:`completions` ディレクトリにコピーするか symlink する必要があります。

.. Create the completions directory:

:code:`completions`  ディレクトリを作成します：

.. code-block:: bash

   mkdir -p ~/.config/fish/completions

.. Now add fish completions from docker.

次に docker から fish completions を追加します。

.. code-block:: bash

   ln -shi /Applications/Docker.app/Contents/Resources/etc/docker.fish-completion ~/.config/fish/completions/docker.fish
   ln -shi /Applications/Docker.app/Contents/Resources/etc/docker-compose.fish-completion ~/.config/fish/completions/docker-compose.fish

.. Give feedback and get help

.. _mac-give-feedback-and-get-help:

フィードバックやヘルプを得るには
========================================

.. To get help from the community, review current user topics, join or start a discussion, log on to our Docker Desktop for Mac forum.

コミュニティからのヘルプを得たり、現在のユーザートピックを見たり、ディスカッションに参加・開始するには `Docker Desktop for Mac forum <https://forums.docker.com/c/docker-for-mac>`_ にログオンください。

.. To report bugs or problems, log on to Docker Desktop for Mac issues on GitHub, where you can review community reported issues, and file new ones. See Logs and Troubleshooting for more details.

バグや問題の報告をするには、 `GitHub の Mac issues <https://github.com/docker/for-mac/issues>`_  にログオンし、そこでコミュニティに報告された報告を見たり、新しい課題を追加できます。詳細は [ログとトラブルシューティング] をご覧ください。

.. For information about providing feedback on the documentation or update it yourself, see Contribute to documentation.

ドキュメントのに対するフェイードバックの提供や、自分自身で更新する方法は、 :doc:`コントリビュート </opensource/toc>` のドキュメントをご覧ください。

.. Docker Hub

.. _mac-docker-hub:

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

.. _mac-two-factor-authentication:

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

   Get Started with Docker for Mac OS X
      https://docs.docker.com/mac/
