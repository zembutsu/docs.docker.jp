.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/config/daemon/systemd/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/config/daemon/systemd.md
   doc version: 19.03
.. check date: 2020/06/23
.. Commits on Jun 10, 2020 7ce086bfcacd638b25e5fe5a130f6a10893044fa
.. ---------------------------------------------------------------------------

.. title: Control and configure Docker with systemd

=======================================
systemd における Docker の設定と管理
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Many Linux distributions use systemd to start the Docker daemon. This document shows a few examples of how to customize Docker’s settings.

Linux ディストリビューションでは、Docker デーモンの起動に systemd を用いるものが多くあります。このドキュメントでは Docker の設定例をいくつか示します。

.. Start the Docker daemon

.. _start-the-docker-daemon:

Docker デーモンの起動
==============================

.. Start manually

.. _start-manually:

手動で起動する場合
------------------------------

.. Once Docker is installed, you need to start the Docker daemon. Most Linux distributions use systemctl to start services. If you do not have systemctl, use the service 

Docker をインストールしたら Docker デーモンの起動が必要になる場合もあるでしょう。たいていの Linux ディストリビューションでは ``systemctl`` を使ってサービスを起動します。``systemctl`` がない場合は ``service`` コマンドを使ってください。

.. - **`systemctl`**:
- ``systemctl`` の場合

  .. ```bash
     $ sudo systemctl start docker
     ```
  .. code-block:: bash

     $ sudo systemctl start docker

.. - **`service`**:
- ``service`` の場合

  .. ```bash
     $ sudo service docker start
     ```
  .. code-block:: bash

     $ sudo service docker start

.. Start automatically at system boot

.. _start-automatically-at-system-boot:

システムブート時に自動起動する場合
-----------------------------------

.. If you want Docker to start at boot, see Configure Docker to start on boot.

Docker をシステムブート時に起動したい場合は :ref:`システムブート時の Docker 起動設定 <configure-docker-to-start-on-boot>` を参照してください。

.. Custom Docker daemon options

.. _custom-docker-daemon-options:

Docker デーモンオプションのカスタマイズ
========================================

.. There are a number of ways to configure the daemon flags and environment variables for your Docker daemon. The recommended way is to use the platform-independent daemon.json file, which is located in /etc/docker/ on Linux by default. See Daemon configuration file.

Docker デーモンに対してのデーモンフラグや環境変数を設定する方法はいろいろあります。推奨されるのは、プラットフォームに依存しない ``daemon.json`` ファイルを用いる方法です。この ``daemon.json`` ファイルは Linux においてはデフォルトで ``/etc/docker/`` に置かれます。詳しくは :ref:`デーモン設定ファイル <daemon-configuration-file>` を参照してください。

.. You can configure nearly all daemon configuration options using daemon.json. The following example configures two options. One thing you cannot configure using daemon.json mechanism is a HTTP proxy.

``daemon.json`` を使うと、デーモン・オプションはほぼすべて設定することができます。以下の例では 2 つのオプションを設定しています。``daemon.json`` による仕組みで設定できないものに :ref:`HTTP プロキシ <systemd-httphttps-proxy>` があります。

..  Runtime directory and storage driver

.. _runtime-directory-and-storage-driver:

実行時の利用ディレクトリとストレージ・ドライバ
--------------------------------------------------

.. You may want to control the disk space used for Docker images, containers, and volumes by moving it to a separate partition.

Docker のイメージ、コンテナ、ボリュームは、別のパーティションを使ってディスク管理を行いたいと考えるかもしれません。

.. To accomplish this, set the following flags in the daemon.json file:

これを行うには ``daemon.json`` ファイルにおいて、以下のようなフラグ設定を行います。

.. ```none
   {
       "graph": "/mnt/docker-data",
       "storage-driver": "overlay"
   }
   ```
.. code-block:: json

   {
       "data-root": "/mnt/docker-data",
       "storage-driver": "overlay2"
   }

.. HTTP/HTTPS proxy

.. _systemd-httphttps-proxy:

.. httphttps-proxy

HTTP/HTTPS プロキシ
--------------------

