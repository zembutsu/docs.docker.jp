.. -*- coding: utf-8 -*-
.. https://docs.docker.com/linux/step_four/
.. doc version: 1.10
.. check date: 2016/4/13
.. -----------------------------------------------------------------------------

.. Build your own image

.. _build-your-own-image-linux:

========================================
自分でイメージを構築
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. The whalesay image could be improved. It would be nice if you didn’t have to think of something to say. And you type a lot to get whalesay to talk.

``whalesay`` イメージを更に改良できます。もしかすると、何も喋らせたくないかもしれません。あるいは、もっと喋らせることもできます。

.. code-block:: bash

   docker run docker/whalesay cowsay boo-boo

.. In this next section, you will improve the whalesay image by building a new version that “talks on its own” and requires fewer words to run.

このセクションでは ``whalesay`` イメージを改良します。（オプションを指定しなくても）「自分で何かを喋る」新しいバージョンのイメージを作成します。実行に必要となるのは、ほんの少しの単語です。

.. Step 1: Open a Docker Quickstart Terminal

.. _step-1-open-a-docker-quickstart-terminal-linux:

ステップ１：Docker クイックスタート・ターミナルを開く
============================================================

.. In this step, you use your favorite text editor to write a short Dockerfile. A Dockerfile describes the software that is “baked” into an image. It isn’t just ingredients tho, it can tell the software what environment to use or what commands to run. Your recipe is going to be very short.

このステップでは、任意のテキストエディタを使い短い Dockerfile を書きます。Dockerfile にはイメージを構成するソフトウェア要素を記述します。Dockerfile は単に素材を記述するだけではありません。どのような環境を使うかや、コンテナの中で実行するコマンドも記述できます。今回の Dockerfile は非常に短いものです。

.. Go back to your terminal window.

1. ターミナル・ウインドウに戻ります。

.. Make a new directory by typing mkdir mydockerbuild and pressing RETURN.

2. 新しいディレクトリを作成するため、 ``mkdir mydockerbuild`` を入力してリターンキーを押します。

.. code-block:: bash

   $ mkdir mydockerbuild

.. This directory serves as the “context” for your build. The context just means it contains all the things you need to build your image.

このディレクトリは構築時の「コンテクスト」（context；内容物）としての役割があります。このコンテクストとは、イメージを構築するために必要な全てを指します。

..    Change to your new directory.

3. 新しいディレクトリに移動します。

    $ cd mydockerbuild

.. Right now the directory is empty.

この時点でディレクトリには何もありません。

.. Create a text file called Dockerfile in your current directory.

4. 現在のディレクトリに ``Dockerfile`` という名称のテキストファイルを作成します。

.. You can use any text editor for example, vi or nano to do this.

``vi`` や ``nano`` などの任意のテキストエディタを使えます。

.. Open your Dockerfile file.

5. Dockerfile ファイルを開きます。

.. Add a line to the file like this:

6. 次のように行を追加します。

.. code-block:: bash

   FROM docker/whalesay:latest

..    The FROM keyword tells Docker which image your image is based on. You are basing your new work on the existing whalesay image.

``FROM`` キーワードは Docker に対してイメージの元となるイメージを伝えます。これから作成する新しいイメージは、既存の ``whalesay`` イメージを使います。

..    Now, add the fortunes program to the image.

7. 次はイメージに ``fortunes`` プログラムを追加します。

.. code-block:: bash

   RUN apt-get -y update && apt-get install -y fortunes

.. The fortunes program has a command that prints out wise sayings for our whale to say. So, the first step is to install it. This line installs the software into the image.

``fortunes`` プログラムは賢そうな言葉を表示するプログラムです。これを今回のこの鯨プログラムに喋らせます。そのための最初のステップは、ソフトウェアのインストールです。この行はイメージ内にソフトウェアをインストールします。

..    Once the image has the software it needs, you instruct the software to run when the image is loaded.

8. イメージに必要なソフトウェアをインストールしたら、イメージの読み込み時に実行するソフトウェアを命令します。

.. code-block:: bash

   CMD /usr/games/fortune -a | cowsay

..    This line tells the fortune program to send its nifty quotes to the cowsay program.

