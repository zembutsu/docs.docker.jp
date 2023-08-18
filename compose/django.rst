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
           environment:
            - POSTGRES_DB=postgres
            - POSTGRES_USER=postgres
            - POSTGRES_PASSWORD=postgres
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

   ..  If you are running Docker on Mac or Windows, you should already
       have ownership of all files, including those generated by
       `django-admin`. List the files just to verify this.

   Docker on Mac あるいは Docker on Windows を利用している場合は、生成されたファイルの所有権は ``django-admin`` が作り出したファイルも含めて、すべて持っています。
   確認のため一覧を表示してみます。

   ..      $ ls -l
           total 32
           -rw-r--r--  1 user  staff  145 Feb 13 23:00 Dockerfile
           drwxr-xr-x  6 user  staff  204 Feb 13 23:07 composeexample
           -rw-r--r--  1 user  staff  159 Feb 13 23:02 docker-compose.yml
           -rwxr-xr-x  1 user  staff  257 Feb 13 23:07 manage.py
           -rw-r--r--  1 user  staff   16 Feb 13 23:01 requirements.txt

   .. code-block:: bash

      $ ls -l
      total 32
      -rw-r--r--  1 user  staff  145 Feb 13 23:00 Dockerfile
      drwxr-xr-x  6 user  staff  204 Feb 13 23:07 composeexample
      -rw-r--r--  1 user  staff  159 Feb 13 23:02 docker-compose.yml
      -rwxr-xr-x  1 user  staff  257 Feb 13 23:07 manage.py
      -rw-r--r--  1 user  staff   16 Feb 13 23:01 requirements.txt

.. ### Connect the database

データベースへの接続設定
========================

.. In this section, you set up the database connection for Django.

ここでは Django におけるデータベース接続の設定を行います。

.. 1.  In your project directory, edit the `composeexample/settings.py` file.

1. プロジェクト・ディレクトリにおいて ``composeexample/settings.py`` ファイルを編集します。

.. 2.  Replace the `DATABASES = ...` with the following:

