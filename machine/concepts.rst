.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/machine/concepts/
.. SOURCE: https://github.com/docker/machine/blob/master/docs/concepts.md
   doc version: 1.11
      https://github.com/docker/machine/commits/master/docs/concepts.md
.. check date: 2016/04/28
.. Commits on Feb 11, 2016 0eb405f1d7ea3ad4c3595fb2c97d856d3e2d9c5c
.. ----------------------------------------------------------------------------

.. Understand Machine concepts and get help

==================================================
Machine の概念に対する理解とヘルプを得る
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Docker Machine allows you to provision Docker machines in a variety of environments, including virtual machines that reside on your local system, on cloud providers, or on bare metal servers (physical computers). Docker Machine creates a Docker host, and you use the Docker Engine client as needed to build images and create containers on the host.

Docker Machine を使えば、様々な環境・様々な仮想マシン上で Docker が動くマシンを自動作成できます。これはローカルのシステム上だけでなく、クラウド・プロバイダ上でも、ベアメタル・サーバ（物理コンピュータ）上でも可能です。Docker Machine で Docker ホストを作成したら、Docker Engine クライアントを使えば、必要に応じてホスト上でイメージの構築やコンテナ作成が可能になります。

.. Drivers for creating machines

マシン作成用のドライバ
==============================

.. To create a virtual machine, you supply Docker Machine with the name of the driver you want use. The driver determines where the virtual machine is created. For example, on a local Mac or Windows system, the driver is typically Oracle VirtualBox. For provisioning physical machines, a generic driver is provided. For cloud providers, Docker Machine supports drivers such as AWS, Microsoft Azure, Digital Ocean, and many more. The Docker Machine reference includes a complete list of supported drivers.

仮想マシンを作成するには、Docker Machine 実行時に使いたいドライバの名前を指定します。ドライバの選択は、仮想マシンをどこで作成するかによります。例えば、ローカルの Mac や Windows システム上であれば、Oracle VirtualBox が一般的なドライバになります。物理マシン上にプロビジョニングする場合は generic （ジェネリック）ドライバです。クラウド・プロバイダであれば、 Docker Machine は AWS ・ Microsoft Azure ・ Digital Ocean 等々に対応してます。Docker Machine のリファレンスに :doc:`サポートしているドライバ一覧 <drivers/index>` があります。

.. Default base operating systems for local and cloud hosts

ローカルまたはクラウド上でデフォルトのベース OS
==================================================

.. Since Docker runs on Linux, each VM that Docker Machine provisions relies on a base operating system. For convenience, there are default base operating systems. For the Oracle Virtual Box driver, this base operating system is boot2docker. For drivers used to connect to cloud providers, the base operating system is Ubuntu 12.04+. You can change this default when you create a machine. The Docker Machine reference includes a complete list of supported operating systems.

Docker を Linux 上で動かす場合、Docker Machine のプロビジョニングは仮想マシンのベースとなるオペレーティング・システムに依存します。簡単なのはデフォルトのベース・オペレーティング・システムを使うことです。Oracle Virtual Box ドライバであれば、ベースにするオペレーティング・システムは `boot2docker <https://github.com/boot2docker/boot2docker>`_ です。クラウド・プロバイダを使う場合はベース・オペレーティング・システムは Ubuntu 12.04 以上です。このデフォルトはマシン作成時に変更できます。Docker Machine リファレンスの :doc:`サポートしているオペレーティング・システムの一覧 </machine/drivers/os-base>` をご覧ください。

.. IP addresses for Docker hosts

Docker ホストの IP アドレス
==============================

.. For each machine you create, the Docker host address is the IP address of the Linux VM. This address is assigned by the docker-machine create subcommand. You use the docker-machine ls command to list the machines you have created. The docker-machine ip <machine-name> command returns a specific host’s IP address.

各マシンの作成時、Docker ホストに対して Linux 仮想マシンの IP アドレスが割り当てられます。これは ``docker-machine create``  サブコマンドの実行時に割り当てられます。作成したマシンの一覧は ``docker-machine ls`` コマンドで確認できます。 ``docker-machine ip <マシン名>`` コマンドは、指定したホストの IP アドレスを返します。

.. Configuring CLI environment variables for a Docker host

CLI の操作対象 Docker ホストを環境変数で指定
==================================================

.. Before you can run a docker command on a machine, you need to configure your command-line to point to that machine. The docker-machine env <machine-name> subcommand outputs the configuration command you should use.

マシン上で ``docker`` コマンドを実行する前に、コマンドライン上で対象のマシンを指定する必要があります。 ``docker-machine env <マシン名>`` サブコマンドを実行したら、適切な命令を出力します。

