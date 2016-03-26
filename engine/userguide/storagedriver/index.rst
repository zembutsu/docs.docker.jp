.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/userguide/storagedriver/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/userguide/storagedriver/index.md
   doc version: 1.10
      https://github.com/docker/docker/commits/master/docs/userguide/storagedriver/index.md
.. check date: 2016/02/10
.. ---------------------------------------------------------------------------

.. Docker storage drivers

.. _docker-storage-drivers

=======================================
Docker ストレージ・ドライバ
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Docker relies on driver technology to manage the storage and interactions associated with images and they containers that run them. This section contains the following pages:

Docker はストレージを管理する技術のドライバに依存し、イメージとコンテナを実行するため相互に連携して動きます。

..    Understand images, containers, and storage drivers
    Select a storage driver
    AUFS storage driver in practice
    Btrfs storage driver in practice
    Device Mapper storage driver in practice
    OverlayFS in practice
    ZFS storage in practice

* :doc:`イメージ、コンテナ、ストレージ・ドライバの理解 <imagesandcontainers>`
* :doc:`ストレージ・ドライバの選択 <selectadriver>`
* :doc:`AUFS ストレージ・ドライバを使う <aufs-driver>`
* :doc:`Btrfs ストレージ・ドライバを使う <btrfs-driver>`
* :doc:`Device Mapper ストレージ・ドライバを使う <device-mapper-driver>`
* :doc:`OverlayFS を使う <overlayfs-driver>`
* :doc:`ZFS ストレージを使う <zfs-driver>`

.. If you are new to Docker containers make sure you read “Understand images, containers, and storage drivers” first. It explains key concepts and technologies that can help you when working with storage drivers.

新しい Docker コンテ案を使う前に、まず :doc:`イメージ、コンテナ、ストレージ・ドライバを理解 <imagesandcontainers>` をお読みください。重要な概念と技術に関する説明があるので、ストレージ・ドライバがどのような動作をするのか理解する手助けになるでしょう。

.. Acknowledgement

謝辞
==========

.. The Docker storage driver material was created in large part by our guest author Nigel Poulton with a bit of help from Docker’s own Jérôme Petazzoni. In his spare time Nigel creates IT training videos, co-hosts the weekly In Tech We Trust podcast, and lives it large on Twitter.

Docker ストレージ・ドライバの基となる大部分は、ゲスト著者である Nigel Poulto 氏によって書かれたもので、Docker 社自身の Jérôme Petazzoni も僅かながら手助けを行いました。Nigel 氏は `IT トレーニングビデオ <http://www.pluralsight.com/author/nigel-poulton>`_ の作成、 `In Tech We Trust ポッドキャスト <http://intechwetrustpodcast.com/>`_ に多くの時間を費やし、大部分は `Twitter <https://twitter.com/nigelpoulton>`_ 上で過ごします。

.. seealso:: 

   Docker storage drivers
      https://docs.docker.com/engine/userguide/storagedriver/