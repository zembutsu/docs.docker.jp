.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/admin/systemd/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/admin/systemd.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/admin/systemd.md
.. check date: 2016/06/13
.. Commits on Jun 2, 2016 c1be45fa38e82054dcad606d71446a662524f2d5
.. ---------------------------------------------------------------------------

.. title: Control and configure Docker with systemd

=======================================
systemd における Docker の設定と管理
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Many Linux distributions use systemd to start the Docker daemon. This document
   shows a few examples of how to customize Docker's settings.

Linux ディストリビューションでは、Docker デーモンの起動に systemd を用いるものが多くあります。
このドキュメントでは Docker の設定例をいくつか示します。

.. ## Start the Docker daemon

.. _start-the-docker-daemon:

Docker デーモンの起動
==============================

.. ### Start manually

.. _start-manually:

手動で起動する場合
------------------------------

.. Once Docker is installed, you will need to start the Docker daemon.
   Most Linux distributions use `systemctl` to start services. If you
   do not have `systemctl`, use the `service` command.

Docker をインストールしたら Docker デーモンを起動する必要があります。
たいていの Linux ディストリビューションでは ``systemctl`` を使ってサービスを起動します。
``systemctl`` がない場合は ``service`` コマンドを使ってください。

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

.. ### Start automatically at system boot

.. _start-automatically-at-system-boot:

システムブート時に自動起動する場合
-----------------------------------

.. If you want Docker to start at boot, see
   [Configure Docker to start on boot](/engine/installation/linux/linux-postinstall.md/#configure-docker-to-start-on-boot).

Docker をシステムブート時に起動したい場合は :ref:`システムブート時の Docker 起動設定 <configure-docker-to-start-on-boot>` を参照してください。

.. ## Custom Docker daemon options

.. _custom-docker-daemon-options:

Docker デーモンオプションのカスタマイズ
========================================

.. There are a number of ways to configure the daemon flags and environment variables
   for your Docker daemon. The recommended way is to use the platform-independent
   `daemon.json` file, which is located in `/etc/docker/` on Linux by default. See
   [Daemon configuration file](/engine/reference/commandline/dockerd.md/#daemon-configuration-file).

Docker デーモンに対してのデーモンフラグや環境変数を設定する方法はいろいろあります。
推奨されるのは、プラットフォームに依存しない ``daemon.json`` ファイルを用いる方法です。
この ``daemon.json`` ファイルは Linux においてはデフォルトで ``/etc/docker/`` に置かれます。
詳しくは :ref:`デーモン設定ファイル <daemon-configuration-file>` を参照してください。

.. Runtime directory and storage driver

.. _runtime-directory-and-storage-driver:

実行時のディレクトリとストレージ・ドライバ
--------------------------------------------------

.. You may want to control the disk space used for Docker images, containers and volumes by moving it to a separate partition.

Docker イメージ、コンテナ、ボリュームを別々のパーティションのディスク・スペースで管理したくなるでしょう。

.. In this example, we’ll assume that your docker.service file looks something like:

この例では、次のような ``docker.service`` ファイルがあるものとします。

.. code-block:: bash

   [Unit]
   Description=Docker Application Container Engine
   Documentation=https://docs.docker.com
   After=network.target docker.socket
   Requires=docker.socket
   
   [Service]
   Type=notify
   ExecStart=/usr/bin/docker daemon -H fd://
   LimitNOFILE=1048576
   LimitNPROC=1048576
   TasksMax=1048576
   
   [Install]
   Also=docker.socket

.. This will allow us to add extra flags via a drop-in file (mentioned above) by placing a file containing the following in the /etc/systemd/system/docker.service.d directory:

これはドロップイン・ファイル（先ほど扱いました）を経由して外部フラグを追加できます。以下の内容を含むファイルを ``/etc/systemd/system/docker.service.d`` に作成します。

.. code-block:: bash

   [Service]
   ExecStart=
   ExecStart=/usr/bin/docker daemon -H fd:// --graph="/mnt/docker-data" --storage-driver=overlay

.. You can also set other environment variables in this file, for example, the HTTP_PROXY environment variables described below.

このファイルに他の環境変数も設定できます。例えば、 ``HTTP_PROXY`` 環境変数を下に追加することもできるでしょう。

.. To modify the ExecStart configuration, specify an empty configuration followed by a new configuration as follows:

ExecSart 設定を変更するには、空の設定の次の行に、新しい設定を追加します。

.. code-block:: bash

   [Service]
   ExecStart=
   ExecStart=/usr/bin/docker daemon -H fd:// --bip=172.17.42.1/16

.. If you fail to specify an empty configuration, Docker reports an error such as:

空の設定があると失敗しますので、次のように表示されるでしょう。

.. code-block:: bash

   docker.service has more than one ExecStart= setting, which is only allowed for Type=oneshot services. Refusing.

.. _systemd-http-proxy:

.. HTTP proxy

HTTP プロキシ
--------------------

.. This example overrides the default docker.service file.

この例はデフォルトの ``docker.service`` ファイルを上書きします。

.. If you are behind an HTTP proxy server, for example in corporate settings, you will need to add this configuration in the Docker systemd service file.

HTTP プロキシサーバの背後にいる場合、ここではオフィスで設定する例として、Docker の systemd サービス・ファイルに設定を追加する必要があるものとします。

.. First, create a systemd drop-in directory for the docker service:

まず、docker サービス向けの systemd ドロップイン・ディレクトリを作成します。

.. code-block:: bash

   mkdir /etc/systemd/system/docker.service.d

.. Now create a file called /etc/systemd/system/docker.service.d/http-proxy.conf that adds the HTTP_PROXY environment variable:

次は ``/etc/systemd/system/docker.service.d/http-proxy.conf`` ファイルを作成し、 ``HTTP_PROXY`` 環境変数を追加します。

.. code-block:: bash

   [Service]
   Environment="HTTP_PROXY=http://proxy.example.com:80/"

.. If you have internal Docker registries that you need to contact without proxying you can specify them via the NO_PROXY environment variable:

内部の Docker レジストリがあれば、プロキシを通さずに通信できるようにするため、 ``NO_PROXY`` 環境変数を指定します。

.. code-block:: bash

   Environment="HTTP_PROXY=http://proxy.example.com:80/"    "NO_PROXY=localhost,127.0.0.1,docker-registry.somecorporation.com"

.. Flush changes:

設定を反映します。

.. code-block:: bash

    $ sudo systemctl daemon-reload

.. Verify that the configuration has been loaded:

設定ファイルが読み込まれたのを確認します。

.. code-block:: bash

   $ systemctl show --property=Environment docker
   Environment=HTTP_PROXY=http://proxy.example.com:80/

.. Restart Docker:

Docker を再起動します。

.. code-block:: bash

   $ sudo systemctl restart docker

.. Manually creating the systemd unit files

.. _manually-creating-the-systemd-unit-files:

systemd ユニットファイルの手動作成
========================================

.. When installing the binary without a package, you may want to integrate Docker with systemd. For this, simply install the two unit files (service and socket) from the github repository to /etc/systemd/system.

パッケージを使わずにバイナリをインストールした場合でも、Docker と systemd を連動したくなるでしょう。簡単に実現するには、単純に `GitHub リポジトリ <https://github.com/docker/docker/tree/master/contrib/init/systemd>`_ にある２つのユニットファイル（サービスとソケット用）を ``/etc/systemd/system`` に置くだけです。

.. seealso:: 

   Quickstart Docker Engine
      https://docs.docker.com/engine/quickstart/
