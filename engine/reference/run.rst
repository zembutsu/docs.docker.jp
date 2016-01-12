.. -*- coding: utf-8 -*-
.. https://docs.docker.com/engine/reference/run/
.. doc version: 1.9
.. check date: 2016/01/10

.. Docker run reference

.. _docker-run-reference:

========================================
Docker run リファレンス
========================================

.. Docker runs processes in isolated containers. A container is a process which runs on a host. The host may be local or remote. When an operator executes docker run, the container process that runs is isolated in that it has its own file system, its own networking, and its own isolated process tree separate from the host.

Docker は隔離されたコンテナでプロセスを実行します。コンテナはホスト上で動くプロセスです。ホストとはローカルかリモートです。作業者が ``docker run`` を実行すると、コンテナのプロセスが隔離されて実行されます。ここではコンテナ自身のファイルシステムを持ち、自身のネットワークを持ち、ホスト上の他のプロセス・ツリーからは隔離されています。

.. This page details how to use the docker run command to define the container’s resources at runtime.

このページでは、コンテナ実行時のリソースを指定するために、 ``docker run`` コマンドの使い方の詳細を説明します。

.. General form

.. _run-general-form:

一般的な形式
====================

.. The basic docker run command takes this form:

基本的な ``docker run`` コマンドの形式は、次の通りです。

.. code-block:: bash

   $ docker run [オプション] イメージ[:タグ|@ダイジェスト値] [コマンド] [引数...]

.. The docker run command must specify an IMAGE to derive the container from. An image developer can define image defaults related to:

``docker run`` コマンドはコンテナを形成する元になる :ref:`イメージ <image>` の指定が必須です。イメージの開発者はイメージに関連するデフォルト値を定義できます。

..    detached or foreground running
    container identification
    network settings
    runtime constraints on CPU and memory
    privileges and LXC configuration

* デタッチ、あるいはフォアグラウンドで実行するか
* コンテナの識別
* ネットワーク設定
* 実行時の CPU とメモリの制限
* 権限と LXC 設定

.. With the docker run [OPTIONS] an operator can add to or override the image defaults set by a developer. And, additionally, operators can override nearly all the defaults set by the Docker runtime itself. The operator’s ability to override image and Docker runtime defaults is why run has more options than any other docker command.

``docker run [オプション]`` では、開発者がイメージに対して行ったデフォルト設定の変更や、設定の追加をオペレータが行えます。そして更に、オペレータは Docker で実行する時、すべてのデフォルト設定を上書きすることもできます。オペレータはイメージと Docker 実行時のデフォルト設定を上書きできるのは、 :doc:`run </engine/reference/commandline/run>` コマンドは他の ``docker`` コマンドより多くのオプションがあるためです。

.. To learn how to interpret the types of [OPTIONS], see Option types.

様々な種類の ``[オプション]`` を理解するには、 :ref:`オプションの種類 <option-types>` をご覧ください。

..    Note: Depending on your Docker system configuration, you may be required to preface the docker run command with sudo. To avoid having to use sudo with the docker command, your system administrator can create a Unix group called docker and add users to it. For more information about this configuration, refer to the Docker installation documentation for your operating system.

.. note::

   Docker システムの設定によっては、 ``docker run`` コマンドを ``sudo`` で実行する必要があるかもしれません。 ``docker`` コマンドで ``sudo`` を使わないようにするには、システム管理者に ``docker`` という名称のグループの作成と、そこにユーザの追加を依頼してください。この設定に関するより詳しい情報は、各オペレーティング・システム向けのインストール用ドキュメントをご覧ください。

.. Operator exclusive options

.. _operator-exclusive-options:

オペレータ専用のオプション
==============================

.. Only the operator (the person executing docker run) can set the following options.

オペレータ（ ``docker run`` の実行者 ）のみ、以下のオプションを設定できます。

