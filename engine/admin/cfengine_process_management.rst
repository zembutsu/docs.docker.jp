.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/admin/cfengine_process_management/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/admin/cfengine_process_management.md
   doc version: 1.11
      https://github.com/docker/docker/commits/master/docs/admin/cfengine_process_management.md
.. check date: 2016/04/19（ドキュメント削除予定） https://github.com/docker/docker/issues/11703
.. Commits on Jan 27, 2016 e310d070f498a2ac494c6d3fde0ec5d6e4479e14
.. ---------------------------------------------------------------------------

.. Process management with CFEngine

.. _process-management-with-cfengine:

=======================================
CFEngine でプロセス管理
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Create Docker containers with managed processes.

プロセスを管理する Docker コンテナを作成します。

.. Docker monitors one process in each running container and the container lives or dies with that process. By introducing CFEngine inside Docker containers, we can alleviate a few of the issues that may arise:

Docker は各実行中のコンテナで１つのプロセスを監視します。そして、コンテナの生死とは、そのプロセスの生死を指します。Docker コンテナ内での CFEngine の動かし方を紹介します。これは、次の問題を軽減するものです。

..    It is possible to easily start multiple processes within a container, all of which will be managed automatically, with the normal docker run command.
    If a managed process dies or crashes, CFEngine will start it again within 1 minute.
    The container itself will live as long as the CFEngine scheduling daemon (cf-execd) lives. With CFEngine, we are able to decouple the life of the container from the uptime of the service it provides.

* １つのコンテナの中で、複数のコンテナを簡単に起動できるかもしれません。通常の ``docker run`` コマンドを実行するだけで、全てを自動的に管理します。
* 停止またはクラッシュしたプロセスを管理し、１分以内に CFEngine が対象プロセスを再起動します。
* CFEngine スケジューリング・デーモン（cf-execd）が動いている限り、コンテナ自身も動かし続けます。CFEngine によって、コンテナの生存をサービスの状況と切り離せるようになります。

.. How it works

どのように動作するのか
==============================

.. CFEngine, together with the cfe-docker integration policies, are installed as part of the Dockerfile. This builds CFEngine into our Docker image.

CFEngine は、cfe-docker 統合ポリシー（integration policies）と一緒に Dockerfile の中でインストールします。Docker イメージの中で CFEngine が構築されています。

.. The Dockerfile’s ENTRYPOINT takes an arbitrary amount of commands (with any desired arguments) as parameters. When we run the Docker container these parameters get written to CFEngine policies and CFEngine takes over to ensure that the desired processes are running in the container.

Dockerfile の ``ENTRYPOINT`` には任意のコマンド（と任意の引数）をパラメータとして指定できます。Docker コンテナが CFEngine ポリシーの書かれたパラメータを受け取り実行する時、CFEngine はコンテナ内で任意のプロセスが間違いなく実行されるようにします。

.. CFEngine scans the process table for the basename of the commands given to the ENTRYPOINT and runs the command to start the process if the basename is not found. For example, if we start the container with docker run "/path/to/my/application parameters", CFEngine will look for a process named application and run the command. If an entry for application is not found in the process table at any point in time, CFEngine will execute /path/to/my/application parameters to start the application once again. The check on the process table happens every minute.

CFEngine は ``ENTRYPOINT`` で指定したコマンドの ``ベースネーム`` （最終的に実行するコマンドの名前）にあたるプロセス・テーブルをスキャンし、 ``ベースネーム`` のプロセスが見つからなければ、それを開始しようとします。例えば、コンテナを ``docker run "/path/to/my/application パラメータ"`` で開始したら、CFEngine は ``application`` という名前のプロセスを探し、コマンドを実行します。もし ``application`` にあたるエントリがプロセス・テーブルに無ければ、 CFEngine は ``/path/to/my/application parameters`` でアプリケーションを再度起動しようとします。このプロセス・テーブルの確認は、毎分実行されます。

.. Note that it is therefore important that the command to start your application leaves a process with the basename of the command. This can be made more flexible by making some minor adjustments to the CFEngine policies, if desired.

従って重要になるのは、アプリケーションを開始するにあたり、そのプロセスにベースネームが含まれている必要があるため、ご注意ください。

.. Usage

使い方
==========

.. This example assumes you have Docker installed and working. We will install and manage apache2 and sshd in a single container.

この例は、Docker をインストール済みであり、動くものと想定しています。これから１つのコンテナの中に ``apache2`` と ``sshd`` をインストール・管理します。

.. There are three steps:

３つの手順を踏みます：

..    Install CFEngine into the container.
    Copy the CFEngine Docker process management policy into the containerized CFEngine installation.
    Start your application processes as part of the docker run command.

1. コンテナの中に CFEngine をインストールします。
2. CFEngine の Docker プロセス管理ポリシーを、CFEngine をインストールしたコンテナにコピーします。
3. ``docker run`` コマンドの一部として、アプリケーション・プロセスを開始します。

.. Building the image

イメージの構築
--------------------

.. The first two steps can be done as part of a Dockerfile, as follows.

以下のように、Dockerfile の１～２ステップで設定できます。

