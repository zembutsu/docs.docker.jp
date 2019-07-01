.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/rails/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/rails.md
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/rails.md
.. check date: 2016/04/28
.. Commits on Mar 28, 2016 93901ec4805b0a72ba71ae910d3214e4856cd876
.. ----------------------------------------------------------------------------

.. title: "Quickstart: Compose and Rails"

=================================================
クィックスタート: Compose と Rails
=================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. This Quickstart guide will show you how to use Docker Compose to set up and run
   a Rails/PostgreSQL app. Before starting, you'll need to have [Compose
   installed](install.md).

このクィックスタートガイドでは Docker Compose を使って、簡単な Rails/PostgreSQL アプリを設定し実行する手順を示します。
はじめるには :doc:`Compose のインストール <install>` が必要です。

.. ### Define the project

プロジェクトの定義
-------------------

.. Start by setting up the four files you'll need to build the app. First, since
   your app is going to run inside a Docker container containing all of its
   dependencies, you'll need to define exactly what needs to be included in the
   container. This is done using a file called `Dockerfile`. To begin with, the
   Dockerfile consists of:

アプリのビルドに必要となる 4 つのファイルを作るところから始めます。
まずアプリケーションは、その依存パッケージも含め、すべてを Docker コンテナの内部にて実行するようにします。
そこでコンテナ内に含めるものが何であるのかは、正確に定義する必要があります。
これを行うのが ``Dockerfile`` というファイルです。
まずは Dockerfile を以下のようにします。

..  FROM ruby:2.3.3
    RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
    RUN mkdir /myapp
    WORKDIR /myapp
    ADD Gemfile /myapp/Gemfile
    ADD Gemfile.lock /myapp/Gemfile.lock
    RUN bundle install
    ADD . /myapp

.. code-block:: dockerfile

   FROM ruby:2.3.3
   RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
   RUN mkdir /myapp
   WORKDIR /myapp
   ADD Gemfile /myapp/Gemfile
   ADD Gemfile.lock /myapp/Gemfile.lock
   RUN bundle install
   ADD . /myapp

.. That'll put your application code inside an image that will build a container
   with Ruby, Bundler and all your dependencies inside it. For more information on
   how to write Dockerfiles, see the [Docker user
   guide](/engine/tutorials/dockerimages.md#building-an-image-from-a-dockerfile)
   and the [Dockerfile reference](/engine/reference/builder.md).

上の設定はイメージ内部にアプリケーション・コードを置きます。
そして Ruby、Bundler などの依存パッケージすべてをコンテナ内部においてビルドします。
Dockerfile の記述方法の詳細は :ref:`Docker ユーザ・ガイド <building-an-image-from-a-dockerfile>` や :doc:`Dockerfile リファレンス </engine/reference/builder>` を参照してください。

.. Next, create a bootstrap `Gemfile` which just loads Rails. It'll be overwritten
   in a moment by `rails new`.

次にブートストラップを行うファイル ``Gemfile`` を生成して、Rails をロードできるようにします。
このファイルは ``rails new`` を行ったタイミングで書き換わります。

..  source 'https://rubygems.org'
    gem 'rails', '5.0.0.1'

.. code-block:: ruby

   source 'https://rubygems.org'
   gem 'rails', '5.0.0.1'

.. You'll need an empty `Gemfile.lock` in order to build our `Dockerfile`.

空のファイル ``Gemfile.lock`` を生成して ``Dockerfile`` のビルドができるようにします。

..  touch Gemfile.lock

.. code-block:: bash

   touch Gemfile.lock

.. Finally, `docker-compose.yml` is where the magic happens. This file describes
   the services that comprise your app (a database and a web app), how to get each
   one's Docker image (the database just runs on a pre-made PostgreSQL image, and
   the web app is built from the current directory), and the configuration needed
   to link them together and expose the web app's port.

最後に ``docker-compose.yml`` が取りまとめてくれます。
このファイルには、データベースとウェブという 2 つのアプリを含んだサービスが定義されています。
そしてそれぞれの Docker イメージをどう作るかが示されています。
（データベースは既存の PostgreSQL イメージにより動作します。
ウェブアプリはカレントディレクトリ内に生成されます。）
また、リンクによってそれを結び合わせることが設定されていて、ウェブ・アプリのポートは外部に公開されています。

