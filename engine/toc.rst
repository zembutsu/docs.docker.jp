.. -*- coding: utf-8 -*-
.. 
.. doc version: 17.06
.. check date: 2017/09/23
.. -----------------------------------------------------------------------------

.. Docker Engine user guide

.. _docker-engine-user-guide-toc:

========================================
Docker Engine ユーザガイド
========================================

.. toctree::
   :hidden:

   概要 <index.rst>
   userguide/eng-image/index.rst
   userguide/storagedriver/index.rst
   userguide/networking/index.rst
   カスタム・メタデータの設定 <userguide/labels-custom-metadata.rst>
   migration.rst
   破壊的変更 <breaking_changes.rst>
   廃止機能 <deprecated.rst>
   faq.rst


.. This guide helps users learn how to use Docker Engine.

このガイドはユーザが Docker Engine の使い方を学ぶのに役立ちます。

.. Learn by example
.. _learn-by-example:

例から学ぶ
==========

..    Network containers
    Manage data in containers
    Samples
    Get started

* :doc:`/engine/tutorials/networkingcontainers`
* :doc:`/engine/tutorials/dockervolumes`
* :doc:`/engine/samples`
* :doc:`/get-started/index`

.. Work with images
.. _work-with-images:

イメージの動作
====================

..    Best practices for writing Dockerfiles
    Create a base image
    Image management

* :doc:`/engine/userguide/eng-image/dockerfile_best-practices`
* :doc:`/engine/userguide/eng-image/baseimages`
* :doc:`/engine/userguide/eng-image/image_management`

.. Manage storage drivers
.. _manage-storage-drivers:

ストレージドライバの管理
------------------------------

..     Understand images, containers, and storage drivers
    Select a storage driver
    AUFS storage in practice
    Btrfs storage in practice
    Device Mapper storage in practice
    OverlayFS storage in practice
    ZFS storage in practice

* :doc:`/engine/userguide/storagedriver/imagesandcontainers`
* :doc:`/engine/userguide/storagedriver/selectadriver`
* :doc:`/engine/userguide/storagedriver/aufs-driver`
* :doc:`/engine/userguide/storagedriver/btrfs-driver`
* :doc:`/engine/userguide/storagedriver/device-mapper-driver`
* :doc:`/engine/userguide/storagedriver/overlayfs-driver`
* :doc:`/engine/userguide/storagedriver/zfs-driver`

.. Configure networks
.. _configure-networks:

ネットワーク設定
====================

..    Understand Docker container networks
    Embedded DNS server in user-defined networks
    Get started with multi-host networking
    Work with network commands

* :doc:`/engine/userguide/networking/index`
* :doc:`/engine/userguide/networking/configure-dns`
* :doc:`/engine/userguide/networking/get-started-overlay`
* :doc:`/engine/userguide/networking/work-with-networks`

.. Work with the default network
.. _work-with-the-default-network:

default ネットワークの動作
------------------------------

..    Understand container communication
    Legacy container links
    Binding container ports to the host
    Build your own bridge
    Configure container DNS
    Customize the docker0 bridge
    IPv6 with Docker

* :doc:`/engine/userguide/networking/default_network/container-communication`
* :doc:`/engine/userguide/networking/default_network/dockerlinks`
* :doc:`/engine/userguide/networking/default_network/binding`
* :doc:`/engine/userguide/networking/default_network/build-bridges`
* :doc:`/engine/userguide/networking/default_network/configure-dns`
* :doc:`/engine/userguide/networking/default_network/custom-docker0`
* :doc:`/engine/userguide/networking/default_network/ipv6`

.. Misc
その他
==========

..    Apply custom metadata

* :doc:`/engine/userguide/labels-custom-metadata`

.. seealso:: 
   Docker Engine user guide | Docker Documentation
      https://docs.docker.com/engine/userguide/#configure-networks
