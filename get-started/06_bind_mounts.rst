.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/get-started/06_bind_mounts/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/get-started/06_bind_mounts.md
.. check date: 2022/09/20
.. Commits on Jun 28, 2022 b0dc95cd626d1cd7f7582307d693fd72a27280ce
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

.. In the previous chapter, we talked about and used a named volume to persist the data in our database. Named volumes are great if we simply want to store data, as we don’t have to worry about where the data is stored.

前章では、データベース内のデータを保持するため、 **名前付きボリューム（named volume）** を使う方法を説明しました。シンプルにデータを保存したい場合には、名前付きボリュームは優れていますが、「どこ」にデータが保管されているか心配したくありません。

.. With bind mounts, we control the exact mountpoint on the host. We can use this to persist data, but it’s often used to provide additional data into containers. When working on an application, we can use a bind mount to mount our source code into the container to let it see code changes, respond, and let us see the changes right away.

**バインド マウント（bind mount）** であれば、ホスト上の正確なマウントポイントを管理できます。バインド マウントはデータ保持に使えますが、使用時はコンテナに対する追加データの指定が度々必要です。アプリケーションの動作中でも、バインド マウントを使ってソースコードをコンテナ内にマウントすると、コードの変更が見えたり反映したりできるようになります。つまり、アプリケーションに対する変更は、直ちに見えるでしょう。

.. For Node-based applications, nodemon is a great tool to watch for file changes and then restart the application. There are equivalent tools in most other languages and frameworks.

Node をベースとするアプリケーション `nodemon <https://npmjs.com/package/nodemon>`_ は素晴らしいツールです。ファイルの変更を監視し、アプリケーションを再起動します。他の言語やフレームワークでも、同様なツールがあります。

.. Quick volume type comparisons
.. _quick-violume-type-comparisons:

ボリューム型の素早い比較
==============================

.. Bind mounts and named volumes are the two main types of volumes that come with the Docker engine. However, additional volume drivers are available to support other uses cases (SFTP, Ceph, NetApp, S3, and more).

バインド マウントと名前付きボリュームは、Docker Engine に組み込まれている２つの主なボリューム型です。しかしながら、他の利用例（ `SFTP <https://github.com/vieux/docker-volume-sshfs>`_ 、 `Ceph <https://ceph.com/geen-categorie/getting-started-with-the-docker-rbd-volume-plugin/>`_ 、 `NetApp <https://netappdvp.readthedocs.io/en/stable/>`_ 、 `S3 <https://github.com/elementar/docker-s3-volume>`_ 、 等）をサポートする追加ボリュームドライバが利用可能です。

.. list-table::
   :header-rows: 1

   * -  
     - 名前付きボリューム
     - バインド マウント
   * - ホスト上の場所
     - Docker が選択
     - 自分で管理
   * - マウント例（ ``-v`` を使用）
     - my-volume:/usr/local/data
     - /path/to/data:/usr/local/data
   * - コンテナの内容に新しいボリュームを加える
     - はい
     - いいえ
   * - ボリューム ドライバのサポート
     - はい
     - いいえ

.. Start a dev-mode container
.. _start-a-dev-mode-container:

開発モードのコンテナを起動
==============================

.. To run our container to support a development workflow, we will do the following:

開発ワークフローをサポートするコンテナを実行するには、以下の作業をします。

.. 
    Mount our source code into the container
    Install all dependencies, including the “dev” dependencies
    Start nodemon to watch for filesystem changes

* ソースコードをコンテナ内にマウント
* 「dev」（開発段階の）依存関係を含む、全ての依存関係をインストール
* ファイルシステムの変更を監視する nodemon を監視

.. So, let’s do it!

それでは、やってみましょう！

..    Make sure you don’t have any previous getting-started containers running.

1. これまでの ``getting-started`` コンテナを実行していないのを確認します。

..    Run the following command from the app directory. We’ll explain what’s going on afterwards:

2. app ディレクトリで以下のコマンドを実行します。何をしようとしているかは、後ほど説明します。

   .. code-block:: bash
   
      $ docker run -dp 3000:3000 \
          -w /app -v "$(pwd):/app" \
          node:18-alpine \
          sh -c "yarn install && yarn run dev"

   .. If you are using PowerShell then use this command:
   .. If you are using Windows then use this command in PowerShell:
   
   Windows を使っている場合は、 PowerShell で以下のコマンドを実行します。

   .. code-block:: bash
   
      PS> docker run -dp 3000:3000 `
          -w /app -v "$(pwd):/app" `
          node:18-alpine `
          sh -c "yarn install && yarn run dev"

   .. If you are using an Apple silicon Mac or another ARM64 device, then use the following command.

   Apple silicon Mac や他の ARM64 デバイスを使っている場合は、以下のコマンドを実行します。

   .. code-block:: bash
   
      $ docker run -dp 3000:3000 \
           -w /app -v "$(pwd):/app" \
           node:18-alpine \
           sh -c "apk add --no-cache python2 g++ make && yarn install && yarn run dev"


   * ``-dp 3000:3000`` … 以前と同じです。 :ruby:`デタッチド <detached>` （バックグラウンド）モードで実行し、 :ruby:`ポート割り当て <port mapping>` を作成
   * ``-w /app`` … コマンドを実行する場所として、「 :ruby:`作業ディレクトリ <working directory>` 」またはカレント ディレクトリを指定
   * ``-v "$(pwd):/app"`` … ホスト上にある現在のディレクトリを、コンテナ内の ``/app`` ディレクトリにバインド マウント
   * ``node:18-alpine`` … 使用するイメージ。これが Dockerfile から作成するアプリ用のベースイメージになるのを意味する
   * ``sh -c "yarn install && yarn run dev"`` … （コンテナで）実行するコマンド。 ``sh`` を使って開始し（alpine には ``bash`` がないため）、全ての依存関係をインストールするため ``yarn install`` を実行し、それから ``yarn run dev`` を実行。 ``package.json`` があれば確認し、それから ``dev`` スクリプトが ``nodemon`` を開始する

.. You can watch the logs using docker logs. You’ll know you’re ready to go when you see this:

3. ``docker logs`` を使ってログを表示できます。以下のような表示になれば、準備が調ったと分かります。

   .. code-block:: bash
   
      $ docker logs -f <container-id>
      nodemon src/index.js
      [nodemon] 2.0.20
      [nodemon] to restart at any time, enter `rs`
      [nodemon] watching dir(s): *.*
      [nodemon] starting `node src/index.js`
      Using sqlite database at /etc/todos/todo.db
      Listening on port 3000

   ログの表示を終了するには、 ``Ctrl`` + ``C`` を実行します。

.. Now, let’s make a change to the app. In the src/static/js/app.js file, let’s change the “Add Item” button to simply say “Add”. This change will be on line 109:

4. 次は、アプリを変更しましょう。 ``src/static/js/app.js`` ファイル内で、「Add Item」ボタンを、シンプルに「Add」と表示するように変えます。変更には 109 行目を変えるだけです。

   .. code-block:: diff
   
      -                         {submitting ? 'Adding...' : 'Add Item'}
      +                         {submitting ? 'Adding...' : 'Add'}

.. Simply refresh the page (or open it) and you should see the change reflected in the browser almost immediately. It might take a few seconds for the Node server to restart, so if you get an error, just try refreshing after a few seconds.

5. ページを単に再読み込みすると（あるいは、ページを開きます）、ほぼ直ちにブラウザに変更が反映しているのが分かるでしょう。Node サーバの再起動には、数秒かかるかもしれず、もしエラーが出てしまった場合には、数秒後に再起動を試してください。

   .. image:: ./images/updated-add-button.png
      :scale: 60%
      :alt: Add ボタンのラベルを更新したスクリーンショット

.. Feel free to make any other changes you’d like to make. When you’re done, stop the container and build your new image using:

6. あとは作りたいように他にも自由に変更します。終わったら、コンテナを停止し、以下のコマンドを使って新しいイメージを構築します。

   .. code-block:: bash
   
      $ docker build -t getting-started .

.. Using bind mounts is very common for local development setups. The advantage is that the dev machine doesn’t need to have all of the build tools and environments installed. With a single docker run command, the dev environment is pulled and ready to go. We’ll talk about Docker Compose in a future step, as this will help simplify our commands (we’re already getting a lot of flags).

バインド マウントの使用は、ローカル開発のセットアップで「非常に」一般的です。この利点は、開発マシンに全ての構築ツールや環境を入れる必要がないからです。 ``docker run`` コマンド１つだけで、開発環境を持ってきて、すぐに始められます。後のステップで、（たくさんのフラグ指定が必要な）コマンド実行を簡単にするのに役立つ Docker Compose を説明します。

.. Recap
.. _part6-recap:

まとめ
==========

.. At this point, we can persist our database and respond rapidly to the needs and demands of our investors and founders. Hooray! But, guess what? We received great news!

これで、データベースを保持し、必要に応じて素早く対応でき、投資家や創設者の要望に応えられるようになりました。やった！ 良いニュースが届きました！

.. Your project has been selected for future development!

**あなたのプロジェクトが今後の開発対象として選ばれました！**

.. In order to prepare for production, we need to migrate our database from working in SQLite to something that can scale a little better. For simplicity, we’ll keep with a relational database and switch our application to use MySQL. But, how should we run MySQL? How do we allow the containers to talk to each other? We’ll talk about that next!

本番環境を準備するには、データベースを SQLite からスケール可能な何かへ以降する必要があります。扱いやすさのため、関係データベースを使い続け、アプリケーションが MySQL を使うように切り替えます。ですが、どうやって MySQL を動かせばよいのでしょうか？ どのようにしてコンテナ間がお互いに通信できるのでしょうか？ 次で解説します。


.. seealso::

   Part 6: User bind mounts
      https://docs.docker.com/get-started/06_bind_mounts/


