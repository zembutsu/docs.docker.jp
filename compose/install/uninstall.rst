.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/install/uninstall/
.. SOURCE: 
   doc version: v20.10
      https://github.com/docker/docker.github.io/blob/master/compose/install/uninstall.md
.. check date: 2022/07/16
.. Commits on Jul 13, 2022 38fec0d159134a9af7e8a3c226057a114b0622be
.. -------------------------------------------------------------------

.. Uninstall Docker Compose
.. _uninstall-docker-compose

==================================================
Docker Compose のアンインストール
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Uninstalling Docker Compose depends on the method you have used to install Docker Compose. On this page you can find specific instructions to uninstall Docker Compose.

Docker Compose のアンインストールは、Docker Compose のインストール方法によって異なります。このページでは、Docker Compose をアンインストールするための詳細手順を確認できます。

.. Uninstalling Docker Desktop
.. _uninstalling-docker-desktop

Docker Desktop のアンインストール
========================================

.. If you want to uninstall Compose and you have installed Docker Desktop, follow the corresponding link bellow to get instructions on how to remove Docker Desktop.

Docker Desktop をインストール済みで Compose をアンインストールしたい場合、以下の適切なリンクから Docker Desktop を削除する手順を確認します。

..    Note that, unless you have other Docker instances installed on that specific environment, you would be removing Docker altogether by uninstalling the Desktop.

.. note::

   対象環境上で他に Docker をインストールしていなければ、Docker Desktop のアンインストールが、 Docker 全体の削除になりますので、ご注意ください。

.. See Uninstall Docker Desktop for:

Docker Desktop のアンインストールをご覧ください：

..  Mac
    Windows
    Linux

* :ref:`Mac <mac-uninstal-docker-desktop>`
* :ref:`Windows <windows-uninstal-docker-desktop>`
* :ref:`Linux <linux-uninstal-docker-desktop>`

.. Uninstalling the Docker Compose CLI plugin
.. _uninstalling-the-docker-compose-cli-plugin:

Docker Compose CLI プラグインのアンインストール
==================================================

.. To remove the Compose CLI plugin, run:
Compose CLI プラグインを削除得するには、次のようにします：

.. code-block:: bash

   $ sudo apt-get remove docker-compose-plugin

.. Or, if using a different distro, use the equivalent package manager instruction to remove docker-compose-plugin.

あるいは、他のディストリビューションを使っている場合は、 ``docker-compose-plugin`` を削除するため、同等のパッケージマネージャの命令を使います。

.. Manually installed
.. _compose-uninstall-manually-installed:

手動インストールの場合
------------------------------

.. If you used curl to install Compose CLI plugin, to uninstall it run:

``curl`` を使って Compose CLI プラグインをインストールしている場合は、アンインストールするために次のように実行します：

.. code-block:: bash

   $ rm $DOCKER_CONFIG/cli-plugins/docker-compose

.. or, if you have installed Compose for all users, run:

あるいは、全ユーザに対して Compose をインストールしている場合は、次のようにします：

.. code-block:: bash

   $ rm /usr/local/lib/docker/cli-plugins/docker-compose

.. You can also use:

また、こちらも使えます：

.. code-block:: bash

   $ docker info --format '{{range .ClientInfo.Plugins}}{{if eq .Name "compose"}}{{.Path}}{{end}}{{end}}'

.. to inspect the location of the Compose CLI plugin.

これは、Compose CLI プラグインの場所を調べます。

..    Got a Permission denied error?
    If you get a Permission denied error using either of the above methods, you do not have the permissions allowing you to remove docker-compose. To force the removal, prepend sudo to either of the above instructions and run it again.

.. note::

   **パーミッション拒否 Permission denied エラーが出ますか？** 
   
   先述の方法を使い **Permission denied** エラーが出る場合、 ``docker-compose`` を削除できる権限がありません。強制的に削除するには、先述の各命令の前に ``sudo`` を付けて、もう一度実行してください。


.. seealso:: 

   Uninstall Docker Compose
      https://docs.docker.com/compose/install/uninstall/

