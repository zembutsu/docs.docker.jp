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
   engine/introduction/understanding-docker.rst


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


Administrate Docker
----------------------------------------

.. toctree::
   :maxdepth: 3
   :caption: Docker 管理

   engine/articles/host_integration.rst
   engine/articles/security.rst
   engine/articles/configuring.rst
   engine/articles/runmetrics.rst
   engine/articles/https.rst
   engine/articles/ambassador_pattern_linking.rst
   engine/articles/systemd.rst

Logging
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. toctree::
   :maxdepth: 3
   :caption: ログ記録

   engine/reference/logging/overview.rst
   engine/reference/logging/awslogs.rst
   engine/reference/logging/log_tags.rst
   engine/reference/logging/fluentd.rst
   engine/reference/logging/journald.rst


Applications and Services
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. toctree::
   :maxdepth: 3
   :caption: アプリケーションとサービス

   engine/examples/running_riak_service.rst
   engine/examples/running_ssh_service.rst


Integrate with Third-party Tools
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. toctree::
   :maxdepth: 3
   :caption: サードパーティ製ツール連携

   engine/articles/cfengine_process_management.rst
   engine/articles/chef.rst
   engine/articles/puppet.rst
   engine/articles/using_supervisord.rst

Docker storage drivers
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. toctree::
   :maxdepth: 3
   :caption: Docker ストレージ・ドライバ

   engine/userguide/storagedriver/index.rst
   engine/userguide/storagedriver/imagesandcontainers.rst
   engine/userguide/storagedriver/selectadriver.rst
   engine/userguide/storagedriver/aufs-driver.rst
   engine/userguide/storagedriver/btrfs-driver.rst
   engine/userguide/storagedriver/device-mapper-driver.rst
   engine/userguide/storagedriver/overlayfs-driver.rst
   engine/userguide/storagedriver/zfs-driver.rst

Networking
----------------------------------------

.. toctree::
   :maxdepth: 3
   :caption: ネットワーク機能

   engine/userguide/networking/index.rst
   engine/userguide/networking/dockernetworks.rst
   engine/userguide/networking/work-with-networks.rst
   engine/userguide/networking/get-started-overlay.rst


Default bridge network
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. toctree::
   :maxdepth: 3
   :caption: デフォルト・ブリッジ・ネットワーク

   engine/userguide/networking/default_network/index.rst
   engine/userguide/networking/default_network/container-communication.rst
   engine/userguide/networking/default_network/dockerlinks.rst
   engine/userguide/networking/default_network/binding.rst
   engine/userguide/networking/default_network/build-bridges.rst
   engine/userguide/networking/default_network/donfigure-dns.rst
   engine/userguide/networking/default_network/custom-docker0.rst
   engine/userguide/networking/default_network/ipv6.rst

Examples
----------------------------------------

.. toctree::
   :maxdepth: 3
   :caption: Docker 利用例

   engine/examples/index.rst
   engine/examples/mongodb.rst
   engine/examples/postgresql_service.rst
   engine/examples/couchdb_data_volumes.rst
   engine/examples/nodejs_web_app.rst
   engine/examples/running_redis_service.rst
   engine/examples/apt-cacher-ng.rst

Manage image repositories
==============================

.. toctree::
   :maxdepth: 3
   :caption: イメージ・レポジトリの管理

   engine/userguide/image_management.rst

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


Docker Engine Commands
----------------------------------------

.. toctree::
   :maxdepth: 3
   :caption: Docker Engine コマンド

   engine/reference/commandline/index.rst
   engine/reference/commandline/cli.rst
   engine/reference/commandline/daemon.rst
   engine/reference/commandline/attach.rst
   engine/reference/commandline/build.rst
   engine/reference/commandline/commit.rst
   engine/reference/commandline/cp.rst
   engine/reference/commandline/create.rst
   engine/reference/commandline/diff.rst
   engine/reference/commandline/events.rst
   engine/reference/commandline/exec.rst
   engine/reference/commandline/export.rst
   engine/reference/commandline/history.rst
   engine/reference/commandline/images.rst
   engine/reference/commandline/import.rst
   engine/reference/commandline/info.rst
   engine/reference/commandline/inspect.rst
   engine/reference/commandline/kill.rst
   engine/reference/commandline/load.rst
   engine/reference/commandline/login.rst
   engine/reference/commandline/logout.rst
   engine/reference/commandline/logs.rst
   engine/reference/commandline/network_connect.rst
   engine/reference/commandline/network_create.rst
   engine/reference/commandline/network_disconnect.rst
   engine/reference/commandline/network_inspect.rst
   engine/reference/commandline/network_ls.rst
   engine/reference/commandline/network_rm.rst
   engine/reference/commandline/pause.rst
   engine/reference/commandline/port.rst
   engine/reference/commandline/ps.rst
   engine/reference/commandline/pull.rst
   engine/reference/commandline/push.rst
   engine/reference/commandline/rename.rst
   engine/reference/commandline/restart.rst
   engine/reference/commandline/rm.rst
   engine/reference/commandline/rmi.rst
   engine/reference/commandline/run.rst
   engine/reference/commandline/save.rst
   engine/reference/commandline/search.rst
   engine/reference/commandline/start.rst
   engine/reference/commandline/stats.rst
   engine/reference/commandline/stop.rst
   engine/reference/commandline/tag.rst
   engine/reference/commandline/top.rst
   engine/reference/commandline/unpause.rst
   engine/reference/commandline/version.rst
   engine/reference/commandline/volume_create.rst
   engine/reference/commandline/volume_inspect.rst
   engine/reference/commandline/volume_ls.rst
   engine/reference/commandline/volume_rm.rst
   engine/reference/commandline/wait.rst


Docker Compose Reference
----------------------------------------

.. toctree::
   :maxdepth: 3
   :caption: Docker Compose リファレンス

   compose/reference/index.rst
   compose/reference/overview.rst
   compose/reference/docker-compose.rst
   compose/reference/build.rst
   compose/reference/help.rst
   compose/reference/kill.rst
   compose/reference/logs.rst
   compose/reference/pause.rst
   compose/reference/port.rst
   compose/reference/ps.rst
   compose/reference/pull.rst
   compose/reference/restart.rst
   compose/reference/rm.rst
   compose/reference/run.rst
   compose/reference/scale.rst
   compose/reference/start.rst
   compose/reference/stop.rst
   compose/reference/unpause.rst
   compose/reference/up.rst


Command and API references
----------------------------------------

.. toctree::
   :maxdepth: 3
   :caption: コマンド・API リファレンス

   engine/reference/builder.rst
   swarm/api/swarm-api.rst


About
==============================

.. toctree::
   :maxdepth: 3
   :caption: Docker について

   engine/reference/glossary.rst



Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`

