.. -*- coding: utf-8 -*-
.. https://docs.docker.com/engine/userguide/storagedriver/selectadriver/
.. doc version: 1.9
.. check date: 2015/12/31
.. -----------------------------------------------------------------------------

.. Select a storage driver

.. _select-a-storage-driver:

========================================
ストレージ・ドライバの選択
========================================

.. This page describes Docker’s storage driver feature. It lists the storage driver’s that Docker supports and the basic commands associated with managing them. Finally, this page provides guidance on choosing a storage driver.

このページは Docker のストレージ・ドライバ機能を説明します。Docker がサポートしているストレージ・ドライバの一覧と、ドライバ管理に関連する基本的なコマンドをみていきます。ページの最後では、ストレージ・ドライバの選び方のガイドを提供します。

.. The material on this page is intended for readers who already have an understanding of the storage driver technology.

このページは、既に :doc:`ストレージ・ドライバ技術を理解 <imagesandcontainers>` している読者を想定しています。

.. A pluggable storage driver architecture

.. _a-pluggable-storage-driver-architecture:

交換可能なストレージ・ドライバ構造
========================================

.. The Docker has a pluggable storage driver architecture. This gives you the flexibility to “plug in” the storage driver is best for your environment and use-case. Each Docker storage driver is based on a Linux filesystem or volume manager. Further, each storage driver is free to implement the management of image layers and the container layer in it’s own unique way. This means some storage drivers perform better than others in different circumstances.

Docker は接続可能な（pluggable）ストレージ・ドライバ構造を持っています。そのため、自分の環境や使い方に応じて、ベストなストレージ・ドライバを「プラグイン」（接続）できるので、柔軟さをもたらします。各 Docker のストレージ・ドライバは、 Linux ファイルシステムやボリューム・マネージャに基づいています。そのうえ、各ストレージ・ドライバはイメージ・レイヤとコンテナ・レイヤの管理を、各々の独自手法により自由に管理方法を実装できます。つまり、同じストレージ・ドライバであっても、異なった状況では性能が良くなるのを意味します。

.. Once you decide which driver is best, you set this driver on the Docker daemon at start time. As a result, the Docker daemon can only run one storage driver, and all containers created by that daemon instance use the same storage driver. The table below shows the supported storage driver technologies and the driver names:

どのドライバがベストかを決めたら、Docker デーモンの起動時にドライバを指定するだけです。Docker デーモンは対象のストレージ・ドライバを使って起動します。そして、デーモン・インスタンスによって作成される全てのコンテナは、全てその同じストレージ・ドライバを使っています。次の表はサポートされているストレージ・ドライバ技術とドライバ名です。

.. Technology 	Storage driver name
   OverlayFS 	overlay
   AUFS 	aufs
   Btrfs 	btrfs
   Device Maper 	devicemapper
   VFS* 	vfs
   ZFS 	zfs

.. list-table::
   :header-rows: 1
   
   * - 技術
     - ストレージ・ドライバ名
   * - OverlayFS
     - ``overlay``
   * - AUFS
     - ``aufs``
   * - Btrfs
     - ``btrfs``
   * - Device Mapper
     - ``devicemapper``
   * - VFS*
     - ``vfs``
   * - ZFS
     - ``zfs``

.. To find out which storage driver is set on the daemon , you use the docker info command:

デーモンで何のストレージ・ドライバが設定されているか確認するには、 ``docker info`` コマンドを使います。

.. code-block:: bash

   $ docker info
   Containers: 0
   Images: 0
   Storage Driver: overlay
    Backing Filesystem: extfs
   Execution Driver: native-0.2
   Logging Driver: json-file
   Kernel Version: 3.19.0-15-generic
   Operating System: Ubuntu 15.04
   ... 以下の出力は省略...

.. The info subcommand reveals that the Docker daemon is using the overlay storage driver with a Backing Filesystem value of extfs. The extfs value means that the overlay storage driver is operating on top of an existing (ext) filesystem. The backing filesystem refers to the filesystem that was used to create the Docker host’s local storage area under /var/lib/docker.

