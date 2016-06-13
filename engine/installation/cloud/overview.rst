.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/installation/cloud/overview/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/installation/cloud/overview.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/installation/cloud/overview.md
.. check date: 2016/06/13
.. Commits on Feb 2, 2016 4e9e95fe8d9ba177ec77727b6fca558a0ba8f01f
.. -----------------------------------------------------------------------------

.. Choose how to install

.. _choose-how-to-install:

==================================================
インストール方法の選択
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. You can install Docker Engine on any cloud platform that runs an operating system (OS) that Docker supports. This includes many flavors and versions of Linux, along with Mac and Windows.

Docker がサポートしているオペレーティング・システム（OS）上であれば、あらゆるクラウド・プラットフォーム上で Docker Engine をインストールできます。OS には Mac や Windows だけでなく、様々な種類の Linux が含まれています。

.. You have two options for installing:

インストールには２種類のオプションがあります。

..    Manually install on the cloud (create cloud hosts, then install Docker Engine on them)
    Use Docker Machine to provision cloud hosts

* クラウド上で手動インストール（クラウド・ホストを作成し、そこに Docker Engine をインストール）
* Docker Machine を使い、クラウド・ホストを自動作成

.. Manually install Docker Engine on a cloud host

.. _manually-install-docker-engine-on-a-cloud-host:

クラウド・ホスト上に Docker Engine を手動セットアップ
============================================================

.. To install on a cloud provider:

クラウド・プロバイダ上でインストールします。

..    Create an account with the cloud provider, and read cloud provider documentation to understand their process for creating hosts.

1. クラウド・プロバイダにアカウントを作成し、クラウド・プロバイダのドキュメントを読み、ホスト作成手順を理解します。

..    Decide which OS you want to run on the cloud host.

2. クラウド・ホスト上で実行する OS を決めます。

..    Understand the Docker prerequisites and install process for the chosen OS. See Install Docker Engine for a list of supported systems and links to the install guides.

3. Docker の必要条件と選択した OS に対するインストール手順を理解します。サポートしているシステムの一覧と、インストール手順へのリンクは、 :doc:`Docker Engine のインストール </engine/installation/index>` をご覧ください。

..    Create a host with a Docker supported OS, and install Docker per the instructions for that OS.

4. Docker がサポートしている OS のホストを作成し、各 OS の指示に従って Docker をインストールします。

.. Example: Manual install on a cloud provider shows how to create an Amazon Web Services (AWS) EC2 instance, and install Docker Engine on it.

:doc:`cloud-ex-aws` は `Amazon Web Services (AWS) <https://aws.amazon.com/>`_ の EC2 インスタンスの作成と、Docker Engine をインストールする方法を紹介しています。

.. Use Docker Machine to provision cloud hosts

.. _use-docker-machine-to-provision-cloud-hosts:

Docker Machine を使ってクラウド・ホストを準備
==================================================

.. Docker Machine driver plugins are available for several popular cloud platforms, so you can use Machine to provision one or more Dockerized hosts on those platforms.

複数の有名なクラウド・プラットフォームに Docker Machine ドライバ・プラグインが対応しています。そのため、Docker Machine を使い、それらのプラットフォーム上に Docker に対応したホストを作成できます。

.. With Docker Machine, you can use the same interface to create cloud hosts with Docker Engine on them, each configured per the options you specify.

Docker Machine を使えば、クラウド・ホストに対応したオプションを指定するだけで、この同じインターフェースを通してマシンが作成できます。

.. To do this, you use the docker-machine create command with the driver for the cloud provider, and provider-specific flags for account verification, security credentials, and other configuration details.

作成するには ``docker-machine create`` コマンドに各プロバイダに対応したドライバを指定し、アカウント認証やセキュリティ証明書や詳細設定など、プロバイダ特定のオプションをしています。

.. Example: Use Docker Machine to provision cloud hosts walks you through the steps to set up Docker Machine and provision a Dockerized host on Digital Ocean.

:doc:`cloud-ex-machine-ocean` を読み進めると、Docker Machine と Docker に対応したホストを `Digital Ocean <https://www.digitalocean.com/>`_ 上に作成していきます。

.. Where to go next

.. _where-to-go-next:

次はどこへ
==========

.. 
    Example: Manual install on a cloud provider (AWS EC2)
    Example: Use Docker Machine to provision cloud hosts (Digital Ocean)
    Using Docker Machine with a cloud provider
    Docker User Guide (after your install is complete, get started using Docker)

* :doc:`cloud-ex-aws` (AWS EC2)
* :doc:`cloud-ex-machine-ocean` (Digital Ocean)
* サポートしているプラットフォームの情報は :doc:`/engine/installation/index` をご覧ください。
* :doc:`Docker ユーザ・ガイド </engine/userguide/index>` (インストールが終わったら、Docker を使い始めましょう)

.. seealso:: 

   Choose how to install
      https://docs.docker.com/engine/installation/cloud/overview/

