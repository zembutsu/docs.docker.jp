.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/installation/linux/docker-ce/centos/
.. SOURCE:
   doc version: 17.06
      https://github.com/docker/docker.github.io/blob/master/engine/installation/linux/docker-ce/centos.md
.. check date: 2016/07/01
.. Commits on Jun 29, 2017 14a5f0fbca4c53ccee9989925cc32a7d6199ead1
.. ----------------------------------------------------------------------------

.. Get Docker CE for CentOS

==============================
CentOS 用 Docker CE の入手
==============================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. To get started with Docker CE on CentOS, make sure you meet the prerequisites, then install Docker.

CentOS 用 Docker CE を利用するには、動作条件に一致するか確認してから、 Docker をインストールしてください。

.. Prerequisites

動作条件
==========

.. Docker EE customers

Docker EE を利用する方は
------------------------------

.. To install Docker Enterprise Edition (Docker EE), go to Get Docker EE for CentOS instead of this topic.

Docker エンタープライズ版（Docker EE）のインストールは、 このページではなく CentOS 用 Docker EE 設定をご覧ください。

.. To learn more about Docker EE, see Docker Enterprise Edition{: target="blank" class="" }.

Docker EE の詳細を学ぶには、  `Docker Enterprise Edition（英語） <https://www.docker.com/enterprise-edition/>`_ をご覧ください。


.. OS requirements

OS 動作条件
--------------------

.. To install Docker CE, you need the 64-bit version of CentOS 7.
.. To install Docker CE, you need the 64-bit version of one of these CentOS versions:

Docker CE をインストールするには、CentOS 7 の 64 ビット版が必要です。

.. Uninstall old versions

.. _uninstall-old-versions:

古いバージョンのアンインストール
----------------------------------------

.. Older versions of Docker were called docker or docker-engine. If these are installed, uninstall them, along with associated dependencies.

Docker の古いバージョンの名前は ``docker`` または ``docker-engine`` です。もしこれらがインストールされている場合は、関連する依存関係を含めてアンインストールします。

.. code-block:: bash

   $ sudo yum remove docker \
                     docker-common \
                     container-selinux \
                     docker-selinux \
                     docker-engine


.. It’s OK if yum reports that none of these packages are installed.

`yum` で対象パッケージがインストールされていないと表示されれば、問題ありません。

.. The contents of /var/lib/docker/, including images, containers, volumes, and networks, are preserved. The Docker CE package is now called docker-ce.

イメージ、コンテナ、ボリューム、ネットワークは ``/var/lib/docker/`` の中に保存されたままです。また、 Docker CE のパッケージは ``docker-ce`` と呼びます。


.. Install Docker CE

Docker CE のインストール
==============================

.. You can install Docker CE in different ways, depending on your needs:

必要に応じて Docker CE のインストール方法を選べます。

..    Most users set up Docker’s repositories and install from them, for ease of installation and upgrade tasks. This is the recommended approach.
..    Some users download the RPM package and install it manually and manage upgrades completely manually. This is useful in situations such as installing Docker on air-gapped systems with no access to the internet.

* ほどんどの利用者は Docker のリポジトリをセットアップし、インストールする方法です。インストールやアップグレード作業を簡単にします。こちらが推奨です。
* 一部のユーザは RPM パッケージをダウンロードし、手動でのインストールや、更新の作業を完全に手動で行います。こちらは Docker をインターネットにアクセスできない領域でインストールしたい場合に便利です。

.. Install using the repository

リポジトリを使ったインストール
------------------------------

.. Before you install Docker CE for the first time on a new host machine, you need to set up the Docker repository. Afterward, you can install and update Docker from the repository.

新しいホストマシン上に Docker CE を初めてインストールする前に、Docker リポジトリのセットアップが必要です。その後、リポジトリから Docker のインストールやアップグレードができます。

.. Set up the repository

リポジトリのセットアップ
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. Install required packages. yum-utils provides the yum-config-manager utility, and device-mapper-persistent-data and lvm2 are required by the devicemapper storage driver.

1. 必要なパッケージをインストールします。 ``yum-utils`` は ``yum-config-manager`` ユーティリティを提供します。そして、 ``device-mapper-persistent-data`` と ``lvm2``  は ``devicemapper`` ストレージ・ドライバの使用に必要です。

.. code-block:: bash

   $ sudo yum install -y yum-utils device-mapper-persistent-data lvm2

.. Use the following command to set up the stable repository. You always need the stable repository, even if you want to install builds from the edge or testing repositories as well.

2. 以降のコマンドでは **stable** （安定版）リポジトリをセットアップします。もしも **edge** や **testing** リポジトリからビルドしたものをインストールしたい場合でも、常に **stable** リポジトリが必要です。

.. Optional: Enable the edge and testing repositories. These repositories are included in the docker.repo file above but are disabled by default. You can enable them alongside the stable repository.

