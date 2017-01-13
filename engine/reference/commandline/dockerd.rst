.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/dockerd/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/dockerd.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/dockerd.md
.. check date: 2016/06/14
.. Commits on Jun 14, 2016 7b2e5216b89b4c454d67473f1fa06c52a4624680
.. -------------------------------------------------------------------

.. daemon

=======================================
daemon
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. code-block:: bash

   使い方: dockerd [オプション]
   
   Linux コンテナの自給自足ランタイム
   
   オプション:
     --api-cors-header=""                   リモート API の CORS ヘッダをセットする
     --authorization-plugin=[]              読み込む認証プラグインを指定
     -b, --bridge=""                        コンテナをネットワーク・ブリッジにアタッチ
     --bip=""                               ネットワーク・ブリッジ IP の指定
     --cgroup-parent=                       全てのコンテナの親 cgroup を指定
     --cluster-store=""                     分散ストレージバックエンドの URL
     --cluster-advertise=""                 クラスタ上のデーモン・インスタンスのアドレス
     --cluster-store-opt=map[]              クラスタのオプションを指定
     --config-file=/etc/docker/daemon.json  デーモン設定ファイル
     --containerd                           containerd ソケットのパス
     -D, --debug                            デバッグ・モードの有効化
     --default-gateway=""                   コンテナのデフォルト・ゲートウェイ IPv4 アドレス
     --default-gateway-v6=""                コンテナのデフォルト・ゲートウェイ IPv6 アドレス
     --dns=[]                               DNS サーバの指定
     --dns-opt=[]                           DNS オプションの指定
     --dns-search=[]                        DNS の検索に使うドメイン（search domain）
     --default-ulimit=[]                    コンテナのデフォルト ulimit 設定を指定
     --exec-opt=[]                          実行時のオプションを指定
     --exec-root="/var/run/docker"          実行ステート・ファイルのルート・ディレクトリ
     --fixed-cidr=""                        IP アドレスの IPv4 サブネットを固定
     --fixed-cidr-v6=""                     IP アドレスの IPv6 サブネットを固定
     -G, --group="docker"                   unix ソケット用のグループ
     -g, --graph="/var/lib/docker"          Docker 実行時の Docker ルート
     -H, --host=[]                          接続するデーモンのソケット
     --help                                 使い方を表示
     --icc=true                             コンテナ内部通信（inter-container communication）を有効化
     --insecure-registry=[]                 安全ではないレジストリとの通信を有効化
     --ip=0.0.0.0                           コンテナのポートがデフォルトでバインドする IP
     --ip-forward=true                      net.ipv4.ip_forward の有効化
     --ip-masq=true                         IP マスカレードの有効化
     --iptables=true                        iptables のルール追加の有効化
     --ipv6                                  IPv6 ネットワークの有効化
     -l, --log-level="info"                 ログ記録レベルの設定
     --label=[]                             デーモンにキー=バリューのラベルを指定
     --log-driver="json-file"               デフォルトのコンテナのログ記録ドライバ
     --log-opt=[]                           ログドライバのオプションを指定
     --mtu=0                                コンテナ・ネットワークの MTU を指定
     --max-concurrent-downloads=3           pull ごとの最大同時ダウンロード数を指定
     --max-concurrent-uploads=5             push ごとの最大同時アップロード数を指定
     --disable-legacy-registry              レガシーのレジストリには接続しない
     -p, --pidfile="/var/run/docker.pid"    デーモン PID ファイル用のパス
     --registry-mirror=[]                   Docker レジストリの優先ミラー
     --add-runtime=[]                       追加 OCI 互換ランタイムの登録
     -s, --storage-driver=""                使用するストレージ・ドライバ
     --selinux-enabled                      SELinux サポートの有効化
     --storage-opt=[]                       ストレージ・ドライバのオプションを指定
     --tls                                  TLSを使用、--tlsverify を含む
     --tlscacert="~/.docker/ca.pem"         この CA で署名された証明書のみ信頼
     --tlscert="~/.docker/cert.pem"         TLS 証明書ファイルのパス
     --tlskey="~/.docker/key.pem"           TLS 鍵ファイルのパス
     --tlsverify                            TLS でリモート認証
     --userns-remap="default"               ユーザ名前空間の再マッピングを有効化
     --userland-proxy=true                  ループバック通信用に userland プロキシを使う

.. Options with [] may be specified multiple times.

[] が付いているオプションは、複数回指定できます。

.. dockerd is the persistent process that manages containers. Docker uses different binary for the daemon and client. To run the daemon you type dockerd.

dockerd はコンテナを管理するために常駐するプロセスです。Docker はデーモンとクライアントで異なるバイナリを使います。デーモンを起動するには ``dockerd`` を入力します。

.. To run the daemon with debug output, use dockerd -D.

デーモンでデバッグ出力を行うには、 ``dockerd -D`` を使います。

.. Daemon socket option

.. _daemon-socket-option:

デーモン・ソケットのオプション
==============================

.. The Docker daemon can listen for Docker Remote API requests via three different types of Socket: unix, tcp, and fd.

Docker デーモンは :doc:`Docker リモート API </engine/reference/api/docker_remote_api>` を受信できます。３種類のソケット ``unix`` 、 ``tcp`` 、 ``fd`` を通します。

.. By default, a unix domain socket (or IPC socket) is created at /var/run/docker.sock, requiring either root permission, or docker group membership.

デフォルトでは ``unix`` ドメイン・ソケット（あるいは IPC ソケット）を ``/var/run/docker.sock`` に作成します。そのため、操作には ``root`` 権限または ``docker`` グループへの所属が必要です。

.. If you need to access the Docker daemon remotely, you need to enable the tcp Socket. Beware that the default setup provides un-encrypted and un-authenticated direct access to the Docker daemon - and should be secured either using the built in HTTPS encrypted socket, or by putting a secure web proxy in front of it. You can listen on port 2375 on all network interfaces with -H tcp://0.0.0.0:2375, or on a particular network interface using its IP address: -H tcp://192.168.59.103:2375. It is conventional to use port 2375 for un-encrypted, and port 2376 for encrypted communication with the daemon.

Docker デーモンにリモートからの接続を考えているのであれば、 ``tcp`` ソケットを有効にする必要があります。デフォルトのセットアップでは、Docker デーモンとの暗号化や認証機能が無いのでご注意ください。また、安全に使うには :doc:`内部の HTTP 暗号化ソケット </engine/security/https>` を使うべきです。あるいは、安全なウェブ・プロキシをフロントに準備してください。ポート ``2375`` をリッスンしている場合は、全てのネットワークインターフェースで ``-H tcp://0.0.0.0:2375`` を指定するか、あるいは IP アドレスを ``-H tcp://192.168.59.103:2375`` のように指定します。慣例として、デーモンとの通信が暗号化されていない場合はポート ``2375`` を、暗号化されている場合はポート ``2376`` を使います。

..    Note: If you’re using an HTTPS encrypted socket, keep in mind that only TLS1.0 and greater are supported. Protocols SSLv3 and under are not supported anymore for security reasons.

.. note::

   HTTP 暗号化ソケットを使う時は、TLS 1.0 以上でサポートされているプロトコル SSLv3 以上をお使いください。以下のバージョンはセキュリティ上の理由によりサポートされていません。

.. On Systemd based systems, you can communicate with the daemon via Systemd socket activation, use dockerd -H fd://. Using fd:// will work perfectly for most setups but you can also specify individual sockets: dockerd -H fd://3. If the specified socket activated files aren’t found, then Docker will exit. You can find examples of using Systemd socket activation with Docker and Systemd in the Docker source tree.

systemd をベースとするシステムでは、 `Systemd ソケット・アクティベーション <http://0pointer.de/blog/projects/socket-activation.html>`_ を通し、 ``dockerd -H fd://`` で通信が可能です。 ``fd://`` は大部分のセットアップで動作するため、個々のソケットを ``dockerd -H fd://3`` のように指定できます。もし指定したソケットが見つからない時は、Docker が終了します。Docker で Systemd ソケット・アクティベーションを使う例は `Docker のソース・ツリー <https://github.com/docker/docker/tree/master/contrib/init/systemd/>`_ をご覧ください。

.. You can configure the Docker daemon to listen to multiple sockets at the same time using multiple -H options:

Docker デーモンは複数の ``-H`` オプションを使い、複数のソケットをリッスンできます。

.. code-block:: bash

   # デフォルトの unix ソケットと、ホスト上の２つの IP アドレスをリッスンする
   dockerd -H unix:///var/run/docker.sock -H tcp://192.168.59.106 -H tcp://10.10.10.2

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

.. Bind Docker to another host/port or a Unix socket

.. _bind-docker-to-another-host-port-or-a-unix-socket:

Docker の別ホスト/ポート、あるいは Unix ソケットをバインド
------------------------------------------------------------

..    Warning: Changing the default docker daemon binding to a TCP port or Unix docker user group will increase your security risks by allowing non-root users to gain root access on the host. Make sure you control access to docker. If you are binding to a TCP port, anyone with access to that port has full Docker access; so it is not advisable on an open network.

.. warning::

   ``docker`` デーモンがバインドするデフォルトの TCP ポートや Unix docker ユーザ・グループの変更は、セキュリティ上の危険性を高めます。危険性とは、ホスト上の root 以外のユーザが root へのアクセスが可能になるかもしれません。 ``docker`` に対するアクセス管理を確実に行ってください。TCP ポートをバインドする場合、ポートにアクセス可能な誰もが Docker に対するフル・アクセスを可能にします。そのため、オープンなネットワーク上では望ましくありません。

.. With -H it is possible to make the Docker daemon to listen on a specific IP and port. By default, it will listen on unix:///var/run/docker.sock to allow only local connections by the root user. You could set it to 0.0.0.0:2375 or a specific host IP to give access to everybody, but that is not recommended because then it is trivial for someone to gain root access to the host where the daemon is running.

Docker デーモンに ``-H`` オプションを指定すると、特定の IP アドレスとポートをリッスンします。デフォルトでリッスンするのは ``unix:///var/run/docker.sock`` であり、root ユーザのみローカル接続可能です。誰もが接続可能とするには ``0.0.0.0:2375`` かホスト IP アドレスを指定しますが、 **非推奨です** 。デーモンを実行しているホストにアクセス可能であれば、誰もが root アクセスを得られるのと同じだからです。

