.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/ps/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/reference/ps.md
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/reference/ps.md
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/compose/reference/ps.md
.. check date: 2022/04/08
.. Commits on Jan 28, 2022 b6b19516d0feacd798b485615ebfee410d9b6f86
.. -------------------------------------------------------------------

.. docker-compose ps
.. _docker-compose-ps:

=======================================
docker-compose ps
=======================================

.. code-block:: bash

   使い方: docker-compose ps [オプション] [サービス...]
   
   オプション:
       -q, --quiet          ID のみ表示
       --services           サービスを表示
       --filter KEY=VAL     属性でサービスをフィルタ
       -a, --all            停止済みコンテナを全て表示（run コマンドで作成されたコンテナを含む）

.. Lists containers.

コンテナ一覧を表示します。

.. code-block:: bash

   $ docker-compose ps
            Name                        Command                 State             Ports
   ---------------------------------------------------------------------------------------------
   mywordpress_db_1          docker-entrypoint.sh mysqld      Up (healthy)  3306/tcp
   mywordpress_wordpress_1   /entrypoint.sh apache2-for ...   Restarting    0.0.0.0:8000->80/tcp

.. seealso:: 

   docker-compose ps
      https://docs.docker.com/compose/reference/ps/
