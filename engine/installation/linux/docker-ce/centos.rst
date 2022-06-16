.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/installation/linux/docker-ce/centos/
.. SOURCE:
   doc version: 17.09
      https://github.com/docker/docker.github.io/blob/master/engine/installation/linux/docker-ce/centos.md
.. check date: 2016/11/25
.. Commits on Oct 25, 2017 4b356427472793ddbb7cb824adc774ba082975ff
.. ----------------------------------------------------------------------------

.. title: Get Docker CE for CentOS

===============================
Docker CE の入手（CentOS 向け）
===============================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. To get started with Docker CE on CentOS, make sure you
   [meet the prerequisites](#prerequisites), then
   [install Docker](#install-docker-ce).

CentOS 用 Docker CE を始めるには、 :ref:`前提条件を満たしているか <ce-prerequisites>` を確認してから、  :ref:`Docker をインストール <ce-install>` してください。

.. ## Prerequisites

.. _ce-prerequisites:

前提条件
==========

.. Docker EE customers

Docker EE を利用する方は
------------------------------

.. To install Docker Enterprise Edition (Docker EE), go to
   [Get Docker EE for CentOS](/engine/installation/linux/docker-ee/centos/)
   **instead of this topic**.

Docker エンタープライズ・エディション（Docker Enterprise Edition; EE）をインストールする場合は、
**このページではなく** :doc:`Docer EE の入手（CentOS 向け） </engine/installation/linux/docker-ee/centos>` に進んでください。

.. To learn more about Docker EE, see
   [Docker Enterprise Edition](https://www.docker.com/enterprise-edition/){: target="_blank" class="_" }.

Docker EE の詳細を学ぶには、  `Docker エンタープライズ・エディション <https://www.docker.com/enterprise-edition/>`_ をご覧ください。


.. ### OS requirements

OS 要件
--------------------

.. To install Docker CE, you need a maintained version of CentOS 7. Archived
   versions aren't supported or tested.

Docker CE をインストールするには、保守対象の CentOS 7 が必要です。
古いバージョンはサポートもテストも行っていません。

.. The `centos-extras` repository must be enabled. This repository is enabled by
   default, but if you have disabled it, you need to
   [re-enable it](https://wiki.centos.org/AdditionalResources/Repositories){: target="_blank" class="_" }.

``centos-extras`` リポジトリを有効にすることが必要です。
このリポジトリはデフォルトでは有効になっていますが、もし無効にしている場合は、 `もう一度有効に <https://wiki.centos.org/AdditionalResources/Repositories>`_ する必要があります。

.. Uninstall old versions

.. _uninstall-old-versions:

古いバージョンのアンインストール
----------------------------------------

.. Older versions of Docker were called `docker` or `docker-engine`. If these are
   installed, uninstall them, along with associated dependencies.

Docker のかつてのバージョンは、`docker` あるいは `docker-engine` と呼ばれていました。
これがインストールされている場合は、関連する依存パッケージも含めアンインストールしてください。

.. code-block:: bash

   $ sudo yum remove docker \
                     docker-common \
                     docker-selinux \
                     docker-engine

.. It's OK if `yum` reports that none of these packages are installed.

``yum`` を実行したときに、上のパッケージがインストールされていないと表示されれば OK です。

.. The contents of `/var/lib/docker/`, including images, containers, volumes, and
   networks, are preserved. The Docker CE package is now called `docker-ce`.

``/var/lib/docker/`` にはイメージ、コンテナ、ボリューム、ネットワークが含まれていて、それは保持されたまま残ります。
なお Docker CE パッケージは、今は ``docker-ce`` と呼ばれます。


.. Install Docker CE

.. _ce-install:

Docker CE のインストール
==============================

.. You can install Docker CE in different ways, depending on your needs:

Docker CE のインストール方法はいくつかあります。
必要に応じて選んでください。

.. - Most users
     [set up Docker's repositories](#install-using-the-repository) and install
     from them, for ease of installation and upgrade tasks. This is the
     recommended approach.
.. - Some users download the RPM package and
     [install it manually](#install-from-a-package) and manage
     upgrades completely manually. This is useful in situations such as installing
     Docker on air-gapped systems with no access to the internet.
.. - In testing and development environments, some users choose to use automated
     [convenience scripts](#install-using-the-convenience-script) to install Docker.

* たいていのユーザは :ref:`Docker のリポジトリをセットアップ <install-using-the-repository>` して、そこからインストールしています。
  インストールやアップグレードの作業が簡単だからです。
  この方法をお勧めします。

* ユーザの中には RPM パッケージをダウンロードし、手動でインストールしている方もいます。
  アップグレードも完全に手動となります。
  この方法は、インターネットにアクセスできない環境で Docker をインストールするような場合には有用です。

* テスト環境や開発環境向けに、自動化された :ref:`便利なスクリプト <convenience-scripts>` を使って Docker のインストールを行うユーザもいます。

.. Install using the repository

.. _install-using-the-repository:

リポジトリを使ったインストール
------------------------------

.. Before you install Docker CE for the first time on a new host machine, you need
   to set up the Docker repository. Afterward, you can install and update Docker
   from the repository.

新しいホストマシンに Docker CE を初めてインストールするときは、その前に Docker リポジトリをセットアップしておくことが必要です。
これを行った後に、リポジトリからの Docker のインストールやアップグレードができるようになります。

.. Set up the repository

リポジトリのセットアップ
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. 1.  Install required packages. `yum-utils` provides the `yum-config-manager`
       utility, and `device-mapper-persistent-data` and `lvm2` are required by the
       `devicemapper` storage driver.

1. 必要なパッケージをインストールします。
   ``yum-utils`` は ``yum-config-manager`` ユーティリティを提供します。
   また ``device-mapper-persistent-data`` と ``lvm2``  は ``devicemapper`` ストレージ・ドライバを利用するために必要です。

   .. code-block:: bash

    $ sudo yum install -y yum-utils \
      device-mapper-persistent-data \
      lvm2

.. 2.  Use the following command to set up the **stable** repository. You always
       need the **stable** repository, even if you want to install builds from the
       **edge** or **test** repositories as well.

2.  以下のコマンドを使って **安定版** （stable）リポジトリをセットアップします。
    **エッジ版** （edge）や **テスト版** （test）リポジトリからインストールしたい場合があったとしても、安定版リポジトリは常に必要となります。

   .. code-block:: bash

      $ sudo yum-config-manager \
          --add-repo \
          https://download.docker.com/linux/centos/docker-ce.repo

.. 3.  **Optional**: Enable the **edge** and **test** repositories. These
       repositories are included in the `docker.repo` file above but are disabled
       by default. You can enable them alongside the stable repository.

3.  **任意の作業** : **エッジ版** （edge）リポジトリ、 **テスト版** （test）リポジトリを有効にします。
    このリポジトリは上記の ``docker.repo`` ファイルに含まれていますが、デフォルトで無効になっています。
    このリポジトリを、 **安定版** （stable）リポジトリとともに有効にします。

   .. code-block:: bash

      $ sudo yum-config-manager --enable docker-ce-edge

   .. code-block:: bash

      $ sudo yum-config-manager --enable docker-ce-test

   ..  You can disable the **edge** or **test** repository by running the
       `yum-config-manager` command with the `--disable` flag. To re-enable it, use
       the `--enable` flag. The following command disables the **edge** repository.

   **エッジ版** リポジトリ、 **テスト版** リポジトリを無効にするには ``yum-config-manager`` コマンドに ``--disable`` フラグをつけて実行します。
   以下のコマンドは **エッジ版** リポジトリを無効にします。

   .. code-block:: bash
   
      $ sudo yum-config-manager --disable docker-ce-edge

   .. > **Note**: Starting with Docker 17.06, stable releases are also pushed to
      > the **edge** and **test** repositories.

   .. note::

      Docker 17.06 以降、安定版リリースは **エッジ版** リポジトリと **テスト版** リポジトリにもプッシュされるようになりました。

   .. [Learn about **stable** and **edge** builds](/engine/installation/).

   :doc:`安定版とエッジ版のチャネルについて学ぶ </engine/installation/index>`

.. Install Docker CE

.. _install-docker-ce:

Docker CE のインストール
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. 1.  Install the latest version of Docker CE, or go to the next step to install a
       specific version.

1.  Docker CE の最新版をインストールします。
    あるいは次の手順に行って、特定のバージョンをインストールします。

   ..  ```bash
       $ sudo yum install docker-ce
       ```

   .. code-block:: bash

      $ sudo yum install docker-ce

   ..  > **Warning**: If you have multiple Docker repositories enabled, installing
       > or updating without specifying a version in the `yum install` or
       > `yum update` command will always install the highest possible version,
       > which may not be appropriate for your stability needs.
       {:.warning}

   .. attention::

      Docker リポジトリを複数有効にしていて、バージョン指定をせずに ``yum install`` によるインストール、または ``yum update`` によるアップデートを行うと、入手可能な最新版がインストールされます。
      安定した版が必要である場合には、適切でない場合があります。

   ..  If this is the first time you have refreshed the package index since adding
       the Docker repositories, you will be prompted to accept the GPG key, and
       the key's fingerprint will be shown. Verify that the fingerprint is
       correct, and if so, accept the key. The fingerprint should match
       `060A 61C5 1B55 8A7F 742B  77AA C52F EB6B 621E 9F35`.

   Docker リポジトリを追加した後に、パッケージインデックスの更新が初めて行なわれる場合には、GPG 鍵を受け入れるための確認が行われ、鍵の指紋（fingerprint）が表示されます。
   鍵の指紋が間違いないものであることを確認したら、鍵を受け入れてください。
   鍵の指紋は ``060A 61C5 1B55 8A7F 742B  77AA C52F EB6B 621E 9F35`` です。

   ..  Docker is installed but not started. The `docker` group is created, but no
       users are added to the group.

   Docker はインストールされましたが、まだ起動はしていません。
   グループ ``docker`` が追加されていますが、このグループにはまだユーザが存在していない状態です。

.. 2.  On production systems, you should install a specific version of Docker CE
       instead of always using the latest. List the available versions. This
       example uses the `sort -r` command to sort the results by version number,
       highest to lowest, and is truncated.

2.  本番環境では Docker CE の最新版を常に利用するようなことはせずに、特定バージョンをインストールするかもしれません。
    そこで利用可能なバージョンの一覧を確認します。
    以下の例では ``sort -r`` コマンドを使って、出力結果をバージョン番号によりソートします。
    一覧は最新のものが上に並びます。
    バージョンは簡略に表示されます。

   ..  > **Note**: This `yum list` command only shows binary packages. To show
       > source packages as well, omit the `.x86_64` from the package name.

   .. note::

      以下の ``yum list`` コマンドではバイナリ・パッケージしか表示されません。
      ソース・パッケージもともに表示する場合は、パッケージ名から ``.x86_64`` の部分を除いてください。

   .. code-block:: bash

      $ yum list docker-ce.x86_64  --showduplicates | sort -r

        docker-ce.x86_64            17.06.ce-1.el7.centos             docker-ce-stable

   ..  The contents of the list depend upon which repositories are enabled, and
       will be specific to your version of CentOS (indicated by the `.el7` suffix
       on the version, in this example). Choose a specific version to install. The
       second column is the version string. You can use the entire version string,
       but **you need to include at least to the first hyphen**. The third column
       is the repository name, which indicates which repository the package is from
       and by extension its stability level. To install a specific version, append
       the version string to the package name and separate them by a hyphen (`-`).

   この一覧内容は、どのリポジトリを有効にしているかによって変わります。
   また利用している CentOS のバージョンに応じたものになります（この例では ``.e17`` というサフィックスにより示されるバージョンです）。
   この中から必要なバージョンを選んでください。
   第２項目はバージョン番号を示しています。
   バージョンの指定はバージョン文字列をすべて指定してもよいですが、省略する場合であっても **少なくとも最初のハイフンまで** は指定するようにしてください。
   第３項目はリポジトリ名です。
   パッケージがどのリポジトリによって提供されているかを示しており、また後ろにある文字から、その安定度合い（安定版かどうか）を見ることができます。
   バージョンを指定してインストールする場合は、パッケージ名の次にハイフン（ ``-`` ）をつけ、さらにバージョン文字列をつけたものを利用します。

   ..  > **Note**: The version string is the package name plus the version up to
       > the first hyphen. In the example above, the fully qualified package name
       > is `docker-ce-17.06.1.ce`.

   .. note::

      バージョン文字列は、パッケージ名に加えて、バージョンの最初にハイフンが出てくるところまでの文字列を使うだけで構いません。
      上の例の場合、有効なパッケージ名は ``docker-ce-17.06.ce`` になります。

   .. code-block:: bash

      $ sudo yum install docker-ce-<有効なバージョン文字列>

.. Start Docker.

3. Docker を起動します。

   .. code-block:: bash

      $ sudo systemctl start docker

..    Verify that docker is installed correctly by running the hello-world image.

4. ``docker`` が正しくインストールされているのを確認するため、 ``hello-world`` イメージを実行します。

   .. code-block:: bash

      $ sudo docker run hello-world

   ..  This command downloads a test image and runs it in a container. When the
       container runs, it prints an informational message and exits.

   このコマンドはテスト用イメージをダウンロードし、コンテナ内で実行します。
   コンテナが起動すると、メッセージを表示して終了します。

.. Docker CE is installed and running. You need to use `sudo` to run Docker
   commands. Continue to [Linux postinstall](/engine/installation/linux/linux-postinstall.md) to allow
   non-privileged users to run Docker commands and for other optional configuration
   steps.

Docker CE がインストールされ、実行できました。
Docker コマンドの実行には ``sudo`` が必要になります。
続いて :doc:`Linux のインストール後 </engine/installation/linux/linux-postinstall>` に進み、非特権ユーザでも Docker コマンドが実行できるように、またその他の追加の設定について見ていきます。

.. Upgrade Docker CE

Docker CE のアップグレード
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. To upgrade Docker CE, first run `sudo yum makecache fast`, then follow the
   [installation instructions](#install-docker), choosing the new version you want
   to install.

Docker CE をアップグレードするには、まず ``sudo yum makecache fast`` を実行してください。
次に :ref:`インストール手順 <ce-install>` に従って、インストールしたい新たなバージョンを選んでください。


.. Install from a package

パッケージからインストール
------------------------------

.. If you cannot use Docker's repository to install Docker, you can download the
   `.rpm` file for your release and install it manually. You will need to download
   a new file each time you want to upgrade Docker.

Docker リポジトリを利用した Docker インストールができない場合は、目的とするリリースの ``.rpm`` ファイルをダウンロードして、手動でインストールする方法があります。この場合 Docker をアップグレードするには、毎回新たな ``.rpm`` ファイルをダウンロードして利用することになります。

.. 1.  Go to
       [{{ download-url-base }}/7/x86_64/stable/Packages/]({{ download-url-base }}/7/x86_64/stable/Packages/)
       and download the `.rpm` file for the Docker version you want to install.

1.  https://download.docker.com/linux/centos/7/x86_64/stable/Packages/ にアクセスして、インストールしたい ``.rpm`` ファイルをダウンロードします。

   ..  > **Note**: To install an **edge**  package, change the word
       > `stable` in the > URL to `edge`.
       > [Learn about **stable** and **edge** channels](/engine/installation/).

   .. note::

       **最新版** パッケージをインストールする場合は URL 内の ``stable`` を ``edge`` に変更してください。
       :doc:`安定版と最新版チャンネルを学ぶにはこちら </engine/installation/index>`  。


.. 2.  Install Docker CE, changing the path below to the path where you downloaded
       the Docker package.

2.  Docker CE をインストールします。
    以下に示すパス部分は、Docker パッケージをダウンロードしたパスに書き換えます。

   .. ```bash
       $ sudo yum install /path/to/package.rpm
       ```
   .. code-block:: bash

      $ sudo yum install /path/to/package.rpm

   ..  Docker is installed but not started. The `docker` group is created, but no
       users are added to the group.

   Docker はインストールされましたが、まだ起動はしていません。
   グループ ``docker`` が追加されていますが、このグループにはまだユーザが存在していない状態です。

3. Docker を起動します。

   .. code-block:: bash

      $ sudo systemctl start docker

.. 4.  Verify that `docker` is installed correctly by running the `hello-world`
       image.

4.  ``docker`` が正しくインストールされているのを確認するため、 ``hello-world`` イメージを実行します。

   .. code-block:: bash

      $ sudo docker run hello-world

   ..  This command downloads a test image and runs it in a container. When the
       container runs, it prints an informational message and exits.

   このコマンドはテスト用イメージをダウンロードし、コンテナ内で実行します。
   コンテナが起動すると、メッセージを表示して終了します。

.. Docker CE is installed and running. You need to use `sudo` to run Docker commands.
   Continue to [Post-installation steps for Linux](/engine/installation/linux/linux-postinstall.md) to allow
   non-privileged users to run Docker commands and for other optional configuration
   steps.

Docker CE がインストールされ、実行できました。
Docker コマンドの実行には ``sudo`` が必要になります。
続いて :doc:`Linux のインストール後 </engine/installation/linux/linux-postinstall>` に進み、非特権ユーザでも Docker コマンドが実行できるように、またその他の追加の設定について見ていきます。


.. Upgrade Docker CE

Docker CE のアップグレード
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. To upgrade Docker CE, download the newer package file and repeat the
   [installation procedure](#install-from-a-package), using `yum -y upgrade`
   instead of `yum -y install`, and pointing to the new file.

Docker CE をアップグレードする場合は、新たなパッケージ・ファイルをダウンロードして、インストール手順をもう一度行います。
その際には ``yum -y install`` でなく ``yum -y upgrade`` を実行します。
またパッケージには新しいものを指定します。

.. include:: ../../../../_includes/install-script.rst

.. Uninstall Docker CE

Docker CE のアンインストール
==============================

..    Uninstall the Docker CE package:

1. Docker CE パッケージをアンインストールします。

   .. code-block:: bash

      $ sudo yum remove docker-ce

.. 2.  Images, containers, volumes, or customized configuration files on your host
       are not automatically removed. To delete all images, containers, and
       volumes:

2.  ホスト上のイメージ、コンテナ、ボリューム、カスタマイズした設定ファイルは自動的に削除されません。
    イメージ、コンテナ、ボリュームをすべて削除するには、以下を実行します。

   .. code-block:: bash

      $ sudo rm -rf /var/lib/docker

.. You must delete any edited configuration files manually.

編集した設定ファイルはすべて手動で削除する必要があります。

.. Next steps

次のステップ
====================

.. - Continue to [Post-installation steps for Linux](/engine/installation/linux/linux-postinstall.md)
   
   - Continue with the [User Guide](/engine/userguide/index.md).

* :doc:`Linux のインストール後 </engine/installation/linux/linux-postinstall>` に進む

* :doc:`ユーザガイド </engine/userguide/index>` に進む


.. seealso:: 

   Get Docker CE for CentOS
      https://docs.docker.com/engine/install/centos/

