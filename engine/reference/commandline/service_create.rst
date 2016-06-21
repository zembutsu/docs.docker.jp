.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/service_create/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/service_create.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/service_create.md
.. check date: 2016/06/21
.. Commits on Jun 20, 2016 daedbc60d61387cb284b871145b672006da1b6de
.. -------------------------------------------------------------------

.. service craete

.. _reference-service-create:

=======================================
service create
=======================================

.. code-block:: bash

   使い方:  docker service create [オプション] イメージ [コマンド] [引数...]
   
   新しいサービスの作成（create）
   
   オプション:
         --constraint value             制約（constraints）の設定 (デフォルト [])
         --endpoint-mode string         エンドポイント・モード(有効な値: VIP, DNSRR)
     -e, --env value                    環境変数の設定 (デフォルト [])
         --help                         使い方の表示
     -l, --label value                  サービス・ラベル (デフォルト [])
         --limit-cpu value              CPU 上限 (デフォルト 0.000)
         --limit-memory value           メモリ上限 (デフォルト 0 B)
         --mode string                  サービス・モード (replicated または global) (デフォルト "replicated")
     -m, --mount value                  サービスに対するマウントをアタッチ
         --name string                  サービス名
         --network value                ネットワークのアタッチ (デフォルト [])
     -p, --publish value                ノード・ポートとしてポートを公開 (デフォルト [])
         --replicas value               タスク数 (デフォルト none)
         --reserve-cpu value            リザーブ CPU (デフォルト 0.000)
         --reserve-memory value         リザーブ・メモリ (デフォルト 0 B)
         --restart-condition string     状況変更時に再起動 (none, on_failure,  any)
         --restart-delay value          再起動を試みるまでの遅延 (デフォルト none)
         --restart-max-attempts value   再起動を諦める最大数 (デフォルト none)
         --restart-window value         再起動ポリシーの評価に使うウインドウ (デフォルト none)
         --stop-grace-period value      強制的にコンテナを kill するまで待つ時間 (デフォルト none)
         --update-delay duration        更新までの遅延
         --update-parallelism uint      同時更新する最大タスク数
     -u, --user string                  ユーザ名か UID
     -w, --workdir string               コンテナ内のワーキング（作業用）・ディレクトリ

.. Creates a service as described by the specified parameters. This command has to be run targeting a manager node.

パラメータで指定を記述した通りに、サービスを作成します。このコマンドの実行対象はマネージャ・ノードです。

.. Examples

例
==========

.. Create a service

サービスの作成
--------------------


.. code-block:: bash

   $ docker service create --name redis redis:3.0.6
   dmu1ept4cxcfe8k8lhtux3ro3
   
   $ docker service ls
   ID            NAME   REPLICAS  IMAGE        COMMAND
   dmu1ept4cxcf  redis  1/1       redis:3.0.6

.. Create a service with 5 tasks

５つのタスクを持つサービスの作成
----------------------------------------

.. You can set the number of tasks for a service using the --replicas option. The following command creates a redis service with 5 tasks:

サービス用のタスク数を ``--replicas`` オプションで指定できます。次のコマンドは ``5`` つのタスクを持つ ``redis`` サービスを作成します。

.. code-block:: bash

   $ docker service create --name redis --replicas=5 redis:3.0.6
   4cdgfyky7ozwh3htjfw0d12qv

.. The above command sets the desired number of tasks for the service. Even though the command returns directly, actual scaling of the service may take some time. The REPLICAS column shows both the actual and desired number of tasks for the service.

このコマンドはサービス用タスクの期待数（desired number）を指定します。コマンド実行はすぐに応答しますが（戻りますが）、実際にサービスがスケールするには時間がかかるでしょう。 ``REPLICAS`` （レプリカ）列に表示されるのは、サービス用タスクの実際の数と期待数です。

.. In the following example, the desired number of tasks is set to 5, but the actual number is 3

この例では、タスクの期待数を ``5`` に指定しましたが、実際の数は ``3`` です。

.. code-block:: bash

   $ docker service ls
   ID            NAME    REPLICAS  IMAGE        COMMAND
   4cdgfyky7ozw  redis   3/5       redis:3.0.7

.. Once all the tasks are created, the actual number of tasks is equal to the desired number:

すべてのタスクを作成したら、実際の数は期待数と同じになります。

.. code-block:: bash

   $ docker service ls
   ID            NAME    REPLICAS  IMAGE        COMMAND
   4cdgfyky7ozw  redis   5/5       redis:3.0.7

.. Create a service with a rolling update constraints

ローリング・アップデート制約を持つサービスの作成
--------------------------------------------------

.. code-block:: bash

   $ docker service create \
     --replicas 10 \
     --name redis \
     --update-delay 10s \
     --update-parallelism 2 \
     redis:3.0.6

.. When this service is updated, a rolling update will update tasks in batches of 2, with 10s between batches.

このサービスを :doc:`更新時 <service_update>` 、ローリング・アップデートはタスクを ``2`` つの束（バッチ）に分け、束の更新間隔を ``10s`` （10秒）にします。

.. Setting environment variables (-e --env)

環境変数の指定（ ``-e --env`` ）
----------------------------------------

.. This sets environmental variables for all tasks in a service. For example:

サービス内の全てのタスク用の環境変数を指定します。例：

.. code-block:: bash

   $ docker service create --name redis_2 --replicas 5 --env MYVAR=foo redis:3.0.6

.. Set metadata on a service (-l --label)

サービスのメタデータを指定（ ``-l --label`` ）
--------------------------------------------------

.. A label is a key=value pair that applies metadata to a service. To label a service with two labels:

ラベルとは ``キー=値`` のペアでアリ、サービス用のメタデータを指定します。サービスに２つのラベルを指定するには、次のようにします。

.. code-block:: bash

   $ docker service create \
     --name redis_2 \
     --label com.example.foo="bar"
     --label bar=baz \
     redis:3.0.6

.. For more information about labels, refer to apply custom metadata

ラベルに関するより詳しい情報は、 :doc:`/engine/userguide/labels-custom-metadata` をご覧ください。

.. Service mode

サービス・モード
--------------------

.. Is this a replicated service or a global service. A replicated service runs as many tasks as specified, while a global service runs on each active node in the swarm.

複製サービス（replicated service）かグローバル・サービス（global service）です。複製サービスは指定した数のタスクを実行するのに対し、グローバル・サービスは swarm 上の各アクティブ・ノード上で実行します。

.. The following command creates a "global" service:

次のコマンドは「グローバル」サービスを作成します。

.. code-block:: bash

   $ docker service create --name redis_2 --mode global redis:3.0.6



関連情報
----------

* :doc:`service_inspect`
* :doc:`service_ls`
* :doc:`service_rm`
* :doc:`service_scale`
* :doc:`service_tasks`
* :doc:`service_update`

.. seealso:: 

   service create
      https://docs.docker.com/engine/reference/commandline/service_create/

