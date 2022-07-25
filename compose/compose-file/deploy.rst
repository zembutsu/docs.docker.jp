.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/compose-file/deploy/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/compose/compose-file/deploy.md
.. check date: 2022/07/23
.. Commits on Apr 27, 2022 d4616a7fdea35d640904057a4ad38f93e4cf0622
.. -------------------------------------------------------------------

.. Compose file deploy reference
.. _compose-file-deploy-reference:

==============================
Compose ファイル展開リファレンス
==============================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Compose specification is a platform-neutral way to define multi-container applications. A Compose implementation supporting deployment of application model MAY require some additional metadata as the Compose application model is way too abstract to reflect actual infrastructure needs per service, or lifecycle constraints.

Compose 仕様とは、複数のコンテナアプリケーションを定義するための、プラットフォームに中立な手法です。Compose の実装でサポートしているアプリケーションの :ruby:`展開（デプロイ） <deployment>` モデルは、サービスごとに必要となる実際の基盤や、ライフサイクルの制限を反映するには、Compose アプリケーションモデルが抽象的すぎるため、追加のメタデータが必要になる場合が :ruby:`あります <MAY>` 。

.. Compose Specification Deployment allows users to declare additional metadata on services so Compose implementations get relevant data to allocate adequate resources on platform and configure them to match user’s needs.

Compose 仕様のデプロイに従うと、ユーザはサービス上に追加のメタデータを宣言できるようになります。そのため、Compose 実装はプラットフォーム上の適切なリソースから、ユーザが必要とする設定に一致するデータを取得できます。

.. Definitions
.. _compose-spec-deploy-definitions:

定義
==========

.. Compose Specification is extended to support an OPTIONAL deploy subsection on services. This section define runtime requirements for a service.

Compose Specification （仕様）は、サービス上で ``deploy`` （展開/デプロイ）サブセクションをオプションでサポートするように拡張されました。このセクションでは、サービスに対するランタイム要件を定義します。

.. endpoint_mode
.. _compose-spec-endoint_mode:

endpoint_mode
--------------------

.. endpoint_mode specifies a service discovery method for external clients connecting to a service. Default and available values are platform specific, anyway the Compose specification define two canonical values:

``endpoint_mode`` は、外部のクライアントがサービスに接続するための、 :ruby:`サービス ディスカバリ <service discovery>` 手法を指定します。デフォルト値および利用可能な値はプラットフォーム固有ですが、どのような場合でも Compose 仕様では2つの適切な値を定義しています。

..  endpoint_mode: vip: Assigns the service a virtual IP (VIP) that acts as the front end for clients to reach the service on a network. Platform routes requests between the client and nodes running the service, without client knowledge of how many nodes are participating in the service or their IP addresses or ports.

..    endpoint_mode: dnsrr: Platform sets up DNS entries for the service such that a DNS query for the service name returns a list of IP addresses (DNS round-robin), and the client connects directly to one of these.

* ``endpoint_mode: vip`` ：サービスに対して仮想 IP （VIP）を割り当てます。これはクライアントがネットワーク上のサービスに到達可能にするためのエンドポイントとして機能します。プラットフォームはクライアントとノードを実行しているサービス間の :ruby:`経路 <route>` を要求しますが、クライアントはノードが何台かや、適切なサービスや IP アドレスやポートを知らなくても要求できます。
* ``endpoint_mod: dnsrr`` ：プラットフォームはサービスのために DNS エントリをセットアップします。サービス名に対する DNS 問い合わせは、IP アドレス（ DNS ラウンドロビン）のリストを返し、クライアントはそれらの1つに直接接続します。

.. code-block:: yaml

   services:
     frontend:
       image: awesome/webapp
       ports:
         - "8080:80"
       deploy:
         mode: replicated
         replicas: 2
         endpoint_mode: vip

.. labels
.. _compose-spec-deploy-lables:

labels
----------

