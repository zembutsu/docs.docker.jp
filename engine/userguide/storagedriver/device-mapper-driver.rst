.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/userguide/storagedriver/device-mapper-driver/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/userguide/storagedriver/device-mapper-driver.md
   doc version: 1.10
      https://github.com/docker/docker/commits/master/docs/userguide/storagedriver/device-mapper-driver.md
.. check date: 2016/02/12
.. ---------------------------------------------------------------------------

.. Docker and the Device Mapper storage driver

.. _docker-and-device-mapper-storage-driver:

========================================
Device Mapper ストレージ・ドライバを使う
========================================

.. Device Mapper is a kernel-based framework that underpins many advanced volume management technologies on Linux. Docker’s devicemapper storage driver leverages the thin provisioning and snapshotting capabilities of this framework for image and container management. This article refers to the Device Mapper storage driver as devicemapper, and the kernel framework as Device Mapper.

Device Mapper は、Linux 上で多くの高度なボリューム管理技術を支えるカーネル・ベースのフレームワークです。Docker の ``devicemapper`` ストレージ・ドライバは、シン・プロビジョニングとスナップショット機能のために、イメージとコンテナ管理にこのフレームワークを活用します。この記事では、Device Mapper ストレージ・ドライバを ``devicemapper`` とし、カーネルのフレームワークを ``Device Mapper`` として言及します。

..     Note: The Commercially Supported Docker Engine (CS-Engine) running on RHEL and CentOS Linux requires that you use the devicemapper storage driver.

.. note::

   ``devicemapper`` ストレージ・ドライバを使うには、 `RHEL か CentOS Linux 上で商用サポート版 Docker Engine (CS-Engine) を実行 <https://www.docker.com/compatibility-maintenance>`_ する必要があります。

.. An alternative to AUFS

.. _an-alternative-to-aufs:

AUFS の代替
====================

.. Docker originally ran on Ubuntu and Debian Linux and used AUFS for its storage backend. As Docker became popular, many of the companies that wanted to use it were using Red Hat Enterprise Linux (RHEL). Unfortunately, because the upstream mainline Linux kernel did not include AUFS, RHEL did not use AUFS either.

当初の Docker は、Ubuntu と Debian Linux 上で AUFS をストレージのバックエンドに使っていました。Docker が有名になるにつれ、多くの会社が Red Hat Enterprise Linux 上で使いたいと考え始めました。残念ながら、AUFS は Linux カーネル上流のメインラインではないため、RHEL では AUFS を扱いませんでした。

.. To correct this Red Hat developers investigated getting AUFS into the mainline kernel. Ultimately, though, they decided a better idea was to develop a new storage backend. Moreover, they would base this new storage backend on existing Device Mapper technology.

この状況を変えるべく、Red Hat の開発者達が AUFS をカーネルのメインラインに入れられるよう取り組みました。しかしながら、新しいストレージ・バックエンドを開発するの方が良い考えであると決断したのです。さらに、ストレージのバックエンドには、既に存在していた ``Device Mapper`` 技術を基盤とすることにしました。

.. Red Hat collaborated with Docker Inc. to contribute this new driver. As a result of this collaboration, Docker’s Engine was re-engineered to make the storage backend pluggable. So it was that the devicemapper became the second storage driver Docker supported.

Red Hat は Docker 社と協同で新しいドライバの開発に取り組みました。この協調の結果、ストレージ・バックエンドの取り付け・取り外し可能な（pluggable）Docker エンジンが再設計されました。そして、 ``devicemapper`` は Docker がサポートする2番目のストレージ・ドライバとなったのです。

.. Device Mapper has been included in the mainline Linux kernel since version 2.6.9. It is a core part of RHEL family of Linux distributions. This means that the devicemapper storage driver is based on stable code that has a lot of real-world production deployments and strong community support.

Device Mapper は Linux カーネルのバージョン 2.6.9 以降、メインラインに組み込まれました。これは、RHEL ファミリーの Linux ディストリビューションの中心部です。つまり、 ``devicemapper`` ストレージ・ドライバは安定したコードを基盤としており、現実世界における多くのプロダクションへのデプロイや、強力なコミュニティのサポートをもたらします。

