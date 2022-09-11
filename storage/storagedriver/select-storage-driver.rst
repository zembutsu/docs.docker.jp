.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/storage/storagedriver/select-storage-driver/
.. SOURCE: 
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/userguide/storagedriver/selectadriver.md
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/storage/storagedriver/select-storage-driver.md
.. check date: 2022/05/03
.. Commits on Aug 6, 2021 f5e49b158bb820ca99d64850a8f1f5a0c7f4eb47
.. ---------------------------------------------------------------------------

.. Docker storage drivers
.. _docker-storage-drivers:

========================================
Docker ストレージ ドライバ
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Ideally, very little data is written to a container’s writable layer, and you use Docker volumes to write data. However, some workloads require you to be able to write to the container’s writable layer. This is where storage drivers come in.

理想的には、コンテナの書き込み可能なレイヤーへのデータが小さければ、データの書き込みには Docker ボリュームを使うでしょう。しかしながら、 :ruby:`作業量 <workload>` によってはコンテナの書き込み可能なレイヤーへの書き込みを必要とする場合があります。

.. Docker supports several storage drivers, using a pluggable architecture. The storage driver controls how images and containers are stored and managed on your Docker host. After you have read the storage driver overview, the next step is to choose the best storage driver for your workloads. Use the storage driver with the best overall performance and stability in the most usual scenarios.

:ruby:`交換可能 <pluggable>` なアーキテクチャを使う、複数のストレージ ドライバを、 Docker はサポートします。ストレージ ドライバが制御するのは、 Docker ホスト上でイメージとコンテナをどのようにして保管および管理するかです。 :doc:`ストレージ ドライバ概要 <index>` を読んだ後であれば、次のステップは、自分の作業量にベストなストレージを選択します。ほとんど一般的なシナリオでは、全体的なパフォーマンスと安定性が最も高いストレージドライバを使用します。

.. The Docker Engine provides the following storage drivers on Linux:
 Linux の Docker Engine は以下のストレージ ドライバを提供します。
 
 .. list-table::
   :header-rows: 1
   
   * - ドライバ
     - 説明
   * - ``overlay2``
     - ``overlay2`` は、現在サポートしている全ての Linux ディストリビューションに適しているストレージドライバであり、追加設定が不要。
   * - ``fuse-overlayfs``
     - ```fuse-overlayfs` が望ましいのはホスト上で Rootless Docker を実行している場合のみです。Ubuntu と Debian 10 では、 ``fuse-overlayfs`` ドライバを使う必要はなく、 rootless モードでも ``overlay2`` は動作します。詳細は :doc:`rootless モードのドキュメント </engine/security/rootless>` をご覧ください。
   * - ``btrfs`` と ``zfs``
     - ``btrfs`` と ``zfs`` ストレージドライバでは「snapshot」のような高度なオプションが使えますが、メンテナンスやセットアップを多く必要とします。これらは正しく設定されている背後のファイルシステムに依存します。
   * - ``vfs``
     - ``vfs`` ストレージドライバは、テスト目的の用途であり、かつ、 コピー オン ライトのファイルシステムが使えない状態向けです。このストレージドライバの性能は乏しく、本番環境の利用では一般的に推奨できません。
   * - ``aufs``
     - このドライバに依存する kernel 3.13 上の Ubuntu 14.04 が ``overlay2`` をサポートしなくなるまで、``aufs`` ストレージドライバは Docker 18.06 以前の推奨ストレージドライバ「でした」。しかし、現在の Ubuntu と Debian は ``overlay2`` をサポートしており、これが現在推奨されているドライバです。
   * - ``devicemapper``
     - ``devicemapper`` ストレージドライバは、設定が無ければ性能が乏しいため、本番環境では ``direct-lvm`` を必要とします。 ``devicemapper`` は CentOS と RHEL では、 kernel のバージョンが ``overlay2`` をサポートしなくなるまで、推奨されているストレージドライバでした。しかし、現在の CentOS と RHEL は ``overlay2`` をサポートしており、これが現在推奨されているドライバです。
   * - ``overlay``
     - 過去の ``overlay`` ドライバは、 ``overlay2`` が必要とする「multiple-lowerdir」機能をサポートしていない kernel のために使われました。現在サポートされている Linux ディストリビューションは、この機能をサポートしているため、非推奨です。