.. Similarly, the Docker client can use -H to connect to a custom port. The Docker client will default to connecting to unix:///var/run/docker.sock on Linux, and tcp://127.0.0.1:2376 on Windows.

同様に、 Docker クライアントは ``-H`` を使い任意のポートに節即できます。 Docker クライアントはデフォルトで、Linux であれば ``unix:///var/run/docker.sock`` へ、Windows であれば ``tcp://127.0.0.1:2376`` に接続します。

.. -H accepts host and port assignment in the following format:

.. code-block:: bash

   tcp://[ホスト]:[ポート][パス] あるいは unix://パス

.. For example:

例：

..    tcp:// -> TCP connection to 127.0.0.1 on either port 2376 when TLS encryption is on, or port 2375 when communication is in plain text.
    tcp://host:2375 -> TCP connection on host:2375
    tcp://host:2375/path -> TCP connection on host:2375 and prepend path to all requests
    unix://path/to/socket -> Unix socket located at path/to/socket

* ``tcp://`` → ``127.0.0.1`` に接続。TLS 暗号化が有効であればポート ``2376`` を、平文の通信時はポート ``2375`` を使用。
* ``tcp://ホスト:2375`` → ホスト:2375  の TCP 接続。
* ``tcp://host:2375/path`` → ホスト:2375 の TCP 接続と、リクエストに追加パスが必要。
* ``unix://path/to/socket`` → ``path/to/socket`` にある Unix ソケット。

.. -H, when empty, will default to the same value as when no -H was passed in.

``-H`` の値がなければ、デフォルトでは ``-H`` を指定しなかった値になります。

.. -H also accepts short form for TCP bindings:

``-H`` は TCP バインドの指定を短縮できます。

.. code-block:: bash

   ``host:` あるいは `host:port` あるいは `:port`

.. Run Docker in daemon mode:

Docker をデーモン・モードで実行するには：

.. code-block:: bash

   $ sudo <path to>/dockerd -H 0.0.0.0:5555 &

.. Download an ubuntu image:

``ubuntu`` イメージをダウンロードするには：

.. code-block:: bash

   $ docker -H :5555 pull ubuntu

.. You can use multiple -H, for example, if you want to listen on both TCP and a Unix socket

複数の ``-H`` を指定できます。たとえば、TCP と Unix ソケットの両方をリッスンするには、次のようにします。

.. code-block:: bash

   # docker をデーモン・モードで実行
   $ sudo <path to>/dockerd -H tcp://127.0.0.1:2375 -H unix:///var/run/docker.sock &
   # デフォルトの Unix ソケットを使い、 ubuntu イメージのダウンロード
   $ docker pull ubuntu
   # あるいは、TCP ポートを使用
   $ docker -H tcp://127.0.0.1:2375 pull ubuntu

.. Daemon storage-driver option

.. _daemon-storage-driver-option:

デーモンのストレージ・ドライバ用オプション
--------------------------------------------------

.. The Docker daemon has support for several different image layer storage drivers: aufs, devicemapper, btrfs, zfs and overlay.

Docker デーモンはイメージ・レイヤ用途に、様々に異なるストレージ・ドライバの利用をサポートします。ドライバは、 ``aufs`` 、 ``devicemapper`` 、 ``btrfs`` 、 ``zfs`` 、 ``overlay`` 、 ``overlay2`` です。

.. The aufs driver is the oldest, but is based on a Linux kernel patch-set that is unlikely to be merged into the main kernel. These are also known to cause some serious kernel crashes. However, aufs is also the only storage driver that allows containers to share executable and shared library memory, so is a useful choice when running thousands of containers with the same program or libraries.

最も古いドライバは ``aufs`` であり、Linux カーネルに対するパッチ群が基になっています。ドライバにはメイン・カーネルにマージされなかったコードも含まれます。そのため、深刻なカーネルのクラッシュを引き起こすのが分かっています。一方で、 ``aufs`` はコンテナの共有実行と共有ライブラリ・メモリが使える唯一のストレージ・ドライバです。そのため、同じプログラムやライブラリで数千ものコンテナを実行する時は便利な選択でしょう。

.. The devicemapper driver uses thin provisioning and Copy on Write (CoW) snapshots. For each devicemapper graph location -- typically /var/lib/docker/devicemapper -- a thin pool is created based on two block devices, one for data and one for metadata. By default, these block devices are created automatically by using loopback mounts of automatically created sparse files. Refer to Storage driver options below for a way how to customize this setup. ~jpetazzo/Resizing Docker containers with the Device Mapper plugin article explains how to tune your existing setup without the use of options.

``devicemapper`` ドライバはシン・プロビジョニング（thin provisioning）とコピー・オン・ライト（Copy on Write）スナップショットを使います。devicemapper の各グラフ（graph）がある典型的な場所は ``/var/lib/docker/devicemapper`` です。シン（thin）プールは２つのブロックデバイス上に作ります。１つはデータで、もう１つはメタデータです。デフォルトでは、別々のファイルとして自動作成したループバックのマウントを元に、これらのブロック・デバイスを自動的に作成します。セットアップのカスタマイズ方法は、以下にある :ref:`ストレージ・ドライバのオプション <storage-driver-options>` をご覧ください。オプションを使わない設定方法は `jpetazzo/Resizing Docker containers with the Device Mapper plugin <http://jpetazzo.github.io/2014/01/29/docker-device-mapper-resize/>`_ の記事に説明があります。

.. The btrfs driver is very fast for docker build - but like devicemapper does not share executable memory between devices. Use dockerd -s btrfs -g /mnt/btrfs_partition.

``btrfs`` ドライバは ``docker build`` が非常に高速です。しかし、 ``devicemapper`` のようにデバイス間の実行メモリを共有しません。使うには ``dockerd -s btrfs -g /mnt/btrfs_partition`` を実行します。

.. The zfs driver is probably not as fast as btrfs but has a longer track record on stability. Thanks to Single Copy ARC shared blocks between clones will be cached only once. Use dockerd -s zfs. To select a different zfs filesystem set zfs.fsname option as described in Storage driver options.

``zfs`` ドライバは ``btrfs`` ほど速くありませんが、安定さのためレコードを長く追跡します。 ``Single Copy ARC`` のおかげで、クローン間の共有ブロックを１度キャッシュします。使うには ``dockerd -s zfs`` を指定します。異なる zfs ファイルシステムセットを選択するには、 ``zfs.fsname`` オプションを  :ref:`ストレージ・ドライバのオプション <storage-driver-options>` で指定します。

.. The overlay is a very fast union filesystem. It is now merged in the main Linux kernel as of 3.18.0. Call dockerd -s overlay to use it.

``overlay`` は非常に高速なユニオン・ファイル・システムです。ようやく Linux カーネル `3.18.0 <https://lkml.org/lkml/2014/10/26/137>`_ でメインにマージされました。使うには ``dockerd -s overlay`` を指定します。

..    Note: As promising as overlay is, the feature is still quite young and should not be used in production. Most notably, using overlay can cause excessive inode consumption (especially as the number of images grows), as well as being incompatible with the use of RPMs.


.. note::

   前途有望な ``overlay`` ですが、機能がまだ若く、プロダクションで使うべきではありません。特に  ``overlay`` を使うと過度の inode 消費を引き起こします（特にイメージが大きく成長する場合）。また、RPM との互換性がありません。

..    Note: Both `overlay` and `overlay2` are currently unsupported on `btrfs` or any Copy on Write filesystem and should only be used over `ext4` partitions.

.. The overlay2 uses the same fast union filesystem but takes advantage of additional features added in Linux kernel 4.0 to avoid excessive inode consumption. Call dockerd -s overlay2 to use it.

``overlay2`` は同じ高速なユニオン・ファイルシステムを使いますが、Linux カーネル 4.0 で追加された `追加機能 <https://lkml.org/lkml/2015/2/11/106>`_ を使います。これは過度のｉノード消費を防ぐものです。使うには ``dockerd -s overlay2`` を実行します。

.. note::

  ``overlay`` や ``overlay2`` および、現時点でサポートされていない ``btrfs`` や他のコピー・オン・ライトのファイルシステムは、 ``ext4`` パーティション上のみで使うべきです。

.. Storage driver options

.. _storage-driver-options:

ストレージ・ドライバのオプション
----------------------------------------

.. Particular storage-driver can be configured with options specified with --storage-opt flags. Options for devicemapper are prefixed with dm and options for zfs start with zfs and options for btrfs start with btrfs.

個々のストレージドライバは ``--storage-opt`` フラグでオプションを設定できます。 ``devicemapper`` 用のオプションは ``dm`` で始まり、 ``zfs`` 用のオプションは ``zfs`` で始まります。また ``btrfs`` 用のオプションは ``btrfs``  で始まります。

.. _devicemapper-options:

devicemapper のオプション
------------------------------

..    dm.thinpooldev

* ``dm.thinpooldev``

..    Specifies a custom block storage device to use for the thin pool.

シン・プール用に使うカスタム・ブロックストレージ・デバイスを指定します。

..    If using a block device for device mapper storage, it is best to use lvm to create and manage the thin-pool volume. This volume is then handed to Docker to exclusively create snapshot volumes needed for images and containers.

ブロック・デバイスをデバイスマッパー・ストレージに指定する場合は、``lvm`` を使うシン・プール・ボリュームの作成・管理がベストです。その後、このボリュームは Docker により、イメージまたはコンテナで、排他的なスナップショット用ボリュームを作成するために使われます。

..    Managing the thin-pool outside of Engine makes for the most feature-rich method of having Docker utilize device mapper thin provisioning as the backing storage for Docker containers. The highlights of the lvm-based thin-pool management feature include: automatic or interactive thin-pool resize support, dynamically changing thin-pool features, automatic thinp metadata checking when lvm activates the thin-pool, etc.