.. Image layering and sharing

.. _devicemapper-image-layering-and-sharing:

イメージのレイヤ化と共有
==============================

.. The devicemapper driver stores every image and container on its own virtual device. These devices are thin-provisioned copy-on-write snapshot devices. Device Mapper technology works at the block level rather than the file level. This means that devicemapper storage driver’s thin provisioning and copy-on-write operations work with blocks rather than entire files.

``devicemapper`` ドライバは、全てのイメージとコンテナを自身の仮想デバイスに保管します。これらのデバイスとは、シン・プロビジョニングされ、コピー・オン・ライト可能であり、スナップショットのデバイスです。Device Mapper 技術はファイル・レベルというよりブロック・レベルで動作します。つまり、 ``devicemapper`` ストレージ・ドライバのシン・プロビジョニング（thin-provisioning）とコピー・オン・ライト（copy-on-write）処理は、ファイルではなくブロックに対して行われます。

..    Note: Snapshots are also referred to as thin devices or virtual devices. They all mean the same thing in the context of the devicemapper storage driver.

.. note::

   また、スナップショットは *シン・デバイス（thin device）* や *仮想デバイス（virtual device）* としても参照されます。つまり、 ``devicemapper`` ストレージ・ドライバにおいては、どれも同じものを意味します。

.. With devicemapper the high level process for creating images is as follows:

``devicemapper`` でイメージを作るハイレベルな手順は、以下の通りです。

..    The devicemapper storage driver creates a thin pool.

1. ``devicemapper`` ストレージ・ドライバはシン・プール（thin pool）を作成します。

..    The pool is created from block devices or loop mounted sparse files (more on this later).

ブロック・デバイスかループ用にマウントされた薄いファイル（sparse files）上に、このプールが作成されます。

..    Next it creates a base device.

2. 次に *ベース・デバイス（base device）* を作成します。

..    A base device is a thin device with a filesystem. You can see which filesystem is in use by running the docker info command and checking the Backing filesystem value.

ベース・デバイスとは、ファイルシステムのシン・デバイス（thin device）です。どのファイルシステムが使われているかを調べるには、 ``docker info`` コマンドを実行し、 ``Backing filesystem`` 値を確認します。

..    Each new image (and image layer) is a snapshot of this base device.

3. それぞれの新しいイメージ（とイメージ・レイヤ）は、このベース・デバイスのスナップショットです。

..    These are thin provisioned copy-on-write snapshots. This means that they are initially empty and only consume space from the pool when data is written to them.

これらがシン・プロビジョニングされたコピー・オン・ライトなスナップショットです。つまり、これらは初期状態では空っぽですが、データが書き込まれるときだけ容量を使います。

.. With devicemapper, container layers are snapshots of the image they are created from. Just as with images, container snapshots are thin provisioned copy-on-write snapshots. The container snapshot stores all updates to the container. The devicemapper allocates space to them on-demand from the pool as and when data is written to the container.

``devicemapper`` では、ここで作成されたイメージのスナップショットが、コンテナ・レイヤになります。イメージと同様に、コンテナのスナップショットも、シン・プロビジョニングされたコピー・オン・ライトなスナップショットです。コンテナのスナップショットに、コンテナ上での全ての変更が保管されます。 ``devicemapper`` は、コンテナに対してデータを書き込むとき、このプールから必要に応じて領域を割り当てます。

.. The high level diagram below shows a thin pool with a base device and two images.

以下のハイレベルな図は、ベース・デバイスのシン・プールと２つのイメージを表します。

.. image:: ./images/base-device.png
   :scale: 60%
   :alt: ベース・デバイス

.. If you look closely at the diagram you’ll see that it’s snapshots all the way down. Each image layer is a snapshot of the layer below it. The lowest layer of each image is a snapshot of the the base device that exists in the pool. This base device is a Device Mapper artifact and not a Docker image layer.

細かく図をみていくと、スナップショットは全体的に下っているのが分かるでしょう。各イメージ・レイヤは下にあるレイヤのスナップショットです。各イメージの最も下にあるレイヤは、プール上に存在するベース・デバイスのスナップショットです。このベース・デバイスとは ``Device Mapper`` のアーティファクト（成果物）であり、Docker イメージ・レイヤではありません。

