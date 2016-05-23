.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/machine/get-started-cloud/
.. SOURCE: https://github.com/docker/machine/blob/master/docs/get-started-cloud.md
   doc version: 1.11
      https://github.com/docker/machine/commits/master/docs/get-started-cloud.md
.. check date: 2016/04/28
.. Commits on Feb 11, 2016 0eb405f1d7ea3ad4c3595fb2c97d856d3e2d9c5c
.. -------------------------------------------------------------------

.. _get-started-cloud:

.. Using Docker Machine with a cloud provider

==================================================
Docker Machine をクラウド・プロバイダで使う
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Docker Machine driver plugins are available for many cloud platforms, so you can use Machine to provision cloud hosts. When you use Docker Machine for provisioning, you create cloud hosts with Docker Engine installed on them.

Docker Machine は様々なクラウド・プラットフォームに対応したプラグインを扱えます。このプラグインに対応したドライバを使えば、Docker Machine でクラウド・ホストを自動作成します。そして、作成するホスト上に Docker Engine も自動インストールできます。

.. You’ll need to install and run Docker Machine, and create an account with the cloud provider.

必要になるのは Docker Machine のインストール・実行と、利用するクラウド・プロバイダ上でのアカウント作成です。

.. Then you provide account verification, security credentials, and configuration options for the providers as flags to docker-machine create. The flags are unique for each cloud-specific driver. For instance, to pass a Digital Ocean access token you use the --digitalocean-access-token flag. Take a look at the examples below for Digital Ocean and AWS.

次にアカウント証明書、セキュリティ証明書など、 ``docker-machine create`` コマンドのオプション用フラグで必要なものを確認します。例えば、 Digital Ocean のアクセス・トークンを指定するには ``--digitalocean-access_token`` フラグを使います。以降のページでは Digital Ocean と AWS の設定例を見ていきます。

.. Examples

サンプル
====================

.. Digital Ocean

Digital Ocean
--------------------

.. For Digital Ocean, this command creates a Droplet (cloud host) called “docker-sandbox”.

次のコマンドは Digital Ocean 上に「docker-sandbox」という名前のドロップレット（クラウド・ホスト）を作成します。

.. code-block:: bash

   $ docker-machine create --driver digitalocean --digitalocean-access-token xxxxx docker-sandbox

.. For a step-by-step guide on using Machine to create Docker hosts on Digital Ocean, see the Digital Ocean Example.

Machine を使い、Digital Ocean 上のホストで更なる操作をするには :doc:`Digital Ocean サンプル </machine/examples/ocean>`  をご覧ください。


.. Amazon Web Services (AWS)

Amazon Web Services (AWS)
------------------------------

.. For AWS EC2, this command creates an instance called “aws-sandbox”:

次のコマンドは AWS EC2 上に「aws-sandbox」という名前のドロップレット（クラウド・ホスト）を作成します。

.. code-block:: bash

  $ docker-machine create --driver amazonec2 --amazonec2-access-key AKI******* --amazonec2-secret-key 8T93C*******  aws-sandbox

.. For a step-by-step guide on using Machine to create Dockerized AWS instances, see the Amazon Web Services (AWS) example.

Machine を使い、AWS 上の Docker 対応インスタンスで更なる操作をするには :doc:`Amazon Web Services (AWS) サンプル </machine/examples/aws>`  をご覧ください。

.. The docker-machine create command

.. _the-docker-machine-create-command:

docker-machine create コマンド
==============================

.. The docker-machine create command typically requires that you specify, at a minimum:

``docker-machine create`` コマンドの実行時、いくつか最小限の指定が必要となります。

..    --driver - to indicate the provider on which to create the machine (VirtualBox, DigitalOcean, AWS, and so on)

* ``--driver`` で、マシンを作成するプロバイダを明示します（ VirtualBox 、 Digital Ocean 、 AWS 、等）。

..    Account verification and security credentials (for cloud providers), specific to the cloud service you are using

* クラウド・サービスを使う場合は、（クラウド・プロバイダの）アカウント証明書やセキュリティ証明書の指定。

..    <machine> - name of the host you want to create

* ``<マシン名>`` で作成したいホスト名。

.. For convenience, docker-machine will use sensible defaults for choosing settings such as the image that the server is based on, but you override the defaults using the respective flags (e.g. --digitalocean-image). This is useful if, for example, you want to create a cloud server with a lot of memory and CPUs (by default docker-machine creates a small server).

扱いやすいように、 ``docker-machine`` でサーバ作成時に一般的なオプションがデフォルトで適用されます。しかし、これらのデフォルト値はフラグを使って上書きできます（例： ``--digitalocean-image`` ）。そのため、クラウド・サーバに多くのメモリや CPU を割り当てたい場合には便利でしょう（デフォルトの ``docker-machine`` は小さなサーバを作成します）。

