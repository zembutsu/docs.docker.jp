.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/docker-for-mac/docker-toolbox/
   doc version: 19.03
      https://github.com/docker/docker.github.io/blob/master/docker-for-mac/kubernetes.md
.. check date: 2020/06/09
.. Commits on May 20, 2020 a7806de7c56672370ec17c35cf9811f61a800a42
.. -----------------------------------------------------------------------------

.. Docker Desktop on Mac vs. Docker Toolbox

.. _mac-deploy-on-kubernetes:

==================================================
Docker Desktop for Mac と Docker Toolbox の比較
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. If you already have an installation of Docker Toolbox, read these topics first to learn how Docker Desktop on Mac and Docker Toolbox differ, and how they can coexist.

既に Docker Toolbox をインストール済みの場合は、最初にこのトピックを読み、Docker Desktop on Mac と Docker Toolbox の違いを学び、どのようにして共存するかを学びます。

.. The Docker Toolbox environment

.. _mac-the-docker-toolbox-environment:

Docker Toolbox 環境
====================

.. Docker Toolbox installs docker, docker-compose, and docker-machine in /usr/local/bin on your Mac. It also installs VirtualBox. At installation time, Toolbox uses docker-machine to provision a VirtualBox VM called default, running the boot2docker Linux distribution, with Docker Engine with certificates located on your Mac at $HOME/.docker/machine/machines/default.

Docker Toolbox は Mac 上の :code:`/usr/local/bin` に、 :code:`docker` 、 :code:`docker-compose` 、 :code:`docker-machine` をインストールします。また、 VirtualBox もインストールします。インストール時に、 Toolbox は :code:`docker-machine` で :code:`default` という名前の VirtualBox 仮想マシンをプロビジョン（自動構築）し、 :code:`boot2docker` Linux ディストリビューション上で Docker Engine を実行し、Docker Engine が使う証明書を :code:`$HOME/.docker/machine/machines/default` に置きます。

.. Before you use docker or docker-compose on your Mac, you typically use the command eval $(docker-machine env default) to set environment variables so that docker or docker-compose know how to talk to Docker Engine running on VirtualBox.

Mac 上で :code:`docker`  や :code:`docker-compose`  を使う前に、 :code:`eval $(docker-machine env default)` のような典型的なコマンドを使い、 :code:`docker` や :code:`docker-compose` が VirtualBox 上で実行している Docker Engine と通信するために必要な環境変数を指定します。

.. This setup is shown in the following diagram.

セットアップすると下図のようになります。

.. Docker Toolbox Install

.. The Docker Desktop on Mac environment

.. _the-docker-desktop-on-mac-environment:

Docker Desktop on Mac 環境
==============================

.. Docker Desktop on Mac is a Mac-native application, that you install in /Applications. At installation time, it creates symlinks in /usr/local/bin for docker and docker-compose and others, to the commands in the application bundle, in /Applications/Docker.app/Contents/Resources/bin.

Docker Desktop on Mac は、 :code:`/Applications` にインストールする Mac ネイティブのアプリケーションです。インストール時に :code:`/Applications/Docker.app/Contents/Resources/bin` から :code:`/usr/local/bin` へ :code:`docker` と :code:`docker-compose`  等のシンボリックリンクを作成し、様々なコマンドを実行できるようにします。

.. Here are some key points to know about Docker Desktop on Mac before you get started:

以下は、 Docker Desktop on Mac を使い始める前に知っておく重要なポイントです：

..    Docker Desktop uses HyperKit instead of Virtual Box. Hyperkit is a lightweight macOS virtualization solution built on top of Hypervisor.framework in macOS 10.10 Yosemite and higher.

* Docker Desktop は VirtualBox の代わりに `HyperKit <https://github.com/docker/HyperKit/>`_ を使います。Hyperkit は軽量な macOS 仮想化ソリューションであり、 macOS 10.10 Yosemite 以降の Hypervisor.framework 上で構築されています。

..    When you install Docker Desktop on Mac, machines created with Docker Machine are not affected.

* Docker Desktop on Mac をインストールしても、Docker Machine で作成したマシンは影響を受けません。

..    Docker Desktop does not use docker-machine to provision its VM. The Docker Engine API is exposed on a socket available to the Mac host at /var/run/docker.sock. This is the default location Docker and Docker Compose clients use to connect to the Docker daemon, so you can use docker and docker-compose CLI commands on your Mac.

* Docker Desktop は仮想マシンのプロビジョンに :code:`docker-machine`  を使いません。Docker Engine API は Mac ホスト上の :code:`/var/run/docker.sock` に露出しているソケットで利用できます。これは Docker と Docker Compose クライアントが Docker デーモンと通信するためのデフォルトの場所です。つまり、 :code:`docker` と :code:`docker-compose`  CLI コマンドが Mac 上で使えます。

