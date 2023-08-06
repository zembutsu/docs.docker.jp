.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/desktop/install/fedora/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/desktop/install/fedora.md
.. check date: 2022/09/19
.. Commits on Sep 18, 2022 ee7765c75238c8b9b5b2116374d55d29819afb20
.. -----------------------------------------------------------------------------

.. |whale| image:: ./images/whale-x.png
      :scale: 50%

.. Install Docker Desktop on Fedora
.. _install-docker-desktop-on-fedora:

=======================================
Fedora に Docker Desktop をインストール
=======================================

.. sidebar:: 目次

   .. contents::
       :depth: 3
       :local:

.. This page contains information on how to install, launch, and upgrade Docker Desktop on a Fedora distribution.

このページは、 Fedora ディストリビューションに Docker Desktop をインストール、起動、更新する仕方の情報を含みます。

.. Prerequisites
.. _desktop-fedora-prerequisites:

動作条件
==========

.. To install Docker Desktop successfully, you must:

Docker Desktop を正しくインストールするには、以下が必須です。

..  Meet the system requirements.
    Have a 64-bit version of either Fedora 35 or Fedora 36.

* :ref:`システム要件 <desktop-linux-system-requirements>` に一致
* Fedora 35 か Fedora 36 の 64-bit バージョンを所有

.. Additionally, for a Gnome Desktop environment you must install AppIndicator and KStatusNotifierItem Gnome extensions.

加えて Gnome Desktop 環境では、 `Gnome 拡張 <https://extensions.gnome.org/extension/615/appindicator-support/>`_ の AppIndicator と KStatusNotifierItem のインストールが必要です。

.. For non-Gnome Desktop environments, gnome-terminal must be installed:

Gnome Desktop 環境でない場合、 ``gnome-terminal`` のインストールが必要です：

.. code-block:: bash

   $ sudo dnf install gnome-terminal

.. Install Docker Desktop
.. _desktop-fedora-install-docker-desktop:

Docker Desktop のインストール
==============================

.. Recommended approach to install Docker Desktop on Debian:

Debian に Docker Desktop をインストールするため、推奨する手順：

..    Set up Docker’s package repository.
    Download latest RPM package.
    Install the package with dnf as follows:

1. :ref:`Docker のパッケージ リポジトリをセットアップ <fedora-set-up-the-repository>`
2. 最新の `RPM パッケージ <https://desktop.docker.com/linux/main/amd64/docker-desktop-4.22.0-x86_64.rpm>`_ をダウンロード
3. 以下のように dnf でパッケージをインストール：

.. code-block:: bash

   $ sudo dnf install ./docker-desktop-<version>-<arch>.rpm

.. There are a few post-install configuration steps done through the post-install script contained in the RPM package.

RPM パッケージ内に含まれる post-install スクリプトによって、いくつかの post-install 設定ステップが処理されます。

.. The post-install script:

post-install スクリプト：

..  Sets the capability on the Docker Desktop binary to map privileged ports and set resource limits.
    Adds a DNS name for Kubernetes to /etc/hosts.
    Creates a link from /usr/bin/docker to /usr/local/bin/com.docker.cli.

* Docker Desktop バイナリに対してケーパビリティを設定し、特権ポートの割り当てと、リソース制限を設定できるようにする
* Kubernetes 用の DNS 名を ``/etc/hosts`` に追加する
* ``/usr/bin/docker`` から ``/usr/local/bin/com.docker.cli`` にリンクを作成する

.. Launch Docker Desktop
.. _desktop-fedora-launch-docker-dekstop:

Docker Desktop の起動
==============================

.. To start Docker Desktop for Linux, search Docker Desktop on the Applications menu and open it. This launches the whale menu icon and opens the Docker Dashboard, reporting the status of Docker Desktop.

Docker Desktop for Linux を開始するには、 **Applications** メニューから **Docker Desktop** を探して開きます。これはクジラのメニューアイコンを起動すると、 Docker Dashboard が開き、Docker Desktop の状態を報告します。

.. Alternatively, open a terminal and run:

あるいは、ターミナルを開き、次のように実行します：

.. code-block:: bash

   $ systemctl --user start docker-desktop

.. When Docker Desktop starts, it creates a dedicated context that the Docker CLI can use as a target and sets it as the current context in use. This is to avoid a clash with a local Docker Engine that may be running on the Linux host and using the default context. On shutdown, Docker Desktop resets the current context to the previous one.

Docker Desktop を起動すると、専用の :doc:`コンテクスト </engine/context/working-with-contexts>` を作成し、これを Docker CLI の操作対象となるよう、現在使用するコンテクストとして設定します。これは、デフォルトのコンテクストとして使われている、 Linux ホスト上の Docker Engine がクラッシュするのを避けるためです。Docker Desktop を終了すると、以前のコンテクストを現在の設定に戻します。

