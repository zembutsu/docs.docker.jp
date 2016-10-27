.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/machine/get-started/
.. SOURCE: https://github.com/docker/machine/blob/master/docs/get-started.md
   doc version: 1.11
      https://github.com/docker/machine/commits/master/docs/get-started.md
.. check date: 2016/04/28
.. Commits on Apr 23, 2016 c9c6bc45f0e91c9b99129c0a16d0641cd7a266e9
.. -------------------------------------------------------------------

.. _get-started:

.. Get started with Docker Machine and local VM

=========================================
Docker Machine をローカル VM で始めるには
=========================================

.. sidebar:: 目次

   .. contents::
       :depth: 3
       :local:

.. Prerequisites

.. _machine-prerequisites:

動作条件
==========

..    Make sure you have the latest VirtualBox correctly installed on your system. If you used Toolbox for Mac or Windows to install Docker Machine, VirtualBox is automatically installed.

* システム上に正しくインストールするには、 `最新バージョンの VirtualBox <https://www.virtualbox.org/wiki/Downloads>`_ をインストールする必要があります。 :doc:`Mac </engine/installation/mac>` または :doc:`Windows </engine/installation/windows>` で Docker Machine のインストールに `Docker Toolbox <https://www.docker.com/products/docker-toolbox>`_ を使えば、VirtualBox を自動的にインストールします。

..    If you used the Quickstart Terminal to launch your first machine and set your terminal environment to point to it, a default machine was automatically created. If this is the case, you can still follow along with these steps, but create another machine and name it something other than “default” (e.g., staging or sandbox).

* １台目のマシンを Quickstart Terminal で作成したら、ターミナル上で default という名称を持つ環境が自動的に用意されます。この場合、以下の手順をそのまま読み進めても構いませんが、「default」以外の名前（ staging や sandbox）で別のマシンの作成も可能です。

.. Use Machine to run Docker containers

.. _use-machine-to-run-docker-containers:

Machine を使って Docker コンテナを実行
========================================

.. To run a Docker container, you:

Docker コンテナを実行するには、

..     create a new (or start an existing) Docker virtual machine
    switch your environment to your new VM
    use the docker client to create, load, and manage containers

* 新しい Docker 仮想マシンを作成します（あるいは既存マシンを開始します）。
* 環境変数を新しい仮想マシンに切り替えます。
* docker クライアントを使い、コンテナの作成、読み込み、管理を行います。

.. Once you create a machine, you can reuse it as often as you like. Like any VirtualBox VM, it maintains its configuration between uses.

Docker Machine で作成したマシンは、必要に応じて何度も再利用できます。マシンは VirtualBox 上の仮想マシンと同じ環境であり、どちらでも同じ設定が使われます。

.. The examples here show how to create and start a machine, run Docker commands, and work with containers.

以下の例で、マシンの作成・起動方法、 Docker コマンドの実行方法、コンテナの使い方を見ていきます。

.. Create a machine

マシンの作成
====================

..    Open a command shell or terminal window.

1. コマンド・シェルやターミナル画面を開きます。

..    These command examples shows a Bash shell. For a different shell, such as C Shell, the same commands are the same except where noted.

以下の例では Bash シェルを扱います。 C シェルのような他のシェルでは、いくつかのコマンドが動作しない可能性がありますので、ご注意ください。

..    Use docker-machine ls to list available machines.

2. ``docker-machine ls`` を使い、利用可能なマシンの一覧を表示します。

..    In this example, no machines have been created yet.

以下の結果から、マシンがまだ１台も作成されていないことが分かります。

.. code-block:: bash

   $ docker-machine ls
   NAME   ACTIVE   DRIVER   STATE   URL   SWARM   DOCKER   ERRORS

..    Create a machine.

3. マシンを作成します。

..    Run the docker-machine create command, passing the string virtualbox to the --driver flag. The final argument is the name of the machine. If this is your first machine, name it default. If you already have a “default” machine, choose another name for this new machine.

コマンド ``docker-machine create`` の実行時、 ``--driver`` フラグに ``virtualbox`` の文字列を指定します。そして、最後の引数がマシン名になります。これが初めてのマシンであれば、名前を ``default`` にしましょう。既に「default｣という名前のマシンが存在している場合は、別の新しいマシン名を指定します。

.. code-block:: bash

   $ docker-machine create --driver virtualbox default
   Running pre-create checks...
   Creating machine...
   (staging) Copying /Users/ripley/.docker/machine/cache/boot2docker.iso to /Users/ripley/.docker/machine/machines/default/boot2docker.iso...
   (staging) Creating VirtualBox VM...
   (staging) Creating SSH key...
   (staging) Starting the VM...
   (staging) Waiting for an IP...
   Waiting for machine to be running, this may take a few minutes...
   Machine is running, waiting for SSH to be available...
   Detecting operating system of created instance...
   Detecting the provisioner...
   Provisioning with boot2docker...
   Copying certs to the local machine directory...
   Copying certs to the remote machine...
   Setting Docker configuration on the remote daemon...
   Checking connection to Docker...
   Docker is up and running!
   To see how to connect Docker to this machine, run: docker-machine env default

