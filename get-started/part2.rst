.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/get-started/part2/
   doc version: 17.06
      https://github.com/docker/docker.github.io/blob/master/get-started/part2.md
.. check date: 2017/09/02
.. Commits on Aug 26 2017 4445f27581bd2d190ecd69b6ca31b8dc04b2b9e3
.. -----------------------------------------------------------------------------

.. Get Started, Part 2: Containers

========================================
Part2：コンテナ
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 2
       :local:

.. Prerequisites

動作条件
==========

..    Install Docker version 1.13 or higher.
      Read the orientation in Part 1.

* :doc:`Docker バージョン 1.13 以上のインストール </engine/installation/index>`
* :doc:`Part1 <index>` の概要を読んでいること

..    Give your environment a quick test run to make sure you’re all set up:

皆さんの環境でセットアップが完了しているかどうか、素早く確認するには：

.. code-block:: bash

   docker run hello-world

.. Introduction

はじめに
==========

.. It’s time to begin building an app the Docker way. We’ll start at the bottom of the hierarchy of such an app, which is a container, which we cover on this page. Above this level is a service, which defines how containers behave in production, covered in Part 3. Finally, at the top level is the stack, defining the interactions of all the services, covered in Part 5.

Docker の手法でアプリケーションを作り始める時です。コンテナによるアプリケーション階層の底部を、このページで始めましょう。このレベルの上位にあるのがサービスであり、プロダクションにおけるコンテナの挙動を定義します。こちらは :doc:`Part3 <part3>` で扱います。最終的にはスタックの頂上であり、 :doc:`Part5 <part5>` で扱う全サービス挙動の定義です。

..    Stack
    Services
    Container (you are here)

* スタック ``Stack``
* サービス ``Services``
* コンテナ（今ここにいます）

.. Your new development environment

.. _your-new-development-environment:

新しい開発環境
====================

.. In the past, if you were to start writing a Python app, your first order of business was to install a Python runtime onto your machine. But, that creates a situation where the environment on your machine has to be just so in order for your app to run as expected; ditto for the server that runs your app.

Python アプリケーションを書き始めようとする時、自分のマシン上に Python ランタイムをインストールするのが、これまでは一番初めの仕事でした。しかし、サーバ上でもアプリケーションが期待する通りに問題なく動作するには、マシンと同じ環境を作成しなくてはいけません。

.. With Docker, you can just grab a portable Python runtime as an image, no installation necessary. Then, your build can include the base Python image right alongside your app code, ensuring that your app, its dependencies, and the runtime, all travel together.

Docker であれば、移動可能な Python ランタイムをイメージ内に収容しているため、インストールは不要です。そして、ベース Python イメージにはアプリのコードも一緒に構築できますし、アプリを確実に動かすための依存関係やランタイムも全て運べます。

.. These portable images are defined by something called a Dockerfile.

移動可能なイメージは ``Dockerifle`` と呼ばれるモノで定義します。

.. Define a container with a Dockerfile

.. _define-a-container-with-a-dockerfile:

``Dockerfile`` でコンテナの定義
========================================

.. Dockerfile will define what goes on in the environment inside your container. Access to resources like networking interfaces and disk drives is virtualized inside this environment, which is isolated from the rest of your system, so you have to map ports to the outside world, and be specific about what files you want to “copy in” to that environment. However, after doing that, you can expect that the build of your app defined in this Dockerfile will behave exactly the same wherever it runs.

``Dockerfile`` では、コンテナ内の環境で何をするかを定義します。ネットワーク・インターフェースとディスク・ドライバののようなリソースは、システム上の他の環境からは隔離された環境内に仮想化されています。このようなリソースに接続するには、ポートを外の世界にマッピング（割り当て）する必要がありますし、どのファイルを環境に「複製」（copy in）するか指定する必要もあります。しかしながら、これらの作業を ``Dockerfile`` における構築時の定義で済ませておけば、どこで実行しても同じ挙動となります。

.. Dockerfile

``Dockerfile``
====================

.. Create an empty directory. Change directories (cd) into the new directory, create a file called Dockerfile, copy-and-paste the following content into that file, and save it. Take note of the comments that explain each statement in your new Dockerfile.

空ディレクトリを作成します。新しいディレクトリ内にディレクトリを変更（ `cd` ）し、 ``Dockerfile`` という名前のファイルを作成し、以降の内容をファイルにコピー＆ペーストし、保存します。なお、Dockerfile のコメントは、各命令文に対する説明です。

