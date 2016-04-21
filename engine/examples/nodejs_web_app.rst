.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/extend/examples/nodejs_web_app/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/examples/nodejs_web_app.md
   doc version: 1.11
      https://github.com/docker/docker/commits/master/docs/examples/nodejs_web_app.md
.. check date: 2016/04/21
.. Commits on Mar 4, 2016 69004ff67eed6525d56a92fdc69466c41606151a
.. ---------------------------------------------------------------

.. Dockerizing a Node.js web app

.. _dockerizing-a-nodejs-web-app:

========================================
Node.js ウェブ・アプリの Docker 化
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

..    Note: - If you don’t like sudo then see Giving non-root access

   ``sudo`` が好きでなければ、 :ref:`giving-non-root-access` をご覧ください。

.. The goal of this example is to show you how you can build your own Docker images from a parent image using a Dockerfile . We will do that by making a simple Node.js hello world web application running on CentOS. You can get the full source code athttps://github.com/enokd/docker-node-hello/.

この例のゴールは、 ``Dockerfile`` を使い、親イメージから自分の Docker イメージを構築できるようにする方法を理解します。ここでは CentOS 上で簡単な Node.js の hello world ウェブ・アプリケーションを実行します。ソースコード全体は https://github.com/enokd/docker-node-hello/ から入手できます。

.. Create Node.js app

.. _create-nodejs-app:

Node.js アプリの作成
====================

.. First, create a directory src where all the files would live. Then create a package.json file that describes your app and its dependencies:

まず、すべてのファイルを置く ``src`` ディレクトリを作成します。それから ``package.json``  ファイルを作成し、アプリケーションと依存関係について記述します。

.. code-block:: json

   {
     "name": "docker-centos-hello",
     "private": true,
     "version": "0.0.1",
     "description": "Node.js Hello world app on CentOS using docker",
     "author": "Daniel Gasienica <daniel@gasienica.ch>",
     "dependencies": {
       "express": "3.2.4"
     }
   }

.. Then, create an index.js file that defines a web app using the Express.js framework:

次に ``index.js`` ファイルを作成し、ウェブアプリが `Express.js <http://expressjs.com/>`_ フレームワークを使うように定義します。

.. code-block:: bash

   var express = require('express');
   
   // Constants
   var PORT = 8080;
   
   // App
   var app = express();
   app.get('/', function (req, res) {
     res.send('Hello world\n');
   });
   
   app.listen(PORT);
   console.log('Running on http://localhost:' + PORT);

In the next steps, we’ll look at how you can run this app inside a CentOS container using Docker. First, you’ll need to build a Docker image of your app.

次のステップでは、Docker が CentOS コンテナの中で、どのようにこのアプリを実行するかを理解していきます。まず、自分のアプリを動かす Docker イメージを作成します。

.. Creating a Dockerfile

.. _nodejs-creating-a-dockerfile:

Dockerfile の作成
====================

.. Create an empty file called Dockerfile:

``Dockerfile`` という名称の空ファイルを作成します。

.. code-block:: bash

   touch Dockerfile

.. Open the Dockerfile in your favorite text editor

好みのエディタで ``Dockerfile`` を開きます。

.. Define the parent image you want to use to build your own image on top of. Here, we’ll use CentOS (tag: centos6) available on the Docker Hub:

自分のイメージの構築に使いたい親イメージを定義します。ここでは `Docker Hub <https://hub.docker.com/>`_ 上で利用可能な `CentOS <https://registry.hub.docker.com/_/centos/>`_ （タグ： ``centos6`` ）を使います。

.. code-block:: bash

   FROM    centos:centos6

.. Since we’re building a Node.js app, you’ll have to install Node.js as well as npm on your CentOS image. Node.js is required to run your app and npm is required to install your app’s dependencies defined in package.json. To install the right package for CentOS, we’ll use the instructions from the Node.js wiki:

Node.js アプリを作りたいため、CentOS イメージ上に Node.js と npm のインストールをします。アプリケーションの実行に Node.js が必要です。また、 ``package.json`` で定義したアプリケーションをインストールするために npm も必要です。CentOS 用の適切なパッケージをインストールするため、 `Node.js wiki <https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager#rhelcentosscientific-linux-6>`_ の指示に従って作業します。

.. code-block:: bash

   # Enable Extra Packages for Enterprise Linux (EPEL) for CentOS
   RUN     yum install -y epel-release
   # Install Node.js and npm
   RUN     yum install -y nodejs npm

.. Install your app dependencies using the npm binary:

``npm`` バイナリでアプリケーションの依存関係をインストールします。

.. code-block:: bash

   # Install app dependencies
   COPY package.json /src/package.json
   RUN cd /src; npm install --production

.. To bundle your app’s source code inside the Docker image, use the COPY instruction:

アプリケーションのソースコードを Docker イメージに取り込むため、 ``COPY`` 命令を使います。

.. code-block:: bash

   # Bundle app source
   COPY . /src