.. This setup is shown in the following diagram.

セットアップすると下図のようになります。

.. Docker Desktop for Mac Install

.. With Docker Desktop on Mac, you only get (and only usually need) one VM, managed by Docker Desktop. Docker Desktop automatically upgrades the Docker client and daemon when updates are available.

Docker Desktop on Mac では、得られるのは1つの仮想マシン（通常必要なのは1つ）です。この仮想マシンは Docker Desktop によって管理されます。Docker Desktop は更新が利用出来るようになれば、自動的に Docker クライアントとデーモンを自動的に更新します。

.. Also note that Docker Desktop can’t route traffic to containers, so you can’t directly access an exposed port on a running container from the hosting machine.

また、Docker Desktop はコンテナに対するトラフィックは径路付け（route）できないので注意してください。つまり、ホストマシン上で実行しているコンテナが公開しているポートに、直接アクセスできません。

.. If you do need multiple VMs, such as when testing multi-node swarms, you can continue to use Docker Machine, which operates outside the scope of Docker Desktop. See Docker Toolbox and Docker Desktop coexistence.

複数のノードの swarm のような、複数の仮想マシンが必要な場合は、Docker Machine を利用し続けられます。Docker Machine は Docker Desktop が操作する範囲外です。詳細は :ref:`docker-toolbox-and-docker-desktop-coexistence` をご覧ください。


.. Setting up to run Docker Desktop on Mac

.. _setting-up-to-run-docker-desktop-on-mac:

Docker Desktop on Mac を動かすためのセットアップ
==================================================

..    Check whether Toolbox DOCKER environment variables are set:

1. どこで Toolbox の DOCKER 環境変数が指定されているか確認します。

.. code-block:: bash

   $ env | grep DOCKER
   DOCKER_HOST=tcp://192.168.99.100:2376
   DOCKER_MACHINE_NAME=default
   DOCKER_TLS_VERIFY=1
   DOCKER_CERT_PATH=/Users/<your_username>/.docker/machine/machines/default

..    If this command returns no output, you are ready to use Docker Desktop.

コマンドを実行しても出力が何もなければ、既に Docker Desktop を利用する準備が整っています。

..    If it returns output (as shown in the example), unset the DOCKER environment variables to make the client talk to the Docker Desktop Engine (next step).

もし（上の例のように）出力があれば、 :code:`DOCKER` 環境園数を無効化し（次のステップ）、 Docker Desktop エンジンとクライアントが通信できるようにします。

..    Run the unset command on the following DOCKER environment variables to unset them in the current shell.

2.　 シェル上で `DOCKER` 環境変数を無効化（unset）するために、以下の `unset` コマンドを実行します。

.. code-block:: bash

   unset DOCKER_TLS_VERIFY
   unset DOCKER_CERT_PATH
   unset DOCKER_MACHINE_NAME
   unset DOCKER_HOST

.. Now, this command should return no output.

それから、次のコマンドを実行しても、何も出力がないのを確認します。

.. code-block:: bash

   $ env | grep DOCKER

.. If you are using a Bash shell, you can use unset ${!DOCKER_*} to unset all DOCKER environment variables at once. (This does not work in other shells such as zsh; you need to unset each variable individually.)

Bash シェルを使っている場合は、 :code:`unset ${!DOCKER_*}` を使い、全ての DOCKER 環境変数を一度で無効化できます。（これは `zsh` のような他のシェルでは動作しません。すなわち、環境変数を１つ１つ無効化する必要があります）

..    Note: If you have a shell script as part of your profile that sets these DOCKER environment variables automatically each time you open a command window, then you need to unset these each time you want to use Docker Desktop.

.. note::

    コマンド画面を開くとき、自動でシェルスクリプトの profile ファイルの一部で各 :code:`DOCKER`  環境変数を読み込んでいる場合、Docker Desktop を使いたい時には都度それぞれの環境変数を無効化する必要があります。

..    If you install Docker Desktop on a machine where Docker Toolbox is installed..

.. warning::

   | Docker Toolbox がインストール済みのマシンに Docker Desktop をインストールすると...
   | Docker Desktop は :code:`/usr/local/bin` にある :code:`docker`  と :code:`docker-compose`  コマンドラインのシンボリックリンクを、Docker Desktop のものへ書き換えます。

..    Docker Desktop replaces the docker and docker-compose command lines in /usr/local/bin with symlinks to its own versions.

.. See also Unset environment variables in the current shell in the Docker Machine topics.

Docker Machine トピックにある :ref:`現在のシェルで環境変数をアンセットする <machine-unset-environment-variables-in-the-current-shell>` もご覧ください。


