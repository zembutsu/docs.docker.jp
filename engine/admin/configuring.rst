.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/admin/configuring/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/admin/configuring.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/admin/configuring.md
.. check date: 2016/06/21
.. Commits on Jun 14, 2016 3020081e94277410984c62d12f88de3d4f258681
.. ---------------------------------------------------------------------------

.. Configuring and running Docker on various distributions

.. _configuring-and-running Docker on various distributions:

============================================================
各システムの Docker 設定と実行
============================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. After successfully installing Docker, the docker daemon runs with its default configuration.

Docker のインストールに成功したら、 ``docker`` デーモンはデフォルトの設定で動いています。

.. In a production environment, system administrators typically configure the docker daemon to start and stop according to an organization’s requirements. In most cases, the system administrator configures a process manager such as SysVinit, Upstart, or systemd to manage the docker daemon’s start and stop.

プロダクション環境では、システム管理者は組織における必要性に従い、 ``docker`` デーモンの設定を変更し、起動・停止するでしょう。ほとんどの場合、システム管理者は ``docker`` デーモンの起動・停止のために ``SysVinit`` 、 ``Upstart`` 、 ``systemd`` といったプロセス・マネージャを設定するでしょう。

.. Running the docker daemon directly

docker デーモンを直接実行
==============================

.. The docker daemon can be run directly using the dockerd command. By default it listens on the Unix socket unix:///var/run/docker.sock

``docker`` デーモンは ``dockerd`` コマンドで直接操作できます。デフォルトでは Unix ソケット ``unix:///var/run/docker.sock`` をリッスンします。