.. code-block:: bash

   FROM ubuntu
   MAINTAINER Eystein Måløy Stenberg <eytein.stenberg@gmail.com>
   
   RUN apt-get update && apt-get install -y wget lsb-release unzip ca-certificates
   
   # install latest CFEngine
   RUN wget -qO- http://cfengine.com/pub/gpg.key | apt-key add -
   RUN echo "deb http://cfengine.com/pub/apt $(lsb_release -cs) main" > /etc/apt/sources.list.d/cfengine-community.list
   RUN apt-get update && apt-get install -y cfengine-community
   
   # install cfe-docker process management policy
   RUN wget https://github.com/estenberg/cfe-docker/archive/master.zip -P /tmp/ && unzip /tmp/master.zip -d /tmp/
   RUN cp /tmp/cfe-docker-master/cfengine/bin/* /var/cfengine/bin/
   RUN cp /tmp/cfe-docker-master/cfengine/inputs/* /var/cfengine/inputs/
   RUN rm -rf /tmp/cfe-docker-master /tmp/master.zip
   
   # apache2 and openssh are just for testing purposes, install your own apps here
   RUN apt-get update && apt-get install -y openssh-server apache2
   RUN mkdir -p /var/run/sshd
   RUN echo "root:password" | chpasswd  # need a password for ssh
   
   ENTRYPOINT ["/var/cfengine/bin/docker_processes_run.sh"]

.. By saving this file as Dockerfile to a working directory, you can then build your image with the docker build command, e.g., docker build -t managed_image.

作業ディレクトリでこのファイルを Dockerfile として保存します。イメージを構築するには docker build コマンドを使います。例： ``docker build -t managed_image`` 。

.. Testing the container

コンテナのテスト
--------------------

.. Start the container with apache2 and sshd running and managed, forwarding a port to our SSH instance:

``apache2`` と ``sshd`` を実行するコンテナを開始し、 SSH インスタンスのポート転送を管理します。

.. code-block:: bash

   $ docker run -p 127.0.0.1:222:22 -d managed_image "/usr/sbin/sshd" "/etc/init.d/apache2 start"

.. We now clearly see one of the benefits of the cfe-docker integration: it allows to start several processes as part of a normal docker run command.

これが、まさに cfe-docker 統合における明確な利点です。通常の ``docker run`` コマンドの一部として、複数のプロセスを開始します。

.. We can now log in to our new container and see that both apache2 and sshd are running. We have set the root password to “password” in the Dockerfile above and can use that to log in with ssh:

新しいコンテナ内にログインしたら、 ``apache2`` と ``sshd`` の両方が動作しています。先ほどの Dockerfile で root パスワードを "password" と指定しましたので、これを使って SSH でログインします。

.. code-block:: bash

   ssh -p222 root@127.0.0.1
   
   ps -ef
   UID        PID  PPID  C STIME TTY          TIME CMD
   root         1     0  0 07:48 ?        00:00:00 /bin/bash /var/cfengine/bin/docker_processes_run.sh /usr/sbin/sshd /etc/init.d/apache2 start
   root        18     1  0 07:48 ?        00:00:00 /var/cfengine/bin/cf-execd -F
   root        20     1  0 07:48 ?        00:00:00 /usr/sbin/sshd
   root        32     1  0 07:48 ?        00:00:00 /usr/sbin/apache2 -k start
   www-data    34    32  0 07:48 ?        00:00:00 /usr/sbin/apache2 -k start
   www-data    35    32  0 07:48 ?        00:00:00 /usr/sbin/apache2 -k start
   www-data    36    32  0 07:48 ?        00:00:00 /usr/sbin/apache2 -k start
   root        93    20  0 07:48 ?        00:00:00 sshd: root@pts/0
   root       105    93  0 07:48 pts/0    00:00:00 -bash
   root       112   105  0 07:49 pts/0    00:00:00 ps -ef

.. If we stop apache2, it will be started again within a minute by CFEngine.

もし apache2 を停止しても、CFEngine が１分以内に再起動します。

.. code-block:: bash

   service apache2 status
    Apache2 is running (pid 32).
   service apache2 stop
            * Stopping web server apache2 ... waiting    [ OK ]
   service apache2 status
    Apache2 is NOT running.
   # ... wait up to 1 minute...
   service apache2 status
    Apache2 is running (pid 173).

.. Adapting to your applications

自分のアプリケーションに適用
==============================

.. To make sure your applications get managed in the same manner, there are just two things you need to adjust from the above example:

自分のアプリケーションでも同じように設定できます。上記の例で調整が必要なのは、２ヵ所だけです。

..    In the Dockerfile used above, install your applications instead of apache2 and sshd.
    When you start the container with docker run, specify the command line arguments to your applications rather than apache2 and sshd.

* 上記の Dockerfile を使い、 ``apache2`` と ``sshd`` のかわりに自分のアプリケーションをインストールします。
* ``docker run`` でコンテナを起動に、 ``apache2`` と ``sshd`` ではなく、自分のアプリケーション用のコマンドライン引数を指定します。

.. seealso:: 

   Process management with CFEngine
      https://docs.docker.com/engine/admin/cfengine_process_management/
