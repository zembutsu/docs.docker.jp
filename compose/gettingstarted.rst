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

このページでは、簡単な Python ウェブ・アプリケーションを Docker Compose で実行しましょう。アプリケーションは Flask フレームワークを使い、Redis の値を増やします。サンプルでは Python を使いますが、ここでの動作概念は Python に親しくなくても理解可能です。

.. Prerequisites

事前準備
==========

.. Make sure you have already installed both Docker Engine and Docker Compose. You don’t need to install Python, it is provided by a Docker image.

既に :doc:`Docker Engine と Docker Compose がインストール済み </compose/install>` なのを確認します。Python をインストールする必要はなく、Docker イメージのものを使います。

.. Step 1: Setup

ステップ１：セットアップ
==============================

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
       redis.incr('hits')
       return 'Hello World! I have been seen %s times.' % redis.get('hits')
   
   
   if __name__ == "__main__":
       app.run(host="0.0.0.0", debug=True)

.. Create another file called requirements.txt in your project directory and add the following:

3. プロジェクト用のディレクトリで別の ``requirements.txt`` という名称のファイルを作成し、次の内容にします。

.. code-block:: text

   flask
   redis

.. These define the applications dependencies.

これらはアプリケーションの依存関係を定義します。

.. Step 2: Create a Docker image

ステップ２：Docker イメージの作成
========================================

.. In this step, you build a new Docker image. The image contains all the dependencies the Python application requires, including Python itself.

このステップでは、新しい Docker イメージを構築します。イメージには Python アプリケーションが必要とする全ての依存関係と Python 自身を含みます。

..    In your project directory create a file named Dockerfile and add the following:

1. プロジェクト用のディレクトリの内で、``Dockerfile`` という名称のファイルを作成し、次の内容にします。

.. code-block:: dockerfile

   FROM python:2.7
   ADD . /code
   WORKDIR /code
   RUN pip install -r requirements.txt
   CMD python app.py

.. This tells Docker to

これは Docker に対して次の情報を伝えます。

..    Build an image starting with the Python 2.7 image.
    Add the current directory . into the path /code in the image.
    Set the working directory to /code.
    Install the Python dependencies.
    Set the default command for the container to python app.py

* Python 2.7 イメージを使って、イメージ構築を始める
* 現在のディレクトリ ``.`` を、イメージ内のパス ``/code`` に加える
* 作業用ディレクトリを ``/code`` に指定する
* Python の依存関係（のあるパッケージを）インストールする
* コンテナが実行するデフォルトのコマンドを ``python app.py`` にする

.. For more information on how to write Dockerfiles, see the Docker user guide and the Dockerfile reference.

Dockerfile の書き方や詳細な情報については、 :ref:`Docker ユーザ・ガイド <building-an-image-from-a-dockerfile>` や :doc:`Dockerfile リファレンス </engine/reference/builder>` をご覧ください。

..    Build the image.

2. イメージを構築します。

.. code-block:: bash

   $ docker build -t web .

.. This command builds an image named web from the contents of the current directory. The command automatically locates the Dockerfile, app.py, and requirements.txt files.

このコマンドは、現在のディレクトリの内容を元にして、 ``web`` という名前のイメージを構築（ビルド）します。コマンドは自動的に ``Dockerfile`` 、 ``app.py`` 、 ``requirements.txt`` を特定します。

.. Step 3: Define services

ステップ３：サービスの定義
==============================

.. Define a set of services using docker-compose.yml:

``docker-compose.yml`` を使い、サービスの集まりを定義します。

..    Create a file called docker-compose.yml in your project directory and add the following:

1. プロジェクト用のディレクトリに移動し、``docker-compose.yml`` という名前のファイルを作成し、次のように追加します。

.. code-block:: yaml

   version: '2'
   services:
     web:
       build: .
       ports:
        - "5000:5000"
       volumes:
        - .:/code
       depends_on:
        - redis
     redis:
       image: redis

.. This Compose file defines two services, web and redis. The web service:

この Compose 用ファイルは ``web`` と ``redis`` という２つのサービスを定義します。``web`` サービスは次のように設定されます。

.. Builds from the Dockerfile in the current directory.
   Forwards the exposed port 5000 on the container to port 5000 on the host machine.
   Mounts the project directory on the host to /code inside the container allowing you to modify the code without having to rebuild the image.
   Links the web service to the Redis service

* 現在のディレクトリにある ``Dockerfile`` から構築する。
* コンテナ内の公開用（exposed）ポート 5000 を、ホストマシン上のポート 5000 に転送する。
* ホスト上のプロジェクト用のディレクトリを、コンテナ内の ``/code`` にマウントし、イメージを再構築しなくてもコードの変更が行えるようにする。
* web サービスを redis サービスにリンクします。

.. The redis service uses the latest public Redis image pulled from the Docker Hub registry.

``redis`` サービスには、Docker Hub レジストリから取得した最新の公開（パブリック） `Redis <https://registry.hub.docker.com/_/redis/>`_ イメージを使用します。

.. Step 4: Build and run your app with Compose

ステップ４：Compose でアプリケーションを構築・実行
==================================================

.. From your project directory, start up your application.

1. プロジェクト用のディレクトリで、アプリケーションを起動します。

.. code-block:: bash

   $ docker-compose up
   Pulling image redis...
   Building web...
   Starting composetest_redis_1...
   Starting composetest_web_1...
   redis_1 | [8] 02 Jan 18:43:35.576 # Server started, Redis version 2.8.3
   web_1   |  * Running on http://0.0.0.0:5000/
   web_1   |  * Restarting with stat

.. Compose pulls a Redis image, builds an image for your code, and start the services you defined.

Compose は Redis イメージを取得し、コードが動作するイメージを構築し、定義したサービスを開始します。

..    Enter http://0.0.0.0:5000/ in a browser to see the application running.

2. ブラウザで ``http://0.0.0.0:5000/`` を開き、アプリケーションの動作を確認します。

.. If you’re using Docker on Linux natively, then the web app should now be listening on port 5000 on your Docker daemon host. If http://0.0.0.0:5000 doesn’t resolve, you can also try http://localhost:5000.

Docker を Linux で直接使っている場合は、ウェブアプリは Docker デーモンのホスト上でポート 5000 をリッスンして（開いて）います。もし http://0.0.0.0:5000/ で接続できなければ、http://localhost:5000 を試してください。

.. If you’re using Docker Machine on a Mac, use docker-machine ip MACHINE_VM to get the IP address of your Docker host. Then, open http://MACHINE_VM_IP:5000 in a browser.

Mac や Windows 上で Docker Machine を使っている場合は、 ``docker-machine ip 仮想マシン名`` を実行し、Docker ホスト上の IP アドレスを取得します。それからブラウザで ``http://仮想マシンのIP:5000`` を開きます。

.. You should see a message in your browser saying:

そうすると、次のメッセージが表示されるでしょう。

::

   Hello World! I have been seen 1 times.

.. Refresh this page.

3. このページを再読み込みします。

.. The number should increment.

番号が増えているでしょう。

.. Step 5: Experiment with some other commands.

ステップ５：他のコマンドを試す
==============================

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
