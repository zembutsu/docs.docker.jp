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

.. Publishing ports and linking to other containers only works with the the default (bridge). The linking feature is a legacy feature. You should always prefer using Docker network drivers over linking.

公開用のポートを他のコンテナとリンクできるのは、デフォルト（ブリッジ）のみです。リンク機能はレガシー（過去の）機能です。リンク機能を使うよりも、常に Docker ネットワーク機能を使うべきです。

.. Your container will use the same DNS servers as the host by default, but you can override this with --dns.

コンテナは、デフォルトではホストと同じ DNS サーバを使いますが、 ``--dns`` で上書きできます。

.. By default, the MAC address is generated using the IP address allocated to the container. You can set the container’s MAC address explicitly by providing a MAC address via the --mac-address parameter (format:12:34:56:78:9a:bc).

デフォルトでは、コンテナに割り当てられる IP アドレスを使って、Mac アドレスが生成されます。コンテナの Mac アドレスの指定は、 ``--mac-address`` パラメータ（書式： ``12:34:56:78:9a:bc`` ）を使い MAC アドレスを指定できます。

.. Supported networks :

サポートしているネットワーク：

.. Network 	Description
.. none 	No networking in the container.
.. bridge (default) 	Connect the container to the bridge via veth interfaces.
.. host 	Use the host's network stack inside the container.
.. container:<name|id> 	Use the network stack of another container, specified via its *name* or *id*.
.. NETWORK 	Connects the container to a user created network (using `docker network create` command)

.. list-table::
   :header-rows: 1

   * - ネットワーク
     - 説明
   * - **none**
     - コンテナにネットワーク機能を持たせません。
   * - **bridge** （デフォルト）
     - コンテナを各インターフェースに接続します。
   * - **host**
     - コンテナ内でホスト側のネットワーク・スタックを使います。
   * - **container:** <名前|id>
     - 他のコンテナ名か ID を指定し、そのネットワーク・スタックを使います。
   * - **NETWORK**
     - ユーザが作成したネットワーク（ ``docker network create`` コマンドを使用 ）にコンテナを接続します。

.. Network: none

.. _network-none:

ネットワーク：none
--------------------

.. With the network is none a container will not have access to any external routes. The container will still have a loopback interface enabled in the container but it does not have any routes to external traffic.

コンテナのネットワークを ``none`` に指定すると、外部の経路に対してアクセスできなくなくなります。それでもコンテナは ``loopback`` インターフェースが有効なものの、外部のトラフィックに対する経路がありません。

.. Network: bridge

.. _network-bridge:

ネットワーク：bridge
--------------------

.. With the network set to bridge a container will use docker’s default networking setup. A bridge is setup on the host, commonly named docker0, and a pair of veth interfaces will be created for the container. One side of the veth pair will remain on the host attached to the bridge while the other side of the pair will be placed inside the container’s namespaces in addition to the loopback interface. An IP address will be allocated for containers on the bridge’s network and traffic will be routed though this bridge to the container.

コンテナのネットワークを ``bridge`` に指定すると、コンテナは Docker のデフォルト・ネットワーク機能をセットアップします。ブリッジはホスト上で設定されるもので、通常は ``docker0`` と名前が付けられます。そして、 ``veth`` インターフェースのペアがコンテナ用に作成されます。 ``veth`` ペアの片方はホスト側にアタッチされたままとなります。もう一方は、コンテナの名前空間の中で ``loopback`` インターフェースに加えて追加されます。ブリッジ・ネットワーク上で IP アドレスがコンテナに割り当てられ、コンテナに対するトラフィックはこのブリッジを経由します。

.. Containers can communicate via their IP addresses by default. To communicate by name, they must be linked.

デフォルトでは、コンテナは各々の IP アドレスを経由して通信できます。コンテナ名で通信するには、リンクする必要があります。

.. Network: host

.. _network-host:

ネットワーク：host
--------------------

