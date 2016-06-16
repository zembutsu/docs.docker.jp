.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/attach/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/attach.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/attach.md
.. check date: 2016/06/14
.. Commits on Jun 7, 2016 2e506039ff9f6502670d42570f835c0d51fcda20
.. -------------------------------------------------------------------

.. attach

=======================================
attach
=======================================

.. code-block:: bash

   使い方: docker attach [オプション] コンテナ
   
   実行中のコンテナにアタッチする
   
     --detach-keys="<sequence>"       エスケープ・キー・シーケンスを設定
     --help                           使い方の表示
     --no-stdin                       STDIN（標準入力）にアタッチしない
     --sig-proxy=true                 受信したシグナルをプロセスに全てプロキシする

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. The docker attach command allows you to attach to a running container using the container’s ID or name, either to view its ongoing output or to control it interactively. You can attach to the same contained process multiple times simultaneously, screen sharing style, or quickly view the progress of your detached process.

``docker attach`` コマンドは、コンテナ ID や名前を使って実行中のコンテナにアタッチ（attach；装着/取り付けの意味）します。処理中の出力を表示するだけでなく、インタラクティブ（双方向）の管理もできます。同じコンテナ化されたプロセスに対して、画面を共有する形式として擬似的に複数回のアタッチが可能ですし、デタッチ（detach；分離の意味）したプロセスも迅速に表示できます。

.. You can detach from the container and leave it running with CTRL-p CTRL-q (for a quiet exit) or with CTRL-c if --sig-proxy is false.
.. コンテナを実行したままデタッチして離れるには、 ``CTRL-p CTRL-q`` （静かに終了）するか、 ``--sig-proxy`` が false であれば ``CTRL-c`` を使います。
.. If --sig-proxy is true (the default),CTRL-c sends a SIGINT to the container.
.. ``--sig-proxy`` が true であれば（デフォルト設定です）、 ``CTRL-c`` の送信とは、コンテナに対して ``SIGINT`` を送信します。

.. To stop a container, use CTRL-c. This key sequence sends SIGKILL to the container. If --sig-proxy is true (the default),CTRL-c sends a SIGINT to the container. You can detach from a container and leave it running using the CTRL-p CTRL-q key sequence.

コンテナを停止するには、 ``CTRL-c`` を使います。このキー・シーケンスはコンテナに対して ``SIGKILL`` を送信します。もしも ``--sig-proxy`` が true であれば（デフォルト）、 ``CTRL-c`` はコンテナに対して ``SIGINT`` を送信します。 ``CTRL-p CTRL-q`` キー・シーケンスを使えば、実行中のコンテナからデタッチして離れられます。

..    Note: A process running as PID 1 inside a container is treated specially by Linux: it ignores any signal with the default action. So, the process will not terminate on SIGINT or SIGTERM unless it is coded to do so.

.. note::

   コンテナ内で PID 1 として実行しているプロセスは、Linux では特別な扱いがされます。通常の操作では、あらゆるシグナルを無視します。そのため、特別にコード化しない限り、プロセスを ``SIGINT`` や ``SIGTERM`` では停止できません。

.. It is forbidden to redirect the standard input of a docker attach command while attaching to a tty-enabled container (i.e.: launched with -t).

tty を有効化したコンテナにアタッチした状態（例： ``-t`` を使って起動）では、``docker attach`` コマンドを使った標準入力のリダイレクトは禁止されています。

.. While a client is connected to container's stdio using docker attach, Docker uses a ~1MB memory buffer to maximize the throughput of the application. If this buffer is filled, the speed of the API connection will start to have an effect on the process output writing speed. This is similar to other applications like SSH. Because of this, it is not recommended to run performance critical applications that generate a lot of output in the foreground over a slow client connection. Instead, users should use the docker logs command to get access to the logs.

クライアントが ``docker attach`` を使ってコンテナの標準入出力に接続時、Docker は 1MB 以下のメモリ・バッファをアプリケーション性能の最大化のために使います。バッファがいっぱいになれば、API の接続速度は、出力を書き込む速度の影響を受け始めます。これは SSH のようなアプリケーションと似ています。そのため、性能がクリティカルなアプリケーションの実行はお薦めしません。フォアグラウントで大量の出力を生成するため、クライアントの接続を遅くします。そのかわり、ユーザは ``docker logs`` コマンドでログにアクセスすべきです。

.. Override the detach sequence

.. _override-the-detach-sequence:

デタッチ・シーケンスの上書き
==============================

.. If you want, you can configure an override the Docker key sequence for detach. This is is useful if the Docker default sequence conflicts with key sequence you use for other applications. There are two ways to define your own detach key sequence, as a per-container override or as a configuration property on your entire configuration.

必要であれば、デタッチ用の Docker キー・シーケンスの設定を上書きできます。Docker デフォルトのキー・シーケンスが他のアプリケーションと重複している場合に役立ちます。デタッチ用キー・シーケンスを指定するには、２つの方法があります。１つはコンテナごとに設定するか、あるいは全体に対してのプロパティを設定します。

.. To override the sequence for an individual container, use the --detach-keys="<sequence>" flag with the docker attach command. The format of the <sequence> is either a letter [a-Z], or the ctrl- combined with any of the following:

個々のコンテナに対するシーケンスを上書きするには、 ``docker attach`` コマンドに ``--detach-keys="<シーケンス>"`` を指定します。 ``<シーケンス>`` の書式は、 [a-Z] までの文字を使うか、 ``ctrl-`` と次の項目を組み合わせます。

..    a-z (a single lowercase alpha character )
    @ (at sign)
    [ (left bracket)
    \\ (two backward slashes)
    _ (underscore)
    ^ (caret)

* ``a-z`` （小文字のアルファベット文字列）
* ``@`` （アット記号）
* ``[`` （左かっこ）
* ``\\`` （２つのバックスラッシュ）
* ``_`` （アンダースコア）
* ``^`` （キャレット）

.. These a, ctrl-a, X, or ctrl-\\ values are all examples of valid key sequences. To configure a different configuration default key sequence for all containers, see Configuration file section.

例えば、 ``a`` 、 ``ctrl-a`` 、 ``x`` 、 ``ctrl-\\``  は、いずれも有効なキー・シーケンスです。全てのコンテナに対する異なったキー・シーケンスを設定するには、 :ref:`設定ファイル <configuration-files>` のセクションをご覧ください。

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

次の２つめの例は、 ``docker attach`` コマンドで処理された終了コードが、 ``bash`` プロセスに戻ってきても使えることが分かります。

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


.. seealso:: 

   attach
      https://docs.docker.com/engine/reference/commandline/attach/