..  version: '3'
    services:
      db:
        image: postgres
      web:
        build: .
        command: bundle exec rails s -p 3000 -b '0.0.0.0'
        volumes:
          - .:/myapp
        ports:
          - "3000:3000"
        depends_on:
          - db

.. code-block:: yaml

   version: '3'
   services:
     db:
       image: postgres
     web:
       build: .
       command: bundle exec rails s -p 3000 -b '0.0.0.0'
       volumes:
         - .:/myapp
       ports:
         - "3000:3000"
       depends_on:
         - db
   
.. >**Tip**: You can use either a `.yml` or `.yaml` extension for this file.

.. tip::

   このファイルの拡張子は ``.yml`` と ``.yaml`` のどちらでも構いません。

.. ### Build the project

プロジェクトのビルド
---------------------

.. With those four files in place, you can now generate the Rails skeleton app
   using [docker-compose run](/compose/reference/run/):

ここまでの 4 つのファイルを使って :doc:`docker-compose run </compose/reference/run>` を実行し、Rails アプリのひながたを生成します。

..  docker-compose run web rails new . --force --database=postgresql

.. code-block:: bash

   docker-compose run web rails new . --force --database=postgresql

.. First, Compose will build the image for the `web` service using the
   `Dockerfile`. Then it will run `rails new` inside a new container, using that
   image. Once it's done, you should have generated a fresh app.

最初に Compose は ``Dockerfile`` を用いて ``web`` サービスに対するイメージをビルドします。
そしてこのイメージを利用して、新たに生成されたコンテナ内にて ``rails new`` を実行します。
処理が完了すれば、できたてのアプリが生成されているはずです。

.. List the files.

ファイル一覧を見てみます。

.. ```shell
   $ ls -l
   total 64
   -rw-r--r--   1 vmb  staff   222 Jun  7 12:05 Dockerfile
   -rw-r--r--   1 vmb  staff  1738 Jun  7 12:09 Gemfile
   -rw-r--r--   1 vmb  staff  4297 Jun  7 12:09 Gemfile.lock
   -rw-r--r--   1 vmb  staff   374 Jun  7 12:09 README.md
   -rw-r--r--   1 vmb  staff   227 Jun  7 12:09 Rakefile
   drwxr-xr-x  10 vmb  staff   340 Jun  7 12:09 app
   drwxr-xr-x   8 vmb  staff   272 Jun  7 12:09 bin
   drwxr-xr-x  14 vmb  staff   476 Jun  7 12:09 config
   -rw-r--r--   1 vmb  staff   130 Jun  7 12:09 config.ru
   drwxr-xr-x   3 vmb  staff   102 Jun  7 12:09 db
   -rw-r--r--   1 vmb  staff   211 Jun  7 12:06 docker-compose.yml
   drwxr-xr-x   4 vmb  staff   136 Jun  7 12:09 lib
   drwxr-xr-x   3 vmb  staff   102 Jun  7 12:09 log
   drwxr-xr-x   9 vmb  staff   306 Jun  7 12:09 public
   drwxr-xr-x   9 vmb  staff   306 Jun  7 12:09 test
   drwxr-xr-x   4 vmb  staff   136 Jun  7 12:09 tmp
   drwxr-xr-x   3 vmb  staff   102 Jun  7 12:09 vendor
   
   ```

.. code-block:: bash

   $ ls -l
   total 64
   -rw-r--r--   1 vmb  staff   222 Jun  7 12:05 Dockerfile
   -rw-r--r--   1 vmb  staff  1738 Jun  7 12:09 Gemfile
   -rw-r--r--   1 vmb  staff  4297 Jun  7 12:09 Gemfile.lock
   -rw-r--r--   1 vmb  staff   374 Jun  7 12:09 README.md
   -rw-r--r--   1 vmb  staff   227 Jun  7 12:09 Rakefile
   drwxr-xr-x  10 vmb  staff   340 Jun  7 12:09 app
   drwxr-xr-x   8 vmb  staff   272 Jun  7 12:09 bin
   drwxr-xr-x  14 vmb  staff   476 Jun  7 12:09 config
   -rw-r--r--   1 vmb  staff   130 Jun  7 12:09 config.ru
   drwxr-xr-x   3 vmb  staff   102 Jun  7 12:09 db
   -rw-r--r--   1 vmb  staff   211 Jun  7 12:06 docker-compose.yml
   drwxr-xr-x   4 vmb  staff   136 Jun  7 12:09 lib
   drwxr-xr-x   3 vmb  staff   102 Jun  7 12:09 log
   drwxr-xr-x   9 vmb  staff   306 Jun  7 12:09 public
   drwxr-xr-x   9 vmb  staff   306 Jun  7 12:09 test
   drwxr-xr-x   4 vmb  staff   136 Jun  7 12:09 tmp
   drwxr-xr-x   3 vmb  staff   102 Jun  7 12:09 vendor

