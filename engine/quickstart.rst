.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/quickstart/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/quickstart.md
.. doc version: 1.10
      https://github.com/docker/docker/commits/master/docs/quickstart.md
.. check date: 2016/03/12
.. Commits on Mar 1, 2016 0b882cc0140bc03dfe79462c5cdf77b972c94067
.. -----------------------------------------------------------------------------

.. Docker Engine Quickstart

.. _docker-engine-quickstart:

=============================
Docker Engine クイックスタート
=============================

.. This quickstart assumes you have a working installation of Docker Engine. To verify Engine is installed and configured, use the following command:

このクイックスタートを始めるにあたり、Docker Engine はインストールを終えているのを前提にしています。Docker Engine がインストール済み・設定済みかを確認するには、次のコマンドを実行します。

..    # Check that you have a working install

.. code-block:: bash

   # インストールしたものが正常に動作するか確認
   $ docker info

.. If you have a successful install, the system information appears. If you get docker: command not found or something like /var/lib/docker/repositories: permission denied you may have an incomplete Docker installation or insufficient privileges to access Engine on your machine. With the default installation of Engine docker commands need to be run by a user that is in the docker group or by the root user.

インストールに成功しているのであれば、システム情報が表示されます。もしも ``docker: command not found`` （訳：docker コマンドが見つかりません）や ``/var/lib/docker/repositories: permission denied`` （訳：権限がありませんｎ）のような表示が出る場合は、Docker のインストールが不完全か、コマンドでマシン上の Docker Engine にアクセスする権限がありません。Docker Engine の標準インストールでは、``docker`` コマンドを実行するには ``docker`` グループに所属するユーザ、もしくは ``root`` の必要があります。

.. Depending on your Engine system configuration, you may be required to preface each docker command with sudo. One way to avoid having to use sudo with the docker commands is to create a Unix group called docker and add users that will be entering docker commands to the ‘docker’ group.

Docker Engine のシステム設定によっては、各 ``docker`` コマンドの前に ``sudo`` が必要になる場合があります。``docker`` コマンドで ``sudo`` を使わないようにする方法の１つに、``docker`` という Unix グループを作成し、ユーザを `docker` グループに追加して ``docker`` コマンドを使えるようにできます。

.. For more information about installing Docker Engine or sudo configuration, refer to the installation instructions for your operating system.

Docker Engine のインストールや ``sudo`` 設定に関しては、 :doc:`インストール <engine/installation>` を参照ください。


.. Download a pre-built image

構築済みイメージのダウンロード
==============================

.. To pull an `ubuntu` image, run:

``ubuntu`` イメージをダウンロード（pull）するには、次のように実行します。

.. # Download an ubuntu image

.. code-block:: bash

   # ubuntu イメージのダウンロード（pull）
   $ docker pull ubuntu

.. This downloads the ubuntu image by name from Docker Hub to a local image cache. To search for an image, run docker search. For more information, go to: Searching images

このコマンドは `Docker Hub <https://hub.docker.com/>`_ 上の ``ubuntu`` イメージをローカルのイメージ・キャッシュにダウンロードします。  イメージを検索するには ``docker search`` コマンドを実行します。詳しい情報は :ref:`searching-for-images` をご覧ください。

.. Note: When the image is successfully downloaded, you see a 12 character hash 539c0211cd76: Download complete which is the short form of the Image ID. These short Image IDs are the first 12 characters of the full image ID. To view this information, run docker inspect or docker images --no-trunc=true.

.. note::

   イメージのダウンロードに成功すると、12文字のハッシュ ``539c0211cd76: Download complete`` が表示されます。これはイメージ ID を短くしたものです。この短いイメージ ID（short image ID）は、完全イメージ ID （full iamge ID）の始めから12文字です。完全イメージ ID を確認するには ``docker inspect`` や ``docker images --no-trunc=true`` を実行します。

.. To display a list of downloaded images, run docker images.

ダウンロードしたイメージの一覧を表示するには ``docker images`` を実行します。

.. Running an interactive shell

対話型シェルの実行
=============================

.. To run an interactive shell in the Ubuntu image:

Ubuntu イメージの対話型シェルを使うには、次のように実行します：

.. code-block:: bash

   $ docker run -i -t ubuntu /bin/bash 

.. The -i flag starts an interactive container. The -t flag creates a pseudo-TTY that attaches stdin and stdout. The image is ubuntu. The command /bin/bash starts a shell you can log in.

