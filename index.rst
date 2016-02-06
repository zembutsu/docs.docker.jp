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

* v1.10 index

目次
====================

.. toctree::
   :caption: Docker Engine
   :hidden:

   engine/toc.rst

.. toctree::
   :caption: Docker Swarm
   :hidden:

   swarm/toc.rst

.. toctree::
   :caption: Docker Compose
   :hidden:

   compose/toc.rst

.. toctree::
   :caption: Docker Hub
   :hidden:

   docker-hub/toc.rst



----

* v1.9 index ( will be migration to v1.10 )

Install
====================

.. toctree::
   :maxdepth: 3
   :caption: インストール

   kitematic/index.rst
   machine/install-machine.rst

Use the Kitematic GUI
------------------------------

.. toctree::
   :maxdepth: 3

   kitematic/userguide/index.rst


Provision & set up Docker hosts
----------------------------------------

.. toctree::
   :maxdepth: 3
   :caption: Docker Machine

   machine/index.rst
   machine/get-started.rst
   machine/get-started-cloud.rst
   machine/migrate-to-machine.rst


Docker Hub
----------------------------------------

.. toctree::
   :maxdepth: 3
   :caption: Docker Hub

   docker-hub/index.rst
   docker-hub/accounts.rst
   docker-hub/repos.rst
   docker-hub/builds.rst
   docker-hub/webhooks.rst
   docker-hub/bitbucket.rst
   docker-hub/github.rst
   docker-hub/orgs.rst
   docker-hub/official_repos.rst

Docker Registry
----------------------------------------

.. toctree::
   :maxdepth: 3
   :caption: Docker Registry

   registry/index.rst
   registry/introduction.rst
   registry/deploying.rst
   registry/configuration.rst
   registry/notifications.rst
   registry/help.rst


Extend Docker
==============================

.. toctree::
   :maxdepth: 3
   :caption: Docker 拡張

   engine/extend/index.rst
   engine/extend/plugins.rst
   engine/extend/plugins_network.rst
   engine/extend/plugins_volume.rst
   engine/extend/plugins_api.rst

Command and API references
==============================

.. toctree::
   :maxdepth: 3
   :caption: コマンド&APIリファレンス

   engine/reference/run.rst
   engine/reference/builder.rst
   engine/reference/remote_api_client_libraries.rst
   engine/reference/docker_io_accounts_api.rst


Docker Machine references
----------------------------------------

.. toctree::
   :maxdepth: 3
   :caption: Docker Machine リファレンス

   machine/drivers/index.rst

Docker Machine Drivers
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. toctree::
   :maxdepth: 3
   :caption: Docker Machine ドライバ

   machine/drivers/os-base.rst
   machine/drivers/aws.rst
   machine/drivers/digital-ocean.rst
   machine/drivers/generic.rst
   machine/drivers/gce.rst
   machine/drivers/soft-layer.rst
   machine/drivers/azure.rst
   machine/drivers/hyper-v.rst
   machine/drivers/openstack.rst
   machine/drivers/virtualbox.rst

Supported Docker Machine subcommands
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. toctree::
   :maxdepth: 3
   :caption: Docker Machine サブコマンド

   machine/reference/index.rst
   machine/reference/active.rst
   machine/reference/config.rst
   machine/reference/create.rst
   machine/reference/env.rst
   machine/reference/help.rst
   machine/reference/inspect.rst
   machine/reference/ip.rst
   machine/reference/kill.rst
   machine/reference/ls.rst
   machine/reference/regenerate-certs.rst
   machine/reference/restart.rst
   machine/reference/rm.rst
   machine/reference/scp.rst
   machine/reference/ssh.rst
   machine/reference/start.rst
   machine/reference/status.rst
   machine/reference/stop.rst
   machine/reference/upgrade.rst
   machine/reference/url.rst


About
==============================

.. toctree::
   :maxdepth: 3
   :caption: Docker について

   release-notes.rst
   engine/reference/glossary.rst


Docs archive
====================

.. toctree::
   :maxdepth: 1
   :caption: Docs アーカイブ
   
   v1.9 <http://docs.docker.jp/v1.9/>


Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`

