.. H-*- coding: utf-8 -*-
.. URL: https://docs.docker.com/desktop/settings/mac/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/desktop/settings/mac.md
.. check date: 2022/09/17
.. Commits on Sep 8, 2022 8bce7328f1d7f6df2ccd508d2f2970c244ebc10f
.. -----------------------------------------------------------------------------

.. |whale| image:: /desktop/install/images/whale-x.png
      :scale: 50%

.. Change Docker Desktop preferences on Mac
.. _change-docker-desktop-preferences-on-mac:

==================================================
Mac 版 Docker Desktop の設定変更
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. This page provides information on how to configure and manage your Docker Desktop settings.

このページでは、 Docker Desktop の設定と管理の方法に関して説明します。

.. To navigate to Preferences either:

**Preferences** に移動するには、以下いずれかです。

..  Select the Docker menu whale menu and then Preferences
    Select the Preferences icon from the Docker Dashboard.

* Docker メニュー |whale| から **Preferences** を選びます。
* Docker ダッシュボードから **Preferences** アイコンを選びます。

.. General
.. _desktop-mac-general:

General
==========

.. On the General tab, you can configure when to start Docker and specify other settings:

設定画面の **General** タブでは、Docker の起動や他の設定を調整できます。

..    Start Docker Desktop when you log in. Select to automatically start Docker Desktop when you log into your machine.

* **Start Docker Desktop when you log in** （ログイン時に Docker Desktop を起動）：マシンにログインする時、自動的に Docker Desktop を起動する時に選びます。

..    Choose Theme for Docker Desktop. Choose whether you want to apply a Light or Dark theme to Docker Desktop. Alternatively you can set Docker Desktop to Use System Settings.

* **Choose Theme for Docker Desktop** （Docker Desktop のテーマ選択）：Docker Desktop に **Light** か **Dark** どちらのテーマを適用するか選びます。あるいは、 Docker Desktop で **Use System Settings** を設定できます。

..    Use integrated container terminal. Select to execute commands in a running container straight from the Docker Dashboard. For more information, see Explore containers.

* **Use integrated container terminal**  （コンテナ ターミナルの統合を使う）：Docker ダッシュボードから実行中のコンテナに対して直接実行するかどうかを選びます。詳しい情報は :doc:`Containers を見渡す </desktop/use-desktop/container>` をご覧ください。

..    Include VM in Time Machine backups. Select to back up the Docker Desktop virtual machine. This option is disabled by default.

* **Include VM in Time Machine backups** （タイムマシン バックアップに仮想マシンを含める）：このオプションを選択すると、Docker Desktop 仮想マシンをバックアップします。このオプションは、デフォルトでは無効です。

..    Use gRPC FUSE for file sharing. Clear this check box to use the legacy osxfs file sharing instead.

* **Use gRPC FUSE for file sharing** （ファイル共有に gRPC FUSE を使用）：このチェックボックスをクリアすると、代わりに古い osxfs ファイル共有を使います。

..    Send usage statistics. Select so Docker Desktop sends diagnostics, crash reports, and usage data. This information helps Docker improve and troubleshoot the application. Clear the check box to opt out. Docker may periodically prompt you for more information.

* **Send usage statics** （利用統計情報の送信）： デフォルトでは、Docker Desktop は診断情報・クラッシュ報告・利用データを送信します。この情報は、 Docker の改善やアプリケーションの問題解決に役立ちます。止めるにはチェックボックスを空にします。Docker は定期的に更なる情報を訊ねるかもしれません。

..    Show weekly tips. Select to display useful advice and suggestions about using Docker.

* **Show Weekly tips** ：Docker の利用に役立つアドバイスや提案を表示します。

..    Open Docker Desktop dashboard at startup. Select to automatically open the dashboard when starting Docker Desktop.

* **Open Docker Desktop dashboard at startup** ：Docker Desktop の起動時に、ダッシュボードを自動的に開きます。

..    Use Docker Compose V2. Select to enable the docker-compose command to use Docker Compose V2. For more information, see Docker Compose V2.

* **Use Docker Compose V2** ：このオプションを選択すると、 ``docker-compose`` コマンドが Docker Compose V2 を使えるようにします。詳しい情報は :ref:`Docker Compose V2 <compose-v2-and-the-new-docker-compose-command>` をご覧ください。

.. Resources:
.. _desktop-mac-resources:

Resources（リソース）
==============================

.. The Resources tab allows you to configure CPU, memory, disk, proxies, network, and other resources.

