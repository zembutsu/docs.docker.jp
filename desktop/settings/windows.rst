.. H-*- coding: utf-8 -*-
.. URL: https://docs.docker.com/desktop/settings/windows/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/desktop/settings/windows.md
.. check date: 2022/09/17
.. Commits on Sep 8, 2022 8bce7328f1d7f6df2ccd508d2f2970c244ebc10f
.. -----------------------------------------------------------------------------

.. |whale| image:: /desktop/install/images/whale-x.png
      :scale: 50%

.. Change Docker Desktop preferences on Windows
.. _change-docker-desktop-preferences-on-windows:

==================================================
Windows 版 Docker Desktop の設定変更
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
.. _desktop-windows-general:

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

.. Expose daemon on tcp://localhost:2375 without TLS - Click this option to enable legacy clients to connect to the Docker daemon. You must use this option with caution as exposing the daemon without TLS can result in remote code execution attacks.

* **Expose daemon on tcp://localhost:2357 without TLS** ：古い（レガシーの）クライアントが Docker デーモンに接続できるようにするには、このオプションを有効化します。このオプションを使う場合は注意が必要です。TLS なしでデーモンを公開する場合は、リモートからのコード実行攻撃をもたらす可能性があるためです。

.. Use the WSL 2 based engine: WSL 2 provides better performance than the legacy Hyper-V backend. For more information, see Docker Desktop WSL 2 backend.

* **Use the WSL 2 based engine** （WSL 2 基盤の Engine を使う）：WSL2 は以前の Hyper-V バックエンドより良いパフォーマンスを提供します。詳しい情報は :doc:`Docker Desktop WSL 2 バックエンド <wsl>` をご覧ください。

.. Send usage statistics. Select so Docker Desktop sends diagnostics, crash reports, and usage data. This information helps Docker improve and troubleshoot the application. Clear the check box to opt out. Docker may periodically prompt you for more information.

* **Send usage statics** （利用統計情報の送信）： デフォルトでは、Docker Desktop は診断情報・クラッシュ報告・利用データを送信します。この情報は、 Docker の改善やアプリケーションの問題解決に役立ちます。止めるにはチェックボックスを空にします。Docker は定期的に更なる情報を訊ねるかもしれません。

..    Show weekly tips. Select to display useful advice and suggestions about using Docker.

* **Show Weekly tips** ：Docker の利用に役立つアドバイスや提案を表示します。

..    Open Docker Desktop dashboard at startup. Select to automatically open the dashboard when starting Docker Desktop.

* **Open Docker Desktop dashboard at startup** ：Docker Desktop の起動時に、ダッシュボードを自動的に開きます。

..    Use Docker Compose V2. Select to enable the docker-compose command to use Docker Compose V2. For more information, see Docker Compose V2.

* **Use Docker Compose V2** ：このオプションを選択すると、 ``docker-compose`` コマンドが Docker Compose V2 を使えるようにします。詳しい情報は :ref:`Docker Compose V2 <compose-v2-and-the-new-docker-compose-command>` をご覧ください。

.. Resources:
.. _desktop-windows-resources:
Resources（リソース）
==============================

.. The Resources tab allows you to configure CPU, memory, disk, proxies, network, and other resources. Different settings are available for configuration depending on whether you are using Linux containers in WSL 2 mode, Linux containers in Hyper-V mode, or Windows containers.

**Resources** （リソース）タブでは、CPU 、メモリ、ディスク、プロキシ、ネットワーク、その他のリソースを設定できます。どのような項目が設定可能かについては、 WSL 2 モードで Linux コンテナを使うか、 Hyper-V モードで Linux コンテナを使うか、 Windows コンテナーを使うかにより異なります。

.. Advanced
.. _desktop-windows-resources-advanced:
ADVANCED（高度な設定）
------------------------------

..  Note
    The Advanced tab is only available in Hyper-V mode, because Windows manages the resources in WSL 2 mode and Windows container mode. In WSL 2 mode, you can configure limits on the memory, CPU, and swap size allocated to the WSL 2 utility VM.

.. note::

   Advanced タブは Hyper-V モードでのみ利用できます。これは Windows が WSL 2 モードと Windows コンテナー モードのリソースを管理するからです。 WSL 2 モードで設定するには、 `WSL 2 が使う仮想マシン <https://docs.microsoft.com/ja-jp/windows/wsl/wsl-config#configure-global-options-with-wslconfig>`_ に対してメモリ、CPU、スワップの割り当てを制限できます。

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
.. _desktop-windows-preferences-file-sharing:

FILE SHARING（ファイル共有）
------------------------------

..  Note
    The Advanced tab is only available in Hyper-V mode, because Windows manages the resources in WSL 2 mode and Windows container mode. In WSL 2 mode, you can configure limits on the memory, CPU, and swap size allocated to the WSL 2 utility VM.

.. note::

   Advanced タブは Hyper-V モードでのみ利用できます。これは Windows が WSL 2 モードと Windows コンテナー モードのリソースを管理するからです。 WSL 2 モードで設定するには、 `WSL 2 が使う仮想マシン <https://docs.microsoft.com/ja-jp/windows/wsl/wsl-config#configure-global-options-with-wslconfig>`_ に対してメモリ、CPU、スワップの割り当てを制限できます。

.. Use File sharing to allow local directories on your machine to be shared with Linux containers. This is especially useful for editing source code in an IDE on the host while running and testing the code in a container.

Linux コンテナと共有したいローカルのディレクトリを選択します。これはホスト上の IDE を用い、コンテナ内でコードの実行やテストをしている場合、ソースコードの編集に特に役立ちます。

.. Note that configuring file sharing is not necessary for Windows containers, only Linux containers. If a directory is not shared with a Linux container you may get file not found or cannot start service errors at runtime. See Volume mounting requires shared folders for Linux containers.

ファイル共有は :ref:`Linux コンテナ <windowsfaqs-how-do-i-switch-between-windows-and-linux-containers>` 内でボリュームをマウントするために必要であり、Windows コンテナ－用ではありません。ディレクトリが Linux コンテナと共有されていなければ、実行時に :code:`file not found` （ファイルが見つかりません）や :code:`cannot start service` （サービスを開始できません）のエラーが出ます。詳しくは :ref:`volume-mounting-requires-shared-drives-for-linux-containers` を御覧ください。

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


   **共有ドライブ、権限、ボリューム・マウントに役立つ情報**

   .. Share only the directories that you need with the container. File sharing introduces overhead as any changes to the files on the host need to be notified to the Linux VM. Sharing too many files can lead to high CPU load and slow filesystem performance.
   * コンテナが必要なディレクトリのみ共有できます。ファイル共有によって、ホスト上のファイルに対するあらゆる変更をLinux 仮想マシンに対して通知する必要があるため、（パフォーマンスの）オーバーヘッドを招く可能があります。非常に多くのファイル共有は、高い CPU 負荷とファイルシステム性能の低下を引き起こす可能性があります。

   .. Shared folders are designed to allow application code to be edited on the host while being executed in containers. For non-code items such as cache directories or databases, the performance will be much better if they are stored in the Linux VM, using a data volume (named volume) or data container.
   * Shared folder（共有フォルダ）とはコンテナの実行時、ホスト上にあるアプリケーションのコードを編集できるようにするための設計です。キャッシュ ディレクトリやデータベースのようなコード以外のものは、 :doc:`データ ボリューム </storage/volume>` （名前付きボリューム）や :doc:`データ コンテナ </storage/volume>` を使う方が、 Linux 仮想マシンに保管するよりもパフォーマンスは向上するでしょう。
   
   .. Docker Desktop sets permissions to read/write/execute for users, groups and others 0777 or a+rwx. This is not configurable. See Permissions errors on data directories for shared volumes.
   * Docker Desktop はユーザ、グループ、その他に対する読み込み／書き込み／実行権限を `0777 あるいは a+rwx <http://permissions-calculator.org/decode/0777/>`_  に設定します。これは調整できません。詳細は :ref:`共有ボリュームでのデータディレクトリ上のパーミッション エラー <win-permissions-errors-on-data-directories-for-shared-volumes>` を御覧ください。
   
   .. Windows presents a case-insensitive view of the filesystem to applications while Linux is case-sensitive. On Linux, it is possible to create two separate files: test and Test, while on Windows these filenames would actually refer to the same underlying file. This can lead to problems where an app works correctly on a developer Windows machine (where the file contents are shared) but fails when run in Linux in production (where the file contents are distinct). To avoid this, Docker Desktop insists that all shared files are accessed as their original case. Therefore if a file is created called test, it must be opened as test. Attempts to open Test will fail with “No such file or directory”. Similarly once a file called test is created, attempts to create a second file called Test will fail.
   * Linux が大文字小文字を区別している場合に限り、Windows はアプリケーションが見えるファイルシステムで大文字小文字を区別できるように表示します。Linux 上では :code:`test` と :code:`Test` という2つの異なるファイルを作成できますが、Windows 上では各ファイルは実際には同じファイルが基になります。これは開発者の Windows マシン上では（コンテンツを共有している場合に）アプリケーションの動作に問題を引き起こす可能性がある程度です。しかし、プロダクションにおける Linux では問題が発生するでしょう（ファイルが明確に識別されるため）。これを避けるためには、Docker Desktop に対して全ての共有ファイルをオリジナル通りにアクセスするよう要求します。つまり、 :code:`test` というファイルを作成したら、必ず :code:`test`  で開くようにします。 :code:`Test`  というファイルを開こうとしても、 "No such file or directry" となり失敗します。似たようなものとして、 :code:`test` というファイルを作成し、その次に :code:`Test` ファイルを作成しようとしても失敗します。

