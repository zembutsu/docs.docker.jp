.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/swarm/swarm_at_scale/04-deploy-app/
.. SOURCE: https://github.com/docker/swarm/blob/master/docs/swarm_at_scale/04-deploy-app.md
   doc version: 1.10
      https://github.com/docker/swarm/commits/master/docs/swarm_at_scale/04-deploy-app.md
.. check date: 2016/03/09
.. Commits on Feb 28, 2016 ec8ceae209c54091065c8f9e50439bd76255b022
.. -------------------------------------------------------------------

.. Deploy the application

.. _deploy-the-application:

==============================
アプリケーションのデプロイ
==============================

.. You’ve built a Swarm cluster so now you are ready to build and deploy the voting application itself.

:doc:`Swarm クラスタを構築 <03-create-cluster>` しましたので、投票アプリケーションを構築・デプロイする準備が整いました。

.. Step 1: Learn about the images

ステップ１：イメージについて学ぶ
========================================

.. Some of the application’s containers are launched form existing images pulled directly from Docker Hub. Other containers are launched from custom images you must build. The list below shows which containers use custom images and which do not:

起動するアプリケーション用コンテナのいくつかは、 Docker Hub から既存のイメージを直接取得します。カスタム・イメージを必要とする他のコンテナは、自分で構築する必要があります。どのコンテナがカスタム・イメージを使えるどうか、あるいは構築する必要があるか確認します。

..    Load balancer container: stock image (ehazlett/interlock)
    Redis containers: stock image (official redis image)
    Postgres (PostgreSQL) containers: stock image (official postgres image)
    Web containers: custom built image
    Worker containers: custom built image
    Results containers: custom built image

* ロードバランサ・コンテナ：作成済みイメージ（ ``ehazlett/interlock`` ）
* Redis コンテナ：作成済みイメージ（公式 ``redis`` イメージ）
* Postgres ( PostgreSQL ) コンテナ：作成済みイメージ（公式 ``postgres`` イメージ）
* Web コンテナ：カスタム・イメージを構築
* Worker コンテナ：カスタム・イメージを構築
* Results コンテナ：カスタム・イメージを構築

.. All custom built images are built using Dockerfile’s pulled from the example application’s public GitHub repository.

カスタム・イメージの構築に必要な Dockerfile は、 `アプリケーションの GitHub 公開リポジトリ <https://github.com/docker/swarm-microservice-demo-v1>`_ から取得できます。

..    If you haven’t already, ssh into the Swarm manager node.

1. Swarm``manager`` ノードに ``ssh`` で接続していなければ、接続します。

..    Clone the application’s GitHub repo

2. `アプリケーションの GitHub リポジトリ <https://github.com/docker/swarm-microservice-demo-v1>`_ をクローンします。

.. code-block:: bash

   $ git clone https://github.com/docker/swarm-microservice-demo-v1
   sudo: unable to resolve host master
   Cloning into 'swarm-microservice-demo-v1'...
   remote: Counting objects: 304, done.
   remote: Compressing objects: 100% (17/17), done.
   remote: Total 304 (delta 5), reused 0 (delta 0), pack-reused 287
   Receiving objects: 100% (304/304), 2.24 MiB | 2.88 MiB/s, done.
   Resolving deltas: 100% (132/132), done.
   Checking connectivity... done.

..    This command creates a new directory structure inside of your working directory. The new directory contains all of the files and folders required to build the voting application images.

このコマンドは、現在のディレクトリ直下に新しいディレクトリ階層を作成します。新しいディレクトリには投票アプリケーション・イメージの構築に必要な全てのファイルとフォルダがあります。

..    The AWS directory contains the cloudformation.json file used to deploy the EC2 instances. The Vagrant directory contains files and instructions required to deploy the application using Vagrant. The results-app, vote-worker, and web-vote-app directories contain the Dockerfiles and other files required to build the custom images for those particular components of the application.

