.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/docker-for-mac/faqs/
   doc version: 19.03
      https://github.com/docker/docker.github.io/blob/master/docker-for-mac/faqs.md
.. check date: 2020/06/10
.. Commits on Apr 23, 2020 087e391397a825aa21d9f81755d4b201ff5c4c06
.. -----------------------------------------------------------------------------

.. Frequently asked questions (FAQ)

.. _mac-frequently-asked-questions-faq

==================================================
よくある質問と回答 [FAQ]
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:


.. Stable and Edge releases 

.. _mac-stable-and-edge-releases:

Stable と Edge リリース
==================================================

.. How do I get the Stable or the Edge version of Docker Desktop?

.. _mac-how-do-i-get-the-stable-or-the-edge-version-of-docker-desktop:

Docker Desktop の Stable か Edge 版を入手するには、どうしたら良いでしょうか？
--------------------------------------------------------------------------------

.. You can download the Stable or the Edge version of Docker Desktop from Docker Hub.

Docker Desktop の Stable や Edge 版は `Docker Hub <https://hub.docker.com/editions/community/docker-ce-desktop-windows/>`_ からダウンロードできます。

.. For installation instructions, see Install Docker Desktop on Mac.

インストール手順は :doc:`Mac に Docker Desktop をインストール <install>` を御覧ください。

.. What is the difference between the Stable and Edge versions of Docker Desktop?

.. _mac-what-is-the-difference-between-the-stable-and-edge-versions-of-docker-desktop:

Docker Desktop の Stable 版と Edge 版の違いは何ですか？
------------------------------------------------------------

.. Two different download channels are available in the Community version of Docker Desktop:

Docker Desktop のコミュニティ版では、2つのダウンロード・チャンネルがあります。

.. The Stable channel provides a general availability release-ready installer for a fully baked and tested, more reliable app. The Stable version of Docker Desktop comes with the latest released version of Docker Engine. The release schedule is synched with Docker Engine releases and patch releases. On the Stable channel, you can select whether to send usage statistics and other data.

**Stable チャンネル** は、完全に固められ、テスト済みであり、信頼できるアプリケーションとして、一般的に利用可能な準備が調っているリリースのインストーラを提供します。リリース時期は Docker エンジンのリリースとパッチ（修正版）リリースに同期しています。Stable チャンネルでは、利用状況統計や他のデータを送信するかどうか選択できます。

.. The Edge channel provides an installer with new features we are working on, but is not necessarily fully tested. It comes with the experimental version of Docker Engine. Bugs, crashes, and issues are more likely to occur with the Edge version, but you get a chance to preview new functionality, experiment, and provide feedback as the apps evolve. Releases are typically more frequent than for Stable, often one or more per month. Usage statistics and crash reports are sent by default. You do not have the option to disable this on the Edge channel.

**Edge チャンネル** は、開発中の新機能を含むインストーラを提供しますが、必要なテストを十分に行っていません。Docker エンジンの実験的なバージョンを含みます。そのため、Edge バージョンの利用時には、バグ、クラッシュなど問題が発生する可能性があります。しかし、新機能のお試しや経験を得られるチャンスとなり、Docker Desktop の進化に対するフィードバックを提供します。一般的に、Edge リリースは Stable に比べ頻繁にリリースがあります。おおよそ、一ヶ月か一ヶ月おきのリリースです。デフォルトで利用統計情報やクラッシュ報告が送信されます。Edge チャンネルでは、これを無効化するオプションはありません。

.. Can I switch between Stable and Edge versions of Docker Desktop?

.. _mac-can-i-switch-between-stable-and-edge-versions-of-docker-desktop

Docker Desktop の Stable と Edge 版を切り替えできますか？
------------------------------------------------------------

.. Yes, you can switch between Stable and Edge versions. You can try out the Edge releases to see what’s new, then go back to Stable for other work. However, you can only have one version of Docker Desktop installed at a time. For more information, see Switch between Stable and Edge versions.

はい、Stable と Edge 版を切り替え可能です。Edge リリースで何が新しくなったか試してみた後、Stable に戻って他のことができます。しかしながら、 **一度に Docker Desktop をインストールできるバージョンは、１つのみ** です。詳しい情報は :ref:`mac-switch-between-stable-and-edge-versions` を御覧ください。

.. What is Docker.app?

.. _what-is-docker-app:

Docker.app とは何ですか？
--------------------------------------------------

.. Docker.app is Docker Desktop on Mac. It bundles the Docker client and Docker Engine. Docker.app uses the macOS Hypervisor.framework to run containers, which means that a separate VirtualBox is not required to run Docker Desktop.