.. Shared folders on demand
.. _desktop-windows-shared-folders-on-demand:

Shared folders on demand（オンデマンド共有フォルダ）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. You can share a folder “on demand” the first time a particular folder is used by a container.

個々のマウントが必要な場合、初回に "オンデマンド" でコンテナが使うフォルダを共有できます。

.. If you run a Docker command from a shell with a volume mount (as shown in the example below) or kick off a Compose file that includes volume mounts, you get a popup asking if you want to share the specified folder

シェルでボリューム・マウント（以下に例があります）する Docker コマンドの実行時や、Compose ファイルで立ち上げ時にボリュームのマウントがあれば、特定のフォルダを共有するかどうか訊ねるポップアップが現れます。

.. You can select to Share it, in which case it is added to your Docker Desktop Shared Folders list and available to containers. Alternatively, you can opt not to share it by selecting Cancel.

**Share it** （共有する）を選択でき、Docker Desktop の「共有フォルダ一覧」にあるいずれかを、コンテナで利用可能になります。あるいは、共有したくない場合には **Cancel** （中止）を選べます。


.. PROXIES
.. _desktop-windows-preferences-proxies:

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
.. _desktop-windows-preferences-network:

NETWORK （ネットワーク）
------------------------------

..  Note
    The Network tab is not available in the Windows container mode because Windows manages networking.

.. note::

   Windows コンテナー モードでは Windows がネットワーク機能を管理するため、 Network タブを利用できません。

.. You can configure Docker Desktop networking to work on a virtual private network (VPN). Specify a network address translation (NAT) prefix and subnet mask to enable Internet connectivity.

Docker Desktop のネットワーク機能を、仮想プライベート ネットワーク（VPN）でも機能するように設定できます。インターネットとの疎通を有効にするには、ネットワーク アドレス変換（NAT）プリフィックスとサブネットマスクを設定します。


.. WSL Integration
.. _desktop-windows-wsl-integration:

WSL Integration
--------------------

.. In WSL 2 mode, you can configure which WSL 2 distributions will have the Docker WSL integration.

WSL 2 モードでは、Docker WSL :ruby:`統合機能 <integration>` で、どの WSL2 ディストリビューションを使うか設定できます。

.. By default, the integration will be enabled on your default WSL distribution. To change your default WSL distro, run wsl --set-default <distro name>. (For example, to set Ubuntu as your default WSL distro, run wsl --set-default ubuntu).

デフォルトでは、統合機能はデフォルトの WSL ディストリビューションを使います。デフォルトの WSL ディストリビューションを変更するには、 ``wsl --set-default <distro name>`` のように実行します。（たとえば、デフォルトの WSL ディストリビューションとして Ubuntu を指定するには、 ``wsl --set-default ubuntu`` を実行します）。

.. You can also select any additional distributions you would like to enable the WSL 2 integration on.

また、WSL 2 統合機能上で利用可能な、追加ディストリビューションも選択できます。

.. For more details on configuring Docker Desktop to use WSL 2, see Docker Desktop WSL 2 backend.

Docker Desktop 上で WSL 2 を利用する設定の詳細は、 :doc:`Docker Desktop WSL 2 バックエンド <wsl>` をご覧ください。


.. Docker Engine
.. _desktop-windows-docker-engine:
Docker :ruby:`Engine <エンジン>`
========================================

.. The Docker Engine page allows you to configure the Docker daemon to determine how your containers run.

Docker Engine のページでは、Docker デーモンの設定や、どのようにしてコンテナを実行するかを決められます。

.. Type a JSON configuration file in the box to configure the daemon settings. For a full list of options, see the Docker Engine dockerd commandline reference.

デーモンの設定をするには、テキストボックス内に JSON 形式の設定ファイルとして入力します。オプションの一覧については、 Docker Engine の :doc:`dockerd コマンドライン・リファレンス </engine/reference/commandline/dockerd>` を御覧ください。

