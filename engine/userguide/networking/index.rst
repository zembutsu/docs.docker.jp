.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/userguide/networking/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/userguide/networking/index.md
   doc version: 1.10
      https://github.com/docker/docker/commits/master/docs/userguide/networking/index.md
.. check date: 2016/02/12
.. ---------------------------------------------------------------------------

.. Docker network feature overview

.. _docker-networks-feature-overview:

========================================
Docker ネットワーク機能の概要
========================================

.. This sections explains how to use the Docker networks feature. This feature allows users to define their own networks and connect containers to them. Using this feature you can create a network on a single host or a network that spans across multiple hosts.

このセクションでは、どのようにして Docker のネットワーク機能を使うかを説明します。ネットワーク機能により、ユーザは自分自身でネットワークを定義し、コンテナを接続できます。他にも、単一のホスト上でのネットワーク作成や、複数のホストを横断するネットワークを作成できます。

..    Understand Docker container networks
    Work with network commands
    Get started with multi-host networking

* :doc:`dockernetworks`
* :doc:`work-with-networks`
* :doc:`get-started-overlay`

.. If you are already familiar with Docker’s default bridge network, docker0 that network continues to be supported. It is created automatically in every installation. The default bridge network is also named bridge. To see a list of topics related to that network, read the articles listed in the Docker default bridge network.

デフォルトのブリッジ・ネットワーク ``bridge0`` に慣れている方向けに、旧来のネットワーク機能のサポートが続きます。 Docker はインストール時にネットワークを自動的作成します。このデフォルト・ブリッジ・ネットワークを ``bridge`` と呼びます。ネットワークに関連する情報は、 :doc:`default_network/index` をご覧ください。

.. seealso:: 

   Docker networks feature overview
      https://docs.docker.com/engine/userguide/networking/