.. The Docker daemon uses the HTTP_PROXY, HTTPS_PROXY, and NO_PROXY environmental variables in its start-up environment to configure HTTP or HTTPS proxy behavior. You cannot configure these environment variables using the daemon.json file.

Docker デーモンではその起動環境において ``HTTP_PROXY``, ``HTTPS_PROXY``, ``NO_PROXY`` という環境変数を利用して、HTTP または HTTPS プロキシの動作を定めています。この環境変数による設定は ``daemon.json`` ファイルを用いて行うことはできません。

.. This example overrides the default docker.service file.

以下は、デフォルトの ``docker.service`` ファイルを上書き設定する例です。

.. If you are behind an HTTP or HTTPS proxy server, for example in corporate settings, you need to add this configuration in the Docker systemd service file.

企業内で設定されるような HTTP あるいは HTTPS プロキシサーバを利用している場合は、Docker systemd サービスファイルに、これらの設定を加える必要があります。

..   Note for rootless mode
    The location of systemd configuration files are different when running Docker in rootless mode. When running in rootless mode, Docker is started as a user-mode systemd service, and uses files stored in each users’ home directory in ~/.config/systemd/user/docker.service.d/. In addition, systemctl must be executed without sudo and with the --user flag. Select the “rootless mode” tab below if you are running Docker in rootless mode.

.. note::

   **rootless （ルートレス）モードの注意** 

   systemd の設定ファイルの場は、Docker を :doc:`rootless モード <engine/security/rootless>` で実行する場合、通常とは異なる場所になります。rootless モードで実行時、 Docker はユーザ・モード systemd サービスで開始され、各ユーザのホームティレクトリにある ``~/.config/systemd/user/docker.service.d/`` に保存されているファイルを使います。さらに、 ``systemctl`` は ``sudo`` を使わずに ``--user``  フラグを使う必要があります。Docker を rootless モードで実行中の場合は、 rootless mode の項目をご覧ください。


通常のインストール
^^^^^^^^^^^^^^^^^^^^

.. 1.  Create a systemd drop-in directory for the docker service:
1.  Docker サービスに対応した systemd のドロップイン・ディレクトリを生成します。

   ..  ```bash
       $ sudo mkdir -p /etc/systemd/system/docker.service.d
       ```
   .. code-block:: bash

       $ mkdir -p /etc/systemd/system/docker.service.d

.. 2.  Create a file called `/etc/systemd/system/docker.service.d/http-proxy.conf`
       that adds the `HTTP_PROXY` environment variable:

2.  ``/etc/systemd/system/docker.service.d/http-proxy.conf`` というファイルを生成して、そこに環境変数 ``HTTP_PROXY`` の設定を書きます。

   ..  ```conf
       [Service]
       Environment="HTTP_PROXY=http://proxy.example.com:80/"
       ```
   .. code-block:: conf

       [Service]
       Environment="HTTP_PROXY=http://proxy.example.com:80/"

.. If you are behind an HTTPS proxy server, set the HTTPS_PROXY environment variable:

HTTPS プロキシサーバを利用している場合には、そこに環境変数 ``HTTPS_PROXY`` の設定を書きます。

   ..  ```conf
       [Service]
       Environment="HTTPS_PROXY=https://proxy.example.com:443/"
       ```
   .. code-block:: conf

       [Service]
       Environment="HTTPS_PROXY=https://proxy.example.com:443/"


.. Multiple environment variables can be set; to set both a non-HTTPS and a HTTPs proxy;

複数の環境変数を設定できます。 HTTPS 以外と HTTPS プロキシの両方を設定するには、次のようにします。

::

   [Service]
   Environment="HTTP_PROXY=http://proxy.example.com:80"
   Environment="HTTPS_PROXY=https://proxy.example.com:443"

.. If you have internal Docker registries that you need to contact without proxying you can specify them via the NO_PROXY environment variable.

3.  内部に Docker レジストリがあって、プロキシを介さずに接続する必要がある場合は、環境変数 ``NO_PROXY`` を通じて設定することができます。

.. The NO_PROXY variable specifies a string that contains comma-separated values for hosts that should be excluded from proxying. These are the options you can specify to exclude hosts:

``NO_PROXY`` 変数の文字列を指定する場合は、プロキシを除外したいホスト名にあたる値の記述を、カンマ記号で区切ります。ホストを除外する指定には、以下のオプションがあります。

..  IP address prefix (1.2.3.4)
    Domain name, or a special DNS label (*)
    A domain name matches that name and all subdomains. A domain name with a leading “.” matches subdomains only. For example, given the domains foo.example.com and example.com:
        example.com matches example.com and foo.example.com, and
        .example.com matches only foo.example.com
    A single asterisk (*) indicates that no proxying should be done
    Literal port numbers are accepted by IP address prefixes (1.2.3.4:80) and domain names (foo.example.com:80)

* IP アドレスのプレフィックス（ ``1.2.3.4`` ）
* ドメイン名、もしくは特別な DNS ラベル（ ``*`` ）
* ドメイン名に一致する、全てのサブドメイン。ドメイン名の先頭に ``.`` 記号があれば、一致するサブドメインのみを対象。例えば、 ``foo.example.com`` と ``example.com``  がある場合：

   * ``example.com`` に一致するのは、 ``example.com`` と ``foo.example.com`` 
   * ``.example.com`` に一致するのは ``foo.example.com`` のみ

* シングル・アスタリスク（ ``*`` ）はプロキシなしがここまでなのを示す
* 許容する整数のポート番号は、 IP アドレスのプレフィックス（ ``1.2.3.4:80`` ）とドメイン名（ ``foo.example.com:80`` ）

.. Config example:

設定例：

::

   [Service]
   Environment="HTTP_PROXY=http://proxy.example.com:80"
   Environment="HTTPS_PROXY=https://proxy.example.com:443"
   Environment="NO_PROXY=localhost,127.0.0.1,docker-registry.example.com,.corp"

.. Flush changes and restart Docker

4. 変更を反映し、 Docker を再起動します。

.. code-block:: bash

   sudo systemctl daemon-reload
   sudo systemctl restart docker

.. Verify that the configuration has been loaded and matches the changes you made, for example:

5. 設定が読み込まれ、変更が反映したかどうかを確認します。

.. code-block:: bash

   sudo systemctl show --property=Environment docker
       
   Environment=HTTP_PROXY=http://proxy.example.com:80 HTTPS_PROXY=https://proxy.example.com:443 NO_PROXY=localhost,127.0.0.1,docker-registry.example.com,.corp


rootless モード
^^^^^^^^^^^^^^^^^^^^

.. 1.  Create a systemd drop-in directory for the docker service:
1.  Docker サービスに対応した systemd のドロップイン・ディレクトリを生成します。

   .. code-block:: bash

       mkdir -p ~/.config/systemd/user/docker.service.d

.. Create a file named ~/.config/systemd/user/docker.service.d/http-proxy.conf that adds the HTTP_PROXY environment variable:

2.  ``~/.config/systemd/user/docker.service.d/http-proxy.conf `` というファイルを生成して、そこに環境変数 ``HTTP_PROXY`` の設定を書きます。

   ..  ```conf
       [Service]
       Environment="HTTP_PROXY=http://proxy.example.com:80/"
       ```
   .. code-block:: conf

       [Service]
       Environment="HTTP_PROXY=http://proxy.example.com:80/"

.. If you are behind an HTTPS proxy server, set the HTTPS_PROXY environment variable:

HTTPS プロキシサーバを利用している場合には、そこに環境変数 ``HTTPS_PROXY`` の設定を書きます。

   ..  ```conf
       [Service]
       Environment="HTTPS_PROXY=https://proxy.example.com:443/"
       ```
   .. code-block:: conf

       [Service]
       Environment="HTTPS_PROXY=https://proxy.example.com:443/"


.. Multiple environment variables can be set; to set both a non-HTTPS and a HTTPs proxy;

複数の環境変数を設定できます。 HTTPS 以外と HTTPS プロキシの両方を設定するには、次のようにします。

::

   [Service]
   Environment="HTTP_PROXY=http://proxy.example.com:80"
   Environment="HTTPS_PROXY=https://proxy.example.com:443"

