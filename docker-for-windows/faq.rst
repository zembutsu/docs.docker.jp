.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/docker-for-windows/faqs/
   doc version: 19.03
      https://github.com/docker/docker.github.io/blob/master/docker-for-windows/faqs.md
.. check date: 2020/06/12
.. Commits on May 18, 2020 fa91630d8271b72fe901104752aa30984a071820
.. -----------------------------------------------------------------------------

.. Frequently asked questions (FAQ)

.. win-frequently-asked-questions-faq

==================================================
よくある質問と回答 [FAQ]
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:


.. Stable and Edge releases 

.. _win-stable-and-edge-releases:

Stable と Edge リリース
==================================================

.. How do I get the Stable or the Edge version of Docker Desktop?

.. _win-how-do-i-get-the-stable-or-the-edge-version-of-docker-desktop:

Docker Desktop の Stable か Edge 版を入手するには、どうしたら良いでしょうか？
--------------------------------------------------------------------------------

.. You can download the Stable or the Edge version of Docker Desktop from Docker Hub.

Docker Desktop の Stable や Edge 版は `Docker Hub <https://hub.docker.com/editions/community/docker-ce-desktop-windows/>`_ からダウンロードできます。

.. For installation instructions, see Install Docker Desktop on Windows.

インストール手順は :doc:`install` を御覧ください。

.. What is the difference between the Stable and Edge versions of Docker Desktop?

.. _win-what-is-the-difference-between-the-stable-and-edge-versions-of-docker-desktop:

Docker Desktop の Stable 版と Edge 版の違いは何ですか？
------------------------------------------------------------

.. Two different download channels are available in the Community version of Docker Desktop:

Docker Desktop のコミュニティ版では、2つのダウンロード・チャンネルがあります。

.. The Stable channel provides a general availability release-ready installer for a fully baked and tested, more reliable app. The Stable version of Docker Desktop comes with the latest released version of Docker Engine. The release schedule is synched with Docker Engine releases and patch releases. On the Stable channel, you can select whether to send usage statistics and other data.

**Stable チャンネル** は、完全に固められ、テスト済みであり、信頼できるアプリケーションとして、一般的に利用可能な準備が調っているリリースのインストーラを提供します。リリース時期は Docker エンジンのリリースとパッチ（修正版）リリースに同期しています。Stable チャンネルでは、利用状況統計や他のデータを送信するかどうか選択できます。

.. The Edge channel provides an installer with new features we are working on, but is not necessarily fully tested. It comes with the experimental version of Docker Engine. Bugs, crashes, and issues are more likely to occur with the Edge version, but you get a chance to preview new functionality, experiment, and provide feedback as the apps evolve. Releases are typically more frequent than for Stable, often one or more per month. Usage statistics and crash reports are sent by default. You do not have the option to disable this on the Edge channel.

**Edge チャンネル** は、開発中の新機能を含むインストーラを提供しますが、必要なテストを十分に行っていません。Docker エンジンの実験的なバージョンを含みます。そのため、Edge バージョンの利用時には、バグ、クラッシュなど問題が発生する可能性があります。しかし、新機能のお試しや経験を得られるチャンスとなり、Docker Desktop の進化に対するフィードバックを提供します。一般的に、Edge リリースは Stable に比べ頻繁にリリースがあります。おおよそ、一ヶ月か一ヶ月おきのリリースです。デフォルトで利用統計情報やクラッシュ報告が送信されます。Edge チャンネルでは、これを無効化するオプションはありません。

.. Can I switch between Stable and Edge versions of Docker Desktop?

.. _win-can-i-switch-between-stable-and-edge-versions-of-docker-desktop

Docker Desktop の Stable と Edge 版を切り替えできますか？
------------------------------------------------------------

.. Yes, you can switch between Stable and Edge versions. You can try out the Edge releases to see what’s new, then go back to Stable for other work. However, you can only have one version of Docker Desktop installed at a time. For more information, see Switch between Stable and Edge versions.

はい、Stable と Edge 版を切り替え可能です。Edge リリースで何が新しくなったか試してみた後、Stable に戻って他のことができます。しかしながら、 **一度に Docker Desktop をインストールできるバージョンは、１つのみ** です。詳しい情報は :ref:`win-switch-between-stable-and-edge-version` を御覧ください。

.. What is an experimental feature?

.. _win-what-is-an-experimental-feature:

実験的機能（experimental features）とは何ですか？
==================================================