2.  ``DATABASES = ...`` の部分を以下のように書き換えます。

   ..      DATABASES = {
               'default': {
                   'ENGINE': 'django.db.backends.postgresql',
                   'NAME': 'postgres',
                   'USER': 'postgres',
                   'HOST': 'db',
                   'PORT': 5432,
               }
           }

   ::

      DATABASES = {
          'default': {
              'ENGINE': 'django.db.backends.postgresql',
              'NAME': 'postgres',
              'USER': 'postgres',
              'HOST': 'db',
              'PORT': 5432,
          }
      }

   ..  These settings are determined by the
       [postgres](https://store.docker.com/images/postgres) Docker image
       specified in `docker-compose.yml`.

   上の設定は ``docker-compose.yml`` に指定した Docker イメージ `postgres <https://hub.docker.com/images/postgres>`_ が定めている内容です。

.. Save and close the file.

3. ファイルを保存して閉じます。

.. 4.  Run the [docker-compose up](/compose/reference/up/) command from the top level directory for your project.

4. プロジェクトのトップ・ディレクトリにおいてコマンド :doc:`docker-compose up </compose/reference/up>` を実行します。

   ..  ```none
       $ docker-compose up
       djangosample_db_1 is up-to-date
       Creating djangosample_web_1 ...
       Creating djangosample_web_1 ... done
       Attaching to djangosample_db_1, djangosample_web_1
       db_1   | The files belonging to this database system will be owned by user "postgres".
       db_1   | This user must also own the server process.
       db_1   |
       db_1   | The database cluster will be initialized with locale "en_US.utf8".
       db_1   | The default database encoding has accordingly been set to "UTF8".
       db_1   | The default text search configuration will be set to "english".

       . . .

       web_1  | May 30, 2017 - 21:44:49
       web_1  | Django version 1.11.1, using settings 'composeexample.settings'
       web_1  | Starting development server at http://0.0.0.0:8000/
       web_1  | Quit the server with CONTROL-C.
       ```

   .. code-block:: bash

      $ docker-compose up
      djangosample_db_1 is up-to-date
      Creating djangosample_web_1 ...
      Creating djangosample_web_1 ... done
      Attaching to djangosample_db_1, djangosample_web_1
      db_1   | The files belonging to this database system will be owned by user "postgres".
      db_1   | This user must also own the server process.
      db_1   |
      db_1   | The database cluster will be initialized with locale "en_US.utf8".
      db_1   | The default database encoding has accordingly been set to "UTF8".
      db_1   | The default text search configuration will be set to "english".

      . . .

      web_1  | May 30, 2017 - 21:44:49
      web_1  | Django version 1.11.1, using settings 'composeexample.settings'
      web_1  | Starting development server at http://0.0.0.0:8000/
      web_1  | Quit the server with CONTROL-C.

   ..  At this point, your Django app should be running at port `8000` on
       your Docker host. On Docker for Mac and Docker for Windows, go
       to `http://localhost:8000` on a web browser to see the Django
       welcome page. If you are using [Docker Machine](/machine/overview.md),
       then `docker-machine ip MACHINE_VM` returns the Docker host IP
       address, to which you can append the port (`<Docker-Host-IP>:8000`).

   この段階で Django アプリは Docker ホスト上のポート ``8000`` で稼動しています。
   Docker Desktop for Mac または Docker Desktop for Windows の場合は、ブラウザから ``http://localhost:8000`` にアクセスすることで、Django の Welcome ページを確認できます。
   :doc:`Docker Machine </machine/overview>` を利用している場合は ``docker-machine ip MACHINE_VM`` を実行すると Docker ホストの IP アドレスが得られるので、ポート番号をつけてアクセスします（ ``<DockerホストID>:8000`` ）。

   ..  ![Django example](images/django-it-worked.png)

   .. image:: /compose/images/django-it-worked.png
      :width: 60%
      :alt: Django の例

   ..  > Note:
       >
       > On certain platforms (Windows 10), you might need to
         edit `ALLOWED_HOSTS` inside `settings.py` and add your Docker host name
         or IP address to the list.  For demo purposes, you can set the value to:
       >
       >       ALLOWED_HOSTS = ['*']
       >
       > Please note this value is **not** safe for production usage.  Refer to the
        [Django documentation](https://docs.djangoproject.com/en/1.11/ref/settings/#allowed-hosts)  for more information.

   .. note::

      特定プラットフォーム（Windows 10）では、 ``settings.py`` ファイル内の ``ALLOWED_HOSTS`` に、ホスト名あるいはホストの IP アドレスを追加することが必要かもしれません。
      ここはデモが目的なので、以下のように設定することにします。

      ::

         ALLOWED_HOSTS = ['*']

      この設定は本番環境では **安全ではありません** 。
      詳しくは `Django ドキュメント <https://docs.djangoproject.com/en/1.11/ref/settings/#allowed-hosts>`_  を参照してください。

.. 5.  List running containers.

5. 起動しているコンテナの一覧を確認します。

   ..  In another terminal window, list the running Docker processes with the `docker ps` command.

   別の端末画面を開いて ``docker container ls`` コマンドを実行し、起動している Docker プロセスの一覧を表示します。

   ..  ```none
       $ docker ps
       CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                    NAMES
       def85eff5f51        django_web          "python3 manage.py..."   10 minutes ago      Up 9 minutes        0.0.0.0:8000->8000/tcp   django_web_1
       678ce61c79cc        postgres            "docker-entrypoint..."   20 minutes ago      Up 9 minutes        5432/tcp                 django_db_1
       ```

   ::

      $ docker ps
      CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                    NAMES
      def85eff5f51        django_web          "python3 manage.py..."   10 minutes ago      Up 9 minutes        0.0.0.0:8000->8000/tcp   django_web_1
      678ce61c79cc        postgres            "docker-entrypoint..."   20 minutes ago      Up 9 minutes        5432/tcp                 django_db_1

.. 6.  Shut down services and clean up by using either of these methods:

6. サービスを停止しクリアするために、以下のいずれかの方法をとります。

   ..  * Stop the application by typing `Ctrl-C`
       in the same shell in where you started it:

   * アプリケーションを実行したシェル上で ``Ctrl-C`` を入力してアプリケーションを止めます。

      .. ```none
         Gracefully stopping... (press Ctrl+C again to force)
         Killing test_web_1 ... done
         Killing test_db_1 ... done
         ```

      ::

         Gracefully stopping... (press Ctrl+C again to force)
         Killing test_web_1 ... done
         Killing test_db_1 ... done

   ..  * Or, for a more elegant shutdown, switch to a different shell, and run [docker-compose down](/compose/reference/down/) from the top level of your Django sample project directory.

   * もう少しきれいなやり方として別のシェル画面に切り替えて、Django サンプル・プロジェクトのトップ・ディレクトリにおいて :doc:`docker-compose down </compose/reference/down>` を実行します。

      .. ```none
         vmb at mymachine in ~/sandbox/django
         $ docker-compose down
         Stopping django_web_1 ... done
         Stopping django_db_1 ... done
         Removing django_web_1 ... done
         Removing django_web_run_1 ... done
         Removing django_db_1 ... done
         Removing network django_default
         ```

      ::

         vmb at mymachine in ~/sandbox/django
         $ docker-compose down
         Stopping django_web_1 ... done
         Stopping django_db_1 ... done
         Removing django_web_1 ... done
         Removing django_web_run_1 ... done
         Removing django_db_1 ... done
         Removing network django_default

..   Once you've shut down the app, you can safely remove the Django project directory (for example, `rm -rf django`).

アプリを停止したら Django プロジェクト・ディレクトリは何も問題なく削除することができます。
（たとえば ``rm -rf django`` ）

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

   "Quickstart: Compose and Django"
      https://docs.docker.com/compose/django/


