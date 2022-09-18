.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/docker-for-mac/faqs/general/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/desktop/faqs/general.md
.. check date: 2022/09/17
.. Commits on Sep 2, 2022 bde9629d685bb0137a052101044bd795616908dc
.. -----------------------------------------------------------------------------

.. Frequently asked questions
.. _desktop-frequently-asked-questions

==================================================
よくある質問と回答 [FAQ]
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

全般
==========

.. What are the system requirements for Docker Desktop?
.. _desktop-what-are-the-system-requirements-for-docker-desktop:

Docker Desktop のシステム動作条件は何ですか？
--------------------------------------------------

.. For information about Docker Desktop system requirements, see:

Docker Desktop のシステム要件に関する情報は、以下をご覧ください。

* :ref:`Mac システム動作条件 <mac-system-requirements>`
* :ref:`Windows システム動作条件 <win-system-requirements>`
* :ref:`Linux システム動作条件 <desktop-linux-system-requirements>`

.. Where does Docker Desktop get installed on my machine?
.. _desktop-where-does-docker-desktop-get-installed-on-my-machine:

Docker Desktop はマシン上のどこにインストールされますか？
------------------------------------------------------------

.. By default, Docker Desktop is installed at the following location:

デフォルトでは、 Docker Desktop は以下の場所にインストールされます：

..  On Mac: /Applications/Docker.app
    On Windows: C:\Program Files\Docker\Docker
    On Linux: /opt/docker-desktop

* Mac 版： ``/Applications/Docker.app``
* Windows 版： ``C:\Program Files\Docker\Docker``
* Linux 版： ``/opt/docker-desktop``

.. Where can I find the checksums for the download files?
.. _desktop-where-can-i-find-the-checksums-for-the-download-files:

ダウンロードするファイルのチェックサムはどこにありますか？
------------------------------------------------------------

.. You can find the checksums on the release notes page.

:doc:`リリースノート </desktop/release-notes>` のページ上にチェックサムがあります。

.. Do I need to pay to use Docker Desktop?
.. _desktop-do-i-need-to-pay-to-use-docker-desktop:

Docker Desktop の利用に支払が必要ですか？
------------------------------------------------------------

.. Docker Desktop is free for small businesses (fewer than 250 employees AND less than $10 million in annual revenue), personal use, education, and non-commercial open-source projects. Otherwise, it requires a paid subscription for professional use. Paid subscriptions are also required for government entities. When downloading and installing Docker Desktop, you are asked to agree to the Docker Subscription Service Agreement.

Docker Desktop は、 :ruby:`中小企業 <small businesses>` （従業員 250 人未満、かつ、年間売上高が 1,000 万米ドル未満）、個人利用、教育、非商用オープンソースプロジェクトは無料です。一方、プロフェッショナル利用ではサブスクリプションの支払が必要です。行政機関もサブスクリプションの支払が必要です。Docker Desktop のダウンロードとインストール時、 `Docker Subscription Service Agreement <https://www.docker.com/legal/docker-subscription-service-agreement>`_ への同意が求められます。

.. Read the Blog and FAQs to learn more.

詳しく知るには、 `ブログ <https://www.docker.com/blog/updating-product-subscriptions/>`_ と `FAQ <https://www.docker.com/pricing/faq>`_ をご覧ください。

.. Can I use Docker Desktop offline?
.. _desktop-can-i-use-docker-desktop-offline:

Docker Desktop をオフラインで使えますか？
------------------------------------------------------------

.. Yes, you can use Docker Desktop offline. However, you cannot access features that require an active internet connection. Additionally, any functionality that requires you to sign won’t work while using Docker Desktop offline or in air-gapped environments. This includes:

はい、 Docker Desktop をオフラインで使えます。しかし、アクティブなインターネット接続を必要とする機能は利用できません。さらに、 Docker Desktop をオフラインで使う場合や :ruby:`エアギャップ <air-gapped>` 環境で使う場合、署名を必要とする機能は動作しません。以下の項目が含まれます。

