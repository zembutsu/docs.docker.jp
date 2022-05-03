.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/storage/troubleshooting_volume_errors/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/storage/troubleshooting_volume_errors.md
   doc version: 20.10
.. check date: 2022/05/03
.. Commits on Aug 7, 2021 4afcaf3b2d8656e3fed75ca9fda445a02efcfc04
.. ---------------------------------------------------------------------------

.. Troubleshoot volume errors
.. _troubleshoot-volume-errors:

==================================================
ボリューム エラーのトラブルシューティング
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. This topic discusses errors which may occur when you use Docker volumes or bind mounts.

このトピックでは、 Docker ボリュームやバインドマウントの使用時に発生する可能性があるエラーについて扱います。

.. Error: Unable to remove filesystem
.. _error-unable-to-remove-filesystem:
``Error: Unable to remove filesystem`` （エラー：ファイルシステムを削除できない）
==========================================================================================

.. Some container-based utilities, such as Google cAdvisor, mount Docker system directories, such as /var/lib/docker/, into a container. For instance, the documentation for cadvisor instructs you to run the cadvisor container as follows:

`Google cAdvisor <https://github.com/google/cadvisor>`_ のような、コンテナをベースとしたツールのいくつかは、 ``/var/lib/docker`` のような Docker システムディレクトリをマウントします。たとえば、 ``cadvisor`` のドキュメントには、 ``cadvisor`` コンテナを次のように実行するような手順があります。

.. code-block:: bash

   $ sudo docker run \
     --volume=/:/rootfs:ro \
     --volume=/var/run:/var/run:rw \
     --volume=/sys:/sys:ro \
     --volume=/var/lib/docker/:/var/lib/docker:ro \
     --publish=8080:8080 \
     --detach=true \
     --name=cadvisor \
     google/cadvisor:latest

.. When you bind-mount /var/lib/docker/, this effectively mounts all resources of all other running containers as filesystems within the container which mounts /var/lib/docker/. When you attempt to remove any of these containers, the removal attempt may fail with an error like the following:

``/var/lib/docker`` のバインド マウントは、実行中の他すべてのコンテナが持つ、全てのリソースをマウントするのに効果的です。これは ``/var/lib/docker`` をコンテナ内のファイルシステムとしてマウントするからです。これらをコンテナから削除しようとしても、以下のようなエラーが発生し、削除は阻止されます。

.. code-block:: bash

   Error: Unable to remove filesystem for
   74bef250361c7817bee19349c93139621b272bc8f654ae112dd4eb9652af9515:
   remove /var/lib/docker/containers/74bef250361c7817bee19349c93139621b272bc8f654ae112dd4eb9652af9515/shm:
   Device or resource busy

.. The problem occurs if the container which bind-mounts /var/lib/docker/ uses statfs or fstatfs on filesystem handles within /var/lib/docker/ and does not close them.

問題が起こるのは、コンテナが ``/var/lib/docker`` をマウントするとき、 ``/var/lib/docker`` を扱うファイルシステム上で ``statfs`` や ``fstatfs`` を使うと、これらを閉じられなくなります。

.. Typically, we would advise against bind-mounting /var/lib/docker in this way. However, cAdvisor requires this bind-mount for core functionality.

通常は、このように ``/var/lib/doker`` に対するバインド マウントに反対したいです。しかしながら、 ``cAdviser`` は中心となる機能で、このバインドマウントが必要です。

.. If you are unsure which process is causing the path mentioned in the error to be busy and preventing it from being removed, you can use the lsof command to find its process. For instance, for the error above:

パスが busy であったり削除できないといったエラーを引き起こすとき、どのプロセスが原因か不確かな場合には、 ``lsof`` コマンドでプロセスを特定できます。たとえば、先ほどのエラーであれば、次のようにします。

.. code-block:: bash

   $ sudo lsof /var/lib/docker/containers/74bef250361c7817bee19349c93139621b272bc8f654ae112dd4eb9652af9515/shm

.. To work around this problem, stop the container which bind-mounts /var/lib/docker and try again to remove the other container.

この問題に対処するには、``/var/lib/docker`` をバインド マウントしているコンテナを停止し、他のコンテナの削除を再び試します。

.. seealso:: 

   Troubleshoot volume errors
      https://docs.docker.com/storage/troubleshooting_volume_errors/