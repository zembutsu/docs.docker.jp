.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/config/daemon/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/config/daemon/index.md
   doc version: 19.03
.. check date: 2020/06/22
.. Commits on Apr 23, 2020 b0f90615659ac1319e8d8a57bb914e49d174242e
.. ---------------------------------------------------------------------------

.. Configure and troubleshoot the Docker daemon

.. _configure-and-troubleshoot-the-docker-daemon:

============================================================
Docker デーモンの設定とトラブルシュート
============================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. After successfully installing and starting Docker, the dockerd daemon runs with its default configuration. This topic shows how to customize the configuration, start the daemon manually, and troubleshoot and debug the daemon if you run into issues.

Docker のインストールに成功したら、 ``dockerd`` デーモンはデフォルトの設定で動いています。このトピックで扱うのは、どのようにして設定を変更するか、手動でデーモンを起動する方法、トラブルシュート、実行に問題があればデーモンのデバッグの仕方です。

.. Start the daemon using operating system utilities

.. _start-the-daemon-using-operating-system-utilities:

オペレーティングシステムのユーティリティでデーモンを起動
============================================================

.. On a typical installation the Docker daemon is started by a system utility, not manually by a user. This makes it easier to automatically start Docker when the machine reboots.

Docker デーモンを典型的にインストールすると、Docker デーモンの起動はユーザが手動で行うのではなく、システム・ユーティリティによって起動されます。これにより、マシンの再起動時に、自動的に Docker を起動するのが簡単になります。

.. The command to start Docker depends on your operating system. Check the correct page under Install Docker. To configure Docker to start automatically at system boot, see Configure Docker to start on boot.

Docker の起動コマンドは、利用しているオペレーティングシステムに依存します。 :doc:`Docker インストール </engine/install>` 以下にある適切なページをご覧ください。システム起動時の Docker 自動起動に関する調整は、 :ref:`ブート時に Docker を起動する設定 <configure-docker-to-start-on-boot>` をご覧ください。

.. Start the daemon manually

.. _start-the-daemon-manually:

デーモンを手動で起動
==============================

.. If you don’t want to use a system utility to manage the Docker daemon, or just want to test things out, you can manually run it using the dockerd command. You may need to use sudo, depending on your operating system configuration.

システム・ユーティリティを使わずに Docker デーモンを管理したい場合や、純粋にテストだけを行いたい場合に、 ``dockerd`` コマンドを使って手動で実行できます。場合によっては ``sudo`` が必要になるかもしれませんが、お使いのオペレーティングシステムの設定に依存します。

.. When you start Docker this way, it runs in the foreground and sends its logs directly to your terminal.

Docker をこの方法で起動すると、Docker はフォアグラウンドで実行され、自身のログはターミナル上に直接送ります。

