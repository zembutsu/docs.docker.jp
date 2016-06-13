.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/installation/binaries/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/installation/binaries.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/installation/binaries.md
.. check date: 2016/06/13
.. Commits on Apr 29, 2016 24ec73f754da16e37726a3f1c6a59de508e255fc
.. -----------------------------------------------------------------------------

.. Installation from binaries

==============================
バイナリをインストール
==============================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. This instruction set is meant for hackers who want to try out Docker on a variety of environments.

**このページは、 Docker を様々な環境で動かそうとしている上級者向けの手順です。**

.. Before following these directions, you should really check if a packaged version of Docker is already available for your distribution. We have packages for many distributions, and more keep showing up all the time!

以下に進む前に、まず、皆さんがお使いのディストリビューションに対応した Docker のパッケージ版が存在しているかどうか、ご確認ください。私たちは様々なディストリビューションに対応したパッケージを提供しています。対応は更に増え続けるでしょう。
j
.. Check runtime dependencies

実行時の依存関係を確認
==============================

.. To run properly, docker needs the following software to be installed at runtime:

docker を適切に実行するには、以下のソフトウェアが実行時に必要です。

..    iptables version 1.4 or later
    Git version 1.7 or later
    procps (or similar provider of a “ps” executable)
    XZ Utils 4.9 or later
    a properly mounted cgroupfs hierarchy (having a single, all-encompassing “cgroup” mount point is not sufficient)

* iptables バージョン 1.4 以上
* Git バージョン 1.7 以上
* procps （あるいは "ps" のように実行できるもの）
* XZ Utils 4.9 以上
* `適切にマウントされた <https://github.com/tianon/cgroupfs-mount/blob/master/cgroupfs-mount>`_ cgroupfs 階層（単一の "cgroup" マウント・ポイントしかないものは `不完全 <https://github.com/docker/docker/issues/3485>`_ です。）

.. Check kernel dependencies

kernel 依存関係の確認
==============================

.. Docker in daemon mode has specific kernel requirements. For details, check your distribution in Installation.

Docker をデーモン・モードで実行するには（サーバとして使うには）、特定のカーネルが必要です。詳細については、各ディストリビューションの :ref:`インストール <on-linux>` のページをご確認ください。

.. A 3.10 Linux kernel is the minimum requirement for Docker. Kernels older than 3.10 lack some of the features required to run Docker containers. These older versions are known to have bugs which cause data loss and frequently panic under certain conditions.

Docker を動かすには少なくとも Linux カーネル 3.10 が必要です。カーネルが 3.10 よりも低い場合は、Docker コンテナを実行するための機能が不足します。また、古いバージョンでは、特定条件下におけるデータの損失や、定期的なパニックが発生するバグが知られています。

.. The latest minor version (3.x.y) of the 3.10 (or a newer maintained version) Linux kernel is recommended. Keeping the kernel up to date with the latest minor version will ensure critical kernel bugs get fixed.

Linux カーネルの推奨バージョンは 3.10 系の最新マイナーバージョン（3.x.y）（または最新の管理バージョン）です。常にカーネルを最新のマイナーバージョンにすることで、致命的なカーネルのバグが修正されるようにします。

..    Warning: Installing custom kernels and kernel packages is probably not supported by your Linux distribution’s vendor. Please make sure to ask your vendor about Docker support first before attempting to install custom kernels on your distribution.

.. warning::

   変更したカーネルやカーネル・パッケージをインストールすると、 Linux ディストリビューションのベンダーによってはサポート対象外になる場合があります。ディストリビューション上に変更したカーネルをインストールする前に、ベンダーに対して Docker をサポートしているかどうか確認をお願いします。

..    Warning: Installing a newer kernel might not be enough for some distributions which provide packages which are too old or incompatible with newer kernels.

.. warning::

  ディストリビューションによっては、古すぎるか新しいカーネルと互換性が無いため、新しいカーネルのパッケージが提供されていない場合があります。

.. Note that Docker also has a client mode, which can run on virtually any Linux kernel (it even builds on OS X!).

