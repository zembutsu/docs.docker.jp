.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/desktop/vm-vdi/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/desktop/vm-vdi.md
.. check date: 2022/09/17
.. Commits on Aug 24, 2022 ff003660554045b368df6ab80cf92e91420a9085
.. -----------------------------------------------------------------------------

.. Run Docker Desktop for Windows in a VM or VDI environment
.. _run-docker-desktop-for-windows-in-a-vm-or-vdi-environment:

==================================================
VM や VDI 環境で Docker Desktop for Window を実行
==================================================

.. sidebar:: 目次

   .. contents::
       :depth: 3
       :local:

.. In general, Docker recommends running Docker Desktop natively on either Mac, Linux, or Windows. However, Docker Desktop for Windows can run inside a virtual desktop provided the virtual desktop is properly configured.

Docker は一般的に、 Mac、 Linux、Windows 上のどれかでネイティブに Docker Desktop を実行するのを推奨します。ですが、仮想デスクトップが適切に設定されている仮想デスクトップ内で Docker Desktop for Linux を実行できます。

.. To run Docker Desktop in a virtual desktop environment, it is essential nested virtualization is enabled on the virtual machine that provides the virtual desktop. This is because, under the hood, Docker Desktop is using a Linux VM in which it runs Docker Engine and the containers.

仮想デスクトップ環境内で Docker Desktop を実行するには、仮想デスクトップを提供する仮想マシン上で、 :ruby:`ネスト化された仮想化 <nested virtualization>` の有効化が必須です。この理由は、 Docker Desktop が内部で Linux VM を使用し、そこで Docker Engine とコンテナを実行しているからです。

.. Virtual desktop support
.. _desktop-virtual-desktop-support:

仮想デスクトップのサポート
==============================

.. Support for running Docker Desktop on a virtual desktop is available to Docker Business customers, on VMware ESXi or Azure VMs only.

.. note::

   Docker ビジネス利用者のために、 VMware ESXi や Azure VM 内での Docker Desktop 実行がサポートされています。

.. The support available from Docker extends to installing and running Docker Desktop inside the VM, once the nested virtualization is set up correctly. The only hypervisors we have successfully tested are VMware ESXi and Azure, and there is no support for other VMs. For more information on Docker Desktop support, see Get support.

ネスト化された仮想化が正しくセットアップされていれば、仮想マシン内で実行している Docker Desktop のインストールと実行まで Docker から利用可能なサポートが拡大されます。既にテストに成功しているハイパーバイザは VMware ESXi と azure のみです。他の仮想マシンは一切サポートされません。Docker Desktop のサポートについての詳しい情報は、 :doc:`サポートを受ける <support>` をご覧ください。

.. For troubleshooting problems and intermittent failures that are outside of Docker’s control, you should contact your hypervisor vendor. Each hypervisor vendor offers different levels of support. For example, Microsoft supports running nested Hyper-V both on-prem and on Azure, with some version constraints. This may not be the case for VMWare ESXi.

Docker が管理している以外の問題や継続的な障害のトラブルシュートには、ハイパーバイザの提供事業者に連絡すべきです。各ハイパーバイザのベンダは、様々なレベルのサポートを提供しています。たとえば、 Microsoft はオンプレミス上と Azure 上のどちらでもネスト化された Hyper-V の実行をサポートしています。VMWare ESXi では、これがあてはまらない場合があります。

.. Enable nested virtualization
.. _desktop-enable-nested-virtualization:

ネスト化された仮想化の有効化
==============================

.. You must enable nested virtualization before you install Docker Desktop on a virtual machine.

仮想マシン上に Docker Desktop をインストールする前に、ネスト化された仮想化の有効化が必要です。

.. Enable nested virtualization on VMware ESXi
.. _desktop-enable-nested-virtualization-on-vmware-esxi:

VMware ESXi 上でネスト化された仮想化を有効化
--------------------------------------------------

.. Nested virtualization of other hypervisors like Hyper-V inside a vSphere VM is not a supported scenario. However, running Hyper-V VM in a VMware ESXi VM is technically possible and, depending on the version, ESXi includes hardware-assisted virtualization as a supported feature. For internal testing, we used a VM that had 1 CPU with 4 cores and 12GB of memory.

vSphere VM 内では、 Hyper-V のような他のハイパーバイザによるネスト化された仮想化は `サポートされていないシナリオ <https://kb.vmware.com/s/article/2009916>`_ です。しかしながら、VMware ESXi VM 内で Hyper-V VM の実行は、技術的には可能で、バージョンに依存しますが ESXi にはハードウェア支援による仮想化もサポートされている機能です。内部のテストで使った VM は、4コア の 1 CPU と 12GB のメモリでした。

.. For steps on how to expose hardware-assisted virtualization to the guest OS, see VMware’s documentation.

ハードウェア支援による仮想化をゲスト OS に公開する手順は、 `VMware のドキュメントをご覧ください <https://docs.vmware.com/en/VMware-vSphere/7.0/com.vmware.vsphere.vm_admin.doc/GUID-2A98801C-68E8-47AF-99ED-00C63E4857F6.html>`_ 。

.. You may also need to configure some network settings.

また、 `いくつかのネットワーク設定の調整 <https://www.vembu.com/blog/nested-hyper-v-vms-on-a-vmware-esxi-server>`_ も必要です。

.. Enable nested virtualization on Microsoft Hyper-V
.. _desktop-enable-nested-virtualization-on-microsoft-hyper-v:

Microsoft Hyper-V 上でネスト化された仮想化を有効化
--------------------------------------------------

.. Nested virtualization is supported by Microsoft for running Hyper-V inside an Azure VM.

Azure VM 内で Hyper-V を実行するにあたり、ネスト化された仮想化は Microsoft によってサポートされています。

.. For Azure virtual machines, check that the VM size chosen supports nested virtualization. Microsoft provides a helpful list on Azure VM sizes and highlights the sizes that currently support nested virtualization. For internal testing, we used D4s_v5 machines. We recommend this specification or above for optimal performance of Docker Desktop.

Azure 仮想マシンでは、 `選んだ VM サイズがネスト化された仮想化をサポートしているかどうか確認します <https://docs.microsoft.com/en-us/azure/virtual-machines/sizes>`_ 。Microsoft は `Azure VM サイズに役立つリストを提供し <https://docs.microsoft.com/en-us/azure/virtual-machines/acu>`_ 、ネスト化された仮想化を現時点でサポートしているサイズを強調表示しています。内部テストでは D4s_v5 マシンを使いました。Docker Desktop のパフォーマンスを最適化するため、この仕様以上を推奨します。

.. seealso::

   Run Docker Desktop for Windows in a VM or VDI environment
      https://docs.docker.com/desktop/vm-vdi/
