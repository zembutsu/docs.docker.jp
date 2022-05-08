.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/docker-for-windows/troubleshoot/
   doc version: 19.03
      https://github.com/docker/docker.github.io/blob/master/docker-for-windows/troubleshoot.md
.. check date: 2020/06/12
.. Commits on May 2-, 2020 a7806de7c56672370ec17c35cf9811f61a800a42
.. -----------------------------------------------------------------------------

.. Logs and troubleshooting

.. _win-logs-and-troubleshooting:

==================================================
ログとトラブルシューティング
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. This page contains information on how to diagnose and troubleshoot Docker Desktop issues, send logs and communicate with the Docker Desktop team, use our forums and Success Center, browse and log issues on GitHub, and find workarounds for known problems.

このページに含む情報は、どのようにして原因を追及し、問題を解決し、ログを送信し、Docker Desktop のチームとやりとりし、フォーラムやナレッジ・ハブで使ったり、GitHub 上で問題を見たり記録したり、既知の問題に対する回避策を発見する方法です。

.. Troubleshoot

.. _docker-win-trobuleshoot:

トラブルシュート
==================================================

.. Choose whale menu > Troubleshoot from the menu bar to see the troubleshoot options.

メニューバーにある Docker のアイコン > **Troubleshoot** を選択し、トラブルシュートのオプションを表示します。

.. Uninstall or reset Docker

.. The Troubleshoot page contains the following options:

トラブルシュートのページには、以下のオプションを含みます。

..    Restart Docker Desktop: Select to restart Docker Desktop.

* **Restart Docker Desktop** （Docker Desktop の再起動）: 選択すると、Docker Desktop を再起動します。

..    Run Diagnostics: Select this option to diagnose any issues on Docker Desktop. For detailed information about diagnostics, see Diagnose problems, send feedback, and create GitHub issues.

* **Run Diagnostics** （診断の開始）: このオプションを選択すると、Docker Desktop 上のあらゆる問題を診断します。診断に関する詳細情報は、 :ref:`win-diagnose-problems-send-feedback-and-create-github-issues` を御覧ください。

..    Reset Kubernetes cluster: Select this option to delete all stacks and Kubernetes resources. For more information, see Kubernetes.

* **Reset Kubernetes cluster** （Kubernetes クラスタのリセット）: このオプションを選択すると、全てのスタックと Kubernetes リソースを削除します。詳しい情報は :ref:`Kubernetes <win-kubernetes>` を御覧ください。

..    Reset disk image: This option resets all Docker data without a reset to factory defaults. Selecting this option results in the loss of existing settings.

* **Reset disk image** （ディスク・イメージのリセット）：設定などを初期値のデフォルトに戻さず、全ての Docker データをリセットします。このオプションを選択した結果、既存の設定は消滅します。

..    Reset to factory defaults: Choose this option to reset all options on Docker Desktop to their initial state, the same as when Docker Desktop was first installed.

* **Reset to factory defaults** （初期値のデフォルトにリセット）: このオプションを選択すると、Docker Desktop の全てのオプションを初期値にリセットし、Docker Desktop が始めてインストールされたのと同じ状態にします。

.. _win-diagnose-problems-send-feedback-and-create-github-issues:

問題の診断、フィードバック送信、GitHub issues の作成
=======================================================


.. In-app diagnostics

.. _win-in-app-diagnostics:

アプリ内診断
--------------------------------------------------

.. If you experience issues for which you do not find solutions in this documentation, on Docker Desktop for Windows issues on GitHub, or the Docker Desktop for Windows forum, we can help you troubleshoot the log data.

発生した問題が、このページ内のドキュメントで解決できない場合は、 `GitHub の Docker Desktop <https://github.com/docker/for-win/issues>`_ や `Docker Desktop for Windows forum <https://forums.docker.com/c/docker-for-win>`_ で、ログデータのトラブルシュートに役立つ可能性があります。

.. Choose whale menu > Troubleshoot > Run Diagnostics.

Docker アイコン > **Troubleshoot**  > **Run Diagnostics** を選択します。


.. Diagnose & Feedback

.. Once the diagnostics are available, you can upload them and obtain a Diagnostic ID, which must be provided when communicating with the Docker team. For more information on our policy regarding personal data, see how is personal data handled in Docker Desktop.

**Diagnose & Feedback** ウインドウが開始されたら、診断情報の収集が始まります。診断情報が取得可能であれば、アップロードするときに必要となる **Diagnostic ID** を得られます。これは Docker チームとやりとりするときに必須です。私たちの個人データ取り扱いポリシーに関する情報は :ref:`win-how-is-personal-data-handled-in-docker-desktop` を御覧ください。

.. Diagnostics & Feedback with ID


.. If you click on Report an issue, it opens Docker Desktop for Windows issues on GitHub in your web browser in a “New issue” template, to be completed before submission. Do not forget to include your diagnostic ID.

**Report an issue** （問題を報告）をクリックすると `GitHub 上の Docker Desktop for Windows issues <https://github.com/docker/for-win/issues/>`_ をウェブブラウザで開き、送信前に必要な一式が揃った "New issue" テンプレートが適用されます。その際に Diagnostic ID （診断 ID）の添付を忘れないでください。

