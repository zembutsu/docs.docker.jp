.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/installation/linux/cruxlinux/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/installation/linux/cruxlinux.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/installation/linux/cruxlinux.md
.. check date: 2016/06/13
.. Commits on Mar 4, 2016 69004ff67eed6525d56a92fdc69466c41606151a
.. ----------------------------------------------------------------------------

.. CRUX Linux

==============================
CRUX Linux
==============================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Installing on CRUX Linux can be handled via the contrib ports from James Mills and are included in the official contrib ports:

CRUX Linux でのインストールは、 `James Mills <http://prologic.shortcircuit.net.au/>`_ の contrib ports によるものと、オフィシャルの `contrib <http://crux.nu/portdb/?a=repo&q=contrib>`_ ports が使えます。

* docker

.. The docker port will build and install the latest tagged version of Docker.

``docker`` port は Docker の最新にタグ付けされたバージョンを構築し、インストールします。

.. Installation

インストール
====================

.. Assuming you have contrib enabled, update your ports tree and install docker:

contrib を有効にしていることを想定しています。ports tree を更新し、docker をインストールします。

.. code-block:: bash

   $ sudo prt-get depinst docker

.. Kernel requirements

カーネルの動作条件
====================

.. To have a working CRUX+Docker Host you must ensure your Kernel has the necessary modules enabled for the Docker Daemon to function correctly.

CRUX+Docker ホストを動作するためには、Kernel は Docker デーモンを機能させるために必要なモジュールを有効化します。

.. Please read the README:

詳細は ``README`` をお読みください。

.. code-block:: bash

   $ sudo prt-get readme docker

.. The docker port installs the contrib/check-config.sh script provided by the Docker contributors for checking your kernel configuration as a suitable Docker host.

``docker`` port は Docker コントリビュータによる ``contrib/check-config.sh`` スクリプトをインストールし、カーネルの設定が Docker ホスト向けに適切かどうか確認します。

.. To check your Kernel configuration run:

カーネルの設定を確認するには、次のように実行します。

.. code-block:: bash

   $ /usr/share/docker/check-config.sh

.. Starting Docker

Docker の起動
====================

.. There is a rc script created for Docker. To start the Docker service:

Docker 用の rc スクリプトが作られます。Docker サービスを開始するには、

.. code-block:: bash

   $ sudo /etc/rc.d/docker start

.. To start on system boot:

システムのブート時に開始するには、

..    Edit /etc/rc.conf
    Put docker into the SERVICES=(...) array after net.

* ``/etc/rc.conf`` を編集
* ``docker`` を ``net`` の後の ``SERVICES=(...)`` アレイに入れます。

.. Images

イメージ
==========

.. There is a CRUX image maintained by James Mills as part of the Docker “Official Library” of images. To use this image simply pull it or use it as part of your FROM line in your Dockerfile(s).

`James Mills <http://prologic.shortcircuit.net.au/>`_ により、Docker「公式ライブラリ」のイメージとして、CRUX イメージがメンテナンスされています。このイメージを使うのであれば、 ``Dockerfile`` の ``FROM`` 行に追加するか、次のようにします。

.. code-block:: bash

   $ docker pull crux
   $ docker run -i -t crux

.. There are also user contributed CRUX based image(s) on the Docker Hub.

Docker Hub には、他にもユーザが貢献した `CRUX ベース・イメージ <https://hub.docker.com/_/crux/>`_ があります。

.. Uninstallation

アンインストール
====================

.. To uninstall the Docker package:

Docker パッケージをアンインストールします。

.. code-block:: bash

   $ sudo prt-get remove docker

.. The above command will not remove images, containers, volumes, or user created configuration files on your host. If you wish to delete all images, containers, and volumes run the following command:

上記のコマンドは、イメージ、コンテナ、ボリュームやホスト上の設定ファイルを削除しません。イメージ、コンテナ、ボリュームを削除するには次のコマンドを実行します。

.. code-block:: bash

   $ rm -rf /var/lib/docker

.. You must delete the user created configuration files manually.

ユーザが作成した設定ファイルは、手動で削除する必要があります。

.. Issues

問題
==========

.. If you have any issues please file a bug with the CRUX Bug Tracker.

何らかの問題があれば、 `CRUX バグ・トラッカー <http://crux.nu/bugs/>`_ にお知らせください。

.. Support

サポート
==========

.. For support contact the CRUX Mailing List or join CRUX’s IRC Channels. on the FreeNode IRC Network.

サポートの連絡は `CRUX メーリングリスト <http://crux.nu/Main/MailingLists>`_ か、 `FreeNode <http://freenode.net/>`_ IRC ネットワークの CRUX `IRC チャンネル <http://crux.nu/Main/IrcChannels>`_ に参加ください。

.. seealso:: 

   Installation on CRUX Linux
      https://docs.docker.com/engine/installation/linux/cruxlinux/
