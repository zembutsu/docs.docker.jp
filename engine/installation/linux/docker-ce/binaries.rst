.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/installation/linux/docker-ce/binaries/
.. SOURCE:
   doc version: 17.06
      https://github.com/docker/docker.github.io/blob/master/engine/installation/linux/docker-ce/binaries.md
.. check date: 2016/09/01
.. Commits on Jun 29, 2017 14a5f0fbca4c53ccee9989925cc32a7d6199ead1
.. ----------------------------------------------------------------------------

.. Install Docker CE form binaries

.. _install-docker-ce-from-binaries:

========================================
バイナリから Docker CE のインストール
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. > **Note**: You may have been redirected to this page because there is no longer
   > a dynamically-linked Docker package for your Linux distribution.

.. note::

   このページへはリダイレクトによりやってきたかもしれません。
   お使いの Linux ディストリビューションでは、ダイナミックリンクによる Docker パッケージが提供されていないためです。

.. If you want to try Docker or use it in a testing environment, but you're not on
   a supported platform, you can try installing from static binaries. If possible,
   you should use packages built for your operating system, and use your operating
   system's package management system to manage Docker installation and upgrades.
   Be aware that 32-bit static binary archives do not include the Docker daemon.

Docker を利用したい、あるいはテスト環境で使いたいと思っても、お使いのプラットフォームでは Docker がサポートされていません。
そんなときはスタティックリンクされたバイナリをインストールしてみてください。
可能であれば、お使いのオペレーティングシステム用にビルドされたパッケージを使い、オペレーティングシステムのパッケージ管理方法に基づいて Docker のインストールやアップグレードを行ってください。
なお 32 ビットのスタティックバイナリには、Docker デーモンが含まれていない点に注意してください。

.. Static binaries for the Docker daemon binary are only available for Linux (as
   `dockerd`) and Windows Server 2016 or Windows 10 (as `dockerd.exe`). Static
   binaries for the Docker client are available for Linux and macOS (as `docker`),
   and Windows Server 2016 or Windows 10 (as `docker.exe`).

Docker デーモンに対するスタティックバイナリは、Linux において（ ``dockerd`` として）、また Windows Server 2016 や Windows 10 において（ ``dockerd.exe`` として）利用可能です。
Docker クライアントに対するスタティックバイナリは、Linux と macOS において（ ``docker`` として）、また Windows Server 2016 や Windows 10 において（ ``docker.exe`` として）利用可能です。

.. ## Install daemon and client binaries on Linux

.. _install-daemon-and-client-binaries-on-linux:

Linux においてデーモンとクライアントのバイナリをインストール
============================================================

.. ### Prerequisites

.. _prerequisites:

前提条件
--------

.. Before attempting to install Docker from binaries, be sure your host machine
   meets the prerequisites:

Docker のバイナリをインストールする場合には、ホストマシンが以下の前提条件を満たしていることを確認してください。