``info`` サブコマンドによって明らかになったのは、Docker デーモンが ``overlay`` ストレージ・ドライバを使い、``Backing Filesystem`` を ``extfs`` の値にしています。 ``extfs`` の値は、 ``overlay`` ストレージ・ドライバの押す差を既存の（ext）ファイルシステム上で行うという意味があります。

.. Which storage driver you use, in part, depends on the backing filesystem you plan to use for your Docker host’s local storage area. Some storage drivers can operate on top of different backing filesystems. However, other storage drivers require the backing filesystem to be the same as the storage driver. For example, the btrfs storage driver on a btrfs backing filesystem. The following table lists each storage driver and whether it must match the host’s backing file system:

自分がどのストレージ・ドライバを使うかの選択にあたり、部分的に、Docker ホストのローカル・ストレージ領域で使おうとするファイルシステムに依存します。いくつかのストレージ・ドライバは、異なったファイルシステム技術の上でも操作できます。しかしながら、特定のストレージ・ドライバは特定のファイルシステム技術を必要とします。例えば、 ``btrfs`` ストレージ・ドライバは ``btrfs`` ファイルシステム技術を使う必要があります。以下の表は、各ストレージ・ドライバが、それぞれホスト上の何のファイルシステム技術をサポートしているかの一覧です。

.. list-table::
   :header-rows: 1
   
   * - ストレージ・ドライバ
     - ファイルシステムと一致する必要があるか
   * - OverlayFS
     - いいえ
   * - aufs
     - いいえ
   * - btrfs
     - はい
   * - devicemapper
     - いいえ
   * - vfs*
     - いいえ
   * - zfs
     - はい

.. You pass the --storage-driver=<name> option to the docker daemon command line or by setting the option on the DOCKER_OPTS line in /etc/defaults/docker file.

設定するには ``docker daemon`` コマンドで ``--storage-driver=<名前>`` オプションを使うか、あるいは、 ``/etc/defaults/docker`` ファイル中の ``DOCKER_OPTS`` 行を編集します。

.. The following command shows how to start the Docker daemon with the devicemapper storage driver using the docker daemon command:

以下のコマンドは Docker デーモンを起動しています。 ``docker daemon`` コマンドで ``devicemapper`` ストレージ・ドライバを指定しています。

.. code-block:: bash

   $ docker daemon --storage-driver=devicemapper &
   
   $ docker info
   Containers: 0
   Images: 0
   Storage Driver: devicemapper
    Pool Name: docker-252:0-147544-pool
    Pool Blocksize: 65.54 kB
    Backing Filesystem: extfs
    Data file: /dev/loop0
    Metadata file: /dev/loop1
    Data Space Used: 1.821 GB
    Data Space Total: 107.4 GB
    Data Space Available: 3.174 GB
    Metadata Space Used: 1.479 MB
    Metadata Space Total: 2.147 GB
    Metadata Space Available: 2.146 GB
    Udev Sync Supported: true
    Deferred Removal Enabled: false
    Data loop file: /var/lib/docker/devicemapper/devicemapper/data
    Metadata loop file: /var/lib/docker/devicemapper/devicemapper/metadata
    Library Version: 1.02.90 (2014-09-01)
   Execution Driver: native-0.2
   Logging Driver: json-file
   Kernel Version: 3.19.0-15-generic
   Operating System: Ubuntu 15.04
   <出力を省略>

.. Your choice of storage driver can affect the performance of your containerized applications. So it’s important to understand the different storage driver options available and select the right one for your application. Later, in this page you’ll find some advice for choosing an appropriate driver.

ストレージ・ドライバの選択は、コンテナ化されたアプリケーションの性能に影響を与えます。そのために大切になるのは、どのようなストレージ・ドライバのオプションが利用可能かを理解し、アプリケーションに対する正しい選択をすることです。このページの後半では、適切なドライバを選ぶためのアドバイスを扱います。

