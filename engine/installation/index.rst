.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/installation/
   doc version: 17.06
      https://github.com/docker/docker.github.io/blob/master/engine/installation/index.md
.. check date: 2017/07/01
.. Commits on Jun 29, 2017 322213052e760120e6a211f5db3d847d4ab52695
.. -----------------------------------------------------------------------------

.. Install Docker

==============================
Docker のインストール
==============================

.. sidebar:: 目次

   .. contents:: 
       :depth: 2
       :local:

.. Docker is available in two editions: Community Edition (CE) and Enterprise Edition (EE).

Docker は **コミュニティ版（CE; Community Edition）** と **エンタープライズ版（EE; Enterprise Edition）** の２つのエディションを使えます。

.. Docker Community Edition (CE) is ideal for developers and small teams looking to get started with Docker and experimenting with container-based apps. Docker CE has two update channels, stable and edge:

Docker コミュニティ版（CE）は開発者や小さなチームが Docker を使い始め、コンテナをベースと下アプリケーションを実験するのに最適です。Docker CE は **stable** と **edge**  の２つの更新用チャンネルがあります。

..    Stable gives you reliable updates every quarter
    Edge gives you new features every month

* **stable（安定版）** は4ヶ月ごとに安定した更新を行います
* **edge（エッジ）** は毎月新機能を追加します

.. For more information about Docker CE, see Docker Community Edition.

Docker CE に関する詳しい情報は、 `Docker Community Edition（英語） <https://www.docker.com/community-edition/>`_  のページをご覧ください。

.. Docker Enterprise Edition (EE) is designed for enterprise development and IT teams who build, ship, and run business critical applications in production at scale. For more information about Docker EE, including purchasing options, see Docker Enterprise Edition.

Docker エンタープライズ版（EE）はエンタープライズにおける開発と IT チーム向けに設計されており、プロダクションでスケールするようなビジネスにとって重要なアプリケーションを構築・移動・実行します。

.. list-table::
   :widths: 100 20 20 20 20
   :header-rows: 1

   * - 
     - Community Edition
     - Enterprise Edition Basic
     - Enterprise Edition Standard
     - Enterprise Edition Advanced
   * - コンテナ・エンジンとオーケストレーション、ネットワーク機能、セキュリティを内蔵
     - .. image:: /engine/images/green-check.png
     - .. image:: /engine/images/green-check.png
     - .. image:: /engine/images/green-check.png
     - .. image:: /engine/images/green-check.png
   * - 認証済みインフラ、プラグイン、ISV コンテナ
     - 
     - .. image:: /engine/images/green-check.png
     - .. image:: /engine/images/green-check.png
     - .. image:: /engine/images/green-check.png
   * - イメージ管理
     - 
     - 
     - .. image:: /engine/images/green-check.png
     - .. image:: /engine/images/green-check.png
   * - コンテナ・アプリ管理
     - 
     - 
     - .. image:: /engine/images/green-check.png
     - .. image:: /engine/images/green-check.png
   * - イメージのセキュリティ・スキャン
     - 
     - 
     - 
     - .. image:: /engine/images/green-check.png


.. Supported platforms

.. _supported-platforms:

対応プラットフォーム
====================

.. Docker CE and EE are available on multiple platforms, on cloud and on-premises. Use the following matrix to choose the best installation path for you.

クラウドやオンプレミスにかかわらず、Docker CE と EE を様々なプラットフォーム上で実行できます。以下の表は皆さんが何をインストールするのが良いのか検討するのに役立つでしょう。

.. list-table::
   :header-rows: 1

   * - プラットフォーム
     - Docker CE x86_64
     - Docker CE ARM
     - Docker EE
   * - :doc:`Ubuntu <./linux/ubuntu>`
     - .. image:: /engine/images/green-check.png
     - .. image:: /engine/images/green-check.png
     - .. image:: /engine/images/green-check.png
   * - :doc:`Debian <./linux/debian>`
     - .. image:: /engine/images/green-check.png
     - .. image:: /engine/images/green-check.png
     - 
   * - :doc:`Red Hat Enterprise Linux <./linux/rhel>`
     - 
     - 
     - .. image:: /engine/images/green-check.png
   * - :doc:`CentOS <./linux/centos>`
     - .. image:: /engine/images/green-check.png
     - 
     - .. image:: /engine/images/green-check.png
   * - :doc:`Fedora <./linux/fedora>`
     - .. image:: /engine/images/green-check.png
     - 
     - 
   * - :doc:`Oracle Linux <./linux/oracle>`
     - 
     - 
     - .. image:: /engine/images/green-check.png
   * - :doc:`SUSE Linux Enterprise Server <./linux/suse>`
     - 
     - 
     - .. image:: /engine/images/green-check.png
   * - :doc:`Microsoft Windows Server 2016 </docker-ee-for-windows/install/index>`
     - 
     - 
     - .. image:: /engine/images/green-check.png
   * - :doc:`Microsoft Windows 10 </docker-for-windows/index>`
     - .. image:: /engine/images/green-check.png
     - 
     - 
   * - :doc:`macOS </docker-for-mac/index>`
     - .. image:: /engine/images/green-check.png
     - 
     - 
   * - :doc:`Microsoft Azure </docker-for-azure/index>`
     - .. image:: /engine/images/green-check.png
     - 
     - .. image:: /engine/images/green-check.png
   * - :doc:`Amazon Web Services </docker-for-aws/>`
     - .. image:: /engine/images/green-check.png
     - 
     - .. image:: /engine/images/green-check.png


.. See also Docker Cloud for setup instructions for Digital Ocean, Packet, SoftLink, or Bring Your Own Cloud.