``AWS`` ディレクトリにある ``cloudformation.json`` ファイルは EC2 インスタンスのデプロイに使いました。 ``Vagrant`` ディレクトリにあるファイルや命令は Vagrant を使ってアプリケーションをデプロイする時に必要となります。 ``results-app`` 、 ``vote-worker`` 、 ``web-vote-app`` ディレクトリには Dockerfile が入っています。これは、 アプリケーションの各コンポーネントとして必要になるカスタム・イメージを構築するために必要なファイルです。

..    Change directory into the swarm-microservice-demo-v1/web-vote-app directory.

3. ``swarm-microservice-demo-v1/web-vote-app`` ディレクトリに移動します。

.. code-block:: bash

   $ cd swarm-microservice-demo-v1/web-vote-app/

..     View the Dockerfile contents.

4. Dockerfile の内容を確認します。

.. code-block:: bash

   $ cat Dockerfile
   # Using official python runtime base image
   FROM python:2.7
   # Set the application directory
   WORKDIR /app
   # Install our requirements.txt
   ADD requirements.txt /app/requirements.txt
   RUN pip install -r requirements.txt
   # Copy our code from the current folder to /app inside the container
   ADD . /app
   # Make port 80 available for links and/or publish
   EXPOSE 80
   # Define our command to be run when launching the container
   CMD ["python", "app.py"]

..    As you can see, the image is based on the official Python:2.7 tagged image, adds a requirements file into the /app directory, installs requirements, copies files from the build context into the container, exposes port 80 and tells the container which command to run.

ご覧の通り、このイメージは公式の ``Python:1.7`` とタグ付けされたイメージをベースにします。 ``/app`` ディレクトリに必要なファイルを追加し、依存関係のあるものをインストールし、構築コンテクストに含めるファイルをコンテナ内にコピーし、コンテナのコマンド実行時にポート ``80`` を公開するよう命令しています。

..    Spend time investigating the other parts of the application by viewing the results-app/Dockerfile and the vote-worker/Dockerfile in the application.

5. 投票アプリケーションの他のパーツも、 ``results-app/Dockerfile`` と ``vote-worker/Dockerfile`` を時間をかけて確認します。

.. Step 2. Build custom images

.. _step-2-build-custom-images:

ステップ２：カスタム・イメージの構築
========================================

..    If you haven’t already, ssh into the Swarm manager node.

1. Swarm ``manager`` ノードに ``ssh`` で入っていなければ、入ります。

..    Make sure you have DOCKER_HOST set

2. ``DOCKER_HOST`` が設定されているのを確認します。

.. code-block:: bash

   $ export DOCKER_HOST="tcp://192.168.33.11:3375"

..    Change to the root of your swarm-microservice-demo-v1 clone.

3. ``swarm-microservice-demo-v1`` をクローンしたディレクトリに移動します。

..    Build the web-votes-app image both the front end nodes.

4. 各フロントエンドのノード上で ``web-votes-app`` イメージを構築します。

**frontend01:**

.. code-block:: bash

   $ docker -H tcp://192.168.33.20:2375 build -t web-vote-app ./web-vote-app

**frontend02:**

.. code-block:: bash

   $ docker -H tcp://192.168.33.21:2375 build -t web-vote-app ./web-vote-app

..    These commands build the web-vote-app image on the frontend01 and frontend02 nodes. To accomplish the operation, each command copies the contents of the swarm-microservice-demo-v1/web-vote-app sub-directory from the manager node to each frontend node. The command then instructs the Docker daemon on each frontend node to build the image and store it locally.

これらのコマンドは ``frontend01`` と ``frontend02`` ノード上に ``web-vote-app`` イメージを構築します。これらのコマンドを実行すると、 ``manager`` ノード上の ``swarm-microservice-demo-v1/web-vote-app`` サブディレクトリの内容が、各フロントエンドのノードにコピーされます。そして、このコマンドは各フロントエンド・ノード内でローカルにイメージを構築・保管します。

..    You’ll notice this example uses a -H flag to pull an image to specific host. This is to help you conceptualize the architecture for this sample. In a production deployment, you’d omit this option and rely on the Swarm manager to distribute the image. The manager would pull the image to every node; so that any node can step in to run the image as needed.

