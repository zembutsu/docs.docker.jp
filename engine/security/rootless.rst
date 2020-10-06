.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/security/rootless/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/engine/security/rootless.md
   doc version: 19.03
.. check date: 2020/07/08
.. Commits on Jun 4, 2020 12b8e799c7b0e57f79d3f5d8e95a8e6e86fcc3f7
.. -------------------------------------------------------------------

.. Run the Docker daemon as a non-root user (Rootless mode)

.. _run-the-docker-daemon-as-a-non-root-user-rootless-mode:

======================================================================
Docker デーモンをルート以外のユーザで実行（Rootless モード）
======================================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3

.. Rootless mode allows running the Docker daemon and containers as a non-root user to mitigate potential vulnerabilities in the daemon and the container runtime.

Rootless モード（Rootless mode）は Docker デーモンとコンテナを root 以外のユーザが実行できるようにするもので、デーモンやコンテナ・ランタイムにおける潜在的な脆弱性を回避します。

.. Rootless mode does not require root privileges even during the installation of the Docker daemon, as long as the prerequisites are met.

Rootless モードは Docker デーモンのインストールに root 権限を必要としないだけでなく、 :ref:`事前準備 <rootless-prerequisites>` においても不要です。

.. Rootless mode was introduced in Docker Engine v19.03.

Rootless モードは Docker Engine v19.03 から導入されました。

..  Note
    Rootless mode is an experimental feature and has some limitations. For details, see Known limitations.

.. note::

   Rootless モードは実験的な機能であり、いくつかの制約があります。詳細は :ref:`既知の制約 <#rootless-known-limitations>` をご覧ください。


.. How it works

どのように動作するか
====================

.. Rootless mode executes the Docker daemon and containers inside a user namespace. This is very similar to userns-remap mode, except that with userns-remap mode, the daemon itself is running with root privileges, whereas in rootless mode, both the daemon and the container are running without root privileges.

Rootless モードは Docker デーモンとコンテナをユーザ名前空間（user namespace）の中で実行します。これは :doc:`userns-remap モード <userns-remap>` と非常に似ていますが、こちらはデーモン自身は root 権限として動作しています。一方の Rootless モードでは、デーモンとコンテナの両方の実行に root 権限がありません。

.. Rootless mode does not use binaries with SETUID bits or file capabilities, except newuidmap and newgidmap, which are needed to allow multiple UIDs/GIDs to be used in the user namespace.

Rootless モードは ``SETUID`` ビットやファイル・ケーパビリティを必要としません、しかし、 ``newuidmap`` と ``newgidmap`` は除外します。これらはユーザ名前空間内で複数の UID/GID を利用可能にするために必要です。

.. Prerequisites

.. _rootless-prerequisites:

事前準備
==========

..    You must install newuidmap and newgidmap on the host. These commands are provided by the uidmap package on most distros.
    /etc/subuid and /etc/subgid should contain at least 65,536 subordinate UIDs/GIDs for the user. In the following example, the user testuser has 65,536 subordinate UIDs/GIDs (231072-296607).

* ホスト上に ``newuidmap`` と ``newgidmap`` のインストールが必要です。各コマンドは多くのディストリビューションで ``uidmap`` パッケージとして提供されています。
* ``/etc/subuid`` と ``/etc/subgid`` はユーザに対して、少なくともサブオーディネイト UID/GID を 65,536 含むべきです。以下の例は、ユーザ ``testuser`` は 65,546 サブオーディネイト UID/GID （231072～296607）を持っています。

.. code-block:: bash

   $ id -u
   1001
   $ whoami
   testuser
   $ grep ^$(whoami): /etc/subuid
   testuser:231072:65536
   $ grep ^$(whoami): /etc/subgid
   testuser:231072:65536

.. Distribution-specific hint

.. _rootless-distribution-specific-hint:

ディストリビューション固有のヒント
----------------------------------------

..    Note: We recommend that you use the Ubuntu kernel.

.. note::

   私たちは Ubuntu kernel の利用を推奨します。

.. Ubuntu

Ubuntu
^^^^^^^^^^

..  No preparation is needed.
    overlay2 storage driver is enabled by default (Ubuntu-specific kernel patch).
    Known to work on Ubuntu 16.04, 18.04, and 20.04.

