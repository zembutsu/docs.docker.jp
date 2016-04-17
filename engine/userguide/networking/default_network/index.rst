.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/userguide/networking/default_network/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/userguide/networking/default_network/index.md
   doc version: 1.11
      https://github.com/docker/docker/commits/master/docs/userguide/networking/default_network/index.md
.. check date: 2016/04/17
.. Commits on Nov 3, 2015 9ef855f9e5fa8077468bda5ce43155318c58e60e
.. ---------------------------------------------------------------------------

.. Docker default bridge network

.. _docker-default-bridge-network:

=========================================
Docker デフォルト・ブリッジ・ネットワーク
=========================================

.. With the introduction of the Docker networks feature, you can create your own user-defined networks. The Docker default bridge is created when you install Docker Engine. It is a bridge network and is also named bridge. The topics in this section are related to interacting with that default bridge network.

Docker ネットワーク機能の導入部では、自分自身で定義したネットワークを作成できました。Docker のデフォルト・ブリッジは、Docker エンジンのインストール時に作成されたものです。この ``bridge`` ネットワークは、 ``bridge`` とも呼ばれます。以下のセクションでは、デフォルトの ``bridge`` ネットワークに関連する話題を扱っています。

..    Understand container communication
    Legacy container links
    Binding container ports to the host
    Build your own bridge
    Configure container DNS
    Customize the docker0 bridge
    IPv6 with Docker


.. toctree::
   :maxdepth: 1

   container-communication
   dockerlinks
   binding
   build-bridges
   configure-dns
   custom-docker0
   ipv6

.. seealso:: 

   Docker default bridge network
      https://docs.docker.com/engine/userguide/networking/default_network/

