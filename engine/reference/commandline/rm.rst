.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/rm/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/rm.md
   doc version: 1.10
      https://github.com/docker/docker/commits/master/docs/reference/commandline/rm.md
.. check date: 2016/02/25
.. Commits on Feb 19, 2016 cdc7f26715fbf0779a5283354048caf9faa1ec4a
.. -------------------------------------------------------------------

.. rm

=======================================
rm
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. code-block:: bash

   Usage: docker rm [OPTIONS] CONTAINER [CONTAINER...]
   
   Remove one or more containers
   
     -f, --force            Force the removal of a running container (uses SIGKILL)
     --help                 Print usage
     -l, --link             Remove the specified link
     -v, --volumes          Remove the volumes associated with the container
   
.. Examples

例
==========

.. code-block:: bash

   $ docker rm /redis
   /redis

.. This will remove the container referenced under the link /redis.

これは ``/redis`` リンクとして参照されているコンテナを削除します。

.. code-block:: bash

   $ docker rm --link /webapp/redis
   /webapp/redis

.. This will remove the underlying link between /webapp and the /redis containers removing all network communication.

これは ``/webapp/redis`` でリンクされているコンテナを削除します。

.. code-block:: bash

   $ docker rm --force redis
   redis

.. The main process inside the container referenced under the link /redis will receive SIGKILL, then the container will be removed.

これは ``/link`` でリンクさているコンテナを ``SIGKILL`` し、コンテナを削除します。

.. code-block:: bash

   $ docker rm $(docker ps -a -q)

.. This command will delete all stopped containers. The command docker ps -a -q will return all existing container IDs and pass them to the rm command which will delete them. Any running containers will not be deleted.

このコマンドは停止しているコンテナを全て削除します。コマンド ``docker ps -a -q`` は終了した全てのコンテナ ID を ``rm`` コマンドに渡し、全て削除するものです。実行チュのコンテナは削除されません。

.. code-block:: bash

   $ docker rm -v redis
   redis

.. This command will remove the container and any volumes associated with it. Note that if a volume was specified with a name, it will not be removed.

このコマンドはコンテナと、コンテナに関連付けられた全ボリュームを削除します。ただし、ボリュームに名前を指定していた場合は、このコマンドでは削除されません。

.. code-block:: bash

   $ docker create -v awesome:/foo -v /bar --name hello redis
   hello
   $ docker rm -v hello

.. In this example, the volume for /foo will remain intact, but the volume for /bar will be removed. The same behavior holds for volumes inherited with --volumes-from.

この例では、ボリューム ``/foo`` は残り続けますが、ボリューム ``/bar`` は削除されます。同様に ``--volumes-from`` で継承関係にあるボリュームも保持されます。

.. seealso:: 

   rm
      https://docs.docker.com/engine/reference/commandline/rm/
