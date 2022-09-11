.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/logs/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/reference/logs.md
   doc version: 1.13
      https://github.com/docker/compose/commits/master/docs/reference/logs.md
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/compose/reference/logs.md
.. check date: 2022/04/08
.. Commits on Jan 28, 2022 b6b19516d0feacd798b485615ebfee410d9b6f86
.. -------------------------------------------------------------------

.. docker-compose logs
.. _docker-compose-logs:

=======================================
docker-compose logs
=======================================

.. code-block:: bash

   使い方: logs [オプション] [サービス...]
   
   オプション:
   --no-color          白黒で画面に出力
   -f, --follow        ログの出力をフォロー（表示しつづける）
   -t, --timestamps    タイムスタンプの表示
   --tail="all"        各コンテナのログの最終行から遡った行を表示

.. Displays log output from services.

サービスからのログ出力を表示します。

.. seealso:: 

   docker-compose logs
      https://docs.docker.com/compose/reference/logs/