* 何も準備する必要がありません
* ``overlay2`` ストレージ・ドライバがデフォルトで有効です（ `Ubuntu 固有のカーネル・パッチ <https://kernel.ubuntu.com/git/ubuntu/ubuntu-bionic.git/commit/fs/overlayfs?id=3b7da90f28fe1ed4b79ef2d994c81efbc58f1144>`_ ）
* 動作するのが分かっているのは Ubuntu 16.04、18.04、20.04 です。

Debian GNU/Linux
^^^^^^^^^^^^^^^^^^^^

..  Add kernel.unprivileged_userns_clone=1 to /etc/sysctl.conf (or /etc/sysctl.d) and run sudo sysctl --system.
    To use the overlay2 storage driver (recommended), run sudo modprobe overlay permit_mounts_in_userns=1 (Debian-specific kernel patch, introduced in Debian 10). Add the configuration to /etc/modprobe.d for persistence.
    Known to work on Debian 9 and 10. overlay2 is only supported since Debian 10 and needs modprobe configuration described above.

* ``/etc/sysctl.conf`` （または ``/etc/sysctl.d`` ）に ``kernel.unprivileged_userns_clone=1`` を追加し、 ``sudo sysctl --system`` を実行。
* ``overlay2`` ストレージ・ドライバ（推奨）を使うために、 ``sudo modprobe overlay permit_mounts_in_userns=1`` を実行（ `Debian 10 で導入された、Debian 独自のカーネル・パッチ 。 <https://salsa.debian.org/kernel-team/linux/blob/283390e7feb21b47779b48e0c8eb0cc409d2c815/debian/patches/debian/overlayfs-permit-mounts-in-userns.patch>`_ ）。設定を残し続けるためには、 ``/etc/modprobe.d`` に設定を追加。
* Debian 9 と 10 での動作が分かっています。 ``overlay2`` をサポートしているのは Debian 10 からで、前述の ``modprobe`` 設定が必要。

Arch Linux
^^^^^^^^^^^^^^^^^^^^

..     Add kernel.unprivileged_userns_clone=1 to /etc/sysctl.conf (or /etc/sysctl.d) and run sudo sysctl --system

* ``/etc/sysctl.conf`` （または ``/etc/sysctl.d`` ）に ``kernel.unprivileged_userns_clone=1`` を追加し、 ``sudo sysctl --system`` を実行。


openSUSE
^^^^^^^^^^^^^^^^^^^^

..    sudo modprobe ip_tables iptable_mangle iptable_nat iptable_filter is required. This might be required on other distros as well depending on the configuration.

..    Known to work on openSUSE 15.

* ``sudo modprobe ip_tables iptable_mangle iptable_nat iptable_filte`` が必要。設定状況によっては、他のディストリビューションのような依存関係が必要な場合があります。
* openSUSE 15 での動作が分かっています。

.. _rootless-fedora-31-and-later:

Fedora 31 以降
^^^^^^^^^^^^^^^^^^^^

..    Fedora 31 uses cgroup v2 by default, which is not yet supported by the containerd runtime. Run sudo grubby --update-kernel=ALL --args="systemd.unified_cgroup_hierarchy=0" to use cgroup v1.
    You might need sudo dnf install -y iptables.

* Fedora 31 では cgroup v2 の利用がデフォルトですが、containerd ランタイムでは未サポートです。 ``sudo grubby --update-kernel=ALL --args="systemd.unified_cgroup_h`` を実行し、 cgroup v1 を使います。
* ``sudo dnf install -y iptables`` が必要になる場合もあります。

CentOS 8
^^^^^^^^^^^^^^^^^^^^

..    You might need sudo dnf install -y iptables.

* ``sudo dnf install -y iptables`` が必要になる場合があります。


CentOS 7
^^^^^^^^^^^^^^^^^^^^

..  Add user.max_user_namespaces=28633 to /etc/sysctl.conf (or /etc/sysctl.d) and run sudo sysctl --system.
    systemctl --user does not work by default. Run the daemon directly without systemd: dockerd-rootless.sh --experimental --storage-driver vfs
    Known to work on CentOS 7.7. Older releases require additional configuration steps.
    CentOS 7.6 and older releases require COPR package vbatts/shadow-utils-newxidmap to be installed.
    CentOS 7.5 and older releases require running sudo grubby --update-kernel=ALL --args="user_namespace.enable=1" and a reboot following this.

