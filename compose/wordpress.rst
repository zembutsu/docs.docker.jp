.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/wordpress/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/wordpress.md
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/wordpress.md
.. check date: 2016/04/28
.. Commits on Apr 9, 2016 4192a009da5cbae5c811b3b965e4ecb4572c95f6
.. ----------------------------------------------------------------------------

.. title: "Quickstart: Compose and WordPress"

=====================================================
クィックスタート: Compose と WordPress
=====================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. You can use Docker Compose to easily run WordPress in an isolated environment
   built with Docker containers. This quick-start guide demonstrates how to use
   Compose to set up and run WordPress. Before starting, you'll need to have
   [Compose installed](/compose/install.md).

Docker Compose を使うと、Docker コンテナとして生成される独立した環境内にて WordPress を簡単に実現することができます。
このクイックスタート・ガイドは、Docker Compose を使った WordPress の設定と実行方法を示すものです。
はじめるには :doc:`Compose のインストール <install>` が必要です。

.. ### Define the project

プロジェクトの定義
====================

.. 1.  Create an empty project directory.

1. プロジェクト用の空のディレクトリを生成します。

   ..  You can name the directory something easy for you to remember.
       This directory is the context for your application image. The
       directory should only contain resources to build that image.

   ディレクトリ名は覚えやすいものにします。
   このディレクトリはアプリケーションイメージのコンテキストディレクトリとなります。
   このディレクトリには、イメージをビルドするために必要となるものだけを含めるようにします。

   ..  This project directory will contain a `docker-compose.yml` file which will
       be complete in itself for a good starter wordpress project.

   このプロジェクトディレクトリに ``docker-compose.yml`` ファイルを置きます。
   このファイルそのものが、WordPress プロジェクトを開始するための内容をすべて含むものとなります。

   ..  >**Tip**: You can use either a `.yml` or `.yaml` extension for
       this file. They both work.

   .. note::

      このファイルの拡張子は ``.yml`` と ``.yaml`` のどちらでも構いません。
      いずれであっても動作します。

   .. 2.  Change directories into your project directory.

2. プロジェクトディレクトリに移動します。

   .. For example, if you named your directory `my_wordpress`:

   そのディレクトリをたとえば ``my_wordpress`` としていた場合、以下のようになります。

   ..      cd my_wordpress/

   .. code-block:: bash

      cd my_wordpress/

   .. 3.  Create a `docker-compose.yml` file that will start your
          `WordPress` blog and a separate `MySQL` instance with a volume
          mount for data persistence:

3. ``docker-compose.yml`` ファイルを生成します。
   このファイルが ``WordPress`` ブログを起動します。
   それとは別に、データ保存のためにボリュームマウントを使った ``MySQL`` インスタンスを生成します。

   ..  ```none
       version: '3'

       services:
          db:
            image: mysql:5.7
            volumes:
              - db_data:/var/lib/mysql
            restart: always
            environment:
              MYSQL_ROOT_PASSWORD: somewordpress
              MYSQL_DATABASE: wordpress
              MYSQL_USER: wordpress
              MYSQL_PASSWORD: wordpress

          wordpress:
            depends_on:
              - db
            image: wordpress:latest
            ports:
              - "8000:80"
            restart: always
            environment:
              WORDPRESS_DB_HOST: db:3306
              WORDPRESS_DB_USER: wordpress
              WORDPRESS_DB_PASSWORD: wordpress
       volumes:
           db_data:
       ```
   .. code-block:: yaml

      version: '3'

      services:
         db:
           image: mysql:5.7
           volumes:
             - db_data:/var/lib/mysql
           restart: always
           environment:
             MYSQL_ROOT_PASSWORD: somewordpress
             MYSQL_DATABASE: wordpress
             MYSQL_USER: wordpress
             MYSQL_PASSWORD: wordpress

         wordpress:
           depends_on:
             - db
           image: wordpress:latest
           ports:
             - "8000:80"
           restart: always
           environment:
             WORDPRESS_DB_HOST: db:3306
             WORDPRESS_DB_USER: wordpress
             WORDPRESS_DB_PASSWORD: wordpress
      volumes:
          db_data:

   .. > **Notes**:
      >
      * The docker volume `db_data` persists any updates made by Wordpress
      to the database. [Learn more about docker volumes](/engine/tutorials/dockervolumes.md)
      >
      * WordPress Multisite works only on ports `80` and `443`.
      {: .note-vanilla}

   .. note::

      * Docker ボリューム ``db_data`` は、WordPress 上から実行されるデータ更新をデータベースに保存します。
        詳細は :doc:`Docker ボリューム </engine/admin/volumes/volumes>` を参照してください。

      * WordPress のマルチサイトは、ポート ``80`` と ``443`` 上においてのみ動作します。


.. ### Build the project

プロジェクトの構築
====================

.. Now, run `docker-compose up -d` from your project directory.

プロジェクトディレクトリ上にて ``docker-compose up -d`` を実行します。

.. This runs [docker-compose up](/compose/reference/up/) in detached mode, pulls
   the needed images, and starts the wordpress and database containers, as shown in
   the example below.

これはデタッチモードにより :doc:`docker-compose up </compose/reference/up>` を実行し、不足する Docker イメージがあれば取得します。
そして WordPress と データベースの両コンテナを起動します。
たとえば以下のようになります。