.. With the network set to host a container will share the host’s network stack and all interfaces from the host will be available to the container. The container’s hostname will match the hostname on the host system. Note that --add-host --hostname --dns --dns-search --dns-opt and --mac-address are invalid in host netmode.

``host`` ネットワークをコンテナに設定すると、ホスト側のネットワーク・スタックと、全てのホスト上のインターフェースがコンテナ上でも共有できます。コンテナのホスト名はホストシステム上のホスト名と一致します。 ``host`` ネットワーク・モードでは、 ``--add-host`` 、 ``--hostname`` 、 ``--dns`` 、 ``--dns-search`` 、 ``--dns-opt`` 、 ``--mac-address`` が無効になるのでご注意ください。

.. Compared to the default bridge mode, the host mode gives significantly better networking performance since it uses the host’s native networking stack whereas the bridge has to go through one level of virtualization through the docker daemon. It is recommended to run containers in this mode when their networking performance is critical, for example, a production Load Balancer or a High Performance Web Server.

デフォルトの ``bridge`` モードと比較すると、 ``host`` モードは *著しく* ネットワーク性能が良いです。これは、bridge の場合は docker デーモンの仮想化レベルを通過しているのに対して、host の場合はネイティブなネットワーク・スタックを用いるからです。例えば、プロダクションのロードバランサや高性能のウェブサーバのような、ネットワーク性能がクリティカルな環境では、このモードでのコンテナ動作を推奨します。

..     Note: --net="host" gives the container full access to local system services such as D-bus and is therefore considered insecure.

.. note::

   ``--net="host"`` を指定すると、コンテナは D-bus のようなローカル・システム・サービスに対してフルアクセスできるので、安全ではないと考えられます。

.. Network: container

.. _network-container:

ネットワーク：container
------------------------------

.. With the network set to container a container will share the network stack of another container. The other container’s name must be provided in the format of --net container:<name|id>. Note that --add-host --hostname --dns --dns-search --dns-opt and --mac-address are invalid in container netmode, and --publish --publish-all --expose are also invalid in container netmode.

``container`` ネットワークをコンテナにセットすると、他のコンテナのネットワーク・スタックを共有します。他のコンテナ名は ``--net container:<名前|id>`` の書式で指定する必要があります。 ``container`` ネットワーク・モードでは、 ``--add-host`` 、 ``--hostname`` 、 ``--dns`` 、 ``--dns-search`` 、 ``--dns-opt`` 、 ``--mac-address`` が無効になるだけでなく、 ``--publish`` 、 ``--publish-all`` 、 ``--expose`` も無効になるのでご注意ください。

.. Example running a Redis container with Redis binding to localhost then running the redis-cli command and connecting to the Redis server over the localhost interface.

例として、Redis コンテナで Redis が ``localhost`` をバインドしているとき、 ``localhost`` インターフェースを通して Redis サーバに ``redis-cli`` コマンドを実行して接続します。

.. code-block:: bash

   $ docker run -d --name redis example/redis --bind 127.0.0.1
   $ # redis コンテナのネットワーク・スタックにある localhost にアクセスします
   $ docker run --rm -it --net container:redis example/redis-cli -h 127.0.0.1

.. User-defined network

.. _user-defined-network:

ユーザ定義ネットワーク
------------------------------

.. You can create a network using a Docker network driver or an external network driver plugin. You can connect multiple containers to the same network. Once connected to a user-defined network, the containers can communicate easily using only another container’s IP address or name.

ネットワークを作成するには、Docker ネットワーク・ドライバか外部のネットワーク・ドライバ・プラグインを使います。同じネットワークに対して、複数のコンテナが接続できます。ユーザ定義ネットワークに接続すると、コンテナはコンテナの名前や IP アドレスを使い、簡単に通信できるようになります。

.. For overlay networks or custom plugins that support multi-host connectivity, containers connected to the same multi-host network but launched from different Engines can also communicate in this way.

``overlay`` ネットワークやカスタム・プラグインは、複数のホストへの接続性をサポートしています。コンテナが同一のマルチホスト・ネットワークに接続していれば、別々のエンジンで起動していても、このネットワークを通して通信可能です。