.. Diagnosing from the terminal

.. _win-diagnosing-from-the-terminal:

ターミナルから診断
--------------------------------------------------

.. On occasions it is useful to run the diagnostics yourself, for instance if Docker Desktop for Windows cannot start.

例えば Docker Desktop for Windows が開始できないなど、場合によっては自分での診断実行が役立つ場合もあります。

.. First locate the com.docker.diagnose, that should be in C:\Program Files\Docker\Docker\resources\com.docker.diagnose.exe.

まず :code:`com.docker.diagnose` を探します。大抵は :code:`C:\Program Files\Docker\Docker\resources\com.docker.diagnose.exe` 
にあるでしょう。

.. To create and upload diagnostics, run:

診断の作成とアップロードをするには、次のコマンドを実行します：

.. code-block:: bash

   PS C:\> & "C:\Program Files\Docker\Docker\resources\com.docker.diagnose.exe" gather -upload

.. After the diagnostics have finished, you should have the following output, containing your diagnostics ID:

診断が終了したら、以下のように診断 ID を含む出力になります。

.. code-block:: bash

   Diagnostics Bundle: C:\Users\User\AppData\Local\Temp\CD6CF862-9CBD-4007-9C2F-5FBE0572BBC2\20180720152545.zip
   Diagnostics ID:     CD6CF862-9CBD-4007-9C2F-5FBE0572BBC2/20180720152545 (uploaded)

.. Troubleshooting

.. _win-troubleshooting:

トラブルシューティング
==================================================

.. Make sure certificates are set up correctly

.. _win-make-sure-certificates-are-set-up-correctly:

証明書の正しいセットアップを確実にする
--------------------------------------------------

.. Docker Desktop ignores certificates listed under insecure registries, and does not send client certificates to them. Commands like docker run that attempt to pull from the registry produces error messages on the command line, for example:

Docker Desktop は安全ではないレジストリ（insecure registry）上にある証明書を無視します。また、そちらに対してクライアント証明書も送りません。 :code:`docker run` のようなコマンドでは、レジストリからの取得（pull）を試みても、次のようなコマンドライン上のエラーメッセージを表示します。

.. code-block:: bash

   Error response from daemon: Get http://192.168.203.139:5858/v2/: malformed HTTP response "\x15\x03\x01\x00\x02\x02"

.. As well as on the registry. For example:

レジストリ側でも同様にエラーが出ます。こちらが例です。

.. code-block:: bash

   2019/06/20 18:15:30 http: TLS handshake error from 192.168.203.139:52882: tls: client didn't provide a certificate
   2019/06/20 18:15:30 http: TLS handshake error from 192.168.203.139:52883: tls: first record does not look like a TLS handshake

.. For more about using client and server side certificates, see How do I add custom CA certificates? and How do I add client certificates? in the Getting Started topic.

クライアントとサーバ側証明書の使用に関しては、導入ガイドのトピックにある :ref:`win-add-custom-ca-certificates-server-side` と :ref:`win-add-client-certificates:` を御覧ください。

.. Volumes

.. _win-troubleshoot-volumes:

ボリューム
----------

.. Permissions errors on data directories for shared volumes

.. _permissions-errors-on-data-directories-for-shared-volumes:

共有ボリュームにおける、データ・ディレクトリ上の権限（permission）エラー
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. Docker Desktop sets permissions on shared volumes to a default value of 0777 (read, write, execute permissions for user and for group).

Docker Desktop は :ref:`共有ボリューム <win-preferences-file-sharing>` 上の権限（パーミッション）をデフォルトで :code:`0777` （ :code:`ユーザ` 及び :code:`グループ` に対して、 :code:`読み込み` ・ :code:`書き込み` ・ :code:`実行` の権限）に設定します。

.. The default permissions on shared volumes are not configurable. If you are working with applications that require permissions different from the shared volume defaults at container runtime, you need to either use non-host-mounted volumes or find a way to make the applications work with the default file permissions.

共有ボリューム上におけるデフォルトの権限は、変更できません。もしも、アプリケーションの動作上、デフォルトの共有ボリューム上でコンテナ実行時に異なる権限が必要となる場合は、ホストをマウントしないボリュームを使用するか、アプリケーション側が初期設定の権限で動作する設定を見つける必要があります。

.. See also, Can I change permissions on shared volumes for container-specific deployment requirements? in the FAQs.

また、 :ref:`can-i-change-permissions-on-shared-volumes-for-container-specific-deployment-requirements` もご覧ください。

.. Volume mounting requires shared drives for Linux containers

.. _volume-mounting-requires-shared-drives-for-linux-containers:

共有ドライブ上へのボリューム・マウントが Linux コンテナに必要です
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. If you are using mounted volumes and get runtime errors indicating an application file is not found, access is denied to a volume mount, or a service cannot start, such as when using Docker Compose, you might need to enable shared drives.

