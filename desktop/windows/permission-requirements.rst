.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/desktop/windows/permission-requirements/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/desktop/windows/permission-requirements.md
.. check date: 2022/09/10
.. Commits on Aug 26, 2022 56c9827312dfe57ac69b80364e016749210cda62
.. -----------------------------------------------------------------------------

.. Understand permission requirements for Windows
.. _understand-permission-requirements-for-windows:

==================================================
Windows のアクセス権要求を理解
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. This page contains information about the permission requirements for running and installing Docker Desktop on Windows, the functionality of the privileged helper process com.docker.service.exe and the reasoning behind this approach.

このページには、 Docker Desktop を Windows 上にインストールして実行するために必要な、アクセス権の要求についての情報が入っています。プロセス ``com.docker.service.exe`` に対する :ruby:`特権ヘルパーサービス <privileged helper process>` について、この手法の背景にある理由を扱います。

.. It also provides clarity on running containers as root as opposed to having Administrator access on the host and the privileges of the Windows Docker engine and Windows containers.

また、ホスト上、および、特権を持つ Windows Docker Engine と Windows コンテナーにおいて、 ``Administrator`` （管理者）アクセス権を持つのではなく、コンテナを ``root`` として実行するのも明確にします。

.. Permission requirements
.. win-permission-requirements:
:ruby:`アクセス権の要求 <permission requirements>`
==================================================

.. While Docker Desktop on Windows can be run without having Administrator privileges, it does require them during installation. On installation the user gets a UAC prompt which allows a privileged helper service to be installed. After that, Docker Desktop can be run by users without administrator privileges, provided they are members of the docker-users group. The user who performs the installation is automatically added to this group, but other users must be added manually. This allows the administrator to control who has access to Docker Desktop.

Windows の Docker Desktop は ``Administrator`` （管理者）特権がなくても実行できますが、インストール時には特権が必要です。ユーザがインストールしようとすると、インストールのために特権ヘルパーサービスに特権を許可するかどうか尋ねるユーザーアカウント制御（UAC）プロンプトが開きます。以降、ユーザは ``docker-users`` グループのメンバーとして指定があれば、 Docker Desktop を管理者権限がなくても実行できます。インストールをするユーザは自動的にこのグループに追加されますが、他のユーザは手動で追加する必要があります。これにより、管理者は誰が Docker Desktop にアクセスできるか制御できるようになります。

.. The reason for this approach is that Docker Desktop needs to perform a limited set of privileged operations which are conducted by the privileged helper process com.docker.service.exe. This approach allows, following the principle of least privilege, Administrator access to be used only for the operations for which it is absolutely necessary, while still being able to use Docker Desktop as an unprivileged user.

Docker Desktop が特権ヘルパープロセス ``com.docker.service.exe`` を使うようにしている理由は、限定的な一連の特権が必要な操作を処理するためです。この手法は、最小限の権限という原則に従い、間違いなく必要な処理のみ ``Administrator`` （管理者）にアクセスできるようにするため、Docker Desktop に特権を与えないまま利用できます。

.. Privileged Helper
.. _win-privileged-helper:
:ruby:`特権ヘルパー <privileged helper>`
==================================================

.. The privileged helper com.docker.service.exe is a Windows service which runs in the background with SYSTEM privileges. It listens on the named pipe //./pipe/dockerBackendV2. The developer runs the Docker Desktop application, which connects to the named pipe and sends commands to the service. This named pipe is protected, and only users that are part of the docker-users group can have access to it.

特権ヘルパー ``com.docker.service.exe`` はバックグラウンドで動作する Windows サービスであり、 ``SYSTEM`` 特権を持ちます。名前付きパイプ ``//./pipe/dockerBackendV2`` をリッスンします。開発者が Docker Desktop アプリケーションを実行するとき、名前付きパイプに接続して、サービスに対する命令を送信します。この名前付きパイプは保護されているため、 ``docker-users`` グループのユーザーのみが接続できます。

.. The service performs the following functionalities:

サービスは以下の機能を処理します：

