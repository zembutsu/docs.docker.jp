.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/get-started/introduction/develop-with-containers/
   doc version: 27.0
      https://github.com/docker/docs/blob/main/content/get-started/introduction/develop-with-containers.md
.. check date: 2025/01/04
.. Commits on Oct 9, 2024 29e9c2d8c4c504412d677a779610dc6749da0df6
.. -----------------------------------------------------------------------------

.. Develop with containers
.. _introduction-develop-with-containers:

========================================
コンテナを使っての開発
========================================

.. raw:: html

   <iframe width="737" height="415" src="https://www.youtube.com/embed/D0SDBrS3t9I" title="YouTube video player" frameborder="1" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

----

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _introduction-develop-with-containers-explanation:

説明
==========

.. Now that you have Docker Desktop installed, you are ready to do some application development. Specifically, you will do the following:

Docker Desktop をインストールしましたので、これで何かしらのアプリケーション開発をする準備が調いました。具体的には、以下の作業をします。

..  Clone and start a development project
    Make changes to the backend and frontend
    See the changes immediately

1. クローンをして、開発プロジェクトを始める
2. バックエンドとフロントエンドに変更を加える
3. 変更を直ちに確認

.. Try it out
.. _introduction-try-it-out-develop:

やってみよう
====================

.. In this hands-on guide, you'll learn how to develop with containers.

このハンズオンガイドでは、コンテナを使った開発方法を学びます。

.. Start the project
.. _introduction-start-the-project:

プロジェクトを始める
==============================

.. To get started, either clone or download the project as a ZIP file to your local machine.

1. 始めるには、クローンするか、ローカルマシンに `ZIP ファイルのプロジェクトをダウンロード <https://github.com/docker/getting-started-todo-app/archive/refs/heads/main.zip>`_ します。

   .. code-block:: console

      $ git clone https://github.com/docker/getting-started-todo-app

   .. And after the project is cloned, navigate into the new directory created by the clone:
   
   プロジェクトをクローンしたら、クローンで作成された新しいディレクトリに移動します。
   
   .. code-block:: console
   
      $ cd getting-started-todo-app

.. Once you have the project, start the development environment using Docker Compose.

2. プロジェクトの準備ができたら、Docker Compose を使って開発環境を起動します。

   .. To start the project using the CLI, run the following command:
   
   CLI を使ってプロジェクトを起動するには、以下のコマンドを実行します。
   
   .. code-block:: console
   
      $ docker compose watch
   
   .. You will see an output that shows container images being pulled down, containers starting, and more. Don't worry if you don't understand it all at this point. But, within a moment or two, things should stabilize and finish.
   
   コンテナイメージのダウンロード、コンテナの起動などの出力が表示されます。この時点では、表示されている全てを理解できなくても心配はありません。少し待てば、状態は安定し、処理が完了します。

.. Open your browser to http://localhost to see the application up and running. It may take a few minutes for the app to run. The app is a simple to-do application, so feel free to add an item or two, mark some as done, or even delete an item.

3. ブラウザで http://localhost/ を開くと、起動して実行中のアプリケーションが見えます。アプリケーションが実行するまで数分かかる場合もあるでしょう。このアプリはシンプルな ToDo （やることリスト）アプリケーションのため、自由に項目をいくつも追加したり、完了したものに印を付けたり、項目の削除もできます。

   .. image:: images/develop-getting-started-app-first-launch.webp
      :alt: ToDo アプリを初めて起動した後の画面

.. What's in the environment?
.. _develop-whats-in-the-environment:

環境内には何がある？
------------------------------

.. Now that the environment is up and running, what's actually in it? At a high-level, there are several containers (or processes) that each serve a specific need for the application:

これで環境を起動し実行していますが、中には何があるのでしょうか。大まかに説明すると、このアプリケーションには複数のコンテナ（またはプロセス）があり、それぞれ特定の役割があります。

