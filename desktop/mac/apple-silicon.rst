.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/desktop/mac/apple-silicon/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/desktop/mac/apple-silicon.md
.. check date: 2022/09/10
.. Commits on Aug 23, 2022 db5bbf624039bbd369765600fc07f0e071c0a282
.. -----------------------------------------------------------------------------

.. Docker Desktop for Apple silicon
.. _docker-desktop-for-apple-silicon:
==================================================
Apple silicon 対応 Docker Desktop
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Docker Desktop for Mac on Apple silicon is now available as a GA release. This enables you to develop applications with your choice of local development environments, and extends development pipelines for ARM-based applications.

Apple silicon に対応した Docker Desktop for Mac が、一般提供開始リリースとして利用可能です。これで、ローカル開発環境としてアプリケーションを開発できるようになります。また、ARM をベースとしたアプリケーション向けの開発パイプラインも拡張できます。

.. Docker Desktop for Apple silicon also supports multi-platform images, which allows you to build and run images for both x86 and ARM architectures without having to set up a complex cross-compilation development environment. Additionally, you can use docker buildx to seamlessly integrate multi-platform builds into your build pipeline, and use Docker Hub to identify and share repositories that provide multi-platform images.

Apple silicon 用 Docker Desktop for Mac は、 :ruby:`マルチプラットフォーム <multi-platform>` イメージもサポートしています。これがあれば、複雑なクロスコンパイル開発環境を準備しなくても、x86 と ARM アーキテクチャの両方に対応するイメージの構築と実行をできるようにします。さらに、:doc:`docker buildx </engine/reference/commandline/buildx>` を使えば、 :ruby:`構築パイプライン <build pipeline>` にマルチプラットフォーム ビルドをシームレスに（途切れなく）統合できるようになります。そして、 `Docker Hub <https://hub.docker.com/>`_ で認証し、マルチプラットフォーム イメージを提供するリポジトリで共有します。

.. Download Docker Desktop for Mac on Apple silicon:

Apple silicon 対応 Docker Desktop をダウンロードします。

..    Download Docker Desktop
..    Mac with Apple chip

.. note::

   **Docker Desktop のダウンロード**
   
   * `Apple チップ用 Mac <https://desktop.docker.com/mac/main/arm64/Docker.dmg>`_

.. System requirements
.. _silicon-system-requirements:
システム要件
--------------------

.. Beginning with Docker Desktop 4.3.0, we have removed the hard requirement to install Rosetta 2. There are a few optional command line tools that still require Rosetta 2 when using Darwin/AMD64. See the Known issues section below. However, to get the best experience, we recommend that you install Rosetta 2. To install Rosetta 2 manually from the command line, run the following command:

Docker Desktop 4.3.0 から、ハードウェア要件から **Rosetta 2** のインストールを削除しました。Darwin/AMD64 を使う場合は、 オプションのコマンドラインツールとして Roseta 2 が必要です。以下にある既知の問題のセクションをご覧ください。一方で、最高の体験を得るには、Rosetta 2 のインストールを推奨します。Rosetta 2 を手動でインストールするには、以下のコマンドを実行します。

.. code-block:: bash

   $ softwareupdate --install-rosetta

.. Known issues
.. _silicon-known-issues:
既知の問題
--------------------

.. Some command line tools do not work when Rosetta 2 is not installed.
    The old version 1.x of docker-compose. We recommend that you use Compose V2 instead. Either type docker compose or enable the Use Docker Compose V2 option in the General preferences tab.
    The docker scan command and the underlying snyk binary.
    The docker-credential-ecr-login credential helper.

* Rosetta 2 をインストールしなければ、コマンドラインツールのいくつかが動作しません。

  * ``docker-compose`` の古いバージョン 1.x 。代わりに Compose V2 のインストールを推奨します。 ``docker compose`` を入力するか、 :ref:`設定の General タブ <mac-general>` にある **Use Docker Compose V2** オプションを有効にします。
  * ``docker scan`` コマンドと、 :ruby:`基礎を成す <underlying>` ``snyk`` バイナリ。
  * ``docker-credential-ecr-login`` :ruby:`認証情報ヘルパー <credential helper>`


.. Not all images are available for ARM64 architecture. You can add --platform linux/amd64 to run an Intel image under emulation. In particular, the mysql image is not available for ARM64. You can work around this issue by using a mariadb image.

.. * ARM64 アーキテクチャのイメージすべてが利用可能ではありません。 ``--platform linux/amd64`` の追加は、Intel イメージをエミュレーション下で実行できるようにします。ですが、特例として ARM64 用の `mysql <https://hub.docker.com/_/mysql?tab=tags&page=1&ordering=last_updated>`_ イメージは利用できません。この問題に対応するには `mariadb イメージ <https://hub.docker.com/_/mariadb?tab=tags&page=1&ordering=last_updated>`_ を使います。

.. Some images do not support the ARM64 architecture. You can add `--platform linux/amd64` to run (or build) an Intel image using emulation.

