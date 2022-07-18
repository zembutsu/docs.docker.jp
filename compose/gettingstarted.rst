.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/gettingstarted/
.. SOURCE: 
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/gettingstarted.md
   doc version: v20.10
      https://github.com/docker/docker.github.io/blob/master/compose/gettingstarted.md
.. check date: 2022/07/16
.. Commits on Jul 15, 2022 a9b15d6253d4f8a8c4dfb5922ceb1e62eb9c1980
.. -------------------------------------------------------------------


.. Get started with Docker Compose
.. _get-started-with-docker-compose:

=======================================
Compose を始めましょう
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:


.. On this page you build a simple Python web application running on Docker Compose. The application uses the Flask framework and maintains a hit counter in Redis. While the sample uses Python, the concepts demonstrated here should be understandable even if you’re not familiar with it.

このページにおいて Docker Compose 上で動く簡単な Python ウェブ アプリケーションを作り出しましょう。このアプリケーションは Flask フレームワークを使い、Redis を使ってアクセスカウンタを管理します。このサンプルでは Python を用いていますが、たとえ Python に詳しくない方でも、ここに示す概念は十分に理解できるようになっています。

.. Prerequisites
.. _compose-gettingstarted-prerequisites:
必要条件
==========

.. Make sure you have already installed both Docker Engine and Docker Compose. You don’t need to install Python or Redis, as both are provided by Docker images.

.. Make sure you have already installed both Docker Engine and Docker Compose. You don’t need to install Python, it is provided by a Docker image.

:doc:`Docker Engine</get-docker>` と :doc:`Docker Compose</compose/install>` がインストール済かどうか確認します。Python と Redis はインストール不要です。どちらも Docker イメージで提供されます。

.. Step 1: Setup
.. _compose-gettingstarted-step1:
ステップ１：セットアップ
==============================

..   Define the application dependencies.

アプリケーションの依存関係を定義します。

.. Create a directory for the project:

1. プロジェクト用のディレクトリを作成します。

.. code-block:: bash

   $ mkdir composetest
   $ cd composetest

