.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/update/
.. SOURCE:
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/update.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_update.yaml
.. check date: 2022/03/27
.. Commits on Aug 22, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker update

=======================================
docker update
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _docker_update-description:

説明
==========

.. Update configuration of one or more containers

1つまたは複数コンテナの設定を :ruby:`更新 <update>` します。

.. _docker_update-usage:

使い方
==========

.. code-block:: bash

   $ docker update [OPTIONS] CONTAINER [CONTAINER...]

.. Extended description
.. _docker_update-extended-description:

補足説明
==========

.. The docker update command dynamically updates container configuration. You can use this command to prevent containers from consuming too many resources from their Docker host. With a single command, you can place limits on a single container or on many. To specify more than one container, provide space-separated list of container names or IDs.

``docker update`` コマンドはコンテナの設定を動的に更新します。このコマンドを使えば、Docker ホスト上でコンテナが多くのリソースを消費するの防ぎます。コマンドを１度実行するだけで、１つまたは複数のコンテナに対して制限を設けられます。複数のコンテナを指定するには、コンテナ名か ID を空白（スペース）区切りで指定します。

.. With the exception of the --kernel-memory value, you can specify these options on a running or a stopped container. You can only update --kernel-memory on a stopped container. When you run docker update on stopped container, the next time you restart it, the container uses those values.

``--kernel-memory`` 値以外は、コンテナを実行中でも停止中でもオプションを指定できます。 ``--kernel-memory`` は停止したコンテナに対してのみ指定できます。停止したコンテナに対して ``docker update`` を実行したら、次のコンテナ再起動時に値が反映します。

..    Warning
    The docker update and docker container update commands are not supported for Windows containers.

