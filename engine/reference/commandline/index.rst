.. -*- coding: utf-8 -*-
.. https://docs.docker.com/engine/reference/commandline/
.. doc version: 1.9
.. check date: 2015/12/25
.. -----------------------------------------------------------------------------

.. The Docker Commands

.. _the-docker-commands:

=======================================
Docker コマンド
=======================================

.. This section contains reference information on using Docker’s command line client. Each command has a reference page along with samples. If you are unfamiliar with the command line, you should start by reading about how to Use the Docker command line.

このセクションは、 Docker のコマンドライン・クライアントを使うにあたってのリファレンス情報です。各コマンドのリファレンス・ページにはサンプルもあります。コマンドラインになれていなければ、 :doc:`cli` から読み始めた方が良いでしょう。

.. You start the Docker daemon with the command line. How you start the daemon affects your Docker containers. For that reason you should also make sure to read the daemon reference page.

Docker デーモンの起動はコマンドラインで行います。Docker デーモンは Docker コンテナに影響を与えるものです。そのため、 ``daemon`` のリファレンス・ページも読んだほうが望ましいでしょう。

.. Docker management commands

.. _docker-management-commands:

Docker 管理コマンド
====================

* :doc:`daemon <daemon>`
* :doc:`info <info>`
* :doc:`inspect <inspect>`
* :doc:`version <version>`

.. Image commands

.. _image-commands:

イメージ用コマンド
====================

* :doc:`build <build>`
* :doc:`commit <commit>`
* :doc:`export <export>`
* :doc:`history <history>`
* :doc:`images <images>`
* :doc:`import <import>`
* :doc:`load <load>`
* :doc:`rmi <rmi>`
* :doc:`save <save>`
* :doc:`tag <tag>`

.. Container commands

.. _container-command:

コンテナ用コマンド
====================

* :doc:`attach <attach>`
* :doc:`cp <cp>`
* :doc:`create <create>`
* :doc:`diff <diff>`
* :doc:`events <events>`
* :doc:`exec <exec>`
* :doc:`kill <kill>`
* :doc:`logs <logs>`
* :doc:`pause <pause>`
* :doc:`port <port>`
* :doc:`ps <ps>`
* :doc:`rename <rename>`
* :doc:`restart <restart>`
* :doc:`rm <rm>`
* :doc:`run <run>`
* :doc:`start <start>`
* :doc:`stats <stats>`
* :doc:`stop <stop>`
* :doc:`top <top>`
* :doc:`unpause <unpause>`
* :doc:`wait <wait>`

.. Hub and registry commands

.. _hub-and-registry-command:

Hub ・レジストり用コマンド
==============================

* :doc:`login <login>`
* :doc:`logout <logout>`
* :doc:`pull <pull>`
* :doc:`push <push>`
* :doc:`search <search>`

.. Network and connectivity commands

.. _network-and-connectivity-commands:

ネットワークと接続用コマンド
==============================

* :doc:`network_connect <network_connect>`
* :doc:`network_create <network_create>`
* :doc:`network_disconnect <network_disconnect>`
* :doc:`network_inspect <network_inspect>`
* :doc:`network_ls <network_ls>`
* :doc:`network_rm <network_rm>`

.. Shared data volume commands

共有データボリューム用コマンド
==============================

* :doc:`volume_create <volume_create>`
* :doc:`volume_inspect <volume_inspect>`
* :doc:`volume_ls <volume_ls>`
* :doc:`volume_rm <volume_rm>`