.. Create a file called app.py in your project directory and paste this in:`

2. プロジェクトのディレクトリ内に ``app.py`` という名前のファイルを作成し、以下の内容を貼り付けます。

.. code-block:: python

   import time
   
   import redis
   from flask import Flask
   
   app = Flask(__name__)
   cache = redis.Redis(host='redis', port=6379)
   
   def get_hit_count():
       retries = 5
       while True:
           try:
               return cache.incr('hits')
           except redis.exceptions.ConnectionError as exc:
               if retries == 0:
                   raise exc
               retries -= 1
               time.sleep(0.5)
   
   @app.route('/')
   def hello():
       count = get_hit_count()
       return 'Hello World! I have been seen {} times.\n'.format(count)

.. In this example, redis is the hostname of the redis container on the application’s network. We use the default port for Redis, 6379.

この例では、 ``redis`` とはアプリケーションのネットワーク上にある redis コンテナのホスト名です。Redis 用のポートとしてデフォルトの ``6379`` を使います。

..     Handling transient errors
    Note the way the get_hit_count function is written. This basic retry loop lets us attempt our request multiple times if the redis service is not available. This is useful at startup while the application comes online, but also makes our application more resilient if the Redis service needs to be restarted anytime during the app’s lifetime. In a cluster, this also helps handling momentary connection drops between nodes.

   .. note::
   
      **一時的なエラーの対応**
      
      この手順では ``get_hit_count`` 関数を書いています。redis サービスが利用できなければ、この基本的な再試行ループで、複数回のリクエストを試みます。これはアプリケーションが立ち上がる場面で役立つだけでなく、アプリの実行中に Redis サービスの再起動が必用な場合にも、アプリケーションに :ruby:`回復力 <resilient>` をもたらします。クラスタ内では、ノード間での瞬間的な途絶を扱う処理でも役立ちます。

.. Create another file called requirements.txt in your project directory and paste this in:

3. プロジェクトのディレクトリ内に別の ``requirements.txt`` を作成し、以下の内容を貼り付けます。

.. code-block:: text

   flask
   redis

.. Step 2: Create a Dockerfile
.. _compose-gettingstarted-step2:
ステップ２：Dockerfile の作成
=============================

.. In this step, you write a Dockerfile that builds a Docker image. The image contains all the dependencies the Python application requires, including Python itself.

このステップでは、 Docker イメージを構築する Dockerfile を書きます。そのイメージには Python 自身を含む、 Python アプリケーションが必要とする全ての依存関係を含みます。

.. In your project directory, create a file named Dockerfile and paste the following:

プロジェクトのディレクトリ内で、 ``Dockerfile`` という名前のファイルを作成し、以下の内容を貼り付けます。

.. code-block:: dockerfile

   # syntax=docker/dockerfile:1
   FROM python:3.7-alpine
   WORKDIR /code
   ENV FLASK_APP=app.py
   ENV FLASK_RUN_HOST=0.0.0.0
   RUN apk add --no-cache gcc musl-dev linux-headers
   COPY requirements.txt requirements.txt
   RUN pip install -r requirements.txt
   EXPOSE 5000
   COPY . .
   CMD ["flask", "run"]

これは Docker に対して指示を伝えます。

..   Build an image starting with the Python 3.7 image.
    Set the working directory to /code.
    Set environment variables used by the flask command.
    Install gcc and other dependencies
    Copy requirements.txt and install the Python dependencies.
    Add metadata to the image to describe that the container is listening on port 5000
    Copy the current directory . in the project to the workdir . in the image.
    Set the default command for the container to flask run.

* Python 3.7 イメージでイメージの構築を開始
* :ruby:`作業ディレクトリ <working directory>` を ``/code`` に指定
* ``flask`` コマンドが使う環境変数を指定
* gcc と他の依存関係をインストール
* ``requirements.txt`` をコピーし、Python 依存関係をインストール
* コンテナがポート 5000 をリッスンするよう、イメージに対してメタデータの記述を追加
* プロジェクト内にある現在のディレクトリ ``.`` を、イメージ内の :ruby:`作業ディレクトリ <workdir>` ``.`` にコピー
* コンテナ実行時のデフォルト コマンド ``flask run`` を指定

.. For more information on how to write Dockerfiles, see the Docker user guide and the Dockerfile reference.

Dockerfile の書き方についての詳細は、 :doc:`Docker ユーザガイド </develop/index>` と :doc:`Dockerfile リファレンス </engine/reference/builder>` をご覧ください。

.. Step 3: Define services in a Compose file
.. _compose-gettingstarted-step3:
ステップ３：Compose ファイル内でサービスを定義
==============================================

.. Create a file called docker-compose.yml in your project directory and paste the following:

プロジェクトのディレクトリに移動し、 ``docker-compose.yml`` という名前のファイルを作成し、以下の内容を貼り付けます。

.. code-block:: yaml

   version: "3.9"
   services:
     web:
       build: .
       ports:
         - "8000:5000"
     redis:
       image: "redis:alpine"

.. This Compose file defines two services: web and redis.

この Compose ファイルは ``web`` と ``redis`` という２つのサービスを定義します。

.. Web service
web サービス
--------------------

.. The web service uses an image that’s built from the Dockerfile in the current directory. It then binds the container and the host machine to the exposed port, 8000. This example service uses the default port for the Flask web server, 5000.

``web`` サービスは、現在のディレクトリ内にある ``Dockerfile`` から構築したイメージを使います。それから、コンテナのポートと、ホストマシン上に公開するポート ``8000`` を :ruby:`結び付け <bind>` ます。この例にあるサービスは、 Flask ウェブサーバのデフォルト ポート ``5000`` を使います。

.. Redis service
redis サービス
--------------------

.. The redis service uses a public Redis image pulled from the Docker Hub registry.

``redis`` サービスは、 Docker Hub レジストリにある公開 `Redis <https://registry.hub.docker.com/_/redis/>`_ イメージを使います。

.. Step 4: Build and run your app with Compose
.. _compose-gettingstarted-step4:
ステップ４：Compose によるアプリケーションの構築と実行
======================================================

.. From your project directory, start up your application by running docker compose up.

