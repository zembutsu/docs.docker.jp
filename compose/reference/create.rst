.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/create/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/reference/create.md
   doc version: 1.13
      https://github.com/docker/compose/commits/master/docs/reference/create.md
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/compose/reference/create.md
.. check date: 2022/04/08
.. Commits on Jan 28, 2022 b6b19516d0feacd798b485615ebfee410d9b6f86
.. -------------------------------------------------------------------

.. create

.. _compose-create:

=======================================
docker-compose create
=======================================
 
.. warning::

   **このコマンドは非推奨です。** かわりに、:doc:`up <up>` コマンドで ``--no-start`` を付けてください。


.. code-block:: bash

   使い方: create [オプション] [サービス...]
   
   オプション:
       --force-recreate       設定やイメージに変更がなくてもコンテナを再作成 --no-recreate とは同時に使えない
       --no-recreate          コンテナが存在していたら、再作成しない
                              --force-recreate とは同時に使えない
       --no-build             イメージがなくても構築しない
       --build                コンテナを作成前にイメージを作成

.. Creates containers for a service.

.. サービス用のコンテナを作成します。

.. seealso:: 

   docker-compose create
      https://docs.docker.com/compose/reference/create/
