.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/desktop/install/linux-install/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/desktop/install/linux-install.md
.. check date: 2022/09/10
.. Commits on Sep 7, 2022 cbbb9f1fac9289c0d2851584010559f8f03846f0
.. -----------------------------------------------------------------------------

.. |whale| image:: ./images/whale-x.png
      :scale: 50%

.. Install Docker Desktop on Linux
.. _install-docker-desktop-on-linux:

=======================================
Linux に Docker Desktop をインストール
=======================================

.. sidebar:: 目次

   .. contents::
       :depth: 3
       :local:

..
    Docker Desktop terms
    Commercial use of Docker Desktop in larger enterprises (more than 250 employees OR more than $10 million USD in annual revenue) requires a paid subscription.

.. note:: **Docker Desktop 利用条件**

   大企業（従業員が 251 人以上、または、年間収入が 1,000 万米ドル以上 ）における Docker Desktop の商用利用には、有料サブスクリプション契約が必要です。

.. This page contains information about system requirements, download URLs, and instructions on how to install and update Docker Desktop for Linux.

このページには、 Docker Desktop for Mac のシステム要件、ダウンロード URL 、Docker Desktop for Linux のインストールと更新の手順の情報を含みます。

.. note::

   **はじめてインストールする場合は、以下にある** :ref:`システム要件 <win-system-requirements>` **に一致するかを確認し、以下のディストリビューション別のインストール手順をご覧ください：**

   * :doc:`Ubuntu <ubnutu.rst>`
   * :doc:`Debian <debian.rst>`
   * :doc:`Fedora <fedora.rst>`

   ----

   * `RPM パッケージ <https://desktop.docker.com/linux/main/amd64/docker-desktop-4.22.0-x86_64.rpm>`_
   * `DEB パッケージ <https://desktop.docker.com/linux/main/amd64/docker-desktop-4.22.0-amd64.deb>`_
   * `Arch パッケージ（実験的） <https://desktop.docker.com/linux/main/amd64/docker-desktop-4.22.0-x86_64.pkg.tar.zst>`_


.. System requirements
.. _desktop-linux-system-requirements:

システム要件
====================

.. To install Docker Desktop successfully, your Linux host must meet the following requirements:

Docker Desktop を正しくインストールするには、Linux ホストが以下の要件を満たす必要があります。

..    64-bit kernel and CPU support for virtualization.

* 仮想化のために、 64-bit カーネルと CPU のサポート

..    KVM virtualization support. Follow the KVM virtualization support instructions to check if the KVM kernel modules are enabled and how to provide access to the kvm device.

* KVM 仮想化のサポート。KVM カーネルモジュールのサポート有効化を確認する方法と、kvm デバイスにアクセスする方法は、以下の :ref:`KVM 仮想化サポート手順 <linux-kvm-virtualization-support>` を参照

..    QEMU must be version 5.2 or newer. We recommend upgrading to the latest version.

* **QEMU はバージョン 5.2 以上が必須** 。最新バージョンへのアップグレードを推奨

..    systemd init system.

* systemd init システム

..    Gnome or KDE Desktop environment.
        For many Linux distros, the Gnome environment does not support tray icons. To add support for tray icons, you need to install a Gnome extension. For example, AppIndicator).

* Gnome または KDE デスクトップ環境

  * 多くの Linux ディストリビューションでは、Gnome 環境でトレイアイコンをサポートしていない。トレイアイコンをサポートするには、Gnome 拡張をインストールする必要がある。例： `AppIndicator <https://extensions.gnome.org/extension/615/appindicator-support/>`_

..    At least 4 GB of RAM.

* 最小 4GB の :ruby:`メモリ RAM`

..    Enable configuring ID mapping in user namespaces, see File sharing.

* ユーザ名前空間で ID マッピングの設定を有効化。 :ref:`ファイル共有 <linux-install-file-sharing>` を参照

.. Docker Desktop for Linux runs a Virtual Machine (VM). For more information on why, see Why Docker Desktop for Linux runs a VM.

Docker Desktop for Linux は仮想マシン（VM）を実行します。なぜ実行するかの詳しい情報は、 :ref:`どうして Docker Desktop for Linux は仮想マシンを実行するのか <linux-install-why-docker-desktop-for-linux-runs-a-vm>` をご覧ください。