``-i`` フラグは対話型 (interactive；インタラクティブ) のコンテナを起動します。``-t`` フラグは疑似ターミナル (pseudo-TTY) を起動し、``stdin`` と ``stdout`` （標準入出力）をアタッチ（接続）します。イメージ名は ``ubuntu`` です。コマンド ``/bin/bash`` を使ってログインできます。

.. To detach the tty without exiting the shell, use the escape sequence Ctrl-p + Ctrl-q. The container will continue to exist in a stopped state once exited. To list all containers, stopped and running, use the docker ps -a command.

シェルを終了せずに ``tty`` をデタッチ（取り外し）するには、エスケープ・シーケンス ``Ctrl-p`` + ``Ctrp-q`` を使います。コンテナから出たあとも、停止するまでコンテナは存在し続けます。

.. Bind Docker to another host/port or a Unix socket

Docker を他のホスト・ポートや Unix ソケットに接続
==================================================

.. Warning: Changing the default docker daemon binding to a TCP port or Unix docker user group will increase your security risks by allowing non-root users to gain root access on the host. Make sure you control access to docker. If you are binding to a TCP port, anyone with access to that port has full Docker access; so it is not advisable on an open network.

.. warning:: 

   ``docker`` デーモンが標準で利用する TCP ポートと Unix *docker* ユーザ・グループの変更は、ホスト上の非 root ユーザが *root* アクセスを得られるという、セキュリティ・リスクを増やします。``docker`` に対する管理を確実に行ってください。TCP ポートの利用時、ポートにアクセスできる誰もが Docker に対する完全なアクセスを可能です。そのため、オープンなネットワーク上での利用は望ましくありません。

.. With -H it is possible to make the Docker daemon to listen on a specific IP and port. By default, it will listen on unix:///var/run/docker.sock to allow only local connections by the root user. You could set it to 0.0.0.0:2375 or a specific host IP to give access to everybody, but that is not recommended because then it is trivial for someone to gain root access to the host where the daemon is running.

Docker デーモンで ``-H`` オプション使用すると、指定した IP アドレスとポートをリッスンします（ポートを開きます）。標準では、``unis:///var/run/docker.sock`` をリッスンし、ローカルの *root* ユーザのみ接続できます。これを ``0.0.0.0:2375`` や特定のホスト IP を指定することで、誰でもアクセス可能にできましたが、**推奨されていません**。理由は、デーモンが稼働しているホスト上の root アクセスを誰もが簡単に得られるためです。

.. Similarly, the Docker client can use -H to connect to a custom port. The Docker client will default to connecting to unix:///var/run/docker.sock on Linux, and tcp://127.0.0.1:2376 on Windows.

同様に、Docker クライアントは ``-H`` を使い、任意のポートに接続可能です。Docker クライアントは、Linux 版では ``unix:///var/run/docker.sock`` に接続し、Windows 版では ``tcp://127.0.0.1:2376`` に接続します。

.. -H accepts host and port assignment in the following format:

``-H`` は次の書式でホストとポートを割り当てます：

:: 

   tcp://[host]:[port][path] or unix://path

.. For example:

例：

.. 
    tcp:// -> TCP connection to 127.0.0.1 on either port 2376 when TLS encryption is on, or port 2375 when communication is in plain text.
    tcp://host:2375 -> TCP connection on host:2375
    tcp://host:2375/path -> TCP connection on host:2375 and prepend path to all requests
    unix://path/to/socket -> Unix socket located at path/to/socket

* ``tcp://`` → ``127.0.0.1`` に TCP 接続時、TLS 暗号化が有効であればポート ``2376`` を、通信がプレーンテキストの場合（暗号化していない）はポート ``2375`` を使います。
* ``tcp://host:2375`` → 対象ホスト:2375 に TCP 接続します。
* ``tcp://host:2375/path`` → 対象ホスト:2375 に TCP 接続し、あらかじめリクエストのパスを追加します。
* ``unix://path/to/socket`` → ``path/to/socket`` にある Unix ソケットに接続します。

.. -H, when empty, will default to the same value as when no -H was passed in.

``-H`` の後に何も指定しないと、標準では ``-H`` を指定していないのと同じ挙動になります。

.. -H also accepts short form for TCP bindings:

また、``-H`` は TCP の指定を省略できます：

.. `host:` or `host:port` or `:port`

::

   `host:` または `host:port` または `:port`


.. Run Docker in daemon mode:

Docker をデーモン・モードで起動する：

.. code-block:: bash

   $ sudo <path to>/docker daemon -H 0.0.0.0:5555 &


.. Download an ubuntu image:

``ubuntu`` イメージをダウンロードする：

.. code-block:: bash

   $ docker -H :5555 pull ubuntu

