.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/get-started/06_bind_mounts/
   doc version: 24.0
      https://github.com/docker/docker.github.io/blob/master/get-started/06_bind_mounts.md
.. check date: 2023/07/17
.. Commits on Jul 13, 2023 68450b02a56c95b2c8ef50f24d40dd57356343b7
.. -----------------------------------------------------------------------------

.. Use bind mounts
.. _use-bind-mounts:

========================================
:ruby:`バインド マウント <bind mount>` の使用
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 2
       :local:

.. In part 5, you used a volume mount to persist the data in your database. A volume mount is a great choice when you need somewhere persistent to store your application data.

:doc:`Part 5 <05_persisting_data>` ではデータベース内のデータを保持するため、ボリュームのマントを使いました。アプリケーションのデータをどこかに保持する必要がある場合、ボリュームマウントは良い選択肢です。

.. A bind mount is another type of mount, which lets you share a directory from the host’s filesystem into the container. When working on an application, you can use a bind mount to mount source code into the container. The container sees the changes you make to the code immediately, as soon as you save a file. This means that you can run processes in the container that watch for filesystem changes and respond to them.

:ruby:`バインド マウント <bind mount>` は他のタイプのマウントであり、ホスト上のファイルシステムをコンテナ内と直接共有します。アプリケーションの動作中でも、バインド マウントを使ってソースコードをコンテナ内にマウントすると、コードの変更が見えたり反映できるようになります。つまり、アプリケーションに対する変更が、直ちに見えるでしょう。

.. In this chapter, you’ll see how you can use bind mounts and a tool called nodemon to watch for file changes, and then restart the application automatically. There are equivalent tools in most other languages and frameworks.

本章で分かるのは、バインドマウントの使い方と、ファイル変更を監視してアプリケーションを自動的に再起動する  `nodemon <https://npmjs.com/package/nodemon>`_ と呼ばれるツールについてです。


.. Quick volume type comparisons
.. _quick-volume-type-comparisons:

ボリューム型の素早い比較
==============================

.. The following table outlines the main differences between volume mounts and bind mounts.

以下の表が示すのは、ボリュームマウントとバインドマウントの主な違いです。


.. list-table::
   :header-rows: 1

   * -  
     - :ruby:`名前付きボリューム <named volume>`
     - :ruby:`バインド マウント <bind mount>`
   * - ホスト上の場所
     - Docker が選択
     - 自分で決める
   * - マウント例（ ``--mount`` を使用）
     - ``type=volume,src=my-volume,target=/usr/local/data``
     - ``type=bind,src=/path/to/data,target=/usr/local/data``
   * - コンテナの内容に新しいボリュームを加える
     - はい
     - いいえ
   * - ボリューム ドライバのサポート
     - はい
     - いいえ

.. Trying out bind mounts
.. _trying-out-bind-mounts:

バインド マウントを試す
==============================

.. Before looking at how you can use bind mounts for developing your application, you can run a quick experiment to get a practical understanding of how bind mounts work.

アプリケーション開発でバインドマウントを使う方法を学ぶ前に、どのようにしてバインドマウントが動作するのか実用的な理解をするために、簡単な実験を行えます。

..    Open a terminal and change directory to the app directory of the getting started repository.

1. ターミナルを開き、ディレクトリを getting-started リポジトリの ``app`` に変更します。

..    Run the following command to start bash in an ubuntu container with a bind mount.

2. 以下のコマンドは、バインドマウントした ``ubuntu`` コンテナで ``bash`` を実行します。

   **Mac / Linux**
   
      .. code-block:: bash
   
         $ docker run -it --mount type=bind,src="$(pwd)",target=/src ubuntu bash
   
   **Windows**

      PowerShell でコマンドを実行します。
   
      .. code-block:: bash
   
         $docker run -it --mount "type=bind,src=$pwd,target=/src" ubuntu bash
   
   .. The --mount option tells Docker to create a bind mount, where src is the current working directory on your host machine (getting-started/app), and target is where that directory should appear inside the container (/src).
   
   ``--mount`` オプションは Docker に対してバインドマウントの作成を命令します。 ``src`` で示す場所は、ホストマシン上の現在の作業ディレクトリ（ ``getting-started/app`` ）です。 ``target`` で示す場所は、はコンテナ内に現れるディレクトリ（ ``/src`` ）です。

