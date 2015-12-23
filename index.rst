.. Docker-docs-ja documentation master file, created by
   sphinx-quickstart on Sat Nov  7 10:06:34 2015.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

.. Welcome to Docker-docs-ja's documentation!

Docker ドキュメント日本語化プロジェクト
==========================================

このサイトは `http://docs.docker.com/ <http://docs.docker.com/>`_ で公開されている Docker ドキュメントの日本語訳を作成・公開・配布するプロジェクトです。この和訳ドキュメントの利用にあたっては、Common Creative License を適用します。訳文の間違いのご指摘、ご意見等やプル・リクエスト等々は、GitHub 上のプロジェクト `https://github.com/zembutsu/docs.docker.jp <https://github.com/zembutsu/docs.docker.jp>`_ までお願いします。

----

.. Welcome Friends to the Docker Docs!

Docker ドキュメントへようこそ！
==========================================

.. Docker Engine or “Docker” creates and runs Docker containers. Install Docker on Ubuntu, Mac OS X, or Windows. Or use the Install menu to choose from others. 

**Docker Engine (エンジン)** または "Docker" は、Docker コンテナを作成・実行します。Docker を :doc:`Ubuntu </engine/installation/ubuntulinux>`  、:doc:`Mac OS X </engine/installation/mac>`、:doc:`Windows </engine/installation/windows>` にインストールします。あるいは、メニューの **インストール** から他を選びます。


.. Kitematic is the desktop GUI for Docker. Install Kitematic.

**Kitematic (カイトマティック)** は Docker 対応のデスクトップ GUI です。 :doc:`Kitematic のインストール <kitematic/index>` はこちらです。


.. Docker Hub is our hosted registry service for managing your images. There is nothing to install. You just sign up!

**Docker Hub (ハブ)** はイメージを管理するためのホステッド・レジストリ・サービス [#f1]_ です。インストール不要です。`サインアップ <https://hub.docker.com/>`_ するだけです。


.. Docker Trusted Registry (DTR) supplies a private dedicated image registry. To learn about DTR for your team, see the overview.

**Docker Trusted Registry (トラステッド・レジストリ)** (DTR) はプライベートな専用イメージ・レジストリを提供します。チームでの DTR の使い方を学ぶには、:doc:`概要 <dokcer-trusted-registry/>` をご覧ください。


.. Docker Machine automates container provisioning on your network or in the cloud. Install machine on Windows, Mac OS X, or Linux.

**Docker Machine (マシン)** は自分のネットワークやクラウド上に、自動的にコンテナをデプロイします。Machine を :doc:`Windows、Mac OS X、Windows<machine/install-machine>`  にインストールできます。

.. Docker Swarm is used to host clustering and container scheduling. Deploy your own “swarm” today in just a few short steps.

**Docker Swarm (スウォーム)** はホストのクラスタリングとコンテナのスケジューリングに使われます。 :doc:`"swarm" をデプロイする <swarm/install-w-machine>` から、いくつかの短いステップで今日から使えます。

.. Docker Compose defines multi-container applications. You can install Docker Compose on Ubuntu, Mac OS X, and other systems.

**Docker Compose (コンポーズ)** はマルチ・コンテナのアプリケーションを定義します。Docker Compose を :doc:`Ubuntu、Mac OS X や、その他のシステム </compose/install>` にインストールできます。

.. Docker Registry provides open source Docker image distribution. See the registry deployment documentation for more information. 

**Docker Registry (レジストリ)** はオープンソースの Docker イメージ配布を提供します。詳細な情報は :doc:`レジストリのデプロイ` をご覧ください。

.. You may notice the docs look different

ドキュメントが違う場合があるので注意すべき
==============================================

.. You also may find a few broken links or other wonkiness. We are working on fixing these things. We appreciate your patience while we go through our growing pains

リンクが切れや信頼できない箇所が見つかるかもしれません。私達はこれら課題の修正中です。産みの苦しみの中、私達は皆さんの我慢に感謝します。


.. rubric:: 脚注

.. [#f1] 訳者注：ホステッドとは、Docker社が提供するという意味です。

----

Install
====================

.. toctree::
   :maxdepth: 3
   :caption: インストール

   engine/installation/index.rst
   engine/installation/mac.rst
   engine/installation/windows.rst
   engine/installation/ubuntulinux.rst
   engine/installation/rhel.rst
   engine/installation/centos.rst
   engine/installation/fedora.rst
   engine/installation/debian.rst
   engine/installation/archlinux.rst
   engine/installation/cruxlinux.rst
   engine/installation/frugalware.rst
   engine/installation/gentoolinux.rst
   engine/installation/oracle.rst
   engine/installation/SUSE.rst
   engine/installation/amazon.rst
   engine/installation/google.rst
   engine/installation/softlayer.rst
   engine/installation/azure.rst
   engine/installation/rackspace.rst
   engine/installation/joyent.rst
   engine/installation/binaries.rst
   kitematic/index.rst
   machine/install-machine.rst
   compose/install.rst
   swarm/install-w-machine.rst


Docker Fundamentals - Docker の基礎
========================================

.. toctree::
   :maxdepth: 3
   :caption: Docker 基礎
   
   engine/userguide/basics.rst
   engine/userguide/index.rst

Work with Docker Images
------------------------------

.. toctree::
   :maxdepth: 3

   engine/articles/dockerfile_best-practice.rst
   engine/articles/baseimages.rst

Work with Docker Containers
------------------------------

.. toctree::
   :maxdepth: 3

   engine/userguide/dockerizing.rst
   engine/userguide/usingdocker.rst
   engine/userguide/dockerimages.rst
   engine/userguide/networkingcontainers.rst
   engine/userguide/dockervolumes.rst
   engine/userguide/dockerrepos.rst

Docker on Windows & OSX
------------------------------

.. toctree::
   :maxdepth: 3

   engine/articles/dsc.rst


Use the Kitematic GUI
------------------------------

.. toctree::
   :maxdepth: 3

   kitematic/userguide/index.rst




Use Docker
==============================

.. toctree::
   :maxdepth: 3
   :caption: Docker を使う

   engine/misc/index.rst
   engine/userguide/labels-custom-metadata.rst
   engine/misc/deprecated.rst



Provision & set up Docker hosts
----------------------------------------

.. toctree::
   :maxdepth: 3
   :caption: Docker Machine

   machine/index.rst
   machine/get-started.rst
   machine/get-started-cloud.rst
   machine/migrate-to-machine.rst


Create multi-container applications
----------------------------------------

.. toctree::
   :maxdepth: 3
   :caption: Docker Compose

   compose/index.rst
   compose/production.rst
   compose/extends.rst
   compose/gettingstarted.rst
   compose/django.rst
   compose/rails.rst
   compose/networking.rst
   compose/wordpress.rst
   compose/completion.rst


Cluster Docker containers
----------------------------------------

.. toctree::
   :maxdepth: 3
   :caption: Docker Swarm

   swarm/index.rst
   swarm/install-manual.rst
   swarm/multi-manager-setup.rst
   swarm/networking.rst
   swarm/discovery.rst
   swarm/scheduler/filter.rst
   swarm/scheduler/strategy.rst


Networking
----------------------------------------

.. toctree::
   :maxdepth: 3
   :caption: ネットワーク機能

   engine/userguide/networking/dockernetworks.rst


Command and API references
----------------------------------------

.. toctree::
   :maxdepth: 3
   :caption: コマンド・API リファレンス

   engine/reference/builder.rst
   swarm/api/swarm-api.rst


Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`

