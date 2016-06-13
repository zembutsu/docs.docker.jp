.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/installation/linux/gentoolinux/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/installation/linux/gentoolinux.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/installation/linux/gentoolinux.md
.. check date: 2016/06/13
.. Commits on Mar 9, 2016 cdd8d3999ffd9f7eeb764f52e21577e0900d7b5c
.. ----------------------------------------------------------------------------

.. Gentoo

==============================
Gentoo
==============================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Installing Docker on Gentoo Linux can be accomplished using one of two ways: the official way and the docker-overlay way.

Gentoo Linux に Docker をインストールするには、２つの方法があります。 **公式** の方法と、 ``docker-overlay`` を使う方法です。

.. Official project page of Gentoo Docker team.

`Gentoo Docker <https://wiki.gentoo.org/wiki/Project:Docker>`_ チームの公式プロジェクト・ページです。

.. Official way

公式の方法
====================

.. The first and recommended way if you are looking for a stable experience is to use the official app-emulation/docker package directly from the tree.

１つめの、そして安定版を使いたい場合にお薦めの方法が、公式の ``app-emulation/docker`` パッケージ・ディレクトリのツリーにあるものです。

.. If any issues arise from this ebuild including, missing kernel configuration flags or dependencies, open a bug on the Gentoo Bugzilla assigned to docker AT gentoo DOT org or join and ask in the official IRC channel on the Freenode network.

カーネルの設定フラグが無い場合や依存関係など、ebuild に関する何らかの問題が起こったら Gentoo `Bugzilla <https://bugs.gentoo.org/>`_ でバグを開き、 ``docker AT gentoo DOT org`` に割り当てるか、Freenode ネットワークの公式 `IRC <http://webchat.freenode.net/?channels=%23gentoo-containers&uio=d4>`_ チャンネルでお訊ねください。

.. docker-overlay way

docker-overlay の方法
==============================

.. If you’re looking for a -bin ebuild, a live ebuild, or a bleeding edge ebuild, use the provided overlay, docker-overlay which can be added using app-portage/layman. The most accurate and up-to-date documentation for properly installing and using the overlay can be found in the overlay.

``-bin`` ebuild、live ebuild、bleeding edge ebuild を探している場合は、オーバレイとして `docker-overlay <https://github.com/tianon/docker-overlay>`_  を提供しています。これは ``app-portage/layman`` を使えるようにしたものです。適切にインストールするための、最も正確かつ最新のドキュメントと、overlay の使い方は `overlay <https://github.com/tianon/docker-overlay/blob/master/README.md#using-this-overlay>`_ をご覧ください。

.. If any issues arise from this ebuild or the resulting binary, including and especially missing kernel configuration flags or dependencies, open an issue on the docker-overlay repository or ping tianon directly in the #docker IRC channel on the Freenode network.

カーネルの設定フラグが無い場合や依存関係など、ebuild に関する何らかの問題が起こったら ``docker-overlay`` リポジトリ上で `issue <https://github.com/tianon/docker-overlay/issues>`_ 開くか、Freenode ネットワークの ``#docker`` IRC チャンネルで ``tianon`` に直接お訊ねください。

.. Installation

インストール
====================

.. Available USE flags

利用可能な USE フラグは次の通りです。

.. list-table::
   :widths: 20 15 65
   :header-rows: 1

   * - USE フラグ
     - デフォルト
     - 説明
   * - aufs
     - 
     - "aufs" graph ドライバと、必要なカーネル・フラグを含む依存関係を有効にします。
   * - btrfs
     - 
     -  "btrfs" graph ドライバと、必要なカーネル・フラグを含む依存関係を有効にします。
   * - contrib
     - Yes
     -  追加のコントリビュート・スクリプトとコンポーネントをインストールします。
   * - device-mapper
     - Yes
     -  "devicemapper" graph ドライバと、必要なカーネル・フラグを含む依存関係を有効にします。
   * - doc
     - 
     -  追加ドキュメント（API、Javadoc、等）を追加します。全体よりも個別のパッケージ毎の追加を推奨します。
   * - lxc
     - 
     - "lxc" 実行ドライバの依存関係を有効化します。
   * - vim-syntax
     - 
     -  vim syntax スクリプトに関連する取得をします。
   * - zsh-completion
     - 
     -  zsh 補完コマンドを有効化します。