.. code-block:: bash

   # 公式 Python ランタイムを親イメージとして使用
   FROM python:2.7-slim
   
   # 作業ディレクトリを /app に設定
   WORKDIR /app
   
   # 現在のディレクトリの内容を、コンテナ内の /app にコピー
   ADD . /app
   
   # requirements.txt で指定された必要なパッケージを全てインストール
   RUN pip install -r requirements.txt
   
   # ポート 80 番をコンテナの外の世界でも利用可能に
   EXPOSE 80
   
   # 環境変数の定義
   ENV NAME World
   
   # コンテナ起動時に app.py を実行
   CMD ["python", "app.py"]

.. This Dockerfile refers to a couple of files we haven’t created yet, namely app.py and requirements.txt. Let’s create those next.

この ``Dockerfile`` は、 ``app.py`` と ``requirements.txt`` といった、まだ作成していないファイルを参照しています。次はこれらを作りましょう。

.. The app itself

アプリ自身
==========

.. Create two more files, requirements.txt and app.py, and put them in the same folder with the Dockerfile. This completes our app, which as you can see is quite simple. When the above Dockerfile is built into an image, app.py and requirements.txt will be present because of that Dockerfile’s ADD command, and the output from app.py will be accessible over HTTP thanks to the EXPOSE command.

さらに２つのファイルを作成します。 ``requirements.txt`` と ``app.py`` です。これらを ``Dockerfile`` と同じフォルダに入れます。アプリは見ての通り、極めて単純になります。先ほどの ``Dockerfile`` でイメージの構築時、 ``Dockerfile`` の ``ADD`` 命令で ``app.py`` と ``requirements.txt`` をイメージの中に組み込みます。

* requirements.txt

.. code-block:: bash

   Flask
   Redis

* app.py

.. code-block:: bash

   from flask import Flask
   from redis import Redis, RedisError
   import os
   import socket
   
   # Redis に接続
   redis = Redis(host="redis", db=0, socket_connect_timeout=2, socket_timeout=2)
   
   app = Flask(__name__)
   
   @app.route("/")
   def hello():
       try:
           visits = redis.incr("counter")
       except RedisError:
           visits = "<i>cannot connect to Redis, counter disabled</i>"
   
       html = "<h3>Hello {name}!</h3>" \
              "<b>Hostname:</b> {hostname}<br/>" \
              "<b>Visits:</b> {visits}"
       return html.format(name=os.getenv("NAME", "world"), hostname=socket.gethostname(), visits=visits)
   
   if __name__ == "__main__":
       app.run(host='0.0.0.0', port=80)

.. Now we see that pip install -r requirements.txt installs the Flask and Redis libraries for Python, and the app prints the environment variable NAME, as well as the output of a call to socket.gethostname(). Finally, because Redis isn’t running (as we’ve only installed the Python library, and not Redis itself), we should expect that the attempt to use it here will fail and produce the error message.

先ほどの ``pip install -r requirements.txt`` で Python 用の Flask と Redis ライブラリをインストールします。そして、アプリは環境変数 ``NAME`` を表示し、また ``socket.gethostname()`` を呼び出した結果も出力します。しかしながら、 Redis は実行できないため（Python ライブラリをインストールしただけであり、 Redis 自身は入っていません）、実行を試みても失敗し、エラーメッセージを表示するでしょう。

..    Note: Accessing the name of the host when inside a container retrieves the container ID, which is like the process ID for a running executable.

.. note::

   コンテナ内でホスト名の取得を試みると、コンテナ ID を返します。コンテナ ID は実行バイナリにおけるプロセス ID のようなものです。

.. That’s it! You don’t need Python or anything in requirements.txt on your system, nor will building or running this image install them on your system. It doesn’t seem like you’ve really set up an environment with Python and Flask, but you have.

以上です！ システム上に Python や ``requirements.txt`` に書かれているどれもが不要であり、それどころか、システム上にイメージの構築や実行も不要なのです。一見すると環境に Python と Flask をインストールしていませんが、既に持っているのです。

.. Build the app

アプリの構築
====================

.. We are ready to build the app. Make sure you are still at the top level of your new directory. Here’s what ls should show:

アプリを構築する準備が整いました。まだ、新しく作成したディレクトリのトップレベルにいるのを確認します。ここでは ``ls`` は次のようになるでしょう。

