.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/gettingstarted/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/gettingstarted.md
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/gettingstarted.md
.. check date: 2016/04/28
.. Commits on Feb 24, 2016 e6797e116648fb566305b39040d5fade83aacffc
.. -------------------------------------------------------------------

.. Getting Started

=======================================
Compose を始めましょう
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. On this page you build a simple Python web application running on Compose. The application uses the Flask framework and increments a value in Redis. While the sample uses Python, the concepts demonstrated here should be understandable even if you’re not familiar with it.

このページにおいて Docker Compose 上で動く簡単な Python ウェブ・アプリケーションを作り出していきましょう。このアプリケーションは Flask フレームワークを使うもので、Redis を使ってアクセスカウンタを管理します。このサンプルでは Python を用いていますが、たとえ Python に詳しくない方でも、ここに示す考え方は十分に理解できるようになっています。

.. Prerequisites

必要条件
==========

.. Make sure you have already installed both Docker Engine and Docker Compose. You don’t need to install Python, it is provided by a Docker image.

:doc:`Docker Engine</engine/installation/index>` と :doc:`Docker Compose</compose/install>` がインストール済であること。Python と Redis はインストールしておく必要はなく、いずれも Docker イメージによって提供されます。

.. Step 1: Setup

ステップ１：セットアップ
==============================

..   Define the application dependencies.

アプリケーションの依存関係を定義します。

.. Create a directory for the project:

1. プロジェクト用のディレクトリを作成します。

.. code-block:: bash

   $ mkdir composetest
   $ cd composetest

.. With your favorite text editor create a file called app.py in your project directory.

2. プロジェクト用のディレクトリに移動し、好みのエディタで ``app.py`` という名称のファイルを作成します。

.. code-block:: python

   from flask import Flask
   from redis import Redis
   
   app = Flask(__name__)
   redis = Redis(host='redis', port=6379)
   
   @app.route('/')
   def hello():
       count = redis.incr('hits')
       return 'Hello World! I have been seen {} times.\n'.format(count)
   
   if __name__ == "__main__":
       app.run(host="0.0.0.0", debug=True)

..         In this example, `redis` is the hostname of the redis container on the application's network. We use the default port for Redis, `6379`.

この例において ``redis`` とはアプリケーションネットワーク上にある redis コンテナのホスト名です。Redis のポートとしてデフォルトの ``6379`` を利用します。

.. Create another file called requirements.txt in your project directory and add the following:

3. プロジェクト用のディレクトリで、もう一つ ``requirements.txt`` という名称のファイルを作成し、次のようにします。

.. code-block:: text

   flask
   redis

.. Step 2: Create a Dockerfile

ステップ２：Dockerfile の作成
=============================

..   In this step, you write a Dockerfile that builds a Docker image. The image
     contains all the dependencies the Python application requires, including Python

このステップでは、Docker イメージを構築する Dockerfile を作ります。そのイメージには依存するすべてもの、つまり Python と Python アプリケーションが含まれます。

..   In your project directory, create a file named `Dockerfile` and paste the
     following:

プロジェクト用のディレクトリ内で、``Dockerfile`` という名称のファイルを作成し、次の内容にします。

.. code-block:: dockerfile

   FROM python:3.4-alpine
   ADD . /code
   WORKDIR /code
   RUN pip install -r requirements.txt
   CMD ["python", "app.py"]

.. This tells Docker to:

これは Docker に対して以下の指示を行います。

..    Build an image starting with the Python 3.4 image.
    Add the current directory `.` into the path `/code` in the image.
    Set the working directory to `/code`.
    Install the Python dependencies.
    Set the default command for the container to `python app.py`.

* Python 3.4 イメージを使って、イメージを構築する
* カレントディレクトリ ``.`` を、イメージ内のパス ``/code`` に加える
* 作業用ディレクトリを ``/code`` に指定する
* Python の依存パッケージをインストールする
* コンテナに対するデフォルトのコマンドを ``python app.py`` にする

