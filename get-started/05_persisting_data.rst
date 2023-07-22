.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/get-started/05_persisting_data/
   doc version: 24.0
      https://github.com/docker/docker.github.io/blob/master/get-started/05_persisting_data.md
.. check date: 2023/07/17
.. Commits on Jun 7, 2023 aee91fdaba9516d06db5b6b580e98f70a9a11c55
.. -----------------------------------------------------------------------------

.. Persist the DB
.. _persist-the-db:

========================================
データベースの保持
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 2
       :local:

.. In case you didn’t notice, your todo list is empty every single time you launch the container. Why is this? In this part, you’ll dive into how the container is working.

気を付けなければ、コンテナを起動するたび、todo リストは毎回きれいに消去されます。どうしてでしょうか？ このパートではコンテナがどのように動作しているのか、深掘りしましょう。

.. The container’s filesystem
.. _the-containers-filesystem:

コンテナのファイルシステム
==============================

.. When a container runs, it uses the various layers from an image for its filesystem. Each container also gets its own “scratch space” to create/update/remove files. Any changes won’t be seen in another container, even if they are using the same image.

コンテナの実行時、イメージの様々なレイヤーを、コンテナの :ruby:`ファイルシステム <filesystem>` に使います。また、各コンテナでは、ファイルを作成、更新、削除するための「 :ruby:`スクラッチ領域 <scratch space>` 」もコンテナ自身が持ちます。たとえ同じイメージを使っていたとしても、（あるコンテナのファイルシステムに対する）あらゆる変更は、他のコンテナからは見えません。


.. See this in practice
.. _see-this-in-practice:

実行して確認
------------------------------

.. To see this in action, you’re going to start two containers and create a file in each. What you’ll see is that the files created in one container aren’t available in another.

この処理を見るために、２つのコンテナを起動し、それぞれにファイルを作成します。一方のコンテナで作成されたファイルは、もう一方のコンテナからは見えないと分かるでしょう。

..    Start an ubuntu container that will create a file named /data.txt with a random number between 1 and 10000.

1. ``ubuntu`` コンテナを起動し、そこに ``/data.txt`` という名前のファイルを作成し、1から10000までのランダムな数を入れます。

   .. code-block:: bash
   
      $ docker run -d ubuntu bash -c "shuf -i 1-10000 -n 1 -o /data.txt && tail -f /dev/null"

   .. In case you’re curious about the command, we’re starting a bash shell and invoking two commands (why we have the &&). The first portion picks a single random number and writes it to /data.txt. The second command is simply watching a file to keep the container running.

   このコマンドに興味があれば説明します。これは bash シェルを開始し、２つのコマンド（これが ``&&`` を使った理由）を実行しました。前半部分はランダムな数を選び、それをファイル ``./data.txt`` に書き出します。後半部分はコンテナを実行し続けるため、単にファイルを見ているだけです。

.. Validate that we can see the output by execing into the container. To do so, open the Dashboard and click the first action of the container that is running the ubuntu image.

.. Validate that you can see the output by accessing the terminal in the container. To do so, you can use the CLI or Docker Desktop’s graphical interface.

2. コンテナのターミナルにアクセスしたら、出力を確認できます。そのために CLI か Docker Desktop のグラフィカルインタフェースを使います。

   **CLI**
   
      .. On the command line, use the docker exec command to access the container. You need to get the container’s ID (use docker ps to get it). In your Mac or Linux terminal, or in Windows Command Prompt or PowerShell, get the content with the following command.
      
      コマンドライン上からコンテナにアクセスするには ``docker exec`` コマンドを使います。コンテナ ID の取得が必要です（取得には ``docker ps`` を使います）。Mac や Linux のターミナルで、あるいは、 Windows コマンドプロンプトや PowerShell で以下のコマンドで実行し、内容を確認します。
      
      .. code-block:: bash
      
         $ docker exec <container-id> cat /data.txt
      
      .. You should see a random number.
      
      ランダムな数字が表示されるでしょう。
   
   **Docker Desktop**
   
      .. In Docker Desktop, go to Containers, hover over the container running the ubuntu image, and select the Show container actions menu. From the dropdown menu, select Open in terminal.
      Docker Desktop では **Containers* に移動し、 **ubuntu** イメージを実行しているコンテナの上にマウスカーソルを移動し、 **Show container actions** メニューを選びます。下に展開したメニューから **Open in terminal** を選びます。

      .. You will see a terminal that is running a shell in the Ubuntu container. Run the following command to see the content of the /data.txt file. Close this terminal afterwards again.
      ターミナルとして開いているのは、 Ubuntu コンテナ内で実行中のシェルです。 ``/data.txt`` ファイル内の内容を確認するには、次のコマンドを実行します。後ほど終わったら、このターミナルを閉じます。

      .. code-block:: bash
      
         $ cat /data.txt
      
      .. You should see a random number.
      
      ランダムな数字が表示されるでしょう。

