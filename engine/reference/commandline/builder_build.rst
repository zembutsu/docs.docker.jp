.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/builder_build/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/builder_build.md
      ソースコードからの自動生成
.. check date: 2022/03/03
.. -------------------------------------------------------------------

.. build

=======================================
docker builder build
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

説明
==========

.. Build an image from a Dockerfile

Dockerfile からイメージを :ruby:`構築 <build>` します。

.. API 1.31+  The client and daemon API must both be at least 1.31 to use this command. Use the docker version command on the client to check your client and daemon API versions.

【API 1.31+】このコマンドを使うには、クライアントとデーモンの両方が最小 `1.31 <https://docs.docker.com/engine/api/v1.31/>`_ を使う必要があります。クライアントとデーモン API バージョンを確認するには、クライアント上で ``docker version`` コマンドを実行します。

使い方
==========

.. code-block:: bash

  $ docker builder build [オプション] パス | URL | -

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--add-host``
     - 
     - ホストから任意の IP 割り当てを追加（host:ip）
   * - ``--build-arg``
     - 
     - 構築時の変数を指定
   * - ``--cache-from``
     - 
     - キャッシュ元とみなすイメージ
   * - ``--cgroup-parent``
     - 
     - コンテナに対するオプションの親 cgroup
   * - ``--compress``
     - 
     - 構築コンテクストを gzip を使って圧縮
   * - ``--cpu-period``
     - 
     - CPU CFS (Completely Fair Scheduler) ピリオドの上限（訳者注：cgroup による CPU リソースへのアクセスを再割り当てする間隔）
   * - ``--cpu-quota``
     - 
     - CPU CFS (Completely Fair Scheduler) クォータの制限
   * - ``--cpu-shares`` , ``-c``
     - 
     - CPU 共有（CPU shares）を指定（相対値）
   * - ``--cpuset-cpus``
     - 
     - 実行する CPU の割り当て（0-3, 0,1）
   * - ``--cpuset-mems``
     - 
     - 実行するメモリ・ノード（MEM）の割り当て（0-3, 0,1）
   * - ``--disable-content-trust``
     - ``true``
     - イメージ検証を無効化
   * - ``--file`` , ``-f``
     - 
     - Dockerfile の名前（デフォルトは ``PATH/Dockerfile`` ）
   * - ``--force-rm``
     - 
     - 中間コンテナをすべて削除
   * - ``--iidfile``
     - 
     - イメージ ID をファイルに書き込む
   * - ``--isolation``
     - 
     - コンテナ隔離技術
   * - ``--label``
     - 
     - イメージのメタデータを設定
   * - ``--memory`` , ``-m``
     - 
     - メモリ制限
   * - ``--memory-swap``
     - 
     - メモリに追加できる swap 上限。なお ``-1`` は swap を無制限
   * - ``--network``
     - 
     - 【API 1.25+】構築時、 RUN 命令を実行中のネットワーク・モードを指定
   * - ``--no-cache``
     - 
     - イメージ構築中にキャッシュを使用しない
   * - ``--output`` , ``-o``
     - 
     - 【API 1.40+】出力先（形式：type=local,dest=path）
   * - ``--platform``
     - 
     - 【API 1.38+】サーバがマルチプラットフォーム対応の場合、プラットフォームを指定
   * - ``--progress``
     - ``auto``
     - 進行状況を出力する種類を指定（auto, plain, tty）。 plain を使うとコンテナの出力を表示
   * - ``--pull``
     - 
     - 常にイメージの新しいバージョンの取得を試みる
   * - ``--quiet`` , ``-q``
     - 
     - 構築時の出力を抑制し、成功時はイメージ ID を表示
   * - ``--rm``
     - ``true``
     - 構築に成功後、中間コンテナを削除
   * - ``--secret``
     - 
     - 【API 1.39+】構築時に表示するシークレットファイル（BuildKit 有効時のみ）： id=mysecret,src=/local/secret
   * - ``--security-opt``
     - 
     - セキュリティオプション
   * - ``--shm-size``
     - 
     - /dev/shm の容量
   * - ``--squash``
     - 
     - 【experimental (daemon)】【API 1.25+】構築したレイヤを、1つの新しいレイヤに圧縮（スカッシュ）
   * - ``--ssh``
     - 
     - 【API 1.39+】構築時に SSH エージェントのソケットかキーを表示（BuildKit の有効化時のみ）（形式： default | <id>[=<socket>|<key>[,<key>]] ）
   * - ``--stream``
     - 
     - サーバにアタッチし、構築コンテクストの状況を表示
   * - ``--tag`` , ``-t``
     - 
     - ``name:tag`` 形式で、名前とオプションでタグを指定
   * - ``--target``
     - 
     - 構築ステージ対象を指定
   * - ``--ulimit``
     - 
     - ulimit オプション



親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker builder<builder>`
     - 構築を管理


.. Related commands

関連コマンド
====================

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker builder build<builder_build>`
     - Dockerfile からイメージを構築
   * - :doc:`docker prune build<builder_prune>`
     - 構築キャッシュの削除

.. seealso:: 

   docker builder build
      https://docs.docker.com/engine/reference/commandline/builder_build/