.. labels specifies metadata for the service. These labels MUST only be set on the service and not on any containers for the service. This assumes the platform has some native concept of “service” that can match Compose application model.

``labels`` はサービスに対してメタデータを指定します。これらのラベルは、サービスに対して「のみ」設定されるだけでなく、サービス用のあらゆるコンテナ「にも」設定されます。これは、プラットフォームが「サービス」という（Compose とは別の）固有の概念を持っていると想定しているためであり、それを Compose アプリケーション モデルと一致できるようにするためです。

.. code-block:: yaml

   services:
     frontend:
       image: awesome/webapp
       deploy:
         labels:
           com.example.description: "This label will appear on the web service"

.. mode
.. _compose-spec-deploy-mode:

mode
----------

.. mode define the replication model used to run the service on platform. Either global (exactly one container per physical node) or replicated (a specified number of containers). The default is replicated.

``mode`` はプラットフォーム上でサービスを実行するために使う複製モデル（レプリケーション モデル）を定義します。 ``global`` （物理ノードごとに1つのコンテナだけ）か ``replicated`` （コンテナの数を指定する）です。デフォルトは ``replicated`` です。

.. code-block:: yaml

   services:
     frontend:
       image: awesome/webapp
       deploy:
         mode: global

.. placement
.. _compose-spec-deploy-placement:

placement
----------

.. placement specifies constraints and preferences for platform to select a physical node to run service containers.

``placement`` はサービス コンテナを実行するプラットフォーム上の物理ノードを選択するための、 :ruby:`制約 <constraint>` や設定を指定します。

.. constraints
.. _compose-sepc-deploy-constraints:

constraints
^^^^^^^^^^^^^^^^^^^^

.. constraints defines a REQUIRED property the platform’s node MUST fulfill to run service container. Can be set either by a list or a map with string values.


