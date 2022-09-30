.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/language/python/develop/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/language/python/develop.md
.. check date: 2022/09/30
.. Commits on Sep 30, 2022 a7a98243508e1f1d1f5f7539daea7126235fc43d
.. -----------------------------------------------------------------------------

.. Use containers for development
.. _python-use-containers-for-development:

========================================
開発にコンテナを使う
========================================

.. Prerequisites
.. _python-develop-prerequisites:

事前準備
==========

.. Work through the steps to build an image and run it as a containerized application in Run your image as a container.

:doc:`run-containers` で、イメージ構築をし、それコンテナ化アプリケーションとして実行します。

.. Introduction
.. _python-develop-introduction:

概要
==========

.. In this module, we’ll walk through setting up a local development environment for the application we built in the previous modules. We’ll use Docker to build our images and Docker Compose to make everything a whole lot easier.

この章では、これまでのモジュールで構築したアプリケーションの、ローカル開発環境をセットアップする方法を説明します。イメージの構築には Docker を使い、すべてをとても簡単にする Docker Compose も使います。

.. Local database and containers
.. _python-local-database-and-containers:

ローカルデータベースとコンテナ
==============================

.. First, we’ll take a look at running a database in a container and how we use volumes and networking to persist our data and allow our application to talk with the database. Then we’ll pull everything together into a compose file which will allow us to setup and run a local development environment with one command. Finally, we’ll take a look at connecting a debugger to our application running inside a container.

まず、コンテナでデータベースを実行する方法と、データを保持するためにボリュームとネットワーク機能を使い、アプリケーションがデータベースと通信できるようにする方法を説明します。それから、compose ファイルの中にすべてを入れ込みます。このファイルは1つのコマンドで、ローカル開発環境のセットアップと実行をできるようにします。最後に、コンテナ内で実行しているアプリケーションに、デバッガを接続する方法を説明します。

.. Instead of downloading MySQL, installing, configuring, and then running the MySQL database as a service, we can use the Docker Official Image for MySQL and run it in a container.

MySQL をダウンロードし、インストールし、設定し、MySQL データベースをサービスとして実行する代わりに、MySQL 用の Docker 公式イメージを使い、コンテナとして実行できるようになります。

.. Before we run MySQL in a container, we’ll create a couple of volumes that Docker can manage to store our persistent data and configuration. Let’s use the managed volumes feature that Docker provides instead of using bind mounts. You can read all about Using volumes in our documentation.

コンテナ内で MySQL を実行する前に、2つのボリュームを作成しておきたいです。これは、Docker が :ruby:`保持し続けるデータ <persistent data>` と :ruby:`設定ファイル <configuration>` を保存できます。バインド マウントを使う代わりに、 docker が提供するマネージド ボリューム機能を使いましょう。詳しい情報は :doc:`/storage/volumes` をご覧ください。

.. Let’s create our volumes now. We’ll create one for the data and one for configuration of MySQL.

それでは、ボリュームを作成しましょう。作成するボリュームの1つは MySQL のデータ用で、もう1つは設定ファイル用です。

.. code-block:: bash

   $ docker volume create mysql
   $ docker volume create mysql_config

.. Now we’ll create a network that our application and database will use to talk with each other. The network is called a user-defined bridge network and gives us a nice DNS lookup service which we can use when creating our connection string.

次は、アプリケーションとデータベースが相互に対話できるようにするためのネットワークを作成します。ネットワークは :ruby:`ユーザ定義ブリッジネットワーク <user-defined bridge network>` と呼ばれ、優れた DNS 名前解決サービスを提供するため、 :ruby:`接続文字列 <connection string>` を作成するために使えます。

.. code-block:: bash

   $ docker network create mysqlnet

.. Now we can run MySQL in a container and attach to the volumes and network we created above. Docker pulls the image from Hub and runs it for you locally. In the following command, option -v is for starting the container with volumes. For more information, see Docker volumes.

次は、コンテナとして MySQL を実行し、先ほど作成したボリュームとネットワークに接続できるようにします。Docker は Hub からイメージを取得し、ローカルでイメージを実行します。以下のコマンドでは、 ``-v`` はコンテナにボリュームを付けて起動します。詳しい情報は :doc:`Docker ボリューム </storage/volumes>` をご覧ください。

.. Now we can run MongoDB in a container and attach to the volumes and network we created above. Docker will pull the image from Hub and run it for you locally.

次は、コンテナとして MongoDB を実行し、先ほど作成したボリュームとネットワークに接続できるようにします。Docker は Hub からイメージを取得し、ローカルでイメージを実行します。

.. code-block:: bash

   $ docker run --rm -d -v mysql:/var/lib/mysql \
     -v mysql_config:/etc/mysql -p 3306:3306 \
     --network mysqlnet \
     --name mysqldb \
     -e MYSQL_ROOT_PASSWORD=p@ssw0rd1 \
     mysql

.. Now, let’s make sure that our MySQL database is running and that we can connect to it. Connect to the running MySQL database inside the container using the following command and enter “p@ssw0rd1” when prompted for the password:

次は、 MySQL データベースが起動して接続できるかどうかを確認します。コンテナ内で実行している MySQL データベースに接続するには、以下のコマンドを実行し、パスワードのプロンプトでは「p@ssw0rd1」を入力します。

.. code-block:: bash

   $ docker exec -ti mysqldb mysql -u root -p
   Enter password:
   Welcome to the MySQL monitor.  Commands end with ; or \g.
   Your MySQL connection id is 8
   Server version: 8.0.23 MySQL Community Server - GPL
   
   Copyright (c) 2000, 2021, Oracle and/or its affiliates.
   
   Oracle is a registered trademark of Oracle Corporation and/or its
   affiliates. Other names may be trademarks of their respective
   owners.
   
   Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.
   
   mysql>

.. Connect the application to the database
.. _python-develop-connect-the-application-to-the-database:

アプリケーションをデータベースに接続
----------------------------------------

.. In the above command, we logged in to the MySQL database by passing the ‘mysql’ command to the mysqldb container. Press CTRL-D to exit the MySQL interactive terminal.

先ほどのコマンドは、 ``mysqldb`` コンテナに対して「mysql」コマンドを実行し MySQL データベースログインしました。 MySQL 双方向ターミナルを終了するには CTRL-D を押します。

.. Next, we’ll update the sample application we created in the Build images module. To see the directory structure of the Python app, see Python application directory structure.

次は、 :ref:`イメージ構築 <python-sample-application>` の章で作成したサンプルアプリケーションを更新します。Python アプリのディレクトリ構成をみるには、 :ref:`python-build-directory-structure` をご覧ください。

.. Okay, now that we have a running MySQL, let’s update the app.py to use MySQL as a datastore. Let’s also add some routes to our server. One for fetching records and one for inserting records.

それでは、MySQL を実行していますので、 ``app.py`` を更新してデータベースとして MySQL を使うようにします。また、サーバに対する手順もいくつか追加しましょう。1つはレコードを取得し、1つはレコードを挿入します。

.. code-block:: python

   import mysql.connector
   import json
   from flask import Flask
   
   app = Flask(__name__)
   
   @app.route('/')
   def hello_world():
       return 'Hello, Docker!'
   
   @app.route('/widgets')
   def get_widgets():
       mydb = mysql.connector.connect(
           host="mysqldb",
           user="root",
           password="p@ssw0rd1",
           database="inventory"
       )
       cursor = mydb.cursor()
   
   
       cursor.execute("SELECT * FROM widgets")
   
       row_headers=[x[0] for x in cursor.description] #this will extract row headers
   
       results = cursor.fetchall()
       json_data=[]
       for result in results:
           json_data.append(dict(zip(row_headers,result)))
   
       cursor.close()
   
       return json.dumps(json_data)
   
   @app.route('/initdb')
   def db_init():
       mydb = mysql.connector.connect(
           host="mysqldb",
           user="root",
           password="p@ssw0rd1"
       )
       cursor = mydb.cursor()
   
       cursor.execute("DROP DATABASE IF EXISTS inventory")
       cursor.execute("CREATE DATABASE inventory")
       cursor.close()
   
       mydb = mysql.connector.connect(
           host="mysqldb",
           user="root",
           password="p@ssw0rd1",
           database="inventory"
       )
       cursor = mydb.cursor()
   
       cursor.execute("DROP TABLE IF EXISTS widgets")
       cursor.execute("CREATE TABLE widgets (name VARCHAR(255), description VARCHAR(255))")
       cursor.close()
   
       return 'init database'
   
   if __name__ == "__main__":
       app.run(host ='0.0.0.0')

.. We’ve added the MySQL module and updated the code to connect to the database server, created a database and table. We also created a couple of routes to save widgets and fetch widgets. We now need to rebuild our image so it contains our changes.

MySQL モジュールを追加し、データベースサーバに接続するようコードを更新し、データベースとテーブルを作成します。また、 widgets の保存と widgets の取得という2つの手順を追加しました。次は、変更を含むイメージを再構築する必要があります。

.. First, let’s add the mysql-connector-python module to our application using pip.

まず、 ``pip`` を使ってアプリケーションに ``mysql-connector-python`` モジュールを追加しましょう。

.. code-block:: bash

   $ pip3 install mysql-connector-python
   $ pip3 freeze | grep mysql-connector-python >> requirements.txt

.. Now we can build our image.

それから、イメージを構築できます。

.. code-block:: bash

   $ docker build --tag python-docker-dev .

.. Now, let’s add the container to the database network and then run our container. This allows us to access the database by its container name.

次はコンテナにデータベースネットワークを追加し、コンテナを実行します。これにより、データベースのコンテナ名を使ってアクセスできるようになります。

.. code-block:: bash

   $ docker run \
     --rm -d \
     --network mysqlnet \
     --name rest-server \
     -p 8000:5000 \
     python-docker-dev

.. Let’s test that our application is connected to the database and is able to add a note.

アプリケーションがデータベースに接続し、メモを追加できるかテストしましょう。

.. code-block:: bash

   $ curl http://localhost:8000/initdb
   $ curl http://localhost:8000/widgets

.. You should receive the following JSON back from our service.