..  Note:
    Docker does not provide support for running Docker Desktop in nested virtualization scenarios. We recommend that you run Docker Desktop for Linux natively on supported distributions.

.. note::

   :ruby:`ネスト化した仮想化状態 <nested virtualization scenario>` では、Docker は Docker Desktop の実行をサポートしません。Docker Desktop for Linux をサポートしているディストリビューションで直接実行するのを推奨します。

.. Supported platform
.. _win-supported-platform:

サポート対象のプラットフォーム
==============================

.. Docker provides .deb and .rpm packages from the following Linux distributions and architectures:

以下の Linux ディストリビューションとアーキテクチャに対し、Docker は ``.deb`` と ``.rpm`` パッケージを提供します。

.. list-table::
   :header-rows: 1

   * - プラットフォーム
     - x86_64 / amd64
   * - :doc:`Ubuntu </desktop/install/ubuntu>`
     - .. image:: /engine/images/green-check.png
   * - :doc:`Debian </desktop/install/debian>`
     - .. image:: /engine/images/green-check.png
   * - :doc:`Fedora </desktop/install/fedora>`
     - .. image:: /engine/images/green-check.png

..  Note:
    An experimental package is available for Arch-based distributions. Docker has not tested or verified the installation.

.. note::

   :doc:`Arch </desktop/install/archlinux>` をベースとしたディストリビューションに対する実験的なパッケージが利用可能です。Docker はテストしておらず、インストールも未検証です。


.. Docker supports Docker Desktop on the current LTS release of the aforementioned distributions and the most recent version. As new versions are made available, Docker stops supporting the oldest version and supports the newest version.

Docker がサポートする Docker Desktop は、前述したディストリビューションの現在の LTS リリースと、最も新しいバージョンです。新しいバージョンが利用可能になれば、Docker は古いバージョンのサポートを停止し、新しいバージョンをサポートします。

.. KVM virtualization support
.. .._linux-install-kvm-virtualization-support:

KVM 仮想化のサポート
------------------------------

.. Docker Desktop runs a VM that requires KVM support.

Docker Desktop は仮想マシンを実行しますが、 `KVM のサポート <https://www.linux-kvm.org/>`_ が必要です。

.. The kvm module should load automatically if the host has virtualization support. To load the module manually, run:

ホストが仮想化をサポートしている場合、 ``kvm`` モジュールは自動的に読み込まれます。モジュールを手動で読み込むには、次のように実行します。

.. code-block:: bash

   $ modprobe kvm

.. Depending on the processor of the host machine, the corresponding module must be loaded:

ホストマシンのプロセッサによって、適切なモジュールを読み込む必要があります。

.. code-block:: bash

   $ modprobe kvm_intel  # Intel プロセッサ
   
   $ modprobe kvm_amd    # AMD プロセッサ

.. If the above commands fail, you can view the diagnostics by running:

先のコマンドに失敗する場合、調査結果を表示するには、次のように実行します。

.. code-block:: bash

   $ kvm-ok

.. To check if the KVM modules are enabled, run:

KVM モジュールが有効化されているかどうかを確認するには、次のように実行します。

.. code-block:: bash

   $ lsmod | grep kvm
   kvm_amd               167936  0
   ccp                   126976  1 kvm_amd
   kvm                  1089536  1 kvm_amd
   irqbypass              16384  1 kvm

.. Set up KVM device user permissions
.. _set-up-kvm-device-user-permissions:

KVM デバイスのユーザ権限をセットアップ
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. To check ownership of /dev/kvm, run :

``/dev/kvm`` の所有者を確認するには、次のように実行します。

.. code-block:: bash

   $ ls -al /dev/kvm

.. Add your user to the kvm group in order to access the kvm device:

kvm デバイスに対してアクセスするには、ユーザを kvm グループに追加します。

.. code-block:: bash

   $ sudo usermod -aG kvm $USER

.. Log out and log back in so that your group membership is re-evaluated.

ログアウトしてログインしなおすと、所属しているグループのメンバー情報が再読み込みされます。

.. Generic installation steps
.. _linux-generic-installation-steps:

一般的なインストール手順
==============================

.. Download the correct package for your Linux distribution and install it with the corresponding package manager. 