**Resources** （リソース）タブでは、CPU 、メモリ、ディスク、プロキシ、ネットワーク、その他のリソースを設定できます。



.. Advanced
.. _desktop-mac-resources-advanced:

ADVANCED（高度な設定）
------------------------------

.. On the Advanced tab, you can limit resources available to Docker.

**Advanced** タブでは、 Docker が利用できるリソースを制限します。

.. Advanced settings are:

Advanced 設定とは、

.. CPUs: By default, Docker Desktop is set to use half the number of processors available on the host machine. To increase processing power, set this to a higher number; to decrease, lower the number.

* **CPUs** （CPU）：デフォルトでは、 ホストマシン上で利用可能なプロセッサ数の半分を、Docker Desktop が使います。処理能力を向上するには、この値を高くします。減らすには、数値を低くします。

.. Memory: By default, Docker Desktop is set to use 2 GB runtime memory, allocated from the total available memory on your Mac. To increase the RAM, set this to a higher number. To decrease it, lower the number.

* **Memory** （メモリ）：デフォルトでは、 マシン上で利用可能な全メモリから `2` GB の実行メモリを使用する設定です。RAM を増やすには、この値を高くします。減らすには、値を低くします。

.. Swap: Configure swap file size as needed. The default is 1 GB.

* **Swap** （スワップ）: 必要になるスワップファイル容量を設定します。デフォルトは 1 GB です。

.. Disk image size: Specify the size of the disk image.

* **Disk image size** （ディスクイメージ容量）：ディスクイメージの容量を指定します。

.. Disk image location: Specify the location of the Linux volume where containers and images are stored.

* **Disk image location** （ディスクイメージの場所）：Linux ボリュームの場所を指定します。ここにコンテナとイメージが置かれます。

.. You can also move the disk image to a different location. If you attempt to move a disk image to a location that already has one, you get a prompt asking if you want to use the existing image or replace it.

また、ディスクイメージは別の場所に移動できます。ディスクイメージの指定先に既にイメージがある場合は、既存のイメージを使うか置き換えるか訊ねる画面を表示します。

.. FILE SHARING
.. _desktop-mac-preferences-file-sharing:

FILE SHARING（ファイル共有）
------------------------------

.. Use File sharing to allow local directories on your machine to be shared with Linux containers. This is especially useful for editing source code in an IDE on the host while running and testing the code in a container.

Linux コンテナと共有したいローカルのディレクトリを選択します。これはホスト上の IDE を用い、コンテナ内でコードの実行やテストをしている場合、ソースコードの編集に特に役立ちます。

.. By default the /Users, /Volume, /private, /tmp and /var/folders directory are shared. If your project is outside this directory then it must be added to the list, otherwise you may get Mounts denied or cannot start service errors at runtime.

デフォルトでは ``/Users`` 、 ``/Volume`` 、``/private`` 、 ``/tmp`` 、``/var/folders``  ディレクトリが共有されます。プロジェクトがこのディレクトリ外であれば、必ずこのリストに追加する必要があります。そうしなければ、 ``Mounts denied`` （マウント拒否）や ``cannot start serice``  （サービスを開始できない）エラーが実行時に出るでしょう。


.. File share settings are:

ファイル共有を設定するには：

..    Add a Directory: Click + and navigate to the directory you want to add.

* **Add a Directory（ディレクトリの追加）** ： `+` をクリックし、追加したいディレクトリを選択します。

.. Remove a Directory: Click - next to the directory you want to remove

* **Remove a Directory（ディレクトリの削除）** ：削除したいディレクトリの横にある `-` をクリックします。

..    Apply & Restart makes the directory available to containers using Docker’s bind mount (-v) feature.

* **Apply & Restart** （適用と再起動）によって、対象ディレクトリが Docker の :ruby:`バインド マウント <bind mount>` （ `-v` ）機能で利用できるようになります。



..    Tips on shared folders, permissions, and volume mounts

