﻿.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/attach/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/cli/blob/master/docs/reference/commandline/attach.md
.. check date: 2022/2/13
.. Commits on Aug 21, 2021 47ba76afb159273e35326bd0cb548e960c51fbc7
.. -------------------------------------------------------------------

.. docker attach

=======================================
docker attach
=======================================

.. seealso:: 

   docker container attach
      https://docs.docker.com/engine/reference/commandline/container_attach/


.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

説明
==========

.. Attach local standard input, output, and error streams to a running container

ローカルの（訳者注：操作中のターミナルのこと）標準入力、標準出力、標準エラー出力を、実行中のコンテナに対して :ruby:`取り付け <attach>` ます。

使い方
==========

.. code-block:: bash

   使い方: docker attach [オプション] コンテナ

詳細説明
==========

.. Use docker attach to attach your terminal’s standard input, output, and error (or any combination of the three) to a running container using the container’s ID or name. This allows you to view its ongoing output or to control it interactively, as though the commands were running directly in your terminal.

``docker attach`` を使い、自分のターミナルの標準入力、標準出力、標準エラー（あるいは、これら3つの組みあわせ）にアタッチするには、コンテナの ID か名前で実行中のコンテナを指定します。これにより、あたかもコマンドを自分のターミナル上で直接実行しているかのように、それらの継続的な出力を見られるようになったり、インタラクティブ（双方向）に制御できます。

.. Note: The attach command will display the output of the ENTRYPOINT/CMD process. This can appear as if the attach command is hung when in fact the process may simply not be interacting with the terminal at that time.

.. note::

   ``attach`` コマンドは ``ENTRYPOINT/CMD`` プロセスの出力も表示します。そのため、attach コマンドの使用時、対象のプロセスが単にターミナルで応答がない場合は、あたかも固まっているかのように見えてしまいます。

.. You can attach to the same contained process multiple times simultaneously, from different sessions on the Docker host.

Docker ホスト上の異なるセッションから、同じプロセスに対し、同時に複数のアタッチができます。

.. To stop a container, use CTRL-c. This key sequence sends SIGKILL to the container. If --sig-proxy is true (the default),CTRL-c sends a SIGINT to the container. If the container was run with -i and -t, you can detach from a container and leave it running using the CTRL-p CTRL-q key sequence.

コンテナを停止するには、 ``CTRL-c`` を使います。このキー・シーケンスはコンテナに対して ``SIGKILL`` を送信します。 ``--sig-proxy`` が true の場合は（デフォルト）、 ``CTRL-c`` はコンテナに対して ``SIGINT`` を送信します。 コンテナを ``-i`` と ``-t`` で実行した場合は、 ``CTRL-p CTRL-q`` キー・シーケンスを使えば、実行中のコンテナからデタッチして離れられます。

.. It is forbidden to redirect the standard input of a docker attach command while attaching to a tty-enabled container (i.e.: launched with -t).

tty を有効化したコンテナにアタッチした状態（例： ``-t`` を使って起動）では、``docker attach`` コマンドを使った標準入力のリダイレクトは禁止されています。

.. While a client is connected to container's stdio using docker attach, Docker uses a ~1MB memory buffer to maximize the throughput of the application. If this buffer is filled, the speed of the API connection will start to have an effect on the process output writing speed. This is similar to other applications like SSH. Because of this, it is not recommended to run performance critical applications that generate a lot of output in the foreground over a slow client connection. Instead, users should use the docker logs command to get access to the logs.

クライアントが ``docker attach`` を使ってコンテナの標準入出力に接続時、Docker は 1MB 以下のメモリ・バッファをアプリケーション性能の最大化のために使います。バッファがいっぱいになれば、API の接続速度は、出力を書き込む速度の影響を受け始めます。これは SSH のようなアプリケーションと似ています。そのため、性能がクリティカルなアプリケーションの実行はお薦めしません。フォアグラウントで大量の出力を生成するため、クライアントの接続を遅くします。そのかわり、ユーザは ``docker logs`` コマンドでログにアクセスすべきです。

.. Override the detach sequence

.. _override-the-detach-sequence:

デタッチ・シーケンスの上書き
------------------------------

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

.. _docker-attach-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前、省略形
     - デフォルト
     - 説明
   * - ``--detach-keys``
     - 
     - コンテナをデタッチするキー・シーケンスを上書き
   * - ``--no-stdin``
     - 
     - 標準入力にアタッチしない
   * - ``--sig-proxy``
     - ``true``
     - プロセスに対して、受信した全てのシグナルをプロキシ（中継）する


.. Examples

例
==========

.. Attach to and detach from a running container🔗

実行中のコンテナにアタッチとデタッチ
----------------------------------------

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


.. Get the exit code of the container’s command

コンテナで実行していたコマンドの、終了コードを得る
------------------------------------------------------------

.. And in this second example, you can see the exit code returned by the bash process is returned by the docker attach command to its caller too:

次の２つめの例は、 ``docker attach`` コマンドで処理された終了コードが、 ``bash`` プロセスに戻ってきても使えるのが分かります。

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


親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI の基本コマンド



.. seealso:: 

   docker attach
      https://docs.docker.com/engine/reference/commandline/attach/
