﻿.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/compose_down/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/compose_down.md
.. check date: 2022/03/06
.. -------------------------------------------------------------------

.. docker compose down

=======================================
docker compose down
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _compose_down-description:

説明
==========

.. Stop and remove containers, networks

コンテナやネットワークの停止と削除をします。

.. _compose_down-usage:

使い方
==========

.. code-block:: bash

   $ docker compose down

.. Extended description

.. _compose_down-extended-description:

補足説明
==========

.. Stops containers and removes containers, networks, volumes, and images created by up.

コンテナを停止し、 ``up`` によって作成されたコンテナ、ネットワーク、ボリューム、イメージを削除します。

.. By default, the only things removed are:

デフォルトで削除するのは、以下の項目のみです。

..    Containers for services defined in the Compose file
    Networks defined in the networks section of the Compose file
    The default network, if one is used

* Compose ファイルで定義したサービス用のコンテナ
* Compose ファイルの networks セクションで定義したネットワーク
* 使用していたデフォルトのネットワーク

.. Networks and volumes defined as external are never removed.

外部で定義したネットワークとボリュームは、決して削除しません。

.. Anonymous volumes are not removed by default. However, as they don’t have a stable name, they will not be automatically mounted by a subsequent up. For data that needs to persist between updates, use explicit paths as bind mounts or named volumes.

:ruby:`匿名ボリューム <anonymous volume>` はデフォルトでは削除しません。しかしながら、これらは特定の名前を持っていませんので、 ``up`` した後で自動的にマウントされません。更新時にデータを保つ必要がある場合は、 :ruby:`バインド・マウント <bind mount>` や :ruby:`名前付きボリューム <named volume>` を用いた外部のパスを使います。

.. _compose_down-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--remove-orphans``
     - 
     - Compose ファイルで定義されていないサービス用のコンテナを削除
   * - ``--rmi``
     - 
     - サービスが使っていないイメージを削除。 ``local`` が削除するのは、カスタムタグ（ ``local`` | ``all`` ）が無いイメージのみ
   * - ``--timeout`` , ``-t``
     - ``10``
     - 停止までのタイムアウトを秒で指定
   * - ``--volumes`` , ``-v``
     - 
     - Compose ファイルの ``volumes`` セクションないで宣言された名前付きボリュームと、コンテナに接続している匿名ボリュームを削除。


親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI のベースコマンド。


.. Related commands

関連コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker compose build<compose_build>`
     - サービスの構築もしくは再構築
   * - :doc:`docker compose convert<compose_convert>`
     - compose ファイルをプラットフォーム固有の形式に変換
   * - :doc:`docker compose cp<compose_cp>`
     - サービス・コンテナとローカル・ファイルシステム間でファイルやフォルダをコピー
   * - :doc:`docker compose create<compose_create>`
     - サービス用のコンテナを作成
   * - :doc:`docker compose down<compose_down>`
     - コンテナやネットワークの停止と削除
   * - :doc:`docker compose events<compose_events>`
     - コンテナからリアルタイムにイベントを受信
   * - :doc:`docker compose exec<compose_exec>`
     - 実行中のコンテナ内でコマンドを実行
   * - :doc:`docker compose images<compose_images>`
     - 作成したコンテナが使っているイメージを一覧表示
   * - :doc:`docker compose kill<compose_kill>`
     - サービスコンテナを強制停止
   * - :doc:`docker compose logs<compose_logs>`
     - コンテナからの出力を表示
   * - :doc:`docker compose ls<compose_ls>`
     - 実行中の compose プロジェクトを一覧表示
   * - :doc:`docker compose pause<compose_pause>`
     - サービスの一時停止
   * - :doc:`docker compose port<compose_port>`
     - ポートを確保している公開ポートを表示
   * - :doc:`docker compose ps<compose_ps>`
     - コンテナを一覧表示
   * - :doc:`docker compose pull<compose_pull>`
     - サービスのイメージを取得
   * - :doc:`docker compose push<compose_push>`
     - サービスのイメージを送信
   * - :doc:`docker compose restart<compose_restart>`
     - コンテナの再起動
   * - :doc:`docker compose rm<compose_rm>`
     - 停止済みのサービス・コンテナを削除
   * - :doc:`docker compose run<compose_run>`
     - サービスを一度限りのコマンドとして実行
   * - :doc:`docker compose start<compose_start>`
     - サービスの開始
   * - :doc:`docker compose stop<compose_stop>`
     - サービスの停止
   * - :doc:`docker compose top<compose_top>`
     - 実行中のプロセスを表示
   * - :doc:`docker compose unpause<compose_unpause>`
     - サービスの一時停止を解除
   * - :doc:`docker compose up<compose_up>`
     - コンテナの作成と開始


.. seealso:: 

   docker compose down
      https://docs.docker.com/engine/reference/commandline/compose_down/
