.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/docker-for-mac/troubleshoot/
   doc version: 19.03
      https://github.com/docker/docker.github.io/blob/master/docker-for-mac/troubleshoot.md
.. check date: 2020/06/10
.. Commits on May 2-, 2020 a7806de7c56672370ec17c35cf9811f61a800a42
.. -----------------------------------------------------------------------------

.. Logs and troubleshooting

.. _mac-logs-and-troubleshooting:

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

.. _docker-mac-trobuleshoot:

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

* **Run Diagnostics** （診断の開始）: このオプションを選択すると、Docker Desktop 上のあらゆる問題を診断します。診断に関する詳細情報は、 :ref:`mac-diagnose-problems-send-feedback-and-create-github-issues` を御覧ください。

..    Reset Kubernetes cluster: Select this option to delete all stacks and Kubernetes resources. For more information, see Kubernetes.

* **Reset Kubernetes cluster** （Kubernetes クラスタのリセット）: このオプションを選択すると、全てのスタックと Kubernetes リソースを削除します。詳しい情報は :ref:`Kubernetes <mac-kubernetes>` を御覧ください。

..    Reset disk image: This option resets all Docker data without a reset to factory defaults. Selecting this option results in the loss of existing settings.

* **Reset disk image** （ディスク・イメージのリセット）：設定などを初期値のデフォルトに戻さず、全ての Docker データをリセットします。このオプションを選択した結果、既存の設定は消滅します。

..    Reset to factory defaults: Choose this option to reset all options on Docker Desktop to their initial state, the same as when Docker Desktop was first installed.

* **Reset to factory defaults** （初期値のデフォルトにリセット）: このオプションを選択すると、Docker Desktop の全てのオプションを初期値にリセットし、Docker Desktop が始めてインストールされたのと同じ状態にします。

..    Uninstall: Choose this option to remove Docker Desktop from your system.

* **Uninstall** （アンインストール）：このオプションを選択すると、システム上から Docker Desktop を削除します。

..    Uninstall Docker Desktop from the command line

..    To uninstall Docker Desktop from a terminal, run: <DockerforMacPath> --uninstall. If your instance is installed in the default location, this command provides a clean uninstall:

.. note:: **コマンドラインから Docker Desktop のアンインストール**

   ターミナルから Docker Desktop をアンインストールするには、 :code:`<DockerforMacのパス> --uninstall` を実行します。実態がデフォルトの場所へインストールしている場合は、このコマンドの実行によってクリーンにアンインストールできます。
   
   .. code-block:: bash
   
      $ /Applications/Docker.app/Contents/MacOS/Docker --uninstall
       Docker is running, exiting...
       Docker uninstalled successfully. You can move the Docker application to the trash.
   
   コマンドラインでアンインストールを試みようとする時は、先の例とは異なり、アプリを機能的に見つけられないため、メニュー上からはアンインストールできません。

..    You might want to use the command-line uninstall if, for example, you find that the app is non-functional, and you cannot uninstall it from the menu.

.. Diagnose problems, send feedback, and create GitHub issues

.. _mac-diagnose-problems-send-feedback-and-create-github-issues:

問題の診断、フィードバック送信、GItHub issues の作成
=======================================================


.. In-app diagnostics

.. _mac-in-app-diagnostics:

アプリ内診断
--------------------------------------------------

.. If you encounter problems for which you do not find solutions in this documentation, on Docker Desktop issues on GitHub, or the Docker Desktop forum, we can help you troubleshoot the log data.

発生した問題が、このページ内のドキュメントで解決できない場合は、 `GitHub の Docker Desktop <https://github.com/docker/for-mac/issues>`_ や `Docker Desktop for Mac forum <https://forums.docker.com/c/docker-for-mac>`_ で、ログデータのトラブルシュートに役立つ可能性があります。

.. Choose whale menu > Troubleshoot > Run Diagnostics.

Docker アイコン > **Troubleshoot**  > **Run Diagnostics** を選択します。


.. Diagnose & Feedback