1. 自分の Linux ディストリビューション向けに適切なパッケージをダウンロードし、適切なパッケージマネージャを使い、そのパッケージをインストールします。

..  Install on Debian
    Install on Fedora
    Install on Ubuntu
    Install on Arch

* :doc:`Debian にインストール </desktop/install/debian>` 
* :doc:`Fedora にインストール </desktop/install/fedora>` 
* :doc:`Ubuntu にインストール </desktop/install/ubuntu>` 
* :doc:`Arch にインストール </desktop/install/archlinux>` 

.. Open your Applications menu in Gnome/KDE Desktop and search for Docker Desktop.

2. Gnome/KDE デスクトップの **Applications** を開き、 **Docker Desktop** を探します。

   ..    Docker app in Hockeyapp

   .. image:: ./images/docker-app-in-apps.png
      :scale: 60%
      :alt: アプリ一覧での Docker

.. Select Docker Desktop to start Docker.
   The Docker menu (whale menu) displays the Docker Subscription Service Agreement window.

3. **Docker Desktop** を選択し、 Docker を起動します。

   Docker メニュー（ |whale| ）は Docker :ruby:`サブスクリプション サービス使用許諾 <Subscription Service Agreement>` ウインドウを表示します。

.. Select Accept to continue. Docker Desktop starts after you accept the terms.

4. **Accept** をクリックすると続きます。使用許諾を承諾した後、 Docker Desktop は起動します。

   .. important::
   
      .. If you do not agree to the terms, the Docker Desktop application will close and you can no longer run Docker Desktop on your machine. You can choose to accept the terms at a later date by opening Docker Desktop.
      
      使用許諾に同意しなければ、 Docker Desktop アプリケーションは終了し、以後マシン上で Docker Dekstop を起動しないようようにします。後日、 Docker Desktop を開いた時、使用許諾を承諾するかどうか選択できます。

   .. For more information, see Docker Desktop Subscription Service Agreement. We recommend that you also read the FAQs.

   詳しい情報は、 `Docker Desktop Subscription Service Agreement（ Docker Desktop サブスクリプション サービス 使用許諾）`_ をご覧ください。また、 `FAQ <https://www.docker.com/pricing/faq>`_ を読むのもお勧めします。

.. Differences between Docker Desktop for Linux and Docker Engine
.. _differences-between-docker-desktop-for-linux-and-docker-engine:

Docker Desktop for Linux と Docker Engien との違い
==================================================

.. Docker Desktop for Linux and Docker Engine can be installed side-by-side on the same machine. Docker Desktop for Linux stores containers and images in an isolated storage location within a VM and offers controls to restrict its resources. Using a dedicated storage location for Docker Desktop prevents it from interfering with a Docker Engine installation on the same machine.

Docker Desktop for Linux と Docker Engine は、同じマシン上で並列にインストールできます。Docker Desktop for Linux は、コンテナとイメージを :ref:`仮想マシン内の <linux-install-why-docker-desktop-for-linux-runs-a-vm>` 分け隔てられた保管場所に保存し、 :ref:`リソースを制限するよう制御 <desktop-settings-linux-resources>` します。Docker Desktop 用（のコンテナやイメージ）は専用の場所に保存するため、同じマシン上にインストールした Docker Engine との干渉を防げます。

.. While it’s possible to run both Docker Desktop and Docker Engine simultaneously, there may be situations where running both at the same time can cause issues. For example, when mapping network ports (-p / --publish) for containers, both Docker Desktop and Docker Engine may attempt to reserve the same port on your machine, which can lead to conflicts (“port already in use”).

Docker Desktop と Docker Engine の両方を同時に実行可能なため、同時に実行すると何らかの問題を引き起こす可能性があります。たとえば、コンテナに対してネットワーク ポート（ ``-p`` / ``--publish`` ）を割り当てると、Docker Desktop と Docker Engine の両方が、同じマシン上のポート確保を試みるため、衝突を引き起こします（「port already in use」＝ポートが既に使用されています）。

.. We generally recommend stopping the Docker Engine while you’re using Docker Desktop to prevent the Docker Engine from consuming resources and to prevent conflicts as described above.

