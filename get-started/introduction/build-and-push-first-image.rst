.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/get-started/introduction/build-and-push-first-image/
   doc version: 27.0
      https://github.com/docker/docs/blob/main/content/get-started/introduction/build-and-push-first-image.md
.. check date: 2025/01/08
.. Commits on Dec 17, 2024 44cce4906f5d743f899b3c8f634c66976b85a6b9
.. -----------------------------------------------------------------------------

.. Build and push your first image
.. _introduction-build-and-push-your-first-image:

========================================
初めてのイメージ構築と送信
========================================

.. raw:: html

   <iframe width="737" height="415" src="https://www.youtube.com/embed/7ge1s5nAa34" title="YouTube video player" frameborder="1" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

----

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _introduction-build-and-pus-first-image-explanation:

説明
==========

.. Now that you've updated the to-do list app, you’re ready to create a container image for the application and share it on Docker Hub. To do so, you will need to do the following:

これで :doc:`ToDo リストアプリ <develop-with-containers>` を更新しましたので、アプリケーションのコンテナイメージを作成し、 Docker Hub 上で共有する準備が調いました。そのためには、以下の作業をします。

..  Sign in with your Docker account
    Create an image repository on Docker Hub
    Build the container image
    Push the image to Docker Hub

1. Docker アカウントにサインイン
2. Docker Hub 上に :ruby:`イメージ <image>` :ruby:`リポジトリ <repository>` を作成
3. コンテナイメージを :ruby:`構築 <build>`
4. Docker Hub にイメージを :ruby:`送信 <push>`

.. Before you dive into the hands-on guide, the following are a few core concepts that you should be aware of.

ハンズオンガイドに進む前に、以下の基本的な概念を理解しておきましょう。

.. Container images
.. _introduction-build-container-image:

コンテナイメージ
--------------------

.. If you’re new to container images, think of them as a standardized package that contains everything needed to run an application, including its files, configuration, and dependencies. These packages can then be distributed and shared with others.

:ruby:`コンテナイメージ <container image>` が全く初めての場合は、アプリケーションの実行に必要なファイルや、設定ファイル、依存関係などを全て含む標準的なパッケージだと考えてください。これらのパッケージは配布したり他人と共有したりできます。

.. Docker Hub
.. _introduction-build-docker-hub:

Docker Hub
--------------------

.. To share your Docker images, you need a place to store them. This is where registries come in. While there are many registries, Docker Hub is the default and go-to registry for images. Docker Hub provides both a place for you to store your own images and to find images from others to either run or use as the bases for your own images.

Docker イメージを共有するには、イメージを保管するための場所が必要です。その場所こそが :ruby:`レジストリ <registory>` です。多くのレジストリがありますが、イメージを扱うのに Docker Hub はデフォルトで頼りになるレジストリです。Docker Hub は自分のイメージを保管する場所としての役割があります。さらに、他人のイメージを見つけて実行するだけでなく、自分のイメージの元（ベース）として使うための場所という役割もあります。

.. In Develop with containers, you used the following images that came from Docker Hub, each of which are Docker Official Images:

:doc:`develop-with-containers` では、 Docker Hub から取得する必要があった以下のイメージは、いずれも :ref:`Docker 公式イメージ（Official Image） <docker-official-images>` と呼ばれます。

..     node - provides a Node environment and is used as the base of your development efforts. This image is also used as the base for the final application image.
   mysql - provides a MySQL database to store the to-do list items
   phpmyadmin - provides phpMyAdmin, a web-based interface to the MySQL database
   traefik  - provides Traefik, a modern HTTP reverse proxy and load balancer that routes requests to the appropriate container based on routing rules

.. Explore the full catalog of Docker Official Images, Docker Verified Publishers, and Docker Sponsored Open Source Software images to see more of what there is to run and build on.