.. Docker Toolbox and Docker Desktop coexistence

.. _docker-toolbox-and-docker-desktop-coexistence:

Docker Toolbox と Docker Desktop の共存
========================================

.. You can use Docker Desktop and Docker Toolbox together on the same machine. When you want to use Docker Desktop make sure all DOCKER environment variables are unset. You can do this in bash with unset ${!DOCKER_*}. When you want to use one of the VirtualBox VMs you have set with docker-machine, just run a eval $(docker-machine env default) (or the name of the machine you want to target). This switches the current command shell to talk to the specified Toolbox machine.

同じマシン上で Docker Desktop と Docker Toolbox を一緒に利用できます。Docker Desktop を使いたい場合は、全ての DOCKER 環境変数を無効化します。これを bash でするには :code:`unset ${!DOCKER_*}` です。 :code:`docker-machine` で設定した VirtualBox 仮想マシンの１つを使いたい場合には、 :code:`eval $(docker-machine env default)` を実行します（あるいは、対象となるマシン名を指定します）。現在操作しているコマンドのシェルで切り替えることにより、特定の Toolbox マシンと通信できるようになります。

.. This setup is represented in the following diagram.

セットアップした状態は、下図のように表せます。

.. Docker Toolbox and Docker Desktop for Mac coexistence

.. Using different versions of Docker tools

.. _using-different-versions-of-docker-tools:

異なるバージョンの Docker ツール群を使う
========================================

.. The coexistence setup works as is as long as your VirtualBox VMs provisioned with docker-machine run the same version of Docker Engine as Docker Desktop. If you need to use VMs running older versions of Docker Engine, you can use a tool like Docker Version Manager to manage several versions of docker client.

Docker Desktop と Docker Machine を共存するセットアップをすると、 :code:`docker-machine` でプロビジョンした VirtualBox 仮想マシンはそのまま残っています。もしも古いバージョンの Docker Engine が動作している仮想マシンを使う必要があれば、 `Docker Version Manage <(https://github.com/getcarina/dvm>`_ のようなツールを使い、docker クライアントで複数のバージョンを管理できるようにします。

.. Checking component versions

.. _checking-component-versions:

コンポーネントのバージョン確認
------------------------------

.. Ideally, the Docker CLI client and Docker Engine should be the same version. Mismatches between client and server, and host machines you might have created with Docker Machine can cause problems (client can’t talk to the server or host machines).

理想としては、 Docker CLI クライアントと Docker Engine のバージョンは同一であるべきです。クライアントとサーバまたはホストマシンでの不一致により、作成した Docker Machine が何らかの問題を引き起こす可能性があります（クライアントがサーバやホストマシンと通信できないなど）。

.. If you have already installed Docker Toolbox, and then installed Docker Desktop, you might get a newer version of the Docker client. Run docker version in a command shell to see client and server versions. In this example, the client installed with Docker Desktop is Version: 19.03.1 and the server (which was installed earlier with Toolbox) is Version: 19.03.2.

既に :doc:`Docker Toolbox </toolbox/overview>` をインストールしていて、追加で Docker Desktop をインストールした場合、おそらく新しいバージョンの Docker クライアントを入手します。コマンド・シェル内で :code:`docker version` を実行し、クライアントとサーバのバージョンを確認します。以下の例では、Docker Desktop でインストールしたクライアントのバージョンは :code:`Version: 19.03.1` で、サーバ（Docker Toolbox で先にインストールしていたもの）は :code:`Version: 19.03.2` です。

.. code-block:: bash

   $ docker version
   Client:
   Version:      19.03.1
   ...
   
   Server:
   Version:      19.03.2
   ...

.. Also, if you created machines with Docker Machine (installed with Toolbox) then upgraded or installed Docker Desktop, you might have machines running different versions of Engine. Run docker-machine ls to view version information for the machines you created. In this example, the DOCKER column shows that each machine is running a different version of server.

また、（Toolbox でインストールした）Docker Machine でマシンを作成していた場合は、アップグレードや Docker Desktop のインストールにより、異なるバージョンの Engine を実行することがあります。 :code:`docker-machine ls` を実行し、作成したマシンのバージョン情報を表示します。 `DOCKER` 列で、各マシン上で異なるバージョンのサーバが動作しているのがわかります。


.. code-block:: bash

   $ docker-machine ls
   NAME             ACTIVE   DRIVER         STATE     URL                         SWARM   DOCKER    ERRORS
   aws-sandbox      -        amazonec2      Running   tcp://52.90.113.128:2376            v19.03.1
   default          *        virtualbox     Running   tcp://192.168.99.100:2376           v19.03.2
   docker-sandbox   -        digitalocean   Running   tcp://104.131.43.236:2376           v19.03.1

