.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/desktop/faqs/windowsfaqs/
   doc version: 19.03
      https://github.com/docker/docker.github.io/blob/master/docker-for-windows/faqs.md
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/desktop/faqs/windowsfaqs.md
.. check date: 2022/08/24
.. Commits on AUg 24, 2022 9888da23c38fd374ded908e0d50bf1aa45eeef4d
.. -----------------------------------------------------------------------------

.. Frequently asked questions for Windows
.. _desktop-frequently-asked-questions-for-windows:

==================================================
よくある質問と回答 Wndows 版
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Can I use VirtualBox alongside Docker Desktop?
.. _desktop-win-can-i-use-virtualbox-alongside-docker-desktop:

VirtualBox と Docker Desktop を併用できますか？
--------------------------------------------------

.. Yes, you can run VirtualBox along with Docker Desktop if you have enabled the Windows Hypervisor Platform feature on your machine.

はい、マシン上で `Windows ハイパーバイザープラットフォーム <https://docs.microsoft.com/ja-jp/virtualization/api/>`_ 機能が有効であれば、 Docker Desktop と VirtualBox を同時に利用できます。

.. Why is Windows 10 or Windows 11 required?
.. _desktop-win-why-is-windows-10-or-windows-11-required:

なぜ Windows 10 か Windows 11 が必要なのですか？
--------------------------------------------------

.. Docker Desktop uses the Windows Hyper-V features. While older Windows versions have Hyper-V, their Hyper-V implementations lack features critical for Docker Desktop to work.

Docker Desktop は Windows Hyper-V 機能を使います。Windows の古いバージョンでも Hyper-V はありますが、それらの Hyper-V には Docker Desktop を動作するために必要な機能が欠如しています。


.. Can I install Docker Desktop on Windows 10 Home?
.. _desktop-win-can-i-install-docker-desktop-on-windows-10-home:

Windows 10 Home に Docker Desktop をインストールできますか？
--------------------------------------------------------------------------------

.. If you are running Windows 10 Home (starting with version 1903), you can install Docker Desktop for Windows with the WSL 2 backend.

Windows Home （バージョン 1903 以上）を実行している場合、 :doc:`WSL 2 バックエンド </desktop/windows/wsl>` で `Docker Desktop for Windows <https://hub.docker.com/editions/community/docker-ce-desktop-windows/>`_ をインストールできます。

.. Can I run Docker Desktop on Windows Server?
.. _desktop-win-can-i-run-docker-desktop-on-windows-server:

Windows Server 上で Docker Desktop を実行できますか？
--------------------------------------------------------------------------------

.. No, running Docker Desktop on Windows Server is not supported.

いいえ、Windows Server 上で Docker Desktop の動作はサポートされていません。

.. How do I run Windows containers on Windows Server?
.. _desktop-win-how-do-i-run-windows-containers-on-windows-server:

Windows Server 上で Windows コンテナーを実行できますか？
--------------------------------------------------------------------------------

.. You can install a native Windows binary which allows you to develop and run Windows containers without Docker Desktop. For more information, see the tutorial about running Windows containers on Windows Server in Getting Started with Windows Containers.

Docker Desktop がなくても、Windows コンテナーの実行や開発ができるネイティブな Windows バイナリをインストールできます。Windows Server 上で Windows コンテナーの実行に関する詳しい情報は、 `Getting Started with Windows Containers <https://github.com/docker/labs/blob/master/windows/windows-containers/README.md>`_ をご覧ください。

.. Why do I see the Docker Desktop Access Denied error message when I try to start Docker Desktop?
.. _desktop-win-why-do-i-see-the-docker-desktop-access-denied-error-message-when-i-try-to-start-docker-desktop:

Docker Desktop の起動時に Docker Desktop Access Denied エラーが出るのはなぜですか？
------------------------------------------------------------------------------------------

.. Docker Desktop displays the Docker Desktop - Access Denied error if a Windows user is not part of the docker-users group.

Windows ユーザーが **docker-users** グループのに所属していなければ、 Docker Desktop は **Docker Desktop - Access Denied** （アクセス拒否）エラーが出ます。

.. If your admin account is different to your user account, add the docker-users group. Run Computer Management as an administrator and navigate to Local Users* and Groups > Groups > docker-users.

自分のユーザーアカウントと管理者アカウントが異なる場合、 **docker-users** グループに追加します。管理者として **コンピューターの管理** を開き、 **ローカル ユーザーとグループ** > **グループ** > **docker-users** を辿ります。

.. Right-click to add the user to the group. Log out and log back in for the changes to take effect.

グループにユーザを追加するには、右クリックします。変更を反映するには、ログアウトしてからログインし直します。


.. Why does Docker Desktop fail to start when anti-virus software is installed?
.. _desktop-win-why-does-docker-desktop-fail-to-start-when-anti-virus-software-is-installed:

アンチウィルス・ソフトウェアをインストールしていると、Docker Desktop の起動に失敗するのはなぜでしょうか？
--------------------------------------------------------------------------------------------------------------

.. Some anti-virus software may be incompatible with Hyper-V and Windows 10 builds which impact Docker Desktop. For more information, see Docker Desktop fails to start when anti-virus software is installed in Troubleshooting.

いくつかのアンチウィルス ソフトウェアは、Hyper-V と Windows 10 ビルドと互換性がなく、Docker Desktop に影響があります。詳しい情報は :ref:`desktop-docker-desktop-fails-to-start-when-anti-virus-software-is-installed` を御覧ください。


.. Can I change permissions on shared volumes for container-specific deployment requirements?
.. _desktop-win-can-i-change-permissions-on-shared-volumes-for-container-specific-deployment-requirements:

コンテナ固有のデプロイに必要となる、共有ボリューム上の権限を変更できますか？
--------------------------------------------------------------------------------

.. Docker Desktop does not enable you to control (chmod) the Unix-style permissions on shared volumes for deployed containers, but rather sets permissions to a default value of 0777 (read, write, execute permissions for user and for group) which is not configurable.

Docker Desktop はデプロイしたコンテナで :ref:`共有ボリューム <win-preferences-file-sharing>` 上で Unix 風の権限を制御（ :code:`chmod` ）できません。それどころか、権限をデフォルトで :code:`0777` の値（ :code:`user` と :code:`group` に対する「読み込み」「書き込み」「実行」の権限 ）に設定し、変更不可能です。

.. For workarounds and to learn more, see Permissions errors on data directories for shared volumes.

回避策を学ぶには :ref:`desktop-topics-windows-permissions-errors-on-data-directories-for-shared-volumes` をご覧ください。

.. How do symlinks work on Windows?
.. _desktop-win-how-do-symlinks-work-on-windows:

Windows でシンボリックリンク（symlink）は機能しますか？
------------------------------------------------------------

.. Docker Desktop supports two types of symlinks: Windows native symlinks and symlinks created inside a container.

Docker Desktop は2種類のシンボリックリンクをサポートします。Windows ネイティブのシンボリックリンクと、コンテナ内で作成されるシンボリックリンクです。

.. The Windows native symlinks are visible within the containers as symlinks, whereas symlinks created inside a container are represented as mfsymlinks. These are regular Windows files with a special metadata. Therefore the symlinks created inside a container appear as symlinks inside the container, but not on the host.

Windows ネイティブのシンボリックリンクは、コンテナ内でシンボリックリンクとして見えます。 コンテナ内で作成されたシンボリックリンクは `mfsymlinks <https://wiki.samba.org/index.php/UNIX_Extensions#Minshall.2BFrench_symlinks>`_ として表示されます。たとえば、通常の Windows ファイルには特別なメタデータがあります。これらはコンテナ内ではシンボリックリンクとして表示されますが、ホスト上からはシンボリックリンクではありません。

.. File sharing with Kubernetes and WSL 2
.. _desktop-win-file-sharing-with-kubernetes-and-wsl-2:

Kubernetes と WSL 2 でファイルを共有する
--------------------------------------------------

.. Docker Desktop mounts the Windows host filesystem under /run/desktop inside the container running Kubernetes. See the Stack Overflow post for an example of how to configure a Kubernetes Persistent Volume to represent directories on the host.

Docker Desktop は Kubernetes を実行するコンテナ内において、 ``/run/desktop`` 以下で Windows ホストファイルシステムをマウントします。 Kubernetes Persistent Volume が示すホスト上のディレクトリの調整方法は、 `Stack Overflow の投稿 <https://stackoverflow.com/questions/67746843/clear-persistent-volume-from-a-kubernetes-cluster-running-on-docker-desktop/69273405#69273>`_ 例をご覧ください。

.. How do I add custom CA certificates
.. _desktop-win-how-do-i-add-custom-ca-certificates:

任意の CA 証明書を追加できますか？
----------------------------------------

.. You can add trusted Certificate Authorities (CAs) to your Docker daemon to verify registry server certificates, and client certificates, to authenticate to registries.

Docker デーモンに対し、レジストリ・サーバ証明書とクライアント証明書の検証用に、信頼できる認証局(CA; Certificate Authorities)を追加してレジストリを認証できます。

.. Docker Desktop supports all trusted Certificate Authorities (CAs) (root or intermediate). Docker recognizes certs stored under Trust Root Certification Authorities or Intermediate Certification Authorities.

Docker Desktop は全ての信頼できうる（ルート及び中間）証明局（CA）をサポートしています。証明書が信頼できるルート認証局や中間認証局の配下にあるかどうか、Docker は識別します。

.. Docker Desktop creates a certificate bundle of all user-trusted CAs based on the Windows certificate store, and appends it to Moby trusted certificates. Therefore, if an enterprise SSL certificate is trusted by the user on the host, it is trusted by Docker Desktop.

