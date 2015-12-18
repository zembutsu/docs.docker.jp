.. -*- coding: utf-8 -*-
.. https://docs.docker.com/engine/installation/debian/
.. doc version: 1.9
.. check date: 2015/12/18
.. -----------------------------------------------------------------------------

.. Debian

==============================
Debian
==============================

.. Docker is supported on these Debian operating systems:

Docker は以下の Debian バージョンをサポートしています。

* Debian testing stretch (64-bit)
* Debian 8.0 Jessie (64-bit)
* Debian 7.7 Wheezy (64-bit)

..    Note: If you previously installed Docker using apt, make sure you update your apt sources to the new apt repository.

.. note::

   以前に Docker を ``apt`` でインストールしていた場合は、 ``apt`` ソースを新しい Docker レポジトリに更新してください。

.. Prerequisites

動作条件
====================

.. Docker requires a 64-bit installation regardless of your Debian version. Additionally, your kernel must be 3.10 at minimum. The latest 3.10 minor version or a newer maintained version are also acceptable.

Docker は 64bit でインストールされた何らかの Debian バージョンを必要とします。さらに、kernel は少なくとも 3.10 以上が必要です。最新の 3.10 マイナーバージョンか、それよりも新しいバージョンが利用可能です。

.. Kernels older than 3.10 lack some of the features required to run Docker containers. These older versions are known to have bugs which cause data loss and frequently panic under certain conditions.

3.10 よりも低いカーネルは、Docker コンテナ実行時に必要な一部の機能が足りません。古いバージョンは既知のバグがあります。その影響により、特定条件下でデータの損失や定期的なカーネルパニックを引き起こします。

.. To check your current kernel version, open a terminal and use uname -r to display your kernel version:

現在のカーネル・バージョンを確認するには、ターミナルを開き、 ``uname -r``  を使ってカーネルのバージョンを確認します。

.. code-block:: bash

   $ uname -r

.. Update your apt sources

apt ソースの更新
--------------------

.. Docker’s apt repository contains Docker 1.7.1 and higher. To set apt to use packages from the new repository:

Docker 1.7.1 以上は Docker の ``apt`` レポジトリに保管されています。 ``apt`` が新しいレポジトリにあるパッケージを使えるように設定します。

..    If you haven’t already done so, log into your Debian instance as a privileged user.

1. まだであれば Debian サーバに特権ユーザでログインします。

..    Open a terminal window.

2. ターミナルのウインドウを開きます。

.. Purge any older repositories.

3. 古いレポジトリをパージします。

.. code-block:: bash

   $ apt-get purge lxc-docker*
   $ apt-get purge docker.io*

..    Add the new gpg key.

3. 新しい ``gpg`` 鍵を追加します。

.. code-block:: bash

   $ sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

..    Open the /etc/apt/sources.list.d/docker.list file in your favorite editor.

4. ``/etc/apt/sources.list.d/docker.list`` ファイルを好みのエディタで開きます。

..    If the file doesn’t exist, create it.

ファイルが存在しなければ、作成します。

..    Remove any existing entries.

5. 既存のエントリがあれば削除します。

..    Add an entry for your Debian operating system.

6. Debian オペレーティング・システム向けのエントリを追加します。

..    The possible entries are:

利用可能なエントリは以下の通りです。

..        On Debian Wheezy

* Debian Wheezy

.. code-block:: bash

   deb https://apt.dockerproject.org/repo debian-wheezy main

..        On Debian Jessie

* Debian Jessie

.. code-block:: bash

   deb https://apt.dockerproject.org/repo debian-jessie main

..        On Debian Stretch/Sid

* Debian Stretch/Sid

.. code-block:: bash

   deb https://apt.dockerproject.org/repo debian-stretch main

..    Save and close the /etc/apt/sources.list.d/docker.list file.

8. ``/etc/apt/sources.list.d/docker.list`` ファイルを保存して閉じます。

..    Update the apt package index.

8. ``apt`` パッケージのインデックスを更新します。

.. code-block:: bash

   $ apt-get update

..    Purge the old repo if it exists.

9. 古いレポジトリが残っているのなら、パージします。

.. code-block:: bash

   $ apt-get purge lxc-docker

..    Verify that apt is pulling from the right repository.

10. ``apt`` が正しいレポジトリから取得できるか確認します。

.. code-block:: bash

   $ apt-cache policy docker-engine

..    From now on when you run apt-get upgrade, apt pulls from the new repository.

これで ``apt-get update`` を実行すると、 ``apt`` は新しいレポジトリから取得します。