``constraints`` は、サービス コンテナを実行するため、プラットフォームのノードが :ruby:`確実に必要としなければいけない <MUST>、 :ruby:`必須 <REQUIRED>` の属性を定義します。リスト形式またはマップ形式の文字列で指定します。

.. code-block:: yaml

   deploy:
     placement:
       constraints:
         - disktype=ssd

.. code-block:: yaml

   deploy:
     placement:
       constraints:
         disktype: ssd

.. preference
.. _compose-spec-deploy-preferences:

preferences
^^^^^^^^^^^^^^^^^^^^

.. preferences defines a property the platform’s node SHOULD fulfill to run service container. Can be set either by a list or a map with string values.

``preferences`` は、サービス コンテナを実行するため、プラットフォームのノードが :ruby:`満たすべき <SHOULD>` 属性を定義します。リスト形式またはマップ形式の文字列で指定します。

.. code-block:: yaml

   deploy:
     placement:
       preferences:
         - datacenter=us-east

.. code-block:: yaml

   deploy:
     placement:
       preferences:
         datacenter: us-east

.. replicas
.. _compose-spec-deploy-replicas:

replicas
----------

.. If the service is replicated (which is the default), replicas specifies the number of containers that SHOULD be running at any given time.

サービスを複製 ``replicated`` （これがデフォルトです）する場合、 ``replicas`` では常に :ruby:`実行すべき <SHOULD>` コンテナの数を指定します。

.. code-block:: yaml

   services:
     frontend:
       image: awesome/webapp
       deploy:
         mode: replicated
         replicas: 6

.. resources
.. _compose-spec-deploy-resources:

resources
----------

.. resources configures physical resource constraints for container to run on platform. Those constraints can be configured as a:

``resources`` 設定は、プラットフォーム上でコンテナを実行するにあたり、物理リソースの制限を設定します。それぞれの制限は、次のようにして設定します。


..  limits: The platform MUST prevent container to allocate more
    reservations: The platform MUST guarantee container can allocate at least the configured amount

* ``limis`` ：プラットフォームは、コンテナに指定した以上の割り当てを防ぐ :ruby:`必要があります <MUST>` 。
* ``reservations`` ：プラットフォームは少なくとも設定した容量をコンテナに対して確実に割り当てる :ruby:`必要があります <MUST>` 。

.. code-block:: yaml

   services:
     frontend:
       image: awesome/webapp
       deploy:
         resources:
           limits:
             cpus: '0.50'
             memory: 50M
             pids: 1
           reservations:
             cpus: '0.25'
             memory: 20M

.. cpus
.. _compose-spec-deploy-:

cpus
^^^^^^^^^^

.. cpus configures a limit or reservation for how much of the available CPU resources (as number of cores) a container can use.

``cpus`` はコンテナが利用できる割り当て可能な CPU リソース（コア数として指定）を、制限または予約する設定をします。

.. memory
.. _compose-spec-deploy-memory:

memory
^^^^^^^^^^

.. memory configures a limit or reservation on the amount of memory a container can allocate, set as a string expressing a byte value.

``memory`` コンテナが割り当て可能なメモリ容量を、制限または予約する設定をします。設定は :ref:`バイト値 <compose-spec-specifying-byte-values>` の文字列で表します。

.. pids
.. _compose-spec-deploy-pids:

pids
^^^^^^^^^^

.. pids tunes a container’s PIDs limit, set as an integer.

``pid`` はコンテナの PID 上限を調整するために、整数値で設定します。

.. devices
.. _compose-spec-deploy-devices:

devices
^^^^^^^^^^

.. devices configures reservations of the devices a container can use. It contains a list of reservations, each set as an object with the following parameters: capabilities, driver, count, device_ids and options.

``devices`` はコンテナが利用できるデバイスの予約を設定します。予約リストの中にある場合、以下のパラメータで各オブジェクトを設定できます： ``capabilities`` 、 ``drievr`` 、 ``count`` 、 ``device_ids`` 、 ``options`` です。

.. Devices are reserved using a list of capabilities, making capabilities the only required field. A device MUST satisfy all the requested capabilities for a successful reservation.

デバイスは capabilities のリストを使って予約するために、 ``capabilities`` のフィールドのみが飛鳥です。予約が成功するためには、デバイスが全ての必要な capabilities を満たす :ruby:`必要があります <MUST>` 。

.. capabilities
.. _compose-spec-deploy-capabilities:

capabilities
````````````````````

.. capabilities are set as a list of strings, expressing both generic and driver specific capabilities. The following generic capabilities are recognized today:

``capabilities`` はリストまたは文字列で設定し、一般的なケーパビリティとドライバ固有のケーパビリティの両方で表せます。現時点では、以下の一般的なケーパビリティを認識します。

..  gpu: Graphics accelerator
    tpu: AI accelerator

* ``gpu`` ：グラフィクス アクセラレータ
* ``tpu`` ：AI アクセラレータ

.. To avoid name clashes, driver specific capabilities MUST be prefixed with the driver name. For example, reserving an nVidia CUDA-enabled accelerator might look like this:

名前の衝突を避けるため、ドライバ固有のケーパビリティには、ドライバ名をプレフィクスとして指定する :ruby:`必要があります <MUST>` 。たとえば、 nVidia CUDA で有効なアクセラレータを予約するには、次のようにします。

.. code-block:: yaml

   deploy:
     resources:
       reservations:
         devices:
           - capabilities: ["nvidia-compute"]

.. driver
.. _compose-spec-deploy-driver:

driver
``````````

.. A different driver for the reserved device(s) can be requested using driver field. The value is specified as a string.

デバイスの予約には、 ``driver`` フィールドを使って異なるドライバを要求できます。この値は、文字として指定します。

.. code-block:: yaml

   deploy:
     resources:
       reservations:
         devices:
           - capabilities: ["nvidia-compute"]
             driver: nvidia

.. count
.. _compose-spec-deploy-count:

count
``````````

.. If count is set to all or not specified, Compose implementations MUST reserve all devices that satisfy the requested capabilities. Otherwise, Compose implementations MUST reserve at least the number of devices specified. The value is specified as an integer.

``count`` を ``all`` にするか指定がない場合、 Compose 実装は要求したケーパビリティを満たすドライバすべてを予約する :ruby:`必要があります <MUST>` 。そうでない場合には、 Compose 実装は、少なくても指定された数のデバイスを予約する必要があります。値は整数値で指定します。

.. code-block:: yaml

   deploy:
     resources:
       reservations:
         devices:
           - capabilities: ["tpu"]
             count: 2

.. count and device_ids fields are exclusive. Compose implementations MUST return an error if both are specified.

``count`` と ``device_ids`` フィールドは :ruby:`どちらか片方しか使えません <exclusive>` 。Compose 実装は両方が指定された場合にエラーを返す :ruby:`必要があります <MUST>` 。

.. device_ids
.. _compose-spec-deploy-device_ids:

device_ids
``````````

.. If device_ids is set, Compose implementations MUST reserve devices with the specified IDs providing they satisfy the requested capabilities. The value is specified as a list of strings.

``device_ids`` が指定された場合、Compose 実装は、要求したケーパビリティを満たし、指定した ID を提供するデバイスを予約する :ruby:`必要があります <MUST>` 。値は文字列のリストとして指定します。

.. code-block:: yaml

   deploy:
     resources:
       reservations:
         devices:
           - capabilities: ["gpu"]
             device_ids: ["GPU-f123d1c9-26bb-df9b-1c23-4a731f61d8c7"]

.. count and device_ids fields are exclusive. Compose implementations MUST return an error if both are specified.

``count`` と ``device_ids`` フィールドは :ruby:`どちらか片方しか使えません <exclusive>` 。Compose 実装は両方が指定された場合にエラーを返す :ruby:`必要があります <MUST>` 。


.. options
.. _compose-spec-deploy-options:

options
``````````

.. Driver specific options can be set with options as key-value pairs.

ドライバのオプションは、 ``options`` でキーバリューのペアとして設定できます。

.. code-block:: yaml

   deploy:
     resources:
       reservations:
         devices:
           - capabilities: ["gpu"]
             driver: gpuvendor
             options:
               virtualization: false

.. restart_policy
.. _compose-spec-deploy-restart_policy:

restart_policy
--------------------

.. restart_policy configures if and how to restart containers when they exit. If restart_policy is not set, Compose implementations MUST consider restart field set by service configuration.

``restart_policy`` はコンテナが終了した場合、どのように再起動するかを指定します。 ``restart_policy`` の指定がなければ、 Compose 実装はサービス設定で ``restart`` フィールドが設定されているとみなす :ruby:`必要があります <MUST>` 。

..  condition: One of none, on-failure or any (default: any).
    delay: How long to wait between restart attempts, specified as a duration (default: 0).
    max_attempts: How many times to attempt to restart a container before giving up (default: never give up). If the restart does not succeed within the configured window, this attempt doesn’t count toward the configured max_attempts value. For example, if max_attempts is set to ‘2’, and the restart fails on the first attempt, more than two restarts MUST be attempted.
    window: How long to wait before deciding if a restart has succeeded, specified as a duration (default: decide immediately).

* ``condition`` ： ``noen`` 、 ``on-failure`` 、 ``any11 のどれか1つです（デフォルト： ``any`` ）
* ``delay`` ：再起動を試みるまで待機する時間を :ref:`期間 <compose-spec-specifying-duration>`で指定します（デフォルト：0）。
* ``max_attemps`` ：コンテナ再起動を中断するまで、何度試みるかを設定します（デフォルト：諦めません）。設定した ``window`` （期間）で再起動が成功しない場合、試行は設定された ``max_attempts`` 値として数えません。たとえば、 ``max_attempts` を ``2`` に指定すると、最初の試行で再起動に失敗したとしても、少なくとも2回目を試行する :ruby:`必要があります <MUST>` 。
* `window``` ：再起動が成功したと判断するまで待機する時間を :ref:`期間 <compose-spec-specifying-duration>`で指定します（デフォルト：即時）。