..    Detached vs foreground
        Detached (-d)
        Foreground
    Container identification
        Name (–name)
        PID equivalent
    IPC settings (–ipc)
    Network settings
    Restart policies (–restart)
    Clean up (–rm)
    Runtime constraints on resources
    Runtime privilege, Linux capabilities, and LXC configuration

* :ref:`デタッチド vs フォアグラウンド <detached-vs-foreground>`
 * :ref:`デタッチド (-d) <detached-d>`
 * :ref:`フォアグラウンド <foreground>`
* :ref:`コンテナの識別 <container-identification>`
 * :ref:`名前 <name-name>`
 * :ref:`PID 相当 <pid-quivalent>`
* :ref:`IPC 設定 <ipc-settings-ipc>`
* :ref:`ネットワーク設定 <network-settings>`
* :ref:`再起動ポリシー <restart-policies-restart>`
* :ref:`クリーンアップ <clean-up-rm>`
* :ref:`実行時のリソース制限 <runtime-constraints-on-resources>`
* :ref:`実行時の権限、Linux 機能、LXC 設定 <runtime-privilege-linux-capabilities-and-lxc-configuration>`

.. Detached vs foreground

.. _detatched-vs-foreground:

デタッチド vs フォアグラウンド
==============================

.. When starting a Docker container, you must first decide if you want to run the container in the background in a “detached” mode or in the default foreground mode:

Docker コンテナの起動時には、まず、コンテナをバックグラウンドで「デタッチド」モード（detached mode）で実行するか、デフォルトのフォアグラウンド・モード（foreground mode）で実行するかを決める必要があります。

.. code-block:: bash

   -d=false: Detached mode: Run container in the background, print new container id

.. Detached (-d)

.. _detached-d:

デタッチド (-d)
--------------------

.. To start a container in detached mode, you use -d=true or just -d option. By design, containers started in detached mode exit when the root process used to run the container exits. A container in detached mode cannot be automatically removed when it stops, this means you cannot use the --rm option with -d option.

コンテナをデタッチド・モードで起動するには、 ``-d=true`` か ``-d`` オプションを使います。設計上、コンテナが実行するルート・プロセスが終了すると、デタッチド・モードで起動したコンテナも終了します。デタッチド・モードのコンテナは停止しても自動的に削除できません。つまり ``-d`` オプションで ``--rm`` を指定できません。

.. Do not pass a service x start command to a detached container. For example, this command attempts to start the nginx service.

デタッチドのコンテナでは ``service x start`` コマンドは受け付けられません。例えば、次のコマンドは ``nginx`` サービスの起動を試みるものです。

.. code-block:: bash

   $ docker run -d -p 80:80 my_image service nginx start

.. This succeeds in starting the nginx service inside the container. However, it fails the detached container paradigm in that, the root process (service nginx start) returns and the detached container stops as designed. As a result, the nginx service is started but could not be used. Instead, to start a process such as the nginx web server do the following:

コンテナ内で ``nginx`` サービスの起動は成功します。しかしながら、デタッチド・コンテナの枠組みにおいては処理が失敗します。これはルート・プロセス（ ``service nginx start`` ）が戻るので、デタッチド・コンテナを停止させようとします。その結果、 ``nginx`` サービスは実行されますが、実行し続けることができません。そのかわり、 ``nginx``  ウェブ・サーバのプロセスを実行するには、次のようにします。

.. code-block:: bash

   $ docker run -d -p 80:80 my_image nginx -g 'daemon off;'

.. To do input/output with a detached container use network connections or shared volumes. These are required because the container is no longer listening to the command line where docker run was run.

コンテナの入出力はネットワーク接続や共有ボリュームも扱えます。コマンドラインで ``docker run`` を実行し終わったあとでも、必要になることがあるでしょう。

.. To reattach to a detached container, use docker attach command.

デタッチド・コンテナに再度アタッチするには、 ``docker`` :doc:`attach </engine/reference/commandline/attach>` コマンドを使います。

.. Foreground

.. _foreground:

フォアグラウンド
--------------------

