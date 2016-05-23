.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/machine/drivers/os-base/
.. SOURCE: https://github.com/docker/machine/blob/master/docs/drivers/os-base.md
   doc version: 1.11
      https://github.com/docker/machine/commits/master/docs/drivers/os-base.md
.. check date: 2016/04/28
.. Commits on Apr 23, 2016 c9c6bc45f0e91c9b99129c0a16d0641cd7a266e9
.. ----------------------------------------------------------------------------

.. Driver options and operating system defaults

.. _driver-options-and-operating-system-defaults:

=======================================
ドライバのオプションと、デフォルト OS
=======================================

.. When Docker Machine provisions containers on local network provider or with a remote, cloud provider such as Amazon Web Services, you must define both the driver for your provider and a base operating system. There are over 10 supported drivers and a generic driver for adding machines for other providers.

ローカル・ネットワーク・プロバイダ、あるいはリモート環境、そして Amazon Web Services のようなクラウド・プロバイダ上において、 Docker Machine がコンテナをプロビジョニングする場合は、プロバイダに対応したドライバと、ベースとなるオペレーティング・システムの両方を定義する必要があります。10 を越えるサポート済みドライバと、その他のプロバイダ上にマシンを追加する generic （ジェネリック）ドライバがあります。

.. Each driver has a set of options specific to that provider. These options provide information to machine such as connection credentials, ports, and so forth. For example, to create an Azure machine:

各ドライバは、各プロバイダ固有のオプション群を持っています。これらのオプションはマシンに対する情報を提供するものです。たとえば、接続時に必要となる認証情報（credential）、ポート番号などがあります。

.. Grab your subscription ID from the portal, then run docker-machine create with these details:

例えば、Azure マシンを作成するには、ポータル上でサブスクリプション ID を取得してから、 ``docker-machine create``  を次のように時刻します。

.. code-block:: bash

   $ docker-machine create -d azure --azure-subscription-id="SUB_ID" --azure-subscription-cert="mycert.pem" A-VERY-UNIQUE-NAME

.. To see a list of providers and review the options available to a provider, see the Docker Machine driver reference.

プロバイダの一覧や、各プロバイダで利用できるオプション一覧を確認するには、 `Docker Machine ドライバ・リファレンス（英語） <https://docs.docker.com/machine/>`_ をご覧ください。

.. In addition to the provider, you have the option of identifying a base operating system. It is an option because Docker Machine has defaults for both local and remote providers. For local providers such as VirtualBox, Fusion, Hyper-V, and so forth, the default base operating system is Boot2Docker. For cloud providers, the base operating system is the latest Ubuntu LTS the provider supports.

プロバイダに加え、ベース・オペレーティング・システムごとに固有のオプションを指定できます。しかし、Docker machine はローカル・リモートの各プロバイダに対するデフォルト指定を持っているため、オプション指定は任意です。VirtualBox、Fusion、Hyper-V 等のようなローカル・プロバイダでは、デフォルトのベース・オペレーティング・システムは Boot2Docker です。クラウド・プロバイダ向けのベース・オペレーティング・システムは、プロバイダが提供している最新の Ubuntu LTS です。

.. Operating System 	Version 	Notes
.. Boot2Docker 	1.5+ 	default for local
.. Ubuntu 	12.04+ 	default for remote
.. RancherOS 	0.3+ 	
.. Debian 	8.0+ 	experimental
.. RedHat Enterprise Linux 	7.0+ 	experimental
.. CentOS 	7+ 	experimental
.. Fedora 	21+ 	experimental

.. list-table::
   :header-rows: 1
   
   * - オペレーティング・システム
     - バージョン
     - メモ
   * - Boot2Docker 
     - 1.5+
     - ローカル用のデフォルト
   * - Ubuntu
     - 12.04+
     - リモート用のデフォルト
   * - RancherOS
     - 0.3+
     - 
   * - Debian
     - 8.0+
     - 実験的(experimental)
   * - Red Hat Enterprise Linux
     - 7.0+
     - 実験的(experimental)
   * - CentOS
     - 7.0+
     - 実験的(experimental)
   * - Fedora
     - 21+
     - 実験的(experimental)

.. To use a different base operating system on a remote provider, specify the provider’s image flag and one of its available images. For example, to select a debian-8-x64 image on DigitalOcean you would supply the --digitalocean-image=debian-8-x64 flag.

リモート・プロバイダ上で異なったベース・オペレーティング・システムを使うには、プロバイダのイメージ・フラグと利用可能なイメージの指定が必要になります。例えば、 DigitalOcean で ``debian-8-x64`` イメージを指定するには、 ``--digitalocean-image=debian-8-x64`` フラグが必要です。

.. If you change the base image for a provider, you may also need to change the SSH user. For example, the default Red Hat AMI on EC2 expects the SSH user to be ec2-user, so you would have to specify this with --amazonec2-ssh-user ec2-user.

プロバイダ用のベース・イメージを変更する時、SSH ユーザの変更も必要になる場合があります。例えば、 EC2 上のデフォルト Red Hat AMI の SSH ユーザは ``ec2-user`` ですので、 ``--amazonec2-ssh-user ec2-user`` と指定する必要があります。

.. seealso:: 

   Driver options and operating system defaults
      https://docs.docker.com/machine/drivers/os-base/

