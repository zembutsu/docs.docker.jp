.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/installation/linux/rhel/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/installation/linux/rhel.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/installation/linux/rhel.md
.. check date: 2016/06/13
.. Commits on Mar 9, 2016 cdd8d3999ffd9f7eeb764f52e21577e0900d7b5c
.. ----------------------------------------------------------------------------

.. Red Hat enterprise Linux

==============================
Red Hat Enterprise Linux
==============================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Docker is supported on Red Hat Enterprise Linux 7. This page instructs you to install using Docker-managed release packages and installation mechanisms. Using these packages ensures you get the latest release of Docker. If you wish to install using Red Hat-managed packages, consult your Red Hat release documentation for information on Red Hat’s Docker support.

Docker は Red Hat Enterprise Linux 7 でサポートされています。このページでは Docker が管理しているパッケージとインストール手法を使ってインストールします。これらパッケージを使い、Docker の最新リリースを入手します。もし Red Hat が管理するパッケージを使いたい場合は、Red Hat の Docker サポートに関する情報のドキュメントをお調べください。


.. Prerequisites

動作条件
====================

.. Docker requires a 64-bit installation regardless of your Red Hat version. Docker requires that your kernel must be 3.10 at minimum, which Red Hat 7 runs.

Docker は 64bit でインストールされた何らかの Red Hat バージョンを必要とします。さらに、Red Hat 7 で動作する kernel は少なくとも 3.10 以上が必要です。

.. To check your current kernel version, open a terminal and use uname -r to display your kernel version:

現在のカーネル・バージョンを確認するには、ターミナルを開き、 ``uname -r``  を使ってカーネルのバージョンを確認します。

.. code-block:: bash

   $ uname -r
   3.10.0-229.el7.x86_64

.. Finally, is it recommended that you fully update your system. Please keep in mind that your system should be fully patched to fix any potential kernel bugs. Any reported kernel bugs may have already been fixed on the latest kernel packages.

最後に、システム全ての更新をお勧めします。システムは潜在的なカーネルのバグを修正するために、全てパッチを当てるべきと考慮ください。報告されているカーネルのバグは、最新のカーネル・パッケージでは修正済みの場合があります。

.. Install Docker Engine

Docker エンジンのインストール
==============================

.. There are two ways to install Docker Engine. You can install with the yum package manager directly yourself. Or you can use curl with the get.docker.com site. This second method runs an installation script which installs via the yum package manager.

Docker エンジンをインストールするには２つの方法があります。 ``yum`` パッケージ・マネージャを使い、直接自分でインストールできます。あるいは、 ``curl`` で ``get.docker.com`` を使う方法があります。２つめの方法はインストール用のスクリプトを実行し、 ``yum``  パッケージ・マネージャを通してセットアップします。

.. Install with yum

yum でインストール
-------------------

..    Log into your machine as a user with sudo or root privileges.

1. マシンに ``sudo`` あるいは ``root`` 特権のあるユーザでログインします。

..    Make sure your existing yum packages are up-to-date.

2. 既存の yum パッケージを更新します。

.. code-block:: bash

   $ sudo yum update

..    Add the yum repo yourself.

3. yum リポジトリを手動で追加します。

.. code-block:: bash

   $ sudo tee /etc/yum.repos.d/docker.repo <<-EOF
   [dockerrepo]
   name=Docker Repository
   baseurl=https://yum.dockerproject.org/repo/main/centos/7
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

.. code-block:: bash

   $ sudo service docker start

..    Verify docker is installed correctly by running a test image in a container.

6. ``docker`` が正常にインストールされたか確認するため、コンテナでテスト用イメージを実行します。

.. code-block:: bash

   $ sudo docker run hello-world
   Unable to find image 'hello-world:latest' locally
       latest: Pulling from hello-world
       a8219747be10: Pull complete
       91c95931e552: Already exists
       hello-world:latest: The image you are pulling has been verified. Important: image verification is a tech preview feature and should not be relied on to provide security.
       Digest: sha256:aa03e5d0d5553b4c3473e89c8619cf79df368babd1.7.1cf5daeb82aab55838d
       Status: Downloaded newer image for hello-world:latest
       Hello from Docker.
       This message shows that your installation appears to be working correctly.
   
   
       To generate this message, Docker took the following steps:
        1. The Docker client contacted the Docker daemon.
        2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
               (Assuming it was not already locally available.)
        3. The Docker daemon created a new container from that image which runs the
               executable that produces the output you are currently reading.
        4. The Docker daemon streamed that output to the Docker client, which sent it
               to your terminal.
   
   
       To try something more ambitious, you can run an Ubuntu container with:
        $ docker run -it ubuntu bash
   
   
       For more examples and ideas, visit:
        http://docs.docker.com/userguide/

.. Install with the script

スクリプトでインストール
------------------------------

.. You use the same installation procedure for all versions of CentOS.

同じ手順が Red Hat Enterprise Linux の全てのバージョンで使えます。