- `node <https://hub.docker.com/_/node>`_ - Node 環境の提供と、開発作業の土台としても使われます。
- `mysql <https://hub.docker.com/_/mysql>`_ - ToDo リスト項目を保管する MySQL データベースを提供します。
- `phpmyadmin <https://hub.docker.com/_/phpmyadmin>`_ - phpMyAdmin という、MySQL データベースに対するウェブベースのインタフェースを提供します。
- `traefik <https://hub.docker.com/_/traefik>`_ - Traefik という、ルーティング規則に基づいて適切なコンテナにリクエストを割り振る、最新の HTTP リバースプロキシとロードバランサを提供します。

.. Explore the full catalog of Docker Official Images, Docker Verified Publishers, and Docker Sponsored Open Source Software images to see more of what there is to run and build on.

実行や構築に使えるイメージの一覧は、 `Docker 公式イメージ <https://hub.docker.com/search?image_filter=official&q=>`_ 、`Docker 認定パブリッシャー <https://hub.docker.com/search?q=&image_filter=store>`_ 、 `Docker スポンサードオープンソースソフトウェア <https://hub.docker.com/search?q=&image_filter=open_source>`_ から探せます。


.. Try it out
.. _introduction-try-it-out-build:

やってみよう
====================

.. In this hands-on guide, you'll learn how to sign in to Docker Hub and push images to Docker Hub repository.

このハンズオンガイドでは、Docker Hub へのサインインの方法と、Docker Hub リポジトリにイメージを送信する方法を学びます。

.. Sign in with your Docker account
.. _introduction-sign-in-with-your-docker-account:

Docker アカウントへのサインイン
========================================

.. To push images to Docker Hub, you will need to sign in with a Docker account.

Docker Hub にイメージを :ruby:`送信 <push>` するには、Docker Hub アカウントにサインインが必要です。

..  Open the Docker Dashboard.
    Select Sign in at the top-right corner.
    If needed, create an account and then complete the sign-in flow.

1. Docker ダッシュボードを開く
2. 左上の角にある **Sign in** を選ぶ
3. 必要な場合はアカウントを作成し、それからサインイン手続きを完了する

.. Once you're done, you should see the Sign in button turn into a profile picture.

完了すると、 **Sign in** ボタンはプロフィール画像に切り替わります。

.. Create an image repository
.. _introduction-create-an-image-repository:

イメージリポジトリの作成
==============================

.. Now that you have an account, you can create an image repository. Just as a Git repository holds source code, an image repository stores container images.

アカウントができましたので、 :ruby:`イメージリポジトリ <image repository>` を作成できます。Git リポジトリがソースコードを保持するように、イメージリポジトリはコンテナイメージを保管する場所です。

..  Go to Docker Hub
   Select Create repository.
   On the Create repository page, enter the following information:
    Repository name - getting-started-todo-app
    Short description - feel free to enter a description if you'd like
    Visibility - select Public to allow others to pull your customized to-do app
    Select Create to create the repository.

1. `Docker Hub <https://hub.docker.com/>`_ に異動します。
2. **Create repository** （リポジトリ作成）をクリックします
3. **Create repository** のページ内では、以下の情報を入力します：

   - **Repository name** （リポジトリ名） - ``getting-started-todo-app``
   - **Short description** （短い説明） - 自由に任意の説明を記入します
   - **Visibility** （表示設定） - **Public** （航海）を選び、カスタマイズした ToDo アプリを誰でも利用できるようにします

.. Build and push the image
.. _introduction-build-and-push-the-image:

イメージの :ruby:`構築 <build>` と :ruby:`送信 <push>`
============================================================

.. Now that you have a repository, you are ready to build and push your image. An important note is that the image you are building extends the Node image, meaning you don't need to install or configure Node, yarn, etc. You can simply focus on what makes your application unique.

これえレポジトリができましたので、イメージの :ruby:`構築 <build>` と :ruby:`送信 <push>` する準備が調いました。重要な注意点として、構築したイメージは Node イメージを拡張したものです。つまり、 Node のインストールや yaml を調整する等の必要はありません。ただアプリケーションをどのように作るかのみ集中できます。