.. For more information on how to write Dockerfiles, see the [Docker user
   guide](/engine/tutorials/dockerimages.md#building-an-image-from-a-dockerfile)
   and the [Dockerfile reference](/engine/reference/builder.md).

Dockerfile の書き方の詳細については、 :ref:`Docker ユーザ・ガイド <building-an-image-from-a-dockerfile>` や :doc:`Dockerfile リファレンス </engine/reference/builder>` をご覧ください。

.. Step 3: Define services in a Compose file

ステップ３：Compose ファイル内でのサービス定義
==============================================

.. Create a file called `docker-compose.yml` in your project directory and paste
   the following:

プロジェクト用のディレクトリに移動し、``docker-compose.yml`` という名称のファイルを作成し、次の内容にします。

.. code-block:: yaml

   version: '3'
   services:
     web:
       build: .
       ports:
        - "5000:5000"
     redis:
       image: "redis:alpine"

.. This Compose file defines two services, `web` and `redis`. The web service:

この Compose ファイルは ``web`` と ``redis`` という２つのサービスを定義します。``web`` サービスは次のように設定します。

.. Uses an image that's built from the `Dockerfile` in the current directory.
   Forwards the exposed port 5000 on the container to port 5000 on the host
   machine. We use the default port for the Flask web server, `5000`.

* カレントディレクトリにある ``Dockerfile`` から構築されるイメージを利用します。
* コンテナの公開用ポート 5000 を、ホストマシンのポート 5000 にポートフォワードします。Flask ウェブ・サーバに対するデフォルトポート ``5000`` をそのまま使います。

.. The `redis` service uses a public
   [Redis](https://registry.hub.docker.com/_/redis/) image pulled from the Docker
   Hub registry.

``redis`` サービスは、Docker Hub レジストリから取得した `Redis <https://registry.hub.docker.com/_/redis/>`_ イメージを利用します。

.. Step 4: Build and run your app with Compose

ステップ４：Compose によるアプリケーションの構築と実行
======================================================

.. From your project directory, start up your application.

1. プロジェクト用のディレクトリで ``docker-compose up`` を実行しアプリケーションを起動します。

.. code-block:: bash

   $ docker-compose up
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

.. Compose pulls a Redis image, builds an image for your code, and start the
   services you defined. In this case, the code is statically copied into the image at build time.

Compose は Redis イメージを取得し、コードに基づいたイメージを構築します。そして定義したサービスを開始します。この例では、イメージの構築時にコードが静的にコピーされます。

..  Enter `http://0.0.0.0:5000/` in a browser to see the application running.

2. ブラウザで ``http://0.0.0.0:5000/`` を開き、アプリケーションが動いていることを確認します。

..    If you're using Docker natively on Linux, Docker for Mac, or Docker for
    Windows, then the web app should now be listening on port 5000 on your
    Docker daemon host. Point your web browser to `http://localhost:5000` to
    find the `Hello World` message. If this doesn't resolve, you can also try
    `http://0.0.0.0:5000`.

Linux、Docker for Mac、Docker for Windows において Docker を直接使っている場合は、ウェブアプリは Docker デーモンが動くホスト上のポート 5000 をリッスンして受けつけます。ブラウザから ``http://localhost:5000`` を入力すると、``Hello World`` メッセージが表示されるはずです。表示されない場合は ``http://0.0.0.0:5000`` を試してください。

..    If you're using Docker Machine on a Mac or Windows, use `docker-machine ip
    MACHINE_VM` to get the IP address of your Docker host. Then, open
    `http://MACHINE_VM_IP:5000` in a browser.

Mac や Windows 上で Docker Machine を使っている場合は、 ``docker-machine ip 仮想マシン名`` を実行すると、Docker ホストの IP アドレスを取得できます。そこでブラウザから ``http://仮想マシンのIP:5000`` を開きます。

.. You should see a message in your browser saying:

ブラウザには以下のメッセージが表示されます。

::

   Hello World! I have been seen 1 times.

.. Refresh this page.

.. Refresh the page.

3. このページを再読み込みします。

.. The number should increment.

数字が増えます。

::

   Hello World! I have been seen 2 times.

4. 別のターミナルウィンドウを開いて、``docker image ls`` と入力し、ローカルイメージの一覧を表示してみます。

.. Listing images at this point should return `redis` and `web`.

この時点におけるイメージの一覧は ``redis`` と ``web`` になります。

::

   $ docker image ls
   REPOSITORY              TAG                 IMAGE ID            CREATED             SIZE
   composetest_web         latest              e2c21aa48cc1        4 minutes ago       93.8MB
   python                  3.4-alpine          84e6077c7ab6        7 days ago          82.5MB
   redis                   alpine              9d8fa9aa0e5b        3 weeks ago         27.5MB

.. You can inspect images with `docker inspect <tag or id>`.

``docker inspect <tag または id>`` によってイメージを確認することもできます。

.. Stop the application, either by running `docker-compose down`
   from within your project directory in the second terminal, or by
   hitting CTRL+C in the original terminal where you started the app.

5. アプリケーションを停止させます。２つめに開いたターミナルウィンドウ上のプロジェクトディレクトリにおいて ``docker-compose down`` を実行します。別のやり方として、アプリを開始したはじめのターミナルウィンドウ上において CTRL+C を入力します。

.. Step 5: Edit the Compose file to add a bind mount

ステップ５：Compose ファイルにバインドマウントを追加
====================================================

.. If you want to run your services in the background, you can pass the -d flag (for “detached” mode) to docker-compose up and use docker-compose ps to see what is currently running:

サービスをバックグラウンドで実行したい場合は、``docker-compose up`` に ``-d`` フラグ（"デタッチド"モード用のフラグ）を付けます。どのように動作しているか見るには、``docker-compose ps`` を使います。

.. code-block:: bash

   $ docker-compose up -d
   Starting composetest_redis_1...
   Starting composetest_web_1...
   $ docker-compose ps
   Name                 Command            State       Ports
   -------------------------------------------------------------------
   composetest_redis_1   /usr/local/bin/run         Up
   composetest_web_1     /bin/sh -c python app.py   Up      5000->5000/tcp

.. The docker-compose run command allows you to run one-off commands for your services. For example, to see what environment variables are available to the web service:

``docker-compose run`` コマンドを使えば、サービスに対して一度だけコマンドを実行します。たとえば、``web`` サービス上でどのような環境変数があるのかを知るには、次のようにします。

.. code-block:: bash

   $ docker-compose run web env

.. See docker-compose --help to see other available commands. You can also install command completion for the bash and zsh shell, which will also show you available commands.

``docker-compose --help`` で利用可能な他のコマンドを確認できます。また、必要があれば bash と zsh シェル向けの :doc:`コマンド補完 </compose/completion>` もインストールできます。

.. If you started Compose with docker-compose up -d, you’ll probably want to stop your services once you’ve finished with them:

Compose を ``docker-compose up -d`` で起動した場合は、次のようにサービスを停止して、終わらせます。

.. code-block:: bash

   $ docker-compose stop

.. At this point, you have seen the basics of how Compose works.

以上、Compose の基本動作を見てきました。

.. Where to go next

次はどこへ
==========

.. 
    Next, try the quick start guide for Django, Rails, or WordPress.
    Explore the full list of Compose commands
    Compose configuration file reference

* 次は、:doc:`Django </compose/django>` 、 :doc:`Rails </compose/rails>`  、 :doc:`WordPress </compose/wordpress>`  向けのクイックスタートガイドを試しましょう。
* :doc:`/compose/reference/index`
* :doc:`/compose/compose-file`

.. seealso:: 

   Getting Started
      https://docs.docker.com/compose/gettingstarted/