..    This command downloads a lightweight Linux distribution ()boot2docker) with the Docker daemon installed, and creates and starts a VirtualBox VM with Docker running.

このコマンドは Docker デーモンをインストールする軽量 Linux ディストリビューション（ `boot2docker <https://github.com/boot2docker/boot2docker>`_ ）をダウンロードし、Docker を動かすための VirtualBox 仮想マシンを作成・起動します。

..    List available machines again to see your newly minted machine.

4. 再び利用可能なマシン一覧表示したら、新しいマシンが出てきます。

.. code-block:: bash

   $ docker-machine ls
   NAME      ACTIVE   DRIVER       STATE     URL                         SWARM   DOCKER   ERRORS
   default   *        virtualbox   Running   tcp://192.168.99.187:2376           v1.9.1

..    Get the environment commands for your new VM.

5. コマンドの環境変数を新しい仮想マシンに設定します。

..    As noted in the output of the docker-machine create command, you need to tell Docker to talk to the new machine. You can do this with the docker-machine env command.

コマンド ``docker-machine create`` を実行しても、そのまま新しいマシンを操作できないので注意が必要です。新しいマシンの操作には ``docker-machine env`` コマンドを使います。

.. code-block:: bash

   $ docker-machine env default
   export DOCKER_TLS_VERIFY="1"
   export DOCKER_HOST="tcp://172.16.62.130:2376"
   export DOCKER_CERT_PATH="/Users/<yourusername>/.docker/machine/machines/default"
   export DOCKER_MACHINE_NAME="default"
   # Run this command to configure your shell:
   # eval "$(docker-machine env default)"

..    Connect your shell to the new machine.

6. シェルを新しいマシンに接続します。

.. code-block:: bash

   $ eval "$(docker-machine env default)"

..    Note: If you are using fish, or a Windows shell such as Powershell/cmd.exe the above method will not work as described. Instead, see the env command’s documentation to learn how to set the environment variables for your shell.

.. note::

   ``fish`` や Powershell 、あるいは ``cmd.exe`` のような Windows シェルでは、先ほどのコマンドは実行できません。自分の使っているシェルで環境変数を有効にする方法は、 ``env`` :doc:`コマンドのドキュメント </machine/reference/env>` をご覧ください。

..    This sets environment variables for the current shell that the Docker client will read which specify the TLS settings. You need to do this each time you open a new shell or restart your machine.

このシェル上で指定した環境変数を使えば、クライアントは指定された  TLS 設定を読み込みます。新しいシェルの起動時やマシン再起動時には、再度指定する必要があります。

..    You can now run Docker commands on this host.

あとはホスト上で Docker コマンドを実行できます。

.. Run containers and experiment with Machine commands

.. _run-containers-and-machine-commands:

Machine コマンドを使ってコンテナを実行
========================================

.. Run a container with docker run to verify your set up.

セットアップが完了したことを確認するため、``docker run`` コマンドを使ってコンテナを起動しましょう。

..    Use docker run to download and run busybox with a simple ‘echo’ command.

1. ``docker run`` コマンドを使い、 ``busybox`` イメージをダウンロードし、 簡単な ``echo`` コマンドを実行します。

.. code-block:: bash

   $ docker run busybox echo hello world
   Unable to find image 'busybox' locally
   Pulling repository busybox
   e72ac664f4f0: Download complete
   511136ea3c5a: Download complete
   df7546f9f060: Download complete
   e433a6c5b276: Download complete
   hello world

..    Get the host IP address.

2. ホストの IP アドレスを確認します。

..    Any exposed ports are available on the Docker host’s IP address, which you can get using the docker-machine ip command:

Docker ホスト上でポート番号が利用可能な IP アドレスの確認は、 ``docker-machine ip`` コマンドを使います。

.. code-block:: bash

   $ docker-machine ip default
   192.168.99.100

..    Run a webserver (nginx) in a container with the following command:

3. コンテナでウェブサーバ（ https://www.nginx.com/ ）を実行するため、次のコマンドを実行します。

.. code-block:: bash

   $ docker run -d -p 8000:80 nginx

..    When the image is finished pulling, you can hit the server at port 8000 on the IP address given to you by docker-machine ip. For instance:

イメージの取得が完了したら、 ``docker-machine ip`` で確認した IP アドレス上のポート 8000 でサーバにアクセスできます。実行例：

.. code-block:: html

   $ curl $(docker-machine ip default):8000
   <!DOCTYPE html>
   <html>
   <head>
   <title>Welcome to nginx!</title>
   <style>
       body {
           width: 35em;
           margin: 0 auto;
           font-family: Tahoma, Verdana, Arial, sans-serif;
       }
   </style>
   </head>
   <body>
   <h1>Welcome to nginx!</h1>
   <p>If you see this page, the nginx web server is successfully installed and
   working. Further configuration is required.</p>

   <p>For online documentation and support please refer to
   <a href="http://nginx.org/">nginx.org</a>.<br/>
   Commercial support is available at
   <a href="http://nginx.com/">nginx.com</a>.</p>

   <p><em>Thank you for using nginx.</em></p>
   </body>
   </html>