.. code-block:: bash

   $ ls
   Dockerfile		app.py			requirements.txt

.. Now run the build command. This creates a Docker image, which we’re going to tag using -t so it has a friendly name.


次は構築コマンドを実行します。これは Docker イメージを作成します。イメージには分かりやすい名前として ``-t`` でタグを指定します。

.. code-block:: bash

   docker build -t friendlyhello .

.. Where is your built image? It’s in your machine’s local Docker image registry:

構築したイメージはどこにあるのでしょうか？ マシン上のローカルにある Docker イメージ・レジストリの中です。

.. code-block:: bash

   $ docker images
   
   REPOSITORY            TAG                 IMAGE ID
   friendlyhello         latest              326387cea398

.. Run the app

アプリの実行
====================

.. Run the app, mapping your machine’s port 4000 to the container’s published port 80 using -p:

アプリの実行にあたり、マシン側のポート 4000 をコンテナの公開ポート 80 に割り当てるには ``-p`` を使います。

.. code-block:: bash

   docker run -p 4000:80 friendlyhello

.. You should see a notice that Python is serving your app at http://0.0.0.0:80. But that message is coming from inside the container, which doesn’t know you mapped port 80 of that container to 4000, making the correct URL http://localhost:4000.

Python がアプリに提供するのは ``http://0.0.0.0:80`` であるのに注意して下さい。しかし、これはコンテナ内で表示されるメッセージであり、コンテナ内からはコンテナのポート 80 番からポート 4000 への割り当ては分かりません。適切な URL は ``http://localhost:4000`` です。

.. Go to that URL in a web browser to see the display content served up on a web page, including “Hello World” text, the container ID, and the Redis error message.

ウェブブラウザで URL を開くと、「Hello World」文字列とコンテナ ID 、Redis エラーメッセージといった内容がウェブページに表示されます。

.. Hello World in browser
.. （図）

.. You can also use the curl command in a shell to view the same content.

シェル上で ``curl`` コマンドを実行しても、同じ内容を表示します。

.. code-block:: bash

   $ curl http://localhost:4000
   
   <h3>Hello World!</h3><b>Hostname:</b> 8fc990912a14<br/><b>Visits:</b> <i>cannot connect to Redis, counter disabled</i>

..    Note: This port remapping of 4000:80 is to demonstrate the difference between what you EXPOSE within the Dockerfile, and what you publish using docker run -p. In later steps, we’ll just map port 80 on the host to port 80 in the container and use http://localhost.

.. note::

   このポート ``4000:80`` の再割り当ては、 ``Dockerfile`` の ``EXPOSE`` での指定とは異なるポートを指定できるデモです。ここでは、 ``docker run -p`` で何を公開（ ``publish`` ）するかを指定しました。後の手順では、ホストのポート 80 をコンテナ内のポート 80 に割り当て、 ``http://localhost`` で接続します。

.. Hit CTRL+C in your terminal to quit.

ターミナル上で ``CTRL+C`` を実行し、終了します。

.. Now let’s run the app in the background, in detached mode:

次はアプリをバックグラウンドで動作するため、デタッチド・モード（detached mode）で実行しましょう。

.. code-block:: bash

   docker run -d -p 4000:80 friendlyhello

.. You get the long container ID for your app and then are kicked back to your terminal. Your container is running in the background. You can also see the abbreviated container ID with docker container ls (and both work interchangeably when running commands):

コマンドを実行しますと、アプリの長いコンテナ ID を表示し、ターミナルに戻ります。コンテナはバックグラウンドで実行中です。なお、 ``docker container ls`` で短縮コンテナ ID を確認できます（コマンド実行時は、長いコンテナ ID と短縮 ID のどちらも利用できます）。

.. code-block:: bash

   $ docker container ls
   CONTAINER ID        IMAGE               COMMAND             CREATED
   1fa4ab2cf395        friendlyhello       "python app.py"     28 seconds ago

.. You’ll see that CONTAINER ID matches what’s on http://localhost:4000.

このように ``http://localhost:4000`` で表示したものと同じコンテナ ID （ ``CONTAINER ID`` ）が表示されます。

.. Now use docker stop to end the process, using the CONTAINER ID, like so:

あとは、プロセスを停止するために ``docker stop`` コマンドでコンテナ ID を次のように指定します。

.. code-block:: bash

   docker stop 1fa4ab2cf395

.. Share your image

.. _share-your-image:

イメージの共有
====================

