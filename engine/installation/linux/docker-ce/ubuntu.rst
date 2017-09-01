.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/
.. SOURCE:
   doc version: 17.06
      https://github.com/docker/docker.github.io/blob/master/engine/installation/linux/docker-ce/ubuntu.md
.. check date: 2016/07/01
.. Commits on Jun 29, 2017 14a5f0fbca4c53ccee9989925cc32a7d6199ead1
.. ----------------------------------------------------------------------------

.. Get Docker CE for Ubuntu

==============================
Ubuntu 用 Docker CE の入手
==============================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. To get started with Docker CE on Ubuntu, make sure you meet the prerequisites, then install Docker.

Ubuntu 用 Docker CE を利用するには、動作条件に一致するか確認してから、 Docker をインストールしてください。

.. Prerequisites

動作条件
==========

.. Docker EE customers

Docker EE を利用する方は
------------------------------

.. To install Docker Enterprise Edition (Docker EE), go to Get Docker EE for Ubuntu instead of this topic.

Docker エンタープライズ版（Docker EE）のインストールは、 このページではなく Ubuntu 用 Docker EE 設定をご覧ください。

.. To learn more about Docker EE, see Docker Enterprise Edition{: target="blank" class="" }.

Docker EE の詳細を学ぶには、  `Docker Enterprise Edition（英語） <https://www.docker.com/enterprise-edition/>`_ をご覧ください。


.. OS requirements

OS 動作条件
--------------------

.. To install Docker CE, you need the 64-bit version of one of these Ubuntu versions:

Docker CE をインストールするには、以下いずれかの Ubuntu の 64 ビット版が必要です。

* Zesty 17.04 (LTS)
* Yakkety 16.10
* Xenial 16.04 (LTS)
* Trusty 14.04 (LTS)

.. Docker CE is supported on Ubuntu on x86_64, armhf, and s390x (IBM z Systems) architectures.

Docker CE がサポートしている Ubuntu のアーキテクチャは、 `x86_64` 、 `armhf` 、 `s390x` （IBM z Systems）です。

.. s390x limitations: System Z is only supported on Ubuntu Xenial, Yakkety, and Zesty.

.. note::

   `x290x` の制限： System Z がサポートしている Ubuntu は Xenial、Yakkety、Zesty のみです。

.. Uninstall old versions

.. _uninstall-old-ubuntu-versions:

古いバージョンのアンインストール
----------------------------------------

.. Older versions of Docker were called docker or docker-engine. If these are installed, uninstall them:

Docker の古いバージョンの名前は ``docker`` または ``docker-engine`` です。もしこれらがインストールされている場合は、アンインストールします。

.. code-block:: bash

   $ sudo apt-get remove docker docker-engine docker.io

.. It’s OK if apt-get reports that none of these packages are installed.

`apt-get` で対象パッケージがインストールされていないと表示されれば、問題ありません。

.. The contents of /var/lib/docker/, including images, containers, volumes, and networks, are preserved. The Docker CE package is now called docker-ce.

イメージ、コンテナ、ボリューム、ネットワークは ``/var/lib/docker/`` の中に保存されたままです。また、 Docker CE のパッケージは ``docker-ce`` と呼びます。

.. Recommended extra packages for Trusty 14.04

Trusty 14.04 向けの推奨 extra パッケージ
----------------------------------------

.. Unless you have a strong reason not to, install the linux-image-extra-* packages, which allow Docker to use the aufs storage drivers.

何らかの強い理由がなければ、 `linux-image-extra-*` パッケージのインストールを推奨します。これは Docker で `aufs` ストレージ・ドライバを使うためのものです。

.. code-block:: bash

   $ sudo apt-get update
   
   $ sudo apt-get install \
       linux-image-extra-$(uname -r) \
       linux-image-extra-virtual

.. For Ubuntu 16.04 and higher, the Linux kernel includes support for OverlayFS, and Docker CE will use the overlay2 storage driver by default.

Ubuntu 16.04 以上は Linux カーネルに OverlayFS のサポートが含まれており、Docker CE は ``overlay2`` ストレージ・ドライバをデフォルトで使います。


.. Install Docker CE

Docker CE のインストール
==============================

.. You can install Docker CE in different ways, depending on your needs:

必要に応じて Docker CE のインストール方法を選べます。

..    Most users set up Docker’s repositories and install from them, for ease of installation and upgrade tasks. This is the recommended approach.
..    Some users download the DEB package and install it manually and manage upgrades completely manually. This is useful in situations such as installing Docker on air-gapped systems with no access to the internet.

* ほどんどの利用者は Docker のリポジトリをセットアップし、インストールする方法です。インストールやアップグレード作業を簡単にします。こちらが推奨です。
* 一部のユーザは DEB パッケージをダウンロードし、手動でのインストールや、更新の作業を完全に手動で行います。こちらは Docker をインターネットにアクセスできない領域でインストールしたい場合に便利です。

.. Install using the repository

リポジトリを使ったインストール
------------------------------

.. Before you install Docker CE for the first time on a new host machine, you need to set up the Docker repository. Afterward, you can install and update Docker from the repository.