.. You might also run into a similar situation with Docker Universal Control Plane (UCP).

Docker Universal Control Plane (UCP) を使っている場合であれば、似たような状況になるでしょう。

.. There are a few ways to address this problem and keep using your older machines. One solution is to use a version manager like DVM.

この問題への対処や古いマシンを使い続けるには、複数の方法があります。解決策の１つは、 `DVM <https://github.com/getcarina/dvm>`_  のようなバージョン管理ソフトを使う方法です。

.. Migrating from Docker Toolbox to Docker Desktop on Mac

.. _migrating-from-docker-toolbox-to-docker-desktop-on-mac:

Docker Toolbox から Docker Desktop on Mac への移行
==================================================

.. Docker Desktop does not propose Toolbox image migration as part of its installer since version 18.01.0. You can migrate existing Docker Toolbox images with the scripts described below. (This migration cannot merge images from both Docker and Toolbox: any existing Docker image is replaced by the Toolbox images.)

Docker Desktop では、バージョン 18.01.0 以降のインストーラの一部として、 Toolbox イメージ移行を提案しなくなりました。既存の Docker Toolbox イメージの移行は、以下のスクリプトで行えます（この移行方法では、 Docker と Toolbox の両方の統合はできません。なぜなら、あらゆる既存の Docker イメージは Toolbox のイメージに置き換えるからです）。

.. Run the following shell commands in a terminal. You need a working qemu-img; it is part of the qemu package in both MacPorts and Brew:

ターミナル内で以下のシェル・コマンドを実行します。動作には MacPorts と Brew 両方の qemu パッケージに含まれる :code:`qemu-img`  が必要です。


.. code-block:: bash

   $ brew install qemu  # or sudo port install qemu

.. First, find your Toolbox disk images. You probably have just one: ~/.docker/machine/machines/default/disk.vmdk.

まず、自分の Toolbox ディスクイメージがどこか探します。おそらくこちらでしょう： :code:`~/.docker/machine/machines/default/disk.vmd` 。


.. code-block:: bash

   $ vmdk=~/.docker/machine/machines/default/disk.vmdk
   $ file "$vmdk"
   /Users/akim/.docker/machine/machines/default/disk.vmdk: VMware4 disk image


.. Second, find out the location and format of the disk image used by your Docker Desktop.

次に、 Docker Desktop が使用しているディスク・イメージの場所とフォーマットを確認します。


.. code-block:: bash

   $ settings=~/Library/Group\ Containers/group.com.docker/settings.json
   $ dimg=$(sed -En 's/.*diskPath.*:.*"(.*)".*/\1/p' < "$settings")
   $ echo "$dimg"
   /Users/akim/Library/Containers/com.docker.docker/Data/vms/0/Docker.raw

.. In this case the format is raw (it could have been qcow2), and the location is ~/Library/Containers/com.docker.docker/Data/vms/0/.

今回はフォーマットは :code:`raw`  です（ :code:`qcow2` の場合もあります） 。また、場所は :code:`~/Library/Containers/com.docker.docker/Data/vms/0/` です。

.. Then:

それから

..    if your format is qcow2, run

* フォーマットが qcow2 であれば、次の様に実行します。

.. code-block:: bash

   $ qemu-img convert -p -f vmdk -O qcow2 -o lazy_refcounts=on "$vmdk" "$dimg"

..    if your format is raw, run the following command. If you are short on disk space, it is likely to fail.

* フォーマットが raw であれば、以下のコマンドを実行します。ディスク容量の空きが少なければ、おそらく失敗するでしょう。

.. code-block:: bash

   $ qemu-img convert -p -f vmdk -O raw "$vmdk" "$dimg"

.. Finally (optional), if you are done with Docker Toolbox, you may fully uninstall it.

（オプション）最後に、Docker Toolbox を使い終えるのであれば、完全に :ref:`アンインストール <mac-how-to-uninstall-toolbox>` したらよいでしょう。

.. How do I uninstall Docker Toolbox?

.. _dow-do-i-uninstall-docker-toolbox:

Docker Toolbox をアンインストールするには？
==================================================

.. You might decide that you do not need Toolbox now that you have Docker Desktop, and want to uninstall it. For details on how to perform a clean uninstall of Toolbox on Mac, see How to uninstall Toolbox in the Toolbox Mac topics.

新しい Docker Desktop を手に入れ、Docker Toolbox が不要になれば、アンインストールを決意するでしょう。Mac 上の Toolbox を完全にアンインストールするための詳細は、Toolbox Mac トピックの :ref:`アンインストール <mac-how-to-uninstall-toolbox>`  をご覧ください。

.. seealso:: 

   Docker Desktop on Mac vs. Docker Toolbox
      https://docs.docker.com/docker-for-mac/docker-toolbox/