.. A container is a snapshot of the image it is created from. The diagram below shows two containers - one based on the Ubuntu image and the other based on the Busybox image.

コンテナは、ここから作成されたイメージのスナップショットです。下図は２つのコンテナです。一方がベースにしているのは Ubuntu イメージであり、もう一方は Busybox イメージをベースにしています。

.. image:: ./images/two-dm-container.png
   :scale: 60%
   :alt: ２つの Device Mapper 上のコンテナ


.. Reads with the devicemapper

.. _reads-with-the-devicemapper:

devicemapper からの読み込み
==============================

.. Let’s look at how reads and writes occur using the devicemapper storage driver. The diagram below shows the high level process for reading a single block (0x44f) in an example container.

``devicemapper`` ストレージ・ドライバが、どのように読み書きしているか見ていきましょう。下図は、サンプル・コンテナが単一のブロック（ ``0x44f`` ）を読み込むという、ハイレベルな手順です。

.. image:: ./images/dm-container.png
   :scale: 60%
   :alt: Device Mapper 上のコンテナ

..    An application makes a read request for block 0x44f in the container.

1. アプリケーションがコンテナ内のブロック ``0x44f`` に対して読み込みを要求します。

..    Because the container is a thin snapshot of an image it does not have the data. Instead, it has a pointer (PTR) to where the data is stored in the image snapshot lower down in the image stack.

コンテナは、イメージの薄い（thin）スナップショットであり、データを持っていません。その代わりに、下層のイメージ層（スタック）にあるイメージのスナップショット上の、どこにデータが保管されているかを示すポインタ（PTR）を持っています。

..    The storage driver follows the pointer to block 0xf33 in the snapshot relating to image layer a005....

2. ストレージ・ドライバは、スナップショットのブロック ``0xf33`` と関連するイメージ・レイヤ ``a005...`` のポインタを探します。

..    The devicemapper copies the contents of block 0xf33 from the image snapshot to memory in the container.

3. ``devicemapper`` はブロック ``0xf33`` の内容を、イメージのスナップショットからコンテナのメモリ上にコピーします。

..    The storage driver returns the data to the requesting application.

4. ストレージ・ドライバはアプリケーションがリクエストしたデータを返します。

.. Write examples

書き込み例
----------

.. With the devicemapper driver, writing new data to a container is accomplish..ed by an allocate-on-demand operation. Updating existing data uses a copy-on-write operation. Because Device Mapper is a block-based technology these operations occur at the block level.

``devicemapper`` ドライバで新しいデータをコンテナに書き込むには、*オンデマンドの割り当て（allocate-on-demand）* を行います。コピー・オン・ライト処理をによって、既存のデータを更新します。Device Mapper はブロック・ベースの技術のため、これらの処理はブロック・レベルで行われます。

.. For example, when making a small change to a large file in a container, the devicemapper storage driver does not copy the entire file. It only copies the blocks to be modified. Each block is 64KB.

例えば、コンテナ内の大きなファイルに小さな変更を加えるとき、 ``devicemapper`` ストレージ・ドライバはファイル全体コピーをコピーしません。コピーするのは、変更するブロックのみです。各ブロックは 64KB です。

.. Writing new data

.. _devicemapper-writing-new-data:

新しいデータの書き込み
------------------------------

.. To write 56KB of new data to a container:

コンテナに 56KB の新しいデータを書き込みます。

..    An application makes a request to write 56KB of new data to the container.

1. アプリケーションはコンテナに 56KB の新しいデータの書き込みを要求します。

..    The allocate-on-demand operation allocates a single new 64KB block to the containers snapshot.

2. オンデマンドの割り当て処理により、コンテナのスナップショットに対して、新しい 64KB のブロックが１つ割り当てられます。

..    If the write operation is larger than 64KB, multiple new blocks are allocated to the container snapshot.

書き込み対象が 64KB よりも大きければ、複数の新しいブロックがコンテナに対して割り当てられます。

..    The data is written to the newly allocated block.

3. 新しく割り当てられたブロックにデータを書き込みます。

.. Overwriting existing data

.. _devicemapper-overwriting-existing-data:

既存のデータを上書き
------------------------------

.. To modify existing data for the first time:

既存のデータに対して初めて変更を加える場合、

..    An application makes a request to modify some data in the container.

1. アプリケーションはコンテナ上にあるデータの変更を要求します。

..    A copy-on-write operation locates the blocks that need updating.

2. 更新が必要なブロックに対して、コピー・オン・ライト処理が行われます。

..    The operation allocates new empty blocks to the container snapshot and copies the data into those blocks.

3. 処理によって新しい空のブロックがコンテナのスナップショットに割り当てられ、そのブロックにデータがコピーされます。

..    The modified data is written into the newly allocated blocks.

3. 新しく割り当てられたブロックの中に、変更したデータを書き込みます。

.. The application in the container is unaware of any of these allocate-on-demand and copy-on-write operations. However, they may add latency to the application’s read and write operations.

コンテナ内のアプリケーションは、必要に応じた割り当てやコピー・オン・ライト処理を意識しません。しかしながら、アプリケーションの読み書き処理において、待ち時間を増やすでしょう。

.. Configuring Docker with Device Mapper

.. _configuring-docker-with-device-mapper:

Device Mapper を Docker を使う設定
========================================

.. The devicemapper is the default Docker storage driver on some Linux distributions. This includes RHEL and most of its forks. Currently, the following distributions support the driver:

複数のディストリビューションにおいて、``devicemapper`` は標準の Docker ストレージ・ドライバです。ディストリビューションはRHEL や派生したものが含まれます。現時点では、以下のディストリビューションがドライバをサポートしています。

* RHEL/CentOS/Fedora
* Ubuntu 12.04
* Ubuntu 14.04
* Debian

.. Docker hosts running the devicemapper storage driver default to a configuration mode known as loop-lvm. This mode uses sparse files to build the thin pool used by image and container snapshots. The mode is designed to work out-of-the-box with no additional configuration. However, production deployments should not run under loop-lvm mode.

Docker ホストは ``devicemapper`` ストレージ・ドライバを、デフォルトでは ``loop-lvm`` というモードで設定します。このモードは、イメージとコンテナのスナップショットが使うシン・プール（thin pool）を構築するために、スパース・ファイル（sparse file；まばらなファイル）を使う指定です。このモードは、設定に変更を加えることなく、革新的な動きをするように設計されています。しかしながら、プロダクションへのデプロイでは、 ``loop-lvm`` モードの下で実行すべきではありません。

.. You can detect the mode by viewing the docker info command:

どのようなモードで動作しているか確認するには ``docker info`` コマンドを使います。

.. code-block:: bash

   $ sudo docker info
   Containers: 0
   Images: 0
   Storage Driver: devicemapper
    Pool Name: docker-202:2-25220302-pool
    Pool Blocksize: 65.54 kB
    Backing Filesystem: xfs
    ...
    Data loop file: /var/lib/docker/devicemapper/devicemapper/data
    Metadata loop file: /var/lib/docker/devicemapper/devicemapper/metadata
    Library Version: 1.02.93-RHEL7 (2015-01-28)
    ...

.. The output above shows a Docker host running with the devicemapper storage driver operating in loop-lvm mode. This is indicated by the fact that the Data loop file and a Metadata loop file are on files under /var/lib/docker/devicemapper/devicemapper. These are loopback mounted sparse files.

この実行結果から、Docker ホストは ``devicemapper`` ストレージ・ドライバの操作に ``loop-lvm`` モードを使っているのが分かります。実際には、 ``データ・ループ・ファイル (data loop file)`` と ``メタデータ・ループ・ファイル (Metadata loop file)`` のファイルが ``/var/lib/docker/devicemapper/devicemapper`` 配下にあるのを意味します。これらがループバックにマウントされているパース・ファイルです。

.. Configure direct-lvm mode for production

.. _configure-direct-lvm-mode-for-production:

プロダクション用に direct-lvm モードを設定
--------------------------------------------------

.. The preferred configuration for production deployments is direct lvm. This mode uses block devices to create the thin pool. The following procedure shows you how to configure a Docker host to use the devicemapper storage driver in a direct-lvm configuration.