.. The following example creates a network using the built-in bridge network driver and running a container in the created network

以下の例は、内蔵の ``bridge`` ネットワーク・ドライバを使ってネットワークを作成し、作成したネットワーク上でコンテナを実行します。

.. code-block:: bash

   $ docker network create -d overlay my-net
   $ docker run --net=my-net -itd --name=container3 busybox

.. Managing /etc/hosts

.. _managing-etc-hosts:

/etc/hosts の管理
--------------------

.. Your container will have lines in /etc/hosts which define the hostname of the container itself as well as localhost and a few other common things. The --add-host flag can be used to add additional lines to /etc/hosts.

``/etc/hosts`` には ``localhost`` や一般的な項目と同じように、自分が定義したコンテナのホスト名が追加されます。 ``--add-host`` フラグを使うことで、 ``/etc/hosts`` に行を追加できます。

.. code-block:: bash

   $ docker run -it --add-host db-static:86.75.30.9 ubuntu cat /etc/hosts
   172.17.0.22     09d03f76bf2c
   fe00::0         ip6-localnet
   ff00::0         ip6-mcastprefix
   ff02::1         ip6-allnodes
   ff02::2         ip6-allrouters
   127.0.0.1       localhost
   ::1             localhost ip6-localhost ip6-loopback
   86.75.30.9      db-static

.. If a container is connected to the default bridge network and linked with other containers, then the container’s /etc/hosts file is updated with the linked container’s name.

コンテナがデフォルト・ブリッジ・ネットワークに接続し、他のコンテナと ``link`` （リンク）すると、コンテナの ``/etc/hosts`` ファイルが更新され、リンクされたコンテナ名が書き込まれます。

.. If the container is connected to user-defined network, the container’s /etc/hosts file is updated with names of all other containers in that user-defined network.

もしもコンテナがユーザ定義ネットワークに接続した場合は、コンテナの ``/etc/hosts`` ファイルが更新され、ユーザ定義ネットワーク上の他のコンテナ名が書き込まれます。

..    Note Since Docker may live update the container’s /etc/hosts file, there may be situations when processes inside the container can end up reading an empty or incomplete /etc/hosts file. In most cases, retrying the read again should fix the problem.

.. note::

   Docker がコンテナの ``/etc/hosts`` ファイルをリアルタイムに更新するかもしれません。そのため、コンテナ内のプロセスが ``/etc/hosts`` ファイルを読み込もうとしても空だったり、あるいは最後まで読み込めない場合が有り得ます。殆どの場合、再度読み込もうとすることで、問題を解決するでしょう。

.. Restart policies (–restart)

.. _restart-policies-restart:

再起動ポリシー（--restart）
==============================

.. Using the --restart flag on Docker run you can specify a restart policy for how a container should or should not be restarted on exit.

Docker で実行時に ``--restart`` フラグを使うことで、再起動ポリシーを指定できます。再起動ポリシーとは、コンテナが終了したときに再起動すべきかどうかを定義します。

.. When a restart policy is active on a container, it will be shown as either Up or Restarting in docker ps. It can also be useful to use docker events to see the restart policy in effect.

コンテナの再起動ポリシーが有効な場合、 ``docker ps`` でコンテナを見ると、常に ``Up`` か ``Restarting`` のどちらかです。また、再起動ポリシーが有効かどうかを確認するため、 ``docker events`` を使うのも便利です。

.. Docker supports the following restart policies:

Docker は以下の再起動ポリシーをサポートしています。

.. Policy 	Result
.. no 	Do not automatically restart the container when it exits. This is the default.
.. on-failure[:max-retries] 	Restart only if the container exits with a non-zero exit status. Optionally, limit the number of restart retries the Docker daemon attempts.
.. always 	Always restart the container regardless of the exit status. When you specify always, the Docker daemon will try to restart the container indefinitely. The container will also always start on daemon startup, regardless of the current state of the container.
.. unless-stopped 	Always restart the container regardless of the exit status, but do not start it on daemon startup if the container has been put to a stopped state before.

