.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/config/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/reference/config.md
   doc version: 1.13
      https://github.com/docker/compose/commits/master/docs/reference/config.md
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/compose/reference/config.md
.. check date: 2022/04/08
.. Commits on Jan 28, 2022 b6b19516d0feacd798b485615ebfee410d9b6f86
.. -------------------------------------------------------------------

.. config

.. _compose-config:

=======================================
docker-compose config
=======================================

.. code-block:: bash

   使い方: docker-compose config [オプション]
   
   オプション:
       --resolve-image-digests  ダイジェスト値にイメージのタグを固定
       --no-interpolate         環境変数を挿入しない
       -q, --quiet              設定の検証のみで、何も表示しない
       --services               サービス名を1行ずつ表示
       --volumes                ボリューム名を1行ずつ表示
       --hash="*"               サービスの config ハッシュを1行ずつ表示
                                "service1,service2" を指定すると、対象サービスのみ表示
                                あるいは、ワイルドカード記号で全サービスを表示

.. Validate and view the compose file.

Compose ファイルを検証・表示します。

.. seealso:: 

   docker-compose config
      https://docs.docker.com/compose/reference/config/
