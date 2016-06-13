.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/installation/linux/oracle/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/installation/linux/oracle.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/installation/linux/oracle.md
.. check date: 2016/06/13
.. Commits on May 26, 2016 7711c842be52cd753c13a50594da301f2158ddae
.. ----------------------------------------------------------------------------

.. Oracle Linux

==============================
Oracle Linux
==============================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Docker is supported Oracle Linux 6 and 7. You do not require an Oracle Linux Support subscription to install Docker on Oracle Linux.

Docker は Oracle Linux 6 と 7 をサポートします。Docker Linux に Docker をインストールするにあたり、Oracle Linux サポートのサブスクリプションは不要です。

.. This page instructs you to install using Docker-managed release packages and installation mechanisms. Using these packages ensures you get the latest release of Docker. If you wish to install using Oracle Linux-managed packages, consult your Oracle Linux documentation.

このページでは Docker が管理しているパッケージとインストール手法を使ってインストールします。これらパッケージを使い、Docker の最新リリースを入手します。もし Oracle Linux が管理するパッケージを使いたい場合は、Oracle Linux の Docker サポートに関する情報の `ドキュメント <https://linux.oracle.com/>`_ をお調べください。

.. Prerequisites

動作条件
====================

.. Due to current Docker limitations, Docker is only able to run only on the x86_64 architecture. Docker requires the use of the Unbreakable Enterprise Kernel Release 3 (3.8.13) or higher on Oracle Linux. This kernel supports the Docker btrfs storage engine on both Oracle Linux 6 and 7

現在は Docker の制限により、Docker は x86_64 アーキテクチャ上でのみ動作します。Docker は Oracle Linux の Unbreakable Enterprise Kernel Release 4 (4.1.12) 以上をサポートします。このカーネルは Oracle Linux 6 と 7 で、Docker の btrfs ストレージエンジンをサポートしています。

.. Install

インストール
====================

.. Note: The procedure below installs binaries built by Docker. These binaries are not covered by Oracle Linux support. To ensure Oracle Linux support, please follow the installation instructions provided in the Oracle Linux documentation.
.. The installation instructions for Oracle Linux 6 can be found in Chapter 10 of the Administrator's Solutions Guide
.. The installation instructions for Oracle Linux 7 can be found in Chapter 29 of the Administrator's Guide

.. note::

   以下のバイナリ版インストール手順は Docker が作成しました。これらのバイナリは Oracle Linux サポートが扱わないものです。Oracle Linux サポートが必要であれば、 `Oracle Linux が提供するドキュメント <https://docs.oracle.com/en/operating-systems/?tab=2>`_ のインストール手順に従ってください。

.. note::

   Oracle Linux 6 および 7 に関するインストール手順は `the Administrator's Solutions Guide の Chapter 2 <https://docs.oracle.com/cd/E52668_01/E75728/html/docker_install_upgrade.html>`_ をご覧ください。


..    Log into your machine as a user with sudo or root privileges.

1. マシンに ``sudo`` あるいは ``root`` 特権のあるユーザでログインします。

..    Make sure your existing yum packages are up-to-date.

2. 既存の yum パッケージを更新します。

.. code-block:: bash

   $ sudo yum update

..    Add the yum repo yourself.

3. yum リポジトリを手動で追加します。

バージョン６の場合：

.. code-block:: bash

   $ sudo tee /etc/yum.repos.d/docker.repo <<-EOF
   [dockerrepo]
   name=Docker Repository
   baseurl=https://yum.dockerproject.org/repo/main/oraclelinux/6
   enabled=1
   gpgcheck=1
   gpgkey=https://yum.dockerproject.org/gpg
   EOF

バージョン７の場合：

.. code-block:: bash

   $ sudo tee /etc/yum.repos.d/docker.repo <<-EOF
   [dockerrepo]
   name=Docker Repository
   baseurl=https://yum.dockerproject.org/repo/main/oraclelinux/7
   enabled=1
   gpgcheck=1
   gpgkey=https://yum.dockerproject.org/gpg
   EOF

..    Install the Docker package.

4. Docker パッケージをインストールします。

.. code-block:: bash

   $ sudo yum install docker-engine

..    Start the Docker daemon.

5. Docker デーモンを開始します。

Oracle Linux６の場合：

.. code-block:: bash

   $ sudo service docker start

Oracle Linux７の場合：