このサンプルでは ``-H`` フラグを使いイメージを取得するホストを指定します。これがこのサンプルのアーキテクチャの概念を理解する手助けになるでしょう。プロダクション環境のデプロイでは、この作業を省略し、Swarm マネージャでイメージを配布させることも可能です。マネージャはイメージを必要とする各ノード上で、個々にイメージを取得（pull）することができます。

..    It may take a minute or so for each image to build. Wait for the builds to finish.

イメージ構築には数分ほど時間がかかるかもしれません。構築完了までお待ち下さい。

..    Build vote-worker image on the worker01 node

5. ``worker01`` ノード上で ``vote-worker`` イメージを構築します。

.. code-block:: bash

   $ docker -H tcp://192.168.33.200:2375 build -t vote-worker ./vote-worker

..    It may take a minute or so for the image to build. Wait for the build to finish.

イメージ構築には数分ほど時間がかかるかもしれません。構築完了までお待ち下さい。

..    Build the results-app on the store node

6. ``store`` ノード上で ``results-app`` を構築します。

.. code-block:: bash

   $ docker -H tcp://192.168.33.250:2375 build -t results-app ./results-app

.. Each of the custom images required by the application is now built and stored locally on the nodes that will use them.

アプリケーションが必要とする各カスタム・イメージを構築し、実行する各ノードのローカルに保管しました。

.. Step 3. Pull images from Docker Hub

ステップ３：Docker Hub からイメージを取得
==================================================

.. For performance reasons, it is always better to pull any required Docker Hub images locally on each instance that needs them. This ensures that containers based on those images can start quickly.

パフォーマンス上の理由により、それぞれのインスタンスの必要性に応じて、Docker Hub からイメージをダウンロードするのは良い方法です。そうすることで、必要とするコンテナを迅速に実行できます。

..    Log into the Swarm manager node.

1. Swarm ``manager`` ノードにログインします。

..    Pull the redis image to your frontend nodes.

2. フロントエンド・ノード で ``redis`` イメージを取得します。

**frontend01:**

.. code-block:: bash

   $ docker -H tcp://192.168.33.20:2375 pull redis

**frontend02:**

.. code-block:: bash

   $ docker -H tcp://192.168.33.21:2375 pull redis

..    Pull the postgres image to the store node

3. ``store`` ノードに ``postgres`` イメージを取得します。

.. code-block:: bash

   $ docker -H tcp://192.168.33.250:2375 pull postgres

..    Pull the ehazlett/interlock image to the interlock node

4. ``interlock`` ノードに ``ehazlett/interlock`` イメージを取得します。

.. code-block:: bash

   $ docker -H tcp://192.168.33.12:2375 pull ehazlett/interlock

.. Each node in the cluster, as well as the interlock node, now has the required images stored locally as shown below.

クラスタ上のノードだけでなく、 ``interlock`` ノードの準備も整いました。これで次のように各ノードで必要なイメージがローカルに保管されている状態です。

.. image:: ../images/interlock.png
   :scale: 60%

.. Now that all images are built, pulled, and stored locally, the next step is to start the application.

これで全てのイメージを構築・取得し、ローカルに保存しました。次のステップはアプリケーションの起動です。

.. Step 4. Start the voting application

.. _step-4-start-the-voting-application:

ステップ４：投票用アプリケーションを起動
========================================

.. In the following steps, your launch several containers to the voting application.

以下の手順は、投票用アプリケーションのコンテナを起動します。

..    If you haven’t already, ssh into the Swarm manager node.

1. Swarm ``manager`` ノードに ``ssh`` 接続していなければ、接続します。

..    Start the interlock container on the interlock node

2. ``interlock`` ノードで ``interlock`` コンテナを起動します。

.. code-block:: bash

   $ docker -H tcp://192.168.33.12:2375 run --restart=unless-stopped -p 80:80 --name interlock -d ehazlett/interlock --swarm-url tcp://192.168.33.11:3375 --plugin haproxy start

