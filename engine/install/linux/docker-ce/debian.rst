.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/installation/linux/debian/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/installation/linux/debian.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/installation/linux/debian.md
.. check date: 2016/06/13
.. Commits on May 26, 2016 6c5f724560d3e1c47c927fa39056cd32de9f0890
.. ----------------------------------------------------------------------------

.. Debian

==============================
Debian
==============================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Docker is supported on these Debian operating systems:

Docker は以下の Debian バージョンをサポートしています。

* Debian testing stretch (64-bit)
* Debian 8.0 Jessie (64-bit)
* Debian 7.7 Wheezy (64-bit) (バックポートが必要)

..    Note: If you previously installed Docker using apt, make sure you update your apt sources to the new apt repository.

.. note::

   以前に Docker を ``apt`` でインストールしていた場合は、 ``apt`` ソースを新しい Docker リポジトリに更新してください。

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


.. Additionally, for users of Debian Wheezy, backports must be available. To enable backports in Wheezy:

さらに、 Debian Wheezy の利用者はバックポートが必ず必要です。Wheezy でバックポートを有効にするには、次のようにします：

..    Log into your machine and open a terminal with sudo or root privileges.

1. マシンにログインし、 ``sudo`` あるいは ``root`` 権限のターミナルを開きます。

..    Open the /etc/apt/sources.list.d/backports.list file in your favorite editor.

2. 任意のエディタで ``/etc/apt/sources.list.d/backports.list`` ファイルを開きます。

..    If the file doesn't exist, create it.

ファイルが無ければ作成します。

..    Remove any existing entries.

3. 既存のエントリがあれば削除します。

..    Add an entry for backports on Debian Wheezy.

4. Debian Wheezy にバックポートのエントリを追加します。

..    An example entry:

エントリの例

.. code-block:: bash

   deb http://http.debian.net/debian wheezy-backports main

..    Update package information:

5. パッケージ情報を更新します。

.. code-block:: bash

   $ apt-get update




.. Update your apt sources

apt ソースの更新
--------------------

.. Docker’s apt repository contains Docker 1.7.1 and higher. To set apt to use packages from the new repository:

Docker 1.7.1 以上は Docker の ``apt`` リポジトリに保管されています。 ``apt`` が新しいリポジトリにあるパッケージを使えるように設定します。

..    If you haven’t already done so, log into your Debian instance as a privileged user.

1. まだであれば Debian サーバに特権ユーザでログインします。

..    Open a terminal window.

2. ターミナルのウインドウを開きます。

.. Purge any older repositories.

3. 古いリポジトリをパージします。

.. code-block:: bash

   $ apt-get purge lxc-docker*
   $ apt-get purge docker.io*

.. Update package information, ensure that APT works with the https method, and that CA certificates are installed.

4. パッケージ情報を更新します。 APT が ``https`` メソッドで動作することを確認し、 ``CA`` 証明書がインストールされるのを確認します。

..    Add the new gpg key.

5. 新しい ``GPG`` 鍵を追加します。

.. code-block:: bash

   $ apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

..    Open the /etc/apt/sources.list.d/docker.list file in your favorite editor.

6. ``/etc/apt/sources.list.d/docker.list`` ファイルを好みのエディタで開きます。

..    If the file doesn’t exist, create it.

ファイルが存在しなければ、作成します。

..    Remove any existing entries.

7. 既存のエントリがあれば削除します。

..    Add an entry for your Debian operating system.

8. Debian オペレーティング・システム向けのエントリを追加します。

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

..    Save and close the file.

9. ファイルを保存して閉じます。

..    Update the apt package index.

10. ``APT`` パッケージのインデックスを更新します。

.. code-block:: bash

   $ apt-get update

..    Verify that APT is pulling from the right repository.

10. ``APT`` が正しいリポジトリから取得しているか確認します。

.. code-block:: bash

   $ apt-cache policy docker-engine

..    From now on when you run apt-get upgrade, apt pulls from the new repository.

これで ``apt-get update`` を実行すると、 ``APT`` は新しいリポジトリから取得します。

.. Install Docker

Docker インストール
====================

.. Before installing Docker, make sure you have set your APT repository correctly as described in the prerequisites.

Docker インストール前に、必要条件で説明した通り、 ``APT`` リポジトリを正しく設定してください。

..    Update your APT package index.

1. ``APT`` パッケージのインデックスを更新します。

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

   ``docker`` グループは ``root`` ユーザ相当です。システム上のセキュリティに対する影響の詳細は、 :ref:`Docker デーモンが直面する攻撃 <docker-daemon-attack-surface>` をご覧ください。

**例：**

.. code-block:: bash

   # docker グループが存在していなければ追加します。
   $ sudo groupadd docker
   
   # 接続するユーザ "${USER}" を docker グループに追加します。
   # 適切なユーザ名に変更してください。
   # この設定が反映されるのは、ログアウト後に、戻ってきてからです。
   $ sudo groupadd docker
   $ sudo gpasswd -a ${USER} docker
   
   # Docker デーモンを再起動します。
   $ sudo service docker restart

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

.. What next?

次は？
==========

.. Continue with the User Guide.

:doc:`ユーザ・ガイド </engine/userguide/index>` へ進みましょう。

.. seealso:: 

   Installation on Debian
      https://docs.docker.com/engine/installation/linux/debian/