1. プロジェクトのディレクトリで ``docker-compose up`` を実行し、アプリケーションを起動します。

   .. code-block:: bash
   
      $ docker compose up
      
      Creating network "composetest_default" with the default driver
      Creating composetest_web_1 ...
      Creating composetest_redis_1 ...
      Creating composetest_web_1
      Creating composetest_redis_1 ... done
      Attaching to composetest_web_1, composetest_redis_1
      web_1    |  * Running on http://0.0.0.0:5000/ (Press CTRL+C to quit)
      redis_1  | 1:C 17 Aug 22:11:10.480 # oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
      redis_1  | 1:C 17 Aug 22:11:10.480 # Redis version=4.0.1, bits=64, commit=00000000, modified=0, pid=1, just started
      redis_1  | 1:C 17 Aug 22:11:10.480 # Warning: no config file specified, using the default config. In order to specify a config file use redis-server /path/to/redis.conf
      web_1    |  * Restarting with stat
      redis_1  | 1:M 17 Aug 22:11:10.483 * Running mode=standalone, port=6379.
      redis_1  | 1:M 17 Aug 22:11:10.483 # WARNING: The TCP backlog setting of 511 cannot be enforced because /proc/sys/net/core/somaxconn is set to the lower value of 128.
      web_1    |  * Debugger is active!
      redis_1  | 1:M 17 Aug 22:11:10.483 # Server initialized
      redis_1  | 1:M 17 Aug 22:11:10.483 # WARNING you have Transparent Huge Pages (THP) support enabled in your kernel. This will create latency and memory usage issues with Redis. To fix this issue run the command 'echo never > /sys/kernel/mm/transparent_hugepage/enabled' as root, and add it to your /etc/rc.local in order to retain the setting after a reboot. Redis must be restarted after THP is disabled.
      web_1    |  * Debugger PIN: 330-787-903
      redis_1  | 1:M 17 Aug 22:11:10.483 * Ready to accept connections

   .. Compose pulls a Redis image, builds an image for your code, and starts the services you defined. In this case, the code is statically copied into the image at build time.
   Compose は Redis イメージを取得し、コードのためのイメージを構築し、それから定義したサービスを起動します。この例では、イメージの構築時に、コードは静的にコピーされます。

.. Enter http://localhost:8000/ in a browser to see the application running.

2. ブラウザで ``http://0.0.0.0:8000/`` を開き、アプリケーションの稼動を確認します。

   .. If you’re using Docker natively on Linux, Docker Desktop for Mac, or Docker Desktop for Windows, then the web app should now be listening on port 8000 on your Docker daemon host. Point your web browser to http://localhost:8000 to find the Hello World message. If this doesn’t resolve, you can also try http://127.0.0.1:8000.

   Linux 上で Docker をネイティブに使っている場合や、 Docker Desktop for Mac 、 Docker Desktop for Windows の場合、これでウェブアプリは Docker デーモンのホスト上でポート 8000 をリッスンします。ウェブブラウザで http://localhost:8000 を開き、 ``Hello World`` メッセージを確認します。表示できなければ、 http://127.0.0.1:8000 で試します。

   .. You should see a message in your browser saying:
   
   ブラウザに次のような文字が表示されるでしょう。
   
   ::
   
     Hello World! I have been seen 1 times.

   .. image:: images/quick-hello-world-1.png
      :scale: 60%
      :alt: ブラウザで hello world

.. Refresh the page.

3. このページを再読み込みします。

   .. The number should increment.

   数字が増えます。

   ::

      Hello World! I have been seen 2 times.

   .. image:: images/quick-hello-world-2.png
      :scale: 60%
      :alt: ブラウザで hello world

.. Switch to another terminal window, and type docker image ls to list local images.

4. 他のターミナルウインドウに切り替え、ローカルにあるイメージを一覧表示する ``docker image ls`` を入力します。

   .. Listing images at this point should return redis and web.

   この時点の一覧では ``redis`` と ``web`` が表示されます。

   .. code-block:: bash
   
      $ docker image ls
      
      REPOSITORY        TAG           IMAGE ID      CREATED        SIZE
      composetest_web   latest        e2c21aa48cc1  4 minutes ago  93.8MB
      python            3.4-alpine    84e6077c7ab6  7 days ago     82.5MB
      redis             alpine        9d8fa9aa0e5b  3 weeks ago    27.5MB

   .. You can inspect images with docker inspect <tag or id>.
   
   ``docker inspect <タグ または id>`` でイメージを確認できます。

.. Stop the application, either by running docker compose down from within your project directory in the second terminal, or by hitting CTRL+C in the original terminal where you started the app.