.. To demonstrate the portability of what we just created, let’s upload our built image and run it somewhere else. After all, you’ll need to learn how to push to registries when you want to deploy containers to production.

作成したイメージの移動性（ポータビリティ）を実証するため、イメージをアップロードし、どこかで動かしましょう。そのためには、コンテナをプロダクションにデプロイする時、どのようにレジストリに送信（push）するかを学ぶ必要があります。

.. A registry is a collection of repositories, and a repository is a collection of images—sort of like a GitHub repository, except the code is already built. An account on a registry can create many repositories. The docker CLI uses Docker’s public registry by default.

レジストリ（registry）はリポジトリの集まりであり、リポジトリとはイメージの集まりです。これは GitHub リポジトリのようなものですが、コードが既に構築済みである点が異なります。レジストリのアカウント（利用者）は多くのリポジトリを作成できます。 ``docker`` コマンドライン・インターフェースは、デフォルトで Docker の公開リポジトリを使います。

..    Note: We’ll be using Docker’s public registry here just because it’s free and pre-configured, but there are many public ones to choose from, and you can even set up your own private registry using Docker Trusted Registry.

.. note::

   ここでは無料に使えて設定済みの Docker 公開レジストリを使いますが、他の公開レジストリからもお選びいただけます。あるいは、 Docker Trusted Regsitry をセットアップすると、自分のプライベートなレジストリも使えます。

.. Log in with your Docker ID

Docker ID でログイン
====================

.. If you don’t have a Docker account, sign up for one at cloud.docker.com. Make note of your username.

Docker アカウントをお持ちでなければ、 `cloud.docker.com <https://cloud.docker.com/>`_ でサインアップ（登録）します。そのとき、ユーザ名をお控えください。

.. Log in to the Docker public registry on your local machine.

自分のローカルマシンから Docker 公開レジストリにログインします。

.. code-block:: bash

   docker login

.. Tag the image

.. _tag-the-image:

イメージのタグ
====================

.. The notation for associating a local image with a repository on a registry is username/repository:tag. The tag is optional, but recommended, since it is the mechanism that registries use to give Docker images a version. Give the repository and tag meaningful names for the context, such as get-started:part1. This will put the image in the get-started repository and tag it as part1.

ローカルのイメージとレジストリ上にあるリポジトリとを関連付ける概念は、 ``ユーザ名/リポジトリ:タグ`` です。タグはオプションですが、指定が推奨されています。これは、レジストリにおける Docker イメージのバージョン指定の仕組みに使う為です。指定するのは ``get-started:part`` のように、レポジトリ名と意味のあるタグ名です。こちらはイメージを ``get-started`` リポジトリに、タグを ``part1`` として送信します。

.. Now, put it all together to tag the image. Run docker tag image with your username, repository, and tag names so that the image will upload to your desired destination. The syntax of the command is:

次はイメージにタグをつけます。 ``docker tag image`` でユーザ名、リポジトリ、タグ名をしていすると、任意の場所へイメージをアップロードします。コマンドの構文は次の通りです。

.. code-block:: bash

   docker tag image ユーザ名/リポジトリ:タグ

.. For example:

例：

.. code-block:: bash

   docker tag friendlyhello john/get-started:part1

.. Run docker images to see your newly tagged image. (You can also use docker image ls.)

:doc:`docker images </engine/reference/commandline/images>` で直近にタグ付けしたイメージを表示します。（ ``docker image ls`` でも同様です）

.. code-block:: bash

   $ docker images
   REPOSITORY               TAG                 IMAGE ID            CREATED             SIZE
   friendlyhello            latest              d9e555c53008        3 minutes ago       195MB
   john/get-started         part1               d9e555c53008        3 minutes ago       195MB
   python                   2.7-slim            1c7128a655f6        5 days ago          183MB
   ...

.. Publish the image

イメージの送信
====================

.. Upload your tagged image to the repository:

タグ付けしたイメージをリポジトリにアップロードします。

.. code-block:: bash

   docker push username/repository:tag

.. Once complete, the results of this upload are publicly available. If you log in to Docker Hub, you will see the new image there, with its pull command.

完了したら、アップロード結果が表示され、誰でも利用可能になります。 `Docker Hub <https://hub.docker.com/>`_ にログインすると、pull コマンドで取得可能な新しいイメージが表示されます。

.. Pull and run the image from the remote repository

リモート・リポジトリにあるイメージの取得と実行
==================================================

