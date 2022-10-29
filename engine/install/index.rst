.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/install/
   doc version: 17.06
      https://github.com/docker/docker.github.io/blob/master/engine/installation/index.md
      https://github.com/docker/docker.github.io/commits/master/engine/installation/index.md
   doc version: 20.10
     https://github.com/docker/docs/blob/master/engine/install/index.md
.. check date: 2022/09/30
.. Commits on Sep 5, 2022 cc0fc46783533fcd8e15e1d139ce2ae5e41f61b2
.. -----------------------------------------------------------------------------

.. Install Docker Engine
.. _install-docker-engine:

==============================
Docker のインストール
==============================

.. sidebar:: 目次

   .. contents:: 
       :depth: 2
       :local:

..  Docker Desktop for Linux
    Docker Desktop helps you build, share, and run containers easily on Mac and Windows as you do on Linux. We are excited to share that Docker Desktop for Linux is now GA. For more information, see Docker Desktop for Linux.

.. important::

   **Docker Desktop for Linux**
   
   Docker Desktop は Mac や Windows と同じように、 Linux 上でも簡単にコンテナを構築、共有、実行するのに役立ちます。今や Docker Desktop for Linux は一般提供しており、共有できるのが嬉しいです。詳しい情報は :doc:`Docker Desktop for Linux` をご覧ください。

.. Supported platforms
.. _engine-supported-platform:

サポートしているプラットフォーム
========================================

.. Docker Engine is available on a variety of Linux platforms, macOS and Windows 10 through Docker Desktop, and as a static binary installation. Find your preferred operating system below.

Docker Engine は様々な Docker Deksop を通して :doc:`Linux プラットフォーム </desktop/install/linux-install>` 、 :doc:`macOS </desktop/install/mac-install>` 、 :doc:`Windows 10 </desktop/install/windows-install>` で利用できますし、 :doc:`静的なバイナリとしてのインストール <binaries>` もできます。

.. Desktop
.. _engine-install-desktop:

デスクトップ
====================


.. list-table::
   :widths: 100 20 20 20 20
   :header-rows: 1

   * - プラットフォーム
     - x86_64 / amd64
     -arm64 (Apple Silicon)
   * - :doc:`Docker Desktop for Linux </desktop/install/linux-install>`
     - .. image:: /engine/images/green-check.png
     - 
   * - :doc:`Docker Desktop for Linux </desktop/install/linux-install>`
     - .. image:: /engine/images/green-check.png
     - 
   * - :doc:`Docker Desktop for Linux </desktop/install/linux-install>`
     - .. image:: /engine/images/green-check.png
     - 




.. Supported platforms

.. _platform-support-matrix:

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


.. See also Docker Cloud for setup instructions for Digital Ocean, Packet, SoftLayer, or Bring Your Own Cloud.

Digital Ocean、Packet、SoftLayer、あるいは皆さん自身のクラウドにセットアップする場合は :ref:`Docker Cloud <on-docker-cloud>` もご覧ください。

.. Time-based release schedule

.. _time-based-release-schedule:

各月のリリース予定
==============================

.. Starting with Docker 17.03, Docker uses a time-based release schedule, outlined below.

Docker 17.03 以降、Docker は月ごとにリリース予定を設けています。概要は以下の通りです。

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
       [#0]_
     - .. image:: /engine/images/green-check.png
     - .. image:: /engine/images/green-check.png
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
       [#0]_
     - .. image:: /engine/images/green-check.png
     - .. image:: /engine/images/green-check.png
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
       [#0]_
     - .. image:: /engine/images/green-check.png
     - .. image:: /engine/images/green-check.png

.. rubric:: 

.. [#0] Docker CE の Linux 版では、３月、6月、９月、12 月の  Edge リリースは ``edge`` チャンネルではなく、 ``stable``  チャンネルでリリースされます。つまり、Linux 版の Edge では両方のチャンネルを有効にする必要があります。

.. Prior releases

.. _priori-releases:

以前のリリース
--------------------

.. Instructions for installing prior releases of Docker can be found in the Docker archives.

以前にリリースした Docker のインストール方法は、 :doc:`Docker アーカイブ </dockerarchve/index>` にあります。

.. Docker Cloud

.. _docker-cloud:

Docker Cloud
====================

.. You can use Docker Cloud to automatically provision and manage your cloud instances.

Docker Cloud を使えば、クラウドインスタンスのセットアップや管理を自動的に行うことができます。

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

Docker のセットアップを終えたら、 :doc:`Docker を始めよう </get-started/index>` で Docker の基本を学びましょう。


.. seealso:: 

   Install
      https://docs.docker.com/engine/installation/


----


（以下、旧いバージョンの情報のため、削除予定）

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