.. If you are running Docker on Linux, the files `rails new` created are owned by
   root. This happens because the container runs as the root user. If this is the
   case, change the ownership of the new files.

Linux 上で Docker を利用している場合、``rails new`` により生成されたファイルの所有者は root になります。
これはコンテナが root ユーザにより実行されているためです。
この場合は、生成されたファイルの所有者を以下のように変更してください。

.. ```shell
   sudo chown -R $USER:$USER .
   ```
.. code-block:: bash

   sudo chown -R $USER:$USER .

.. If you are running Docker on Mac or Windows, you should already have ownership
   of all files, including those generated by `rails new`.

Docker on Mac あるいは Docker on Windows を利用している場合、``rails new`` により生成されたファイルも含め、すべてのファイルに対しての所有権は、正しく設定されているはずです。

.. Now that you’ve got a new Gemfile, you need to build the image again. (This, and changes to the Dockerfile itself, should be the only times you’ll need to rebuild.)

これで新しい ``Gemfile`` ができたので、イメージを再構築する必要があります（つまり、Dockerfile の更新時、必要に応じて再起動を行うべきです）。

.. code-block:: bash

   $ docker-compose build


.. Connect the database

データベースに接続
====================

.. The app is now bootable, but you’re not quite there yet. By default, Rails expects a database to be running on localhost - so you need to point it at the db container instead. You also need to change the database and username to align with the defaults set by the postgres image.

アプリケーションが実行可能になりましたが、まだ足りないものがあります。デフォルトでは、データベースは ``localhost`` で実行するとみなされます。そのため、``db`` コンテナに指示しなくてはいけません。``postgres`` イメージにデフォルトで設定されている database と username を変更する必要があります。

.. Replace the contents of config/database.yml with the following:

``config/database.yml`` を次のように置き換えます。

.. code-block:: yaml

   development: &default
     adapter: postgresql
     encoding: unicode
     database: postgres
     pool: 5
     username: postgres
     password:
     host: db
   
   test:
     <<: *default
     database: myapp_test

.. You can now boot the app with:

これでアプリケーションを起動できます。

.. code-block:: bash

   $ docker-compose up

.. If all’s well, you should see some PostgreSQL output, and then—after a few seconds—the familiar refrain:

上手くいけば、次のような PostgreSQL の出力が見え、数秒後、似たような表示を繰り返します。

.. code-block:: bash

   myapp_web_1 | [2014-01-17 17:16:29] INFO  WEBrick 1.3.1
   myapp_web_1 | [2014-01-17 17:16:29] INFO  ruby 2.2.0 (2014-12-25) [x86_64-linux-gnu]
   myapp_web_1 | [2014-01-17 17:16:29] INFO  WEBrick::HTTPServer#start: pid=1 port=3000

.. Finally, you need to create the database. In another terminal, run:

最後にデータベースを作成する必要があります。他のターミナルで、次のように実行します。

.. code-block:: bash

   $ docker-compose run web rake db:create

.. That’s it. Your app should now be running on port 3000 on your Docker daemon. If you’re using Docker Machine, then docker-machine ip MACHINE_VM returns the Docker host IP address.

以上です。これで Docker デーモン上のポート 3000 でアプリケーションが動作しているでしょう。もし :doc:`Docker Machine </machine/index>` を使っている場合は、``docker-machine ip 仮想マシン名`` で Docker ホストの IP アドレスを確認できます。


.. More Compose documentation

Compose の更なるドキュメント
==============================

..
    User guide
    Installing Compose
    Getting Started
    Get started with Django
    Get started with WordPress
    Command line reference
    Compose file reference

* :doc:`ユーザガイド <index>`
* :doc:`/compose/install`
* :doc:`/compose/gettingstarted`
* :doc:`/compose/django`
* :doc:`/compose/wordpress`
* :doc:`/compose/reference/index`
* :doc:`/compose/compose-file`

.. seealso:: 

   Quickstart: Docker Compose and Rails
      https://docs.docker.com/compose/rails/