シン・プールの管理を Docker Engine の外で行うため、最も機能豊富な手法をもたらします。Docker コンテナの背後にあるストレージとして、Docker はデバイスマッパーによる シン・プロビジョニングを活用するからです。lvm をベースにしたシン・プール管理機能に含まれるハイライトは、自動もしくはインタラクティブなシン・プールの容量変更のサポートです。動的にシン・プールを変更する機能とは、lvm が シン・プールをアクティブにする時、自動的にメタデータのチェックを行います。

..    As a fallback if no thin pool is provided, loopback files are created. Loopback is very slow, but can be used without any pre-configuration of storage. It is strongly recommended that you do not use loopback in production. Ensure your Engine daemon has a --storage-opt dm.thinpooldev argument provided.

シン・プールが割り当てられ無ければフェイルバックします。この時、ループバックのファイルが作成されます。ループバックは非常に遅いものですが、ストレージの再設定を行わなくても利用可能になります。プロダクション環境においては、ループバックを使わないよう強く推奨します。Docker Engine デーモンで ``--storage-opt dm.thinpooldev`` の指定があるのを確認してください。

..    Example use:

使用例：

.. code-block:: bash

   $ dockerd \
         --storage-opt dm.thinpooldev=/dev/mapper/thin-pool

* ``dm.basesize``

..    Specifies the size to use when creating the base device, which limits the size of images and containers. The default value is 100G. Note, thin devices are inherently “sparse”, so a 100G device which is mostly empty doesn’t use 100 GB of space on the pool. However, the filesystem will use more space for the empty case the larger the device is.

ベース・デバイス作成時の容量を指定します。これはイメージとコンテナのサイズの上限にあたります。デフォルトの値は 10GB です。シン・デバイスは本質的に「希薄」（sparse）なのを覚えて置いてください。そのため、10GB のデバイスの大半が空白で未使用だったとしても、10GB の領域がプールされます。しかしながら、ファイルシステムがより大きなデバイスであれば、空白としても多くの容量を使う可能性があるでしょう。

.. The base device size can be increased at daemon restart which will allow all future images and containers (based on those new images) to be of the new base device size.

以後のイメージや（イメージを元にする）コンテナが利用可能となる新しいベース・デバイス容量を増やしたい場合は、デーモンの再起動で変更できます。

.. Example use:

使用例：

.. code-block:: bash

   $ dockerd --storage-opt dm.basesize=50G

.. This will increase the base device size to 50G. The Docker daemon will throw an error if existing base device size is larger than 50G. A user can use this option to expand the base device size however shrinking is not permitted.

これはベース・デバイス容量を 50GB に増やしています。Docker デーモンはこのベース・イメージの容量が 50GB よりも大きくなるとエラーを投げます。ユーザはこのオプションを使ってベース・デバイス容量を拡張できますが、縮小はできません。

..    This value affects the system-wide “base” empty filesystem that may already be initialized and inherited by pulled images. Typically, a change to this value requires additional steps to take effect:

システム全体の「ベース」となる空白のファイルシステムに対して、設定値が影響を与えます。これは、既に初期化されているか、取得しているイメージから継承している場合です。とりわけ、この値の変更時には、反映するにために追加手順が必要です。

.. code-block:: bash

   $ sudo service docker stop
   $ sudo rm -rf /var/lib/docker
   $ sudo service docker start

..    Example use:

使用例：

.. code-block:: bash

   $ dockerd --storage-opt dm.basesize=20G

* ``dm.loopdatasize``

..        Note: This option configures devicemapper loopback, which should not be used in production.

.. note::

   この設定はデバイスマッパーのループバックを変更するものです。プロダクションで使うべきではありません。

..    Specifies the size to use when creating the loopback file for the “data” device which is used for the thin pool. The default size is 100G. The file is sparse, so it will not initially take up this much space.

「データ」デバイスがシン・プール用に使うためのループバック・ファイルの作成時、この容量の指定に使います。デフォルトの容量は 100GB です。ファイルは希薄なため、初期段階ではさほど容量を使いません。

..    Example use:

使用例：

.. code-block:: bash

   $ dockerd --storage-opt dm.loopdatasize=200G

* ``dm.loopmetadatasize``

..        Note: This option configures devicemapper loopback, which should not be used in production.

.. note::

   この設定はデバイスマッパーのループバックを変更するものです。プロダクションで使うべきではありません。

..    Specifies the size to use when creating the loopback file for the “metadata” device which is used for the thin pool. The default size is 2G. The file is sparse, so it will not initially take up this much space.

「メタデータ」デバイスがシン・プール用に使うためのループバック・ファイルの作成時、この容量の指定に使います。デフォルトの容量は 2GB です。ファイルは希薄なため、初期段階ではさほど容量を使いません。

..    Example use:

使用例：

   $ dockerd --storage-opt dm.loopmetadatasize=4G

* ``dm.fs``

..    Specifies the filesystem type to use for the base device. The supported options are “ext4” and “xfs”. The default is “xfs”

ベース・デバイスで使用するファイルシステムの種類を指定します。サポートされているオプションは「ext4」と「xfs」です。デフォルトは「xfs」です。

..    Example use:

使用例：

.. code-block:: bash

   $ dockerd --storage-opt dm.fs=ext4

* ``dm.mkfsarg``

..    Specifies extra mkfs arguments to be used when creating the base device.

ベース・デバイスの作成時に mkfs に対する追加の引数を指定します。

..    Example use:

使用例：

.. code-block:: bash

   $ dockerd --storage-opt "dm.mkfsarg=-O ^has_journal"

* ``dm.mountopt``

..    Specifies extra mount options used when mounting the thin devices.

シン・デバイスをマウントする時に使う、追加マウントオプションを指定します。

..    Example use:

使用例：

   $ dockerd --storage-opt dm.mountopt=nodiscard

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

   $ dockerd \
         --storage-opt dm.datadev=/dev/sdb1 \
         --storage-opt dm.metadatadev=/dev/sdc1

* ``dm.metadatadev``

..    (Deprecated, use dm.thinpooldev)

（廃止されました。 ``dm.thinpooldev`` をお使いください ）

..     Specifies a custom blockdevice to use for metadata for the thin pool.

シン・プール用のブロック・デバイスが使うメタデータを指定します。

..    For best performance the metadata should be on a different spindle than the data, or even better on an SSD.

最も性能の高いメタデータとは、データとは軸が異なる場所にあるものです。 SSD を使うのが望ましいでしょう。

..    If setting up a new metadata pool it is required to be valid. This can be achieved by zeroing the first 4k to indicate empty metadata, like this:

新しいメタデータ・プールのセットアップには有効化が必要です。次のように、ゼロ値を使い、始めから 4096 まで空白のメタデータを作ります。

.. code-block:: bash

   $ dd if=/dev/zero of=$metadata_dev bs=4096 count=1

..    Example use:

使用例：

.. code-block:: bash

   $ dockerd \
         --storage-opt dm.datadev=/dev/sdb1 \
         --storage-opt dm.metadatadev=/dev/sdc1

* ``dm.blocksize``

..    Specifies a custom blocksize to use for the thin pool. The default blocksize is 64K.

シン・プールで使うカスタム・ブロックサイズを指定します。デフォルトのブロックサイズは 64K です。

..    Example use:

使用例：

.. code-block:: bash

   $ dockerd --storage-opt dm.blocksize=512K

* ``dm.blkdiscard``

..    Enables or disables the use of blkdiscard when removing devicemapper devices. This is enabled by default (only) if using loopback devices and is required to resparsify the loopback file on image/container removal.

デバイスマッパー・デバイスの削除時に blkdiscard を使うか使わないかを指定します。デフォルトは有効であり、ループバック・デバイスを使っているのであれば、イメージやコンテナ削除時にループバック・ファイルを再希薄化させるために使います。

..    Disabling this on loopback can lead to much faster container removal times, but will make the space used in /var/lib/docker directory not be returned to the system for other use when containers are removed.

このループバックを無効にしたら、コンテナの削除時間がより早くなります。しかし、 ``/var/lib/docker`` ディレクトリで使用している領域量は、コンテナが削除された時点で使っていた領域を返してしまいます。

..    Example use:

使用例：

.. code-block:: bash

   $ dockerd --storage-opt dm.blkdiscard=false

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

``docker`` デーモンの起動時に有効にするには、 ``udev`` 同期をサポートしているかどうかに拘わらず、 ``dm.override_udev_sync_check`` を true にします。

.. code-block:: bash

   $ dockerd --storage-opt dm.override_udev_sync_check=true

..    When this value is true, the devicemapper continues and simply warns you the errors are happening.

この値が ``true`` の場合、 ``devicemapper`` はエラーが発生しても簡単に警告を表示するだけで、処理を継続します。

..        Note: The ideal is to pursue a docker daemon and environment that does support synchronizing with udev. For further discussion on this topic, see docker#4036. Otherwise, set this flag for migrating existing Docker daemons to a daemon with a supported environment.

.. note::

   ``docker`` デーモンと環境を追跡するという考えは、 ``udev`` の同期機能をサポートするためのものでした。このトピックに関しては `docker#4036 <https://github.com/docker/docker/issues/4036>`_ をご覧ください。一方で、既存の Docker デーモンを、サポートされている別の環境に移行する時のフラグとしても使います。

* ``dm.use_deferred_removal``

..    Enables use of deferred device removal if libdm and the kernel driver support the mechanism.

``libdm`` やカーネル・ドライバがサポートしている仕組みがあれば、デバイス削除の遅延を有効化します。

..    Deferred device removal means that if device is busy when devices are being removed/deactivated, then a deferred removal is scheduled on device. And devices automatically go away when last user of the device exits.

デバイス削除の遅延が意味するのは、デバイスを無効化・非アクティブ化しようとしてもビジー（使用中）であれば、デバイス上で遅延削除が予定されます。そして、最後にデバイスを使っているユーザが終了したら、自動的に削除します。

..    For example, when a container exits, its associated thin device is removed. If that device has leaked into some other mount namespace and can’t be removed, the container exit still succeeds and this option causes the system to schedule the device for deferred removal. It does not wait in a loop trying to remove a busy device.

例えば、コンテナを終了したら、関連づけられているシン・デバイスも削除されます。デバイスが他のマウント名前空間も利用しているの場合は、削除できません。コンテナの終了が成功したら、このオプションが有効であれば、システムがデバイスの遅延削除をスケジュールします。使用中のデバイスが削除できるまで、ループを繰り返すことはありません。

