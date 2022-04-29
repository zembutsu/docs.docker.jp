.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/config/daemon/ipv6/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/userguide/networking/default_network/ipv6.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/userguide/networking/default_network/ipv6.md
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/config/daemon/ipv6.md
.. check date: 2022/04/29
.. Commits on Aug 7, 2021 fbfa187a83fd8006bd032c149b5a26b684f48032
.. ---------------------------------------------------------------------------

.. Enable IPv6 support

.. _enable-ipv6-support:

========================================
IPv6 サポートの有効化
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Before you can use IPv6 in Docker containers or swarm services, you need to enable IPv6 support in the Docker daemon. Afterward, you can choose to use either IPv4 or IPv6 (or both) with any container, service, or network.

Docker コンテナや swarm サービスで IPv6 を有効化する前に、Docker デーモンで IPv6 サポートを有効化する必要があります。それから、コンテナ、サービス、ネットワークに対して IPv4 か IPv6 （あるいは両方）の割り当てを選びます。

..    Note: IPv6 networking is only supported on Docker daemons running on Linux hosts.

.. note::

   IPv6 ネットワーク機能をサポートしているのは、 Linux ホスト上の Docker デーモンです。

..    Edit /etc/docker/daemon.json, set the ipv6 key to true and the fixed-cidr-v6 key to your IPv6 subnet. In this example we are setting it to 2001:db8:1::/64.

1. ``/etc/docker/daemon.json`` を編集し、 ``ipv6`` キーを ``true`` に設定し、 ``fixed-cidr-v6`` キーを自分の IPv6 サブネットにします。この例では、 ``2001:db8:1::/64`` に対して設定しようとしています。

   .. code-block:: yaml
   
      {
        "ipv6": true,
        "fixed-cidr-v6": "2001:db8:1::/64"
      }
   
   ..    Save the file.

   ファイルを保存します。

..    Reload the Docker configuration file.

2. Docker 設定ファイルを再読み込みします。

   .. code-block:: bash
   
      $ systemctl reload docker

.. You can now create networks with the --ipv6 flag and assign containers IPv6 addresses using the --ip6 flag.

これでネットワーク作成時に ``--ipv6`` を指定できるようになり、コンテナに対して ``--ip6`` フラグで IPv6 アドレスを割り当てられるようになります。

.. seealso:: 

   Enable IPv6 support | Docker Documentation
      https://docs.docker.com/config/daemon/ipv6/