.. list-table::
   :header-rows: 1
   
   * - ポリシー
     - 結果
   * - **no** （なし）
     - コンテナが終了しても、自動的には再起動しません。これがデフォルトです。
   * - **on-failure** [:最大リトライ数]
     - コンテナが 0 以外の終了コードで停止したら再起動します。オプションで Docker デーモンが何度再起動を試みるかを指定できます。
   * - **always** （常に）
     - コンテナの終了コードに拘わらず、常にコンテナの再起動を試みます。Docker デーモンは無制限に再起動を試みます。また、デーモンの起動時にも、コンテナの状況に拘わらず常に起動を試みます。
   * - **unless-stopped** （停止していない場合）
     - コンテナの終了コードに拘わらず、常にコンテナの再起動を試みます。しかし、直近のコンテナが停止状態であったのであれば、デーモンの起動時にコンテナを開始しません。

.. An ever increasing delay (double the previous delay, starting at 100 milliseconds) is added before each restart to prevent flooding the server. This means the daemon will wait for 100 ms, then 200 ms, 400, 800, 1600, and so on until either the on-failure limit is hit, or when you docker stop or docker rm -f the container.

サーバが溢れかえるのを防ぐため、再起動の前に遅延時間が追加されます（遅延は100ミリ秒から開始し、直前の値の２倍になります）。つまり、デーモンは100ミリ秒待った後は、200ミリ秒、400、800、1600…と ``on-failure`` 上限に到達するか、あるいは、コンテナを ``docker stop`` で停止するか、 ``docker rm -f`` で強制削除するまで続けます。

.. If a container is successfully restarted (the container is started and runs for at least 10 seconds), the delay is reset to its default value of 100 ms.

コンテナの再起動が成功すると（コンテナは少なくとも10秒以内で起動します）、遅延時間の値は再び 100 ミリ秒にリセットされます。

.. You can specify the maximum amount of times Docker will try to restart the container when using the on-failure policy. The default is that Docker will try forever to restart the container. The number of (attempted) restarts for a container can be obtained via docker inspect. For example, to get the number of restarts for container “my-container”;

**on-failure** ポリシーを使うことで、Docker がコンテナの再起動を試みる最大回数を指定できます。デフォルトでは、Docker はコンテナを永久に再起動し続けます。コンテナの再起動（を試みる）回数は ``docker inspect`` で確認可能です。たとえば、コンテナ「my-container」の再起動数を取得するには、次のようにします。

.. code-block:: bash

   $ docker inspect -f "{{ .RestartCount }}" my-container
   # 2

.. Or, to get the last time the container was (re)started;

あるいは、コンテナが（再）起動した時刻を知るには、次のようにします。

.. code-block:: bash

   $ docker inspect -f "{{ .State.StartedAt }}" my-container
   # 2015-03-04T23:47:07.691840179Z

.. You cannot set any restart policy in combination with “clean up (–rm)”. Setting both --restart and --rm results in an error.

再起動ポリシーと :ref:`クリーンアップ <clean-up-rm>` は同時に指定できません。 ``--restart`` と ``--rm`` を同時に指定してもエラーになります。

.. Examples

.. _restart-examples:

例
^^^^^^^^^^

.. code-block:: bash

   $ docker run --restart=always redis

.. This will run the redis container with a restart policy of always so that if the container exits, Docker will restart it.

こちらの例は、 **常に (always)** 再起動するポリシーで ``redis`` コンテナを実行しているので、停止すると Docker は再起動します。

.. code-block:: bash

   $ docker run --restart=on-failure:10 redis

.. This will run the redis container with a restart policy of on-failure and a maximum restart count of 10. If the redis container exits with a non-zero exit status more than 10 times in a row Docker will abort trying to restart the container. Providing a maximum restart limit is only valid for the on-failure policy.