.. In foreground mode (the default when -d is not specified), docker run can start the process in the container and attach the console to the process’s standard input, output, and standard error. It can even pretend to be a TTY (this is what most command line executables expect) and pass along signals. All of that is configurable:

フォアグラウンド・モード（ ``-d`` を指定しない場合のデフォルト ）では、 ``docker run`` はコンテナの中でプロセスを開始し、プロセスの標準入出力・標準エラーをコンソールにアタッチします。これは TTY のふりをするだけでなく（TTY は大部分のコマンド・ラインで実行可能なものと想定しています）、シグナルも渡せます。

.. code-block:: bash

   -a=[]           : Attach to `STDIN`, `STDOUT` and/or `STDERR`
   -t=false        : Allocate a pseudo-tty
   --sig-proxy=true: Proxify all received signal to the process (non-TTY mode only)
   -i=false        : Keep STDIN open even if not attached

.. If you do not specify -a then Docker will attach all standard streams. You can specify to which of the three standard streams (STDIN, STDOUT, STDERR) you’d like to connect instead, as in:

もし Docker で ``-a`` を指定しなければ、Docker は `自動的に全ての標準ストリームをアタッチ <https://github.com/docker/docker/blob/75a7f4d90cde0295bcfb7213004abce8d4779b75/commands.go#L1797>`_ します。３つの標準ストリーム（ ``STDIN`` 、 ``STDOUT`` 、 ``STDERR`` ）のうち、特定のものに対してのみ接続も可能です。

.. code-block:: bash

   $ docker run -a stdin -a stdout -i -t ubuntu /bin/bash

.. For interactive processes (like a shell), you must use -i -t together in order to allocate a tty for the container process. -i -t is often written -it as you’ll see in later examples. Specifying -t is forbidden when the client standard output is redirected or piped, such as in: echo test | docker run -i busybox cat.

（シェルのような）インタラクティブなプロセスでは、コンテナのプロセスに対して tty を割り当てるため、 ``-i -t`` を一緒に使う必要があります。 ``-i -t`` は ``-it`` としても書くことができます。後ろの例で出てきます。 ``-t`` を指定すると、クライアント側の出力を ``echo test | docker run -i busybox cat`` のようにリダイレクトやパイプできます。

..     Note: A process running as PID 1 inside a container is treated specially by Linux: it ignores any signal with the default action. So, the process will not terminate on SIGINT or SIGTERM unless it is coded to do so.

.. note::

   コンテナの中で PID 1 として実行しているプロセスは、Linux から特別に扱われます。デフォルトの操作では、あらゆるシグナルを無視します。そのため、プロセスは ``SIGINT`` か ``SIGTERM`` で停止するようにコードを書かない限り、停止できません。

.. Container identification

.. _container-identification:

コンテナの識別
====================

.. Name (–name)

.. _name-name:

名前（--name）
--------------------

.. The operator can identify a container in three ways:

オペレータはコンテナを３つの方法で識別できます。

..    UUID long identifier (“f78375b1c487e03c9438c729345e54db9d20cfa2ac1fc3494b6eb60872e74778”)
    UUID short identifier (“f78375b1c487”)
    Name (“evil_ptolemy”)

* UUID 長い（ロング）識別子（"f78375b1c487e03c9438c729345e54db9d20cfa2ac1fc3494b6eb60872e74778"）
* UUID 短い（ショート）識別子（"f78375b1c487"）
* 名前（"evil_ptolemy"）

.. The UUID identifiers come from the Docker daemon. If you do not assign a container name with the --name option, then the daemon generates a random string name for you. Defining a name can be a handy way to add meaning to a container. If you specify a name, you can use it when referencing the container within a Docker network. This works for both background and foreground Docker containers.

UUID 識別子は Docker デーモンから与えられます。コンテナの名前を ``--name`` オプションで割り当てなければ、デーモンはランダムな文字列から名前を生成します。コンテナに対する目的を表すために、 ``name`` を定義するのが簡単な方法でしょう。 ``name`` を指定すると、これは Docker ネットワーク内でコンテナを参照するために使えます。この参照機能は、バックグラウンドでもフォアグラウンドでも、両方の Docker コンテナで動作します。

