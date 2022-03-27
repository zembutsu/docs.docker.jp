.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/dockerd/
.. SOURCE:
   doc version: 20.10
      https://github.com/docker/cli/blob/master/docs/reference/commandline/dockerd.md
.. check date: 2022/03/27
.. Commits on Mar 27, 2022 dd7397342af52b1140a3a8d48a66a4451d2b246f
.. -------------------------------------------------------------------

.. dockerd daemon

=======================================
dockerd daemon
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. code-block:: bash

   Usage: dockerd COMMAND
   
   A self-sufficient runtime for containers.
   
   Options:
         --add-runtime runtime                   Register an additional OCI compatible runtime (default [])
         --allow-nondistributable-artifacts list Allow push of nondistributable artifacts to registry
         --api-cors-header string                Set CORS headers in the Engine API
         --authorization-plugin list             Authorization plugins to load
         --bip string                            Specify network bridge IP
     -b, --bridge string                         Attach containers to a network bridge
         --cgroup-parent string                  Set parent cgroup for all containers
         --config-file string                    Daemon configuration file (default "/etc/docker/daemon.json")
         --containerd string                     containerd grpc address
         --containerd-namespace string           Containerd namespace to use (default "moby")
         --containerd-plugins-namespace string   Containerd namespace to use for plugins (default "plugins.moby")
         --cpu-rt-period int                     Limit the CPU real-time period in microseconds for the
                                                 parent cgroup for all containers
         --cpu-rt-runtime int                    Limit the CPU real-time runtime in microseconds for the
                                                 parent cgroup for all containers
         --cri-containerd                        start containerd with cri
         --data-root string                      Root directory of persistent Docker state (default "/var/lib/docker")
     -D, --debug                                 Enable debug mode
         --default-address-pool pool-options     Default address pools for node specific local networks
         --default-cgroupns-mode string          Default mode for containers cgroup namespace ("host" | "private") (default "host")
         --default-gateway ip                    Container default gateway IPv4 address
         --default-gateway-v6 ip                 Container default gateway IPv6 address
         --default-ipc-mode string               Default mode for containers ipc ("shareable" | "private") (default "private")
         --default-runtime string                Default OCI runtime for containers (default "runc")
         --default-shm-size bytes                Default shm size for containers (default 64MiB)
         --default-ulimit ulimit                 Default ulimits for containers (default [])
         --dns list                              DNS server to use
         --dns-opt list                          DNS options to use
         --dns-search list                       DNS search domains to use
         --exec-opt list                         Runtime execution options
         --exec-root string                      Root directory for execution state files (default "/var/run/docker")
         --experimental                          Enable experimental features
         --fixed-cidr string                     IPv4 subnet for fixed IPs
         --fixed-cidr-v6 string                  IPv6 subnet for fixed IPs
     -G, --group string                          Group for the unix socket (default "docker")
         --help                                  Print usage
     -H, --host list                             Daemon socket(s) to connect to
         --host-gateway-ip ip                    IP address that the special 'host-gateway' string in --add-host resolves to.
                                                 Defaults to the IP address of the default bridge
         --icc                                   Enable inter-container communication (default true)
         --init                                  Run an init in the container to forward signals and reap processes
         --init-path string                      Path to the docker-init binary
         --insecure-registry list                Enable insecure registry communication
         --ip ip                                 Default IP when binding container ports (default 0.0.0.0)
         --ip-forward                            Enable net.ipv4.ip_forward (default true)
         --ip-masq                               Enable IP masquerading (default true)
         --iptables                              Enable addition of iptables rules (default true)
         --ip6tables                             Enable addition of ip6tables rules (default false)
         --ipv6                                  Enable IPv6 networking
         --label list                            Set key=value labels to the daemon
         --live-restore                          Enable live restore of docker when containers are still running
         --log-driver string                     Default driver for container logs (default "json-file")
     -l, --log-level string                      Set the logging level ("debug"|"info"|"warn"|"error"|"fatal") (default "info")
         --log-opt map                           Default log driver options for containers (default map[])
         --max-concurrent-downloads int          Set the max concurrent downloads for each pull (default 3)
         --max-concurrent-uploads int            Set the max concurrent uploads for each push (default 5)
         --max-download-attempts int             Set the max download attempts for each pull (default 5)
         --metrics-addr string                   Set default address and port to serve the metrics api on
         --mtu int                               Set the containers network MTU
         --network-control-plane-mtu int         Network Control plane MTU (default 1500)
         --no-new-privileges                     Set no-new-privileges by default for new containers
         --node-generic-resource list            Advertise user-defined resource
         --oom-score-adjust int                  Set the oom_score_adj for the daemon (default -500)
     -p, --pidfile string                        Path to use for daemon PID file (default "/var/run/docker.pid")
         --raw-logs                              Full timestamps without ANSI coloring
         --registry-mirror list                  Preferred Docker registry mirror
         --rootless                              Enable rootless mode; typically used with RootlessKit
         --seccomp-profile string                Path to seccomp profile
         --selinux-enabled                       Enable selinux support
         --shutdown-timeout int                  Set the default shutdown timeout (default 15)
     -s, --storage-driver string                 Storage driver to use
         --storage-opt list                      Storage driver options
         --swarm-default-advertise-addr string   Set default address or interface for swarm advertised address
         --tls                                   Use TLS; implied by --tlsverify
         --tlscacert string                      Trust certs signed only by this CA (default "~/.docker/ca.pem")
         --tlscert string                        Path to TLS certificate file (default "~/.docker/cert.pem")
         --tlskey string                         Path to TLS key file (default "~/.docker/key.pem")
         --tlsverify                             Use TLS and verify the remote
         --userland-proxy                        Use userland proxy for loopback traffic (default true)
         --userland-proxy-path string            Path to the userland proxy binary
         --userns-remap string                   User/Group setting for user namespaces
         --validate                              Validate daemon configuration and exit
     -v, --version                               Print version information and quit

.. Options with [] may be specified multiple times.

[] が付いているオプションは、複数回指定できます。


.. Description
.. _dockerd_description:
説明
==========

.. dockerd is the persistent process that manages containers. Docker uses different binary for the daemon and client. To run the daemon you type dockerd.

dockerd はコンテナを管理するために常駐するプロセスです。Docker はデーモンとクライアントで異なるバイナリを使います。デーモンを起動するには ``dockerd`` を入力します。

.. To run the daemon with debug output, use dockerd --debug or add "debug": true to the daemon.json file.

デーモンにデバッグ情報を出力するには、 ``dockerd --debug`` を使って実行するか、 :ruby:`daemon.json ファイル <daemon-configuration-file>` に ``"debug": true`` を追加します。

.. Environment variables
.. _dockerd_environment-variables:
環境変数
----------

.. For easy reference, the following list of environment variables are supported by the dockerd command line:

簡単なリファレンスとして、 ``dockerd`` コマンドラインは以下の環境変数をサポートします。

..    DOCKER_DRIVER The graph driver to use.
    DOCKER_NOWARN_KERNEL_VERSION Prevent warnings that your Linux kernel is unsuitable for Docker.
    DOCKER_RAMDISK If set this will disable ‘pivot_root’.
    DOCKER_TMPDIR Location for temporary Docker files.
    MOBY_DISABLE_PIGZ Do not use unpigz to decompress layers in parallel when pulling images, even if it is installed.

* ``DOCKER_DRIVER`` 使用するグラフ ドライバ
* ``DOCKER_NOWARN_KERNEL_VERSION`` Linux カーネルが Docker に不適当でも警告を表示しない
* ``DOCKER_RAMDISK`` 設定すると、「pivot_root」を無効化
* ``DOCKER_TMPDIR`` 一時的な Docker ファイルの場所
* ``MOBY_DISABLE_PIGZ`` イメージの取得時、並列レイヤ圧縮には ``unpigz`` がインストールされていても使用しない

.. Examples
使用例
==========

.. Daemon socket option
.. _daemon-socket-option:

デーモン・ソケットのオプション
------------------------------

.. The Docker daemon can listen for Docker Remote API requests via three different types of Socket: unix, tcp, and fd.

Docker デーモンは :doc:`Docker リモート API </engine/reference/api/docker_remote_api>` を受信できます。３種類のソケット ``unix`` 、 ``tcp`` 、 ``fd`` を通します。

.. By default, a unix domain socket (or IPC socket) is created at /var/run/docker.sock, requiring either root permission, or docker group membership.

デフォルトでは ``unix`` ドメイン・ソケット（あるいは IPC ソケット）を ``/var/run/docker.sock`` に作成します。そのため、操作には ``root`` 権限または ``docker`` グループへの所属が必要です。

.. If you need to access the Docker daemon remotely, you need to enable the tcp Socket. Beware that the default setup provides un-encrypted and un-authenticated direct access to the Docker daemon - and should be secured either using the built in HTTPS encrypted socket, or by putting a secure web proxy in front of it. You can listen on port 2375 on all network interfaces with -H tcp://0.0.0.0:2375, or on a particular network interface using its IP address: -H tcp://192.168.59.103:2375. It is conventional to use port 2375 for un-encrypted, and port 2376 for encrypted communication with the daemon.

Docker デーモンにリモートからの接続を考えているのであれば、 ``tcp`` ソケットを有効にする必要があります。デフォルトのセットアップでは、Docker デーモンとの暗号化や認証機能が無いのでご注意ください。また、安全に使うには :doc:`内部の HTTP 暗号化ソケット </engine/security/https>` を使うべきです。あるいは、安全なウェブ・プロキシをフロントに準備してください。ポート ``2375`` をリッスンしている場合は、全てのネットワークインターフェースで ``-H tcp://0.0.0.0:2375`` を指定するか、あるいは IP アドレスを ``-H tcp://192.168.59.103:2375`` のように指定します。慣例として、デーモンとの通信が暗号化されていない場合はポート ``2375`` を、暗号化されている場合はポート ``2376`` を使います。

