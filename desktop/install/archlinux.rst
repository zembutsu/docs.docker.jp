.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/desktop/install/archlinux/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/desktop/install/archlinux.md
.. check date: 2022/09/10
.. Commits on Aug 11, 2022 184fbf7a718a8b80531549e5aad7af2ba13b71ee
.. -----------------------------------------------------------------------------

.. |whale| image:: ./images/whale-x.png
      :scale: 50%

.. Install Docker Desktop on Arch-based distributions
.. _install-docker-desktop-on-arch-based-distributions:

======================================================================
Arch ベースのディストリビューションに Docker Desktop をインストール
======================================================================

.. sidebar:: 目次

   .. contents::
       :depth: 3
       :local:

.. This topic discusses installation of Docker Desktop from an Arch package that Docker provides in addition to the supported platforms. Docker has not tested or verified the installation.

このトピックでは、サポート対象のプラットフォームに加え、Docker が提供する `Arch パッケージ <https://desktop-stage.docker.com/linux/main/amd64/78459/docker-desktop-4.8.0-x86_64.pkg.tar.zst>`_ から Docker Desktop をインストールする方法を説明します。Docker はテストをしておらず、インストールも検証していません。

.. Prerequisites
.. _desktop-archlinux-prerequisites:

動作条件
==========

.. To install Docker Desktop successfully, you must meet the system requirements.

Docker Desktop を正しくインストールするには、 :ref:`システム要件 <desktop-linux-system-requirements>` に一致する必要があります。

.. Additionally, for non-Gnome Desktop environments, gnome-terminal must be installed:

さらに、Gnome Desktop 環境ではない場合、 ``gnome-terminal`` のインストールが必要です：

.. code-block:: bash

   $ sudo pacman -S gnome-terminal

.. Install Docker Desktop
.. _desktop-archlinux-install-docker-desktop:

Docker Desktop のインストール
==============================

..    Install client binaries. Docker does not have an Arch package repository. Binaries not included in the package must be installed manually before installing Docker Desktop.
    Install Docker client binary on Linux. On Arch-based distributions, users must install the Docker client binary. Static binaries for the Docker client are available for Linux (as docker).
    Download the Arch package from the release page.
    Install the package:

1. クライアントのバイナリをインストールします。Docker には Arch パッケージのリポジトリがありません。パッケージに含まれないバイナリは、 Docker Desktop をインストールする前に、手動でインストールする必要があります。
2. :doc:`Linux 用の Docker クライアントバイナリをインストールします <install-daemon-and-client-binaries-on-linux>` 。Arch ベースのディストリビューション上では、ユーザは Docker クライアントのバイナリをインストールする必要があります。Linux 用 Docker クライントの静的なバイナリが（ ``docker`` として）利用できます。
3. :doc:`リリース </desktop/release-notes>` ページから Arch パッケージをダウンロードします。
4. パッケージをインストールします。

.. code-block:: bash

   $ sudo pacman -U ./docker-desktop-<version>-<arch>.pkg.tar.zst


.. Launch Docker Desktop
.. _desktop-archlinux-launch-docker-dekstop:

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


.. Uninstall Docker Desktop
.. _desktop-archlinux-uninstall-docker-desktop:

Docker Desktop のアンインストール
========================================

.. To remove Docker Desktop for Linux, run:

Docker Desktop for Linux を削除するには、次のように実行します。

.. code-block:: bash

   $ sudo pacman -R docker-desktop

.. For a complete cleanup, remove configuration and data files at $HOME/.docker/desktop, the symlink at /usr/local/bin/com.docker.cli, and purge the remaining systemd service files.

完全に削除するには、 ``$HOME/.docker/desktop`` にある設定ファイルとデータを削除し、 ``/usr/local/bin/com.docker.cli`` を削除し、残っている systemd サービスファイルを削除します。

.. code-block:: bash

   $ rm -r $HOME/.docker/desktop
   $ sudo rm /usr/local/bin/com.docker.cli
   $ sudo pacman -Rns docker-desktop

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

   Install Docker Desktop on Arch-based distributions
      https://docs.docker.com/desktop/install/archlinux/