..    This command is issued against the interlock instance and maps port 80 on the instance to port 80 inside the container. This allows the container to load balance connections coming in over port 80 (HTTP). The command also applies the --restart=unless-stopped policy to the container, telling Docker to restart the container if it exits unexpectedly.

このコマンドは ``interlock`` インスタンスのポート 80 をコンテナ内のポート 80 に割り当てます。これにより、コンテナがポート 80 （HTTP）に来たトラフィックを負荷分散できます。また、このコマンドはコンテナに対して ``--restart=unless-stopped`` ポリシーを設定しています。これはコンテナが不意に停止することがあれば、コンテナを（自動的に）再起動します。

..     Verify the container is running.

3. コンテナが起動していることを確認します。

.. code-block:: bash

   $ docker -H tcp://192.168.33.12:2375 ps

..    Start a redis container on your front end nodes.

4. フロントエンド・ノード上で ``redis`` コンテナを起動します。

**frontend01:**

.. code-block:: bash

   $ docker run --restart=unless-stopped --env="constraint:node==frontend01" -p 6379:6379 --name redis01 --net mynet -d redis
   $ docker -H tcp://192.168.33.20:2375 ps

**frontend02:**

.. code-block:: bash

   $ docker run --restart=unless-stopped --env="constraint:node==frontend02" -p 6379:6379 --name redis02 --net mynet -d redis
   $ docker -H tcp://192.168.33.21:2375 ps

..    These two commands are issued against the Swarm cluster. The commands specify node constraints, forcing Swarm to start the containers on frontend01 and frontend02. Port 6379 on each instance is mapped to port 6379 inside of each container for debugging purposes. The command also applies the --restart=unless-stopped policy to the containers and attaches them to the mynet overlay network.

Swarm クラスタに対して２つのコマンドを実行します。このコマンドはノード制約（code constrains）を指定し、Swarm に ``frontend01`` と ``frontend02`` でコンテナを起動するよう指定しています。また、デバッグ目的のために各コンテナのポート 6379 を各インスタンスのポート 6379 に割り当てます。さらにコンテナに対する ``--restart=unless-stopped `` ポリシーと、コンテナを ``mynet`` オーバレイ・ネットワークに接続する設定を行っています。

..    Start a web-vote-app container the frontend nodes.

5. フロントエンド・ノード上で ``web-vote-app`` コンテナを起動します。

**frontend01:**

.. code-block:: bash

   $ docker run --restart=unless-stopped --env="constraint:node==frontend01" -d -p 5000:80 -e WEB_VOTE_NUMBER='01' --name frontend01 --net mynet --hostname votingapp.local web-vote-app

**frontend02:**

.. code-block:: bash

   $ docker run --restart=unless-stopped --env="constraint:node==frontend02" -d -p 5000:80 -e WEB_VOTE_NUMBER='02' --name frontend02 --net mynet --hostname votingapp.local web-vote-app

..    These two commands are issued against the Swarm cluster. The commands specify node constraints, forcing Swarm to start the containers on frontend01 and frontend02. Port 5000 on each node is mapped to port 80 inside of each container. This allows connections to come in to each node on port 5000 and be forwarded to port 80 inside of each container.

Swarm クラスタに対して２つのコマンドを実行します。このコマンドはノード制約（code constrains）を指定し、Swarm に ``frontend01`` と ``frontend02`` でコンテナを起動するよう指定しています。また、各コンテナのポート ``80`` を各インスタンスのポート ``5000`` に割り当てます。これは各ノード上のポート ``5000`` に接続すると、各コンテナのポート ``80`` に転送されます。

..    Both containers are attached to the mynet overlay network and both containers are given the votingapp-local hostname. The --restart=unless-stopped policy is also applied to these containers.

どちらのコンテナも ``mynet`` オーバレイ・ネットワークに接続し、どちらも ``votingapp-local`` ホスト名を持ちます。コンテナに対して ``--restart=unless-stopped`` ポリシーも指定しています。

..    Start the postgres container on the store node

6. ``store`` ノード上で ``postgres``  コンテナを起動します。