.. Note: Containers on the default bridge network must be linked to communicate by name.

.. note::

   デフォルト・ブリッジ・ネットワーク内のコンテナは、相互に名前で通信するにはリンクする必要があります。

.. PID equivalent

.. _pid-equivalnet:

PID 相当
--------------------

.. Finally, to help with automation, you can have Docker write the container ID out to a file of your choosing. This is similar to how some programs might write out their process ID to a file (you’ve seen them as PID files):

あとは、自動処理を簡単にするため、任意に選択したファイルに対して Docker はコンテナ ID を書き出せます。これは、プログラムがプロセス ID をファイルに書き出す（いわゆる PID ファイルのことです）のに似ています。

.. code-block:: bash

   --cidfile="": コンテナの ID をファイルに書き出す

.. Image[:tag]

.. _image-tag:

イメージ[:タグ]
--------------------

.. While not strictly a means of identifying a container, you can specify a version of an image you’d like to run the container with by adding image[:tag] to the command. For example, docker run ubuntu:14.04.


.. Image[@digest]

.. _image-digest:

イメージ[@ダイジェスト値]
------------------------------

.. Images using the v2 or later image format have a content-addressable identifier called a digest. As long as the input used to generate the image is unchanged, the digest value is predictable and referenceable.

v2 以降のイメージ・フォーマットのイメージを使うと、その中にダイジェスト値（digest）と呼ばれる識別子が、内容に対して割り当てられています。入力に使われたイメージファイルに対する変更がなければ、ダイジェスト値とは予想されうる値であり、参照可能なものです。

.. PID settings (–pid)

.. _pid-settings-pid:

PID 設定（--pid）
====================

..   --pid=""  : Set the PID (Process) Namespace mode for the container,
..          'host': use the host's PID namespace inside the container

.. code-block:: bash

   --pid=""  : コンテナに対する PID （プロセス）名前空間モードを指定
          'host':コンテナ内のホストが使う PID 名前空間

.. By default, all containers have the PID namespace enabled.

デフォルトでは、全てのコンテナは有功な PID 名前空間を持っています。

.. PID namespace provides separation of processes. The PID Namespace removes the view of the system processes, and allows process ids to be reused including pid 1.

PID 名前空間はプロセスの分離をもたらします。PID 名前空間はシステム・プロセスを見えないようにし、PID 1 を含むプロセス ID を再利用できるようにします。

.. In certain cases you want your container to share the host’s process namespace, basically allowing processes within the container to see all of the processes on the system. For example, you could build a container with debugging tools like strace or gdb, but want to use these tools when debugging processes within the container.

コンテナがホスト上の特定のプロセス名前空間を共有する場合は、コンテナ内のプロセスが、システム上の全プロセスを基本的に見られるようにします。例えば、 ``strace`` や ``gdb`` のようなデバッグ用ツールを含むコンテナを構築したとき、コンテナ内のデバッグ用プロセスのみツールを使えるように指定する場合です。

.. code-block:: bash

   $ docker run --pid=host rhel7 strace -p 1234

.. This command would allow you to use strace inside the container on pid 1234 on the host.

このコマンドはホスト上の pid 1234 として、コンテナの中で ``strace`` を使うものです。

.. UTS settings (–uts)

.. _uts-settings-uts:

UTS 設定（--uts）
====================

..   --uts=""  : Set the UTS namespace mode for the container,
..          'host': use the host's UTS namespace inside the container


.. code-block:: bash

   --uts=""  : UTS 名前空間モードをコンテナに設定する
          'host': コンテナ内でホストの UTS 名前空間を使う

.. The UTS namespace is for setting the hostname and the domain that is visible to running processes in that namespace. By default, all containers, including those with --net=host, have their own UTS namespace. The host setting will result in the container using the same UTS namespace as the host.

