.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/rm/
.. SOURCE:
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/rm.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_rm.yaml
.. check date: 2022/03/23
.. Commits on Aug 22, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker rm

=======================================
docker rm
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _docker_remove-description:

説明
==========

.. Remove one or more containers

1つまたは複数のコンテナを :ruby:`削除 <remove>` します。

.. _docker_remove-usage:

使い方
==========

.. code-block:: bash

   $ docker rm [OPTIONS] CONTAINER [CONTAINER...]

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <docker_rm-examples>` をご覧ください。

.. _docker_rm-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--force`` , ``-f``
     - 
     - 実行中のコンテナを強制的に削除（ SIGKILL を使用）
   * - ``--link`` , ``-l``
     - 
     - 指定されたリンクを削除
   * - ``--volumes`` , ``-v``
     - 
     - コンテナに割り当てられた :ruby:`匿名ボリューム <anonymous volume>` を削除


.. Examples
.. _docker_rm-examples:

使用例
==========

.. Remove a container
.. _docker_rm-remove-a-container:

コンテナの削除
--------------------

.. This will remove the container referenced under the link /redis.

これは ``/redis`` へのリンクとして参照されているコンテナを削除します。

.. code-block:: bash

   $ docker rm /redis
   /redis

.. Remove a link specified with --link on the default bridge network
.. _docker_rm-remove-a-link-specified-with-link-on-the-default-bridge-network:
デフォルトのブリッジ・ネットワーク上で、 ``--link`` によって指定されたリンクを削除
----------------------------------------------------------------------------------------------------

.. This removes the underlying link between /webapp and the /redis containers on the default bridge network, removing all network communication between the two containers. This does not apply when --link is used with user-specified networks.

これは、デフォルトのブリッジ・ネットワーク上で、 ``/webapp`` と ``/redis`` コンテナ間を構成するリンクを削除し、この2つのコンテナ間で全てのネットワーク通信を削除します。ただし、ユーザ定義ネットワーク上で ``--link`` が使われている場合には、適用されません。

.. code-block:: bash

   $ docker rm --link /webapp/redis
   /webapp/redis

.. Force-remove a running container
.. _docker_rm-force-remove-a-running-container:
実行中のコンテナを強制削除
------------------------------

.. This command force-removes a running container.

このコマンドは、実行中のコンテナを強制的に削除します。

.. code-block:: bash

   $ docker rm --force redis
   redis

.. The main process inside the container referenced under the link /redis will receive SIGKILL, then the container will be removed.

これは ``/link`` でリンクされているコンテナを ``SIGKILL`` し、それからコンテナを削除します。

.. Remove all stopped containers
.. _docker_rm-remove-all-stopped-containers:
停止したコンテナを全て削除
-----------------------------

.. Use the docker container prune command to remove all stopped containers, or refer to the docker system prune command to remove unused containers in addition to other Docker resources, such as (unused) images and networks.

``docker container prune`` コマンドを使い、全ての停止済みコンテナを削除するか、あるいは、 ``docker system prune`` コマンドで未使用のコンテナに加え、（未使用の）イメージとネットワークのような他の Docker リソースを削除します。

.. Alternatively, you can use the docker ps with the -q / --quiet option to generate a list of container IDs to remove, and use that list as argument for the docker rm command.

別の方法として、 ``docker ps`` に ``-q`` / ``--quiet`` オプションを使い、削除するコンテナの一覧リストを生成し、 ``docker rm`` コマンドの引数に、これらリストを使って削除できます。

.. Combining commands can be more flexible, but is less portable as it depends on features provided by the shell, and the exact syntax may differ depending on what shell is used. To use this approach on Windows, consider using PowerShell or Bash.

コマンドの組み合わせは、より柔軟になりますが、シェルが提供する機能に依存するため、 :ruby:`移植性 <portable>` は低下します。さらに、正確な構文が、どのシェルを使うかに依存します（どのシェルを使うかにより、正確な構文は異なります）。Windows 上でこの手法を使う場合、 PowerShell か Bash の利用を検討ください。

.. The example below uses docker ps -q to print the IDs of all containers that have exited (--filter status=exited), and removes those containers with the docker rm command:

以下の例は ``docker ps -q`` を使い、 :ruby:`終了した <exited>` コンテナ（ ``--filter status=exited`` ）すべての ID を表示し、そして、これらコンテナを ``docker rm`` コマンドで削除します。

.. code-block:: bash

   $ docker rm $(docker ps --filter status=exited -q)

.. Or, using the xargs Linux utility;

あるいは、 Linux ユーティリティ ``xargs`` を使う場合は、このようになります。

.. code-block:: bash

   $ docker ps --filter status=exited -q | xargs docker rm

.. Remove a container and its volumes
.. _docker_rm-remove-a-container-and-its-volumes:
コンテナと、そのボリュームを削除
----------------------------------------

.. code-block:: bash

   $ docker rm -v redis
   redis

.. This command removes the container and any volumes associated with it. Note that if a volume was specified with a name, it will not be removed.

このコマンドはコンテナと、コンテナに関連づけられた全ボリュームを削除します。ただし、ボリュームに名前を指定していた場合は、このコマンドでは削除されません。

.. Remove a container and selectively remove volumes
.. _docker_rm-remove-a-container-and-selectively-remove-volumes:
コンテナと指定したボリュームを削除
----------------------------------------

.. code-block:: bash

   $ docker create -v awesome:/foo -v /bar --name hello redis
   hello
   $ docker rm -v hello

.. In this example, the volume for /foo remains intact, but the volume for /bar is removed. The same behavior holds for volumes inherited with --volumes-from.

この例では、ボリューム ``/foo`` は以後も残り続けますが、ボリューム ``/bar`` は削除します。同様に ``--volumes-from`` で継承関係にあるボリュームも保持します。

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI の基本コマンド

.. seealso:: 

   docker rm
      https://docs.docker.com/engine/reference/commandline/rm/
