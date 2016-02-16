.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/daemon/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/daemon.md
   doc version: 1.10
      https://github.com/docker/docker/commits/master/docs/reference/commandline/daemon.md
.. check date: 2016/02/16
.. -------------------------------------------------------------------

.. daemon

=======================================
daemon
=======================================

.. code-block:: bash

   Usage: docker daemon [OPTIONS]
   
   A self-sufficient runtime for linux containers.
   
   Options:
     --api-cors-header=""                   Set CORS headers in the remote API
     --authorization-plugin=[]              Set authorization plugins to load
     -b, --bridge=""                        Attach containers to a network bridge
     --bip=""                               Specify network bridge IP
     --cgroup-parent=                       Set parent cgroup for all containers
     -D, --debug                            Enable debug mode
     --default-gateway=""                   Container default gateway IPv4 address
     --default-gateway-v6=""                Container default gateway IPv6 address
     --cluster-store=""                     URL of the distributed storage backend
     --cluster-advertise=""                 Address of the daemon instance on the cluster
     --cluster-store-opt=map[]              Set cluster options
     --config-file=/etc/docker/daemon.json  Daemon configuration file
     --dns=[]                               DNS server to use
     --dns-opt=[]                           DNS options to use
     --dns-search=[]                        DNS search domains to use
     --default-ulimit=[]                    Set default ulimit settings for containers
     --exec-opt=[]                          Set exec driver options
     --exec-root="/var/run/docker"          Root of the Docker execdriver
     --fixed-cidr=""                        IPv4 subnet for fixed IPs
     --fixed-cidr-v6=""                     IPv6 subnet for fixed IPs
     -G, --group="docker"                   Group for the unix socket
     -g, --graph="/var/lib/docker"          Root of the Docker runtime
     -H, --host=[]                          Daemon socket(s) to connect to
     --help                                 Print usage
     --icc=true                             Enable inter-container communication
     --insecure-registry=[]                 Enable insecure registry communication
     --ip=0.0.0.0                           Default IP when binding container ports
     --ip-forward=true                      Enable net.ipv4.ip_forward
     --ip-masq=true                         Enable IP masquerading
     --iptables=true                        Enable addition of iptables rules
     --ipv6                                 Enable IPv6 networking
     -l, --log-level="info"                 Set the logging level
     --label=[]                             Set key=value labels to the daemon
     --log-driver="json-file"               Default driver for container logs
     --log-opt=[]                           Log driver specific options
     --mtu=0                                Set the containers network MTU
     --disable-legacy-registry              Do not contact legacy registries
     -p, --pidfile="/var/run/docker.pid"    Path to use for daemon PID file
     --registry-mirror=[]                   Preferred Docker registry mirror
     -s, --storage-driver=""                Storage driver to use
     --selinux-enabled                      Enable selinux support
     --storage-opt=[]                       Set storage driver options
     --tls                                  Use TLS; implied by --tlsverify
     --tlscacert="~/.docker/ca.pem"         Trust certs signed only by this CA
     --tlscert="~/.docker/cert.pem"         Path to TLS certificate file
     --tlskey="~/.docker/key.pem"           Path to TLS key file
     --tlsverify                            Use TLS and verify the remote
     --userns-remap="default"               Enable user namespace remapping
     --userland-proxy=true                  Use userland proxy for loopback traffic

.. Options with [] may be specified multiple times.

[] が付いているオプションは、複数回指定できます。

.. The Docker daemon is the persistent process that manages containers. Docker uses the same binary for both the daemon and client. To run the daemon you type docker daemon.

Docker デーモンはコンテナを管理するために常駐するプロセスです。Docker はデーモンもクライアントも同じバイナリを使います。デーモンを起動するには ``docker daemon`` を入力します。

.. To run the daemon with debug output, use docker daemon -D.

デーモンでデバッグ出力を行うには、 ``docker daemon -D`` を使います。

.. Daemon socket option

.. _daemon-socket-option:

デーモン・ソケットのオプション
==============================

.. The Docker daemon can listen for Docker Remote API requests via three different types of Socket: unix, tcp, and fd.

Docker デーモンは :doc:`Docker リモート API </engine/reference/api/docker_remote_api>` をリッスンできます。３種類のソケット、 ``unix`` 、 ``tcp`` 、 ``fd`` を通して利用できます。

.. By default, a unix domain socket (or IPC socket) is created at /var/run/docker.sock, requiring either root permission, or docker group membership.

デフォルトでは ``unix`` ドメイン・ソケット（あるいは IPC ソケット）が ``/var/run/docker.sock`` に作成されるため、 ``root`` パーミッションか ``docker`` グループへの所属が必要です。

.. If you need to access the Docker daemon remotely, you need to enable the tcp Socket. Beware that the default setup provides un-encrypted and un-authenticated direct access to the Docker daemon - and should be secured either using the built in HTTPS encrypted socket, or by putting a secure web proxy in front of it. You can listen on port 2375 on all network interfaces with -H tcp://0.0.0.0:2375, or on a particular network interface using its IP address: -H tcp://192.168.59.103:2375. It is conventional to use port 2375 for un-encrypted, and port 2376 for encrypted communication with the daemon.

Docker デーモンにリモートからの接続を考えているのであれば、 ``tcp`` ソケットを有効にする必要があります。デフォルトのセットアップでは、Docker デーモンとの暗号化や認証機能はありませんのでご注意ください。そして、安全に使うには :doc:`内蔵の HTTP 暗号化ソケット </engine/articles/https>` を使うべきです。あるいは安全なウェブ・プロキシをフロントに準備してください。ポート ``2375`` をリッスンしている場合は、全てのネットワークインターフェースで ``-H tcp://0.0.0.0:2375`` を使うか、あるいは IP アドレスを ``-H tcp://192.168.59.103:2375`` のように指定します。習慣として、デーモンとの通信が暗号化されていない場合はポート ``2375`` を、暗号化されている場合はポート ``2376`` を使います。

..    Note: If you’re using an HTTPS encrypted socket, keep in mind that only TLS1.0 and greater are supported. Protocols SSLv3 and under are not supported anymore for security reasons.

.. note::

   HTTP 暗号化ソケットを使う時は、TLS 1.0 以上でサポートされているプロトコル SSLv3 以上をお使いください。以下のバージョンはセキュリティ上の理由によりサポートされていません。

.. On Systemd based systems, you can communicate with the daemon via Systemd socket activation, use docker daemon -H fd://. Using fd:// will work perfectly for most setups but you can also specify individual sockets: docker daemon -H fd://3. If the specified socket activated files aren’t found, then Docker will exit. You can find examples of using Systemd socket activation with Docker and Systemd in the Docker source tree.

systemd をベースとするシステムでは、 `Systemd ソケット・アクティベーション <http://0pointer.de/blog/projects/socket-activation.html>`_ を通して、 ``docker damon -H fd://`` で通信が可能です。 ``fd://`` は大部分のセットアップで動作しますが、個々のソケットを ``docker daemon -H fd://3`` のように指定できます。もし指定したソケットが見つからない婆は、Docker は終了します。Docker で Systemd ソケット・アクティベーションを使う例は `Docker のソース・ツリー <https://github.com/docker/docker/tree/master/contrib/init/systemd/>`_ をご覧ください。

.. You can configure the Docker daemon to listen to multiple sockets at the same time using multiple -H options:

Docker デーモンは複数の ``-H`` オプションを使い、複数のソケットをリッスンできます。

.. code-block:: bash

   # デフォルトの unix ソケットと、ホスト上の２つの IP アドレスをリッスンする
   docker daemon -H unix:///var/run/docker.sock -H tcp://192.168.59.106 -H tcp://10.10.10.2

.. The Docker client will honor the DOCKER_HOST environment variable to set the -H flag for the client.

Docker クライアントは ``DOCKER_HOST`` 環境変数か ``-H`` フラグで接続できるようになります。

