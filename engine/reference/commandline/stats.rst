.. -*- coding: utf-8 -*-
.. https://docs.docker.com/engine/reference/commandline/stats/
.. doc version: 1.9
.. check date: 2015/12/27
.. -----------------------------------------------------------------------------

.. stats

=======================================
stats
=======================================

.. code-block:: bash

   Usage: docker stats [OPTIONS] CONTAINER [CONTAINER...]
   
   Display a live stream of one or more containers' resource usage statistics
   
     --help=false       Print usage
     --no-stream=false  Disable streaming stats and only pull the first result

.. Running docker stats on multiple containers

``docker stats`` を複数のコンテナに実行します。

.. code-block:: bash

   $ docker stats redis1 redis2
   CONTAINER           CPU %               MEM USAGE / LIMIT     MEM %               NET I/O             BLOCK I/O
   redis1              0.07%               796 KB / 64 MB        1.21%               788 B / 648 B       3.568 MB / 512 KB
   redis2              0.07%               2.746 MB / 64 MB      4.29%               1.266 KB / 648 B    12.4 MB / 0 B

.. The docker stats command will only return a live stream of data for running containers. Stopped containers will not return any data.

``docker stats`` コマンドは実行中のコンテナのデータを、ライブ・ストレームで返します。停止しているコンテナは何らデータを返しません。

..    Note: If you want more detailed information about a container’s resource usage, use the API endpoint.

.. note::

   コンテナのリソース使用状況に関する詳細な情報を得たい場合は、 API エンドポイントをご利用ください。

