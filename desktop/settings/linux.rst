.. H-*- coding: utf-8 -*-
.. URL: https://docs.docker.com/desktop/settings/linux/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/desktop/settings/linux.md
.. check date: 2022/09/17
.. Commits on Sep 8, 2022 8bce7328f1d7f6df2ccd508d2f2970c244ebc10f
.. -----------------------------------------------------------------------------

.. |whale| image:: /desktop/install/images/whale-x.png
      :width: 50%

.. Change Docker Desktop preferences on Linux
.. _change-docker-desktop-preferences-on-linux:

==================================================
Linux 版 Docker Desktop の設定変更
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
.. _desktop-linux-general:

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

.. Send usage statistics. Select so Docker Desktop sends diagnostics, crash reports, and usage data. This information helps Docker improve and troubleshoot the application. Clear the check box to opt out. Docker may periodically prompt you for more information.

* **Send usage statics** （利用統計情報の送信）： デフォルトでは、Docker Desktop は診断情報・クラッシュ報告・利用データを送信します。この情報は、 Docker の改善やアプリケーションの問題解決に役立ちます。止めるにはチェックボックスを空にします。Docker は定期的に更なる情報を訊ねるかもしれません。

..    Show weekly tips. Select to display useful advice and suggestions about using Docker.

* **Show Weekly tips** ：Docker の利用に役立つアドバイスや提案を表示します。

..    Open Docker Desktop dashboard at startup. Select to automatically open the dashboard when starting Docker Desktop.

* **Open Docker Desktop dashboard at startup** ：Docker Desktop の起動時に、ダッシュボードを自動的に開きます。

..    Use Docker Compose V2. Select to enable the docker-compose command to use Docker Compose V2. For more information, see Docker Compose V2.

* **Use Docker Compose V2** ：このオプションを選択すると、 ``docker-compose`` コマンドが Docker Compose V2 を使えるようにします。詳しい情報は :ref:`Docker Compose V2 <compose-v2-and-the-new-docker-compose-command>` をご覧ください。

.. Resources:
.. _desktop-linux-resources:
Resources（リソース）
==============================

.. The Resources tab allows you to configure CPU, memory, disk, proxies, network, and other resources.

**Resources** （リソース）タブでは、CPU 、メモリ、ディスク、プロキシ、ネットワーク、その他のリソースを設定できます。

.. Advanced
.. _desktop-linux-resources-advanced:
ADVANCED（高度な設定）
------------------------------

.. On the Advanced tab, you can limit resources available to Docker.

**Advanced** タブでは、 Docker が利用できるリソースを制限します。

.. Advanced settings are:

Advanced 設定とは、

.. CPUs: By default, Docker Desktop is set to use half the number of processors available on the host machine. To increase processing power, set this to a higher number; to decrease, lower the number.

* **CPUs** （CPU）：デフォルトでは、 ホストマシン上で利用可能なプロセッサ数の半分を、Docker Desktop が使います。処理能力を向上するには、この値を高くします。減らすには、数値を低くします。

.. Memory: By default, Docker Desktop is set to use 25% of your host’s memory. To increase the RAM, set this to a higher number; to decrease it, lower the number.

By default, Docker Desktop is set to use 2 GB runtime memory, allocated from the total available memory on your Mac. To increase the RAM, set this to a higher number. To decrease it, lower the number.

* **Memory** （メモリ）：デフォルトでは、 ホスト上のメモリの 25% を使う設定です。RAM を増やすには、この値を高くします。減らすには、値を低くします。

.. Swap: Configure swap file size as needed. The default is 1 GB.

* **Swap** （スワップ）: 必要になるスワップファイル容量を設定します。デフォルトは 1 GB です。

.. Disk image size: Specify the size of the disk image.

* **Disk image size** （ディスクイメージ容量）：ディスクイメージの容量を指定します。

.. Disk image location: Specify the location of the Linux volume where containers and images are stored.

* **Disk image location** （ディスクイメージの場所）：Linux ボリュームの場所を指定します。ここにコンテナとイメージが置かれます。

.. You can also move the disk image to a different location. If you attempt to move a disk image to a location that already has one, you get a prompt asking if you want to use the existing image or replace it.

また、ディスクイメージは別の場所に移動できます。ディスクイメージの指定先に既にイメージがある場合は、既存のイメージを使うか置き換えるか訊ねる画面を表示します。

.. FILE SHARING
.. _desktop-linux-preferences-file-sharing:

FILE SHARING（ファイル共有）
------------------------------


.. Use File sharing to allow local directories on your machine to be shared with Linux containers. This is especially useful for editing source code in an IDE on the host while running and testing the code in a container.

Linux コンテナと共有したいローカルのディレクトリを選択します。これはホスト上の IDE を用い、コンテナ内でコードの実行やテストをしている場合、ソースコードの編集に特に役立ちます。

.. By default the /home/<user> directory is shared. If your project is outside this directory then it must be added to the list, otherwise you may get Mounts denied or cannot start service errors at runtime.

デフォルトでは ``/home/<user>`` ディレクトリが共有されます。プロジェクトがこのディレクトリ以外の場合は、リストに追加する必要があります。そうしなければ、実行時に ``Mounts denined`` や ``cannot start service`` エラーが出ます。


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


.. PROXIES
.. _desktop-linux-preferences-proxies:

PROXIES（プロキシ）
--------------------

.. To configure HTTP proxies, switch on the Manual proxy configuration setting.