.. Your app binds to port 8080 so you’ll use the EXPOSE instruction to have it mapped by the docker daemon:

アプリケーションはポート ``8080`` を利用するため、 ``EXPOSE`` 命令を使い ``docker`` デーモンがポートを割り当てるようにします。

.. code-block:: bash

   EXPOSE  8080

.. Last but not least, define the command to run your app using CMD which defines your runtime, i.e. node, and the path to our app, i.e. src/index.js (see the step where we added the source to the container):

最後にあと少し、実行時にアプリケーションが実行できるよう ``CMD`` 命令でコマンドを定義します。例えば ``node`` と、アプリケーション、例えば ``src/index.js`` を指定します（ソースファイルは前の手順でコンテナに加えていました）。

.. code-block:: bash

   CMD ["node", "/src/index.js"]

.. Your Dockerfile should now look like this:

これで ``Dockerfile`` は次のようになります。

.. code-block:: bash

   FROM    centos:centos6
   
   # Enable Extra Packages for Enterprise Linux (EPEL) for CentOS
   RUN     yum install -y epel-release
   # Install Node.js and npm
   RUN     yum install -y nodejs npm
   
   # Install app dependencies
   COPY package.json /src/package.json
   RUN cd /src; npm install --production
   
   # Bundle app source
   COPY . /src
   
   EXPOSE  8080
   CMD ["node", "/src/index.js"]

.. Building your image

イメージを構築
====================

.. Go to the directory that has your Dockerfile and run the following command to build a Docker image. The -t flag lets you tag your image so it’s easier to find later using the docker images command:

``Dockerfile`` のあるディレクトリに移動し、Docker イメージを構築するため次のコマンドを実行します。 ``-t`` フラグを使いイメージにタグを付けておくと、あとから ``docker images`` コマンドで簡単に探せます。

.. code-block:: bash

   $ docker build -t <your username>/centos-node-hello .

.. Your image will now be listed by Docker:

作成したイメージは、Docker のイメージ一覧に表示されます。

.. code-block:: bash

   $ docker images
   
   # Example
   REPOSITORY                          TAG        ID              CREATED
   centos                              centos6    539c0211cd76    8 weeks ago
   <your username>/centos-node-hello   latest     d64d3505b0d2    2 hours ago

.. Run the image

.. _nodejs-run-the-image:

イメージの実行
====================

.. Running your image with -d runs the container in detached mode, leaving the container running in the background. The -p flag redirects a public port to a private port in the container. Run the image you previously built:

イメージに ``-d``  を付けて実行すると、コンテナはデタッチド・モードで動作します。これは、コンテナをバックグラウンドで動作するものです。 ``-p`` フラグで、コンテナ内のプライベートなポートを公開ポートに渡します。

.. code-block:: bash

   $ docker run -p 49160:8080 -d <your username>/centos-node-hello

.. Print the output of your app:

アプリケーションの出力を表示します。

.. code-block:: bash

   # Get container ID
   $ docker ps
   
   # Print app output
   $ docker logs <container id>
   
   # Example
   Running on http://localhost:8080

.. Test

.. _nodejs-test:

テスト
==========

To test your app, get the port of your app that Docker mapped:

アプリケーションをテストするには、Docker でアプリケーションにポートを割り当てます。

.. code-block:: bash

   $ docker ps
   
   # Example
   ID            IMAGE                                     COMMAND              ...   PORTS
   ecce33b30ebf  <your username>/centos-node-hello:latest  node /src/index.js         49160->8080

.. In the example above, Docker mapped the 8080 port of the container to 49160.

上記の例では、Docker はコンテナのポート ``8080`` をポート ``49160`` に割り当てています。

.. Now you can call your app using curl (install if needed via: sudo apt-get install curl):

これで ``curl`` を使ってアプリケーションを呼び出せます（必要があれば ``sudo apt-get install curl`` でインストールします。 ）。

.. code-block:: bash

   $ curl -i localhost:49160
   
   HTTP/1.1 200 OK
   X-Powered-By: Express
   Content-Type: text/html; charset=utf-8
   Content-Length: 12
   Date: Sun, 02 Jun 2013 03:53:22 GMT
   Connection: keep-alive
   
   Hello world

.. If you use Docker Machine on OS X, the port is actually mapped to the Docker host VM, and you should use the following command:

OS X 上で Docker Machine を使っているのであれば、ポートが実際に割り当てられているのは Docker ホストの VM 側であり、次のコマンドを使う必要があります。

.. code-block:: bash

   $ curl $(docker-machine ip VM_NAME):49160

.. We hope this tutorial helped you get up and running with Node.js and CentOS on Docker. You can get the full source code at https://github.com/enokd/docker-node-hello/.

私たちはこのチュートリアルが Docker 上で Node.js と CentOS を動かすための手助けになればと望んでいます。全てのソースコードは https://github.com/enokd/docker-node-hello/ にあります。

.. seealso:: 

   Dockerizing a Node.js web app
      https://docs.docker.com/engine/examples/nodejs_web_app/