* ``/etc/sysctl.conf`` （または ``/etc/sysctl.d`` ）に ``user.max_user_namespaces=28633`` を追加し、 ``sudo sysctl --system`` を実行。
* デフォルトでは ``systemctl --user`` が動作しません。systemd を使わずに直接デーモンを実行します： ``dockerd-rootless.sh --experimental --storage-driver vfs``
* CentOS 7.7 での動作が分かっています。以前のリリースでは、追加の設定手順が必要です。
* CentOS 7.6 以前のリリースでは `COPR パッケージ vbatts/shadow-utils-newxidmap <https://copr.fedorainfracloud.org/coprs/vbatts/shadow-utils-newxidmap/>`_ をインストールします。
* CentOS 7.5 以前のリリースでは、 ``sudo grubby --update-kernel=ALL --args="user_namespace.enable=1"`` の実行と、有効化のために再起動が必要です。


.. Known limitations

.. _rootless-known-limitations:

既知の制限
====================

..  Only vfs graphdriver is supported. However, on Ubuntu and Debian 10, overlay2 and overlay are also supported.
    Following features are not supported:
        Cgroups (including docker top, which depends on the cgroups)
        AppArmor
        Checkpoint
        Overlay network
        Exposing SCTP ports
    To use the ping command, see Routing ping packets.
    To expose privileged TCP/UDP ports (< 1024), see Exposing privileged ports.
    IPAddress shown in docker inspect and is namespaced inside RootlessKit’s network namespace. This means the IP address is not reachable from the host without nsenter-ing into the network namespace.
    Host network (docker run --net=host) is also namespaced inside RootlessKit.

* ``vfs`` グラフドライバをサポートしています。しかしながら、 Ubuntu と Debian 10 では ``overlay2`` と ``overlay`` もサポートしています。
* 以下の機能は非サポートです。

   * cgroups（cgroups に依存する ``docker top`` を含みます）
   * AppArmor
   * Checkpoint
   * オーバレイ・ネットワーク
   * SCTP ポートの公開（exposing）
* ``ping`` コマンドを使うには、 :ref:`routing-ping-packets` をご覧ください。
* 特権 TCP/UDP ポート（ポート 1024 以下）を公開するには、 :ref:`exposing-privileged-ports` をご覧ください。
* ``docker inspect`` で表示する ``IPAddress`` とは、RootlessKit のネットワーク名前空間内で名前区間化されたものです。つまり、 ``nsenter`` 化しなければ、そのネットワーク名前空間にはホスト側から到達できない IP アドレスです。
* また、ホスト・ネットワーク（ ``docker run --net=host`` ）も RootlessKit 内に名前空間化されています。

.. Install

.. _rootless-install:

インストール
====================

.. The installation script is available at https://get.docker.com/rootless.

インストール用のスクリプトは  https://get.docker.com/rootless にあります。

.. code-block:: bash

   $ curl -fsSL https://get.docker.com/rootless | sh

.. Make sure to run the script as a non-root user. To install Rootless Docker as the root user, see the Manual installation steps.

スクリプトを root 以外のユーザで実行します。root ユーザとして Rootless Docker をインストールするには、 :ref:`手動インストール <rootless-manual-installation>` の手順をご覧ください。

.. The script shows environment variables that are required:

スクリプトによって表示される環境変数が必要になります：

.. code-block:: bash

   $ curl -fsSL https://get.docker.com/rootless | sh
   ...
   # Docker binaries are installed in /home/testuser/bin
   # WARN: dockerd is not in your current PATH or pointing to /home/testuser/bin/dockerd
   # Make sure the following environment variables are set (or add them to ~/.bashrc):
   
   export PATH=/home/testuser/bin:$PATH
   export PATH=$PATH:/sbin
   export DOCKER_HOST=unix:///run/user/1001/docker.sock
   
   #
   # To control docker service run:
   # systemctl --user (start|stop|restart) docker
   #

.. Manual installation

.. _rootless-manual-installation:

手動インストール
--------------------

.. To install the binaries manually without using the installer, extract docker-rootless-extras-<version>.tar.gz along with docker-<version>.tar.gz from https://download.docker.com/linux/static/stable/x86_64/

インストーラを使わず手動でバイナリをインストールするには、 https://download.docker.com/linux/static/stable/x86_64/ から ``docker-<version>.tar.gz`` と一緒に ``docker-rootless-extras-<version>.tar.gz`` を展開します。

.. If you already have the Docker daemon running as the root, you only need to extract docker-rootless-extras-<version>.tar.gz. The archive can be extracted under an arbitrary directory listed in the $PATH. For example, /usr/local/bin, or $HOME/bin.