.. Experimental features provide early access to future product functionality. These features are intended for testing and feedback only as they may change between releases without warning or can be removed entirely from a future release. Experimental features must not be used in production environments. Docker does not offer support for experimental features.

実験的機能とは、今後のプロダクト機能を早期に利用できます。各機能のテストやフィードバックのみを目的としており、今後のリリースでは予告のない変更や、将来的なリリースでは機能全体が削除される場合があります。実験的機能はプロダクション環境で利用すべきではありません。実験的機能に対し、Docker はサポートを提供しません。


..    To enable experimental features in the Docker CLI, edit the config.json file and set experimental to enabled.

..    To enable experimental features from the Docker Desktop menu, click Settings (Preferences on macOS) > Command Line and then turn on the Enable experimental features toggle. Click Apply & Restart.

.. attention::

   Docker CLI で実験的機能を有効にするには、 :code:`config.json` ファイルを編集し、 :code:`experimental` を enabled（有効）にしてください。
   Docker Desktop のメニューから実験的機能を有効にするには、  **Settings** （macOS は **Preferences** ）> **Command Line**  をクリックし、それから **Enable experimental features** トグルを有効に切り替えます。 **Apply & Restart** （適用と再起動）をクリックします。

.. For a list of current experimental features in the Docker CLI, see Docker CLI Experimental features.

Docker CLI の現時点における実験的機能の一覧は、 `Docker CLI Experimental features <https://github.com/docker/cli/blob/master/experimental/README.md>`_  をご覧ください。

.. How do I?

.. _win-how-do-i:

どうしたらいいでしょうか？
==================================================


.. How do I connect to the remote Docker Engine API?

.. _win-how-do-i-connect-to-the-remote-docker-engine-api:

リモートの Docker Engine API に接続するには？
--------------------------------------------------

.. You might need to provide the location of the Engine API for Docker clients and development tools.

Docker クライアントと開発ツール用のために、 Engine API の場所を指定する必要があるでしょう。

.. On Docker Desktop, clients can connect to the Docker Engine through a named pipe: npipe:////./pipe/docker_engine, or TCP socket at this URL: tcp://localhost:2375.

Docker Desktop では、Docker Engine は、 名前付きパイプ :code:`npipe:////./pipe/docker_engine` または :code:`tcp://localhost:2375.` にある **TCP ソケット** を通して接続できます。

.. See also Docker Engine API and Docker Desktop for Mac forums topic Using pycharm Docker plugin...

.. How do I connect from a container to a service on the host?

.. _win-how-do-i-connect-from-a-container-to-a-service-on-the-host:

ホスト上のサービスにコンテナから接続するには？
--------------------------------------------------

.. Windows has a changing IP address (or none if you have no network access). We recommend that you connect to the special DNS name host.docker.internal, which resolves to the internal IP address used by the host. This is for development purposes and will not work in a production environment outside of Docker Desktop for Windows.

Windows は変動 IP アドレスを持ちます（あるいは、ネットワーク接続がなければ存在しません）。私たちが推奨するのは  :code:`host.docker.internal` という特別な DNS 名での接続です。これはホストによって使われる内部の IP アドレスを名前解決します。これは開発用途であり、Docker Desktop for Windows 以外のプロダクション環境では動作しません。

.. The gateway is also reachable as gateway.docker.internal.

また、ゲートウェイには :code:`gateway.docker.internal` で到達できます。

.. For more information about the networking features in Docker Desktop for Windows, see Networking.

Docker Desktop for Windows のネットワーク機能についての情報は :doc:`ネットワーク機能 <networking>` の :ref:`win-i-want-to-connect-from-a-container-to-a-service-on-the-host` を御覧ください。

.. How do I connect to a container from Windows?

.. _win-how-do-i-connect-to-a-container-from-windows

Windows からコンテナに接続するには？
--------------------------------------------------

.. We recommend that you publish a port, or connect from another container. You can use the same method on Linux if the container is on an overlay network and not a bridge network, as these are not routed.

私たちが推奨するのはポートの公開か、他のコンテナからの接続です。コンテナがオーバレイ・ネットワークを使う場合は、Linux と同じような手法が使えますが、ブリッジ・ネットワークの場合は経路付け（ルーティング）されず使えません。

.. For more information and examples, see I want to connect to a container from the Mac in the Networking topic.

詳細な情報と例は :doc:`ネットワーク機能 <networking>` の :ref:`i-want-to-connect-to-a-container-from-windows` を御覧ください。

.. Volumes