新しいホストマシン上に Docker CE を初めてインストールする前に、Docker リポジトリのセットアップが必要です。その後、リポジトリから Docker のインストールやアップグレードができます。

.. Set up the repository

リポジトリのセットアップ
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

..    Update the apt package index:

1. ``apt`` パッケージ・インデックスを更新します：

.. code-block:: bash

   $ sudo apt-get update

..    Install packages to allow apt to use a repository over HTTPS:

2. ``apt`` が HTTPS を通してリポジトリを使えるように、パッケージをインストールします。

.. code-block:: bash

   $ sudo apt-get install \
       apt-transport-https \
       ca-certificates \
       curl \
       software-properties-common

..    Add Docker’s official GPG key:

3. Docker の公式 GPG 鍵を追加します。

.. code-block:: bash

   $ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

..    Verify that the key fingerprint is 9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88.

鍵の fingerprint（フィンガープリント）が ``9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88`` と表示されるのを確認します。

.. code-block:: bash

   $ sudo apt-key fingerprint 0EBFCD88
   
   pub   4096R/0EBFCD88 2017-02-22
         Key fingerprint = 9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
   uid                  Docker Release (CE deb) <docker@docker.com>
   sub   4096R/F273FCD8 2017-02-22

..    Use the following command to set up the stable repository. You always need the stable repository, even if you want to install builds from the edge or testing repositories as well. To add the edge or testing repository, add the word edge or testing (or both) after the word stable in the commands below.

4. 以降のコマンドでは **stable** （安定版）リポジトリをセットアップします。もしも **edge** や **testing** リポジトリからビルドしたものをインストールしたい場合でも、常に **stable** リポジトリが必要です。 **edge** や **testing** リポジトリを追加するには、以降のコマンドの ``stable`` 文字のあとに ``edge`` か ``testing`` （あるいは両方）を追加します。

..        Note: The lsb_release -cs sub-command below returns the name of your Ubuntu distribution, such as xenial.
..        Sometimes, in a distribution like Linux Mint, you might have to change $(lsb_release -cs) to your parent Ubuntu distribution. For example: If you are using Linux Mint Rafaela, you could use trusty.

.. note:: ``lsb_release -cs`` サブコマンドは ``xenial`` のような Ubuntu ディストリビューション名を表示します。

   時々、Linux mint のようなディストリビューションでは、 ``$(lsb_release -cs)`` を親 Ubuntu ディストリビューションに変更する必要があるかもしれません。たとえば、 ``Linux Mint Rafaela`` をお使いの場合は ``trusty`` を使えます。


**amd64** :

.. code-block:: bash

   $ sudo add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) \
      stable"

**armhf** :

.. code-block:: bash

   $ sudo add-apt-repository \
      "deb [arch=armhf] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) \
      stable"

**s390x** :

.. code-block:: bash

   $ sudo add-apt-repository \
      "deb [arch=s390x] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) \
      stable"

..        Note: Starting with Docker 17.06, stable releases are also pushed to the edge and testing repositories.

.. note::

   Docker 17.06 以降、 stable リリースは **edge** と **testing** リポジトリにも送られます。

..    Learn about stable and edge channels.

:doc:`stable と edge チャンネルについて学ぶ </engine/installation/index>`

.. Install Docker CE

Docker CE のインストール
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

..    Update the apt package index.

1. ``apt`` パッケージ・インデックスを更新します。

.. code-block:: bash

   $ sudo apt-get update

..    Install the latest version of Docker CE, or go to the next step to install a specific version. Any existing installation of Docker is replaced.

2. 最新バージョンの Docker CE をインストールするか、次のステップで特定のバージョンをインストールします。インストール済みの Docker は置き換えられます。

.. code-block:: bash

   $ sudo apt-get install docker-ce

..        Warning: If you have multiple Docker repositories enabled, installing or updating without specifying a version in the apt-get install or apt-get update command will always install the highest possible version, which may not be appropriate for your stability needs.

.. attention::

   複数の Docker リポジトリを有効にすると、 ``apt-get install`` または ``apt-get update`` コマンドでバージョン指定をしなければ、常に最新バージョンをインストールします。そのため、安定性が必要な場合には、適切ではない場合があります。

..    On production systems, you should install a specific version of Docker CE instead of always using the latest. This output is truncated. List the available versions.

3. プロダクション（本番向け）システムでは、Docker CE 最新版を使う代わりに、特定のバージョンをインストールすべきでしょう。以下の出力は、利用可能なバージョンを簡略して一覧表示します。

.. code-block:: bash

   $ apt-cache madison docker-ce
   
   docker-ce | 17.06.0~ce-0~ubuntu-xenial | https://download.docker.com/linux/ubuntu xenial/stable amd64 Packages

..    The contents of the list depend upon which repositories are enabled, and will be specific to your version of Ubuntu (indicated by the xenial suffix on the version, in this example). Choose a specific version to install. The second column is the version string. The third column is the repository name, which indicates which repository the package is from and by extension its stability level. To install a specific version, append the version string to the package name and separate them by an equals sign (=):

