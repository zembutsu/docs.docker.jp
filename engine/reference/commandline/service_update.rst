.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/service_update/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/service_update.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/service_update.md
.. check date: 2016/06/21
.. Commits on Jun 20, 2016 daedbc60d61387cb284b871145b672006da1b6de
.. -------------------------------------------------------------------

.. service update

.. _reference-service-update:

=======================================
service update
=======================================

.. code-block:: bash

   使い方:  docker service update [オプション] サービス
   
   サービスを更新します。
   
   オプション:
         --arg value                    サービスのコマンド引数 (デフォルト [])
         --command value                サービス・コマンド (デフォルト [])
         --constraint value             制約（constraint）の場所  (デフォルト [])
         --endpoint-mode string         エンドポイント・モード(有効な値: VIP, DNSRR)
     -e, --env value                    環境変数を指定 (デフォルト [])
         --help                         使い方の表示
         --image string                 サービスのイメージとタグ
     -l, --label value                  サービスのラベル (デフォルト [])
         --limit-cpu value              CPU 上限 (デフォルト 0.000)
         --limit-memory value           メモリ上限 (デフォルト 0 B)
         --mode string                  サービス・モード (replicated か global) (デフォルト "replicated")
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

.. Updates a service as described by the specified parameters. This command has to be run targeting a manager node. The parameters are the same as docker service create. Please look at the description there for further information.

パラメータで指定を記述した通りに、サービスを更新します。このコマンドの実行対象はマネージャ・ノードです。各パラメータは ``docker service create`` と同じです。より詳しい情報は、それぞれの説明をご覧ください。

.. Examples

例
==========

.. Update a service

サービスを更新します。

.. code-block:: bash

   $ docker service update --limit-cpu 2 redis 

関連情報
----------

* :doc:`service_create`
* :doc:`service_inspect`
* :doc:`service_ls`
* :doc:`service_rm`
* :doc:`service_scale`
* :doc:`service_tasks`

.. seealso:: 

   service update
      https://docs.docker.com/engine/reference/commandline/service_update/

