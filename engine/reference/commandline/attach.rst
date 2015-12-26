.. -*- coding: utf-8 -*-
.. https://docs.docker.com/engine/reference/commandline/attach/
.. doc version: 1.9
.. check date: 2015/12/26
.. -----------------------------------------------------------------------------

.. attach

=======================================
attach
=======================================

.. code-block:: bash

   Usage: docker attach [OPTIONS] CONTAINER
   
   Attach to a running container
   
     --help=false        Print usage
     --no-stdin=false    Do not attach STDIN
     --sig-proxy=true    Proxy all received signals to the process

.. The docker attach command allows you to attach to a running container using the container’s ID or name, either to view its ongoing output or to control it interactively. You can attach to the same contained process multiple times simultaneously, screen sharing style, or quickly view the progress of your detached process.

``docker attach`` コマンドは、コンテナ ID や名前を使って実行中のコンテナにアタッチ（attach；装着/取り付けの意味）します。処理中の出力を表示するだけでなく、インタラクティブ（双方向）の管理もできます。同じコンテナ化されたプロセスに対して、画面を共有する形式として擬似的に複数回のアタッチが可能ですし、デタッチ（dettach；分離の意味）したプロセスの迅速な表示もできます。

.. You can detach from the container and leave it running with CTRL-p CTRL-q (for a quiet exit) or with CTRL-c if --sig-proxy is false.

コンテナを実行したままデタッチして離れるには、 ``CTRL-p CTRL-q`` （静かに終了）するか、 ``--sig-proxy`` が false であれば ``CTRL-c`` を使います。

.. If --sig-proxy is true (the default),CTRL-c sends a SIGINT to the container.

``--sig-proxy`` が true であれば（デフォルト設定です）、 ``CTRL-c`` の送信とは、コンテナに対して ``SIGINT`` を送信します。

..    Note: A process running as PID 1 inside a container is treated specially by Linux: it ignores any signal with the default action. So, the process will not terminate on SIGINT or SIGTERM unless it is coded to do so.

.. note::

   コンテナ内で PID 1 として実行しているプロセスは、Linux では特別な扱いがされます。通常の操作では、あらゆるシグナルを無視します。そのため、特別にコード化しない限り、プロセスを ``SIGINT`` や ``SIGTERM`` では停止できません。

.. It is forbidden to redirect the standard input of a docker attach command while attaching to a tty-enabled container (i.e.: launched with -t).

tty を有効化したコンテナにアタッチした状態（例： ``-t`` を使って起動）では、``docker attach`` コマンドを使った標準入力のリダイレクトは禁止されています。

.. Examples

例
----------

.. code-block:: bash

   $ docker run -d --name topdemo ubuntu /usr/bin/top -b
   $ docker attach topdemo
   top - 02:05:52 up  3:05,  0 users,  load average: 0.01, 0.02, 0.05
   Tasks:   1 total,   1 running,   0 sleeping,   0 stopped,   0 zombie
   Cpu(s):  0.1%us,  0.2%sy,  0.0%ni, 99.7%id,  0.0%wa,  0.0%hi,  0.0%si,  0.0%st
   Mem:    373572k total,   355560k used,    18012k free,    27872k buffers
   Swap:   786428k total,        0k used,   786428k free,   221740k cached
   
   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
    1 root      20   0 17200 1116  912 R    0  0.3   0:00.03 top
   
    top - 02:05:55 up  3:05,  0 users,  load average: 0.01, 0.02, 0.05
    Tasks:   1 total,   1 running,   0 sleeping,   0 stopped,   0 zombie
    Cpu(s):  0.0%us,  0.2%sy,  0.0%ni, 99.8%id,  0.0%wa,  0.0%hi,  0.0%si,  0.0%st
    Mem:    373572k total,   355244k used,    18328k free,    27872k buffers
    Swap:   786428k total,        0k used,   786428k free,   221776k cached
   
      PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
          1 root      20   0 17208 1144  932 R    0  0.3   0:00.03 top
   
   
    top - 02:05:58 up  3:06,  0 users,  load average: 0.01, 0.02, 0.05
    Tasks:   1 total,   1 running,   0 sleeping,   0 stopped,   0 zombie
    Cpu(s):  0.2%us,  0.3%sy,  0.0%ni, 99.5%id,  0.0%wa,  0.0%hi,  0.0%si,  0.0%st
    Mem:    373572k total,   355780k used,    17792k free,    27880k buffers
    Swap:   786428k total,        0k used,   786428k free,   221776k cached
   
    PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
         1 root      20   0 17208 1144  932 R    0  0.3   0:00.03 top
   ^C$
   $ echo $?
   0
   $ docker ps -a | grep topdemo
   7998ac8581f9        ubuntu:14.04        "/usr/bin/top -b"   38 seconds ago      Exited (0) 21 seconds ago                          topdemo

.. And in this second example, you can see the exit code returned by the bash process is returned by the docker attach command to its caller too:

この２つめの例は、 ``docker attach`` コマンドで処理された終了コードが、 ``bash`` プロセスに戻ってきても使えることがわかります。

.. code-block:: bash

   $ docker run --name test -d -it debian
   275c44472aebd77c926d4527885bb09f2f6db21d878c75f0a1c212c03d3bcfab
   $ docker attach test
   $$ exit 13
   exit
   $ echo $?
   13
   $ docker ps -a | grep test
   275c44472aeb        debian:7            "/bin/bash"         26 seconds ago      Exited (13) 17 seconds ago                         test
   
   