.. You can use multiple -H, for example, if you want to listen on both TCP and a Unix socket

複数の ``-H`` を使えます。例えば TCP と Unix ソケットの両方をリッスンしたい場合です。

.. # Run docker in daemon mode
   $ sudo <path to>/docker daemon -H tcp://127.0.0.1:2375 -H unix:///var/run/docker.sock &
   # Download an ubuntu image, use default Unix socket
   $ docker pull ubuntu
   # OR use the TCP port
   $ docker -H tcp://127.0.0.1:2375 pull ubuntu


.. code-block:: bash

   # docker をデーモン・モードで実行
   $ sudo <path to>/docker daemon -H tcp://127.0.0.1:2375 -H unix:///var/run/docker.sock &
   # 標準の Unix ソケットを使い、Ubuntu イメージをダウンロード
   $ docker pull ubuntu
   # あるいは、TCP ポートを使用
   $ docker -H tcp://127.0.0.1:2375 pull ubuntu


.. Starting a long-running worker process

長時間動作するワーカー・プロセスの開始
======================================

.. # Start a very useful long-running process
   $ JOB=$(docker run -d ubuntu /bin/sh -c "while true; do echo Hello world; sleep 1; done")
   
   # Collect the output of the job so far
   $ docker logs $JOB
   
   # Kill the job
   $ docker kill $JOB

.. code-block:: bash

   # とても便利な長時間動作プロセスの開始
   $ JOB=$(docker run -d ubuntu /bin/sh -c "while true; do echo Hello world; sleep 1; done")
   
   # これまでのジョブの出力を収集
   $ docker logs $JOB
   
   # ジョブの停止(kill)
   $ docker kill $JOB


.. Listing containers

コンテナの一覧
=============================

.. $ docker ps # Lists only running containers
   $ docker ps -a # Lists all containers

.. code-block:: bash

   $ docker ps # 実行中のコンテナのみリスト表示
   $ docker ps -a # 全てのコンテナをリスト表示

.. Controlling containers

コンテナの制御
=============================

.. code-block:: bash

   # 新しいコンテナの起動
   $ JOB=$(docker run -d ubuntu /bin/sh -c "while true; do echo Hello world; sleep 1; done")
   
   # コンテナの停止
   $ docker stop $JOB
   
   # コンテナの起動
   $ docker start $JOB
   
   # コンテナの再起動
   $ docker restart $JOB
   
   # コンテナを SIGKILL で停止
   $ docker kill $JOB
   
   # コンテナを削除
   $ docker stop $JOB # Container must be stopped to remove it
   $ docker rm $JOB

.. Bind a service on a TCP port

TCP ポートにサービスを割り当て
==============================

.. code-block:: bash

   # コンテナにポート 4444 を割り当て、netcat でリッスンする
   $ JOB=$(docker run -d -p 4444 ubuntu:12.10 /bin/nc -l 4444)
   
   # どの外部ポートがコンテナに NAT されているか？
   $ PORT=$(docker port $JOB 4444 | awk -F: '{ print $2 }')
   
   # 公開ポートに接続
   $ echo hello world | nc 127.0.0.1 $PORT
   
   # ネットワーク接続の動作を確認
   $ echo "Daemon received: $(docker logs $JOB)"

.. Commiting (saving) a container state

コンテナの状態をコミット（保存）
========================================

.. To save the current state of a container as an image:

現在のコンテナの状態をイメージとして保存するには、 ``docker commit`` コマンドを使います。

.. code-block:: bash

   $ docker commit <コンテナ> <何かの名前>

.. When you commit your container, Docker Engine only stores the diff (difference) between the source image and the current state of the container's image. To list images you already have, run:

コンテナのコミットとは、元になったイメージと現在のコンテナの差分情報のみを、Docker Engine が保存します。どのようなイメージがあるかを確認するには、次のコマンドを実行します。

.. code-block:: bash

   # List your images
   $ docker images

.. You now have an image state from which you can create new instances.

コミットによって新しいイメージを手に入れました。これを使い、新しいインスタンス（訳者注：コンテナのこと）を作成可能でうｓ。

.. Where to go next

次はどこに行きますか
=============================

..  Work your way through the Docker User Guide
    Read more about Share Images via Repositories
    Review Command Line

* :doc:`Docker ユーザ・ガイド <userguide/index>` の中に進む
* :doc:`レポジトリを通したイメージの共有 <userguide/containers/dockerrepos>` について読む
* :doc:`コマンドラインの練習 <reference/commandline/cli>` を参照

.. seealso:: 

   Quickstart Docker Engine
      https://docs.docker.com/engine/quickstart/

