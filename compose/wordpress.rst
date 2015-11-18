.. http://docs.docker.com/compose/wordpress/
.. doc version: 1.9
.. check date: 2015/11/18

.. Quickstart Guide: Compose and WordPress

=================================================
クイックスタート・ガイド：Compose と Wordpress
=================================================

.. You can use Compose to easily run WordPress in an isolated environment built with Docker containers.

Compose を使えば、Docker コンテナを構築に使い、分離した環境に上で簡単に WordPress を実行できます。

.. Define the project

プロジェクトの定義
====================

.. First, Install Compose and then download WordPress into the current directory:

まず、 :doc:`Compose をインストール </compose/install>` し、現在のディレクトリに WordPress をダウンロードします。

.. code-block:: bash

   $ curl https://wordpress.org/latest.tar.gz | tar -xvzf -

.. This will create a directory called wordpress. If you wish, you can rename it to the name of your project.

これにより ``wordpress`` という名称のディレクトリを作成しました。必要であれば名前を変更し、プロジェクト名を変更できます。

.. Next, inside that directory, create a Dockerfile, a file that defines what environment your app is going to run in. For more information on how to write Dockerfiles, see the Docker user guide and the Dockerfile reference. In this case, your Dockerfile should be:

次に、ディレクトリに入り、 ``Dockerfile`` を作成します。このファイルでは、どのような環境でアプリケーションを実行しようとしているかを定義します。Dockerfile の書き方は、 :ref:`Docker ユーザガイド <building-an-image-from-a-dockerfile>` と :doc:`Dockerfile リファレンス</compose/builder>` をお読みください。この例では、Dockefile を次のようにします：

.. code-block:: yaml

   FROM orchardup/php5
   ADD . /code

.. This tells Docker how to build an image defining a container that contains PHP and WordPress.

これは Docker に対して、イメージの構築方法を伝えます。そのイメージとは、PHP と Wordpress を含むコンテナを定義したものです。

.. Next you’ll create a docker-compose.yml file that will start your web service and a separate MySQL instance:

次に、 ``docker-compose.yml`` ファイルを作成します。これはウェブ・サービスと MySQL インスタンスを分けて起動するものです。

.. code-block:: yaml

   web:
     build: .
     command: php -S 0.0.0.0:8000 -t /code
     ports:
       - "8000:8000"
     links:
       - db
     volumes:
       - .:/code
   db:
     image: orchardup/mysql
     environment:
       MYSQL_DATABASE: wordpress

.. A supporting file is needed to get this working. wp-config.php is the standard WordPress config file with a single change to point the database configuration at the db container:

動かすためには、ファイル編集が必要です。``wp-config.php`` という通常の WordPress の設定ファイルです。このファイルの１箇所だけ、データベースの接続先を ``db`` コンテナに書き換えます。

.. code-block:: php

   <?php
   define('DB_NAME', 'wordpress');
   define('DB_USER', 'root');
   define('DB_PASSWORD', '');
   define('DB_HOST', "db:3306");
   define('DB_CHARSET', 'utf8');
   define('DB_COLLATE', '');
   
   define('AUTH_KEY',         'put your unique phrase here');
   define('SECURE_AUTH_KEY',  'put your unique phrase here');
   define('LOGGED_IN_KEY',    'put your unique phrase here');
   define('NONCE_KEY',        'put your unique phrase here');
   define('AUTH_SALT',        'put your unique phrase here');
   define('SECURE_AUTH_SALT', 'put your unique phrase here');
   define('LOGGED_IN_SALT',   'put your unique phrase here');
   define('NONCE_SALT',       'put your unique phrase here');
   
   $table_prefix  = 'wp_';
   define('WPLANG', '');
   define('WP_DEBUG', false);
   
   if ( !defined('ABSPATH') )
       define('ABSPATH', dirname(__FILE__) . '/');
   
   require_once(ABSPATH . 'wp-settings.php');


.. Build the project

プロジェクトの構築
====================

.. With those four files in place, run docker-compose up inside your WordPress directory and it’ll pull and build the needed images, and then start the web and database containers. If you’re using Docker Machine, then docker-machine ip MACHINE_VM gives you the machine address and you can open http://MACHINE_VM_IP:8000 in a browser.

ここに４つのファイルができています。Wordpress ディレクトリの中で、``docker-compose up`` を実行すると、必要なイメージを取得・構築し、ウェブとデータベースのコンテナを起動します。 :doc:`Docker Machine </machine/index>` を使っている場合は、``docker-machine ip 仮想マシン名`` を実行することで、マシンの IP アドレスを取得します。それからブラウザで ``http://仮想マシンのIP:8000`` を開きます。


.. More Compose documentation

Compose の更なるドキュメント
==============================

..
    User guide
    Installing Compose
    Getting Started
    Get started with Django
    Get started with Rails
    Command line reference
    Compose file reference

* :doc:`ユーザガイド </index>`
* :doc:`/compose/gettingstarted`
* :doc:`/compose/django`
* :doc:`/compose/rails`
* :doc:`/compose/reference`
* :doc:`/compose/compose-file`


