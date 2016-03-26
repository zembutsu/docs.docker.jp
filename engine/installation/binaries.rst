.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/installation/binaries/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/installation/binaries.md
   doc version: 1.10
      https://github.com/docker/docker/commits/master/docs/installation/binaries.md
   doc version: 1.9
      https://github.com/docker/docker/commits/release/v1.9/docs/installation/binaries.md
.. check date: 2016/03/26
.. Commits on Jan 27, 2016 e310d070f498a2ac494c6d3fde0ec5d6e4479e14
.. -----------------------------------------------------------------------------

.. Binaries

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

.. Get the Docker binary

Docker バイナリの入手
==============================

.. You can download either the latest release binary or a specific version. After downloading a binary file, you must set the file’s execute bit to run it.

最新版や特定バージョンのバイナリをダウンロードできます。バイナリ・ファイルをダウンロード後、ファイルを実行するために実行権限の設定が必要です。

.. To set the file’s execute bit on Linux and OS X:

Linux と Mac OS でファイル実行権限を設定：

.. code-block:: bash

   $ chmod +x docker

.. To get the list of stable release version numbers from GitHub, view the docker/docker releases page.

GitHub で安定リリース・バージョンの一覧を確認できます。 ``docker/docker`` `リリース・ページ <https://github.com/docker/docker/releases>`_ をご覧ください。

..    Note
..    1) You can get the MD5 and SHA256 hashes by appending .md5 and .sha256 to the URLs respectively
..    2) You can get the compressed binaries by appending .tgz to the URLs

.. note:

   1) MD5 と SHA256 ハッシュは、先ほどの URL の .md5 と .sha256 から取得できます。
   2) URL の .tgz から圧縮したバイナリを取得できます。


.. Get the Linux binary

Linux バイナリの入手
------------------------------

.. To download the latest version for Linux, use the following URLs:

Linux の最新バージョンは、以下の URL からダウンロードします。

.. code-block:: bash

   https://get.docker.com/builds/Linux/i386/docker-latest
   https://get.docker.com/builds/Linux/x86_64/docker-latest

.. To download a specific version for Linux, use the following URL patterns:

Linux 用の特定バージョンをダウンロードするには、次の URL パターンを使います。

.. code-block:: bash

   https://get.docker.com/builds/Linux/i386/docker-<version>
   https://get.docker.com/builds/Linux/x86_64/docker-<version>

.. For example:

実行例：

.. code-block:: bash

   https://get.docker.com/builds/Linux/i386/docker-1.6.0
   https://get.docker.com/builds/Linux/x86_64/docker-1.6.0

.. Get the Mac OS X binary

Mac OS X バイナリの入手
------------------------------

.. The Mac OS X binary is only a client. You cannot use it to run the docker daemon. To download the latest version for Mac OS X, use the following URLs:

Mac OS X ではクライアント用のバイナリが提供されています。docker デーモンは実行できません。Mac OS X の最新バージョンは、以下の URL からダウンロードします。

.. code-block:: bash

   https://get.docker.com/builds/Darwin/i386/docker-latest
   https://get.docker.com/builds/Darwin/x86_64/docker-latest

.. To download a specific version for Mac OS X, use the following URL patterns:

Mac OS X 用の特定バージョンをダウンロードするには、次の URL パターンを使います。

.. code-block:: bash

   https://get.docker.com/builds/Darwin/i386/docker-<version>
   https://get.docker.com/builds/Darwin/x86_64/docker-<version>

.. For example:

実行例：

.. code-block:: bash

   https://get.docker.com/builds/Darwin/i386/docker-1.6.0
   https://get.docker.com/builds/Darwin/x86_64/docker-1.6.0

.. Get the Windows binary

Windows バイナリの入手
------------------------------

.. You can only download the Windows client binary for version 1.6.0 onwards. Moreover, the binary is only a client, you cannot use it to run the docker daemon. To download the latest version for Windows, use the following URLs:

Windows クライアントのバイナリは、バージョン 1.6.0 以降をダウンロードできます。ただし、バイナリはクライアントのみであり、docker デーモンを実行できません。以下の URL から Windows の最新バージョンをダウンロードします。

.. code-block:: bash

   https://get.docker.com/builds/Windows/i386/docker-latest.exe
   https://get.docker.com/builds/Windows/x86_64/docker-latest.exe

.. To download a specific version for Windows, use the following URL pattern:

Windows 用の特定バージョンをダウンロードするには、次の URL パターンを使います。

.. code-block:: bash

   https://get.docker.com/builds/Windows/i386/docker-<version>.exe
   https://get.docker.com/builds/Windows/x86_64/docker-<version>.exe

.. For example:

実行例：

.. code-block:: bash

   https://get.docker.com/builds/Windows/i386/docker-1.6.0.exe
   https://get.docker.com/builds/Windows/x86_64/docker-1.6.0.exe

.. Run the Docker daemon

Docker デーモンの実行
==============================

.. code-block:: bash

   # start the docker in daemon mode from the directory you unpacked
   $ sudo ./docker daemon &

.. Giving non-root access

.. _giving-non-root-access:

root 以外のアクセス
--------------------

.. The docker daemon always runs as the root user, and the docker daemon binds to a Unix socket instead of a TCP port. By default that Unix socket is owned by the user root, and so, by default, you can access it with sudo.

``docker`` デーモンは常に root ユーザとして稼働します。そして、デフォルトの ``docker`` デーモンは TCP ポートのかわりに Unix ソケットをバインドします。この Unix ソケットの所有者は *root* のため、 ``sudo`` でアクセスする必要があります。

.. If you (or your Docker installer) create a Unix group called docker and add users to it, then the docker daemon will make the ownership of the Unix socket read/writable by the docker group when the daemon starts. The docker daemon must always run as the root user, but if you run the docker client as a user in the docker group then you don’t need to add sudo to all the client commands.

あなたが（あるいは Docker インストーラが） *docker* という名称の Unix グループを作成している場合は、デーモンを起動後、 *docker* グループに追加したユーザが ``docker`` デーモンの Unix ソケットを読み書きできるようになります。 ``docker`` デーモンは常に root ユーザとして実行する必要がありますが、*docker*  グループに所属しているユーザであれば、 ``docker`` クライアント実行時に ``sudo`` コマンド実行が不要です。

..     Warning: The docker group (or the group specified with -G) is root-equivalent; see Docker Daemon Attack Surface details.

.. warning::

   *docker* グループ（あるいは ``-G`` でグループを指定）は root と同等です。詳細は :ref:`docker-daemon-attack-surface` をご覧ください。

.. Upgrades

アップグレード
====================

.. To upgrade your manual installation of Docker, first kill the docker daemon:

手動でインストールした Docker をアップグレードするには、まず docker デーモンを停止します。

.. code-block:: bash

   $ killall docker

.. Then follow the regular installation steps.

以降は通常のインストール手順と同じです。

.. Run your first container!

はじめてのコンテナ実行！
==============================

.. code-block:: bash

   # docker バージョンの確認
   $ sudo ./docker version
   
   # コンテナを実行し、コンテナ内のシェルをインタラクティブに開きます
   $ sudo ./docker run -i -t ubuntu /bin/bash

.. Continue with the User Guide.

:doc:`ユーザ・ガイド </engine/userguide/index>` に進みます。

.. seealso:: 

   Binaries
      https://docs.docker.com/engine/installation/binaries/