..    Example use:

使用例：

.. code-block:: bash

    $ dockerd --storage-opt dm.use_deferred_removal=true

* ``dm.use_deferred_deletion``

..    Enables use of deferred device deletion for thin pool devices. By default, thin pool device deletion is synchronous. Before a container is deleted, the Docker daemon removes any associated devices. If the storage driver can not remove a device, the container deletion fails and daemon returns.

シン・プール用デバイスの遅延削除を有効化するのに使います。デフォルトでは、シン・プールの削除は同期します。コンテナを削除する前に、Docker デーモンは関連するデバイスを削除します。ストレージ・ドライバがデバイスを削除できなければ、コンテナの削除は失敗し、デーモンはエラーを表示します。

..    Error deleting container: Error response from daemon: Cannot destroy container

..    To avoid this failure, enable both deferred device deletion and deferred device removal on the daemon.

この失敗を避けるには、デバイス遅延削除（deletion）と、デバイス遅延廃止（removal）をデーモンで有効化します。

.. code-block:: bash

   $ dockerd \
         --storage-opt dm.use_deferred_deletion=true \
         --storage-opt dm.use_deferred_removal=true

..    With these two options enabled, if a device is busy when the driver is deleting a container, the driver marks the device as deleted. Later, when the device isn’t in use, the driver deletes it.

この２つのオプションが有効であれば、ドライバがコンテナを削除する時にデバイスが使用中でも、ドライバはデバイスを削除対象としてマークします。その後、デバイスが使えなくなったら、ドライバはデバイスを削除します。

..    In general it should be safe to enable this option by default. It will help when unintentional leaking of mount point happens across multiple mount namespaces.

通常、安全のためにデフォルトでこのオプションを有効化すべきです。複数のマウント名前空間にまたがり、マウントポイントの意図しないリークが発生した時に役立つでしょう。

* ``dm.min_free_space``

..    Specifies the min free space percent in a thin pool require for new device creation to succeed. This check applies to both free data space as well as free metadata space. Valid values are from 0% - 99%. Value 0% disables free space checking logic. If user does not specify a value for this option, the Engine uses a default value of 10%.

シン・プールが新しいデバイスを正常に作成するために必要な最小ディスク空き容量を、パーセントで指定します。チェックはデータ領域とメタデータ領域の両方に適用します。有効な値は 0% ~ 99% です。値を 0% に指定すると空き領域のチェック機構を無効にします。ユーザがオプションの値を指定しなければ、Engine はデフォルト値 10% を用います。

..    Whenever a new a thin pool device is created (during docker pull or during container creation), the Engine checks if the minimum free space is available. If sufficient space is unavailable, then device creation fails and any relevant docker operation fails.

新しいシン・プール用デバイスを作成すると（ ``docker pull`` 時やコンテナの作成時 ）、すぐに Engine は最小空き容量を確認します。十分な領域がなければデバイスの作成は失敗し、対象の ``docker`` オプションは失敗します。

..    To recover from this error, you must create more free space in the thin pool to recover from the error. You can create free space by deleting some images and containers from the thin pool. You can also add more storage to the thin pool.

このエラーから復帰するには、エラーが出なくなるようシン・プール内の空き容量を増やす必要があります。シン・プールかにある同じイメージやコンテナを削除することで、空き容量を増やせます。

..    To add more space to a LVM (logical volume management) thin pool, just add more storage to the volume group container thin pool; this should automatically resolve any errors. If your configuration uses loop devices, then stop the Engine daemon, grow the size of loop files and restart the daemon to resolve the issue.

LVM (Logical Volume Management；論理ボリューム管理) シン・プールの容量を増やすには、コンテナのシン・プールのボリューム・グループに対する領域を追加します。そうすると、エラーは出なくなります。もしループ・デバイスを使う設定であれば、Engine デーモンは停止します。この問題を解決するにはデーモンを再起動してループ・ファイルの容量を増やします。

..    Example use:

指定例：

.. code-block:: bash

   $ dockerd --storage-opt dm.min_free_space=10%

.. Currently supported options of zfs:

.. 現時点で ``zfs`` がサポートしているオプション：

.. _zfs-options:

ZFS オプション
--------------------

* ``zfs.fsname``

..    Set zfs filesystem under which docker will create its own datasets. By default docker will pick up the zfs filesystem where docker graph (/var/lib/docker) is located.

Docker が自身のデータセットとして、どの zfs ファイルシステムを使うか指定します。デフォルトの Docker は docker グラフ（ ``/var/lib/docker`` ）がある場所を zfs ファイルシステムとして用います。

..    Example use:

使用例：

.. code-block:: bash

   $ dockerd -s zfs --storage-opt zfs.fsname=zroot/docker

.. _btrfs-options:

Btrfs オプション
--------------------

* ``btrfs.min_space``

..    Specifies the mininum size to use when creating the subvolume which is used for containers. If user uses disk quota for btrfs when creating or running a container with --storage-opt size option, docker should ensure the size cannot be smaller than btrfs.min_space.

コンテナ用サブボリュームの作成時に、最小容量を指定します。コンテナに ``--storage-opt 容量`` オプションを指定して作成・実行する時、ユーザが btrfs のディスク・クォータを使っていれば、docker は ``btrfs.min_space`` より小さな ``容量`` を指定できないようにします。

..    Example use: $ docker daemon -s btrfs --storage-opt btrfs.min_space=10G


.. Docker runtime execution option

.. _docker-runtime-execution-option:

Docker ランタイム実行オプション
========================================

.. The Docker daemon relies on a OCI compliant runtime (invoked via the containerd daemon) as its interface to the Linux kernel namespaces, cgroups, and SELinux.

Docker デーモンは `OCI <https://github.com/opencontainers/specs>`_ 基準のランタイム（containerd デーモンの呼び出し）に基づいています。これに従いながら Linux カーネルの ``名前空間（namespaces）`` 、 ``コントロール・グループ（cgroups）`` 、 ``SELinux`` に対するインターフェースとして動作します。

.. Docker runtime execution options

.. _docker-runtime-execution-options:

Docker ランタイム実行オプション
========================================

.. The Docker daemon relies on a OCI compliant runtime (invoked via the containerd daemon) as its interface to the Linux kernel namespaces, cgroups, and SELinux.

Docker デーモンは `OCI <https://github.com/opencontainers/specs>`_ 規格のランタイムに依存します（ ``containerd`` デーモンを経由して呼び出します）。これが Linux カーネルの ``namespace`` 、 ``cgroups`` 、``SELinux`` のインターフェースとして働きます。

.. Runtimes can be registered with the daemon either via the configuration file or using the --add-runtime command line argument.

ランタイムはデーモンに登録できます。登録は設定ファイルを通してか、あるいは、コマンドラインの引数 ``--add-runtime``  を使います。

.. The following is an example adding 2 runtimes via the configuration:

以下の例は、設定ファイルを通して２つのランタイムを追加しています。

.. code-block:: json

       "default-runtime": "runc",
       "runtimes": {
           "runc": {
               "path": "runc"
           },
           "custom": {
               "path": "/usr/local/bin/my-runc-replacement",
               "runtimeArgs": [
                   "--debug"
               ]
           }
       }

.. This is the same example via the command line:

これは、コマンドライン上で次のように実行するのと同じです。

.. code-block:: bash

   $ sudo dockerd --add-runtime runc=runc --add-runtime custom=/usr/local/bin/my-runc-replacement

.. Note: defining runtime arguments via the command line is not supported.

.. note::

   ランタイム引数はコマンドラインを経由して定義できません（サポートされていません）。

.. Options for the runtime

.. _options-for-the-runtime:

ランタイム用のオプション
========================================

.. You can configure the runtime using options specified with the --exec-opt flag. All the flag’s options have the native prefix. A single native.cgroupdriver option is available.

ランタイムのオプションは ``--exec-opt`` フラグで指定できます。全てのオプションのフラグには、先頭に ``native`` が付きます。（現時点では）唯一 ``native.cgroupdriver`` オプションを利用可能です。

.. The native.cgroupdriver option specifies the management of the container’s cgroups. You can specify only specify cgroupfs or systemd. If you specify systemd and it is not available, the system errors out. If you omit the native.cgroupdriver option,cgroupfs is used.

``native.cgroupdriver`` オプションはコンテナの cgroups 管理を指定します。 ``systemd`` の ``cgroupfs`` で指定可能です。 ``systemd`` で指定時、対象が利用可能でなければ、システムはエラーを返します。 ``native.cgroupdriver`` オプションを指定しなければ ``cgroupfs`` を使います。

.. This example sets the cgroupdriver to systemd:

次の例は ``systemd`` に ``cgroupdriver``  を指定しています。

.. code-block:: bash

   $ sudo dockerd --exec-opt native.cgroupdriver=systemd

.. Setting this option applies to all containers the daemon launches.

このオプション設定は、デーモンが起動した全てのコンテナに対して適用します。

.. Also Windows Container makes use of --exec-opt for special purpose. Docker user can specify default container isolation technology with this, for example:

また、Windows コンテナであれば特別な目的のために ``--exec-opt`` を使えます。Docker がデフォルトで使うコンテナの分離技術の指定です。指定例：

.. code-block:: bash

   $ dockerd --exec-opt isolation=hyperv

.. Will make hyperv the default isolation technology on Windows, without specifying isolation value on daemon start, Windows isolation technology will default to process.

.. Will make hyperv the default isolation technology on Windows. If no isolation value is specified on daemon start, on Windows client, the default is hyperv, and on Windows server, the default is process.

この指定は Windows 上のデフォルト分離技術 ``hyperv`` を使います。デーモン起動時に分離技術の指定が無ければ、Windows クライアントはデフォルトで ``hyper-v`` を使い、Windows server はデフォルトで ``process`` を使います。


.. Daemon DNS options

.. _daemon-dns-options:

デーモンの DNS オプション
==============================

.. To set the DNS server for all Docker containers, use dockerd --dns 8.8.8.8.

全ての Docker コンテナ用の DNS サーバを設定するには、 ``dockerd --dns 8.8.8.8`` を使います。

.. To set the DNS search domain for all Docker containers, use dockerd --dns-search example.com.

