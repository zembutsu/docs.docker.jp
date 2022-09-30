.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/compose_rm/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/compose_rm.md
.. check date: 2022/03/06
.. ------------------------------------------------------------------

.. docker compose rm

=======================================
docker compose rm
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _compose_rm-description:

説明
==========

.. Removes stopped service containers

停止済みのサービス・コンテナを削除します。

.. _compose_rm-usage:

使い方
==========

.. code-block:: bash

   $ docker compose rm [SERVICE...]

.. Extended description

.. _compose_rm-extended-description:

補足説明
==========

.. Removes stopped service containers.

停止済みサービス・コンテナを削除します。

.. By default, anonymous volumes attached to containers are not removed. You can override this with -v. To list all volumes, use docker volume ls.

デフォルトでは、コンテナにアタッチされた匿名ボリュームを削除しません。これは ``-v`` で上書きできます。ボリューム一覧を表示するには、 ``docker volume ls`` を使います。

.. Any data which is not in a volume is lost.

ボリュームに入っていないデータは消失します。

.. Running the command with no options also removes one-off containers created by docker compose run:

オプションをつけずにコマンドを実行すると、 ``docker compose run`` によって作成された一回限りのコンテナも削除します。

.. code-block:: bash

   $ docker compose rm
   Going to remove djangoquickstart_web_run_1
   Are you sure? [yN] y
   Removing djangoquickstart_web_run_1 ... done

.. _compose_rm-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--all`` , ``-a``
     - 
     - 非推奨 - 何もしない
   * - ``--force`` , ``-f``
     - 
     - 削除の確認をしない
   * - ``--stop`` , ``-s``
     - 
     - 削除する前に、必要があればコンテナを停止
   * - ``--volumes`` , ``-v``
     - 
     - コンテナにアタッチしている、あらゆる匿名ボリュームを削除


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

   docker compose rm
      https://docs.docker.com/engine/reference/commandline/compose_rm/