.. code-block:: bash

   $ dockerd
   
   INFO[0000] +job init_networkdriver()
   INFO[0000] +job serveapi(unix:///var/run/docker.sock)
   INFO[0000] Listening for HTTP on unix (/var/run/docker.sock)

.. To stop Docker when you have started it manually, issue a Ctrl+C in your terminal.

手動で起動した Docker を停止するには、ターミナル上で ``Ctrl+C`` を実行します。

.. Configure the Docker daemon

.. _configure-the-docker-daemon:

Docker デーモンの設定
==============================

.. There are two ways to configure the Docker daemon:

Docker デーモンの設定を変更するには、２つの方法があります。

..  Use a JSON configuration file. This is the preferred option, since it keeps all configurations in a single place.
    Use flags when starting dockerd.

* JSON 設定ファイルを使う方法。全ての設定情報を１ヵ所にまとめているため、望ましいオプション
* ``dockerd`` で起動時にフラグを付ける方法

.. You can use both of these options together as long as you don’t specify the same option both as a flag and in the JSON file. If that happens, the Docker daemon won’t start and prints an error message.

フラグと JSON ファイルで同じオプションを指定しなければ、両方の選択肢を同時に利用できます。その際、 Docker デーモンが起動できなければ、エラーメッセージを表示します。

.. To configure the Docker daemon using a JSON file, create a file at /etc/docker/daemon.json on Linux systems, or C:\ProgramData\docker\config\daemon.json on Windows. On MacOS go to the whale in the taskbar > Preferences > Daemon > Advanced.

Docker デーモンを JSON ファイルで設定するには、Linux システム上では ``/etc/docker/daemon.json`` にファイルを作成するか、Windows 上では ``C:\ProgramData\docker\config\daemon.json`` を作成します。Mac OS ではタスクバーの鯨アイコンから Preferences > Daemon > Advanced を選択します。

.. Here’s what the configuration file looks like:

設定ファイルとは、以下のような形式です。

.. code-block:: json

   {
     "debug": true,
     "tls": true,
     "tlscert": "/var/docker/server.pem",
     "tlskey": "/var/docker/serverkey.pem",
     "hosts": ["tcp://192.168.59.3:2376"]
   }

.. With this configuration the Docker daemon runs in debug mode, uses TLS, and listens for traffic routed to 192.168.59.3 on port 2376. You can learn what configuration options are available in the dockerd reference docs

この設定を使って Docker デーモンを起動すると、デバッグモードで起動し、TLS を使い、 ``192.168.59.3`` のポート ``2376`` へリッスンしているトラフィックを転送します。設定情報のオプションに関する情報は :ref:`dockerd リファレンス・ドキュメント <daemon-configuration-file>` をご覧ください。

.. You can also start the Docker daemon manually and configure it using flags. This can be useful for troubleshooting problems.

また、Docker デーモンを手動かつフラグを設定して起動することもできます。これは問題のトラブルシューティングに役立ちます。

.. Here’s an example of how to manually start the Docker daemon, using the same configurations as above:

以下の理恵は、Docker デーモンを手動で起動し、先ほどの設定と同じオプションを指定しています。

.. code-block:: bash

   dockerd --debug \
     --tls=true \
     --tlscert=/var/docker/server.pem \
     --tlskey=/var/docker/serverkey.pem \
     --host tcp://192.168.59.3:2376

.. You can learn what configuration options are available in the dockerd reference docs, or by running:

どのような設定オプションが利用可能かどうかを知るには、 :doc:`dockerd リファレンス・ドキュメント</engine/reference/commandline/dockerd>` か、次のように実行します。

.. code-block:: bash

   dockerd --help

.. Many specific configuration options are discussed throughout the Docker documentation. Some places to go next include:

Docker ドキュメント上で、様々な設定オプションが話題に上がっています。次にご覧ください。

..  Automatically start containers
    Limit a container’s resources
    Configure storage drivers
    Container security

* :doc:`/config/containers/start-containers-automatically`
* :doc:`/config/containers/resource_constraints`
* :doc:`/storage/storagedriver/select-storage-driver`
* :doc:`/engine/security`

.. Docker daemon directory

.. _docker-daemon-directory:

Docker デーモンのディレクトリ
==============================

.. The Docker daemon persists all data in a single directory. This tracks everything related to Docker, including containers, images, volumes, service definition, and secrets.

Docker デーモンは全てのデータを１つのディレクトリ内に保存します。この場所に Docker に関連する全てがおかれており、コンテナ、イメージ、ボリューム、サービス定義、シークレットがあります。

.. By default this directory is:

このディレクトリはデフォルトで、以下の通りです。

..  /var/lib/docker on Linux.
    C:\ProgramData\docker on Windows.

* Linux 上では ``/var/lib/docker`` 
* Windows 上では ``C:\ProgramData\docker`` 

.. You can configure the Docker daemon to use a different directory, using the data-root configuration option.

Docker デーモンの設定により、オプションで ``data-root`` を設定すると 、ここで利用するディレクトリを変更できます。

.. Since the state of a Docker daemon is kept on this directory, make sure you use a dedicated directory for each daemon. If two daemons share the same directory, for example, an NFS share, you are going to experience errors that are difficult to troubleshoot.

Docker デーモンはこのディレクトリ上で状態を保持するため、各デーモンがそれぞれ専用のディレクトリを使う必要があります。例えば NFS 共有のようなディレクトリで、もしも２つのデーモンが同じディレクトリを共有すると、問題解決が困難なエラーに直面することになるでしょう。

.. Troubleshoot the daemon

.. _troubleshoot-the-daemon:

デーモンのトラブルシュート
==============================

.. You can enable debugging on the daemon to learn about the runtime activity of the daemon and to aid in troubleshooting. If the daemon is completely non-responsive, you can also force a full stack trace of all threads to be added to the daemon log by sending the SIGUSR signal to the Docker daemon.

デーモンに対するデバッギングを有効化すると、デーモンのランタイム動作に関して知ることができるようになり、トラブルシューティングに役立ちます。もし、デーモンが完全に無応答であれば、Docker デーモンに対して ``SIGUSR`` シグナルを送信し、全てのスレッドに対してデーモンのログを追加出来るよう、 :ref:`スタック・トレースの強制によるログ記録 <force-a-stack-trace-to-be-logged>` も行えます。

.. Troubleshoot conflicts between the daemon.json and startup scripts

.. _troubleshoot-conflicts-between-the-daemon.json-and-startup-scripts:

``daemon.json`` とスタートアップ・スクリプト間で競合した時のトラブルシュート
--------------------------------------------------------------------------------

.. If you use a daemon.json file and also pass options to the dockerd command manually or using start-up scripts, and these options conflict, Docker fails to start with an error such as:

``daemon.json`` ファイルの利用と、 ``dockerd`` コマンドに対して手動もしくはスタートアップ・スクリプトでオプション指定の利用を同時に利用すると、お互いのオプションが競合するとき、Docker は起動できず、次のようなエラーを出力します。

::

   unable to configure the Docker daemon with file /etc/docker/daemon.json:
   the following directives are specified both as a flag and in the configuration
   file: hosts: (from flag: [unix:///var/run/docker.sock], from file: [tcp://127.0.0.1:2376])

.. If you see an error similar to this one and you are starting the daemon manually with flags, you may need to adjust your flags or the daemon.json to remove the conflict.

もしも、フラグを付けてデーモンを手動で起動するときと似たようなエラーであれば、フラグの設定を調整するか、衝突を避けるために ``daemon.json`` を削除します。

..    Note: If you see this specific error, continue to the next section for a workaround.

.. note::

   これが何らかの具体的なエラーであれば、 :ref:`次のセクション <use-the-hosts-key-in-daemonjson-with-systemd>` を参照して回避してください。

.. If you are starting Docker using your operating system’s init scripts, you may need to override the defaults in these scripts in ways that are specific to the operating system.

オペレーティングシステムの init スクリプトで Docker を起動しようとしている場合は、特定のオペレーティングシステムを対象としたデフォルトのスタートアップ・スクリプトで上書きする必要があるかもしれません。

.. Use the hosts key in daemon.json with systemd

.. _:use-the-hosts-key-in-daemonjson-with-systemd:

systemd で daemon.json にホストキーを使う
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. One notable example of a configuration conflict that is difficult to troubleshoot is when you want to specify a different daemon address from the default. Docker listens on a socket by default. On Debian and Ubuntu systems using systemd, this means that a host flag -H is always used when starting dockerd. If you specify a hosts entry in the daemon.json, this causes a configuration conflict (as in the above message) and Docker fails to start.

設定が競合する有名な例として、デーモンをデフォルトとは異なる場所へ指定しようとする時は、トラブルシュートが大変です。Docker はデフォルトでソケットを通してリッスンしようとします。Debian と Ubuntu のシステム上では ``systemd`` を使います。つまり、 ``dockerd`` の起動時に、常にホストフラグ ``-H`` を使うのを意味します。もしも ``daemon.json`` に ``hosts`` エントリを指定しても、これによって（前述の）設定ファイルの競合を引き起こし、Docker は起動に失敗します。

.. To work around this problem, create a new file /etc/systemd/system/docker.service.d/docker.conf with the following contents, to remove the -H argument that is used when starting the daemon by default.

この問題に対処するには、以下の内容の新しいファイル ``/etc/systemd/system/docker.service.d/docker.conf`` を作成し、デフォルトでデーモン起動時に  ``-H`` 引数を使わないよう削除します。

::

   [Service]
   ExecStart=
   ExecStart=/usr/bin/dockerd

.. There are other times when you might need to configure systemd with Docker, such as configuring a HTTP or HTTPS proxy.

他にも、 :ref:`HTTP や HTTPS プロキシの設定 <httphttps-proxy>` のように、Docker で ``systemd`` の設定が必要になる場合があるでしょう。

..    Note: If you override this option and then do not specify a hosts entry in the daemon.json or a -H flag when starting Docker manually, Docker fails to start.

.. note::

   Docker を手動で起動するとき、 このオプションを上書きし、 ``daemon.json`` の ``hosts`` エントリや ``-H`` フラグの指定が無ければ、Docker は起動に失敗します。

.. Run sudo systemctl daemon-reload before attempting to start Docker. If Docker starts successfully, it is now listening on the IP address specified in the hosts key of the daemon.json instead of a socket.

Docker を起動しようとする前に、 ``sudo systemctl daemon-reload`` を実行します。Docker が起動に成功すると、ソケットではなく、 ``daemon.json`` の ``hosts``  キーで指定した IP アドレスでリッスンします。

..    Important: Setting hosts in the daemon.json is not supported on Docker Desktop for Windows or Docker Desktop for Mac.

.. important::

   ``daemon.json`` での ``hosts`` 設定は、 Docker Desktop for Windows や Docker Desktop for Mac ではサポートされていません。

.. Out Of Memory Exceptions (OOME)

.. out-of-memory-exceptions-oome

Out Of Memory Exception (OOME)
----------------------------------------

.. If your containers attempt to use more memory than the system has available, you may experience an Out Of Memory Exception (OOME) and a container, or the Docker daemon, might be killed by the kernel OOM killer. To prevent this from happening, ensure that your application runs on hosts with adequate memory and see Understand the risks of running out of memory.

システムで利用可能なメモリよりも、多くのメモリ利用をコンテナが試みようとすると、Out Of Memory Exception (OOME) が発生し、 Docker あるいは Docker デーモンがカーネル OOM killer によって強制停止されるでしょう。この挙動を防ぐためには、ホスト上で実行するアプリケーションに対し、十分なメモリを割り当ててから実行します。詳細は :ref:`Out of Memory を引き起こすリスクの理解 <understand-the-risks-of-running-out-of-memory>` をご覧ください

.. Read the logs

ログを読む
--------------------

.. The daemon logs may help you diagnose problems. The logs may be saved in one of a few locations, depending on the operating system configuration and the logging subsystem used:

デーモンのログは問題の解析に役立つでしょう。ログは1ヵ所に保存されますが、オペレーティングシステムの設定と、サブシステムが使っているログ記録システムに依存します。

* オペレーティングシステム
  * 場所
* RHEL, Oracle Linux
   * ``/var/log/messages``
* Debian
   * ``/var/log/daemon.log``
* Ubuntu 16.04+, CentOS
   * コマンド ``journalctl -u docker.service`` を使用
* Ubuntu 14.10-
   * ``/var/log/upstart/docker.log``
* macOS (Docker 18.01+)
   * ``~/Library/Containers/com.docker.docker/Data/vms/0/console-ring``
* macOS (Docker <18.01)
   * ``~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/console-ring``
* Windows
   * ``AppData\Local``

.. Enable debugging

デバッギングの有効化
--------------------

.. There are two ways to enable debugging. The recommended approach is to set the debug key to true in the daemon.json file. This method works for every Docker platform.

デバッグを有効化するには2つの方法があります。推奨する方法は、 ``daemon.json`` ファイル中で ``debug`` キーを ``true`` に設定するものです。この手法は全ての Docker プラットフォームで動作します。

..    Edit the daemon.json file, which is usually located in /etc/docker/. You may need to create this file, if it does not yet exist. On macOS or Windows, do not edit the file directly. Instead, go to Preferences / Daemon / Advanced.

1. ``daemon.json`` ファイルを編集します。通常は ``/etc/docker`` にあります。ファイルが存在していなければ、このファイルを作る必要があります。macOS や Windows であれば、このディレクトリは編集しないで、かわりに **Preferences > Daemon > Advanced** で設定します。

..    If the file is empty, add the following:

2. ファイルが空っぽであれば、次の様に追加します。

::

   {
     "debug": true
   }

..    If the file already contains JSON, just add the key "debug": true, being careful to add a comma to the end of the line if it is not the last line before the closing bracket. Also verify that if the log-level key is set, it is set to either info or debug. info is the default, and possible values are debug, info, warn, error, fatal.

既に JSON ファイルが存在していれば、 ``"debug": true`` のキーのみ追加します。このとき、この記述がカッコ（ブランケット）を閉じる直前の行でなければ、行末にカンマ記号を追加する必要がありますので注意してください。また、もしも ``log-level`` キーを設定している場合、そこでは ``info`` か ``debug`` が指定されているか確認します。 ``info`` はデフォルトであり、変更可能な値は ``debug`` 、 ``info``、  ``warn`` 、 ``error`` 、 ``fatal`` です。

..    Send a HUP signal to the daemon to cause it to reload its configuration. On Linux hosts, use the following command.

3. 設定情報を再読込するため、デーモンに対して ``HUB`` シグナルを送信します。 Linux ホスト上では以下のコマンドを使います。

.. code-block:: bash

   $ sudo kill -SIGHUP $(pidof dockerd)

..    On Windows hosts, restart Docker.

Windows ホスト上では Docker を再起動します。

.. Instead of following this procedure, you can also stop the Docker daemon and restart it manually with the debug flag -D. However, this may result in Docker restarting with a different environment than the one the hosts’ startup scripts create, and this may make debugging more difficult.

以上の手順のほかに、Docker デーモンを停止し、手動で Docker デーモンを起動する時にデバッグ用のフラグ ``-D`` を付ける方法もあります。しかしながら、通常ホスト側のスタートアップ・スクリプトによって作成する Docker 環境とは、異なる環境が起動してしまう場合もあります。そして、そうなればデバッグが困難になるでしょう。

.. Force a stack trace to be logged

.. _force-a-stack-trace-to-be-logged:

スタック・トレースのログ記録を強制
----------------------------------------

.. If the daemon is unresponsive, you can force a full stack trace to be logged by sending a SIGUSR1 signal to the daemon.

デーモンの反応がなくなった場合、 ``SIGUSR1`` をデーモンに送ると、 完全なスタック・トレースの強制によってログを記録できます。

..    Linux:

* Linux :

   .. code-block:: bash
   
      $ sudo kill -SIGUSR1 $(pidof dockerd)

..    Windows Server:

* Windows Server:

   * `docker-signal <https://github.com/moby/docker-signal>`_ のダウンロード
   * ``Get-Process dockerd`` で dockerd の ID を取得
   * ``--pid=<デーモンのPID>`` を付けて実行

..    Download docker-signal.

..    Get the process ID of dockerd Get-Process dockerd.

..    Run the executable with the flag --pid=<PID of daemon>.

.. This forces a stack trace to be logged but does not stop the daemon. Daemon logs show the stack trace or the path to a file containing the stack trace if it was logged to a file.

このスタック・トレースの強制は、デーモンを停止せずにログを記録します。デーモンのログは、スタック・トレース上、あるいは、ファイルにスタック・トレースを記録する設定をしている場合は、そのパスにあるファイルに記録します。

.. The daemon continues operating after handling the SIGUSR1 signal and dumping the stack traces to the log. The stack traces can be used to determine the state of all goroutines and threads within the daemon.

``SIGUSR1``  シグナルを受けてもデーモンは操作を実行し、スタック・トレースのログを送り続けます。スタック・トレースによって、全ての goroutine の状態や、デーモンないのスレッド状況が分かるでしょう。

.. View stack traces

スタックトレースの表示
------------------------------

.. The Docker daemon log can be viewed by using one of the following methods:

Docker デーモンのログ表示は、以下の方法どちらかを使って行えます。

..  By running journalctl -u docker.service on Linux systems using systemctl
    /var/log/messages, /var/log/daemon.log, or /var/log/docker.log on older Linux systems

* Linux システム上では ``systemctl`` を使い、 ``journalctl -u docker.service`` を実行します。
* 以前の Linux システム上では ``/var/log/messages`` 、 ``/var/log/daemon.log`` 、 ``/var/log/docker.log`` を読みます。

..    Note: It is not possible to manually generate a stack trace on Docker Desktop for Mac or Docker Desktop for Windows. However, you can click the Docker taskbar icon and choose Diagnose and feedback to send information to Docker if you run into issues.

.. note::

   Docker Desktop for Mac や Docker Desktop for Windows 上では、スタック・トレースを手動で生成することができません。ですが、問題が発生した時は、 Docker タスクバーアイコンをクリックし、 **Diagnose and feedbak**  を選択し、Docker に対して情報を送信できます。

.. Look in the Docker logs for a message like the following:

Docker のログに表示される文字列は、以下のようなものです。

::

   ...goroutine stacks written to /var/run/docker/goroutine-stacks-2017-06-02T193336z.log
   ...daemon datastructure dump written to /var/run/docker/daemon-data-2017-06-02T193336z.log

.. The locations where Docker saves these stack traces and dumps depends on your operating system and configuration. You can sometimes get useful diagnostic information straight from the stack traces and dumps. Otherwise, you can provide this information to Docker for help diagnosing the problem.

Docker がこれらスタック・トレースおよびダンプ情報をどこに記録するかは、利用しているオペレーティングシステムと設定に依存します。スタック・トレースとダンプから直接解析した情報が、役に立つ場合があるでしょう。あるいは、問題の解析のために、Docker への送信が役立つ場合もあるでしょう。

.. Check whether Docker is running

.. _check-whether-docker-is-running:

どこにある Docker が動作しているか確認
----------------------------------------

.. The operating-system independent way to check whether Docker is running is to ask Docker, using the docker info command.

Docker がどこで動作しているかはオペレーティングシステムによって別々ですが、確認するには ``docker info``  コマンドを実行します。

.. You can also use operating system utilities, such as sudo systemctl is-active docker or sudo status docker or sudo service docker status, or checking the service status using Windows utilities.

また、オペレーティングシステムのユーティリティも利用できます。 ``sudo systemctl is-active docker`` や ``sudo status docker`` や ``sudo service docker status`` や、Windows ユーティリティを使ったサービスを確認できます。

.. Finally, you can check in the process list for the dockerd process, using commands like ps or top.

あとは、 ``dockerd`` プロセスのプロセスリストを確認するには、 ``ps`` や ``top`` のようなコマンドを使います。

.. seealso:: 

   Configuring and running Docker on various distributions
      https://docs.docker.com/config/daemon/
