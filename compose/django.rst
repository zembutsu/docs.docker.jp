.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/django/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/django.md
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/django.md
.. check date: 2016/04/28
.. Commits on Apr 9, 2016 e6797e116648fb566305b39040d5fade83aacffc
.. -------------------------------------------------------------------

.. title: "Quickstart: Compose and Django"

====================================
クィックスタート: Compose と Django
====================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. This quick-start guide demonstrates how to use Docker Compose to set up and run a simple Django/PostgreSQL app. Before starting, you'll need to have
   [Compose installed](install.md).

このクィックスタート・ガイドでは Docker Compose を使って、簡単な Django/PostgreSQL アプリを設定し実行する手順を示します。
はじめる前に :doc:`Compose をインストール </compose/install>` してください。

.. ### Define the project components

プロジェクトのコンポーネントを定義
===================================

.. For this project, you need to create a Dockerfile, a Python dependencies file,
   and a `docker-compose.yml` file. (You can use either a `.yml` or `.yaml` extension for this file.)

このプロジェクトでは Dockerfile、Python の依存パッケージを示すファイル、 ``docker-compose.yml`` ファイルをそれぞれ生成します。（ ``docker-compose.yml`` の拡張子は ``.yml`` と ``.yaml`` のどちらでも構いません。）

..    Create an empty project directory.

1. プロジェクト用の空のディレクトリを作成します。

   ..  You can name the directory something easy for you to remember. This directory is the context for your application image. The directory should only contain resources to build that image.

   ディレクトリ名は覚えやすいものにします。
   このディレクトリはアプリケーションイメージのコンテキストディレクトリとなります。
   このディレクトリには、イメージをビルドするために必要となるものだけを含めるようにします。

.. 2. Create a new file called `Dockerfile` in your project directory.