UTS 名前空間とは、プロセスを実行する名前空間上で見えるホスト名とドメイン名を設定するものです。デフォルトでは、全てのコンテナは ``--uts=host`` の指定により、自身の UTS 名前空間を持っています。 ``host`` には、ホスト名として同じ UTS 名前空間をコンテナで使えるようにする設定をします。

.. You may wish to share the UTS namespace with the host if you would like the hostname of the container to change as the hostname of the host changes. A more advanced use case would be changing the host’s hostname from a container.

ホスト上と UTS 名前空間を共有したい場合もあるでしょう。例えば、コンテナを動かすホストがホスト名を変更してしまい、コンテナのホスト名も変更したい場合です。より高度な使い方としては、コンテナからホスト側のホスト名の変更を行うケースです。

..    Note: --uts="host" gives the container full access to change the hostname of the host and is therefore considered insecure.

.. note::

   ``--uts="host"`` 設定をすると、ホスト上のホスト名の変更に対するフル・アクセスをもたらすため、安全ではないと考えられます。

.. IPC settings (–ipc)

.. _ipc-settings-ipc:

IPC 設定（--ipc） 
====================

.. --ipc=""  : Set the IPC mode for the container,
             'container:<name|id>': reuses another container's IPC namespace
             'host': use the host's IPC namespace inside the container

.. code-block:: bash

   --ipc=""  : コンテナに IPC モードを設定する
                'container:<名前|id>': 他のコンテナの IPC 名前空間を再利用
                'host': ホストの IPC 名前空間をコンテナの中で使用

.. By default, all containers have the IPC namespace enabled.

デフォルトでは、全てのコンテナが有功な IPC 名前空間を持っています。

.. IPC (POSIX/SysV IPC) namespace provides separation of named shared memory segments, semaphores and message queues.

IPC (POSIX/SysV IPC) 名前空間は、共有メモリ・セグメント、セマフォ、メッセージ・キューとよばれる分離を提供します。

.. Shared memory segments are used to accelerate inter-process communication at memory speed, rather than through pipes or through the network stack. Shared memory is commonly used by databases and custom-built (typically C/OpenMPI, C++/using boost libraries) high performance applications for scientific computing and financial services industries. If these types of applications are broken into multiple containers, you might need to share the IPC mechanisms of the containers.

プロセス間通信はネットワーク・スタックをパイプするか通過するよりも、共有メモリ・セグメントはメモリの速度まで加速します。共有メモリとは、一般的にデータベースや、科学計算や緊急サービス産業向けの高性能アプリケーション向けカスタム・ビルド（典型的なのは、C/OpenMPI、C++ の高速化ライブラリ）に用いられます。この種のアプリケーションが複数のコンテナに分割される場合は、コンテナの IPC 機構を使って共有する必要があるでしょう。

.. Network settings

.. _network-settings:

ネットワーク設定
====================

.. code-block:: bash

   --dns=[]         : Set custom dns servers for the container
   --net="bridge"   : Connects a container to a network
                       'bridge': creates a new network stack for the container on the docker bridge
                       'none': no networking for this container
                       'container:<name|id>': reuses another container network stack
                       'host': use the host network stack inside the container
                       'NETWORK': connects the container to user-created network using `docker network create` command
   --add-host=""    : Add a line to /etc/hosts (host:IP)
   --mac-address="" : Sets the container's Ethernet device's MAC address

.. By default, all containers have networking enabled and they can make any outgoing connections. The operator can completely disable networking with docker run --net none which disables all incoming and outgoing networking. In cases like this, you would perform I/O through files or STDIN and STDOUT only.

デフォルトでは、全てのコンテナはネットワーク機能を持っており、外部に対する接続を可能とします。オペレータはネットワークを無効化したいのであれば ``docker run --net=none`` を指定することで、内側と外側の両方のネットワーク機能を無効化します。このような指定をすると、 I/O 処理はファイルに対してか、 ``STDIN`` と ``STDOUT`` のみになります。
