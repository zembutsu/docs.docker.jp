.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/create/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/reference/create.md
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/reference/create.md
.. check date: 2016/04/28
.. Commits on Mar 3, 2016 e1b87d7be0aa11f5f87762635a9e24d4e8849e77
.. -------------------------------------------------------------------

.. create

.. _compose-create:

=======================================
create
=======================================

.. code-block:: bash

   使い方: create [オプション] [サービス...]
   
   オプション:
       --force-recreate       設定やイメージに変更がなくてもコンテナを再作成 --no-recreate とは同時に使えない
       --no-recreate          コンテナが存在していたら、再作成しない
                              --force-recreate とは同時に使えない
       --no-build             イメージがなくても構築しない
       --build                コンテナを作成前にイメージを作成

.. Creates containers for a service.

サービス用のコンテナを作成します。

.. seealso:: 

   create
      https://docs.docker.com/compose/reference/create/
