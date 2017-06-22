.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/installation/linux/ubuntulinux/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/installation/linux/ubuntulinux.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/installation/linux/ubuntulinux.md
.. check date: 2016/06/13
.. Commits on Jun 2, 2016 53a1de2b1651f0cd5fb3a1f5a3c26f4d5f5dd9b2
.. ----------------------------------------------------------------------------

.. Ubuntu

==============================
Ubuntu
==============================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Docker is supported on these Ubuntu operating systems:

Docker は以下のオペレーティング・システムをサポートしています。

* Ubuntu Xenial 16.04 (LTS)
* Ubuntu Wily 15.10
* Ubuntu Trusty 14.04 (LTS)
* Ubuntu Precise 12.04 (LTS)

.. This page instructs you to install using Docker-managed release packages and installation mechanisms. Using these packages ensures you get the latest release of Docker. If you wish to install using Ubuntu-managed packages, consult your Ubuntu documentation.

このページは、Docker が管理しているパッケージとインストール手順で作業します。Docker が提供する最新リリースのパッケージを使えるようにします。もし Ubuntu が管理するパッケージを使いたい場合は、Ubuntu のドキュメントをお調べください。

..    Note: Ubuntu Utopic 14.10 and 15.04 exist in Docker’s APT repository but are no longer officially supported.

.. note::

   Ubuntu Utopic 14.10 と 15.04 には Docker の ``apt`` リポジトリが存在しますが、（Dockerが）公式にサポートしていません。

.. Prerequisites

動作条件
====================

.. Docker requires a 64-bit installation regardless of your Ubuntu version. Additionally, your kernel must be 3.10 at minimum. The latest 3.10 minor version or a newer maintained version are also acceptable.

Docker は 64 bit でインストールされた何らかの Ubuntu バージョンを必要とします。加えて、kernel は少なくとも 3.10 以上が必要です。最新の 3.10 マイナーバージョンか、それよりも新しいバージョンを利用可能です。

.. Kernels older than 3.10 lack some of the features required to run Docker containers. These older versions are known to have bugs which cause data loss and frequently panic under certain conditions.

3.10 よりも低いカーネルは、Docker コンテナ実行時に必要な一部の機能が足りません。古いバージョンは既知のバグがあります。その影響により、特定条件下でデータの損失や定期的なカーネルパニックを引き起こします。

.. To check your current kernel version, open a terminal and use uname -r to display your kernel version:

現在のカーネル・バージョンを確認するには、ターミナルを開き、 ``uname -r``  を使ってカーネルのバージョンを確認します。

.. code-block:: bash

   $ uname -r
   3.11.0-15-generic

..    Note: If you previously installed Docker using apt, make sure you update your apt sources to the new Docker repository.

.. note::

   以前に Docker を ``apt`` でインストールしていた場合は、 ``apt`` ソースを新しい Docker リポジトリに更新してください。

.. Update your apt sources

apt ソースの更新
--------------------

.. Docker’s apt repository contains Docker 1.7.1 and higher. To set apt to use packages from the new repository:

Docker 1.7.1 以上は Docker の ``apt`` リポジトリに保管されています。 ``apt`` が新しいリポジトリにあるパッケージを使えるように設定します。

.. Log into your machine as a user with `sudo` or `root` privileges.

1. マシンに ``sudo`` もしくは ``root`` 特権のあるユーザでログインします。

..    Open a terminal window.

2. ターミナルのウインドウを開きます。

.. Update package information, ensure that APT works with the https method, and that CA certificates are installed.

3. パッケージ情報を更新します。 APT が ``https`` メソッドで動作することを確認し、 ``CA`` 証明書がインストールされるのを確認します。

.. code-block:: bash

   $ sudo apt-get update
   $ sudo apt-get install apt-transport-https ca-certificates

..    Add the new gpg key.

4. 新しい ``GPG`` 鍵を追加します。

.. code-block:: bash

   $ sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

..    Open the /etc/apt/sources.list.d/docker.list file in your favorite editor.

5. ``/etc/apt/sources.list.d/docker.list`` ファイルを任意のエディタで開きます。

..    If the file doesn’t exist, create it.

ファイルが存在しなければ、作成します。

..    Remove any existing entries.

6. 既存のエントリがあれば削除します。

..    Add an entry for your Ubuntu operating system.

7. Ubuntu オペレーティング・システム向けのエントリを追加します。

..    The possible entries are:

利用可能なエントリは以下の通りです。

..        On Ubuntu Precise 12.04 (LTS)

* Ubuntu Precise 12.04 (LTS)

.. code-block:: bash

   deb https://apt.dockerproject.org/repo ubuntu-precise main

..        On Ubuntu Trusty 14.04 (LTS)

* Ubuntu Trusty 14.04 (LTS)

.. code-block:: bash

   deb https://apt.dockerproject.org/repo ubuntu-trusty main

..        Ubuntu Wily 15.10

* Ubuntu Wily 15.10

.. code-block:: bash

   deb https://apt.dockerproject.org/repo ubuntu-wily main

..        Ubuntu Xenial 16.04 (LTS)

* Ubuntu Xenial 16.04 (LTS)

.. code-block:: bash

   deb https://apt.dockerproject.org/repo ubuntu-xenial main

.. Note: Docker does not provide packages for all architectures. You can find nightly built binaries in https://master.dockerproject.org. To install docker on a multi-architecture system, add an [arch=...] clause to the entry. Refer to the Debian Multiarch wiki for details.

.. note::

   Docker のパッケージは全てのアーキテクチャに対応していません。しかし、毎晩構築（nightly build）のバイナリは https://master.dockerproject.org/ にあります。Docker をマルチ・アーキテクチャのシステムにインストールするには、 ``[arch=...]`` エントリの項目を追加します。詳細は `Debian Multiarch wiki <https://wiki.debian.org/Multiarch/HOWTO#Setting_up_apt_sources>`_ をご覧ください。

..    Save and close the /etc/apt/sources.list.d/docker.list file.

8. ``/etc/apt/sources.list.d/docker.list`` ファイルを保存して閉じます。

..    Update the apt package index.

9. ``apt`` パッケージのインデックスを更新します。

.. code-block:: bash

   $ sudo apt-get update

..    Purge the old repo if it exists.

10. 古いリポジトリが残っているのなら、パージします。

.. code-block:: bash

   $ sudo apt-get purge lxc-docker

..    Verify that apt is pulling from the right repository.

11. ``apt`` が正しいリポジトリから取得できるか確認します。

.. code-block:: bash

   $ apt-cache policy docker-engine

..    From now on when you run apt-get upgrade, apt pulls from the new repository.

これで ``apt-get update`` を実行したら、 ``apt`` は新しいリポジトリから取得します。

.. Prerequisites by Ubuntu Version

Ubuntu バージョン固有の動作条件
----------------------------------------

* Ubuntu Xenial 16.04 (LTS)
* Ubuntu Wily 15.10
* Ubuntu Trusty 14.04 (LTS)

.. For Ubuntu Trusty, Wily, and Xenial, it’s recommended to install the linux-image-extra kernel package. The linux-image-extra package allows you use the aufs storage driver.

Ubuntu Trusty・Wily・Xenial では、 ``linux-image-extra`` カーネル・パッケージのインストールを推奨します。この ``linux-image-extra`` は ``aufs`` ストレージ・ドライバを利用可能にします。

.. To install the linux-image-extra package for your kernel version:

自分のカーネル・バージョンに対応した ``linux-image-extra`` パッケージをインストールします。

..    Open a terminal on your Ubuntu host.

1. Ubuntu ホスト上のターミナルを開きます。

..    Update your package manager.

2. パッケージ・マネージャを更新します。

.. code-block:: bash

   $ sudo apt-get update

..    Install the recommended package.

3. 推奨パッケージをインストールします。

.. code-block:: bash

   $ sudo apt-get install linux-image-extra-$(uname -r)

..    Go ahead and install Docker.

4. Docker のインストールに進みます。

.. Ubuntu Precise 12.04 (LTS)

Ubuntu Precise 12.04 (LTS)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. For Ubuntu Precise, Docker requires the 3.13 kernel version. If your kernel version is older than 3.13, you must upgrade it. Refer to this table to see which packages are required for your environment:

Ubuntu Precise では、Docker は カーネル・バージョン 3.13 が必要です。カーネルのバージョンが 3.13 よりも古い場合は、更新が必要です。環境に応じてどのパッケージが必要になるかは、次のリストをご覧ください。

