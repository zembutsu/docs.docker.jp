.. -*- coding: utf-8 -*-
.. https://docs.docker.com/engine/reference/commandline/rm/
.. doc version: 1.9
.. check date: 2015/12/27
.. -----------------------------------------------------------------------------

.. rm

=======================================
rm
=======================================

.. code-block:: bash

   Usage: docker rm [OPTIONS] CONTAINER [CONTAINER...]
   
   Remove one or more containers
   
     -f, --force=false      Force the removal of a running container (uses SIGKILL)
     --help=false           Print usage
     -l, --link=false       Remove the specified link
     -v, --volumes=false    Remove the volumes associated with the container
   
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