こちらの例は、 **失敗したら (on-failure)** 10回カウントするまで再起動を行うポリシーで ``redis`` コンテナを起動しています。もし ``redis`` コンテナが 0 以外の状態で終了すると、Docker はコンテナの再起動を１０回続けて試みます。再起動の上限を設定できるのは、 **on-failure** ポリシーを有効にした場合のみです。

.. Clean up (–rm)

.. _clean-up-rm:

クリーンアップ（--rm）
----------------------

.. By default a container’s file system persists even after the container exits. This makes debugging a lot easier (since you can inspect the final state) and you retain all your data by default. But if you are running short-term foreground processes, these container file systems can really pile up. If instead you’d like Docker to automatically clean up the container and remove the file system when the container exits, you can add the --rm flag:

デフォルトではコンテナを終了しても、コンテナのファイルシステム（の内容）を保持し続けます。これにより、多くのデバッグをより簡単にし（最後の状態を確認できるので）、そして、全てのデータを維持し続けるのがデフォルトです。しかし、短い期間だけ **フォアグラウンド** で動かしたとしても、これらのコンテナのファイルシステムが溜まり続けます。そうではなく、 **コンテナが終了した時に、自動的にコンテナをクリーンアップし、ファイルシステムを削除する** には ``--rm`` フラグを追加します。

.. code-block:: bash

   --rm=false: Automatically remove the container when it exits (incompatible with -d)

..     Note: When you set the --rm flag, Docker also removes the volumes associated with the container when the container is removed. This is similar to running docker rm -v my-container.

.. note::

   ``--rm`` フラグを設定すると、コンテナの削除時、関連するボリュームも削除されます。これは ``docker rm -v my-container`` を実行するのと同様です。

.. Security configuration

.. _security-configuration:

セキュリティ設定
====================

.. code-block:: bash

   --security-opt="label:user:USER"   : Set the label user for the container
   --security-opt="label:role:ROLE"   : Set the label role for the container
   --security-opt="label:type:TYPE"   : Set the label type for the container
   --security-opt="label:level:LEVEL" : Set the label level for the container
   --security-opt="label:disable"     : Turn off label confinement for the container
   --security-opt="apparmor:PROFILE"  : Set the apparmor profile to be applied
                                        to the container

.. You can override the default labeling scheme for each container by specifying the --security-opt flag. For example, you can specify the MCS/MLS level, a requirement for MLS systems. Specifying the level in the following command allows you to share the same content between containers.

各コンテナに対するデフォルトのラベリング・スキーマ（labeling scheme）は ``--security-opt`` フラグを指定することで上書き可能です。たとえば、MCS/MLS レベルを指定するには MLS システムが必要です。コンテナ間で同じ内容を共有できるようにレベルを指定するには、次のようにコマンドを実行します。

.. code-block:: bash

   $ docker run --security-opt label:level:s0:c100,c200 -i -t fedora bash

. .An MLS example might be:

MLS であれば、次のような例になります。

.. code-block:: bash

   $ docker run --security-opt label:level:TopSecret -i -t rhel7 bash

.. To disable the security labeling for this container versus running with the --permissive flag, use the following command:

コンテナに対するセキュリティ・ラベリングを無効化するには、 ``--permissive`` フラグを使い、次のように指定します。

.. code-block:: bash

   $ docker run --security-opt label:disable -i -t fedora bash

.. If you want a tighter security policy on the processes within a container, you can specify an alternate type for the container. You could run a container that is only allowed to listen on Apache ports by executing the following command:

コンテナ内のプロセスに対して、何らかのセキュリティ・ポリシーを適用するには、コンテナに対して何らかのタイプを指定します。コンテナを実行する時、Apache のポートのみがリッスンできるようにするには、次のように実行します。

.. $ docker run --security-opt label:type:svirt_apache_t -i -t centos bash

..    Note: You would have to write policy defining a svirt_apache_t type.

.. note::

   ここでは ``svirt_apache_t`` タイプ に対する書き込みポリシーがあるものと想定しています。