.. _win-faq-volumes:

ボリューム
====================

.. Can I change permissions on shared volumes for container-specific deployment requirements?

.. _can-i-change-permissions-on-shared-volumes-for-container-specific-deployment-requirements:

コンテナ固有のデプロイに必要となる、共有ボリューム上の権限を変更できますか？
--------------------------------------------------------------------------------

.. No, at this point, Docker Desktop does not enable you to control (chmod) the Unix-style permissions on shared volumes for deployed containers, but rather sets permissions to a default value of 0777 (read, write, execute permissions for user and for group) which is not configurable.

いいえ、現時点では、Docker Desktop はデプロイしたコンテナで :ref:`共有ボリューム <win-preferences-file-sharing>` 上で Unix 風の権限を制御（ :code:`chmod` ）できません。それどころか、権限をデフォルトで :code:`0777` の値（ :code:`user` と :code:`group` に対する「読み込み」「書き込み」「実行」の権限 ）に設定し、変更不可能です。

.. For workarounds and to learn more, see Permissions errors on data directories for shared volumes.

回避策を学ぶには :ref:`permissions-errors-on-data-directories-for-shared-volumes` をご覧ください。

.. How do symlinks work on Windows?

.. _how-do-symlinks-work-on-windows:

シンボリックリンク（symlink）をサポートしますか？
--------------------------------------------------

.. Docker Desktop supports 2 kinds of symlink:

Docker Desktop は2種類のシンボリックリンクをサポートします。

..    Windows native symlinks: these are visible inside containers as symlinks.
    Symlinks created inside a container: these are represented as mfsymlinks i.e. regular Windows files with special metadata. These appear as symlinks inside containers but not as symlinks on the host.

1. Windows ネイティブのシンボリックリンク：これらはコンテナ内でシンボリックリンクとして見えます。
2. コンテナ内で作成されたシンボリックリンク：これらは `mfsymlinks <https://wiki.samba.org/index.php/UNIX_Extensions#Minshall.2BFrench_symlinks>`_ として表示されます。たとえば、通常の Windows ファイルには特別なメタデータがあります。これらはコンテナ内ではシンボリックリンクとして表示されますが、ホスト上からはシンボリックリンクではありません。


.. Certificates

.. _win-faq-certificates:

証明書
==========

.. How do I add custom CA certificates?

.. _win-how-do-i-add-custom-ca-certificates:
どのようにしてカスタム CA 証明書を追加しますか？
--------------------------------------------------

.. Docker Desktop supports all trusted Certificate Authorities (CAs) (root or intermediate). Docker recognizes certs stored under Trust Root Certification Authorities or Intermediate Certification Authorities.

Docker Desktop は全ての信頼できる（ルート及び中間の）認証局（CA）をサポートしています。Docker は信頼できるルート認証局や中間認証局以下に保管されている証明書を認識します。

.. For more information on adding server and client side certs, see Adding TLS certificates in the Getting Started topic.

サーバとクライアント側証明書の追加に関する情報は、導入ガイドの記事にある :ref:`win-add-tls-certificates` を御覧ください。


.. How do I add client certificates?

.. _win-how do i add client certificates:
どのようにしてクライアント証明書を追加しますか？
--------------------------------------------------

.. For information on adding client certificates, see Add client certificates in the Getting Started topic.

サーバとクライアント側証明書の追加に関する情報は、導入ガイドの記事にある :ref:`win-add-tls-certificates` を御覧ください。

.. Can I run Docker Desktop in nested virtualization scenarios?

.. _win-can-i-run-docker-desktop-in-nested-virtualization-scenarios:

ネスト化した仮想化シナリオで Docker Desktop を動かせられますか？
----------------------------------------------------------------------

.. Docker Desktop can run inside a Windows 10 VM running on apps like Parallels or VMware Fusion on a Mac provided that the VM is properly configured. However, problems and intermittent failures may still occur due to the way these apps virtualize the hardware. For these reasons, Docker Desktop is not supported in nested virtualization scenarios. It might work in some cases, and not in others. For more information, see Running Docker Desktop in nested virtualization scenarios.

Paralles や VMware Fusion on a Mac が提供する Windows 10 仮想マシン内で、仮想マシンを適切に設定していれば Docker Desktop は実行可能です。しかしながら、ハードウェアを仮想化したアプリケーションを使うため、問題や断続的な停止が発生する可能性があります。これらの理由により、 **ネスト化した仮想化シナリオで Docker Desktop はサポート対象外です** 。詳しい情報は、 :ref:`running-docker-desktop-in-nested-virtualization-scenarios-win` をご覧ください。