既に Docker を root として実行中の場合は、 ``docker-rootless-extras-<version>.tar.gz`` のみを展開します。アーカイブは ``$PATH`` 以下の相対ディレクトリに展開されます。たとえば、 ``/usr/local/bin`` や ``$HOME/bin`` です。


.. Nightly channel

.. _rootless-nightly-channel:

nightly チャネル
------------------------------

.. To install a nightly version of the Rootless Docker, run the installation script using CHANNEL="nightly":

nightly バージョンの Rootless Docker をインストールするには、インストール・スクリプトで ``CHANNEL="nightly"`` を使って実行します。

.. code-block:: bash

   $ curl -fsSL https://get.docker.com/rootless | CHANNEL="nightly" sh

.. The raw binary archives are available at:

単体のバイナリは、こちらからダウンロードできます。

* https://master.dockerproject.org/linux/x86_64/docker-rootless-extras.tgz
* https://master.dockerproject.org/linux/x86_64/docker.tgz

.. Usage

.. _rootless-usage:

使い方
==========

.. Daemon

.. _rootless-usage-daemon:

デーモン
----------

.. Use systemctl --user to manage the lifecycle of the daemon:

``systemctl --user`` を使い、デーモンのライフサイクルを管理します。

.. code-block:: bash

   $ systemctl --user start docker

.. To launch the daemon on system startup, enable the systemd service and lingering:

システム起動時にデーモンを起動するには、 systemd サービスを有効化し、実行し続ける設定にします。

.. code-block:: bash

   $ systemctl --user enable docker
   $ sudo loginctl enable-linger $(whoami)

.. To run the daemon directly without systemd, you need to run dockerd-rootless.sh instead of dockerd:

systemd を使わずにデーモンを直接起動するには、 ``dockerd`` の代わりに ``dockerd-rootless.sh`` の実行が必要です。

.. code-block:: bash

   $ dockerd-rootless.sh --experimental --storage-driver vfs

.. As Rootless mode is experimental, you need to run dockerd-rootless.sh with --experimental.

Rootless モードは実験的なため、 ``docker-rootless.sh`` には ``--experimental`` が必要です。

.. You also need --storage-driver vfs unless you are using Ubuntu or Debian 10 kernel. You don’t need to care about these flags if you manage the daemon using systemd, as these flags are automatically added to the systemd unit file.

また、 Ubuntu や Debian 10 カーネルを使っていない場合は、 ``--storage-driver vfs`` の指定も必要です。systemd を使ってデーモンを管理している場合、これらのフラグについて考慮する必要はありません。systemd ユニットファイル内で各フラグが自動的に追加されるためです。

.. Remarks about directory paths:

ディレクトリのパスについて説明します：

..  The socket path is set to $XDG_RUNTIME_DIR/docker.sock by default. $XDG_RUNTIME_DIR is typically set to /run/user/$UID.
    The data dir is set to ~/.local/share/docker by default.
    The exec dir is set to $XDG_RUNTIME_DIR/docker by default.
    The daemon config dir is set to ~/.config/docker (not ~/.docker, which is used by the client) by default.

* ソケットのパスは、デフォルトで ``$XDG_RUNTIME_DIR/docker.sock`` に設定されます。 ``$XDG_RUNTIME_DIR`` は通常 ``/run/user/$UID`` に設定されます。
* データ・ディレクトリは、デフォルトで ``~/.local/share/docker`` に設定されます。
* 実行ディレクトリは、デフォルトで ``$XDG_RUNTIME_DIR/docker`` に設定されます。

.. Other remarks:

その他の説明です：

..  The dockerd-rootless.sh script executes dockerd in its own user, mount, and network namespaces. You can enter the namespaces by running nsenter -U --preserve-credentials -n -m -t $(cat $XDG_RUNTIME_DIR/docker.pid).
    docker info shows rootless in SecurityOptions
    docker info shows none as Cgroup Driver