.. Once the diagnostics are available, you can upload them and obtain a Diagnostic ID, which must be provided when communicating with the Docker team. For more information on our policy regarding personal data, see how is personal data handled in Docker Desktop.

**Diagnose & Feedback** ウインドウが開始されたら、診断情報の収集が始まります。診断情報が取得可能であれば、アップロードするときに必要となる **Diagnostic ID** を得られます。これは Docker チームとやりとりするときに必須です。私たちの個人データ取り扱いポリシーに関する情報は :ref:`mac-how-is-personal-data-handled-in-docker-desktop` を御覧ください。

.. Diagnostics & Feedback with ID

.. If you click Report an issue, this opens Docker Desktop for Mac issues on GitHub in your web browser in a “New issue” template. Add the details before submitting the issue. Do not forget to copy/paste your diagnostic ID.

**Report an issue** （問題を報告）をクリックすると `GitHub 上の Docker Desktop for Mac issues <https://github.com/docker/for-mac/issues/>`_ をウェブブラウザで開き、送信前に必要な一式が揃った "New issue" テンプレートが適用されます。その際に Diagnostic ID （診断 ID）の添付を忘れないでください。


.. Diagnosing from the terminal

.. _diagnosing-from-the-terminal:

ターミナルから診断
--------------------------------------------------

.. In some cases, it is useful to run the diagnostics yourself, for instance, if Docker Desktop cannot start.

例えば Docker Desktop for Mac が開始できないなど、場合によっては自分での診断実行が役立つ場合もあります。

.. First, locate the com.docker.diagnose tool. If you have installed Docker Desktop in the Applications directory, then it is located at /Applications/Docker.app/Contents/MacOS/com.docker.diagnose.

まず :code:`com.docker.diagnose` を探します。大抵は :code:`/Applications/Docker.app/Contents/MacOS/com.docker.diagnose` 
にあるでしょう。

.. To create and upload diagnostics, run:

診断の作成とアップロードをするには、次のコマンドを実行します：

.. code-block:: bash

   $ /Applications/Docker.app/Contents/MacOS/com.docker.diagnose gather -upload

.. After the diagnostics have finished, you should have the following output, containing your diagnostics ID:

診断が終了したら、以下のように診断 ID を含む出力になります。

.. code-block:: bash

   Diagnostics Bundle: /tmp/B8CF8400-47B3-4068-ADA4-3BBDCE3985D9/20190726143610.zip
   Diagnostics ID:     B8CF8400-47B3-4068-ADA4-3BBDCE3985D9/20190726143610 (uploaded)
   Diagnostics Bundle: /tmp/BE9AFAAF-F68B-41D0-9D12-84760E6B8740/20190905152051.zip
   Diagnostics ID:     BE9AFAAF-F68B-41D0-9D12-84760E6B8740/20190905152051 (uploaded)

.. The diagnostics ID (here BE9AFAAF-F68B-41D0-9D12-84760E6B8740/20190905152051) is composed of your user ID (BE9AFAAF-F68B-41D0-9D12-84760E6B8740) and a timestamp (20190905152051). Ensure you provide the full diagnostics ID, and not just the user ID.

診断 ID （ここでは BE9AFAAF-F68B-41D0-9D12-84760E6B8740/20190905152051）にはユーザ ID （BE9AFAAF-F68B-41D0-9D12-84760E6B8740）とタイムスタンプ（20190905152051）が合わさっています。診断 ID 全体を見て、ユーザ ID のみではないことを確認します。

.. To view the contents of the diagnostic file, run:

診断ファイルの内容を表示するには、次のように実行します。

.. code-block:: bash

   $ open /tmp/BE9AFAAF-F68B-41D0-9D12-84760E6B8740/20190905152051.zip

.. Check the logs

.. _mac-check-the-logs:

ログの確認
==================================================

.. In addition to using the diagnose and feedback option to submit logs, you can browse the logs yourself. The following documentation is about macOS 10.12 onwards; for older versions, see older documentation.

