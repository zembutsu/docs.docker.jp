.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/info/
.. SOURCE:
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/info.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_info.yaml
.. check date: 2022/03/20
.. Commits on Oct 12, 2021 ed135fe151ad43ca1093074c8fbf52243402013a
.. -------------------------------------------------------------------

.. docker info

=======================================
docker info
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _docker_info-description:

説明
==========

.. Display system-wide information

システムの幅広い情報を表示します。

.. _docker_info-usage:

使い方
==========

.. code-block:: bash

   $ docker info [OPTIONS]

.. Extended description
.. _docker_info-extended-description:

補足説明
==========

.. This command displays system wide information regarding the Docker installation. Information displayed includes the kernel version, number of containers and images. The number of images shown is the number of unique images. The same image tagged under different names is counted only once.

このコマンドは、 Docker のインストールに関する広範囲なシステム情報を表示します。表示する情報には、カーネルのバージョン、コンテナとイメージの数を含みます。表示するイメージの数とは、ユニークなイメージ数です。同じイメージで違うタグが付いている場合は、１つとして数えます。

.. If a format is specified, the given template will be executed instead of the default format. Go’s text/template package describes all the details of the format.

出力形式（フォーマット）を指定すると、デフォルトの出力形式の代わりに、指定したテンプレートで処理します。出力形式の詳細すべてが Go 言語の `text/template <https://golang.org/pkg/text/template/>`_ パッケージの説明にあります。

.. Depending on the storage driver in use, additional information can be shown, such as pool name, data file, metadata file, data space used, total data space, metadata space used, and total metadata space.

使用するストレージ・ドライバに応じて追加情報を表示します。例えばプール名、データ・ファイル、メタデータ・ファイル、データ使用量、全データの容量、メタデータの使用量、全メタデータの容量です。

.. The data file is where the images are stored and the metadata file is where the meta data regarding those images are stored. When run for the first time Docker allocates a certain amount of data space and meta data space from the space available on the volume where /var/lib/docker is mounted.

