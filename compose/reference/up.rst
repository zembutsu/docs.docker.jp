.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/up/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/reference/up.md
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/reference/up.md
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/compose/reference/up.md
.. check date: 2022/04/09
.. Commits on Jan 28, 2022 b6b19516d0feacd798b485615ebfee410d9b6f86
.. -------------------------------------------------------------------

.. docker-compose up

.. _docker-compose-up:

=======================================
docker-compose up
=======================================

.. code-block:: bash

   使い方: docker-compose up [オプション] [--scale サービス=数...] [サービス...]
   
   オプション:
     -d, --detach               デタッチド・モード: バックグラウンドでコンテナを実行し、新しいコンテナ名を表示
                                 --abort-on-container-exit と同時に使えない
      --no-color                 白黒で画面に表示
      --quiet-pull              進捗情報を表示しない
      --no-deps                  リンクしたサービスを起動しない
      --force-recreate           設定やイメージに変更がなくても、コンテナを再作成する
                                --no-recreate と同時に使えません
      --always-recreate-deps    依存関係のあるコンテナを再作成
                                --no-recreate と同時に使えません
      --no-recreate              コンテナが既に存在していれば、再作成しない
                                 --force-recreate と同時に使えない
      --no-build                 イメージが見つからなくても構築しない
      --no-start                 作成してもサービスを起動しない
      --build                    コンテナを開始前にイメージを構築する
      --abort-on-container-exit  コンテナが１つでも停止したら全てのコンテナを停止
                                 -d と同時に使えない
      --attach-dependencies      依存するコンテナにアタッチ
      -t, --timeout TIMEOUT      アタッチしている、あるいは既に実行中のコンテナを
                                 停止する時のタイムアウト秒数を指定 (デフォルト:10 )
     -V, --renew-anon-volumes   以前のコンテナからデータを再利用せず、匿名ボリュームの再作成
      --remove-orphans           Compose ファイルで定義されていないサービス用のコンテナを削除
      --exit-code-from SERVICE   指定されたサービスコンテナの終了コードを返す
                                 --abort-on-container-exit の指定を暗に含む
      --scale SERVICE=NUM        SERVICE のインスタンス数を NUM とする
                                 Compose ファイルに scale の設定があっても上書きされる


.. Builds, (re)creates, starts, and attaches to containers for a service.

サービス用のコンテナを構築、作成、起動、アタッチします。

.. Unless they are already running, this command also starts any linked services.

リンクされているサービスがまだ起動していない場合は、それらも起動します。

.. The docker-compose up command aggregates the output of each container (essentially running docker-compose logs --follow). When the command exits, all containers are stopped. Running docker-compose up --detach starts the containers in the background and leaves them running.

``docker-compose up`` コマンドでは、各コンテナの出力を統合します（実質的には ``docker-compose up --follow`` の実行です）。コマンドから :ruby:`抜ける <exit>` と、コンテナは全て停止します。 ``docker-compose up --detach`` を実行すると、コンテナはバックグランドで起動し、そのまま実行し続けます。

.. If there are existing containers for a service, and the service’s configuration or image was changed after the container’s creation, docker-compose up picks up the changes by stopping and recreating the containers (preserving mounted volumes). To prevent Compose from picking up changes, use the --no-recreate flag.

もしサービス用のコンテナが存在している場合、かつ、コンテナを作成後にサービスの設定やイメージを変更している場合は、 ``docker-compose up -d`` を実行すると、 設定を反映するためにコンテナを停止・再作成します（マウントしているボリュームは、そのまま保持します）。Compose が設定を反映させないようにするには、 ``--no-recreate`` フラグを使います。

.. If you want to force Compose to stop and recreate all containers, use the --force-recreate flag.

コンテナすべてを強制的に停止および再生成するには ``--force-recreate`` フラグを指定します。

.. If the process encounters an error, the exit code for this command is 1.

処理でエラーが発生した場合、対象コマンドの終了コードは ``1`` です。

.. If the process is interrupted using SIGINT (ctrl + C) or SIGTERM, the containers are stopped, and the exit code is 0.

プロセスが ``SIGINT`` （ ``ctrl`` + ``C`` ）や ``SIGTERM`` で中断した場合、コンテナは停止し、終了コードは ``0`` です。

.. If SIGINT or SIGTERM is sent again during this shutdown phase, the running containers are killed, and the exit code is 2.

シャットダウン段階の途中で ``SIGINT`` や ``SIGTERM`` を再送信すると、実行中のコンテナは :ruby:`停止 <kill>` され、終了コードは ``2`` になります。

.. seealso:: 

   docker-compose up
      https://docs.docker.com/compose/reference/up/