.. note::

   **共有フォルダ上でのパーミッションとボリューム マウントの tips**

   ..     Share only the directories that you need with the container. File sharing introduces overhead as any changes to the files on the host need to be notified to the Linux VM. Sharing too many files can lead to high CPU load and slow filesystem performance.
   * コンテナ内で必要とするディレクトリのみ共有できます。ファイル共有は、あらゆる変更をホスト上の Linux VM に対して通知する必要があるため、オーバーヘッドを招きます。多くのファイル共有によって、高い CPU 負荷とファイルシステム性能の低下を引き起こす可能性があります。

   ..     Shared folders are designed to allow application code to be edited on the host while being executed in containers. For non-code items such as cache directories or databases, the performance will be much better if they are stored in the Linux VM, using a data volume (named volume) or data container.

   * 共有フォルダとは、実行しているコンテナ内から、ホスト上にあるアプリケーションのコードを編集できるように設計されています。そのため、キャッシュ用のディレクトリや、データベースのようなソースコード以外の場合には、Linux VM に保管される :doc:`データ ボリューム </storage/volumes>` （ :ruby:`名前付きボリューム <named volume>` ）や :doc:`データ コンテナ </storage/volumes>` を使うほうが、パフォーマンスが良くなります。

   ..     If you share the whole of your home directory into a container, MacOS may prompt you to give Docker access to personal areas of your home directory such as your Reminders or Downloads.

   * コンテナ内に自分のホーム ディレクトリ全体を共有しようとすると、 MacOS はリマインダやダウンロードといったホームディレクトリ上の個人データエリアへのアクセスを、 Docker に許可するかどうか確認を求めます。

   ..     By default, Mac file systems are case-insensitive while Linux is case-sensitive. On Linux, it is possible to create 2 separate files: test and Test, while on Mac these filenames would actually refer to the same underlying file. This can lead to problems where an app works correctly on a Mac (where the file contents are shared) but fails when run in Linux in production (where the file contents are distinct). To avoid this, Docker Desktop insists that all shared files are accessed as their original case. Therefore, if a file is created called test, it must be opened as test. Attempts to open Test will fail with the error No such file or directory. Similarly, once a file called test is created, attempts to create a second file called Test will fail.
   ..   For more information, see Volume mounting requires file sharing for any project directories outside of /Users.)

   * Linux のファイルシステは :ruby:`大文字と小文字を区別する <case-sensitive>` のに対し、 Mac のファイルシステムはデフォルトでは :ruby:`大文字と小文字を区別しません <case-insensitive>` 。Linux 上では ``test`` と ``Test`` という２つのファイルを作成できますが、 Mac の場合は、これらファイル名を使うと、どちらも元になっている同じファイルにを参照します。これにより、Mac 上では（ファイル内容を共有していると）アプリケーションが正しく動かないよう問題を引き起こす可能性があり、 Linux の本番環境では（ファイル対象が明確に異なるため）障害になるでしょう。これを避けるため、 Docker Desktop は共有している全てのファイルを、オリジナルの大文字か小文字かにもどづいて関連づけます。そのため、 ``test`` という名前のファイルを作成すると、必ず ``test`` として開かれます。 ``Test`` を開こうとしても、 ``No such file or directory`` のエラーになります。同様に、まず ``test`` という名前でファイルを作成すると、次に ``Test`` という名前でファイルを作成しようとしても失敗します。

   詳しい情報は、 :ref:`/Users ディレクトリ外でファイル共有が必要なボリュームのマウント <volume-mounting-requires-file-sharing-for-any-project-directories-outside-of-users>` をご覧ください。

.. PROXIES
.. _desktop-mac-preferences-proxies:

PROXIES（プロキシ）
--------------------

.. HTTP/HTTPS proxies can be used when:

次のような時、 HTTP/HTTPS プロキシを使えます。

..  Logging in to Docker
    Pulling or pushing images
    Fetching artifacts during image builds
    Containers interact with the external network
    Scanning images

* Docker にログイン
* イメージの送受信
* イメージ構築中に成果物を取得
* コンテナが外部ネットワークと通信
* イメージの脆弱性検査

.. Each use case above is configured slightly differently.

これらの使用例ごとに、設定は若干異なります。

.. If the host uses a static HTTP/HTTPS proxy configuration, Docker Desktop reads this configuration and automatically uses these settings for logging into Docker and for pulling and pushing images.

ホストが静的な HTTP/HTTPS プロキシ設定を使う場合、この設定を Docker Desktop が自動的に読み込み、これらの設定を Docker へのログインやイメージ送受信のために使います。

.. If the host uses a more sophisticated HTTP/HTTPS configuration, enable Manual proxy configuration and enter a single upstream proxy URL of the form http://username:password@proxy:port.

ホスト上がより詳細な設定を使う場合は、 **Manual proxy configuration** （手動プロキシ設定）を有効にし、 ``http://username:password@proxy:port`` の形式で上流のプロキシ URL を入力します。

.. HTTP/HTTPS traffic from image builds and running containers is forwarded transparently to the same upstream proxy used for logging in and image pulls. If you want to override this behaviour and use different HTTP/HTTPS proxies for image builds and running containers, see Configure the Docker client.