プロダクションへのデプロイに適した設定は ``direct lvm`` です。このモードはシン・プールの作成にブロック・デバイスを使います。以下の手順は、Docker ホストが ``devicemapper`` ストレージ・ドライバを ``direct-lvm`` 設定を使えるようにします。

..    Caution: If you have already run the Docker daemon on your Docker host and have images you want to keep, push them Docker Hub or your private Docker Trusted Registry before attempting this procedure.

.. caution::

  既に Docker ホスト上で Docker デーモンを使っている場合は、イメージを維持する必要がありますので、処理を進める前に、それらのイメージを Docker Hub やプライベート Docker Trusted Registry に ``push`` しておきます。

.. The procedure below will create a 90GB data volume and 4GB metadata volume to use as backing for the storage pool. It assumes that you have a spare block device at /dev/xvdf with enough free space to complete the task. The device identifier and volume sizes may be be different in your environment and you should substitute your own values throughout the procedure. The procedure also assumes that the Docker daemon is in the stopped state.

以下の手順は 90GB のデータ・ボリュームと 4GB のメタデータ・ボリュームを作成し、ストレージ・プールの基礎として使います。ここでは別のブロック・デバイス ``/dev/xvdf`` を持っており、処理するための十分な空き容量があると想定しています。デバイスの識別子とボリューム・サイズは皆さんの環境とは異なるかもしれません。手順を勧めるときは、自分の環境にあわせて適切に置き換えてください。また、手順は Docker デーモンが ``stop`` （停止）した状態から始めることを想定しています。

..    Log in to the Docker host you want to configure and stop the Docker daemon.

1. Docker ホストにログインし、設定対象の Docker デーモンを停止します。

..    If it exists, delete your existing image store by removing the /var/lib/docker directory.

2. 終了したら、 ``/var/lib/docker`` ディレクトリに保管されている既存のイメージを削除します。

.. code-block:: bash

   $ sudo rm -rf /var/lib/docker

..    Create an LVM physical volume (PV) on your spare block device using the pvcreate command.

3. もう１つのブロックデバイス上で ``pvcreate`` コマンドを使い、 LVM 物理ボリューム（PV; Physical Volume）を作成します。

.. code-block:: bash

   $ sudo pvcreate /dev/xvdf
   Physical volume `/dev/xvdf` successfully created

..    The device identifier may be different on your system. Remember to substitute your value in the command above.

このデバイス識別子は、皆さんの環境によって異なります。このコマンドを実行する時は、適切な値に書き換えてください。

..    Create a new volume group (VG) called vg-docker using the PV created in the previous step.

4. 先の手順で作成した物理ボリュームを使い、 ``vg-docker`` という名称の新しいボリューム・グループ（VG; Volume Group）を作成します。

.. code-block:: bash

   $ sudo vgcreate vg-docker /dev/xvdf
   Volume group `vg-docker` successfully created

..    Create a new 90GB logical volume (LV) called data from space in the vg-docker volume group.

5. ``vg-docker`` ボリューム・グループ上の領域に、 ``data``  という名所の新しい 90GB の論理ボリューム（LV; Logical Volume）を作成します。

.. code-block:: bash

   $ sudo lvcreate -L 90G -n data vg-docker
   Logical volume `data` created.

..    The command creates an LVM logical volume called data and an associated block device file at /dev/vg-docker/data. In a later step, you instruct the devicemapper storage driver to use this block device to store image and container data.

このコマンドは ``data`` と呼ばれる LVM 論理ボリュームを作成し、 ``/dev/vg-docker/data`` にであるブロック・デバイス・ファイルに関連づけます。後の手順で、 ``devicemapper`` ストレージ・ドライバがこのブロックデバイスを使い、イメージやコンテナのデータを保管するように指示します。

..    If you receive a signature detection warning, make sure you are working on the correct devices before continuing. Signature warnings indicate that the device you’re working on is currently in use by LVM or has been used by LVM in the past.

署名に関する警告が表示される場合は、作業を続ける前に、正しいデバイスが動作しているかどうか確認します。署名の警告が意味するのは、作業対象が LVM によって既に使われているか、あるいは過去に使われていたかです。