私たちは、Docker Engine がリソースを消費の消費を避けたり、前述のような衝突を避けるため、 Docker Desktop の利用時は Docker Desktop を停止するのを一般的に推奨します。

.. Use the following command to stop the Docker Engine service:

以下のコマンドで Docker Engine サービスを停止します：

.. code-block:: bash

   $ sudo systemctl stop docker docker.socket containerd

.. Depending on your installation, the Docker Engine may be configured to automatically start as a system service when your machine starts. Use the following command to disable the Docker Engine service, and to prevent it from starting automatically:

インストール状況によって、 Docker Engine はマシン起動時に自動的にサービスとして起動するよう設定されています。以下のコマンドを実行し、Docker Engine サービスが自動的に起動するのを防ぎます：

.. code-block:: bash

   $ sudo systemctl disable docker docker.socket containerd

.. Switch between Docker Desktop and Docker Engine
.. _switch-between-docker-desktop-and-docker-engine:

Docker Desktop と Docker Engine 間の切り替え
--------------------------------------------------

.. The Docker CLI can be used to interact with multiple Docker Engines. For example, you can use the same Docker CLI to control a local Docker Engine and to control a remote Docker Engine instance running in the cloud. Docker Contexts allow you to switch between Docker Engines instances.

Docker CLI は複数の Docker Engine と相互接続できます。たとえば、同じ Docker CLI を使い、ローカルの Docker Engine とクラウド上で実行しているリモートの Docker Engine インスタンス（訳者注：Docker Engine 実行している"実体"そのものを指す抽象的な表現）を制御できます。 :doc:`Docker Contests </engine/context/working-with-contexts>` により、Docker Engine インスタンス（実体）間の切り替えができます。

.. When installing Docker Desktop, a dedicated “desktop-linux” context is created to interact with Docker Desktop. On startup, Docker Desktop automatically sets its own context (desktop-linux) as the current context. This means that subsequent Docker CLI commands target Docker Desktop. On shutdown, Docker Desktop resets the current context to the default context.

Docker Desktop をインストールするとき、専用の「desktop-linux」コンテクストが Docker Desktop とやりとりするため作成されます。起動時、 Docker Desktop は現在のコンテクストを、自動的に自身のコンテクスト（ ``desktop-linux`` ）へと設定します。つまり、以降の Docker CLI コマンドは Docker Desktop が対象になります。シャットダウン時、Docker Desktop は現在のコンテクストを ``default`` コンテクストにリセットします。

.. Use the docker context ls command to view what contexts are available on your machine. The current context is indicated with an asterisk (*);

``docker context ls`` コマンドを使うと、自分のマシン上で何のコンテクストが利用できるか表示します。現在のコンテクストは、アスタリスク記号（ ``*`` ） で示されます。

.. code-block:: bash

   $ docker context ls
   NAME            DESCRIPTION                               DOCKER ENDPOINT                                  ...
   default *       Current DOCKER_HOST based configuration   unix:///var/run/docker.sock                      ...
   desktop-linux                                             unix:///home/<user>/.docker/desktop/docker.sock  ... 

.. If you have both Docker Desktop and Docker Engine installed on the same machine, you can run the docker context use command to switch between the Docker Desktop and Docker Engine contexts. For example, use the “default” context to interact with the Docker Engine;

同じマシン上に Docker Desktop と Docker Engine の両方をインストールしている場合は、 ``docker context use`` コマンドを使い、Docker Desktop と Docker Engine コンテクスト間を切り替え可能です。たとえば、「default」コンテクストを使い Docker Engine とやりとりするには、次のようにします：

.. code-block:: bash

   $ docker context use default
   default
   Current context is now "default"

.. And use the desktop-linux context to interact with Docker Desktop:

それから、 ``desktop-linux`` コンテクストを使い、 Docker Desktop とやりとりします：

.. code-block:: bash

   $ docker context use desktop-linux
   desktop-linux
   Current context is now "desktop-linux"

.. Refer to the Docker Context documentation for more details.

詳細は :doc:`Docker Context のドキュメント </engine/context/working-with-contexts>` をご覧ください。

.. Updates
.. _win-updates:

更新（アップデート）
====================

.. Once a new version for Docker Desktop is released, the Docker UI shows a notification. You need to download the new package each time you want to upgrade manually.