.. For a complete list of docker-machine subcommands, see the Docker Machine subcommand reference.

``docker-machine`` サブコマンドの一覧は :doc:`/machine/reference/index` をご覧ください。

.. Crash Reporting

クラッシュ報告
====================

.. Provisioning a host is a complex matter that can fail for a lot of reasons. Your workstation may have a wide variety of shell, network configuration, VPN, proxy or firewall issues. There are also reasons from the other end of the chain: your cloud provider or the network in between.

ホストのプロビジョニングには複雑な問題があり、様々な理由により失敗する場合があります。皆さんの作業環境ではシェル、ネットワーク設定、VPN、プロキシやファイアウォールに関する多くの問題があるかもしれません。また、これが他との問題の切り分け箇所（クラウド・プロバイダ、あるいは、ネットワーク間での問題か）になります。

.. To help docker-machine be as stable as possible, we added a monitoring of crashes whenever you try to create or upgrade a host. This will send, over HTTPS, to Bugsnag some information about your docker-machine version, build, OS, ARCH, the path to your current shell and, the history of the last command as you could see it with a --debug option. This data is sent to help us pinpoint recurring issues with docker-machine and will only be transmitted in the case of a crash of docker-machine.

``docker-machine`` が安定するための手助けとなるよう、私たちはホスト上で ``create`` や ``upgrade`` を試みるときクラッシュ（障害情報）を監視できるようにしました。クラッシュ報告は HTTPS を経由して送信します。送信される情報は ``docker-machine`` のバージョン、構築に関して、OS 、アーキテクチャ、現在のシェル上のパス、ホスト上での直近の履歴といった、 ``--debug`` オプション指定時に参照できるものです。送信されたデータは ``docker-machine`` 実行時にどのような問題が発生しているかを、ピンポイントで把握できるようにします。送信されるのは ``docker-machine`` がクラッシュした場合のみです。

.. If you wish to opt out of error reporting, you can create a no-error-report file in your $HOME/.docker/machine directory, and Docker Machine will disable this behavior. e.g.:

エラーメッセージを送りたくなければ、自分の ``$HOME/docker/machine`` ディレクトリに ``no-error-report`` ファイルを置きます。そうしておけば Docker Machine はレポートを報告しません。

.. code-block:: bash

   $ mkdir -p ~/.docker/machine && touch ~/.docker/machine/no-error-report

.. Leaving the file empty is fine -- Docker Machine just checks for its presence.

このファイルは空のままで構いません。Docker Machine はファイルの存否のみ確認します。

.. Getting help

ヘルプが必要ですか？
====================

.. Docker Machine is still in its infancy and under active development. If you need help, would like to contribute, or simply want to talk about the project with like-minded individuals, we have a number of open channels for communication.

Docker Machine は開発途上であり、積極的に開発が行われています。ヘルプが必要であれば、あるいは貢献したい場合、一番簡単なのはプロジェクトの仲間に声をかけることです。私たちはコミュニケーションのために開かれたチャンネルを用意しています。

..    To report bugs or file feature requests: please use the issue tracker on Github.
    To talk about the project with people in real time: please join the #docker-machine channel on IRC.
    To contribute code or documentation changes: please submit a pull request on Github.

* バグ報告や機能リクエストを送りたい： `GitHub の課題トラッカー <https://github.com/docker/machine/issues>`_ をご利用ください。
* プロジェクトの人々とリアルタイムに会話したい： IRC の ``#docker-machine`` チャンネルにご参加ください。
* コードやドキュメント変更に貢献したい： `GitHub にプル・リクエストを送信 <https://github.com/docker/machine/pulls>`_ ください。

.. For more information and resources, please visit our help page.

更に詳しい情報やリソースについては、 `プロジェクトのヘルプ <https://docs.docker.com/project/get-help/>`_ ページをご覧ください。

.. Where to go next

次はどこへ
====================

..    Create and run a Docker host on your local system using VirtualBox
    Provision multiple Docker hosts on your cloud provider
    Docker Machine driver reference
    Docker Machine subcommand reference

* :doc:`ローカルシステム上に VirtualBox を使い </machine/get-started>` Docker ホストを作成・実行する
* :doc:`クラウド・プロバイダ上に </machine/get-started-cloud>` 複数の Docker ホストを自動構築する
* :doc:`Docker Machine ドライバ・リファレンス </machine/drivers/index>`
* :doc:`Docker Machine サブコマンド・リファレンス </machine/reference/index>`

.. seealso:: 

   Understand Machine concepts and get help
      https://docs.docker.com/machine/concepts/