3. **オプション** :  **edge** や **testing** リポジトリを有効化します。これらのリポジトリは ``docker.repo`` ファイルに含まれますが、デフォルトでは無効です。stable リポジトリと併用して有効化できます。

.. You can disable the edge or testing repository by running the yum-config-manager command with the --disable flag. To re-enable it, use the --enable flag. The following command disables the edge repository.

``yum-config-manager`` コマンド実行時に ``--disable`` フラグを使えば、 **edge** や **testing** リポジトリを無効にできます。再び有効にするには ``--enable`` フラグを使います。以下のコマンドは **edge** リポジトリを無効化します。

.. code-block:: bash

   $ sudo yum-config-manager --disable docker-ce-edge

..        Note: Starting with Docker 17.06, stable releases are also pushed to the edge and testing repositories.

.. note::

   Docker 17.06 以降、 stable リリースは **edge** と **testing** リポジトリにも送られます。

..    Learn about stable and edge channels.

:doc:`stable と edge チャンネルについて学ぶ </engine/installation/index>`

.. Install Docker CE

Docker CE のインストール
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

..    Update the yum package index.

1. ``yum`` パッケージ・インデックスを更新します。

.. code-block:: bash

   $ sudo yum makecache fast

.. If this is the first time you have refreshed the package index since adding the Docker repositories, you will be prompted to accept the GPG key, and the key’s fingerprint will be shown. Verify that the fingerprint is correct, and if so, accept the key. The fingerprint should match 060A 61C5 1B55 8A7F 742B 77AA C52F EB6B 621E 9F35.

Docker リポジトリを追加後、パッケージ一覧の更新が初めての場合は、 GPG 鍵を受け入れるかどうかの確認と、鍵のフィンガープリント（fingerprint；指紋）を表示します。フィンガープリントが正しいものであると確認したら、鍵を受け入れます。鍵のフィンガープリントが ``9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88`` と一致するのを確認します。


..    Install the latest version of Docker CE, or go to the next step to install a specific version. Any existing installation of Docker is replaced.

2. 最新バージョンの Docker CE をインストールするか、次のステップで特定のバージョンをインストールします。インストール済みの Docker は置き換えられます。

.. code-block:: bash

   $ sudo yum install docker-ce

..        Warning: If you have multiple Docker repositories enabled, installing or updating without specifying a version in the yum install or yum update command will always install the highest possible version, which may not be appropriate for your stability needs.

.. attention::

   複数の Docker リポジトリを有効にすると、 ``yum install`` または ``yum update`` コマンドでバージョン指定をしなければ、常に最新バージョンをインストールします。そのため、安定性が必要な場合には、適切ではない場合があります。

..    On production systems, you should install a specific version of Docker CE instead of always using the latest. List the available versions. his example uses the sort -r command to sort the results by version number, highest to lowest, and is truncated.

3. プロダクション（本番向け）システムでは、Docker CE 最新版を使う代わりに、特定のバージョンをインストールすべきでしょう。利用可能なバージョンを一覧表示します。例では ``sort -r`` コマンドを使い、バージョン番号の結果を高いものから低いものへとソートします。また、表示を簡略化します。

.. note::

.. Note: This yum list command only shows binary packages. To show source packages as well, omit the .x86_64 from the package name.

   こちらの ``yum list`` コマンドが表示するのはバイナリ・パッケージのみです。ソース・パッケージも同様に表示するには、パッケージ名から ``.86_64`` を省略します。


.. code-block:: bash

   $ yum list docker-ce.x86_64  --showduplicates | sort -r
   
   docker-ce.x86_64  17.06.0.el7  

.. The contents of the list depend upon which repositories are enabled, and will be specific to your version of CentOS (indicated by the .el7 suffix on the version, in this example). Choose a specific version to install. The second column is the version string. The third column is the repository name, which indicates which repository the package is from and by extension its stability level. To install a specific version, append the version string to the package name and separate them by a hyphen (-):

　こちらには有効なリポジトリを表示します。また、特定の CentOS バージョンのものを表示します（この例では ``.el7`` が付いているバージョンを表示 ）。インストールするバージョンを選択します。２列目はバージョンの文字列です。３列目はリポジトリ名です。ここにはパッケージがどのリポジトリを使うかを示し、パッケージ名には安定性とバージョン番号を表示します。特定のバージョンをインストールするには、パッケージ名にハイフン記号（ ``-`` ）でバージョン文字列を追加します。

.. code-block:: bash

   $ sudo yum install docker-ce-<バージョン>

.. Start Docker.

4. Docker を起動します。

.. code-block:: bash

   $ sudo systemctl start docker

..    Verify that docker is installed correctly by running the hello-world image.

5. ``docker`` が正しくインストールされているのを確認するため、 ``hello-world`` イメージを実行します。

.. code-block:: bash

   $ sudo docker run hello-world