.. Can I use VirtualBox alongside Docker Desktop?

.. _can-i-use-virtualbox-alongside-docker-desktop:

VirtualBox と Docker Desktop を併用できますか？
--------------------------------------------------

.. Yes, you can run VirtualBox along with Docker Desktop if you have enabled the Windows Hypervisor Platform feature on your machine.

はい、マシン上で `Windows ハイパーバイザープラットフォーム <https://docs.microsoft.com/ja-jp/virtualization/api/>`_ 機能が有効であれば、 Docker Desktop と VirtualBox を同時に利用できます。

.. Windows requirements

.. _faq-windows-requirements:

Windows 動作条件
====================

.. Can I run Docker Desktop on Windows Server?

.. _can-i-run-docker-desktop-on-windows-server:

Windows Server 上で Docker Desktop を実行できますか？
--------------------------------------------------------------------------------

.. No, running Docker Desktop on Windows Server is not supported.

いいえ、Windows Server 上で Docker Desktop の動作はサポートされていません。

.. How do I run Windows containers on Windows Server?

.. _how-do-i-run-windows-containers-on-windows-server:

Windows Server 上で Windows コンテナを実行できますか？
--------------------------------------------------------------------------------

.. You can install a native Windows binary which allows you to develop and run Windows containers without Docker Desktop. For more information, see the tutorial about running Windows containers on Windows Server in Getting Started with Windows Containers.

Docker Desktop がなくても、Windows コンテナの実行や開発ができるネイティブな Windows バイナリをインストールできます。Windows Server 上で Windows コンテナの実行に関する詳しい情報は、 `Getting Started with Windows Containers <https://github.com/docker/labs/blob/master/windows/windows-containers/README.md>`_ をご覧ください。

.. Can I install Docker Desktop on Windows 10 Home?

.. _can-i-install-docker-desktop-on-windows-10-home:

Windows 10 Home に Docker Desktop をインストールできますか？
--------------------------------------------------------------------------------

.. Windows 10 Home, version 2004 users can now install Docker Desktop Stable 2.3.0.2 or a later release with the WSL 2 backend.

Windows 10 Home のバージョン 2004 のユーザであれば、 `Docker Desktop Stable 2.3.0.2 <https://hub.docker.com/editions/community/docker-ce-desktop-windows/>`_ 以降のリリースで :doc:`WSL 2 backend` を使えば利用できます。

.. Docker Desktop Stable releases require the Hyper-V feature which is not available in the Windows 10 Home edition.

Docker Desktop Stable リリースは、 Hyper-V 機能を必要とするため、Windows 10 Home エディションではサポートされていません。

.. Why is Windows 10 required?

.. _why-is-windows-10-required:

なぜ Windows 10 が必要なのですか？
----------------------------------------

.. Docker Desktop uses the Windows Hyper-V features. While older Windows versions have Hyper-V, their Hyper-V implementations lack features critical for Docker Desktop to work.

Docker Desktop は Windows Hyper-V 機能を使います。Windows の古いバージョンでも Hyper-V はありますが、それらの Hyper-V には Docker Desktop を動作するために必要な機能が欠如しています。

.. Why does Docker Desktop fail to start when anti-virus software is installed?

.. _why-does-docker-desktop-fail-to-start-when-anti-virus-software-is-installed:

アンチウィルス・ソフトウェアをインストールしていると、Docker Desktop の起動に失敗するのはなぜでしょうか？
--------------------------------------------------------------------------------------------------------------

.. Some anti-virus software may be incompatible with Hyper-V and Windows 10 builds which impact Docker Desktop. For more information, see Docker Desktop fails to start when anti-virus software is installed in Troubleshooting.

いくつかのアンチウィルス・ソフトウェアは、Hyper-V と Windows 10 ビルドと互換性がなく、Docker Desktop に影響があります。詳しい情報は :doc:`troubleshoot` の :ref:`win-docker-desktop-fails-to-start-when-anti-virus-software-is-installed` を御覧ください。


.. Feedback

.. _win-faq-feedback:

フィードバック
==================================================

.. What kind of feedback are we looking for?

.. _win-what kind of feedback are we looking for:

どのような種類のフィードバックが求められていますか？
------------------------------------------------------------

.. Everything is fair game. We’d like your impressions on the download-install process, startup, functionality available, the GUI, usefulness of the app, command line integration, and so on. Tell us about problems, what you like, or functionality you’d like to see added.

