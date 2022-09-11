.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/docker-for-windows/docker-toolbox/
   doc version: 19.03
      https://github.com/docker/docker.github.io/blob/master/docker-for-windows/docker-toolbox.md
.. check date: 2020/06/12
.. Commits on May 22, 2020 a7806de7c56672370ec17c35cf9811f61a800a42
.. -----------------------------------------------------------------------------

.. Migrate Docker Toolbox

.. _win-migrate-docker-toolbox:

==================================================
Docker Toolbox の移行
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. This page explains how to migrate your Docker Toolbox disk image, or images if you have them, to Docker Desktop for Windows.

このページで説明するのは、Docker Toolbox ディスクイメージや既にあるイメージを Docker Desktop for Windows に移行する方法です。

.. How to migrate Docker Toolbox disk images to Docker Desktop

.. _win-how-to-migrate-docker-toolbox-disk-images-to-docker-desktop:

Docker Toolbox ディスクイメージを Docker Desktop への移行方法
=================================================================

..    Warning

..    Migrating disk images from Docker Toolbox clobbers Docker images if they exist. The migration process replaces the entire VM with your previous Docker Toolbox data.

.. warning::

   Docker Toolbox からのディスクイメージ移行は、既存の Docker イメージを上書きします。移行手順では、以前の Docker Toolbox データ全体を含む仮想マシン全体を置き換えます。

..    Install qemu (a machine emulator): https://cloudbase.it/downloads/qemu-img-win-x64-2_3_0.zip.
    Install Docker Desktop for Windows.
    Stop Docker Desktop, if running.
..    Move your current Docker VM disk to a safe location:

1. `qemu <https://www.qemu.org/>`_ をインストールします。 https://cloudbase.it/downloads/qemu-img-win-x64-2_3_0.zip
2. :doc:`Docker Desktop for Windows <install>` をインストールします。
3. もしも Docker が起動中であれば停止します。
4. 現在の Docker 仮想マシン・ディスクを安全な場所の移動します。

.. code-block:: bash

   mv 'C:\Users\Public\Documents\Hyper-V\Virtual Hard Disks\MobyLinuxVM.vhdx' C:/<any directory>

..    Convert your Toolbox disk image:

5.　Toolbox ディスク・イメージを変換します。

.. code-block:: bash

   qemu-img.exe convert 'C:\Users\<username>\.docker\machine\machines\default\disk.vmdk' -O vhdx -o subformat=dynamic -p 'C:\Users\Public\Documents\Hyper-V\Virtual Hard Disks\MobyLinuxVM.vhdx'

..    Restart Docker Desktop (with your converted disk).

6.　Docker Desktop を（変換したディスクを用いて）再起動します。

.. How to uninstall Docker Toolbox

.. _win-how-to-uninstall-docker-toolbox:

Docker Toolbox をアンインストールする方法
==================================================

.. Whether or not you migrate your Docker Toolbox images, you may decide to uninstall it. For details on how to perform a clean uninstall of Toolbox, see How to uninstall Toolbox.

Docker Toolbox イメージを移行するかどうかに関わらず、アンインストールを決めるべきでしょう。Toolbox をクリーン・アンインストールする詳細は、 :ref:`Toolbox のアンインストール方法 <how-to-uninstall-toolbox>` を御覧ください。


.. seealso:: 

   Migrate Docker Toolbox
      https://docs.docker.com/docker-for-windows/docker-toolbox/