..    Create a new logical volume (LV) called metadata from space in the vg-docker volume group.

6. ``vg-docker`` ボリューム・グループ上の領域に、 ``metadata`` と呼ばれる新しい論議ボリューム(LV)を作成します。

.. code-block:: bash

   $ sudo lvcreate -L 4G -n metadata vg-docker
   Logical volume `metadata` created.

..    This creates an LVM logical volume called metadata and an associated block device file at /dev/vg-docker/metadata. In the next step you instruct the devicemapper storage driver to use this block device to store image and container metadata.

これは ``metadata`` という名称の LVM 論理ボリュームを作成し、 ``/dev/vg-docker/metadata`` にあるブロック・デバイス・ファイルに関連づけられます。次のステップで、  ``devicemapper`` ストレージ・ドライバがこのブロックデバイスを使い、イメージやコンテナのデータを保管するように指示します。

..    Start the Docker daemon with the devicemapper storage driver and the --storage-opt flags.

7. Docker デーモンが ``devicemapper`` ストレージ・ドライバを使って起動するため、 ``--storage-opt`` フラグを使います。

..    The data and metadata devices that you pass to the --storage-opt options were created in the previous steps.

先ほどの手順で作成した ``data`` と ``metadata`` デバイスを ``--storage-opt`` オプションで指定します。

.. code-block:: bash

     $ sudo docker daemon --storage-driver=devicemapper --storage-opt dm.datadev=/dev/vg-docker/data --storage-opt dm.metadatadev=/dev/vg-docker/metadata &
     [1] 2163
     [root@ip-10-0-0-75 centos]# INFO[0000] Listening for HTTP on unix (/var/run/docker.sock)
     INFO[0027] Option DefaultDriver: bridge
     INFO[0027] Option DefaultNetwork: bridge
     <出力を省略>
     INFO[0027] Daemon has completed initialization
     INFO[0027] Docker daemon commit=0a8c2e3 execdriver=native-0.2 graphdriver=devicemapper version=1.8.2

..    It is also possible to set the --storage-driver and --storage-opt flags in the Docker config file and start the daemon normally using the service or systemd commands.

また、 ``--storage-driver`` と ``--storage-opt`` フラグは Docker の設定ファイルか、デーモンの起動に使う ``service`` や ``systemd`` コマンドでも指定できます。

..    Use the docker info command to verify that the daemon is using data and metadata devices you created.

8. ``docker info`` コマンドを使い、デーモンが先ほど作成した ``data`` と ``metadata`` デバイスが使われていることを確認します。

.. code-block:: bash

   $ sudo docker info
   INFO[0180] GET /v1.20/info
   Containers: 0
   Images: 0
   Storage Driver: devicemapper
    Pool Name: docker-202:1-1032-pool
    Pool Blocksize: 65.54 kB
    Backing Filesystem: xfs
    Data file: /dev/vg-docker/data
    Metadata file: /dev/vg-docker/metadata
   [...]

..    The output of the command above shows the storage driver as devicemapper. The last two lines also confirm that the correct devices are being used for the Data file and the Metadata file.

このコマンドの出力から、ストレージ・ドライバが ``devicemapper`` であることが分かります。最後の２行から、適切なデバイスが ``Datafile`` と ``Metadata file`` を使っていることも分かります。

.. Examine devicemapper structures on the host

.. _examine-devicemapper-structure-on-the-host:

ホスト上の devicemapper 構造の例
----------------------------------------

.. You can use the lsblk command to see the device files created above and the pool that the devicemapper storage driver creates on top of them.

``lsblk`` コマンドを使うと、先ほど作成したデバイス・ファイルと、その上に ``devicemapper`` ストレージ・ドライバによって作られた ``pool`` （プール）を確認できます。

.. code-block:: bash

   $ sudo lsblk
   NAME                       MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
   xvda                       202:0    0    8G  0 disk
   └─xvda1                    202:1    0    8G  0 part /
   xvdf                       202:80   0   10G  0 disk
   ├─vg--docker-data          253:0    0   90G  0 lvm
   │ └─docker-202:1-1032-pool 253:2    0   10G  0 dm
   └─vg--docker-metadata      253:1    0    4G  0 lvm
     └─docker-202:1-1032-pool 253:2    0   10G  0 dm
  