.. raw:: html

   <div class="blockquote">
     <b>イメージや Dockerfile とは何でしょうか？</b>
     <p>簡単に説明すると、コンテナイメージとは、プロセスを実行するために必要な全てが含まれるパッケージと考えられます。今回の場合は Node 環境、バックエンドのコードと、コンパイル済みの React コードが含まれます。</p>
     <p>このイメージを使ってコンテナを実行するあらゆるマシンでは、マシン上に事前に何もインストールしていなくても、アプリケーションを構築および実行できます。</p>
     <p> <code class="docutils literal notranslate"><span class="pre">Dockerfile</span></code>はテキスト（文字列）で書かれたスクリプトであり、イメージをどのように構築するかの命令が書かれています。このクイックスタートでは、リポジトリにはあらかじめ Dockerfile が含まれています。</p>
   </div>


.. tab-set::

    .. tab-item:: CLI

        .. To get started, either clone or download the project as a ZIP file to your local machine.
        
        1. はじめるには、ローカルマシン上にプロジェクトをクローンするか、 `ZIP ファイルとしてダウンロード <https://github.com/docker/getting-started-todo-app/archive/refs/heads/main.zip>`_ します。
        
           .. code-block:: console
           
              $ git clone https://github.com/docker/getting-started-todo-app
        
           プロジェクトをクローンしたら、クローンで作られた新しいディレクトリに移動します：
           
           .. code-block:: console
           
              $ cd getting-started-todo-app
        
        .. Build the project by running the following command, swapping out DOCKER_USERNAME with your username.
        
        2. 以下のコマンドの ``DOCKER_USERNAME`` を自分のユーザ名に置き換えてから、プロジェクトを構築します。
        
           .. code-block:: console
           
              $ docker build -t <DOCKER_USERNAME>/getting-started-todo-app .
        
        .. To verify the image exists locally, you can use the docker image ls command:
        
        3. イメージがローカルにあるかどうか確認するには、 ``docker image ls`` コマンドを使えます。
        
           .. code-block:: console
           
              $ docker image ls
        
           .. You will see output similar to the following:
           
           次のような出力になるでしょう
           
           .. code-block:: console
           
               REPOSITORY                          TAG       IMAGE ID       CREATED          SIZE
               mobydock/getting-started-todo-app   latest    1543656c9290   2 minutes ago    1.12GB
               ...

        .. To push the image, use the `docker push` command. Be sure to replace `DOCKER_USERNAME` with your username:
        
        4. イメージを ``docker push`` コマンドを使って送信します。 ``DOCKER_USERNAME`` は自分のユーザ名に置き換えてから実行します。
        
           .. code-block:: console
           
              $ docker push <DOCKER_USERNAME>/getting-started-todo-app
        
           .. Depending on your upload speeds, this may take a moment to push.
        
           アップロード速度にもよりますが、送信には少し時間がかかる場合があります。


    .. tab-item:: VS Code

        .. Open Visual Studio Code. In the File menu, select Open Folder. Choose Clone Git Repository and paste this URL: https://github.com/docker/getting-started-todo-app
        
        1. Visual Studio Code を開きます。 **ソース管理** メニューから **リポジトリの複製** を選びます。または、ようこそタブで **GIt リポジトリのクローン** をクリックします。それから URL ``https://github.com/docker/getting-started-todo-app`` をペーストします。
        
           .. image:: images/clone-the-repo.webp
              :alt: リポジトリを VS code でクローンする方法

        .. Right-click the Dockerfile and select the Build Image... menu item.
        
        2. ``Dockerfile`` を右クリックし、 **Build Image** 項目を選びます。

           .. image:: images/build-vscode-menu-item.webp
              :alt: 表示されている項目を右クリックし、「Build Image」メニューを選択

        .. In the dialog that appears, enter a name of DOCKER_USERNAME/getting-started-todo-app, replacing DOCKER_USERNAME with your Docker username.
        
        3. 入力欄には ``DOCKER_USERNAME/getting-started-todo-app`` の ``DOCKER_USERNAME`` を自分の Docker ユーザ名に置き換えて入力します。

        .. After pressing Enter, you'll see a terminal appear where the build will occur. Once it's completed, feel free to close the terminal.
        
        4. エンターキーを押すと、構築状況が分かるターミナルが開きます。構築が終われば、ターミナルを閉じて構いません。
        
        .. Open the Docker Extension for VS Code by selecting the Docker logo in the left nav menu.
        
        5. VS Code 用 Docker Extension を開くには、左ナビゲーションメニュー内の Docker ロゴをクリックします。
        

        .. Find the image you created. It'll have a name of docker.io/DOCKER_USERNAME/getting-started-todo-app.
        
        6. 作成したイメージを探します。名前は ``docker.io/DOCKER_USERNAME/getting-started-todo-app`` の形式です。
        
        .. Expand the image to view the tags (or different versions) of the image. You should see a tag named latest, which is the default tag given to an image.
        
        7. イメージ名をクリックして展開すると、イメージ名のタグ（または異なるバージョン）が表示されます。イメージのデフォルトのタグを使う場合は、 ``latest`` （最新）のタグが見えるでしょう。

        .. Right-click on the latest item and select the Push... option.
        
        8. **latest** 項目を右クリックしてから、 **Push** （送信）オプションを選びます。

           .. image:: images/build-vscode-push-image.webp
              :alt: Docker Extension で右クリックし、イメージを送信


        .. Press Enter to confirm and then watch as your image is pushed to Docker Hub. Depending on your upload speeds, it might take a moment to push the image. Once the upload is finished, feel free to close the terminal.
        
        9. **Enter** を押して確認の後、Docker Hub にイメージが送信されるのを見ましょう。アップロード速度によりますが、イメージ送信には少し時間がかかる場合があります。アップロードが完了したら、ターミナルは閉じて構いません。