データ・ファイルとはイメージの保管場所です。また、メタデータ・ファイルとは各イメージのメタ・データの保管場所です。Docker は初回起動時に ``/var/lib/docker`` をマウントします。そして、この場所にデータ領域とメタ・データ領域を割り当てます。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <docker_info-examples>` をご覧ください。

.. _docker_info-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--format`` , ``-f``
     - 
     - 指定した Go テンプレートを使って、出力を整える

.. Examples
.. _docker_info-examples:

使用例
==========

.. Show output
.. _docker_info-show-output:

短い出力
----------

.. The example below shows the output for a daemon running on Red Hat Enterprise Linux, using the devicemapper storage driver. As can be seen in the output, additional information about the devicemapper storage driver is shown:

以下の例は Red Hat Enterprise Linux 上でデーモンを実行時の出力結果です。ここでは devicemapper ストレージ・ドライバを使っています。ご覧の通り、devicemapper ストレージ・ドライバに関する追加情報が表示されています。

.. code-block:: bash

   $ docker info
   Client:
    Context:    default
    Debug Mode: false
   Server:
    Containers: 14
     Running: 3
     Paused: 1
     Stopped: 10
    Images: 52
    Server Version: 1.10.3
    Storage Driver: devicemapper
     Pool Name: docker-202:2-25583803-pool
     Pool Blocksize: 65.54 kB
     Base Device Size: 10.74 GB
     Backing Filesystem: xfs
     Data file: /dev/loop0
     Metadata file: /dev/loop1
     Data Space Used: 1.68 GB
     Data Space Total: 107.4 GB
     Data Space Available: 7.548 GB
     Metadata Space Used: 2.322 MB
     Metadata Space Total: 2.147 GB
     Metadata Space Available: 2.145 GB
     Udev Sync Supported: true
     Deferred Removal Enabled: false
     Deferred Deletion Enabled: false
     Deferred Deleted Device Count: 0
     Data loop file: /var/lib/docker/devicemapper/devicemapper/data
     Metadata loop file: /var/lib/docker/devicemapper/devicemapper/metadata
     Library Version: 1.02.107-RHEL7 (2015-12-01)
    Execution Driver: native-0.2
    Logging Driver: json-file
    Plugins:
     Volume: local
     Network: null host bridge
    Kernel Version: 3.10.0-327.el7.x86_64
    Operating System: Red Hat Enterprise Linux Server 7.2 (Maipo)
    OSType: linux
    Architecture: x86_64
    CPUs: 1
    Total Memory: 991.7 MiB
    Name: ip-172-30-0-91.ec2.internal
    ID: I54V:OLXT:HVMM:TPKO:JPHQ:CQCD:JNLC:O3BZ:4ZVJ:43XJ:PFHZ:6N2S
    Docker Root Dir: /var/lib/docker
    Debug Mode: false
    Username: gordontheturtle
    Registry: https://index.docker.io/v1/
    Insecure registries:
     myinsecurehost:5000
     127.0.0.0/8


.. Show debugging output
.. _docker_info-show-debugging-output:

デバッグ出力を表示
--------------------

.. Here is a sample output for a daemon running on Ubuntu, using the overlay2 storage driver and a node that is part of a 2-node swarm:

この例は Ubuntu 上で実行しているデーモンの出力結果です。 overlay2 ストレージドライバを使い、2つのノードで構成されている swarm （クラスタ）の1つノードだと分かります。

.. code-block:: bash

   $ docker --debug info
   Client:
    Context:    default
    Debug Mode: true
   Server:
    Containers: 14
     Running: 3
     Paused: 1
     Stopped: 10
    Images: 52
    Server Version: 1.13.0
    Storage Driver: overlay2
     Backing Filesystem: extfs
     Supports d_type: true
     Native Overlay Diff: false
    Logging Driver: json-file
    Cgroup Driver: cgroupfs
    Plugins:
     Volume: local
     Network: bridge host macvlan null overlay
    Swarm: active
     NodeID: rdjq45w1op418waxlairloqbm
     Is Manager: true
     ClusterID: te8kdyw33n36fqiz74bfjeixd
     Managers: 1
     Nodes: 2
     Orchestration:
      Task History Retention Limit: 5
     Raft:
      Snapshot Interval: 10000
      Number of Old Snapshots to Retain: 0
      Heartbeat Tick: 1
      Election Tick: 3
     Dispatcher:
      Heartbeat Period: 5 seconds
     CA Configuration:
      Expiry Duration: 3 months
     Root Rotation In Progress: false
     Node Address: 172.16.66.128 172.16.66.129
     Manager Addresses:
      172.16.66.128:2477
    Runtimes: runc
    Default Runtime: runc
    Init Binary: docker-init
    containerd version: 8517738ba4b82aff5662c97ca4627e7e4d03b531
    runc version: ac031b5bf1cc92239461125f4c1ffb760522bbf2
    init version: N/A (expected: v0.13.0)
    Security Options:
     apparmor
     seccomp
      Profile: default
    Kernel Version: 4.4.0-31-generic
    Operating System: Ubuntu 16.04.1 LTS
    OSType: linux
    Architecture: x86_64
    CPUs: 2
    Total Memory: 1.937 GiB
    Name: ubuntu
    ID: H52R:7ZR6:EIIA:76JG:ORIY:BVKF:GSFU:HNPG:B5MK:APSC:SZ3Q:N326
    Docker Root Dir: /var/lib/docker
    Debug Mode: true
     File Descriptors: 30
     Goroutines: 123
     System Time: 2016-11-12T17:24:37.955404361-08:00
     EventsListeners: 0
    Http Proxy: http://test:test@proxy.example.com:8080
    Https Proxy: https://test:test@proxy.example.com:8080
    No Proxy: localhost,127.0.0.1,docker-registry.somecorporation.com
    Registry: https://index.docker.io/v1/
    WARNING: No swap limit support
    Labels:
     storage=ssd
     staging=true
    Experimental: false
    Insecure Registries:
     127.0.0.0/8
    Registry Mirrors:
      http://192.168.1.2/
      http://registry-mirror.example.com:5000/
    Live Restore Enabled: false

.. The global -D option causes all docker commands to output debug information.

グローバル ``-D`` オプションであれば、全ての ``docker`` コマンドのデバッグ情報を出力します。

.. Format the output
.. _docker_info-format-the-output:

出力形式
----------

.. You can also specify the output format:

出力形式の指定もできます。

.. code-block:: bash

   $ docker info --format '{{json .}}'
   {"ID":"I54V:OLXT:HVMM:TPKO:JPHQ:CQCD:JNLC:O3BZ:4ZVJ:43XJ:PFHZ:6N2S","Containers":14, ...}

.. Run docker info on Windows
.. _docker_run-run-docker-info-on-windows:

Windows 上で ``docker info`` を実行
----------------------------------------

.. Here is a sample output for a daemon running on Windows Server 2016:

こちらの例は、 Windows Server 2016 上で実行しているデーモンの出力です。

.. code-block:: bash

   E:\docker>docker info
   Client:
    Context:    default
    Debug Mode: false
   Server:
    Containers: 1
     Running: 0
     Paused: 0
     Stopped: 1
    Images: 17
    Server Version: 1.13.0
    Storage Driver: windowsfilter
     Windows:
    Logging Driver: json-file
    Plugins:
     Volume: local
     Network: nat null overlay
    Swarm: inactive
    Default Isolation: process
    Kernel Version: 10.0 14393 (14393.206.amd64fre.rs1_release.160912-1937)
    Operating System: Windows Server 2016 Datacenter
    OSType: windows
    Architecture: x86_64
    CPUs: 8
    Total Memory: 3.999 GiB
    Name: WIN-V0V70C0LU5P
    ID: NYMS:B5VK:UMSL:FVDZ:EWB5:FKVK:LPFL:FJMQ:H6FT:BZJ6:L2TD:XH62
    Docker Root Dir: C:\control
    Debug Mode: false
    Registry: https://index.docker.io/v1/
    Insecure Registries:
     127.0.0.0/8
    Registry Mirrors:
      http://192.168.1.2/
      http://registry-mirror.example.com:5000/
    Live Restore Enabled: false


親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI の基本コマンド

.. Warnings about kernel support
.. _docker_info-warnings-about-kernel-support:

kernel のサポートに関する警告
==============================

.. If your operating system does not enable certain capabilities, you may see warnings such as one of the following, when you run docker info:

オペレーティングシステムで何らかの :ruby:`ケーパビリティ <capabilitiy>` を有効化できない場合、 ``docker info`` コマンドの実行時、次のようなエラーが出るでしょう。

.. code-block:: bash

   WARNING: Your kernel does not support swap limit capabilities. Limitation discarded.

.. code-block:: bash

   WARNING: No swap limit support

.. You can ignore these warnings unless you actually need the ability to limit these resources, in which case you should consult your operating system’s documentation for enabling them. Learn more.

:doc:`各リソースの制限 </config/containers/resource_constraints>` をするには、各オペレーティングシステムごとに有効化する必要があります。詳細は :ref:`こちら <your-kernel-does-not-support-cgroup-swap-limit-capabilities>` です。この制限が不要の場合、これらのメッセージは無視できます。

.. seealso:: 

   docker info
      https://docs.docker.com/engine/reference/commandline/info/
