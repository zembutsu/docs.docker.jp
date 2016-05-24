.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/up/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/reference/up.md
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/reference/up.md
.. check date: 2016/04/28
.. Commits on Mar 16, 2016 20c29f7e47ade7567ee35f3587790f6235d17d59
.. -------------------------------------------------------------------

.. up

.. _compose-up:

=======================================
up
=======================================

.. code-block:: bash

   使い方: up [オプション] [サービス...]
   
   オプション:
       -d                         デタッチド・モード: バックグラウンドでコンテナを実行し、新しいコンテナ名を表示
                                  --abort-on-container-exit と同時に使えない
       --no-color                 白黒で画面に表示
       --no-deps                  リンクしたサービスを表示しない
       --force-recreate           設定やイメージに変更がなくても、コンテナを再作成する
                                  --no-recreate と同時に使えません
       --no-recreate              コンテナが既に存在していれば、再作成しない
                                  --force-recreate と同時に使えない
       --no-build                 イメージが見つからなくても構築しない
       --build                    コンテナを開始前にイメージを構築する
       --abort-on-container-exit  コンテナが１つでも停止したら全てのコンテナを停止
                                  -d と同時に使えない
       -t, --timeout TIMEOUT      アタッチしている、あるいは既に実行中のコンテナを
                                  停止する時のタイムアウト秒数を指定 (デフォルト:10 )
       --remove-orphans           Compose ファイルで定義されていないサービス用のコンテナを削除

.. Builds, (re)creates, starts, and attaches to containers for a service.

サービス用のコンテナの構築、作成、起動、アタッチを行います。

.. Unless they are already running, this command also starts any linked services.

既に実行している場合は、このコマンドによってリンクされているサービスも起動します。

.. The docker-compose up command aggregates the output of each container. When the command exits, all containers are stopped. Running docker-compose up -d starts the containers in the background and leaves them running.

``docker-compose up`` コマンドは各コンテナの出力を統合します。コマンドを終了（exit）すると、全てのコンテナを停止します。 ``docker-compose up -d`` で実行すると、コンテナをバックグラウンドで起動し、実行し続けます。

.. If there are existing containers for a service, and the service’s configuration or image was changed after the container’s creation, docker-compose up picks up the changes by stopping and recreating the containers (preserving mounted volumes). To prevent Compose from picking up changes, use the --no-recreate flag.

もしサービス用のコンテナが存在している場合、かつ、コンテナを作成後にサービスの設定やイメージを変更している場合は、 ``docker-compose up -d`` を実行すると、 設定を反映するためにコンテナを停止・再作成します（マウントしているボリュームは、そのまま保持します）。Compose が設定を反映させないようにするには、 ``--no-cecreate`` フラグを使います。

.. If you want to force Compose to stop and recreate all containers, use the --force-recreate flag.

もしも Compose で処理時、強制的に全てのコンテナを停止・再作成するには ``--force-recreate`` フラグを使います。

.. seealso:: 

   up
      https://docs.docker.com/compose/reference/up/