.. After running the command, Docker starts an interactive bash session in the root directory of the container’s filesystem

3. コマンドの実行後、コンテナが持つファイルシステムのルートディレクトリ内で、Docker は対話式の ``bash`` セッションを開始します。

   .. code-block:: bash

      root@ac1237fad8db:/# pwd
      /
      root@ac1237fad8db:/# ls
      bin   dev  home  media  opt   root  sbin  srv  tmp  var
      boot  etc  lib   mnt    proc  run   src   sys  usr

.. Change directory to the src directory.

4. ``src`` ディレクトリにディレクトリを変更します。

   .. This is the directory that you mounted when starting the container. Listing the contents of this directory displays the same files as in the getting-started/app directory on your host machine.

   ここはコンテナ起動時にマウントしたディレクトリです。このディレクトリ内容の一覧を表示したら、ホストマシン上の ``getting-started/app`` ディレクトリと同じようにファイルを表示します。
   
   .. code-block:: bash

      root@ac1237fad8db:/# cd src
      root@ac1237fad8db:/src# ls
      Dockerfile  node_modules  package.json  spec  src  yarn.lock

.. Create a new file named myfile.txt.

5. ``myfile.txt`` という名前の新しいファイルを作成します。

   .. code-block:: bash

      root@ac1237fad8db:/src# touch myfile.txt
      root@ac1237fad8db:/src# ls
      Dockerfile  myfile.txt  node_modules  package.json  spec  src  yarn.lock

.. Open the app directory on the host and observe that the myfile.txt file is in the directory.

6. ホスト上の ``app`` ディレクトリを開き、ディレクトリ内に ``myfile.txt`` があるかどうか調べます。

   .. code-block:: bash

      ├── app/
      │ ├── Dockerfile
      │ ├── myfile.txt
      │ ├── node_modules/
      │ ├── pacakge.json
      │ ├── spec/
      │ ├── src/
      │ └── yarn.lock

.. From the host, delete the myfile.txt file.

7. ホストから ``myfile.txt`` ファイルを削除します。

.. In the container, list the contents of the app directory once more. Observe that the file is now gone.

8. コンテナ内で、再び ``app`` ディレクトリ内の内容を一覧表示します。今度はファイルが消えてしまったと分かります。

   .. code-block:: bash
   
      root@ac1237fad8db:/src# ls
      Dockerfile  node_modules  package.json  spec  src  yarn.lock

.. Stop the interactive container session with Ctrl + D.

9. 対話型のコンテナセッションを ``Ctrl`` + ``D`` で停止します。

.. That’s all for a brief introduction to bind mounts. This procedure demonstrated how files are shared between the host and the container, and how changes are immediately reflected on both sides. Now you can use bind mounts to develop software.


以上がバインドマウントの簡単な紹介のすべてです。この手順では、ホストとコンテナ間でどのようにファイルを共有しているのかと、どちらにも変更が直ちに反映されるのを示しました。これでソフトウェア開発にバインドマウントを利用できます。

.. Deployment containers
コンテナのデプロイ
====================

.. Using bind mounts is common for local development setups. The advantage is that the development machine doesn’t need to have all of the build tools and environments installed. With a single docker run command, Docker pulls dependencies and tools.

ローカル開発環境のセットアップで、バインドマウントの利用は一般的です。利点は、開発マシン上に全ての構築ツールや環境をインストールする必要がありません。docker run コマンドを1回実行するだけで、Docker は依存関係とツールを取得します。

.. Run your app in a development container
.. _run-your-app-in-a-development-container:

開発用のコンテナでアプリを実行
------------------------------

.. The following steps describe how to run a development container with a bind mount that does the following:

以下の手順で示すのは、バインドマウントがある開発用のコンテナを実行する手順です：