.. Now, start another ubuntu container (the same image) and you’ll see you don’t have the same file. In your Mac or Linux terminal, or in Windows Command Prompt or PowerShell, get the content with the following command.

3. 次に、他の ``ubuntu`` コンテナ（同じイメージ）を起動しても、同じファイルは見えないでしょう。Mac や Linux のターミナルで、あるいは、 Windows コマンドプロンプトや PowerShell で以下のコマンドで実行し、内容を確認します。

   .. code-block:: bash

      $ docker run -it ubuntu ls /

   .. In this case the command lists the files in the root directory of the container. Look, there’s no data.txt file there! That’s because it was written to the scratch space for only the first container.
   
   このコマンドの場合、コンテナ内のルートディレクトリ以下のファイルを一覧表示します。確認してください、 ``data.txt`` ファイルは一覧にありません。その理由は、ファイルを書き出したのは、１つめのコンテナのスクラッチ領域だけだからです。

.. Go ahead and remove the first container using the docker rm -f <container-id> command.

4. 次に進むため、 ``docker rm -f <コンテナID>`` コマンドを使って、１つめのコンテナを削除します。

.. Container volumes
.. _container-volumes:

コンテナの :ruby:`ボリューム <volume>`
========================================

.. With the previous experiment, we saw that each container starts from the image definition each time it starts. While containers can create, update, and delete files, those changes are lost when the container is removed and all changes are isolated to that container. With volumes, we can change all of this.

これまで試したように、各コンテナは、イメージの定義からコンテナが起動するのが分かりました。コンテナはファイルの作成、更新、削除ができますが、コンテナを削除したら、それらの変更は消失します。また、コンテナに対する全ての変更とは、 :ruby:`隔離された <isolated>` 対象のコンテナに対してのみです。ですが、 :ruby:`ボリューム <volume>` を使えば、これら全てを変えられます。

.. Volumes provide the ability to connect specific filesystem paths of the container back to the host machine. If a directory in the container is mounted, changes in that directory are also seen on the host machine. If we mount that same directory across container restarts, we’d see the same files.

:doc:`ボリューム </storage/volumes>` は、コンテナ内で指定したファイルシステムのパスを、ホストマシン上へと接続できる機能を備えています。コンテナ内にディレクトリをマウントすると、ディレクトリに対する変更は、ホストマシン上からも見えます。コンテナを再起動する場合にも、同じディレクトリをマウントしていれば、再起動後も同じファイルが見えます。

.. There are two main types of volumes. You’ll eventually use both, but you’ll start with volume mounts.

ボリュームは主に２種類あります。ゆくゆくは両方を使いますが、まずはボリュームのマウントから始めましょう。

.. Persist the todo data
.. _persist-the-todo-data:

todo データを保持する
==============================

.. By default, the todo app stores its data in a SQLite database at /etc/todos/todo.db in the container’s filesystem. If you’re not familiar with SQLite, no worries! It’s simply a relational database that stores all the data in a single file. While this isn’t the best for large-scale applications, it works for small demos. You’ll learn how to switch this to a different database engine later.

デフォルトでは、todo アプリが自身のデータを保存するのは、コンテナ用ファイルシステム内で ``/etc/todo/todo.db`` にある `SQLite Databese <https://www.sqlite.org/index.html>`_ の中です。SQLite に不慣れでも、心配は要りません！ これはシンプルなリレーショナル データベースで、１つのファイル内に全てのデータを保存します。大きくスケールするアプリケーションには最良ではありませんが、小さなデモには効果的です。これを他のデータベースエンジンに切り替える方法は、後ほどお伝えします。

