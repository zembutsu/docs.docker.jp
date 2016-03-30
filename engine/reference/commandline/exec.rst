.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/exec/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/exec.md
   doc version: 1.10
      https://github.com/docker/docker/commits/master/docs/reference/commandline/exec.md
.. check date: 2016/02/19
.. -------------------------------------------------------------------

.. exec

=======================================
exec
=======================================

.. code-block:: bash

   Usage: docker exec [OPTIONS] CONTAINER COMMAND [ARG...]
   
   Run a command in a running container
   
     -d, --detach=false         Detached mode: run command in the background
     --detach-keys              Specify the escape key sequence used to detach a container
     --help=false               Print usage
     -i, --interactive=false    Keep STDIN open even if not attached
     --privileged=false         Give extended Linux capabilities to the command
     -t, --tty=false            Allocate a pseudo-TTY
     -u, --user=                Username or UID (format: <name|uid>[:<group|gid>])

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
