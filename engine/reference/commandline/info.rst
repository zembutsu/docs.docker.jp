.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/info/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/info.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/info.md
.. check date: 2016/06/16
.. Commits on Jun 14, 2016 9acf97b72a4d5ff7b1bcad36fb19b53775f01596
.. -------------------------------------------------------------------

.. info

=======================================
info
=======================================

.. code-block:: bash

   使い方: docker info [オプション]
   
   システムの広範囲な情報を表示します。
   
     --help              使い方を表示。

.. This command displays system wide information regarding the Docker installation. Information displayed includes the kernel version, number of containers and images. The number of images shown is the number of unique images. The same image tagged under different names is counted only once.

このコマンドは、 Docker のインストールに関する広範囲なシステム情報を表示します。表示する情報には、カーネルのバージョン、コンテナとイメージの数を含みます。表示するイメージの数とは、ユニークなイメージ数です。同じイメージで違うタグが付いている場合は、１つとして数えます。

.. Depending on the storage driver in use, additional information can be shown, such as pool name, data file, metadata file, data space used, total data space, metadata space used, and total metadata space.

使用するストレージ・ドライバに応じて追加情報を表示します。例えばプール名、データ・ファイル、メタデータ・ファイル、データ使用量、全データの容量、メタデータの使用量、全メタデータの容量です。

.. The data file is where the images are stored and the metadata file is where the meta data regarding those images are stored. When run for the first time Docker allocates a certain amount of data space and meta data space from the space available on the volume where /var/lib/docker is mounted.

データ・ファイルとはイメージの保管場所です。また、メタデータ・ファイルとは各イメージのメタ・データの保管場所です。Docker は初回起動時に ``/var/lib/docker`` をマウントします。そして、この場所にデータ領域とメタ・データ領域を割り当てます。

.. EXAMPLES

.. _info-examples:

例
==========

.. Display Docker system information

.. _display-docker-system-information:

Docker システム情報を表示
------------------------------

.. Here is a sample output for a daemon running on Ubuntu, using the overlay storage driver and a node that is part of a 2 node Swarm cluster:

こちらは Ubuntu 上で実行しているデーモンの出力例です。overlay ストレージドライバを使い、２つのノードを持つ Swarm クラスタです。

.. code-block:: bash

   $ docker -D info
   Containers: 14
    Running: 3
    Paused: 1
    Stopped: 10
   Images: 52
   Server Version: 1.11.1
   Storage Driver: overlay
    Root Dir: /var/lib/docker/aufs
    Backing Filesystem: extfs
   Logging Driver: json-file
   Cgroup Driver: cgroupfs
   Plugins:
    Volume: local
    Network: bridge null host
   Swarm: 
    NodeID: 0gac67oclbxq7
    IsManager: YES
    Managers: 2
    Nodes: 2
   Kernel Version: 4.4.0-21-generic
   Operating System: Ubuntu 16.04 LTS
   OSType: linux
   Architecture: x86_64
   CPUs: 24
   Total Memory: 62.86 GiB
   Name: docker
   ID: I54V:OLXT:HVMM:TPKO:JPHQ:CQCD:JNLC:O3BZ:4ZVJ:43XJ:PFHZ:6N2S
   Docker Root Dir: /var/lib/docker
   Debug mode (client): true
   Debug mode (server): true
    File Descriptors: 59
    Goroutines: 159
    System Time: 2016-04-26T14:04:06.14689342-04:00
    EventsListeners: 0
   Http Proxy: http://test:test@localhost:8080
   Https Proxy: https://test:test@localhost:8080
   No Proxy: localhost,127.0.0.1,docker-registry.somecorporation.com
   Username: svendowideit
   Registry: https://index.docker.io/v1/
   WARNING: No swap limit support
   Labels:
    storage=ssd
    staging=true
   Insecure registries:
    myinsecurehost:5000
    127.0.0.0/8

.. The global -D option tells all docker commands to output debug information.

グローバルな ``-D`` オプションは 、 ``docker`` コマンドのデバッグ情報を表示します。

.. The example below shows the output for a daemon running on Red Hat Enterprise Linux, using the devicemapper storage driver. As can be seen in the output, additional information about the devicemapper storage driver is shown:

以下の例は Red Hat Enterprise Linux 上でデーモンを実行時の出力結果です。ここでは devicemapper ストレージ・ドライバを使っています。ご覧の通り、devicemapper ストレージ・ドライバに関する追加情報が表示されています。

.. code-block:: bash

   $ docker info
   Containers: 14
    Running: 3
    Paused: 1
    Stopped: 10
   Untagged Images: 52
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
   Debug mode (client): false
   Debug mode (server): false
   Username: xyz
   Registry: https://index.docker.io/v1/
   Insecure registries:
    myinsecurehost:5000
    127.0.0.0/8

.. seealso:: 

   info
      https://docs.docker.com/engine/reference/commandline/info/