.. - A 64-bit installation
   - Version 3.10 or higher of the Linux kernel. The latest version of the kernel
     available for you platform is recommended.
   - `iptables` version 1.4 or higher
   - `git` version 1.7 or higher
   - A `ps` executable, usually provided by `procps` or a similar package.
   - [XZ Utils](http://tukaani.org/xz/) 4.9 or higher
   - A [properly mounted](
     https://github.com/tianon/cgroupfs-mount/blob/master/cgroupfs-mount)
     `cgroupfs` hierarchy; a single, all-encompassing `cgroup` mount
     point is not sufficient. See Github issues
     [#2683](https://github.com/moby/moby/issues/2683),
     [#3485](https://github.com/moby/moby/issues/3485),
     [#4568](https://github.com/moby/moby/issues/4568)).

* 64 ビットシステム。
* Linux カーネルのバージョンは 3.10 またはそれ以上。
  利用するプラットフォームが提供する最新カーネルを用いることを推奨。
* ``iptables`` のバージョンは 1.4 またはそれ以上。
* ``git`` のバージョンは 1.7 またはそれ以上。
* ``ps`` 実行モジュールがあること。通常 ``procps`` あるいは類似パッケージが提供している。
* `XZ Utils <http://tukaani.org/xz/>`_ のバージョンは 4.9 またはそれ以上。
* `cgroupfs 階層が適切にマウントされていること <https://github.com/tianon/cgroupfs-mount/blob/master/cgroupfs-mount>`_ 。
  単純にすべてを取りまとめた ``cgroup`` マウントポイントでは不十分です。
  Github の 以下の issue を参考にしてください。
  `#2683 <https://github.com/moby/moby/issues/2683>`_ 、
  `#3485 <https://github.com/moby/moby/issues/3485>`_ 、
  `#4568 <https://github.com/moby/moby/issues/4568>`_

.. #### Secure your environment as much as possible

できるだけセキュアな環境を
```````````````````````````

.. ##### OS considerations

OS に関すること
''''''''''''''''

.. Enable SELinux or AppArmor if possible.

利用可能であれば SELinux や AppArmor を有効にしてください。

.. It is recommended to use AppArmor or SELinux if your Linux distribution supports
   either of the two. This helps improve security and blocks certain
   types of exploits. Review the documentation for your Linux distribution for
   instructions for enabling and configuring AppArmor or SELinux.

利用する Linux ディストリビューションが SELinux または AppArmor をサポートしている場合は、それらを利用することを推奨します。
これを有効にしていればセキュリティは向上し、ある種のセキュリティ攻撃を防ぐことにもつながります。
SELinux や AppArmor を設定し有効にする手順については、各 Linux ディストリビューションのドキュメントを参照してください。

.. > Security Warning
   >
   > If either of the security mechanisms is enabled, do not disable it as a
   > work-around to make Docker or its containers run. Instead, configure it
   > correctly to fix any problems.
   {:.warning}

.. warning::
   セキュリティ警告
     このセキュリティ機能を有効にしていた場合には、Docker やコンテナを動作させたいからというので、機能を無効にするのはお止めください。
     そのかわりに、正しく機能するように設定を適切に行ってください。

.. ##### Docker daemon considerations

Docker デーモンに関すること
''''''''''''''''''''''''''''

.. - Enable `seccomp` security profiles if possible. See
     [Enabling `seccomp` for Docker](/engine/security/seccomp.md).

* 利用可能であれば、セキュリティプロファイル ``seccomp`` を有効にしてください。
  :doc:`Docker における seccomp の利用 </engine/security/seccomp>` を参照。

.. - Enable user namespaces if possible. See the
     [Daemon user namespace options](/engine/reference/commandline/dockerd/#/daemon-user-namespace-options).

* 利用可能であればユーザ名前空間を有効にしてください。
  :doc:`デーモンのユーザ名前空間に関するオプション </engine/reference/commandline/dockerd>` を参照。

.. ### Install static binaries

スタティックバイナリのインストール
----------------------------------

.. 1.  Download the static binary archive. Go to
       [https://download.docker.com/linux/static/stable/](https://download.docker.com/linux/static/stable/x86_64/)
       (or change `stable` to `edge` or `test`),
       choose your hardware platform, and download the `.tgz` file relating to the
       version of Docker CE you want to install.

1.  スタティックバイナリのアーカイブをダウンロードします。
    `https://download.docker.com/linux/static/stable/ <https://download.docker.com/linux/static/stable/x86_64/>`_ へ行き、対応するハードウェアプラットフォーム向けのものを選びます。
    （ ``stable`` の部分は必要に応じて ``nightly`` や ``test`` とします。）
    必要としている Docker CE のバージョンに対応づいた ``.tgz`` ファイルをダウンロードします。

.. 2.  Extract the archive using the `tar` utility. The `dockerd` and `docker`
       binaries are extracted.

2.  ``tar`` ユーティリティを使ってアーカイブを展開します。
    バイナリ ``dockerd`` と ``docker`` が抽出されます。

   ..  ```bash
       $ tar xzvf /path/to/<FILE>.tar.gz
       ```
   .. code-block:: bash

       $ tar xzvf /path/to/<FILE>.tar.gz

.. 3.  **Optional**: Move the binaries to a directory on your executable path, such
       as `/usr/bin/`. If you skip this step, you must provide the path to the
       executable when you invoke `docker` or `dockerd` commands.

3.  **任意の作業**: 上のバイナリを実行パスの通ったディレクトリ、たとえば ``/usr/bin/`` などに移動させます。
    この作業を行わない場合、``docker`` や ``dockerd`` コマンドを起動する際には、常に実行ファイルへのパスも指定する必要があります。

   ..  ```bash
       $ sudo cp docker/* /usr/bin/
       ```
   .. code-block:: bash

       $ sudo cp docker/* /usr/bin/

.. 4.  Start the Docker daemon:

4.  Docker デーモンを起動します。

   ..  ```bash
       $ sudo dockerd &
       ```
   .. code-block:: bash

       $ sudo dockerd &

   ..  If you need to start the daemon with additional options, modify the above
       command accordingly or create and edit the file `/etc/docker/daemon.json`
       to add the custom configuration options.

   デーモンに追加のオプションをつけて実行する必要がある場合は、上記のコマンドそれぞれを修正するか、あるいは設定ファイル ``/etc/docker/daemon.json`` を生成編集します。
   そこに必要な設定オプションを追加します。

.. 5.  Verify that Docker is installed correctly by running the `hello-world`
       image.

5.  Docker が正しくインストールされたことを確認するために ``hello-world`` イメージを実行します。

   ..  ```bash
       $ sudo docker run hello-world
       ```
   .. code-block:: bash

       $ sudo docker run hello-world

   ..  This command downloads a test image and runs it in a container. When the
       container runs, it prints an informational message and exits.

   このコマンドはテストイメージをダウンロードして、コンテナ内で実行します。
   コンテナが起動すると、メッセージを表示して終了します。

.. ### Next steps

次のステップ
------------

.. - Continue to [Post-installation steps for Linux](/engine/installation/linux/linux-postinstall.md)

* :doc:`Linux インストール後の作業 </install/linux/linux-postinstall>` へ進む

.. - Continue with the [User Guide](/engine/userguide/index.md).

* :doc:`ユーザ・ガイド </engine/userguide/index>` へ進む

.. ## Install client binaries on macOS

macOS においてクライアントのバイナリをインストール
==================================================

.. The macOS binary includes the Docker client only. It does not include the
   `dockerd` daemon.

macOS のバイナリには Docker クライアントのみが提供されます。
つまり ``dockerd`` デーモンは含まれていません。

.. 1.  Download the static binary archive. Go to
       [https://download.docker.com/mac/static/stable/x86_64/](https://download.docker.com/mac/static/stable/x86_64/),
       (or change `stable` to `edge` or `test`),
       and download the `.tgz` file relating to the version of Docker CE you want
       to install.

1.  スタティックバイナリのアーカイブをダウンロードします。
    `https://download.docker.com/mac/static/stable/x86_64/ <https://download.docker.com/mac/static/stable/x86_64/>`_ へ行きます。
    （ ``stable`` の部分は必要に応じて ``nightly`` や ``test`` とします。）
    必要としている Docker CE のバージョンに対応づいた ``.tgz`` ファイルをダウンロードします。

.. 2.  Extract the archive using the `tar` utility. The `docker` binary is
       extracted.

2.  ``tar`` ユーティリティーを使ってアーカイブを展開します。
    バイナリ ``docker`` が抽出されます。

   ..  ```bash
       $ tar xzvf /path/to/<FILE>.tar.gz
       ```
   .. code-block:: bash

       $ tar xzvf /path/to/<FILE>.tar.gz

.. 3.  **Optional**: Move the binary to a directory on your executable path, such
       as `/usr/local/bin/`. If you skip this step, you must provide the path to the
       executable when you invoke `docker` or `dockerd` commands.

3.  **任意の作業**: 上のバイナリを実行パスの通ったディレクトリ、たとえば ``/usr/local/bin/`` などに移動させます。
    この作業を行わない場合、``docker`` や ``dockerd`` コマンドを起動する際には、常に実行ファイルへのパスも指定する必要があります。

   ..  ```bash
       $ sudo cp docker/docker /usr/local/bin/
       ```
   .. code-block:: bash

       $ sudo cp docker/docker /usr/local/bin/

.. 4.  Verify that Docker is installed correctly by running the `hello-world`
       image. The value of `<hostname>` is a hostname or IP address running the
       Docker daemon and accessible to the client.

4.  Docker が正しくインストールされたことを確認するために ``hello-world`` イメージを実行します。
    ``<hostname>`` にはホスト名かその IP アドレスを指定します。
    このホストは Docker デーモンが起動しているマシンのことであり、クライアントからアクセス可能であるものです。

   ..  ```bash
       $ sudo docker -H <hostname> run hello-world
       ```
   .. code-block:: bash

       $ sudo docker -H <hostname> run hello-world

   ..  This command downloads a test image and runs it in a container. When the
       container runs, it prints an informational message and exits.

   このコマンドはテストイメージをダウンロードして、コンテナ内で実行します。
   コンテナが起動すると、メッセージを表示して終了します。

.. ## Install server and client binaries on Windows

Windows においてクライアントのバイナリをインストール
====================================================

.. You can install Docker from binaries on Windows Server 2016 or Windows 10. Both
   the `dockerd.exe` and `docker.exe` binaries are included.

Docker のバイナリは Windows Server 2016 や Windows 10 にインストールします。
バイナリには ``dockerd.exe`` と ``docker.exe`` がともに含まれます。

.. 1.  Use the following PowerShell commands to install and start Docker:

1.  以下のように PowerShell コマンドを実行して Docker のインストールと起動を行います。

   ..  ```none
       PS C:\> Invoke-WebRequest https://download.docker.com/win/static/stable/x86_64//docker-{{ minor-version }}.0-ce.zip -UseBasicParsing -OutFile docker.zip

       PS C:\> Expand-Archive docker.zip -DestinationPath $Env:ProgramFiles

       PS C:\> Remove-Item -Force docker.zip

       PS C:\> dockerd --register-service

       PS C:\> Start-Service docker
       ```

   .. code-block:: batch

      PS C:\> Invoke-WebRequest https://download.docker.com/win/static/stable/x86_64//docker-17.06.0-ce.zip -UseBasicParsing -OutFile docker.zip

      PS C:\> Expand-Archive docker.zip -DestinationPath $Env:ProgramFiles

      PS C:\> Remove-Item -Force docker.zip

      PS C:\> dockerd --register-service

      PS C:\> Start-Service docker

.. 2.  Verify that Docker is installed correctly by running the `hello-world`
       image.

2.  Docker が正しくインストールされたことを確認するために ``hello-world`` イメージを実行します。

   ..  ```none
       PS C:\> docker run hello-world:nanoserver
       ```
   ::

       PS C:\> docker run hello-world:nanoserver

   ..  This command downloads a test image and runs it in a container. When the
       container runs, it prints an informational message and exits.

   このコマンドはテストイメージをダウンロードして、コンテナ内で実行します。
   コンテナが起動すると、メッセージを表示して終了します。

.. ## Upgrade static binaries

スタティックバイナリのアップグレード
====================================

.. To upgrade your manual installation of Docker CE, first stop any
   `dockerd` or `dockerd.exe`  processes running locally, then follow the
   regular installation steps to install the new version on top of the existing
   version.

Docker CE を手動によりインストールしていて、これをアップデートする場合は、まずローカルで起動させている ``dockerd`` あるいは ``dockerd.exe`` のプロセスをすべて終了させます。
そして通常の手順により新しいバージョンをインストールします。

.. ## Next steps

次のステップ
============

.. Continue with the [User Guide](../userguide/index.md).

:doc:`ユーザ・ガイド </engine/userguide/index>` へ進む

.. seealso::
   Install Docker CE from binaries
     https://docs.docker.com/install/linux/docker-ce/binaries/
