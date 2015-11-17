.. http://docs.docker.com/machine/

.. _machine:

.. Docker Machine

=======================================
Docker Machine
=======================================

.. Machine lets you create Docker hosts on your computer, on cloud providers, and inside your own data center. It automatically creates hosts, installs Docker on them, then configures the docker client to talk to them. A “machine” is the combination of a Docker host and a configured client.

Machine （マシン）は自分のコンピュータ上やクラウド・プロバイダに Docker ホスト（Dockerの動作環境）を作成します。自動的にホストを作成し、そこに Docker をインストールし、 ``docker`` クライアントがホストと通信できるように調整します。この "machine" は、Docker ホストとクライアントを連結する設定をします。

.. Once you create one or more Docker hosts, Docker Machine supplies a number of commands for managing them. Using these commands you can

１つまたは複数の Docker ホストを作った後は、Docker Machine はこれらを管理するための、複数のコマンドを提供します。次のようなコマンドが利用可能です。

..    start, inspect, stop, and restart a host
    upgrade the Docker client and daemon
    configure a Docker client to talk to your host

* ホストに対する start（開始）、inspect（調査）、stop（停止）、restart（再起動）
* Docker クライアントとデーモンの upgrade（更新）
* Docker クライアントがホストと津心できるよう configure（設定）

.. Looking for the installation docs?

インストール用のドキュメントをお探しですか？
--------------------------------------------------

.. For Windows or Mac, you can obtain Docker Machine by installing the Docker Toolbox. To read instructions for installing Machine on Linux or for installing Machine alone without Docker Toolbox, see the Machine installation instructions.

Windows か Mac の場合、Docker Machine は `Docker Toolbox <https://www.docker.com/toolbox>`_ のインストールで入手できます。Linux の場合や Docker Toolbox を使わず Machine のみインストールしたい場合は、:doc:`Machine のインストール方法 </machine/install-machine/>` をお読みください。


.. Understand Docker Machine basic concepts

Docker Machine 基本概念の理解
==============================

.. Docker Machine allows you to provision Docker on virtual machines that reside either on your local system or on a cloud provider. Docker Machine creates a host on a VM and you use the Docker Engine client as needed to build images and create containers on the host.

Docker Machine は仮想マシン上に Docker をプロビジョン（訳者注：自動的にセットアップ）します。仮想マシンはローカルのシステム上だけではなく、クラウド・プロバイダ上でも利用できます。Docker Machine は仮想マシン上にホストを作成し、Docker Engine クライアントで、そのホスト上でイメージの構築やコンテナの作成を行えるようにします。

.. To create a virtual machine, you supply Docker Machine with the name of the driver you want use. The driver represents the virtual environment. For example, on a local Linux, Mac, or Windows system the driver is typically Oracle Virtual Box. For cloud providers, Docker Machine supports drivers such as AWS, Microsoft Azure, Digital Ocean and many more. The Docker Machine reference includes a complete list of the supported drivers.

仮想マシンの作成にあたり、Docker machine に対して利用したいドライバ名を伝えます。ドライバとは仮想化の環境を表すものです。例えば、ローカルの Linux、Mac、Windows システムにおける典型的なドライバは、Oracle Virtual Box です。クラウド・プロバイダであれば、Docker Machine は AWS、Microsoft Azure、Digital Ocean など多くのドライバをサポートしています。Docker Machine のリファレンスには、:doc:`サポートしているドライバ一覧 </machine/drivers>` のリストがあります。

.. Since Docker runs on Linux, each VM that Docker Machine provisions relies on a base operating system. For convenience, there are default base operating systems. For the Oracle Virtual Box driver, this base operating system is the boot2docker.iso. For drivers used to connect to cloud providers, the base operating system is Ubuntu 12.04+. You can change this default when you create a machine. The Docker Machine reference includes a complete list of the supported operating systems.

