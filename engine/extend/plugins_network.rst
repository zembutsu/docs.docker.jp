.. -*- coding: utf-8 -*-
.. https://docs.docker.com/engine/extend/plugins_network/
.. doc version: 1.9
.. check date: 2016/01/09

.. title: "Docker network driver plugins"

.. _docker-network-driver-plugins:

==========================================
Docker ネットワーク・ドライバ・プラグイン
==========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. # Engine network driver plugins

.. _engine-network-driver-plugins:

Engine ネットワーク・ドライバ・プラグイン
=============================================

.. This document describes Docker Engine network driver plugins generally
   available in Docker Engine. To view information on plugins
   managed by Docker Engine, refer to [Docker Engine plugin system](index.md).

ここでは Docker Engine において、一般的に利用可能な Docker Engine ネットワーク・ドライバ・プラグインについて説明します。
Docker Engine が管理するプラグインに関する情報は :doc:`Docker Engine プラグイン・システム <index>` を参照してください。

.. Docker Engine network plugins enable Engine deployments to be extended to
   support a wide range of networking technologies, such as VXLAN, IPVLAN, MACVLAN
   or something completely different. Network driver plugins are supported via the
   LibNetwork project. Each plugin is implemented as a  "remote driver" for
   LibNetwork, which shares plugin infrastructure with Engine. Effectively, network
   driver plugins are activated in the same way as other plugins, and use the same
   kind of protocol.

Docker Engine ネットワーク・プラグインは、Engineによるデプロイメントを拡張して、非常に多くのネットワーク技術へのサポートを可能とします。
対応するネットワーク技術としてたとえば VXLAN, IPVLAN, MACVLAN などがあり、これ以外にも全く異なる技術にも対応可能です。
ネットワーク・ドライバ・プラグインは LibNetwork プロジェクトを通じてサポートされています。
各プラグインは LibNetwork における「リモートドライバ」として実装されており、Engine におけるプラグイン基盤を共有しています。
実際にネットワーク・ドライバ・プラグインは、他のプラグインと同様の方法で取り入れることができるものであり、同じようなプロトコルを利用しています。

.. ## Network driver plugins and swarm mode

.. _network-driver-plugins-and-swarm-mode:

ネットワーク・ドライバ・プラグインとスウォーム・モード
=======================================================

.. Docker 1.12 adds support for cluster management and orchestration called
   [swarm mode](https://docs.docker.com/engine/swarm/). Docker Engine running in swarm mode currently
   only supports the built-in overlay driver for networking. Therefore existing
   networking plugins will not work in swarm mode.

Docker 1.12 から :doc:`スウォーム・モード </engine/swarm/>` と呼ばれるクラスタ管理およびオーケストレーション機能がサポートされるようになりました。
スウォーム・モードにおいて稼動する Docker Engine は、現時点ネットワークに関しては、ビルトインの overlay ドライバのみをサポートします。
したがってすでに提供されているネットワーク・プラグインは、スウォーム・モードにおいては動作しません。

.. When you run Docker Engine outside of swarm mode, all networking plugins that
   worked in Docker 1.11 will continue to function normally. They do not require
   any modification.

スウォーム・モード以外で Docker Engine を稼動させると、Docker 1.1 において動作していたネットワーク・プラグインは引き続き正常に動作します。
そこには特に修正を必要としません。

.. ## Using network driver plugins

.. _using-network-driver-plugins:

ネットワーク・ドライバ・プラグインの利用
=========================================

.. The means of installing and running a network driver plugin depend on the
   particular plugin. So, be sure to install your plugin according to the
   instructions obtained from the plugin developer.

ネットワーク・ドライバ・プラグインのインストール方法や実行方法は、個々のプラグインにより異なります。
そこでプラグインをインストールする際には、プラグイン開発者が示す説明に従ってください。

.. Once running however, network driver plugins are used just like the built-in
   network drivers: by being mentioned as a driver in network-oriented Docker
   commands. For example,

ネットワーク・ドライバ・プラグインを実行することができれば、後はビルトインのネットワーク・ドライバと変わらずに利用していきます。
つまりネットワーク関連の Docker コマンドにおいて、ドライバを取り扱うコマンドを用いていきます。
たとえば以下のとおりです。

..  $ docker network create --driver weave mynet

.. code-block:: bash

   $ docker network create --driver weave mynet

.. Some network driver plugins are listed in [plugins](legacy_plugins.md)

ネットワーク・ドライバ・プラグインの一覧が :doc:`プラグイン <legacy_plugins>` にあります。

.. The `mynet` network is now owned by `weave`, so subsequent commands
   referring to that network will be sent to the plugin,

``mynet`` ネットワークは ``weave`` により所有されたので、これ以降にネットワークを参照するコマンドは、プラグインに送信され実行されることになります。

..  $ docker run --network=mynet busybox top

.. code-block:: bash

   $ docker run --network=mynet busybox top

.. ## Write a network plugin

.. _write-a-network-plugin:

ネットワーク・プラグインの開発
==================================

.. Network plugins implement the [Docker plugin
   API](plugin_api.md) and the network plugin protocol

ネットワーク・プラグインは、:doc:`Docker プラグイン API <plugin_api>` とネットワーク・プラグイン・プロトコルにより実装されます。

.. ## Network plugin protocol

.. _network-plugin-protocol:

ネットワーク・プラグイン・プロトコル
====================================

.. The network driver protocol, in addition to the plugin activation call, is
   documented as part of libnetwork:
   [https://github.com/docker/libnetwork/blob/master/docs/remote.md](https://github.com/docker/libnetwork/blob/master/docs/remote.md).

ネットワーク・ドライバ・プロトコル、およびプラグイン・アクティベーション・コール（plugin activation call）については、libnetwork の一部 https://github.com/docker/libnetwork/blob/master/docs/remote.md としてドキュメント化されています。

.. # Related Information

関連情報
====================

.. To interact with the Docker maintainers and other interested users, see the IRC channel `#docker-network`.

Docker メンテナや関心を寄せているユーザと会話をしてみたい方は、IRC チャネル ``#docker-network`` にアクセスしてください。

.. -  [Docker networks feature overview](https://docs.docker.com/engine/userguide/networking/)
   -  The [LibNetwork](https://github.com/docker/libnetwork) project

* :doc:`Docker ネットワーク機能の概要 </engine/userguide/networking/index>`
* `LibNetwork <https://github.com/docker/libnetwork>`_ プロジェクト

.. seealso:: 

   Engine network driver plugins
      https://docs.docker.com/engine/extend/plugins_network/