5. アプリケーションを停止するには、2つめのターミナル内のプロジェクトディレクトリ内で ``docker comopse down`` を実行するか、アプリを起動した元々のターミナルで CTRL+C を実行します。

.. Step 5: Edit the Compose file to add a bind mount
.. _compose-gettingstarted-step5:
ステップ５：Compose ファイルに :ruby:`バインド マウント <bind mount>` を追加
================================================================================

.. Edit docker-compose.yml in your project directory to add a bind mount for the web service:

プロジェクトのディレクトリ内にある ``docker-compose.yml`` を編集し、 ``web`` サービスに :doc:`バインド マウント </storage/bind-mounts>` を追加します。

.. code-block:: yaml

   version: "3.9"
   services:
     web:
       build: .
       ports:
         - "8000:5000"
       volumes:
         - .:/code
       environment:
         FLASK_ENV: development
     redis:
       image: "redis:alpine"

.. The new volumes key mounts the project directory (current directory) on the host to /code inside the container, allowing you to modify the code on the fly, without having to rebuild the image. The environment key sets the FLASK_ENV environment variable, which tells flask run to run in development mode and reload the code on change. This mode should only be used in development.

新しい ``volumes`` キーは、ホスト上のプロジェクトがあるディレクトリ（現在のディレクトリ）を、コンテナ内の ``/code`` にマウントします。これにより、イメージを再構築しなくても、実行しながらコードを変更できるようになります。 ``environment`` キーは環境変数 ``FLASK_ENV`` を設定します。これは ``flask run`` に対し、開発モードでの実行と、コードに変更があれば再読込するように伝えます。このモードは開発環境下でのみ使うべきです。

.. Step 6: Re-build and run the app with Compose
.. _compose-gettingstarted-step6:
ステップ６：Compose でアプリの再構築と実行
==============================================

.. From your project directory, type docker compose up to build the app with the updated Compose file, and run it.

プロジェクトのディレクトリで、更新した Compose ファイルでアプリを構築して実行するため、 ``docker compose up`` を入力します。

.. code-block:: bash

   $ docker compose up
   
   Creating network "composetest_default" with the default driver
   Creating composetest_web_1 ...
   Creating composetest_redis_1 ...
   Creating composetest_web_1
   Creating composetest_redis_1 ... done
   Attaching to composetest_web_1, composetest_redis_1
   web_1    |  * Running on http://0.0.0.0:5000/ (Press CTRL+C to quit)

.. Check the Hello World message in a web browser again, and refresh to see the count increment.

``Hello World`` メッセージをウェブブラウザで再度確認すると、再読込で数値が増えるのが分かります。

..   Shared folders, volumes, and bind mounts
        If your project is outside of the Users directory (cd ~), then you need to share the drive or location of the Dockerfile and volume you are using. If you get runtime errors indicating an application file is not found, a volume mount is denied, or a service cannot start, try enabling file or drive sharing. Volume mounting requires shared drives for projects that live outside of C:\Users (Windows) or /Users (Mac), and is required for any project on Docker Desktop for Windows that uses Linux containers. For more information, see File sharing on Docker for Mac, and the general examples on how to Manage data in containers.
        If you are using Oracle VirtualBox on an older Windows OS, you might encounter an issue with shared folders as described in this VB trouble ticket. Newer Windows systems meet the requirements for Docker Desktop for Windows and do not need VirtualBox.

.. important::

   **共有フォルダ、ボリューム、バインド マウント**
   
   * プロジェクトが ``Users`` ディレクトリ（ ``cd ~`` ）の外にある場合、Dockerfile とボリュームが使おうとしているドライブや場所を共有する必要があります。実行時にアプリケーションのファイルが見つからないというエラーが出た場合、ボリューム マウントが拒否されているか、サービスが起動できないため、ファイルまたはドライブの共有を試します。ボリューム マウントには、 ``C:\Users`` （Windows）や ``/Users`` （Mac）の外でプロジェクト用の共有ドライブが必要となります。そのため、Docker Desktop for Windows 上のあらゆるプロジェクトは :ref:`Linux コンテナー <switch-between-windows-and-linux-containers>` が必要です。詳しい情報は、 Docker for Mac の :ref:`ファイル共有 <mac-file-sharing>` と、一般的な設定については :doc:`コンテナ内でのデータ管理 </storage/volumes>` をご覧ください。
   * 古い Windows OS 上で Oracle VirtualBox を使っている場合、 `VB trouble ticket <https://www.virtualbox.org/ticket/14920>`_ に示されている共有フォルダに関する問題が起こるかもしれません。より新しい Windows システムであれば、 :doc:`Docker for Windows </desktop/install/windows-install>` の要件を満たすため、VirtualBox は必要としません。

