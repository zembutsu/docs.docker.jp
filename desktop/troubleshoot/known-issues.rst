.. H-*- coding: utf-8 -*-
.. URL: https://docs.docker.com/desktop/troubleshoot/known-issues/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/desktop/troubleshoot/known-issues.md
.. check date: 2022/09/17
.. Commits on Jul 25, 2022 81fb76d3f408c8ea6c0ccdbd2ffb58bf37c8570b
.. -----------------------------------------------------------------------------

.. |whale| image:: /desktop/install/images/whale-x.png
      :width: 50%

.. Known issues for Docker Desktop on Mac
.. _desktop-known-issues-for-docker-desktop-on-mac:

==================================================
Mac 版 Docker Desktop で既に分かっている問題
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:


.. The following issues are seen when using the virtualization.framework experimental feature:
    Some VPN clients can prevent the VM running Docker from communicating with the host, preventing Docker Desktop starting correctly. See docker/for-mac#5208.
    This is an interaction between vmnet.framework (as used by virtualization.framework) and the VPN clients.
    Some container disk I/O is much slower than expected. See docker/for-mac#5389. Disk flushes are particularly slow due to the need to guarantee data is written to stable storage on the host. We have also observed specific performance problems when using the virtualization.framework on Intel chips on MacOS Monterey.
    This is an artifact of the new virtualization.framework.
    The Linux Kernel may occasionally crash. Docker now detects this problem and pops up an error dialog offering the user the ability to quickly restart Linux.
    We are still gathering data and testing alternate kernel versions.

* ``virtualization.framework`` 実験的機能を使用時、以下の問題が見受けられます。

  * いくつかの VPN クライアントは、ホスト上から VM で動作している Docker への通信を阻止できるため、 Docker Desktop を正しい起動を妨げます。 `docker/for-mac#5208 <https://github.com/docker/for-mac/issues/5208>`_ をご覧ください。

    これは ``vmnet.framework`` （ ``virtualization.fremework`` によって使われます）と VPN クライアント間の相互干渉によるものです。

  * いくつかのコンテナのディスク I/O が予想よりも遅くなります。 `docker/for-mac#5389 <https://github.com/docker/for-mac/issues/5389>`_ をご覧ください。特にディスクの :ruby:`フラッシュ <flush>` は遅くなります。これは、ホスト上の安定したストレージ上に、データを確実に書き込む必要があるためです。他にも分かっているのは、 Intel チップ上の MacOS Monterery で ``virtualization.fremework`` 利用時に、パフォーマンス上の問題があります。

    これは新しい ``virtualization.fremework`` 技術による副作用です。


  * Linux Kernel が時々クラッシュする可能性があります。Docker は現在この問題を検出でき、利用者に対して素早く Linux を再起動できるようにエラーダイアログ画面をポップアップします。

    現在もデータを収集中であり、代替 kernel のバージョンを試験中です。

..    IPv6 is not (yet) supported on Docker Desktop.

* IPv6 は（まだ） Docker Desktop 上ではサポートされていません。

.. On Apple silicon in native arm64 containers, older versions of libssl such as debian:buster, ubuntu:20.04, and centos:8 will segfault when connected to some TLS servers, for example, curl https://dl.yarnpkg.com. The bug is fixed in newer versions of libssl in debian:bullseye, ubuntu:21.04, and fedora:35.

* Apple silicon 上のネイティブな ``arm64`` コンテナで、 ``debian:buster`` や ``ubuntu:20.04``や ``centos:8`` のように、 ``libssl`` の古いバージョンを使っている場合は、 ``curl https://dl.yarnpkg.com`` のように、いくつかのTLS サーバへの接続を試みるとセグメンテーション違反になります。このバグは、 ``debian:bullseye`` ・ ``ubuntu:21.04`` ・ ``fedora:35`` に含まれる ``libssl`` の新しいバージョンで修正済みです。

