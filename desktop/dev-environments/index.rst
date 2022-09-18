.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/desktop/dev-environments/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/desktop/dev-environments/index.md
.. check date: 2022/09/18
.. Commits on Aug 23, 2022 99cf5d44bfad4820ffe4153f3be2f9a9d4e5b1c8
.. -----------------------------------------------------------------------------

.. Overview
.. _dev-env-overview:

==================================================
概要
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Dev Environments boosts collaboration by allowing you to share work-in-progress code with your team members. This removes any potential merge conflicts while moving between Git branches to get your code on to their machine.

Dev Environments はチームメンバと作業中のコードを共有できるようにするため、コラボレーションを後押しします。これにより、Git ブランチ間を移動してコードをマシンに取得するにあたり、 merge のコンフリクトが発生しないようにします。

.. Dev Environments uses tools built into code editors that allows Docker to access code mounted into a container rather than on your local host. This isolates the tools, files and running services on your machine allowing multiple versions of them to exist side by side.

Dev Environmens はコードエディタ内蔵ツールを使います。これは Docker によって、ローカルホスト上ではなく、コンテナにマウントされたコードにアクセスできるようにします。マシン上のツール、ファイル、実行中のサービスを分離するため、複数のバージョンを共存できるようにします。

.. You can also switch between your developer environments or your team members’ environments, move between branches to look at changes that are in progress, without moving off your current Git branch. This makes reviewing PRs as simple as opening a new environment.

また、現在の Git ブランチを移動しなくても、開発者の環境とチームメンバの環境とを切り替えられるようになり、ブランチ間を移動して作業中の変更を確認できるようになります。これにより、 PR のレビューは新しい環境を開くのと同じくらいシンプルになります。

..  Beta
    The Dev Environments feature is currently in Beta. We recommend that you do not use this in production environments.


.. note::

   **ベータ**
   
   Dev Environments 機能は現時点では `ベータ <https://docs.docker.com/release-lifecycle/#beta>`_ です。プロダクション環境での利用を推奨しません。

.. image:: ../images/dev-env.png
   :scale: 60%
   :alt: Docker Desktop

.. Prerequisites
.. _dev-env-prerequisites:

動作条件
==========

.. Dev Environments is available as part of Docker Desktop 3.5.0 release. Download and install Docker Desktop 3.5.0 or higher:

Dev Environments は Docker Desktop 3.5.0 リリースの一部として利用可能です。 **Docker Desktop 3.5.0** 以上をダウンロードとインストールしてください。

..    Docker Desktop

* :doc:`Docker Desktop </desktop/release-notes>`

.. To get started with Dev Environments, you must also install the following tools and extension on your machine:

Dev Environments を使い始めるには、以下のツールと拡張をマシン上にインストールする必要があります：

..  Git
    Visual Studio Code
    Visual Studio Code Remote Containers Extension

* `Git <https://git-scm.com/>`_
* `Visual Studio Code <https://code.visualstudio.com/>`_
* `Visual Studio Code Remote Containers Extension <https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers>`_

.. Add Git to your PATH on Windows
.. _dev-env-add-git-to-your-path-on-windows:

Windows 上の PATH に Git を追加
========================================

.. If you have already installed Git, and it’s not detected properly, run the following command to check whether you can use Git with the CLI or PowerShell:

GIt をインストール済みの場合で、適切な状態か分からなければ、以下のコマンドを実行し、 CLI や PowerShell で使う Git がどこにあるか確認できます。

.. code-block:: bash

   $ git --version

.. If it doesn’t detect Git as a valid command, you must reinstall Git and ensure you choose the option Git from the command line... or the Use Git and optional Unix tools... on the Adjusting your PATH environment step.

有効なコマンドとして Git を確認できなければ、Git の再インストールが必要です。さらに、 **Adjusting your PATH environment** のステップで、 **Git from the command line..** や **Use Git and optional Unix tools...** オプションを選ぶ必要があります。

.. image:: ../images/dev-env-gitbash.png
   :scale: 60%
   :alt: Windows のパスに Git を追加

..  Note
    After Git is installed, restart Docker Desktop. Select Quit Docker Desktop, and then start it again.

.. note::

   Git のインストール後、 Docker Desktop を再起動します。 **Quit Docker Desktop** を選んでから、 DOcker Desktop を再開してください。

.. Known issues
.. _dev-env-known-issues:

既知の問題
==========

.. The following section lists known issues and workarounds:

以降のセクションで、既知の問題と回避策を列挙します：

..  When sharing a Dev Environment between Mac and Windows, the VS Code terminal may not function correctly in some cases. To work around this issue, use the Exec in CLI option in the Docker Dashboard.
    When sharing a Dev Environment between ARM64 and AMD64 machines, the environment is emulated.

1. Mac と Windows 間で Dev Environemnt を共有した場合、 VS Code terminal は一部で適切に機能しません。この問題を回避するには、 Docker Dashboard の Exec in CLI オプションを使います。
2. ARM64 と AMD64 マシン間で Dev Environment を共有した場合、環境はエミュレートされます。


.. What’s next?

次はどうしますか？
====================

.. Learn how to:

方法を学びます：

..  Create a Dev Environment
    Create a Compose Dev Environment
    Share your Dev Environment

* :doc:`Dev Environment を作成 <create-dev-env>`
* :doc:`Compose Dev Environment を作成 <create-compose-dev-env>`
* :doc:`Dev Environment を共有 <share>`

.. seealso::

   Overview
      https://docs.docker.com/desktop/dev-environments/