..  The in-app Quick Start Guide
    Pulling or pushing an image to Docker Hub
    Image Access Management
    Vulnerability scanning
    Viewing remote images in the Docker Dashboard
    Settting up Dev Environments
    Docker build when using Buildkit. You can work around this by disabling BuildKit. Run DOCKER_BUILDKIT=0 docker build . to disable BuildKit.
    Deploying an app to the cloud through Compose ACI and ECS integrations
    Kubernetes (Images are download when you enable Kubernetes for the first time)
    Check for updates
    In-app diagnostics (including the Self-diagnose tool)
    Tip of the week
    Sending usage statistics

* アプリ内の :ref:`クイックスタートガイド <desktop-quick-start-guide>`
* Docker Hub とのイメージ送受信
* :doc:`イメージのアクセス管理 </docker-hub/image-access-management>`
* :doc:`脆弱性検査 </docker-hub/vulnerability-scanning>`
* Docker ダッシュボード内でリモートにあるイメージの表示
* :doc:`Dev Environments </desktop/dev-environments>` のセットアップ
* :doc:`BuildKit </develop/develop-images/build_enhancements>` の使用時。BuildKit を無効化すると回避できる。BuildKit を無効化するには ``DOCKER_BUILDKIT=0 docker build .`` を実行
* Compose `ACI <https://docs.docker.com/cloud/aci-integration/>`_ と `ECS <https://docs.docker.com/cloud/ecs-integration/>`_ 統合を通す、クラウドへのアプリのデプロイ
* :doc:`Kubernetes </desktop/kubernetes>` （Kubernetes の初回実行時、イメージをダウンロードするため）
* アップデートの確認
* :ref:`アプリ内での診断 <desktop-diagnose-from-the-app>` （自己診断ツールを含む）
* 今週の Tip 表示
* 使用量統計の送信

.. Where can I find information about diagnosing and troubleshooting Docker Desktop issues?
.. _desktop-where-can-i-find-information-about-diagnosing-and-troubleshooting-docker-desktop-issues:

Docker Desktop の問題を診断したりトラブルシューティングする情報はどこにありますか？
------------------------------------------------------------------------------------------

.. You can find information about diagnosing and troubleshooting common issues in the Troubleshooting topic.

診断やトラブルシューティングに関する共通課題の情報は、 :doc:`トラブルシューティングの記事 </desktop/troubleshoot/overview>` にあります。

.. If you do not find a solution in troubleshooting, browse the Github repositories or create a new issue:

トラブルシューティングで解決策が見つからなければ、 GitHub リポジトリを探すか、新しい issue を作成してください：

..  docker/for-mac - - docker/for-win
    docker/for-linux

* `docker/for-mac <https://github.com/docker/for-mac/issues>`_
* `docker/for-win <https://github.com/docker/for-win/issues>`_
* `docker/for-linux <https://github.com/docker/for-linux/issues>`_


.. How do I connect to the remote Docker Engine API?
.. _desktop-how-do-i-connect-to-the-remote-docker-engine-api:

リモートの Docker Engine API に接続するには？
------------------------------------------------------------

.. To connect to the remote Engine API, you might need to provide the location of the Engine API for Docker clients and development tools.

リモート Engine API に接続するには、 Docker クライアントと開発ツールに対し Engine API の場所を指定する必要があります。

.. Mac and Windows WSL 2 users can connect to the Docker Engine through a Unix socket: unix:///var/run/docker.sock.

Mac と Windows WSL 2 ユーザは、 Unix ソケットを通して Docker Engine に接続できます： ``unix:///var/run/docker.sock``

.. If you are working with applications like Apache Maven that expect settings for DOCKER_HOST and DOCKER_CERT_PATH environment variables, specify these to connect to Docker instances through Unix sockets.


もしも `Apache Maven <https://maven.apache.org/>`_ のようなアプリケーションを動作中であれば、 :code:`DOCKER_HOST` と :code:`DOCKER_CERT_PATH` 環境変数の設定が必要です。特にこれらで Docker にアクセスするためには Unix ソケットの指定が必要です。