.. You can create and manage as many local VMs running Docker as you please; just run docker-machine create again. All created machines will appear in the output of docker-machine ls.

あとは、好きなだけ実行したいローカル仮想マシンを作成・管理できます。そのためには ``docker-machine create`` を実行するだけです。作成されたマシン全ての情報を確認するには ``docker-machine ls`` を使います。

.. Start and stop machines

.. _start-and-stop-machines:

マシンの起動と停止
====================

.. If you are finished using a host for the time being, you can stop it with docker-machine stop and later start it again with docker-machine start.

ホストを使い終わり、しばらく使わないのであれば、 ``docker-machine stop`` を実行して停止できます。あとで起動したい場合は ``docker-machine start``  を実行します。

.. code-block:: bash

   $ docker-machine stop default
   $ docker-machine start default

.. Operate on machines without specifying the name

マシンの名前を指定せずに操作するには
========================================

.. Some docker-machine commands will assume that the given operation should be run on a machine named default (if it exists) if no machine name is specified. Because using a local VM named default is such a common pattern, this allows you to save some typing on the most frequently used Machine commands.

いくつかの ``docker-machine`` コマンドは、マシン名を明示しれなければ ``default`` という名称のマシン（が存在している場合）に対して処理を行います。そのため、 ``default`` ローカル仮想マシンは一般的なパターンとして、頻繁に利用できるでしょう。

.. For example:

実行例：

.. code-block:: bash

      $ docker-machine stop
      Stopping "default"....
      Machine "default" was stopped.

      $ docker-machine start
      Starting "default"...
      (default) Waiting for an IP...
      Machine "default" was started.
      Started machines may have new IP addresses.  You may need to re-run the `docker-machine env` command.

      $ eval $(docker-machine env)

      $ docker-machine ip
        192.168.99.100

.. Commands that follow this style are:

コマンドは以下の形式でも利用可能です。

* ``docker-machine config``
* ``docker-machine env``
* ``docker-machine inspect``
* ``docker-machine ip``
* ``docker-machine kill``
* ``docker-machine provision``
* ``docker-machine regenerate-certs``
* ``docker-machine restart``
* ``docker-machine ssh``
* ``docker-machine start``
* ``docker-machine status``
* ``docker-machine stop``
* ``docker-machine upgrade``
* ``docker-machine url``

.. For machines other than default, and commands other than those listed above, you must always specify the name explicitly as an argument.

``default`` 以外のマシンでは、常に特定のマシン名をコマンドの引数として明示する必要があります。

.. Start local machines on startup

.. _start-local-machines-on-startup:

起動時にローカル・マシンの自動起動
========================================

.. In order to ensure that the Docker client is automatically configured at the start of each shell session, some users like to embed eval $(docker-machine env default) in their shell profiles (e.g., the ~/.bash_profile file). However, this fails if the default machine is not running. If desired, you can configure your system to start the default machine automatically.

シェルのセッションを開く度に、Docker クライアントが自動的に毎回設定された状態にするには、対象ユーザのシェル profile （例： ``~/.bash_profile`` ファイル ）に追記（ ``eval $(docker-machine env default)`` ）します。しかし、 ``default`` のマシンが起動されていなければコマンドは実行できません。そのような場合は、システム起動時に ``default`` マシンが自動的に起動するよう設定します。

.. Here is an example of how to configure this on OS X.

以下の例は OS X 上での設定です。

.. Create a file called com.docker.machine.default.plist under ~/Library/LaunchAgents with the following content:

``~/Library/LaunchAgents`` 以下に ``com.docker.machine.default.plist`` ファイルを作成します。内容は次の通りです。

.. code-block:: xml

   <?xml version="1.0" encoding="UTF-8"?>
   <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
   <plist version="1.0">
       <dict>
           <key>EnvironmentVariables</key>
           <dict>
               <key>PATH</key>
               <string>/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin</string>
           </dict>
           <key>Label</key>
           <string>com.docker.machine.default</string>
           <key>ProgramArguments</key>
           <array>
               <string>/usr/local/bin/docker-machine</string>
               <string>start</string>
               <string>default</string>
           </array>
           <key>RunAtLoad</key>
           <true/>
       </dict>
   </plist>

.. You can change the default string above to make this LaunchAgent start any machine(s) you desire.

この中にある ``LaunchAgent`` の ``default``  を書き換えれば、任意のマシン（群）を起動できます。

.. Where to go next

次はどこへ行きますか
====================

..    Provision multiple Docker hosts on your cloud provider
    Understand Machine concepts
    Docker Machine driver reference
    Docker Machine subcommand reference

* 複数の machine を :doc:`クラウド・プロバイダ </machine/get-started-cloud/>` にインストール
* :doc:`concepts`
* :doc:`Docker Machine ドライバ・リファレンス </machine/drivers/index>`
* :doc:`Docker Machine サブコマンド・リファレンス </machine/reference/index>`

.. seealso::

   Get started with Docker Machine and a local VM
      https://docs.docker.com/machine/get-started/