2. プロジェクトディレクトリ内に ``Dockerfile`` というファイルを新規生成します。

   ..  The Dockerfile defines an application's image content via one or more build
       commands that configure that image. Once built, you can run the image in a
       container.  For more information on `Dockerfiles`, see the [Docker user
       guide](/engine/tutorials/dockerimages.md#building-an-image-from-a-dockerfile)
       and the [Dockerfile reference](/engine/reference/builder.md).

   Dockerfile はアプリケーション・イメージの内容を定義するものであり、イメージを設定しビルドするコマンドがいくつか記述されます。
   ビルドが成功すると、コンテナ内にてイメージが起動します。
   ``Dockerfile`` の詳細は :ref:`Docker ユーザ・ガイド <building-an-image-from-a-dockerfile>` や :doc:`Dockerfile リファレンス </engine/reference/builder>` を参照してください。

.. Add the following content to the Dockerfile.

3. ``Dockerfile`` に次の内容を加えます。

   ..      FROM python:3
           ENV PYTHONUNBUFFERED 1
           RUN mkdir /code
           WORKDIR /code
           ADD requirements.txt /code/
           RUN pip install -r requirements.txt
           ADD . /code/

   .. code-block:: dockerfile

      FROM python:3
      ENV PYTHONUNBUFFERED 1
      RUN mkdir /code
      WORKDIR /code
      ADD requirements.txt /code/
      RUN pip install -r requirements.txt
      ADD . /code/

   ..  This `Dockerfile` starts with a [Python 3 parent image](https://hub.docker.com/r/library/python/tags/3/).
       The parent image is modified by adding a new `code` directory. The parent image is further modified
       by installing the Python requirements defined in the `requirements.txt` file.

   この ``Dockerfile`` はまず `Python 3 の親イメージ <https://hub.docker.com/r/library/python/tags/3/>`_ から始まっています。
   この親イメージには新規のディレクトリ ``code`` が加えられます。 
   さらに ``requirements.txt`` ファイルに定義された Python 依存パッケージをインストールする変更が加えられています。

.. Save and close the Dockerfile.

4. ``Dockerfile`` を保存して閉じます。

.. 5. Create a `requirements.txt` in your project directory.

5. プロジェクト・ディレクトリに ``requirements.txt`` というファイルを生成します。

   ..  This file is used by the `RUN pip install -r requirements.txt` command in your `Dockerfile`.

   このファイルは ``Dockerfile`` 内の ``RUN pip install -r requirements.txt`` というコマンドにおいて利用されます。

.. Add the required software in the file.

6. ファイル中に必要なソフトウェアを記述します。

   ..      Django>=1.8,<2.0
           psycopg2

   ::

      Django>=1.8,<2.0
      psycopg2

.. Save and close the requirements.txt file.

7. ``requirements.txt`` ファイルを保存して閉じます。

.. 8. Create a file called `docker-compose.yml` in your project directory.

8. プロジェクト・ディレクトリ内に ``docker-compose.yml`` というファイルを生成します。

   ..  The `docker-compose.yml` file describes the services that make your app. In
       this example those services are a web server and database.  The compose file
       also describes which Docker images these services use, how they link
       together, any volumes they might need mounted inside the containers.
       Finally, the `docker-compose.yml` file describes which ports these services
       expose. See the [`docker-compose.yml` reference](compose-file.md) for more
       information on how this file works.

   ``docker-compose.yml`` ファイルは、アプリケーションを作り出すサービスを記述するものです。
   この例においてそのサービスとは、ウェブ・サーバーとデータベースです。
   Compose ファイルはまた、各サービスが利用する Docker イメージを記述します。
   そしてどのように互いにリンクし合い、コンテナ内部にマウントすべきボリュームはどのようなものかを定義します。
   そして ``docker-compose.yml`` ファイルには、各サービスが公開するポート番号が何かも記述します。
   このファイルがどのようにして動作するかの詳細は :doc:`docker-compose.yml リファレンス </compose/compose-file>` を参照してください。

.. Add the following configuration to the file.

9. ファイルに以下の設定を追加します。

   ..  ```none
       version: '3'

       services:
         db:
           image: postgres
         web:
           build: .
           command: python3 manage.py runserver 0.0.0.0:8000
           volumes:
             - .:/code
           ports:
             - "8000:8000"
           depends_on:
             - db
       ```

   .. code-block:: yaml

      version: '3'

      services:
        db:
          image: postgres
        web:
          build: .
          command: python3 manage.py runserver 0.0.0.0:8000
          volumes:
            - .:/code
          ports:
            - "8000:8000"
          depends_on:
            - db


   ..  This file defines two services: The `db` service and the `web` service.

   このファイルには ``db`` サービスと ``web`` サービスという 2 つのサービスが定義されています。

.. Save and close the docker-compose.yml file.

10. ``docker-compose.yml`` ファイルを保存して閉じます。

.. ### Create a Django project

Django プロジェクトの生成
==============================

.. In this step, you create a Django starter project by building the image from the build context defined in the previous procedure.

ここでの手順では、前の手順で定義したビルドコンテキストからイメージをビルドし、Django プロジェクトのひながたを生成します。

.. 1. Change to the root of your project directory.

1. プロジェクト・ディレクトリに移動します。

.. 2. Create the Django project by running
   the [docker-compose run](/compose/reference/run/) command as follows.

2. Django プロジェクトを生成するために :doc:`docker-compose run </compose/reference/run>` コマンドを以下のように実行します。

   ..      docker-compose run web django-admin.py startproject composeexample .

   .. code-block:: bash

      docker-compose run web django-admin.py startproject composeexample .

   ..  This instructs Compose to run `django-admin.py startproject composeexample`
       in a container, using the `web` service's image and configuration. Because
       the `web` image doesn't exist yet, Compose builds it from the current
       directory, as specified by the `build: .` line in `docker-compose.yml`.

   このコマンドは Compose に対し、コンテナ内において ``django-admin startproject composeexample`` を実行するものです。
   その際には ``web`` サービスイメージとその設定を利用します。
   ただし ``web`` イメージはこの時点ではまだ存在していないため、Compose はカレントディレクトリからそのイメージをビルドします。このことは ``docker-compose.yml`` の ``build: .`` という記述行において指示されています。

   ..  Once the `web` service image is built, Compose runs it and executes the
       `django-admin.py startproject` command in the container. This command
       instructs Django to create a set of files and directories representing a
       Django project.

   ``web`` サービスイメージがビルドされると Compose はこのイメージを起動し、コンテナ内でコマンド ``django-admin startproject`` を実行します。
   このコマンドは Django に対して、Django プロジェクトを組み立てるファイルやディレクトリを生成することを指示するものです。

.. 3. After the `docker-compose` command completes, list the contents of your project.

3. ``docker-compose`` コマンドの処理が完了したら、プロジェクト内の一覧を表示してみます。

   ..      $ ls -l
           drwxr-xr-x 2 root   root   composeexample
           -rw-rw-r-- 1 user   user   docker-compose.yml
           -rw-rw-r-- 1 user   user   Dockerfile
           -rwxr-xr-x 1 root   root   manage.py
           -rw-rw-r-- 1 user   user   requirements.txt

   .. code-block:: bash

      $ ls -l
      drwxr-xr-x 2 root   root   composeexample
      -rw-rw-r-- 1 user   user   docker-compose.yml
      -rw-rw-r-- 1 user   user   Dockerfile
      -rwxr-xr-x 1 root   root   manage.py
      -rw-rw-r-- 1 user   user   requirements.txt

   ..  If you are running Docker on Linux, the files `django-admin` created are
       owned by root. This happens because the container runs as the root user.
       Change the ownership of the new files.

   Linux 上で Docker を利用している場合、``django-admin`` が生成したファイルの所有者が root になっています。
   これはコンテナが root ユーザで実行されるからです。
   生成されたファイルの所有者を以下のようにして変更します。

   ..        sudo chown -R $USER:$USER .

   .. code-block:: bash

      sudo chown -R $USER:$USER .

.. If you are running Docker on Mac or Windows, you should already have ownership of all files, including those generated by django-admin. List the files just verify this.

Docker を Mac あるいは Windows 上で動かしている場合は、 ``django-admin`` によって作成されたファイルも含む、全ファイルの所有者は、実行したユーザの権限です。次のように確認可能です。

.. code-block:: bash

   $ ls -l
   total 32
   -rw-r--r--  1 user  staff  145 Feb 13 23:00 Dockerfile
   drwxr-xr-x  6 user  staff  204 Feb 13 23:07 composeexample
   -rw-r--r--  1 user  staff  159 Feb 13 23:02 docker-compose.yml
   -rwxr-xr-x  1 user  staff  257 Feb 13 23:07 manage.py
   -rw-r--r--  1 user  staff   16 Feb 13 23:01 requirements.txt

.. Connect the database

データベースに接続
====================

.. In this section, you set up the database connection for Django.

このセクションでは、Django 用のデータベースをセットアップします。

..    In your project directory, edit the composeexample/settings.py file.

1. プロジェクト用ディレクトリで、``composeexample/settings.py`` ファイルを編集します。

..    Replace the DATABASES = ... with the following:

2. ``DATABASES = ...`` を以下のものに置き換えます。

::

   DATABASES = {
       'default': {
           'ENGINE': 'django.db.backends.postgresql_psycopg2',
           'NAME': 'postgres',
           'USER': 'postgres',
           'HOST': 'db',
           'PORT': 5432,
       }
   }

.. These settings are determined by the postgres Docker image specified in docker-compose.yml.

これらの設定は ``docker-compose.yml`` で指定した `postgres <https://hub.docker.com/_/postgres/>`_ Docker イメージによって決められているものです。

.. Save and close the file.

3. ファイルを保存して閉じます。

.. Run the docker-compose up command.

4. ``docker-compose up`` コマンドを実行します。

.. code-block:: bash

   $ docker-compose up
   Starting composepractice_db_1...
   Starting composepractice_web_1...
   Attaching to composepractice_db_1, composepractice_web_1
   ...
   db_1  | PostgreSQL init process complete; ready for start up.
   ...
   db_1  | LOG:  database system is ready to accept connections
   db_1  | LOG:  autovacuum launcher started
   ..
   web_1 | Django version 1.8.4, using settings 'composeexample.settings'
   web_1 | Starting development server at http://0.0.0.0:8000/
   web_1 | Quit the server with CONTROL-C.

.. At this point, your Django app should be running at port 8000 on your Docker host. If you are using a Docker Machine VM, you can use the docker-machine ip MACHINE_NAME to get the IP addres

これで Django アプリが Docker ホスト上のポート ``8000`` で動作しているでしょう。Docker Machine の仮想マシンを使っている場合は、``docker-machine ip マシン名`` を実行して IP アドレスを取得できます。

.. More Compose documentation

Compose の更なるドキュメント
==============================

..
    User guide
    Installing Compose
    Getting Started
    Get started with Rails
    Get started with WordPress
    Command line reference
    Compose file reference

* :doc:`ユーザガイド <index>`
* :doc:`/compose/install`
* :doc:`/compose/gettingstarted`
* :doc:`/compose/rails`
* :doc:`/compose/wordpress`
* :doc:`/compose/reference/index`
* :doc:`/compose/compose-file`

.. seealso:: 

   Quicks
      https://docs.docker.com/machine/reference/