.. For a full list of the flags/settings available and their defaults, see the output of docker-machine create -h at the command line, the create command in the Machine command line reference, and driver options and operating system defaults in the Machine driver reference.

デフォルトの値、あるいは利用可能なフラグや設定を全て確認したい場合は、コマンドラインで ``docker-machine create -h`` を使います。他にも、Machine :doc:`コマンドライン・リファレンス </machine/reference/index>` の :doc:`create </machine/reference/create>` コマンドや、Machine ドライバ・リファレンスの :doc:`/machine/drivers/os-base`  をご覧ください。

.. Drivers for cloud providers

.. _drivers-for-cloud-providers:

クラウド・プロバイダ向けのドライバ
========================================

.. When you install Docker Machine, you get a set of drivers for various cloud providers (like Amazon Web Services, Digital Ocean, or Microsoft Azure) and local providers (like Oracle VirtualBox, VMWare Fusion, or Microsoft Hyper-V).

Docker Machine をインストーしたら、様々なクラウド・プロバイダに対応したドライバ（Amazon Web Services 、 Digital Ocean 、 Microsoft Azure 等）と、ローカルのプロバイダ（Oracle VirtualBox 、VMware Fusion 、Microsoft Hyper-V）が利用可能になります。

.. See Docker Machine driver reference for details on the drivers, including required flags and configuration options (which vary by provider).

各ドライバの詳細は :doc:`Docker Machine ドライバ・リファレンス </machine/drivers/index>` から、必要なフラグや設定オプション（プロバイダごとにかなり違います）をご確認ください。

.. 3rd-party driver plugins

.. _3rd-party-driver-plugins:

サード・パーティのドライバ・プラグイン
========================================

.. Several Docker Machine driver plugins for use with other cloud platforms are available from 3rd party contributors. These are use-at-your-own-risk plugins, not maintained by or formally associated with Docker.

サード・パーティの貢献者による様々なクラウド・プラットフォームに対応した Docker Machine プラグインがあります。これらのプラグイン利用にあたっては、利用者の皆さん自身でリスクを取ってください。Docker によって直接メンテナンスされているものではありません。

.. See Available driver plugins in the docker/machine repo on GitHub.

使うには、GItHub の docker/machine リポジトリ上の `利用可能なドライバ・プラグイン <https://github.com/docker/machine/blob/master/docs/AVAILABLE_DRIVER_PLUGINS.md>`_ をご覧ください。

.. Adding a host without a driver

.. _adding-a-host-without-a-driver:

ドライバを使わずにホストを追加
==============================

.. You can add a host to Docker which only has a URL and no driver. Then you can use the machine name you provide here for an existing host so you don’t have to type out the URL every time you run a Docker command.

Docker の場所を指定したら、ドライバがないホストの追加が可能です。既存のホストに関するマシン名を指定することにより、Docker コマンド使用時に毎回オプションを指定する必要がなくなります。

.. code-block:: bash

   $ docker-machine create --url=tcp://50.134.234.20:2376 custombox
   $ docker-machine ls
   NAME        ACTIVE   DRIVER    STATE     URL
   custombox   *        none      Running   tcp://50.134.234.20:2376

.. Using Machine to provision Docker Swarm clusters

Machine で Docker Swarm クラスタの自動構築
==================================================

.. Docker Machine can also provision Docker Swarm clusters. This can be used with any driver and will be secured with TLS.

Docker Machine を使えば :doc:`Docker Swarm </swarm/overview>` クラスタのプロビジョンもできます。どのドライバを使っても TLS で安全にします。

..    To get started with Swarm, see How to get Docker Swarm.

* Swarm を使うには :doc:`/swarm/get-swarm` をご覧ください。

..    To learn how to use Machine to provision a Swarm cluster, see Provision a Swarm cluster with Docker Machine.

* Machine で Swarm クラスタを構築する方法は :doc:`/swarm/provision-with-machine` をご覧ください。

.. Where to go next

次はどこへ行きますか
====================

* サンプル： Docker 対応の :doc:`Digital Ocean ドロップレット </machine/examples/ocean>` をプロビジョニング
* サンプル： Docker 対応の :doc:`AWS EC2 インスタンス </machine/examples/aws>` をプロビジョニング
* :doc:`concepts`
* :doc:`Docker Machine ドライバ・リファレンス </machine/drivers/index>`
* :doc:`Docker Machine サブコマンド・リファレンス </machine/reference/index>`
* :doc:`/swarm/provision-with-machine` 

.. seealso:: 

   Use Docker Machine to provision hosts on cloud providers
      https://docs.docker.com/machine/get-started-cloud/

