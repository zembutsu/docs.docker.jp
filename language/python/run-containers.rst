.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/language/python/run-containers/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/language/python/run-containers.md
.. check date: 2022/09/30
.. Commits on Sep 29, 2022 561118ec5b1f1497efad536545c0b39aa8026575
.. -----------------------------------------------------------------------------

.. Run your image as a container
.. _python-run-your-image-as-a-container:

========================================
コンテナとしてイメージを実行
========================================

.. Prerequisites
.. _python-run-prerequisites:

事前準備
==========

.. Work through the steps to build a Python image in Build your Python image.

:doc:`build-images` で、 Python イメージ構築手順を実行します。

.. Overview
.. _python-run-overview:

概要
==========

.. In the previous module, we created our sample application and then we created a Dockerfile that we used to produce an image. We created our image using the docker command docker build. Now that we have an image, we can run that image and see if our application is running correctly.

前章ではサンプルアプリケーションを作成し、イメージ作成に使うための Dockerfile を作成しました。そして ``docker build`` コマンドを使い、イメージを作成しました。次は、イメージを準備できましたので、アプリケーションを正しく実行できるかどうか確認するため、このイメージを実行します。

.. A container is a normal operating system process except that this process is isolated in that it has its own file system, its own networking, and its own isolated process tree separate from the host.

コンテナでは、通常のオペレーティングシステムの手順を除外しています。このコンテナのプロセスは隔離されており、独自のファイルシステムを持ち、独自のネットワーク機能を持ち、ホストから分離されている独自のプロセスツリーも持ちます。

.. To run an image inside of a container, we use the docker run command. The docker run command requires one parameter which is the name of the image. Let’s start our image and make sure it is running correctly. Run the following command in your terminal.

コンテナ内でイメージを実行するには、 ``docker run`` コマンドを使います。 ``docker run`` コマンドには1つのパラメータが必要であり、それはイメージ名です。これまで作成したイメージ使い、正しく起動できるかどうかを確認しましょう。ターミナル内で以下のコマンドを実行します。

.. code-block:: bash

   $ docker run python-docker

.. After running this command, you’ll notice that you were not returned to the command prompt. This is because our application is a REST server and runs in a loop waiting for incoming requests without returning control back to the OS until we stop the container.

このコマンドを実行後、コマンドプロンプトには何も応答がないのが分かるでしょう。これは、アプリケーションが REST サーバであり、リクエスト要求を受け付けるためのループを実行中のため、 OS がコンテナを停止するまで制御は戻りません。

.. Let’s open a new terminal then make a GET request to the server using the curl command.

新しいターミナルを開き、 ``curl`` コマンドを使って ``GET`` リクエストを作成しましょう。

.. code-block:: bash

   $ curl localhost:5000
   curl: (7) Failed to connect to localhost port 5000: Connection refused

.. As you can see, our curl command failed because the connection to our server was refused. This means, we were not able to connect to the localhost on port 5000. This is expected because our container is running in isolation which includes networking. Let’s stop the container and restart with port 5000 published on our local network.

見ての通り curl コマンドが失敗したのは、サーバへの接続が拒否されたからです。つまり、ローカルホストのポート 5000 へ接続できません。これは、ネットワークも隔離した状態でコンテナを実行しているからです。コンテナを停止し、ローカルネットワーク上でポート 5000 を公開して再起動しましょう。

.. To stop the container, press ctrl-c. This will return you to the terminal prompt.

コンテナを停止するには、 ctrl-c を押します。これでターミナルにプロンプトが戻ります。

.. To publish a port for our container, we’ll use the --publish flag (-p for short) on the docker run command. The format of the --publish command is [host port]:[container port]. So, if we wanted to expose port 5000 inside the container to port 3000 outside the container, we would pass 3000:5000 to the --publish flag.

コンテナのポートを公開するには、docker run コマンドで ``--publish`` フラグ（短縮形は ``-p`` ） を使います。 ``--publish`` 命令は ``[host port]:[container port]`` 形式です。そのため、コンテナ外のポート 3000 に コンテナ内のポート 5000 を公開するには、 ``--publish`` フラグに ``3000:5000`` を渡します。

.. We did not specify a port when running the flask application in the container and the default is 5000. If we want our previous request going to port 5000 to work we can map the host’s port 8000 to the container’s port 5000:

コンテナ内で flask アプリケーションの実行にあたり、ポートを指定しませんでしたので、デフォルトの 5000 になります。ポート 5000 に対して先ほどのリクエストを行うには、ホスト側のポート 8000 をコンテナ側のポート 5000 にマップして行えるようになります。

.. code-block:: bash

   $ docker run --publish 8000:5000 python-docker

.. Now let’s rerun the curl command from above. Remember to open a new terminal.

これで先ほどの curl コマンドは応答を返すでしょう。新しく開いたターミナルに戻ります。

.. code-block:: bash

   $ curl localhost:8000
   Hello, Docker!

.. Success! We were able to connect to the application running inside of our container on port 8000. Switch back to the terminal where your container is running and you should see the POST request logged to the console.

成功です！ コンテナ内で実行しているアプリケーションにポート 8000 で接続できました。コンテナを実行しているターミナルに切り替えると、コンソールに GET リクエストのログが表示されるでしょう。

.. code-block:: bash

   [31/Jan/2021 23:39:31] "GET / HTTP/1.1" 200 -

.. Press ctrl-c to stop the container.

ctrl-c を押してコンテナを停止します。

.. Run in detached mode
.. _python-run-in-detached-mode:

デタッチドモードで実行
==============================

.. This is great so far, but our sample application is a web server and we don’t have to be connected to the container. Docker can run your container in detached mode or in the background. To do this, we can use the --detach or -d for short. Docker starts your container the same as before but this time will “detach” from the container and return you to the terminal prompt.

サンプルアプリケーションは今のところ順調ですが、これはウェブサーバであり、ターミナルをコンテナに接続しておく必要はありません。Docker はアプリケーションを :ruby:`デタッチド モード <detouched mode>` やバックグラウンドとして実行できます。そのためには、 ``--detach`` か短縮形の ``-d`` を使います。 Docker はこれまでと同じように実行しますが、今回はコンテナから「 :ruby:`離れ <detachb>`」、ターミナルに戻るようにします。

.. code-block:: bash

   $ docker run -d -p 8000:5000 python-docker
   ce02b3179f0f10085db9edfccd731101868f58631bdf918ca490ff6fd223a93b

.. Docker started our container in the background and printed the Container ID on the terminal.

Docker はバックグラウンドでコンテナを起動し、ターミナル上にはコンテナ ID を表示します。

.. Again, let’s make sure that our container is running properly. Run the same curl command from above.

再び、コンテナが正しく動作するか確認しましょう。先ほどと同じ curl コマンドを実行します。

.. code-block:: bash

   $ curl localhost:8000
   Hello, Docker!


.. List containers
.. _python-run-list-containers:

コンテナ一覧
====================

.. Since we ran our container in the background, how do we know if our container is running or what other containers are running on our machine? Well, we can run the docker ps command. Just like on Linux, to see a list of processes on your machine we would run the ps command. In the same spirit, we can run the docker ps command which will show us a list of containers running on our machine.

コンテナはバックグラウンドで実行していますので、コンテナが実行中かどうかを知るには、あるいは、マシン上で何のコンテナが実行中かを知るにはどうしたらよいでしょうか。そうですね、 ``docker ps`` コマンドを実行できます。Linux でマシン上のプロセス一覧を表示するには、 ps コマンドを実行します。同様に、マシン上で実行しているコンテナを一覧表示するには ``docker ps`` コマンドを実行できます。

.. code-block:: bash

   $ docker ps
   CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                    NAMES
   ce02b3179f0f        python-docker         "python3 -m flask ru…"   6 minutes ago       Up 6 minutes        0.0.0.0:8000->5000/tcp   wonderful_kalam

.. The ps command tells a bunch of stuff about our running containers. We can see the Container ID, the image running inside the container, the command that was used to start the container, when it was created, the status, ports that exposed and the name of the container.

``ps`` コマンドは実行中コンテナの一群を表示します。コンテナ ID 、コンテナ内で実行しているイメージ、コンテナ起動時に使うコマンド、作成時、状態、ポートと公開ポート、コンテナ名の表示が見えます。

.. You are probably wondering where the name of our container is coming from. Since we didn’t provide a name for the container when we started it, Docker generated a random name. We’ll fix this in a minute but first we need to stop the container. To stop the container, run the docker stop command which does just that, stops the container. You will need to pass the name of the container or you can use the container id.

