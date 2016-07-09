.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/userguide/containers/dockerizing/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/userguide/containers/dockerizing.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/userguide/containers/dockerizing.md
.. check date: 2016/06/13
.. Commits on Mar 5, 2016 3b74be8ab7d93a70af3e0ac6418627c1de72228b
.. ----------------------------------------------------------------------------

.. _hello-world-in-a-container:

.. Hello world in a container

=======================================
コンテナで Hello world
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. So what's this docker thing all about?

*Docker とは一体何なのでしょうか？*

.. Docker allows you to run applications, worlds you create, inside containers. Running an application inside a container takes a single command: docker run.

Docker はコンテナ内に作成した世界で、アプリケーションを実行可能にします。コンテナ内でアプリケーションを実行するには、``docker run`` コマンドを実行するだけです。

.. Note: Depending on your Docker system configuration, you may be required to preface each docker command on this page with sudo. To avoid this behavior, your system administrator can create a Unix group called docker and add users to it.

.. note:: 

   Docker システムの設定によっては、ガイドにおける各ページの ``docker`` コマンドで ``sudo`` が必要になる場合があります。この挙動を回避するには、システム管理者に対して ``docker`` という名称の Unix グループを作成し、そこにユーザを追加するようご依頼ください。

.. Run a Hello world

.. _run-a-hello-world:

Hello world の実行
===================

.. Let's run a hello world container.

まず hello world コンテナを実行しましょう。

.. code-block:: bash

   $ docker run ubuntu:14.04 /bin/echo 'Hello world'
   Hello world

.. You just launched your first container!

初めてコンテナを実行しました！

.. In this example:

この例では以下の作業を行いました。

* ``docker run`` でコンテナを実行します（runは「実行」の意味）。

* ``ubuntu`` は実行するイメージです。この例では Ubuntu オペレーティング・システムのイメージです。イメージを指定したら、Docker はまずホスト上にイメージがあるかどうか確認します。イメージがローカルに存在していなければ、パブリック・イメージ・レジストリである `Docker Hub <https://hub.docker.com/>`_ からイメージを取得（pull）します。

* ``/bin/echo`` は新しいコンテナ内で実行するコマンドです。

.. The container launches. Docker creates a new Ubuntu environment and executes the /bin/echo command inside it and then prints out:

コンテナを起動するとは、Docker が新しい Ubuntu 環境を作成し、その中で ``/bin/echo`` コマンドを実行し、その結果を出力します。

.. code-block:: bash

   Hello world

.. So what happened to the container after that? Well, Docker containers only run as long as the command you specify is active. Therefore, in the above example, the container stops once the command is executed.

それでは、表示後のコンテナはどのような状況でしょうか。Docker コンテナが実行されていたのは、指定したコマンドを処理していた間のみです。この例では、コマンドを実行したのち、直ちにコンテナが停止しました。

.. Run an interactive container
.. _run-an-interactive-container:

インタラクティブなコンテナを実行
========================================

.. Let’s specify a new command to run in the container.

新しいコマンドを指定して、別のコンテナを起動しましょう。

.. code-block:: bash

   $ docker run -t -i ubuntu:14.04 /bin/bash
   root@af8bae53bdd3:/#

.. In this examples:

この例は、次の処理を行います。

.. docker run runs a container.
    ubuntu is the image you would like to run.
    -t flag assigns a pseudo-tty or terminal inside the new container.
    -i flag allows you to make an interactive connection by grabbing the standard in (STDIN) of the container.
    /bin/bash launches a Bash shell inside our container.

* ``docker run`` コマンドでコンテナを実行します。
* ``ubuntu`` イメージを使って起動します。
* ``-t`` フラグは新しいコンテナ内に疑似ターミナル (pseudo-tty) を割り当てます。
* ``-i`` フラグはコンテナの標準入力 (``STDIN``)を取得し、双方向に接続できるようにします（訳者注：正確には標準エラー STDOUT も含めた標準入出力を扱います）。
* ``/bin/bash`` はコンテナ内で Bash シェルを起動します。

.. The container launches. We can see there is a command prompt inside it:

コンテナを起動したら、次のようなコマンド・プロンプトが表示されます。

.. code-block:: bash

   root@af8bae53bdd3:/# pwd
   /
   root@af8bae53bdd3:/# ls
   bin boot dev etc home lib lib64 media mnt opt proc root run sbin srv sys tmp usr var

この例は：

* ``pwd`` を実行し、現在のディレクトリが表示されます。ここでは ``/`` ルート・ディレクトリにいることが分かります。
* ``ls`` はルートディレクトリ以下のディレクトリ一覧を表示します。典型的な Linux ファイル・システムのように見えます。

.. Now, you can play around inside this container. When completed, run the exit command or enter Ctrl-D to exit the interactive shell.

これで、コンテナ内で遊べます。終わったら ``exit`` コマンドまたは ``Ctrl-D`` を入力して終了できます。

.. code-block:: bash

   root@af8bae53bdd3:/# exit

.. Note: As with our previous container, once the Bash shell process has finished, the container is stopped.

.. note::

   先ほど作成したコンテナと同様に、Bash シェルのプロセスが終了すると、コンテナは停止します。

.. Start a daemonized Hello world

.. _start-a-daemonized-hello-world:

Docker 化した Hello world の起動
========================================

.. Let’s create a container that runs as a daemon.

デーモンとして実行するコンテナを作成しましょう。

.. code-block:: bash

   $ docker run -d ubuntu:14.04 /bin/sh -c "while true; do echo hello world; sleep 1; done"
   1e5535038e285177d5214659a068137486f96ee5c2e85a4ac52dc83f2ebe4147

.. In this example:

この例では：

..    docker run runs the container.
    -d flag runs the container in the background (to daemonize it).
    ubuntu is the image you would like to run.

* ``docker run`` はコンテナを実行します。
* ``-d`` フラグはバックグラウンドで（デーモン化して）コンテナを実行します。
* ``ubuntu`` は実行しようとしているイメージです。

.. Finally, we specified a command to run:

最後に、実行するコマンドを指定します：

.. code-block:: bash

   /bin/sh -c "while true; do echo hello world; sleep 1; done"

.. In the output, we do not see hello world but a long string:

出力は先ほどのように ``hello world`` を表示せず、文字列を表示します。

.. code-block:: bash

   1e5535038e285177d5214659a068137486f96ee5c2e85a4ac52dc83f2ebe4147

.. Note: The container ID is a bit long and unwieldy. Later, we will cover the short ID and ways to name our containers to make working with them easier.

.. note::

   コンテナ ID は長くて扱いにくいものです。あとで短い ID を扱います。こちらを使えば、コンテナをより簡単に操作できます。

.. We can use this container ID to see what’s happening with our hello world daemon.

このコンテナ ID を使い、``hello world`` デーモンで何が起こっているのかを調べます。

.. First, let’s make sure our container is running. Run the docker ps command. The docker ps command queries the Docker daemon for information about all the containers it knows about.

はじめに、コンテナが実行中であることを確認しましょう。 ``docker ps`` コマンドを実行します。``docker ps`` コマンドは、Docker デーモンに対し、デーモンが知っている全てのコンテナ情報を問い合わせます。

.. code-block:: bash

   $ docker ps
   CONTAINER ID  IMAGE         COMMAND               CREATED        STATUS       PORTS NAMES
   1e5535038e28  ubuntu:14.04  /bin/sh -c 'while tr  2 minutes ago  Up 1 minute        insane_babbage

.. In this example, we can see our daemonized container. The docker ps returns some useful information:

この例はデーモン化したコンテナを見ています。 ``docker ps`` は便利な情報を返します。

..    1e5535038e28 is the shorter variant of the container ID.
    ubuntu is the used image.
    the command, status, and assigned name insane_babbage.

* ``1e5535038e28`` はコンテナ ID の短いバージョンです。
* ``ubuntu`` は使用したイメージです。
* コマンド、状態、コンテナに自動で割り当てられた名前は ``insane_babbage`` です。

.. Note: Docker automatically generates names for any containers started. We’ll see how to specify your own names a bit later.

.. note::

   Docker はコンテナ開始する時、自動的に名前を作成します。自分自身で名前を指定する方法は、後ほど紹介します。

.. Now, we know the container is running. But is it doing what we asked it to do? To see this we’re going to look inside the container using the docker logs command.

これでコンテナが実行中だと分かりました。しかし、実行時に指定した処理が正しく行われているでしょうか。コンテナの中でどのような処理が行われているか確認するには、``docker logs`` を使います。

.. Let’s use the container name insane_babbage.

コンテナ名 ``insane_babbage`` を指定しましょう。

.. code-block:: bash

   $ docker logs insane_babbage
   hello world
   hello world
   hello world
   . . .

.. In this example:

この例では：

..    docker logs looks inside the container and returns hello world.

* ``docker logs`` でコンテナ内をのぞき込んだら、 ``hello world`` を返します。

.. Awesome! The daemon is working and you have just created your first Dockerized application!

すばらしいです！ デーモンとして動いています。初めて Docker 化（Dockerized）したアプリケーションを作成しました！

.. Next, run the docker stop command to stop our detached container.

次は ``docker stop`` コマンドでデタッチド・コンテナ（バックグラウンドで動作しているコンテナ）を停止します。

.. code-block:: bash

   $ docker stop insane_babbage
   insane_babbage

.. The docker stop command tells Docker to politely stop the running container and returns the name of the container it stopped.

``docker stop`` コマンドは、Docker に対して丁寧にコンテナを停止するよう命令します。処理が成功したら、停止したコンテナ名を表示します。

.. Let’s check it worked with the docker ps command.

``docker ps`` コマンドを実行して、動作確認しましょう。

.. code-block:: bash

   $ docker ps
   CONTAINER ID  IMAGE         COMMAND               CREATED        STATUS       PORTS NAMES

.. Excellent. Out container is stopped.

素晴らしいですね。コンテナが停止しました。


.. Next steps

次のステップ
===================

.. So far, you launched your first containers using the docker run command. You ran an interactive container that ran in the foreground. You also ran a detached container that ran in the background. In the process you learned about several Docker commands:

ここまでは ``docker run`` コマンドを使い、初めてのコンテナを起動しました。フォアグラウンドで動作する、双方向に操作可能なコンテナを実行しました。また、バックグラウンドで動作するデタッチド・コンテナも実行しました。この過程で、複数の Docker コマンドを学びました。

.. 
    docker ps - Lists containers.
    docker logs - Shows us the standard output of a container.
    docker stop - Stops running containers.

* ``docker ps`` - コンテナの一覧を表示。
* ``docker logs`` - コンテナの標準出力を表示。
* ``docker stop`` - 実行中のコンテナを停止。

.. Now, you have the basis learn more about Docker and how to do some more advanced tasks. Go to “Run a simple application“ to actually build a web application with the Docker client.

以上で、Docker の基本と高度な処理を学びました。次は :doc:`シンプルなアプリケーションの実行 </engine/userguide/containers/usingdocker>` に移動し、Docker クライアントを使って実際のウェブアプリケーションを構築しましょう。

.. seealso:: 

   Hello world in a container
      https://docs.docker.com/engine/userguide/containers/dockerizing/