* ``dockerd-rootless.sh`` スクリプトの ``dockerd`` 実行は、自分自身のユーザ、マウント、ネットワークの各名前空間を使います。名前空間に入る場合は、 ``nsenter -U --preserve-credentials -n -m -t $(cat $XDG_RUNTIME_DI`` を実行します。
* ``docker info`` を実行すると、 ``SecutiryOptions`` が ``rootless`` と表示します。
* ``docker info`` を実行すると、 ``Cgroup Driver`` が ``none`` と表示します。

.. Client

.. _rootless-usage-client:

クライアント
--------------------

.. You need to specify the socket path explicitly.

ソケットのパスを明確に指定する必要があります。

.. To specify the socket path using $DOCKER_HOST:

``$DOCKER_HOST``` でソケットのパスを指定するには：

.. code-block:: bash

   $ export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock
   $ docker run -d -p 8080:80 nginx

.. To specify the socket path using docker context:

``docker context`` でソケットのパスを指定するには：

.. code-block:: bash

   $ docker context create rootless --description "for rootless mode" --docker "host=unix://$XDG_RUNTIME_DIR/docker.sock"
   rootless
   Successfully created context "rootless"
   $ docker context use rootless
   rootless
   Current context is now "rootless"
   $ docker run -d -p 8080:80 nginx

.. Best practices

.. _rootless-best-practices:

ベストプラクティス
====================

.. Rootless Docker in Docker

.. _rootless-docker-in-docker:

Rootless Docker in Docker
------------------------------

.. To run Rootless Docker inside “rootful” Docker, use the docker:<version>-dind-rootless image instead of docker:<version>-dind.

Rootless Docker の中で "rootful" （root風に） Docker を実行するには、 ``docker:<version>-dind`` イメージの変わりに ``docker:<version>-dind-rootless`` イメージを使います。

.. code-block:: bash

   $ docker run -d --name dind-rootless --privileged docker:19.03-dind-rootless --experimental

.. The docker:<version>-dind-rootless image runs as a non-root user (UID 1000). However, --privileged is required for disabling seccomp, AppArmor, and mount masks.

``docker:<version>-dind-rootless`` イメージは非 root ユーザ（UID 1000）として実行します。しかしながら、 seccomp、AppArmor、mount mask を無効化するために ``--privileged`` が必要です。

.. Expose Docker API socket through TCP

.. _expose-docker-api-socket-through-tcp:

Docker API ソケットを TCP を通して公開
----------------------------------------

.. To expose the Docker API socket through TCP, you need to launch dockerd-rootless.sh with DOCKERD_ROOTLESS_ROOTLESSKIT_FLAGS="-p 0.0.0.0:2376:2376/tcp".

Docker API ソケットを TCP を通して公開するには、 ``dockerd-rootless.sh`` の起動に ``DOCKERD_ROOTLESS_ROOTLESSKIT_FLAGS="-p 0.0.0.0:2376:2376/tcp"`` の指定が必要です。

.. code-block:: bash

   $ DOCKERD_ROOTLESS_ROOTLESSKIT_FLAGS="-p 0.0.0.0:2376:2376/tcp" \
     dockerd-rootless.sh --experimental \
     -H tcp://0.0.0.0:2376 \
     --tlsverify --tlscacert=ca.pem --tlscert=cert.pem --tlskey=key.pem

.. Expose Docker API socket through SSH

.. _expose-docker-api-socket-through-ssh:

Docker API ソケットを SSH を通して公開
----------------------------------------

.. To expose the Docker API socket through SSH, you need to make sure $DOCKER_HOST is set on the remote host.

Docker API ソケットを SSH を通して公開するには、リモートホスト上で ``$DOCKER_HOST``` の指定が必要です。

.. code-block:: bash

   $ ssh -l <REMOTEUSER> <REMOTEHOST> 'echo $DOCKER_HOST'
   unix:///run/user/1001/docker.sock
   $ docker -H ssh://<REMOTEUSER>@<REMOTEHOST> run ...

.. Routing ping packets

.. _rootless-routing-ping-packets:

ping パケットのルーティング
----------------------------------------

.. On some distributions, ping does not work by default.

いくつかのディストリビューションで、デフォルトでは ``ping`` が動作しません。

.. Add net.ipv4.ping_group_range = 0 2147483647 to /etc/sysctl.conf (or /etc/sysctl.d) and run sudo sysctl --system to allow using ping.

``/etc/sysctl.conf`` （または ``/etc/sysctl.d`` ）に ``net.ipv4.ping_group_range = 0 2147483647`` を追加し、 ``ping`` の使用を許可するために ``sudo sysctl --system`` を実行します。

.. Exposing privileged ports

.. _rootless-exposing-privileged-ports

特権ポートの公開
--------------------

.. To expose privileged ports (< 1024), set CAP_NET_BIND_SERVICE on rootlesskit binary.

特権ポート（1024 以下）を公開するには、 ``rootlesskit`` バイナリに対して ``CAP_NET_BIND_SERVICE`` を設定します。

.. code-block:: bash

   $ sudo setcap cap_net_bind_service=ep $HOME/bin/rootlesskit

.. Or add net.ipv4.ip_unprivileged_port_start=0 to /etc/sysctl.conf (or /etc/sysctl.d) and run sudo sysctl --system.

``/etc/sysctl.conf`` （または ``/etc/sysctl.d`` ）に ``net.ipv4.ip_unprivileged_port_start=0`` を追加し、 ``sudo sysctl --system`` を実行します。


.. Limiting resources

.. _rootless-limiting-resources:

リソースの制限
--------------------

.. In Docker 19.03, rootless mode ignores cgroup-related docker run flags such as --cpus, --memory, --pids-limit`.

Docker 19.03 では、rootless モードでは cgroups に関連する ``docker run`` のフラグ、 ``--cpu`` 、 ``--memory`` 、 ``-pids-limit`` を無視します。

.. However, you can still use the traditional ulimit and cpulimit, though they work in process-granularity rather than in container-granularity, and can be arbitrarily disabled by the container process.

しかしながら、伝統的な ``ulimit`` と ``cpulimit`` は利用できます。これはコンテナ粒度というよりはプロセス粒度に対して機能するからです。また、コンテナのプロセスからの任意の割り当て（arbitrarily）は無効化されます。

.. For example:

例：

..  To limit CPU usage to 0.5 cores (similar to docker run --cpus 0.5): docker run <IMAGE> cpulimit --limit=50 --include-children <COMMAND>
    To limit max VSZ to 64MiB (similar to docker run --memory 64m): docker run <IMAGE> sh -c "ulimit -v 65536; <COMMAND>"
    To limit max number of processes to 100 per namespaced UID 2000 (similar to docker run --pids-limit=100): docker run --user 2000 --ulimit nproc=100 <IMAGE> <COMMAND>

* CPU の使用を 0.5 コアに制限するには（ ``docker run --cpus 0.5`` のように）： ``docker run --cpus 0.5): docker run <イメージ> cpulimit --limit=50 --include-children <コマンド>``
* 最大 VSZ を 64MiB に制限するには（ ``docker run --memory 64m`` のように）： ``docker run <イメージ> sh -c "ulimit -v 65536; <コマンド>"`` 
* UID 2000 の名前空間ごとに最大 100 プロセスに制限する（ ``docker run --pids-limit=100`` のように）： ``docker run --user 2000 --ulimit nproc=100 <IMAGE> <コマンド>``

.. Changing the network stack

.. _rootless-changing the network stack:

ネットワーク・スタックの変更
------------------------------

.. dockerd-rootless.sh uses slirp4netns (if installed) or VPNKit as the network stack by default.

デフォルトでは、 ``dockerd-rootless.sh`` は `slirp4netns <https://github.com/rootless-containers/slirp4netns>`_ （インストール済みであれば）または `VPNKit <https://github.com/moby/vpnkit>`_  をネットワーク・スタックとして使います。

.. These network stacks run in userspace and might have performance overhead. See RootlessKit documentation for further information.

これらのネットワーク・スタックはユーザ空間内で実行されるため、パフォーマンスのオーバヘッドを招く場合があります。詳しい情報は `RootlessKit ドキュメント（英語） <https://github.com/rootless-containers/rootlesskit/tree/v0.9.5#network-drivers>`_ をご覧ください。

.. Optionally, you can use lxc-user-nic instead for the best performance. To use lxc-user-nic, you need to edit /etc/lxc/lxc-usernet and set $DOCKERD_ROOTLESS_ROOTLESSKIT_NET=lxc-user-nic.

オプションで、ベストなパフォーマンスの代わりに ``lxc-user-nic`` を利用できます。 ``lxc-user-nic`` を使うには、 `/etc/lxc/lxc-usernet <https://github.com/rootless-containers/rootlesskit/tree/v0.9.5#--netlxc-user-nic-experimental>`_ を編集し、 ``$DOCKERD_ROOTLESS_ROOTLESSKIT_NET=lxc-user-nic`` を指定します。

.. Troubleshooting

.. _rootless-troubleshooting:

トラブルシューティング
==============================

.. Errors when starting the Docker daemon

Docker デーモン起動時のエラー
------------------------------


**[rootlesskit:parent] error: failed to start the child: fork/exec /proc/self/exe: operation not permitted**

.. This error occurs mostly when the value of /proc/sys/kernel/unprivileged_userns_clone is set to 0:

このエラーが発生するのは、ほとんどが ``/proc/sys/kernel/unprivileged_userns_clone`` の値を 0 に設定している時です。

.. code-block:: bash

   $ cat /proc/sys/kernel/unprivileged_userns_clone
   0

.. To fix this issue, add kernel.unprivileged_userns_clone=1 to /etc/sysctl.conf (or /etc/sysctl.d) and run sudo sysctl --system.

この問題を解決するには、 ``/etc/sysctl.conf`` （あるいは ``/etc/sysctl.d`` ）に ``kernel.unprivileged_userns_clone=1`` を追加し、 ``sudo sysctl --system`` を実行します。

**[rootlesskit:parent] error: failed to start the child: fork/exec /proc/self/exe: no space left on device**

.. This error occurs mostly when the value of /proc/sys/user/max_user_namespaces is too small:

このエラーが発生するのは、ほとんどが ``/proc/sys/user/max_user_namespaces`` が小さすぎる時です。

.. code-block:: bash

   $ cat /proc/sys/user/max_user_namespaces
   0

.. To fix this issue, add user.max_user_namespaces=28633 to /etc/sysctl.conf (or /etc/sysctl.d) and run sudo sysctl --system.

この問題を解決するには、 ``/etc/sysctl.conf`` （あるいは ``/etc/sysctl.d`` ）に ``user.max_user_namespaces=28633`` を追加し、 ``sudo sysctl --system`` を実行します。

**[rootlesskit:parent] error: failed to setup UID/GID map: failed to compute uid/gid map: No subuid ranges found for user 1001 (“testuser”)**

.. This error occurs when /etc/subuid and /etc/subgid are not configured. See Prerequisites.

**XDG_RUNTIME_DIR を取得できない**

.. This error occurs when $XDG_RUNTIME_DIR is not set.

このエラーが発生するのは、 ``$XDG_RUNTIME_DIR`` の設定がない時です。

.. On a non-systemd host, you need to create a directory and then set the path:

systemd がないホスト上では、ディレクトリの作成とパスの設定が必要になります。

.. code-block:: bash

   $ export XDG_RUNTIME_DIR=$HOME/.docker/xrd
   $ rm -rf $XDG_RUNTIME_DIR
   $ mkdir -p $XDG_RUNTIME_DIR
   $ dockerd-rootless.sh --experimental

..    Note: You must remove the directory every time you log out.

.. note::

   このディレクトリは、ログアウト時に毎回削除する必要があります。

.. On a systemd host, log into the host using pam_systemd (see below). The value is automatically set to /run/user/$UID and cleaned up on every logout.

systemd ホスト上では、ホストへのログインに ``pam_systemd`` を使います（以下をご覧ください）。この値は自動的に ``/run/user/$UID`` に指定され、ログアウト後にクリーンアップされます。

**systemctl --user がエラー「Failed to connect to bus: No such file or directory」で失敗**

.. This error occurs mostly when you switch from the root user to an non-root user with sudo:

このエラーが発生するのは、ほとんどが root ユーザから非 root ユーザに ``sudo`` で切り替える時です。

.. code-block:: bash

   # sudo -iu testuser
   $ systemctl --user start docker
   Failed to connect to bus: No such file or directory

.. Instead of sudo -iu <USERNAME>, you need to log in using pam_systemd. For example:

``sudo -iu <ユーザ名>`` の代わりに、 ``pam_systemd`` を使ってログインする必要があります。たとえば、

..  Log in through the graphic console
    ssh <USERNAME>@localhost
    machinectl shell <USERNAME>@

* グラフィック・コンロールを通してログイン
* ``ssh <ユーザ名>@localhost``
* ``machinectl shell <ユーザ名>@``

.. The daemon does not start up automatically

**デーモンが自動的に起動しない**

.. You need sudo loginctl enable-linger $(whoami) to enable the daemon to start up automatically. See Usage.

デーモンを自動的に起動するには ``sudo loginctl enable-linger $(whoami)`` を実行する必要があります。 :ref:`rootless-usage` をご覧ください。

.. dockerd fails with “rootless mode is supported only when running in experimental mode”

**dockerd がエラー「rootless mode is supported only when running in experimental mode」**

.. This error occurs when the daemon is launched without the --experimental flag. See Usage.

このエラーが発生するのは、 ``--experimental`` を付けずにデーモンを起動した時です。 :ref:`rootless-usage` をご覧ください。

``docker pull`` errors
------------------------------

**docker: failed to register layer: Error processing tar file(exit status 1): lchown <FILE>: invalid argument**

.. This error occurs when the number of available entries in /etc/subuid or /etc/subgid is not sufficient. The number of entries required vary across images. However, 65,536 entries are sufficient for most images. See Prerequisites.

このエラーが発生するのは、 ``/etc/subuid`` か ``/etc/subgid`` で利用可能なエントリ数が十分ではない時です。エントリに必要な数は、イメージによって様々です。しかしながら、ほとんどのイメージでは 65,536 で十分です。 :ref:`rootless-prerequisites` をご覧ください。

``docker run`` errors
------------------------------

.. --cpus, --memory, and --pids-limit are ignored

**--cpu、 --memory 、 --pids-limit が無視される**

.. This is an expected behavior in Docker 19.03. For more information, see Limiting resources.

この挙動は Docker 19.03 で想定された挙動です。詳しい情報は :ref:`rootless-limiting-resources` をご覧ください。

.. Error response from daemon: cgroups: cgroup mountpoint does not exist: unknown.

**デーモンからのエラー応答「groups: cgroup mountpoint does not exist: unknown.」**

.. This error occurs mostly when the host is running in cgroup v2. See the section Fedora 31 or later for information on switching the host to use cgroup v1.

このエラーが発生するのは、ほとんどが cgroup v2 がホスト上で動作している時です。ホストが cgroup v1 を使うように切り替えるための情報は、 :ref:`rootless-fedora-31-and-later` のセクションをご覧ください。


.. Networking errors

ネットワークのエラー
------------------------------

.. docker run -p fails with cannot expose privileged port

**docker run -p で「cannot expose privileged port」のエラー**

.. docker run -p fails with this error when a privileged port (< 1024) is specified as the host port.

``docker run -p`` はホスト側のポートとして特権ポート（1024未満）を指定するとエラーになります。

.. code-block:: bash

   $ docker run -p 80:80 nginx:alpine
   docker: Error response from daemon: driver failed programming external connectivity on endpoint focused_swanson (9e2e139a9d8fc92b37c36edfa6214a6e986fa2028c0cc359812f685173fa6df7): Error starting userland proxy: error while calling PortManager.AddPort(): cannot expose privileged port 80, you might need to add "net.ipv4.ip_unprivileged_port_start=0" (currently 1024) to /etc/sysctl.conf, or set CAP_NET_BIND_SERVICE on rootlesskit binary, or choose a larger port number (>= 1024): listen tcp 0.0.0.0:80: bind: permission denied.

.. When you experience this error, consider using an unprivileged port instead. For example, 8080 instead of 80.

このエラーに遭遇したら、代わりに特権のないポートの利用を検討ください。たとえば 80 の代わりに 8080 を使います。

.. code-block:: bash

   $ docker run -p 8080:80 nginx:alpine

.. To allow exposing privileged ports, see Exposing privileged ports.

特権ポートの公開を許可するには、 :ref:`rootless-exposing-privileged-ports` をご覧ください。

.. ping doesn’t work

**ping できません**

.. Ping does not work when /proc/sys/net/ipv4/ping_group_range is set to 1 0:

``/proc/sys/net/ipv4/ping_group_range`` が ``1 0`` の設定であれば、 ping は機能しません。

.. code-block:: bash

   $ cat /proc/sys/net/ipv4/ping_group_range
   1       0

.. For details, see Routing ping packets.

詳細は :ref:`rootless-routing-ping-packets` をご覧ください。

.. IPAddress shown in docker inspect is unreachable

**docker inspect で表示された IPAddress に到達できません（unreachable）** 

.. This is an expected behavior, as the daemon is namespaced inside RootlessKit’s network namespace. Use docker run -p instead.

これは予想されうる挙動で、デーモンは RootlessKit のネットワーク名前空間内にいるからです。かわりに ``docker run -p``  を使います。

.. --net=host doesn’t listen ports on the host network namespace

**--net=host がホスト・ネットワーク名前空間上でポートをリッスンしません**

.. This is an expected behavior, as the daemon is namespaced inside RootlessKit’s network namespace. Use docker run -p instead.

これは予想されうる挙動で、デーモンは RootlessKit のネットワーク名前空間内にいるからです。かわりに ``docker run -p``  を使います。

.. seealso:: 

   Run the Docker daemon as a non-root user (Rootless mode)
      https://docs.docker.com/engine/security/rootless/