.. linux-image-generic-lts-trusty 	Generic Linux kernel image. This kernel has AUFS built in. This is required to run Docker.
.. linux-headers-generic-lts-trusty 	Allows packages such as ZFS and VirtualBox guest additions which depend on them. If you didn’t install the headers for your existing kernel, then you can skip these headers for the”trusty” kernel. If you’re unsure, you should include this package for safety.
.. xserver-xorg-lts-trusty 	Optional in non-graphical environments without Unity/Xorg. Required when running Docker on machine with a graphical environment.
.. To learn more about the reasons for these packages, read the installation instructions for backported kernels, specifically the LTS Enablement Stack — refer to note 5 under each version.
.. libgl1-mesa-glx-lts-trusty

* ``linux-image-generic-lts-trusty``… generic の Linux カーネル・イメージ。このカーネルは AUFS が組み込み済み。Docker 実行に必要。
* ``linux-headers-generic-lts-trusty`` … ZFS と VirtualBox のゲスト追加に依存するようなパッケージを利用可能にします。既存のカーネルに対して headers をインストールしなければ、"trusty" カーネル向けのヘッダをスキップします。自信がなければ、安全のためにこのパッケージを導入すべきです。
* ``xserver-xorg-lts-trusty`` , ``libgl1-mesa-glx-lts-trusty`` … Unity/Xorg を持たない（グラフィカルではない）環境向けのオプションです。Docker をグラフィカルな環境で実行する時に **必要** です。これらのパッケージが必要な理由は、バックポートされたカーネルに関するインストール手順をご覧ください。 `LTS Enablement Stack <https://wiki.ubuntu.com/Kernel/LTSEnablementStack>`_ の note 5 にある各バージョンをご覧ください。

.. To upgrade your kernel and install the additional packages, do the following:

カーネルのアップグレードと追加パッケージのインストールは次のようにします。

..    Open a terminal on your Ubuntu host.

1. Ubuntu ホスト上でターミナルを開きます。

..    Update your package manager.

2. パッケージ・マネージャを更新します。

.. code-block:: bash

   $ sudo apt-get update

..    Install both the required and optional packages.

3. 必要なパッケージとオプションのパッケージの両方をインストールします。

.. code-block:: bash

   $ sudo apt-get install linux-image-generic-lts-trusty

..    Depending on your environment, you may install more as described in the preceding table.

環境に応じて、先ほどのリストにあるパッケージをインストールします。

..    Reboot your host.

4. ホストを再起動します。

.. code-block:: bash

   $ sudo reboot

..    After your system reboots, go ahead and install Docker.

5. システムの再起動後、Docker のインストールに移ります。

.. Install

インストール
====================

.. Make sure you have installed the prerequisites for your Ubuntu version. Then, install Docker using the following:

インストール前に、各 Ubuntu バージョン固有の作業を終えてください。それから、以降の手順で Docker をインストールします。

..    Log into your Ubuntu installation as a user with sudo privileges.

1. インストールする Ubuntu に、 ``sudo``  特権を持つユーザでログインします。

..    Update your apt package index.

2. ``apt`` パッケージのインデックスを更新します。

.. code-block:: bash

   $ sudo apt-get update

..    Install Docker.

3. Docker をインストールします。

.. code-block:: bash

   $ sudo apt-get install docker-engine

..    Start the docker daemon.

4. ``docker`` デーモンを開始します。

.. code-block:: bash

   $ sudo service docker start

..    Verify docker is installed correctly.

5. ``docker`` を正常にインストールしたかを確認します。

.. code-block:: bash

   $ sudo docker run hello-world

..    This command downloads a test image and runs it in a container. When the container runs, it prints an informational message. Then, it exits.

このコマンドは、テストイメージをダウンロードし、コンテナとして実行します。コンテナを実行時にメッセージ情報を表示して、それから終了します。

.. Optional configurations

オプション設定
====================

.. This section contains optional procedures for configuring your Ubuntu to work better with Docker.

このセクションは、Ubuntu と Docker がうまく機能するようなオプション手順を紹介します。

..    Create a docker group
    Adjust memory and swap accounting
    Enable UFW forwarding
    Configure a DNS server for use by Docker
    Configure Docker to start on boot



.. Create a Docker group

docker グループの作成
------------------------------

.. The docker daemon binds to a Unix socket instead of a TCP port. By default that Unix socket is owned by the user root and other users can access it with sudo. For this reason, docker daemon always runs as the root user.

``docker`` デーモンは TCP ポートの代わりに Unix ソケットをバインドします。デフォルトでは、Unix ソケットは ``root`` ユーザによって所有されており、他のユーザは ``sudo`` でアクセスできます。このため、 ``docker`` デーモンは常に ``root`` ユーザとして実行されています。