.. code-block:: yaml

   deploy:
        restart_policy:
          condition: on-failure
          delay: 5s
          max_attempts: 3
          window: 120s

.. rollback_config
.. _compose-spec-rollback_config:

rollback_config
--------------------

.. rollback_config configures how the service should be rollbacked in case of a failing update.

``rollback_config`` は、更新に失敗した場合、サービスをどのようにロールバックするかを設定します。

..  parallelism: The number of containers to rollback at a time. If set to 0, all containers rollback simultaneously.
    delay: The time to wait between each container group’s rollback (default 0s).
    failure_action: What to do if a rollback fails. One of continue or pause (default pause)
    monitor: Duration after each task update to monitor for failure (ns|us|ms|s|m|h) (default 0s).
    max_failure_ratio: Failure rate to tolerate during a rollback (default 0).
    order: Order of operations during rollbacks. One of stop-first (old task is stopped before starting new one), or start-first (new task is started first, and the running tasks briefly overlap) (default stop-first).

* ``parallelism`` ：同時にコンテナをロールバックする数です。 0 を指定すると、全コンテナのロールバックを一斉に行います。
* ``delay`` ：各コンテナのグループがロールバックするまで待機する時間です（デフォルトは 0s）。
* ``failure_action`` ：ロールバックに失敗した場合にどうするか設定します。 ``continue`` か ``pause`` のどちらかです（デフォルトは ``pause`` ）。
* ``monitor`` ：各タスクのロールバックが失敗するまで監視する期間です（ ``ns|us|ms|s|m|h`` ）（デフォルトは 0s）。
* ``max_failure_ratio`` ：ロールバック中に許容される失敗の割合（デフォルトは 0）。
* ``order`` ：ロールバック中に処理する順番。 ``stop-first`` （古いタスクを停止してから、新しいタスクを開始）、 ``start-first`` （まず新しいタスクを起動するため、実行中のタスクが瞬間的に重複）のどちらかです。（デフォルトは ``stop-first`` ）