全ての Docker コンテナ用の DNS 検索ドメインを設定するには、 ``dockerd --dns-search example.com`` を使います。

.. Insecure registries

.. _insecure-registries:

安全ではないレジストリ
==============================

.. Docker considers a private registry either secure or insecure. In the rest of this section, registry is used for private registry, and myregistry:5000 is a placeholder example for a private registry.

Docker はプライベート・レジストリが安全か否かを確認します。このセクションでは、 *レジストリ* として *プライベート・レジストリ (private registry)* を使い、例としてプライベート・レジストリが ``myregistry:5000`` で動作しているものとします。

.. A secure registry uses TLS and a copy of its CA certificate is placed on the Docker host at /etc/docker/certs.d/myregistry:5000/ca.crt. An insecure registry is either not using TLS (i.e., listening on plain text HTTP), or is using TLS with a CA certificate not known by the Docker daemon. The latter can happen when the certificate was not found under /etc/docker/certs.d/myregistry:5000/, or if the certificate verification failed (i.e., wrong CA).

安全なレジストリは、TLS を使い、CA 証明書のコピーが ``/etc/docker/certs.d/myregistry:5000/ca.crt`` にあります。安全ではないレジストリとは、TLS を使っていない場合（例：平文の HTTP をリッスン）や、TLS を使っていても Docker デーモンが知らない CA 証明書を使う場合を指します。後者であれば、証明書が ``/etc/docker/certs.d/myregistry:5000/`` 以下に存在しないか、証明書の照合に失敗しています（例：CA が違う）。

.. By default, Docker assumes all, but local (see local registries below), registries are secure. Communicating with an insecure registry is not possible if Docker assumes that registry is secure. In order to communicate with an insecure registry, the Docker daemon requires --insecure-registry in one of the following two forms:

デフォルトでは、Docker はローカルにあるレジストリ（以下のローカル・レジストリについてをご覧ください）は安全であるとみなします。Docker はレジストリが安全とみなさない限り、安全ではないレジストリとの通信はできません。安全ではないレジストリと通信できるようにするには、Docker デーモンに ``--insecure-registry`` という２つの形式のオプションが必要です。

..    --insecure-registry myregistry:5000 tells the Docker daemon that myregistry:5000 should be considered insecure.
..    --insecure-registry 10.1.0.0/16 tells the Docker daemon that all registries whose domain resolve to an IP address is part of the subnet described by the CIDR syntax, should be considered insecure.

* ``--insecure-registry myregistry:5000`` は、 Docker デーモンに対して myregistry:5000 が安全ではないと考えられると伝えます。
* ``--insecure-registry 10.1.0.0/16`` は 、Docker デーモンに対して、ドメインの逆引き時、CIDR 構文で記述した対象サブネット上に IP アドレスを持つ全てが安全ではないと伝えます。

.. The flag can be used multiple times to allow multiple registries to be marked as insecure.

このフラグは、複数のレジストリに対して安全ではないと複数回指定できます。

.. If an insecure registry is not marked as insecure, docker pull, docker push, and docker search will result in an error message prompting the user to either secure or pass the --insecure-registry flag to the Docker daemon as described above.

安全ではないレジストリを「安全ではない」と指定しなければ、 ``docker pull`` 、 ``docker push`` 、 ``docker search`` を実行してもエラーメッセージが帰ってきます。ユーザは安全なレジストリを使うか、あるいは先ほどのように ``--insecure-registry`` フラグで Docker デーモンに対して明示する必要があります。

.. Local registries, whose IP address falls in the 127.0.0.0/8 range, are automatically marked as insecure as of Docker 1.3.2. It is not recommended to rely on this, as it may change in the future.

IP アドレスが 127.0.0.0/8 の範囲にあるローカルのレジストリは、Docker 1.3.2 以降、自動的に安全ではないレジストリとしてマークされます。ですが、これを信用するのは推奨しません。将来のバージョンでは変更される可能性があります。

.. Enabling --insecure-registry, i.e., allowing un-encrypted and/or untrusted communication, can be useful when running a local registry. However, because its use creates security vulnerabilities it should ONLY be enabled for testing purposes. For increased security, users should add their CA to their system’s list of trusted CAs instead of enabling --insecure-registry.

``--insecure-registry`` を有効にするとは、暗号化されていない、あるいは信頼できない通信を可能にします。そのため、ローカル環境でのレジストリ実行には便利でしょう。しかし、セキュリティ上の脆弱性を生み出してしまうため、テスト目的のみで使うべきです。セキュリティを高めるには、 ``--insecure-registry`` を有効にするのではなく、信頼できる CA 機関が発行する CA を使うべきです。

.. Legacy Registries

.. _legacy-registries:

過去のレジストリ
====================

.. Enabling --disable-legacy-registry forces a docker daemon to only interact with registries which support the V2 protocol. Specifically, the daemon will not attempt push, pull and login to v1 registries. The exception to this is search which can still be performed on v1 registries.

``--disable-legacy-registry`` を有効にしたら、Docker は v2 プロトコルをサポートしているデーモンとしか通信しないように強制します。この指定によって、デーモンは v1 レジストリへの ``push`` 、 ``pull`` 、 ``login`` を阻止します。例外として、v1 レジストリでも ``search`` のみ実行できます。

.. Running a Docker daemon behind a HTTPS_PROXY

Docker デーモンを HTTPS_PROXY の背後で実行
==================================================

.. When running inside a LAN that uses a HTTPS proxy, the Docker Hub certificates will be replaced by the proxy’s certificates. These certificates need to be added to your Docker host’s configuration:

LAN の内部で ``HTTPS`` プロキシを使う場合、Docker Hub の証明書がプロキシの証明書に置き換えられます。これら証明書を、Docker ホストの設定に追加する必要があります。

..    Install the ca-certificates package for your distribution

1. 各ディストリビューションに対応する ``ca-certificates`` パッケージをインストールします。

..    Ask your network admin for the proxy’s CA certificate and append them to /etc/pki/tls/certs/ca-bundle.crt

2. ネットワーク管理者にプロキシの CA 証明書を訊ね、 ``/etc/pki/tls/certs/ca-bundle.crt`` に追加します。

..    Then start your Docker daemon with HTTPS_PROXY=http://username:password@proxy:port/ docker daemon. The username: and password@ are optional - and are only needed if your proxy is set up to require authentication.

3. Docker デーモンに ``HTTPS_PROXY=http://ユーザ名:パスワード@proxy:port/ dockerd`` を付けて起動します。 ``ユーザ名:`` と ``パスワード@`` はオプションです。そして、プロ指揮の認証設定も必要であれば追加します。

.. This will only add the proxy and authentication to the Docker daemon’s requests - your docker builds and running containers will need extra configuration to use the proxy

これは Docker デーモンのリクエストに対してプロキシと認証の設定を追加しただけです。 ``docker build`` でコンテナを実行する時は、プロキシを使うために更なる追加設定が必要です。

.. Default Ulimits

.. _default-ulimits:

Ulimits のデフォルト
====================

.. --default-ulimit allows you to set the default ulimit options to use for all containers. It takes the same options as --ulimit for docker run. If these defaults are not set, ulimit settings will be inherited, if not set on docker run, from the Docker daemon. Any --ulimit options passed to docker run will overwrite these defaults.

``--default-ulimit`` を使い、全てのコンテナに対するデフォルトの ``ulimit`` オプションを指定できます。これは ``docker run`` 時に ``--ulimit`` オプションを指定するのと同じです。デフォルトを設定しなければ、 ``ulimit`` 設定を継承します。 ``docker run`` 時に設定しななければ、Docker デーモンから継承します。``docker run`` 時のあらゆる ``--ulimit`` オプションは、デフォルトを上書きします。

.. Be careful setting nproc with the ulimit flag as nproc is designed by Linux to set the maximum number of processes available to a user, not to a container. For details please check the run reference.

``noproc`` と ``ulimit`` フラグを使う時は注意してください。 ``noproc`` は Linux がユーザに対して利用可能な最大プロセス数を設定するものであり、コンテナ向けではありません。詳細については、 :doc:`run` リファレンスをご確認ください。

.. Nodes discovery

.. _nodes-discovery:

ノードのディスカバリ（検出）
==============================

.. The --cluster-advertise option specifies the ‘host:port’ or interface:port combination that this particular daemon instance should use when advertising itself to the cluster. The daemon is reached by remote hosts through this value. If you specify an interface, make sure it includes the IP address of the actual Docker host. For Engine installation created through docker-machine, the interface is typically eth1.

``--cluster-advertise`` オプションは、 ``ホスト:ポート`` あるいは ``インターフェース:ポート`` の組み合わせを指定します。これは、この特定のデーモン・インスタンスがクラスタに自分自身の存在を伝える（advertising）ために使います。リモートホストに到達するデーモンの情報を、ここに指定します。インターフェースを指定する場合は、実際の Docker ホスト上の IP アドレスも含められます。例えば、 ``docker-machine`` を使ってインストールする時、典型的なインターフェースは ``eth1`` です。

.. The daemon uses libkv to advertise the node within the cluster. Some key-value backends support mutual TLS. To configure the client TLS settings used by the daemon can be configured using the --cluster-store-opt flag, specifying the paths to PEM encoded files. For example:

デーモンはクラスタ内のノードに存在を伝えるため、 `libkv <https://github.com/docker/libkv/>`_ を使います。キーバリュー・バックエンドは相互に TLS をサポートします。デーモンが使用するクライアント TLS の設定は ``--cluster-store-opt`` フラグを使い、PEM エンコード・ファイルのパスを指定します。実行例：

.. code-block:: bash

   dockerd \
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

キーバリュー・ストアのパスを指定します。指定しなければ、デフォルトの ``docker/nodes`` を使います。

.. Access authorization

.. _access-authorization:

アクセス認証
====================

.. Docker’s access authorization can be extended by authorization plugins that your organization can purchase or build themselves. You can install one or more authorization plugins when you start the Docker daemond using the --authorization-plugin=PLUGIN_ID option.

Docker のアクセス認証は認証プラグインの拡張であり、組織が組織自身で購入・構築できます。認証プラグイン（authorization plugin）を使うには、Docker ``daemond`` で ``--authorization-plugin=PLUGIN_ID`` オプションを使って起動します。