マウント・ボリュームを使用中に、アプリケーション・ファイルが見つからないというランタイム・エラーが表示される場合は、ボリューム・マウントに対するアクセスが拒否されているか、あるいは、 :doc:` Docker Compose </compose/gettingstarted>` などを使っていてサービスが開始できない場合には、  :ref:`共有ドライブ <<win-preferences-file-sharing>` の有効化が必要でしょう。

.. Volume mounting requires shared drives for Linux containers (not for Windows containers). Click whale menu and then Settings > Shared Drives and share the drive that contains the Dockerfile and volume.

Linux コンテナ（Windows コンテナではありません）でボリュームをマウントするには、共有ドライブが必要です。Docker アイコンをクリックし、それから **Settings > Shared Drives** を選び、Dockerfile と ボリュームを置くためのドライブを共有します。

.. Support for symlinks

.. _win-support-for-simlinks:


シンボリックリンク（symlinks）のサポート
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. Symlinks work within and across containers. To learn more, see How do symlinks work on Windows? in the FAQs.

シンボリックリンクはコンテナ間および横断して機能します。詳しく学ぶには、 FAQ の :ref:`how-do-symlinks-work-on-windows` をご覧ください。

.. Avoid unexpected syntax errors, use Unix style line endings for files in containers

.. _avoid-unexpected-syntax-errors,-use-unix-style-line-endings-for-files-in-containers:

予期しない構文エラー（unexpected syntax error）を避けるため、コンテナ内でファイルの行末を unix 風にする
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. Any file destined to run inside a container must use Unix style \n line endings. This includes files referenced at the command line for builds and in RUN commands in Docker files.

コンテナ内で実行するあらゆるファイルは、 Unix 風の行末 :code:`\n` を使う必要があります。これをファイルに含むのは、ビルド用のコマンドラインや Dockerfile における RUN 命令で参照するからです。

.. Docker containers and docker build run in a Unix environment, so files in containers must use Unix style line endings: \n, not Windows style: \r\n. Keep this in mind when authoring files such as shell scripts using Windows tools, where the default is likely to be Windows style line endings. These commands ultimately get passed to Unix commands inside a Unix based container (for example, a shell script passed to /bin/sh). If Windows style line endings are used, docker run fails with syntax errors.

Docker コンテナと :code:`docker build` の実行は Unix 環境のため、コンテナ内のファイルは Unix 風の行末 :code:`\n` を使うのが必須です。 Window 風の :code:`\r\n` ではありません。シェルスクリプトのようなファイルを作成するときは、Windows ツールを使うとデフォルトで Windows 風の行末になるので、気に留めておいてください。各コマンドは、最終的には Unix をベースするコンテナ内の Unix コマンドに渡されます（例えば、シェルスクリプトは :code:`/bin/sh` に渡されます）。もしも Windows 風の行末が用いられると、 :code:`docker run` は構文エラーになり失敗します。

.. For an example of this issue and the resolution, see this issue on GitHub: Docker RUN fails to execute shell script.

この問題と解決方法の例は、GitHub 上の issue を御覧ください：  `Docker RUN でシェルスクリプトの実行に失敗する（英語） <https://github.com/moby/moby/issues/24388)>`_ 

.. Virtualization

.. _win-troubleshoot-virtualization:

仮想化
--------------------

.. Your machine must have the following features for Docker Desktop to function correctly:

Docker Desktop を正しく機能するには、マシンには以下の機能が必要です。

..    Hyper-V installed and working
    Virtualization enabled in the BIOS

1. `Hyper-V <https://docs.microsoft.com/ja-jp/windows-server/virtualization/hyper-v/hyper-v-technology-overview>`_ をインストールして、動作させる
2. 仮想化の有効化

.. Hyper-V

.. _win-troubleshoot-hyper-v:

Hyper-V
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. Docker Desktop requires Hyper-V as well as the Hyper-V Module for Windows Powershell to be installed and enabled. The Docker Desktop installer enables it for you.

Docker Desktop をインストールして有効化するには、 Hyper-V と同様に Windows Powershell 用 Hyper-V モジュールも必要です。Docker Desktop インストーラは、これらを有効化します。

.. Docker Desktop also needs two CPU hardware features to use Hyper-V: Virtualization and Second Level Address Translation (SLAT), which is also called Rapid Virtualization Indexing (RVI). On some systems, Virtualization must be enabled in the BIOS. The steps required are vendor-specific, but typically the BIOS option is called Virtualization Technology (VTx) or something similar. Run the command systeminfo to check all required Hyper-V features. See Pre-requisites for Hyper-V on Windows 10 for more details.

また、Docker Desktop は Hyper-V を使うために2つの CPU 機能を使います。すなわち、仮想化と  Rapid Virtualization Indexing (RVI) とも呼ばれる Second Level Address Translation (SLAT) です。同じシステムの BIOS 上で、Virtualization （仮想化）の有効化が必須です。必要な手順はベンダによって異なりますが、典型的な BIOS オプションは :code:`Virtualization Technology (VTx)` と呼ばれるものか、似たようなものです。Hyper-V 機能が必要とする全てを確認するには、 :code:`systeminfo` コマンドを実行します。詳細は `Windows 10 Hyper-V のシステム要件 <https://docs.microsoft.com/ja-jp/virtualization/hyper-v-on-windows/reference/hyper-v-requirements>`_ を御覧ください。