..    Note: If you’re using an HTTPS encrypted socket, keep in mind that only TLS1.0 and greater are supported. Protocols SSLv3 and under are not supported anymore for security reasons.

.. note::

   HTTP 暗号化ソケットを使う時は、TLS 1.0 以上をお使いください。プロトコル SSLv3 未満のバージョンは、セキュリティ上の理由によりサポートされていません。

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


.. code-block:: bash

   $ export DOCKER_HOST="tcp://0.0.0.0:2375"
   $ docker ps

.. Setting the DOCKER_TLS_VERIFY environment variable to any value other than the empty string is equivalent to setting the --tlsverify flag. The following are equivalent:

``DOCKER_TLS_VERIFY`` 環境変数が設定してあれば、コマンド実行時に ``--tlsverify`` フラグを都度指定するのと同じです。以下はいずれも同じです。

.. code-block:: bash

   $ docker --tlsverify ps
   # または
   $ export DOCKER_TLS_VERIFY=1
   $ docker ps

.. The Docker client will honor the HTTP_PROXY, HTTPS_PROXY, and NO_PROXY environment variables (or the lowercase versions thereof). HTTPS_PROXY takes precedence over HTTP_PROXY.

Docker クライアントは ``HTTP_PROXY`` 、 ``HTTPS_PROXY`` 、 ``NO_PROXY`` 環境変数を（あるいは小文字でも）使えます。 ``HTTPS_PROXY`` は ``HTTP_PROXY`` よりも上位です。

.. The Docker client supports connecting to a remote daemon via SSH:

Docker クライアントは、リモートのデーモンに SSH を経由した接続をサポートしています。

.. code-block:: bash

   $ docker -H ssh://me@example.com:22 ps
   $ docker -H ssh://me@example.com ps
   $ docker -H ssh://example.com ps

.. To use SSH connection, you need to set up ssh so that it can reach the remote host with public key authentication. Password authentication is not supported. If your key is protected with passphrase, you need to set up ssh-agent.

SSH 接続を使うには、リモートホストに公開鍵認証による ``ssh`` をセットアップする必要があります。パスワード認証はサポートしています。鍵がパスフレーズで保護されている場合、 ``ssh-agent`` のセットアップが必要です。

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

同様に、 Docker クライアントは ``-H`` を使い任意のポートに接続できます。 Docker クライアントはデフォルトで、Linux であれば ``unix:///var/run/docker.sock`` へ、Windows であれば ``tcp://127.0.0.1:2376`` に接続します。

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

``-H`` は TCP バインドの指定を短縮できます。   ``host:` あるいは `host:port` あるいは `:port` です。

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

.. On Linux, the Docker daemon has support for several different image layer storage drivers: aufs, devicemapper, btrfs, zfs, overlay, overlay2, and fuse-overlayfs.

Linux では、Docker デーモンはイメージ・レイヤ用途に、様々に異なるストレージ・ドライバの利用をサポートします。ドライバは、 ``aufs`` 、 ``devicemapper`` 、 ``btrfs`` 、 ``zfs`` 、 ``overlay`` 、 ``overlay2`` です。

.. The aufs driver is the oldest, but is based on a Linux kernel patch-set that is unlikely to be merged into the main kernel. These are also known to cause some serious kernel crashes. However, aufs is also the only storage driver that allows containers to share executable and shared library memory, so is a useful choice when running thousands of containers with the same program or libraries.

最も古いドライバは ``aufs`` であり、Linux カーネルに対するパッチ群が基になっています。ドライバにはメイン・カーネルにマージされなかったコードも含まれます。そのため、深刻なカーネルのクラッシュを引き起こすのが分かっています。一方で、 ``aufs`` はコンテナの共有実行と共有ライブラリ・メモリが使える唯一のストレージ・ドライバです。そのため、同じプログラムやライブラリで数千ものコンテナを実行する時は便利な選択でしょう。

.. The devicemapper driver uses thin provisioning and Copy on Write (CoW) snapshots. For each devicemapper graph location -- typically /var/lib/docker/devicemapper -- a thin pool is created based on two block devices, one for data and one for metadata. By default, these block devices are created automatically by using loopback mounts of automatically created sparse files. Refer to Storage driver options below for a way how to customize this setup. ~jpetazzo/Resizing Docker containers with the Device Mapper plugin article explains how to tune your existing setup without the use of options.

``devicemapper`` ドライバはシン・プロビジョニング（thin provisioning）とコピー・オン・ライト（Copy on Write）スナップショットを使います。devicemapper の各グラフ（graph）がある典型的な場所は ``/var/lib/docker/devicemapper`` です。シン（thin）プールは２つのブロックデバイス上に作ります。１つはデータで、もう１つはメタデータです。デフォルトでは、別々のファイルとして自動作成したループバックのマウントを元に、これらのブロック・デバイスを自動的に作成します。セットアップのカスタマイズ方法は、以下にある :ref:`ストレージ・ドライバのオプション <storage-driver-options>` をご覧ください。オプションを使わない設定方法は `jpetazzo/Resizing Docker containers with the Device Mapper plugin <http://jpetazzo.github.io/2014/01/29/docker-device-mapper-resize/>`_ の記事に説明があります。

.. The btrfs driver is very fast for docker build - but like devicemapper does not share executable memory between devices. Use dockerd -s btrfs -g /mnt/btrfs_partition.

``btrfs`` ドライバは ``docker build`` が非常に高速です。しかし、 ``devicemapper`` のようにデバイス間の実行メモリを共有しません。使うには ``dockerd -s btrfs -g /mnt/btrfs_partition`` を実行します。

.. The zfs driver is probably not as fast as btrfs but has a longer track record on stability. Thanks to Single Copy ARC shared blocks between clones will be cached only once. Use dockerd -s zfs. To select a different zfs filesystem set zfs.fsname option as described in Storage driver options.

``zfs`` ドライバは ``btrfs`` ほど速くありませんが、安定さのためレコードを長く追跡します。 ``Single Copy ARC`` のおかげで、クローン間の共有ブロックを１度キャッシュします。使うには ``dockerd -s zfs`` を指定します。異なる zfs ファイルシステムセットを選択するには、 ``zfs.fsname`` オプションを  :ref:`ストレージ・ドライバのオプション <storage-driver-options>` で指定します。

.. The overlay is a very fast union filesystem. It is now merged in the main Linux kernel as of 3.18.0. overlay also supports page cache sharing, this means multiple containers accessing the same file can share a single page cache entry (or entries), it makes overlay as efficient with memory as aufs driver. Call dockerd -s overlay to use it.

``overlay`` は非常に高速なユニオン・ファイルシステムです。ようやく Linux カーネル `3.18.0 <https://lkml.org/lkml/2014/10/26/137>`_ でメインにマージされました。また、 ``overlay`` は :ruby:`ページキャッシュ共有 <page cache sharing>` も竿ポートしています。つまり、複数のコンテナで1つのページキャッシュのエントリ（あるいは全体）を共有できるため、 ``overlay`` は ``aufs`` ドライバよりもメモリが効率的です。

｡.. The overlay2 uses the same fast union filesystem but takes advantage of additional features added in Linux kernel 4.0 to avoid excessive inode consumption. Call dockerd -s overlay2 to use it.

``overlay2`` は同じく速いユニオン・ファイルシステムを使いますが、 Linux カーネル 4.0 で追加された過度の inode 消費を抑制する `追加機能 <https://lkml.org/lkml/2015/2/11/106>`_ を利用できる利点があります。使うには ``dockerd -s overlay2`` を実行します。

.. The overlay storage driver can cause excessive inode consumption (especially as the number of images grows). We recommend using the overlay2 storage driver instead.

.. note::

   ``overlay`` ストレージドライバは、過度の inode を消費する可能性があります（特に、イメージ数が増加すると）。そのかわり、 ``overlay2`` ストレージドライバの利用を推奨します。

.. Both overlay and overlay2 are currently unsupported on btrfs or any Copy on Write filesystem and should only be used over ext4 partitions.

.. note::

   ``overlay`` と ``overlay2`` は、どちらも ``btrfs`` をサポートしていないため、あらゆるファイルシステムへのコピーや書き込みは、 ``ext4`` パーティション上のみを利用すべきです。

.. The fuse-overlayfs driver is similar to overlay2 but works in userspace. The fuse-overlayfs driver is expected to be used for Rootless mode.

``fuse-overlayfs`` ドライバは ``overlay2`` と似ていますが、 :ruby:`ユーザスペース <userspace>` 内で動作します。 ``fuse-overlayfs`` ドライバは、 :doc:`Rootless モード </engine/security/rootless>` での利用が想定されています。

.. On Windows, the Docker daemon supports a single image layer storage driver depending on the image platform: windowsfilter for Windows images, and lcow for Linux containers on Windows.

Window では、Docker デーモンがサポートしているのは、 単一イメージ・レイヤのストレージ・ドライバに依存します。Windows イメージ用のは``windowsfilter`` であり、 Windows 上の Linux コンテナは ``lcow`` です。


.. Options per storage driver
.. _storage-driver-options:

ストレージ・ドライバごとのオプション
----------------------------------------

.. Particular storage-driver can be configured with options specified with --storage-opt flags. Options for devicemapper are prefixed with dm and options for zfs start with zfs and options for btrfs start with btrfs.

個々のストレージドライバは ``--storage-opt`` フラグでオプションを設定できます。 ``devicemapper`` 用のオプションは ``dm`` で始まり、 ``zfs`` 用のオプションは ``zfs`` で始まります。また ``btrfs`` 用のオプションは ``btrfs``  で始まります。

.. _devicemapper-options:

devicemapper のオプション
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. This is an example of the configuration file for devicemapper on Linux:

これは Linux 上の deviemapper 用の設定ファイルを使う例です。