.. code-block:: bash

   $ docker run --restart=unless-stopped --env="constraint:node==store" --name pg -e POSTGRES_PASSWORD=pg8675309 --net mynet -p 5432:5432 -d postgres

..    This command is issued against the Swarm cluster and starts the container on store. It maps port 5432 on the store node to port 5432 inside the container and attaches the container to the mynet overlay network. The command also inserts the database password into the container via the POSTGRES_PASSWORD environment variable and applies the --restart=unless-stopped policy to the container.

このコマンドは Swarm クラスタに対して ``store`` 上でコンテナを起動します。 ``store`` ノード上のポート 5432 をコンテナ内の 5432 に割り当てて、コンテナを ``mynet`` オーバレイ・ネットワークに接続します。

..    Sharing passwords like this is not recommended for production use cases.

プロダクションでの利用ではパスワード共有は推奨されません。

..    Start the worker01 container on the worker01 node

7. ``worker01`` ノード上で ``worker01`` コンテナを起動します。

.. code-block:: bash

   $ docker run --restart=unless-stopped --env="constraint:node==worker01" -d -e WORKER_NUMBER='01' -e FROM_REDIS_HOST=1 -e TO_REDIS_HOST=2 --name worker01 --net mynet vote-worker

..    This command is issued against the Swarm manager and uses a constraint to start the container on the worker01 node. It passes configuration data into the container via environment variables, telling the worker container to clear the queues on frontend01 and frontend02. It adds the container to the mynet overlay network and applies the --restart=unless-stopped policy to the container.

このコマンドは Swarm マネージャに対して ``worker01`` ノード上でコンテナを起動するよう制約（constraint）を使っています。これは環境変数を通して設定用のデータを渡しています。これは worker コンテナに対して、 ``frontend01`` と ``frontend02`` にあるキューをクリアにするよう命令しています。また、コンテナを ``mynet`` オーバレイ・ネットワークに追加し、コンテナに ``--restart=unless-stopped`` ポリシーを適用しています。

..    Start the results-app container on the store node

8. ``store`` ノード上で ``results-app``  コンテナを起動します。

.. code-block:: bash

   $ docker run --restart=unless-stopped --env="constraint:node==store" -p 80:80 -d --name results-app --net mynet results-app

..    This command starts the results-app container on the store node by means of a node constraint. It maps port 80 on the store node to port 80 inside the container. It adds the container to the mynet overlay network and applies the --restart=unless-stopped policy to the container.

このコマンドはノード制約（node constraint）によって ``store`` ノード上に results-app コンテナを起動します。 ``store`` ノードのポート 80 をコンテナ内のポート 80 に割り当てます。コンテナを ``mynet`` オーバレイ・ネットワークに接続し、 ``--restart=unless-stopped`` ポリシーをコンテナに適用します。

.. The application is now fully deployed as shown in the diagram below.

下図の状態となれば、これでアプリケーションのデプロイは完了です。

.. image:: ../images/fully-deployed.png
   :scale: 60%

.. Step 5. Test the application

.. _step-5-test-the-application:

ステップ５：アプリケーションのテスト
========================================

.. Now that the application is deployed and running, it’s time to test it. To do this, you configure a DNS mapping on the machine where you are running your web browser. This maps the “votingapp.local” DNS name to the public IP address of the interlock node.

これでアプリケーションはデプロイが終わり、実行中になりました。さぁ、テストの時間です。そのためにはウェブ・ブラウザが実行中のマシンから参照できるよう、DNS 設定を調整する必要があります。そのために「votingapp.local」DNS名を ``interlock`` ノードのパブリック IP アドレスに割り当てます。

..    Configure the DNS name resolution on your local machine for browsing.

1. ブラウザで参照できるようにするため、ローカルのマシン上の DNS 名前解決の設定を変更します。