.. code-block:: bash

   $ dockerd
   
   INFO[0000] +job init_networkdriver()
   INFO[0000] +job serveapi(unix:///var/run/docker.sock)
   INFO[0000] Listening for HTTP on unix (/var/run/docker.sock)
   ...
   ...

.. Configuring the docker daemon directly

docker デーモンを直接設定
==============================

.. If you’re running the docker daemon directly by running docker daemon instead of using a process manager, you can append the configuration options to the docker run command directly. Other options can be passed to the docker daemon to configure it.

プロセス・マネージャの代わりに、``docker daemon`` コマンドを使って ``docker`` デーモンを直接実行できます。 ``docker`` をコマンドで直接実行時に、オプション設定を追加可能です。 ``docker`` デーモンを設定するための他のオプションも追加できます。

.. Some of the daemon’s options are:

デーモンで利用可能なオプション：

.. Flag 	Description
   -D, --debug=false 	Enable or disable debug mode. By default, this is false.
   -H,--host=[] 	Daemon socket(s) to connect to.
   --tls=false 	Enable or disable TLS. By default, this is false.

.. list-table::
   :widths: 50 50
   :header-rows: 1
   
   * - フラグ
     - 説明
   * - ``-D`` , ``--debug=false``
     - デバッグ・モードの有効化と無効化。デフォルトは false
   * - ``-H`` , ``--host=[]``
     - デーモンが接続するソケット
   * - ``--tls=false``
     - TLS の有効化と無効化。デフォルトは false

.. Here is an example of running the docker daemon with configuration options:

以下は ``docker`` デーモンに設定オプションを付けて実行する例です。

.. code-block:: bash

   $ dockerd -D --tls=true --tlscert=/var/docker/server.pem    --tlskey=/var/docker/serverkey.pem -H tcp://192.168.59.3:2376

.. These options :

３つのオプションがあります：

..    Enable -D (debug) mode
    Set tls to true with the server certificate and key specified using --tlscert and --tlskey respectively
    Listen for connections on tcp://192.168.59.3:2376

* ``-D`` （デバッグ）モードの有効化
* ``tls`` を有効にするため、サーバ証明書と鍵を ``--tlscert`` と ``--tlskey`` で個々に指定
* ``tcp://192.168.59.3:2376`` への接続をリッスン

.. The command line reference has the complete list of daemon flags with explanations.

コマンドライン・リファレンスの :doc:`デーモンのフラグ一覧 </engine/reference/commandline/dockerd>` に説明があります。

.. Daemon debugging

.. _daemon-debugging:

デーモンのデバッグ
--------------------

.. As noted above, setting the log level of the daemon to “debug” or enabling debug mode with -D allows the administrator or operator to gain much more knowledge about the runtime activity of the daemon. If faced with a non-responsive daemon, the administrator can force a full stack trace of all threads to be added to the daemon log by sending the SIGUSR1 signal to the Docker daemon. A common way to send this signal is using the kill command on Linux systems. For example, kill -USR1 <daemon-pid> sends the SIGUSR1 signal to the daemon process, causing the stack dump to be added to the daemon log.

更に捕捉しますと、管理者やオペレータがデーモンの実行時の挙動に関して、更に詳細な情報を得るには、デーモンのログレベルを「debug」に設定するか、 ``-D`` オプションを付けてデバッグ・モードにします。デーモンからの応答が無くても、Docker デーモンに対して ``SIGUSR1``  シグナルを送信することで、デーモンのログに追加された全てのスレッドを強制的に追跡します。Linux システム上でシグナルを送る一般的な方法は ``kill`` シグナルを使います。例えば ``kill -USR1 <デーモンのpid>`` を実行したら、デーモンのプロセスに ``SIGUSR1`` シグナルを送信し、スタック・ダンプをデーモンのログに追加します。

..    Note: The log level setting of the daemon must be at least “info” level and above for the stack trace to be saved to the logfile. By default the daemon’s log level is set to “info”.

.. note::

  スタック・トレースをログに保存するには、 デーモンのログレベルの設定は少なくとも「info」レベル以上にする必要があります。デフォルトのデーモンのログレベルは「info」に設定されています。

.. The daemon will continue operating after handling the SIGUSR1 signal and dumping the stack traces to the log. The stack traces can be used to determine the state of all goroutines and threads within the daemon.

デーモンは ``SIGUSR1`` シグナルを受け取った後、スタック・トレースをダンプしてログに出力します。スタック・トレースはデーモン内部の全ての goroutine の状態とスレッドの把握に使えます。

.. Ubuntu

Ubuntu
==========

.. As of 14.04, Ubuntu uses Upstart as a process manager. By default, Upstart jobs are located in /etc/init and the docker Upstart job can be found at /etc/init/docker.conf.

Ubuntu ``14.04`` からはプロセス・マネージャに Upstart を使います。デフォルトでは、Upstart のジョブは ``/etc/init`` に保管され、 ``docker`` Upstart ジョブは ``/etc/init/docker.conf`` にあります。

.. After successfully installing Docker for Ubuntu, you can check the running status using Upstart in this way:

:doc:`Ubuntu で Docker のインストール </engine/installation/linux/ubuntulinux>` に成功した後、Upstart で稼働状態を確認するには、次のようにします。

.. code-block:: bash

   $ sudo status docker
   docker start/running, process 989

.. Running Docker

コンテナの実行
--------------------

.. You can start/stop/restart the docker daemon using

``docker`` デーモンは次のように開始・停止・再起動できます。

.. code-block:: bash

   $ sudo start docker
   
   $ sudo stop docker
   
   $ sudo restart docker

.. Configuring Docker

Docker の設定
--------------------

.. The instructions below depict configuring Docker on a system that uses upstart as the process manager. As of Ubuntu 15.04, Ubuntu uses systemd as its process manager. For Ubuntu 15.04 and higher, refer to control and configure Docker with systemd.

以下の例は、プロセス・マネージャに ``upstart`` を使い Docker システムを設定する方法です。Ubuntu 15.04 以降はプロセス・マネージャに ``systemd`` を使います。Ubuntu 15.04 以降は、 :doc:`systemd` をご覧ください。

.. You configure the docker daemon in the /etc/default/docker file on your system. You do this by specifying values in a DOCKER_OPTS variable.

システム上にある ``docker`` デーモンの設定は、 ``/etc/default/docker`` ファイルを編集します。ここに ``DOCKER_OPTS`` 環境変数を指定可能です。

.. To configure Docker options:

Docker オプションの設定を変更するには：

..    Log into your host as a user with sudo or root privileges.

1. ホストに ``sudo`` や ``root`` 特権を持つユーザでログインします。

..    If you don’t have one, create the /etc/default/docker file on your host. Depending on how you installed Docker, you may already have this file.

2. ホスト上に ``/etc/default/docker`` ファイルがなければ作成します。Docker のインストール方法によっては、既にファイルが作成されている場合があります。

..    Open the file with your favorite editor.

3. 任意のエディタでファイルを開きます。

.. code-block:: bash

   $ sudo vi /etc/default/docker

..    Add a DOCKER_OPTS variable with the following options. These options are appended to the docker daemon’s run command.

4. ``DOCKER_OPTS`` 変数に、次のオプションを指定します。これらのオプションは ``docker`` デーモンを実行する時に追加されます。

.. code-block:: bash

   DOCKER_OPTS="-D --tls=true --tlscert=/var/docker/server.pem --tlskey=/var/docker/serverkey.pem -H tcp://192.168.59.3:2376"

.. These options :

これらのオプションの意味は：

..    Enable -D (debug) mode
    Set tls to true with the server certificate and key specified using --tlscert and --tlskey respectively
    Listen for connections on tcp://192.168.59.3:2376

* ``-D`` （デバッグ）モードの有効化
* ``tls`` を有効にするため、サーバ証明書と鍵を ``--tlscert`` と ``--tlskey`` で個々に指定
* ``tcp://192.168.59.3:2376`` への接続をリッスン

.. The command line reference has the complete list of daemon flags with explanations.

コマンドライン・リファレンスの :doc:`デーモンのフラグ一覧 </engine/reference/commandline/dockerd>` に説明があります。

..     Save and close the file.

5. ファイルを保存して閉じます。

..    Restart the docker daemon.

6. ``docker`` デーモンを再起動します。

.. code-block:: bash

   $ sudo restart docker

..    Verify that the docker daemon is running as specified with the ps command.

7. ``docker`` デーモンが指定したオプションで実行しているか、 ``ps`` コマンドで確認します。

.. code-block:: bash

   $ ps aux | grep docker | grep -v grep

.. Logs

ログ
----------

.. By default logs for Upstart jobs are located in /var/log/upstart and the logs for docker daemon can be located at /var/log/upstart/docker.log

Upstart ジョブのログは、デフォルトでは ``/var/log/upstart`` に保管されており、 ``docker`` デーモンのログは ``/var/log/upstart/docker.log`` にあります。

.. code-block:: bash

   $ tail -f /var/log/upstart/docker.log
   INFO[0000] Loading containers: done.
   INFO[0000] Docker daemon commit=1b09a95-unsupported graphdriver=aufs version=1.11.0-dev
   INFO[0000] +job acceptconnections()
   INFO[0000] -job acceptconnections() = OK (0)
   INFO[0000] Daemon has completed initialization

.. CentOS / Red Hat Enterprise Linux / Fedora

CentOS / Red Hat Enterprise Linux / Fedora
==================================================

.. As of 7.x, CentOS and RHEL use systemd as the process manager. As of 21, Fedora uses systemd as its process manager.

CentOS と RHEL の ``7.x`` 以降では、プロセス・マネージャに ``systemd`` を使います。Fedora ``21`` 以降は、プロセス・マネージャに ``systemd`` を使います。

.. After successfully installing Docker for CentOS/Red Hat Enterprise Linux/Fedora, you can check the running status in this way:

:doc:`CentOS </engine/installation/linux/centos>` 、 :doc:`Red Hat Enterprise Linux </engine/installation/linux/rhel>` 、 :doc:`Fedora </engine/installation/linux/fedora>` に Docker をインストール後は、次のように稼働状態を確認できます。

.. code-block:: bash

   $ sudo systemctl status docker

.. Running Docker

Docker の実行
--------------------

.. You can start/stop/restart the docker daemon using

``docker`` デーモンは次のように開始・停止・再起動できます。

.. code-block:: bash

   $ sudo systemctl start docker
   
   $ sudo systemctl stop docker
   
   $ sudo systemctl restart docker

.. If you want Docker to start at boot, you should also:

Docker をブート時に起動するようにするには、次のように実行すべきです。

.. code-block:: bash

   $ sudo systemctl enable docker

.. Configuring Docker

Docker の設定
--------------------

.. For CentOS 7.x and RHEL 7.x you can control and configure Docker with systemd.

CentOS 7.x と RHEL 7.x では :doc:`systemd で Docker を管理・設定できます <systemd>` 。

.. Previously, for CentOS 6.x and RHEL 6.x you would configure the docker daemon in the /etc/sysconfig/docker file on your system. You would do this by specifying values in a other_args variable. For a short time in CentOS 7.x and RHEL 7.x you would specify values in a OPTIONS variable. This is no longer recommended in favor of using systemd directly.

以前の CentOS 6.x や RHEL 6.x の場合は、システム上にある ``docker`` デーモンの設定は ``/etc/default/docker`` ファイルを編集し、ここで様々な変数を設定します。CentOS 7.x と RHEL 7.x では、この変数名が ``OPTIONS`` になります。CentOS 6.x と RHEL 6.x では、この変数名は ``other_args`` です。このセクションでは CentOS 7 の ``docker`` デーモンを例に説明します。

.. For this section, we will use CentOS 7.x as an example to configure the docker daemon.

.. このセクションでは、CentOS 7.x で ``docker`` デーモンを設定する例をみていきます。

.. To configure Docker options:

Docker オプションの設定を変更するには：

..    Log into your host as a user with sudo or root privileges.

1. ホストに ``sudo`` や ``root`` 特権を持つユーザでログインします。

.. Create the /etc/systemd/system/docker.service.d directory.

2. ``/etc/systemd/system/docker.service.d`` ディレクトリを作成します。

.. code-block:: bash

   $ sudo mkdir /etc/systemd/system/docker.service.d

.. Create a /etc/systemd/system/docker.service.d/docker.conf file. 

3. ``/etc/systemd/system/docker.service.d/docker.conf`` ファイルを作成します。

.. Open the file with your favorite editor

4. 任意のエディタでファイルを開きます。

.. code-block:: bash

   $ sudo vi /etc/systemd/system/docker.service.d/docker.conf

.. Override the ExecStart configuration from your docker.service file to customize the docker daemon. To modify the ExecStart configuration you have to specify an empty configuration followed by a new one as follows:

5. ``docker`` デーモンの設定を変更するため、 ``docker.service`` ファイルの ``ExecStart`` 設定を上書きします。 ``ExecStart`` 設定を変更するためには、新しい設定行を追加する前に、次のように空の設定行を追加します。

.. code-block:: bash

   [Service]
   ExecStart=
   ExecStart=/usr/bin/dockerd -H fd:// -D --tls=true --tlscert=/var/docker/server.pem --tlskey=/var/docker/serverkey.pem -H tcp://192.168.59.3:2376

.. These options :

これらのオプションの意味は：

..    Enable -D (debug) mode
    Set tls to true with the server certificate and key specified using --tlscert and --tlskey respectively
    Listen for connections on tcp://192.168.59.3:2376

* ``-D`` （デバッグ）モードの有効化
* ``tls`` を有効にするため、サーバ証明書と鍵を ``--tlscert`` と ``--tlskey`` で個々に指定
* ``tcp://192.168.59.3:2376`` への接続をリッスン

.. The command line reference has the complete list of daemon flags with explanations.

コマンドライン・リファレンスの :doc:`デーモンのフラグ一覧 </engine/reference/commandline/dockerd>` に説明があります。

..    Save and close the file.

6. ファイルを保存して閉じます。

.. Flush change

7. 変更を反映（フラッシュ）します。

.. code-block:: bash

   $ sudo systemctl daemon-reload

..    Restart the docker daemon.

8. ``docker`` デーモンを再起動します。

.. code-block:: bash

   $ sudo systemctl restart docker

..     Verify that the docker daemon is running as specified with the ps command.

9. ``docker`` デーモンが指定したオプションで実行しているか、 ``ps`` コマンドで確認します。

.. code-block:: bash

   $ ps aux | grep docker | grep -v grep

.. Logs

ログ
----------

.. systemd has its own logging system called the journal. The logs for the docker daemon can be viewed using journalctl -u docker

systemd は自身で journal と呼ばれるロギング・システムを持っています。 ``docker`` デーモンのログ表示は ``journalctl -u docker`` を使います。

.. code-block:: bash

   $ sudo journalctl -u docker
   May 06 00:22:05 localhost.localdomain systemd[1]: Starting Docker Application Container Engine...
   May 06 00:22:05 localhost.localdomain docker[2495]: time="2015-05-06T00:22:05Z" level="info" msg="+job serveapi(unix:///var/run/docker.sock)"
   May 06 00:22:05 localhost.localdomain docker[2495]: time="2015-05-06T00:22:05Z" level="info" msg="Listening for HTTP on unix (/var/run/docker.sock)"
   May 06 00:22:06 localhost.localdomain docker[2495]: time="2015-05-06T00:22:06Z" level="info" msg="+job init_networkdriver()"
   May 06 00:22:06 localhost.localdomain docker[2495]: time="2015-05-06T00:22:06Z" level="info" msg="-job init_networkdriver() = OK (0)"
   May 06 00:22:06 localhost.localdomain docker[2495]: time="2015-05-06T00:22:06Z" level="info" msg="Loading containers: start."
   May 06 00:22:06 localhost.localdomain docker[2495]: time="2015-05-06T00:22:06Z" level="info" msg="Loading containers: done."
   May 06 00:22:06 localhost.localdomain docker[2495]: time="2015-05-06T00:22:06Z" level="info" msg="Docker daemon commit=1b09a95-unsupported graphdriver=aufs version=1.11.0-dev""
   May 06 00:22:06 localhost.localdomain docker[2495]: time="2015-05-06T00:22:06Z" level="info" msg="+job acceptconnections()"
   May 06 00:22:06 localhost.localdomain docker[2495]: time="2015-05-06T00:22:06Z" level="info" msg="-job acceptconnections() = OK (0)"

.. Note: Using and configuring journal is an advanced topic and is beyond the scope of this article.

.. note::

   journal の使い方や設定方法は高度なトピックのため、この記事の範囲では扱いません。

.. Daemonless Containers

.. _daemonless-containers:

デーモンのないコンテナ（daemonless container）
==================================================

.. Starting with Docker 1.12 containers can run without Docker or containerd running. This allows the Docker daemon to exit, be upgraded, or recover from a crash without affecting running containers on the system. To enable this functionality you need to add the --live-restore flag when launching dockerd. This will ensure that Docker does not kill containers on graceful shutdown or on restart leaving the containers running.

Docker 1.12 から、 Docker や containerd 実行しなくてもコンテナを実行可能になります。これにより、システム上のコンテナに影響を与えずに、Docker デーモンを停止してのアップグレードや障害からの復旧が可能になります。この機能を有効にするためには、 ``dockerd`` の起動時点で ``--live-restore`` フラグの追加が必要です。この場合、Docker はコンテナの停止（kill）や丁寧な停止（graceful shutdown）や、実行中のコンテナに対する再起動ができなくなります。

.. While the Docker daemon is down logging will still be captured, however, it will be capped at the kernel's pipe buffer size before the buffer fills up, blocking the process. Docker will need to be restarted to flush these buffers. You can modify the kernel's buffer size by changing /proc/sys/fs/pipe-max-size.

Docker デーモンが停止中でも、ログ機能は収集し続けます。しかしながら、カーネルのパイプ・バッファ・サイズにバッファが満たされる上限に到達すると、処理が止まります。これらのバッファをフラッシュするには、Docker で再起動が必用です。カーネルがキャッシュするバッファ・サイズは ``/proc/sys/fs/pipe-max-size`` で変更できます。

.. seealso:: 

   Configuring and running Docker on various distributions
      https://docs.docker.com/engine/admin/configuring/