イメージ構築やコンテナ実行中の HTTP/HTTPS トラフィックは、ログインやイメージ取得に使うのと同じ上流のプロキシに、透過的に転送されます。この挙動を上書きし、イメージ構築とコンテナ実行で異なる HTTP/HTTPS プロキシを使いたい場合は、 :ref:`Docker クライアントの設定 <proxy-configure-the-docker-client>` をご覧ください。

.. The HTTPS proxy settings used for scanning images are set using the HTTPS_PROXY environment variable.

イメージ検査に使う HTTPS プロキシを設定するには、 ``HTTPS_PROXY`` 環境変数を使って指定します。

.. Network
.. _desktop-mac-preferences-network:

NETWORK （ネットワーク）
------------------------------

.. You can configure Docker Desktop networking to work on a virtual private network (VPN). Specify a network address translation (NAT) prefix and subnet mask to enable Internet connectivity.

Docker Desktop のネットワーク機能を、仮想プライベート ネットワーク（VPN）でも機能するように設定できます。インターネットとの疎通を有効にするには、ネットワーク アドレス変換（NAT）プリフィックスとサブネットマスクを設定します。

.. Docker Engine
.. _desktop-mac-docker-engine:
Docker :ruby:`Engine <エンジン>`
========================================

.. The Docker Engine page allows you to configure the Docker daemon to determine how your containers run.

Docker Engine のページでは、Docker デーモンの設定や、どのようにしてコンテナを実行するかを決められます。

.. Type a JSON configuration file in the box to configure the daemon settings. For a full list of options, see the Docker Engine dockerd commandline reference.

デーモンの設定をするには、テキストボックス内に JSON 形式の設定ファイルとして入力します。オプションの一覧については、 Docker Engine の :doc:`dockerd コマンドライン・リファレンス </engine/reference/commandline/dockerd>` を御覧ください。

.. Click Apply & Restart to save your settings and restart Docker Desktop.

**Apply & Restart** （適用と再起動）をクリックし、設定を保存して Docker Desktop を再起動します。

.. Experimental Features
.. _desktop-mac-experimental-features:
Experimental Features（実験的機能）
========================================

.. Experimental features provide early access to future product functionality. These features are intended for testing and feedback only as they may change between releases without warning or can be removed entirely from a future release. Experimental features must not be used in production environments. Docker does not offer support for experimental features.

実験的機能は、今後提供する機能を先行利用できます。各機能は、テストやフィードバックを意図した、参考程度のものです。そのため、リリース時までに警告が出たり、今後のリリースでは削除されたりする場合があります。本番向けの環境では、実験的機能を決して使わないでください。Docker は実験的機能に対するサポートを提供していません。

.. For a list of current experimental features in the Docker CLI, see Docker CLI Experimental features.

Docker CLI における現在の実験的機能一覧は、 `Docker CLI Experimental features <https://github.com/docker/cli/blob/master/experimental/README.md>`_ をご覧ください。


.. Enable the new Apple Virtualization framework
.. _enable-the-new-apple-virtualization-framework:

新しい Apple Virtualization framework を有効化
--------------------------------------------------

.. Select Use the new Virtualization framework to allow Docker Desktop to use the new virtualization.framework instead of the ‘hypervisor.framework’. Ensure to reset your Kubernetes cluster when you enable the new Virtualization framework for the first time.

**Use the new Virtualization framework** （新しい Apple Virtualization framework を有効化）を選ぶと、 Docker Desktop は ``hypervisor.framework`` の代わりに、新しい ``virtualization.framework`` を使います。新しい仮想化フレームワークを有効化すると、初回は Kubernetes クラスタが確実にリセットされます。

.. Enable VirtioFS
.. _enable-virtiofs:

VirtioFS の有効化
--------------------

.. Docker Desktop for Mac lets developers use a new experimental file-sharing implementation called virtiofS; the current default is gRPC-FUSE. virtiofs has been found to significantly improve file sharing performance on macOS. For more details, see our blog post Speed boost achievement unlocked on Docker Desktop 4.6 for Mac.

Docker Desktop for Mac は、 `virtiofs <https://virtio-fs.gitlab.io/>`_ と呼ばれる新しい実験的ファイル共有実装を、開発者が使えるようにしています。つまり、現時点でのデフォルトは gRPC-FUSE です。virtiofs は macOS 上でファイル共有パフォーマンスを著しく改善するのが分かっています。詳細はブログ投稿 `Speed boost achievement unlocked on Docker Desktop 4.6 for Mac. <https://www.docker.com/blog/speed-boost-achievement-unlocked-on-docker-desktop-4-6-for-mac/>`_ をご覧ください。

