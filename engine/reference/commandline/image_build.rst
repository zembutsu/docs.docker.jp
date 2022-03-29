.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/image_build/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/image_build.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_image_build.yaml
.. check date: 2022/03/28
.. Commits on Dec 9, 2020 3ed725064445f19e836620432ba7522865002da5
.. -------------------------------------------------------------------

.. docker image build

=======================================
docker image build
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _image_build-description:

説明
==========

.. Build an image from a Dockerfile

Dockerfile からイメージを :ruby:`構築 <build>` します。

.. _image_build-usage:

使い方
==========

.. code-block:: bash

   $ docker image build [OPTIONS] PATH | URL | -


.. _image_biuld-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--add-host``
     - 
     - 任意のホストに対し IP を割り当てを追加（host:ip）
   * - ``--build-arg``
     - 
     - 構築時の変数を設定
   * - ``--cache-from``
     - 
     - イメージに対してキャッシュ元を指定
   * - ``--cgroup-parent``
     - 
     - コンテナに対する任意の親 cgroup
   * - ``--compress``
     - 
     - 構築コンテクストを gzip を使って圧縮
   * - ``--cpu-period``
     - 
     - CPU CFS (completely Fair Scheduler)期間を制限
   * - ``--cpu-quota``
     - 
     - CPU CFS (completely Fair Scheduler)クォータを制限
   * - ``--cpu-shares`` 、 ``-c``
     - 
     - CPU :ruby:`配分 <share>` （相対ウェイト）
   * - ``--cpuset-cpus``
     - 
     - アクセスを許可する CPU を指定（ 0-3, 0, 1 ）
   * - ``--cpuset-mems``
     - 
     - アクセスを許可するメモリノードを指定（ 0-3, 0, 1 ）
   * - ``--disable-context-trust``
     - ``true``
     - イメージの検証を無効化
   * - ``--file`` 、 ``-f``
     - 
     - Dockerfile の名前（デフォルトは ``パス/Dockerfile`` ）
   * - ``--force-rm``
     - 
     - 中間コンテナを常に削除
   * - ``--iidfile``
     - 
     - イメージ ID をファイルに書き込む
   * - ``--isolation``
     - 
     - コンテナ分離技術
   * - ``--label``
     - 
     - イメージにメタデータを設定
   * - ``--memory`` 、 ``-m``
     - 
     - メモリの上限
   * - ``--memory-swap``
     - 
     - スワップの上限は、メモリとスワップの合計と同じ： ``-1`` はスワップを無制限にする
   * - ``--network``
     - 
     - 【API 1.25+】 構築中の RUN 命令で使うネットワークモードを指定
   * - ``--no-cache``
     - 
     - イメージの構築時にキャッシュを使用しない
   * - ``--output`` 、 ``-o``
     - 
     - 【API 1.40+】 アウトプット先を指定（書式：type=local,dest=path）
   * - ``--platform``
     - 
     - 【API 1.38+】 サーバがマルチプラットフォーム対応であれば、プラットフォームを指定
   * - ``--progress``
     - ``auto``
     - 進行状況の出力タイプを設定（auto、plain、tty）。plain を使うと、コンテナの出力を表示
   * - ``--pull``
     - 
     - イメージは、常に新しいバージョンのダウンロードを試みる
   * - ``--quiet`` 、 ``-q``
     - 
     - 構築時の出力と成功時のイメージ ID 表示を抑制
   * - ``--rm``
     - ``true``
     - 構築に成功後、中間コンテナを削除
   * - ``--secret``
     - 
     - 【API 1.39+】 構築時に利用するシークレットファイル（BuildKit 有効時のみ）： id=mysecret,src=/local/secret
   * - ``--security-opt``
     - 
     - セキュリティのオプション
   * - ``--shm-size``
     - 
     - /dev/shm の容量
   * - ``--squash``
     - 
     - 【experimental (daemon) | API 1.25+】 構築するレイヤを、単一の新しいレイヤに :ruby:`押し込む <squash>`
   * - ``--ssh``
     - 
     - 【API 1.39+】 構築時に利用する SSH エージェントのソケットやキー（BuildKit 有効時のみ）（書式：default | <id>[=<socket>] | <key>[,<key>]] ）
   * - ``--stream``
     - 
     - サーバにアクセスし、構築コンテクストの状況を表示し続ける
   * - ``--tag`` 、 ``-t``
     - 
     - 名前と、オプションでタグを ``名前:タグ`` の形式で指定
   * - ``--target``
     - 
     - 構築する対象の構築ステージを指定
   * - ``--ulimit``
     - 
     - ulimit オプション


.. Parent command

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker image <image>`
     - イメージの管理


.. Related commands

関連コマンド
====================

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker image build <image_build>`
     - Dockerfile からイメージを構築
   * - :doc:`docker image history <image_history>`
     - イメージの履歴を表示
   * - :doc:`docker image import <image_import>`
     - ファイルシステム・イメージを作成するため、tar ボールから内容を :ruby:`取り込み <import>`
   * - :doc:`docker image inspect <image_inspect>`
     - 1つまたは複数イメージの詳細情報を表示
   * - :doc:`docker image load <image_load>`
     - tar アーカイブか標準入力からイメージを :ruby:`読み込み <load>`
   * - :doc:`docker image ls <image_ls>`
     - イメージ一覧表示
   * - :doc:`docker image prune <image_prune>`
     - 使用していないイメージの削除
   * - :doc:`docker image pull <image_pull>`
     - レジストリからイメージやリポジトリを :ruby:`取得 <pull>`
   * - :doc:`docker image push <image_push>`
     - レジストリにイメージやリポジトリを :ruby:`送信 <push>`
   * - :doc:`docker image rm <image_rm>`
     - 1つまたは複数のイメージを削除
   * - :doc:`docker image save<image_save>`
     - 1つまたは複数イメージを tar アーカイブに保存（デフォルトで標準出力にストリーミング）
   * - :doc:`docker image tag<image_tag>`
     - :ruby:`対象イメージ <TARGET_IMAGE>` に :ruby:`元イメージ <SOURCE_IMAGE>` を参照する :ruby:`タグ <tag>` を作成


.. seealso:: 

   docker image build
      https://docs.docker.com/engine/reference/commandline/image_build/