診断とフィードバックオプションによるログ送信だけでなく、自分自身でログを確認できます。以下のドキュメントは macOS 10.12 移行のものです。もしも古いバージョンであれば `古いドキュメント <https://github.com/docker/docker.github.io/blob/v17.12/docker-for-mac/troubleshoot.md#check-the-logs>`_ をご覧ください。

.. In a terminal

.. _mac-in-a-terminal:

ターミナル上で
--------------------------------------------------

.. To watch the live flow of Docker Desktop logs in the command line, run the following script from your favorite shell.

コマンドライン上で Docker Desktop ログのライブフロー（live flow）を表示するには、任意のシェルで以下のスクリプトを実行します。

.. code-block:: bash

   $ pred='process matches ".*(ocker|vpnkit).*"
     || (process in {"taskgated-helper", "launchservicesd", "kernel"} && eventMessage contains[c] "docker")'
   $ /usr/bin/log stream --style syslog --level=debug --color=always --predicate "$pred"

.. Alternatively, to collect the last day of logs (1d) in a file, run:


あるいは、直近1日のログ（ :code:`1d` ） をファイルに集めるには、次の様に実行します。

.. code-block:: bash

   $ /usr/bin/log show --debug --info --style syslog --last 1d --predicate "$pred" >/tmp/logs.txt

.. In the Console app

.. _mac-in-the-console-app:

アプリケーション上で
--------------------------------------------------

.. Macs provide a built-in log viewer, named “Console”, which you can use to check Docker logs.

Mac には "Console" という内蔵ログビュアーがあります。これを使って Docker のログを確認できます。

.. The Console lives in /Applications/Utilities; you can search for it with Spotlight Search.

Console は :code:`/Applications/Utilities` にあります。これはスポットライト検索で見つけられます。

.. To read the Docker app log messages, type docker in the Console window search bar and press Enter. Then select ANY to expand the drop-down list next to your docker search entry, and select Process.

Docker アプリのログ・メッセージを読むには、 Console ウインドウの検索バーで :code:`docker` と入力し、エンターを押します。それから `ANY` を選択肢、ドロップダウンリストを展開し、その横にある :code:`docker` と検索語を入力し、 `Press` を押します。

.. Mac Console search for Docker app

.. You can use the Console Log Query to search logs, filter the results in various ways, and create reports.

Console ログクエリを使ってログを検索でき、様々な方法で結果をフィルだしたり、レポートを作成したりできます。

.. Troubleshooting

.. _mac-troubleshooting:

トラブルシューティング
==================================================

.. Make sure certificates are set up correctly

.. _mac-make-sure-certificates-are-set-up-correctly:

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

.. For more about using client and server side certificates, see Adding TLS certificates in the Getting Started topic.

クライアントとサーバ側証明書の使用に関しては、導入ガイドのトピックにある :ref:`mac-add-tls-certificates` を御覧ください。

.. Docker Desktop does not start if Mac user account and home folder are renamed after installing the app

.. _mac-docker-desktop-does-not-start:

アプリをインストール後、Mac ユーザアカウントとホームフォルダの名称を変更したら、 Docker Desktop が起動しません
------------------------------------------------------------------------------------------------------------------------

.. See Do I need to reinstall Docker Desktop if I change the name of my macOS account? in the FAQs.

FAQ にある :ref:`do-i-need-to-reinstall-docker-for-mac-if-i-change-the-name-of-my-macos-account` をご覧ください。

.. Volume mounting requires file sharing for any project directories outside of /Users

.. _mac-volume-mounting-requires-file-sharing:

`/Users` 以外のプロジェクト・ディレクトリをファイル共有するため、ボリュームのマウントが必要な場合
------------------------------------------------------------------------------------------------------------------------

.. If you are using mounted volumes and get runtime errors indicating an application file is not found, access to a volume mount is denied, or a service cannot start, such as when using Docker Compose, you might need to enable file sharing.

