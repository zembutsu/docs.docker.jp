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

.. Using network driver plugins

.. _using-network-driver-plugins:

ネットワーク・ドライバ・プラグインを使う
========================================

.. The means of installing and running a network driver plugin depend on the particular plugin. So, be sure to install your plugin according to the instructions obtained from the plugin developer.

ネットワーク・ドライバ・プラグインのインストール実行は、個々のプラグインに依存します。そのため、プラグインをインストールするには、各プラグインの開発者から指示を得てください。

.. Once running however, network driver plugins are used just like the built-in network drivers: by being mentioned as a driver in network-oriented Docker commands. For example,

ネットワーク・ドライバを実行しても、内部ネットワーク・ドライバのように扱えないかもしれません。ネットワーク対応の Docker コマンドでドライバを操作します。例えば、次のようなコマンドです。

.. code-block:: bash

   $ docker network create --driver weave mynet

.. Some network driver plugins are listed in plugins

ネットワーク・ドライバのプラグイン一覧は、 :doc:`こちら <plugins>` をご覧ください。

.. The mynet network is now owned by weave, so subsequent commands referring to that network will be sent to the plugin,

``mynet`` ネットワークは ``weave`` の所有となりましたので、以下に続くコマンドは、プラグインの管理するネットワークに対して送信されます。

.. code-block:: bash

   $ docker run --net=mynet busybox top

.. Write a network plugin

.. _write-a-network-plugin:

ネットワーク・プラグインを書くには
==================================

.. Network plugins implement the Docker plugin API and the network plugin protocol

ネットワーク・プラグインの実装は、 :doc:`Docker プラグイン API <plugin_api>` のネットワーク・プラグイン・プロトコルをご覧ください。

.. Network plugin protocol

.. _network-plugin-protocol:

ネットワーク・プラグイン・プロトコル
====================================

.. The network driver protocol, in addition to the plugin activation call, is documented as part of libnetwork: https://github.com/docker/libnetwork/blob/master/docs/remote.md.

ネットワーク・ドライバ・プロトコルとは、プラグイン・アクティベーション・コール（plugin activation call）の追加です。詳細については libnetwork の該当ドキュメント https://github.com/docker/libnetwork/blob/master/docs/remote.md をご覧ください。

.. Related Information

関連情報
====================

.. To interact with the Docker maintainers and other interested users, se the IRC channel #docker-network.

Docker メンテナや他のユーザと対話するには、IRC チャンネルの ``#docker-network`` にお越し下さい。

..    Docker networks feature overview
    The LibNetwork project

* :doc:`Docker ネットワーク機能の概要 </engine/userguide/networking/index>`
* `LibNetwork <https://github.com/docker/libnetwork>`_ プロジェクト

.. seealso:: 

   Engine network driver plugins
      https://docs.docker.com/engine/extend/plugins_network/