全てが対象です。私たちはダウンロード、インストール手順、起動、利用可能な機能、GUI、アプリケーションの使いやすさ、コマンドライン統合、などなど、皆さんの所感を求めています。問題があれば、何をしたいのか、どのような機能が欲しいのかを教えてください。

.. What if I have problems or questions?

.. _win-what if i have problems or questions:

問題や質問がある場合は、どうしたら良いでしょうか？
--------------------------------------------------

.. You can find information about diagnosing and troubleshooting common issues in the Logs and Troubleshooting topic.

診断やトラブルシューティングに関する共通課題の情報は、 :doc:`troubleshoot` の記事にあります。

.. If you do not find a solution in Troubleshooting, browse issues on Docker Desktop for Windows issues on GitHub or create a new one. You can also create new issues based on diagnostics. To learn more, see Diagnose problems, send feedback, and create GitHub issues.

トラブルシューティングで解決策が見つからなければ、 `GitHub の Docker Desktop for Windows の issue <https://github.com/docker/for-win/issues>`_ を見るか、新しい issue を作成してください。また、診断結果に基づいて新しい issue の作成もできます。詳細を学ぶには :ref:`win-diagnose-problems-send-feedback-and-create-github-issues` を御覧ください。

.. The Docker Desktop for Windows forum provides discussion threads as well, and you can create discussion topics there, but we recommend using the GitHub issues over the forums for better tracking and response.

`Docker Desktop for Windows フォーラム <https://forums.docker.com/c/docker-for-windows>`_ には議論のスレッドがあります。そちらでも議論のトピックを作成できますが、私たちが推奨するのはフォーラムではなく GitHub issue を使う方が、追跡可能かつ反応も良いです。

.. How can I opt out of sending my usage data?

.. _win-how can i opt out of sending my usage data:

私の利用統計データの送信を停止できますか？
--------------------------------------------------

.. If you do not want to send of usage data, use the Stable channel. For more information, see What is the difference between the Stable and Edge versions of Docker Desktop.

利用統計データの送信を行いたくなければ、 Stable チャンネルを御利用ください。詳しい情報については、 :ref:`mac-what-is-the-difference-between-the-stable-and-edge-versions-of-docker-desktop` を御覧ください。

.. How is personal data handled in Docker Desktop?

.. _win-how is personal data handled in docker desktop:

Docker Desktop での個人データの取り扱いはどのようになっていますか？
----------------------------------------------------------------------

.. When uploading diagnostics to help Docker with investigating issues, the uploaded diagnostics bundle may contain personal data such as usernames and IP addresses. The diagnostics bundles are only accessible to Docker, Inc. employees who are directly involved in diagnosing Docker Desktop issues.

アップロードされた診断情報は、Docker の問題調査に役立ちますが、ユーザ名や IP アドレスなど個人情報がアップロードされる診断データに含まれる場合があります。診断データにアクセス可能なのは、Docker Desktop の問題を直接解析する Docker, Inc. の従業員のみです。

.. By default Docker, Inc. will delete uploaded diagnostics bundles after 30 days unless they are referenced in an open issue on the docker/for-mac or docker/for-win issue trackers. If an issue is closed, Docker, Inc. will remove the referenced diagnostics bundles within 30 days. You may also request the removal of a diagnostics bundle by either specifying the diagnostics ID or via your GitHub ID (if the diagnostics ID is mentioned in a GitHub issue). Docker, Inc. will only use the data in the diagnostics bundle to investigate specific user issues, but may derive high-level (non personal) metrics such as the rate of issues from it.

`docker/for-mac <https://github.com/docker/for-mac/issues>`_ や  `docker/for-win <https://github.com/docker/for-win/issues>`_ の issue トラッカーで、オープンになっていても参照の必要がなければ、Docker, Inc. はアップロードされた診断情報を通常 30 日で削除します。もし issue がクローズされれば、Docker, Inc. は参照された診断情報を 30 日以内に削除します。また、診断 ID かGitHub ID（診断 ID が GitHub issue で使われている場合は）のどちらかで、診断情報の削除要求が可能です。 Docker, Inc. は診断情報のデータを、特定のユーザに対する調査にのみ用いますが、そこから発生する頻度などハイレベル（個人に依存しない）なメトリクスを得る場合もあります。


.. seealso:: 

   Frequently asked questions (FAQ)
      https://docs.docker.com/docker-for-windows/faqs/