.. To install Hyper-V manually, see Install Hyper-V on Windows 10. A reboot is required after installation. If you install Hyper-V without rebooting, Docker Desktop does not work correctly.

Hyper-V を手動でインストールするには、 `Windows 10 上に Hyper-V をインストールする <https://docs.microsoft.com/ja-jp/virtualization/hyper-v-on-windows/quick-start/enable-hyper-v?redirectedfrom=MSDN>_ を御覧ください。インストール後は再起動が必用です。Hyper-V をインストールしても再起動をしないと、 Docker Desktop は正しく動作しません。

.. From the start menu, type Turn Windows features on or off and press enter. In the subsequent screen, verify that Hyper-V is enabled:

スタートメニューから、 **Windows 機能の有効化又は無効化** を入力し、エンターを押します。以下の画面のようになっていると、Hyper-V は有効です。

.. Hyper-V on Windows features

.. Hyper-V driver for Docker Machine

.. _hyper-v-driver-for-docker-machine:

Docker Machine 用の Hyper-V ドライバ
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. The Docker Desktop installation includes the legacy tool Docker Machine which uses the old boot2docker.iso, and the Microsoft Hyper-V driver to create local virtual machines. This is tangential to using Docker Desktop, but if you want to use Docker Machine to create multiple local Virtual Machines (VMs), or to provision remote machines, see the Docker Machine topics. This is documented only for users looking for information about Docker Machine on Windows, which requires that Hyper-V is enabled, an external network switch is active, and referenced in the flags for the docker-machine create command as described in the Docker Machine driver example.

Docker Desktop のインストールには、Docker Machine という以前のツールが使う古い :code:`boot2docker.iso` と、ローカルで仮想マシンを作成するための `Microsoft Hyper-V ドライバ <https://docs.docker.com/machine/drivers/hyper-v/>`_ を含みます。これらは Docker Desktop とはほとんど関係がありませんが、Docker Machine で複数のローカル仮想マシン（VM）を作成したいときや、リモートマシンをプロビジョン（自動構築）するために必要です。詳しくは :doc:`Docker Machine </machine/index>` の記事を御覧ください。こちらのドキュメントは Docker Machine on Windows について探している方向けのドキュメントであり、必要となる Hyper-V の有効化や、アクティブに切り替える外部ネットワークや、  `前述の Docker Machine ドライバ例 <https://docs.docker.com/machine/drivers/hyper-v/#example>`_ にある :code:`docker-machine create` コマンドのフラグも含むリファレンスです。

.. Virtualization must be enabled

.. _virtualization-must-be-enabled:

仮想化を必ず有効化
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. In addition to Hyper-V or WSL 2, virtualization must be enabled. Check the Performance tab on the Task Manager:

:ref:`Hyper-V <win-troubleshoot-hyper-v>` や :doc:`WSL 2 <wsl>` を追加するには、仮想化の有効化が必要です。タスクマネージャー上のパフォーマンス・タブをクリックします。

.. Task Manager

.. If you manually uninstall Hyper-V, WSL 2 or disable virtualization, Docker Desktop cannot start. See Unable to run Docker for Windows on Windows 10 Enterprise.