Digital Ocean、Packet、SoftLink、あるいは皆さん自身のクラウドにセットアップする場合は :ref:`Docker Cloud <on-docker-cloud>` もご覧ください。

.. Time-based release schedule

.. _time-based-release-schedule:

時間を基準としたリリース予定
==============================

.. Starting with Docker 17.03, Docker uses a time-based release schedule, outlined below.

Docker 17.03 以降、Docker は時間を基準としたりりース（time-based release）予定しています。概要は以下の通りです。

.. list-table::
   :header-rows: 1

   * - 月
     - Docker CE Edge
     - Docker CE Stable
     - Docker EE
   * - １月
     - .. image:: /engine/images/green-check.png
     - 
     - 
   * - ２月
     - .. image:: /engine/images/green-check.png
     - 
     - 
   * - ３月
     - .. image:: /engine/images/green-check.png
     - .. image:: /engine/images/green-check.png
     - .. image:: /engine/images/green-check.png
   * - ４月
     - .. image:: /engine/images/green-check.png
     - 
     - 
   * - ５月
     - .. image:: /engine/images/green-check.png
     - 
     - 
   * - ６月
     - .. image:: /engine/images/green-check.png
     - 
     - 
   * - ７月
     - .. image:: /engine/images/green-check.png
     - 
     - 
   * - ８月
     - .. image:: /engine/images/green-check.png
     - 
     - 
   * - ９月
     - .. image:: /engine/images/green-check.png
     - 
     - 
   * - 10月
     - .. image:: /engine/images/green-check.png
     - 
     - 
   * - 11月
     - .. image:: /engine/images/green-check.png
     - 
     - 
   * - 12月
     - .. image:: /engine/images/green-check.png
     - 
     - 

Docker CE の Linux 版では、３月、6月、９月、12 月の  Edge リリースは ``edge`` チャンネルではなく、 ``stable``  チャンネルでリリースされます。つまり、Linux 版の Edge では両方のチャンネルを有効にする必要があります。

.. Prior releases

.. _priori-releases:

以前のリリース
--------------------

.. Instructions for installing prior releases of Docker can be found in the Docker archives.

以前にリリースした Docker のインストール方法は、 :doc:`Docker アーカイブ </dockerarchve/index>` にあるかもしれません。

.. Docker Cloud

.. _docker-cloud:

Docker Cloud
====================

.. You can use Docker Cloud to automatically provision and manage your cloud instances.

Docker Cloud を使えば、各クラウド環境上に自動的にセットアップできます。

..    Amazon Web Services setup guide
    DigitalOcean setup guide
    Microsoft Azure setup guide
    Packet setup guide
    SoftLayer setup guide
    Use the Docker Cloud Agent to Bring your Own Host

* `Amazon Web Services setup guide <https://docs.docker.com/docker-cloud/infrastructure/link-aws/>`_
* `DigitalOcean setup guide <https://docs.docker.com/docker-cloud/infrastructure/link-do/>`_
* `Microsoft Azure setup guide <https://docs.docker.com/docker-cloud/infrastructure/link-do/>`_
* `Packet setup guide <https://docs.docker.com/docker-cloud/infrastructure/link-packet/>`_
* `SoftLayer setup guide <https://docs.docker.com/docker-cloud/infrastructure/link-softlayer/>`_
* `Use the Docker Cloud Agent to Bring your Own Host <https://docs.docker.com/docker-cloud/infrastructure/byoh/>`_


.. Get started

はじめましょう
====================

.. After setting up Docker, try learning the basics over at Getting started with Docker.

Docker のセットアップを終えた、 :doc:`Docker を始めよう </get-started/index>` で Docker の基本を学びましょう。

ｰｰｰｰ
（以下、旧リンク情報）

.. On Cloud

クラウド
==========

* :doc:`インストール方法を選択 <cloud/overview>`
* :doc:`例：クラウド・プロバイダ上で手動インストール <cloud/cloud-ex-aws>`
* :doc:`例：Docker Machine でクラウド・ホスト作成 <cloud/cloud-ex-machine-ocean>`

（以下v.1.9 用ドキュメント；削除予定）

* :doc:`Amazon EC2 Installation <amazon>`
* :doc:`Install on Joyent Public Cloud <joyent>`
* :doc:`Google Cloud Platform <google>`
* :doc:`IBM SoftLayer <softlayer>`
* :doc:`Microsoft Azure platform <azure>`
* :doc:`Rackspace Cloud <rackspace>`

.. On OSX and Windows

OSX と Windows
====================

* :doc:`Mac OS X <mac>`
* :doc:`Windows <windows>`

.. The Docker Archives

Docker ドキュメントのアーカイブ
========================================

.. Instructions for installing prior releases of Docker can be found in the following docker archives: Docker v1.7, Docker v1.6, Docker v1.5, and Docker v1.4.

以前にリリースされた Docker バージョンのインストール方法は、docker アーカイブで見つけられます： `Docker v1.7 <http://docs.docker.com/v1.7/>`_ 、 `Docker v1.6 <http://docs.docker.com/v1.6/>`_ 、 `Docker v1.5 <http://docs.docker.com/v1.5/>`_ 、 `Docker v1.4 <http://docs.docker.com/v1.4/>`_ 。

.. Where to go After Installing

インストール後は
====================

* :doc:`Docker について </engine/index>`
* `サポート（英語） <https://www.docker.com/support/>`_
* `トレーニング（英語） <https://training.docker.com//>`_

.. seealso:: 

   Install
      https://docs.docker.com/engine/installation/