.. If you have internal Docker registries that you need to contact without proxying you can specify them via the NO_PROXY environment variable.

3.  内部に Docker レジストリがあって、プロキシを介さずに接続する必要がある場合は、環境変数 ``NO_PROXY`` を通じて設定することができます。

.. The NO_PROXY variable specifies a string that contains comma-separated values for hosts that should be excluded from proxying. These are the options you can specify to exclude hosts:

``NO_PROXY`` 変数の文字列を指定する場合は、プロキシを除外したいホスト名にあたる値の記述を、カンマ記号で区切ります。ホストを除外する指定には、以下のオプションがあります。

..  IP address prefix (1.2.3.4)
    Domain name, or a special DNS label (*)
    A domain name matches that name and all subdomains. A domain name with a leading “.” matches subdomains only. For example, given the domains foo.example.com and example.com:
        example.com matches example.com and foo.example.com, and
        .example.com matches only foo.example.com
    A single asterisk (*) indicates that no proxying should be done
    Literal port numbers are accepted by IP address prefixes (1.2.3.4:80) and domain names (foo.example.com:80)

* IP アドレスのプレフィックス（ ``1.2.3.4`` ）
* ドメイン名、もしくは特別な DNS ラベル（ ``*`` ）
* ドメイン名に一致する、全てのサブドメイン。ドメイン名の先頭に ``.`` 記号があれば、一致するサブドメインのみを対象。例えば、 ``foo.example.com`` と ``example.com``  がある場合：

   * ``example.com`` に一致するのは、 ``example.com`` と ``foo.example.com`` 
   * ``.example.com`` に一致するのは ``foo.example.com`` のみ

* シングル・アスタリスク（ ``*`` ）はプロキシなしがここまでなのを示す
* 許容する整数のポート番号は、 IP アドレスのプレフィックス（ ``1.2.3.4:80`` ）とドメイン名（ ``foo.example.com:80`` ）

.. Config example:

設定例：

::

   [Service]
   Environment="HTTP_PROXY=http://proxy.example.com:80"
   Environment="HTTPS_PROXY=https://proxy.example.com:443"
   Environment="NO_PROXY=localhost,127.0.0.1,docker-registry.example.com,.corp"

.. Flush changes and restart Docker

4. 変更を反映し、 Docker を再起動します。

.. code-block:: bash

   systemctl --user daemon-reload
   systemctl --user restart docker

.. Verify that the configuration has been loaded and matches the changes you made, for example:

5. 設定が読み込まれ、変更が反映したかどうかを確認します。

.. code-block:: bash

   systemctl --user show --property=Environment docker
       
   Environment=HTTP_PROXY=http://proxy.example.com:80 HTTPS_PROXY=https://proxy.example.com:443 NO_PROXY=localhost,127.0.0.1,docker-registry.example.com,.corp

.. Configure where the Docker daemon listens for connections

.. _configure-where-the-docker-daemon-listens-for-connections:

Docker デーモンが接続のリッスンをどこで行うか設定
============================================================

.. See Configure where the Docker daemon listens for connections.

:ref:`Docker デーモンが接続のリッスンをどこで行うか制御 <control-where-the-docker-daemon-listens-for-connections>` をご覧ください。



.. ## Manually create the systemd unit files

.. _manually-create-the-systemd-unit-files:

systemd ユニットファイルの手動作成
========================================

.. When installing the binary without a package, you may want
   to integrate Docker with systemd. For this, install the two unit files
   (`service` and `socket`) from [the github
   repository](https://github.com/moby/moby/tree/master/contrib/init/systemd)
   to `/etc/systemd/system`.

パッケージを利用せずにインストールを行った場合は、systemd を用いた Docker の設定が必要になるはずです。
これを行うには 2 つのユニットファイル（``service`` と ``socket`` ）を `Github リポジトリ <https://github.com/moby/moby/tree/master/contrib/init/systemd>`_ から入手して ``/etc/systemd/system`` に置いてください。

.. seealso:: 

   Control Docker with systemd
      https://docs.docker.com/config/daemon/systemd/