.. code-block:: yaml

   {
     "storage-driver": "devicemapper",
     "storage-opts": [
       "dm.thinpooldev=/dev/mapper/thin-pool",
       "dm.use_deferred_deletion=true",
       "dm.use_deferred_removal=true"
     ]
   }

..    dm.thinpooldev
``dm.thinpooldev``
`````````````````````````````

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

   $ sudo dockerd --storage-opt dm.thinpooldev=/dev/mapper/thin-pool

``dm.directlvm_device``
`````````````````````````````

.. As an alternative to providing a thin pool as above, Docker can setup a block device for you.

先述とは別の thin pool を指定します。Docker で使いたいブロックデバイスを指定できます。

.. Example:

使用例：

.. code-block:: bash

   $ sudo dockerd --storage-opt dm.directlvm_device=/dev/xvdf


dm.thinp_percent
`````````````````````````````

.. Sets the percentage of passed in block device to use for storage.

ストレージに使うための、ブロックデバイスのパーセントを指定します。

.. Example:

使用例：

.. code-block:: bash

   $ sudo dockerd --storage-opt dm.thinp_percent=95

dm.thinp_metapercent
`````````````````````````````

.. Sets the percentage of the passed in block device to use for metadata storage.

メタデータのストレージに使うための、ブロックデバイスのパーセント指定します。

.. Example:

使用例：

.. code-block:: bash

   $ sudo dockerd --storage-opt dm.thinp_metapercent=1

dm.thinp_autoextend_threshold
`````````````````````````````

.. Sets the value of the percentage of space used before lvm attempts to autoextend the available space [100 = disabled]

``lvm`` が利用可能なスペースに自動展開する前に、使用する値をパーセントで指定します（ 100 = 無効化 ）。

.. Example:
使用例：

.. code-block:: bash

   $ sudo dockerd --storage-opt dm.thinp_autoextend_threshold=80

dm.thinp_autoextend_percent
`````````````````````````````

.. Sets the value percentage value to increase the thin pool by when lvm attempts to autoextend the available space [100 = disabled]

``lvm`` が利用可能なスペースに自動展開する場合、 thin pool が増加する値をパーセントで指定します（ 100 = 無効化 ）。

.. Example:
使用例：

.. code-block:: bash

   $ sudo dockerd --storage-opt dm.thinp_autoextend_percent=20


``dm.basesize``
`````````````````````````````

.. Specifies the size to use when creating the base device, which limits the size of images and containers. The default value is 10G. Note, thin devices are inherently “sparse”, so a 10G device which is mostly empty doesn’t use 10 GB of space on the pool. However, the filesystem will use more space for the empty case the larger the device is.

ベース・デバイスの生成に使う容量を指定します。これはイメージやコンテナのサイズを制限します。デフォルト値は 10G です。なお thin device は基本的に「 :ruby:`まばら <sparse>` 」のため、デバイス上の10 G はほとんどが空となり、プール上で 10G を占有しません。ただしデバイスが大きくなればなるほど、ファイルシステムが扱う空データはより多くなります。

.. The base device size can be increased at daemon restart which will allow all future images and containers (based on those new images) to be of the new base device size.

ベース・デバイスの容量は、デーモンの再起動によって増えます。再起動により、以後生成されるイメージやコンテナ（その新たなイメージに基づくもの）は、新たなベース・デバイスの容量に基づいて生成されます。

.. Examples

使用例：

.. code-block:: bash

   $ dockerd --storage-opt dm.basesize=50G

.. This will increase the base device size to 50G. The Docker daemon will throw an error if existing base device size is larger than 50G. A user can use this option to expand the base device size however shrinking is not permitted.

これはベース・デバイス容量を 50GB に増やしています。ベース・デバイス容量が元から 50 G よりも大きかった場合には、Docker デーモンはエラーを出力します。ユーザはこのオプションを使ってベース・デバイス容量を拡張できますが、縮小はできません。

.. This value affects the system-wide “base” empty filesystem that may already be initialized and inherited by pulled images. Typically, a change to this value requires additional steps to take effect:

システム全体の「ベース」となる空白のファイルシステムに対して、設定値が影響を与えます。これは、既に初期化されているか、取得しているイメージから継承している場合です。とりわけ、この値の変更時には、反映するにために追加手順が必要です。

.. code-block:: bash

   $ sudo service docker stop
   
   $ sudo rm -rf /var/lib/docker
   
   $ sudo service docker start

``dm.loopdatasize``
````````````````````

..        Note: This option configures devicemapper loopback, which should not be used in production.

.. note::

   この設定はデバイスマッパーのループバックを変更するものです。プロダクションで使うべきではありません。

..    Specifies the size to use when creating the loopback file for the “data” device which is used for the thin pool. The default size is 100G. The file is sparse, so it will not initially take up this much space.

「データ」デバイスがシン・プール用に使うためのループバック・ファイルの作成時、この容量の指定に使います。デフォルトの容量は 100GB です。ファイルは希薄なため、初期段階ではさほど容量を使いません。

..    Example

使用例：

.. code-block:: bash

   $ dockerd --storage-opt dm.loopdatasize=200G

``dm.loopmetadatasize``
``````````````````````````````

..        Note: This option configures devicemapper loopback, which should not be used in production.

.. note::

   この設定はデバイスマッパーのループバックを変更するものです。プロダクションで使うべきではありません。

..    Specifies the size to use when creating the loopback file for the “metadata” device which is used for the thin pool. The default size is 2G. The file is sparse, so it will not initially take up this much space.

「メタデータ」デバイスがシン・プール用に使うためのループバック・ファイルの作成時、この容量の指定に使います。デフォルトの容量は 2GB です。ファイルは希薄なため、初期段階ではさほど容量を使いません。

..    Example

使用例：

   $ dockerd --storage-opt dm.loopmetadatasize=4G

``dm.fs``
``````````

..    Specifies the filesystem type to use for the base device. The supported options are “ext4” and “xfs”. The default is “xfs”

ベース・デバイスで使用するファイルシステムの種類を指定します。サポートされているオプションは「ext4」と「xfs」です。デフォルトは「xfs」です。

..    Example

使用例：

.. code-block:: bash

   $ dockerd --storage-opt dm.fs=ext4

``dm.mkfsarg``
````````````````````

..    Specifies extra mkfs arguments to be used when creating the base device.

ベース・デバイスの作成時に mkfs に対する追加の引数を指定します。

..    Example use:

使用例：

.. code-block:: bash

   $ dockerd --storage-opt "dm.mkfsarg=-O ^has_journal"

``dm.mountopt``
````````````````````

..    Specifies extra mount options used when mounting the thin devices.

シン・デバイスをマウントする時に使う、追加マウントオプションを指定します。

..    Example

使用例：

   $ dockerd --storage-opt dm.mountopt=nodiscard

``dm.datadev``
````````````````````

..    (Deprecated, use dm.thinpooldev)

（廃止されました。 ``dm.thinpooldev`` をお使いください ）

..    Specifies a custom blockdevice to use for data for the thin pool.

シン・プール用のブロック・デバイスが使うデータを指定します。

..    If using a block device for device mapper storage, ideally both datadev and metadatadev should be specified to completely avoid using the loopback device.

デバイスマッパー用のストレージにブロック・デバイスを使う時、datadev と metadatadev の両方がループバック・デバイスを完全に使わないようにするのが理想です。

..    Example

使用例：

.. code-block:: bash

   $ dockerd \
         --storage-opt dm.datadev=/dev/sdb1 \
         --storage-opt dm.metadatadev=/dev/sdc1

``dm.metadatadev``
````````````````````

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

``dm.blocksize``
````````````````````

..    Specifies a custom blocksize to use for the thin pool. The default blocksize is 64K.

シン・プールで使うカスタム・ブロックサイズを指定します。デフォルトのブロックサイズは 64K です。

..    Example

使用例：

.. code-block:: bash

   $ dockerd --storage-opt dm.blocksize=512K

``dm.blkdiscard``
````````````````````

.. Enables or disables the use of blkdiscard when removing devicemapper devices. This is enabled by default (only) if using loopback devices and is required to resparsify the loopback file on image/container removal.

デバイスマッパー・デバイスの削除時に、``blkdiscard`` の利用を許可するかしないかを指定します。これはループバック・デバイス利用時（のみ）、デフォルトは有効です。ループバック・ファイルの場合は、イメージやコンテナの削除時に再度スパースとする必要があるからです。

.. Disabling this on loopback can lead to much faster container removal times, but will make the space used in /var/lib/docker directory not be returned to the system for other use when containers are removed.

ループバックに対してこれを無効にした場合は、コンテナの削除時間を *大きく* 削減できます。ただしコンテナが削除されても、 ``/var/lib/docker`` ディレクトリに割り当てられていた領域は、他プロセスが利用できる状態に戻されることはありません。

..    Example

使用例：

.. code-block:: bash

   $ dockerd --storage-opt dm.blkdiscard=false

``dm.override_udev_sync_check``
````````````````````````````````````````

..    Overrides the udev synchronization checks between devicemapper and udev. udev is the device manager for the Linux kernel.

``devicemapper`` と ``udev`` 間における ``udev`` 同期確認の設定を上書きします。 ``udev`` は Linux カーネル用のデバイスマッパーです。

.. To view the udev sync support of a Docker daemon that is using the devicemapper driver, run:

``devicemapper`` ドライバーを利用する Docker デーモンが ``udev`` 同期をサポートしているかどうかは、以下を実行して確認できます。

.. code-block:: bash

   $ docker info
   <...>
   Udev Sync Supported: true
   <...>

.. When udev sync support is true, then devicemapper and udev can coordinate the activation and deactivation of devices for containers.

``udev`` 同期サポートが ``true`` であれば、``devicemapper`` と udev は連携してコンテナ向けデバイスの有効化、無効化を行います。

.. When udev sync support is false, a race condition occurs between thedevicemapper and udev during create and cleanup. The race condition results in errors and failures. (For information on these failures, see docker#4036)

``udev`` 同期サポートが ``false`` であれば、 ``devicemapper`` と ``udev`` 間で作成・クリーンアップ時に競合を引き起こします。競合状態の結果、エラーが発生して失敗します（失敗に関する詳しい情報は `docker#4036 <https://github.com/docker/docker/issues/4036>`_ をご覧ください。）