.. code-block:: bash

   dockerd --authorization-plugin=plugin1 --authorization-plugin=plugin2,...

.. The PLUGIN_ID value is either the plugin’s name or a path to its specification file. The plugin’s implementation determines whether you can specify a name or path. Consult with your Docker administrator to get information about the plugins available to you.

``PLUGIN_ID`` の値とは、プラグイン名かファイルのパスを指定します。どのプラグインを実装するかを決めるのは、名前またはパスです。あなたの Docker 管理者に対して、利用可能なプラグインの情報をお訊ねください。

.. Once a plugin is installed, requests made to the daemon through the command line or Docker’s remote API are allowed or denied by the plugin. If you have multiple plugins installed, at least one must allow the request for it to complete.

プラグインをインストール後は、コマンドラインや Docker のリモート API を実行する時、プラグインを許可するか許可しないかを選べます。複数のプラグインをインストールした場合は、最後の１つだけが処理されます。

.. For information about how to create an authorization plugin, see authorization plugin section in the Docker extend section of this documentation.

認証プラグインの作成方法については、この Docker ドキュメントの拡張に関するセクションにある :doc:`認証プラグイン </engine/extend/plugins_authorization>` をご覧ください。

.. Daemon user namespace option

.. _daemon-user-namespace-option:

デーモンのユーザ名前空間オプション
========================================

.. The Linux kernel user namespace support provides additional security by enabling a process, and therefore a container, to have a unique range of user and group IDs which are outside the traditional user and group range utilized by the host system. Potentially the most important security improvement is that, by default, container processes running as the root user will have expected administrative privilege (with some restrictions) inside the container but will effectively be mapped to an unprivileged uid on the host.

Linux カーネルの `ユーザ名前空間(user namespace)サポート <http://man7.org/linux/man-pages/man7/user_namespaces.7.html>`_  はプロセスに対する追加のセキュリティを提供します。これを使えば、コンテナでユーザ ID とグループ ID を使う場合、それをコンテナの外、つまり Docker ホスト上で使うユーザ ID とグループ ID のユニークな範囲を指定できます。これは重要なセキュリティ改善になる可能性があります。デフォルトでは、コンテナのプロセスは ``root`` ユーザとして動作しますので、コンテナ内で管理特権（と制限）を持っていることが予想されます。しかし、その影響はホスト上の権限の無い ``uid`` に対して割り当てられます。

.. When user namespace support is enabled, Docker creates a single daemon-wide mapping for all containers running on the same engine instance. The mappings will utilize the existing subordinate user and group ID feature available on all modern Linux distributions. The /etc/subuid and /etc/subgid files will be read for the user, and optional group, specified to the --userns-remap parameter. If you do not wish to specify your own user and/or group, you can provide default as the value to this flag, and a user will be created on your behalf and provided subordinate uid and gid ranges. This default user will be named dockremap, and entries will be created for it in /etc/passwd and /etc/group using your distro’s standard user and group creation tools.

ユーザ名前空間のサポートを有効化したら、Docker はデーモンが扱うマッピングを作成します。これは、同じ Engine のインスタンス上で実行する全コンテナと対応するものです。マッピングを使い、従属ユーザ（subordinate user）ID と従属グループ ID を活用します。この機能は最近の全ての Linux ディストリビューション上において利用可能です。 ``--userns-remap`` パラメータを指定することで、 ``/etc/subuid`` と ``/etc/subguid``  ファイルがユーザとオプションのグループ用に使われます。このフラグに自分でユーザとグループを指定しなければ、ここでは ``default`` が指定されます。 default のユーザとは ``dockremap`` と言う名前であり、各ディストリビューションの一般的なユーザとグループ作成ツールを使い、 ``/etc/passwd`` と ``/etc/group`` にエントリが追加されます。

..    Note: The single mapping per-daemon restriction is in place for now because Docker shares image layers from its local cache across all containers running on the engine instance. Since file ownership must be the same for all containers sharing the same layer content, the decision was made to map the file ownership on docker pull to the daemon’s user and group mappings so that there is no delay for running containers once the content is downloaded. This design preserves the same performance for docker pull, docker push, and container startup as users expect with user namespaces disabled.

.. note::

   現時点ではデーモンごとに１つしかマッピングしないいう制約があります。これは Engine インスタンス上で実行している全てのコンテナにまたがる共有イメージ・レイヤを Docker が共有しているためです。ファイルの所有者は、レイヤ内容を共有している全てのコンテナで共通の必要があるため、解決策としては ``docker pull`` の処理時、ファイル所有者をデーモンのユーザとグループに割り当てる（マッピングする）ことでした。そのため、イメージ内容をダウンロード後は遅延無くコンテナを起動できました。この設計は同じパフォーマンスを維持するため、 ``docker pull`` と ``docker push`` の実行時には維持されています。
   
.. Starting the daemon with user namespaces enabled

.. _starting-the-daemon-with-user-namespaces-enabled:

ユーザ名前空間を有効にしてデーモンを起動
----------------------------------------

.. To enable user namespace support, start the daemon with the --userns-remap flag, which accepts values in the following format

ユーザ名前空間のサポートを有効化するには、デーモン起動時に ``--userns-remap`` フラグを使います。以下のフォーマット形式が指定できます。

* uid
* uid:gid
* ユーザ名
* ユーザ名:グループ名

.. If numeric IDs are provided, translation back to valid user or group names will occur so that the subordinate uid and gid information can be read, given these resources are name-based, not id-based. If the numeric ID information provided does not exist as entries in /etc/passwd or /etc/group, daemon startup will fail with an error message.

整数値の ID を指定したら、有効なユーザ名かグループ名に交換されます。これにより、従属 uid と gid の情報が読み込まれ、指定されたこれらのリソースは ID ベースではなく名前ベースでとなります。 ``/etc/passwd`` や ``/etc/group`` にエントリが無い数値 ID 情報が指定された場合は、docker は起動せずにエラーを表示します。

.. Note: On Fedora 22, you have to touch the /etc/subuid and /etc/subgid files to have ranges assigned when users are created. This must be done before the --userns-remap option is enabled. Once these files exist, the daemon can be (re)started and range assignment on user creation works properly.

.. note::

   Fedora 22 では、ユーザ作成時に範囲を割り当てるために必要な ``/etc/subuid`` と ``/etc/subgid``  ファイルを ``touch`` コマンドで作成する必要があります。この作業は ``--usernsremap``  オプションを有効にする前に行わなくてはいけません。ファイルが存在していれば、ユーザが作成した処理が範囲で処理が適切に行われるよう、デーモンを（再）起動できます。

.. Example: starting with default Docker user management:

例：default の Docker ユーザ管理
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: bash

   $ dockerd --userns-remap=default

.. When default is provided, Docker will create - or find the existing - user and group named dockremap. If the user is created, and the Linux distribution has appropriate support, the /etc/subuid and /etc/subgid files will be populated with a contiguous 65536 length range of subordinate user and group IDs, starting at an offset based on prior entries in those files. For example, Ubuntu will create the following range, based on an existing user named user1 already owning the first 65536 range:

``default`` を指定したら、 Docker は ``dockermap`` というユーザ名とグループ名が存在しているかどうか確認し、無ければ作成します。ユーザを作成したら、 Linux ディストリビューションは ``/etc/subuid`` と ``/etc/subgid`` ファイルの使用をサポートします。これは従属ユーザ ID と従属グループ ID を 65536 まで数える（カウントする）もので、これらは既存のファイルへのエントリをオフセットに使います。例えば、Ubuntu は次のような範囲を作成します。既存の ``user1`` という名前のユーザは、既に 65536 までの範囲を持っています。

.. code-block:: bash

   $ cat /etc/subuid
   user1:100000:65536
   dockremap:165536:65536


.. If you have a preferred/self-managed user with subordinate ID mappings already configured, you can provide that username or uid to the --userns-remap flag. If you have a group that doesn’t match the username, you may provide the gid or group name as well; otherwise the username will be used as the group name when querying the system for the subordinate group ID range.

もしも、既に自分で行った従属ユーザの設定を使いたい場合は、 ``--userns-remap`` フラグにユーザ名または UID を指定します。グループがユーザ名と一致しない場合は、同様に ``gid`` やグループ名も指定します。そうしなければ、従属グループ ID の範囲をシステムが応答する時に、ユーザ名がグループ名として使われます。

.. Detailed information on subuid/subgid ranges

.. _detailed-information-on-subuid-subgid-ranges:

``subuid`` / ``subgid`` 範囲についての詳細情報
--------------------------------------------------

.. Given potential advanced use of the subordinate ID ranges by power users, the following paragraphs define how the Docker daemon currently uses the range entries found within the subordinate range files.

パワーユーザであれば、従属 ID の範囲変更という高度な使い方があります。以下で扱うのは、現在どのようにして Docker デーモンが従属範囲のファイルから範囲を決めているかの定義です。

.. The simplest case is that only one contiguous range is defined for the provided user or group. In this case, Docker will use that entire contiguous range for the mapping of host uids and gids to the container process. This means that the first ID in the range will be the remapped root user, and the IDs above that initial ID will map host ID 1 through the end of the range.

最も簡単なケースは、ユーザとグループに対する近接範囲（contiguous range）を１つだけ指定する場合です。この例では、Docker はコンテナのプロセスに対し、ホスト側の uid と gid の全てを近接範囲として割り当て（マッピングし）ます。つまり、範囲において一番始めに割り当てるのが root ユーザです。この ID が初期 ID として、（ホスト側）範囲における最後をホスト ID 1 として（コンテナ側に）割り当てます。

.. From the example /etc/subuid content shown above, the remapped root user would be uid 165536.

先ほど取り上げた ``/etc/subuid`` の例では、root ユーザに再割り当てする uid は 165536 になります。

.. If the system administrator has set up multiple ranges for a single user or group, the Docker daemon will read all the available ranges and use the following algorithm to create the mapping ranges:

システム管理者は単一のユーザまたはグループに対して複数の範囲を設定できます。Docker デーモンは利用可能な範囲から、以下のアルゴリズムに基づき範囲を割り当てます。