.. Recap
.. _build-and-push-first-image-recap:

振り返り
==========

.. Before you move on, take a moment and reflect on what happened here. Within a few moments, you were able to build a container image that packages your application and push it to Docker Hub.

次に進む前に時間を取り、ここで何をしたかを振り返ります。短時間で、アプリケーションをパッケージ化したコンテナイメージを構築し、それを Docker Hub へ送信できるようになりました。

.. Going forward, you’ll want to remember that:

次に進む前に、以下の項目を覚えておきましょう。

..  Docker Hub is the go-to registry for finding trusted content. Docker provides a collection of trusted content, composed of Docker Official Images, Docker Verified Publishers, and Docker Sponsored Open Source Software, to use directly or as bases for your own images.
    Docker Hub provides a marketplace to distribute your own applications. Anyone can create an account and distribute images. While you are publicly distributing the image you created, private repositories can ensure your images are accessible to only authorized users.

* 信頼できる内容（のイメージ）を探すためには、Docker Hub が頼りになります。Docker が提供するのはDocker 公式イメージ集、Docker 認定パブリッシャー、Docker スポンサードオープンソースソフトウェアといった内容の信頼できるイメージであり、自分が使うためのベース（土台）として直接利用できます。
* Docker Hub は、自分のアプリケーションを配布するマーケットプレイスとしての機能も提供します。誰でもアカウントを作成し、イメージを配布できます。作成したイメージは誰にでも配布できますが、プライベートリポジトリの設定によって許可したユーザのみがイメージにアクセス可能にできます。

.. raw:: html

   <div class="blockquote">
     <b>その他のリポジトリを使うには</b>
     <p>Docker Hub はデフォルトのレジストリですが、レジストリとは `Open Container Initiative <https://opencontainers.org/>`_ によって相互運用性を確保された標準規格です。これにより、会社や組織は自身のプライベートなリポジトリを運用できます。Docker Hub からプライベートリポジトリに信頼できる内容をミラー（またはコピー）するのは、かなりよくあります。</p>
   </div>


.. Next steps
.. _build-and-push-next-steps:

次のステップ
====================

.. Now that you’ve built an image, it's time to discuss why you as a developer should learn more about Docker and how it will help you in your day-to-day tasks.

これでイメージを構築できましたので、どうして開発者が Docker について更に学ぶべきなのか、そして、Docker が日々のタスクに役立つのかを検討していきましょう。

.. raw:: html

   <a href="whats-next.html" class="start-button">次に進む</a>



|

.. seealso::

   Build and push your first image | Docker Docs
      https://docs.docker.com/get-started/introduction/build-and-push-first-image/