例：

.. code-block:: bash

   $ export DOCKER_HOST=unix:///var/run/docker.sock

.. Docker Desktop Windows users can connect to the Docker Engine through a named pipe: npipe:////./pipe/docker_engine, or TCP socket at this URL: tcp://localhost:2375.

Docker Desktop Windows ユーザが Docker Engine に対して接続するには、 **名前付きパイプ** ： ``npipe:////./pipe/docker_engine`` か、 ``tcp://localhost:2375`` の URL で示す **TCP ソケット** を通します。

.. For details, see Docker Engine API.

詳細は `Docker Engine API <https://docs.docker.com/engine/api/>`_ をご覧ください。

.. How do I connect from a container to a service on the host?
.. _desktop-how-do-i-connect-from-a-container-to-a-service-on-the-host:

ホスト上のサービスにコンテナから接続するには？
------------------------------------------------------------

.. Mac, Linux, and Windows have a changing IP address (or none if you have no network access). On both Mac and Windows, we recommend that you connect to the special DNS name host.docker.internal, which resolves to the internal IP address used by the host. This is for development purposes and does not work in a production environment outside of Docker Desktop.

Mac、Linux、Windows は変動する IP アドレスを持ちます（ネットワーク接続がない場合は、持ちません）。 Mac と Windows の両方で推奨するのは、特別な DNS 名 ``host.docker.internal`` を使った接続です。これは、ホストに依って使われる内部の IP アドレスに名前解決します。これは開発用途であり、 Docker Desktop の外のプロダクション環境では機能しません。

.. For more information and examples, see how to connect from a container to a service on the host.

詳しい情報や例については、 :ref:`desktop-networking-i-want-to-connect-from-a-container-to-a-service-on-the-host` をご覧ください。

.. Can I pass through a USB device to a container?
.. _desktop-can-i-pass-through-a-usb-device-to-a-container:

USB デバイスをコンテナにパススルーできますか？
--------------------------------------------------

.. Unfortunately, it is not possible to pass through a USB device (or a serial port) to a container as it requires support at the hypervisor level.

残念ながら、USB デバイス（あるいはシリアルポート）はコンテナへのパススルーができません。これはハイパーバイザ段階のサポートを必要とするからです。

.. Can I run Docker Desktop in nested virtualization scenarios?
.. _desktop-can-i-run-docker-desktop-in-nested-virtualization-scenarios:

ネスト化した仮想化シナリオで Docker Desktop を動かせられますか？
----------------------------------------------------------------------

.. In general, Docker recommends running Docker Desktop natively on either Mac, Linux, or Windows. However, Docker Desktop for Windows can run inside a virtual desktop provided the virtual desktop is properly configured. For more information, see Run Docker Desktop in a VM or VDI environment

一般的に、Mac、Linux、Windows 上のいずれにおいても Docker Desktop をネイティブに実行するのを Docker は推奨します。しかし、 適切に設定された仮想デスクトップであれば、提供される仮想デスクトップ内で Docker Desktop for Windows を実行可能です。より詳しい情報は :doc:`VM や VDI 環境で Docker Desktop for Window を実行 </desktop/vm-vdi>` をご覧ください。

.. Docker Desktop’s UI appears green, distorted, or has visual artifacts. How do I fix this?
.. _desktop-docker-desktops-ui-appears-green-distorted-or-has-visual-artifacts-how-do-i-fix-this:

Docker Desktop の UI が緑色になったり、ゆがんでいたり、視覚的な不具合があります。どうしたら直せますか？
------------------------------------------------------------------------------------------------------------------------

.. Docker Desktop uses hardware-accelerated graphics by default, which may cause problems for some GPUs. In such cases, Docker Desktop will launch successfully, but some screens may appear green, distorted, or have some visual artifacts.

Docker Desktop はデフォルトでハードウェア アクセラレーション グラフィクスを使うため、 GPU によっては問題が発生する可能性があります。そのような場合、 Docker Desktop の起動に成功しても、いくつかの画面が緑色で表示されたり、ゆがんだり、視覚的な不具合が発生します。

