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

.. You can configure nearly all daemon configuration options using `daemon.json`. The following
   example configures two options. One thing you cannot configure using `daemon.json` mechanism is
   a [HTTP proxy](#http-proxy).

``daemon.json`` を使うと、デーモン・オプションはほぼすべて設定することができます。
以下の例では 2 つのオプションを設定しています。
``daemon.json`` による仕組みで設定できないものに :ref:`HTTP プロキシ <http-proxy>` があります。

.. ### Runtime directory and storage driver

.. _runtime-directory-and-storage-driver:

実行時の利用ディレクトリとストレージ・ドライバ
--------------------------------------------------

.. You may want to control the disk space used for Docker images, containers,
   and volumes by moving it to a separate partition.

Docker のイメージ、コンテナー、ボリュームは、別のパーティションを使ってディスク管理を行いたいと考えるかもしれません。

.. To accomplish this, set the following flags in the `daemon.json` file:

これを行うには ``daemon.json`` ファイルにおいて、以下のようなフラグ設定を行います。

.. ```none
   {
       "graph": "/mnt/docker-data",
       "storage-driver": "overlay"
   }
   ```
.. code-block:: json

   {
       "graph": "/mnt/docker-data",
       "storage-driver": "overlay"
   }

.. ### HTTP/HTTPS proxy

.. _systemd-httphttps-proxy:

HTTP/HTTPS プロキシ
--------------------

.. The Docker daemon uses the `HTTP_PROXY`, `HTTPS_PROXY`, and `NO_PROXY` environmental variables in
   its start-up environment to configure HTTP or HTTPS proxy behavior. You cannot configure

.. these environment variables using the `daemon.json` file.

Docker デーモンではその起動環境において ``HTTP_PROXY``, ``HTTPS_PROXY``, ``NO_PROXY`` という環境変数を利用して、HTTP または HTTPS プロキシの動作を定めています。
この環境変数による設定は ``daemon.json`` ファイルを用いて行うことはできません。

.. This example overrides the default `docker.service` file.

以下は、デフォルトの ``docker.service`` ファイルを上書き設定する例です。

.. If you are behind an HTTP or HTTPS proxy server, for example in corporate settings,
   you will need to add this configuration in the Docker systemd service file.

企業内で設定されるような HTTP あるいは HTTPS プロキシサーバを利用している場合は、Docker systemd サービスファイルに、これらの設定を加える必要があります。

.. 1.  Create a systemd drop-in directory for the docker service:
1.  Docker サービスに対応した systemd のドロップイン・ディレクトリを生成します。

   ..  ```bash
       $ mkdir -p /etc/systemd/system/docker.service.d
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

   ..  Or, if you are behind an HTTPS proxy server, create a file called
       `/etc/systemd/system/docker.service.d/https-proxy.conf`
       that adds the `HTTPS_PROXY` environment variable:

   また HTTPS プロキシサーバを利用している場合には ``/etc/systemd/system/docker.service.d/https-proxy.conf`` というファイルを生成して、そこに環境変数 ``HTTPS_PROXY`` の設定を書きます。

   ..  ```conf
       [Service]
       Environment="HTTPS_PROXY=https://proxy.example.com:443/"
       ```
   .. code-block:: conf

       [Service]
       Environment="HTTPS_PROXY=https://proxy.example.com:443/"

.. 3.  If you have internal Docker registries that you need to contact without
       proxying you can specify them via the `NO_PROXY` environment variable:

3.  内部に Docker レジストリがあって、プロキシを介さずに接続する必要がある場合は、環境変数 ``NO_PROXY`` を通じて設定することができます。

   ..  ```conf
       Environment="HTTP_PROXY=http://proxy.example.com:80/" "NO_PROXY=localhost,127.0.0.1,docker-registry.somecorporation.com"
       ```
   .. code-block:: conf

      Environment="HTTP_PROXY=http://proxy.example.com:80/" "NO_PROXY=localhost,127.0.0.1,docker-registry.somecorporation.com"

   ..  Or, if you are behind an HTTPS proxy server:

   また HTTPS プロキシサーバであれば以下のようになります。

   ..  ```conf
       Environment="HTTPS_PROXY=https://proxy.example.com:443/" "NO_PROXY=localhost,127.0.0.1,docker-registry.somecorporation.com"
       ```
   .. code-block:: conf

      Environment="HTTPS_PROXY=https://proxy.example.com:443/" "NO_PROXY=localhost,127.0.0.1,docker-registry.somecorporation.com"

.. 4.  Flush changes:
4.  設定を反映します。

   ..  ```bash
       $ sudo systemctl daemon-reload
       ```
   .. code-block:: bash

      $ sudo systemctl daemon-reload

.. 5.  Restart Docker:
5.  Docker を再起動します。

   ..  ```bash
       $ sudo systemctl restart docker
       ```
   .. code-block:: bash

      $ sudo systemctl restart docker

.. 6.  Verify that the configuration has been loaded:
6.  設定がロードされていることを確認します。

   ..  ```bash
       $ systemctl show --property=Environment docker
       Environment=HTTP_PROXY=http://proxy.example.com:80/
       ```
   .. code-block:: bash

      $ systemctl show --property=Environment docker
      Environment=HTTP_PROXY=http://proxy.example.com:80/

   ..  Or, if you are behind an HTTPS proxy server:

   HTTPS プロキシサーバの場合は以下のとおりです。

   ..  ```bash
       $ systemctl show --property=Environment docker
       Environment=HTTPS_PROXY=https://proxy.example.com:443/
       ```
   .. code-block:: bash

      $ systemctl show --property=Environment docker
      Environment=HTTPS_PROXY=https://proxy.example.com:443/

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

   Quickstart Docker Engine
      https://docs.docker.com/engine/quickstart/
