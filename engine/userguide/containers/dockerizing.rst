.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/userguide/containers/dockerizing/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/userguide/containers/dockerizing.md
   doc version: 1.10
      https://github.com/docker/docker/commits/master/docs/userguide/containers/dockerizing.md
   doc version: 1.9
      https://github.com/docker/docker/commits/release/v1.9/docs/userguide/dockerizing.md
.. check date: 2016/02/10
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

Docker はアプリケーションをコンテナ内に作成した世界で実行可能にします。コンテナ内でアプリケーションを実行するには、``docker run`` コマンドを実行するだけです。

.. Note: Depending on your Docker system configuration, you may be required to preface each docker command on this page with sudo. To avoid this behavior, your system administrator can create a Unix group called docker and add users to it.

.. note:: 

   Docker システムの設定によっては、ガイドにおける各ページの ``docker`` コマンドで ``sudo`` が必要になる場合があります。この挙動を回避するには、システム管理者に対して ``docker`` という名称の Unix グループを作成し、そこにユーザを追加するようご依頼ください。

.. Run a Hello world

.. _run-a-hello-world:

Hello world の実行
===================

.. Let's try it now.

まずは、試してみましょう。

.. code-block:: bash

   $ docker run ubuntu:14.04 /bin/echo 'Hello world'
   Hello world

.. And you just launched your first container!

これが初めて起動したコンテナです！

.. So what just happened? Let’s step through what the docker run command did.

一体何が起こったのでしょうか？ ``docker run`` コマンドが処理した内容を見ていきましょう。

.. First we specified the docker binary and the command we wanted to execute, run. The docker run combination runs containers.

まず ``docker`` バイナリに対して、処理したいコマンド ``run`` （「実行」の意味）を指定します。コマンド ``docker run`` の組み合わせは、コンテナを実行 （run）するという意味です。

.. Next we specified an image: ubuntu. This is the source of the container we ran. Docker calls this an image. In this case we used the Ubuntu operating system image.

次に続くのはイメージ ``ubuntu`` の指定です。これは、私達が実行したコンテナの元になるモノです。これを Docker ではイメージと呼びます。この例では、Ubuntu オペレーティング・システムのイメージを使いました。

.. When you specify an image, Docker looks first for the image on your Docker host. If it can’t find it then it downloads the image from the public image registry: Docker Hub.

イメージを指定すると、Docker はまず 自身の Docker ホスト上でイメージを探します。もしイメージが見つからなければ、パブリック・イメージ・レジストリの `Docker Hub <https://hub.docker.com/>`_ からイメージをダウンロードします。

.. Next we told Docker what command to run inside our new container:

次に、新しいコンテナ内で何のコマンドを実行するか Docker に対して命令します。

.. code-block:: bash

   /bin/echo 'Hello world'

.. When our container was launched Docker created a new Ubuntu environment and then executed the /bin/echo command inside it. We saw the result on the command line:

コンテナが起動すると、Docker は新しい Ubuntu 環境を作り、その中で ``/bin/echo`` コマンドを実行します。コマンドライン上では、次の結果が表示されます：

.. code-block:: bash

   Hello world


.. So what happened to our container after that? Well Docker containers only run as long as the command you specify is active. Here, as soon as Hello world was echoed, the container stopped.

それでは、表示した後のコンテナはどのような状況でしょうか。Docker コンテナが実行されていたのは、指定したコマンドを処理していた間のみです。この例では、``Hello world`` を画面に表示した後、直ちにコンテナが停止しました。

.. An interactive container
.. _an-interactive-container:


インタラクティブなコンテナ
==============================

.. Let’s try the docker run command again, this time specifying a new command to run in our container.

もう一度 ``docker run`` コマンドを実行しましょう。今度はコンテナ内で新しいコマンドを指定します。

.. code-block:: bash

   $ docker run -t -i ubuntu:14.04 /bin/bash
   root@af8bae53bdd3:/#

.. Here we’ve again specified the docker run command and launched an ubuntu image. But we’ve also passed in two flags: -t and -i. The -t flag assigns a pseudo-tty or terminal inside our new container and the -i flag allows us to make an interactive connection by grabbing the standard in (STDIN) of the container.

ここでは再び ``docker run`` コマンドを実行し、``ubuntu`` イメージを起動しました。しかし、今回は ``-t`` と ``-i`` の２つのフラグも付けています。``-t`` フラグは新しいコンテナの中に疑似ターミナル (pseudo-tty) を割り当てます。``-i`` フラグはコンテナの標準入力 (``STDIN``)を取得し、双方向に接続できるようにします。