新しいバージョンの Docker Desktop がリリースされると、 Docker UI に通知が表示されます。更新をしたい場合は、新しいパッケージを都度手動でダウンロードする必要があります。

.. To upgrade your installation of Docker Desktop, first stop any instance of Docker Desktop running locally, then follow the regular installation steps to install the new version on top of the existing version.

インストール済みの Docker Desktop を更新するには、まずローカルで実行しているあらゆる Docker Desktop を停止し、既存のバージョンの上に、新しいバージョンを通常のインストール手順に従ってインストールします。


.. Uninstall Docker Desktop
.. _linux-uninstall-docker-desktop:

Docker Desktop のアンインストール
========================================

.. Docker Desktop can be removed from a Linux host using the package manager.

Docker Desktop は Linux ホストが使うパッケージマネージャで削除できます。

.. Once Docker Desktop has been removed, users must remove the credsStore and currentContext properties from the ~/.docker/config.json.

Docker Desktop を削除したら、ユーザは ``~/.docker/config.json`` から ``credsStore`` と ``currentContext`` プロパティの削除が必要です。

.. Uninstalling Docker Desktop destroys Docker containers, images, volumes, and other Docker related data local to the machine, and removes the files generated by the application. Refer to the back up and restore data section to learn how to preserve important data before uninstalling.

.. note::

   Docker Desktop のアンインストールは、ローカルのマシンにある Docker コンテナ、イメージ、ボリューム、 Docker 関連のデータ破棄し、アプリケーションによって作成された全てのファイルも破棄します。アンインストール前に重要なデータを保持する方法については、 :doc:`バックアップと修復 </desktop/backup-and-restore>` を参照ください。

.. Why Docker Desktop for Linux runs a VM
.. _linux-install-why-docker-desktop-for-linux-runs-a-vm:

どうして Docker Desktop for Linux は仮想マシンとして実行するのか
======================================================================

.. Docker Desktop for Linux runs a Virtual Machine (VM) for the following reasons:

Docker Desktop for Linux は、以下の理由のため仮想マシン（VM）として実行します：

..    To ensure that Docker Desktop provides a consistent experience across platforms.

1. **プラットフォーム間を横断しても、Docker Desktop が一貫した体験の提供を保証するためです。**

   ..    During research, the most frequently cited reason for users wanting Docker Desktop for Linux (DD4L) was to ensure a consistent Docker Desktop experience with feature parity across all major operating systems. Utilizing a VM ensures that the Docker Desktop experience for Linux users will closely match that of Windows and macOS.

   調査により、ユーザが Docker Desktop for Linux (DD4L) に最も多く求められている理由は、多くの主なオペレーティングシステム上で Docker Desktop 体験の一貫性を保証することでした。VM の使用により、Linux ユーザの Docker Desktop 体験は、 Windows と macOS に近くなります。

   ..    This need to deliver a consistent experience across all major OSs will become increasingly important as we look towards adding exciting new features, such as Docker Extensions, to Docker Desktop that will benefit users across all tiers. We’ll provide more details on these at DockerCon22. Watch this space.

   すべての主要な OS で一貫した経験を提供する必要が、ますます重要になってきているため、私たちは Docker Desktop に対して Docker Extensions のような心躍る新機能を追加し、全ての層のユーザに対して利便をもたらします。これらの詳細は DockerCon22 で説明予定です。こちらに注目ください。

..    To make use of new kernel features

2. **新しいカーネル機能を使用するため。**

   ..    Sometimes we want to make use of new operating system features. Because we control the kernel and the OS inside the VM, we can roll these out to all users immediately, even to users who are intentionally sticking on an LTS version of their machine OS.

   時々、新しいオペレーティングシステム機能を利用したい場合があります。私たちはカーネルと VM 内の OS を制御しているため、全てのユーザに対し各機能をただちに提供できます。たとえ、マシン OS の LTS バージョンを固定しようとしているユーザに対してもです。

.. To enhance security

