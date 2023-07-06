.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/compose_build/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/compose_build.md
.. check date: 2022/03/06
.. -------------------------------------------------------------------

.. docker compose build

=======================================
docker compose build
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _compose_build-description:

説明
==========

.. Build or rebuild services

サービスの構築もしくは再構築です。

.. _compose_build-usage:

使い方
==========

.. code-block:: bash

   $ docker compose build [SERVICE...]

.. Extended description

.. _compose_build-extended-description:

補足説明
==========

.. Services are built once and then tagged, by default as project_service.

サービスを一旦 :ruby:`構築 <build>` し、その後にタグ付けします。デフォルトでは ``project_service`` （プロジェクト名_サービス名）です。

.. If the Compose file specifies an image name, the image is tagged with that name, substituting any variables beforehand. See variable interpolation.

Compose ファイル仕様の `image <https://github.com/compose-spec/compose-spec/blob/master/spec.md#image>`_ 名があれば、対象のイメージはその名前でタグ付けされるため、以前に指定していた値は上書きされます。詳細は `変数の書き換え <https://github.com/compose-spec/compose-spec/blob/master/spec.md#interpolation>`_ をご覧ください。

.. If you change a service’s Dockerfile or the contents of its build directory, run docker compose build to rebuild it.

サービスの ``Dockerfile`` や構築ディレクトリ内容を変更した場合は、それらを再構築するために ``docker compose build`` を実行します。

.. _compose_build-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--build-arg``
     - 
     - サービスの構築時に変数を指定
   * - ``--compress``
     - ``true``
     - 構築コンテクストを gzip を使って圧縮。非推奨
   * - ``--force-rm``
     - ``true``
     - 中間コンテナを常に削除。非推奨
   * - ``--memory`` , ``-m``
     - 
     - 構築コンテナのメモリ上限を指定。buildkit では未サポート
   * - ``--no-cache``
     - 
     - イメージの構築時にキャッシュを使わない
   * - ``--no-rm``
     - 
     - 構築の成功後、中間コンテナを削除しない。非推奨
   * - ``--parallel``
     - ``true``
     - 並列にイメージを構築。非推奨
   * - ``--progress``
     - ``auto``
     - 進捗の出力タイプを指定（ ``auto`` 、 ``plain`` 、 ``noTty`` ）
   * - ``--pull``
     - 
     - 常にイメージの新しいバージョンの取得を試みる
   * - ``--quite`` , ``-q``
     - 
     - 標準出力（STDOUT）に何も表示しない



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

   docker compose build
      https://docs.docker.com/engine/reference/commandline/compose_build/
