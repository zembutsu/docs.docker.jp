.. -*- coding: utf-8 -*-
.. https://docs.docker.com/engine/articles/using_supervisord/
.. doc version: 1.9
.. check date: 2015/12/29
.. -----------------------------------------------------------------------------

.. Using Supervisor with Docker

.. _using-pupet:

=======================================
Supervisor と Docker を使う
=======================================

..    Note: - If you don’t like sudo then see Giving non-root access

.. note::

   **sudo を使いたくなければ**、 :ref:`ルート以外でアクセスするには  <giving-non-root-access>` をご覧ください。

.. Traditionally a Docker container runs a single process when it is launched, for example an Apache daemon or a SSH server daemon. Often though you want to run more than one process in a container. There are a number of ways you can achieve this ranging from using a simple Bash script as the value of your container’s CMD instruction to installing a process management tool.

伝統的に Docker コンテナは起動時に１つのプロセスを実行します。たとえば、Apache デーモンや SSH サーバのデーモンです。しかし、コンテナ内で複数のプロセスを起動したいこともあるでしょう。これを実現するにはいくつもの方法があります。プロセス管理ツールをインストールすることで、コンテナの ``CMD`` 命令で単純な Bash スクリプトを使えるようにします。

.. In this example we’re going to make use of the process management tool, Supervisor, to manage multiple processes in our container. Using Supervisor allows us to better control, manage, and restart the processes we want to run. To demonstrate this we’re going to install and manage both an SSH daemon and an Apache daemon.

この例では、プロセス管理ツール `Supervisor <http://supervisord.org/>` を使い、コンテナ内で複数のプロセスを管理します。Supervisor を使うことにより、制御・管理しやすくし、実行したいプロセスを再起動できます。デモンストレーションとして、SSH デーモンと Apache デーモンの両方をインストール・管理します。


.. Creating a Dockerfile

Dockerfile の作成
====================

.. Let’s start by creating a basic Dockerfile for our new image.

基本的な ``Dockerfile`` から新しいイメージを作りましょう。

.. code-block:: bash

   FROM ubuntu:13.04
   MAINTAINER examples@docker.com

.. Installing Supervisor

Supervisor のインストール
==============================

.. We can now install our SSH and Apache daemons as well as Supervisor in our container.

SSH と Apache デーモンと同じように、Supervisor をコンテナにインストールできます。

.. code-block:: bash

   RUN apt-get update && apt-get install -y openssh-server apache2 supervisor
   RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/run/sshd /var/log/supervisor

.. Here we’re installing the openssh-server, apache2 and supervisor (which provides the Supervisor daemon) packages. We’re also creating four new directories that are needed to run our SSH daemon and Supervisor.

ここでインストールしたパッケージは ``openssh-server`` 、 ``apache2`` 、 ``supervisor`` （Supervisor デーモンを提供）です。それから、SSH デーモンと Supervisor を実行するための新しいディレクトリの作成も必要です。

.. Adding Supervisor’s configuration file

Supervisor の設定ファイルを追加
================================

.. Now let’s add a configuration file for Supervisor. The default file is called supervisord.conf and is located in /etc/supervisor/conf.d/.

次は Supervisor の設定ファイルを追加しましょう。デフォルトのファイルは ``supervisord.conf`` であり、 ``/etc/supervisor/conf.d/`` に置きます。

.. code-block:: bash

   COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

.. Let’s see what is inside our supervisord.conf file.

.. code-block:: bash

   [supervisord]
   nodaemon=true
   
   [program:sshd]
   command=/usr/sbin/sshd -D
   
   [program:apache2]
   command=/bin/bash -c "source /etc/apache2/envvars && exec /usr/sbin/apache2 -DFOREGROUND"

.. The supervisord.conf configuration file contains directives that configure Supervisor and the processes it manages. The first block [supervisord] provides configuration for Supervisor itself. We’re using one directive, nodaemon which tells Supervisor to run interactively rather than daemonize.

``supervisord.conf`` 設定ファイルにはディレクティブ（命令）を記述します。これは Supervisor とプロセスを管理するためです。始めのブロック ``[supervisord]`` は Supervisord 自身の設定を指定します。ここで使ったディレクティブ ``nodaemon`` は、Supervisor をデーモン化するのではなく、インタラクティブに実行します。

.. The next two blocks manage the services we wish to control. Each block controls a separate process. The blocks contain a single directive, command, which specifies what command to run to start each process.

次の２つのブロックは制御したいサービスを管理します。各ブロックは、別々のプロセスです。ブロックには ``command`` というディレクティブが１つあり、各プロセスで何のコマンドを起動するか指定します。

.. Exposing ports and running Supervisor

ポートの公開と Supervisor の実行
========================================

.. Now let’s finish our Dockerfile by exposing some required ports and specifying the CMD instruction to start Supervisor when our container launches.

``Dockerfile`` を作り終えるため、コンテナの実行時に、公開に必要なポートや Supervisor 起動のための``CMD`` 命令を追加します。

.. code-block:: bash

   EXPOSE 22 80
   CMD ["/usr/bin/supervisord"]

.. Here We’ve exposed ports 22 and 80 on the container and we’re running the /usr/bin/supervisord binary when the container launches.

ここでは、コンテナのポート 22 と 80 を公開し、コンテナの起動時に ``/usr/bin/supervisord`` バイナリを実行します。

.. Building our image

イメージの構築
====================

.. We can now build our new image.

これで新しいイメージを構築できます。

.. code-block:: bash

   $ docker build -t <yourname>/supervisord .

.. Running our Supervisor container

Supervisor コンテナを実行
==============================

.. Once We’ve got a built image we can launch a container from it.

イメージを構築したら、これを使ってコンテナを起動します。

.. code-block:: bash

   $ docker run -p 22 -p 80 -t -i <yourname>/supervisord
   2013-11-25 18:53:22,312 CRIT Supervisor running as root (no user in config file)
   2013-11-25 18:53:22,312 WARN Included extra file "/etc/supervisor/conf.d/supervisord.conf" during parsing
   2013-11-25 18:53:22,342 INFO supervisord started with pid 1
   2013-11-25 18:53:23,346 INFO spawned: 'sshd' with pid 6
   2013-11-25 18:53:23,349 INFO spawned: 'apache2' with pid 7
   . . .

.. We’ve launched a new container interactively using the docker run command. That container has run Supervisor and launched the SSH and Apache daemons with it. We’ve specified the -p flag to expose ports 22 and 80. From here we can now identify the exposed ports and connect to one or both of the SSH and Apache daemons.

``docker run`` コマンドを実行することで、新しいコンテナをインタラクティブに起動しました。このコンテナは Supervisor を実行し、一緒に SSH と Apache デーモンを起動します。 ``-p`` フラグを指定し、ポート 22 と 80 を公開します。ここで、SSH と Apache デーモンの両方に接続できるようにするため、公開ポートを個々に指定しています。