3. **セキュリティを拡張します。** 

   .. Container image vulnerabilities pose a security risk for the host environment. There is a large number of unofficial images that are not guaranteed to be verified for known vulnerabilities. Malicious users can push images to public registries and use different methods to trick users into pulling and running them. The VM approach mitigates this threat as any malware that gains root privileges is restricted to the VM environment without access to the host.

   コンテナ イメージの脆弱性は、ホスト環境に対してセキュリティの危険性をもたらします。数多くの非公式イメージは、既知の脆弱性に対する対応が保証されていません。悪意のあるユーザは公開レジストリにイメージを送信でき、異なる手法でユーザがイメージをダウンロードして実行するよう企みます。VM のアプローチにより、VM からはホストにアクセスできない環境のため、 root 特権の取得を試みるあらゆるマルウェアによる脅威を抑制します。

   .. Why not run rootless Docker? Although this has the benefit of superficially limiting access to the root user so everything looks safer in “top”, it allows unprivileged users to gain CAP_SYS_ADMIN in their own user namespace and access kernel APIs which are not expecting to be used by unprivileged users, resulting in vulnerabilities.

   どうして rootless Docker を実行しないのでしょうか？ これは root ユーザに対するアクセスを表面的に制限する利点があり、何より最も安全に見えますが、権限のないユーザが自身のユーザ名前空間内で ``CAP_SYS_ADMIN`` を得ると、特権のないユーザにより予期しないカーネル API にアクセスされ、結果として `脆弱性 <https://www.openwall.com/lists/oss-security/2022/01/18/7>`_ になります。

.. To provide the benefits of feature parity and enhanced security, with minimal impact on performance

4. **性能上の影響を最小限にしながら、同等性の機能と、強化されたセキュリティという利点を提供するためです。**

   .. The VM utilized by DD4L uses virtiofs, a shared file system that allows virtual machines to access a directory tree located on the host. Our internal benchmarking shows that with the right resource allocation to the VM, near native file system performance can be achieved with virtiofs.

   DD4L が使われる VM は  ``virtiofs`` を使います。これは、共有ファイルシステムであり、仮想マシンがホスト上にあるディレクトリツリーに直接アクセスできるようにします。私たちの内部ベンチマークが示すのは、VM へ正しいリソースを割り当てると、 virtiofs ファイルシステムはネイティブに近い性能を発揮します。

   .. As such, we have adjusted the default memory available to the VM in DD4L. You can tweak this setting to your specific needs by using the Memory slider within the Settings > Resources tab of Docker Desktop.

   それで、 DD4L では VM に割り当て可能なデフォルトのメモリを調整しました。この設定を調整するには、 Docker Desktop の **Settings > Resources** タブのなかにある **Memory** スライダを使います。

.. File sharing
.. _linux-install-file-sharing:

ファイル共有
====================

.. Docker Desktop for Linux uses virtiofs as the default (and currently only) mechanism to enable file sharing between the host and Docker Desktop VM. In order not to require elevated privileges, without unnecessarily restricting operations on the shared files, Docker Desktop runs the file sharing service (virtiofsd) inside a user namespace (see user_namespaces(7)) with UID and GID mapping configured. As a result Docker Desktop relies on the host being configured to enable the current user to use subordinate ID delegation. For this to be true /etc/subuid (see subuid(5)) and /etc/subgid (see subgid(5)) must be present. Docker Desktop only supports subordinate ID delegation configured via files. Docker Desktop maps the current user ID and GID to 0 in the containers. It uses the first entry corresponding to the current user in /etc/subuid and /etc/subgid to set up mappings for IDs above 0 in the containers.

Docker Desktop for Linux は、ホストと Docker Desktop VM 間でファイル共有をできるようにするため、デフォルト（かつ現時点では唯一）の手法として `virtiofs <https://virtio-fs.gitlab.io/>`_ を使います。共有ファイルの操作に不要な制限を加えることなく、特権への昇格を不要とするために、Docker Desktop はユーザ名前空間内に（ ``user_namespaces(7)`` 参照）ファイル共有サービス（ ``virtiofsd`` ）を実行し、 UID と GID の割り当てを調整可能にします。結果として Docker Desktop は、現在のユーザが :ruby:`下位 ID 委任 <subordinate ID delegation>` が利用できるように設定されたホストに依存します。これを実現するため、 ``/etc/subuid`` （ ``subuid(5)`` 参照）と ``/etc/subgid`` （ ``subgid(5)`` 参照）の存在が必要です。Docker Desktop はファイルを経由した下位 ID 委任のみサポートします。Docker Desktop は現在のユーザ ID と GID をコンテナ内では 0 に割り当て（マップ）します。 ``/etc/subuid`` と ``/etc/subgid`` の現在のユーザに対応する1つめのエントリを使い、コンテナ内で先ほどの 0 を適切な ID に割り当てます。