.. code-block:: bash

   $ docker -H tcp://0.0.0.0:2375 ps
   # あるいは
   $ export DOCKER_HOST="tcp://0.0.0.0:2375"
   $ docker ps
   # どちらも同じです

.. Setting the DOCKER_TLS_VERIFY environment variable to any value other than the empty string is equivalent to setting the --tlsverify flag. The following are equivalent:

``DOCKER_TLS_VERIFY`` 環境変数が設定してあれば、コマンド実行時に ``--tlsverify`` フラグを都度指定するのと同じです。以下はいずれも同じです。

.. code-block:: bash

   $ docker --tlsverify ps
   # または
   $ export DOCKER_TLS_VERIFY=1
   $ docker ps

.. The Docker client will honor the HTTP_PROXY, HTTPS_PROXY, and NO_PROXY environment variables (or the lowercase versions thereof). HTTPS_PROXY takes precedence over HTTP_PROXY.

Docker クライアントは ``HTTP_PROXY`` 、 ``HTTPS_PROXY`` 、 ``NO_PROXY`` 環境変数を（あるいは小文字でも）使えます。 ``HTTPS_PROXY`` は ``HTTP_PROXY`` よりも上位です。

.. Daemon storage-driver option

.. _daemon-storage-driver-option:

デーモンのストレージ・ドライバ用オプション
--------------------------------------------------

.. The Docker daemon has support for several different image layer storage drivers: aufs, devicemapper, btrfs, zfs and overlay.

Docker デーモンは様々に異なるイメージ・レイヤ・ストレージ・ドライバをサポートしています。ドライバは、 ``aufs`` 、 ``devicemapper`` 、 ``btrfs`` 、 ``zfs`` 、 ``overlay`` です。

.. The aufs driver is the oldest, but is based on a Linux kernel patch-set that is unlikely to be merged into the main kernel. These are also known to cause some serious kernel crashes. However, aufs is also the only storage driver that allows containers to share executable and shared library memory, so is a useful choice when running thousands of containers with the same program or libraries.

``aufs`` ドライバは最も古いものですが、Linux カーネルに対するパッチ群が基になっています。ここにはメイン・カーネルにマージされなかったものも含まれます。そのため、深刻なカーネルのクラッシュを引き起こすことも分かっています。しかしながら、 ``aufs`` はコンテナの共有実行と共有ライブラリ・メモリが使える唯一のストレージ・ドライバでもあります。そのため、同じプログラムやライブラリで数千ものコンテナを実行する時は便利な選択でしょう。

.. The devicemapper driver uses thin provisioning and Copy on Write (CoW) snapshots. For each devicemapper graph location – typically /var/lib/docker/devicemapper – a thin pool is created based on two block devices, one for data and one for metadata. By default, these block devices are created automatically by using loopback mounts of automatically created sparse files. Refer to Storage driver options below for a way how to customize this setup. ~jpetazzo/Resizing Docker containers with the Device Mapper plugin article explains how to tune your existing setup without the use of options.

``devicemapper`` ドライバはシン・プロビジョニング（thin provisioning）とコピー・オン・ライト（Copy on Write）スナップショットを使います。各 devicemapper が位置する場所は、典型的なのは ``/var/lib/docker/devicemapper``  です。シン（thin）プールは２つのブロックデバイス上に作られます。１つはデータであり、もう１つはメタデータです。デフォルトでは、これらのブロック・デバイスは、別々のファイルとして自動されたループバックのマウントをもとに、自動的に作成されます。セットアップのカスタマイズ方法は、以下にある :ref:`ストレージ・ドライバのオプション <storage-driver-options>` をご覧ください。 `jpetazzo/Resizing Docker containers with the Device Mapper plugin <http://jpetazzo.github.io/2014/01/29/docker-device-mapper-resize/>`_ の記事に、オプションを使わない調整のしかたについて説明があります。

.. The btrfs driver is very fast for docker build - but like devicemapper does not share executable memory between devices. Use docker daemon -s btrfs -g /mnt/btrfs_partition.

``btrfs`` ドライバは ``docker build`` が非常に高速です。しかし、 ``devicemapper`` のようにデバイス間の実行メモリを共有しません。使うには ``docker daemon -s btrfs -g /mnt/btrfs_partition`` とします。

.. The zfs driver is probably not as fast as btrfs but has a longer track record on stability. Thanks to Single Copy ARC shared blocks between clones will be cached only once. Use docker daemon -s zfs. To select a different zfs filesystem set zfs.fsname option as described in Storage driver options.

``zfs`` ドライバは ``btrfs`` ほど速くありませんが、安定さのためレコードを長く追跡します。 ``Single Copy ARC`` のおかげで、クローン間の共有ブロックが１度キャッシュされます。使うには ``docker daemon -s zfs`` を指定します。異なる zfs ファイルシステムセットを選択するには、 ``zfs.fsname`` オプションを  :ref:`ストレージ・ドライバのオプション <storage-driver-options>` で指定します。

.. The overlay is a very fast union filesystem. It is now merged in the main Linux kernel as of 3.18.0. Call docker daemon -s overlay to use it.

``overlay`` は非常に高速なユニオン・ファイル・システムです。ようやく Linux カーネル `3.18.0 <https://lkml.org/lkml/2014/10/26/137>`_ でメインにマージされました。使うには ``docker daemon -s overlay`` を指定します。

..    Note: As promising as overlay is, the feature is still quite young and should not be used in production. Most notably, using overlay can cause excessive inode consumption (especially as the number of images grows), as well as being incompatible with the use of RPMs.

.. note::

   前途有望な ``overlay`` は、機能がまだ若く、プロダクションで使うべきではありません。とりわけ、 ``overlay`` を使うと過度の inode 消費を引き起こしますし（特にイメージが大きく成長すると）、RPM との互換性がありません。

..    Note: It is currently unsupported on btrfs or any Copy on Write filesystem and should only be used over ext4 partitions.

.. note::

   現在のサポートされていない ``btrfs`` やコピー・オン・ライトのファイルシステムは、 ``ext4`` パーティション上のみで使うべきです。

.. Storage driver options

.. _storage-driver-options:

ストレージ・ドライバのオプション
----------------------------------------

.. Particular storage-driver can be configured with options specified with --storage-opt flags. Options for devicemapper are prefixed with dm and options for zfs start with zfs.

個々のストレージドライバは ``--storage-opt`` フラグでオプションを設定できます。 ``devicemapper`` 用のオプションは ``dm`` で始まり、 ``zfs`` 用のオプションは ``zfs`` で始まります。

..    dm.thinpooldev

* ``dm.thinpooldev``

..    Specifies a custom block storage device to use for the thin pool.

シン・プール用に使うカスタム・ブロックストレージ・デバイスを指定します。

..    If using a block device for device mapper storage, it is best to use lvm to create and manage the thin-pool volume. This volume is then handed to Docker to exclusively create snapshot volumes needed for images and containers.

ブロック・デバイスをデバイスマッパー・ストレージに使う場合、``lvm`` を使った thin プール・ボリュームの作成・管理がベストです。その後、このボリュームは Docker により、イメージまたはコンテナで、排他的なスナップショット用ボリュームを作成するために使われます。

..    Managing the thin-pool outside of Docker makes for the most feature-rich method of having Docker utilize device mapper thin provisioning as the backing storage for Docker’s containers. The highlights of the lvm-based thin-pool management feature include: automatic or interactive thin-pool resize support, dynamically changing thin-pool features, automatic thinp metadata checking when lvm activates the thin-pool, etc.

シン・プールの管理を Docker の外で行うため、最も機能豊富な手法をもたらします。Docker コンテナの背後にあるストレージとして、Docker はデバイスマッパーによる シン・プロビジョニングを活用するからです。lvm をベースにしたシン・プール管理機能に含まれるハイライトは、自動もしくはインタラクティブなシン・プールの容量変更のサポートです。動的にシン・プールを変更する機能とは、lvm が シン・プールをアクティブにする時、自動的にメタデータのチェックを行います。