.. With the database being a single file, if you can persist that file on the host and make it available to the next container, it should be able to pick up where the last one left off. By creating a volume and attaching (often called “mounting”) it to the directory where you stored the data, you can persist the data. As your container writes to the todo.db file, it will persist the data to the host in the volume.

データベースはたった１つのファイルです。そのため、ホスト上のファイルを次のコンテナで利用できるようにするだけで、データベースを保持できるため、最後に中断したところから継続できるでしょう。ボリュームを作成し、データを保管するディレクトリに :ruby:`取り付ける <attach>` と（よく :ruby:`マウントする <mounting>` と言います）、データを :ruby:`保持 <persist>` できます。つまり、私たちのコンテナが書き出す ``todo.db`` ファイルは、ホスト上のボリュームに置いておけば、保持できます。

.. As mentioned, you’re going to use a volume mount. Think of a volume mount as an opaque bucket of data. Docker fully manages the volume, including the storage location on disk. You only need to remember the name of the volume.

先述の通り、ここではボリュームのマウントを使おうとしています。ボリュームのマウントとは、中身が見えないデータの :ruby:`入れ物 <bucket>` と考えてください。Docker がディスク上で物理的な場所を確保するため、必要なのはボリュームの名前を覚えておくだけです。

.. Create a volume and start the container
.. _create-a-volume-and-start-the-container:

ボリュームの作成とコンテナの起動
----------------------------------------

.. You can create the volume and start the container using the CLI or Docker Desktop’s graphical interface.

CLI か Docker Desktop のグラフィカルインタフェースを使い、ボリュームの作成とコンテナの起動ができます。

**CLI**

   ..    Create a volume by using the docker volume create command.
   
   1. ``docker volume create`` コマンドを使ってボリュームを作成します。
   
      .. code-block:: bash
   
         $ docker volume create todo-db
   
   .. Stop and remove the todo app container once again with docker rm -f <id>, as it is still running without using the persistent volume.
   
   2. todo アプリのコンテナを再び作り直します。 :ruby:`保存するボリューム <persistence>` を使わずに起動しているため、 ``docker rm -f <tag>``  で停止と削除をします。
   
   .. Start the todo app container, but add the --mount option to specify a volume mount. Give the volume a name, and mount it to /etc/todos in the container, which captures all files created at the path. In your Mac or Linux terminal, or in Windows Command Prompt or PowerShell, run the following command:
   
   3. todo アプリのコンテナを起動しますが、ボリュームのマウントを指定する ``--mount`` オプションを追加します。ボリューム名を与え、そこをコンテナ内の ``/etc/todos`` にマウントすると、そのパスに作成された全てのファイルを（ボリューム内に）確保します。Mac や Linux のターミナルで、あるいは、 Windows コマンドプロンプトや PowerShell で以下のコマンドで実行します。
   
   .. code-block:: bash
   
      $ docker run -dp 127.0.0.1:3000:3000 --mount type=volume,src=todo-db,target=/etc/todos getting-started

**Docker Desktop**

   1. ボリュームを作成します。
   
      a. Docker Desktop で **Volumes** を選びます。
      b. **Volumes** で **Create** を選びます。
      c. ボリューム名として ``todo-db`` を指定し、それから **Create** を選びます。

   2. アプリのコンテナを停止・削除します。
   
      a. Docker Desktop で **Containers** を選びます。
      b. 対象コンテナの **Actions** 列にある **Delete** を選びます。

   3. ボリュームを待つのしてアプリコンテナを起動します。
   
      a. Docker Desktop の一番上にある検索ボックスを選びます。
      b. 検索ウインドウで **Images** タブを選びます。
      c. 検索ボックスでコンテナ名を ``getting-started`` と指定します。
      
         .. tip::
         
            検索でフィルタを使えば **local images** （ローカルイメージ）のみ表示できます。

      d. 自分が作ったイメージを選び、 **Run** （実行）を選びます。
      e. **Optional settings** を選びます。
      f. **Host path** （ホスト側パス）で、ボリューム名 ``todo-db`` を指定します
      g. **Container path** （コンテナ側パス）で ``/etc/todos`` を指定します。
      h. **Run** （実行）を選びます。


