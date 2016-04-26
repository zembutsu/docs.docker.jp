.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/info/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/info.md
   doc version: 1.11
      https://github.com/docker/docker/commits/master/docs/reference/commandline/info.md
.. check date: 2016/04/26
.. Commits on Mar 31, 2016 44a50abe7b16368bdc8b70e01cb095dc46cbbbaf
.. -------------------------------------------------------------------

.. info

=======================================
info
=======================================

.. code-block:: bash

   Usage: docker info [OPTIONS]
   
   Display system-wide information
   
     --help              Print usage

.. For example:

例：

.. code-block:: bash

   $ docker -D info
   Containers: 14
    Running: 3
    Paused: 1
    Stopped: 10
   Images: 52
   Server Version: 1.9.0
   Storage Driver: aufs
    Root Dir: /var/lib/docker/aufs
    Backing Filesystem: extfs
    Dirs: 545
    Dirperm1 Supported: true
   Execution Driver: native-0.2
   Logging Driver: json-file
   Cgroup Driver: cgroupfs
   Plugins:
    Volume: local
    Network: bridge null host
   Kernel Version: 3.19.0-22-generic
   OSType: linux
   Architecture: x86_64
   Operating System: Ubuntu 15.04
   CPUs: 24
   Total Memory: 62.86 GiB
   Name: docker
   ID: I54V:OLXT:HVMM:TPKO:JPHQ:CQCD:JNLC:O3BZ:4ZVJ:43XJ:PFHZ:6N2S
   Docker Root Dir: /var/lib/docker
   Debug mode (client): true
   Debug mode (server): true
    File Descriptors: 59
    Goroutines: 159
    System Time: 2015-09-23T14:04:20.699842089+08:00
    EventsListeners: 0
    Init SHA1:
    Init Path: /usr/bin/docker
    Docker Root Dir: /var/lib/docker
    Http Proxy: http://test:test@localhost:8080
    Https Proxy: https://test:test@localhost:8080
   WARNING: No swap limit support
   Username: svendowideit
   Registry: [https://index.docker.io/v1/]
   Labels:
    storage=ssd
   Insecure registries:
    myinsecurehost:5000
    127.0.0.0/8

.. The global -D option tells all docker commands to output debug information.

グローバルな ``-D`` オプションは 、 ``docker`` コマンドのデバッグ情報を表示します。

.. When sending issue reports, please use docker version and docker -D info to ensure we know how your setup is configured.

issue レポートを送信するときは、私たちがどのような設定がされているか知るため、 ``docker version`` と ``docker -D info`` をお知らせください。

.. seealso:: 

   info
      https://docs.docker.com/engine/reference/commandline/info/