.. To allow the docker daemon to start, regardless of udev sync not being supported, set dm.override_udev_sync_check to true:

``udev`` 同期がサポートされているかどうかに関係なく ``docker`` デーモンを起動するならば、``dm.override_udev_sync_check`` を true に設定してください。

.. code-block:: bash

   $ dockerd --storage-opt dm.override_udev_sync_check=true

..    When this value is true, the devicemapper continues and simply warns you the errors are happening.

この値が ``true`` の場合、 ``devicemapper`` はエラーが発生しても簡単に警告を表示するだけで、処理を継続します。

..     Note

    The ideal is to pursue a docker daemon and environment that does support synchronizing with udev. For further discussion on this topic, see docker#4036. Otherwise, set this flag for migrating existing Docker daemons to a daemon with a supported environment.

.. note::

   理想的には ``udev`` との同期をサポートする ``docker`` デーモンおよび環境を目指すべきところです。これに関してのさらなるトピックは `docker#4036 <https://github.com/docker/docker/issues/4036>`_ をご覧ください。これができない限りは、既存の Docker デーモンが動作する環境上において、正常動作するように本フラグを設定してください。

``dm.use_deferred_removal``
``````````````````````````````

..    Enables use of deferred device removal if libdm and the kernel driver support the mechanism.

``libdm`` やカーネル・ドライバがサポートしている仕組みがあれば、デバイス削除の遅延を有効化します。

..    Deferred device removal means that if device is busy when devices are being removed/deactivated, then a deferred removal is scheduled on device. And devices automatically go away when last user of the device exits.

デバイス削除の遅延が意味するのは、デバイスを無効化・非アクティブ化しようとしてもビジー（使用中）であれば、デバイス上で遅延削除が予定されます。そして、最後にデバイスを使っているユーザが終了したら、自動的に削除します。

..    For example, when a container exits, its associated thin device is removed. If that device has leaked into some other mount namespace and can’t be removed, the container exit still succeeds and this option causes the system to schedule the device for deferred removal. It does not wait in a loop trying to remove a busy device.

例えば、コンテナを終了したら、関連づけられているシン・デバイスも削除されます。デバイスが他のマウント名前空間も利用しているの場合は、削除できません。コンテナの終了が成功したら、このオプションが有効であれば、システムがデバイスの遅延削除をスケジュールします。使用中のデバイスが削除できるまで、ループを繰り返すことはありません。

..    Example

使用例：

.. code-block:: bash

    $ dockerd --storage-opt dm.use_deferred_removal=true

``dm.use_deferred_deletion``
``````````````````````````````

..    Enables use of deferred device deletion for thin pool devices. By default, thin pool device deletion is synchronous. Before a container is deleted, the Docker daemon removes any associated devices. If the storage driver can not remove a device, the container deletion fails and daemon returns.

シン・プール用デバイスの遅延削除を有効化するのに使います。デフォルトでは、シン・プールの削除は同期します。コンテナを削除する前に、Docker デーモンは関連するデバイスを削除します。ストレージ・ドライバがデバイスを削除できなければ、コンテナの削除は失敗し、デーモンはエラーを表示します。

.. code-block:: bash

   Error deleting container: Error response from daemon: Cannot destroy container

..    To avoid this failure, enable both deferred device deletion and deferred device removal on the daemon.

この失敗を避けるには、デバイス遅延削除（deletion）と、デバイス遅延廃止（removal）をデーモンで有効化します。

.. code-block:: bash

   $ sudo dockerd \
         --storage-opt dm.use_deferred_deletion=true \
         --storage-opt dm.use_deferred_removal=true

..    With these two options enabled, if a device is busy when the driver is deleting a container, the driver marks the device as deleted. Later, when the device isn’t in use, the driver deletes it.

この２つのオプションが有効であれば、ドライバがコンテナを削除する時にデバイスが使用中でも、ドライバはデバイスを削除対象としてマークします。その後、デバイスが使えなくなったら、ドライバはデバイスを削除します。

..    In general it should be safe to enable this option by default. It will help when unintentional leaking of mount point happens across multiple mount namespaces.

通常、安全のためにデフォルトでこのオプションを有効化すべきです。複数のマウント名前空間にまたがり、マウントポイントの意図しないリークが発生した時に役立つでしょう。

``dm.min_free_space``
``````````````````````````````

..    Specifies the min free space percent in a thin pool require for new device creation to succeed. This check applies to both free data space as well as free metadata space. Valid values are from 0% - 99%. Value 0% disables free space checking logic. If user does not specify a value for this option, the Engine uses a default value of 10%.

シン・プールが新しいデバイスを正常に作成するために必要な最小ディスク空き容量を、パーセントで指定します。チェックはデータ領域とメタデータ領域の両方に適用します。有効な値は 0% ~ 99% です。値を 0% に指定すると空き領域のチェック機構を無効にします。ユーザがオプションの値を指定しなければ、Engine はデフォルト値 10% を用います。

.. Whenever a new a thin pool device is created (during docker pull or during container creation), the Engine checks if the minimum free space is available. If sufficient space is unavailable, then device creation fails and any relevant docker operation fails.

新たなシン・プール・デバイスが生成される際（ ``docker pull`` の処理中あるいはコンテナ生成中）には、必ず Engine が最小空き領域を確認します。十分な空き領域がなかった場合、デバイス生成処理は失敗し、これに関連した ``docker`` 処理もすべて失敗します。

.. To recover from this error, you must create more free space in the thin pool to recover from the error. You can create free space by deleting some images and containers from the thin pool. You can also add more storage to the thin pool.

上のエラーを解消するためには、シン・プール内により多くの空き領域を生成しておくことが必要です。イメージやコンテナーをいくつかそのシンプールから削除すれば、空き領域は確保されます。あるいはシンプールに対して、より多くのストレージを割り当てる方法もあります。

.. To add more space to a LVM (logical volume management) thin pool, just add more storage to the volume group container thin pool; this should automatically resolve any errors. If your configuration uses loop devices, then stop the Engine daemon, grow the size of loop files and restart the daemon to resolve the issue.

LVM（logical volume management；論理ボリューム管理）上のシン・プールに容量追加を行うなら、シン・プールがあるボリューム・グループに対してストレージ追加を行ないます。そうするだけでエラーは自動解消されます。ループ・デバイスを利用するように設定している場合は、いったん Engine デーモンを停止させて、ループ・ファイルのサイズを増やした上でデーモンを再起動すれば、エラーは解消します。

..    Example

指定例：

.. code-block:: bash

   $ dockerd --storage-opt dm.min_free_space=10%

``dm.xfs_nospace_max_retries``
``````````````````````````````

.. Specifies the maximum number of retries XFS should attempt to complete IO when ENOSPC (no space) error is returned by underlying storage device.

ENOSPC（空き容量がない）エラーがストレージドライバで発生した時 、完全な IO を試みるため、 XFS が再試行する上限数を指定します。

.. By default XFS retries infinitely for IO to finish and this can result in unkillable process. To change this behavior one can set xfs_nospace_max_retries to say 0 and XFS will not retry IO after getting ENOSPC and will shutdown filesystem.

デフォルトの XFS は IO が完了するまで無限に繰り返すため、結果として停止不可能なプロセスが発生する可能があります。この挙動を変更するには、xfs_nospace_max_retries を 0 にし、XFS が ENOSPC の後に IO を再試行せず、ファイルシステムをシャットダウンします。

.. Example
使用例：

.. code-block:: bash

   $ sudo dockerd --storage-opt dm.xfs_nospace_max_retries=0

``dm.libdm_log_level``
``````````````````````````````

.. Specifies the maxmimum libdm log level that will be forwarded to the dockerd log (as specified by --log-level). This option is primarily intended for debugging problems involving libdm. Using values other than the defaults may cause false-positive warnings to be logged.

 ``dockerd`` ログに渡す（ ``--log-level`` として指定）、最大の ``libdb`` ログレベルを指定します。このオプションが主に想定しているのは、 ``libdm`` によって引き起こされる問題のデバッグ用途です。デフォルトから値を変えることにより、偽陽性のログが記録させる可能性があります。

.. Values specified must fall within the range of valid libdm log levels. At the time of writing, the following is the list of libdm log levels as well as their corresponding levels when output by dockerd.

値の指定は、有効な ``libdm`` ログレベル範囲内に収める必要があります。以下の ``libdm`` ログレベル一覧にあるものから、 ``dockerd`` による適切なレベルに応じて書き込まれます。


.. list-table::
   :header-rows: 1

   * - ``libdm`` レベル
     - 値
     - ``--log-level``
   * - ``_LOG_FATAL``
     - 2
     - error
   * - ``_LOG_ERR``
     - 3
     - error
   * - ``_LOG_WARN``
     - 4
     - warn
   * - ``_LOG_NOTICE``
     - 5
     - info
   * - ``_LOG_INFO``
     - 6
     - info
   * - ``_LOG_DEBUG``
     - 7
     - debug

.. Example
使用例：

.. code-block:: bash

   $ sudo dockerd \
         --log-level debug \
         --storage-opt dm.libdm_log_level=7

.. Currently supported options of zfs:
.. 現時点で ``zfs`` がサポートしているオプション：

.. _zfs-options:

ZFS オプション
--------------------

``zfs.fsname``
````````````````````

..    Set zfs filesystem under which docker will create its own datasets. By default docker will pick up the zfs filesystem where docker graph (/var/lib/docker) is located.