.. From now on, you can use docker run and run your app on any machine with this command:

あとは ``docker run`` コマンドをつかい、あらゆるマシン上でアプリを実行できます。

.. code-block:: bash

   docker run -p 4000:80 username/repository:tag

.. If the image isn’t available locally on the machine, Docker will pull it from the repository.

もしもイメージがマシン上のローカルに存在しなければ、 Docker はリポジトリから取得します。

.. code-block:: bash

   docker image rm <iイメージ ID>

.. code-block:: bash

   $ docker run -p 4000:80 john/get-started:part1
   Unable to find image 'john/get-started:part1' locally
   part1: Pulling from orangesnap/get-started
   10a267c67f42: Already exists
   f68a39a6a5e4: Already exists
   9beaffc0cf19: Already exists
   3c1fe835fb6b: Already exists
   4c9f1fa8fcb8: Already exists
   ee7d8f576a14: Already exists
   fbccdcced46e: Already exists
   Digest: sha256:0601c866aab2adcc6498200efd0f754037e909e5fd42069adeff72d1e2439068
   Status: Downloaded newer image for john/get-started:part1
    * Running on http://0.0.0.0:80/ (Press CTRL+C to quit)

..    Note: If you don’t specify the :tag portion of these commands, the tag of :latest will be assumed, both when you build and when you run images. Docker will use the last version of the image that ran without a tag specified (not necessarily the most recent image).

.. note::

   各コマンドで ``:タグ`` を指定しなければ、 ``:latest`` タグが指定されたものとみなされます。これは build 時も run 時も同様です。Docker はイメージに対するタグの指定が無ければ（直近のイメージであれば不要です）、最新版を使います。

.. No matter where docker run executes, it pulls your image, along with Python and all the dependencies from requirements.txt, and runs your code. It all travels together in a neat little package, and the host machine doesn’t have to install anything but Docker to run it.

どこで ``docker run`` を実行したとしても、 Python と ``requirements.txt`` で指定した全ての依存関係と実行するコードが入ったイメージをダウンロード（pull）します。整った小さなパッケージで全てを持ち運びできます。そして、ホストマシン上では Docker さえ実行できれば、何もインストールする必要はありません。

.. Conclusion of part two

パート２のまとめ
====================

.. That’s all for this page. In the next section, we will learn how to scale our application by running this container in a service.

以上でこのページは終わりです。次のセクションでは、 **サービス** としてこのコンテナを実行し、アプリケーションをどのようにスケールするかを学びミズ合う。

.. Continue to Part 3 »

* :doc:`パート３へ進む <part3>`

.. Recap and cheat sheet (optional)

まとめとチート・シート（オプション）
========================================

.. Here’s a terminal recording of what was covered on this page:

`このページで扱ったターミナルを録画したもの <https://asciinema.org/a/blkah0l4ds33tbe06y4vkme6g>`_ がこちらです。

.. Here is a list of the basic Docker commands from this page, and some related ones if you’d like to explore a bit before moving on.

こちらはこのページで扱った Docker の基本コマンドと関連コマンドです。次に進む前に、試してみてはいかがでしょうか。

.. code-block:: bash

   docker build -t friendlyname .               # このディレクトリ内にある DockerCile でイメージ作成
   docker run -p 4000:80 friendlyname  # "friendlyname" の実行にあたり、ポート 4000 を 80 に割り当て
   docker run -d -p 4000:80 friendlyname                            # 同じですが、デタッチド・モード
   docker container ls                                                  # 全ての実行中コンテナを表示
   docker container ls -a                                       # 停止中も含めて全てのコンテナを表示
   docker container stop <hash>                                       # 指定したコンテナを丁寧に停止
   docker container kill <hash>                               # 指定したコンテナを強制シャットダウン
   docker container rm <hash>                                   # マシン上から指定したコンテナを削除
   docker container rm $(docker container ls -a -q)                           # 全てのコンテナを削除
   docker image ls -a                                               # マシン上の全てのイメージを表示
   docker image rm <image id>                                       # マシン上の特定のイメージを削除
   docker image rm $(docker image ls -a -q)                         # マシン上の全てのイメージを削除
   docker login                                       # CLI セッションで Docker の認証を行いログイン
   docker tag <image> username/repository:tag      # レジストリにアップロードする <image> にタグ付け
   docker push username/repository:tag                                  # タグ付けしたイメージを送信
   docker run username/repository:tag                               # レジストリにあるイメージを実行