おそらく、コンテナに割り当てられている名前を不思議に思うでしょう。コンテナ起動時に名前を指定しませんでしたが、Docker がランダムな名前を生成しました。この名前は変更できますが、まずはコンテナの停止が必要です。コンテナを停止するには、 ``docker stop`` コマンドを実行してコンテナを停止します。コマンドにはコンテナ名かコンテナ ID を渡す必要があります。

.. code-block:: bash

   $ docker stop wonderful_kalam
   wonderful_kalam

.. Now rerun the docker ps command to see a list of running containers.

実行中のコンテナ一覧を表示するため、 ``docker ps`` コマンドに戻ります。

.. code-block:: bash

   $ docker ps
   CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES

.. Stop, start, and name containers
.. _python-stop-start-and-name-containers:

コンテナの停止、起動、名前
==============================

.. Docker containers can be started, stopped and restarted. When we stop a container, it is not removed but the status is changed to stopped and the process inside of the container is stopped. When we ran the docker ps command, the default output is to only show running containers. If we pass the --all or -a for short, we will see all containers on our system whether they are stopped or started.

Docker コンテナは起動、停止、再起動できます。コンテナを停止しても削除はされず、状態は停止済み（stopped）となり、コンテナ内のプロセスは停止します。 ``docker ps`` コマンドを実行すると、デフォルトの出力は実行中のコンテナのみです。 ``--all`` か短縮形の ``-a`` を渡すと、システム上で停止中か起動しているかにかかわらず、全てのコンテナを表示します。

.. code-block:: bash

   $ docker ps -a
   CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                      PORTS               NAMES
   ce02b3179f0f        python-docker         "python3 -m flask ru…"   16 minutes ago      Exited (0) 5 minutes ago                        wonderful_kalam
   ec45285c456d        python-docker         "python3 -m flask ru…"   28 minutes ago      Exited (0) 20 minutes ago                       agitated_moser
   fb7a41809e5d        python-docker         "python3 -m flask ru…"   37 minutes ago      Exited (0) 36 minutes ago                       goofy_khayyam

.. If you’ve been following along, you should see several containers listed. These are containers that we started and stopped but have not been removed.

先ほどとは違い、複数のコンテナが表示されました。これらのコンテナは起動中か、停止中ですが削除はされていなかったものです。

.. Let’s restart the container that we just stopped. Locate the name of the container we just stopped and replace the name of the container below in the restart command.

停止しているコンテナを再起動しましょう。先ほど停止したコンテナの名前を探し、次の再起動コマンドのコンテナ名の部分を置き換えてください。

.. code-block:: bash

   $ docker restart wonderful_kalam

.. Now, list all the containers again using the ps command.

それから、再び ps コマンドを使ってコンテナを一覧表示します。

.. code-block:: bash

   $ docker ps --all
   CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                      PORTS                    NAMES
   ce02b3179f0f        python-docker         "python3 -m flask ru…"   19 minutes ago      Up 8 seconds                0.0.0.0:8000->5000/tcp   wonderful_kalam
   ec45285c456d        python-docker         "python3 -m flask ru…"   31 minutes ago      Exited (0) 23 minutes ago                            agitated_moser
   fb7a41809e5d        python-docker         "python3 -m flask ru…"   40 minutes ago      Exited (0) 39 minutes ago                            goofy_khayyam

.. Notice that the container we just restarted has been started in detached mode and has port 8000 exposed. Also, observe the status of the container is “Up X seconds”. When you restart a container, it will be started with the same flags or commands that it was originally started with.

再起動したコンテナの状態はデタッチドモードで起動済みとなり、ポート 8000 を公開しています。また、コンテナの状態を見てみると「Up X seconds」（起動 X 秒）となっています。コンテナを再起動する場合、元元のコンテナを起動したときと同じフラグやコマンドで起動します。

.. Now, let’s stop and remove all of our containers and take a look at fixing the random naming issue. 

次に、コンテナをすべて停止して削除するには、ランダムな名前を調べる必要があります。

.. Stop the container we just started. Find the name of your running container and replace the name in the command below with the name of the container on your system.

起動したコンテナを停止します。実行中のコンテナ名を調べ、以下のコマンドにあるコンテナ名を、自分のシステム上にあるコンテナの名前に置き換えます。

.. code-block:: bash

   $ docker stop wonderful_kalam
   wonderful_kalam

.. Now that all of our containers are stopped, let’s remove them. When a container is removed, it is no longer running nor is it in the stopped status. However, the process inside the container has been stopped and the metadata for the container has been removed.