Docker が自身のデータセットとして、どの zfs ファイルシステムを使うか指定します。デフォルトの Docker は docker グラフ（ ``/var/lib/docker`` ）がある場所を zfs ファイルシステムとして用います。

..    Example

使用例：

.. code-block:: bash

   $ dockerd -s zfs --storage-opt zfs.fsname=zroot/docker

.. _btrfs-options:

Btrfs オプション
--------------------

``btrfs.min_space``
````````````````````

..    Specifies the mininum size to use when creating the subvolume which is used for containers. If user uses disk quota for btrfs when creating or running a container with --storage-opt size option, docker should ensure the size cannot be smaller than btrfs.min_space.

コンテナ用サブボリュームの作成時に、最小容量を指定します。コンテナに ``--storage-opt 容量`` オプションを指定して作成・実行する時、ユーザが btrfs のディスク・クォータを使っていれば、docker は ``btrfs.min_space`` より小さな ``容量`` を指定できないようにします。

..    Example

.. code-block:: bash

   $ docker daemon -s btrfs --storage-opt btrfs.min_space=10G


.. Overlay2 options
.. _overlay2-options:
overlay2 のオプション
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

``overlay2.override_kernel_check``
````````````````````````````````````````

.. Overrides the Linux kernel version check allowing overlay2. Support for specifying multiple lower directories needed by overlay2 was added to the Linux kernel in 4.0.0. However, some older kernel versions may be patched to add multiple lower directory support for OverlayFS. This option should only be used after verifying this support exists in the kernel. Applying this option on a kernel without this support will cause failures on mount.

Linux カーネルのバージョンチェックで overlay2 の許可を上書きします。Linux カーネル 4.0.0 では overlay2 が必要とする複数の低位ディレクトリの指定をサポートしました。しかしながら、いくつかの古いカーネルでは、 OverlayFS が複数の低位ディレクトリをサポートするためにパッチが適用されている可能性があります。このオプションは、カネール上でサポート対象であることを確認している場合のみ使うべきです。このオプションをサポートしていないカーネル上で実行すると、マウントに失敗します。

``overlay2.size``
````````````````````

.. Sets the default max size of the container. It is supported only when the backing fs is xfs and mounted with pquota mount option. Under these conditions the user can pass any size less then the backing fs size.

コンテナのデフォルト :ruby:`最大容量 <max size>` を指定します。サポートされているのは、バックエンドのファイルシステムが ``xfs`` かつ ``pquota`` マウントオプションでマウントしている場合のみです。ユーザが指定できる容量は、バックエンドのファイルシステムの容量以下です。

.. Example

使用例

.. code-block:: dockerfile

   $ sudo dockerd -s overlay2 --storage-opt overlay2.size=1G

.. Windowsfilter options
windowsfilter のオプション
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

``size``
``````````

.. Specifies the size to use when creating the sandbox which is used for containers. Defaults to 20G.

コンテナが使用するサンドボックスの作成時に使う容量を指定します。デフォルトは 20GB です。

.. Example

使用例

.. code-block:: bash

   C:\> dockerd --storage-opt size=40G

.. LCOW (Linux Containers on Windows) options