.. update_config
.. _compose-spec-update_config:

update_config
--------------------

.. update_config configures how the service should be updated. Useful for configuring rolling updates.

``update_config`` は、どのようにしてサービスを更新すべきか設定します。ローリングアップデートの設定に役立ちます。

..  parallelism: The number of containers to update at a time.
    delay: The time to wait between updating a group of containers.
    failure_action: What to do if an update fails. One of continue, rollback, or pause (default: pause).
    monitor: Duration after each task update to monitor for failure (ns|us|ms|s|m|h) (default 0s).
    max_failure_ratio: Failure rate to tolerate during an update.
    order: Order of operations during updates. One of stop-first (old task is stopped before starting new one), or start-first (new task is started first, and the running tasks briefly overlap) (default stop-first).

* ``parallelism`` ：同時にコンテナを更新する数です。
* ``delay`` ：各コンテナのグループが更新するまで待機する時間です。
* ``failure_action`` ：更新に失敗した場合にどうするか設定します。 ``continue`` か ``pause`` のどちらかです（デフォルトは ``pause`` ）。
* ``monitor`` ：各タスク更新が失敗するまで監視する期間です（ ``ns|us|ms|s|m|h`` ）（デフォルトは 0s）。
* ``max_failure_ratio`` ：更新中に許容される失敗の割合。
* ``order`` ：更新中に処理する順番。 ``stop-first`` （古いタスクを停止してから、新しいタスクを開始）、 ``start-first`` （まず新しいタスクを起動するため、実行中のタスクが瞬間的に重複）のどちらかです。（デフォルトは ``stop-first`` ）

.. code-block:: yaml

   deploy:
     update_config:
       parallelism: 2
       delay: 10s
       order: stop-first

.. seealso:: 

   Compose file deploy reference
      https://docs.docker.com/compose/compose-file/deploy/