..    As a fallback if no thin pool is provided, loopback files will be created. Loopback is very slow, but can be used without any pre-configuration of storage. It is strongly recommended that you do not use loopback in production. Ensure your Docker daemon has a --storage-opt dm.thinpooldev argument provided.

シン・プールが割り当てられなければフェイルバックします。このとき、ループバックのファイルが作成されます。ループバックは非常に遅いものですが、ストレージの再設定を行わなくても利用可能になります。プロダクション環境においては、ループバックを使わない事を強く推奨します。Docker デーモンで ``--storage-opt dm.thinpooldev`` が指定されていること確認してください。

..    Example use:

使用例：

.. code-block:: bash

   $ docker daemon \
         --storage-opt dm.thinpooldev=/dev/mapper/thin-pool

* ``dm.basesize``

..    Specifies the size to use when creating the base device, which limits the size of images and containers. The default value is 100G. Note, thin devices are inherently “sparse”, so a 100G device which is mostly empty doesn’t use 100 GB of space on the pool. However, the filesystem will use more space for the empty case the larger the device is.

ベース・デバイス作成時の容量を指定します。これはイメージとコンテナのサイズの上限にあたります。デフォルトの値は 10GB です。シン・デバイスは本質的に「希薄」（sparse）なのを覚えて置いてください。そのため、10GB のデバイスの大半がカラッポで未使用だったとしても、10GB の領域がプールされます。しかしながら、ファイルシステムがより大きなデバイスであれば、カラッポだとしても多くの容量を使うでしょう。

.. The base device size can be increased at daemon restart which will allow all future images and containers (based on those new images) to be of the new base device size.

以後のイメージや（イメージを元にする）コンテナが利用可能となる新しいベース・デバイス容量を増やしたい場合は、デーモンの再起動で変更できます。

.. Example use:

使用例：

.. code-block:: bash

   $ docker daemon --storage-opt dm.basesize=50G

.. This will increase the base device size to 50G. The Docker daemon will throw an error if existing base device size is larger than 50G. A user can use this option to expand the base device size however shrinking is not permitted.

これはベース・デバイス容量を 50GB に増やしています。Docker デーモンはこのベース・イメージの容量が 50GB よりも大きくなるとエラーを投げます。ユーザはこのオプションを使ってベース・デバイス容量を拡張できますが、縮小はできません。

..    This value affects the system-wide “base” empty filesystem that may already be initialized and inherited by pulled images. Typically, a change to this value requires additional steps to take effect:

システム全体の「ベース」となるカラッポのファイルシステムに対して、設定値が影響を与えます。これは、既に初期化されているか、取得しているイメージから継承している場合です。とりわけ、この値の変更時には、反映させるために追加の手順が必要です。

.. code-block:: bash

   $ sudo service docker stop
   $ sudo rm -rf /var/lib/docker
   $ sudo service docker start

..    Example use:

使用例：

.. code-block:: bash

   $ docker daemon --storage-opt dm.basesize=20G

* ``dm.loopdatasize``

..        Note: This option configures devicemapper loopback, which should not be used in production.

.. note::

   この設定はデバイスマッパーのループバックを変更するものです。プロダクションで使うべきではありません。

..    Specifies the size to use when creating the loopback file for the “data” device which is used for the thin pool. The default size is 100G. The file is sparse, so it will not initially take up this much space.

「データ」デバイスがシン・プール用に使うためのループバック・ファイルの作成時、この容量の指定に使います。デフォルトの容量は 100GB です。ファイルは希薄なため、初期段階ではさほど容量を使いません。

..    Example use:

使用例：

.. code-block:: bash

   $ docker daemon --storage-opt dm.loopdatasize=200G

* ``dm.loopmetadatasize``

..        Note: This option configures devicemapper loopback, which should not be used in production.

.. note::

   この設定はデバイスマッパーのループバックを変更するものです。プロダクションで使うべきではありません。

..    Specifies the size to use when creating the loopback file for the “metadata” device which is used for the thin pool. The default size is 2G. The file is sparse, so it will not initially take up this much space.

「メタデータ」デバイスがシン・プール用に使うためのループバック・ファイルの作成時、この容量の指定に使います。デフォルトの容量は 2GB です。ファイルは希薄なため、初期段階ではさほど容量を使いません。

..    Example use:

使用例：

   $ docker daemon --storage-opt dm.loopmetadatasize=4G

* ``dm.fs``

..    Specifies the filesystem type to use for the base device. The supported options are “ext4” and “xfs”. The default is “xfs”

ベース・デバイスで使用するファイルシステムの種類を指定します。サポートされているオプションは「ext4」と「xfs」です。デフォルトは「xfs」です。

..    Example use:

使用例：

.. code-block:: bash

   $ docker daemon --storage-opt dm.fs=ext4

* ``dm.mkfsarg``

..    Specifies extra mkfs arguments to be used when creating the base device.

ベース・デバイスの作成時に mkfs に対する追加の引数を指定します。

..    Example use:

使用例：

.. code-block:: bash

   $ docker daemon --storage-opt "dm.mkfsarg=-O ^has_journal"

* ``dm.mountopt``

..    Specifies extra mount options used when mounting the thin devices.

シン・デバイスをマウントするときに使う、追加マウントオプションを指定します。

..    Example use:

使用例：

   $ docker daemon --storage-opt dm.mountopt=nodiscard

* ``dm.datadev``

..    (Deprecated, use dm.thinpooldev)

（廃止されました。 ``dm.thinpooldev`` をお使いください ）

..    Specifies a custom blockdevice to use for data for the thin pool.

シン・プール用のブロック・デバイスが使うデータを指定します。

..    If using a block device for device mapper storage, ideally both datadev and metadatadev should be specified to completely avoid using the loopback device.

デバイスマッパー用のストレージにブロック・デバイスを使う時、datadev と metadatadev の両方がループバック・デバイスを完全に使わないようにするのが理想です。

..    Example use:

使用例：

.. code-block:: bash

   $ docker daemon \
         --storage-opt dm.datadev=/dev/sdb1 \
         --storage-opt dm.metadatadev=/dev/sdc1

* ``dm.metadatadev``

..    (Deprecated, use dm.thinpooldev)

（廃止されました。 ``dm.thinpooldev`` をお使いください ）

..     Specifies a custom blockdevice to use for metadata for the thin pool.

シン・プール用のブロック・デバイスが使うメタデータを指定します。

..    For best performance the metadata should be on a different spindle than the data, or even better on an SSD.

最も性能の高いメタデータとは、データとは軸が異なる場所にあるもので、あるいは SSD を使うのが望ましいでしょう。

..    If setting up a new metadata pool it is required to be valid. This can be achieved by zeroing the first 4k to indicate empty metadata, like this:

新しいメタデータ・プールのセットアップには有効化が必要です。次のように、ゼロ値を使い、始めから 4096 までカラッポのメタデータを作ります。

.. code-block:: bash

   $ dd if=/dev/zero of=$metadata_dev bs=4096 count=1

..    Example use:

使用例：

.. code-block:: bash

   $ docker daemon \
         --storage-opt dm.datadev=/dev/sdb1 \
         --storage-opt dm.metadatadev=/dev/sdc1

* ``dm.blocksize``

..    Specifies a custom blocksize to use for the thin pool. The default blocksize is 64K.

シン・プールで使うカスタム・ブロックサイズを指定します。デフォルトのブロックサイズは 64K です。

..    Example use:

使用例：

.. code-block:: bash

   $ docker daemon --storage-opt dm.blocksize=512K

* ``dm.blkdiscard``

..    Enables or disables the use of blkdiscard when removing devicemapper devices. This is enabled by default (only) if using loopback devices and is required to resparsify the loopback file on image/container removal.

デバイスマッパー・デバイスの削除時に blkdiscard を使うか使わないかを指定します。デフォルトは有効であり、ループバック・デバイスを使っているのであれば、イメージやコンテナ削除時にループバック・ファイルを再希薄化させるために使います。

..    Disabling this on loopback can lead to much faster container removal times, but will make the space used in /var/lib/docker directory not be returned to the system for other use when containers are removed.

