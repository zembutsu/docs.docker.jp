.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/logs/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/reference/logs.md
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/reference/logs.md
.. check date: 2016/04/28
.. Commits on Mar 2, 2016 9b36dc5c540f9c88bdf6cb5e5b8e7e7b745d3c8f
.. -------------------------------------------------------------------

.. logs

.. _compose-logs:

=======================================
logs
=======================================

.. code-block:: bash

   使い方: logs [オプション] [サービス...]
   
   オプション:
   --no-color          白黒で画面に出力
   -f, --follow        ログの出力をフォロー（表示しつづける）
   -t, --timestamps    タイムスタンプの表示
   --tail              各コンテナのログの最終行から遡った行を表示

.. Displays log output from services.

サービスからのログ出力を表示します。

.. seealso:: 

   logs
      https://docs.docker.com/compose/reference/logs/

