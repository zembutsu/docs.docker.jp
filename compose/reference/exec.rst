.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/exec/
.. -------------------------------------------------------------------

.. title: docker-compose exec

.. _docker-compose-exec:

=======================================
docker-compose exec
=======================================

.. ```
   Usage: exec [options] [-e KEY=VAL...] SERVICE COMMAND [ARGS...]

   Options:
       -d, --detach      Detached mode: Run command in the background.
       --privileged      Give extended privileges to the process.
       -u, --user USER   Run the command as this user.
       -T                Disable pseudo-tty allocation. By default `docker-compose exec`
                         allocates a TTY.
       --index=index     index of the container if there are multiple
                         instances of a service [default: 1]
       -e, --env KEY=VAL Set environment variables (can be used multiple times,
                         not supported in API < 1.25)
       -w, --workdir DIR Path to workdir directory for this command.
   ```
::

   利用方法: exec [オプション] [-e KEY=VAL...] SERVICE COMMAND [ARGS...]
   
   オプション:
       -d, --detach      デタッチモード。コマンドをバックグラウンドで実行します。
       --privileged      プロセスに対して拡張された権限を与えます。
       -u, --user USER   指定されたユーザによりコマンドを実行します。
       -T                擬似 TTY への割り当てを無効にします。 デフォルトにおいて
                         `docker-compose exec` には TTY が割り当てられます。
       --index=index     サービスのインスタンスが複数ある場合に、そのコンテナの
                         インデックスを指定します。[デフォルト: 1]
       -e, --env KEY=VAL 環境変数を設定します。
                         (複数の設定が可能。API 1.25 未満ではサポートされていません。)
       -w, --workdir DIR このコマンドのワークディレクトリのパスを指定します。

.. This is the equivalent of `docker exec`. With this subcommand you can run arbitrary
   commands in your services. Commands are by default allocating a TTY, so you can
   use a command such as `docker-compose exec web sh` to get an interactive prompt.

このコマンドは ``docker exec`` と同じです。
このサブコマンドを使って、サービスに対する任意のコマンドを実行することができます。
コマンドはデフォルトでは TTY が割り当てられます。
したがって ``docker-compose exec web sh`` のようなコマンドを実行すると、対話可能なプロンプトを用いることができます。


.. seealso:: 

   docker-compose exec
      https://docs.docker.com/compose/reference/exec/