このループバックを無効にすると、コンテナの削除時間がより早くなります。しかし、 ``/var/lib/docker`` ディレクトリで使用している領域量は、コンテナが削除された時点で使っていた領域を返してしまいます。

..    Example use:

使用例：

.. code-block:: bash

   $ docker daemon --storage-opt dm.blkdiscard=false

* ``dm.override_udev_sync_check``

..    Overrides the udev synchronization checks between devicemapper and udev. udev is the device manager for the Linux kernel.

``devicemapper`` と ``udev`` 間における ``udev`` 同期確認の設定を上書きします。 ``udev`` は Linux カーネル用のデバイスマッパーです。

..    To view the udev sync support of a Docker daemon that is using the devicemapper driver, run:

Docker デーモンが ``udev`` 同期をサポートしているかどうかは、 ``devicemapper`` ドライバを使い確認します。

.. code-block:: bash

   $ docker info
   [...]
   Udev Sync Supported: true
   [...]

..    When udev sync support is true, then devicemapper and udev can coordinate the activation and deactivation of devices for containers.

``udev`` 同期サポートが ``true`` であれば、 ``devicemapper`` と udev を組み合わせ、コンテナ向けのデバイスを有効化（activation）・無効化（deactivation）します。

..    When udev sync support is false, a race condition occurs between thedevicemapper and udev during create and cleanup. The race condition results in errors and failures. (For information on these failures, see docker#4036)

``udev`` 同期サポートが ``false`` であれば、 ``devicemapper`` と ``udev`` 間で作成・クリーンアップ時に競合を引き起こします。競合状態の結果、エラーが発生して失敗します（の失敗に関する詳しい情報は `docker#4036 <https://github.com/docker/docker/issues/4036>`_ をご覧ください。）

..    To allow the docker daemon to start, regardless of udev sync not being supported, set dm.override_udev_sync_check to true:

``docker`` デーモンを開始するには、 ``udev`` 同期をサポートしているかどうかに関わらず、 ``dm.override_udev_sync_check`` を true にします。

.. code-block:: bash

   $ docker daemon --storage-opt dm.override_udev_sync_check=true

..    When this value is true, the devicemapper continues and simply warns you the errors are happening.

この値が ``true`` の場合、 ``devicemaper`` はエラーが発生しても簡単に警告を表示するだけで、処理を継続します。

..        Note: The ideal is to pursue a docker daemon and environment that does support synchronizing with udev. For further discussion on this topic, see docker#4036. Otherwise, set this flag for migrating existing Docker daemons to a daemon with a supported environment.

.. note::

   ``docker`` デーモンと環境を追跡するという考えは、 ``udev`` の同期機能をサポートするためのものでした。このトピックに関しては `docker#4036 <https://github.com/docker/docker/issues/4036>`_ をご覧下さい。一方で、既存の Docker デーモンを、サポートされている別の環境に移行する時のフラグとしても使います。

* ``dm.use_deferred_removal``

..    Enables use of deferred device removal if libdm and the kernel driver support the mechanism.

``libdm`` やカーネル・ドライバがサポートしている仕組みがあれば、デバイス削除の遅延を有効化します。

..    Deferred device removal means that if device is busy when devices are being removed/deactivated, then a deferred removal is scheduled on device. And devices automatically go away when last user of the device exits.

デバイス削除の遅延が意味するのは、デバイスを無効化・非アクティブ化しようとしてもビジー（使用中）であれば、デバイス上で遅延削除が予定されます。そして、最後にデバイスを使っているユーザが終了すると、自動的に削除します。

..    For example, when a container exits, its associated thin device is removed. If that device has leaked into some other mount namespace and can’t be removed, the container exit still succeeds and this option causes the system to schedule the device for deferred removal. It does not wait in a loop trying to remove a busy device.

例えば、コンテナを終了すると、関連づけられているシン・デバイスも削除されます。デバイスが他のマウント名前空間も利用しているの場合は、削除できません。コンテナの終了が成功したら、このオプションが有効であれば、システムがデバイスの遅延削除をスケジュールします。使用中のデバイスが削除できるまで、ループを繰り返すことはありません。

..    Example use:

使用例：

.. code-block:: bash

    $ docker daemon --storage-opt dm.use_deferred_removal=true

* ``dm.use_deferred_deletion``

..    Enables use of deferred device deletion for thin pool devices. By default, thin pool device deletion is synchronous. Before a container is deleted, the Docker daemon removes any associated devices. If the storage driver can not remove a device, the container deletion fails and daemon returns.

シン・プール用デバイスの遅延削除を有効化するのに使います。デフォルトでは、シン・プールの削除は同期します。コンテナを削除する前に、Docker デーモンは関連するデバイスを削除します。ストレージ・ドライバがデバイスを削除できなければ、コンテナの削除は失敗し、デーモンはエラーを表示します。

..    Error deleting container: Error response from daemon: Cannot destroy container

..    To avoid this failure, enable both deferred device deletion and deferred device removal on the daemon.

この失敗を避けるには、デバイス遅延削除（deletion）と、デバイス遅延廃止（removal）をデーモンで有効化します。

.. code-block:: bash

   $ docker daemon \
         --storage-opt dm.use_deferred_deletion=true \
         --storage-opt dm.use_deferred_removal=true

..    With these two options enabled, if a device is busy when the driver is deleting a container, the driver marks the device as deleted. Later, when the device isn’t in use, the driver deletes it.

この２つのオプションが有効であれば、ドライバがコンテナを削除する時にデバイスが使用中でも、ドライバはデバイスを削除対象としてマークします。その後、デバイスが使えなくなったら、ドライバはデバイスを削除します。

..    In general it should be safe to enable this option by default. It will help when unintentional leaking of mount point happens across multiple mount namespaces.

通常、安全のためにデフォルトでこのオプションを有効化すべきです。複数のマウント名前空間にまたがり、マウントポイントの意図しないリークが発生したときに役立つでしょう。

.. Currently supported options of zfs:

現時点で ``zfs`` がサポートしているオプション：

* ``zfs.fsname``

..    Set zfs filesystem under which docker will create its own datasets. By default docker will pick up the zfs filesystem where docker graph (/var/lib/docker) is located.

Docker が自身のデータセットとして、どの zfs ファイルシステムを使うか指定します。デフォルトの Docker は docker グラフ（ ``/var/lib/docker`` ）がある場所を zfs ファイルシステムとして用います。

..    Example use:

使用例：

.. code-block:: bash

   $ docker daemon -s zfs --storage-opt zfs.fsname=zroot/docker

.. Docker execdriver option

.. _docker-execdriver-option:

Docker 実行ドライバのオプション
========================================

.. The Docker daemon uses a specifically built libcontainer execution driver as its interface to the Linux kernel namespaces, cgroups, and SELinux.

Docker デーモンは Linux カーネルの ``namespaces`` 、 ``cgroups`` 、 ``SELinux`` に対するインターフェースとして、特別に作られた ``libcontainer`` 実行ドライバを使います。

.. There is still legacy support for the original LXC userspace tools via the lxc execution driver, however, this is not where the primary development of new functionality is taking place. Add -e lxc to the daemon flags to use the lxc execution driver.

``lxc`` 実行ドライバを通して、オリジナルの `LXC 名前空間ツール <https://linuxcontainers.org/>`_ もレガシーとしてサポートします。しかし、新機能を追加するための重要な開発対象ではなくなっています。 ``-e lxc`` をデーモンのフラグに追加し、 ``lxc`` 実行ドライバを使えます。

.. Options for the native execdriver

.. _options-for-the-native-execdriver:

ネイティブ実行ドライバのオプション
========================================

.. You can configure the native (libcontainer) execdriver using options specified with the --exec-opt flag. All the flag’s options have the native prefix. A single native.cgroupdriver option is available.

``native`` (libcontainer) 実行ドライバは、 ``--exec-opt`` フラグを使ってオプションを指定できます。全てのオプションのフラグには、先頭に ``native`` が付きます。 ``native.cgroupdriver`` オプションが利用可能です。

.. The native.cgroupdriver option specifies the management of the container’s cgroups. You can specify cgroupfs or systemd. If you specify systemd and it is not available, the system uses cgroupfs. By default, if no option is specified, the execdriver first tries systemd and falls back to cgroupfs. This example sets the execdriver to cgroupfs:

``native.cgroupdriver`` オプションはコンテナの cgroups 管理を指定します。 ``systemd`` の ``cgroupfs`` で指定可能です。 ``systemd`` で指定した時、対象が利用可能でなければ、システムは ``cgroupfs`` を使います。デフォルトでは、オプションの指定がない場合、実行ドライバはまず ``systemd`` と ``cgroupfs`` のフェイルバックを試みます。次の例は ``cgroupfs`` を実行ドライバに設定します。

.. code-block:: bash

   $ sudo docker daemon --exec-opt native.cgroupdriver=cgroupfs

.. Setting this option applies to all containers the daemon launches.

このオプション設定は、デーモンが起動した全てのコンテナに対して適用されます。

.. Daemon DNS options

.. _daemon-dns-options:

デーモンの DNS オプション
==============================

.. To set the DNS server for all Docker containers, use docker daemon --dns 8.8.8.8.

全ての Docker コンテナに向けての DNS サーバを設定するには、 ``docker damon --dns 8.8.8.8`` を使います。

.. To set the DNS search domain for all Docker containers, use docker daemon --dns-search example.com.

全ての Docker コンテナに向けて DNS 検索ドメインを設定するには、 ``docker daemon --dns-search example.com`` を使います。

.. Insecure registries

.. _insecure-registries:

安全ではないレジストリ
==============================

.. Docker considers a private registry either secure or insecure. In the rest of this section, registry is used for private registry, and myregistry:5000 is a placeholder example for a private registry.

Docker はプライベート・レジストリが安全かそうでないかを確認します。このセクションでは、 *レジストリ* として *プライベート・レジストリ (private registry)* を使い、例としてプライベート・レジストリが ``myregistry:5000`` で動作しているものとします。

.. A secure registry uses TLS and a copy of its CA certificate is placed on the Docker host at /etc/docker/certs.d/myregistry:5000/ca.crt. An insecure registry is either not using TLS (i.e., listening on plain text HTTP), or is using TLS with a CA certificate not known by the Docker daemon. The latter can happen when the certificate was not found under /etc/docker/certs.d/myregistry:5000/, or if the certificate verification failed (i.e., wrong CA).

安全なレジストリは、TLS を使い、CA 証明書のコピーが ``/etc/docker/certs.d/myregistry:5000/ca.crt`` にあります。安全ではないレジストリとは、TLS を使っていない場合（例：平文の HTTP をリッスン）や、TLS を使っていても Docker デーモンが知らない CA 証明書を使う場合を指します。後者であれば、証明書が ``/etc/docker/certs.d/myregistry:5000/`` 以下に存在しないか、証明書の照合に失敗しています（例：CA が違う）。

.. By default, Docker assumes all, but local (see local registries below), registries are secure. Communicating with an insecure registry is not possible if Docker assumes that registry is secure. In order to communicate with an insecure registry, the Docker daemon requires --insecure-registry in one of the following two forms:

デフォルトでは、Docker はローカルにあるレジストリ（以下のローカル・レジストリについてをご覧ください）は安全であるとみなします。Docker はレジストリが安全とみなさない限り、安全ではないレジストリとの通信はできません。安全ではないレジストリと通信できるようにするには、Docker デーモンに ``--insecure-registry`` という２つの形式のオプションが必要です。

..    --insecure-registry myregistry:5000 tells the Docker daemon that myregistry:5000 should be considered insecure.
..    --insecure-registry 10.1.0.0/16 tells the Docker daemon that all registries whose domain resolve to an IP address is part of the subnet described by the CIDR syntax, should be considered insecure.

* ``--insecure-registry myregistry:5000`` Docker デーモンに対して、myregistry:5000 は安全ではないと考えられると伝えます。
* ``--insecure-registry 10.1.0.0/16`` は Docker デーモンに対して、ドメインを逆引きすると、CIDR 構文で記述した対象のサブネット上の IP アドレスを持つ全てが安全ではないと伝えます。

.. The flag can be used multiple times to allow multiple registries to be marked as insecure.

このフラグは、複数のレジストリに対して安全ではないと複数回指定できます。

.. If an insecure registry is not marked as insecure, docker pull, docker push, and docker search will result in an error message prompting the user to either secure or pass the --insecure-registry flag to the Docker daemon as described above.

安全ではないレジストリを「安全ではない」と指定しなければ、 ``docker pull`` 、 ``docker push`` 、 ``docker search`` を実行してもエラーメッセージが帰ってきます。ユーザは安全なレジストリを使うか、あるいは先ほどのように ``--insecure-registry`` フラグで Docker デーモンに対して明示する必要があります。

.. Local registries, whose IP address falls in the 127.0.0.0/8 range, are automatically marked as insecure as of Docker 1.3.2. It is not recommended to rely on this, as it may change in the future.

IP アドレスが 127.0.0.0/8 の範囲にあるローカルのレジストリは、Docker 1.3.2 以降、自動的に安全ではないレジストリとしてマークされます。ですが、これを信用するのは推奨しません。将来のバージョンでは変更される可能性があります。

.. Enabling --insecure-registry, i.e., allowing un-encrypted and/or untrusted communication, can be useful when running a local registry. However, because its use creates security vulnerabilities it should ONLY be enabled for testing purposes. For increased security, users should add their CA to their system’s list of trusted CAs instead of enabling --insecure-registry.

``--insecure-registry`` を有効にするとは、暗号化されていない、あるいは信頼できない通信を可能にします。そのため、ローカルでのレジストリ実行には便利でしょう。しかし、セキュリティ上の脆弱性を生み出してしまうため、テスト目的のみで使うべきです。セキュリティを高めるには、 ``--insecure-registry`` を有効にするのではなく、信頼できる CA 機関が発行する CA を使うべきです。

.. Legacy Registries

.. _legacy-registries:

過去のレジストリ
====================

.. Enabling --disable-legacy-registry forces a docker daemon to only interact with registries which support the V2 protocol. Specifically, the daemon will not attempt push, pull and login to v1 registries. The exception to this is search which can still be performed on v1 registries.

``--disable-legacy-registry`` を有効にすると、Docker は V2 プロトコルをサポートしているデーモンとしか通信しないように強制します。この指定によって、デーモンは v1 レジストリへの ``push`` 、 ``pull`` 、 ``login`` を阻止します。例外として、v1 レジストリでも ``search`` のみ実行できます。

.. Running a Docker daemon behind a HTTPS_PROXY

Docker デーモンを HTTPS_PROXY の背後で動かす
==================================================

.. When running inside a LAN that uses a HTTPS proxy, the Docker Hub certificates will be replaced by the proxy’s certificates. These certificates need to be added to your Docker host’s configuration:

LAN の内部で ``HTTPS`` プロキシを使う場合、Docker Hub の証明書がプロキシの証明書に置き換えられます。これら証明書を、Docker ホストの設定に追加する必要があります。

..    Install the ca-certificates package for your distribution

1. 各ディストリビューションに対応する ``ca-certificates`` パッケージをインストールします。

..    Ask your network admin for the proxy’s CA certificate and append them to /etc/pki/tls/certs/ca-bundle.crt

2. ネットワーク管理者にプロキシの CA 証明書を訊き、 ``/etc/pki/tls/certs/ca-bundle.crt`` に追加します。

..    Then start your Docker daemon with HTTPS_PROXY=http://username:password@proxy:port/ docker daemon. The username: and password@ are optional - and are only needed if your proxy is set up to require authentication.

3. Docker デーモンに ``HTTPS_PROXY=http://username:password@proxy:port/ docker daemon`` を付けて起動します。 ``username:`` と ``password@`` はオプションです。そして、プロ指揮の認証設定も必要であれば追加します。

.. This will only add the proxy and authentication to the Docker daemon’s requests - your docker builds and running containers will need extra configuration to use the proxy

これは Docker デーモンのリクエストに対してプロキシと認証の設定を追加しただけです。 ``docker build`` でコンテナを実行する時は、プロキシを使うために更なる追加設定が必要です。

.. Default Ulimits

.. _default-ulimits:

Ulimits のデフォルト
====================

.. --default-ulimit allows you to set the default ulimit options to use for all containers. It takes the same options as --ulimit for docker run. If these defaults are not set, ulimit settings will be inherited, if not set on docker run, from the Docker daemon. Any --ulimit options passed to docker run will overwrite these defaults.

``--default-uliit`` を使い、全てのコンテナに対するデフォルトの ``ulimit`` オプションを指定できます。 ``docker run`` 時に ``--ulimit`` オプションを指定するのと同じです。デフォルトを設定しなければ、 ``ulimit`` 設定は継承されます。 ``docker run`` 時に設定されなければ、Docker デーモンから継承します。``docker run`` 時のあらゆる ``--ulimit`` オプションは、デフォルトを上書きします。

.. Be careful setting nproc with the ulimit flag as nproc is designed by Linux to set the maximum number of processes available to a user, not to a container. For details please check the run reference.

``noproc`` と ``ulimit`` フラグを使う時は注意してください。 ``noproc`` は Linux がユーザに対して利用可能な最大プロセス数を設定するものであり、コンテナ向けではありません。詳細については、 :doc:`<run>` リファレンスをご確認ください。

.. Nodes discovery

.. _nodes-discovery:

ノードのディスカバリ（検出）
==============================

.. The --cluster-advertise option specifies the ‘host:port’ or interface:port combination that this particular daemon instance should use when advertising itself to the cluster. The daemon is reached by remote hosts through this value. If you specify an interface, make sure it includes the IP address of the actual Docker host. For Engine installation created through docker-machine, the interface is typically eth1.

``--cluster-advertise`` オプションは、 ``ホスト:ポート`` あるいは ``インターフェース:ポート`` の組み合わせを指定します。これは、この特定のデーモン・インスタンスがクラスタに自分自身の存在を伝える（advertising）ために使います。リモートホストに到達するデーモンの情報を、ここに指定します。インターフェースを指定する場合は、実際の Docker ホスト上の IP アドレスも含められます。たとえば、 ``docker-machine`` を使ってインストールする時、典型的なインターフェースは ``eth1`` です。

.. The daemon uses libkv to advertise the node within the cluster. Some key-value backends support mutual TLS. To configure the client TLS settings used by the daemon can be configured using the --cluster-store-opt flag, specifying the paths to PEM encoded files. For example:

デーモンはクラスタ内のノードに存在を伝えるため、 `libkv <https://github.com/docker/libkv/>`_ を使います。キーバリュー・バックエンドは同じ TLS をサポートします。デーモンが使用するクライアント TLS の設定は ``--cluster-store-opt`` フラグを使い、PEM エンコード・ファイルのパスを指定します。実行例：

.. code-block:: bash

   docker daemon \
       --cluster-advertise 192.168.1.2:2376 \
       --cluster-store etcd://192.168.1.2:2379 \
       --cluster-store-opt kv.cacertfile=/path/to/ca.pem \
       --cluster-store-opt kv.certfile=/path/to/cert.pem \
       --cluster-store-opt kv.keyfile=/path/to/key.pem

.. The currently supported cluster store options are:

現在サポートされているクラスタ・ストアのオプションは：

* ``kv.cacertfile``

..    Specifies the path to a local file with PEM encoded CA certificates to trust

信頼すべき CA 証明書がエンコードされた PEM のローカル・パスを指定します。

* ``kv.certfile``

..    Specifies the path to a local file with a PEM encoded certificate. This certificate is used as the client cert for communication with the Key/Value store.

証明書でエンコードされた PEM のローカル・パスを指定。この証明書はクライアントがキーバリュー・ストアとの通信の証明に使います。

* ``kv.keyfile``

..    Specifies the path to a local file with a PEM encoded private key. This private key is used as the client key for communication with the Key/Value store.

秘密鍵がエンコードされた PEM のローカル・パスを指定します。この秘密鍵はクライアントがキーバリュー・ストアと通信時に鍵として使います。

* ``kv.path``

..   Specifies the path in the Key/Value store. If not configured, the default value is ‘docker/nodes

キーバリュー・ストアのパスを指定します。指定しなければ、デフォルトの ``docker/nodes`` が使われます。

.. Access authorization

.. _access-authorization:

アクセス認証
====================

.. Docker’s access authorization can be extended by authorization plugins that your organization can purchase or build themselves. You can install one or more authorization plugins when you start the Docker daemon using the --authorization-plugin=PLUGIN_ID option.

Docker のアクセス認証は認証プラグインの拡張であり、組織が組織自身で購入・構築できます。認証プラグイン（authorization plugin）を使うには、Docker ``daemon`` で ``--authorization-plugin=PLUGIN_ID`` オプションを使って起動します。

.. code-block:: bash

   docker daemon --authorization-plugin=plugin1 --authorization-plugin=plugin2,...

.. The PLUGIN_ID value is either the plugin’s name or a path to its specification file. The plugin’s implementation determines whether you can specify a name or path. Consult with your Docker administrator to get information about the plugins available to you.

``PLUGIN_ID`` の値とは、プラグイン名かファイルのパスを指定します。どのプラグインを実装するかを決めるのは、名前またはパスです。あなたの Docker 管理者に対して、利用可能なプラグインの情報をお訊ねください。

.. Once a plugin is installed, requests made to the daemon through the command line or Docker’s remote API are allowed or denied by the plugin. If you have multiple plugins installed, at least one must allow the request for it to complete.

プラグインをインストール後は、コマンドラインや Docker のリモート API を実行する時、プラグインを許可するか許可しないかを選べます。複数のプラグインをインストールした場合は、最後の１つだけが処理されます。

.. For information about how to create an authorization plugin, see authorization plugin section in the Docker extend section of this documentation.

認証プラグインの作成方法については、この Docker ドキュメントの拡張に関するセクションにある :doc:`認証プラグイン </engine/extend/authorization>` をご覧ください。

.. Daemon user namespace option

.. _daemon-user-namespce-option:

デーモンのユーザ名前空間オプション
========================================

.. The Linux kernel user namespace support provides additional security by enabling a process, and therefore a container, to have a unique range of user and group IDs which are outside the traditional user and group range utilized by the host system. Potentially the most important security improvement is that, by default, container processes running as the root user will have expected administrative privilege (with some restrictions) inside the container but will effectively be mapped to an unprivileged uid on the host.

Linux カーネルの `ユーザ名前空間(user namespace)サポート <http://man7.org/linux/man-pages/man7/user_namespaces.7.html>`_  はプロセスに対する追加のセキュリティを提供します。これを使えば、コンテナでユーザ ID とグループ ID を使う場合、それをコンテナの外、つまり Docker ホスト上で使うユーザ ID とグループ ID のユニークな範囲を指定できます。これは重要なセキュリティ改善になる可能性があります。デフォルトでは、コンテナのプロセスは ``root`` ユーザとして実行されるので、コンテナ内で管理特権（と制限）を持っていることが予想されます。しかし、その影響はホスト上の権限の無い ``uid`` に対して割り当てられます。

.. When user namespace support is enabled, Docker creates a single daemon-wide mapping for all containers running on the same engine instance. The mappings will utilize the existing subordinate user and group ID feature available on all modern Linux distributions. The /etc/subuid and /etc/subgid files will be read for the user, and optional group, specified to the --userns-remap parameter. If you do not wish to specify your own user and/or group, you can provide default as the value to this flag, and a user will be created on your behalf and provided subordinate uid and gid ranges. This default user will be named dockremap, and entries will be created for it in /etc/passwd and /etc/group using your distro’s standard user and group creation tools.

ユーザ名前空間のサポートを有効化すると、Docker はデーモンが扱うマッピングを作成します。これは、同じ Engine のインスタンス上で実行する全コンテナと対応するものです。マッピングを使い、従属ユーザ（subordinate user）ID と従属グループ ID を活用します。この機能は最近の全ての Linux ディストリビューション上において利用可能です。 ``--userns-remap`` パラメータを指定することで、 ``/etc/subuid`` と ``/etc/subguid``  ファイルがユーザとオプションのグループ用に使われます。このフラグに自分でユーザとグループを指定しなければ、ここでは ``default`` が指定されます。 default のユーザとは ``dockremap`` と言う名前であり、各ディストリビューションの一般的なユーザとグループ作成ツールを使い、 ``/etc/passwd`` と ``/etc/group`` にエントリが追加されます。

..    Note: The single mapping per-daemon restriction is in place for now because Docker shares image layers from its local cache across all containers running on the engine instance. Since file ownership must be the same for all containers sharing the same layer content, the decision was made to map the file ownership on docker pull to the daemon’s user and group mappings so that there is no delay for running containers once the content is downloaded. This design preserves the same performance for docker pull, docker push, and container startup as users expect with user namespaces disabled.

.. note::

   現時点ではデーモン毎に１つだけマッピングするという制約があります。これは Engine インスタンス上で実行している全てのコンテナにまたがる共有イメージ・レイヤを Docker が共有しているためです。ファイルの所有者は、レイヤ内容を共有している全てのコンテナで共通の必要があるため、解決策としては ``docker pull`` の処理時、ファイル所有者をデーモンのユーザとグループに割り当てる（マッピングする）ことでした。そのため、イメージ内容をダウンロード後は遅延なくコンテナを起動できました。この設計は同じパフォーマンスを維持するため、 ``docker pull`` と ``docker push`` の実行時には維持されています。
   
.. Starting the daemon with user namespaces enabled

.. _starting-the-daemon-with-user-namespaces-enableed:

ユーザ名前空間を有効にしてデーモンを起動
----------------------------------------

.. To enable user namespace support, start the daemon with the --userns-remap flag, which accepts values in the following format

ユーザ名前空間のサポートを有効化するには、デーモン起動時に ``--userns-remap`` フラグを使います。以下のフォーマット形式が指定できます。

* uid
* uid:gid
* ユーザ名
* ユーザ名:グループ名

.. If numeric IDs are provided, translation back to valid user or group names will occur so that the subordinate uid and gid information can be read, given these resources are name-based, not id-based. If the numeric ID information provided does not exist as entries in /etc/passwd or /etc/group, daemon startup will fail with an error message.

整数値の ID が指定されると、有効なユーザ名かグループ名に交換されます。これにより、従属 uid と gid の情報が読み込まれ、指定されたこれらのリソースは ID ベースではなく名前ベースでとなります。 ``/etc/passwd`` や ``/etc/group`` にエントリが無い数値 ID 情報が指定された場合は、docker は起動せずにエラーを表示します。

.. Example: starting with default Docker user management:

例：default の Docker ユーザ管理
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: bash

   $ docker daemon --userns-remap=default

.. When default is provided, Docker will create - or find the existing - user and group named dockremap. If the user is created, and the Linux distribution has appropriate support, the /etc/subuid and /etc/subgid files will be populated with a contiguous 65536 length range of subordinate user and group IDs, starting at an offset based on prior entries in those files. For example, Ubuntu will create the following range, based on an existing user named user1 already owning the first 65536 range:

``default`` が指定されると、 Docker は ``dockermap`` というユーザ名とグループ名が存在しているかどうか確認し、なければ作成します。ユーザが作成されると、 Linux ディストリビューションは ``/etc/subuid`` と ``/etc/subgid`` ファイルの使用をサポートします。これは従属ユーザ ID と従属グループ ID を 65536 まで数える（カウントする）もので、これらは既存のファイルへのエントリをオフセットに使います。例えば、Ubuntu は次のような範囲を作成します。既存の ``user1`` という名前のユーザは、既に 65536 までの範囲を持っています。

.. code-block:: bash

   $ cat /etc/subuid
   user1:100000:65536
   dockremap:165536:65536

.. Note: On a fresh Fedora install, we had to touch the /etc/subuid and /etc/subgid files to have ranges assigned when users were created. Once these files existed, range assignment on user creation worked properly.

.. note::

   Fedora の新規インストール時であれば、ユーザが作成時に範囲を割り当てるために ``/etc/subuid`` と ``/etc/subguid`` ファイルを ``touch`` コマンドで作成する必要があります。ファイルが作成されていれば、ユーザ作成時に適切な範囲が割り当てられます。

.. If you have a preferred/self-managed user with subordinate ID mappings already configured, you can provide that username or uid to the --userns-remap flag. If you have a group that doesn’t match the username, you may provide the gid or group name as well; otherwise the username will be used as the group name when querying the system for the subordinate group ID range.

もしも、既に自分で行った従属ユーザの設定を使いたい場合は、 ``--userns-remap`` フラグにユーザ名か UID を指定します。グループがユーザ名と一致しない場合は、同様に ``gid`` やグループ名も指定します。そうしなければ、従属グループ ID の範囲をシステムが応答するときに、ユーザ名がグループ名として使われます。

.. Detailed information on subuid/subgid ranges

.. _detailed-information-on-subuid-subgid-ranges:

``subuid`` / ``subgid`` 範囲についての詳細情報
--------------------------------------------------

.. Given potential advanced use of the subordinate ID ranges by power users, the following paragraphs define how the Docker daemon currently uses the range entries found within the subordinate range files.

パワーユーザであれば、従属 ID の範囲変更という高度な使い方があります。以下では、現在どのようにして Docker デーモンが従属範囲のファイルから範囲を決めているかの定義を扱います。

(ToDo)

.. The simplest case is that only one contiguous range is defined for the provided user or group. In this case, Docker will use that entire contiguous range for the mapping of host uids and gids to the container process. This means that the first ID in the range will be the remapped root user, and the IDs above that initial ID will map host ID 1 through the end of the range.

.. From the example /etc/subuid content shown above, the remapped root user would be uid 165536.

.. If the system administrator has set up multiple ranges for a single user or group, the Docker daemon will read all the available ranges and use the following algorithm to create the mapping ranges:


..    The range segments found for the particular user will be sorted by start ID ascending.
..    Map segments will be created from each range in increasing value with a length matching the length of each segment. Therefore the range segment with the lowest numeric starting value will be equal to the remapped root, and continue up through host uid/gid equal to the range segment length. As an example, if the lowest segment starts at ID 1000 and has a length of 100, then a map of 1000 -> 0 (the remapped root) up through 1100 -> 100 will be created from this segment. If the next segment starts at ID 10000, then the next map will start with mapping 10000 -> 101 up to the length of this second segment. This will continue until no more segments are found in the subordinate files for this user.
..    If more than five range segments exist for a single user, only the first five will be utilized, matching the kernel’s limitation of only five entries in /proc/self/uid_map and proc/self/gid_map.

.. User namespace known restrictions:

.. _user-namespace-known-restrictions:

ユーザ名前空間と既知の制限
------------------------------

(ToDo)

.. The following standard Docker features are currently incompatible when running a Docker daemon with user namespaces enabled:

..    sharing PID or NET namespaces with the host (--pid=host or --net=host)
    sharing a network namespace with an existing container (--net=container:*other*)
    sharing an IPC namespace with an existing container (--ipc=container:*other*)
    A --readonly container filesystem (this is a Linux kernel restriction against remounting with modified flags of a currently mounted filesystem when inside a user namespace)
    external (volume or graph) drivers which are unaware/incapable of using daemon user mappings
    Using --privileged mode flag on docker run

.. In general, user namespaces are an advanced feature and will require coordination with other capabilities. For example, if volumes are mounted from the host, file ownership will have to be pre-arranged if the user or administrator wishes the containers to have expected access to the volume contents.

.. Finally, while the root user inside a user namespaced container process has many of the expected admin privileges that go along with being the superuser, the Linux kernel has restrictions based on internal knowledge that this is a user namespaced process. The most notable restriction that we are aware of at this time is the inability to use mknod. Permission will be denied for device creation even as container root inside a user namespace.


.. Miscellaneous options

.. _miscellaneous-options:

その他のオプション
====================

.. IP masquerading uses address translation to allow containers without a public IP to talk to other machines on the Internet. This may interfere with some network topologies and can be disabled with --ip-masq=false.

IP マスカレードはコンテナがパブリック IP を持っていなくても、インターネット上の他のマシンと通信するための仕組みです。これにより、インターフェースは複数のネットワーク・トポロジを持ちますが、 ``--ip-masq=false`` を使って無効化できます。

.. Docker supports softlinks for the Docker data directory (/var/lib/docker) and for /var/lib/docker/tmp. The DOCKER_TMPDIR and the data directory can be set like this:

Docker は Docker データ／ディレクトリ（ ``/var/lib/docker`` ）と ``/var/lib/docker/tmp``  に対するソフトリンクをサポートしています。 ``DOCKER_TMPDIR`` を使っても、データディレクトリを次のように指定可能です。

.. code-block:: bash

   DOCKER_TMPDIR=/mnt/disk2/tmp /usr/local/bin/docker daemon -D -g /var/lib/docker -H unix:// > /var/lib/docker-machine/docker.log 2>&1
   # あるいは
   export DOCKER_TMPDIR=/mnt/disk2/tmp
   /usr/local/bin/docker daemon -D -g /var/lib/docker -H unix:// > /var/lib/docker-machine/docker.log 2>&1

.. Default cgroup parent

.. _default-cgroup-parent:

デフォルトの親 cgroup
==============================

.. The --cgroup-parent option allows you to set the default cgroup parent to use for containers. If this option is not set, it defaults to /docker for fs cgroup driver and system.slice for systemd cgroup driver.

``--cgroup-parent`` オプションは、コンテナがデフォルトで使う親 cgroup （cgroup parent）を指定できます。オプションを設定しないと、 ``/docker`` を fs cgroup ドライバとして使います。また ``system.slice`` を systemd cgroup ドライバとして使います。

.. If the cgroup has a leading forward slash (/), the cgroup is created under the root cgroup, otherwise the cgroup is created under the daemon cgroup.

cgroup はスラッシュ記号（ ``/`` ）で始まるルート cgroup の下に作成されますが、他の cgroup は daemon cgroup の下に作成されます。

.. Assuming the daemon is running in cgroup daemoncgroup, --cgroup-parent=/foobar creates a cgroup in /sys/fs/cgroup/memory/foobar, whereas using --cgroup-parent=foobar creates the cgroup in /sys/fs/cgroup/memory/daemoncgroup/foobar

デーモンが cgroup ``daemoncgroup`` で実行されており、``--cgroup-parent=/foobar`` で ``/sys/fs/cgroup/memory/foobar`` の中に cgroup を作成すると仮定すると、 ``--cgroup-parent=foobar`` は ``/sys/fs/cgroup/memory/daemoncgroup/foobar`` に cgroup を作成します。

.. This setting can also be set per container, using the --cgroup-parent option on docker create and docker run, and takes precedence over the --cgroup-parent option on the daemon.

これらの指定はコンテナに対しても可能です。 ``docker create`` と ``docker run`` の実行時に ``--cgroup-parent`` を使うと、デーモンのオプションで指定した ``--cgroup-parent`` よりも優先されます。

.. Daemon configuration file

.. _daemon-configuration-file:

デーモン設定ファイル
====================

.. The --config-file option allows you to set any configuration option for the daemon in a JSON format. This file uses the same flag names as keys, except for flags that allow several entries, where it uses the plural of the flag name, e.g., labels for the label flag. By default, docker tries to load a configuration file from /etc/docker/daemon.json on Linux and %programdata%\docker\config\daemon.json on Windows.

``--config-file`` オプションを使うと、デーモンに対する設定オプションを JSON 形式で指定できます。このファイルでは、フラグと同じ名前をキーとします。ただし、複数の項目を指定可能なフラグの場合は、キーを複数形で指定します（例： ``label`` フラグの指定は ``labels`` になります ）。デフォルトは、 Linux の場合は ``/etc/docker/daemon.json`` にある設定ファイルを Docker が読み込もうとします。Windows の場合は ``%programdata%\docker\config\daemon.json`` です。

.. The options set in the configuration file must not conflict with options set via flags. The docker daemon fails to start if an option is duplicated between the file and the flags, regardless their value. We do this to avoid silently ignore changes introduced in configuration reloads. For example, the daemon fails to start if you set daemon labels in the configuration file and also set daemon labels via the --label flag.

設定ファイル上のオプションは、フラグで指定するオプションと競合してはいけません。ファイルとフラグが重複したまま docker デーモンを起動しようとしても、どのような値を指定しても、起動に失敗します。例えば、デーモンの起動時にラベルを設定ファイルで定義し、かつ、 ``--label`` フラグを指定すると、デーモンは起動に失敗します。

.. Options that are not present in the file are ignored when the daemon starts. This is a full example of the allowed configuration options in the file:

デーモン起動時、ファイルに記述しないオプション項目は無視します。次の例は、利用可能な全てのオプションをファイルに記述したものです。

.. code-block:: json

   {
   	"authorization-plugins": [],
   	"dns": [],
   	"dns-opts": [],
   	"dns-search": [],
   	"exec-opts": [],
   	"exec-root": "",
   	"storage-driver": "",
   	"storage-opts": "",
   	"labels": [],
   	"log-driver": "",
   	"log-opts": [],
   	"mtu": 0,
   	"pidfile": "",
   	"graph": "",
   	"cluster-store": "",
   	"cluster-store-opts": [],
   	"cluster-advertise": "",
   	"debug": true,
   	"hosts": [],
   	"log-level": "",
   	"tls": true,
   	"tlsverify": true,
   	"tlscacert": "",
   	"tlscert": "",
   	"tlskey": "",
   	"api-cors-headers": "",
   	"selinux-enabled": false,
   	"userns-remap": "",
   	"group": "",
   	"cgroup-parent": "",
   	"default-ulimits": {},
          "ipv6": false,
          "iptables": false,
          "ip-forward": false,
          "ip-mask": false,
          "userland-proxy": false,
          "ip": "0.0.0.0",
          "bridge": "",
          "bip": "",
          "fixed-cidr": "",
          "fixed-cidr-v6": "",
          "default-gateway": "",
          "default-gateway-v6": "",
          "icc": false
   }

.. Configuration reloading

.. _configuration-reloading:

設定の再読み込み
--------------------

.. Some options can be reconfigured when the daemon is running without requiring to restart the process. We use the SIGHUP signal in Linux to reload, and a global event in Windows with the key Global\docker-daemon-config-$PID. The options can be modified in the configuration file but still will check for conflicts with the provided flags. The daemon fails to reconfigure itself if there are conflicts, but it won’t stop execution.

いくつかのオプションは設定を反映するために、デーモンのプロセスの再起動を必要とせず、実行中のまま行えます。再読み込みするために、Linux では ``SIGHUP`` シグナルを使います。Windows では ``Global\docker-daemon-config-$PID`` をキーとするグローバル・イベントを使います。設定ファイルでオプションを変更できますが、指定済みのフラグと競合していなか確認されます。もし設定に重複があれば、デーモンは発生を反映できませんが、実行中のデーモンは止まりません。

.. The list of currently supported options that can be reconfigured is this:

現時点で変更可能なオプションは以下の通りです。

..    debug: it changes the daemon to debug mode when set to true.
    labels: it replaces the daemon labels with a new set of labels.

* ``debug`` ：true を設定すると、デーモンをデバッグ・モードにします。
* ``lables`` ：デーモンのラベルを新しく設定したものに変えます。