.. We’ve also specified a new command for our container to run: /bin/bash. This will launch a Bash shell inside our container.

また、コンテナ実行時に ``/bin/bash`` という新しいコマンドも指定しました。これは、コンテナの中で Bash シェルを起動しようとします。

.. So now when our container is launched we can see that we’ve got a command prompt inside it:

そして、コンテナが起動したら、次のようなコマンド・プロンプトが表示されるでしょう。

.. code-block:: bash

   root@af8bae53bdd3:/#

.. Let’s try running some commands inside our container:

コンテナ内でいくつかのコマンドを実行しましょう：

.. code-block:: bash

   root@af8bae53bdd3:/# pwd
   /
   root@af8bae53bdd3:/# ls
   bin boot dev etc home lib lib64 media mnt opt proc root run sbin srv sys tmp usr var

.. You can see we’ve run the pwd to show our current directory and can see we’re in the / root directory. We’ve also done a directory listing of the root directory which shows us what looks like a typical Linux file system.

``pwd`` を実行すると、現在のディレクトリが表示されます。ここでは ``/`` ルートディレクトリにいることがわかります。また、ルートディレクトリ以下でディレクトリ一覧を表示すると、典型的な Linux ファイル・システムのように見えます。

.. You can play around inside this container and when you’re done you can use the exit command or enter Ctrl-D to finish.

これで、コンテナ内で遊ぶことができます。終わった後は ``exit`` コマンドか ``Ctrl-D`` を入力して終了できます。

.. code-block:: bash

   root@af8bae53bdd3:/# exit

.. As with our previous container, once the Bash shell process has finished, the container is stopped.

先ほど作成したコンテナと同様に、Bash シェルのプロセスが終了すると、コンテナは停止します。

.. A daemonized Hello world

.. _a-daemonized-hello-world:

Hello world のデーモン化
==============================

.. Now a container that runs a command and then exits has some uses but it’s not overly helpful. Let’s create a container that runs as a daemon, like most of the applications we’re probably going to run with Docker.

先ほどのように、コマンドを実行して終了するコンテナにも使い道はありますが、あまり有用ではありません。今度は、通常実行するであろう多くのアプリケーションと同様に、デーモンとして実行するコンテナを Docker で作りましょう。

.. Again we can do this with the docker run command:

次のように、再度 ``docker run`` コマンドを実行します：

.. code-block:: bash

   $ docker run -d ubuntu:14.04 /bin/sh -c "while true; do echo hello world; sleep 1; done"
   1e5535038e285177d5214659a068137486f96ee5c2e85a4ac52dc83f2ebe4147

.. Wait, what? Where’s our “hello world” output? Let’s look at what we’ve run here. It should look pretty familiar. We ran docker run but this time we specified a flag: -d. The -d flag tells Docker to run the container and put it in the background, to daemonize it.

あれ？ ちょっと待ってください。 「hello world」の出力はどこに行ったのでしょうか。まずは、今ここで何を処理したのか確認しましょう。大部分が先ほどと同じコマンドに見えます。しかし ``docker run`` を実行するとき、今回は ``-d`` フラグを指定しました。``-d`` フラグとは、コンテナ実行時にデーモン化し、バックグラウンドで動作するように Docker に対して指示します。

.. We also specified the same image: ubuntu.

また、同じイメージ ``ubuntu`` を指定しました。

.. Finally, we specified a command to run:

最後に、実行するコマンドを指定します：

.. code-block:: bash

   /bin/sh -c "while true; do echo hello world; sleep 1; done"

.. This is the (hello) world’s silliest daemon: a shell script that echoes hello world forever.

これは世界で最も単純な (hello world) デーモンです。永遠に  ``hello world`` を表示し続けるシェルスクリプトです。

.. So why aren’t we seeing any hello world’s? Instead Docker has returned a really long string:

それなのに ``hello world`` が表示されないのは何故でしょうか。そのかわり、Docker は長い文字列を返しました。

.. code-block:: bash

   1e5535038e285177d5214659a068137486f96ee5c2e85a4ac52dc83f2ebe4147

.. This really long string is called a container ID. It uniquely identifies a container so we can work with it.

この長い文字列を *コンテナ ID (container ID)* と呼びます。個々のコンテナを識別して操作するのに使います。

