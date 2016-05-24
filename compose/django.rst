.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/django/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/django.md
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/django.md
.. check date: 2016/04/28
.. Commits on Apr 9, 2016 e6797e116648fb566305b39040d5fade83aacffc
.. -------------------------------------------------------------------

.. Quickstart Guide: Docker Compose and Django

==================================================
クイックスタート・ガイド：Docker Compose と Django
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. This quick-start guide demonstrates how to use Docker Compose to set up and run a simple Django/PostgreSQL app. Before starting, you’ll need to have Compose installed.

このクイックスタート・ガイドは Docker Compose を使い、簡単な Django/PostgreSQL アプリをセットアップします。事前に :doc:`Compose のインストール </compose/install>` が必要です。

.. Define the project components

プロジェクトの構成物を定義
==============================

.. For this project, you need to create a Dockerfile, a Python dependencies file, and a docker-compose.yml file.

このプロジェクトでは、Dockerfile と、Python 依存関係のファイル、``docker-compose.yml`` ファイルを作成する必要があります。

..    Create an empty project directory.

1. プロジェクト用の空のディレクトリを作成します。

..    You can name the directory something easy for you to remember. This directory is the context for your application image. The directory should only contain resources to build that image.

覚えやすい名前のディレクトリを作成します。このディレクトリがアプリケーション・イメージの内容（コンテクスト）となるものです。ディレクトリには、イメージ構築に関するリソースのみ置くべきです。

..    Create a new file called Dockerfile in your project directory.

2. プロジェクト用のディレクトリに、``Dockerfile`` という名称の新規ファイルを作成します。

..    The Dockerfile defines an application’s image content via one or more build commands that configure that image. Once built, you can run the image in a container. For more information on Dockerfiles, see the Docker user guide and the Dockerfile reference.

Dockerfile はアプリケーションのイメージ内容に含まれる、１つまたは複数のイメージ構築用のコマンドを定義します。構築（ビルド）時に、コンテナの中でイメージを実行できます。``Dockerfile`` の詳細情報については、 :ref:`Docker ユーザ・ガイド <building-an-image-from-a-dockerfile>` や :doc:`Dockerfile リファレンス </engine/reference/builder>` をご覧ください。

.. Add the following content to the Dockerfile.

3. ``Dockerfile`` に次の内容を加えます。

.. code-block:: dockerfile

   
   FROM python:2.7
   ENV PYTHONUNBUFFERED 1
   RUN mkdir /code
   WORKDIR /code
   ADD requirements.txt /code/
   RUN pip install -r requirements.txt
   ADD . /code/

.. This Dockerfile starts with a Python 2.7 base image. The base image is modified by adding a new code directory. The base image is further modified by installing the Python requirements defined in the requirements.txt file.

この ``Dockerfile`` は Python 2.7 ベース・イメージを使って開始します。ベース・イメージに新しく ``/code`` ディレクトリ追加という変更が行われます。ベース・イメージは、``requirements.txt`` ファイルで定義されている Python 依存関係のインストールという、更なる変更を定義します。

.. Save and close the Dockerfile.

4. ``Dockerfile`` を保存して閉じます。

.. Create a requirements.txt in your project directory.

5. ``requirements.txt`` をプロジェクト用のディレクトリに作成します。

.. This file is used by the RUN pip install -r requirements.txt command in your Dockerfile.

このファイルは ``Dockerfile`` の ``RUN pip install -r requirements.txt`` 命令で使います。

.. Add the required software in the file.

6. ファイル中に必要なソフトウェアを記述します。

::

  Django
  psycopg2

.. Save and close the requirements.txt file.

7. ``requirements.txt`` ファイルを保存して閉じます。

.. Create a file called docker-compose.yml in your project directory.

8. プロジェクト用のディレクトリに ``docker-compose.yml`` という名称のファイルを作成します。

