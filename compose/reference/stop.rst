.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/stop/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/reference/stop.md
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/reference/stop.md
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/compose/reference/stop.md
.. check date: 2022/04/09
.. Commits on Jan 28, 2022 b6b19516d0feacd798b485615ebfee410d9b6f86
.. -------------------------------------------------------------------

.. docker-compose stop
.. _docker-compose-stop:

=======================================
docker-compose stop
=======================================

.. code-block:: bash

   使い方: docker-compose stop [オプション] [サービス...]
   
   オプション:
   -t, --timeout TIMEOUT      シャットダウンのタイムアウト秒数を指定 (デフォルト: 10).

.. Stops running containers without removing them. They can be started again with docker-compose start.

稼働中のコンテナを停止しますが、削除しません。 ``docker-compose start`` コマンドで、再起動できます。

.. seealso:: 

   docker-compose stop
      https://docs.docker.com/compose/reference/stop/