..  React frontend - a Node container that's running the React dev server, using Vite.
    Node backend - the backend provides an API that provides the ability to retrieve, create, and delete to-do items.
    MySQL database - a database to store the list of the items.
    phpMyAdmin - a web-based interface to interact with the database that is accessible at http://db.localhost.
    Traefik proxy - Traefik is an application proxy that routes requests to the right service. It sends all requests for localhost/api/* to the backend, requests for localhost/* to the frontend, and then requests for db.localhost to phpMyAdmin. This provides the ability to access all applications using port 80 (instead of different ports for each service).

- React フロントエンド - `Vite <https://vitejs.dev/>`_ を使って、 React 開発サーバを実行中の Node コンテナ
- Node バックエンド - ToDo 項目の読み出し、作成、削除ができる API バックエンドを提供
- MySQL データベース - 項目の一覧を保存するデータベース
- phpMyAdmin - データベースに対して `http://db.localhost/ <http://db.localhost/>`_ でアクセスできる、ウェブベースでやりとりできるインターフェース
- Traefik プロキシ -  `Traefik <https://traefik.io/traefik/>`_ は、リクエストを適切なサービスに振り分けるアプリケーションプロキシです。 ``localhost/api/*`` に対する全てのリクエストをバックエンドへ、 ``localhost/*`` へのリクエストはフロントエンドへ、 ``db.localhost`` へのリクエストは phpMyAdmin へ送ります。これによりポート 80 を使って（サービスごとに異なるポートを使うのではなく）全てのアプリケーションへアクセスできるようにします。

.. With this environment, you as the developer don’t need to install or configure any services, populate a database schema, configure database credentials, or anything. You only need Docker Desktop. The rest just works.

この環境内では、開発者は何らかのサービスのインストールや設定変更をする必要はなく、データベース構造の設定投入や、データベース認証情報の設定なども一切不要です。必要なのは Docker Desktop だけです。あとは自動的に動きます。

.. Make changes to the app.
.. _develop-Make changes to the app:

アプリを修正する
====================

.. With this environment up and running, you’re ready to make a few changes to the application and see how Docker helps provide a fast feedback loop.

環境を起動し実行できるようになり、アプリケーションに対していくつか変更を加える準備が調いましたので、素早いフィードバックループに Docker が役立つ方法を見ていきましょう。

.. Change the greeting
.. _develop-change-the-greeting:

あいさつ文の変更
------------------------------

.. The greeting at the top of the page is populated by an API call at /api/greeting. Currently, it always returns "Hello world!". You’ll now modify it to return one of three randomized messages (that you'll get to choose).

ページ上部にある :ruby:`あいさつ文 <greeting>` は ``/api/greeting`` への API 呼び出しによって処理されます。現時点では、常に「Hello world!」を返します。これを、3つのランダムなメッセージ（自由に選べる）から1つを返すように修正します。


..    Open the backend/src/routes/getGreeting.js file in a text editor. This file provides the handler for the API endpoint.

1. テキストエディタで ``backend/src/routes/getGreeting.js`` を開きます。このファイルは API エンドポインドの処理を担当します。

..    Modify the variable at the top to an array of greetings. Feel free to use the following modifications or customize it to your own liking. Also, update the endpoint to send a random greeting from this list.

2. 先頭の変数を、複数のあいさつ文を格納する配列に変更します。以降の変更を自由に調整したり、好みに応じてカスタマイズしたりしてください。また、このリストからランダムなあいさつ文を送るには、エンドポイントを更新します。

   .. code-block:: javascript
      :linenos:
      :emphasize-lines: 1-5,9
   
      const GREETINGS = [
          "Whalecome!",
          "All hands on deck!",
          "Charting the course ahead!",
      ];
   
      module.exports = async (req, res) => {
          res.send({
              greeting: GREETINGS[ Math.floor( Math.random() * GREETINGS.length )],
          });
      };

.. If you haven't done so yet, save the file. If you refresh your browser, you should see a new greeting. If you keep refreshing, you should see all of the messages appear.

3. ファイルを保存していなければ、ファイルを保存します。ブラウザを再読み込みすると、新しいあいさつ文が表示されるでしょう。再読み込みを続けると全てのメッセージが表示されます。

   .. image:: images/develop-app-with-greetings.webp
      :alt: ToDo アプリが更新され、テキストフィールの場所が更新されます


.. Change the placeholder text
.. _develop-change-the-placeholder-text:

入力欄の文字を変更
--------------------

.. When you look at the app, you'll see the placeholder text is simply "New Item". You’ll now make that a little more descriptive and fun. You’ll also make a few changes to the styling of the app too.

アプリを見ると、入力欄にはシンプルな「New Item」（新しいアイテム）が見えます。もう少し説明的で楽しいものへ変えましょう。また、アプリのスタイルも新しいものへと変えられます。

..  Open the client/src/components/AddNewItemForm.jsx file. This provides the component to add a new item to the to-do list.
    Modify the placeholder attribute of the Form.Control element to whatever you'd like to display.


1. ``client/src/components/AddNewItemForm.jsx`` ファイルを開きます。これは ToDo リストに新しいアイテムを追加するコンポーネントです。
2. ``From.Control`` 要素の ``placeholder`` 属性を表示したいものへ変えます。

   .. code-block:: jsx
      :linenos:
      :lineno-start: 33
      :emphasize-lines: 5

      <Form.Control
          value={newItem}
          onChange={(e) => setNewItem(e.target.value)}
          type="text"
          placeholder="What do you need to do?"
          aria-label="New item"
      />

.. Save the file and go back to your browser. You should see the change already hot-reloaded into your browser. If you don't like it, feel free to tweak it until it looks just right.

3. ファイルを保存してブラウザに戻ります。ブラウザは既にホットリロードされて見た目が変わっているでしょう。表示が好ましくなければ、適切な見た目へと自由に変えてください。

   .. image:: images/develop-app-with-updated-placeholder.webp
      :alt: ToDo アプリが更新され、入力欄の場所が更新されます

.. Change the background color
.. _deveop-change-the-background-color:

背景色の変更
--------------------

.. Before you consider the application finalized, you need to make the colors better.

アプリケーションを仕上げる前に、色の見栄えを良くする必要があります。

..    Open the client/src/index.scss file.

1. ``client/src/index.scss`` ファイルを開きます。

..    Adjust the background-color attribute to any color you'd like. The provided snippet is a soft blue to go along with Docker's nautical theme.

2. ``background-color`` 属性を好きな色に調整します。提供しているスニペットは Docker の航海テーマと同じ薄い青色です。

   ..    If you're using an IDE, you can pick a color using the integrated color pickers. Otherwise, feel free to use an online Color Picker

   IDE を使っている場合、統合されたカラーピッカーを使って色を選択できます。そうでなければ、オンラインの `カラーピッカー <https://www.w3schools.com/colors/colors_picker.asp>`_ をお使いください。

   .. code-block:: css
      :linenos:
      :lineno-start: 3
      :emphasize-lines: 2
   
      body {
          background-color: #99bbff;
          margin-top: 50px;
          font-family: 'Lato';
      }

   .. Each save should let you see the change immediately in the browser. Keep adjusting it until it's the perfect setup for you.
   
   それぞれを保存すると、ブラウザへ直ちに反映されるでしょう。完璧にセットアップできるまで、調整を続けてください。


   .. image:: images/develop-app-with-updated-client.webp
      :alt: ToDo アプリが更新され、入力欄と背景色が更新されます

.. And with that, you're done. Congrats on updating your website.

以上で完了です。ウェブサイトの更新、お疲れさまでした。

.. Recap
.. _developa-app-recap:

振り返り
==========

.. Before you move on, take a moment and reflect on what happened here. Within a few moments, you were able to:

次に進む前に時間を取り、ここで何をしたかを振り返ります。短時間で、以下のことができるようになりました：

..    Start a complete development project with zero installation effort. The containerized environment provided the development environment, ensuring you have everything you need. You didn't have to install Node, MySQL, or any of the other dependencies directly on your machine. All you needed was Docker Desktop and a code editor.
..    Make changes and see them immediately. This was made possible because 1) the processes running in each container are watching and responding to file changes and 2) the files are shared with the containerized environment.


* インストールの苦労は一切なく、完全な開発プロジェクトをプロジェクトを開始しました。コンテナ化された環境として、必要なすべてがの開発環境が提供されました。マシン上に Node や MySQL など一切他の依存関係をインストールする必要がありませんでした。必要だったのは Docker Desktop とコードエディタのみです。
* 変更をすると直ちに反映されました。これができたのは、1) 各コンテナ内で実行しているプロセスは、ファイル変更を監視して反応するのと、 2) ファイルはコンテナ化された環境に共有されているからです。


.. Docker Desktop enables all of this and so much more. Once you start thinking with containers, you can create almost any environment and easily share it with your team.

Docker Desktop はこれだけでなく多くのことが可能になります。コンテナについて考え始めると、ほぼあらゆる環境を作成でき、チームとも簡単に共有できます。

.. Next steps
.. _develop-app-next-steps:

次のステップ
====================

.. Now that the application has been updated, you’re ready to learn about packaging it as a container image and pushing it to a registry, specifically Docker Hub.

これでアプリケーションを更新したので、コンテナイメージとしてパッケージ化し、とりわけ Docker Hub というリポジトリに送信する方法を学ぶ準備が調いました。

.. raw:: html

   <a href="build-and-push-first-image.html" class="start-button">初めてのイメージ構築と送信</a>



|

.. seealso::

   Develop with containers | Docker Docs
      https://docs.docker.com/get-started/introduction/develop-with-containers/