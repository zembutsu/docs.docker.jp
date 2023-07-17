.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/get-started/03_updating_app/
   doc version: 24.0
      https://github.com/docker/docker.github.io/blob/master/get-started/03_updating_app.md
.. check date: 2023/07/17
.. Commits on Jun 7, 2023 aee91fdaba9516d06db5b6b580e98f70a9a11c55
.. -----------------------------------------------------------------------------

.. Update the application
.. _update-the-application:

========================================
アプリケーションの更新
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 2
       :local:

.. In part 2, you containerized a todo application. In this part, you will update the application and container image. You will also learn how to stop and remove a container.

:doc:`Part 2 <02_our_app>` では Todo アプリケーションをコンテナ化しました。このパートでは、アプリケーションとコンテナイメージを更新します。また、コンテナの停止と削除する方法も学びます。

.. Update the source code
.. _update-the-source-code:

ソースコードの更新
====================

.. In the steps below, you will change the “empty text” when you don’t have any todo list items to “You have no todo items yet! Add one above!”

以下のステップでは、Todo リストにアイテムが一切なければ「何も表示しない」のではなく、「You have no todo items yet! Add one above!」（todo アイテムがありません！追加してください！）と表示します。


..    In the src/static/js/app.js file, update line 56 to use the new empty text.

1. ``src/static/js/app.js`` ファイル内で、何もない時に表示する文字を変更するため、56 行目を更新します。

   .. code-block:: diff
   
      -                <p className="text-center">No items yet! Add one above!</p>
      +                <p className="text-center">You have no todo items yet! Add one above!</p>

.. Build your updated version of the image, using the same docker build command you used in part 2.

2. イメージの更新版を構築するため、 :doc:`Part 2 <02_our_app>` で使用した ``docker build`` コマンドを使います。

   .. code-block:: bash
   
      $ docker build -t getting-started .

.. Start a new container using the updated code.

3. 更新したコードを使う新しいコンテナを起動します。

   .. code-block:: bash
   
      $ docker run -dp 127.0.0.1:3000:3000 getting-started

.. You probably saw an error like this (the IDs will be different):

おそらく次のようなエラーが出ているでしょう（ID は違います）：

.. code-block:: bash

   docker: Error response from daemon: driver failed programming external connectivity on endpoint laughing_burnell 
   (bb242b2ca4d67eba76e79474fb36bb5125708ebdabd7f45c8eaf16caaabde9dd): Bind for 0.0.0.0:3000 failed: port is already allocated.

.. The error occurred because you aren’t able to start the new container while your old container is still running. The reason is that the old container is already using the host’s port 3000 and only one process on the machine (containers included) can listen to a specific port. To fix this, you need to remove the old container.

このエラーが表示されたのは、古いコンテナがまだ実行中のため、新しいコンテナを起動できないからです。その理由は、古いコンテナが既にホスト側のポート 3000 を使用中であり、マシン上では1つのプロセス（コンテナも含みます）しか特定のポートをリッスンできないからです。これに対応するには、古いコンテナの削除が必要です。

.. Remove a container using the CLI
.. _remove-a-container-using-the-cli:

古いコンテナの削除
==============================

.. To remove a container, you first need to stop it. Once it has stopped, you can remove it. You can remove the old container using the CLI or Docker Desktop’s graphical interface. Choose the option that you’re most comfortable with.

コンテナを削除するには、まずコンテナの停止が必要です。停止した後に削除できます。古いコンテナの削除には CLI を削除する方法と Docker Desktop のグラフィカルインタフェースを使う方法があります。どちらでも、やりやすい方法を自由に選んでください。

**CLI**

.. Remove a container using the CLI
.. _remove-a-container-using-the-cli:

CLI でコンテナを削除
--------------------

..    Get the ID of the container by using the docker ps command.

1. ``docker ps`` コマンドを使い、コンテナの ID を調べます。

   .. code-block:: bash
   
      $ docker ps

.. Use the docker stop command to stop the container. Replace <the-container-id> with the ID from docker ps.

2. ``docker stop`` コマンドでコンテナを停止します。 <the-container-id> は ``docker ps`` で調べた ID に置き換えます。

   .. code-block:: bash
   
      $ docker stop <the-container-id>

.. Once the container has stopped, you can remove it by using the docker rm command.

3. コンテナが停止したら、 ``docker rm`` コマンドで削除できます。

   .. code-block:: bash
   
      $ docker rm <the-container-id>

..    Note
    You can stop and remove a container in a single command by adding the “force” flag to the docker rm command. For example: docker rm -f <the-container-id>

.. note::

   ``docker rm`` コマンドに「 :ruby:`強制 <force>` 」フラグを付ければ、１回のコマンドでコンテナの停止と削除ができます。例： ``docker rm -f <the-container-id>``


**Docker Desktop**



.. Remove a container using the Docker Dashboard
.. _remove-a-container-using-the-docker-dashboard:

Docker ダッシュボードでコンテナを削除
----------------------------------------

..    Open Docker Desktop to the Containers view.

1. Docker Desktop を開き、 **Containers** を表示します。

..    Select the trash can icon under the Actions column for the old, currently running container that you want to delete.

2. 削除しようとしている、古くて実行しているコンテナの **Actions** 列の下にあるゴミ箱のアイコンをクリックします。

..    In the confirmation dialog, select Delete forever.

3. 確認ダイアログでは **Delete forever** （完全に削除）を選びます。

.. Start the updated app container
.. _start-the-updated-app-container:

更新したアプリのコンテナを起動
------------------------------

.. Now, start your updated app using the docker run command.

1. 次は、 ``docker run`` コマンドを使い、更新したアプリを起動します。

   .. code-block:: bash
   
      $ docker run -dp 127.0.0.1:3000:3000 getting-started

.. Refresh your browser on http://localhost:3000 and you should see your updated help text.

2. ブラウザで http://localhost:3000 を再読み込むと、説明の文字が更新されているでしょう。

.. Updated application with updated empty text

.. image:: ./images/todo-list-updated-empty-text.png
   :scale: 60%
   :alt: Todo List Manager のスクリーンショット

.. Next steps
.. _part3-next-steps:

次のステップ
====================

.. While we were able to build an update, there were two things you might have noticed:

構築と更新を行いましたが、2つの注意点があります。

..  All of the existing items in our todo list are gone! That’s not a very good app! We’ll talk about that shortly.
    There were a lot of steps involved for such a small change. In an upcoming section, we’ll talk about how to see code updates without needing to rebuild and start a new container every time we make a change.

* todo リストに追加していたアイテムは、全て消えてしまいます！ 良いアプリではありませんね！  近いうちに説明します。
* 小さな変更のように、実際には多くの改良ステップがあります。以降のセクションでは、再構築を必要としないコードの編集方法や、変更する度に新しくコンテナを起動する方法を説明します。

.. Before talking about persistence, we’ll quickly see how to share these images with others.

:ruby:`永続性 <persistence>` （データの保持）を説明する前に、他人とイメージを共有する方法を見ます。


.. seealso::

   Update the application
      https://docs.docker.com/get-started/03_updating_app/