HTTP プロキシを設定するには、 **Manual proxy configuration** 設定を切り替えます。

.. Your proxy settings, however, are not propagated into the containers you start. If you wish to set the proxy settings for your containers, you need to define environment variables for them, just like you would do on Linux, for example:

プロキシを設定しても、コンテナを開始するまで情報は伝わりません。コンテナにプロキシ設定を指定したい場合は、環境変数を使って指定します。Linux であれば、次のようにします。

.. code-block:: bash

   $ docker run -e HTTP_PROXY=http://proxy.example.com:3128 alpine env
   
   PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   HOSTNAME=b7edf988b2b5
   TERM=xterm
   HOME=/root
   HTTP_PROXY=http://proxy.example.com:3128

.. For more information on setting environment variables for running containers, see Set environment variables.

実行中のコンテナに対し、環境変数を設定する詳しい情報は、 :ref:`環境変数の設定 <docker_run-set-environment-variable>` をご覧ください。


.. Network
.. _desktop-linux-preferences-network:

NETWORK （ネットワーク）
------------------------------

.. Docker Desktop uses a private IPv4 network for internal services such as a DNS server and an HTTP proxy. In case the choice of subnet clashes with something in your environment, specify a custom subnet using the Network setting.

Docker Desktop は DNS サーバと HTTP プロキシのような内部サービスのために、プライベートな IPv4 ネットワークを使います。自分の環境とサブネットが被ってしまう場合は、 **NETWORK** 設定で任意のサブネットを指定します。


.. Docker Engine
.. _desktop-linux-docker-engine:
Docker :ruby:`Engine <エンジン>`
========================================

.. The Docker Engine page allows you to configure the Docker daemon to determine how your containers run.

Docker Engine のページでは、Docker デーモンの設定や、どのようにしてコンテナを実行するかを決められます。

.. Type a JSON configuration file in the box to configure the daemon settings. For a full list of options, see the Docker Engine dockerd commandline reference.

デーモンの設定をするには、テキストボックス内に JSON 形式の設定ファイルとして入力します。オプションの一覧については、 Docker Engine の :doc:`dockerd コマンドライン・リファレンス </engine/reference/commandline/dockerd>` を御覧ください。

.. Click Apply & Restart to save your settings and restart Docker Desktop.

**Apply & Restart** （適用と再起動）をクリックし、設定を保存して Docker Desktop を再起動します。

.. Experimental Features
.. _desktop-linux-experimental-features:
Experimental Features（実験的機能）
========================================

.. Experimental features provide early access to future product functionality. These features are intended for testing and feedback only as they may change between releases without warning or can be removed entirely from a future release. Experimental features must not be used in production environments. Docker does not offer support for experimental features.

実験的機能は、今後提供する機能を先行利用できます。各機能は、テストやフィードバックを意図した、参考程度のものです。そのため、リリース時までに警告が出たり、今後のリリースでは削除されたりする場合があります。本番向けの環境では、実験的機能を決して使わないでください。Docker は実験的機能に対するサポートを提供していません。

.. For a list of current experimental features in the Docker CLI, see Docker CLI Experimental features.

Docker CLI における現在の実験的機能一覧は、 `Docker CLI Experimental features <https://github.com/docker/cli/blob/master/experimental/README.md>`_ をご覧ください。

.. From the Experimental features tab, you can sign up to the Developer Preview program.

**Experimental features** タブからは、 `Developer Preview Proguram <https://www.docker.com/community/get-involved/developer-preview/>`_ にサインアップしてください。

.. Kubernetes
.. _desktop-linux-kubernetes:

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
.. _desktop-linux-software-updates:

Software Updates （ソフトウェア更新）
========================================

.. The Software Updates section notifies you of any updates available to Docker Desktop. When there’s a new update, you can choose to download the update right away, or click the Release Notes option to learn what’s included in the updated version.

**Software Updates** （ソフトウェア更新）セクションは、Docker Desktop で利用可能な更新バージョンを通知します。新しい更新があれば選択肢があります。すぐにダウンロードと更新をするか、あるいは、 **Release Notes** （リリースノート）のオプションで更新版で何が入ったのかを確認します。

.. Turn off the check for updates by clearing the Automatically check for updates check box. This disables notifications in the Docker menu and also the notification badge that appears on the Docker Dashboard. To check for updates manually, select the Check for updates option in the Docker menu.

チェックボックス **Automatically check for updates** をクリアすると、自動更新の確認をしません。無効化の通知は、 Docker メニューと、 Docker ダッシュボード上の通知バッジからも分かります。手動で更新を確認するには、 Docker メニューから **Check for updates** オプションを選びます。

.. To allow Docker Desktop to automatically download new updates in the background, select Always download updates. This downloads newer versions of Docker Desktop when an update becomes available. After downloading the update, click Apply and Restart to install the update. You can do this either through the Docker menu or in the Updates section in the Docker Dashboard.

Docker Desktop の新しい更新の自動ダウンロードを、バックグラウンドで行いたい場合は、 **Always download updates** を選びます。これは、Docker の更新版が利用可能になると、新しいバージョンをダウンロードします。この設定をするには、 Docker メニューだけでなく、 Docker ダッシュボードの **Updates** セクションからも行えます。

.. Extensions:
.. _desktop-linux-extensions:

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

   Change Docker Desktop settings on Linux
      https://docs.docker.com/desktop/settings/linux/


