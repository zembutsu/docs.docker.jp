.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/stats/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/stats.md
   doc version: 1.10
      https://github.com/docker/docker/commits/master/docs/reference/commandline/stats.md
.. check date: 2016/02/25
.. Commits on Jan 26, 2016 d76fba0191fc64759febc1ee22c6bc28ff49b3d6
.. -------------------------------------------------------------------

.. stats

=======================================
stats
=======================================

.. code-block:: bash

   Usage: docker stats [OPTIONS] [CONTAINER...]
   
   Display a live stream of one or more containers' resource usage statistics
   
     -a, --all          Show all containers (default shows just running)
     --help             Print usage
     --no-stream        Disable streaming stats and only pull the first result

.. The docker stats command returns a live data stream for running containers. To limit data to one or more specific containers, specify a list of container names or ids separated by a space. You can specify a stopped container but stopped containers do not return any data.

``docker stats`` コマンドは実行中のコンテナからライブ・データ・ストリームを返します。特定コンテナの情報のみを取得するには、コンテナ名またはコンテナ ID をスペース句切りで追加します。ここでは停止しているコンテナも指定できますが、停止中のコンテナは何も返しません。

.. If you want more detailed information about a container’s resource usage, use the /containers/(id)/stats API endpoint.

コンテナのリソース使用詳細を知りたい場合は、 ``/containers/(id)/stats`` API エンドポイントを使います。

.. Examples

例
==========

.. Running docker stats on multiple containers

``docker stats`` を複数のコンテナに実行します。

.. code-block:: bash

   $ docker stats
   CONTAINER           CPU %               MEM USAGE / LIMIT     MEM %               NET I/O             BLOCK I/O
   1285939c1fd3        0.07%               796 KB / 64 MB        1.21%               788 B / 648 B       3.568 MB / 512 KB
   9c76f7834ae2        0.07%               2.746 MB / 64 MB      4.29%               1.266 KB / 648 B    12.4 MB / 0 B
   d1ea048f04e4        0.03%               4.583 MB / 64 MB      6.30%               2.854 KB / 648 B    27.7 MB / 0 B

.. Running docker stats on multiple containers by name and id.

``docker stats`` で複数のコンテナ名・ID を指定します。

.. code-block:: bash

   $ docker stats fervent_panini 5acfcb1b4fd1
   CONTAINER           CPU %               MEM USAGE/LIMIT     MEM %               NET I/O
   5acfcb1b4fd1        0.00%               115.2 MB/1.045 GB   11.03%              1.422 kB/648 B
   fervent_panini      0.02%               11.08 MB/1.045 GB   1.06%               648 B/648 B

.. seealso:: 

   stats
      https://docs.docker.com/engine/reference/commandline/stats/
