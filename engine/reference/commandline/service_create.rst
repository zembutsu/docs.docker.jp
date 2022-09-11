.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/service_create/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/service_create.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_service_create.yaml
.. check date: 2022/04/02
.. Commits on Apr 2, 2022 098129a0c12e3a79398b307b38a67198bd3b66fc
.. -------------------------------------------------------------------

.. docker service craete

.. _docker_service-create:

=======================================
docker service create
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _service-description:

説明
==========

.. Create a new service

 新しいサービスを作成します。

.. API 1.24+
   Open the 1.24 API reference (in a new window)
   The client and daemon API must both be at least 1.25 to use this command. Use the docker version command on the client to check your client and daemon API versions.
   Swarm This command works with the Swarm orchestrator.

- 【API 1.24+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.25 <https://docs.docker.com/engine/api/v1.25/>`_ の必要があります。クライアントとデーモン API のバージョンを調べるには、 ``docker version`` コマンドを使います。
- 【Swarm】このコマンドは Swarm オーケストレータと動作します。

.. _docker_service-usage:

使い方
==========

.. code-block:: bash

   $ docker service create [OPTIONS] IMAGE [COMMAND] [ARG...]

.. Extended description
.. _service_create-extended-description:

補足説明
==========

Creates a service as described by the specified parameters.

..    Note
    This is a cluster management command, and must be executed on a swarm manager node. To learn about managers and workers, refer to the Swarm mode section in the documentation.

.. note::

   これはクラスタ管理コマンドであり、 swarm manager ノードで実行する必要があります。manager と worker について学ぶには、ドキュメント内の :doc:`Swarm モードのセクション </engine/swarm/index>` を参照ください。