* イメージのいくつかは ARM64 アーキテクチャをサポートしていません。 Intel イメージでエミュレーションを使うには、実行時（または構築時）に ``--platform linux/amd64`` を追加できます。


  .. However, attempts to run Intel-based containers on Apple silicon machines under emulation can crash as qemu sometimes fails to run the container. In addition, filesystem change notification APIs (inotify) do not work under qemu emulation. Even when the containers do run correctly under emulation, they will be slower and use more memory than the native equivalent.

  一方、エミュレーション下の Applie silicon マシン上で、 Intel ベースのコンテナを実行しようとすると、コンテナの実行時に、時々 qemu が落ちてクラッシュを引き起こします。さらに、 qemu エミュレーション下では、ファイルシステム変更通知 API （ ``inotify`` ）が動作しません。エミュレーション下でコンテナを正しく動作させようとしても、本来の状況と比べて遅くなり、より多くのメモリを使います。

  .. In summary, running Intel-based containers on Arm-based machines should be regarded as “best effort” only. We recommend running arm64 containers on Apple silicon machines whenever possible, and encouraging container authors to produce arm64, or multi-arch, versions of their containers. We expect this issue to become less common over time, as more and more images are rebuilt supporting multiple architectures.

  まとめると、Arm ベースのマシン上で Intel ベースのコンテナの実行とは、「ベストエフォート」のみと見なすべきです。 Apple silicon マシン上では、可能な限り arm64 コンテナの実行を推奨します。また、コンテナの作者に対しては、arm64 やマルチアーキテクチャに対応したコンテナのバージョンの作成を推奨しています。時間が経てば `マルチアーキテクチャをサポートする <https://www.docker.com/blog/multi-arch-build-and-images-the-simple-way/>`_ イメージの再構築が増えていき、この問題は減っていくと考えています。

.. ping from inside a container to the Internet does not work as expected. To test the network, we recommend using curl or wget. See docker/for-mac#5322.

* コンテナ内からインターネットに対する ``ping`` が期待通りに動作しません。ネットワークの確認には、 ``curl`` や ``wget`` の利用を推奨します。 `docker/for-mac#5322 <https://github.com/docker/for-mac/issues/5322#issuecomment-809392861>`_ をご覧ください。

.. Users may occasionally experience data drop when a TCP stream is half-closed.

* TCP 通信が half-closed の場合、時々データ欠損が発生する場合があります。

.. Fixes since Docker Desktop RC 3
.. _fixes-since-docker-desktop-rc-3:
Docker Desktop RC 3 までの修正
----------------------------------------

..  Docker Desktop now ensures the permissions of /dev/null and other devices are correctly set to 0666 (rw-rw-rw-) inside --privileged containers. Fixes docker/for-mac#5527.
    Docker Desktop now reduces the idle CPU consumption.

* Docker Desktop は今後 ``/dev/null`` のパーミッションを確保するようになり、 ``--privileged`` コンテナ内では他のデバイスが正しく ``0666``  （ ``rw-rw-rw-`` ） に設定されます。 `docker/for-mac#5527 <https://github.com/docker/for-mac/issues/5527>`_ の修正です。
* Docker Desktop は今後アイドル CPU 消費を減らします。

.. Fixes since Docker Desktop RC 2
.. _fixes-since-docker-desktop-rc-2:
Docker Desktop RC 2 までの修正
----------------------------------------

..    Update to Linux kernel 5.10.25 to improve reliability.

* 安定性を向上するため `Linux kernel 5.10.25 <https://hub.docker.com/layers/docker/for-desktop-kernel/5.10.25-6594e668feec68f102a58011bb42bd5dc07a7a9b/images/sha256-80e22cd9c9e6a188a785d0e23b4cefae76595abe1e4a535449627c2794b10871?context=repo>`_ にアップデートします。

.. Fixes since Docker Desktop RC 1
.. _fixes-since-docker-desktop-rc-1:
Docker Desktop RC 1 までの修正
----------------------------------------

..    Inter-container HTTP and HTTPS traffic is now routed correctly. Fixes docker/for-mac#5476.

* コンテナ間の HTTP と HTTPS 通信が、今後正しく経路付けされます。 `docker/for-mac#5476 <https://github.com/docker/for-mac/issues/5476>`_ の修正です。

.. Fixes since Docker Desktop preview 3.1.0
.. _fixes-since-docker-desktop-preview-3-1-0:
Docker Desktop preview 3.1.0 までの修正
----------------------------------------

..  The build should update automatically to future versions.
    HTTP proxy support is working, including support for domain name based no_proxy rules via TLS SNI. Fixes docker/for-mac#2732.

* 以降のバージョンでは、ビルドを自動的に更新できるようにします。
* HTTP プロキシのサポートが機能します。これには TLS SNI を経由した ``no_proxy`` ルールをベースとするドメイン名のサポートも含みます。 `docker/for-mac#2732 <https://github.com/docker/for-mac/issues/2732>`_ の修正です。

.. Fixes since the Apple Silicon preview 7
.. _Fixes-since-the-Apple-Silicon-preview-7:
Apple Silicon preview 7 までの修正
----------------------------------------

..  Kubernetes now works (although you might need to reset the cluster in our Troubleshoot menu one time to regenerate the certificates).
    osxfs file sharing works.
    The host.docker.internal and vm.docker.internal DNS entries now resolve.
    Removed hard-coded IP addresses: Docker Desktop now dynamically discovers the IP allocated by macOS.
    The updated version includes a change that should improve disk performance.
    The Restart option in the Docker menu works.

* Kubernetes が動作します（しかしながら、証明書を再作成するため、一度トラブルシュートのメニューからクラスタのリセットが必要になるでしょう）。
* osxfs ファイル共有が動作します。
* ``host.docker.internal`` と ``vm.docker.internal`` DNS エントリが名前解決できます。
* :ruby:`固定された <hard-coded>` IP アドレスを削除しました。今後 Docker Desktop は macOS によって割り当てられた IP を動的に発見します。
* 更新版に含まれる変更によって、ディスクのパフォーマンスが改善されるでしょう。
* Docker メニューの **Restart** オプションが動作します。


.. seealso:: 

   Docker Desktop for Apple silicon
      https://docs.docker.com/desktop/mac/apple-silicon/