..    Log into your machine as a user with sudo or root privileges.

1. マシンに ``sudo`` あるいは ``root`` 特権のあるユーザでログインします。

..     Make sure your existing yum packages are up-to-date.

2. 既存の yum パッケージを更新します。

.. code-block:: bash

   $ sudo yum update

..    Run the Docker installation script.

3. Docker インストール用スクリプトを実行します。

.. code-block:: bash

   $ curl -sSL https://get.docker.com/ | sh

..    Start the Docker daemon.

4. Docker デーモンを起動します。

.. code-block:: bash

   $ sudo service docker start

..    Verify docker is installed correctly by running a test image in a container.

5.  ``docker`` が正常にインストールされたか確認するため、コンテナでテスト用イメージを実行します。

.. code-block:: bash

   $ sudo docker run hello-world

.. Create a docker group

docker グループの作成
==============================

.. The docker daemon binds to a Unix socket instead of a TCP port. By default that Unix socket is owned by the user root and other users can access it with sudo. For this reason, docker daemon always runs as the root user.

``docker`` デーモンは TCP ポートの替わりに Unix ソケットをバインドします。デフォルトでは、Unix ソケットは ``root`` ユーザによって所有されており、他のユーザは ``sudo`` でアクセスできます。このため、 ``docker`` デーモンは常に ``root`` ユーザとして実行されています。

.. To avoid having to use sudo when you use the docker command, create a Unix group called docker and add users to it. When the docker daemon starts, it makes the ownership of the Unix socket read/writable by the docker group.

``docker`` コマンド利用時に ``sudo`` を使わないようにするには、 ``docker`` という名称のグループを作成し、そこにユーザを追加します。 ``docker`` デーモンが起動すると、``docker`` グループの所有者により Unix ソケットの読み書きが可能になります。

..    Warning: The docker group is equivalent to the root user; For details on how this impacts security in your system, see Docker Daemon Attack Surface for details.

.. warning::

   ``docker`` グループは ``root`` ユーザ相当です。システム上のセキュリティに対する影響の詳細は、 :ref:`Docker デーモンが直面する攻撃 <docker-daemon-attack-surface>` をご覧ください。

.. To create the docker group and add your user:

``docker`` グループを作成し、ユーザを追加するには、

..    Log into Red Hat as a user with sudo privileges.

1. Red Hat に ``sudo`` 特権のあるユーザでログインします。

..    Create the docker group and add your user.

2. ``docker`` グループを作成し、ユーザを追加します。

.. code-block:: bash

   $ sudo usermod -aG docker ubuntu

..    Log out and log back in.

3. ログアウトしてから、再度ログインします。

..    This ensures your user is running with the correct permissions.

対象ユーザが正しい権限を持つようにするためです。

..    Verify your work by running docker without sudo.

4. ``sudo`` を使わずに ``docker`` が実行できることを確認します。

.. code-block:: bash

   $ docker run hello-world

.. Start the docker daemon at boot

ブート時の Docker 開始設定
------------------------------

.. To ensure Docker starts when you boot your system, do the following:

Docker をブート時に起動するようにするには、次のように実行します。

.. code-block:: bash

   $ sudo chkconfig docker on

.. If you need to add an HTTP Proxy, set a different directory or partition for the Docker runtime files, or make other customizations, read our Systemd article to learn how to customize your Systemd Docker daemon options.

HTTP プロキシの追加が必要な場合、Docker のランタイム・ファイルを異なったディレクトリやパーティションに置いてください。あるいは別のカスタマイズ方法として、Systemd の記事 :doc:`Systemd Docker デーモン・オプションのカスタマイズ </engine/admin/systemd>` から、どのように設定するかをご覧ください。

.. Uninstall

アンインストール
====================

.. You can uninstall the Docker software with yum.

Docker ソフトウェアを yum でアンインストール可能です。

..    List the package you have installed.

1. インストールしたパッケージの一覧を表示します。

.. code-block:: bash

   $ yum list installed | grep docker
   yum list installed | grep docker
   docker-engine.x86_64                1.7.1-0.1.el7@/docker-engine-1.7.1-0.1.el7.x86_64

..    Remove the package.

2. パッケージを削除します。

.. code-block:: bash

   $ sudo yum -y remove docker-engine.x86_64

..    This command does not remove images, containers, volumes, or user created configuration files on your host.

上記のコマンドは、イメージ、コンテナ、ボリュームやホスト上の設定ファイルを削除しません。

..    To delete all images, containers, and volumes run the following command:

3. イメージ、コンテナ、ボリュームを削除するには次のコマンドを実行します。

.. code-block:: bash

   $ rm -rf /var/lib/docker

..    Locate and delete any user-created configuration files.

4. ユーザが作成した設定ファイルを探して削除します。

.. seealso:: 

   Installation on Red Hat Enterprise Linux
      https://docs.docker.com/engine/installation/linux/rhel/
