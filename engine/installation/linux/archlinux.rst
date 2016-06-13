.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/installation/linux/archlinux/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/installation/linux/archlinux.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/installation/linux/archlinux.md
.. check date: 2016/06/13
.. Commits on Jan 27, 2016 e310d070f498a2ac494c6d3fde0ec5d6e4479e14
.. -----------------------------------------------------------------------------

.. Arch Linux

==============================
Arch Linux
==============================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Installing on Arch Linux can be handled via the package in community:

Arch Linux におけるインストールは、コミュニティが扱うパッケージを使います。

..    docker

* `docker <https://www.archlinux.org/packages/community/x86_64/docker/>`_

..  or the following AUR package:

または、次の AUR パッケージを使います。

* `docker-git <https://aur.archlinux.org/packages/docker-git/>`_

.. The docker package will install the latest tagged version of docker. The docker-git package will build from the current master branch.

docker パッケージを使うと、latest（最新）にタグづけられたバージョンの Docker をインストールします。docker-git パッケージを使うと、現在のマスタ・ブランチから構築します。

.. Dependencies

依存関係
==========

.. Docker depends on several packages which are specified as dependencies in the packages. The core dependencies are:

Docker のパッケージは、複数の特定パッケージと依存関係があります。主な依存関係は次の通りです。

* bridge-utils
* device-mapper
* iproute2
* lxc
* sqlite

.. Installation

インストール
====================

.. For the normal package a simple

通常のパッケージはシンプルです。

.. code-block:: bash

   $ sudo pacman -S docker

.. is all that is needed.

これで必要なパッケージすべてが入ります。

.. For the AUR package execute:

AUR パッケージは次のように実行します。

.. code-block:: bash

   $ yaourt -S docker-git

.. The instructions here assume yaourt is installed. See Arch User Repository for information on building and installing packages from the AUR if you have not done so before.

このコマンドは **yaourt** のインストール済みを想定しています。インストールしていなければ、あらかじめ `Arch ユーザ・リポジトリ <https://wiki.archlinux.org/index.php/Arch_User_Repository#Installing_packages>`_ の構築と AUR でパッケージをインストールする情報をご覧ください。

.. Starting Docker

Docker の起動
====================

.. There is a systemd service unit created for docker. To start the docker service:

docker によって systemd サービスの unit が作成されます。docker サービスを起動するには、

.. code-block:: bash

   $ sudo systemctl start docker

.. To start on system boot:

システムのブート時に開始するには、

.. code-block:: bash

   $ sudo systemctl enable docker

.. Custom daemon options

デーモンのオプション設定
==============================

.. If you need to add an HTTP Proxy, set a different directory or partition for the Docker runtime files, or make other customizations, read our systemd article to learn how to customize your systemd Docker daemon options.

HTTP プロキシの追加が必要な場合、Docker のランタイム・ファイルを異なったディレクトリやパーティションに置いてください。あるいは別のカスタマイズ方法として、Systemd の記事 :doc:`Systemd Docker デーモン・オプションのカスタマイズ </engine/admin/systemd>` から、どのように設定するかをご覧ください。

.. Running Docker with a manually-defined network

Docker のネットワークを手動設定する
========================================

.. If you manually configure your network using systemd-network with systemd version 219 or higher, containers you start with Docker may be unable to access your network. Beginning with version 220, the forwarding setting for a given network (net.ipv4.conf.<interface>.forwarding) defaults to off. This setting prevents IP forwarding. It also conflicts with Docker which enables the net.ipv4.conf.all.forwarding setting within a container.

``systemd`` バージョン 219 以上では、 ``systemd-network`` を使い、手動でネットワークを設定できます。そのため、Docker でコンテナを起動してもネットワークに接続できないかもしれません。バージョン 220 を使う場合、ネットワークの転送設定（ ``net.ipv4.conf.<インターフェース>.forwarding`` ）がデフォルトでは *off* です。この設定は IP 転送を阻止します。また、これは Docker がコンテナの中で設定する ``net.ipv4.conf.all.forward`` と競合します。

.. To work around this, edit the <interface>.network file in /usr/lib/systemd/network/ on your Docker host (ex: /usr/lib/systemd/network/80-container-host0.network) add the following block:

動作するためには、Docker ホスト上の ``/usr/lib/systemd/network/`` にある ``<インターフェース>.network`` ファイルを編集し（例： ``/usr/lib/systemd/network/80-container-host0.netowrk`` ）、次のブロックを追加します。

.. code-block:: bash

   [Network]
   ...
   IPForward=kernel
   ...

.. This configuration allows IP forwarding from the container as expected.

この設定は、コンテナからと予想される IP 転送を許可するものです。

.. Uninstallation

アンインストール
====================

.. To uninstall the Docker package:

Docker パッケージをアンインストールします。

.. code-block:: bash

   $ sudo pacman -R docker

.. To uninstall the Docker package and dependencies that are no longer needed:

Docker パッケージと必要の無い依存関係をアンインストールするには、次のようにします。

.. code-block:: bash

   $ sudo pacman -Rns docker

.. The above commands will not remove images, containers, volumes, or user created configuration files on your host. If you wish to delete all images, containers, and volumes run the following command:

上記のコマンドは、イメージ、コンテナ、ボリュームやホスト上の設定ファイルを削除しません。イメージ、コンテナ、ボリュームを削除するには次のコマンドを実行します。

.. code-block:: bash

   $ rm -rf /var/lib/docker

.. You must delete the user created configuration files manually.

ユーザが作成した設定ファイルは、手動で削除する必要があります。

.. seealso:: 

   Installation on Arch Linux
      https://docs.docker.com/engine/installation/linux/archlinux/
