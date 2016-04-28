.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/machine/reference/upgrade/
.. SOURCE: https://github.com/docker/machine/blob/master/docs/reference/upgrade.md
   doc version: 1.11
      https://github.com/docker/machine/commits/master/docs/reference/upgrade.md
.. check date: 2016/04/28
.. Commits on Feb 28, 2016 1331811dca44b95216dcdd011f2de3551d1dd8e9
.. ----------------------------------------------------------------------------

.. upgrade

.. _machine-upgrade:

=======================================
upgrade
=======================================

.. Upgrade a machine to the latest version of Docker. How this upgrade happens depends on the underlying distribution used on the created instance.

マシンを Docker の最新バージョンにアップグレードします。どのようにアップグレードをするかは、インスタンス作成に用いたディストリビューションに依存します。

.. For example, if the machine uses Ubuntu as the underlying operating system, it will run a command similar to sudo apt-get upgrade docker-engine, because Machine expects Ubuntu machines it manages to use this package. As another example, if the machine uses boot2docker for its OS, this command will download the latest boot2docker ISO and replace the machine’s existing ISO with the latest.

たとえば、動作するオペレーティング・システムを Ubuntu としてマシンを起動している場合、Docker Machine は Ubuntu マシンのパッケージを管理しているとみなすため、 ``sudo apt-get upgrade docker-engine`` のようなコマンドを実行します。

.. code-block:: bash

   $ docker-machine upgrade default
   Stopping machine to do the upgrade...
   Upgrading machine default...
   Downloading latest boot2docker release to /home/username/.docker/machine/cache/boot2docker.iso...
   Starting machine back up...
   Waiting for VM to start...

..    Note: If you are using a custom boot2docker ISO specified using --virtualbox-boot2docker-url or an equivalent flag, running an upgrade on that machine will completely replace the specified ISO with the latest “vanilla” boot2docker ISO available.

.. note::

   もし ``--virtualbox-boot2docker-url`` を使いカスタム boot2docker ISO を使っているか、同等のフラグを使っている場合、upgrade の実行とは、Docker Machine によって ISO イメージを最新の「vanilla」boot2docker ISO イメージに完全に置き換えるものです。

.. seealso:: 

   upgrade
      https://docs.docker.com/machine/reference/upgrade/
