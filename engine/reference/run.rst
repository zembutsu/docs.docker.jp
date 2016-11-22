.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/run/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/run.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/run.md
.. check date: 2016/06/14
.. Commits on Jun 14, 2016 e6e8c4d700c4510e463eb16fedba51b6e8a3ccd6
.. -------------------------------------------------------------------

.. Docker run reference

.. _docker-run-reference:

========================================
Docker run リファレンス
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Docker runs processes in isolated containers. A container is a process which runs on a host. The host may be local or remote. When an operator executes docker run, the container process that runs is isolated in that it has its own file system, its own networking, and its own isolated process tree separate from the host.

Docker は隔離（独立）したコンテナでプロセスを実行します。コンテナはホスト上で動くプロセスです。ホストとはローカルまたはリモートの環境です。作業者が ``docker run`` を実行したら、コンテナのプロセスを隔離（独立）して実行します。コンテナは自身ファイルシステムとネットワークを持ち、ホスト上の他のプロセス・ツリーからは隔離されて（独立して）います。

.. This page details how to use the docker run command to define the container’s resources at runtime.

このページではコンテナ実行時にリソースを指定できるよう、 ``docker run`` コマンドの使い方の詳細を説明します。

.. General form

.. _run-general-form:

一般的な形式
====================

.. The basic docker run command takes this form:

基本的な ``docker run`` コマンドの形式は、次の通りです。

.. code-block:: bash

   $ docker run [オプション] イメージ[:タグ|@ダイジェスト値] [コマンド] [引数...]

.. The docker run command must specify an IMAGE to derive the container from. An image developer can define image defaults related to:

``docker run`` コマンドは、コンテナ形成の元になる :ref:`イメージ <image>` 指定が必要です。イメージの開発者はイメージに関連するデフォルト値を定義できます。

..    detached or foreground running
    container identification
    network settings
    runtime constraints on CPU and memory
    privileges and LXC configuration

* デタッチドあるいはフォアグラウンドで実行
* コンテナの識別
* ネットワーク設定
* 実行時の CPU とメモリの制限
* 権限と LXC 設定

.. With the docker run [OPTIONS] an operator can add to or override the image defaults set by a developer. And, additionally, operators can override nearly all the defaults set by the Docker runtime itself. The operator’s ability to override image and Docker runtime defaults is why run has more options than any other docker command.

``docker run [オプション]`` の実行時、作業者は設定の追加や、開発者がイメージに指定したデフォルト設定を上書き可能です。そして更に、作業者は Docker の実行時、ほぼ全てのデフォルト設定を上書きできます。 :doc:`run </engine/reference/commandline/run>` コマンドは他の ``docker`` コマンドより多くのオプションがあるため、作業者はイメージと Docker 実行時のデフォルト設定を上書きできます。

.. To learn how to interpret the types of [OPTIONS], see Option types.

様々な種類の ``[オプション]`` を理解するには、 :ref:`オプションの種類 <option-types>` をご覧ください。

..    Note: Depending on your Docker system configuration, you may be required to preface the docker run command with sudo. To avoid having to use sudo with the docker command, your system administrator can create a Unix group called docker and add users to it. For more information about this configuration, refer to the Docker installation documentation for your operating system.

.. note::

   Docker システムの設定によっては、 ``docker run`` コマンドを ``sudo`` で実行する必要があるかもしれません。 ``docker`` コマンドで ``sudo`` を使わないようにするには、システム管理者に ``docker`` という名称のグループの作成と、そこにユーザの追加を依頼してください。この設定に関するより詳しい情報は、各オペレーティング・システム向けのインストール用ドキュメントをご覧ください。

.. Operator exclusive options

.. _operator-exclusive-options:

作業者専用のオプション
==============================

.. Only the operator (the person executing docker run) can set the following options.

作業者（ ``docker run`` の実行者 ）のみ、以下のオプションを設定できます。

..    Detached vs foreground
        Detached (-d)
        Foreground
    Container identification
        Name (--name)
        PID equivalent
    IPC settings (--ipc)
    Network settings
    Restart policies (--restart)
    Clean up (--rm)
    Runtime constraints on resources
    Runtime privilege, Linux capabilities, and LXC configuration

* :ref:`デタッチドかフォアグラウンド <detached-vs-foreground>`

 * :ref:`デタッチド(-d) <detached-d>` 
 * :ref:`フォアグラウンド <foreground>`

* :ref:`コンテナの識別 <container-identification>`

 * :ref:`名前 <name-name>`
 * :ref:`PID に相当 <pid-equivalent>`

* :ref:`IPC 設定 <ipc-settings-ipc>`
* :ref:`ネットワーク設定 <network-settings>`
* :ref:`再起動ポリシー <restart-policies-restart>`
* :ref:`クリーンアップ <clean-up-rm>`
* :ref:`実行時のリソース制限 <runtime-constraints-on-resources>`
* :ref:`実行時の権限、Linux 機能、LXC 設定 <runtime-privilege-linux-capabilities-and-lxc-configuration>`

.. Detached vs foreground

.. _detached-vs-foreground:

デタッチドまたはフォアグラウンド
========================================

.. When starting a Docker container, you must first decide if you want to run the container in the background in a “detached” mode or in the default foreground mode:

Docker コンテナの起動時に、まず、コンテナをバックグラウンドで「デタッチド」モード（detached mode）で実行するか、デフォルトのフォアグラウンド・モード（foreground mode）で実行するかを決める必要があります。

.. code-block:: bash

   -d=false: Detached mode: Run container in the background, print new container id

.. Detached (-d)

.. _detached-d:

デタッチド (-d)
--------------------

.. To start a container in detached mode, you use -d=true or just -d option. By design, containers started in detached mode exit when the root process used to run the container exits. A container in detached mode cannot be automatically removed when it stops, this means you cannot use the --rm option with -d option.

コンテナをデタッチド・モードで起動するには、 ``-d=true`` か ``-d`` オプションを使います。設計上、コンテナが実行するルート・プロセスが終了したら、デタッチド・モードで起動したコンテナも終了します。デタッチド・モードのコンテナは停止しても自動的に削除できません。つまり ``-d`` オプションでは ``--rm`` を指定できません。

.. Do not pass a service x start command to a detached container. For example, this command attempts to start the nginx service.

デタッチドのコンテナでは ``service x start`` コマンドを受け付けません。例えば、次のコマンドは ``nginx`` サービスの起動を試みます。

.. code-block:: bash

   $ docker run -d -p 80:80 my_image service nginx start

.. This succeeds in starting the nginx service inside the container. However, it fails the detached container paradigm in that, the root process (service nginx start) returns and the detached container stops as designed. As a result, the nginx service is started but could not be used. Instead, to start a process such as the nginx web server do the following:

コンテナ内で ``nginx`` サービスの起動は成功します。しかしながら、デタッチド・コンテナの枠組み内では処理に失敗します。これはルート・プロセス（ ``service nginx start`` ）が終了するため、デタッチド・コンテナは停止されます。その結果、 ``nginx`` サービスは実行しますが、実行を継続できません。この方法を使わず  ``nginx``  ウェブ・サーバのプロセスを実行するには、次のようにします。

.. code-block:: bash

   $ docker run -d -p 80:80 my_image nginx -g 'daemon off;'

.. To do input/output with a detached container use network connections or shared volumes. These are required because the container is no longer listening to the command line where docker run was run.

コンテナの入出力はネットワーク接続や共有ボリュームも扱えます。コマンドラインで ``docker run`` を実行し終わった後でも、必要になる場合があるでしょう。

.. To reattach to a detached container, use docker attach command.

デタッチド・コンテナに再度アタッチ（接続）するには、 ``docker`` :doc:`attach </engine/reference/commandline/attach>` コマンドを使います。

.. Foreground

.. _foreground:

フォアグラウンド
--------------------

.. In foreground mode (the default when -d is not specified), docker run can start the process in the container and attach the console to the process’s standard input, output, and standard error. It can even pretend to be a TTY (this is what most command line executables expect) and pass along signals. All of that is configurable:

フォアグラウンド・モード（ ``-d`` を指定しないデフォルト ）の場合、 ``docker run`` はコンテナの中でプロセスを開始し、プロセスの標準入出力・標準エラーをコンソールにアタッチします。これは TTY の振りをするだけでなく（TTY は大部分のコマンド・ラインで実行可能なものと想定しています）、シグナルも渡せます。

.. code-block:: bash

   -a=[]           : Attach to `STDIN`, `STDOUT` and/or `STDERR`
   -t=false        : Allocate a pseudo-tty
   --sig-proxy=true: Proxify all received signal to the process (non-TTY mode only)
   -i=false        : Keep STDIN open even if not attached

.. If you do not specify -a then Docker will attach all standard streams. You can specify to which of the three standard streams (STDIN, STDOUT, STDERR) you’d like to connect instead, as in:

Docker で ``-a`` を指定しなければ、Docker は `自動的に全ての標準ストリームをアタッチ <https://github.com/docker/docker/blob/75a7f4d90cde0295bcfb7213004abce8d4779b75/commands.go#L1797>`_ します。３つの標準ストリーム（ ``STDIN`` 、 ``STDOUT`` 、 ``STDERR`` ）のうち、特定のものに対してのみ接続も可能です。

.. code-block:: bash

   $ docker run -a stdin -a stdout -i -t ubuntu /bin/bash

.. For interactive processes (like a shell), you must use -i -t together in order to allocate a tty for the container process. -i -t is often written -it as you’ll see in later examples. Specifying -t is forbidden when the client standard output is redirected or piped, such as in: echo test | docker run -i busybox cat.

（シェルのような）インタラクティブなプロセスでは、コンテナのプロセスに対して tty を割り当てるために、 ``-i -t`` を一緒に使う必要があります。 後の例で出てきますが ``-i -t`` は ``-it`` と書けます。 クライアント側の標準出力を ``echo test | docker run -i busybox cat`` のようにリダイレクトやパイプする場合 ``-t`` は指定できません。

..     Note: A process running as PID 1 inside a container is treated specially by Linux: it ignores any signal with the default action. So, the process will not terminate on SIGINT or SIGTERM unless it is coded to do so.

.. note::

   コンテナ内で PID 1 として実行しているプロセスは、Linux が特別に扱います。デフォルトの操作では、あらゆるシグナルを無視します。そのため、プロセスは ``SIGINT`` か ``SIGTERM`` で停止するようにコードを書かない限り、停止できません。

.. Container identification

.. _container-identification:

コンテナの識別
====================

.. Name (--name)

.. _name-name:

名前（--name）
--------------------

.. The operator can identify a container in three ways:

作業者はコンテナを３つの方法で識別できます。

..    UUID long identifier (“f78375b1c487e03c9438c729345e54db9d20cfa2ac1fc3494b6eb60872e74778”)
    UUID short identifier (“f78375b1c487”)
    Name (“evil_ptolemy”)

* 長い（ロング） UUID 識別子（"f78375b1c487e03c9438c729345e54db9d20cfa2ac1fc3494b6eb60872e74778"）
* 短い（ショート）UUID 識別子（"f78375b1c487"）
* 名前（"evil_ptolemy"）

.. The UUID identifiers come from the Docker daemon. If you do not assign a container name with the --name option, then the daemon generates a random string name for you. Defining a name can be a handy way to add meaning to a container. If you specify a name, you can use it when referencing the container within a Docker network. This works for both background and foreground Docker containers.

UUID 識別子は Docker デーモンから与えられます。コンテナの名前を ``--name`` オプションで割り当てなければ、デーモンはランダムな文字列から名前を生成します。コンテナに対する目的を表すには、 ``name`` の定義が簡単でしょう。 ``name`` を指定したら、これを Docker ネットワーク内でコンテナを参照用に使えます。この参照機能は、バックグラウンドでもフォアグラウンドどちらの Docker コンテナでも動作します。

.. Note: Containers on the default bridge network must be linked to communicate by name.

.. note::

   デフォルトのブリッジ・ネットワーク内にあるコンテナの場合は、相互に名前で通信するにはリンクする必要があります。

.. PID equivalent

.. _pid-equivalent:

PID 相当の機能
--------------------

.. Finally, to help with automation, you can have Docker write the container ID out to a file of your choosing. This is similar to how some programs might write out their process ID to a file (you’ve seen them as PID files):

あとは、自動処理を簡単にするため、Docker は任意に選択したファイルに対してコンテナ ID を書き出せます。これは、プログラムがプロセス ID をファイルに書き出す（いわゆる PID ファイルです）のに似ています。

.. code-block:: bash

   --cidfile="": コンテナの ID をファイルに書き出す

.. Image[:tag]

.. _image-tag:

イメージ[:タグ]
--------------------

.. While not strictly a means of identifying a container, you can specify a version of an image you’d like to run the container with by adding image[:tag] to the command. For example, docker run ubuntu:14.04.

コンテナ実行時のコマンドで ``イメージ[:タグ]`` を追加すると、イメージのバージョンを厳密に指定できます。例えば ``docker run ubuntu:14.04`` と実行します。


.. Image[@digest]

.. _image-digest:

イメージ[@ダイジェスト値]
------------------------------

.. Images using the v2 or later image format have a content-addressable identifier called a digest. As long as the input used to generate the image is unchanged, the digest value is predictable and referenceable.