..    You might encounter errors when using docker-compose up with Docker Desktop (ValueError: Extra Data). We’ve identified this is likely related to data and/or events being passed all at once rather than one by one, so sometimes the data comes back as 2+ objects concatenated and causes an error.

* Docker Desktop で :code:`docker-compose up`  の実行時にエラーが出るかもしれません（  :code:`ValueError: Extra Data` ）。この現象が発生するのは、関連するデータのイベントが１つ１つ処理されるのではなく、一度にすべて処理されるためです。そのため、２つ以上のオブジェクトが連続して戻るようなデータがあれば、まれにエラーを引き起こします。

..    Force-ejecting the .dmg after running Docker.app from it can cause the whale icon to become unresponsive, Docker tasks to show as not responding in the Activity Monitor, and for some processes to consume a large amount of CPU resources. Reboot and restart Docker to resolve these issues.

* :code:`Docker.app` の実行後、 :code:`.dmg` を強制イジェクトすると、鯨のアイコンが反応しなくなります。また、アクティビティモニタでは、いくつかのプロセスが CPU リソースの大部分を消費してしまい、Docker が無反応なように見えます。この問題を解決するには、リブートして Docker を再起動します。

.. Docker does not auto-start on login even when it is enabled in Preferences. This is related to a set of issues with Docker helper, registration, and versioning.

* Docker を **Preferences** でログイン時に自動起動を設定しても、有効にならない場合があります。これは Docker ヘルパー、登録、バージョンに関連する一連の問題です。

..    Docker Desktop uses the HyperKit hypervisor (https://github.com/docker/hyperkit) in macOS 10.10 Yosemite and higher. If you are developing with tools that have conflicts with HyperKit, such as Intel Hardware Accelerated Execution Manager (HAXM), the current workaround is not to run them at the same time. You can pause HyperKit by quitting Docker Desktop temporarily while you work with HAXM. This allows you to continue work with the other tools and prevent HyperKit from interfering.

* macOS 10.10 Yosemite 以降では、Docker Desktop は :code:`HyperKit` ハイパーバイザ（ https://github.com/docker/hyperkit ）を使います。`Intel Hardware Accelerated Execution Manager (HAXM) <https://software.intel.com/en-us/android/articles/intel-hardware-accelerated-execution-manager/>`_ のような :code:`HyperKit` と競合するようなツールで開発を行っている場合、同時に両者を実行するための回避策は、現時点ではありません。一時的に Docker Desktop を終了して :code:`HyperKit` を停止すると、 HAXM を利用できます。これにより :code:`HyperKit` による干渉を防ぎながら、他のツールも利用し続けることができます。

..    If you are working with applications like Apache Maven that expect settings for DOCKER_HOST and DOCKER_CERT_PATH environment variables, specify these to connect to Docker instances through Unix sockets. For example:

* `Apache Maven <https://maven.apache.org/>`_ のようなアプリケーションを使っている場合に、 :code:`DOCKER_HOST ` と :code:`DOCKER_CERT_PATH` 環境変数をそれぞれ設定し、Docker に対して Unix ソケットを通して接続するように設定を試みる場合があります。その場合は、次のようにします。

.. code-block:: bash

    export DOCKER_HOST=unix:///var/run/docker.sock

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
   この挙動を回避するには、ベンダーまたはサードパーティ ライブラリ Docker ボリュームの中に入れ、 `osxfs` マウントの外で一時的にファイルシステム処理を行うようにします。そして、 Unison や :code:`rsync` のようなサードパーティ製ツールを使い、コンテナのディレクトリとバインド マウントしたディレクトリ間を同期します。私たちは数々の技術を用いながら性能改善にアクティブに取り組んでいます。詳細を学ぶには、 `ロードマップ上のトピック <https://github.com/docker/roadmap/issues/7>`_ をご覧ください。


.. seealso::

   Known issues for Docker Desktop on Mac
      https://docs.docker.com/desktop/troubleshoot/known-issues/

