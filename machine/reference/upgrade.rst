.. -*- coding: utf-8 -*-
.. https://docs.docker.com/machine/reference/upgrade/
.. doc version: 1.9
.. check date: 2016/01/28
.. -----------------------------------------------------------------------------

.. upgrade

.. _machine-upgrade:

=======================================
upgrade
=======================================

.. Upgrade a machine to the latest version of Docker. How this upgrade happens depends on the underlying distribution used on the created instance.

マシンを Docker の最新バージョンにアップグレードします。どのようにアップグレードをするかは、インスタンス作成に用いたディストリビューションに依存します。

.. For example, if the machine uses Ubuntu as the underlying operating system, it will run a command similar to sudo apt-get upgrade lxc-docker, because Machine expects Ubuntu machines it manages to use this package. As another example, if the machine uses boot2docker for its OS, this command will download the latest boot2docker ISO and replace the machine’s existing ISO with the latest.

たとえば、動作するオペレーティング・システムを Ubuntu としてマシンを起動している場合、Docker Machine は Ubuntu マシンのパッケージを管理しているとみなすため、 ``sudo apt-get upgrade lxc-docker`` のようなコマンドを実行します。

.. code-block:: bash

   $ docker-machine upgrade dev
   Stopping machine to do the upgrade...
   Upgrading machine dev...
   Downloading latest boot2docker release to /home/username/.docker/machine/cache/boot2docker.iso...
   Starting machine back up...
   Waiting for VM to start...

..    Note: If you are using a custom boot2docker ISO specified using --virtualbox-boot2docker-url or an equivalent flag, running an upgrade on that machine will completely replace the specified ISO with the latest “vanilla” boot2docker ISO available.

.. note::

   もし ``--virtualbox-boot2docker-url`` を使いカスタム boot2docker ISO を使っているか、同等のフラグを使っている場合、upgrade の実行とは、Docker Machine によって ISO イメージを最新の「vanilla」boot2docker ISO イメージに完全に置き換えるものです。