LCOW (Windows の Linux コンテナ）オプション
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

``lcow.globalmode``
````````````````````

.. Specifies whether the daemon instantiates utility VM instances as required (recommended and default if omitted), or uses single global utility VM (better performance, but has security implications and not recommended for production deployments).

デーモンに対して必要とされるユーティリティ VM インスタンスの例示を指定（推奨かつ、省略時はデフォルト）するか、1つのグローバル・ユーティリティ VM （優れたパフォーマンスですが、セキュリティ関連でプロダクションへのデプロイは推奨されません）を使います。

.. Example

使用例

.. code-block:: bash

   C:\> dockerd --storage-opt lcow.globalmode=false

``lcow.kirdpath``
````````````````````
.. Specifies the folder path to the location of a pair of kernel and initrd files used for booting a utility VM. Defaults to %ProgramFiles%\Linux Containers.

ユーティリティ VM を起動するために使う、カーネルと initrd ファイルのセットが入っているフォルダを指定します。デフォルトは ``%ProgramFiles%\Linux Containers`` です。

.. Example

使用例

.. code-block:: bash

   C:\> dockerd --storage-opt lcow.kirdpath=c:\path\to\files

``lcow.kernel``
````````````````````

.. Specifies the filename of a kernel file located in the lcow.kirdpath path. Defaults to bootx64.efi.

カーネルのファイルが置かれている ``cow.kirdpath`` パスにあるファイル名を指定します。デフォルトは ``bootx64.efi`` です。

.. Example

使用例

.. code-block:: bash

   C:\> dockerd --storage-opt lcow.kernel=kernel.efi

``lcow.initrd``
````````````````````

.. Specifies the filename of an initrd file located in the lcow.kirdpath path. Defaults to initrd.img.

initrd ファイルが置かれている ``cow.kirdpath`` パスにあるファイル名を指定します。デフォルトは ``initrd.img`` です。

.. Example
使用例

.. code-block:: bash

   C:\> dockerd --storage-opt lcow.initrd=myinitrd.img

``lcow.bootparameters``
``````````````````````````````

.. Specifies additional boot parameters for booting utility VMs when in kernel/ initrd mode. Ignored if the utility VM is booting from VHD. These settings are kernel specific.

kernel/initrd モードでは、ユーティリティ VM をッ起動するための起動パラメータを追加で指定します。ユーティリティ VM を VHD から起動する場合には、無視されミズ会う。それぞれの設定はカーネルに依存します。

.. Example
使用例

.. code-block:: bash

   C:\> dockerd --storage-opt "lcow.bootparameters='option=value'"

``lcow.vhdx``
````````````````````

.. Specifies a custom VHDX to boot a utility VM, as an alternate to kernel and initrd booting. Defaults to uvm.vhdx under lcow.kirdpath.

起動時に、代替カーネルと initrd を使う、ユーティリティ VM として起動するカスタム VHDX を指定します。デフォルトは ``lcow.kirdpath`` 以下の ``uvm.vhdx`` です。

.. Example
使用例

.. code-block:: dockerfile

   C:\> dockerd --storage-opt lcow.vhdx=custom.vhdx

``lcow.timeout``
````````````````````

.. Specifies the timeout for utility VM operations in seconds. Defaults to 300.

ユーティリティ VM 操作のタイムアウトを秒で指定します。デフォルトは 300 です。

.. Example
使用例

.. code-block:: bash

   C:\> dockerd --storage-opt lcow.timeout=240

``lcow.sandboxsize``
````````````````````

.. Specifies the size in GB to use when creating the sandbox which is used for containers. Defaults to 20. Cannot be less than 20.

コンテナが使うサンドボックスの作成時、使用する容量を GB で指定します。デフォルトは 20 です。 20 以下にはできません。

.. Example
使用例

.. code-block:: bash

   C:\> dockerd --storage-opt lcow.sandboxsize=40


.. Docker runtime execution options
.. _docker-runtime-execution-options:

Docker ランタイム実行オプション
----------------------------------------

.. The Docker daemon relies on a OCI compliant runtime (invoked via the containerd daemon) as its interface to the Linux kernel namespaces, cgroups, and SELinux.

Docker デーモンは `OCI <https://github.com/opencontainers/specs>`_ 規格のランタイムに依存します（ ``containerd`` デーモンを経由して呼び出します）。これが Linux カーネルの ``namespace`` 、 ``cgroups`` 、``SELinux`` のインターフェースとして働きます。

.. By default, the Docker daemon automatically starts containerd. If you want to control containerd startup, manually start containerd and pass the path to the containerd socket using the --containerd flag. For example:

デフォルトでは、 Docker デーモンは自動的に ``containerd`` を起動します。 ``containerd`` の起動を制御したい場合は、手動で ``containerd`` の起動時、 ``--containerd`` フラグを使って ``containerd`` ソケットのパスを指定します。以下は実行例です。

.. code-block:: bash

   $ sudo dockerd --containerd /var/run/dev/docker-containerd.sock

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

.. The native.cgroupdriver option specifies the management of the container’s cgroups. You can only specify cgroupfs or systemd. If you specify systemd and it is not available, the system errors out. If you omit the native.cgroupdriver option, cgroupfs is used on cgroup v1 hosts, systemd is used on cgroup v2 hosts with systemd available.

``native.cgroupdriver`` オプションはコンテナの cgroups 管理を指定します。 ``systemd`` の ``cgroupfs`` でのみ指定可能です。 ``systemd`` で指定時、対象が利用可能でなければ、システムはエラーを返します。 ``native.cgroupdriver`` オプションを指定しなければ ``cgroupfs`` を使います。 ``native.cgroupdriver `` オプションを省略すると、 ``cgroupfs`` は cgroup v1 ホストを使い、 systemd が利用可能であれば ``systemd`` は cgroup v2 ホストを使います。

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

.. Will make hyperv the default isolation technology on Windows. If no isolation value is specified on daemon start, on Windows client, the default is hyperv, and on Windows server, the default is process.

この指定は Windows 上のデフォルト分離技術 ``hyperv`` を使います。デーモン起動時に分離技術の指定が無ければ、Windows クライアントはデフォルトで ``hyper-v`` を使い、Windows server はデフォルトで ``process`` を使います。

.. Daemon DNS options
.. _daemon-dns-options:

デーモンの DNS オプション
------------------------------

.. To set the DNS server for all Docker containers, use:

全ての Docker コンテナが使う DNS サーバを指定するには、次のようにします。

.. code-block:: bash

   $ sudo dockerd --dns 8.8.8.8

.. To set the DNS search domain for all Docker containers, use:

全てのコンテナが使う DNS 検索ドメインを設定するには、次のようにします。

.. code-block:: bash

   $ sudo dockerd --dns-search example.com

.. Allow push of nondistributable artifacts

:ruby:`配布不可能 <nondistributable>` な :ruby:`アーティファクト <artifact>` の送信を許可
------------------------------------------------------------------------------------------

.. Some images (e.g., Windows base images) contain artifacts whose distribution is restricted by license. When these images are pushed to a registry, restricted artifacts are not included.

イメージによっては（例： Windows ベースのイメージ）、ライセンスによって配布が制限されているアーティファクトを含む場合があります。これらイメージをレジストリに送信しようとしても、制限されたアーティファクトは含まれません。

.. To override this behavior for specific registries, use the --allow-nondistributable-artifacts option in one of the following forms:

特定の制限に対するこの挙動を上書きするには、以下の形式どちらかで ``--allow-nondistributable-artifacts`` オプションを使います。

..    --allow-nondistributable-artifacts myregistry:5000 tells the Docker daemon to push nondistributable artifacts to myregistry:5000.
    --allow-nondistributable-artifacts 10.1.0.0/16 tells the Docker daemon to push nondistributable artifacts to all registries whose resolved IP address is within the subnet described by the CIDR syntax.

* ``--allow-nondistributable-artifacts myregistry:5000`` は、 Docker デーモンに対して myregistry:500 へ配布不可能なアーティファクトを送信するよう命令します。
* ``--allow-nondistributable-artifacts 10.1.0.0/16`` は、 Docker デーモンに対し、 CIDR 構文で記述されたサブネット範囲内で、 IP アドレスの名前解決ができる全てのレジストリに対し、配布不可能なアーティファクトを送信するよう命令します。

.. This option can be used multiple times.

このオプションは何回も使えます。

.. This option is useful when pushing images containing nondistributable artifacts to a registry on an air-gapped network so hosts on that network can pull the images without connecting to another server.

配布不可能なアーティファクトを含むイメージを :ruby:`エアギャップ・ネットワーク <air-gapped network>` （訳者注：空気で絶縁されているかのように、到達できないネットワークの意味）上のレジストリに送信を許可する場合は、他のサーバに接続しなくてもイメージを取得できるようになるため、このオプションが役立ちます。

..    Warning: Nondistributable artifacts typically have restrictions on how and where they can be distributed and shared. Only use this feature to push artifacts to private registries and ensure that you are in compliance with any terms that cover redistributing nondistributable artifacts.

.. warning::

  配布不可能アーティファクトは、典型的に、どのように、どこで配布や共有ができるか制限があります。この機能を、アーティファクトをプライベート・レジストリに送信するために使う場合、配布不可能なアーティファクトの再配布に関する利用条件に従ってください。

.. Insecure registries
.. _insecure-registries:

:ruby:`安全ではないレジストリ <insecure registry>`
--------------------------------------------------

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
^^^^^^^^^^^^^^^^^^^^

.. Enabling --disable-legacy-registry forces a docker daemon to only interact with registries which support the V2 protocol. Specifically, the daemon will not attempt push, pull and login to v1 registries. The exception to this is search which can still be performed on v1 registries.

``--disable-legacy-registry`` を有効にしたら、Docker は v2 プロトコルをサポートしているデーモンとしか通信しないように強制します。この指定によって、デーモンは v1 レジストリへの ``push`` 、 ``pull`` 、 ``login`` を阻止します。例外として、v1 レジストリでも ``search`` のみ実行できます。

.. Running a Docker daemon behind a HTTPS_PROXY
.. _running-a-docker-daemon-behind-a-https_proxy:

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

.. Default Ulimits settings
.. _default-ulimits-settings:

デフォルト ``ulimits`` 設定
====================

.. --default-ulimit allows you to set the default ulimit options to use for all containers. It takes the same options as --ulimit for docker run. If these defaults are not set, ulimit settings will be inherited, if not set on docker run, from the Docker daemon. Any --ulimit options passed to docker run will overwrite these defaults.

``--default-ulimit`` を使い、全てのコンテナに対するデフォルトの ``ulimit`` オプションを指定できます。これは ``docker run`` 時に ``--ulimit`` オプションを指定するのと同じです。デフォルトを設定しなければ、 ``ulimit`` 設定を継承します。 ``docker run`` 時に設定しななければ、Docker デーモンから継承します。``docker run`` 時のあらゆる ``--ulimit`` オプションは、デフォルトを上書きします。

.. Be careful setting nproc with the ulimit flag as nproc is designed by Linux to set the maximum number of processes available to a user, not to a container. For details please check the run reference.

``noproc`` と ``ulimit`` フラグを使う時は注意してください。 ``noproc`` は Linux がユーザに対して利用可能な最大プロセス数を設定するものであり、コンテナ向けではありません。詳細については、 :doc:`run` リファレンスをご確認ください。

.. Nodes discovery
.. _nodes-discovery:

ノードのディスカバリ（検出）
------------------------------

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

現在サポートされているクラスタ・ストアのオプションは、i以下の通りです。

.. list-table::
   :header-rows: 1

   * - オプション
     - 説明
   * - ``discovery.heartbeat``
     - ハートビート・タイマーを秒で指定します。これはデーモンの ``keepalive`` メカニズムによって、クラスタ上に存在するノードを利用可能にするためのディスカバリ・モジュールが機能するようにします。
   * - ``discovery.ttl``
     - TTL（time-to-live）を秒で指定します。これは有効なハートビートを指定した ttl 値以内に受信できなければ、ディスカバリ・モジュールがノードをタイムアウトするために使います。
   * - ``kv.cacertfile``
     - 信頼すべき CA 証明書がエンコードされた PEM のローカル・パスを指定します。
   * - ``kv.certfile``
     - 証明書でエンコードされた PEM のローカル・パスを指定。この証明書はクライアントがキーバリュー・ストアとの通信の証明に使います。
   * - ``kv.keyfile``
     - 秘密鍵がエンコードされた PEM のローカル・パスを指定します。この秘密鍵はクライアントがキーバリュー・ストアと通信時に鍵として使います。
   * - ``kv.path``
     - キーバリュー・ストアのパスを指定します。指定しなければ、デフォルトの ``docker/nodes`` を使います。

.. Access authorization
.. _access-authorization:

アクセス認証
--------------------

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

デーモンの :ruby:`ユーザ名前空間 <user namespace>` オプション
----------------------------------------------------------------------
========================================

.. The Linux kernel user namespace support provides additional security by enabling a process, and therefore a container, to have a unique range of user and group IDs which are outside the traditional user and group range utilized by the host system. Potentially the most important security improvement is that, by default, container processes running as the root user will have expected administrative privilege (with some restrictions) inside the container but will effectively be mapped to an unprivileged uid on the host.

Linux カーネルの `ユーザ名前空間(user namespace)サポート <http://man7.org/linux/man-pages/man7/user_namespaces.7.html>`_  はプロセスに対する追加のセキュリティを提供します。これを使えば、コンテナでユーザ ID とグループ ID を使う場合、それをコンテナの外、つまり Docker ホスト上で使うユーザ ID とグループ ID のユニークな範囲を指定できます。これは重要なセキュリティ改善になる可能性があります。デフォルトでは、コンテナのプロセスは ``root`` ユーザとして動作しますので、コンテナ内で管理特権（と制限）を持っていることが予想されます。しかし、その影響はホスト上の権限の無い ``uid`` に対して割り当てられます。

.. For details about how to use this feature, as well as limitations, see Isolate containers with a user namespace.

この機能の使い方に関する詳細や制限は、 :doc:`</engine/security/userns-remap>` をご覧ください。

.. Miscellaneous options
.. _miscellaneous-options:

その他のオプション
--------------------

.. IP masquerading uses address translation to allow containers without a public IP to talk to other machines on the Internet. This may interfere with some network topologies and can be disabled with --ip-masq=false.

IP マスカレードはコンテナがパブリック IP を持っていなくても、インターネット上の他のマシンと通信するための仕組みです。これにより、インターフェースは複数のネットワーク・トポロジを持ちますが、 ``--ip-masq=false`` を使って無効化できます。

.. Docker supports softlinks for the Docker data directory (/var/lib/docker) and for /var/lib/docker/tmp. The DOCKER_TMPDIR and the data directory can be set like this:

Docker は Docker データ・ディレクトリ（ ``/var/lib/docker`` ）と ``/var/lib/docker/tmp``  に対するソフトリンクをサポートしています。 ``DOCKER_TMPDIR`` を使っても、データディレクトリを次のように指定可能です。

.. code-block:: bash

   DOCKER_TMPDIR=/mnt/disk2/tmp /usr/local/bin/docker daemon -D -g /var/lib/docker -H unix:// > /var/lib/docker-machine/docker.log 2>&1

あるいは

.. code-block:: bash

   export DOCKER_TMPDIR=/mnt/disk2/tmp
   /usr/local/bin/dockerd -D -g /var/lib/docker -H unix:// > /var/lib/docker-machine/docker.log 2>&1

.. Default cgroup parent
.. _default-cgroup-parent:

デフォルトの親 cgroup
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. The --cgroup-parent option allows you to set the default cgroup parent to use for containers. If this option is not set, it defaults to /docker for fs cgroup driver and system.slice for systemd cgroup driver.

``--cgroup-parent`` オプションは、コンテナが利用するデフォルトの親 cgroup を設定します。このオプションが指定されていない場合、デフォルトは fs cgroup ドライバに対しては ``/docker`` となり、systemd cgroup ドライバに対しては ``system.slice`` となります。

.. If the cgroup has a leading forward slash (/), the cgroup is created under the root cgroup, otherwise the cgroup is created under the daemon cgroup.

cgroup の先頭がスラッシュ（ ``/`` ）で始まる場合、この cgroup はルート cgroup のもとに生成され、そうでない場合はデーモン cgroup のもとに生成されます。

.. Assuming the daemon is running in cgroup daemoncgroup, --cgroup-parent=/foobar creates a cgroup in /sys/fs/cgroup/memory/foobar, whereas using --cgroup-parent=foobar creates the cgroup in /sys/fs/cgroup/memory/daemoncgroup/foobar

デーモンが仮に ``daemoncgroup`` という cgroup 内で実行されているとすると、 ``--cgroup-parent=/foobar`` という指定を行うと、cgroup は ``/sys/fs/cgroup/memory/foobar`` のもとに生成されます。一方 ``--cgroup-parent=foobar`` と指定すると、cgroup は ``/sys/fs/cgroup/memory/daemoncgroup/foobar`` のもとに生成されます。

.. The systemd cgroup driver has different rules for --cgroup-parent. Systemd represents hierarchy by slice and the name of the slice encodes the location in the tree. So --cgroup-parent for systemd cgroups should be a slice name. A name can consist of a dash-separated series of names, which describes the path to the slice from the root slice. For example, --cgroup-parent=user-a-b.slice means the memory cgroup for the container is created in /sys/fs/cgroup/memory/user.slice/user-a.slice/user-a-b.slice/docker-<id>.scope.

systemd cgroup ドライバには ``--cgroup-parent`` に対して別ルールがあります。systemd はスライス（訳者注：systemd における CPU やメモリなどのリソースを分割する単位のこと）による階層構造により表現され、そのスライス名はツリー内の場所をエンコードしています。したがって systemd cgroups に対する ``--cgroup-parent`` の設定値はスライス名とします。1 つの名前は、一連の名前をダッシュで区切って構成します。これが、そのスライスに対するルートスライスからのパスを表します。たとえば ``--cgroup-parent=user-a-b.slice`` というのは、コンテナに対するメモリ cgroup であり、``/sys/fs/cgroup/memory/user.slice/user-a.slice/user-a-b.slice/docker-<id>.scope`` に生成されます。

.. This setting can also be set per container, using the --cgroup-parent option on docker create and docker run, and takes precedence over the --cgroup-parent option on the daemon.

この指定はコンテナ単位で行うこともできます。その場合は ``docker create`` や ``docker run`` の実行時に ``--cgroup-parent`` を指定します。この指定は、デーモンに対する ``--cgroup-parent`` オプションよりも優先して適用されます。

.. Daemon metrics
.. _dockerd-daemon-metrics:
デーモンのメトリクス
^^^^^^^^^^^^^^^^^^^^

.. The --metrics-addr option takes a tcp address to serve the metrics API. This feature is still experimental, therefore, the daemon must be running in experimental mode for this feature to work.

``--metrics-addr`` オプションは、メトリクス API を提供する TCP アドレスを渡します。この機能はまだ実験的です。そのため、この機能を使うためには、実験的モードでデーモンを実行する必要があります。

.. To serve the metrics API on localhost:9323 you would specify --metrics-addr 127.0.0.1:9323, allowing you to make requests on the API at 127.0.0.1:9323/metrics to receive metrics in the prometheus format.

メトリクス API を ``localhost:9323`` で提供するには、 ``--metrics-addr 127.0.0.1:9323`` を指定します。これにより、 ``127.0.0.1:9323/metrics`` の API にリクエストを送ると、 `prometheus <https://prometheus.io/docs/instrumenting/exposition_formats/>`_ 形式でメトリクスを受信できます。

.. Port 9323 is the default port associated with Docker metrics to avoid collisions with other prometheus exporters and services.

ポート ``9323`` は `Docker メトリクスに関連づけられているデフォルトのポート <https://github.com/prometheus/prometheus/wiki/Default-port-allocations>`_ であり、他の prometheus exporter とサービスと衝突しないようにしています。

.. If you are running a prometheus server you can add this address to your scrape configs to have prometheus collect metrics on Docker. For more information on prometheus refer to the prometheus website.

prometheus サーバを実行中であれば、このアドレスを使って Docker 上のメトリクスを prometheus が収集できるようスクレイプを設定できます。prometheus の詳しい情報は `prometheus のウェブサイト <https://prometheus.io/>`_ をご覧ください。

.. code-block:: yaml

   scrape_configs:
     - job_name: 'docker'
       static_configs:
         - targets: ['127.0.0.1:9323']

.. Please note that this feature is still marked as experimental as metrics and metric names could change while this feature is still in experimental. Please provide feedback on what you would like to see collected in the API.

この機能は実験的な段階であり、メトリクスとメトリクス名は実験的な機能である間に変わる可能性があるのでご注意ください。API での収集に関するフィードバックを提供ください。

.. Node Generic Resources
.. _dockerd-node-generic-resources:
:ruby:`ノードに属する <node generic>` リソース
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. The --node-generic-resources option takes a list of key-value pair (key=value) that allows you to advertise user defined resources in a swarm cluster.

``--node-generic-resources`` オプションはキーバリューのペア（ ``key=value`` ）を指定子、swarm クラスタ内にユーザ定義リソースを :ruby:`通知します <advertise>` 。

.. The current expected use case is to advertise NVIDIA GPUs so that services requesting NVIDIA-GPU=[0-16] can land on a node that has enough GPUs for the task to run.

現時点で想定している使用例は、 NVIDIA GPU の通知です。 ``NVIDIA-GPU=[0-16]`` を要求するサービスは、タスクを実行可能なノート上での処理を可能にします。

.. Example of usage:

使用例：

.. code-block:: yalm

   {
     "node-generic-resources": [
       "NVIDIA-GPU=UUID1",
       "NVIDIA-GPU=UUID2"
     ]
   }

.. Daemon configuration file
.. _daemon-configuration-file:

デーモン設定ファイル
--------------------

.. The --config-file option allows you to set any configuration option for the daemon in a JSON format. This file uses the same flag names as keys, except for flags that allow several entries, where it uses the plural of the flag name, e.g., labels for the label flag.

``--config-file`` オプションを使えば、デーモンに対する設定オプションを JSON 形式で指定できます。このファイルでは、フラグと同じ名前をキーとします。ただし、複数の項目を指定可能なフラグの場合は、キーを複数形で指定します（例： ``label`` フラグの指定は ``labels`` になります ）。

.. The options set in the configuration file must not conflict with options set via flags. The docker daemon fails to start if an option is duplicated between the file and the flags, regardless their value. We do this to avoid silently ignore changes introduced in configuration reloads. For example, the daemon fails to start if you set daemon labels in the configuration file and also set daemon labels via the --label flag. Options that are not present in the file are ignored when the daemon starts.

設定ファイル上のオプションは、フラグで指定するオプションと競合してはいけません。ファイルとフラグが重複したまま docker デーモンを起動しようとしても、どのような値を指定しても、起動に失敗します。例えば、デーモンの起動時にラベルを設定ファイルで定義し、かつ、 ``--label`` フラグを指定したら、デーモンは起動に失敗します。デーモン起動時、ファイルに記述しないオプション項目は無視します。

.. On Linux

Linux の場合
^^^^^^^^^^^^^^^^^^^^

.. The default location of the configuration file on Linux is /etc/docker/daemon.json. The --config-file flag can be used to specify a non-default location.

デフォルトは、 Linux の場合は ``/etc/docker/daemon.json`` にある設定ファイルを Docker が読み込もうとします。デフォルトではない場所の指定に ``--config-file`` オプションが使えます。

.. This is a full example of the allowed configuration options on Linux:

次の例は、Linux で利用可能な全てのオプションをファイルに記述したものです。

.. code-block:: json

   {
     "allow-nondistributable-artifacts": [],
     "api-cors-header": "",
     "authorization-plugins": [],
     "bip": "",
     "bridge": "",
     "cgroup-parent": "",
     "cluster-advertise": "",
     "cluster-store": "",
     "cluster-store-opts": {},
     "containerd": "/run/containerd/containerd.sock",
     "containerd-namespace": "docker",
     "containerd-plugin-namespace": "docker-plugins",
     "data-root": "",
     "debug": true,
     "default-address-pools": [
       {
         "base": "172.30.0.0/16",
         "size": 24
       },
       {
         "base": "172.31.0.0/16",
         "size": 24
       }
     ],
     "default-cgroupns-mode": "private",
     "default-gateway": "",
     "default-gateway-v6": "",
     "default-runtime": "runc",
     "default-shm-size": "64M",
     "default-ulimits": {
       "nofile": {
         "Hard": 64000,
         "Name": "nofile",
         "Soft": 64000
       }
     },
     "dns": [],
     "dns-opts": [],
     "dns-search": [],
     "exec-opts": [],
     "exec-root": "",
     "experimental": false,
     "features": {},
     "fixed-cidr": "",
     "fixed-cidr-v6": "",
     "group": "",
     "hosts": [],
     "icc": false,
     "init": false,
     "init-path": "/usr/libexec/docker-init",
     "insecure-registries": [],
     "ip": "0.0.0.0",
     "ip-forward": false,
     "ip-masq": false,
     "iptables": false,
     "ip6tables": false,
     "ipv6": false,
     "labels": [],
     "live-restore": true,
     "log-driver": "json-file",
     "log-level": "",
     "log-opts": {
       "cache-disabled": "false",
       "cache-max-file": "5",
       "cache-max-size": "20m",
       "cache-compress": "true",
       "env": "os,customer",
       "labels": "somelabel",
       "max-file": "5",
       "max-size": "10m"
     },
     "max-concurrent-downloads": 3,
     "max-concurrent-uploads": 5,
     "max-download-attempts": 5,
     "mtu": 0,
     "no-new-privileges": false,
     "node-generic-resources": [
       "NVIDIA-GPU=UUID1",
       "NVIDIA-GPU=UUID2"
     ],
     "oom-score-adjust": -500,
     "pidfile": "",
     "raw-logs": false,
     "registry-mirrors": [],
     "runtimes": {
       "cc-runtime": {
         "path": "/usr/bin/cc-runtime"
       },
       "custom": {
         "path": "/usr/local/bin/my-runc-replacement",
         "runtimeArgs": [
           "--debug"
         ]
       }
     },
     "seccomp-profile": "",
     "selinux-enabled": false,
     "shutdown-timeout": 15,
     "storage-driver": "",
     "storage-opts": [],
     "swarm-default-advertise-addr": "",
     "tls": true,
     "tlscacert": "",
     "tlscert": "",
     "tlskey": "",
     "tlsverify": true,
     "userland-proxy": false,
     "userland-proxy-path": "/usr/libexec/docker-proxy",
     "userns-remap": ""
   }

..    Note:
    You cannot set options in daemon.json that have already been set on daemon startup as a flag. On systems that use systemd to start the Docker daemon, -H is already set, so you cannot use the hosts key in daemon.json to add listening addresses. See https://docs.docker.com/engine/admin/systemd/#custom-docker-daemon-options for how to accomplish this task with a systemd drop-in file.

.. note::

   デーモンの起動時に既にフラグが指定されていると、 ``daemon.json`` オプションを指定できません。 ``systemd`` を使って Docker デーモンを起動するシステム上では、 ``-H`` が既に設定されているため、リッスンしているアドレスに加え、 ``daemon.json`` で ``hosts`` キーを使えません。 :ruby:`任意の docker デーモン・オプション <custom-docker-daemon-options>` にある、 systemd 投入ファイルでの処理方法をご覧ください。

.. On Windows
Windows の場合
^^^^^^^^^^^^^^^^^^^^

.. The default location of the configuration file on Windows is %programdata%\docker\config\daemon.json. The --config-file flag can be used to specify a non-default location.

デフォルトは、 Windows の場合は ``%programdata%\docker\config\daemon.json`` にある設定ファイルを Docker が読み込もうとします。デフォルトではない場所の指定に ``--config-file`` オプションが使えます。

.. This is a full example of the allowed configuration options on Windows:

次の例は、Windows で利用可能な全てのオプションをファイルに記述したものです。

.. code-block:: json

   {
     "allow-nondistributable-artifacts": [],
     "authorization-plugins": [],
     "bridge": "",
     "cluster-advertise": "",
     "cluster-store": "",
     "containerd": "\\\\.\\pipe\\containerd-containerd",
     "containerd-namespace": "docker",
     "containerd-plugin-namespace": "docker-plugins",
     "data-root": "",
     "debug": true,
     "default-runtime": "",
     "default-ulimits": {},
     "dns": [],
     "dns-opts": [],
     "dns-search": [],
     "exec-opts": [],
     "experimental": false,
     "features": {},
     "fixed-cidr": "",
     "group": "",
     "hosts": [],
     "insecure-registries": [],
     "labels": [],
     "log-driver": "",
     "log-level": "",
     "max-concurrent-downloads": 3,
     "max-concurrent-uploads": 5,
     "max-download-attempts": 5,
     "mtu": 0,
     "pidfile": "",
     "raw-logs": false,
     "registry-mirrors": [],
     "shutdown-timeout": 15,
     "storage-driver": "",
     "storage-opts": [],
     "swarm-default-advertise-addr": "",
     "tlscacert": "",
     "tlscert": "",
     "tlskey": "",
     "tlsverify": true
   }

.. Feature options
.. _dockerd-feature-options:
機能のオプション
^^^^^^^^^^^^^^^^^^^^

.. The optional field features in daemon.json allows users to enable or disable specific daemon features. For example, {"features":{"buildkit": true}} enables buildkit as the default docker image builder.

``daemon.json`` のオプション・フィールド ``features`` により、ユーザは特定のデーモン機能を有効または無効にできます。あとえば、 ``{"features":{"buildkit": true}}`` はデフォルトの docker イメージ・ビルダとして ``buildkit`` を有効にします。

.. The list of currently supported feature options:

現時点でサポートしている機能のオプションは、以下の通りです。

..    buildkit: It enables buildkit as default builder when set to true or disables it by false. Note that if this option is not explicitly set in the daemon config file, then it is up to the cli to determine which builder to invoke.

* ``buildkit`` ： ``true`` を指定すると、デフォルトのビルダとして ``buildkit`` を有効化し、 ``false`` では無効化します。このオプションはデーモンの設定ファイル中で明示できないため、どのビルダ使うかは、処理するコマンドライン・クライアントに依存します。

.. Configuration reload behavior
.. _configuration-reload-behavior:
設定を再読込時の挙動
^^^^^^^^^^^^^^^^^^^^
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
* ``live-restore`` ：デーモンの停止期間中もコンテナ実行を維持 :doc:` </config/containers/live-restore>` を有効化します。
* ``max-concurrent-downloads`` ：pull ごとの最大同時ダウンロード数を更新します。
* ``max-concurrent-uploads`` ：push ごとの最大同時アップロード数を更新します。
* ``default-runtime`` ：デフォルトのランタイム（コンテナ作成時にランタイムの指定がない場合）を更新します。「デフォルト」とは Docker 公式パッケージに含まれるランタイムを意味します。
* ``runtimes`` ：コンテナ実行時に利用可能な OCI ランタイムの一覧です。
* ``authorization-plugin`` ：使用する認証プラグインを指定します。
* ``allow-nondistributable-artifacts`` ：レジストリの設定を置き換え、デーモンが配布不可能なアーティファクトを、新しいレジストリのセットに送信できるようにします。
* ``insecure-registries`` ：デーモンの安全ではないレジストリを、新しいセットの安全ではないレジストリに置き換えます。デーモンの設定を読み込み直した時、かつて設定していた安全ではないレジストリが存在していなければ、デーモンの設定から既存のものが削除されます。
* ``registry-mirrors`` ：デーモンのレジストリ・ミラーを、新しいセットのレジストリ・ミラーに置き換えます。デーモンの設定を読み込み直した時、かつて設定していたレジストリ・ミラーが存在していなければ、デーモンの設定から既存のものが削除されます。
* ``shuwdown-timeout`` ：全てのコンテナを停止するための、デーモンの既存のタイムアウト設定を、新しいタイムアウトに置き換えます。
* ``features`` ：特定の機能を有効化または無効化します。

.. Updating and reloading the cluster configurations such as --cluster-store, --cluster-advertise and --cluster-store-opts will take effect only if these configurations were not previously configured. If --cluster-store has been provided in flags and cluster-advertise not, cluster-advertise can be added in the configuration file without accompanied by --cluster-store Configuration reload will log a warning message if it detects a change in previously configured cluster configurations.

``--cluster-store`` 、 ``--cluster-advertise`` 、 ``--cluster-store-opts`` のようなクラスタ設定情報の更新や再読み込みが反映できるのは、これまでに指定しない項目に対してのみです。フラグで ``--cluster-store`` を指定しても ``cluster-advertise`` を指定していなければ、 ``cluster-advertise`` は ``--cluster-store`` を一緒に指定しなくても反映します。既に設定済みのクラスタ設定に対して変更を試みたら、設定読み込み時に警告メッセージをログに残します。

.. Running multiple daemons
.. _running-multiple-daemons:

複数のデーモンを実行
--------------------

..     Note: Running multiple daemons on a single host is considered as "experimental". The user should be aware of unsolved problems. This solution may not work properly in some cases. Solutions are currently under development and will be delivered in the near future.

.. note::

   単一ホスト上での複数デーモンの実行は「実験的」機能です。利用者は、未解決問題に注意すべきです。この解決方法は、特定条件下で動作しない可能性があります。解決方法は現在開発中であり、近いうちに解決されるでしょう。

.. This section describes how to run multiple Docker daemons on a single host. To run multiple daemons, you must configure each daemon so that it does not conflict with other daemons on the same host. You can set these options either by providing them as flags, or by using a daemon configuration file.

このセクションの説明は、単一ホスト上で複数の Docker デーモンを実行する方法です。複数のデーモンを実行するには、各デーモンごとに同一ホスト上で重複しないような設定が必要です。各オプションはフラグを使って指定するか、あるいは :ref:`daemon-configuration-file` で指定します。

.. The following daemon options must be configured for each daemon:

各デーモンで以下のオプション指定が必須です：

.. code-block:: bash

   -b, --bridge=                          Attach containers to a network bridge
   --exec-root=/var/run/docker            Root of the Docker execdriver
   --data-root=/var/lib/docker            Root of persisted Docker data
   -p, --pidfile=/var/run/docker.pid      Path to use for daemon PID file
   -H, --host=[]                          Daemon socket(s) to connect to
   --iptables=true                        Enable addition of iptables rules
   --config-file=/etc/docker/daemon.json  Daemon configuration file
   --tlscacert="~/.docker/ca.pem"         Trust certs signed only by this CA
   --tlscert="~/.docker/cert.pem"         Path to TLS certificate file
   --tlskey="~/.docker/key.pem"           Path to TLS key file

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
* ``--data-root`` はイメージ、ボリューム、クラスタ状態を保存する場所です。デフォルト値は ``/var/lib/docker`` です。デーモンごとに別々のパラメータを指定し、重複しないようにする必要があります。
* ``-p, --pidfile=/var/run/docker.pid`` はデーモンのプロセス ID を保存する場所です。PID ファイルのパスを指定します。
* ``--host=[]`` には、 Docker デーモンがクライアントからの接続をリッスンする場所を指定します。指定しなければ、デフォルトは ``/var/run/docker.sock`` です。
* ``--iptables=false`` は、Docker デーモンが iptables へのルール追加を阻止します。複数のデーモンが iptables ルールを管理すると、既存のルールが他のデーモンによって上書きされてしまう可能性があります。このオプションを無効化すると、コンテナのポートを公開するためには、手動で iptables のルールを追加する必要があります。 Docker が iptables のルール追加を防止すると、 ``--ip-masq`` を ``true`` にしていたとしても、 IP マスカレードのルールを追加できず、Docker コンテナは外部ホストへ接続できなかったり、デフォルトのブリッジ以外を使うインターネットに接続できなくなります。
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

   docker daemon
      https://docs.docker.com/engine/reference/commandline/daemon/