.. USE flags are described in detail on tianon’s blog.

USE フラグの詳細説明は、 `tianon's blog <https://tianon.github.io/post/2014/05/17/docker-on-gentoo.html>`_ をご覧ください。

.. The package should properly pull in all the necessary dependencies and prompt for all necessary kernel options.

パッケージは、依存関係が必要なパッケージをすべて取得するかや、カーネル・オプションを指定するか確認します。

.. code-block:: bash

   $ sudo emerge -av app-emulation/docker

..    Note: Sometimes there is a disparity between the latest versions in the official Gentoo tree and the docker-overlay.
..    Please be patient, and the latest version should propagate shortly.

.. note::

   時折、**Gentoo tree** と **docker-overlay** の間には、最新バージョンに相違が発生します。
   すぐに最新版が利用できるようになるまで、どうかお待ちください。

.. Starting Docker

Docker の起動
====================

.. Ensure that you are running a kernel that includes all the necessary modules and configuration (and optionally for device-mapper and AUFS or Btrfs, depending on the storage driver you’ve decided to use).

実行するカーネルが、必要な全てのモジュールや設定（オプションでデバイス・マッパーや AUFS や Birtfs を使うなら、依存するストレージ・ドライバ）がされていることを確認します。

.. To use Docker, the docker daemon must be running as root.

Docker を使うには、 ``docker`` デーモンを **root** として実行する必要があります。

.. To use Docker as a non-root user, add yourself to the docker group by running the following command:

Docker を **root ではない** ユーザが使うには、次のコマンドでユーザを **docker** グループに追加します。

.. code-block:: bash

   $ sudo usermod -a -G docker user

.. OpenRC

OpenRC
----------

.. To start the docker daemon:

``docker`` デーモンを開始します。

.. code-block:: bash

   $ sudo /etc/init.d/docker start

.. To start on system boot:

システムのブート時に開始します。

.. code-block:: bash

   $ sudo rc-update add docker default

.. systemd

systemd
----------

.. To start the docker daemon:

``docker`` デーモンを開始します。

.. code-block:: bash

   $ sudo systemctl start docker

.. To start on system boot:

システムのブート時に開始します。

.. code-block:: bash

   $ sudo systemctl enable docker

.. If you need to add an HTTP Proxy, set a different directory or partition for the Docker runtime files, or make other customizations, read our systemd article to learn how to customize your systemd Docker daemon options.

.. If you need to add an HTTP Proxy, set a different directory or partition for the Docker runtime files, or make other customizations, read our Systemd article to learn how to customize your Systemd Docker daemon options.

HTTP プロキシの追加が必要な場合、Docker のランタイム・ファイルを異なったディレクトリやパーティションに置いてください。あるいは別のカスタマイズ方法として、Systemd の記事 :doc:`Systemd Docker デーモン・オプションのカスタマイズ </engine/admin/systemd>` から、どのように設定するかをご覧ください。

.. Uninstallation

アンインストール
====================

.. To uninstall the Docker package:

Docker パッケージをアンインストールします。

.. code-block:: bash

   $ sudo emerge -cav app-emulation/docker

.. To uninstall the Docker package and dependencies that are no longer needed:

Docker パッケージと必要の無い依存関係をアンインストールするには、次のようにします。

.. code-block:: bash

   $ sudo emerge -C app-emulation/docker

.. The above commands will not remove images, containers, volumes, or user created configuration files on your host. If you wish to delete all images, containers, and volumes run the following command:

上記のコマンドは、イメージ、コンテナ、ボリュームやホスト上の設定ファイルを削除しません。イメージ、コンテナ、ボリュームを削除するには次のコマンドを実行します。

.. code-block:: bash

   $ rm -rf /var/lib/docker

.. You must delete the user created configuration files manually.

ユーザが作成した設定ファイルは、手動で削除する必要があります。

.. seealso:: 

   Installation on Gentoo
      https://docs.docker.com/engine/installation/linux/gentoolinux/