:doc:`Docker Compose </compose/gettingstarted>` 等を使う場合、もしもマウント・ボリュームを使用していて、実行時にアプリケーション・ファイルが見つからない、ボリューム・マウントへのアクセスが拒否、サービスが起動できないなどのエラーが出る時は、 :ref:`ファイル共有 <mac-preferences-file-sharing>` を有効化する必要があるかもしれません。

.. Volume mounting requires shared drives for projects that live outside of the /Users directory. Go to whale menu > Preferences > Resources > File sharing and share the drive that contains the Dockerfile and volume.

:code:`/Users` ディレクトリの外をボリュームマウントするには、プロジェクトに対してドライブ共有する必要があります。 **鯨アイコン > Preferences > Resources > File sharing**  に移動し、Dockerfile とボリュームを含むドライブを共有します。

.. Incompatible CPU detected

.. _mac-incompatible-cpu-detected:

互換性がない CPU の検出
--------------------------------------------------

.. Docker Desktop requires a processor (CPU) that supports virtualization and, more specifically, the Apple Hypervisor framework. Docker Desktop is only compatible with Mac systems that have a CPU that supports the Hypervisor framework. Most Macs built in 2010 and later support it,as described in the Apple Hypervisor Framework documentation about supported hardware:

Docker Desktop が必要なのは、仮想化をサポートしているプロセッサ（CPU）と、とりわけ  `Apple Hypervisor framework <https://developer.apple.com/documentation/hypervisor>`_ です。 Docker Desktop が適合するのは、このハイパーバイザ・フレームワークをサポートしている CPU を搭載する Mac システムのみです。多くの Mac は 2010 年以降、最近まで製造されたものであり、サポートしています。詳細は Apple Hypervisor Framework ドキュメントにサポートしているハードウェアの情報があります。

.. Generally, machines with an Intel VT-x feature set that includes Extended Page Tables (EPT) and Unrestricted Mode are supported.

`一般的に、Intel VT-x 機能ががセットされたマシンには、Extended Page Table (EPT) と Unrestricted モードがサポートされています。`

.. To check if your Mac supports the Hypervisor framework, run the following command in a terminal window.

自分の Mac が Hypervisor frametowk をサポートしているかどうか確認するには、ターミナルウインドウ上で以下のコマンドを実行します。

.. code-block:: bash

   sysctl kern.hv_support

.. If your Mac supports the Hypervisor Framework, the command prints kern.hv_support: 1.

もしも Mac がハイパーバイザ・フレームワークをサポートしていたら、コマンドの結果は :code:`kern.hv_support: 1` です。

.. If not, the command prints kern.hv_support: 0.

もしサポートしていなければ、コマンドの結果は :code:`kern.hv_support: 0` です。

.. See also, Hypervisor Framework Reference in the Apple documentation, and Docker Desktop Mac system requirements.

また、Apple のドキュメント `Hypervisor Framework Reference <https://developer.apple.com/library/mac/documentation/DriversKernelHardware/Reference/Hypervisor/>`_ と Docker Desktop :ref:`Mac システム要件 <mac-system-requirements>` をご覧ください。

.. Workarounds for common problems

.. _mac-workarounds-for-common-problems:

共通する問題の回避策
----------------------------------------

..    If Docker Desktop fails to install or start properly on Mac:
        Make sure you quit Docker Desktop before installing a new version of the application (whale menu > Quit Docker Desktop). Otherwise, you get an “application in use” error when you try to copy the new app from the .dmg to /Applications.
        Restart your Mac to stop / discard any vestige of the daemon running from the previously installed version.
        Run the uninstall commands from the menu.


* Mac で Docker Desktop のインストールに失敗するか、適切に起動しない：
   * アプリケーションの新しいバージョンをインストールする前に、Docker Desktop を確実に終了しておきます（鯨アイコン > **Quit Docker Desktop** ）。そうしなければ、新しいアプリケーションを :code:`.dmg`  から :code:`/Applications` にコピーしようとしても、 "アプリケーションが使用中です" とエラーが出ます。
   * 以前にインストールしたバージョンが動作していたデーモンの停止と、その痕跡を無くすために、 Mac の再起動をします。
   * メニューからアンインストールのコマンドを実行します。