.. code-block:: bash

   $ sudo systemctl start docker.service

..    Verify docker is installed correctly by running a test image in a container.

6. ``docker`` が正常にインストールされたか確認するため、コンテナでテスト用イメージを実行します。

.. code-block:: bash

   $ sudo docker run hello-world

.. Optional configurations

オプション設定
====================

.. This section contains optional procedures for configuring your Oracle Linux to work better with Docker.

このセクションは、Oracle Linux と Docker がうまく機能するようなオプション手順を紹介します。

..    Create a docker group
    Configure Docker to start on boot
    Use the btrfs storage engine

* docker グループの作成
* ブート時の Docker 開始設定
* btrfs ストレージ・エンジンを使う

.. Create a Docker group

docker グループの作成
------------------------------

.. The docker daemon binds to a Unix socket instead of a TCP port. By default that Unix socket is owned by the user root and other users can access it with sudo. For this reason, docker daemon always runs as the root user.

``docker`` デーモンは TCP ポートの替わりに Unix ソケットをバインドします。デフォルトでは、Unix ソケットは ``root`` ユーザによって所有されており、他のユーザは ``sudo`` でアクセスできます。このため、 ``docker`` デーモンは常に ``root`` ユーザとして実行されています。

.. To avoid having to use sudo when you use the docker command, create a Unix group called docker and add users to it. When the docker daemon starts, it makes the ownership of the Unix socket read/writable by the docker group.

``docker`` コマンド利用時に ``sudo`` を使わないようにするには、 ``docker`` という名称のグループを作成し、そこにユーザを追加します。 ``docker`` デーモンが起動すると、``docker`` グループの所有者により Unix ソケットの読み書きが可能になります。

..    Warning: The docker group is equivalent to the root user; For details on how this impacts security in your system, see Docker Daemon Attack Surface for details.

.. warning::

   ``docker`` グループは ``root`` ユーザ相当です。システム上のセキュリティに対する影響の詳細は、 :ref:`Docker デーモンが直面する攻撃 <docker-daemon-attack-surface>` をご覧ください。

.. To create the docker group and add your user:

``docker`` グループを作成し、ユーザを追加するには、

..    Log into Oracle Linux as a user with sudo privileges.

1. Oracle Linux に ``sudo`` 特権のあるユーザでログインします。

..    Create the docker group and add your user.

2. ``docker`` グループを作成し、ユーザを追加します。

.. code-block:: bash

   $ sudo usermod -aG docker username

..    Log out and log back in.

3. ログアウトしてから、再度ログインします。

..    This ensures your user is running with the correct permissions.

対象ユーザが正しい権限を持つようにするためです。

..    Verify your work by running docker without sudo.

4. ``sudo`` を使わずに ``docker`` が実行できることを確認します。

.. code-block:: bash

   $ docker run hello-world

..    If this fails with a message similar to this:

失敗すると、次のようなメッセージが表示されます。

.. code-block:: bash

   Cannot connect to the Docker daemon. Is 'docker daemon' running on this host?

..    Check that the DOCKER_HOST environment variable is not set for your shell. If it is, unset it.

``DOCKER_HOST`` 環境変数をシェル上で確認します。もし設定されていれば、unset します。



.. Start the docker daemon at boot

ブート時の Docker 開始設定
------------------------------

.. To ensure Docker starts when you boot your system, do the following:

Docker をブート時に起動するようにするには、次のように実行します。

Oracle Linux 6 の場合：

.. code-block:: bash

   $ sudo chkconfig docker on

Oracle Linux 7 の場合：

.. code-block:: bash

   $ sudo systemctl enable docker.service

.. If you need to add an HTTP Proxy, set a different directory or partition for the Docker runtime files, or make other customizations, read our Systemd article to learn how to customize your Systemd Docker daemon options.

HTTP プロキシの追加が必要な場合、Docker のランタイム・ファイルを異なったディレクトリやパーティションに置いてください。あるいは別のカスタマイズ方法として、Systemd の記事 :doc:`Systemd Docker デーモン・オプションのカスタマイズ </engine/admin/systemd>` から、どのように設定するかをご覧ください。

.. Use the btrfs storage engine

btrfs ストレージ・エンジンを使う
----------------------------------------

