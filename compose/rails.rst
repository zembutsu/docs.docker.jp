.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/rails/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/rails.md
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/rails.md
.. check date: 2016/04/28
.. Commits on Mar 28, 2016 93901ec4805b0a72ba71ae910d3214e4856cd876
.. ----------------------------------------------------------------------------

.. Quickstart Guide: Compose and Rails

=================================================
クイックスタート・ガイド：Docker Compose と Rails
=================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. This quick-start guide demonstrates how to use Docker Compose to set up and run a simple Rails/PostgreSQL app. Before starting, you’ll need to have Compose installed.

このクイックスタート・ガイドは Docker Compose を使い、簡単な Rails/PostgreSQL アプリをセットアップします。事前に :doc:`Compose のインストール </compose/install>` が必要です。

.. Define the project

プロジェクトを定義
====================

.. Start by setting up the three files you’ll need to build the app. First, since your app is going to run inside a Docker container containing all of its dependencies, you’ll need to define exactly what needs to be included in the container. This is done using a file called Dockerfile. To begin with, the Dockerfile consists of:

アプリケーションを構築するため、３つのファイルをセットアップしていきます。まずアプリケーションを実行する前に、 Docker コンテナ内には、依存関係のある全ての準備が必要になります。そのため、コンテナ中で何が必要なのかを、正確に定義しなくてはいけません。この定義に使うのが ``Dockerfile`` と呼ばれるファイルです。まずはじめに、Dockerfile は次のような構成です。

.. code-block:: dockerfile

   FROM ruby:2.2.0
   RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
   RUN mkdir /myapp
   WORKDIR /myapp
   ADD Gemfile /myapp/Gemfile
   ADD Gemfile.lock /myapp/Gemfile.lock
   RUN bundle install
   ADD . /myapp

これはイメージ内にアプリケーションのコードを送ります。ここでは Ruby イメージを使い、Bundler や内部の依存関係を持つコンテナを作成します。 ``Dockerfile`` の書き方など詳細情報については、 :ref:`Docker ユーザ・ガイド <building-an-image-from-a-dockerfile>` や :doc:`Dockerfile リファレンス </engine//reference/builder>` をご覧ください。

.. Next, create a bootstrap Gemfile which just loads Rails. It’ll be overwritten in a moment by rails new.

次に Rails を読み込むだけのブートストラップ用の ``Gemfile`` を作成します。``rails new`` によって上書きされます。

.. code-block:: ruby

   source 'https://rubygems.org'
   gem 'rails', '4.2.0'

.. You’ll need an empty Gemfile.lock in order to build our Dockerfile.

そして ``Dockerfile`` の構築には、空の ``Gemfile.lock`` が必要です。

.. code-block:: bash

   $ touch Gemfile.lock

.. Finally, docker-compose.yml is where the magic happens. This file describes the services that comprise your app (a database and a web app), how to get each one’s Docker image (the database just runs on a pre-made PostgreSQL image, and the web app is built from the current directory), and the configuration needed to link them together and expose the web app’s port.

最後に ``docker-compose.yml`` というファイルに、これら全てを結び付けます。アプリケーション構成するサービス（ここでは、ウェブサーバとデータベースです）を定義します。構成とは、使用する Docker イメージ（データベースは既製の PostgreSQL イメージを使い、ウェブ・アプリケーションは現在のディレクトリで構築します）と、必要であればどこをリンクするかや、ウェブ・アプリケーションの公開用ポートを記述します。

.. code-block:: yaml

   version: '2'
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
   
.. Build the project

プロジェクトの構築
====================

.. With those three files in place, you can now generate the Rails skeleton app using docker-compose run:

これらの３つのファイルを用い、``docker-compose run`` コマンドを使い新しい Rails スケルトン・アプリを作成します。

.. code-block:: bash

   $ docker-compose run web rails new . --force --database=postgresql --skip-bundle

.. First, Compose will build the image for the web service using the Dockerfile. Then it’ll run rails new inside a new container, using that image. Once it’s done, you should have generated a fresh app:

Compose はまず ``Dockerfile`` を使い ``web`` サービスのイメージを構築します。それからそのイメージを使った新しいコンテナの中で、``rails new`` を実行します。完了すると、次のように新しいアプリが作成されています。

.. code-block:: bash

    $ ls
    Dockerfile   app          docker-compose.yml      tmp
    Gemfile      bin          lib          vendor
    Gemfile.lock config       log
    README.rdoc  config.ru    public
    Rakefile     db           test

.. The files rails new created are owned by root. This happens because the container runs as the root user. Change the ownership of the new files.

``rails new`` によって作成されるファイルは所有者が root でした。これはコンテナが ``root`` ユーザによって実行されたからです。新しいファイルの所有者を変更します。

.. code-block:: bash

   sudo chown -R $USER:$USER .

.. Uncomment the line in your new Gemfile which loads therubyracer, so you’ve got a Javascript runtime:

新しい ``Gemfile`` から ``therubyracer`` を読み込む行をアンコメントします。これは Javascript のランタイムを入手したからです。

.. code-block:: ruby

   gem 'therubyracer', platforms: :ruby

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

