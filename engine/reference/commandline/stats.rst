.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/stats/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/stats.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/stats.md
.. check date: 2016/06/16
.. Commits on Apr 9, 2016 0e3846e280195cb47c47a7739b475b281dd301cb
.. -------------------------------------------------------------------

.. stats

=======================================
stats
=======================================

.. code-block:: bash

   使い方: docker stats [オプション] [コンテナ...]
   
   １つまたは複数のコンテナのリソース使用状況をライブで流し続ける
   
     -a, --all          全てのコンテナを表示（デフォルトは実行中のものだけ）
     --help             使い方の表示
     --no-stream        ストリームを無効化し、初回の結果しか表示しない

.. The docker stats command returns a live data stream for running containers. To limit data to one or more specific containers, specify a list of container names or ids separated by a space. You can specify a stopped container but stopped containers do not return any data.

``docker stats`` コマンドは実行中のコンテナからライブ・データ・ストリームを返します。特定コンテナの情報のみを取得するには、コンテナ名またはコンテナ ID をスペース区切りで追加します。ここでは停止しているコンテナも指定できますが、停止中のコンテナは何も返しません。

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
   1285939c1fd3        0.07%               796 KiB / 64 MiB        1.21%               788 B / 648 B       3.568 MB / 512 KB
   9c76f7834ae2        0.07%               2.746 MiB / 64 MiB      4.29%               1.266 KB / 648 B    12.4 MB / 0 B
   d1ea048f04e4        0.03%               4.583 MiB / 64 MiB      6.30%               2.854 KB / 648 B    27.7 MB / 0 B

.. Running docker stats on multiple containers by name and id.

``docker stats`` で複数のコンテナ名・ID を指定します。

.. code-block:: bash

   $ docker stats fervent_panini 5acfcb1b4fd1
   CONTAINER           CPU %               MEM USAGE/LIMIT     MEM %               NET I/O
   5acfcb1b4fd1        0.00%               115.2 MiB/1.045 GiB   11.03%              1.422 kB/648 B
   fervent_panini      0.02%               11.08 MiB/1.045 GiB   1.06%               648 B/648 B

.. seealso:: 

   stats
      https://docs.docker.com/engine/reference/commandline/stats/