.. Docker on Oracle Linux 6 and 7 supports the use of the btrfs storage engine. Before enabling btrfs support, ensure that /var/lib/docker is stored on a btrfs-based filesystem. Review Chapter 5 of the Oracle Linux Administrator’s Solution Guide for details on how to create and mount btrfs filesystems.

Docker は Oracle Linux 6 と 7 で btrfs ストレージ・エンジンの使用をサポートしています。btrfs サポートを有効化する前に、 ``/var/lib/docker`` が btrfs に対応したファイルシステムに保管されていることを確認します。 `Oracle Linux Administrator's Solution Guide <http://docs.oracle.com/cd/E37670_01/E37355/html/index.html>`_ の `Chapter 5 <http://docs.oracle.com/cd/E37670_01/E37355/html/ol_btrfs.html>`_ にある btrfs ファイルシステムの作成とマウント方法をご確認ください。

.. To enable btrfs support on Oracle Linux:

Oracle Linux 上で btrfs サポートを有効化します。

..    Ensure that /var/lib/docker is on a btrfs filesystem.

1. ``/var/lib/docker`` が btrfs ファルシステム上にあることを確認します。

..    Edit /etc/sysconfig/docker and add -s btrfs to the OTHER_ARGS field.

2. ``/etc/sysconfig/docker`` を編集し、 ``-s btrfs`` を ``OTHER_ARGS`` フィールドに追加します。

..    Restart the Docker daemon:

3. Docker デーモンを再起動します。

.. Uninstall

アンインストール
====================

.. To uninstall the Docker package:

Docker パッケージをアンインストールします。

.. code-block:: bash

   $ sudo yum -y remove docker

..    The above command will not remove images, containers, volumes, or user created configuration files on your host. If you wish to delete all images, containers, and volumes run the following command:

上記のコマンドは、イメージ、コンテナ、ボリュームやホスト上の設定ファイルを削除しません。イメージ、コンテナ、ボリュームを削除するには次のコマンドを実行します。

.. code-block:: bash

   $ rm -rf /var/lib/docker

..    Locate and delete any user-created configuration files.

ユーザが作成した設定ファイルは、探して削除する必要があります。

.. Known issues

既知の問題
==========

.. Docker unmounts btrfs filesystem on shutdown

Docker 停止時の btrfs ファイルシステムのアンマウント
------------------------------------------------------------

.. If you’re running Docker using the btrfs storage engine and you stop the Docker service, it will unmount the btrfs filesystem during the shutdown process. You should ensure the filesystem is mounted properly prior to restarting the Docker service.

Docker を btrfs ストレージ・エンジンを使って実行している場合、Docker サービスを停止すると、停止プロセスの中で btrfs ファイルシステムをアンマウントします。Docker サービスを再起動する場合は、ファイルシステムがマウントされているか確認してください。

.. On Oracle Linux 7, you can use a systemd.mount definition and modify the Docker systemd.service to depend on the btrfs mount defined in systemd.

Oracle Linux 7 では、 ``systemd.mount`` 定義を使えます。Docker の ``systemd.service`` を編集し、 btrfs マウントに関する systemd の定義を書き換えます。

.. SElinux support on Oracle Linux 7

Oracle Linux 7 の SELinux サポート
----------------------------------------

.. SElinux must be set to Permissive or Disabled in /etc/sysconfig/selinux to use the btrfs storage engine on Oracle Linux 7.

Oracle Linux 7 で btrfs ストレージ・エンジンを使う場合は、 ``/etc/sysconfig/selinux``  の SELinux の設定を ``Permissive`` か ``Disabled`` にする必要があります。

.. Further issues?

さらに問題が？
====================

.. If you have a current Basic or Premier Support Subscription for Oracle Linux, you can report any issues you have with the installation of Docker via a Service Request at My Oracle Support.

既に Oracle Linux の Basic か Premier サポートのサブスクリプションをお持ちであれば、Docker のインストールに関連する問題は `My Oracle Support <http://support.oracle.com/>`_ にリクエスト可能です。

.. If you do not have an Oracle Linux Support Subscription, you can use the Oracle Linux Forum for community-based support.

Oracle Linux サポート・サブスクリプションをお持ちでなければ、 `Oracle Linux Forum <https://community.oracle.com/community/server_%26_storage_systems/linux/oracle_linux>`_ コミュニティのサポートをご利用ください。

.. seealso:: 

   Installation on Oracle Linux
      https://docs.docker.com/engine/installation/linux/oracle/
