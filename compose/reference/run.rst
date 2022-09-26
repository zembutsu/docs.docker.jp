.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/run/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/reference/run.md
   doc version: 1.13
      https://github.com/docker/compose/commits/master/docs/reference/run.md
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/compose/reference/run.md
.. check date: 2022/04/09
.. Commits on Jan 28, 2022 b6b19516d0feacd798b485615ebfee410d9b6f86
.. -------------------------------------------------------------------

.. dokcer-compose run
.. _docker-compose-run:

=======================================
docker-compose run
=======================================

.. code-block:: bash

   使い方: 
       docker-compose run [オプション] [-v ボリューム...] [-p ポート...] [-e KEY=VAL...] [-l KEY=VALUE...]
        サービス [コマンド] [引数...]
   
   オプション:
    -d, --detach            デタッチド・モード: コンテナをバックグラウンドで実行し、新しいコンテナ名を表示
      --name NAME           コンテナに名前を割り当て
      --entrypoint CMD      イメージのエントリーポイントを上書き
      -e KEY=VAL            環境変数を指定 (複数回指定できる)
      -l, --label KEY=VAL   ラベルの追加または上書き (複数回指定できる)
      -u, --user=""         実行時のユーザ名または uid を指定
      --no-deps             リンクしたサービスを起動しない
      --rm                  コンテナ実行後に削除。デタッチド・モードの場合は無視
      -p, --publish=[]      コンテナのポートをホスト側に公開
      --service-ports       サービス用のポートを有効化し、ホスト側に割り当て可能にする
      --use-aliases         コンテナが接続するネットワークで、ネットワークでのサービス名エイリアス（別名）を使う
      -v, --volume=[]       ボリュームのバインドマウント（デフォルト []）
      -T                    疑似ターミナル (pseudo-tty) 割り当てを無効化。デフォルトの `docker-compose run` は TTY を割り当て
      -w, --workdir=""      コンテナ内の作業ディレクトリを指定


.. Runs a one-time command against a service. For example, the following command starts the web service and runs bash as its command.

サービスに対して１回コマンドを実行します。たとえば、次のコマンドは ``web`` サービスを開始するためのコマンドで、サービス内で ``bash`` としてコマンドを実行します。

.. code-block:: bash

   docker-compose run web bash

.. Commands you use with run start in new containers with configuration defined by that of the service, including volumes, links, and other details. However, there are two important differences.

``run`` コマンドを使うと、設定ファイルで定義された通りに、サービスとして新しいコンテナを開始します。また、定義されているボリューム、リンク、その他の詳細も持ちます。しかし、ここでは２つの重要な違いがあります。

.. First, the command passed by run overrides the command defined in the service configuration. For example, if the web service configuration is started with bash, then docker-compose run web python app.py overrides it with python app.py.

１つは、 ``run`` コマンドの指定は、サービス設定ファイル上での定義を上書きします。たとえば、 ``web`` サービスは ``bash`` で開始する設定だとしても、 ``docker-compose run web python app.py`` を実行すると、 ``python app.py`` で上書きします。

.. The second difference is that the docker-compose run command does not create any of the ports specified in the service configuration. This prevents port collisions with already-open ports. If you do want the service’s ports to be created and mapped to the host, specify the --service-ports flag:

２つめの違いとして、 ``docker-compose run`` コマンドはサービス設定ファイルで指定したポートを作成しません。これは、既に開いているポートとの衝突を避けるためです。サービス用のポートを作成し、ホスト側に割り当てるには、 ``--service-ports`` フラグを使います。

.. code-block:: bash

   docker-compose run --service-ports web python manage.py shell

.. Alternatively, manual port mapping can be specified with the --publish or -p options, just as when using docker run:

別の方法として、手動でポートの割り当てを設定することも可能です。Docker で ``run`` コマンドを使う時と同様に、 ``--publish`` または ``-p`` オプションを使うだけです。

.. code-block:: bash

   docker-compose run --publish 8080:80 -p 2022:22 -p 127.0.0.1:2021:21 web python manage.py shell

.. If you start a service configured with links, the run command first checks to see if the linked service is running and starts the service if it is stopped. Once all the linked services are running, the run executes the command you passed it. For example, you could run

リンク機能を使ってサービスを開始する場合、 ``run`` コマンドはリンク先のサービスが実行中かどうかをまず確認し、サービスが停止していれば起動します。全てのリンク先のサービスが起動したら、指定したコマンドで ``run`` 命令が実行されます。たとえば、次のように実行できます。

.. code-block:: bash

   docker-compose run db psql -h db -U docker

.. This opens an interactive PostgreSQL shell for the linked db container.

これはリンクしている ``db`` コンテナに対して、PostgreSQL シェルで操作をします。

.. If you do not want the run command to start linked containers, use the --no-deps flag:

``run`` コマンドを実行するとき、リンクしているコンテナを起動したくない場合は ``--no-deps`` フラグを使います。

.. code-block:: bash

   docker-compose run --no-deps web python manage.py shell

.. If you want to remove the container after running while overriding the container’s restart policy, use the --rm flag:

コンテナの再起動ポリシーを上書きし、コンテナの実行後に削除したい場合は ``--rm`` フラグを使います。

.. code-block:: bash

    docker-compose run --rm web python manage.py db upgrade

.. This runs a database upgrade script, and removes the container when finished running, even if a restart policy is specified in the service configuration.

このデータベース更新スクリプトを実行すると、サービス設定で再起動ポリシーが指定されていたとしても、処理の実行が終了したらコンテナを削除します。

.. seealso:: 

   docker-compose run
      https://docs.docker.com/compose/reference/run/