Docker Desktop は Windows 証明局ストアに基づき、全てのユーザが信頼する CAの証明書バンドルを作成します。また、Moby の信頼できる証明書にも適用します。そのため、エンタープライズ SSL 証明書がホスト上のユーザによって信頼されている場合は、Docker Desktop からも信頼されます。

.. To learn more about how to install a CA root certificate for the registry, see Verify repository client with certificates in the Docker Engine topics.

レジストリに対する CA ルート証明書のインストール方法について学ぶには、Docker エンジン記事の :doc:`証明書でリポジトリ・クライアントを認証する </engine/security/certificates>` をご覧ください。

.. How do I add client certificates?
.. _desktop-win-how-do-i-add-client-certificates:
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

認証用にクライアント TLS 証明書を設定する方法を学ぶには、Docker エンジンの記事 :doc:`証明書でリポジトリ・クライアントを確認する </engine/security/certificates>` をご覧ください。


.. Switch between Windows and Linux containers
.. _desktop-win-switch-between-windows-and-linux-containers:

Windows と Linux コンテナとの切り替え
----------------------------------------

.. From the Docker Desktop menu, you can toggle which daemon (Linux or Windows) the Docker CLI talks to. Select Switch to Windows containers to use Windows containers, or select Switch to Linux containers to use Linux containers (the default).

Docker Desktop のメニューから、Docker CLI が通信するデーモン（Linux か Windows）を切り替えできます。 **Switch to Windows containers** （Windows コンテナーへ切り替え）を選ぶと Windows コンテナーを使います。又は、 **Switch to Linux containers** （Linux コンテナへ切り替え）を選ぶと Linux コンテナを使います（こちらがデフォルト）。

.. For more information on Windows containers, refer to the following documentation:

Windows コンテナに関する詳しい情報は、以下のドキュメントを参照ください。

..    Microsoft documentation on Windows containers.

* `Windows とコンテナー <https://docs.microsoft.com/ja-jp/virtualization/windowscontainers/about/>`_ にあるマイクロソフトのドキュメント

..    Build and Run Your First Windows Server Container (Blog Post) gives a quick tour of how to build and run native Docker Windows containers on Windows 10 and Windows Server 2016 evaluation releases.

* `Build and Run Your First Windows Server Container (ブログ投稿） <https://blog.docker.com/2016/09/build-your-first-docker-windows-server-container/>`_ では、Windows 10 と Windows Server 2016 evaluation リリースで、ネイティブな Docker Windows コンテナーを構築・実行するクイック ツアーを提供しています。

..    Getting Started with Windows Containers (Lab) shows you how to use the MusicStore application with Windows containers. The MusicStore is a standard .NET application and, forked here to use containers, is a good example of a multi-container application.

* `Getting Start with Windows Containers(Lab)（英語） <https://github.com/docker/labs/blob/master/windows/windows-containers/README.md>`_ では、 `MusicStore <https://github.com/aspnet/MusicStore/blob/dev/README.md>`_ の Windows コンテナー アプリケーションの使い方を紹介します。MusicStore は標準的な .NET アプリケーションであり、  `コンテナ－を使うものをコチラからフォーク <https://github.com/friism/MusicStore>`_ できます。これは複数コンテナー アプリケーションの良い例です。

..    To understand how to connect to Windows containers from the local host, see Limitations of Windows containers for localhost and published ports

* ローカルホストから Windows コンテナーに対して接続する方法を理解するには、 :ref:`Windows からコンテナーに接続したい <i-want-to-connect-to-a-container-from-windows>` をご覧ください。

..    Settings dialog changes with Windows containers
..    When you switch to Windows containers, the Settings dialog only shows those tabs that are active and apply to your Windows containers:

..    General
    Proxies
    Daemon
    Reset

.. tips::

   **Windows コンテナ－での設定ダイアログ変更について** 
   
   Windows コンテナ－に切り替えると、設定ダイアログは WIndows コンテナ－に対して適用できる、以下のタブのみ表示します。
   
   * General
   * Proxies
   * Daemon
   * Reset

.. If you set proxies or daemon configuration in Windows containers mode, these apply only on Windows containers. If you switch back to Linux containers, proxies and daemon configurations return to what you had set for Linux containers. Your Windows container settings are retained and become available again when you switch back.

Windows コンテナ－ モードでプロキシやデーモンの設定を行っても、それらが適用されるのは Windows コンテナ－に対してのみです。Linux コンテナに設定を切り戻すと、プロキシとデーモンの設定は Linux コンテナ用に設定していたものに戻ります。Windows コンテナ－の設定は保持されていますので、再び切り替えると Windows コンテナー向けの設定で利用できます。


.. seealso:: 

   Frequently asked questions for Windows
      https://docs.docker.com/desktop/faqs/windowsfaqs/