..  Ensuring that kubernetes.docker.internal is defined in the Win32 hosts file. Defining the DNS name kubernetes.docker.internal allows Docker to share Kubernetes contexts with containers.
    Securely caching the Registry Access Management policy which is read-only for the developer.
    Creating the Hyper-V VM "DockerDesktopVM" and managing its lifecycle - starting, stopping and destroying it. The VM name is hard coded in the service code so the service cannot be used for creating or manipulating any other VMs.
    Getting the VHDX disk size.
    Moving the VHDX file or folder.
    Starting and stopping the Windows Docker engine and querying whether it is running.
    Deleting all Windows containers data files.
    Checking if Hyper-V is enabled.
    Checking if the bootloader activates Hyper-V.
    Checking if required Windows features are both installed and enabled.
    Conducting healthchecks and retrieving the version of the service itself.

* ``kubernetes.docker.internal`` が Win32 hosts ファイルで定義されているのを確認します。DNS 名 ``kubernetes.docker.internal`` の定義により、Docker はコンテナと Kubernetes コンテクストとを共有できるようにします。
* レジストリ アクセス マネジメント ポリシーは、開発者に対しては読み込み専用のため、安全にキャッシュします。
* Hyper-V 仮想マシン ``"DockerDesktopVM"`` を作成し、仮想マシンの開始、停止、削除といったライフサイクルを管理します。仮想マシンの名前はサービスコードによってハードコード（固定）されているため、サービスは他の仮想マシンの作成や操作ができません。
* VHDX ディスク容量を取得します。
* VHDX ファイルやフォルダを移動します。
* Windows Docker Engine を開始または停止し、実行中かどうかを確認します。
* Windows コンテナーのデータファイルを削除します。
* Hyper-V が有効化されているかどうかを確認します。
* Hyper-V のブートローダーの有効化を確認します。
* 必要な Windows 機能が、インストール済みで有効化されているのを確認します。
* ヘルスチェックを実施し、サービス自身のバージョン情報を取得します。


.. Containers running as root within the Linux VM
.. win-containers-running-as-root-within-the-linux-vm:
Linux VM 内で root としてコンテナを実行
========================================

.. The Linux Docker daemon and containers run in a minimal, special-purpose Linux VM managed by Docker. It is immutable so users can’t extend it or change the installed software. This means that although containers run by default as root, this does not allow altering the VM and does not grant Administrator access to the Windows host machine. The Linux VM serves as a security boundary and limits what resources from the host can be accessed. File sharing uses a user-space crafted file server and any directories from the host bind mounted into Docker containers still retain their original permissions. It does not give the user access to any files that it doesn’t already have access to.

Linux Docker デーモンとコンテナは、Docker によって管理されている軽量な Linux VM 内で実行されます。これはつまり、コンテナはデフォルトでは ``root`` として実行しているとはいえ、Windows ホストマシンに対しての ``Administrator`` （管理者）アクセス許可ではありません。Linux VM サーバはセキュリティ境界であり、ホストからどのリソースにアクセスできるか制限があります。ホストから Docker コンテナ内にバインド マウントされる、ユーザースペースで作成されたファイルサーバーやあらゆるディレクトリは、元々のパーミッションを維持したままです。まだアクセスできないファイルに対しては、ユーザーに対してアクセス権を与えません。

.. Windows Containers
.. _permission-windows-containers:
Windows コンテナー
====================

.. Unlike the Linux Docker engine and containers which run in a VM, Windows containers are an operating system feature, and run directly on the Windows host with Administrator privileges. For organizations which do not want their developers to run Windows containers, a –no-windows-containers installer flag is available from version 4.11 to disable their use.

仮想マシン内で実行される Linux Docker Engine やコンテナとは異なり、Windows コンテナーはオペレーティングシステムとしての機能です。そのため、実行には Windows ホストで ``Administrator`` （管理者）特権が直接必要です。Windows コンテナーを開発者に対して実行させたくない組織の場合、 バージョン 4.11 から機能を無効かするために、インストーラで ``--no-windows-containers`` のフラグが利用できます。

.. Networking
.. _permission-networking:
ネットワーク機能
====================

.. For network connectivity, Docker Desktop uses a user-space process (vpnkit), which inherits constraints like firewall rules, VPN, HTTP proxy properties etc. from the user that launched it.

ネットワーク疎通のため、Docker Desktop はユーザー空間プロセス（ ``vpnkit`` ）を使います。これは、ユーザが Docker Desktop を起動する時、ファイアウォールのルールや、VPN、HTTP プロキシプロパティ等の制限を継承します。

.. seealso:: 

   Understand permission requirements for Windows | Docker Documentation
      https://docs.docker.com/desktop/windows/permission-requirements/