.. Shared storage systems and the storage driver

.. _shared-storage-system-and-the-storage-driver:

共有ストレージ・システムとストレージ・ドライバ
==================================================

.. Many enterprises consume storage from shared storage systems such as SAN and NAS arrays. These often provide increased performance and availability, as well as advanced features such as thin provisioning, deduplication and compression.

多くのエンタープライズでは、SAN や NAS アレイのような共有ストレージ・システムをストレージ容量に使います。性能や安定性を向上させるためだけでなく、プロビジョニング・冗長化・圧縮など、高度な機能を提供します。

.. The Docker storage driver and data volumes can both operate on top of storage provided by shared storage systems. This allows Docker to leverage the increased performance and availability these systems provide. However, Docker does not integrate with these underlying systems.

Docker ストレージ・ドライバとデータ・ボリュームは、共有ストレージ・システムが提供するストレージ上でも操作可能です。そのため、これらの提供されるシステムによって、Docker の性能と可用性が増大させられます。しかしながら、 Docker はこれら基盤システムとは統合できません。

.. Remember that each Docker storage driver is based on a Linux filesystem or volume manager. Be sure to follow existing best practices for operating your storage driver (filesystem or volume manager) on top of your shared storage system. For example, if using the ZFS storage driver on top of XYZ shared storage system, be sure to follow best practices for operating ZFS filesystems on top of XYZ shared storage system.

各ストレージ・ドライバは Linux ファイルシステムやボリューム・マネージャを基盤としているのを覚えておいてください。自分の共有ストレージ・システム上でストレージ・ドライバ（ファイスシステムやボリューム）を操作するベストプラクティスを理解してください。例えば、ZFS ストレージ・ドライバを XYZ 共有ストレージ・システム上で使うのであれば、XYZ 共有ストレージ・システム上の ZFS ファイルシステムの操作のベストプラクティスを理解すべきです。

.. Which storage driver should you choose?

どのストレージ・ドライバを選ぶべきか？
========================================

.. As you might expect, the answer to this question is “it depends”. While there are some clear cases where one particular storage driver outperforms other for certain workloads, you should factor all of the following into your decision:

予想されているかもしれませんが、この疑問に対する答えは「その場合による」です。あるストレージ・ドライバの使用例が、特定の処理をする場合には優れていることもあります。決定にあたっては、以下の全ての要素を検討すべきでしょう。

.. Choose a storage driver that you and your team/organization are comfortable with. Consider how much experience you have with a particular storage driver. There is no substitute for experience and it is rarely a good idea to try something brand new in production. That’s what labs and laptops are for!

あなたやチーム/組織が満足するストレージ・ドライバを選択します。そのストレージ・ドライバを、どれだけ（これまでに）経験してきたかを検討してください。相応の経験が無いのであれば、まったく新しいプロダクション環境で挑むのは、良い考えとは滅多にも言えないでしょう。研究やノート PC 上の利用であれば、そうではありませんが。

.. If your Docker infrastructure is under support contracts, choose an option that will get you good support. You probably don’t want to go with a solution that your support partners have little or no experience with.

もしあなたの Docker インフラが何らかのサポート契約を受けているのであれば、より良いサポートを受けるという選択肢もあります。あるいは、サポート・パートナーの経験が無いまたは少なければ、ソリューションを必要としない場合もあるでしょう。

.. Whichever driver you choose, make sure it has strong community support and momentum. This is important because storage driver development in the Docker project relies on the community as much as the Docker staff to thrive.

どのドライバを選択したとしても、強いコミュニティのサポートと勢いがあるのを覚えておいてください。

.. Related information

関連情報
==========

..    Understand images, containers, and storage drivers
    AUFS storage driver in practice
    Btrfs storage driver in practice
    Device Mapper storage driver in practice

* :doc:`imagesandcontainers`
* :doc:`aufs-drive`
* :doc:`btrfs-driver`
* :doc:`device-mapper-driver`