.. To avoid having to use sudo when you use the docker command, create a Unix group called docker and add users to it. When the docker daemon starts, it makes the ownership of the Unix socket read/writable by the docker group.

``docker`` コマンド利用時に ``sudo`` を使わないようにするには、 ``docker`` という名称のグループを作成し、そこにユーザを追加します。 ``docker`` デーモンが起動したら、``docker`` グループの所有者により Unix ソケットの読み書きが可能になります。

..    Warning: The docker group is equivalent to the root user; For details on how this impacts security in your system, see Docker Daemon Attack Surface for details.

.. warning::

   ``docker`` グループに所属するユーザは ``root`` と同等です。システム上のセキュリティに対する影響の詳細は、 :ref:`Docker デーモンが直面する攻撃 <docker-daemon-attack-surface>` をご覧ください。

.. To create the docker group and add your user:

``docker`` グループを作成し、ユーザを追加するには、

..    Log into Ubuntu as a user with sudo privileges.

1. Ubuntu に ``sudo`` 特権のあるユーザでログインします。

..    This procedure assumes you log in as the ubuntu user.

ログイン時のユーザ名は ``ubuntu`` ユーザかも知れません。

..    Create the docker group and add your user.

2. ``docker`` グループを作成し、ユーザを追加します。

.. code-block:: bash

   $ sudo usermod -aG docker ubuntu

..    Log out and log back in.

3. ログアウトしてから、再度ログインします。

..    This ensures your user is running with the correct permissions.

対象ユーザが適切な権限を持つようにするためです。

..    Verify your work by running docker without sudo.

4. ``sudo`` を使わずに ``docker`` の実行を確認します。

.. code-block:: bash

   $ docker run hello-world

..    If this fails with a message similar to this:

失敗時は、次のようなメッセージが表示されます。

.. code-block:: bash

   Cannot connect to the Docker daemon. Is 'docker daemon' running on this host?

..    Check that the DOCKER_HOST environment variable is not set for your shell. If it is, unset it.

``DOCKER_HOST`` 環境変数をシェル上で確認します。もし設定されていれば、unset します。

.. Adjust memory and swap accounting

メモリとスワップ利用量の調整
------------------------------

.. When users run Docker, they may see these messages when working with an image:

ユーザが Docker を実行する時、イメージ実行時に次のメッセージを表示する場合があります。

.. code-block:: bash

   WARNING: Your kernel does not support cgroup swap limit. WARNING: Your
   kernel does not support swap limit capabilities. Limitation discarded.

.. To prevent these messages, enable memory and swap accounting on your system. Enabling memory and swap accounting does induce both a memory overhead and a performance degradation even when Docker is not in use. The memory overhead is about 1% of the total available memory. The performance degradation is roughly 10%.

このメッセージを出さないようにするには、システム上でメモリとスワップの利用量（アカウンティング）を設定します。メモリとスワップ利用量の設定を有効にしますと、Docker を使っていない時、メモリのオーバヘッドとパフォーマンスの低下を減らします。メモリのオーバヘッドは利用可能な全メモリの１％程度です。パフォーマンス低下は、おおよそ10%です。

.. To enable memory and swap on system using GNU GRUB (GNU GRand Unified Bootloader), do the following:

GNU GRUB (GNU GRand Unified Bootloader) システム上で、メモリとスワップを次のように設定します。

..    Log into Ubuntu as a user with sudo privileges.

1. Ubuntu に ``sudo`` 特権のあるユーザでログインします。

..    Edit the /etc/default/grub file.

2. ``/etc/default/grub`` ファイルを編集します。

..    Set the GRUB_CMDLINE_LINUX value as follows:

3. ``GRUB_CMDLINE_LINUX`` 値を次のように設定します。

.. code-block:: bash

   GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"

..    Save and close the file.

4. ファイルを保存して閉じます。

..    Update GRUB.

5. GRUB を更新します。

.. code-block:: bash

   $ sudo update-grub

..    Reboot your system.

6. システムを再起動します。

.. Enable UFW forwarding

UFW 転送の有効化
--------------------

.. If you use UFW (Uncomplicated Firewall) on the same host as you run Docker, you’ll need to do additional configuration. Docker uses a bridge to manage container networking. By default, UFW drops all forwarding traffic. As a result, for Docker to run when UFW is enabled, you must set UFW’s forwarding policy appropriately.