.. The docker-compose.yml file describes the services that make your app. In this example those services are a web server and database. The compose file also describes which Docker images these services use, how they link together, any volumes they might need mounted inside the containers. Finally, the docker-compose.yml file describes which ports these services expose. See the docker-compose.yml reference for more information on how this file works.

``docker-compose.yml`` ファイルは、アプリケーションを作るためのサービスを記述します。この例におけるサービスとはウェブサーバとデータベースです。また、Compose ファイルではサービスが利用する Docker イメージ、どのように相互にリンクするか、コンテナ内で必要となるボリュームをそれぞれ定義します。最後に ``docker-compose.yml`` ファイルでサービスを公開するポートを指定します。詳細な情報や動作に関しては :doc:`docker-compose.yml リファレンス </compose/compose-file>` をご覧ください。

.. Add the following configuration to the file.

9. ファイルに以下の設定を追加します。

.. code-block:: yaml

   version: '2'
   services:
     db:
       image: postgres
     web:
       build: .
       command: python manage.py runserver 0.0.0.0:8000
       volumes:
         - .:/code
       ports:
         - "8000:8000"
       depends_on:
         - db

.. This file defines two services: The db service and the web service

このファイルは２つのサービスを定義しています。``db`` サービスと ``web`` サービスです。

.. Save and close the docker-compose.yml file.

10. ``docker-compose.yml`` ファイルを保存して閉じます。

.. Create a Django project

Django プロジェクトの作成
==============================

.. In this step, you create a Django started project by building the image from the build context defined in the previous procedure.

このステップでは、Django を開始するプロジェクトを作りましょう。そのためには、先の手順で構築内容を定義したイメージを作成します。

..     Change to the root of your project directory.

1. プロジェクト用のディレクトリに移動します。

..     Create the Django project using the docker-compose command.

2. Django プロジェクトを ``docker-compose`` コマンドを使って作成します。

.. code-block:: bash

   $ docker-compose run web django-admin.py startproject composeexample .

..    This instructs Compose to run django-admin.py startproject composeeexample in a container, using the web service’s image and configuration. Because the web image doesn’t exist yet, Compose builds it from the current directory, as specified by the build: . line in docker-compose.yml.

これは Compose に対して、コンテナ内で ``django-admin.py startproject composeexample`` を実行するよう命令します。コンテナは ``web`` サービスのイメージと設定を使います。``web`` イメージはまだ作成していませんが、``docker-compose.yml`` の ``build: .`` 行の命令があるため、現在のディレクトリ上で構築します。

.. Once the web service image is built, Compose runs it and executes the django-admin.py startproject command in the container. This command instructs Django to create a set of files and directories representing a Django project.

``web`` サービスのイメージを構築したら、Compose はこのイメージを使い、コンテナ内で ``django-admin.py startproject`` を実行します。このコマンドは Django プロジェクトの代表として、Django に対してファイルとディレクトリの作成を命令します。

.. After the docker-compose command completes, list the contents of your project.

3. ``docker-compose`` コマンドが完了したら、プロジェクトのディレクトリ内は次のようになります。

.. code-block:: bash

   $ ls -l
   drwxr-xr-x 2 root   root   composeexample
   -rw-rw-r-- 1 user   user   docker-compose.yml
   -rw-rw-r-- 1 user   user   Dockerfile
   -rwxr-xr-x 1 root   root   manage.py
   -rw-rw-r-- 1 user   user   requirements.txt

.. If you are running Docker on Linux, the files django-admin created are owned by root. This happens because the container runs as the root user. Change the ownership of the the new files.

.. The files django-admin created are owned by root. This happens because the container runs as the root user.

ファイル ``django-admin`` は所有者が root として作成されました。これはコンテナが ``root`` ユーザによって実行されたからです。

Docker を Linux 上で動かしている場合は、 ``django-admin`` は root の所有者として作成されます。つまり、これはコンテナが root ユーザとして実行されるのを意味します。新しいファイルの所有者を変更するには、次のように実行します。

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


