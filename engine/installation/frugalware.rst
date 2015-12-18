.. -*- coding: utf-8 -*-
.. https://docs.docker.com/engine/installation/frugalware/
.. doc version: 1.9
.. check date: 2015/12/18
.. -----------------------------------------------------------------------------

.. FrugalWare

==============================
FrugalWare
==============================

.. Installing on FrugalWare is handled via the official packages:

FrugalWare でのインストールは、公式パッケージを使います。

* lxc-docker i686
* lxc-docker x86_64

.. The lxc-docker package will install the latest tagged version of Docker.

lxc-docker パッケージは、最新とタグづけられた Docker のバージョンをインストールします。

.. Dependencies

依存関係
====================

.. Docker depends on several packages which are specified as dependencies in the packages. The core dependencies are:

Docker のパッケージは、複数の特定パッケージと依存関係があります。主な依存関係は次の通りです。

* systemd
* lvm2
* sqlite3
* libguestfs
* lxc
* iproute2
* bridge-utils

.. Installation

インストール
====================

.. A simple

簡単です。

.. code-block:: bash

   $ sudo pacman -S lxc-docker

.. is all that is needed.

これで必要な全てがインストールされます。

.. Starting Docker

Docker の起動
====================

.. There is a systemd service unit created for Docker. To start Docker as service:

docker によって systemd サービスの unit が作成されます。docker サービスを起動するには、

.. code-block:: bash

   $ sudo systemctl start lxc-docker

.. To start on system boot:

システムのブート時に開始するには、

.. code-block:: bash

.. $ sudo systemctl enable lxc-docker

.. Custom daemon options

デーモンのオプション設定
==============================

.. If you need to add an HTTP Proxy, set a different directory or partition for the Docker runtime files, or make other customizations, read our systemd article to learn how to customize your Systemd Docker daemon options.

HTTP プロキシの追加が必要な場合、Docker のランタイム・ファイルを異なったディレクトリやパーティションに置いてください。あるいは別のカスタマイズ方法として、Systemd の記事 :doc:`Systemd Docker デーモン・オプションのカスタマイズ </engine/articles/systemd>` から、どのように設定するかをご覧ください。

.. Uninstallation

アンインストール
====================

.. To uninstall the Docker package:

Docker パッケージをアンインストールするには、

.. code-block:: bash

   $ sudo pacman -R lxc-docker

.. To uninstall the Docker package and dependencies that are no longer needed:

Docker パッケージと必要の無い依存関係をアンインストールするには、次のようにします。

.. code-block:: bash

   $ sudo pacman -Rns lxc-docker

.. The above commands will not remove images, containers, volumes, or user created configuration files on your host. If you wish to delete all images, containers, and volumes run the following command:

上記のコマンドは、イメージ、コンテナ、ボリュームやホスト上の設定ファイルを削除しません。イメージ、コンテナ、ボリュームを削除するには次のコマンドを実行します。

.. code-block:: bash

   $ rm -rf /var/lib/docker

.. You must delete the user created configuration files manually.

ユーザが作成した設定ファイルは、手動で削除する必要があります。