.. 
    Mount our source code into the container
    Install all dependencies
    Start nodemon to watch for filesystem changes

   * ソースコードをコンテナ内にマウント
   * 全ての依存関係をインストール
   * ファイルシステムの変更を監視する ``nodemon`` を開始

.. You can use the CLI or Docker Desktop to run your container with a bind mount.

バインドマウントしてコンテナを実行するには、 CLI か Docker Desktop を使えます。

**CLI**

   ..    Make sure you don’t have any previous getting-started containers running.

   1. これまでの ``getting-started`` コンテナが動作していないのを確認します。

   .. Run the following command from the getting-started/app directory.
   
   2. ``getting-started/app`` ディレクトリから以下のコマンドを実行します。
   
      **Mac / Linux**
      
         .. code-block:: bash
         
            $ docker run -dp 127.0.0.1:3000:3000 \
                -w /app --mount type=bind,src="$(pwd)",target=/app \
                node:18-alpine \
                sh -c "yarn install && yarn run dev"
   
      **Windows**
      
         このコマンドを PowerShell で実行します。
   
            $ docker run -dp 127.0.0.1:3000:3000 `
                -w /app --mount "type=bind,src=$pwd,target=/app" `
                node:18-alpine `
                sh -c "yarn install && yarn run dev"

   .. The following is a breakdown of the command:
   
   以下はコマンドの詳細です：
   
      * ``-dp 127.0.0.1:3000:3000`` … 以前と同じです。デタッチド（バックグラウンド）モードで実行し、ポート割り当てを作成します。
      * ``-w /app`` … 「 :ruby:`作業ディレクトリ <working directory>` 」 またはカレントディレクトリを指定します。
      * ``--mount "type=bind,src=$pwd,target=/app"`` … ホスト上のカレントディレクトリを、コンテナ内の ``/app`` ディレクトリにバインドマウントします。
      * ``node:18-alpine`` … 使用するイメージです。なお、これが Dockerfile からアプリを作成するベースイメージです。
      * ``sh -c "yarn install && yarn run dev"`` … シェルを開始するのに ``sh`` を使い（ alpine には ``bash`` はありません）、パッケージをインストールするため ``yarn install`` を実行し、開発用サーバを開始するために ``yarn run dev`` を実行します。 ``packagejson`` の中を見ると、 ``dev`` スクリプトが ``nodemon`` を起動しているのが分かります。

   .. You can watch the logs using docker logs <container-id>. You’ll know you’re ready to go when you see this:
   
   3. ``docker logs <container-id>`` を使いログを観察できます。準備が調えば、次のような表示になるでしょう：
   
      .. code-block:: bash
      
         $ docker logs -f <container-id>
         nodemon src/index.js
         [nodemon] 2.0.20
         [nodemon] to restart at any time, enter `rs`
         [nodemon] watching dir(s): *.*
         [nodemon] starting `node src/index.js`
         Using sqlite database at /etc/todos/todo.db
         Listening on port 3000
      
      .. When you’re done watching the logs, exit out by hitting Ctrl+C.
      
      ログの観察が終わったら、 ``Ctrl`` + ``C`` を入力して終了します。

**Docker Desktop**

   ..    Make sure you don’t have any previous getting-started containers running.

   1. これまでの ``getting-started`` コンテナが動作していないのを確認します。

   .. Run the image with a bind mount.
   
   2. バインドマウントしてイメージを起動します。
   
      a. Docker Desktop の一番上にある検索ボックスを選びます。
      b. 検索ウインドウで **Images** タブを選びます。
      c. 検索ボックスでコンテナ名を ``getting-started`` と指定します。
      
         .. tip::
         
            検索でフィルタを使えば **local images** （ローカルイメージ）のみ表示できます。

      d. 自分が作ったイメージを選び、 **Run** （実行）を選びます。
      e. **Optional settings** を選びます。
      f. **Host path** （ホスト側パス）で、ホストマシン上の ``app`` ディレクトリのパスを指定します
      g. **Container path** （コンテナ側パス）で ``/app`` を指定します。
      h. **Run** （実行）を選びます。

   3. Docker Desktop を使ってコンテナのログを観察できます。
   
      a. Docker Desktop の **Containers** を選びます。
      b. コンテナ名を選びます。
   
      準備が調えば、次の様な表示になるでしょう：
      
      .. code-block:: bash
      
         $ docker logs -f <container-id>
         nodemon src/index.js
         [nodemon] 2.0.20
         [nodemon] to restart at any time, enter `rs`
         [nodemon] watching dir(s): *.*
         [nodemon] starting `node src/index.js`
         Using sqlite database at /etc/todos/todo.db
         Listening on port 3000


.. Develop your app with the development container
.. _develop your app with the development container:
開発用コンテナにアプリをデプロイ
----------------------------------------

.. Update your app on your host machine and see the changes reflected in the container.

ホストマシン上のアプリを更新し、コンテナ内に変更が反映されるのを確認します。

.. In the src/static/js/app.js file, on line 109, change the “Add Item” button to simply say “Add”:

1. ``src/static/js/app.js`` ファイル内の 109 行目の、「Add Item」ボタンをシンプルに「Add」と表示するように変えます。

   .. code-block:: diff
   
      -                         {submitting ? 'Adding...' : 'Add Item'}
      +                         {submitting ? 'Adding...' : 'Add'}

   ファイルを保存します。

.. Refresh the page in your web browser, and you should see the change reflected almost immediately. It might take a few seconds for the Node server to restart. If you get an error, try refreshing after a few seconds.

2. ウェブブラウザでページを再読み込みしたら、ほぼ直ちに変更が反映しているのが分かるでしょう。Node サーバの再起動には、数秒かかるかもしれず、もしエラーが出てしまった場合には、数秒後に再読み込みを試してください。

   .. image:: ./images/updated-add-button.png
      :width: 60%
      :alt: Add ボタンのラベルを更新したスクリーンショット

.. Feel free to make any other changes you’d like to make. Each time you make a change and save a file, the nodemon process restarts the app inside the container automatically. When you’re done, stop the container and build your new image using:

3. あとは、他も自由気ままに変更します。変更後は毎回ファイルを保存しますと、 ``nodemon`` プロセスがコンテナ内のアプリを再起動します。終わったら、コンテナを停止し、以下のコマンドを使って新しいイメージを構築します。

   .. code-block:: bash
   
      $ docker build -t getting-started .

.. Next steps
.. _part6-next-steps:

次のステップ
====================

.. At this point, you can persist your database and see changes in your app as you develop without rebuilding the image.

現段階で、データベースを保持できるようになり、イメージを再構築しなくても、開発しているアプリを変更できるのが分かりました。

.. In addition to volume mounts and bind mounts, Docker also supports other mount types and storage drivers for handling more complex and specialized use cases. To learn more about the advanced storage concepts, see Manage data in Docker.

ボリュームマウントとバインドマウントに加え、より複雑かつ専門的なユースケースに対応するため、Docker は他のマウントタイプやストレージドライバをサポートします。

.. In order to prepare your app for production, you need to migrate your database from working in SQLite to something that can scale a little better. For simplicity, you’ll keep using a relational database and switch your application to use MySQL. But, how should you run MySQL? How do you allow the containers to talk to each other? You’ll learn about that in the next section.

アプリの本番環境を準備するには、データベースを SQLite からスケール可能な何かに移行する必要があります。扱いやすさのため、関係データベースの採用にあたり、アプリケーションが MySQL を使うように切り替えます。ですが、どうやって MySQL を動かせばよいのでしょうか？ どのようにしてコンテナ間でお互いが通信できるのでしょうか？ これは次のセクションで学びます。


.. raw:: html

   <div style="overflow: hidden; margin-bottom:20px;">
      <a href="07_multi_container.html" class="btn btn-neutral float-left">複数コンテナのアプリ <span class="fa fa-arrow-circle-right"></span></a>
   </div>



.. seealso::

   Part 6: User bind mounts
      https://docs.docker.com/get-started/06_bind_mounts/


