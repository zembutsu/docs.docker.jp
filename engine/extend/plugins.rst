.. -*- coding: utf-8 -*-
.. https://docs.docker.com/engine/extend/plugins/
.. doc version: 1.9
.. check date: 2016/01/09

.. Understand Docker plugins

.. _understand-docker-plugin:

========================================
Docker プラグインの理解
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. You can extend the capabilities of the Docker Engine by loading third-party plugins. This page explains the types of plugins and provides links to several volume and network plugins for Docker.

サードパーティー製のプラグインを読み込むと、Docker Engine の機能を拡張できます。このページではプラグインの種類についてと、いくつかの Docker 向けボリュームとネットワークのプラグインのリンクを紹介します。

.. Types of plugins

.. _types-of-plugins:

プラグインの種類
====================

.. Plugins extend Docker’s functionality. They come in specific types. For example, a volume plugin might enable Docker volumes to persist across multiple Docker hosts and a network plugin might provide network plumbing.

プラグインは Docker の機能性を拡張します。拡張機能には複数の種類があります。例えば、 :doc:`volume plugin <plugins_volume>` は複数のホストを横断して存在する Docker ボリュームを有功にします。 :doc:`network plugin <plugins_network>` はネットワークの管（plumbing）を提供するでしょう。

.. Currently Docker supports volume and network driver plugins. In the future it will support additional plugin types.

現時点の Docker はボリュームとネットワーク・ドライバのプラグインをサポートしています。近いうちに、他のプラグインの種類もサポートするでしょう。

.. Installing a plugin

.. _installing-a-plugin:

プラグインのインストール
==============================

.. Follow the instructions in the plugin’s documentation.

設定方法は、各プラグインのドキュメントをご覧ください。

.. Finding a plugin

.. _finding-a-plugin:

プラグインを探す
====================

.. The following plugins exist:

次のようなプラグインがあります。

..    The Blockbridge plugin is a volume plugin that provides access to an extensible set of container-based persistent storage options. It supports single and multi-host Docker environments with features that include tenant isolation, automated provisioning, encryption, secure deletion, snapshots and QoS.

* `Blockbridge plugin <https://github.com/blockbridge/blockbridge-docker-volume>`_ はボリューム・プラグインです。コンテナをベースとした持続型のストレージ向けオプション、その拡張セットへのアクセスを提供します。１つまたは複数の Docker 環境で、テナントの分離、自動プロビジョニング、暗号化、安全な削除、スナップショット、QoS といった機能を提供します。

..    The Convoy plugin is a volume plugin for a variety of storage back-ends including device mapper and NFS. It’s a simple standalone executable written in Go and provides the framework to support vendor-specific extensions such as snapshots, backups and restore.

* `Convoy plugin <https://github.com/rancher/convoy>`_ はボリューム・プラグインです。 device mapper や NSF を含む様々なストレージ・バックエンドに対応します。スタンドアローンのバイナリはシンプルなGo言語で書かれています。スナップショット、バックアップ、リストアといったベンダ固有の拡張をサポートしたフレームワークを提供します。

..    The Flocker plugin is a volume plugin which provides multi-host portable volumes for Docker, enabling you to run databases and other stateful containers and move them around across a cluster of machines.

* `Flocker plugin <https://clusterhq.com/docker-plugin/>`_ は Docker 対応の複数ホストで、ボリュームをポータブルに持ち運ぶためのプラグインです。これにより、データベースや他のステートフル（状態を持たない）なコンテナを、クラスタ上のマシンにまたがって実行できるようにします。

..    The GlusterFS plugin is another volume plugin that provides multi-host volumes management for Docker using GlusterFS.

* `GlusterFS plugin <https://github.com/calavera/docker-volume-glusterfs>`_ は Docker が GlusterFS を使って複数ホストのボリュームを管理可能にするプラグインです。

..    The Keywhiz plugin is a plugin that provides credentials and secret management using Keywhiz as a central repository.

* `Kyewhiz plugin <https://github.com/calavera/docker-volume-keywhiz>`_ は Keywhiz を中央リポジトリとして、証明書やシークレット（秘密情報）の管理を提供するプラグインです。

..    The Netshare plugin is a volume plugin that provides volume management for NFS ¾, AWS EFS and CIFS file systems.

* `Netshare plugin <https://github.com/gondor/docker-volume-netshare>`_ は NFS v3/v4 、AWS FEC、CIFS ファイルシステムでボリュームを管理するプラグインです。