.. list-table::
   :header-rows: 1

   * - コンテナ内の ID
     - ホスト上の ID
   * - 0 (root)
     - Docker Desktop を実行ｓているユーザの ID （例： 1000 ）
   * - 1
     - 0 + ``/etc/subid`` / ``/etc/subgid`` で指定されている ID 範囲（例： 100000）
   * - 2
     - 1 + ``/etc/subid`` / ``/etc/subgid`` で指定されている ID 範囲（例： 100001）
   * - 3
     - 2 + ``/etc/subid`` / ``/etc/subgid`` で指定されている ID 範囲（例： 100002）
   * - …
     - …

.. If /etc/subuid and /etc/subgid are missing, they need to be created. Both should contain entries in the form - <username>:<start of id range>:<id range size>. For example, to allow the current user to use IDs from 100000 to 165535:

もしも ``/etc/subuid`` と ``/etc/subgid`` が無ければ、作成の必要があります。どちらも ``<username>:<start of id range>:<id range size>`` の形式でのエントリを含む必要があります。たとえば、現在のユーザに対して 100000 から 165535 までの使用を許可するには：

.. code-block:: bash

   $ grep "$USER" /etc/subuid >> /dev/null 2&>1 || (echo "$USER:100000:65536" | sudo tee -a /etc/subuid)
   $ grep "$USER" /etc/subgid >> /dev/null 2&>1 || (echo "$USER:100000:65536" | sudo tee -a /etc/subgid)

.. To verify the configs have been created correctly, inspect their contents:

設定により、正しく作成されているかどうかを確認するには、それぞれのコンテナを調べます：

.. code-block:: bash

   $ echo $USER
   exampleuser
   $ cat /etc/subuid
   exampleuser:100000:65536
   $ cat /etc/subgid
   exampleuser:100000:65536

.. In this scenario if a shared file is chowned inside a Docker Desktop container owned by a user with a UID of 1000, it shows up on the host as owned by a user with a UID of 100999. This has the unfortunate side effect of preventing easy access to such a file on the host. The problem is resolved by creating a group with the new GID and adding our user to it, or by setting a recursive ACL (see setfacl(1)) for folders shared with the Docker Desktop VM.

たとえば、 Docker Desktop コンテナ内で、UID が 1000 のユーザが所有するよう ``chown`` された共有ファイルは、ホスト上では UID が 100999 のユーザによって所有されているように表示されます。このため、ホスト上でこのようなファイルに簡単にアクセスできないという、残念な副作用があります。この問題を解決するには、新しい GID でグループを作成し、そこに私たちのユーザを追加するか、Docker Desktop VM で共有しているフォルダに再帰的 ACL（ `setfacl(1)``` ）を設定します。

.. Where to go next

次はどこへ行きますか
==============================

..    Troubleshooting describes common problems, workarounds, how to run and submit diagnostics, and submit issues.
    FAQs provide answers to frequently asked questions.
    Release notes lists component updates, new features, and improvements associated with Docker Desktop releases.
    Get started with Docker provides a general Docker tutorial.
    Back up and restore data provides instructions on backing up and restoring data related to Docker.

* :doc:`トラブルシューティング </desktop/troubleshoot/overview>` は一般的な問題、回避方法、統計情報の送信方法、問題報告の仕方があります。
* :doc:`FAQs </desktop/faqs/general>` は、よく見受けられる質問と回答があります。
* :doc:`リリースノート </desktop/release-notes>` は Docker Desktop  リリースに関連する更新コンポーネント、新機能、改良の一覧があります。
* :doc:`Docker の始め方 </get-started/index>` は一般的な Docker チュートリアルです。
* :doc:`バックアップと修復 </desktop/backup-and-restore>` は Docker 関連データのバックアップと修復手順です。

.. seealso::

   Install Docker Desktop on Linux
      https://docs.docker.com/desktop/install/linux-install/