Docker を実行するホスト上で `UFW (Uncomplicated Firewall) <https://help.ubuntu.com/community/UFW>`_ を使っている場合、追加設定が必要になります。Docker はコンテナのネットワーク機能のためにブリッジを使用します。デフォルトでは、UFW は全ての転送(forwarding)トラフィックを破棄(drop)します。そのため、UFW が有効な状態で Docker を実行する場合、UFW の forwarding ポリシーを適切に設定しなくてはいけません。

.. Also, UFW’s default set of rules denies all incoming traffic. If you want to reach your containers from another host allow incoming connections on the Docker port. The Docker port defaults to 2376 if TLS is enabled or 2375 when it is not. If TLS is not enabled, communication is unencrypted. By default, Docker runs without TLS enabled.

また、UFW のデフォルト設定は incoming トラフィックを全て拒否します。他のホストからコンテナに接続したい場合、Docker のポートに対する incoming トラフィックを許可する設定をします。Docker のポートは TLS が有効であれば ``2376`` であり、そうでなければ ``2375`` です。デフォルトでは、TLS が有効でなければ通信は暗号化しません。Docker のデフォルトは、TLS が有効ではありません。

.. To configure UFW and allow incoming connections on the Docker port:

UFW を設定するには、Docker ポートに対する incoming 接続を許可します。

..     Log into Ubuntu as a user with sudo privileges.

1. Ubuntu に ``sudo`` 特権のあるユーザでログインします。

..    Verify that UFW is installed and enabled.

2. UFW のインストールと有効化を確認します。

.. code-block:: bash

   $ sudo ufw status

..    Open the /etc/default/ufw file for editing.

3. ``/etc/default/ufw`` を開き、編集します。

.. code-block:: bash

   $ sudo nano /etc/default/ufw

..    Set the DEFAULT_FORWARD_POLICY policy to:

4. ``DEFAULT_FOWRARD_POLICY`` ポリシーを設定します。

.. code-block:: bash

   DEFAULT_FORWARD_POLICY="ACCEPT"

..    Save and close the file.

5. ファイルを保存して閉じます。

..    Reload UFW to use the new setting.

6. UFW を新しい設定を使って再読み込みします。

.. code-block:: bash

   $ sudo ufw reload

..    Allow incoming connections on the Docker port.

7. Docker ポートの incoming 接続を許可します。

.. code-block:: bash

   $ sudo ufw allow 2375/tcp

.. Configure a DNS server for use by Docker

Docker が使う DNS サーバの設定
------------------------------

.. Systems that run Ubuntu or an Ubuntu derivative on the desktop typically use 127.0.0.1 as the default nameserver in /etc/resolv.conf file. The NetworkManager also sets up dnsmasq to use the real DNS servers of the connection and sets up nameserver 127.0.0.1 in /etc/resolv.conf.

Ubuntu や Ubuntu 派生システムのデスクトップを動かすシステムは、デフォルトで ``/etc/resolv.conf`` ファイルで使用する ``nameserver`` は ``127.0.0.1`` です。NetworkManager も ``dnsmasq`` をセットアップする時は、 ``/etc/resolv.conf`` を ``nameserver 127.0.0.1`` に設定します。

.. When starting containers on desktop machines with these configurations, Docker users see this warning:

デスクトップ・マシンでコンテナを起動時、このような設定であれば、次の警告が出ます。

.. code-block:: bash

   WARNING: Local (127.0.0.1) DNS resolver found in resolv.conf and containers
   can't use it. Using default external servers : [8.8.8.8 8.8.4.4]

.. The warning occurs because Docker containers can’t use the local DNS nameserver. Instead, Docker defaults to using an external nameserver.

この警告は、Docker コンテナがローカルの DNS サーバを使えないためです。そのかわりDocker はデフォルトで外部のネームサーバを使います。

.. To avoid this warning, you can specify a DNS server for use by Docker containers. Or, you can disable dnsmasq in NetworkManager. Though, disabling dnsmasq might make DNS resolution slower on some networks.

警告を出ないようにするには、Docker コンテナが使うための DNS サーバを指定します。あるいは、NetworkManager で ``dnsmasq``  を無効にもできます。 ``dnsmasq`` を無効にすると、同一ネットワークの DNS 名前解決が遅くなるかも知れません。

.. To specify a DNS server for use by Docker:

Docker が使う DNS サーバの指定方法は、次の通りです。