..    The range segments found for the particular user will be sorted by start ID ascending.

1. 特定ユーザに対する範囲のセグメント（区分）が見つれば、開始 ID を昇順でソートします。

..    Map segments will be created from each range in increasing value with a length matching the length of each segment. Therefore the range segment with the lowest numeric starting value will be equal to the remapped root, and continue up through host uid/gid equal to the range segment length. As an example, if the lowest segment starts at ID 1000 and has a length of 100, then a map of 1000 -> 0 (the remapped root) up through 1100 -> 100 will be created from this segment. If the next segment starts at ID 10000, then the next map will start with mapping 10000 -> 101 up to the length of this second segment. This will continue until no more segments are found in the subordinate files for this user.

2. セグメントの割り当てには、各セグメントの長さに一致するよう、範囲の値を増やします。そうすると、セグメントの範囲は最も低い数値から始まり、これを root として再割り当てし、あとはホスト側の uid/gid と一致する範囲まで繰り返します。例えば、最小セグメントの ID が 1000 から始まり、長さが 100 としたら、 1000 を 0 にマップし（root として再マップ）ます。これを対象セグメントでは 1100 が 100 にマップするまで続けます。次のセグメントは ID 10000 から始まる場合、次は 10000 が 101 にマップし、その長さの分だけ処理します。この処理を対象ユーザのサボーディネート（従属）ファイルに空きセグメントが無くなるまで繰り返します。

..    If more than five range segments exist for a single user, only the first five will be utilized, matching the kernel’s limitation of only five entries in /proc/self/uid_map and proc/self/gid_map.

3. ユーザ向けのセグメント範囲が無くなった場合は、カーネルで５つまで使えるよう制限されているエントリ ``/proc/self/uid_map`` と ``/proc/self/gid_map`` が使えます。

.. Disable user namespace for a container

.. _disable-user-namespace-for-a-container:

コンテナ用のユーザ名前空間を無効化
----------------------------------------

.. If you enable user namespaces on the daemon, all containers are started with user namespaces enabled. In some situations you might want to disable this feature for a container, for example, to start a privileged container (see user namespace known restrictions). To enable those advanced features for a specific container use --userns=host in the run/exec/create command. This option will completely disable user namespace mapping for the container’s user.

デーモンでユーザ名前空間を有効にしたら、全てのコンテナはユーザ名前空間が有効な状態で起動します。状況によってはコンテナに対するユーザ名前空間を無効化したい時があるでしょう。例えば、特権コンテナ（privileged container）の起動時です（詳細は  :ref:`user-namespace-known-restrictions` をご覧ください ）。これらの高度な機能を使うには、コンテナの ``run`` ``exec`` ``create`` コマンド実行時に ``--userns=host`` を指定します。このオプションを使えばコンテナの利用者に対するユーザ名前空間の割り当てを完全に無効化します。


.. User namespace known restrictions:

.. _user-namespace-known-restrictions:

ユーザ名前空間と既知の制限
------------------------------

.. The following standard Docker features are currently incompatible when running a Docker daemon with user namespaces enabled:

Docker デーモンのユーザ名前空間を有効にした状態では、以下の Docker 標準機能は互換性がありません。

..    sharing PID or NET namespaces with the host (--pid=host or --net=host)
    A --readonly container filesystem (this is a Linux kernel restriction against remounting with modified flags of a currently mounted filesystem when inside a user namespace)
    external (volume or graph) drivers which are unaware/incapable of using daemon user mappings
    Using --privileged mode flag on docker run (unless also specifying --userns=host)

* ホスト・モードにおける PID 名前空間または NET 名前空間（ ``--pid=host`` あるいは ``--net=host`` ）
* ``--readonly`` コンテナ・ファイルシステム（ユーザ名前空間内において、現在のマウント・ファイルシステムのフラグを変更してリマウントすることは、Linux カーネルの制約によりできません）
* デーモンが知らない／機能を持たない外部ドライバ（ボリュームやグラフ）をユーザ名前空間内で実行
* ``docker run`` で ``--privileged`` モードのフラグを指定（また ``--userns=host`` も指定できません ）

.. In general, user namespaces are an advanced feature and will require coordination with other capabilities. For example, if volumes are mounted from the host, file ownership will have to be pre-arranged if the user or administrator wishes the containers to have expected access to the volume contents.

一般的に、ユーザ名前空間は高度な機能であり、他の機能との調整を必要とします。例えば、ホストにボリュームをマウントするときは、ファイルの所有者はユーザもしくは管理者がボリューム・コンテナにアクセスできるよう、あらかじめ調整しておきます。

.. Finally, while the root user inside a user namespaced container process has many of the expected admin privileges that go along with being the superuser, the Linux kernel has restrictions based on internal knowledge that this is a user namespaced process. The most notable restriction that we are aware of at this time is the inability to use mknod. Permission will be denied for device creation even as container root inside a user namespace.

最後に、ユーザ名前空間に対応したコンテナ・プロセス内の ``root`` ユーザとは、多くの管理特権を持っていると考えるかもしれません。ですが、Linux カーネルは内部情報に基づきユーザ名前空間内のプロセスとして制限を施します。現時点で最も注意が必要な制約は ``mknod`` の使用です。コンテナ内のユーザ名前空間では ``root`` であったとしてもデバイス作成の権限がありません。

.. Miscellaneous options

.. _miscellaneous-options:

その他のオプション
====================

.. IP masquerading uses address translation to allow containers without a public IP to talk to other machines on the Internet. This may interfere with some network topologies and can be disabled with --ip-masq=false.

IP マスカレードはコンテナがパブリック IP を持っていなくても、インターネット上の他のマシンと通信するための仕組みです。これにより、インターフェースは複数のネットワーク・トポロジを持ちますが、 ``--ip-masq=false`` を使って無効化できます。

.. Docker supports softlinks for the Docker data directory (/var/lib/docker) and for /var/lib/docker/tmp. The DOCKER_TMPDIR and the data directory can be set like this:

Docker は Docker データ・ディレクトリ（ ``/var/lib/docker`` ）と ``/var/lib/docker/tmp``  に対するソフトリンクをサポートしています。 ``DOCKER_TMPDIR`` を使っても、データディレクトリを次のように指定可能です。

.. code-block:: bash

   DOCKER_TMPDIR=/mnt/disk2/tmp /usr/local/bin/docker daemon -D -g /var/lib/docker -H unix:// > /var/lib/docker-machine/docker.log 2>&1
   # あるいは
   export DOCKER_TMPDIR=/mnt/disk2/tmp
   /usr/local/bin/dockerd -D -g /var/lib/docker -H unix:// > /var/lib/docker-machine/docker.log 2>&1

.. Default cgroup parent

.. _default-cgroup-parent:

デフォルトの親 cgroup
==============================

.. The --cgroup-parent option allows you to set the default cgroup parent to use for containers. If this option is not set, it defaults to /docker for fs cgroup driver and system.slice for systemd cgroup driver.

``--cgroup-parent`` オプションは、コンテナがデフォルトで使う親 cgroup （cgroup parent）を指定できます。オプションを設定しなければ、 ``/docker`` を fs cgroup ドライバとして使います。また ``system.slice`` を systemd cgroup ドライバとして使います。

.. If the cgroup has a leading forward slash (/), the cgroup is created under the root cgroup, otherwise the cgroup is created under the daemon cgroup.

cgroup はスラッシュ記号（ ``/`` ）で始まるルート cgroup の下に作成されますが、他の cgroup は daemon cgroup の下に作成されます。

.. Assuming the daemon is running in cgroup daemoncgroup, --cgroup-parent=/foobar creates a cgroup in /sys/fs/cgroup/memory/foobar, whereas using --cgroup-parent=foobar creates the cgroup in /sys/fs/cgroup/memory/daemoncgroup/foobar

デーモンが cgroup ``daemoncgroup`` で実行されており、``--cgroup-parent=/foobar`` で ``/sys/fs/cgroup/memory/foobar`` の中に cgroup を作成したと仮定時、 ``--cgroup-parent=foobar`` は ``/sys/fs/cgroup/memory/daemoncgroup/foobar`` に cgroup を作成します。

.. The systemd cgroup driver has different rules for --cgroup-parent. Systemd represents hierarchy by slice and the name of the slice encodes the location in the tree. So --cgroup-parent for systemd cgroups should be a slice name. A name can consist of a dash-separated series of names, which describes the path to the slice from the root slice. For example, --cgroup-parent=user-a-b.slice means the memory cgroup for the container is created in /sys/fs/cgroup/memory/user.slice/user-a.slice/user-a-b.slice/docker-<id>.scope.

systemd cgroup ドライバは ``--cgroup-parent`` と異なるルールです。Systemd のリソース階層は、スライス（訳者注：systemd における CPU やメモリなどのリソースを分割する単位のこと）とツリー上でスライスをエンコードする場所の名前で表します。そのため systemd cgroups 用の ``--cgroup-parent`` はスライス名と同じにすべきです。名前はダッシュ区切りの名前で構成します。つまりルート・スライスからのスライスに対するパスです。例えば ``--cgroup-parent=user-a-b.slice`` を指定する意は、コンテナ用の cgroup を ``/sys/fs/cgroup/memory/user.slice/user-a.slice/user-a-b.slice/docker-<id>.scope`` に割り当てます。

.. This setting can also be set per container, using the --cgroup-parent option on docker create and docker run, and takes precedence over the --cgroup-parent option on the daemon.

これらの指定はコンテナに対しても可能です。 ``docker create`` と ``docker run`` の実行時に ``--cgroup-parent`` を使うと、デーモンのオプションで指定した ``--cgroup-parent`` よりも優先されます。

.. Daemon configuration file

.. _daemon-configuration-file:

デーモン設定ファイル
====================

.. The --config-file option allows you to set any configuration option for the daemon in a JSON format. This file uses the same flag names as keys, except for flags that allow several entries, where it uses the plural of the flag name, e.g., labels for the label flag. By default, docker tries to load a configuration file from /etc/docker/daemon.json on Linux and %programdata%\docker\config\daemon.json on Windows.