..        On Windows machines this is done by adding votingapp.local <interlock-public-ip> to the C:\Windows\System32\Drivers\etc\hosts file. Modifying this file requires administrator privileges. To open the file with administrator privileges, right-click C:\Windows\System32\notepad.exe and select Run as administrator. Once Notepad is open, click file > open and open the file and make the edit.
        On OSX machines this is done by adding votingapp.local <interlock-public-ip> to /private/etc/hosts.
        On most Linux machines this is done by adding votingapp.local <interlock-public-ip> to /etc/hosts.


* Windows マシンの場合は ``C:\Windows\System32\Drivers\etc\hosts file`` ファイルに ``votingapp.local <interlock-パブリックIP>`` の行を追加します。管理者権限でファイルを開くために ``C:\Windows\System32\notepad.exe`` を右クリックし、 ``管理者として実行`` を選びます。メモ帳が開いたら、 ``ファイル`` → ``開く`` でファイルを開き、編集します。

* OSX マシンの場合は ``votingapp.local <interlock-パブリックIP>`` を ``/private/etc/hosts`` に追加します。

* 殆どの Linux マシン上では  ``votingapp.local <interlock-パブリックIP>`` を ``/etc/hosts`` に追加します。

..    Be sure to replace <interlock-public-ip> with the public IP address of your interlock node. You can find the interlock node’s Public IP by selecting your interlock EC2 Instance from within the AWS EC2 console.

``<interlock-パブリックIP>`` の部分は、各自の ``interlock`` ノードの IP アドレスに置き換えてください。 AWS EC2 コンソール内の ``interlock`` EC2 インスタンスの場所からノードのパブリック IP アドレスを確認できます。

..    Verify the mapping worked with a ping command from your local machine.

2. 正常に名前解決できるか確認するために、自分のマシン上で ``ping`` コマンドを実行します。

.. code-block:: bash

   ping votingapp.local
   Pinging votingapp.local [54.183.164.230] with 32 bytes of data:
   Reply from 54.183.164.230: bytes=32 time=164ms TTL=42
   Reply from 54.183.164.230: bytes=32 time=163ms TTL=42
   Reply from 54.183.164.230: bytes=32 time=169ms TTL=42

..    Point your web browser to http://votingapp.local

3. ブラウザで http://votingapp.local を開きます。

..    Notice the text at the bottom of the web page. This shows which web container serviced the request. In the diagram above, this is frontend02. If you refresh your web browser you should see this change as the Interlock load balancer shares incoming requests across both web containers.

ウェブページ上の文字列にご注意ください。ここに表示されているのは、どのウェブ・コンテナ・サービスに対してリクエストしているかです。これが ``frontend02`` であれば、ウェブ・ブラウザを再読込すると、 interlock ロード・バランサは入ってきたリクエストを両方のコンテナに振り分けるのが分かります。

..  To see more detailed load balancer data from the Interlock service, point your web browser to http://stats:interlock@votingapp.local/haproxy?stats

Interlock サービスの負荷分散に関する詳細なデータは、ブラウザで http://stats:interlock@votingapp.local/haproxy?stats を開きます。

..    Cast your vote. It is recommended to choose “Dogs” ;-)

4. 投票します。「Dogs」を選ぶことを推奨します ;-)

..    To see the results of the poll, you can point your web browser at the public IP of the store node

5. 投票結果を見るには、 ``store`` ノードのパブリック IP アドレスをブラウザで開きます。

.. Next steps

次のステップ
====================

.. Congratulations. You have successfully walked through manually deploying a microservice-based application to a Swarm cluster. Of course, not every deployment goes smoothly. Now that you’ve learned how to successfully deploy an application at scale, you should learn what to consider when troubleshooting large applications running on a Swarm cluster.

おめでとうございます。マイクロサービスをベースとしたアプリケーションを Swarm クラスタ上に手動でデプロイできました。もちろん、すべてが上手くいくとは限りません。どのようにスケールするアプリケーションをデプロイするかを学びましたので、次は :doc:`Swarm クラスタ上で大規模アプリケーション実行時のトラブルシューティング <05-troubleshoot>` を学ぶべきでしょう。

.. seealso::

   Deploy the application
      https://docs.docker.com/swarm/swarm_at_scale/04-deploy-app/
