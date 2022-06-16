.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/exec/
.. SOURCE:
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/exec.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_exec.yaml
.. check date: 2022/03/20
.. Commits on Aug 22, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker exec

=======================================
docker exec
=======================================

.. seealso:: 

   :doc:`docker container exec <container_exec>`

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _docker_exec-description:

説明
==========

.. Run a command in a running container

実行中のコンテナ内でコマンドを実行します。

.. _docker_exec-usage:

使い方
==========

.. code-block:: bash

   $ docker exec [OPTIONS] CONTAINER COMMAND [ARG...]

.. Extended description
.. _docker_exec-extended-description:

補足説明
==========

.. The docker exec command runs a new command in a running container.

``docker exec`` コマンドは実行中のコンテナ内で、新しいコマンドを実行します。

.. The command started using docker exec only runs while the container’s primary process (PID 1) is running, and it is not restarted if the container is restarted.

``docker exec`` コマンドが使えるのは、コンテナのプライマリ・プロセス（ ``PID 1`` として実行するプロセス）が実行中の時のみです。また、コンテナが再起動した場合は、こちらコマンドは再度実行されません。

.. COMMAND will run in the default directory of the container. If the underlying image has a custom directory specified with the WORKDIR directive in its Dockerfile, this will be used instead.

コマンドは、コンテナ内のデフォルトディレクトリで実行します。元になるイメージが、 Dockerfile 内の WORKDIR 命令で任意のディレクトリを指定している場合、そちらで実行します。

.. COMMAND should be an executable, a chained or a quoted command will not work. Example: docker exec -ti my_container "echo a && echo b" will not work, but docker exec -ti my_container sh -c "echo a && echo b" will.

コマンドは実行可能な状態である必要があり、連結するコマンドや、クォートしたコマンドは動作しません。例えば、 ``docker exec -ti my_container "echo a && echo b"`` は動作しませんが、 ``docker exec -ti my_container sh -c "echo a && echo b"`` は動作します。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <docker_exec-examples>` をご覧ください。

.. _docker_exec-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--detach`` , ``-d``
     - 
     - デタッチド・モード：バックグラウンドでコマンドを実行
   * - ``--detach-keys``
     - 
     - コンテナをデタッチするキー手順を上書き
   * - ``--env`` , ``-e``
     - 
     - 【API 1.25+】環境変数を指定
   * - ``--env-file``
     - 
     - 【API 1.25+】環境変数のファイルを読み込む
   * - ``--interactive`` , ``-i``
     - 
     - アタッチしていなくても、標準入力を開き続ける
   * - ``--privileged``
     - 
     - このコンテナに対して :ruby:`拡張権限 <extended privileged>` を与える
   * - ``--tty`` , ``-t``
     - 
     - :ruby:`疑似 <pseudo>` TTY を割り当て
   * - ``--user`` , ``-u``
     - 
     - ユーザ名または UID （format: <name|uid>[:<group|gid>]）
   * - ``--workdir`` , ``-w``
     - 
     - 【API 1.35+】コンテナ内の作業ディレクトリ


.. Examples
.. _docker_exec-examples:

使用例
==========

.. Run docker exec on a running container
.. _docker_exec-run-docker-exec-on-a-running-container:
実行中のコンテナに ``docker exec`` を実行
--------------------------------------------------

.. First, start a container.

まず、コンテナを起動します。

.. code-block:: bash

   $ docker run --name ubuntu_bash --rm -i -t ubuntu bash

.. This will create a container named ubuntu_bash and start a Bash session.

これは ``ubuntu_bash`` という名前のコンテナを作成し、Bash セッションを開始します。

.. Next, execute a command on the container.

次に、コンテナ上でコマンドを実行します。

.. code-block:: bash

   $ docker exec -d ubuntu_bash touch /tmp/execWorks

.. This will create a new file /tmp/execWorks inside the running container ubuntu_bash, in the background.

こちらは実行中の ``ubuntu_bash`` コンテナ内において、バックグランドで新しいファイル ``/tmp/execWorks`` を作成します。

.. Next, execute an interactive bash shell on the container.

次に、コンテナ上で双方向の ``bash`` シェルを実行します。

.. code-block:: bash

   $ docker exec -it ubuntu_bash bash

.. This will create a new Bash session in the container ubuntu_bash.

これにより、 ``ubuntu_bash`` コンテナ内に新しい Bash セッションを作成します。

.. Next, set an environment variable in the current bash session.

次に、現在の bash セッションに対し、環境変数を設定します。

.. code-block:: bash

   $ docker exec -it -e VAR=1 ubuntu_bash bash

.. This will create a new Bash session in the container ubuntu_bash with environment variable $VAR set to “1”. Note that this environment variable will only be valid on the current Bash session.

これは、 ``ubuntu_bash`` コンテナ内で新しい Bash セッションを開始し、環境変数 ``$VAR`` を ``1``  にしています。この環境変数が有効なのは、現在の Bash セッションのみという点に注意してください。

.. By default docker exec command runs in the same working directory set when container was created.

デフォルトの ``docker exec`` コマンドは、コンテナが作成時に設定された作業ディレクトリ内で実行します。

.. code-block:: bash

   $ docker exec -it ubuntu_bash pwd
   /

.. You can select working directory for the command to execute into

コマンドを実行するディレクトリを指定できます。

.. code-block:: bash

   $ docker exec -it -w /root ubuntu_bash pwd
   /root

.. Try to run docker exec on a paused container

.. _docker_exec-try-to-run-docker-exec-on-a-paused-container:

:ruby:`一時停止中 <pause>` のコンテナで ``docker exec`` を実行を試す
----------------------------------------------------------------------

.. If the container is paused, then the docker exec command will fail with an error:

コンテナがが一時停止中の場合、 ``docker exec`` コマンドはエラーになります。

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



親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI の基本コマンド

.. seealso:: 

   docker exec
      https://docs.docker.com/engine/reference/commandline/exec/