..    If docker commands aren’t working properly or as expected, you may need to unset some environment variables, to make sure you are not using the legacy Docker Machine environment in your shell or command window. Unset the DOCKER_HOST environment variable and related variables.
        If you use bash, use the following command: unset ${!DOCKER_*}
        For other shells, unset each environment variable individually as described in Setting up to run Docker Desktop on Mac in Docker Desktop on Mac vs. Docker Toolbox.

* もし :code:`docker` コマンドが適切または期待通りに動作しない場合は、シェルまたはコマンド画面で古い Docker Machine 環境を使用していないことを確認し、いくつかの環境変数を削除する必要があるかもしれません。 :code:`DOCKER_HOST` 環境変数と関連する変数をアンセットします。
   * bash を使用中であれば、次のコマンドを実行します： :code:`unset ${!DOCKER_*}` 
   * それ以外のシェルでは、各環境変数を :doc:`docker-toolbox` の :ref:`setting-up-to-run-docker-desktop-on-mac` に書いてある手順に従い、個々にアンセットします。

..    Network connections fail if the macOS Firewall is set to “Block all incoming connections”. You can enable the firewall, but bootpd must be allowed incoming connections so that the VM can get an IP address.

* macOS ファイアウォールを「外部からの接続を全てブロック」（Block all incoming connections）に設定している場合、ネットワーク通信に失敗します。ファイアウォールは有効化できますが、仮想マシンが IP アドレスを取得できるようにするため、 :code:`bootpd` に対して外部からの接続（incoming connections）を許可する必要があります。

..    For the hello-world-nginx example, Docker Desktop must be running to get to the web server on http://localhost/. Make sure that the Docker icon is displayed on the menu bar, and that you run the Docker commands in a shell that is connected to the Docker Desktop Engine (not Engine from Toolbox). Otherwise, you might start the webserver container but get a “web page not available” error when you go to localhost. For more information on distinguishing between the two environments, see Docker Desktop on Mac vs. Docker Toolbox.

* :code:`hello-world-nginx` を例に挙げると、 Docker Desktop は :code:`http://localhost/` 上のウェブサーバに到達する必要があります。メニューバーに Docker アイコンが表示されているのを確認し、それからシェル上で Docker コマンドを実行し、Docker Desktop Engine に接続しているかどうかを確認します（Toolbox 上の Engine ではありません）。そうでなければ、ウェブサーバ用コンテナの起動はできますが、 :code:`localhost` に移動しても「ウェブページが表示できません」とエラーが出るでしょう。2つの環境間の区別に関する情報は :doc:`docker-toolbox` をご覧ください。

..    If you see errors like Bind for 0.0.0.0:8080 failed: port is already allocated or listen tcp:0.0.0.0:8080: bind: address is already in use:
        These errors are often caused by some other software on the Mac using those ports.
        Run lsof -i tcp:8080 to discover the name and pid of the other process and decide whether to shut the other process down, or to use a different port in your docker app.

* :code:`Bind for 0.0.0.0:8080 failed: port is already allocated` （ポートが既に割り当て済みです）や :code:`listen tcp tcp:0.0.0.0:8080: bind: address is already in use` のようなエラーが出る場合は：
   * Mac 上の他のソフトウェアによって対象ポートが既に利用されているため、エラーが起こる場合があります。
   * :code:`lsof -i tcp:8080` を実行し、他のプロセスの名前と pid を確認し、他のプロセスを停止するかどうかを決めます。あるいは、docker アプリケーションが他のポートを使うようにします。

.. Known issues

.. _mac-known-issues:

既知の問題
==================================================

..    IPv6 is not (yet) supported on Docker Desktop.

* IPv6 は（まだ） Docker Desktop 上ではサポートされていません。

..    You might encounter errors when using docker-compose up with Docker Desktop (ValueError: Extra Data). We’ve identified this is likely related to data and/or events being passed all at once rather than one by one, so sometimes the data comes back as 2+ objects concatenated and causes an error.

