.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/machine/migrate-to-machine/
.. SOURCE: https://github.com/docker/machine/blob/master/docs/migrate-to-machine.md
   doc version: 1.11
      https://github.com/docker/machine/commits/master/docs/migrate-to-machine.md
.. check date: 2016/04/28
.. Commits on Feb 11, 2016 0eb405f1d7ea3ad4c3595fb2c97d856d3e2d9c5c
.. ----------------------------------------------------------------------------

.. _migrate-to-machine:

.. Migrate from Boot2Docker to Docker Machine

==================================================
Boot2Docker から Docker Machine への移行
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. If you were using Boot2Docker previously, you have a pre-existing Docker boot2docker-vm VM on your local system. To allow Docker Machine to manage this older VM, you must migrate it.

これまで Boot2Docker を使っていた場合は、既に Dockerの ``boot2docker-vm`` 仮想マシンがローカルシステム上に存在しています。Docker Machine で古い仮想マシンを管理する場合は、移行が必要です。

..    Open a terminal or the Docker CLI on your system.
..    Type the following command.

1. ターミナルか、システム上の Docker CLI を開きます。
2. 次のコマンドを実行します。

.. code-block:: bash

    $ docker-machine create -d virtualbox --virtualbox-import-boot2docker-vm boot2docker-vm docker-vm

..    Use the docker-machine command to interact with the migrated VM.

3. ``docker-machine`` コマンドを使い、対話式に仮想マシンを移行します。

.. Subcommand comparison

サブコマンドの比較
====================

.. The docker-machine subcommands are slightly different than the boot2docker subcommands. The table below lists the equivalent docker-machine subcommand and what it does:

``docker-machine`` サブコマンドは、``boot2docker`` サブコマンドと若干の違いがあります。次の表は ``docker-machine`` サブコマンドとの互換性を比較したものです。

.. list-table::
   :widths: 25 25 50
   :header-rows: 1

   * - ``boot2docker``
     - ``docker-machine``
     - ``docker-machine`` の説明
   * - init
     - create
     - 新しい docker ホストの作成
   * - up
     - start
     - 停止しているマシンの起動
   * - ssh
     - ssh
     - コマンドの実行やマシンとの双方向 ssh セッション
   * - save
     - ―
     - 使用不可
   * - down
     - stop
     - 実行中のマシンの停止
   * - poweroff
     - stop
     - 実行中のマシンの停止
   * - reset
     - restart
     - 実行中のマシンの再起動
   * - config
     - inspect
     - マシン設定詳細の表示
   * - status
     - ls
     - マシン一覧と状態の表示
   * - info
     - inspect
     - マシンの詳細を表示
   * - ip
     - ip
     - マシンの IP アドレスを表示
   * - shellinit
     - env
     - シェルがマシンと対話するために必要なコマンドの表示
   * - delete
     - rm
     - マシンの削除
   * - download
     - ―
     - 使用不可
   * - upgrade
     - upgrade
     - マシン上の Docker クライアントを最新安定版に更新

.. seealso:: 

   Migrate from Boot2Docker to Docker Machine
      https://docs.docker.com/machine/migrate-to-machine/