ただし、Docker をクライアント・モードとして使うのであれば、ほとんどの Linux カーネル上で実行可能です（たとえ OS X 上でビルドしていても！）。

.. Enable AppArmor and SELinux when possible

可能であれば AppArmor と SELinux の有効化を
==================================================

.. Please use AppArmor or SELinux if your Linux distribution supports either of the two. This helps improve security and blocks certain types of exploits. Your distribution’s documentation should provide detailed steps on how to enable the recommended security mechanism.

Linux ディストリビューションが AppArmor か SELinuxをサポートしているのであれば、どちらかをご利用ください。セキュリティの改善と、あらゆる種類の内部攻撃（exploits）から守るための助けとなります。推奨されるセキュリティ機構と詳細な使い方は、各ディストリビューションのドキュメントをご覧ください。

.. Some Linux distributions enable AppArmor or SELinux by default and they run a kernel which doesn’t meet the minimum requirements (3.10 or newer). Updating the kernel to 3.10 or newer on such a system might not be enough to start Docker and run containers. Incompatibilities between the version of AppArmor/SELinux user space utilities provided by the system and the kernel could prevent Docker from running, from starting containers or, cause containers to exhibit unexpected behaviour.

ディストリビューションによっては AppArmor や SELinux がデフォルトで有効になっていても、カーネルの最小動作条件（3.10以上）を満たさないかもしれません。カーネルを 3.10 や新しいものへ更新すると、そのシステムでは Docker の起動やコンテナを実行できないかもしれません。システムが提供する AppArmor や SELinux のユーザ・スペース・ユーティリティとカーネル間の非互換性により、Docker の実行ができなかったり、コンテナを起動できない等、コンテナが予期しない動作を起こす可能性があります。

..    Warning: If either of the security mechanisms is enabled, it should not be disabled to make Docker or its containers run. This will reduce security in that environment, lose support from the distribution’s vendor for the system, and might break regulations and security policies in heavily regulated environments.

.. warning:: 何らかのセキュリティ機構を有効にしている場合、Docker やコンテナが実行できようにするため無効化すべきではありません。無効化は環境のセキュリティを低下させ、システムはディストリビューション・ベンダからのサポートを受けられなくなります。さらに、極めて管理された環境においては、規則やセキュリティポリシー違反にもなるでしょう。

.. Get the Docker Engine binary

Docker Engine バイナリの入手
==============================

.. You can download either the latest release binaries or a specific version. To get the list of stable release version numbers from GitHub, view the docker/docker releases page. You can get the MD5 and SHA256 hashes by appending .md5 and .sha256 to the URLs respectively

最新版や特定バージョンのバイナリをダウンロードできます。GitHub 上から安定リリース版の一覧を確認するには ``docker/docker`` `リリース・ページ <https://github.com/docker/docker/releases>`_ をご覧ください。MD5 と SHA256 ハッシュを取得するには、URL に対応する .md5 と .sha256 をご覧ください。

.. Get the Linux binaries

Linux バイナリの入手
------------------------------

.. To download the latest version for Linux, use the following URLs:

Linux の最新バージョンは、以下の URL からダウンロードします。

.. code-block:: bash

   https://get.docker.com/builds/Linux/i386/docker-latest.tgz
   https://get.docker.com/builds/Linux/x86_64/docker-latest.tgz

.. To download a specific version for Linux, use the following URL patterns:

Linux 用の特定バージョンをダウンロードするには、次の URL パターンを使います。

.. code-block:: bash

   https://get.docker.com/builds/Linux/i386/docker-<version>.tgz
   https://get.docker.com/builds/Linux/x86_64/docker-<version>.tgz

.. For example:

例：

.. code-block:: bash

   https://get.docker.com/builds/Linux/i386/docker-1.11.0.tgz
   https://get.docker.com/builds/Linux/x86_64/docker-1.11.0.tgz

.. Note These instructions are for Docker Engine 1.11 and up. Engine 1.10 and under consists of a single binary, and instructions for those versions are different. To install version 1.10 or below, follow the instructions in the 1.10 documentation.