もしも Hyper-V を手動でアンインストールするか、仮想化を無効にしたら、Docker Desktop は起動できません。 [Windows 10 Enterprise では Docker for Windows を実行できません（英語）](https://github.com/docker/for-win/issues/74) を御覧ください。

.. Networking and WiFi problems upon Docker Desktop for Windows install

.. _networking-and-wifi-problems-upon-docker-desktop-for-windows-install:

Docker Desktop for Windows インストール後のネットワーク機能と WiFi 問題
--------------------------------------------------------------------------------

.. Some users may experience networking issues during install and startup of Docker Desktop. For example, upon install or auto-reboot, network adapters and/or WiFi may get disabled. In some scenarios, problems are due to having VirtualBox or its network adapters still installed, but in other scenarios this is not the case. See the GitHub issue Enabling Hyper-V feature turns my wi-fi off.

Docker Desktop のインストールと起動によって、何人かの利用者は、ネットワーク機能の問題が発生する可能性があります。例えば、インストールあるいは自動再起動の後、ネットワーク・アダプタと WiFi のどちらかか両方が無効化するものです。問題のいくつかの原因は、 VirtualBox を導入しているか、そのネットワーク・アダプタをインストールしている場合ですが、その他の原因によっても起こる可能性があります。GitHub issue `Hyper-V 機能の有効化で wi-fi が切れる（英語） <https://github.com/docker/for-win/issues/139>`_ を御覧ください。

.. Here are some steps to take if you experience similar problems:

こちらは、もしも似たような問題が発生したときの対応手順です。

..    Ensure virtualization is enabled, as described above in Virtualization must be enabled.

1.  :ref:`virtualization-must-be-enabled` で前述した通り、 **仮想化** の有効化を確認します。

..    Ensure Hyper-V is installed and enabled, as described above in Hyper-V must be enabled.

2. :ref:`Hyper-V を必ず有効化 <virtualization-must-be-enabled>` で前述した通り、**Hyper-V** のインストールと有効化を確認します。

..    Ensure DockerNAT is enabled by checking the Virtual Switch Manager on the Actions tab on the right side of the Hyper-V Manager.

3. **Hyper-V マネージャー** の右側にある **操作** タブ上の **仮想スイッチマネージャー** で **DockerNAT** の有効化を確認します。

..    Hyper-V manager

..    Set up an external network switch. If you plan at any point to use Docker Machine to set up multiple local VMs, you need this anyway, as described in the topic on the Hyper-V driver for Docker Machine. You can replace DockerNAT with this switch.

4. 外部ネットワークスイッチをセットアップします。 :doc:`Docker Machine </machine/overview>` で複数のローカル VM のセットアップを検討中であれば、前述の `Docker Machine 用 Hyper-V ドライバ <https://docs.docker.com/machine/drivers/hyper-v/#example>`_ にある作業はいずれ必要です。 :code:`DockerNAT` はこのスイッチに置き換え可能です。

..    If previous steps fail to solve the problems, follow steps on the Cleanup README.

5. 以上の手順でも問題解決できない場合は、次の `クリーンアップ Readme <https://github.com/MicrosoftDocs/Virtualization-Documentation/blob/master/windows-server-container-tools/CleanupContainerHostNetworking/README.md>`_ にある手順を進めてください。

..        Read the full description before you run the Windows cleanup script.
..        The cleanup command has two flags, -Cleanup and -ForceDeleteAllSwitches. Read the whole page before running any scripts, especially warnings about -ForceDeleteAllSwitches. {: .warning}

.. tip::

    | **Windows クリーンアップスクリプトを実行する前に、必ずお読みください** 
    | クリーンアップ・コマンドには2つのフラグ :code:`-Cleanup` と :code:`-ForceDeleteAllSwitches` があります。スクリプトの実行前に各ページをお読みください。特に :code:`-ForceDeleteAllSwitches` に書かれた警告をお読みください。

.. Windows containers and Windows Server

.. _windows-containers-and-windows-server:

Windows コンテナと Windows Server
--------------------------------------------------

.. Docker Desktop is not supported on Windows Server. If you have questions about how to run Windows containers on Windows 10, see Switch between Windows and Linux containers.

Windows Server 上での Docker Desktop はサポート外です。そのかわり、追加費用なしで `Docker Enterprise Basic <https://docs.docker.com/ee/>`_ を利用可能です。Windows 10 上で Windows コンテナの実行に関する疑問があれば、 :ref:`switch-between-windows-and-linux-containers` を御覧ください。

.. A full tutorial is available in docker/labs on Getting Started with Windows Containers.

`docker/labs  <https://github.com/docker/labs>`_ の `Getting Started with Windows Container <https://github.com/docker/labs/blob/master/windows/windows-containers/README.md>`_ に全てのチュートリアルがあります。

.. You can install a native Windows binary which allows you to develop and run Windows containers without Docker Desktop. However, if you install Docker this way, you cannot develop or run Linux containers. If you try to run a Linux container on the native Docker daemon, an error occurs:

ネイティブな Windows バイナリをインストールしたら、Windows Desktop がなくても Windows コンテナの開発と実行が可能です。しかし、この方法で Docker をインストールしたら、Linux コンテナの開発と実行ができません。もしもネイティブな Docker デーモンで Linux コンテナの実行を試みても、次のようなエラーが発生します。

.. code-block:: bash

   C:\Program Files\Docker\docker.exe:
    image operating system "linux" cannot be used on this platform.
    See 'C:\Program Files\Docker\docker.exe run --help'.

.. Limitations of Windows containers for localhost and published ports

.. _Limitations-of-Windows-containers-for-localhost-and-published-ports:

:code:`localhost` の Windows コンテナの制限と公開ポート
------------------------------------------------------------

.. Docker Desktop for Windows provides the option to switch Windows and Linux containers. If you are using Windows containers, keep in mind that there are some limitations with regard to networking due to the current implementation of Windows NAT (WinNAT). These limitations may potentially resolve as the Windows containers project evolves.

Docker Desktop for Windows は、Windows と Linux コンテナの切り替えオプションがあります。もし Windows コンテナを使っている場合は、現時点における Windows NAT (WinNAT) の実装により、ネットワーク機能に対する複数の制限があります。それぞれの制限は Windows コンテナ・プロジェクトの進化によって、いずれは解決する可能性があります。

.. Windows containers work with published ports on localhost beginning with Windows 10 1809 using Docker Desktop for Windows as well as Windows Server 2019 / 1809 using Docker EE.

Windows 10 1819 で使える Docker Desktop for Windows から、Windows コンテナはローカルホスト上でのポート公開が可能になりました。Windows Server 2019 / 1809 で Docker EE を使う場合も同様です。

.. If you are working with a version prior to Windows 10 18.09, published ports on Windows containers have an issue with loopback to the localhost. You can only reach container endpoints from the host using the container’s IP and port. With Windows 10 18.09, containers work with published ports on localhost.

もしも `Windows 10 18.09` 未満のバージョンを使う場合は、Windows コンテナの公開ポートがローカルホストにループバックされる問題があります。ホストからコンテナのエンドポイントに到達できる唯一の方法は、コンテナの IP とポートを使います。 `Windows 10 18.09` では、コンテナはローカルホスト上にポートを公開可能です。

.. So, in a scenario where you use Docker to pull an image and run a webserver with a command like this:

それでは、Docker を使ってイメージを取得してウェブサーバを実行するため、次のようなコマンド実行例を見ましょう。

.. code-block:: bash

   > docker run -d -p 80:80 --name webserver nginx

.. Using curl http://localhost, or pointing your web browser at http://localhost does not display the nginx web page (as it would do with Linux containers).

:code:`curl http://localhost` を使うか、ウェブ・ブラウザで :code:`http://localhost` を表示しても、 `nginx` ウェブページは（Linux コンテナの場合とは違い）表示されません。

.. To reach a Windows container from the local host, you need to specify the IP address and port for the container that is running the service.

ローカルホストから Windows コンテナに到達するには、サービスを実行しているコンテナの IP アドレスとポートを指定する必要があります。

.. You can get the container IP address by using docker inspect with some --format options and the ID or name of the container. For the example above, the command would look like this, using the name we gave to the container (webserver) instead of the container ID:

コンテナに割り当てられている IP アドレスを知るには、 :code:`docker inspect`  に複数の :code:`--format` オプションと、コンテナの ID 又は名前を使います。先ほどの例では、コマンドを実行するときにコンテナ ID ではなくコンテナ名（ :code:`webserver` ）を使います。

.. code-block:: bash

   $ docker inspect \
     --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' \
     webserver

.. This gives you the IP address of the container, for example:

これにより、コンテナの IP アドレスを次のように表示します。

.. code-block:: bash

   $ docker inspect \
     --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' \
     webserver
   
   172.17.0.2

.. Now you can connect to the webserver by using http://172.17.0.2:80 (or simply http://172.17.0.2, since port 80 is the default HTTP port.)

あとは、ウェブサーバに対して :code:`http://172.17.0.2:80` を使って接続できるようになります（あるいは、ポート `80` はデフォルトの HTTP ポートのため、シンプルに :code:`http://172.17.0.2` を使います）。

.. For more information, see:

更に詳しい情報は、以下を御覧ください。

..    Docker Desktop for Windows issue on GitHub: Port binding does not work for locahost
    Published Ports on Windows Containers Don’t Do Loopback
    Windows NAT capabilities and limitations

*  GitHub の Docker Desktop for Windows issue: `localhost でポートのバインドが機能しません（英語） <https://github.com/docker/for-win/issues/458>`_ 
* `Windows コンテナの公開ポートがループバックしない（英語）] <https://blog.sixeyed.com/published-ports-on-windows-containers-dont-do-loopback/>`_
* `Windows NAT の機能と制限（英語） <https://techcommunity.microsoft.com/t5/virtualization/windows-nat-winnat-capabilities-and-limitations/ba-p/382303>`_


.. Running Docker Desktop in nested virtualization scenarios

.. _running-docker-desktop-in-nested-virtualization-scenarios-win:

ネストした仮想化環境で Docker Desktop を実行
--------------------------------------------------

.. Docker Desktop can run inside a Windows 10 VM running on apps like Parallels or VMware Fusion on a Mac provided that the VM is properly configured. However, problems and intermittent failures may still occur due to the way these apps virtualize the hardware. For these reasons, Docker Desktop is not supported in nested virtualization scenarios. It might work in some cases, and not in others.

Paralles や VMware Fusion a Mac 上で動く Windows 10 仮想マシン内で、適切な設定をすると Docker Desktop を実行可能です。しかしながら、ハードウェア仮想化アプリの手法によって、問題や一時的な問題が発生する可能性があります。そのため、 **Docker Desktop はネストした仮想化環境での実行をサポートしません** 。動く場合もあれば、動かない場合もあります。

.. For best results, we recommend you run Docker Desktop natively on a Windows system (to work with Windows or Linux containers), or on Mac to work with Linux containers.

最良の結果を出すには、Windows システム上で Docker Desktop をネイティブに実行するのを推奨します（Windows コンテナも Linux コンテナも動作します）。また Mac では Linux コンテナのみ動作します。

.. If you still want to use nested virtualization

.. _if-you-still-want-to-use-nested-virtualization:

それでもネスト化した仮想化環境を使いたい場合には
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

..    Make sure nested virtualization support is enabled in VMWare or Parallels. Check the settings in Hardware > CPU & Memory > Advanced Options > Enable nested virtualization (the exact menu sequence might vary slightly).
    Configure your VM with at least 2 CPUs and sufficient memory to run your workloads.
    Make sure your system is more or less idle.
    Make sure your Windows OS is up-to-date. There have been several issues with some insider builds.
    The processor you have may also be relevant. For example, Westmere based Mac Pros have some additional hardware virtualization features over Nehalem based Mac Pros and so do newer generations of Intel processors.

* VMware や Paralles でネスト化した仮想化サポートが有効になっているかどうかを確認します。設定の **Hardware > CPU & Memory > Advanced Options > Enable nested virtualization** を確認します（展開するメニュー順番は、若干変わるかもしれません）。
* 仮想マシンが最小 2 CPU と、ワークロードを実行するための十分なメモリを使うように設定します。
* システムは多少のアイドル（余裕）があるようにします。
* Windows OS を最新版へ確実に更新します。insider ビルドによっては、複数の問題があります。
* 適切なプロセッサも必要です。例えば、Westmere ベースの Mac Pro は、Nehalem ベースの Mac Pro よりもハードウェア仮想化機能が追加されていますし、更に新しい世代のインテル・プロセッサもそうでしょう。

.. Typical failures we see with nested virtualization

.. _typical-failures-we-see-with-nested-virtualization:

ネスト化した仮想化環境で起こる典型的な問題
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

..    Slow boot time of the Linux VM. If you look in the logs and find some entries prefixed with Moby. On real hardware, it takes 5-10 seconds to boot the Linux VM; roughly the time between the Connected log entry and the * Starting Docker ... [ ok ] log entry. If you boot the Linux VM inside a Windows VM, this may take considerably longer. We have a timeout of 60s or so. If the VM hasn’t started by that time, we retry. If the retry fails we print an error. You can sometimes work around this by providing more resources to the Windows VM.

* Linux 仮想マシンのブート時に確認します。ログを見て、 :code:`Moby` を先頭に含む行がないかどうか調べます。実在のハードウェアでは、Linux 仮想マシンのブートにかかる時間は 5 ～ 10 秒です。つまり、おおよその時間は、 :code:`Connected`  のログ記録から :code:`* Starting Docker ... [OK]` ログ記録までです。もしも Windows 仮想マシン内で Linux 仮想マシンをブートするのであれば、この処理にかかる時間はより長くなります。タイムアウトは 60 秒以上です。もし VM が時間までに起動しなければ、リトライします。リトライに失敗したら、エラーを表示します。Windows 仮想マシンに対し、更にリソースを提供することで回避可能な場合があります。

..    Sometimes the VM fails to boot when Linux tries to calibrate the time stamp counter (TSC). This process is quite timing sensitive and may fail when executed inside a VM which itself runs inside a VM. CPU utilization is also likely to be higher.

* ブート時、タイムスタンプ・カウンタ（TSC）の補正を Linux が行うとき、仮想マシンが落ちる場合があります。この処理はタイミングがセンシティブなため、仮想マシン内で仮想マシンを実行する場合に落ちるかもしれません。また、 CPU 使用率も高くなります。

..    Ensure “PMU Virtualization” is turned off in Parallels on Macs. Check the settings in Hardware > CPU & Memory > Advanced Settings > PMU Virtualization.

* Paralles on Mac では "PMU Virtualizatoin" が無効かどうかを確認します。 設定の **Hardware > CPU & Memory > Advanced Settings > PMU Virtualization** を確認します。

.. Related issues

.. _win-troubleshoot-virtual-related-issues:

関連する問題
^^^^^^^^^^^^^^^^^^^^

.. Discussion thread on GitHub at Docker for Windows issue 267.

GitHub の議論スレッドは `Docker for Windows issue 267 <https://github.com/docker/for-win/issues/267>`_ です。


.. Networking issues

.. _troubleshoot-networking-issues:

ネットワーク機能の課題
--------------------------------------------------

.. IPv6 is not (yet) supported on Docker Desktop.

Docker Desktop は（まだ） IPv6 をサポートしていません。

.. Some users have reported problems connecting to Docker Hub on the Docker Desktop stable version. (See GitHub issue 22567.)

Docker Desktop 安定版（stable）を使っているユーザ数名から、 Docker Hub への接続問題が報告されています。 `GitHub issue [22567] <https://github.com/moby/moby/issues/22567>`_ を御覧ください）

.. Here is an example command and error message:

以下はコマンドとエラーメッセージの例です。

.. code-block:: bash

   > docker run hello-world
   
   Unable to find image 'hello-world:latest' locally
   Pulling repository docker.io/library/hello-world
   C:\Program Files\Docker\Docker\Resources\bin\docker.exe: Error while pulling image: Get https://index.docker.io/v1/repositories/library/hello-world/images: dial tcp: lookup index.docker.io on 10.0.75.1:53: no such host.
   See 'C:\Program Files\Docker\Docker\Resources\bin\docker.exe run --help'.

.. As an immediate workaround to this problem, reset the DNS server to use the Google DNS fixed address: 8.8.8.8. You can configure this through the Settings

この問題を一時的に回避するには、 DNS サーバの設定をリセットし、 Google DNS の固定アドレス `8.8.8.8` を使います。この設定は **Settings** から行えます。

..    Network dialog, as described in the topic Network. Docker automatically restarts when you apply this setting, which could take some time.

.. note::

    **Network**  ダイアログについては、 [ネットワーク]() のトピックに詳細があります。この設定を適用したら、少し時間をおいた後、Docker は自動的に再起動します。


.. NAT/IP configuration

.. _win-nat-ip-configuration:

NAT/IP 設定
--------------------------------------------------

.. By default, Docker Desktop uses an internal network prefix of 10.0.75.0/24. Should this clash with your normal network setup, you can change the prefix from the Settings menu. See the Network topic under Settings.

デフォルトでは、 Docker Desktop は `10.0.75.0/24` の内部ネットワーク・プリフィックスを使用します。通常のネットワークセットアップで衝突してしまう場合には、 **Settings** （設定）メニューからプリフィックスを変更可能です。 [設定]() 以下の [ネットワーク]() 記事を御覧ください。


.. Workarounds

.. _win-workarounds:

回避策（ワークアラウンド）
==============================

.. Reboot

.. _win-reboot:

再起動
--------------------------------------------------

.. Restart your PC to stop / discard any vestige of the daemon running from the previously installed version.

PC を再起動し、以前にインストールしたバージョンで動いているデーモンの残骸を、停止・削除します。

.. Unset DOCKER_HOST

.. _win-unset-docker-host:

:code:`DOCKER_HOST` のリセット（unset）
--------------------------------------------------

.. The DOCKER_HOST environmental variable does not need to be set. If you use bash, use the command unset ${!DOCKER_*} to unset it. For other shells, consult the shell’s documentation.

:code:`DOCKER_HOST` 環境変数の設定は不要です。 bash を使用する場合は、リセットのために :code:`unset ${!DOCKER_*}` コマンドを使います。他のシェルの場合は、シェルのドキュメントをご確認ください。

.. Make sure Docker is running for webserver examples

.. _win-make-sure-docker-is-running-for-webserver-examples:


ウェブサーバの例で Docker が動作しているのを確認
--------------------------------------------------

.. For the hello-world-nginx example and others, Docker Desktop must be running to get to the webserver on http://localhost/. Make sure that the Docker whale is showing in the menu bar, and that you run the Docker commands in a shell that is connected to the Docker Desktop Engine (not Engine from Toolbox). Otherwise, you might start the webserver container but get a “web page not available” error when you go to docker.

:code:`hello-world-nginx` サンプルなどを使い、 Docker Desktop で :code:`https://localhost` 上にウェブサーバを起動します。メニューバー上に Docker 鯨（のアイコン）があるのを確認し、シェル上の Docker コマンドが Docker Desktop エンジンに接続しているのを確認します（Toolbox のエンジンではありません）。そうしなければ、ウェブサーバ・コンテナは実行できるかもしれませんが、 `docker`  は  "web page not available"（ウェブページが表示できません）というエラーを返すでしょう。

.. How to solve port already allocated errors

.. _win-how-to-solve-port-already-allocated-errors:

'port already allocated' （ポートが既に割り当てられています） エラーを解決するには
--------------------------------------------------------------------------------------

.. If you see errors like Bind for 0.0.0.0:8080 failed: port is already allocated or listen tcp:0.0.0.0:8080: bind: address is already in use ...

:code:`Bind for 0.0.0.0:8080 failed: port is already allocated` や :code:`listen tcp:0.0.0.0:8080: bind: address is already in use` ... のようなエラーが出ることがあるでしょう。

.. These errors are often caused by some other software on Windows using those ports. To discover the identity of this software, either use the resmon.exe GUI and click “Network” and then “Listening Ports” or in a Powershell use netstat -aon | find /i "listening " to discover the PID of the process currently using the port (the PID is the number in the rightmost column). Decide whether to shut the other process down, or to use a different port in your docker app.

これらのエラーは、Windows 上の他のソフトウェアが各ポートを使っている場合によく発生します。どのソフトウェアが使っているかを見つけるか、 :code:`resmon.exe` の GUI を使い "Network" と "listening Ports"  をクリックするか、 Powershell 上では :code:`netstat -aon | find /i "listening "` を使って、対象ポートを現在使っているプロセスの PID を見つけます（PID の値は行の右端です）。他のプロセスの停止を決めるか、あるいは、docker アプリで別のポートを使うかを決めます。

.. Docker Desktop fails to start when anti-virus software is installed

.. _win-docker-desktop-fails-to-start-when-anti-virus-software-is-installed:

アンチウィルス・ソフトウェアをインストールしていると、Docker Desktop の起動に失敗
-------------------------------------------------------------------------------------

.. Some anti-virus software may be incompatible with Hyper-V and Microsoft Windows 10 builds. The conflict typically occurs after a Windows update and manifests as an error response from the Docker daemon and a Docker Desktop start failure.

いくつかのアンチウィルス・ソフトウェアは、Hyper-V と Microsoft Windows 10 ビルドによっては互換性がない場合があります。典型的に発生するのは Windows update 直後で、Docker デーモンからエラーの反応が表示され、Docker Desktop の起動に失敗します。

.. For a temporary workaround, uninstall the anti-virus software, or explore other workarounds suggested on Docker Desktop forums.

一時的な回避策としては、アンチウィルス・ソフトウェアをアンインストールするか、Docker Desktop フォーラム上での他の回避策をお探しください。


.. seealso:: 

   Logs and troubleshooting
      https://docs.docker.com/docker-for-windows/troubleshoot/