.. The Docker Desktop installer updates Docker Compose and the Docker CLI binaries on the host. It installs Docker Compose V2 and gives users the choice to link it as docker-compose from the Settings panel. Docker Desktop installs the new Docker CLI binary that includes cloud-integration capabilities in /usr/local/bin and creates a symlink to the classic Docker CLI at /usr/local/bin/com.docker.cli.

Docker Desktop インストーラは、ホスト上の Docker Compose と Docker CLI バイナリを更新します。Docker Compose V2 がインストールされますが、ユーザは設定パネルから docker-compose としてリンクするかどうかを選べます。Docker Desktop は新しい Docker CLI バイナリをインストールします。これはクラウド統合機能を含んでおり、 ``/usr/local/bin`` にインストールし、 古い Docker CLI は``/usr/local/bin/com.docker.cli`` にシンボリックリンクを作成します。

.. After you’ve successfully installed Docker Desktop, you can check the versions of these binaries by running the following commands:

Docker Desktop のインストールに成功すると、以下のコマンドを実行し、各バイナリのバージョンを確認できます。

.. code-block:: bash

   $ docker compose version
   Docker Compose version v2.5.0
   
   $ docker --version
   Docker version 20.10.14, build a224086349
   
   $ docker version
   Client: Docker Engine - Community
   Cloud integration: 1.0.24
   Version:           20.10.14
   API version:       1.41
   ...

.. To enable Docker Desktop to start on login, from the Docker menu, select Settings > General > Start Docker Desktop when you log in.

ログイン時に Docker Desktop を起動するよう設定するには、Docker メニューから、 **Settings > General > Start Docker Desktop when you log in** を選びます。

.. Alternatively, open a terminal and run:

あるいは、ターミナルを開き、次のように実行します。

.. code-block:: bash

   $ systemctl --user enable docker-desktop

.. To stop Docker Desktop, click on the whale menu tray icon to open the Docker menu and select Quit Docker Desktop.

Docker Desktop を停止するには、トレイアイコンのクジラメニューをクリックし、Docker メニューを開き **Quit Docker Desktop** を選びます。

.. Alternatively, open a terminal and run:

あるいは、ターミナルを開き、次のように実行します。

.. code-block:: bash

   $ systemctl --user stop docker-desktop

.. Upgrade Docker Desktop
.. _desktop-fedora-upgrade-docker-desktop:

Docker Desktop の更新
==============================

.. Once a new version for Docker Desktop is released, the Docker UI shows a notification. You need to first remove the previous version and then download the new package each time you want to upgrade Docker Desktop. Run:

新しいバージョンの Docker Desktop がリリースされると、 Docker UI は通知を表示します。Docker Desktop を更新したい場合は、まず古いバージョンを削除し、それから都度新しいパッケージをダウンロードします。次のように実行します。

.. code-block:: bash

   $ sudo dnf remove docker-desktop
   $ sudo dnf install ./docker-desktop-<version>-<arch>.rpm

.. Uninstall Docker Desktop
.. _desktop-fedora-uninstall-docker-desktop:

Docker Desktop のアンインストール
========================================

.. To remove Docker Desktop for Linux, run:

Docker Desktop for Linux を削除するには、次のように実行します。

.. code-block:: bash

   $ sudo dnf remove docker-desktop

.. For a complete cleanup, remove configuration and data files at $HOME/.docker/desktop, the symlink at /usr/local/bin/com.docker.cli, and purge the remaining systemd service files.

完全に削除するには、 ``$HOME/.docker/desktop`` にある設定ファイルとデータを削除し、 ``/usr/local/bin/com.docker.cli`` を削除し、残っている systemd サービスファイルを削除します。

.. code-block:: bash

   $ rm -r $HOME/.docker/desktop
   $ sudo rm /usr/local/bin/com.docker.cli

.. Remove the credsStore and currentContext properties from $HOME/.docker/config.json. Additionally, you must delete any edited configuration files manually.

``$HOME/.docker/config.json`` から ``credsStore`` と ``currentContext`` プロパティを削除します。加えて、変更を加えた設定ファイルは、手動で削除する必要があります。

.. Next steps

次のステップ
====================

.. Take a look at the Get started training modules to learn how to build an image and run it as a containerized application.
    Review the topics in Develop with Docker to learn how to build new applications using Docker.

* イメージの構築方法やコンテナ化したアプリケーションを実行する方法を学ぶには、 :doc:`Get Started </get-started/index>` をご覧ください。
* Docker を使って新しいアプリケーションを構築する方法を学ぶには、 :doc:`/develop/index` にあるトピックをご覧ください。


.. seealso::

   Install Docker Desktop on Fedora
      https://docs.docker.com/desktop/install/fedora/

