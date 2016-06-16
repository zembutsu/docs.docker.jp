.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/exec/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/exec.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/exec.md
.. check date: 2016/06/16
.. Commits on Jan 4, 2016 cdc7f26715fbf0779a5283354048caf9faa1ec4a
.. -------------------------------------------------------------------

.. exec

=======================================
exec
=======================================

.. code-block:: bash

   使い方: docker exec [オプション] コンテナ コマンド [引数...]
   
   実行中のコンテナでコマンドを実行
   
     -d, --detach=false         デタッチド・モード: コマンドをバックグラウンドで実行
     --detach-keys              デタッチド・コンテナに特定のエスケープ・キー・シーケンスを設定
     --help=false               使い方の表示
     -i, --interactive=false    アタッチしていなくても STDIN をオープンにし続ける
     --privileged=false         コマンドに拡張 Linux ケーパビリティの追加
     -t, --tty=false            疑似ターミナル (pseudo-TTY) の割り当て
     -u, --user=                ユーザ名か UID (書式: <名前|uid>[:<グループ|gid>])

.. The docker exec command runs a new command in a running container.

``docker exec`` コマンドは実行中のコンテナ内で、新しいコマンドを実行します。

.. The command started using docker exec only runs while the container’s primary process (PID 1) is running, and it is not restarted if the container is restarted.

``docker exec`` コマンドが使えるのは、コンテナのプラマリ・プロセス（ ``PID 1`` ）が実行中の時のみです。そして、コンテナが再起動されても、こちらは再起動されません。

.. If the container is paused, then the docker exec command will fail with an error:

コンテナを一時停止すると、 ``docker exec`` コマンドは停止し、エラーになります。

.. code-block:: bash

   $ docker pause test
   test
   $ docker ps
   CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                   PORTS               NAMES
   1ae3b36715d2        ubuntu:latest       "bash"              17 seconds ago      Up 16 seconds (Paused)                       test
   $ docker exec test ls
   FATA[0000] Error response from daemon: Container test is paused, unpause the container before exec
   $ echo $?
   1

.. Examples

.. _exec-examples:

例
==========

.. code-block:: bash

   $ docker run --name ubuntu_bash --rm -i -t ubuntu bash

.. This will create a container named ubuntu_bash and start a Bash session.

これは ``ubuntu_bash`` という名前のコンテナを作成し、Bash セッションを開始します。

.. code-block:: bash

   $ docker exec -d ubuntu_bash touch /tmp/execWorks

.. This will create a new file /tmp/execWorks inside the running container ubuntu_bash, in the background.

こちらは実行中の ``ubuntu_bash`` コンテナ内で、新しいファイル ``/tmp/execWorks`` をバックグラウンドで作成します。

.. code-block:: bash

   $ docker exec -it ubuntu_bash bash

.. This will create a new Bash session in the container ubuntu_bash.

こちらは ``ubuntu_bash`` コンテナ内に新しい Bash セッションを作成します。

.. seealso:: 

   exec
      https://docs.docker.com/engine/reference/commandline/exec/