.. To enable virtioFS:

virtioFS を有効化するには：

..    Verify that you are on the following macOS version:
        macOS 12.2 or later (for Apple Silicon)
        macOS 12.3 or later (for Intel)

1. macOS が以下のバージョンかどうかを確認

   * macOS 12.2 以上（Apple Silicon の場合）
   * macOS 12.3 以上（Intel の場合）

..    Select Enable VirtioFS accelerated directory sharing to enable virtioFS.

2. virtioFS を有効化するには **Enable VirtioFS accelerated directory sharing** を選ぶ

..    Click Apply & Restart.

3. **Apply & Restart** をクリック

.. Kubernetes
.. _desktop-mac-kubernetes:

Kubernetes
==========

.. Docker Desktop includes a standalone Kubernetes server that runs on your Mac, so that you can test deploying your Docker workloads on Kubernetes. To enable Kubernetes support and install a standalone instance of Kubernetes running as a Docker container, select Enable Kubernetes.

Docker Desktop には :ruby:`単独 <standalone>` の Kubernetes サーバが入っています。Kubernetes は Mac ホスト上で実行できますので、Kubernetes 上に Docker ワークロードを試験的にデプロイできます。Kubernetes サポートの有効化と、Docker コンテナとして Kubernetes のスタンドアロン インスタンスをインストールかつ実行するには、 **Enable Kubernetes** を選びます。

..    Select Show system containers (advanced) to view internal containers when using Docker commands.

Docker コマンドを使って内部コンテナを表示するには、 **Show system containers (advanced)** を選択します。

.. Select Reset Kubernetes cluster to delete all stacks and Kubernetes resources.

すべてのスタックと Kubernetes を削除するには、 **Reset Kubernetes cluster** を選択します。

.. For more information about using the Kubernetes integration with Docker Desktop, see Deploy on Kubernetes.

Docker Desktop と Kubernetes を統合して使うための詳しい情報は :doc:`Kubernetes </desktop/kubernetes>` をご覧ください。

.. Software Updates
.. _desktop-mac-software-updates:

Software Updates （ソフトウェア更新）
========================================

.. The Software Updates section notifies you of any updates available to Docker Desktop. When there’s a new update, you can choose to download the update right away, or click the Release Notes option to learn what’s included in the updated version.

**Software Updates** （ソフトウェア更新）セクションは、Docker Desktop で利用可能な更新バージョンを通知します。新しい更新があれば選択肢があります。すぐにダウンロードと更新をするか、あるいは、 **Release Notes** （リリースノート）のオプションで更新版で何が入ったのかを確認します。

.. Turn off the check for updates by clearing the Automatically check for updates check box. This disables notifications in the Docker menu and also the notification badge that appears on the Docker Dashboard. To check for updates manually, select the Check for updates option in the Docker menu.

チェックボックス **Automatically check for updates** をクリアすると、自動更新の確認をしません。無効化の通知は、 Docker メニューと、 Docker ダッシュボード上の通知バッジからも分かります。手動で更新を確認するには、 Docker メニューから **Check for updates** オプションを選びます。

.. To allow Docker Desktop to automatically download new updates in the background, select Always download updates. This downloads newer versions of Docker Desktop when an update becomes available. After downloading the update, click Apply and Restart to install the update. You can do this either through the Docker menu or in the Updates section in the Docker Dashboard.

Docker Desktop の新しい更新の自動ダウンロードを、バックグラウンドで行いたい場合は、 **Always download updates** を選びます。これは、Docker の更新版が利用可能になると、新しいバージョンをダウンロードします。この設定をするには、 Docker メニューだけでなく、 Docker ダッシュボードの **Updates** セクションからも行えます。

.. Extensions:
.. _desktop-mac-extensions:

Extensions
==========

.. Use the Extensions tab to:

**Extensions** タブを使い、次のことができます。

..  Enable Docker Extensions
    Allow only extensions distributed through the Docker Marketplace
    Show Docker Extensions system containers

* **Docker Extensions の有効化**
* **Docker マーケットプレイスを通して配布されるエクステンションのみ許可**
* **Docker Extensions システムコンテナの表示**

.. For more information about Docker extensions, see Extensions.

Docker Extensions に関する詳しい情報は、 :doc:`Extensions </desktop/extensions>` をご覧ください。

.. seealso::

   Change Docker Desktop preferences on Mac
      https://docs.docker.com/desktop/settings/mac/

