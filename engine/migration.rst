.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/migration/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/migration.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/migration.md
.. check date: 2016/06/13
.. Commits on Feb 12, 2016 57e2a82355c15005875fedc733dc45081af5a2d9
.. -----------------------------------------------------------------------------

.. Migrate to Engine 1.10

=======================================
Engine 1.10 への移行
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Starting from version 1.10 of Docker Engine, we completely change the way image data is addressed on disk. Previously, every image and layer used a randomly assigned UUID. In 1.10 we implemented a content addressable method using an ID, based on a secure hash of the image and layer data.

Docker Engine バージョン 1.10 以降は、ディスク上にイメージ・データを割り当てる方式が完全に変わります。従来は、各イメージとレイヤに対してランダムな UUID を割り当てていました。バージョン 1.10 からは、イメージとレイヤ・データの安全なハッシュ値を元にした ID を使い、中身を指定できる手法を実装しました。

.. The new method gives users more security, provides a built-in way to avoid ID collisions and guarantee data integrity after pull, push, load, or save. It also brings better sharing of layers by allowing many images to freely share their layers even if they didn’t come from the same build.

新しい手法は、利用者を更に安全にします。組み込まれた方式は ID の衝突を防止し、pull ・ push ・ load ・ save を実行した後のデータを保証します。また、レイヤの共有を改善しました。たとえ同時に構築していなくても、多くのイメージ間でレイヤを自由に共有できるようになります。

.. Addressing images by their content also lets us more easily detect if something has already been downloaded. Because we have separated images and layers, you don’t have to pull the configurations for every image that was part of the original build chain. We also don’t need to create layers for the build instructions that didn’t modify the filesystem.

イメージに対して内容に関する情報を割り当てることで、既にダウンロード済みのイメージがあるかどうかの検出も容易になります。これはイメージとレイヤが分離しているためであり、オリジナルの構築チェーンに含まれる各イメージを、それぞれ取得（pull）する必要はありません。また、構築命令のためにレイヤを作成する必用がなくなったため、ファイルシステムを変更しません。

.. Content addressability is the foundation for the new distribution features. The image pull and push code has been reworked to use a download/upload manager concept that makes pushing and pulling images much more stable and mitigates any parallel request issues. The download manager also brings retries on failed downloads and better prioritization for concurrent downloads.

連想機能（content addressability；コンテント・アドレッサビィティ）とは、新しい配布機能の基礎です。イメージの取得（pull）と送信（push）の手法は、ダウンロード／アップロード・マネージャの概念を扱うために調整されました。これにより、イメージの送受信がより安定し、並列リクエスト時の問題を軽減します。ダウンロード・マネージャはダウンロードの失敗時にリトライできるようになり、ダウンロードにおける適切な優先度付けも行えるようにもなりました。

.. We are also introducing a new manifest format that is built on top of the content addressable base. It directly references the content addressable image configuration and layer checksums. The new manifest format also makes it possible for a manifest list to be used for targeting multiple architectures/platforms. Moving to the new manifest format will be completely transparent.

更に、新しいマニフェスト・フォーマットも導入しました。これは連想機能をベースにしています。これは連想イメージ（content addressable image）の設定やレイヤのチェックサムを直接参照できます。この新しいマニフェスト・フォーマットにより、複数のアーキテクチャやプラットフォームのためにマニフェスト・リストが利用できるでしょう。新しいマニフェスト・フォーマットへの移行は、完全に透過的です。

.. Preparing for upgrade

アップグレードの準備
====================

.. To make your current images accessible to the new model we have to migrate them to content addressable storage. This means calculating the secure checksums for your current data.

現在のイメージを新しいモデルで利用できるようにするには、連想ストレージ（content addressable storage）への移行が必要です。すなわち、現在のデータの安全なチェックサムを計算することを意味します。

.. All your current images, tags and containers are automatically migrated to the new foundation the first time you start Docker Engine 1.10. Before loading your container, the daemon will calculate all needed checksums for your current data, and after it has completed, all your images and tags will have brand new secure IDs.

Docker Engine 1.10 の初回起動時は、現時点における全てのイメージ、タグ、コンテナが自動的に新しい基盤上に移行します。そのため、コンテナを読み込む前に、デーモンは現時点のデータに対するチェックサムを全て計算する必要があります。計算が終わったら、全てのイメージとタグは新しい安全な ID に更新されます。

.. While this is simple operation, calculating SHA256 checksums for your files can take time if you have lots of image data. On average you should assume that migrator can process data at a speed of 100MB/s. During this time your Docker daemon won’t be ready to respond to requests.

**これは非常に単純な操作ですが、各ファイルに対する SHA256 チェックサムを計算するため、多くのイメージ・データがあれば計算に時間を消費します。** データの移行プロセスにかかる時間は、およそ平均して１秒あたり 100MB と想定されます。この処理の間、Docker デーモンはリクエストに応答できません。

.. Minimizing migration time

.. _minimizing-migration-time:

移行時間の最小化
====================

.. If you can accept this one time hit, then upgrading Docker Engine and restarting the daemon will transparently migrate your images. However, if you want to minimize the daemon’s downtime, a migration utility can be run while your old daemon is still running.

一度だけの処理が許容できるのであれば、Docker Engine のアップグレードと、デーモンの再起動により、イメージの移行が透過的に行われます。しかしながら、デーモンの停止時間を最小化したい場合は、古いデーモンを動かしたまま移行ツールを使えます。

.. This tool will find all your current images and calculate the checksums for them. After you upgrade and restart the daemon, the checksum data of the migrated images will already exist, freeing the daemon from that computation work. If new images appeared between the migration and the upgrade, those will be processed at time of upgrade to 1.10.

このツールは現在のイメージを全て探し出し、それらのチェックサムを計算します。デーモンのアップグレードと再起動を行った後、移行するイメージに対するチェックサム・データが既に存在していれば、デーモンは計算処理を行いません。移行とアップグレード期間中に新しいイメージが追加されている場合は、1.10 へのアップグレードのプロセス中で処理されます。

.. You can download the migration tool here.

`移行ツールはこちらからダウンロードできます <https://github.com/docker/v1.10-migrator/releases>`_ 。

.. The migration tool can also be run as a Docker image. While running the migrator image you need to expose your Docker data directory to the container. If you use the default path then you would run:

移行ツールは Docker イメージとしても実行することができます。移行用ツールのイメージを実行している間、このコンテナに対して Docker のデータを直接公開する必要があります。

.. code-block:: bash

   $ docker run --rm -v /var/lib/docker:/var/lib/docker docker/v1.10-migrator

.. If you use the devicemapper storage driver, you also need to pass the flag --privileged to give the tool access to your storage devices.

devicemapper ストレージ・ドライバを使っている場合は、 ``--privileged`` フラグを指定することで、ツールがストレージ・デバイスにアクセス可能となります。

.. seealso:: 

   Migrate to Engine 1.10
      https://docs.docker.com/engine/migration/