* Docker Desktop で :code:`docker-compose up`  の実行時にエラーが出るかもしれません（  :code:`ValueError: Extra Data` ）。この現象が発生するのは、関連するデータのイベントが１つ１つ処理されるのではなく、一度にすべて処理されるためです。そのため、２つ以上のオブジェクトが連続して戻るようなデータがあれば、まれにエラーを引き起こします。

..    Force-ejecting the .dmg after running Docker.app from it can cause the whale icon to become unresponsive, Docker tasks to show as not responding in the Activity Monitor, and for some processes to consume a large amount of CPU resources. Reboot and restart Docker to resolve these issues.

* :code:`Docker.app` の実行後、 :code:`.dmg` を強制イジェクトすると、鯨のアイコンが反応しなくなります。また、アクティビティモニタでは、いくつかのプロセスが CPU リソースの大部分を消費してしまい、Docker が無反応なように見えます。この問題を解決するには、リブートして Docker を再起動します。

..    Docker does not auto-start on login even when it is enabled in whale menu > Preferences. This is related to a set of issues with Docker helper, registration, and versioning.

* Docker を鯨のアイコン > Preferences でログイン時に自動起動を設定しても、有効にならない場合があります。これは Docker ヘルパー、登録、バージョンに関連する一連の問題です。