Docker は Linux 上で動作するため、Docker Machine がプロビジョンする仮想マシンは、ベース・オペレーティング・システムを頼りとします。便宜上、標準のベース・オペレーティング・システムがあります。Oracle Virtual Box ドライバの場合は、このベース・オペレーティング・システムは ``boot2docker.iso`` になります。ドライバがクラウド・プロバイダに接続する場合、ベース・オペレーティング・システムは Ubuntu 12.04 以上です。仮想マシン作成時、この標準設定を変更可能です。Docker Machine リファレンスには、:doc:`サポートしているオペレーティング・システムの一覧 </machine/drivers/os-base>` があります。

.. For each machine you create, the Docker host address is the IP address of the Linux VM. This address is assigned by the docker-machine create subcommand. You use the docker-machine ls command to list the machines you have created. The docker-machine ip <machine-name> command returns a specific host’s IP address.

作成した各マシンにおいて、Docker ホストのアドレスとは、Linux 仮想マシンの IP アドレスです。この IP アドレスは ``docker-machine create`` サブコマンド実行時に割り当てられます。``docker-machine ls`` コマンドは、作成したマシンの一覧を表示します。``docker-machine ip <マシン名>`` コマンドは、指定したホストの IP アドレスを返します。

.. Before you can run a docker command on a machine, you configure your command-line to point to that machine. The docker-machine env <machine-name> subcommand outputs the configuration command you should use. When you run a container on the Docker host, the container’s ports map to ports on the VM.

マシン上で ``docker`` コマンドを実行しなくても、自分のコマンドライン上で対象マシンを指し示せます。 ``docker-machine env <マシン名>`` サブコマンドの出力結果が、使うべきコマンドです。Docker ホスト上でコンテナを実行すると、コンテナのポートが仮想マシン上のポートに割り当てられます。

.. For a complete list of the docker-machine subcommands, see the Docker Machine subcommand reference.

``docker-machine`` サブコマンドの完全な一覧は、 :doc:`Docker Machine サブコマンド・リファレンス </machine/reference>` をご覧ください。

.. Getting help

ヘルプを得るには
====================

.. Docker Machine is still in its infancy and under active development. If you need help, would like to contribute, or simply want to talk about the project with like-minded individuals, we have a number of open channels for communication.

Docker Machine は、初期段階であり活発に開発が進んでいます。ヘルプが必要な場合、貢献したい場合、あるいはプロジェクトの同志と対話したい場合、私たちは多くのコミュニケーションのためのチャンネルを開いています。

..    To report bugs or file feature requests: please use the issue tracker on Github.
    To talk about the project with people in real time: please join the #docker-machine channel on IRC.
    To contribute code or documentation changes: please submit a pull request on Github.

* バグ報告や機能リクエストは、 `GitHub の issue トラッカー <https://github.com/docker/machine/issues>`_ をご利用ください。
* プロジェクトのメンバーとリアルタイムに会話したければ、IRC の ``#docker-machine`` チャンネルにご参加ください。
* コードやドキュメントの変更に貢献したい場合は、`GitHub にプルリクエスト <https://github.com/docker/machine/pulls>`_ をお送りください。

.. For more information and resources, please visit our help page.

より詳細な情報やリソースについては、私たちの `ヘルプ用ページ <https://docs.docker.com/project/get-help/>`_ をご覧ください。

.. Where to go next

次はどこへ行きますか？
==============================

..    Install a machine on your local system using VirtualBox.
    Install multiple machines on your cloud provider.
    Docker Machine driver reference
    Docker Machine subcommand reference

* machine を :doc:`ローカルの VirtualBox を使ったシステム </machine/get-started>` にインストール
* 複数の machine を :doc:`クラウド・プロバイダ </machine/get-started-cloud/>` にインストール
* :doc:`Docker Machine ドライバ・リファレンス </machine/drivers>`
* :doc:`Docker Machine サブコマンド・リファレンス </machine/reference>`