.. Step 7: Update the application
.. _compose-gettingstarted-step7:
ステップ７：アプリケーションの更新
==================================

.. Because the application code is now mounted into the container using a volume, you can make changes to its code and see the changes instantly, without having to rebuild the image.

アプリケーションのコードはボリュームを使いコンテナ内にマウントしましたので、コードに対する変更は、イメージを再構築しなくても、直ちに確認できるようになります。

.. Change the greeting in app.py and save it. For example, change the Hello World! message to Hello from Docker!:

``app.py`` の挨拶を書き換え、保存します。たとえば、 ``Hello World!`` メッセージを ``Hello from Docker!`` に変更します。

.. code-block:: bash

   return 'Hello from Docker! I have been seen {} times.\n'.format(count)

.. Refresh the app in your browser. The greeting should be updated, and the counter should still be incrementing.


ブラウザでアプリを再読み込みします。挨拶が更新され、さらにカウンタも増え続けます。

   .. image:: images/quick-hello-world-2.png
      :scale: 60%
      :alt: ブラウザで hello world

.. Step 8: Experiment with some other commands
.. _compose-gettingstarted-step8:
ステップ８：その他のコマンドを試す
==================================

バックグラウンドでサービスを実行したい場合は、 ``docker compose up`` に ``-d`` フラグ（これは「 :ruby:`デタッチド <detached>` 」モード）を付けて、 ``docker compose ps`` で現在の実行状況を確認します。

.. code-block:: bash

   $ docker compose up -d
   
   Starting composetest_redis_1...
   Starting composetest_web_1...
   
   $ docker compose ps
   
          Name                      Command               State           Ports         
   -------------------------------------------------------------------------------------
   composetest_redis_1   docker-entrypoint.sh redis ...   Up      6379/tcp              
   composetest_web_1     flask run                        Up      0.0.0.0:8000->5000/tcp

.. The docker compose run command allows you to run one-off commands for your services. For example, to see what environment variables are available to the web service:

``docker compose run`` コマンドは、サービスに対して一度だけコマンドを実行できます。たとえば、 ``web`` サービスに対し、環境変数が何かを見るには、次のようにします：

.. code-block:: bash

   $ docker compose run web env

.. See docker compose --help to see other available commands.

``docker compose --help`` で、他の利用可能なコマンドを確認できます。

.. If you started Compose with docker compose up -d, stop your services once you’ve finished with them:

``docker compose up -d`` で Compose を起動した場合は、サービスを :ruby:`停止 <stop>` するために、次のコマンドを実行します。

.. code-block:: bash

   $ docker compose stop

.. You can bring everything down, removing the containers entirely, with the down command. Pass --volumes to also remove the data volume used by the Redis container:

コンテナ全体を削除し、全てを終了するには、 ``down`` コマンドを使います。 ``--volumes`` を追加すると、 Redis コンテナによって使われたデータ ボリュームも削除します。

.. code-block:: bash

   $ docker compose down --volumes

.. At this point, you have seen the basics of how Compose works.

これで、 Compose がどのように機能するかの基本が分かりました。

.. Where to go next
次は何を読みますか
==================

..
    Next, try the Sample apps with Compose
    Explore the full list of Compose commands
    Compose configuration file reference
    To learn more about volumes and bind mounts, see Manage data in Docker

* 次は、:doc:`Compose のサンプルアプリ <samples-for-compose>` を試しましょう。
* :doc:`Compose コマンドの一覧を調べる </compose/reference/index>`
* :doc:`Compose 設定ファイル リファレンス </compose/compose-file>`
* ボリュームやバインド マウントについて学ぶには :doc:`Docker のデータ管理 </storage/index>` をご覧ください。

.. seealso:: 

   Get started with Docker Compose
      https://docs.docker.com/compose/gettingstarted/