.. Verify that the data persists
.. _verify-that-the-data-persists:

データの保持を確認
--------------------

.. Once the container starts up, open the app and add a few items to your todo list.

1. コンテナが起動したら、アプリを開き、todo リストに新しいアイテムを追加します。

   .. image:: ./images/items-added.png
      :scale: 60%
      :alt: Todo リストにアイテムを追加

..    Stop and remove the container for the todo app. Use the Dashboard or docker ps to get the ID and then docker rm -f <id> to remove it.

2. todo アプリ用のコンテナを停止・削除します。コンテナの ID をダッシュボードか ``docker ps`` コマンドで調べ、 ``docker rm -f <id>`` で削除します。

..    Start a new container using the same command from above.

3. 先ほどと同じコマンドを使い、新しいコンテナを起動します。

..    Open the app. You should see your items still in your list!

4. アプリを開きます。そうすると、まだリストにアイテムが残っているのが見えるでしょう！

..    Go ahead and remove the container when you’re done checking out your list.

5. リストの挙動を確認できれば、次へ進むためにコンテナを削除します。

.. You’ve now learned how to persist data.

これでデータを保持する方法を学びました。

.. Dive into the volume
.. _dive-into-the-volume:

ボリュームを深掘り
====================

.. A lot of people frequently ask “Where is Docker storing my data when I use a volume?” If you want to know, you can use the docker volume inspect command.

多くの人々が頻繁に尋ねるのは「ボリュームを使う時、 Docker が私のデータを"実際に"保存するのはどこですか？」です。知りたければ ``docker volume inspect`` コマンドで調べられます。

.. code-block:: bash

   $ docker volume inspect todo-db
   [
       {
           "CreatedAt": "2019-09-26T02:18:36Z",
           "Driver": "local",
           "Labels": {},
           "Mountpoint": "/var/lib/docker/volumes/todo-db/_data",
           "Name": "todo-db",
           "Options": {},
           "Scope": "local"
       }
   ]

.. The Mountpoint is the actual location on the disk where the data is stored. Note that on most machines, you will need to have root access to access this directory from the host. But, that’s where it is!

この ``MountPoint`` （マウントポイント）こそが、ディスク上に実際のデータを保管している場所です。ほとんどのマシンでは、このディレクトにホスト上からアクセスするには root 権限が必要なので注意してください。まさに、そこにデータがあります！

..    Accessing volume data directly on Docker Desktop
    While running in Docker Desktop, the Docker commands are actually running inside a small VM on your machine. If you wanted to look at the actual contents of the Mountpoint directory, you would need to first get inside of the VM.

.. note::

   **Docker Desktop 上で直接ボリュームのデータにアクセスするには**
   
   Docker Desktop を実行中に、Docker コマンドが実際に動くのは、マシン上の小さな仮想マシン内です。マウントポイントのディレクトリ内で、実際の内容を見たい場合は、何よりもまず仮想マシン内に入る必要があります。

.. Next steps
.. _part5-next-steps:

次のステップ
====================

.. At this point, you have a functioning application that can survive restarts.

ここまで、アプリケーションを再起動しても（テータを）保持できる機能を確認しました。

.. However, you saw earlier that rebuilding images for every change takes quite a bit of time. There’s got to be a better way to make changes, right? With bind mounts, there is a better way.

ところで一方、初期の頃から変更を加えるたびに、何度も何度も毎回イメージの再構築をしています。これを改善したいと思いますよね？ バインド マウントの使用こそが良い方法です。


.. raw:: html

   <div style="overflow: hidden; margin-bottom:20px;">
      <a href="06_bind_mounts.html" class="btn btn-neutral float-left">バインドマウントを使う <span class="fa fa-arrow-circle-right"></span></a>
   </div>


.. seealso::

   Part 5: Persist the DB
      https://docs.docker.com/get-started/05_persisting_data/