.. note::

   以下の手順は Docker Engine 1.11 以上を対象にしています。Engine 1.10 以下は単一のバイナリであり、インストール方法が異なります。バージョン 1.10 以下のインストール方法は、 `1.10 ドキュメント <http://docs.docker.jp/v1.10/engine/installation/binaries.html>`_ をご覧ください。

.. Install the Linux binaries

.. _instlall-the-linux-binaries:

Linux バイナリのインストール
------------------------------

.. After downloading, you extract the archive, which puts the binaries in a directory named docker in your current location.

ダウンロード後、アーカイブを展開します。現在の場所より下にある ``docker`` ディレクトリにバイナリを置きます。

.. code-block:: bash

   $ tar -xvzf docker-latest.tgz
   
   docker/
   docker/docker-containerd-ctr
   docker/docker
   docker/docker-containerd
   docker/docker-runc
   docker/docker-containerd-shim

.. Engine requires these binaries to be installed in your host’s $PATH. For example, to install the binaries in /usr/bin:

Engine は、これらバイナリをホスト上の ``$PATH`` の場所に置く必要があります。例えば、バイナリを ``/usr/bin`` にインストールするには、次のようにします。

.. code-block:: bash

   $ mv docker/* /usr/bin/

..    Note: If you already have Engine installed on your host, make sure you stop Engine before installing (killall docker), and install the binaries in the same location. You can find the location of the current installation with dirname $(which docker).

.. note::

   既にホスト上で Engine をインストールしている場合は、インストール前に Engine を停止（ ``killall docker`` ）し、それから同じ場所にバイナリをインストールします。現在のインストール場所は ``dirname $(which docker)``  で確認できます。

.. Run the Engine daemon on Linux

.. _run-the-engine-daemon-on-linux:

Linux 上で engine デーモンを実行
----------------------------------------

.. You can manually start the Engine in daemon mode using:

Engine をデーモン・モードとして手動で実行できます：

.. code-block:: bash

   $ sudo docker daemon &

.. The GitHub repository provides samples of init-scripts you can use to control the daemon through a process manager, such as upstart or systemd. You can find these scripts in the contrib directory.

デーモンを upstart や systemd のようなプロセス・マネージャを通して管理できるよう、GitHub リポジトリにはサンプルの init スクリプトがあります。スクリプトは `contrib ディレクトリ <https://github.com/docker/docker/tree/master/contrib/init>`_  をご覧ください。

.. For additional information about running the Engine in daemon mode, refer to the daemon command in the Engine command line reference.

Engine をデーモン・モードで実行する時の詳しい情報は、Engine コマンド・リファレンスの :doc:`daemon コマンド </engine/reference/commandline/dockerd>` をご覧ください。

.. Get the Mac OS X binary

Mac OS X バイナリの入手
------------------------------

.. The Mac OS X binary is only a client. You cannot use it to run the docker daemon. To download the latest version for Mac OS X, use the following URLs:

Mac OS X ではクライアント用のバイナリが提供されています。docker デーモンは実行できません。Mac OS X の最新バージョンは、以下の URL からダウンロードします。

.. code-block:: bash

   https://get.docker.com/builds/Darwin/x86_64/docker-latest.tgz

.. To download a specific version for Mac OS X, use the following URL patterns:

Mac OS X 用の特定バージョンをダウンロードするには、次の URL パターンを使います。

.. code-block:: bash

   https://get.docker.com/builds/Darwin/x86_64/docker-<version>.tgz

.. For example:

例：

.. code-block:: bash

   https://get.docker.com/builds/Darwin/x86_64/docker-1.11.0.tgz

.. You can extract the downloaded archive either by double-clicking the downloaded .tgz or on the command line, using tar -xvzf docker-1.11.0.tgz. The client binary can be executed from any location on your filesystem.

ダウンロードしたアーカイブを展開するには、ダウンロードした ``.tgz`` をダブルクリックするか、コマンドライン上で ``tar -xvzf docker-1.11.0.tgz`` を実行します。クライアントのバイナリはファイルシステム上のあらゆる場所で実行できます。

.. Get the Windows binary

Windows バイナリの入手
------------------------------

.. You can only download the Windows binary for version 1.9.1 onwards. Moreover, the 32-bit (i386) binary is only a client, you cannot use it to run the docker daemon. The 64-bit binary (x86_64) is both a client and daemon.

Windows クライアントのバイナリは、バージョン 1.9.1 以降をダウンロードできます。ただし、バイナリは 32 ビット(i386)のクライアントのみであり、docker デーモンを実行できません。以下の URL から 64 ビットのバイナリ（クライアントとデーモン）をダウンロードします。

.. code-block:: bash

   https://get.docker.com/builds/Windows/i386/docker-latest.zip
   https://get.docker.com/builds/Windows/x86_64/docker-latest.zip

.. To download a specific version for Windows, use the following URL pattern:

Windows 用の特定バージョンをダウンロードするには、次の URL パターンを使います。

.. code-block:: bash

   https://get.docker.com/builds/Windows/i386/docker-<version>.zip
   https://get.docker.com/builds/Windows/x86_64/docker-<version>.zip

.. For example:

例：

.. code-block:: bash

   https://get.docker.com/builds/Windows/i386/docker-1.11.0.zip
   https://get.docker.com/builds/Windows/x86_64/docker-1.11.0.zip


.. Note These instructions are for Engine 1.11 and up. Instructions for older versions are slightly different. To install version 1.10 or below, follow the instructions in the 1.10 documentation.

.. note::

   以下の手順は Docker Engine 1.11 以上を対象にしています。Engine 1.10 以下は単一のバイナリであり、インストール方法が異なります。バージョン 1.10 以下のインストール方法は、 `1.10 ドキュメント <http://docs.docker.jp/v1.10/engine/installation/binaries.html>`_ をご覧ください。



.. Giving non-root access

.. _giving-non-root-access:

root 以外のアクセス
====================

.. The docker daemon always runs as the root user, and the docker daemon binds to a Unix socket instead of a TCP port. By default that Unix socket is owned by the user root, and so, by default, you can access it with sudo.

``docker`` デーモンは常に root ユーザとして稼働します。そして、デフォルトの ``docker`` デーモンは TCP ポートのかわりに Unix ソケットをバインドします。この Unix ソケットの所有者は *root* のため、 ``sudo`` でアクセスする必要があります。

.. If you (or your Docker installer) create a Unix group called docker and add users to it, then the docker daemon will make the ownership of the Unix socket read/writable by the docker group when the daemon starts. The docker daemon must always run as the root user, but if you run the docker client as a user in the docker group then you don’t need to add sudo to all the client commands.

あなたが（あるいは Docker インストーラが） *docker* という名称の Unix グループを作成している場合は、デーモンを起動後、 *docker* グループに追加したユーザが ``docker`` デーモンの Unix ソケットを読み書きできるようになります。 ``docker`` デーモンは常に root ユーザとして実行する必要がありますが、*docker*  グループに所属しているユーザであれば、 ``docker`` クライアント実行時に ``sudo`` コマンド実行が不要です。

..     Warning: The docker group (or the group specified with -G) is root-equivalent; see Docker Daemon Attack Surface details.

.. warning::

   *docker* グループ（あるいは ``-G`` でグループを指定）は root と同等です。詳細は :ref:`docker-daemon-attack-surface` をご覧ください。

.. Upgrade Docker Engine

Docker Engine のアップグレード
==============================

.. To upgrade your manual installation of Docker, first kill the docker daemon:

手動でインストールした Docker をアップグレードするには、まず docker デーモンを停止します。

.. code-block:: bash

   $ killall docker

.. Then follow the regular installation steps.

以降は通常のインストール手順と同じです。

.. Next steps

次のステップ
====================

.. Continue with the User Guide.

:doc:`ユーザ・ガイド </engine/userguide/index>` に進みます。

.. seealso:: 

   Installation from binaries
      https://docs.docker.com/engine/installation/binaries/