イメージ・形式 v2 以降のイメージを使えば、その中にダイジェスト値（digest）と呼ばれる識別子が、内容に対して割り当てられています。入力に使われたイメージファイルに対する変更が無ければ、ダイジェスト値とは予想されうる値であり、参照可能なものです。

.. The following example runs a container from the `alpine` image with the  `sha256:9cacb71397b640eca97488cf08582ae4e4068513101088e9f96c9814bfda95e0` digest:

次の例は ``sha256:9cacb71397b640eca97488cf08582ae4e4068513101088e9f96c9814bfda95e0`` ダイジェスト値の ``alpine`` イメージを使い、コンテナを実行する例です。

.. code-block:: bash

   $ docker run alpine@sha256:9cacb71397b640eca97488cf08582ae4e4068513101088e9f96c9814bfda95e0 date

.. PID settings (--pid)

.. _pid-settings-pid:

PID 設定（--pid）
====================

..   --pid=""  : Set the PID (Process) Namespace mode for the container,
..          'host': use the host's PID namespace inside the container

.. code-block:: bash

   --pid=""  : コンテナに対する PID （プロセス）名前空間モードを指定
               'container:<名前|id>': 他のコンテナの PID 名前空間に参加
               'host': コンテナ内でホスト側の PID 名前空間を使う

.. By default, all containers have the PID namespace enabled.

デフォルトでは、全てのコンテナは有効な PID 名前空間を持っています。

.. PID namespace provides separation of processes. The PID Namespace removes the view of the system processes, and allows process ids to be reused including pid 1.

PID 名前空間はプロセスの分離をもたらします。PID 名前空間はシステム・プロセスを見えないようにし、PID 1 を含むプロセス ID を再利用できるようにします。

.. In certain cases you want your container to share the host’s process namespace, basically allowing processes within the container to see all of the processes on the system. For example, you could build a container with debugging tools like strace or gdb, but want to use these tools when debugging processes within the container.

コンテナがホスト上の特定のプロセス名前空間を共有する場合は、コンテナ内のプロセスが、システム上の全プロセスを基本的に見られるようにします。例えば、 ``strace`` や ``gdb`` のようなデバッグ用ツールを含むコンテナを構築した時、コンテナ内のデバッグ用プロセスのみツールを使えるように指定する場合です。

.. Example: run htop inside a container

例：コンテナ内で htop を実行
------------------------------

.. Create this Dockerfile:

Dockerfile を作成します：