..    Docker Desktop uses the HyperKit hypervisor (https://github.com/docker/hyperkit) in macOS 10.10 Yosemite and higher. If you are developing with tools that have conflicts with HyperKit, such as Intel Hardware Accelerated Execution Manager (HAXM), the current workaround is not to run them at the same time. You can pause HyperKit by quitting Docker Desktop temporarily while you work with HAXM. This allows you to continue work with the other tools and prevent HyperKit from interfering.

* macOS 10.10 Yosemite 以降では、Docker Desktop は :code:`HyperKit` ハイパーバイザ（ https://github.com/docker/hyperkit ）を使います。`Intel Hardware Accelerated Execution Manager (HAXM) <https://software.intel.com/en-us/android/articles/intel-hardware-accelerated-execution-manager/>`_ のような :code:`HyperKit` と競合するようなツールで開発を行っている場合、同時に両者を実行するための回避策は、現時点ではありません。一時的に Docker Desktop を終了して :code:`HyperKit` を停止すると、 HAXM を利用できます。これにより :code:`HyperKit` による干渉を防ぎながら、他のツールも利用し続けることができます。

..    If you are working with applications like Apache Maven that expect settings for DOCKER_HOST and DOCKER_CERT_PATH environment variables, specify these to connect to Docker instances through Unix sockets. For example:

* `Apache Maven <https://maven.apache.org/>`_ のようなアプリケーションを使っている場合に、 :code:`DOCKER_HOST ` と :code:`DOCKER_CERT_PATH` 環境変数をそれぞれ設定し、Docker に対して Unix ソケットを通して接続するように設定を試みる場合があります。その場合は、次のようにします。

.. code-block:: bash

    export DOCKER_HOST=unix:///var/run/docker.sock

..    docker-compose 1.7.1 performs DNS unnecessary lookups for localunixsocket.local which can take 5s to timeout on some networks. If docker-compose commands seem very slow but seem to speed up when the network is disabled, try appending 127.0.0.1 localunixsocket.local to the file /etc/hosts. Alternatively you could create a plain-text TCP proxy on localhost:1234 using:

* :code:`docker-compose` 1.7.1 は :code:`localunixsocket.local` という不要な DNS 名前解決を処理するため、同一ネットワーク上で 5 秒のタイムアウトを引き起こします。もしも :code:`docker-compose` コマンドの処理が非常に遅く、ネットワークを無効化しても速度が向上しない場合は、ファイル :code:`/etc/hosts` に :code:`127.0.0.1 localunixsocket.local` の追加を試みてください。別の方法として、 localhost:1234 を使うプレインテキストの TCP プロキシを作成することもできます。

.. code-block:: bash

    docker run -d -v /var/run/docker.sock:/var/run/docker.sock -p 127.0.0.1:1234:1234 bobrik/socat TCP-LISTEN:1234,fork UNIX-CONNECT:/var/run/docker.sock

..    and then export DOCKER_HOST=tcp://localhost:1234.

それから :code:`export DOCKER_HOST=tcp://localhost:1234.` です。

..    There are a number of issues with the performance of directories bind-mounted with osxfs. In particular, writes of small blocks, and traversals of large directories are currently slow. Additionally, containers that perform large numbers of directory operations, such as repeated scans of large directory trees, may suffer from poor performance. Applications that behave in this way include:
        rake
        ember build
        Symfony
        Magento
        Zend Framework
        PHP applications that use Composer to install dependencies in a vendor folder

* :code:`osxfs` ではディレクトリのバインド・マウントによる性能上の問題がいくつかあります。とくに、小さなブロックへの書き込みと、大きなディレクトリの再帰的な表示です。さらに、大きなディレクトリ階層を繰り返しスキャンするような、コンテナが非常に多いディレクトリの操作をすると、乏しいパフォーマンスに陥る可能性があります。このような挙動となりうるアプリケーションには：

   * :code:`rake`
   * :code:`ember build`
   * Symfony
   * Magento
   * Zend Framework
   * PHP アプリケーションのうち、 `Composer <https://getcomposer.org/>`_ で :code:`vendor` フォルダに依存関係をインストールする場合
   この挙動を回避するには、ベンダーまたはサードパーティ・ライブラリ Docker ボリュームの中に入れ、 `osxfs` マウントの外で一時的にファイルシステム処理を行うようにします。そして、 Unison や :code:`rsync` のようなサードパーティ製ツールを使い、コンテナのディレクトリとバインド・マウントしたディレクトリリ間を同期します。私たちは数々の技術を用いながら :code:`osxfs` 性能改善にアクティブに取り組んでいます。詳細を学ぶには、 :ref:`osxfs-performance-issues-solutions-and-roadmap` をご覧ください。

..    As a work-around for this behavior, you can put vendor or third-party library directories in Docker volumes, perform temporary file system operations outside of osxfs mounts, and use third-party tools like Unison or rsync to synchronize between container directories and bind-mounted directories. We are actively working on osxfs performance using a number of different techniques. To learn more, see the topic on Performance issues, solutions, and roadmap.

..    If your system does not have access to an NTP server, then after a hibernate the time seen by Docker Desktop may be considerably out of sync with the host. Furthermore, the time may slowly drift out of sync during use. To manually reset the time after hibernation, run:

* システムが NTP サーバにアクセスできなければ、Docker Desktop が一時休止後に見える時間の関係で、ホストとの同期が外れてしまう可能性があります。さらに同期のために用いる時間が少々ずれる可能性があります。一時休止後に手動でリセットするには、次のコマンドを実行します。
.. code-block:: bash

    docker run --rm --privileged alpine hwclock -s

..    Or, to resolve both issues, you can add the local clock as a low-priority (high stratum) fallback NTP time source for the host. To do this, edit the host’s /etc/ntp-restrict.conf to add:

あるいは、両方の問題を解決するには、ホストをソースとするフォールバック NTP 時間を低プライオリティ（high stratum）のローカルクロックとして追加する方法があります。これのするには、ホスト側の :code:`/etc/ntp-restrict.conf`  に追加します。

.. code-block:: bash

    server 127.127.1.1              # LCL, local clock
    fudge  127.127.1.1 stratum 12   # increase stratum

..    Then restart the NTP service with:

それから、次のコマンドで NTP サービスを再起動します。

.. code-block:: bash

    sudo launchctl unload /System/Library/LaunchDaemons/org.ntp.ntpd.plist
    sudo launchctl load /System/Library/LaunchDaemons/org.ntp.ntpd.plist



.. seealso:: 

   Logs and troubleshooting
      https://docs.docker.com/docker-for-mac/troubleshoot/