この行は ``fortune`` プログラム（の結果）を、気の利いたことを喋る ``cowsay`` プログラムに送ります。

.. Check your work, your file should look like this:

9. これまでの作業内容を確認します。ファイル内容は次の通りでしょう。

.. code-block:: bash

   FROM docker/whalesay:latest
   RUN apt-get -y update && apt-get install -y fortunes
   CMD /usr/games/fortune -a | cowsay

.. Save and close your Dockerfile.

10. Dockerfile を保存して閉じます。

..    At this point, you have all your software ingredients and behaviors described in a Dockerfile. You are ready to build a new image.

以上で Dockerfile 中にソフトウェア全ての要素と挙動を記述しました。これで新しいイメージを構築する準備が整いました。

.. Step 2: Build an image from your Dockerfile

.. _step-2-build-an-image-from-your-dockerfile-linux:

ステップ２：Dockerfile を使ってイメージ構築
==================================================

..    Now, build your new image by typing the docker build -t docker-whale . command in your terminal (don’t forget the . period).

1. 次は新しいイメージを構築するため ``docker build -t docker-whale .`` コマンドをターミナル上で実行します（最後のピリオド ``.`` を忘れないでください）。

.. code-block:: bash

   $ docker build -t docker-whale .
   Sending build context to Docker daemon 158.8 MB
   ...省略...
   Removing intermediate container a8e6faa88df3
   Successfully built 7d9495d03763

..    The command takes several seconds to run and reports its outcome. Before you do anything with the new image, take a minute to learn about the Dockerfile build process.

このコマンドを実行後、結果が出るまで数秒ほどかかります。この新しいイメージを使う前に、Dockerfile 構築時の流れを学びましょう。

.. Step 3: Learn about the build process

.. _step-3-learn-about-the-build-process-linux:

ステップ３：構築時の流れを学ぶ
==============================

.. The docker build -t docker-whale . command takes the Dockerfile in the current directory, and builds an image called docker-whale on your local machine. The command takes about a minute and its output looks really long and complex. In this section, you learn what each message means.

``docker build -t docker-whale .`` コマンドは、現在のディレクトリ内にある ``Dockerfile`` を使います。そして、自分のマシン上に ``docker-whale`` という名称のイメージを構築します。コマンドの処理には少し時間がかかります。処理結果の表示は少し複雑に見えるでしょう。このセクションでは、各メッセージの意味を学びます。

.. First Docker checks to make sure it has everything it needs to build.

まず Docker は構築時に必要な全てを確認します。

.. code-block:: bash

   Sending build context to Docker daemon 158.8 MB

.. Then, Docker loads with the whalesay image. It already has this image locally as you might recall from the last page. So, Docker doesn’t need to download it.

それから Docker は ``whalesay`` イメージを読み込みます。読み込むイメージは、先ほどのステップで既にローカルにあります。そのため、Docker は改めてダウンロードしません。

.. code-block:: bash

   Step 0 : FROM docker/whalesay:latest
    ---> fb434121fc77

.. Docker moves onto the next step which is to update the apt-get package manager. This takes a lot of lines, no need to list them all again here.

Docker は次の行に移ります。 ``apt-get`` パッケージ・マネージャを更新します。ここでは多くのメッセージが表示されますが、表示されるのは初回だけです。

.. code-block:: bash

   Step 1 : RUN apt-get -y update && apt-get install -y fortunes
    ---> Running in 27d224dfa5b2
   Ign http://archive.ubuntu.com trusty InRelease
   Ign http://archive.ubuntu.com trusty-updates InRelease
   Ign http://archive.ubuntu.com trusty-security InRelease
   Hit http://archive.ubuntu.com trusty Release.gpg
   ....snip...
   Get:15 http://archive.ubuntu.com trusty-security/restricted amd64 Packages [14.8 kB]
   Get:16 http://archive.ubuntu.com trusty-security/universe amd64 Packages [134 kB]
   Reading package lists...
   ---> eb06e47a01d2

.. Then, Docker installs the new fortunes software.

それから、Docker は新しい ``fortunes`` ソフトウェアをインストールします。