.. Install Docker

Docker インストール
====================

.. Before installing Docker, make sure you have set your apt repository correctly as described in the prerequisites.

Docker インストール前に、必要条件で説明した通り、 ``apt`` レポジトリを正しく設定してください。

..    Update your apt package index.

1. ``apt`` パッケージのインデックスを更新します。

.. code-block:: bash

   $ sudo apt-get update

..    Install Docker.

2. Docker をインストールします。

.. code-block:: bash

   $ sudo apt-get install docker-engine

..    Start the docker daemon.

3. ``docker`` デーモンを開始します。

.. code-block:: bash

   $ sudo service docker start

..    Verify docker is installed correctly.

4. ``docker`` が正常にインストールされたか確認します。

.. code-block:: bash

   $ sudo docker run hello-world

..    This command downloads a test image and runs it in a container. When the container runs, it prints an informational message. Then, it exits.

このコマンドは、テストイメージをダウンロードし、コンテナとして実行します。コンテナを実行すると、メッセージ情報を表示して、終了します。


.. Giving non-root access

root 以外のアクセス指定
------------------------------

.. The docker daemon always runs as the root user and the docker daemon binds to a Unix socket instead of a TCP port. By default that Unix socket is owned by the user root, and so, by default, you can access it with sudo.

``docker`` デーモンは常に ``root`` ユーザとして実行され、 ``docker`` デーモンは TCP ポートの替わりに Unix ソケットをバインドします。デフォルトでは、Unix ソケットは ``root`` ユーザによって所有されており、他のユーザは ``sudo`` でアクセスできます。

.. If you (or your Docker installer) create a Unix group called docker and add users to it, then the docker daemon will make the ownership of the Unix socket read/writable by the docker group when the daemon starts. The docker daemon must always run as the root user, but if you run the docker client as a user in the docker group then you don’t need to add sudo to all the client commands. From Docker 0.9.0 you can use the -G flag to specify an alternative group.

あなた（もしくは Docker インストーラ）は、``docker`` という名称のグループを作成し、そこにユーザを追加します。 ``docker`` デーモンが起動すると、``docker`` グループの所有者により Unix ソケットの読み書きが可能になります。 ``docker`` デーモンは常に ``root`` ユーザとして実行しなくてはいけませんが、 ``docker`` グループのユーザであれば、 ``docker`` クライアントを実行できますので、 ``sudo`` 設定を全てのクライアントのコマンドに追加する必要はありません。Docker 0.9.0 移行は、 ``-G`` フラグを使って別のグループを指定できます。

..    Warning: The docker group is equivalent to the root user; For details on how this impacts security in your system, see Docker Daemon Attack Surface for details.

.. warning::

   ``docker`` グループは ``root`` ユーザ相当です。システム上のセキュリティに対する影響の詳細は、 :ref:`Docker デーモンが直面する攻撃 <docker-daemon-attach surface>` をご覧ください。

.. To create the docker group and add your user:

``docker`` グループを作成し、ユーザを追加するには、

..    Log into Debian as a user with sudo privileges.

1. Debian に ``sudo`` 特権のあるユーザでログインします。

..    Create the docker group and add your user.

2. ``docker`` グループを作成し、ユーザを追加します。

.. code-block:: bash

   $ sudo groupadd docker
   $ sudo gpasswd -a ${USER} docker

..    Restart the Docker daemon.

3. Docker デーモンを再起動します。

.. Upgrade Docker

Docker のアップグレード
==============================

.. To install the latest version of Docker with apt-get:

Docker の最新版をインストールするには、 ``apt-get`` を使います。

.. code-block:: bash

   $ apt-get upgrade docker-engine

.. Uninstallation

アンインストール
====================

.. To uninstall the Docker package:

Docker パッケージをアンインストールします。

.. code-block:: bash

   $ sudo apt-get purge docker-engine

.. To uninstall the Docker package and dependencies that are no longer needed:

Docker パッケージと必要の無い依存関係をアンインストールします。

.. code-block:: bash

   $ sudo apt-get autoremove --purge docker-engine

.. The above commands will not remove images, containers, volumes, or user created configuration files on your host. If you wish to delete all images, containers, and volumes run the following command:

上記のコマンドは、イメージ、コンテナ、ボリュームやホスト上の設定ファイルを削除しません。イメージ、コンテナ、ボリュームを削除するには次のコマンドを実行します。

.. code-block:: bash

   $ rm -rf /var/lib/docker

.. You must delete the user created configuration files manually.

ユーザが作成した設定ファイルは、手動で削除する必要があります。