.. ```
   $ docker-compose up -d
   Creating network "my_wordpress_default" with the default driver
   Pulling db (mysql:5.7)...
   5.7: Pulling from library/mysql
   efd26ecc9548: Pull complete
   a3ed95caeb02: Pull complete
   ...
   Digest: sha256:34a0aca88e85f2efa5edff1cea77cf5d3147ad93545dbec99cfe705b03c520de
   Status: Downloaded newer image for mysql:5.7
   Pulling wordpress (wordpress:latest)...
   latest: Pulling from library/wordpress
   efd26ecc9548: Already exists
   a3ed95caeb02: Pull complete
   589a9d9a7c64: Pull complete
   ...
   Digest: sha256:ed28506ae44d5def89075fd5c01456610cd6c64006addfe5210b8c675881aff6
   Status: Downloaded newer image for wordpress:latest
   Creating my_wordpress_db_1
   Creating my_wordpress_wordpress_1
   ```

.. code-block:: bash

   $ docker-compose up -d
   Creating network "my_wordpress_default" with the default driver
   Pulling db (mysql:5.7)...
   5.7: Pulling from library/mysql
   efd26ecc9548: Pull complete
   a3ed95caeb02: Pull complete
   ...
   Digest: sha256:34a0aca88e85f2efa5edff1cea77cf5d3147ad93545dbec99cfe705b03c520de
   Status: Downloaded newer image for mysql:5.7
   Pulling wordpress (wordpress:latest)...
   latest: Pulling from library/wordpress
   efd26ecc9548: Already exists
   a3ed95caeb02: Pull complete
   589a9d9a7c64: Pull complete
   ...
   Digest: sha256:ed28506ae44d5def89075fd5c01456610cd6c64006addfe5210b8c675881aff6
   Status: Downloaded newer image for wordpress:latest
   Creating my_wordpress_db_1
   Creating my_wordpress_wordpress_1

.. > **Note**: WordPress Multisite works only on ports `80` and/or `443`.
   If you get an error message about binding `0.0.0.0` to port `80` or `443`
   (depending on which one you specified), it is likely that the port you
   configured for WordPress is already in use by another service.

.. note::

   WordPress のマルチサイトは、ポート ``80`` と ``443`` 上においてのみ動作します。
   ``0.0.0.0`` の ``80`` や ``443`` （あるいは設定したポート） へのバインディングに関するエラーが発生したら、WordPress に割り当てたポートが、すでに別のサービスによって利用されていることが考えられます。

.. ### Bring up WordPress in a web browser

.. _bring-up-wordpress-in-a-web-browser:

ウェブ・ブラウザ上での WordPress の起動
========================================

.. At this point, WordPress should be running on port `8000` of your Docker Host,
   and you can complete the "famous five-minute installation" as a WordPress
   administrator.

この時点で WordPress は Docker ホスト上のポート ``8000`` 番を使って稼動しています。
そこで WordPress の管理者となって「よく知られた 5 分インストール」を行うことができます。

.. > **Note**: The WordPress site will not be immediately available on port `8000`
   because the containers are still being initialized and may take a couple of
   minutes before the first load.

.. note::

   WordPress サイトはポート ``8000`` を使って稼動していると述べましたが、即座に利用できるわけではありません。
   コンテナは初期化を行っている最中であり、初回の読み込み処理には数分の時間を要するからです。

.. If you are using [Docker Machine](/machine/index.md), you can run the command
   `docker-machine ip MACHINE_VM` to get the machine address, and then open
   `http://MACHINE_VM_IP:8000` in a web browser.

:doc:`Docker Machine </machine/index>` を利用している場合は、``docker-machine ip MACHINE_VM`` を実行してマシンの IP アドレスを取得できます。
そこでウェブ・ブラウザから ``http://MACHINE_VM_IP:8000`` にアクセスしてください。

.. If you are using Docker for Mac or Docker for Windows, you can use
   `http://localhost` as the IP address, and open `http://localhost:8000` in a web
   browser.

Docker Desktop for Mac や Docker Desktop for Windows を利用している場合、IP アドレスとしては ``http://localhost`` を利用し、ウェブ・ブラウザから ``http://localhost:8000`` にアクセスしてください。

.. ![Choose language for WordPress install](images/wordpress-lang.png)

.. image:: ./images/wordpress-lang.png
   :scale: 60%
   :alt: WordPress 言語選択

.. ![WordPress Welcome](images/wordpress-welcome.png)

.. image:: ./images/wordpress-welcome.png
   :scale: 60%
   :alt: WordPress ようこそ画面

.. ### Shutdown and cleanup

シャットダウンとクリーンアップ
========================================

.. The command [docker-compose down](/compose/reference/down.md) removes the
   containers and default network, but preserves your Wordpress database.

:doc:`docker-compose down </compose/reference/down>` コマンドを実行すると、コンテナとデフォルトネットワークが削除されます。
ただし WordPress データベースは残ります。

.. The command `docker-compose down --volumes` removes the containers, default
   network, and the Wordpress database.

``docker-compose down --volumes`` コマンドを実行すると、コンテナとデフォルトネットワーク、さらに WordPress データベースも削除します。

.. ## More Compose documentation

Compose ドキュメント
==============================

.. - [User guide](/compose/index.md)
   - [Installing Compose](/compose/install.md)
   - [Getting Started](/compose/gettingstarted.md)
   - [Get started with Django](/compose/django.md)
   - [Get started with Rails](/compose/rails.md)
   - [Command line reference](/compose/reference/index.md)
   - [Compose file reference](/compose/compose-file/index.md)

* :doc:`ユーザガイド <index>`
* :doc:`/compose/install`
* :doc:`/compose/gettingstarted`
* :doc:`/compose/django`
* :doc:`/compose/rails`
* :doc:`/compose/reference/index`
* :doc:`/compose/compose-file`

.. seealso:: 

   Quickstart: Compose and WordPress
      https://docs.docker.com/compose/wordpress/