.. code-block:: bash

   Removing intermediate container e2a84b5f390f
   Step 2 : RUN apt-get install -y fortunes
    ---> Running in 23aa52c1897c
   Reading package lists...
   Building dependency tree...
   Reading state information...
   The following extra packages will be installed:
     fortune-mod fortunes-min librecode0
   Suggested packages:
     x11-utils bsdmainutils
   The following NEW packages will be installed:
     fortune-mod fortunes fortunes-min librecode0
   0 upgraded, 4 newly installed, 0 to remove and 3 not upgraded.
   Need to get 1961 kB of archives.
   After this operation, 4817 kB of additional disk space will be used.
   Get:1 http://archive.ubuntu.com/ubuntu/ trusty/main librecode0 amd64 3.6-21 [771 kB]
   ...snip......
   Setting up fortunes (1:1.99.1-7) ...
   Processing triggers for libc-bin (2.19-0ubuntu6.6) ...
    ---> c81071adeeb5
   Removing intermediate container 23aa52c1897c

.. Finally, Docker finishes the build and reports its outcome.

最後に Docker は構築終了を画面に表示します。

.. code-block:: bash

   Step 3 : CMD /usr/games/fortune -a | cowsay
    ---> Running in a8e6faa88df3
    ---> 7d9495d03763
   Removing intermediate container a8e6faa88df3
   Successfully built 7d9495d03763

.. Step 4: Run your new docker-whale

.. _step-4-run-your-new-docker-whale-linux:

ステップ４：新しい docker-whale を実行
========================================

.. In this step, you verify the new images is on your computer and then you run your new image.

このステップではコンピュータ上にイメージがあるかどうか確認してから、新しいイメージを実行します。

..    If it isn’t already there, place your cursor at the prompt in your terminal window.

1. ターミナル・ウインドウ上でなければ、画面にカーソルを合わせます。

..    Type docker images and press RETURN.

2. ``docker images`` を実行してリターンキーを押します。

..    This command, you might remember, lists the images you have locally.

このコマンドはローカルにあるイメージの一覧を表示します。覚えておくと良いでしょう。

.. code-block:: bash

   $ docker images
   REPOSITORY           TAG          IMAGE ID          CREATED             VIRTUAL SIZE
   docker-whale         latest       7d9495d03763      4 minutes ago       273.7 MB
   docker/whalesay      latest       fb434121fc77      4 hours ago         247 MB
   hello-world          latest       91c95931e552      5 weeks ago         910 B

..    Run your new image by typing docker run docker-whale and pressing RETURN.

3. 新しいイメージを実行します。``docker run docker-whale`` を入力して、エンターキーを押します。

.. code-block:: bash

   $ docker run docker-whale
    _________________________________________ 
   / "He was a modest, good-humored boy. It  \
   \ was Oxford that made him insufferable." /
    ----------------------------------------- 
             \
              \
               \     
                             ##        .            
                       ## ## ##       ==            
                    ## ## ## ##      ===            
                /""""""""""""""""___/ ===        
           ~~~ {~~ ~~~~ ~~~ ~~~~ ~~ ~ /  ===- ~~~   
                \______ o          __/            
                 \    \        __/             
                   \____\______/   

.. As you can see, you’ve made the whale a lot smarter. It finds its own things to say and the command line is a lot shorter! You may also notice that Docker didn’t have to download anything. That is because the image was built locally and is already available.

ご覧の通り、少し賢くなった鯨プログラムを作りました。コマンドラインで何かを自分で指定すると、その表示もできます！  そして、Docker は何もダウンロードしないことにも注目します。これはイメージをローカルで構築しており、ダウンロードする必要がないからです。

.. Where to go next

次は何をしますか
====================

.. On this page, you learned to build an image by writing your own Dockerfile. You ran your image in a container. In the next section, you take the first step in sharing your image by creating a Docker Hub account.

このページでは自分で Dockerfile を記述し、イメージを構築する方法を学びました。そして、自分のイメージを使ってコンテナを実行しました。次のセクションではイメージを共有する第一歩として、 :doc:`Docker Hub アカウントを作成 <step_five>` します。

.. seealso:: 

   Biuld your own image
      https://docs.docker.com/linux/step_four/