.. The Docker Engine has a prioritized list of which storage driver to use if no storage driver is explicitly configured, assuming that the storage driver meets the prerequisites, and automatically selects a compatible storage driver. You can see the order in the source code for Docker Engine 20.10.

Docker Engine は、ストレージ ドライバが明確に設定されていなければ、ストレージ ドライバが要件に合うよう、どれを使うのか優先順位を付けます。そして、互換性のあるストレージ ドライバを自動的に選びます。選ぶ順番は `Docker Engine 20.10 のソースコード <https://github.com/moby/moby/blob/20.10/daemon/graphdriver/driver_linux.go#L52-L53>`_ で見られます。

.. Some storage drivers require you to use a specific format for the backing filesystem. If you have external requirements to use a specific backing filesystem, this may limit your choices. See Supported backing filesystems.

ストレージ ドライバによっては、 :ruby:`基盤ファイルシステム <backing filesystem>` で特定のフォーマットの使用が必要になる場合があります。特定の支援ファイルシステムに外部要件があれば、選択は制限されるかもしれません。 :ref:`サポートしている基盤ファイルシステム <supported-backing-filesystems>` をご覧ください。

.. After you have narrowed down which storage drivers you can choose from, your choice is determined by the characteristics of your workload and the level of stability you need. See Other considerations for help in making the final decision.

どのストレージ ドライバを使うのかを絞り込むのは、 :ruby:`作業負荷 <workload>` の特性と、必要とする安定性を決めた後です。

.. Supported storage drivers per Linux distribution
.. _supported-storage-drivers-per-linux-distribution:
Linux ディストリビューション別のサポート済みドライバ
============================================================

..  Docker Desktop, and Docker in Rootless mode
    Modifying the storage-driver is not supported on Docker Desktop for Mac and Docker Desktop for Windows, and only the default storage driver can be used. The comparison table below is also not applicable for Rootless mode. For the drivers available in rootless mode, see the Rootless mode documentation.

.. note::

   **Docker Desktop と Rootless モードの Docker** 

   Docker Desktop for Mac と Docker Desktop for Windows では、 ストレージ ドライバの変更をサポートしておらず、デフォルトのストレージ ドライバのみ利用できます。以下の表は、 Rootless モードにも適用されません。Rootless モードで利用可能なドライバについては、 :doc:`Rootless モードのドキュメント </engine/security/rootless>` をご覧ください。

.. Your operating system and kernel may not support every storage driver. For instance, aufs is only supported on Ubuntu and Debian, and may require extra packages to be installed, while btrfs is only supported if your system uses btrfs as storage. In general, the following configurations work on recent versions of the Linux distribution:

オペレーティングシステムと kernel によっては、すべてのストレージ ドライバをサポートしていない可能性があります。たとえば、 ``aufs`` は Ubuntu と Debian のみサポートしています。また、 ``btrfs`` をストレージとして使う場合、システムが ``btrfs`` をサポートしていても、追加パッケージが必要になる場合があります。通常、最近の Linux ディストリビューションであれば以下の設定が動作します。