.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <service_create-examples>` をご覧ください。


.. _secret_create-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--cap-add``
     - 
     - 【API 1.41+】Linux ケーパビリティを追加
   * - ``--cap-drop``
     - 
     - 【API 1.41+】Linux ケーパビリティを削除
   * - ``--config``
     - 
     - 【API 1.30+】サービスに対して適用する設定を指定
   * - ``--constraint``
     - 
     - 場所の :ruby:`制約 <constraint>`
   * - ``--container-label``
     - 
     - コンテナのラベル
   * - ``--credentail-spec``
     - 
     - 【API 1.29+】マネージド・サービス・アカウントの証明書設定（Windows のみ）
   * - ``--detach`` , ``-d``
     - 
     - 【API 1.29+】サービスとのやりとりを待たず、直ちに出る
   * - ``--dns``
     - 
     - 【API 1.25+】任意の DNS サービスを指定
   * - ``--dns``
     - 
     - 【API 1.25+】任意の DNS サービスを指定
   * - ``--dns-option``
     - 
     - 【API 1.25+】DNS オプションを指定
   * - ``--dns-search``
     - 
     - 【API 1.25+】任意の DNS 検索ドメインを指定
   * - ``--endpoint-mode``
     - ``vip``
     - エンドポイント・モードを指定（ ``vip`` か ``dnsrr`` ）
   * - ``--env-file``
     - 
     - 環境変数をファイルから読み込む
   * - ``--generic-resource``
     - 
     - ユーザ定義リソース
   * - ``--group``
     - 
     - 【API 1.25+】コンテナに対する追加のユーザグループを指定
   * - ``--health-cmd``
     - 
     - 【API 1.25+】正常性を確認するために実行するコマンド
   * - ``--health-interval``
     - 
     - 【API 1.25+】確認を実行する間隔（ ms|s|m|h）（デフォルト 0s）
   * - ``--health-retries``
     - 
     - 【API 1.25+】障害と報告するために必要な、失敗を繰り返す回数
   * - ``--health-start-period``
     - 
     - 【API 1.29+】 正常性確認をカウントダウン開始するまで、コンテナ初期化まで待つ期間を指定（ms|s|m|h）（デフォルト 0s）
   * - ``--health-timeout``
     - 
     - 【API 1.25+】実行の確認を許容する最長時間（ms|s|m|h）（デフォルト 0s）
   * - ``--host``
     - 
     - 【API 1.25+】任意のホストから IP アドレスのマッピングを指定（ホスト:ip）
   * - ``--hostname``
     - 
     - 【API 1.25+】コンテナのホスト名
   * - ``--init``
     - 
     - 【API 1.25+】コンテナ内で :ruby:`初回のプロセス <init>` として実行し、シグナルを転送し、プロセスに渡す
   * - ``--isolation``
     - 
     - 【API 1.35+】コンテナ分離（隔離）技術
   * - ``--label`` , ``-l``
     - 
     - サービスのラベル
   * - ``--limit-cpu``
     - 
     - CPU 制限
   * - ``--memory``
     - 
     - メモリ制限
   * - ``--limit-pids``
     - 
     - 【API 1.41+】【Swarm】プロセス数の上限を制限（デフォルト 0 = 無制限）
   * - ``--log-driver``
     - 
     - サービス用のログ記録ドライバ
   * - ``--log-opt``
     - 
     - ログ記録ドライバのオプション
   * - ``--max-concurrent``
     - 
     - 【API 1.41+】並列に実行するジョブタスク数（デフォルトは --replicas と同じ）
   * - ``--mode``
     - ``replicated``
     - サービスモード（ replicated、global、replicated-job、global-job）
   * - ``--mount``
     - 
     - サービスに対してファイルシステム・マウントをアタッチ
   * - ``--name``
     - 
     - サービス名
   * - ``--network``
     - 
     - 接続するネットワーク
   * - ``--no-healthcheck``
     - 
     - 【API 1.25+】コンテナに指定されている HEATHCHECK を無効化
   * - ``--no-resolve-image``
     - 
     - 【API 1.30+】イメージのダイジェスト値とサポートしているプラットフォームを、レジストリに問い合わせしない
   * - ``--placement-perf``
     - 
     - 【API 1.28+】placement設定を追加
   * - ``--publish`` , ``-p``
     - 
     - ノードのポートとして公開するポート
   * - ``--quiet`` , ``-q``
     - 
     - 進捗の表示を抑制
   * - ``--read-only``
     - 
     - 【API 1.28+】コンテナのルート・ファイルシステムを読み込み専用としてマウント
   * - ``--replicas``
     - 
     - タスク数
   * - ``--replicas-max-per-node``
     - 
     - 【API 1.40+】ノードごとの最大タスク（デフォルトは 0 = 無制限）
   * - ``--reservice-cpu``
     - 
     - CPU 予約
   * - ``--reserve-memory``
     - 
     - メモリ予約
   * - ``--restart-condition``
     - 
     - 状況が発生した時に再起動（ ``none`` | ``on-failure`` | ``any`` ）（デフォルトは ``any`` ）
   * - ``--restart-delay``
     - 
     - 再起動を試みるまでの遅延（ ``ns`` | ``us`` | ``ms`` | ``s`` | ``m`` | ``h`` ）（デフォルト 5s ）
   * - ``--restart-max-attempts``
     - 
     - 再起動を断念するまで試す数
   * - ``--restart-window``
     - 
     - 再起動ポリシーを評価するために使う期間（ ``ns`` | ``us`` | ``ms`` | ``s`` | ``m`` | ``h`` ）
   * - ``--rollback-delay``
     - 
     - 【API 1.28+】タスクをロールバックするまでの遅延（ ``ns`` | ``us`` | ``ms`` | ``s`` | ``m`` | ``h`` ）（デフォルト 0s ）
   * - ``--rollback-failure-action``
     - 
     - 【API 1.28+】ロールバック失敗時の処理（ ``pause`` | ``continue`` ）（デフォルト ``pause`` ）
   * - ``--rollback-max-failure-ratio``
     - 
     - 【API 1.28+】ロールバックを許容する :ruby:`障害率 <failure rate>` （デフォルト 0）
   * - ``--rollback-monitor``
     - 
     - 【API 1.28+】各タスクのロールバックが失敗するまで監視する時間（ ``ns`` | ``us`` | ``ms`` | ``s`` | ``m`` | ``h`` ）（デフォルト 5s ）
   * - ``--rollback-order``
     - 
     - 【API 1.29+】ロールバック順番（ ``start-first`` | ``stop-first`` ）（デフォルト ``stop-first`` ）
   * - ``--rollback-parallelism``
     - ``1``
     - 【API 1.28+】同時にロールバックする最大タスク数（ 0 はロールバックを一斉実施）
   * - ``--secret``
     - 
     - 【API 1.25+】 サービス側に露出するシークレットを指定
   * - ``--stop-grace-period``
     - 
     - コンテナを強制停止するまで待機する時間（ ``ns`` | ``us`` | ``ms`` | ``s`` | ``m`` | ``h`` ）（デフォルト 10s ）
   * - ``--stop-signal``
     - 
     - 【API 1.28+】コンテナの停止シグナル
   * - ``--sysctl``
     - 
     - 【API 1.40+】sysctl オプション
   * - ``--tty`` , ``-t``
     - 
     - 疑似ターミナルを割り当て
   * - ``--ulimit``
     - 
     - 【API 1.41+】 ulimit オプション
   * - ``--update-delay``
     - 
     - 更新間の遅延（ ``ns`` | ``us`` | ``ms`` | ``s`` | ``m`` | ``h`` ）（デフォルト 0s ）
   * - ``--update-failure-action``
     - 
     - 更新失敗時の処理（ ``pause`` | ``continue`` | ``rollback`` ）（デフォルト ``pause`` ）
   * - ``--update-max-failure-ratio``
     - 
     - 【API 1.25+】許容する :ruby:`更新失敗率 <failure rate>` （デフォルト 0）
   * - ``--update-monitor``
     - 
     - 【API 1.25+】各タスクの更新が失敗するまで監視する時間（ ``ns`` | ``us`` | ``ms`` | ``s`` | ``m`` | ``h`` ）（デフォルト 5s ）
   * - ``--update-order``
     - 
     - 【API 1.29+】更新順番（ ``start-first`` | ``stop-first`` ）（デフォルト ``stop-first`` ）
   * - ``--update-parallelism``
     - ``1``
     - 同時に更新する最大タスク数（ 0 は更新を一斉実施）
   * - ``--user`` , ``-u``
     - 
     - ユーザ名か UID（形式： <name|uid>[:<group|gid>] ）
   * - ``--with-registry-auth``
     - 
     - swarm エージェントに対して送信する、レジストリ認証情報の詳細
   * - ``--workdir`` , ``-w``
     - 
     - コンテナ内の作業ディレクトリ


.. Examples
.. _service_create-examples:

使用例
==========

.. Create a service
.. _service_create-create-a-service:

サービスの作成
--------------------

.. code-block:: bash

   $ docker service create --name redis redis:3.0.6
   
   dmu1ept4cxcfe8k8lhtux3ro3
   
   $ docker service create --mode global --name redis2 redis:3.0.6
   
   a8q9dasaafudfs8q8w32udass
   
   $ docker service ls
   
   ID            NAME    MODE        REPLICAS  IMAGE
   dmu1ept4cxcf  redis   replicated  1/1       redis:3.0.6
   a8q9dasaafud  redis2  global      1/1       redis:3.0.6

.. Create a service using an image on a private registry
.. _service_create-create-a-service-using-an-image-on-a-private-registry:
プライベート・レジストリ上にあるイメージを使ってサービスを作成
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. If your image is available on a private registry which requires login, use the --with-registry-auth flag with docker service create, after logging in. If your image is stored on registry.example.com, which is a private registry, use a command like the following:

イメージがログインを必要とするプライベート・レジストリ上にある場合、 ``docker service create`` に ``--with-registry-auth`` フラグを使い、その後にログインします。イメージが ``registry.example.com`` というプライベート・レジストリに保管されている場合、次のようなコマンドを実行します。

.. code-block:: bash

   $ docker login registry.example.com
   
   $ docker service  create \
     --with-registry-auth \
     --name my_service \
     registry.example.com/acme/my_image:latest

.. This passes the login token from your local client to the swarm nodes where the service is deployed, using the encrypted WAL logs. With this information, the nodes are able to log into the registry and pull the image.

これは、ローカルのクライアントからサービスがデプロイされる swam ノードに対し、暗号化 WAL ログを使ってログイントークンを渡します。この情報を使い、ノードはレジストリにログインし、イメージを取得できるようになります。

（以下 ToDo）

.. Parent command

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker service<service>`
     - サービスを管理


.. Related commands

関連コマンド
====================

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker service create<service_create>`
     - 新しいサービスを作成
   * - :doc:`docker service inspect<service_inspect>`
     - 1つまたは複数サービスの詳細情報を表示
   * - :doc:`docker service logs<service_logs>`
     - サービスかタスクのログを取得
   * - :doc:`docker service ls<service_ls>`
     - サービス一覧表示
   * - :doc:`docker service ps<service_ps>`
     - 1つまたは複数タスクの一覧表示
   * - :doc:`docker service rm<service_rm>`
     - 1つまたは複数サービスの削除
   * - :doc:`docker service rollback<service_rollback>`
     - サービス設定の変更を :ruby:`復帰 <rollback>`
   * - :doc:`docker service scale<service_scale>`
     - 1つまたは複数サービスを :ruby:`スケール <scale>`
   * - :doc:`docker service update<service_update>`
     - サービスの更新



.. seealso:: 

   docker service create
      https://docs.docker.com/engine/reference/commandline/service_create/