.. Click Apply & Restart to save your settings and restart Docker Desktop.

**Apply & Restart** （適用と再起動）をクリックし、設定を保存して Docker Desktop を再起動します。

.. Experimental Features
.. _desktop-windows-experimental-features:
Experimental Features（実験的機能）
========================================

.. Experimental features provide early access to future product functionality. These features are intended for testing and feedback only as they may change between releases without warning or can be removed entirely from a future release. Experimental features must not be used in production environments. Docker does not offer support for experimental features.

実験的機能は、今後提供する機能を先行利用できます。各機能は、テストやフィードバックを意図した、参考程度のものです。そのため、リリース時までに警告が出たり、今後のリリースでは削除されたりする場合があります。本番向けの環境では、実験的機能を決して使わないでください。Docker は実験的機能に対するサポートを提供していません。

.. For a list of current experimental features in the Docker CLI, see Docker CLI Experimental features.

Docker CLI における現在の実験的機能一覧は、 `Docker CLI Experimental features <https://github.com/docker/cli/blob/master/experimental/README.md>`_ をご覧ください。



.. Kubernetes
.. _desktop-windows-kubernetes:

Kubernetes
==========

..     Note
    The Kubernetes tab is not available in Windows container mode.

.. note::

   Windows コンテナー モードでは、 Kuberentes タブを利用できません。

.. Docker Desktop includes a standalone Kubernetes server that runs on your Mac, so that you can test deploying your Docker workloads on Kubernetes. To enable Kubernetes support and install a standalone instance of Kubernetes running as a Docker container, select Enable Kubernetes.

Docker Desktop には :ruby:`単独 <standalone>` の Kubernetes サーバが入っています。Kubernetes は Mac ホスト上で実行できますので、Kubernetes 上に Docker ワークロードを試験的にデプロイできます。Kubernetes サポートの有効化と、Docker コンテナとして Kubernetes のスタンドアロン インスタンスをインストールかつ実行するには、 **Enable Kubernetes** を選びます。

..    Select Show system containers (advanced) to view internal containers when using Docker commands.

Docker コマンドを使って内部コンテナを表示するには、 **Show system containers (advanced)** を選択します。

.. Select Reset Kubernetes cluster to delete all stacks and Kubernetes resources.

すべてのスタックと Kubernetes を削除するには、 **Reset Kubernetes cluster** を選択します。

.. For more information about using the Kubernetes integration with Docker Desktop, see Deploy on Kubernetes.

Docker Desktop と Kubernetes を統合して使うための詳しい情報は :doc:`Kubernetes </desktop/kubernetes>` をご覧ください。

.. Software Updates
.. _desktop-windows-software-updates:

Software Updates （ソフトウェア更新）
========================================

.. The Software Updates section notifies you of any updates available to Docker Desktop. When there’s a new update, you can choose to download the update right away, or click the Release Notes option to learn what’s included in the updated version.

**Software Updates** （ソフトウェア更新）セクションは、Docker Desktop で利用可能な更新バージョンを通知します。新しい更新があれば選択肢があります。すぐにダウンロードと更新をするか、あるいは、 **Release Notes** （リリースノート）のオプションで更新版で何が入ったのかを確認します。

.. Turn off the check for updates by clearing the Automatically check for updates check box. This disables notifications in the Docker menu and also the notification badge that appears on the Docker Dashboard. To check for updates manually, select the Check for updates option in the Docker menu.

チェックボックス **Automatically check for updates** をクリアすると、自動更新の確認をしません。無効化の通知は、 Docker メニューと、 Docker ダッシュボード上の通知バッジからも分かります。手動で更新を確認するには、 Docker メニューから **Check for updates** オプションを選びます。

.. To allow Docker Desktop to automatically download new updates in the background, select Always download updates. This downloads newer versions of Docker Desktop when an update becomes available. After downloading the update, click Apply and Restart to install the update. You can do this either through the Docker menu or in the Updates section in the Docker Dashboard.

Docker Desktop の新しい更新の自動ダウンロードを、バックグラウンドで行いたい場合は、 **Always download updates** を選びます。これは、Docker の更新版が利用可能になると、新しいバージョンをダウンロードします。この設定をするには、 Docker メニューだけでなく、 Docker ダッシュボードの **Updates** セクションからも行えます。

.. Extensions:
.. _desktop-windows-extensions:

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

   Change Docker Desktop settings on Windows
      https://docs.docker.com/desktop/settings/windows/