.. The diagram below shows the image from prior examples updated with the detail from the lsblk command above.

下図は、先ほどの例で使ったイメージの更新を、 ``lsblk`` コマンドの詳細で表しています。

.. image:: ./images/devicemapper-pool.png
   :scale: 60%
   :alt: ディスク構造上のイメージ

.. In the diagram, the pool is named Docker-202:1-1032-pool and spans the data and metadata devices created earlier. The devicemapper constructs the pool name as follows:

この図では、プールは ``Docker-202:1-1032-pool`` と名付けられ、先ほど作成した ``data`` と ``metadata`` デバイスに渡っています。この ``devicemapper`` のプール名は、次のような形式です。

.. code-block:: bash

   Docker-MAJ:MIN-INO-pool

.. MAJ, MIN and INO refer to the major and minor device numbers and inode.

``MAJ`` 、 ``NIN`` 、 ``INO`` は、デバイスのメジャー番号、マイナー番号、inode 番号です。

.. Because Device Mapper operates at the block level it is more difficult to see diffs between image layers and containers. However, there are two key directories. The /var/lib/docker/devicemapper/mnt directory contains the mount points for images and containers. The /var/lib/docker/devicemapper/metadata directory contains one file for every image and container snapshot. The files contain metadata about each snapshot in JSON format.

Device Mapper はブロック・レベルで処理を行うため、イメージ・レイヤとコンテナ間の差分を見るのは、少し大変です。しかしながら、２つの鍵となるディレクトリがあります。 ``/var/lib/docker/devicemapper/mnt`` ディレクトリには、イメージとコンテナのマウント・ポントがあります。 ``/var/lib/docker/devicemapper/metadata`` ディレクトリには、それぞれのイメージとコンテナのスナップショットを格納する１つのファイルがあります。このファイルには、各スナップショットのメタデータが JSON 形式で含まれています。

.. Device Mapper and Docker performance

.. _device-mapper-and-docker-performance:

Device Mapper と Docker 性能
==============================

.. It is important to understand the impact that allocate-on-demand and copy-on-write operations can have on overall container performance.

重要なのは、オンデマンドの割り当て（allocate-on-demand）とコピー・オン・ライト（copy-on-write）処理が、コンテナ全体の性能に対して影響があるのを理解することです。

.. Allocate-on-demand performance impact

.. _allocate-on-demand-performance-impact:

オンデマンドの割り当てが性能に与える影響
----------------------------------------

.. The devicemapper storage driver allocates new blocks to a container via an allocate-on-demand operation. This means that each time an app writes to somewhere new inside a container, one or more empty blocks has to be located from the pool and mapped into the container.

``devicemapper`` ストレージ・ドライバは、オンデマンドの割り当て処理時、コンテナに対して新しいブロックを割り当てます。この処理が意味するのは、コンテナの中でアプリケーションが何かを書き込みをするごとに、プールから１つまたは複数の空ブロックを探し、コンテナの中に割り当てます。

.. All blocks are 64KB. A write that uses less than 64KB still results in a single 64KB block being allocated. Writing more than 64KB of data uses multiple 64KB blocks. This can impact container performance, especially in containers that perform lots of small writes. However, once a block is allocated to a container subsequent reads and writes can operate directly on that block.

全てのブロックは 64KB です。64KB より小さな書き込みの場合でも、64Kb のブロックが１つ割り当てられます。これがコンテナの性能に影響を与えます。特にコンテナ内で多数の小さなファイルを書き込む場合に影響があるでしょう。しかしながら、一度ブロックがコンテナに対して割り当てらたら、以降の読み込みは対象のブロックを直接処理できます。

.. Copy-on-write performance impact

.. _copy-on-write-performance-impact:

コピー・オン・ライトが性能に与える影響
----------------------------------------

.. Each time a container updates existing data for the first time, the devicemapper storage driver has to perform a copy-on-write operation. This copies the data from the image snapshot to the container’s snapshot. This process can have a noticeable impact on container performance.