`Docker.app` は Mac 上の Docker Desktop です。Docker クライアントと Docker Engine が同梱されています。 `Docker.app` は macOS Hypervisor.framework でコンテナを実行します。つまり Docker Desktop の実行に、別途 VirtualBox をセットアップする必要がありません。


.. What are the system requirements for Docker Desktop?

.. _mac-what-are-the-system-requirements-for-docker-desktop:

Docker Desktop のシステム動作条件は何ですか？
--------------------------------------------------

.. You need a Mac that supports hardware virtualization. For more information, see Docker Desktop Mac system requirements.

システム動作条件に関する情報は、 :ref:`Docker Desktop Mac システム動作条件 <mac-system-requirements>` を御覧ください。

.. What is an experimental feature?

.. _mac-what-is-an-experimental-feature:

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

.. _mac-how-do-i:

どうしたらいいでしょうか？
==================================================


.. How do I connect to the remote Docker Engine API?

.. _mac-how-do-i-connect-to-the-remote-docker-engine-api:

リモートの Docker Engine API に接続するには？
--------------------------------------------------

.. You might need to provide the location of the Engine API for Docker clients and development tools.

Docker クライアントと開発ツール用のために、 Engine API の場所を指定する必要があるでしょう。

.. On Docker Desktop, clients can connect to the Docker Engine through a Unix socket: unix:///var/run/docker.sock.

Docker Desktop では、Docker Engine は、 Unix ソケット :code:`unix:///var/run/docker.sock` では接続できません。

.. See also Docker Engine API and Docker Desktop for Mac forums topic Using pycharm Docker plugin...

`Docker Engine API <https://docs.docker.com/engine/api/>`_ と、 Docker Desktop for Mac フォーラムの `Using pycharm Docker plugin... <https://forums.docker.com/t/using-pycharm-docker-plugin-with-docker-beta/8617>`_ トピックをご覧ください。

.. If you are working with applications like Apache Maven that expect settings for DOCKER_HOST and DOCKER_CERT_PATH environment variables, specify these to connect to Docker instances through Unix sockets. For example:

もしも `Apache Maven <https://maven.apache.org/>`_ のようなアプリケーションを動作中であれば、 :code:`DOCKER_HOST` と :code:`DOCKER_CERT_PATH` 環境変数の設定が必要でしょう。特にこれらで Docker にアクセスするためには Unix ソケットの指定が必要です。例：

.. code-block:: bash

   export DOCKER_HOST=unix:///var/run/docker.sock

.. How do I connect from a container to a service on the host?

.. _mac-how-do-i-connect-from-a-container-to-a-service-on-the-host:

ホスト上のサービスにコンテナから接続するには？
--------------------------------------------------

.. Mac has a changing IP address (or none if you have no network access). We recommend that you attach an unused IP to the lo0 interface on the Mac so that containers can connect to this address.

Mac は変動 IP アドレスを持ちます（あるいは、ネットワーク接続がなければ存在しません）。私たちが推奨するのは IP を使わず、Mac 上の :code:`lo0` インターフェースを使い、コンテナはこのアドレスで接続します。

.. For more information and examples, see I want to connect from a container to a service on the host in the Networking topic.

Docker Desktop for Mac のネットワーク機能についての情報は :doc:`ネットワーク機能 <networking>` の :ref:`mac-i-want-to-connect-from-a-container-to-a-service-on-the-host` を御覧ください。

.. How do I connect to a container from Mac?

.. _mac-how-do-i-connect-to-a-container-from-mac

Mac からコンテナに接続するには？
--------------------------------------------------

.. We recommend that you publish a port, or connect from another container. You can use the same method on Linux if the container is on an overlay network and not a bridge network, as these are not routed.

私たちが推奨するのはポートの公開か、他のコンテナからの接続です。コンテナがオーバレイ・ネットワークを使う場合は、Linux と同じような手法が使えますが、ブリッジ・ネットワークの場合は経路付け（ルーティング）されず使えません。

.. For more information and examples, see I want to connect to a container from the Mac in the Networking topic.

詳細な情報と例はは :doc:`ネットワーク機能 <networking>` の :ref:`i-want-to-connect-to-a-container-from-the-mac` を御覧ください。

.. Can I use an SSH agent inside a container?

.. _mac-can-i-use-an-ssh-agent-inside-a-container:
コンテナ内で SSH エージェントを使えますか？
--------------------------------------------------

.. Yes, you can use the host’s SSH agent inside a container. For more information, see SSH agent forwarding.

はい、ホスト側の SSH エージェントをコンテナ内でも利用できます。詳しい情報は、 :ref:`osxfs-ssh-agent-forwarding` をご覧ください。

