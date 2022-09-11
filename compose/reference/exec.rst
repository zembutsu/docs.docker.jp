.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/exec/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/compose/reference/exec.md
.. check date: 2022/04/08
.. Commits on Jan 28, 2022 b6b19516d0feacd798b485615ebfee410d9b6f86
.. -------------------------------------------------------------------

.. docker-compose exec
.. _docker-compose-exec:

=======================================
docker-compose exec
=======================================


.. code-block:: bash

   使い方: exec [オプション] [-e KEY=VAL...] サービス コマンド [引数...]
   
   オプション:
       -d, --detach      デタッチモード。コマンドをバックグラウンドで実行
       --privileged      プロセスに対して拡張された権限を与える
       -u, --user USER   指定されたユーザによりコマンドを実行
       -T                擬似 TTY への割り当てを無効化。 デフォルトでは `docker-compose exec` には TTY が割り当て
       --index=index     サービスのインスタンスが複数ある場合に、そのコンテナの
                         インデックスを指定 [デフォルト: 1]
       -e, --env KEY=VAL 環境変数を設定
                         (複数の設定が可能。API 1.25 未満ではサポートされていない)
       -w, --workdir DIR このコマンドの作業ディレクトリのパスを指定します。

.. This is the equivalent of docker exec. With this subcommand you can run arbitrary commands in your services. Commands are by default allocating a TTY, so you can use a command such as docker-compose exec web sh to get an interactive prompt.

このコマンドは ``docker exec`` と同じです。このサブコマンドを使い、サービスに対して任意のコマンドを実行できます。コマンドにはデフォルトでは TTY が割り当てられるため、 ``docker-compose exec web sh`` のようなコマンドを実行すると、双方向のプロンプトが利用できます。


.. seealso:: 

   docker-compose exec
      https://docs.docker.com/compose/reference/exec/
