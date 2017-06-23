.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/installation/linux/SUSE/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/installation/linux/SUSE.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/installation/linux/SUSE.md
.. check date: 2016/06/13
.. Commits on Jan 27, 2016 e310d070f498a2ac494c6d3fde0ec5d6e4479e14
.. ----------------------------------------------------------------------------

.. openSUSE and SUSE Linux Enterprise

========================================
openSUSE and SUSE Linux Enterprise
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. This page provides instructions for installing and configuring the lastest Docker Engine software on openSUSE and SUSE systems.

このページは最新の Docker エンジン・ソフトウェアを openSUSE と SUSE システムにインストール・設定する方法を紹介します。

..    Note: You can also find bleeding edge Docker versions inside of the repositories maintained by the Virtualization:containers project on the Open Build Service. This project delivers also other packages that are related with the Docker ecosystem (for example, Docker Compose).

.. note::

   `Open Build Service <https://build.opensuse.org/>`_ では `Virtualization container project <https://build.opensuse.org/project/show/Virtualization:containers>`_ の中で派生バージョンの Docker がメンテナンスされています。このプロジェクトは他の Docker エコシステム（例：Docker Compose）パッケージも提供しています。

.. Prerequisites

動作条件
==========

.. You must be running a 64 bit architecture.

64 bit アーキテクチャで実行する必要があります。

.. openSUSE

openSUSE
----------

.. Docker is part of the official openSUSE repositories starting from 13.2. No additional repository is required on your system.

Docker は openSUSE 13.2 以降、公式リポジトリの一つです。システム上に追加リポジトリは不要です。

.. SUSE Linux Enterprise

SUSE Linux Enterprise
------------------------------

.. Docker is officially supported on SUSE Linux Enterprise 12 and later. You can find the latest supported Docker packages inside the Container module. To enable this module, do the following:

SUSE Linux Enterprise 12 以降、Docker は正式にサポートされています。 ``Container`` モジュールの中で、最新のサポートされた Docker パッケージを確認できます。このモジュールを有効にするには、次のようにします。

..    Start YaST, and select Software > Software Repositories.

1. YaST を開始します。*Software* > *Software Repositories* を選びます。

..    Click Add to open the add-on dialog.

2. add-on ダイアログで *Add* をクリックして開きます。

..    Select Extensions and Module from Registration Server and click Next.

3. *Extensions and Module from Registration Server* を選択し、 *Next* をクリックします。

..    From the list of available extensions and modules, select Container Module and click Next. The containers module and its repositories are added to your system.

4. 利用可能な extensions と modules の中から、 *Container Module* を選び、 *Next* をクリックします。container モジュールとリポジトリがシステムに追加されます。

..    If you use Subscription Management Tool, update the list of repositories at the SMT server.

5. Subscription Management Tool を使っている場合、SMT サーバのリポジトリ・リストを更新します。

.. Otherwise execute the following command:

あるいは、次のコマンドを実行します。

.. code-block:: bash

   $ sudo SUSEConnect -p sle-module-containers/12/x86_64 -r ''
   
.. **Note:** currently the `-r ''` flag is required to avoid a known limitation of `SUSEConnect`.

.. note::

   現時点では ``-r`` フラグが ``SUSEConnect`` に対する既知の制限を避けるために必要です。

.. The Virtualization:containers project on the Open Build Service contains also bleeding edge Docker packages for SUSE Linux Enterprise. However these packages are not supported by SUSE.

   `Open Build Service <https://build.opensuse.org/>`_ にある `Virtualization container project <https://build.opensuse.org/project/show/Virtualization:containers>`_ には SUSE Linux Enteprise の Docker 派生パッケージが含まれています。しかしながら、これらのパッケージは SUSE に **サポートされません**。

.. Install Docker

Docker インストール
====================

..    Install the Docker package:

1. Docker パッケージをインストールします。

.. code-block:: bash

   $ sudo zypper in docker

..    Start the Docker daemon.

2. Docker デーモンを開始します。

.. code-block:: bash

   $ sudo systemctl start docker

..    Test the Docker installation.

3. Docker インストールを確認します。

.. code-block:: bash

   $ sudo docker run hello-world

.. Configure Docker boot options

Docker 起動時のオプション設定
==============================

.. You can use these steps on openSUSE or SUSE Linux Enterprise. To start the docker daemon at boot, set the following:

この手順は openSUSE でも SUSE でも使えます。``docker`` デーモンをブート時に起動するには、次のようにします。

.. code-block:: bash

   $ sudo systemctl enable docker

.. The docker package creates a new group named docker. Users, other than root user, must be part of this group to interact with the Docker daemon. You can add users with this command syntax:

``docker`` パッケージは ``docker`` という名称のグループを作成します。 ``root`` 以外のユーザが Docker デーモンに接続するには、このグループに所属させるひつヨガあります。ユーザの追加は、次のような構文です。

.. code-block:: bash

   sudo /usr/sbin/usermod -a -G docker <username>

.. Once you add a user, make sure they relog to pick up these new permissions.

ユーザを追加したら、新しい権限を適用するために再ログインします。

.. Enable external network access

外部ネットワークへのアクセス
==============================

.. If you want your containers to be able to access the external network, you must enable the net.ipv4.ip_forward rule. To do this, use YaST.

コンテナが外部のネットワークへ接続できるようにするには、 ``net.ipv4.ip_forwrad`` ルールを有効にしなくてはいけません。ここでは YaST を使います。

.. For openSUSE Tumbleweed and later, browse to the System -> Network Settings -> Routing menu. For SUSE Linux Enterprise 12 and previous openSUSE versions, browse to Network Devices -> Network Settings -> Routing menu (f) and check the Enable IPv4 Forwarding box.

openSUSE Tumbleweed 以降は、**System -> Network Settings -> Routing** メニューを開きます。SUSE Linux Enterprise 12 と以前の openSUSE バージョンの場合は、 **Network Device -> Network Settings -> Routing** メニューを開き、 *Enable IPv4 Forwarding* ボックスにチェックを入れます。

.. When networking is handled by the Network Manager, instead of YaST you must edit the /etc/sysconfig/SuSEfirewall2 file needs by hand to ensure the FW_ROUTE flag is set to yes like so:

YaST の替わりに Network Manager でネットワークを管理している場合は、 ``/etc/sysconfig/SuSEfirewall2`` ファイルの ``FW_ROUTE`` フラグを ``yes`` にする必要があります。

.. code-block:: bash

   FW_ROUTE="yes"

.. Custom daemon options

デーモンのオプション設定
==============================

.. If you need to add an HTTP Proxy, set a different directory or partition for the Docker runtime files, or make other customizations, read our Systemd article to learn how to customize your Systemd Docker daemon options.

HTTP プロキシの追加が必要な場合、Docker のランタイム・ファイルを異なったディレクトリやパーティションに置いてください。あるいは別のカスタマイズ方法として、Systemd の記事 :doc:`Systemd Docker デーモン・オプションのカスタマイズ </engine/admin/systemd>` から、どのように設定するかをご覧ください。

.. Uninstallation

アンインストール
====================

.. To uninstall the Docker package:

Docker パッケージをアンインストールします。

.. code-block:: bash

   $ sudo zypper rm docker

.. The above command does not remove images, containers, volumes, or user created configuration files on your host. If you wish to delete all images, containers, and volumes run the following command:

上記のコマンドは、イメージ、コンテナ、ボリュームやホスト上の設定ファイルを削除しません。イメージ、コンテナ、ボリュームを削除するには次のコマンドを実行します。

.. code-block:: bash

   $ rm -rf /var/lib/docker

.. You must delete the user created configuration files manually.

ユーザが作成した設定ファイルは、探して削除する必要があります。

.. Where to go from here

どこに進みますか
====================

.. You can find more details about Docker on openSUSE or SUSE Linux Enterprise in the Docker quick start guide on the SUSE website. The document targets SUSE Linux Enterprise, but its contents apply also to openSUSE.

openSUSE または SUSE Linux Enterprise での Docker に関するより詳しい情報は、SUSE ウェブサイト上の `Docker quick start guide <https://www.suse.com/documentation/sles-12/dockerquick/data/dockerquick.html>`_ をご覧ください。このドキュメントの対象は SUSE Linux Enterprise 向けですが、openSUSE にも適用できます。

.. Continue to the User Guide.

:doc:`ユーザガイド </engine/userguide/index>` に進みます。

.. seealso:: 

   Installation on openSUSE and SUSE Linux Enterprise
      https://docs.docker.com/engine/installation/linux/SUSE/

