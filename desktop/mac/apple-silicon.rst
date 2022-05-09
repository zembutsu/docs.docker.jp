.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/desktop/mac/apple-silicon/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/desktop/mac/apple-silicon.md
.. check date: 2022/05/10
.. Commits on Apr 13, 2022 ec5dc89d85debe81c04d5d84a10d881391c6824c
.. -----------------------------------------------------------------------------

.. Docker Desktop for Apple silicon
.. _docker-desktop-for-apple-silicon:
==================================================
Apple silicon 向け Docker Desktop
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



.. seealso:: 

   Docker Desktop for Apple silicon
      https://docs.docker.com/desktop/mac/apple-silicon/