..    The OpenStorage Plugin is a cluster aware volume plugin that provides volume management for file and block storage solutions. It implements a vendor neutral specification for implementing extensions such as CoS, encryption, and snapshots. It has example drivers based on FUSE, NFS, NBD and EBS to name a few.

* `OpenStorage Plugin <https://github.com/libopenstorage/openstorage>`_ はクラスタ検出ボリューム・プラグインであり、ファイルやブロック・ストレージにおけるボリューム管理ソリューションを提供します。扱えるのは、ベンダ中立の拡張機能です。例えば CoS、暗号化、スナップショットです。サンプル・ドライバがベースにしているのは、FUSE、NFS、NBD、EBS などです。

..    The Pachyderm PFS plugin is a volume plugin written in Go that provides functionality to mount Pachyderm File System (PFS) repositories at specific commits as volumes within Docker containers.

* `Pachyderm PFS plugin <https://github.com/pachyderm/pachyderm/tree/master/src/cmd/pfs-volume-driver>`_ は Go 言語で書かれたボリューム・プラグインです。PFS (Pachyderm File System) リポジトリにマウントできる機能を提供します。Docker コンテナがなくても、ボリュームに対するコミットを行えるようにします。

..    The REX-Ray plugin is a volume plugin which is written in Go and provides advanced storage functionality for many platforms including EC2, OpenStack, XtremIO, and ScaleIO.

* `REX-Ray plugin <https://github.com/emccode/rexraycli>`_ は Go 言語で書かれたボリューム・プラグインです。ES2、OpenStack、XtreamIO、ScaleIO を含む多くのプラットフォームに対応した高度なストレージ機能を提供します。

..    The Contiv Volume Plugin is an open source volume plugin that provides multi-tenant, persistent, distributed storage with intent based consumption using ceph underneath.

* `Contiv Volume Plugin <https://github.com/contiv/volplugin>`_ はオープンソースのボリューム・プラグインです。ceph をベースとした技術により、マルチ・テナントで、永続型、分散したストレージを提供します。

..    The Contiv Networking is an open source libnetwork plugin to provide infrastructure and security policies for a multi-tenant micro services deployment, while providing an integration to physical network for non-container workload. Contiv Networking implements the remote driver and IPAM APIs available in Docker 1.9 onwards.

* `Contiv Networking <https://github.com/contiv/netplugin>`_ はオープンソースの libnetwork プラグインであり、マルチ・テナントのマイクロサービスのデプロイにおけるインフラとセキュリティ・ポリシーを提供します。この環境では、コンテナに対する負担無しに、物理ネットワークの統合をもたらします。Contiv Networking は Docker 1.9 以降で利用可能な リモート・ドライバと IPAM API を実装しています。

..    The Weave Network Plugin creates a virtual network that connects your Docker containers - across multiple hosts or clouds and enables automatic discovery of applications. Weave networks are resilient, partition tolerant, secure and work in partially connected networks, and other adverse environments - all configured with delightful simplicity.

* `Weave Network Plugin <https://github.com/weaveworks/docker-plugin>`_ は Docker コンテナを結ぶ仮想ネットワークを作成します。これは複数のホストやクラウドをまたがり、アプリケーションの自動的な発見を可能にします。Weave network は弾力性（resilient）があり、分散耐性（partition tolerant）があり、安全で、部分的なネットワークでも利用できます。他のツールによる環境と異なり、全ての設定が極めて単純です。

.. Troubleshooting a plugin

.. _troubleshooting-a-plugin:

プラグインのトラブルシューティング
========================================

.. If you are having problems with Docker after loading a plugin, ask the authors of the plugin for help. The Docker team may not be able to assist you.

プラグインを読み込んだ後で Docker に問題が起こったら、プラグインの作者に助けを求めてください。Docker チームはあなたを助けられません（訳者注：Docker コミュニティ外のツールのため）。

.. Writing a plugin

.. _writing-a-plugin:

プラグインを書くには
====================

.. If you are interested in writing a plugin for Docker, or seeing how they work under the hood, see the docker plugins reference.

Docker プラグインを書くことに興味があれば、あるいは、水面下でどのような処理がされているかに興味があれば、 `docker プラグイン・リファレンス <plugin_api>`_ をご覧ください。

.. seealso:: 

   Understand Engine plugins
      https://docs.docker.com/engine/extend/plugins/