.. Note: The container ID is a bit long and unwieldy. A bit later, we’ll see a shorter ID and ways to name our containers to make working with them easier.

.. note::

   コンテナ ID は長くて扱いにくいものです。もう少し後で、より短い ID をお見せします。こちらを使えば、コンテナをより簡単に操作できます。

.. We can use this container ID to see what’s happening with our hello world daemon.

このコンテナ ID を使い、``hello world`` デーモンで何が起こっているのかを調べます。

.. Firstly let’s make sure our container is running. We can do that with the docker ps command. The docker ps command queries the Docker daemon for information about all the containers it knows about.

はじめに、コンテナが実行中であることを確認しましょう。確認には ``docker ps`` コマンドを実行します。``docker ps`` コマンドは、Docker デーモンに対し、デーモンが知っている全てのコンテナ情報を問い合わせます。

.. code-block:: bash

   $ docker ps
   CONTAINER ID  IMAGE         COMMAND               CREATED        STATUS       PORTS NAMES
   1e5535038e28  ubuntu:14.04  /bin/sh -c 'while tr  2 minutes ago  Up 1 minute        insane_babbage

.. Here we can see our daemonized container. The docker ps has returned some useful information about it, starting with a shorter variant of its container ID: 1e5535038e28.

ここではデーモン化されたコンテナが見えています。``docker ps`` は、コンテナ ID: ``1e5535038e28`` で始まる短いバージョンのコンテナ ID のほかにも、コンテナに関する便利な情報を返します。

.. We can also see the image we used to build it, ubuntu, the command it is running, its status and an automatically assigned name, insane_babbage.

また、構築時に用いたイメージは ``ubuntu`` であり、実行中のコマンドと、その状態、さらに自動的に割り当てられた名前が ``insane_babbage`` だと分かります。

.. Note: Docker automatically generates names for any containers started. We’ll see how to specify your own names a bit later.

.. note::

   Docker はコンテナ開始する時、自動的に名前を作成します。自分自身で名前を指定する方法は、後ほど紹介します。

.. Okay, so we now know it’s running. But is it doing what we asked it to do? To see this we’re going to look inside the container using the docker logs command. Let’s use the container name Docker assigned.

大丈夫ですね。コンテナは実行中だと分かりました。しかし、実行時に指定した処理が正しく行われているでしょうか。コンテナの中でどのような処理が行われているか確認するには、``docker logs`` を使います。Docker が割り当てたコンテナ名を使いましょう。

.. code-block:: bash

   $ docker logs insane_babbage
   hello world
   hello world
   hello world
   . . .

.. The docker logs command looks inside the container and returns its standard output: in this case the output of our command hello world.

``docker logs`` コマンドは、コンテナの中をみて、その標準出力を返します。この例ではコマンド ``hello world`` の出力にあたります。

.. Awesome! Our daemon is working and we’ve just created our first Dockerized application!

できましたね！ デーモンは動作中です。始めて Docker 化したアプリケーションを作りました！

.. Now we’ve established we can create our own containers let’s tidy up after ourselves and stop our detached container. To do this we use the docker stop command.

このように自分自身でコンテナを作れることを確認できました。あとは自分で後片付けのため、実行中のコンテナを停止します。停止するには ``docker stop`` コマンドを使います。

.. code-block:: bash

   $ docker stop insane_babbage
   insane_babbage

.. The docker stop command tells Docker to politely stop the running container. If it succeeds it will return the name of the container it has just stopped.

``docker stop`` コマンドは、Docker に対して丁寧にコンテナを停止するよう命令します。処理が成功すると、停止したコンテナ名を表示します。

.. Let’s check it worked with the docker ps command.

``docker ps`` コマンドを実行して、動作確認しましょう。

.. code-block:: bash

   $ docker ps
   CONTAINER ID  IMAGE         COMMAND               CREATED        STATUS       PORTS NAMES

.. Excellent. Out container has been stopped.

素晴らしいです。コンテナが停止しました。


.. Next steps

次のステップ
===================

.. So far, you launched your first containers using the docker run command. You ran an interactive container that ran in the foreground. You also ran a detached container that ran in the background. In the process you learned about several Docker commands:

ここまでは ``docker run`` コマンドを使い、初めてのコンテナを起動しました。フォアグラウンドで動作する双方向に操作可能なコンテナを実行しました。また、バックグラウンドで動作するデタッチド・コンテナも実行しました。この過程で、複数の Docker コマンドを学びました。

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