..    This command downloads a test image and runs it in a container. When the container runs, it prints an informational message and exits.

このコマンドはテスト用イメージをダウンロードし、コンテナ内で実行します。コンテナを実行したら、情報を表示したあと終了します。

.. Docker CE is installed and running. You need to use sudo to run Docker commands. Continue to Linux postinstall to allow non-privileged users to run Docker commands and for other optional configuration steps.

Docker CE はインストールされ、実行しています。Docker コマンドの実行には ``sudo`` が必要です。 引き続き :doc:`/engine/installation/linux/linux-postinstall` から、特権のないユーザで Docker コマンドを実行できるようにしたり、他のオプション設定を進めます。

.. Upgrade Docker CE

Docker CE のアップグレード
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. To upgrade Docker CE, first run sudo yum makecache fast, then follow the installation instructions, choosing the new version you want to install.

Docker CE をアップグレードするには、まず ``sudo yum makecache fast`` を実行します。それからインストールしたい新しいバージョンを選び、インストール手順に従います。

.. Install from a package

パッケージからインストール
------------------------------

.. If you cannot use Docker’s repository to install Docker CE, you can download the .rpm file for your release and install it manually. You will need to download a new file each time you want to upgrade Docker CE.

Docker CE のインストールに Docker のリポジトリが使えない場合、 ``.rpm`` ファイルをダウンロードし、手作業でインストールできます。Docker CE をアップグレードしたい場合は、新しいファイルのダウンロードが毎回必要です。

..     Go to https://download.docker.com/linux/centos/7/x86_64/stable/Packages/ and download the .rpm file for the Docker version you want to install.

1. https://download.docker.com/linux/centos/7/x86_64/stable/Packages/に移動し、インストールしたい Docker バージョンの ``.rpm`` ファイルをダウンロードします。

..        Note: To install an edge package, change the word stable in the URL to edge. Learn about stable and edge channels.

.. note::

   **edge**  パッケージをインストールするには、URL 中の ``stable`` の文字を ``edge`` にします。 :doc:`stable と edge チャンネルを学ぶにはこちら </engine/installation/index>`  。


..    Install Docker CE, changing the path below to the path where you downloaded the Docker package.

2. Docker CE をインストールするには、以下のパスの場所を Docker パッケージをダウンロードした場所に変更します。

.. code-block:: bash

   $ sudo yum install /path/to/package.rpm

3. Docker を起動します。

   $ sudo systemctl start docker

..    Verify that Docker CE is installed correctly by running the hello-world image.

4. Docker CE が正しくインストールされているのを確認するため、 ``hello-world`` イメージを実行します。

.. code-block:: bash

   $ sudo docker run hello-world

..    This command downloads a test image and runs it in a container. When the container runs, it prints an informational message and exits.

このコマンドはテスト用イメージをダウンロードし、コンテナ内で実行します。コンテナを実行したら、情報を表示したあと終了します。

.. Docker CE is installed and running. You need to use sudo to run Docker commands. Continue to Post-installation steps for Linux to allow non-privileged users to run Docker commands and for other optional configuration steps.

Docker CE はインストールされ、実行しています。Docker コマンドの実行には ``sudo`` が必要です。 引き続き :doc:`/engine/installation/linux/linux-postinstall` から、特権のないユーザで Docker コマンドを実行できるようにしたり、他のオプション設定を進めます。


.. Upgrade Docker CE

Docker CE のアップグレード
------------------------------

.. To upgrade Docker CE, download the newer package file and repeat the installation procedure, using yum -y upgrade instead of yum -y install, and pointing to the new file.


Docker CE をアップグレードするには、新しいパッケージ・ファイルをダウンロードし、インストール手順の ``yum -y install`` の代わりに ``yum -y upgrade`` を実行します。また、新しいファイルに置き換えます。


.. Uninstall Docker CE

Docker CE のアンインストール
==============================

..    Uninstall the Docker CE package:

1. Docker CE パッケージをアンインストールします。

.. code-block:: bash

   $ sudo yum remove docker-ce

..    Images, containers, volumes, or customized configuration files on your host are not automatically removed. To delete all images, containers, and volumes:

2. ホスト上のイメージ、コンテナ、ボリューム、その他にカスタマイズした設定ファイルは自動的に削除されません。全てのイメージ、コンテナ、ボリュームを削除するには：

.. code-block:: bash

   $ sudo rm -rf /var/lib/docker

.. You must delete any edited configuration files manually.

編集した設定ファイルは全て児童で削除する必要があります。

.. Next steps

次のステップ
====================

..    Continue to Post-installation steps for Linux
    Continue with the User Guide.

* :doc:`/engine/installation/linux/linux-postinstall` に進む
* :doc:`ユーザガイド </engine/userguide/index>` に進む


.. seealso:: 

   Get Docker CE for CentOS
      https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#uninstall-docker-ce