..    Log into Ubuntu as a user with sudo privileges.

1. Ubuntu に ``sudo`` 特権のあるユーザでログインします。

..    Open the /etc/default/docker file for editing.

2. ``/etc/default/docker`` ファイルを開き、編集します。

.. code-block:: bash

   $ sudo nano /etc/default/docker

..    Add a setting for Docker.

3. Docker の設定を追加します。

.. code-block:: bash

   DOCKER_OPTS="--dns 8.8.8.8"

..    Replace 8.8.8.8 with a local DNS server such as 192.168.1.1. You can also specify multiple DNS servers. Separated them with spaces, for example:

``8.8.8.8`` を ``192.168.1.1`` のようなローカルの DNS サーバに置き換えます。複数の DNS サーバも指定できます。その場合は、次の例のようにスペースで分離します。

.. code-block:: bash

   --dns 8.8.8.8 --dns 192.168.1.1

..        Warning: If you’re doing this on a laptop which connects to various networks, make sure to choose a public DNS server.

.. warning::

   この作業を PC 上で行う場合は様々なネットワークに接続するため、パブリック DNS サーバを選択してください。

..    Save and close the file.

4. ファイルを保存して閉じます。

..    Restart the Docker daemon.

5. Docker デーモンを再起動します。

.. code-block:: bash

   $ sudo service docker restart


.. Or, as an alternative to the previous procedure, disable dnsmasq in NetworkManager (this might slow your network).

**あるいは、先ほどの手順とは別の方法として**、NetworkManager で ``dnsmasq`` を無効化する方法もあります（ネットワークが遅くなるかも知れません）。

..    Open the /etc/NetworkManager/NetworkManager.conf file for editing.

1. ``/etc/NetworkManager/NetworkManager.conf`` ファイルを開き、編集します。

.. code-block:: bash

   $ sudo nano /etc/NetworkManager/NetworkManager.conf

..    Comment out the dns=dsnmasq line:

2. ``dns=dnsmasq`` 行をコメントアウトします。

.. code-block:: bash

   dns=dnsmasq

..    Save and close the file.

3. ファイルを保存して閉じます。

..    Restart both the NetworkManager and Docker.

4. NetworkManager と Docker の両方を再起動します。

.. code-block:: bash

   $ sudo restart network-manager
   $ sudo restart docker

.. Configure Docker to start on boot

ブート時の Docker 起動設定
------------------------------

.. Ubuntu uses systemd as its boot and service manager 15.04 onwards and upstart for versions 14.10 and below.

Ubuntu ``15.04`` 以上はサービス・マネージャに ``systemd`` を使って起動します。 ``14.10`` 以下のバージョンでは ``upstart`` です。

.. For 15.04 and up, to configure the docker daemon to start on boot, run

``15.04`` 以上で ``docker`` デーモンをブート時に起動するようにするには、次のように実行します。

.. code-block:: bash

   $ sudo systemctl enable docker

.. For 14.10 and below the above installation method automatically configures upstart to start the docker daemon on boot

``14.10`` 以下では、自動的に ``upstart`` を使って Docker デーモンをブート時に起動する設定がインストール時に行われます。

.. Upgrade Docker

Docker のアップグレード
==============================

.. To install the latest version of Docker with apt-get:

Docker の最新版をインストールするには、 ``apt-get`` を使います。

.. code-block:: bash

   $ sudo apt-get upgrade docker-engine

.. Uninstallation

アンインストール
====================

.. To uninstall the Docker package:

Docker パッケージをアンインストールします。

.. code-block:: bash

   $ sudo apt-get purge docker-engine

.. To uninstall the Docker package and dependencies that are no longer needed:

Docker パッケージと必要のない依存関係をアンインストールします。

.. code-block:: bash

   $ sudo apt-get autoremove --purge docker-engine

.. The above commands will not remove images, containers, volumes, or user created configuration files on your host. If you wish to delete all images, containers, and volumes run the following command:

上記のコマンドは、イメージ、コンテナ、ボリュームやホスト上の設定ファイルを削除しません。イメージ、コンテナ、ボリュームを削除するには次のコマンドを実行します。

.. code-block:: bash

   $ rm -rf /var/lib/docker

.. You must delete the user created configuration files manually.

ユーザが作成した設定ファイルは、手動で削除する必要があります。

.. seealso:: 

   Installation on Ubuntu
      https://docs.docker.com/engine/installation/linux/ubuntulinux/

