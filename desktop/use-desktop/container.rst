.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/desktop/use-desktop/container/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/desktop/use-desktop/container.md
.. check date: 2022/09/15
.. Commits on Sep 10, 2022 8bc2c44ed06ca967197a8b4a80729a79397b858d
.. -----------------------------------------------------------------------------

.. |whale| image:: /desktop/install/images/whale-x.png
      :scale: 50%

.. Explore Containers
.. _explore-containers:

=======================================
:ruby:`Containers <コンテナ>` を見渡す
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. The Containers view lists all your running containers and applications. You must have running or stopped containers and applications to see them listed.

**Containers** は全ての実行中のコンテナとアプリケーションの一覧を表示します。一覧に表示するには、コンテナ化アプリケーションが実行中もしくは停止中の必要があります。

.. Container actions
.. _container-actions:

コンテナ操作
====================

.. Use the Search field to search for any specific container.

あらゆるコンテナを探すには、 **Search** 部分を使います。

.. From the Containers view you can perform the following actions on one or more containers at once:

**Containers** の表示からは、一つまたは複数のコンテナに対し、以下の処理を同時に行えます。

..    Pause
    Resume
    Stop
    Start
    Delete

* Pause （一次停止）
* Resume （再開）
* Stop （停止）
* Start （起動）
* Delete （削除）

.. When you hover over individual containers, you can also:

個々のコンテナの上にマウスカーソルを移動すると、以下も行えます：

..  Click Open in Visual Studio Code to open the application in VS Code.
    Open the port exposed by the container in a browser.

* **Open in Visual Studio Code** は VS Code でアプリケーションを開きます。
* コンテナが公開しているポートをブラウザで開きます。

.. Integrated terminal
.. _desktop-integrated-terminal:

:ruby:`統合ターミナル <integrated terminal>`
--------------------------------------------------

.. You also have the option to open an integrated terminal, on a running container, directly within Docker Desktop. This allows you to quickly execute commands within your container so you can understand its current state or debug when something goes wrong.

「integrated terminal」のオプションを開くと、実行中のコンテナに対して Docker Deksop 内で直接操作できます。これにより、コンテナ内で素早くコマンドを実行できるようになるため、何らかの以上が発生した場合、現在の状況を理解したり、デバッグするのに役立ちます。

.. Using the integrated terminal is the same as running docker exec -it <container-id> /bin/sh, or docker exec -it <container-id> cmd.exe if you are using Windows containers, in your external terminal. It also:

統合ターミナルの使用とは、 ``docker exec -it <container-id> /bin/sh`` か ``docker exec -it <container-id> cmd.exe`` を実行するのと同じです。Windows コンテナーを使用中の場合は、外部のターミナルになります。また、

..  Automatically detects the default user for a running container from the image’s Dockerfile. If no use is specified it defaults to root.
    Persists your session if you navigate to another part of the Docker Dashboard and then return.
    Supports copy, paste, search, and clearing your session.

* イメージの Dockerfile からコンテナを実行する場合、デフォルトのユーザを自動的に検出します。指定がない場合、デフォルトは ``root`` になります。
* Docker ダッシュボードで別の場所に移動した後に戻っても、セッションは継続しています。
* コピー、ペースト、検索、セッションのクリアをサポートします。

.. To open the integrated terminal, hover over your running container and select the Show container actions menu. From the dropdown menu, select Open in terminal.

統合ターミナルを開くには、実行中のコンテナの上にマウスを移動し、 **Show container actions** （コンテナの処理を表示）面ｙ－を選びます。ドロップダウンメニューから、 **Open in terminal** （ターミナルで開く）を選びます。

.. To use your external terminal, change your settings.

外部のターミナルを使うには、設定を変更します。

.. Inspect a container
.. _desktop-inspect-a-container:

コンテナを :ruby:`調べる <inspect>`
========================================

.. You can obtain detailed information about the container when you select a container.

コンテナ名をクリックすると、対象となるコンテナの詳細情報を得られます。

.. The container view displays Logs, Inspect, and Stats tabs and provides quick action buttons to perform various actions.

コンテナの表示画面では、 **Logs** 、 **Inspect** 、 **Stats** タブが表示され、クイック アクション ボタンから様々な処理が行えます。

..  Select Logs to see logs from the container. You can also:
        Use Cmd + f/Ctrl + f to open the search bar and find specific entries. Search matches are highlighted in yellow.
        Press Enter or Shift + Enter to jump to the next or previous search match respectively.
        Use the Copy icon in the top right-hand corner to copy all the logs to your clipboard.
        Automatically copy any logs content by highlighting a few lines or a section of the logs.
        Use the Clear terminal icon in the top right-hand corner to clear the logs terminal.
        Select and view external links that may be in your logs.
    Select Inspect to view low-level information about the container. You can see the local path, version number of the image, SHA-256, port mapping, and other details.
    Select Stats to view information about the container resource utilization. You can see the amount of CPU, disk I/O, memory, and network I/O used by the container.


* **Logs** をクリックすると、コンテナからのログを表示します。また、次のことも出来ます：

  * ``Cmd + f / Ctrl +f`` を使うと、検索バーが開き、入力した項目を検索できます。検索結果に一致すると、黄色でハイライトします。
  * ``Enter`` か ``Shift + Enter`` で検索結果に一致する場所を前後にジャンプします。
  * 右上の角にある **Copy** アイコンを使うと、全てのログをクリップボードにコピーします。
  * ログの中で数行または一部をハイライトすると、ログの内容を自動的にコピーします。
  * 右上の角にある **Clear terminal** アイコンを使うと、ログのターミナルをクリアします。
  * ログの中に外部リンクがある場合は、選択して表示します。

* **Inspect** をクリックすると、コンテナに関する低レベルの情報を表示します。ローカルのパス、イメージのバージョン番号、SHA-256、ポート割り当て、その他の詳細を表示できます。

* **Stats** をクリックすると、コンテナのリソース使用状況についての情報を表示します。コンテナによって使われる CPU 、ディスク I/O 、メモリ、ネットワーク I/O の量を確認できます。

.. seealso::

   Explore Containers
      https://docs.docker.com/desktop/use-desktop/container/