.. list-table::
   :header-rows: 1
   
   * - Linux ディストリビューション
     - 推奨されるストレージ ドライバ
     - 代替ドライバ
   * - Ubuntu
     - ``overlay2``
     - ``overlay`` [#f1]_ 、``devicemapper`` [#f2]_ 、 ``aufs`` [#f3]_ 、 ``zfs`` 、 ``vfs``
   * - Debian
     - ``overlay2``
     - ``overlay`` [#f1]_ 、``devicemapper`` [#f2]_ 、 ``aufs`` [#f3]_ 、 ``vfs``
   * - CentOS
     - ``overlay2``
     - ``overlay`` [#f1]_ 、``devicemapper`` [#f2]_ 、 ``zfs`` 、 ``vfs``
   * - Fedora
     - ``overlay2``
     - ``overlay`` [#f1]_ 、``devicemapper`` [#f2]_ 、 ``zfs`` 、 ``vfs``
   * - SLES 15
     - ``overlay2``
     - ``overlay`` [#f1]_ 、``devicemapper`` [#f2]_ 、 ``vfs``
   * - RHEL
     - ``overlay2``
     - ``overlay`` [#f1]_ 、``devicemapper`` [#f2]_ 、 ``vfs``

.. ¹) The overlay storage driver is deprecated, and will be removed in a future release. It is recommended that users of the overlay storage driver migrate to overlay2.
   ²) The devicemapper storage driver is deprecated, and will be removed in a future release. It is recommended that users of the devicemapper storage driver migrate to overlay2.
   ³) The aufs storage driver is deprecated, and will be removed in a future release. It is recommended that users of the aufs storage driver migrate to overlay2.

.. [#f1] ``overlay`` ストレージ ドライバは非推奨であり、今後のリリースで削除されます。 ``overlay`` ストレージ ドライバの利用者は、 ``overlay2`` への移行を推奨します。
.. [#f2] ``devicemapper`` ストレージ ドライバは非推奨であり、今後のリリースで削除されます。 ``devicemapper`` ストレージ ドライバの利用者は、 ``overlay2`` への移行を推奨します。
.. [#f3] ``aufs`` ストレージ ドライバは非推奨であり、今後のリリースで削除されます。 ``aufs`` ストレージ ドライバの利用者は、 ``overlay2`` への移行を推奨します。

.. When in doubt, the best all-around configuration is to use a modern Linux distribution with a kernel that supports the overlay2 storage driver, and to use Docker volumes for write-heavy workloads instead of relying on writing data to the container’s writable layer.

未確定の場合、あらゆる用途でベストなのは、最近の Linux ディストリビューションと kernel がサポートしている ``overlay2`` ストレージ ドライバを使う設定です。そして、書き込みが多い作業量の場合には、コンテナの書き込み可能なレイヤーに書き込みを依存するのではなく、 Docker ボリュームを使います。

.. The vfs storage driver is usually not the best choice, and primarily intended for debugging purposes in situations where no other storage-driver is supported. Before using the vfs storage driver, be sure to read about its performance and storage characteristics and limitations.

``vfs`` ストレージ ドライバは、通常はベストな選択ではありませんが、他のストレージ ドライバがサポートされていない状況で、主に調査目的として使えます。 ``vfs`` ストレージ ドライバを使う前に、 :doc:`パフォーマンスとストレージの特徴および制限 <vfs-driver>` をご覧ください。

.. The recommendations in the table above are known to work for a large number of users. If you use a recommended configuration and find a reproducible issue, it is likely to be fixed very quickly. If the driver that you want to use is not recommended according to this table, you can run it at your own risk. You can and should still report any issues you run into. However, such issues have a lower priority than issues encountered when using a recommended configuration.

上表での推奨項目は、多くの利用者に役立つと知られています。推奨する設定を使い、再現可能な問題を発見した場合は、素早い修正があるでしょう。この表で推奨されないドライバを使う場合は、自分自身でリスクを負って実行できます。実行にあたり、あらゆる問題は報告されるべきです。しかしながら、推奨される定を使った時に比べて、このような問題解決の優先度は低くなります。

.. Depending on your Linux distribution, other storage-drivers, such as btrfs may be available. These storage drivers can have advantages for specific use-cases, but may require additional set-up or maintenance, which make them not recommended for common scenarios. Refer to the documentation for those storage drivers for details.

Linux ディストリビューションに依存しますが、 ``btrfs`` のようなストレージ ドライバが利用可能な場合があります。これらのストレージドライバは、特定の用途で有利になりますが、通常の利用では推奨されていない追加セットアップやメンテナンスが必要となる場合があります。詳細は、各ストレージ ドライバのドキュメントをご覧ください。

.. Supported backing filesystem
.. _supported-backing-filesystem:
サポートしている基盤ファイルシステム
========================================

.. With regard to Docker, the backing filesystem is the filesystem where /var/lib/docker/ is located. Some storage drivers only work with specific backing filesystems.

Docker は :ruby:`基盤ファイルシステム <backing filesystem>` が、ファイルシステムの ``/var/lib/docker/`` に位置していると想定しています。いくつかのストレージ ドライバは、特定の基盤ファイルシステムでのみ動作します。

.. list-table::
   :header-rows: 1
   
   * - ストレージ ドライバ
     - サポートしている基盤ファイルシステム
   * - ``overlay2`` 、 ``overlay``
     - ``xfs`` で ftype=1 、 ``ext4``
   * - ``fuse-overlayfs``
     - あらゆるファイルシステム
   * - ``aufs``
     - ``xfs`` 、 ``ext4``
   * - ``devicemapper``
     - ``direct-lvm``
   * - ``btrfs``
     - ``btrfs``
   * - ``zfs``
     - ``zfs``
   * - ``vfs``
     - あらゆるファイルシステム

.. Other considerations
.. _other-considerations:
他の検討事項
====================

.. Suitability for your workload
..-_suitability-for-your-workload:
処理内容に適しているかどうか
------------------------------

.. Among other things, each storage driver has its own performance characteristics that make it more or less suitable for different workloads. Consider the following generalizations:

何より、それぞれのストレージドライバは自身の性能上の特徴があり、処理内容が変われば適している場合も、適さない場合もあります。以下のまとめを考えます。

..  overlay2, aufs, and overlay all operate at the file level rather than the block level. This uses memory more efficiently, but the container’s writable layer may grow quite large in write-heavy workloads.
    Block-level storage drivers such as devicemapper, btrfs, and zfs perform better for write-heavy workloads (though not as well as Docker volumes).
    For lots of small writes or containers with many layers or deep filesystems, overlay may perform better than overlay2, but consumes more inodes, which can lead to inode exhaustion.
    btrfs and zfs require a lot of memory.
    zfs is a good choice for high-density workloads such as PaaS.

* ``overlay2`` 、 ``aufs`` 、 ``overlay`` は、全ての処理をブロック単位ではなくファイル単位で行います。これはメモリを効率的に使いますが、書き込みがとても多い処理内容では、コンテナの書き込み可能なレイヤーが肥大化する可能性があります。
* ``devicemapper`` 、 ``btrfs`` 、 ``zfs`` のようなブロック単位のストレージ ドライバは、書き込みが多い処理内容で、良いパフォーマンスです（ Docker ボリュームと同じくらいではありませんが）。
* たくさんの小さな書き込みや、多くのレイヤーがあるコンテナや、階層が深いファイルシステムでは、 ``overalay`` が ``overlay2`` よりパフォーマンスが良いかもしれませんが、多くの inode を消費するため、 inode の肥大化を招く可能性があります。
* ``btrfs`` と ``zfs`` は多くのメモリが必要です。
* ``zfs`` は PaaS のような高密度の処理内容に対し、良い選択です。

.. More information about performance, suitability, and best practices is available in the documentation for each storage driver.

パフォーマンス、安定性、ベストプラクティスに関する詳しい情報は、各ストレージ ドライバのドキュメントをご覧ください。

.. Shared storage systems and the storage driver
.. _shared-storage-systems-and-the-storage-driver:
共有ストレージ システムとストレージドライバ
--------------------------------------------------

.. If your enterprise uses SAN, NAS, hardware RAID, or other shared storage systems, they may provide high availability, increased performance, thin provisioning, deduplication, and compression. In many cases, Docker can work on top of these storage systems, but Docker does not closely integrate with them.

会社で SAN 、 NAS 、 ハードウェア RAID や他の共有ストレージ システムを使っている場合、それらが高可用性、パフォーマンス増加、シン プロビジョニング、冗長化、圧縮といった機能を提供しているかもしれません。多くの場合、これらのストレージ システム上でも Docker は動作します。しかし、 Docker はそれらと密接に統合されてはいません。

.. Each Docker storage driver is based on a Linux filesystem or volume manager. Be sure to follow existing best practices for operating your storage driver (filesystem or volume manager) on top of your shared storage system. For example, if using the ZFS storage driver on top of a shared storage system, be sure to follow best practices for operating ZFS filesystems on top of that specific shared storage system.

それぞれのストレージは、 Linux ファイルシステムやボリューム マネージャに基づいています。共有ファイルシステム上で、操作しようとしているストレージドライバの処理（ファイルシステムや ボリュームマネージャ）に関するベストプラクティスを確実に理解してください。たとえば、共有ファイルシステム上で ZFS ストレージドライバを使う場合、特定の共有ストレージシステム上で ZFS ファイルシステムを扱うベストプラクティスの理解が必要です。


.. Stability
.. _storaget-driver-stability:
安定性
----------

.. For some users, stability is more important than performance. Though Docker considers all of the storage drivers mentioned here to be stable, some are newer and are still under active development. In general, overlay2, aufs, and devicemapper are the choices with the highest stability.

利用者によっては、パフォーマンスよりも安定性の方が重要です。Docker では、ここで言及した全てのストレージ ドライバは安定していると考えており、他にも新しいものや活発な開発下にあるものも安定していると考えています。一般的に、 ``overlay2`` 、 ``aufs`` 、 ``devicemapper`` は高い安定性のために選ばれます。

.. Test with your own workloads
.. _test-with-your-own-workloads:
自分の処理内容をテスト
------------------------------

.. You can test Docker’s performance when running your own workloads on different storage drivers. Make sure to use equivalent hardware and workloads to match production conditions, so you can see which storage driver offers the best overall performance.

異なるストレージ ドライバ上で自身の処理内容を実行する時は、Docker のパフォーマンスをテストできます。同等のハードウェアと本番環境の状況に一致する処理内容で、どのストレージ ドライバが全体的なパフォーマンスがベストかを確認できます。

.. Check your current storage driver
.. _check-your-current-storage-driver:
現在のストレージドライバを確認
==============================

.. The detailed documentation for each individual storage driver details all of the set-up steps to use a given storage driver.

個々のストレージドライバの詳細なドキュメントに、セットアップ手順や捨て緒レージドライバの使い方などの詳細があります。

.. To see what storage driver Docker is currently using, use docker info and look for the Storage Driver line:

Docker が現在どのストレージ ドライバを使っているか確認するには、 ``docker info`` を使い、 ``Storage Driver`` の行を探します。

.. code-block:: bash

   $ docker info
   
   Containers: 0
   Images: 0
   Storage Driver: overlay2
    Backing Filesystem: xfs
   <...>

.. To change the storage driver, see the specific instructions for the new storage driver. Some drivers require additional configuration, including configuration to physical or logical disks on the Docker host.

ストレージ ドライバを変更するには、新しいストレージ ドライバの個々の手順を確認します。ドライバによっては、Docker ホスト上の物理ディスクもしくは論理ディスクの設定を含む、追加の設定を必要とします。

..  Important
    When you change the storage driver, any existing images and containers become inaccessible. This is because their layers cannot be used by the new storage driver. If you revert your changes, you can access the old images and containers again, but any that you pulled or created using the new driver are then inaccessible.

.. important::

   ストレージ ドライバを変更すると、あらゆる既存のイメージとコンテナにアクセスできなくなります。これは、それらのレイヤーが新しいストレージ ドライバでは使えないためです。変更を戻せば、再び以前のイメージとコンテナにアクセスできますが、新しいドライバで取得または作成したイメージやコンテナには、アクセスできなくなります。

.. Related information
関連情報
==========

..    About images, containers, and storage drivers
    aufs storage driver in practice
    devicemapper storage driver in practice
    overlay and overlay2 storage drivers in practice
    btrfs storage driver in practice
    zfs storage driver in practice

* :doc:`イメージ、コンテナ、ストレージ ドライバについて <index>`
* :doc:`aufs ストレージ ドライバ <aufs-driver>` 
* :doc:`devicemapper ストレージ ドライバ <device-mapper-driver>` 
* :doc:`overlay および overlay2 ストレージ ドライバ <overlayfs-driver>` 
* :doc:`btrfs ストレージ ドライバ <btrfs-driver>` 
* :doc:`zfs ストレージ ドライバ <zfs-driver>` 


.. seealso:: 

   Select a storage driver
      https://docs.docker.com/engine/userguide/storagedriver/selectadriver/