.. To work around this issue, disable hardware acceleration by creating a "disableHardwareAcceleration": true entry in Docker Desktop’s settings.json file. You can find this file at:

この問題を回避するには、ハードウェア アクセラレーションを無効化します。そのためには、 Docker Desktop の ``settings.json`` ファイル内に ``"disableHardwareAcceleration": true`` エントリを追加します。このファイルは、以下の場所にあります：

..  Mac: ~/Library/Group Containers/group.com.docker/settings.json
    Windows: C:\Users\[USERNAME]\AppData\Roaming\Docker\settings.json

* **Mac** ： ``~/Library/Group Containers/group.com.docker/settings.json``
* **Windows** ： ``C:\Users\[USERNAME]\AppData\Roaming\Docker\settings.json``

.. After updating the settings.json file, close and restart Docker Desktop to apply the changes.

``settings.json`` ファイルの更新後は、変更を反映するために Docker Desktop を閉じ、再起動します。


.. Can I run Docker Desktop on Virtualized hardware?
.. _desktop-can-i-run-docker-desktop-on-virtualized-hardware:

仮想ハードウェア上 Docker Desktop を実行できますか？
------------------------------------------------------------

.. No, currently this is unsupported and against terms of use.

いいえ、現時点ではサポート外であり、利用規約に反します。

.. Releases
.. _desktop-faq-releases:

リリース
==========

.. How do new users install Docker Desktop?
.. _desktop-how-do-new-users-install-docker-desktop:

新しいユーザに Docker Desktop をインストールするには？
------------------------------------------------------------

.. Each Docker Desktop release is also delivered as a full installer for new users. The same applies if you have skipped a version, although this doesn’t normally happen as updates are applied automatically.

Docker Engine の各リリースは、新規ユーザに対する完全なインストーラとしても提供されています。アップデートが自動的に適用されるため、通常はバージョンを飛ばそうとしてもできません。

.. How frequent will new releases be?
.. _desktop-how-frequent-will-new-releases-be:

新しいリリースまでの頻度はどのくらいですか？
--------------------------------------------------

.. New releases are available roughly monthly, unless there are critical fixes that need to be released sooner.

新しいリリースはおおよそ毎月ですが、深刻な問題に対応する必要があれば迅速にリリースされます。

.. How do I ensure that all users on my team are using the same version?
.. _desktop-how-do-i-ensure-that-all-users-on-my-team-are-using-the-same-version:

チーム内の全ユーザが同じバージョンを確実に使えるようにするには？
----------------------------------------------------------------------

.. Previously you had to manage this yourself. Now, it happens automatically as a side effect of all users being on the latest version.

以前は自分自身でバージョンを管理する必要がありました。いまは全てのユーザが最新バージョンを自動的に利用できるようになっています。

.. My colleague has got a new version but I haven’t got it yet.
.. _desktop-my-colleague-has-got-a-new-version-but-i-havent-got-it-yet:

同僚は新しいバージョンにしましたが、私はまだです
--------------------------------------------------

.. Sometimes we may roll out a new version gradually over a few days. Therefore, if you wait, it will turn up soon. Alternatively, you can select Check for Updates from the Docker menu to jump the queue and get the latest version immediately.

新しいバージョンの提供はを、数日かけて緩やかに行う場合があります。そのため、待っていれば、まもなく更新されます。あるいは、 Docker Desktop メニューから **Check for Updates** を選ぶと、キューを飛ばし、ただちに最新版を取得します。

.. Where can I find information about Stable and Edge releases?

Stable と Edge リリースに関する情報はどこにありますか？
------------------------------------------------------------

.. Starting with Docker Desktop 3.0.0, Stable and Edge releases are combined into a single, cumulative release stream for all users.

Docker Desktop 3.0.0 以降、 Stable と Edge リリースとは1つに統合され、全てのユーザ向けに、累積するリリースの流れになります。


.. seealso:: 

   Frequently asked questions
      https://docs.docker.com/desktop/faqs/general/