コンテナ内のデータを初めて更新するたびに、毎回 ``devicemapper`` ストレージ・ドライバがコピー・オン・ライト処理を行います。このコピーとは、イメージのスナップショット上のデータを、コンテナのスナップショットにコピーするものです。この処理が、コンテナの性能に対して留意すべき影響を与えます。

.. All copy-on-write operations have a 64KB granularity. As a results, updating 32KB of a 1GB file causes the driver to copy a single 64KB block into the container’s snapshot. This has obvious performance advantages over file-level copy-on-write operations which would require copying the entire 1GB file into the container layer.

コピー・オン・ライト処理は 64KB 単位で行われます。そのため、1GB のファイルのうち 32KB を更新する場合は、コンテナのスナップショット内にある 64KB のブロックをコピーします。これはファイル・レベルのコピー・オン・ライト処理に比べて、著しい性能をもたらします。ファイルレベルであれば、コンテナ・レイヤに含まれる 1GB のファイル全体をコピーする必要があるからです。

.. In practice, however, containers that perform lots of small block writes (<64KB) can perform worse with devicemapper than with AUFS.

しかしながら、現実的には、コンテナが多くの小さなブロック（64KB以下）に書き込みをするのであれば、 ``devicemapper`` は AUFS を使うよりも性能が劣ります。

.. Other device mapper performance considerations

.. _other-device-mapper-performance-consideration:

Device Mapper の性能に対するその他の考慮
----------------------------------------

.. There are several other things that impact the performance of the devicemapper storage driver..

``devicemapper`` ストレージ・ドライバの性能に対して、他にもいくつかの影響を与える要素があります。

..    The mode. The default mode for Docker running the devicemapper storage driver is loop-lvm. This mode uses sparse files and suffers from poor performance. It is not recommended for production. The recommended mode for production environments is direct-lvm where the storage driver writes directly to raw block devices.

* **モード** ：Docker が ``devicemapper`` ストレージ・ドライバを使用する時、デフォルトのモードは ``loop-lvm`` です。このモードはスパース・ファイル（space files；薄いファイル）を使うので、性能を損ないます。そのため、 **プロダクションへのデプロイでは推奨されません** 。プロダクション環境で推奨されるモードは ``direct-lvm`` です。これはストレージ・ドライバが直接 raw ブロック・デバイスに書き込みます。

..    High speed storage. For best performance you should place the Data file and Metadata file on high speed storage such as SSD. This can be direct attached storage or from a SAN or NAS array.

* **高速なストレージ** ：ベストな性能を出すためには、 ``データ・ファイル`` と ``メタデータ・ファイル`` を、 SSD のような高速なストレージ上に配置すべきです。あるいは、 SAN や NAS アレイといった、ダイレクト・アタッチ・ストレージでも同様でしょう。

..    Memory usage. devicemapper is not the most memory efficient Docker storage driver. Launching n copies of the same container loads n copies of its files into memory. This can have a memory impact on your Docker host. As a result, the devicemapper storage driver may not be the best choice for PaaS and other high density use cases.

* **メモリ使用量** ： ``devicemapper`` は Docker ストレージ・ドライバのなかで、最も悪いメモリ使用効率です。同じコンテナのｎ個のコピーを起動するとき、ｎ個のファイルをメモリ上にコピーします。これは、Docker ホスト上のメモリに対して影響があります。このため、 PaaS や他の高密度な用途には、``devicemapper`` ストレージ・ドライバがベストな選択肢とは言えません。

.. One final point, data volumes provide the best and most predictable performance. This is because they bypass the storage driver and do not incur any of the potential overheads introduced by thin provisioning and copy-on-write. For this reason, you may want to place heavy write workloads on data volumes.

最後に１点、データ・ボリュームは最上かつ最も予測可能な性能を提供します。これは、ストレージ・ドライバを迂回し、シン・プロビジョニングやコピー・オン・ライト処理を行わないためです。そのため、データ・ボリューム上で重たい書き込みを行うのに適しています。

.. Related Information

関連情報
==========

..    Understand images, containers, and storage drivers
    Select a storage driver
    AUFS storage driver in practice
    Btrfs storage driver in practice

* :doc:`imagesandcontainers`
* :doc:`selectadriver`
* :doc:`aufs-driver`
* :doc:`btrfs-driver`