.. How do I add custom CA certificates?

.. _mac-how-do-i-add-custom-ca-certificates:
どのようにしてカスタム CA 証明書を追加しますか？
--------------------------------------------------

.. Docker Desktop supports all trusted certificate authorities (CAs) (root or intermediate). For more information on adding server and client side certs, see Add TLS certificates in the Getting Started topic.

Docker Desktop は全ての信頼された認証局（root または中間）をサポートしています。サーバとクライアント側それぞれの証明書を追加するための情報は、導入ガイドの :ref:`mac-add-tls-certificates` トピックをご覧ください。

.. How do I add client certificates?

.. _mac-how do i add client certificates:
どのようにしてクライアント証明書を追加しますか？
--------------------------------------------------

.. For information on adding client certificates, see Add client certificates in the Getting Started topic.

クライアント証明書を追加するための情報は、導入ガイドの :ref:`mac-add-client-certificates` トピックをご覧ください。

.. Can I pass through a USB device to a container?

.. _mac-can-i-pass-through-a-usb-device-to-a-container:

USB デバイスをコンテナにパススルーできますか？
--------------------------------------------------

.. Unfortunately, it is not possible to pass through a USB device (or a serial port) to a container as it requires support at the hypervisor level.

残念ながら、USB デバイス（あるいはシリアルポート）はコンテナへのパススルーができません。これはハイパーバイザ・レベルのサポートを必要とするからです。

.. Can I run Docker Desktop in nested virtualization scenarios?

.. _mac-can-i-run-docker-desktop-in-nested-virtualization-scenarios:

ネスト化した仮想化シナリオで Docker Desktop を動かせられますか？
----------------------------------------------------------------------

.. Docker Desktop can run inside a Windows 10 VM running on apps like Parallels or VMware Fusion on a Mac provided that the VM is properly configured. However, problems and intermittent failures may still occur due to the way these apps virtualize the hardware. For these reasons, Docker Desktop is not supported in nested virtualization scenarios. It might work in some cases, and not in others. For more information, see Running Docker Desktop in nested virtualization scenarios.

Paralles や VMware Fusion on a Mac が提供する Windows 10 仮想マシン内で、仮想マシンを適切に設定していれば Docker Desktop は実行可能です。しかしながら、ハードウェアを仮想化したアプリケーションを使うため、問題や断続的な停止が発生する可能性があります。これらの理由により、 **ネスト化した仮想化シナリオで Docker Desktop はサポート対象外です** 。詳しい情報は、 :ref:`running-docker-desktop-in-nested-virtualization-scenarios` をご覧ください。

.. Components of Docker Desktop

.. _mac-components-of-docker-desktop:

Docker Desktop のコンポーネント
==================================================

.. What is HyperKit?

.. _what-is-hyperkit:

HyperKit とは何ですか？
--------------------------------------------------

.. HyperKit is a hypervisor built on top of the Hypervisor.framework in macOS. It runs entirely in userspace and has no other dependencies.

HyperKit はmacOS の Hypervisor.framerowk 上に構築されたハイパーバイザです。これは他の依存関係なく、ユーザ空間全体を実行できます。

.. We use HyperKit to eliminate the need for other VM products, such as Oracle VirtualBox or VMWare Fusion.

私たちが HyperKit を採用するのは、 Oracle VirtualBox や VMWare Fusion のような他の仮想マシンプロダクトの必要性を無くすためです。

.. What is the benefit of HyperKit?

.. _mac-what-is-the-benefit-of-hyperkit:

HyperKit の利点は何ですか？
--------------------------------------------------

.. HyperKit is thinner than VirtualBox and VMWare fusion, and the version we include is customized for Docker workloads on Mac.

HyperKit は VirtualBox や VMware fusion よりも薄く、Mac 上で Docker ワークロード向けにカスタマイズしたバージョンだからです。

.. Why is com.docker.vmnetd running after I quit the app?

.. _mac--why-is-com.docker.vmnetd-running-after-i-quit-the-app:

アプリ終了後、どうして com.docker.vmnetd が動くのですか？
------------------------------------------------------------

.. The privileged helper process com.docker.vmnetd is started by launchd and runs in the background. The process does not consume any resources unless Docker.app connects to it, so it’s safe to ignore.

特権ヘルパー・プロセス :code:`com.docker.vmnetd`  は :code:`launched` によって開始され、バックグラウンドで動作します。このプロセスは Docker.app が接続していなければリソースを消費しないため、無視しても構いません。


.. Feedback

.. _mac-faq-feedback:

フィードバック
==================================================

.. What kind of feedback are we looking for?

.. _mac-what kind of feedback are we looking for:

どのような種類のフィードバックが求められていますか？
------------------------------------------------------------

.. Everything is fair game. We’d like your impressions on the download-install process, startup, functionality available, the GUI, usefulness of the app, command line integration, and so on. Tell us about problems, what you like, or functionality you’d like to see added.

全てが対象です。私たちはダウンロード、インストール手順、起動、利用可能な機能、GUI、アプリケーションの使いやすさ、コマンドライン統合、などなど、皆さんの所感を求めています。問題があれば、何をしたいのか、どのような機能が欲しいのかを教えてください。

.. What if I have problems or questions?

.. _mac-what if i have problems or questions:

問題や質問がある場合は、どうしたら良いでしょうか？
--------------------------------------------------

.. You can find information about diagnosing and troubleshooting common issues in the Logs and Troubleshooting topic.

診断やトラブルシューティングに関する共通課題の情報は、 :doc:`troubleshoot` の記事にあります。

.. If you do not find a solution in Troubleshooting, browse issues on Docker Desktop for Mac issues on GitHub or create a new one. You can also create new issues based on diagnostics. To learn more, see Diagnose problems, send feedback, and create GitHub issues.

トラブルシューティングで解決策が見つからなければ、 `GitHub の Docker Desktop for Mac の issue <https://github.com/docker/for-mac/issues>`_ を見るか、新しい issue を作成してください。また、診断結果に基づいて新しい issue の作成もできます。詳細を学ぶには :ref:`mac-diagnose-problems-send-feedback-and-create-github-issues` を御覧ください。

.. The Docker Desktop for Mac forum provides discussion threads as well, and you can create discussion topics there, but we recommend using the GitHub issues over the forums for better tracking and response.

`Docker Desktop for Mac フォーラム <https://forums.docker.com/c/docker-for-windows>`_ には議論のスレッドがあります。そちらでも議論のトピックを作成できますが、私たちが推奨するのはフォーラムではなく GitHub issue を使う方が、追跡可能かつ反応も良いです。

.. How can I opt out of sending my usage data?

.. _mac-how can i opt out of sending my usage data:

私の利用統計データの送信を停止できますか？
--------------------------------------------------

.. If you do not want to send of usage data, use the Stable channel. For more information, see What is the difference between the Stable and Edge versions of Docker Desktop.

利用統計データの送信を行いたくなければ、 Stable チャンネルを御利用ください。詳しい情報については、 :ref:`mac-what-is-the-difference-between-the-stable-and-edge-versions-of-docker-desktop` を御覧ください。

.. How is personal data handled in Docker Desktop?

.. _mac-how is personal data handled in docker desktop:

Docker Desktop での個人データの取り扱いはどのようになっていますか？
----------------------------------------------------------------------

.. When uploading diagnostics to help Docker with investigating issues, the uploaded diagnostics bundle may contain personal data such as usernames and IP addresses. The diagnostics bundles are only accessible to Docker, Inc. employees who are directly involved in diagnosing Docker Desktop issues.

アップロードされた診断情報は、Docker の問題調査に役立ちますが、ユーザ名や IP アドレスなど個人情報がアップロードされる診断データに含まれる場合があります。診断データにアクセス可能なのは、Docker Desktop の問題を直接解析する Docker, Inc. の従業員のみです。

.. By default Docker, Inc. will delete uploaded diagnostics bundles after 30 days unless they are referenced in an open issue on the docker/for-mac or docker/for-win issue trackers. If an issue is closed, Docker, Inc. will remove the referenced diagnostics bundles within 30 days. You may also request the removal of a diagnostics bundle by either specifying the diagnostics ID or via your GitHub ID (if the diagnostics ID is mentioned in a GitHub issue). Docker, Inc. will only use the data in the diagnostics bundle to investigate specific user issues, but may derive high-level (non personal) metrics such as the rate of issues from it.

`docker/for-mac <https://github.com/docker/for-mac/issues>`_ や  `docker/for-win <https://github.com/docker/for-win/issues>`_ の issue トラッカーで、オープンになっていても参照の必要がなければ、Docker, Inc. はアップロードされた診断情報を通常 30 日で削除します。もし issue がクローズされれば、Docker, Inc. は参照された診断情報を 30 日以内に削除します。また、診断 ID かGitHub ID（診断 ID が GitHub issue で使われている場合は）のどちらかで、診断情報の削除要求が可能です。 Docker, Inc. は診断情報のデータを、特定のユーザに対する調査にのみ用いますが、そこから発生する頻度などハイレベル（個人に依存しない）なメトリクスを得る場合もあります。


.. seealso:: 

   Frequently asked questions (FAQ)
      https://docs.docker.com/docker-for-mac/faqs/