``--config-file`` オプションを使えば、デーモンに対する設定オプションを JSON 形式で指定できます。このファイルでは、フラグと同じ名前をキーとします。ただし、複数の項目を指定可能なフラグの場合は、キーを複数形で指定します（例： ``label`` フラグの指定は ``labels`` になります ）。デフォルトは、 Linux の場合は ``/etc/docker/daemon.json`` にある設定ファイルを Docker が読み込もうとします。Windows の場合は ``%programdata%\docker\config\daemon.json`` です。

.. The options set in the configuration file must not conflict with options set via flags. The docker daemon fails to start if an option is duplicated between the file and the flags, regardless their value. We do this to avoid silently ignore changes introduced in configuration reloads. For example, the daemon fails to start if you set daemon labels in the configuration file and also set daemon labels via the --label flag.

設定ファイル上のオプションは、フラグで指定するオプションと競合してはいけません。ファイルとフラグが重複したまま docker デーモンを起動しようとしても、どのような値を指定しても、起動に失敗します。例えば、デーモンの起動時にラベルを設定ファイルで定義し、かつ、 ``--label`` フラグを指定したら、デーモンは起動に失敗します。

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
   	"storage-opts": [],
   	"labels": [],
   	"log-driver": "",
   	"log-opts": [],
   	"mtu": 0,
   	"pidfile": "",
   	"graph": "",
   	"cluster-store": "",
   	"cluster-store-opts": {},
   	"cluster-advertise": "",
   	"max-concurrent-downloads": 3,
   	"max-concurrent-uploads": 5,
   	"debug": true,
   	"hosts": [],
   	"log-level": "",
   	"tls": true,
   	"tlsverify": true,
   	"tlscacert": "",
   	"tlscert": "",
   	"tlskey": "",
   	"api-cors-header": "",
   	"selinux-enabled": false,
   	"userns-remap": "",
   	"group": "",
   	"cgroup-parent": "",
   	"default-ulimits": {},
          "ipv6": false,
          "iptables": false,
          "ip-forward": false,
          "ip-masq": false,
          "userland-proxy": false,
          "ip": "0.0.0.0",
          "bridge": "",
          "bip": "",
          "fixed-cidr": "",
          "fixed-cidr-v6": "",
          "default-gateway": "",
          "default-gateway-v6": "",
          "icc": false,
          "raw-logs": false,
          "registry-mirrors": [],
          "insecure-registries": [],
          "disable-legacy-registry": false,
          "default-runtime": "runc",
          "runtimes": {
              "runc": {
                  "path": "runc"
              },
              "custom": {
                  "path": "/usr/local/bin/my-runc-replacement",
                  "runtimeArgs": [
                      "--debug"
                  ]
               }
          }
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
   cluster-store: it reloads the discovery store with the new address.
   cluster-store-opts: it uses the new options to reload the discovery store.
   cluster-advertise: it modifies the address advertised after reloading.
    labels: it replaces the daemon labels with a new set of labels.
   `max-concurrent-downloads`: it updates the max concurrent downloads for each pull.
   `max-concurrent-uploads`: it updates the max concurrent uploads for each push.
   default-runtime: it updates the runtime to be used if not is specified at container creation. It defaults to "default" which is the runtime shipped with the official docker packages.
   runtimes: it updates the list of available OCI runtimes that can be used to run containers

* ``debug`` ：true を設定したら、デーモンをデバッグ・モードにします。
* ``cluster-store`` ：新しいアドレスにディスカバリ・ストアを読み込み直します。
* ``cluster-store-opts`` ：ディスカバリ・ストアを読み込む時の新しいオプションを指定します。
* ``cluster-advertise`` ：再起動後のアドバタイズド・アドレスを指定します。
* ``labels`` ：デーモンのラベルを新しく設定したものに変えます。
* ``max-concurrent-downloads`` ：pull ごとの最大同時ダウンロード数を更新します。
* ``max-concurrent-uploads`` ：push ごとの最大同時アップロード数を更新します。
* ``default-runtime`` ：デフォルトのランタイム（コンテナ作成時にランタイムの指定がない場合）を更新します。「デフォルト」とは Docker 公式パッケージに含まれるランタイムを意味します。
* ``runtimes`` ：コンテナ実行時に利用可能な OCI ランタイムの一覧です。

.. Updating and reloading the cluster configurations such as --cluster-store, --cluster-advertise and --cluster-store-opts will take effect only if these configurations were not previously configured. If --cluster-store has been provided in flags and cluster-advertise not, cluster-advertise can be added in the configuration file without accompanied by --cluster-store Configuration reload will log a warning message if it detects a change in previously configured cluster configurations.

``--cluster-store`` 、 ``--cluster-advertise`` 、 ``--cluster-store-opts`` のようなクラスタ設定情報の更新や再読み込みが反映できるのは、これまでに指定しない項目に対してのみです。フラグで ``--cluster-store`` を指定しても ``cluster-advertise`` を指定していなければ、 ``cluster-advertise`` は ``--cluster-store`` を一緒に指定しなくても反映します。既に設定済みのクラスタ設定に対して変更を試みたら、設定読み込み時に警告メッセージをログに残します。

.. Running multiple daemons

.. _running-multiple-daemons:

複数のデーモンを実行
====================

..     Note: Running multiple daemons on a single host is considered as "experimental". The user should be aware of unsolved problems. This solution may not work properly in some cases. Solutions are currently under development and will be delivered in the near future.

.. note::

   単一ホスト上での複数デーモンの実行は「実験的」機能です。利用者は、未解決問題に注意すべきです。この解決方法は、特定条件下で動作しない可能性があります。解決方法は現在開発中であり、近いうちに解決されるでしょう。

.. This section describes how to run multiple Docker daemons on a single host. To run multiple daemons, you must configure each daemon so that it does not conflict with other daemons on the same host. You can set these options either by providing them as flags, or by using a daemon configuration file.

このセクションの説明は、単一ホスト上で複数の Docker デーモンを実行する方法です。複数のデーモンを実行するには、各デーモンごとに同一ホスト上で重複しないような設定が必要です。各オプションはフラグを使って指定するか、あるいは :ref:`daemon-configuration-file` で指定します。

.. The following daemon options must be configured for each daemon:

各デーモンで以下のオプション指定が必須です：

.. code-block:: bash

   -b, --bridge=                          コンテナがアタッチするネットワーク・ブリッジ
   --exec-root=/var/run/docker            Docker 実行ドライバのルート
   -g, --graph=/var/lib/docker            Docker ランタイムのルート
   -p, --pidfile=/var/run/docker.pid      デーモンの PID ファイルに使うパス
   -H, --host=[]                          デーモンが接続するソケット
   --config-file=/etc/docker/daemon.json  Daemon 設定ファイル
   --tlscacert="~/.docker/ca.pem"         信頼できる認証局で署名された証明書
   --tlscert="~/.docker/cert.pem"         TLS 証明書ファイルのパス
   --tlskey="~/.docker/key.pem"           TLS 鍵ファイルのパス

.. When your daemons use different values for these flags, you can run them on the same host without any problems. It is very important to properly understand the meaning of those options and to use them correctly.

デーモンに対してフラグ用に異なる値を指定したら、同じホスト上でも、別のデーモンを問題なく起動できます。各オプションと使い方を適切に理解するのは、非常に重要です。

..    The -b, --bridge= flag is set to docker0 as default bridge network. It is created automatically when you install Docker. If you are not using the default, you must create and configure the bridge manually or just set it to 'none': --bridge=none
    --exec-root is the path where the container state is stored. The default value is /var/run/docker. Specify the path for your running daemon here.
    --graph is the path where images are stored. The default value is /var/lib/docker. To avoid any conflict with other daemons set this parameter separately for each daemon.
    -p, --pidfile=/var/run/docker.pid is the path where the process ID of the daemon is stored. Specify the path for your pid file here.
    --host=[] specifies where the Docker daemon will listen for client connections. If unspecified, it defaults to /var/run/docker.sock.
    --config-file=/etc/docker/daemon.json is the path where configuration file is stored. You can use it instead of daemon flags. Specify the path for each daemon.
    --tls* Docker daemon supports --tlsverify mode that enforces encrypted and authenticated remote connections. The --tls* options enable use of specific certificates for individual daemons.

* ``-b, --bridge=`` フラグはデフォルトのブリッジ・ネットワークとして ``docker0`` を指定します。これは Docker インストール時に自動作成されます。デフォルトで使いたくなければ、手動で何らかのブリッジを作成して設定するか、あるいは ``none`` を ``--bridge=none`` で指定します。
* ``--exec-root``  はコンテナの状態を補完するパスです。デフォルトの値は ``/var/run/docker`` です。ここで docker デーモンを実行するパスを指定します。
* ``--graph`` はイメージを保存する場所です。デフォルト値は ``/var/lib/docker`` です。デーモンごとに別々のパラメータを指定し、重複しないようにする必要があります。
* ``-p, --pidfile=/var/run/docker.pid`` はデーモンのプロセス ID を保存する場所です。PID ファイルのパスを指定します。
* ``--host=[]`` には、 Docker デーモンがクライアントからの接続をリッスンする場所を指定します。指定しなければ、デフォルトは ``/var/run/docker.sock`` です。
* ``--config-file=/etc/docker/daemon.json`` は設定ファイルがあるパスです。デーモンのフラグの代わりに、こちらで指定できます。各デーモンごとにパスの指定が必要です。
* ``--tls*`` は Docker デーモンが ```--tlsverify`` （TLS認証）モードを有効化します。これはリモート接続時に暗号化と認証を義務づけます。 ``--tls*`` オプションを有効にするには、デーモンごとに証明書を指定する必要があります。

.. Example script for a separate “bootstrap” instance of the Docker daemon without network:

次の例は、「bootstrap」インスタンスとして、ネットワークを持たない Docker デーモンを起動します。

.. code-block:: bash

   $ docker daemon \
           -H unix:///var/run/docker-bootstrap.sock \
           -p /var/run/docker-bootstrap.pid \
           --iptables=false \
           --ip-masq=false \
           --bridge=none \
           --graph=/var/lib/docker-bootstrap \
           --exec-root=/var/run/docker-bootstrap

.. seealso:: 

   daemon
      https://docs.docker.com/engine/reference/commandline/daemon/