.. warning::

   Windows コンテナでは ``docker update`` と ``docker container update`` はサポートしていません。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <docker_update-examples>` をご覧ください。

.. _docker_update-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--blkio-weight``
     - 
     - ブロック I/O ウエイト（相対値）を 10 ～ 1000 までの値でウエイトを設定（デフォルト 0）
   * - ``--cpu-period``
     - 
     - CPU CFS (Completely Fair Scheduler) の間隔を設定
   * - ``--cpu-quota``
     - 
     - CPU CFS (Completely Fair Scheduler) のクォータを設定
   * - ``--cpu-rt-period``
     - 
     - 【API 1.25+】 CPU real-time period 制限をマイクロ秒で指定
   * - ``--cpu-rt-runtime``
     - 
     - 【API 1.25+】 CPU real-time runtime 制限をマイクロ秒で指定
   * - ``--cpu-shares`` , ``-c``
     - 
     - CPU 共有（相対値）
   * - ``--cpus``
     - 
     - 【API 1.25+】 CPU 数
   * - ``--cpuset-cpus``
     - 
     - 実行する CPU の割り当て（0-3, 0,1）
   * - ``--cpuset-mems``
     - 
     - 実行するメモリ・ノード（MEM）の割り当て（0-3, 0,1）
   * - ``--kernel-memory``
     - 
     - カーネル・メモリ上限
   * - ``--memory`` , ``-m``
     - 
     - メモリ上限
   * - ``--memory-reservation``
     - 
     - メモリのソフト上限
   * - ``--memory-swap``
     - 
     - 整数値の指定はメモリにスワップ値を追加。 ``-1`` は無制限スワップを有効化
   * - ``--pids-limit``
     - 
     - コンテナの pids 制限を調整（ -1 は無制限）
   * - ``--restart``
     - 
     - コンテナ終了時に適用する再起動ポリシー

.. Examples
.. _docker_update-examples:

使用例
==========

.. The following sections illustrate ways to use this command.

以下のセクションはコマンドの使い方を説明します。

.. Update a container’s cpu-shares
.. _docker_update-update-a-containers-cpu-shares:

コンテナの cpu-shares を更新
----------------------------------------

.. To limit a container's cpu-shares to 512, first identify the container name or ID. You can use docker ps to find these values. You can also use the ID returned from the docker run command. Then, do the following:

コンテナの CPU 共有上限を 512 に設定するには、まずコンテナ名か ID を確認します。 **docker ps** で値を確認できます。あるいは **docker run** コマンド実行時に ID を返すので、ここでも確認できます。それから次のように実行します。

.. code-block:: bash

   $ docker update --cpu-shares 512 abebf7571666

.. Update a container with cpu-shares and memory
.. _docker_update-update-a-container-with-cpu-shares-and-memory:

コンテナの cpu-shares とメモリを更新
----------------------------------------

.. To update multiple resource configurations for multiple containers:

複数のコンテナに対して複数のリソースを更新します。

.. code-block:: bash

   $ docker update --cpu-shares 512 -m 300M abebf7571666 hopeful_morse

.. Update a container’s kernel memory constraints
.. _docker_update-update-a-containers-kernel-memory-constraints:
コンテナのカーネル・メモリ制限を更新
----------------------------------------

.. You can update a container’s kernel memory limit using the --kernel-memory option. On kernel version older than 4.6, this option can be updated on a running container only if the container was started with --kernel-memory. If the container was started without --kernel-memory you need to stop the container before updating kernel memory.

コンテナのカーネル・メモリ制限は ``--kernel-memory`` オプションを使って更新できます。カーネルバージョン 4.6 よりも古ければ、 ``--kernel-memory`` でコンテナを起動したコンテナのみ、オプションで更新できます。 ``--kernel-memory`` を指定せずに起動したコンテナは、カーネルメモリを更新する前にコンテナの停止が必要です。

..    Note
    The --kernel-memory option has been deprecated since Docker 20.10.

.. note::

   ``--kernel-memory`` オプションは Docker 20.10 以降では非推奨になりました。


.. For example, if you started a container with this command:

たとえば、コンテナを次のコマンドで実行したとします。

.. code-block:: bash

   $ docker run -dit --name test --kernel-memory 50M ubuntu bash

.. You can update kernel memory while the container is running:

実行中のコンテナはカーネルメモリを更新できます。

.. code-block:: bash

   $ docker update --kernel-memory 80M test

.. If you started a container without kernel memory initialized:

コンテナの初期化時にカーネルメモリを指定せずに起動した場合は、こちらです。

.. code-block:: bash

   $ docker run -dit --name test2 --memory 300M ubuntu bash

.. Update kernel memory of running container test2 will fail. You need to stop the container before updating the --kernel-memory setting. The next time you start it, the container uses the new value.

実行中のコンテナ ``test2`` に対するカーネルメモリ更新は失敗します。 ``--kernel-memory`` 設定を更新する前に、コンテナの停止が必要です。コンテナを次に起動すると、コンテナは新しい値を使います。

.. Kernel version newer than (include) 4.6 does not have this limitation, you can use --kernel-memory the same way as other options.

カーネルバージョン 4.6 （以上）では、この制限はありません。他のオプションと同じように ``--kernel-memory`` を使えます。

.. Update a container's restart policy
.. _docker_update-Update a container's restart policy:

コンテナの再起動ポリシーを更新
------------------------------

.. You can change a container’s restart policy on a running container. The new restart policy takes effect instantly after you run docker update on a container.

実行中のコンテナに対し、コンテナの再起動ポリシーを変更できます。新しい再起動ポリシーは、コンテナに対して ``docker update`` を実行後、直ちに反映されます。

.. To update restart policy for one or more containers:

１つまたは複数のコンテナに対する再起動ポリシーを更新します。。

.. code-block:: bash

   $ docker update --restart=on-failure:3 abebf7571666 hopeful_morse

.. Note that if the container is started with “--rm” flag, you cannot update the restart policy for it. The AutoRemove and RestartPolicy are mutually exclusive for the container.

コンテナに ``--rm`` フラグを付けて起動した場合は、再起動ポリシーを変更できないため、注意が必要です。コンテナには ``AutoRemove`` と ``RestartPolicy`` を同時に指定できません。


親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI の基本コマンド


.. seealso:: 

   docker update
      https://docs.docker.com/engine/reference/commandline/update/