サービスからは以下の JSON を受け取るでしょう。

.. code-block:: bash

   []


.. Use Compose to develop locally
.. _python-develop-use-compose-to-develop-locally:

Compose を使ってローカルで開発
==============================

.. In this section, we’ll create a Compose file to start our python-docker and the MySQL database using a single command. We’ll also set up the Compose file to start the python-docker-dev application in debug mode so that we can connect a debugger to the running process.

このセクションでは、 python-docker と MySQL データベースを1つのコマンドで起動するための :doc:`Compose ファイル </compose/index>` を作成します。また、 python-docker-dev アプリケーションをデバッグモードで起動するための Compose ファイルも作成しますので、実行中のプロセスにデバッガを接続できるようになります。

.. Open the python-docker directory in your IDE or a text editor and create a new file named docker-compose.dev.yml. Copy and paste the following commands into the file.

IDE のメモ機能やテキストエディタで ``python-docker`` を開き、 ``docker-compose.dev.yml`` という名前の新しいファイルを作成します。ファイル内に以下の命令をコピー＆ペーストします。

.. code-block:: yaml

   version: '3.8'
   
   services:
    web:
     build:
      context: .
     ports:
     - 8000:5000
     volumes:
     - ./:/app
   
    mysqldb:
     image: mysql
     ports:
     - 3306:3306
     environment:
     - MYSQL_ROOT_PASSWORD=p@ssw0rd1
     volumes:
     - mysql:/var/lib/mysql
     - mysql_config:/etc/mysql
   
   volumes:
     mysql:
     mysql_config:

.. This Compose file is super convenient as we do not have to type all the parameters to pass to the docker run command. We can declaratively do that in the Compose file.

この Compose ファイルは ``docker run`` コマンドに一切パラメータを渡す必要がないため、とても便利です。Compose ファイル内で宣言的にパラメータを指定します。

.. We expose port 8000 so that we can reach the dev web server inside the container. We also map our local source code into the running container to make changes in our text editor and have those changes picked up in the container.

ポート ``8000`` を公開していますので、コンテナ内の dev  ウェブサーバに到達できます。また、ローカルのソースコードを実行中のコンテナにマッピングしていますので、テキストエディタで変更できるだけなく、それらの変更をコンテナに取り込めます。

.. Another really cool feature of using a Compose file is that we have service resolution set up to use the service names. Therefore, we are now able to use “mysqldb” in our connection string. The reason we use “mysqldb” is because that is what we’ve named our MySQL service as in the Compose file.

Compose ファイルを使う上で、もう1つの素晴らしい機能は、サービス名を使ってサービスの名前解決をできるようになります。そのため、接続文字列として「mysqldb」が使えるようになります。「mysqld」という名前を使えるのは、 MySQL サービスに対して Compose ファイル内でそのように名付けたからです。

.. Now, to start our application and to confirm that it is running properly, run the following command:

次は、アプリケーションを起動し、適切に動作しているか確認しましょう。

.. code-block:: bash

   $ docker-compose -f docker-compose.dev.yml up --build

.. We pass the --build flag so Docker will compile our image and then start the containers.

``--build`` フラグを渡したため、 Docker はイメージをコンパイルした後、イメージを起動します。

.. Now let’s test our API endpoint. Open a new terminal then make a GET request to the server using the curl commands:

.. Now let’s test our API endpoint. Run the following curl command:

それから、API エンドポイントをテストしましょう。新しいターミナルを開き、 curl コマンドを使いサーバに対する GET リクエストを作成します。


.. code-block:: bash

   $ curl http://localhost:8000/initdb
   $ curl http://localhost:8000/widgets

.. You should receive the following response:

次のような反応を受け取るでしょう：

.. code-block:: json

   []


.. Next steps
.. _python-develop-next-steps:

次のステップ
====================

.. In this module, we took a look at creating a general development image that we can use pretty much like our normal command line. We also set up our Compose file to map our source code into the running container and exposed the debugging port.

この章では、通常のコマンドラインとほとんど同じように使える、一般的な開発用イメージ作成方法を説明しました。また、 Compose ファイルもセットアップし、ソースコードを実行中のコンテナにマップし、デバッグポイントを公開しました。

.. In the next module, we’ll take a look at how to set up a CI/CD pipeline using GitHub Actions. See:

次の章では、 GitHub Actions を使って CI/CD パイプラインをセットアップする方法を説明します。

.. Run your tests

:doc:`CI/CD の設定 <configure-ci-cd>`

.. Feedback
.. _python-develop-feedback:

フィードバック
====================

.. Help us improve this topic by providing your feedback. Let us know what you think by creating an issue in the Docker Docs GitHub repository. Alternatively, create a PR to suggest updates.

フィードバックを通し、このトピックの改善を支援ください。考えがあれば、 `Docker Docs <https://github.com/docker/docs/issues/new?title=[Python%20docs%20feedback]>`_ GitHub リポジトリに issue を作成して教えてください。あるいは、更新の提案のために `RP を作成 <https://github.com/docker/docs/pulls>`_ してください。

.. seealso::

   Use containers for development
      https://docs.docker.com/language/python/develop/


