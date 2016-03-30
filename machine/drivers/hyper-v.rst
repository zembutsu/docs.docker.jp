.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/machine/drivers/hyper-v/
.. SOURCE: https://github.com/docker/machine/blob/master/docs/drivers/hyper-v.md
   doc version: 1.10
      https://github.com/docker/machine/commits/master/docs/drivers/hyper-v.md
.. check date: 2016/03/09
.. Commits on Feb 4, 2016 a8625397bc0b3526a3177303a1e39dac25e68850
.. ----------------------------------------------------------------------------

.. Microsoft Hyper-V

.. _driver-microsoft-hyper-v:

=======================================
Microsoft Hyper-V
=======================================

.. Creates a Boot2Docker virtual machine locally on your Windows machine using Hyper-V. See here for instructions to enable Hyper-V. You will need to use an Administrator level account to create and manage Hyper-V machines.

自分の Windows マシン上にある Hyper-V で、Boot2Docker 仮想マシンを作成します。Hyper-V の有効化は `こちら <http://windows.microsoft.com/en-us/windows-8/hyper-v-run-virtual-machines>`_ をご覧ください。Hyper-V マシンの作成・管理のためには、管理者レベル権限を使う必要があります。

..    Note: You will need an existing virtual switch to use the driver. Hyper-V can share an external network interface (aka bridging), see this blog. If you would like to use NAT, create an internal network, and use Internet Connection Sharing.

.. note::

   ドライバを使うには既存の仮想スイッチを使う必要があります。Hyper-V は外部のネットワーク・インターフェース（ブリッジなど）を共有できます。詳しくは `こちらのブログ <http://blogs.technet.com/b/canitpro/archive/2014/03/11/step-by-step-enabling-hyper-v-for-use-on-windows-8-1.aspx>`_ をご覧ください。NAT を使いたい場合は、内部のネットワーク（internal network）を作成し、 `Internet Connection Sharing <http://www.packet6.com/allowing-windows-8-1-hyper-v-vm-to-work-with-wifi/>`_ を有効化します。

.. code-block:: bash

   $ docker-machine create --driver hyperv vm

.. Options:

オプション：

..    --hyperv-boot2docker-url: The URL of the boot2docker ISO. Defaults to the latest available version.
    --hyperv-boot2docker-location: Location of a local boot2docker iso to use. Overrides the URL option below.
    --hyperv-virtual-switch: Name of the virtual switch to use. Defaults to first found.
    --hyperv-disk-size: Size of disk for the host in MB.
    --hyperv-memory: Size of memory for the host in MB. By default, the machine is setup to use dynamic memory.

* ``--hyperv-boot2docker-url`` : boot2docker ISO の URL 。デフォルトは利用可能な最新バージョン。
* ``--hyperv-virtual-switch`` : 使用する仮想スイッチ名。デフォルトは１番目に見つかったもの。
* ``--hyperv-disk-size`` : ホスト上のディスク容量を MB 単位で指定。
* ``--hyperv-memory`` : ホスト上のメモリ容量を MB 単位で指定。デフォルトでは、マシンは dynamic メモリをセットアップに使います。
* ``--hyperv-cpu-count`` : ホスト上の CPU 数。
* ``--hyperv-static-macaddress`` : Hyper-V ネットワーク・アダプタの静的 MAC アドレス。
* ``--hyperv-vlan-id`` : Hyper-V ネットワーク・アダプタの VLAN ID （存在している場合）。


.. Environment variables and default values:

利用可能な環境変数とデフォルト値は以下の通りです。

.. list-table::
   :header-rows: 1
   
   * - コマンドライン・オプション
     - 環境変数
     - デフォルト値
   * - ``--hyperv-boot2docker-url``
     - ``HYPERV_BOOT2DOCKER_URL``
     - *最新の boot2docker url*
   * - ``--hyperv-virtual-switch``
     - ``HYPERV_VIRTUAL_SWITCH``
     - *１番目に見つけたもの*
   * - ``--hyperv-disk-size``
     - ``HYPERV_DISK_SIZE``
     - ``20000``
   * - ``--hyperv-memory``
     - ``HYPERV_MEMORY``
     - ``1024``
   * - ``--hyperv-cpu-count``
     - ``HYPERV_CPU_COUNT``
     - ``1``
   * - ``--hyperv-static-macaddress``
     - ``HYPERV_STATIC_MACADDRESS``
     - *未定義*
   * - ``--hyperv-vlan-id``
     - ``HYPERV_VLAN_ID``
     - *未定義*

.. seealso:: 

   Microsoft Hyper-V
      https://docs.docker.com/machine/drivers/hyper-v/