.. code-block:: dockerfile

   FROM alpine:latest
   RUN apk add --update htop && rm -rf /var/cache/apk/*
   CMD ["htop"]

.. Build the Dockerfile and tag the image as myhtop:

Dockerfile を構築し、イメージに ``myhtop`` とタグ付け：

.. code-block:: bash

   $ docker build -t myhtop .

.. Use the following command to run htop inside a container:

次のコマンドを使いコンテナ内で ``htop`` を実行：

.. code-block:: bash

   $ docker run -it --rm --pid=host myhtop

.. Joining another container's pid namespace can be used for debugging that container.

他コンテナの pid 名前空間に参加するのは、コンテナのデバッグ用に便利です。

.. Example

例
----------

.. Start a container running a redis server:

redis サーバが動くコンテナを起動します：

.. code-block:: bash

   $ docker run --name my-redis -d redis

.. Debug the redis container by running another container that has strace in it:

redis コンテナのデバッグに、strace が入っている他のコンテナを実行。

.. code-block:: bash

   $ docker run --it --pid=container:my-redis bash
   $ strace -p 1


.. UTS settings (--uts)

.. _uts-settings-uts:

UTS 設定（--uts）
====================

..   --uts=""  : Set the UTS namespace mode for the container,
..          'host': use the host's UTS namespace inside the container


.. code-block:: bash

   --uts=""  : UTS 名前空間モードをコンテナに設定する
          'host': コンテナ内でホストの UTS 名前空間を使用

.. The UTS namespace is for setting the hostname and the domain that is visible to running processes in that namespace. By default, all containers, including those with --net=host, have their own UTS namespace. The host setting will result in the container using the same UTS namespace as the host.

.. UTS 名前空間とは、プロセスを実行する名前空間上で見えるホスト名とドメイン名を設定するものです。デフォルトでは、全てのコンテナは ``--uts=host`` の指定により、自身の UTS 名前空間を持っています。 ``host`` には、ホスト名として同じ UTS 名前空間をコンテナで使えるよう設定します。


.. The UTS namespace is for setting the hostname and the domain that is visible to running processes in that namespace. By default, all containers, including those with --net=host, have their own UTS namespace. The host setting will result in the container using the same UTS namespace as the host. Note that --hostname is invalid in host UTS mode.

UTS 名前空間とは、プロセスを実行する名前空間上で見えるホスト名とドメイン名を設定するものです。デフォルトでは、全てのコンテナは ``--uts=host`` の指定により、自身の UTS 名前空間を持っています。  ``host`` には、ホスト名として同じ UTS 名前空間をコンテナで使えるよう設定します。なお、 ``host`` UTS モードでは ``--hostname`` の指定ができないため、ご注意ください。

.. You may wish to share the UTS namespace with the host if you would like the hostname of the container to change as the hostname of the host changes. A more advanced use case would be changing the host’s hostname from a container.

ホスト上と UTS 名前空間を共有したい場合もあるでしょう。例えば、コンテナを動かすホストがホスト名を変更してしまい、コンテナのホスト名も変更したい場合です。より高度な使い方としては、コンテナからホスト側のホスト名の変更を行うケースです。

.. IPC settings (--ipc)

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

デフォルトでは、全てのコンテナが有効な IPC 名前空間を持っています。

.. IPC (POSIX/SysV IPC) namespace provides separation of named shared memory segments, semaphores and message queues.

IPC (POSIX/SysV IPC) 名前空間は、共有メモリ・セグメント、セマフォ、メッセージ・キューと呼ばれる分離を提供します。

.. Shared memory segments are used to accelerate inter-process communication at memory speed, rather than through pipes or through the network stack. Shared memory is commonly used by databases and custom-built (typically C/OpenMPI, C++/using boost libraries) high performance applications for scientific computing and financial services industries. If these types of applications are broken into multiple containers, you might need to share the IPC mechanisms of the containers.

プロセス間通信は共有メモリ・セグメントはメモリの速度まで（ネットワーク・スタックをパイプするか通過するよりも速く加速）します。共有メモリとは、一般的にデータベースや、科学計算や緊急サービス産業向けの高性能アプリケーション向けカスタム・ビルド（典型的なのは、C/OpenMPI、C++ の高速化ライブラリ）に用いられます。この種のアプリケーションが複数のコンテナに分割される場合は、コンテナの IPC 機構を使って共有する必要があるでしょう。

.. Network settings

.. _network-settings:

ネットワーク設定
====================

.. code-block:: bash

   --dns=[]         : コンテナ用のカスタム DNS サーバを設定
   --net="bridge"   : コンテナをネットワークに接続
                       'bridge': docker ブリッジ上でコンテナ用に新しいネットワーク・スタックを作成
                       'none': コンテナにネットワーク機能を付けない
                       'container:<name|id>': 他のコンテナ用ネットワーク・スタックを再利用
                       'host': コンテナ内でホスト側ネットワーク・スタックを使用
                       'NETWORK': 「docker network create」コマンドでユーザ作成したネットワークを使用
   --net-alias=[]   : コンテナにネットワーク内部用のエイリアスを追加
   --add-host=""    : /etc/hosts に行を追加（ホスト名:IPアドレス）
   --mac-address="" : コンテナのイーサネット・デバイス Mac アドレスを指定
   --ip=""          : コンテナのイーサネット・デバイスに IPv4 アドレスを指定
   --ip6=""         : コンテナのイーサネット・デバイスに IPv6 アドレスを指定

.. By default, all containers have networking enabled and they can make any outgoing connections. The operator can completely disable networking with docker run --net none which disables all incoming and outgoing networking. In cases like this, you would perform I/O through files or STDIN and STDOUT only.

デフォルトでは、全てのコンテナはネットワーク機能を持っており、外部に対する接続が可能です。作業者がネットワークを無効化したい場合は ``docker run --net=none`` を指定し、内側と外側の両方のネットワーク機能を無効化します。このように指定したら、 I/O 処理はファイルに対してか、 ``STDIN`` と ``STDOUT`` のみになります。

.. Publishing ports and linking to other containers only works with the default (bridge). The linking feature is a legacy feature. You should always prefer using Docker network drivers over linking.

公開用のポートを他のコンテナとリンクできるのは、デフォルト（ブリッジ）のみです。リンク機能はレガシー（過去の）機能です。リンク機能を使うよりも、常に Docker ネットワーク機能を使うべきです。

.. Your container will use the same DNS servers as the host by default, but you can override this with --dns.

コンテナは、デフォルトではホストと同じ DNS サーバを使いますが、 ``--dns`` で上書きできます。

.. By default, the MAC address is generated using the IP address allocated to the container. You can set the container’s MAC address explicitly by providing a MAC address via the --mac-address parameter (format:12:34:56:78:9a:bc). Be aware that Docker does not check if manually specified MAC addresses are unique.

デフォルトでは、コンテナに割り当てられる IP アドレスを使い、MAC アドレスを生成します。コンテナの MAC アドレスの指定は、 ``--mac-address`` パラメータ（書式： ``12:34:56:78:9a:bc`` ）を使い MAC アドレスを指定できます。 Docker は MAC アドレスがユニークかどうか（重複しているかどうか）を確認する仕組みが無いため、ご注意ください。

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

コンテナのネットワークを ``none`` に指定したら、外部の経路に対してアクセス不能にします。コンテナ内では ``loopback`` （ループバック）インターフェースが有効ですが、外部のトラフィックに対する経路が無くなります。

.. Network: bridge

.. _network-bridge:

ネットワーク：bridge
--------------------

.. With the network set to bridge a container will use docker’s default networking setup. A bridge is setup on the host, commonly named docker0, and a pair of veth interfaces will be created for the container. One side of the veth pair will remain on the host attached to the bridge while the other side of the pair will be placed inside the container’s namespaces in addition to the loopback interface. An IP address will be allocated for containers on the bridge’s network and traffic will be routed though this bridge to the container.

コンテナのネットワークを ``bridge`` に指定したら、コンテナは Docker のデフォルト・ネットワーク機能をセットアップします。ブリッジはホスト上で設定されるもので、通常は ``docker0`` と名前が付けられます。そして、 ``veth`` インターフェースのペアがコンテナ用に作成されます。 ``veth`` ペアの片方はホスト側にアタッチされたままとなります。もう一方は、コンテナの名前空間の中で ``loopback`` インターフェースに加えて追加します。ブリッジ・ネットワーク上で IP アドレスがコンテナに割り当てられ、コンテナに対するトラフィックはこのブリッジを経由します。

.. Containers can communicate via their IP addresses by default. To communicate by name, they must be linked.

デフォルトでは、コンテナは各々の IP アドレスを経由して通信できます。コンテナ名で通信するには、リンクする必要があります。

.. Network: host

.. _network-host:

ネットワーク：host
--------------------

.. With the network set to host a container will share the host’s network stack and all interfaces from the host will be available to the container. The container’s hostname will match the hostname on the host system. Note that --mac-address is invalid in host netmode. Even in host network mode a container has its own UTS namespace by default. As such --hostname is allowed in host network mode and will only change the hostname inside the container. Similar to --hostname, the --add-host, --dns, --dns-search, and --dns-opt options can be used in host network mode. These options update /etc/hosts or /etc/resolv.conf inside the container. No change are made to /etc/hosts and /etc/resolv.conf on the host.

``host`` ネットワークをコンテナに設定したら、ホスト側のネットワーク・スタックと、全てのホスト上のインターフェースがコンテナ上でも共有できます。コンテナのホスト名はホストシステム上のホスト名と一致します。 ``host`` ネットワーク・モードでは、  ``--mac-address`` が無効になるのでご注意ください。 たとえ ``host``  ネットワーク・モードだとしても、コンテナは自身の UTS 名前空間をデフォルトで持ちます。そのため、  ``host`` ネットワーク・モードで ``--hostname`` が許可されるのは、コンテナの中でホスト名を変えるだけです。 ``--hostname`` 同様、 ``--add-host`` 、 ``--dns``  、 ``--dns-search``  、 ``--dns-opt`` オプションは ``host`` ネットワーク・モードで利用可能です。これらのオプションはコンテナ内の ``/etc/hosts`` や ``/etc/resolv.conf`` を更新するだけです。ホスト側の ``/etc/hosts`` や ``/etc/resolv.conf`` は変更しません。

.. Compared to the default bridge mode, the host mode gives significantly better networking performance since it uses the host’s native networking stack whereas the bridge has to go through one level of virtualization through the docker daemon. It is recommended to run containers in this mode when their networking performance is critical, for example, a production Load Balancer or a High Performance Web Server.

デフォルトの ``bridge`` モードと比べ、 ``host`` モードは *著しく* ネットワーク性能が優れます。これは、bridge の場合は docker デーモンの仮想化レベルを通過しているのに対して、host の場合はネイティブなネットワーク・スタックを用いるからです。例えば、プロダクションのロードバランサや高性能のウェブサーバのような、ネットワーク性能がクリティカルな環境では、このモードでのコンテナ動作を推奨します。

..     Note: --net="host" gives the container full access to local system services such as D-bus and is therefore considered insecure.

.. note::

   ``--net="host"`` の指定時は、コンテナは D-bus のようなローカル・システム・サービスに対してフルアクセス可能なため、安全ではないと考えられます。

.. Network: container

.. _network-container:

ネットワーク：container
------------------------------

.. With the network set to container a container will share the network stack of another container. The other container’s name must be provided in the format of --net container:<name|id>. Note that --add-host --hostname --dns --dns-search --dns-opt and --mac-address are invalid in container netmode, and --publish --publish-all --expose are also invalid in container netmode.

``container`` ネットワークをコンテナに指定したら、他のコンテナのネットワーク・スタックを共有します。他のコンテナ名は ``--net container:<名前|id>`` の書式で指定する必要があります。 ``container`` ネットワーク・モードでは、 ``--add-host`` 、 ``--hostname`` 、 ``--dns`` 、 ``--dns-search`` 、 ``--dns-opt`` 、 ``--mac-address`` が無効になるだけでなく、 ``--publish`` 、 ``--publish-all`` 、 ``--expose`` も無効になるのでご注意ください。

.. Example running a Redis container with Redis binding to localhost then running the redis-cli command and connecting to the Redis server over the localhost interface.

次の例は、Redis コンテナで Redis が ``localhost`` をバインドしている時、 ``localhost`` インターフェースを通して Redis サーバに ``redis-cli`` コマンドを実行して接続します。

.. code-block:: bash

   $ docker run -d --name redis example/redis --bind 127.0.0.1
   $ # redis コンテナのネットワーク・スタックにある localhost にアクセスします
   $ docker run --rm -it --net container:redis example/redis-cli -h 127.0.0.1

.. User-defined network

.. _user-defined-network:

ユーザ定義ネットワーク
------------------------------

.. You can create a network using a Docker network driver or an external network driver plugin. You can connect multiple containers to the same network. Once connected to a user-defined network, the containers can communicate easily using only another container’s IP address or name.

ネットワークを作成するには、Docker ネットワーク・ドライバか外部のネットワーク・ドライバ・プラグインを使います。同じネットワークに対して、複数のコンテナが接続できます。ユーザ定義ネットワークに接続したら、コンテナはコンテナの名前や IP アドレスを使い、簡単に通信できるようになります。

.. For overlay networks or custom plugins that support multi-host connectivity, containers connected to the same multi-host network but launched from different Engines can also communicate in this way.

``overlay`` ネットワークやカスタム・プラグインは、複数のホストへの接続性をサポートしています。コンテナが同一のマルチホスト・ネットワークに接続していれば、別々のエンジンで起動していても、このネットワークを通して通信可能です。

.. The following example creates a network using the built-in bridge network driver and running a container in the created network

以下の例は、内部 ``bridge`` ネットワーク・ドライバを使ってネットワークを作成し、作成したネットワーク上でコンテナを実行します。

.. code-block:: bash

   $ docker network create -d bridge my-net
   $ docker run --net=my-net -itd --name=container3 busybox

.. Managing /etc/hosts

.. _managing-etc-hosts:

/etc/hosts の管理
--------------------

.. Your container will have lines in /etc/hosts which define the hostname of the container itself as well as localhost and a few other common things. The --add-host flag can be used to add additional lines to /etc/hosts.

``/etc/hosts`` には ``localhost`` や一般的な項目と同じように、自分が定義したコンテナのホスト名を追加できます。  ``/etc/hosts`` に行を追加するには ``--add-host`` フラグを使います。

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

   Docker がコンテナの ``/etc/hosts`` ファイルをリアルタイムに更新するかもしれません。そのため、コンテナ内のプロセスが ``/etc/hosts`` ファイルを読み込もうとしても空だったり、あるいは最後まで読み込めなかったりする場合が有り得ます。ほとんどの場合、再度読み込みで問題が解決するでしょう。

.. Restart policies (--restart)

.. _restart-policies-restart:

再起動ポリシー（--restart）
==============================

.. Using the --restart flag on Docker run you can specify a restart policy for how a container should or should not be restarted on exit.

Docker で実行時に ``--restart`` フラグを使えば、再起動ポリシーを指定できます。再起動ポリシーとは、コンテナが終了時に再起動すべきかどうかを定義します。

.. When a restart policy is active on a container, it will be shown as either Up or Restarting in docker ps. It can also be useful to use docker events to see the restart policy in effect.

コンテナの再起動ポリシーが有効な場合、 ``docker ps`` でコンテナを見たら、常に ``Up`` か ``Restarting`` のどちらかです。また、再起動ポリシーが有効かどうかを確認するため、 ``docker events`` を使うのも便利です。

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

**on-failure** ポリシーを使えば、Docker がコンテナの再起動を試みる最大回数を指定できます。デフォルトでは、Docker はコンテナを永久に再起動し続けます。コンテナの再起動（を試みる）回数は ``docker inspect`` で確認可能です。例えば、コンテナ「my-container」の再起動数を取得するには、次のようにします。

.. code-block:: bash

   $ docker inspect -f "{{ .RestartCount }}" my-container
   # 2

.. Or, to get the last time the container was (re)started;

あるいは、コンテナが（再）起動した時刻を知るには、次のようにします。

.. code-block:: bash

   $ docker inspect -f "{{ .State.StartedAt }}" my-container
   # 2015-03-04T23:47:07.691840179Z

.. You cannot set any restart policy in combination with “clean up (--rm)”. Setting both --restart and --rm results in an error.

再起動ポリシーと :ref:`クリーンアップ <clean-up-rm>` は同時に指定できません。 ``--restart`` と ``--rm`` を同時に指定してもエラーになります。

.. Examples

.. _restart-examples:

例
----------

.. code-block:: bash

   $ docker run --restart=always redis

.. This will run the redis container with a restart policy of always so that if the container exits, Docker will restart it.

こちらの例は、 **常に (always)** 再起動するポリシーで ``redis`` コンテナを実行します。そのため、コンテナが停止すると Docker はコンテナを再起動します。

.. code-block:: bash

   $ docker run --restart=on-failure:10 redis

.. This will run the redis container with a restart policy of on-failure and a maximum restart count of 10. If the redis container exits with a non-zero exit status more than 10 times in a row Docker will abort trying to restart the container. Providing a maximum restart limit is only valid for the on-failure policy.

こちらの例は、 **失敗したら (on-failure)** 10回カウントするまで再起動を行うポリシーで ``redis`` コンテナを起動しています。もし ``redis`` コンテナが 0 以外の状態で終了したら、Docker はコンテナの再起動を１０回続けて試みます。再起動の上限を設定できるのは、 **on-failure** ポリシーを有効にした場合のみです。

.. Exit Status

.. _exit-status:

終了ステータス（exit status）
==============================

.. The exit code from docker run gives information about why the container failed to run or why it exited. When docker run exits with a non-zero code, the exit codes follow the chroot standard, see below:

``docker run`` の終了コードから得られる情報は、なぜコンテナが実行に失敗したかや、なぜ終了したかです。 ``docker run`` がゼロ以外のコードで終了する時、終了コードは ``chroot`` 標準に従います。

.. 125 if the error is with Docker daemon itself

**125** は Docker デーモン **自身** のエラー発生です。

.. code-block:: bash

   $ docker run --foo busybox; echo $?
   # 定義されていない --foo フラグを指定したため 
     See 'docker run --help'.
     125

.. 126 if the contained command cannot be invoked

**126** は **コンテナ内のコマンド** が実行できない場合のエラーです。

.. code-block:: bash

   $ docker run busybox /etc; echo $?
   # "/etc" には実行権限がありません 
     docker: Error response from daemon: Contained command could not be invoked
     126

.. 127 if the contained command cannot be found

**127** は **コンテナ内のコマンド** が見つからない場合です。

.. code-block:: bash

   $ docker run busybox foo; echo $?
   # 環境変数 $PATH の中に "foo" 実行ファイルが見つかりません。
     docker: Error response from daemon: Contained command not found or does not exist
     127

.. Exit code of contained command otherwise

**コンテナ内におけるコマンド** の **終了コード** は上書きできます。

.. code-block:: bash

   $ docker run busybox /bin/sh -c 'exit 3'
   # 3


.. Clean up (--rm)

.. _clean-up-rm:

クリーンアップ（--rm）
==============================

.. By default a container’s file system persists even after the container exits. This makes debugging a lot easier (since you can inspect the final state) and you retain all your data by default. But if you are running short-term foreground processes, these container file systems can really pile up. If instead you’d like Docker to automatically clean up the container and remove the file system when the container exits, you can add the --rm flag:

デフォルトではコンテナを終了しても、コンテナのファイルシステム（の内容）を保持し続けます。これにより、多くのデバッグをより簡単にします（最後の状態を確認できるため）。そして、全てのデータを維持し続けるのがデフォルトです。しかし、短い期間だけ **フォアグラウンド** で動かしたとしても、これらのコンテナのファイルシステムが溜まり続けます。そうではなく、 **コンテナの終了時に、自動的にコンテナをクリーンアップし、ファイルシステムを削除する** には ``--rm`` フラグを追加します。

.. code-block:: bash

   --rm=false: Automatically remove the container when it exits (incompatible with -d)

..     Note: When you set the --rm flag, Docker also removes the volumes associated with the container when the container is removed. This is similar to running docker rm -v my-container. Only volumes that are specified without a name are removed. For example, with docker run --rm -v /foo -v awesome:/bar busybox top, the volume for /foo will be removed, but the volume for /bar will not. Volumes inherited via --volumes-from will be removed with the same logic -- if the original volume was specified with a name it will not be removed.

.. note::

   ``--rm`` フラグを設定したら、コンテナの削除時、関連するボリュームも削除します。これは ``docker rm -v my-container`` の実行と同じです。ただし、名前を指定しなかったボリュームのみ削除します。例えば ``docker run --rm -v /foo -v awesome:/bar busybox top`` の場合、 ``/foo`` ボリュームを削除します。しかし、 ``/bar`` は削除されません。 ``--volume-form`` で継承しているボリュームが削除されないのと同じ仕組みです。このように、オリジナルのボリュームに名前が指定されていれば、そこは削除 **されません** 。

.. Security configuration

.. _security-configuration:

セキュリティ設定
====================

.. code-block:: bash

   --security-opt="label=user:USER"   : コンテナの user ラベルを指定
   --security-opt="label=role:ROLE"   : コンテナの role ラベルを指定
   --security-opt="label=type:TYPE"   : コンテナの type ラベルを指定
   --security-opt="label=level:LEVEL" : コンテナの lovel ラベルを指定
   --security-opt="label=disable"     : コンテナのラベル割り当てを無効化
   --security-opt="apparmor=PROFILE"  : コンテナに適用する apparmor profile を指定
   --security-opt="no-new-privileges" : コンテナが新しい権限を得るのを無効化
   --security-opt="seccomp=unconfined": コンテナ用の seccomp 制限を無効化
   --security-opt="seccomp=profile.json": sccomp フィルタで使うホワイトリスト syscall seccompo Json ファイルを指定

.. You can override the default labeling scheme for each container by specifying the --security-opt flag. Specifying the level in the following command allows you to share the same content between containers.

各コンテナに対するデフォルトのラベリング・スキーマ（labeling scheme）は ``--security-opt`` フラグを指定することで上書き可能です。コンテナ間で同じ内容を共有できるようレベルを指定するには、次のようにコマンドを実行します。

.. code-block:: bash

   $ docker run --security-opt label=level:s0:c100,c200 -i -t fedora bash

.. **Note**: Automatic translation of MLS labels is not currently supported.

.. note::

   MLS ラベルの自動変換は、現在サポートしていません。


.. To disable the security labeling for this container versus running with the --permissive flag, use the following command:

コンテナに対するセキュリティ・ラベリングを無効化するには、 ``--permissive`` フラグを使い、次のように指定します。

.. code-block:: bash

   $ docker run --security-opt label=disable -i -t fedora bash

.. If you want a tighter security policy on the processes within a container, you can specify an alternate type for the container. You could run a container that is only allowed to listen on Apache ports by executing the following command:

コンテナ内のプロセスに対して、何らかのセキュリティ・ポリシーを適用するには、コンテナに対して何らかのタイプを指定します。コンテナを実行する時、Apache のポートのみがリッスンできるようにするには、次のように実行します。

.. code-block:: bash

   $ docker run --security-opt label=type:svirt_apache_t -i -t centos bash

..    Note: You would have to write policy defining a svirt_apache_t type.

.. note::

   ここでは ``svirt_apache_t`` タイプ に対する書き込みポリシーがあるものと想定しています。

.. If you want to prevent your container processes from gaining additional privileges, you can execute the following command:

コンテナのプロセスに特権を追加できないようにするには、次のコマンドを実行します。

.. code-block:: bash

   $ docker run --security-opt no-new-privileges -it centos bash

.. For more details, see kernel documentation.

より詳しい情報は、 `カーネルのドキュメント <https://www.kernel.org/doc/Documentation/prctl/no_new_privs.txt>`_ をご覧ください。

.. Specifying custom cgroups

.. _specifying-custom-cgroups:

カスタム cgroups の指定
==============================

.. Using the --cgroup-parent flag, you can pass a specific cgroup to run a container in. This allows you to create and manage cgroups on their own. You can define custom resources for those cgroups and put containers under a common parent group.

``--cgroup-parent`` フラグを使うことで、コンテナを特定の cgroup で実行できるようにします。これにより自分自身で cgroup の作成や管理が可能になります。各 cgroup に対してカスタム・リソースを定義でき、コンテナを共通の親グループ下に置くこともできます。

.. Runtime constraints on resources

.. _runtime-constraints-on-resources:

実行時のリソース制限
====================

.. The operator can also adjust the performance parameters of the container:

作業者はコンテナのパフォーマンス・パラメータも調整できます。

.. Option 	Description
.. -m, --memory="" 	Memory limit (format: <number>[<unit>], where unit = b, k, m or g)
.. --memory-swap="" 	Total memory limit (memory + swap, format: <number>[<unit>], where unit = b, k, m or g)
.. --memory-reservation="" 	Memory soft limit (format: <number>[<unit>], where unit = b, k, m or g)
.. --kernel-memory="" 	Kernel memory limit (format: <number>[<unit>], where unit = b, k, m or g)
.. -c, --cpu-shares=0 	CPU shares (relative weight)
.. --cpu-period=0 	Limit the CPU CFS (Completely Fair Scheduler) period
.. --cpuset-cpus="" 	CPUs in which to allow execution (0-3, 0,1)
.. --cpuset-mems="" 	Memory nodes (MEMs) in which to allow execution (0-3, 0,1). Only effective on NUMA systems.
.. --cpu-quota=0 	Limit the CPU CFS (Completely Fair Scheduler) quota
.. --blkio-weight=0 	Block IO weight (relative weight) accepts a weight value between 10 and 1000.
.. --oom-kill-disable=false 	Whether to disable OOM Killer for the container or not.
.. --memory-swappiness="" 	Tune a container’s memory swappiness behavior. Accepts an integer between 0 and 100.

.. list-table::
   :header-rows: 1
   
   * - オプション
     - 説明
   * - ``-m`` , ``--memory=""``
     - メモリの上限（書式： ``<数値> [<単位>]`` 、単位は b、k、m、g のいずれか）
   * - ``--memory-swap=""``
     - 合計メモリの上限（メモリ＋スワップ、書式： ``<数値> [<単位>]`` 、単位は b、k、m、g  のいずれか）
   * - ``--memory-reservation=""``
     - メモリのソフト・リミット（書式： ``<数値> [<単位>]`` 、単位は b、k、m、g のいずれか）
   * - ``--kernel-memory=""``
     - カーネル・メモリの上限（書式： ``<数値> [<単位>]`` 、単位は b、k、m、g のいずれか）
   * - ``-c`` , ``--cpu-shares=0``
     - CPU 共有（CPU shares）を相対値で指定
   * - ``--cpu-period=0``
     - CPU CFS (Completely Fair Scheduler) ピリオドの上限（訳者注：cgroup による CPU リソースへのアクセスを再割り当てする間隔）
   * - ``--cpuset-cpus=""``
     - 実行する CPU の割り当て（0-3, 0,1）
   * - ``--cpuset-mems=""``
     - 実行するメモリ・ノード（MEM）の割り当て（0-3, 0,1）。NUMA システムのみで動作
   * - ``--cpu-quota=0``
     - CPU CFS (Completely Fair Scheduler) のクォータを設定
   * - ``--blkio-weight=0``
     - ブロック I/O ウエイト（相対値）を 10 ～ 1000 までの値でウエイトを設定
   * - ``--oom-kill-disable=false``
     - コンテナを OOM killer による停止を無効化するかどうか指定
   * - ``--memory-swappiness=""``
     - コンテナがメモリのスワップ度合いを調整。整数値の 0 ～ 100 で指定

.. User memory constraints

.. _user-memory-constraints:

ユーザ・メモリの制限
--------------------

.. We have four ways to set user memory usage:

ユーザのメモリ使用を制限するには、４つの方法があります。

.. Option 	Result
.. memory=inf, memory-swap=inf (default) 	There is no memory limit for the container. The container can use as much memory as needed.
.. memory=L<inf, memory-swap=inf 	(specify memory and set memory-swap as -1) The container is not allowed to use more than L bytes of memory, but can use as much swap as is needed (if the host supports swap memory).
.. memory=L<inf, memory-swap=2*L 	(specify memory without memory-swap) The container is not allowed to use more than L bytes of memory, swap *plus* memory usage is double of that.
.. memory=L<inf, memory-swap=S<inf, L<=S 	(specify both memory and memory-swap) The container is not allowed to use more than L bytes of memory, swap *plus* memory usage is limited by S.

.. list-table::
   :header-rows: 1
   
   * - オプション
     - 結果
   * - **memory=inf, memory-swap=inf** （デフォルト）
     - コンテナに対する上限を設けない。コンテナは必要な分のメモリを使える
   * - **memory=L<inf, memory-swap=inf**
     - （memory を指定し、memory-swap を ``-1`` にする）コンテナは L バイト以上のメモリ使用が許されないが、必要があればスワップを使える（ホスト側がスワップ・メモリをサポートしている場合）
   * - **memory=L<inf, memory-swap=2*L**
     - （memory を指定するが memory-swap は指定しない）コンテナは L バイト以上のメモリ使用は許されないが、指定した値の２倍の「追加」スワップ・メモリが使える
   * - **memory=L<inf, memory-swap=S<inf, L<=S**
     - （memory も memory-swap も指定する）コンテナは L バイト以上のメモリ使用が許されないが、「追加」スワップ・メモリは S バイトまで使える

.. Examples:

例：

.. code-block:: bash

   $ docker run -ti ubuntu:14.04 /bin/bash

.. We set nothing about memory, this means the processes in the container can use as much memory and swap memory as they need.

メモリを設定していません。これはコンテナ内のプロセスは必要な分だけメモリが使えます。それだけでなく、スワップ・メモリも同様に必要なだけ使えます。

.. code-block:: bash

   $ docker run -ti -m 300M --memory-swap -1 ubuntu:14.04 /bin/bash

.. We set memory limit and disabled swap memory limit, this means the processes in the container can use 300M memory and as much swap memory as they need (if the host supports swap memory).

メモリ上限を指定し、スワップ・メモリの制限を無効化しました。これはコンテナ内のプロセスは 300M のメモリを使えます。それだけでなく、スワップ・メモリは必要なだけ使えます（ホスト側がスワップ・メモリをサポートしている場合）。

.. code-block:: bash

   $ docker run -ti -m 300M ubuntu:14.04 /bin/bash

.. We set memory limit only, this means the processes in the container can use 300M memory and 300M swap memory, by default, the total virtual memory size (--memory-swap) will be set as double of memory, in this case, memory + swap would be 2*300M, so processes can use 300M swap memory as well.

メモリの上限のみ設定しました。これはコンテナが 300M のメモリと 300M のスワップ・メモリを使えます。合計の仮想メモリサイズ（total virtual memory size、 --memory-swap で指定）はメモリの２倍に設定されます。今回の例では、メモリ＋スワップは 2×300M ですので、プロセスは 300M のスワップ・メモリを利用できます。

.. code-block:: bash

   $ docker run -ti -m 300M --memory-swap 1G ubuntu:14.04 /bin/bash

.. We set both memory and swap memory, so the processes in the container can use 300M memory and 700M swap memory.

メモリとスワップ・メモリを指定しましたので、コンテナ内のプロセスは 300M のメモリと 700M のスワップ・メモリを使えます。

.. Memory reservation is a kind of memory soft limit that allows for greater sharing of memory. Under normal circumstances, containers can use as much of the memory as needed and are constrained only by the hard limits set with the -m/--memory option. When memory reservation is set, Docker detects memory contention or low memory and forces containers to restrict their consumption to a reservation limit.

メモリ予約（memory reservation）は、メモリに対するある種のソフト・リミットであり、共有メモリを大きくします。通常の状況下であれば、コンテナは必要とするだけ多くのメモリを使うことができます。そして、 ``-m`` か ``--memory`` オプションがある時のみ、コンテナに対してハード・リミットが設定されます。メモリ予約が設定したら、Docker はメモリのコンテンション（競合）や少ないメモリを検出し、コンテナが予約した上限まで使えるようにします。

.. Always set the memory reservation value below the hard limit, otherwise the hard limit takes precedence. A reservation of 0 is the same as setting no reservation. By default (without reservation set), memory reservation is the same as the hard memory limit.

メモリ予約の値は、常にハード・リミット以下に設定しなければ、ハード・リミットが先に処理されてしまいます。予約値を 0 に設定するのは、予約しないのと同じです。デフォルトでは（予約をセットしない場合）、メモリ予約とはメモリのハード・リミットと同じです。

.. Memory reservation is a soft-limit feature and does not guarantee the limit won’t be exceeded. Instead, the feature attempts to ensure that, when memory is heavily contended for, memory is allocated based on the reservation hints/setup.

メモリ予約とはソフト・リミット機能であり、制限を超過しないことを保証しません。その代わりに、かなりメモリが競合する場合、予約のヒント/設定に基づいてメモリの割り当てを試みる機能があります。

.. The following example limits the memory (-m) to 500M and sets the memory reservation to 200M.

次の例はメモリの上限（ ``-m`` ）を 500M に制限し、メモリ予約を 200M に設定します。

.. code-block:: bash

   $ docker run -ti -m 500M --memory-reservation 200M ubuntu:14.04 /bin/bash

.. Under this configuration, when the container consumes memory more than 200M and less than 500M, the next system memory reclaim attempts to shrink container memory below 200M.

この設定の下では、コンテナはメモリを 200MB 以上 ～ 500MB 以下まで使えます。次のシステム・メモリはコンテナのメモリが 200MB 以下になるよう縮小を試みます。

.. The following example set memory reservation to 1G without a hard memory limit.

次の例はメモリのハード・リミットを設定せず、メモリ予約を 1G に設定します。

.. code-block:: bash

   $ docker run -ti --memory-reservation 1G ubuntu:14.04 /bin/bash

.. The container can use as much memory as it needs. The memory reservation setting ensures the container doesn’t consume too much memory for long time, because every memory reclaim shrinks the container’s consumption to the reservation.

コンテナはメモリを必要なだけ使えます。メモリ予約設定により、コンテナが長時間多くのメモリを消費しなくなります。これはコンテナがメモリを消費したとしても、予約分を使えるようにメモリの使用を縮小しようとするからです。

.. By default, kernel kills processes in a container if an out-of-memory (OOM) error occurs. To change this behaviour, use the --oom-kill-disable option. Only disable the OOM killer on containers where you have also set the -m/--memory option. If the -m flag is not set, this can result in the host running out of memory and require killing the host’s system processes to free memory.

デフォルトでは、アウト・オブ・メモリ（OOM; out of memory）エラーが発生したら、カーネルはコンテナ内のプロセスを停止（kill）します。この振る舞いを変更するには、 ``--oom-kill-disable`` オプションを使います。また、 ``-m/--memory`` オプションを指定した時のみ、コンテナに対する OOM が無効化できます。もし ``-m`` フラグがセットされなければ、ホスト側でアウト・オブ・メモリ処理が発生します。また、ホスト側のシステム・プロセスが空きメモリを必要とするため、対象のプロセスを停止（kill）します。

.. The following example limits the memory to 100M and disables the OOM killer for this container:

次の例はメモリの上限を 100M とし、対象となるコンテナに対する OOM killer （アウト・オブ・メモリ処理による強制停止）を無効化します。

.. code-block:: bash

   $ docker run -ti -m 100M --oom-kill-disable ubuntu:14.04 /bin/bash

.. The following example, illustrates a dangerous way to use the flag:

次の例では、危険なフラグの使い方を説明します。

.. code-block:: bash

   $ docker run -ti --oom-kill-disable ubuntu:14.04 /bin/bash

.. The container has unlimited memory which can cause the host to run out memory and require killing system processes to free memory.

コンテナは無制限にメモリを使えるため、ホスト上のメモリを使い果たしたら、空きメモリ確保のために、システム・プロセスを停止する必要が出てきます。

.. Kernel memory constraints

.. _kernel-memory-constraints:

カーネル・メモリ制限
--------------------

.. Kernel memory is fundamentally different than user memory as kernel memory can’t be swapped out. The inability to swap makes it possible for the container to block system services by consuming too much kernel memory. Kernel memory includes：

カーネル・メモリはスワップ・アウトできないため、ユーザ・メモリとは根本的に異なります。このスワップができないことにより、システム・サービスがカーネル・メモリを多く使えないように妨害する可能性があります。カーネル・メモリとは、次の項目を指します。

..    stack pages
    slab pages
    sockets memory pressure
    tcp memory pressure

* stack pages
* slab pages
* sockets memory pressure
* tcp memory pressure

.. You can setup kernel memory limit to constrain these kinds of memory. For example, every process consumes some stack pages. By limiting kernel memory, you can prevent new processes from being created when the kernel memory usage is too high.

これらのメモリを制限するため、カーネル・メモリの上限を設定できます。例えば、各プロセスが同じスタック・ページ（stack page）を使うようにする場合です。カーネル・メモリの制限により、カーネル・メモリの使用量が大きい時、新しいプロセスの作成を妨げます。

.. Kernel memory is never completely independent of user memory. Instead, you limit kernel memory in the context of the user memory limit. Assume “U” is the user memory limit and “K” the kernel limit. There are three possible ways to set limits:

カーネル・メモリはユーザ・メモリとは完全に独立しています。その代わり、ユーザ・メモリを制限すると同時に、カーネル・メモリの制限も必要です。上限の設定には３つの方法があります。ここでは、「U」はユーザ・メモリの上限で、「K」はカーネルの上限とみなしています。

.. Option 	Result
.. U != 0, K = inf (default) 	This is the standard memory limitation mechanism already present before using kernel memory. Kernel memory is completely ignored.
.. U != 0, K < U 	Kernel memory is a subset of the user memory. This setup is useful in deployments where the total amount of memory per-cgroup is overcommitted. Overcommitting kernel memory limits is definitely not recommended, since the box can still run out of non-reclaimable memory. In this case, you can configure K so that the sum of all groups is never greater than the total memory. Then, freely set U at the expense of the system's service quality.
.. U != 0, K > U 	Since kernel memory charges are also fed to the user counter and reclamation is triggered for the container for both kinds of memory. This configuration gives the admin a unified view of memory. It is also useful for people who just want to track kernel memory usage.

.. list-table::
   :header-rows: 1
   
   * - オプション
     - 結果
   * - **U != 0, K = inf** （デフォルト）
     - カーネル・メモリが使う前に、標準的なメモリ制限を設ける仕組み。カーネル・メモリは完全に無視される。
   * - **U != 0, K < U**
     - カーネル・メモリをユーザ・メモリのサブセットとする。この設定は cgroup ごとに大きな合計メモリ容量をオーバーコミットで割り当て、デプロイする場合に使いやすい。カーネル・メモリ制限のオーバコミットは、全く推奨されていない。範囲が再利用できないメモリ領域の場合が有り得るため。この例では、 K を設定したので、全グループの合計は、全メモリ容量を超えられない。そして、システム・サービスの品質のために U を任意に設定できる。
   * - **U != 0, K > U**
     - カーネルのメモリを使用するため、コンテナ向けに両方のメモリが、ユーザ・カウンタと再利用トリガに影響を与えます。

.. Examples:

例：

   $ docker run -ti -m 500M --kernel-memory 50M ubuntu:14.04 /bin/bash

.. We set memory and kernel memory, so the processes in the container can use 500M memory in total, in this 500M memory, it can be 50M kernel memory tops.

メモリとカーネルメモリを設定しました。これにより、コンテナ内のプロセスは合計 500M まで使えます。この 500M のメモリのうち、トップに 50M のカーネル・メモリがあります。

.. code-block:: bash

   $ docker run -ti --kernel-memory 50M ubuntu:14.04 /bin/bash

.. We set kernel memory without -m, so the processes in the container can use as much memory as they want, but they can only use 50M kernel memory.

**-m** オプションを指定せずカーネル・メモリを指定しました。そのため、コンテナ内のプロセスは必要なだけ多くのメモリを利用可能ですが、そこに最低限 50M のカーネル・メモリを使います。

.. Swappiness constraint

.. _swappiness-constraint:

スワップ回避（swappiness）制限
------------------------------

.. By default, a container’s kernel can swap out a percentage of anonymous pages. To set this percentage for a container, specify a --memory-swappiness value between 0 and 100. A value of 0 turns off anonymous page swapping. A value of 100 sets all anonymous pages as swappable. By default, if you are not using --memory-swappiness, memory swappiness value will be inherited from the parent.

デフォルトでは、コンテナのカーネルは、アノニマス・ページ・メモリ上の何パーセントかをスワップ・アウトします。コンテナ向けのこのパーセントを指定するには ``--memory-swappiness`` で 0 ～ 100 までの値を設定します。この値が 0 であればアノニマス・ページのスワッピング（anonymous page swapping）を無効にします。値を 100 にすると全てのページがスワップ可能となります。デフォルトでは、 ``--memory-swappiness`` を指定しなければ、メモリのスワップ回避（swappiness）は親の値を継承します。

.. For example, you can set:

例：

.. code-block:: bash

   $ docker run -ti --memory-swappiness=0 ubuntu:14.04 /bin/bash

.. Setting the --memory-swappiness option is helpful when you want to retain the container’s working set and to avoid swapping performance penalties.

``--memory-swappiness`` オプションが役立つのは、コンテナの作業セットを維持し、スワップによるパフォーマンスのペナルティを避ける場合です。

.. CPU share constraint

.. _cpu-share-constraint:

CPU 共有制限
--------------------

.. By default, all containers get the same proportion of CPU cycles. This proportion can be modified by changing the container’s CPU share weighting relative to the weighting of all other running containers.

デフォルトでは、全てのコンテナは同じ CPU サイクルの割合を持っています。この割合は変更可能なものであり、コンテナの CPU 共有ウエイトを、実行中の全てのコンテナに対する相対的な値として変更できます。

.. To modify the proportion from the default of 1024, use the -c or --cpu-shares flag to set the weighting to 2 or higher. If 0 is set, the system will ignore the value and use the default of 1024.

割合をデフォルトの 1024 から変更するには、 ``-c`` か ``--cpu-shares`` フラグでウエイトを 2 以上の値で設定します。もし 0 を設定しても、システムは値を無視してデフォルトの 1024 を使います。

.. The proportion will only apply when CPU-intensive processes are running. When tasks in one container are idle, other containers can use the left-over CPU time. The actual amount of CPU time will vary depending on the number of containers running on the system.

割合が適用されるのは　CPU に対する処理が集中する時のみです。あるコンテナのタスクがアイドル（何もしていない待機状態）であれば、他のコンテナは CPU 時間の余剰を利用できます。実際に割り当てられる CPU 時間の量は、システム上で実行するコンテナの下図に非常に依存します。

.. For example, consider three containers, one has a cpu-share of 1024 and two others have a cpu-share setting of 512. When processes in all three containers attempt to use 100% of CPU, the first container would receive 50% of the total CPU time. If you add a fourth container with a cpu-share of 1024, the first container only gets 33% of the CPU. The remaining containers receive 16.5%, 16.5% and 33% of the CPU.

例えば、３つのコンテナがあるとしましょう。１つめの CPU 共有は 1024 で、残り２つの CPU 共有は 512 とします。もし３つのコンテナが CPU を 100% 使用している状態になれば、１つめのコンテナが合計 CPU 時間の 50% を扱えます。４つめのコンテナを CPU 共有 1024 として追加したら、１つめのコンテナが得られるのは CPU の 33% になります。そして、残りの２つめ以降のコンテナが得られる CPU 時間は、それぞれ 16.5%（２つめ）、16.5%（３つめ）、33% （４つめ）となります。

.. On a multi-core system, the shares of CPU time are distributed over all CPU cores. Even if a container is limited to less than 100% of CPU time, it can use 100% of each individual CPU core.

複数のコアを持つ（マルチ・コア）システム上では、全ての CPU コアに分散してCPU 時間が共有されます。コンテナが CPU 時間の 100% より低く制限していても、個々の CPU コアでは 100% 利用できます。

.. For example, consider a system with more than three cores. If you start one container {C0} with -c=512 running one process, and another container {C1} with -c=1024 running two processes, this can result in the following division of CPU shares:

例えば、システムが３つ以上のコアを持っていると想定してみましょう。１つめのコンテナ ``{C0}`` では ``-c=512`` を指定し、１つのプロセスを実行するものとします。そして、他のコンテナ ``{C1}`` は ``-c=1024``  を指定し、２つのプロセスを実行するとします。この結果、CPU 共有は個々のコアに分散されます。

.. code-block:: bash

   PID    container    CPU CPU share
   100    {C0}     0   100% of CPU0
   101    {C1}     1   100% of CPU1
   102    {C1}     2   100% of CPU2

.. CPU period constraint

.. _cpu-period-constraint:

CPU 周期（period）制約
------------------------------

.. The default CPU CFS (Completely Fair Scheduler) period is 100ms. We can use --cpu-period to set the period of CPUs to limit the container’s CPU usage. And usually --cpu-period should work with --cpu-quota.

デフォルトの CPU CFS（Completely Fair Scheduler）周期は 100 ミリ秒です。コンテナの CPU 使用率を制限するには、 ``--cpu-period`` で CPU の周期を制限します。そして、通常の ``--cpu-period`` は ``--cpu-quota`` と一緒に使われるでしょう。

.. Examples:

例：

.. code-block:: bash

   $ docker run -ti --cpu-period=50000 --cpu-quota=25000 ubuntu:14.04 /bin/bash

.. If there is 1 CPU, this means the container can get 50% CPU worth of run-time every 50ms.

もし１ CPU であれば、コンテナは 50 ミリ秒ごとに CPU の 50% を利用できます（訳者注：--cpu-quota のクォータ値が、 --cpu-period 周期の半分のため）。

.. For more information, see the CFS documentation on bandwidth limiting.

より詳しい情報については、`CFS ドキュメントの帯域制限について（英語） <https://www.kernel.org/doc/Documentation/scheduler/sched-bwc.txt>`_ をご覧ください。

.. Cpuset constraint

.. _cpuset-constraint:

CPU セット制限
--------------------

.. We can set cpus in which to allow execution for containers.

どの CPU でコンテナを実行するか指定できます。

.. Examples:

例：

.. code-block:: bash

   $ docker run -ti --cpuset-cpus="1,3" ubuntu:14.04 /bin/bash

.. This means processes in container can be executed on cpu 1 and cpu 3.

これはコンテナ内のプロセスを cpu 1 と cpu 3 で実行します。

.. code-block:: bash

   $ docker run -ti --cpuset-cpus="0-2" ubuntu:14.04 /bin/bash

.. This means processes in container can be executed on cpu 0, cpu 1 and cpu 2.

こちらはコンテナ内のプロセスを cpu 0 、cpu 1 、 cpu 2 で実行します。

.. We can set mems in which to allow execution for containers. Only effective on NUMA systems.

NUMA system 上でのみ、どのコンテナをメモリ上で実行するか設定できます。

.. Examples:

.. code-block:: bash

   $ docker run -ti --cpuset-mems="1,3" ubuntu:14.04 /bin/bash

.. This example restricts the processes in the container to only use memory from memory nodes 1 and 3.

この例ではコンテナ内でのプロセスを、メモリ・ノード 1 と 3 上のメモリのみに使用を制限します。

.. code-block:: bash

   $ docker run -ti --cpuset-mems="0-2" ubuntu:14.04 /bin/bash

.. This example restricts the processes in the container to only use memory from memory nodes 0, 1 and 2.

この例ではコンテナ内でのプロセスを、メモリ・ノード ０と１と２ 上のメモリのみに使用を制限します。

.. CPU quota constraint

.. _cpu-quota-constraint:

CPU クォータ制限
--------------------

.. The --cpu-quota flag limits the container’s CPU usage. The default 0 value allows the container to take 100% of a CPU resource (1 CPU). The CFS (Completely Fair Scheduler) handles resource allocation for executing processes and is default Linux Scheduler used by the kernel. Set this value to 50000 to limit the container to 50% of a CPU resource. For multiple CPUs, adjust the --cpu-quota as necessary. For more information, see the CFS documentation on bandwidth limiting.

``--cpu-quota`` フラグはコンテナの CPU 使用を制限します。デフォルト値 0 の場合、コンテナは CPU リソース（ 1 CPU ）の 100% を扱えます。CFS (Completely Fair Scheduler) がプロセス実行時のリソース割り当てを扱っており、これがカーネルによってデフォルトの Linux スケジューラとして使われています。この値を 50000 に指定したら、コンテナは CPU リソースの 50% までの使用に制限されます。複数の CPU の場合は、 ``--cpu-quota`` の調整が必要です。より詳しい情報については、`CFS ドキュメントの帯域制限について（英語） <https://www.kernel.org/doc/Documentation/scheduler/sched-bwc.txt>`_ をご覧ください。

.. Block IO bandwidth (Blkio) constraint

.. _block-io-bandwidth-blkio-constraint:

ブロック IO 帯域（blkio）制限
------------------------------

.. By default, all containers get the same proportion of block IO bandwidth (blkio). This proportion is 500. To modify this proportion, change the container’s blkio weight relative to the weighting of all other running containers using the --blkio-weight flag.

デフォルトでは、全てのコンテナはブロック IO 帯域（blkio）を同じ割合で取得します。デフォルトの割合は 500 です。割合を変更するには ``--blkio-weight`` フラグを使い、実行中の全てのコンテナに対する装置亜的な blkio ウエイトを指定します。

.. The --blkio-weight flag can set the weighting to a value between 10 to 1000. For example, the commands below create two containers with different blkio weight:

``--blkio-weight`` フラグは、 10 ～ 1000 までのウエイト値を設定できます。例えば、次のコマンドは２つのコンテナに対し、別々の blkio ウエイトと設定しています。

.. code-block:: bash

   $ docker run -ti --name c1 --blkio-weight 300 ubuntu:14.04 /bin/bash
   $ docker run -ti --name c2 --blkio-weight 600 ubuntu:14.04 /bin/bash

.. If you do block IO in the two containers at the same time, by, for example:

例えば、次のようにして２つのコンテナで同時にブロック IO を確認できます。

.. code-block:: bash

   $ time dd if=/mnt/zerofile of=test.out bs=1M count=1024 oflag=direct

.. You’ll find that the proportion of time is the same as the proportion of blkio weights of the two containers.

２つのコンテナ間の blkio ウエイトの割合により、処理にかかる時間の割合が変わるのが分かるでしょう。

..    Note: The blkio weight setting is only available for direct IO. Buffered IO is not currently supported.

.. note::

   blkio ウエイトの設定は直接 IO (direct IO) のみです。現時点ではバッファ IO (buffered IO) をサポートしていません。

.. Additional groups

.. _additional-groups:

グループの追加
====================

.. code-block:: bash

   --group-add: 実行時のグループを追加

.. By default, the docker container process runs with the supplementary groups looked up for the specified user. If one wants to add more to that list of groups, then one can use this flag:

Docker コンテナのプロセスを実行できるのは、デフォルトでは、補助的なグループに所属しているユーザのみです（訳者注：docker グループに所属するユーザ）。グループを更に追加したい場合は、このフラグを使います。

.. code-block:: bash

   $ docker run --rm --group-add audio --group-add nogroup --group-add 777 busybox id
   uid=0(root) gid=0(root) groups=10(wheel),29(audio),99(nogroup),777

.. Runtime privilege, Linux capabilities, and LXC configuration

.. _runtime-privilege-linux-capabilities-and-lxc-configuration:

実行時の権限、Linux 機能、LXC 設定
==================================

.. code-block:: bash

   --cap-add: Linux ケーパビリティの追加
   --cap-drop: Linux ケーパビリティの削除（ドロップ）
   --privileged=false: コンテナに拡張権限を与える
   --device=[]: --privileged（特権）フラグが無いコンテナ内でもデバイスの実行を許可
   --lxc-conf=[]: カスタム lxc オプションの追加

.. By default, Docker containers are “unprivileged” and cannot, for example, run a Docker daemon inside a Docker container. This is because by default a container is not allowed to access any devices, but a “privileged” container is given access to all devices (see lxc-template.go and documentation on cgroups devices).

デフォルトでは、Docker コンテナは「unprivileged」（権限が無い）ため、Docker コンテナの中で Docker デーモンを動かす等ができません。これは、デフォルトのコンテナはあらゆるデバイスに対して接続できないためであり、「privileged」（特権）コンテナのみが全てのコンテナに接続できます（ `lxc-template.go <https://github.com/docker/docker/blob/master/daemon/execdriver/lxc/lxc_template.go>`_ と `cgroups devices <https://www.kernel.org/doc/Documentation/cgroup-v1/devices.txt>`_ のドキュメントをご覧ください ）

.. When the operator executes docker run --privileged, Docker will enable to access to all devices on the host as well as set some configuration in AppArmor or SELinux to allow the container nearly all the same access to the host as processes running outside containers on the host. Additional information about running with --privileged is available on the Docker Blog.

作業者が ``docker run --privileged`` を実行したら、Docker はホスト上の全てのデバイスに対して接続可能になります。この時、 AppArmor や SELinux の設定があれば、ホスト上のコンテナ外のプロセスと同じように、ホスト上の同じアクセス権限が与えられた状態で利用可能になります。 ``--privileged`` の実行に関する追加情報については、 `Docker ブログの投稿（英語） <http://blog.docker.com/2013/09/docker-can-now-run-within-docker/>`_ をご覧ください。

.. If you want to limit access to a specific device or devices you can use the --device flag. It allows you to specify one or more devices that will be accessible within the container.

特定のデバイスに対する許可だけ加えたい時は、 ``--device`` フラグが使えます。これを指定したら、１つまたは複数のデバイスがコンテナ内から接続できるようになります。

.. code-block:: bash

   $ docker run --device=/dev/snd:/dev/snd ...

.. By default, the container will be able to read, write, and mknod these devices. This can be overridden using a third :rwm set of options to each --device flag:

デフォルトでは、コンテナはデバイスに対して ``read`` 、 ``write`` 、 ``mknod`` が可能です。それぞれの ``--device`` フラグは、 ``:rwm`` という３つのオプション・セットで上書きできます。

.. code-block:: bash

   $ docker run --device=/dev/sda:/dev/xvdc --rm -it ubuntu fdisk  /dev/xvdc
   
   Command (m for help): q
   $ docker run --device=/dev/sda:/dev/xvdc:r --rm -it ubuntu fdisk  /dev/xvdc
   You will not be able to write the partition table.
   
   Command (m for help): q
   
   $ docker run --device=/dev/sda:/dev/xvdc:w --rm -it ubuntu fdisk  /dev/xvdc
       crash....
   
   $ docker run --device=/dev/sda:/dev/xvdc:m --rm -it ubuntu fdisk  /dev/xvdc
   fdisk: unable to open /dev/xvdc: Operation not permitted

.. In addition to --privileged, the operator can have fine grain control over the capabilities using --cap-add and --cap-drop. By default, Docker has a default list of capabilities that are kept. The following table lists the Linux capability options which can be added or dropped.

``--privileged`` に加え、作業者は ``--cap-add`` と ``--cap-drop`` を使い、ケーパビリティに対する詳細な制御が可能になります。デフォルトでは、Docker はデフォルトのケーパビリティ一覧を保持しています。次の表は、追加・削除可能な Linux ケーパビリティのオプション一覧です。

.. Capability Key 	Capability Description
.. SETPCAP 	Modify process capabilities.
.. SYS_MODULE 	Load and unload kernel modules.
.. SYS_RAWIO 	Perform I/O port operations (iopl(2) and ioperm(2)).
.. SYS_PACCT 	Use acct(2), switch process accounting on or off.
.. SYS_ADMIN 	Perform a range of system administration operations.
.. SYS_NICE 	Raise process nice value (nice(2), setpriority(2)) and change the nice value for arbitrary processes.
.. SYS_RESOURCE 	Override resource Limits.
.. SYS_TIME 	Set system clock (settimeofday(2), stime(2), adjtimex(2)); set real-time (hardware) clock.
.. SYS_TTY_CONFIG 	Use vhangup(2); employ various privileged ioctl(2) operations on virtual terminals.
.. MKNOD 	Create special files using mknod(2).
.. AUDIT_WRITE 	Write records to kernel auditing log.
.. AUDIT_CONTROL 	Enable and disable kernel auditing; change auditing filter rules; retrieve auditing status and filtering rules.
.. MAC_OVERRIDE 	Allow MAC configuration or state changes. Implemented for the Smack LSM.
.. MAC_ADMIN 	Override Mandatory Access Control (MAC). Implemented for the Smack Linux Security Module (LSM).
.. NET_ADMIN 	Perform various network-related operations.
.. SYSLOG 	Perform privileged syslog(2) operations.
.. CHOWN 	Make arbitrary changes to file UIDs and GIDs (see chown(2)).
.. NET_RAW 	Use RAW and PACKET sockets.
.. DAC_OVERRIDE 	Bypass file read, write, and execute permission checks.
.. FOWNER 	Bypass permission checks on operations that normally require the file system UID of the process to match the UID of the file.
.. DAC_READ_SEARCH 	Bypass file read permission checks and directory read and execute permission checks.
.. FSETID 	Don’t clear set-user-ID and set-group-ID permission bits when a file is modified.
.. KILL 	Bypass permission checks for sending signals.
.. SETGID 	Make arbitrary manipulations of process GIDs and supplementary GID list.
.. SETUID 	Make arbitrary manipulations of process UIDs.
.. LINUX_IMMUTABLE 	Set the FS_APPEND_FL and FS_IMMUTABLE_FL i-node flags.
.. NET_BIND_SERVICE 	Bind a socket to internet domain privileged ports (port numbers less than 1024).
.. NET_BROADCAST 	Make socket broadcasts, and listen to multicasts.
.. IPC_LOCK 	Lock memory (mlock(2), mlockall(2), mmap(2), shmctl(2)).
.. IPC_OWNER 	Bypass permission checks for operations on System V IPC objects.
.. SYS_CHROOT 	Use chroot(2), change root directory.
.. SYS_PTRACE 	Trace arbitrary processes using ptrace(2).
.. SYS_BOOT 	Use reboot(2) and kexec_load(2), reboot and load a new kernel for later execution.
.. LEASE 	Establish leases on arbitrary files (see fcntl(2)).
.. SETFCAP 	Set file capabilities.
.. WAKE_ALARM 	Trigger something that will wake up the system.
.. BLOCK_SUSPEND 	Employ features that can block system suspend.

.. list-table::
   :header-rows: 1
   
   * - ケーパビリティのキー(capability key)
     - ケーパビリティの説明
   * - SETPCAP
     - プロセスの機能を変更
   * - SYS_MODULE
     - カーネル・モジュールのロード(load)・アンロード(unload)
   * - SYSRAWIO
     - ランダム I/O ポート操作  (iopl(2) と ioperm(2)).
   * - SYS_PACCT
     - acct(2) を用いたプロセスのスイッチ回数のカウント有無
   * - SYS_ADMIN
     - システム管理オペレーションの処理範囲
   * - SYS_NICE
     - プロセスの nice 値  (nice(2), setpriority(2)) を上げるのと、任意プロセスに対する nice 値を設定
   * - SYS_RESOURCE
     - リソース上限の上書き
   * - SYS_TIME
     - システム・クロック (settimeofday(2), stime(2), adjtimex(2)) の設定
   * - SYS_TTY_CONFIG
     - vhangup(2) を使用。仮想ターミナル上で ioctl(2) オペレーションの関連権限
   * - MKNOD
     - mknod(2) で特別ファイルを作成
   * - AUDIT_WRITE
     - カーネル監査（ auditing ）ログに記録
   * - AUDIT_CONTROL
     - カーネルの監査（ auditing ）を有効化。監査フィルタルールの変更や、監査状態やフィルタリング・ルールの読み出し
   * - MAC_OVERRIDE
     - MAC 設定や状態の変更。Smack LSM 用の実装
   * - MAC_ADMIN
     - Mandatory アクセス・コントロール（MAC）の上書き。Smack Linux Security Module (LSM) 用の実装
   * - NET_ADMIN
     - 様々なネットワーク関連処理の実施
   * - SYSLOG
     - 特権 syslog(2) 処理の実施
   * - CHOWN
     - ファイルの UID と GID 属性を変更（ chown(2) を参照）
   * - NET_RAW
     - RAW と PACKET ソケットを使用
   * - DAC_OVERRIDE
     - ファイル音読み書き実行時に迂回し、権限を確認
   * - FOWNER
     - 操作権限の確認時に迂回し、ファイルの UID がシステム上で必要とする UID と一致するか確認
   * - DAC_READ_SEARCH
     - ファイル読み込み権限の確認を迂回し、ディレクトリの読み込み・実行権限を確認
   * - FSETID
     - ファイル変更時にユーザ ID とグループ ID を変更しない
   * - KILL
     - シグナル送信時の権限確認をバイパス
   * - SETGID
     - プロセス GID を GID 一覧にある任意のものに変更
   * - SETUID
     - プロセス UID を任意のものに変更
   * - LINUX_IMMUTABLE
     - FS_APPEND_FL と FS_IMMUTABLE_FL i-node フラグを設定
   * - NET_BIND_SERVICE
     - ソケットをインターネット・ドメイン権限用のポート（ポート番号は 1024 以下）に割り当て
   * - NET_BROADCAST
     - ソケットをブロードキャストし、マルチキャストをリッスンする
   * - IPC_LOCK
     - メモリのロック（mlock(2), mlockall(2), mmap(2), shmctl(2)）
   * - IPC_OWNER
     - System V IPC オブジェクト操作用の権限確認
   * - SYS_CHROOT
     - chroot(2) を使い、ルート・ディレクトリを変更
   * - SYS_PTRACE
     - ptrace(2) を使い、任意のプロセスをトレース
   * - SYS_BOOT
     - reboot(2) と kexec_load(2) を使い、後の処理用にリブートと新しいカーネルを読み込み
   * - LEASE
     - 任意のファイルのリースを確立（詳細は fcntl(2) ）
   * - SETFCAP
     - ファイルの機能を設定
   * - WAKE_ALARM
     - システムを起動する何らかのトリガ
   * - BLOCK_SUSPEND
     - ブロック・システムをサスペンドする機能

.. Further reference information is available on the capabilities(7) - Linux man page

より詳細なリファレンス情報は `Linux man ページの capabilities(7) <http://linux.die.net/man/7/capabilities>`_ をご覧ください。

.. Both flags support the value ALL, so if the operator wants to have all capabilities but MKNOD they could use:

作業者は全ての機能を有効化するために ``ALL`` 値を使えますが 、 ``MKNOD`` だけ除外したい時は次のようにします。

.. code-block:: bash

   $ docker run --cap-add=ALL --cap-drop=MKNOD ...

.. For interacting with the network stack, instead of using --privileged they should use --cap-add=NET_ADMIN to modify the network interfaces.

ネットワーク・スタックとやりとりするには、 ``--privileged`` を使う替わりに、ネットワーク・インターフェースの変更には ``--cap-add=NET_ADMIN`` を使うべきでしょう。

.. code-block:: bash

   $ docker run -t -i --rm  ubuntu:14.04 ip link add dummy0 type dummy
   RTNETLINK answers: Operation not permitted
   $ docker run -t -i --rm --cap-add=NET_ADMIN ubuntu:14.04 ip link add dummy0 type dummy

.. To mount a FUSE based filesystem, you need to combine both --cap-add and --device:

FUSE を基盤とするファイルシステムをマウントするには、 ``--cap-add`` と ``--device`` の両方を使う必要があります。

.. code-block:: bash

   $ docker run --rm -it --cap-add SYS_ADMIN sshfs sshfs sven@10.10.10.20:/home/sven /mnt
   fuse: failed to open /dev/fuse: Operation not permitted
   $ docker run --rm -it --device /dev/fuse sshfs sshfs sven@10.10.10.20:/home/sven /mnt
   fusermount: mount failed: Operation not permitted
   $ docker run --rm -it --cap-add SYS_ADMIN --device /dev/fuse sshfs
   # sshfs sven@10.10.10.20:/home/sven /mnt
   The authenticity of host '10.10.10.20 (10.10.10.20)' can't be established.
   ECDSA key fingerprint is 25:34:85:75:25:b0:17:46:05:19:04:93:b5:dd:5f:c6.
   Are you sure you want to continue connecting (yes/no)? yes
   sven@10.10.10.20's password:
   root@30aa0cfaf1b5:/# ls -la /mnt/src/docker
   total 1516
   drwxrwxr-x 1 1000 1000   4096 Dec  4 06:08 .
   drwxrwxr-x 1 1000 1000   4096 Dec  4 11:46 ..
   -rw-rw-r-- 1 1000 1000     16 Oct  8 00:09 .dockerignore
   -rwxrwxr-x 1 1000 1000    464 Oct  8 00:09 .drone.yml
   drwxrwxr-x 1 1000 1000   4096 Dec  4 06:11 .git
   -rw-rw-r-- 1 1000 1000    461 Dec  4 06:08 .gitignore
   ....

.. The default seccomp profile will adjust to the selected capabilities, in order to allow use of facilities allowed by the capabilities, so you should not have to adjust this, since Docker 1.12. In Docker 1.10 and 1.11 this did not happen and it may be necessary to use a custom seccomp profile or use --security-opt seccomp=unconfined when adding capabilities.

デフォルトの seccomp profile は特定のケーパビリティでファシリティを使えるようになりました。そのため Docker 1.12 から調整は不要です。Docker 1.10 と Docker 1.11 では何も起こりませんので、カスタム seccomp profile を使うか ``--security-opt seccomp=unconfined`` でケーパビリティを追加します。

.. Logging drivers (--log-driver)

.. _logging-drivers-log-driver:

ログ記録ドライバ（--log-driver）
========================================

.. The container can have a different logging driver than the Docker daemon. Use the --log-driver=VALUE with the docker run command to configure the container’s logging driver. The following options are supported:

Docker デーモンはコンテナごとに異なったログ記録ドライバを指定できます。コンテナのログ記録ドライバを指定するには、 ``docker run`` コマンドで ``--log-driver=VALUE`` を指定します。以下のオプションがサポートされています。

.. none 	Disables any logging for the container. docker logs won’t be available with this driver.
.. json-file 	Default logging driver for Docker. Writes JSON messages to file. No logging options are supported for this driver.
.. syslog 	Syslog logging driver for Docker. Writes log messages to syslog.
.. journald 	Journald logging driver for Docker. Writes log messages to journald.
.. gelf 	Graylog Extended Log Format (GELF) logging driver for Docker. Writes log messages to a GELF endpoint likeGraylog or Logstash.
.. fluentd 	Fluentd logging driver for Docker. Writes log messages to fluentd (forward input).
.. awslogs 	Amazon CloudWatch Logs logging driver for Docker. Writes log messages to Amazon CloudWatch Logs

.. list-table::

  * - ``none``
    - コンテナのログ記録ドライバを無効化します。このドライバでは ``docker logs`` が機能しません。
  * - ``json-file``
    - Docker に対応するデフォルトのログ記録ドライバです。ファイルに JSON メッセージを書き込みます。このドライバに対するオプションはありません。
  * - ``syslog``
    - Docker に対応する Syslog ログ記録ドライバです。ログのメッセージを syslog に書き込みます。
  * - ``journald``
    - Docker に対応する Journald ログ記録ドライバです。ログのメッセージを ``journald`` に書き込みます。
  * - ``fluentd``
    - Docker に対応する Fluentd ログ記録ドライバです。ログ・メッセージを ``fluentd`` に書き込みます（forward input）。
  * - ``awslogs``
    - Docker に対応する Amazon CloudWatch Logs ロギング・ドライバです。ログ・メッセージを Amazon CloudWatch Logs に書き込みます。

.. The docker logs command is available only for the json-file and journald logging drivers. For detailed information on working with logging drivers, see Configure a logging driver.

``docker logs`` コマンドが使えるのは ``json-file`` と ``journald`` ログ記録ドライバのみです。ログ記録ドライバの詳細な情報については :doc:`ログ記録ドライバの設定 </engine/admin/logging/overview>` をご覧ください。

.. Overriding Dockerfile image defaults

.. _overriding-dockerfile-image-defaults:

Dockerfile イメージのデフォルトより優先
========================================

.. When a developer builds an image from a Dockerfile or when she commits it, the developer can set a number of default parameters that take effect when the image starts up as a container.

開発者は :doc:`Dockerfile </engine/reference/builder>` を使ってイメージ構築時やコミット時、対象イメージを使ったコンテナを起動時に有効な各種パラメータを、開発者自身が設定できます。

.. Four of the Dockerfile commands cannot be overridden at runtime: FROM, MAINTAINER, RUN, and ADD. Everything else has a corresponding override in docker run. We’ll go through what the developer might have set in each Dockerfile instruction and how the operator can override that setting.

実行時に４つのコマンド ``FROM`` 、 ``MAINTAINER`` 、 ``RUN`` 、 ``ADD``  は上書きできません。それ以外のコマンド全ては ``docker run`` で上書きできます。開発者が Dockerfile で個々の命令を設定していたとしても、作業者はその設定を上書きして操作できます。

..    CMD (Default Command or Options)
    ENTRYPOINT (Default Command to Execute at Runtime)
    EXPOSE (Incoming Ports)
    ENV (Environment Variables)
    VOLUME (Shared Filesystems)
    USER
    WORKDIR


* :ref:`run-cmd`
* :ref:`run-entrypoint`
* :ref:`expose-incoming-ports`
* :ref:`run-env`
* :ref:`run-volume`
* :ref:`run-user`
* :ref:`run-workdir`

.. CMD (default command or options)

.. _run-cmd:

CMD（デフォルトのコマンドかオプション）
----------------------------------------

.. Recall the optional COMMAND in the Docker commandline:

Docker コマンドラインでのオプション ``コマンド`` を取り消します。

.. code-block:: bash

   $ docker run [オプション] イメージ[:タグ|@DIGEST] [コマンド] [引数...]

.. This command is optional because the person who created the IMAGE may have already provided a default COMMAND using the Dockerfile CMD instruction. As the operator (the person running a container from the image), you can override that CMD instruction just by specifying a new COMMAND.

このコマンドは様々なオプションを指定します。 ``イメージ`` の作者が Dockerfile の ``CMD`` 命令を使い、デフォルトの ``コマンド`` を既に設定している場合があるためです。作業者（イメージからコンテナを実行する人）は、 ``CMD`` 命令を上書きして新しい ``コマンド`` を実行します。

.. If the image also specifies an ENTRYPOINT then the CMD or COMMAND get appended as arguments to the ENTRYPOINT.

イメージに ``ENTRYPOINT`` も指定されていれば、 ``CMD`` や ``コマンド`` は ``ENTRYPOINT`` に対する引数となります。

.. ENTRYPOINT (default command to execute at runtime)

.. _run-entrypoint:

ENTRYPOINT（実行時に処理するデフォルトのコマンド）
--------------------------------------------------

.. code-block:: bash

    --entrypoint="": Overwrite the default entrypoint set by the image

.. The ENTRYPOINT of an image is similar to a COMMAND because it specifies what executable to run when the container starts, but it is (purposely) more difficult to override. The ENTRYPOINT gives a container its default nature or behavior, so that when you set an ENTRYPOINT you can run the container as if it were that binary, complete with default options, and you can pass in more options via the COMMAND. But, sometimes an operator may want to run something else inside the container, so you can override the default ENTRYPOINT at runtime by using a string to specify the new ENTRYPOINT. Here is an example of how to run a shell in a container that has been set up to automatically run something else (like /usr/bin/redis-server):

イメージの ``ENTRYPOINT`` は ``コマンド`` と似ています。これはコンテナを開始する時に実行するコマンドを指定しているためです。しかし、こちらは（意図的に）上書きを難しくしています。 ``ENTRYPOINT`` が提供するのは、コンテナ自身が持つデフォルトの特性や振る舞いです。そのため ``ENTRYPOINT`` を指定しておけば、コンテナ実行時、あたかもコンテナ自身をバイナリのようにして実行可能です。その場合は、デフォルトのオプションを持っているでしょうし、あるいは自分で ``コマンド`` を指定してオプションを指定することも可能です。しかし、時々オペレータはコンテナの中で何らかのコマンドを実行したい場合もあるでしょう。例えば、デフォルトの ``ENTRYPOINT`` の代わりに、自分で ``ENTRYPOINT`` を新たに指定したい場合です。次の例はコンテナ上でシェルを実行するものであり、同様に何らかのもの（ ``/usr/bin/redis-server`` のように ）を自動的に起動できます。

.. code-block:: bash

   $ docker run -i -t --entrypoint /bin/bash example/redis

.. or two examples of how to pass more parameters to that ENTRYPOINT:

あるいは、次の２つの例は ENTRYPOINT に更にパラメータを渡すものです。

.. code-block:: bash

   $ docker run -i -t --entrypoint /bin/bash example/redis -c ls -l
   $ docker run -i -t --entrypoint /usr/bin/redis-cli example/redis --help

.. EXPOSE (incoming ports)

.. _expose-incoming-ports:

EXPOSE （露出用のポート）
------------------------------

.. The following run command options work with container networking:

``run`` コマンドには、コンテナのネットワークに対応する以下のオプションがあります。

.. code-block:: bash

   --expose=[]: コンテナ内のポートまたはポート範囲を露出する
                これらは「EXPOSE」命令の露出ポートに追加する
   -P=false   : 全ての露出ポートをホスト側インターフェースに公開する
   -p=[]      : コンテナのポートまたはポート範囲をホスト側に公開する
                  書式: ip:ホスト側ポート:コンテナ側ポート | ip::コンテナ側ポート | ホスト側ポート:コンテナ側ポート | コンテナ側ポート
                  ホスト側ポートとコンテナ側のポートは、どちらもポート範囲を指定可能です。
                  両方で範囲を指定した時は、コンテナ側のポート範囲とホスト側のポート範囲が
                  一致する必要があります。例：
                      -p 1234-1236:1234-1236/tcp
   
                  ホスト側のポート範囲しか指定しない時は、コンテナ側ポートが範囲になるとは限りません。
                  このような場合、コンテナ側で公開されるポートはホスト側のポート範囲のいずれかです。
                   (例 -p 1234-1236:1234/tcp )
   
                  (実際の割り当てを確認するには ``docker port`` を使う)
   
   --link=""  : 他のコンテナに対するリンクを追加 (<名前 or id>:エイリアス or <名前 or id>)

.. With the exception of the EXPOSE directive, an image developer hasn’t got much control over networking. The EXPOSE instruction defines the initial incoming ports that provide services. These ports are available to processes inside the container. An operator can use the --expose option to add to the exposed ports.

イメージの開発者は、``EXPOSE`` 命令以外のネットワーク機能に関する管理は行えません。 ``EXPOSE`` 命令が定義するのは、サービスが初期化時に提供する受信用ポートです。このポートはコンテナの中のプロセスが利用可能にします。作業者は ``--expose`` オプションを使い、公開用ポートを追加できます。

.. To expose a container’s internal port, an operator can start the container with the -P or -p flag. The exposed port is accessible on the host and the ports are available to any client that can reach the host.

コンテナの内部ポートを露出（expose）するために、オペレータはコンテナ実行時に ``-P``  か ``-p`` フラグを使えます。公開用のポートはホスト上でアクセス可能であり、そのポートはホストに到達可能なクライアントであれば誰でも利用できます。

.. The -P option publishes all the ports to the host interfaces. Docker binds each exposed port to a random port on the host. The range of ports are within an ephemeral port range defined by /proc/sys/net/ipv4/ip_local_port_range. Use the -p flag to explicitly map a single port or range of ports.

``-P`` オプションはホスト・インターフェース上に全てのポートを公開します。Docker は公開されたポートを、ホスト側のポートに対してランダムに拘束（bind）します。このポートの範囲を *エフェメラル・ポート範囲（ephemeral port range）* と呼び、 ``/proc/sys/net/ipv4/ip_local_port_range`` によって定義されています。 ``-p`` フラグを使うと、特定のポートやポートの範囲を割り当てます。

.. The port number inside the container (where the service listens) does not need to match the port number exposed on the outside of the container (where clients connect). For example, inside the container an HTTP service is listening on port 80 (and so the image developer specifies EXPOSE 80 in the Dockerfile). At runtime, the port might be bound to 42800 on the host. To find the mapping between the host ports and the exposed ports, use docker port.

コンテナ内のポート番号（サービスがリッスンしているポート番号）は、コンテナの外に露出するポート番号（クライアントが接続する番号）と一致させる必要がありません。例えば、コンテナ内の HTTP サービスがポート 80 をリッスンしているとします（そして、イメージ開発者は Dockerfile で ``EXPOSE 80`` を指定しているでしょう ）。実行する時に、ホスト側のポート 42800 以上が使われます。公開用ポートがホスト側のどのポートに割り当てられたかを確認するには、 ``docker port`` コマンドを使います。

.. If the operator uses --link when starting a new client container in the default bridge network, then the client container can access the exposed port via a private networking interface. If --link is used when starting a container in a user-defined network as described in Docker network overview””), it will provide a named alias for the container being linked to.

デフォルトのブリッジ・ネットワークにおいて、新しいクライアント・コンテナの起動時にオペレータが ``--link`` を指定したら、クライアント・コンテナはプライベートなネットワーク・インターフェースを経由して公開ポートにアクセスできます。 :doc:`Docker ネットワーク概要 </engine/userguide/networking/index>` にあるユーザ定義ネットワーク上で ``--link`` を指定したら、コンテナをリンクするためのエイリアス名を作成します。

.. ENV (environment variables)

.. _run-env:

ENV（環境変数）
--------------------

.. When a new container is created, Docker will set the following environment variables automatically:

新しいコンテナの作成時、Docker は以下の環境変数を自動的に設定します。

.. Variable 	Value
   HOME 	Set based on the value of USER
   HOSTNAME 	The hostname associated with the container
   PATH 	Includes popular directories, such as :
   /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   TERM 	xterm if the container is allocated a pseudo-TTY

.. list-table::
   :header-rows: 1
   
   * - 変数
     - 値
   * - ``HOME``
     - ``USER`` の値を元にして指定
   * - ``HOSTNAME``
     - コンテナに関連づけるホスト名
   * - ``PATH``
     - ``/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin`` のような一般的なディレクトリを含む
   * - ``TERM``
     - コンテナが疑似ターミナル（pseudo-TTY）を割り当てるときは ``xterm``

.. Additionally, the operator can set any environment variable in the container by using one or more -e flags, even overriding those mentioned above, or already defined by the developer with a Dockerfile ENV:

更に、オペレータはコンテナに対して **環境変数の組み合わせ** を ``-e`` フラグで追加できます。先ほど言及した環境変数や、開発者が Dockerfile の中で ``ENV`` で定義済みの環境変数を上書きできます。

.. code-block:: bash

   $ docker run -e "deep=purple" --rm ubuntu /bin/bash -c export
   declare -x HOME="/"
   declare -x HOSTNAME="85bc26a0e200"
   declare -x OLDPWD
   declare -x PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
   declare -x PWD="/"
   declare -x SHLVL="1"
   declare -x container="lxc"
   declare -x deep="purple"

.. Similarly the operator can set the hostname with -h.

似たようなものとして、オペレータは ``-h`` で **hostname （ホスト名）** も定義できます。

.. HEALTHCHECK

.. _run-healthcheck:

HEALTHCHECK（ヘルスチェック）
------------------------------

.. code-block:: bash

     --health-interval       チェックを実行する間隔
     --health-retries        障害を報告するまでに必要な連続失敗回数
     --health-timeout        チェックを実行できる最長時間
     --no-healthcheck        コンテナ固有のヘルスチェックを無効化

.. Example:

例：

.. code-block:: bash

   $ docker run --name=test -d \
       --health-cmd='stat /etc/passwd || exit 1' \
       --health-interval=2s \
       busybox sleep 1d
   $ sleep 2; docker inspect --format='{{.State.Health.Status}}' test
   healthy
   $ docker exec test rm /etc/passwd
   $ sleep 2; docker inspect --format='{{json .State.Health}}' test
   {
     "Status": "unhealthy",
     "FailingStreak": 3,
     "Log": [
       {
         "Start": "2016-05-25T17:22:04.635478668Z",
         "End": "2016-05-25T17:22:04.7272552Z",
         "ExitCode": 0,
         "Output": "  File: /etc/passwd\n  Size: 334       \tBlocks: 8          IO Block: 4096   regular file\nDevice: 32h/50d\tInode: 12          Links: 1\nAccess: (0664/-rw-rw-r--)  Uid: (    0/    root)   Gid: (    0/    root)\nAccess: 2015-12-05 22:05:32.000000000\nModify: 2015..."
       },
       {
         "Start": "2016-05-25T17:22:06.732900633Z",
         "End": "2016-05-25T17:22:06.822168935Z",
         "ExitCode": 0,
         "Output": "  File: /etc/passwd\n  Size: 334       \tBlocks: 8          IO Block: 4096   regular file\nDevice: 32h/50d\tInode: 12          Links: 1\nAccess: (0664/-rw-rw-r--)  Uid: (    0/    root)   Gid: (    0/    root)\nAccess: 2015-12-05 22:05:32.000000000\nModify: 2015..."
       },
       {
         "Start": "2016-05-25T17:22:08.823956535Z",
         "End": "2016-05-25T17:22:08.897359124Z",
         "ExitCode": 1,
         "Output": "stat: can't stat '/etc/passwd': No such file or directory\n"
       },
       {
         "Start": "2016-05-25T17:22:10.898802931Z",
         "End": "2016-05-25T17:22:10.969631866Z",
         "ExitCode": 1,
         "Output": "stat: can't stat '/etc/passwd': No such file or directory\n"
       },
       {
         "Start": "2016-05-25T17:22:12.971033523Z",
         "End": "2016-05-25T17:22:13.082015516Z",
         "ExitCode": 1,
         "Output": "stat: can't stat '/etc/passwd': No such file or directory\n"
       }
     ]
   }

.. The health status is also displayed in the docker ps output.

``docker ps`` の出力からもヘルス・ステータスを表示できます。

.. TMPFS (mount tmpfs filesystems)

.. _run-tmpfs:

TMPFS （tmfps ファイルシステムのマウント）
--------------------------------------------------

.. code-block:: bash

   --tmpfs=[]: tmpfs マウントを作成: コンテナ側ディレクトリ[:<オプション>],
               オプションは Linux コマンドの 'mount -t tmpfs -o' オプションと同一形式

.. The example below mounts an empty tmpfs into the container with the rw, noexec, nosuid, and size=65536k options.

この例では、オプションで ``rw`` 、 ``noexec`` 、 ``nosuid`` 、 ``size=65536k`` 、コンテナに対して空の tmpfs をマウントしています。

.. code-block:: bash

   $ docker run -d --tmpfs /run:rw,noexec,nosuid,size=65536k my_image


.. VOLUME (shared filesystems)

.. _run-volume:

VOLUME（共有ファイルシステム）
------------------------------

.. code-block:: bash

   -v=[]: バインド（拘束）マウントを作成: [ホスト側ディレクトリ:]コンテナ側ディレクトリ[:<オプション>]
   オプションはカンマ区切りで [rw|ro] または [z|Z]、[[r]shared|[r]slave|[r]private]、そして [nocopy] から選択

.. The 'host-src' is an absolute path or a name value.

``host-src`` は絶対パスもしくは名前を値にします。

.. If neither 'rw' or 'ro' is specified then the volume is mounted in read-write mode.

``rw`` （読み書き）または ``ro`` （読み込み専用）の指定が無ければ、読み書き可能なモードでマウントします。

.. The `nocopy` modes is used to disable automatic copying requested volume path in the container to the volume storage location. For named volumes, `copy` is the default mode. Copy modes are not supported for bind-mounted volumes.

``nocopy`` モードを指定したら、コンテナ内に要求したボリューム・パスに対して、ボリュームを保存している場所からの自動コピーを無効にします。名前付きボリュームの場合は、 ``copy`` がデフォルトのモードです。コピー・モードではバインド・マウント（bind-mounted）したボリュームに対するコピーをサポートしていません。

.. code-block:: bash

   --volumes-from="": 指定したコンテナにある全てのボリュームをマウント

..    Note: The auto-creation of the host path has been deprecated.
..   ホスト側のパスを自動作成する機能は :ref:`廃止 <auto-creating-missing-host-paths-for-bind-mounts>` されました。

.. Note: When using systemd to manage the Docker daemon’s start and stop, in the systemd unit file there is an option to control mount propagation for the Docker daemon itself, called MountFlags. The value of this setting may cause Docker to not see mount propagation changes made on the mount point. For example, if this value is slave, you may not be able to use the shared or rshared propagation on a volume.

.. note::

   Docker デーモンの開始・停止を systemd で管理する場合は、 Docker デーモン自身がマウント・プロパゲーション（mount propagation）を管理できるよう、systemd の unit ファイル上で ``MountFlags`` というオプションを設定します。このマウントポイントが変更されても、Docker はマウント・プロパゲーションの変更を把握できません。例えば、値を ``slave`` としているのであれば、ボリュームのプロパゲーション値に ``shared`` や ``rshared`` を指定すべきではないでしょう。

.. The volumes commands are complex enough to have their own documentation in section Managing data in containers. A developer can define one or more VOLUME’s associated with an image, but only the operator can give access from one container to another (or from a container to a volume mounted on the host).

ボリューム関連コマンドは :doc:`/engine/userguide/containers/dockervolumes` セクション自身のドキュメントでも複雑なものです。開発者は１つまたは複数の ``VOLUME`` を作成し、イメージと関連づけることが可能です。しかし、作業者ができるのは、あるコンテナから別のコンテナに対してのみです（あるいは、コンテナからホスト側のボリュームにマウントする場合）。

.. The container-dir must always be an absolute path such as /src/docs. The host-dir can either be an absolute path or a name value. If you supply an absolute path for the host-dir, Docker bind-mounts to the path you specify. If you supply a name, Docker creates a named volume by that name.

``コンテナ側ディレクトリ`` は ``/src/docs`` のように常に絶対パスの必要があります。 ``ホスト側ディレクトリ`` は絶対パスか ``名前`` を値に指定できます。 ``ホスト側ディレクトリ`` に絶対パスを指定する場合は、 Docker は指定したパスを拘束マウント（bind-mounts）します。 ``名前`` を指定する場合は、Docker は ``名前`` を持つボリュームを作成します。

.. A name value must start with an alphanumeric character, followed by a-z0-9, _ (underscore), . (period) or - (hyphen). An absolute path starts with a / (forward slash).

``名前`` は英数字で始まる必要があり、以降は ``a-z0-9`` 、``_`` （アンダースコア）、 ``.`` （ピリオド）、 ``-`` （ハイフン）が使えます。絶対パスは ``/`` （フォアワード・スラッシュ）で始める必要があります。

.. For example, you can specify either /foo or foo for a host-dir value. If you supply the /foo value, Docker creates a bind-mount. If you supply the foo specification, Docker creates a named volume.

例えば、 ``ホスト側ディレクトリ`` の値に ``/foo`` か ``foo`` を指定したとします。 ``/foo`` 値を指定した場合は、Docker はホスト上に拘束マウントを作成します。 ``foo`` を指定したら、Docker は指定された名前でボリュームを作成します。

.. USER

.. _run-user:

USER
----------

.. root (id = 0) is the default user within a container. The image developer can create additional users. Those users are accessible by name. When passing a numeric ID, the user does not have to exist in the container.

   ``root`` （id = 0）はコンテナのでふぉると・ゆーざいです。イメージ開発者は追加ユーザを作成できます。これらのユーザは名前で関連づけられます。特定の ID を指定するときは、コンテナの中にユーザが存在しなくても構いません。

.. The developer can set a default user to run the first process with the Dockerfile USER instruction. When starting a container, the operator can override the USER instruction by passing the -u option.

開発者は Dockerfile の ``USER`` 命令を使い、１つめのプロセスを実行する時のユーザを定義できます。コンテナ起動時に ``-u`` オプションを使うと ``USER`` 命令を上書きできます。

.. code-block:: bash

   -u="", --user="": ユーザ名または UID を指定する命令。オプションでグループ名や GUID を指定

.. The followings examples are all valid:

以下は有効な例です。

.. code-block:: bash

   --user=[ user | user:group | uid | uid:gid | user:gid | uid:group ]

..     Note: if you pass a numeric uid, it must be in the range of 0-2147483647.

.. note::

   数値で UID を指定する場合は、0 ～ 2147483647 の範囲内の必要があります。

.. WORKDIR

.. _run-workdir:

WORKDIR
----------

.. The default working directory for running binaries within a container is the root directory (/), but the developer can set a different default with the Dockerfile WORKDIR command. The operator can override this with:

コンテナ内でバイナリを実行する時、デフォルトの作業用ディレクトリはルート( ``/`` ) ディレクトリです。しかし開発者は Dockerfile の ``WORKDIR`` コマンドを使い、デフォルトの作業用ディレクトリを変更できます。作業者が更に設定を上書きするには、次のようにします。

.. code-block:: bash

   -w="": コンテナ内の作業用（ワーキング）ディレクトリ

.. seealso:: 

   Docker run reference
      https://docs.docker.com/engine/reference/run/
