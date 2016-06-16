.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/update/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/update.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/update.md
.. check date: 2016/06/16
.. Commits on Feb 20, 2016 ff3ea4c90f2ede5cccc6b49c4d2aad7201c91a4c
.. -------------------------------------------------------------------

.. update

=======================================
update
=======================================

.. code-block:: bash

   使い方: docker update [オプション] コンテナ [コンテナ...]
   
   １つまたは複数のコンテナの設定を更新
   
     --help=false               使い方を表示
     --blkio-weight=0           ブロック IO (相対ウエイト)、10 ～ 1000 の間
     --cpu-shares=0             CPU 共有 (相対ウエイト)
     --cpu-period=0             CPU CFS (Completely Fair Scheduler) の上限値
     --cpu-quota=0              CPU CFS (Completely Fair Scheduler) の上限クォータ
     --cpuset-cpus=""           処理を許可する CPU を指定 (0-3, 0,1)
     --cpuset-mems=""           実行を許可するメモリ・ノード (MEMs) を指定 (0-3, 0,1)
     -m, --memory=""            メモリ上限
     --memory-reservation=""    メモリのソフト上限
     --memory-swap=""           整数値はメモリスワップの追加。 -1 はスワップを無制限に有効
     --kernel-memory=""         Kernel メモリ上限: コンテナは必ず停止
     --restart                  コンテナ再起動時の再起動ポリシーを指定

.. The docker update command dynamically updates container configuration. You can use this command to prevent containers from consuming too many resources from their Docker host. With a single command, you can place limits on a single container or on many. To specify more than one container, provide space-separated list of container names or IDs.

``docker update`` コマンドはコンテナの設定を動的に更新します。このコマンドを使えば、Docker ホスト上でコンテナが多くのリソースを消費するの防ぎます。コマンドを１度実行するだけで、１つまたは複数のコンテナに対して制限を設けられます。複数のコンテナを指定するには、コンテナ名か ID を空白（スペース）区切りで指定します。

.. With the exception of the --kernel-memory value, you can specify these options on a running or a stopped container. You can only update --kernel-memory on a stopped container. When you run docker update on stopped container, the next time you restart it, the container uses those values.

``--kernel-memory`` 値以外は、コンテナを実行中でも停止中でもオプションを指定できます。 ``--kernel-memory`` は停止したコンテナに対してのみ指定できます。停止したコンテナに対して ``docker update`` を実行したら、次のコンテナ再起動時に値が反映します。

.. Another configuration you can change with this command is restart policy, new restart policy will take effect instantly after you run docker update on a container.

他にも再起動ポリシーを変更できます。コンテナに対する新しい再起動ポリシーは、 ``docker update`` コマンドを実行した直後に有効になります。

.. EXAMPLES

例
==========

.. The following sections illustrate ways to use this command.

以下のセクションはコマンドの使い方を説明します。

.. Update a container with cpu-shares=512

コンテナを ``cpu-shares=512`` に更新
----------------------------------------

.. To limit a container's cpu-shares to 512, first identify the container name or ID. You can use docker ps to find these values. You can also use the ID returned from the docker run command. Then, do the following:

コンテナの CPU 共有上限を 512 に設定するには、まずコンテナ名か ID を確認します。 **docker ps** で値を確認できます。あるいは **docker run** コマンド実行時に ID を返すので、ここでも確認できます。それから次のように実行します。

.. code-block:: bash

   $ docker update --cpu-shares 512 abebf7571666

.. Update a container with cpu-shares and memory

コンテナの CPU 共有とメモリを更新
----------------------------------------

.. To update multiple resource configurations for multiple containers:

複数のコンテナに対して複数のリソースを更新します。

.. code-block:: bash

   $ docker update --cpu-shares 512 -m 300M abebf7571666 hopeful_morse

.. Update a container's restart policy

コンテナの再起動ポリシーを更新
------------------------------

.. To update restart policy for one or more containers:

１つまたは複数のコンテナに対する再起動ポリシーを更新。

.. code-block:: bash

   $ docker update --restart=on-failure:3 abebf7571666 hopeful_morse

.. seealso:: 

   update
      https://docs.docker.com/engine/reference/commandline/update/