これで全てのコンテナが停止しましたので、これらを削除しましょう。コンテナを削除すると、二度と起動できないだけでなく、停止中の状態としても表示されません。コンテナ内のプロセスが停止されているだけなく、コンテナのメタデータも削除されています。

.. code-block:: bash

   $ docker ps --all
   CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                      PORTS                    NAMES
   ce02b3179f0f        python-docker         "python3 -m flask ru…"   19 minutes ago      Up 8 seconds                0.0.0.0:8000->5000/tcp   wonderful_kalam
   ec45285c456d        python-docker         "python3 -m flask ru…"   31 minutes ago      Exited (0) 23 minutes ago                            agitated_moser
   fb7a41809e5d        python-docker         "python3 -m flask ru…"   40 minutes ago      Exited (0) 39 minutes ago                            goofy_khayyam

.. To remove a container, simply run the docker rm command passing the container name. You can pass multiple container names to the command in one command.

コンテナを削除するには、シンプルに ``docker rm`` コマンドへコンテナ名を渡すだけです。1つのコマンド内で、複数のコンテナ名を渡せます。

.. Again, make sure you replace the containers names in the below command with the container names from your system.

もう一度、以下のコマンドにあるコンテナ名を自分のシステム上のものへと置き換えて、コマンドを実行します。

.. code-block:: bash

   $ docker rm wonderful_kalam agitated_moser goofy_khayyam
   wonderful_kalam
   agitated_moser
   goofy_khayyam

.. Run the docker ps --all command again to see that all containers are gone.

``docker ps --all`` コマンドを実行し、全てのコンテナが消えたのを確認します。

.. Now let’s address the pesky random name issue. Standard practice is to name your containers for the simple reason that it is easier to identify what is running in the container and what application or service it is associated with. Just like good naming conventions for variables in your code make it simpler to read, so does naming your containers.

次は厄介なランダムな名前の問題を解決しましょう。標準的な解決策としては、シンプルな理由からコンテナに対して名前を付けます。そうすると、どのようなコンテナを実行しているかや、何のアプリケーションやサービスが関連付けられているかが分かりやすくなるためです。コード内の変数に分かりやすい名前を付けるのと同じように、コンテナに名前を付けて分かりやすくします。

.. To name a container, we just need to pass the --name flag to the run command.

コンテナに名前を付けるには、 run コマンドに ``--name`` フラグを付けます。

.. code-block:: bash

   $ docker run -d -p 8000:5000 --name rest-server python-docker
   1aa5d46418a68705c81782a58456a4ccdb56a309cb5e6bd399478d01eaa5cdda
   $ docker ps
   CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                    NAMES
   1aa5d46418a6        python-docker         "python3 -m flask ru…"   3 seconds ago       Up 3 seconds        0.0.0.0:8000->5000/tcp   rest-server

.. That’s better! We can now easily identify our container based on the name.

良いですね！ これで名前に基づいてコンテナを簡単に区別できます。

.. Next steps
.. _python-run-next-steps:

次のステップ
====================

.. In this module, we took a look at running containers, publishing ports, and running containers in detached mode. We also took a look at managing containers by starting, stopping, and restarting them. We also looked at naming our containers so they are more easily identifiable. In the next module, we’ll learn how to run a database in a container and connect it to our application. See:

この章では、コンテナの実行、ポートの公開、デタッチドモードでのコンテナ実行について説明しました。また、コンテナを管理するために起動、停止、再起動の方法を設営しました。ほかにも、コンテナを簡単に識別できるよう、コンテナに対して名前を付ける方法を説明しました。次の章では、コンテナ内でデータベースを実行する方法と、アプリケーションに接続する方法を説明します。

.. How to develop your application

* :doc:`アプリケーション開発の仕方 <develop>`

.. Feedback
.. _python-run-feedback:

フィードバック
====================

.. Help us improve this topic by providing your feedback. Let us know what you think by creating an issue in the Docker Docs GitHub repository. Alternatively, create a PR to suggest updates.

フィードバックを通し、このトピックの改善を支援ください。考えがあれば、 `Docker Docs <https://github.com/docker/docs/issues/new?title=[Python%20docs%20feedback]>`_ GitHub リポジトリに issue を作成して教えてください。あるいは、更新の提案のために `RP を作成 <https://github.com/docker/docs/pulls>`_ してください。


.. seealso::

   Run your image as a container
      https://docs.docker.com/language/python/run-containers/


