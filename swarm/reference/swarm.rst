.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/swarm/reference/swarm/
.. SOURCE: https://github.com/docker/swarm/blob/master/docs/reference/swarm.md
   doc version: 1.11
      https://github.com/docker/swarm/commits/master/docs/reference/swarm.md
.. check date: 2016/04/29
.. Commits on Feb 25, 2016 e8fad3d657f23aea08b3d03eab422ae89cfa3442
.. -------------------------------------------------------------------

.. Swarm — A Docker-native clustering system

.. _swarm-a-docker-native-clustering-system:

===================================================
swarm - Docker ネイティブのクラスタリング・システム
===================================================

.. The swarm command runs a Swarm container on a Docker Engine host and performs the task specified by the required subcommand, COMMAND.

``swarm`` コマンドは Docker Engine のホスト上に Swarm コンテナを起動し、指定されたサブコマンドに応じたタスクを処理します。

.. Use swarm with the following syntax:

``swarm`` は次の構文で使います。

.. code-block:: bash

   $ docker run swarm [オプション] コマンド [引数...]

.. For example, you use swarm with the manage subcommand to create a Swarm manager in a high-availability cluster with other managers:

例えば、 ``swarm`` で ``manage`` サブコマンドを使えば Swarm マネージャを作成します。この時、クラスタ上にある他のマネージャと可用性を持たせるには：

.. code-block:: bash

   $ docker run -d -p 4000:4000 swarm manage -H :4000 --replication --advertise 172.30.0.161:4000 consul://172.30.0.165:8500

.. Options

オプション
====================

.. The swarm command has the following options:

``swarm`` コマンドには以下のオプションがあります。

..    --debug — Enable debug mode. Display messages that you can use to debug a Swarm node. For example: time=“2016-02-17T17:57:40Z” level=fatal msg=“discovery required to join a cluster. See ‘swarm join --help’.” The environment variable for this option is [$DEBUG].
    --log-level "<value>" or -l "<value>" — Set the log level. Where <value> is: debug, info, warn, error, fatal, or panic. The default value is info.
    --experimental — Enable experimental features.
    --help or -h — Display help.
    --version or -v — Display the version. For example: $ docker run swarm --version swarm version 1.1.0 (a0fd82b)

* ``--debug`` : デバッグ・モードを有効にします。Swarm ノードのデバッグ用に使うメッセージを表示します。例： time=“2016-02-17T17:57:40Z” level=fatal msg=“discovery required to join a cluster. See ‘swarm join --help’.” 。このオプションは環境変数 ``${DEBUG}`` でも指定可能です。
* ``--log-level "<値>"`` または ``-l "<値>"`` : ログレベルを指定します。 ``<値>`` に入るのは ``debug`` 、 ``info``  、 ``warn`` 、``error`` 、 ``fatal`` 、 ``panic``  です。デフォルト値は ``info`` です。
* ``--experimental`` : 実験的機能を有効にします。
* ``--help`` または ``-h`` : ヘルプを表示します。
* ``--version``  または ``-v`` : バージョン情報を表示します。例：  $ docker run swarm --version swarm version 1.1.0 (a0fd82b)

.. Commands

コマンド
==========

.. The swarm command has the following subcommands:

``swarm`` コマンドには以下のサブコマンドがあります。

..    create, c - Create a discovery token
    list, l - List the nodes in a Docker cluster
    manage, m - Create a Swarm manager
    join, j - Create a Swarm node
    help - Display a list of Swarm commands, or help for one command

* :doc:`create, c <create>` : ディスカバリ・トークンの作成
* :doc:`list, l <list>` : Docker クラスタのノード一覧を表示
* :doc:`manage, m <manage>` : Swarm マネージャの作成
* :doc:`join, j <join>` : Swarm ノードの作成
* :doc:`help, h <help>` : Swarm コマンドの一覧を表示するか、各コマンドに対するヘルプを表示。

.. seealso:: 

   Swarm — A Docker-native clustering system
      https://docs.docker.com/swarm/reference/swarm/