　こちらには有効なリポジトリを表示します。また、特定の Ubuntu バージョンのものを表示します（この例では ``xenial`` が付いているバージョンを表示 ）。インストールするバージョンを選択します。２列目はバージョンの文字列です。３列目はリポジトリ名です。ここにはパッケージがどのリポジトリを使うかを示し、パッケージ名には安定性とバージョン番号を表示します。特定のバージョンをインストールするには、パッケージ名にイコール記号（ ``=`` ）でバージョン文字列を追加します。

.. code-block:: bash

   $ sudo apt-get install docker-ce=<バージョン>

..    The Docker daemon starts automatically.

Docker デーモンは自動的に起動します。

..    Verify that Docker CE is installed correctly by running the hello-world image.

4. Docker CE が正しくインストールされているのを確認するため、 ``hello-world`` イメージを実行します。

.. code-block:: bash

   $ sudo docker run hello-world

..    This command downloads a test image and runs it in a container. When the container runs, it prints an informational message and exits.

このコマンドはテスト用イメージをダウンロードし、コンテナ内で実行します。コンテナを実行したら、情報を表示したあと終了します。

.. Docker CE is installed and running. You need to use sudo to run Docker commands. Continue to Linux postinstall to allow non-privileged users to run Docker commands and for other optional configuration steps.

Docker CE はインストールされ、実行しています。Docker コマンドの実行には ``sudo`` が必要です。 引き続き :doc:`/engine/installation/linux/linux-postinstall` から、特権のないユーザで Docker コマンドを実行できるようにしたり、他のオプション設定を進めます。

.. Upgrade Docker CE

Docker CE のアップグレード
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. To upgrade Docker CE, first run sudo apt-get update, then follow the installation instructions, choosing the new version you want to install.

Docker CE をアップグレードするには、まず ``sudo apt-get update`` を実行します。それからインストールしたい新しいバージョンを選び、インストール手順に従います。

.. Install from a package

パッケージからインストール
------------------------------

.. If you cannot use Docker’s repository to install Docker CE, you can download the .deb file for your release and install it manually. You will need to download a new file each time you want to upgrade Docker CE.

Docker CE のインストールに Docker のリポジトリが使えない場合、 ``.deb`` ファイルをダウンロードし、手作業でインストールできます。Docker CE をアップグレードしたい場合は、新しいファイルのダウンロードが毎回必要です。

..    Go to https://download.docker.com/linux/ubuntu/dists/, choose your Ubuntu version, browse to pool/stable/ and choose amd64, armhf, or s390x. Download the .deb file for the Docker version you want to install and for your version of Ubuntu.

1. https://download.docker.com/linux/ubuntu/dists/ に移動し、Ubuntu バージョンを選び、 ``pool/stable/`` を見ます。そして ``amd64`` 、 ``armhf`` 、 ``x390x`` を選びます。そして、インストールしたい Ubuntu のバージョンに対応した Docker バージョンの ``.deb`` ファイルをダウンロードします。

..        Note: To install an edge package, change the word stable in the URL to edge. Learn about stable and edge channels.

.. note::

   **edge**  パッケージをインストールするには、URL 中の ``stable`` の文字を ``edge`` にします。 :doc:`stable と edge チャンネルを学ぶにはこちら </engine/installation/index>`  。


..    Install Docker CE, changing the path below to the path where you downloaded the Docker package.

2. Docker CE をインストールするには、以下のパスの場所を Docker パッケージをダウンロードした場所に変更します。

.. code-block:: bash

   $ sudo dpkg -i /path/to/package.deb

..    The Docker daemon starts automatically.

Docker デーモンは自動的に起動します。

..    Verify that Docker CE is installed correctly by running the hello-world image.

3. Docker CE が正しくインストールされているのを確認するため、 ``hello-world`` イメージを実行します。

.. code-block:: bash

   $ sudo docker run hello-world

..    This command downloads a test image and runs it in a container. When the container runs, it prints an informational message and exits.

このコマンドはテスト用イメージをダウンロードし、コンテナ内で実行します。コンテナを実行したら、情報を表示したあと終了します。

.. Docker CE is installed and running. You need to use sudo to run Docker commands. Continue to Post-installation steps for Linux to allow non-privileged users to run Docker commands and for other optional configuration steps.

Docker CE はインストールされ、実行しています。Docker コマンドの実行には ``sudo`` が必要です。 引き続き :doc:`/engine/installation/linux/linux-postinstall` から、特権のないユーザで Docker コマンドを実行できるようにしたり、他のオプション設定を進めます。


.. Upgrade Docker CE

Docker CE のアップグレード
------------------------------

.. To upgrade Docker CE, download the newer package file and repeat the installation procedure, pointing to the new file.

Docker CE をアップグレードするには、新しいパッケージ・ファイルをダウンロードし、インストール手順を新しいファイルに置き換えて、繰り返します。


.. Uninstall Docker CE

Docker CE のアンインストール
==============================

..    Uninstall the Docker CE package:

1. Docker CE パッケージをアンインストールします。

.. code-block:: bash

   $ sudo apt-get purge docker-ce

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

   Get Docker CE for Ubuntu | Docker Documentation
      https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#uninstall-docker-ce

