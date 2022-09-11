.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/pull/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/reference/pull.md
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/reference/pull.md
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/compose/reference/pull.md
.. check date: 2022/04/09
.. Commits on Jan 28, 2022 b6b19516d0feacd798b485615ebfee410d9b6f86
.. -------------------------------------------------------------------

.. docker-compose pull
.. _docker-compose-pull:

=======================================
docker-compose pull
=======================================

.. code-block:: bash

   使い方: docker-compose pull [オプション] [サービス...]
   
   オプション:
       --ignore-pull-failures  取得可能なイメージは取得し、取得に失敗するイメージを無視
       --parallel              非推奨。複数のイメージを並列に取得（デフォルトで有効）
       --no-parallel           並列取得を無効化
       -q, --quiet             進捗情報を表示せずに取得
       --include-deps          依存関係を宣言済みのサービスも取得

.. Pulls an image associated with a service defined in a docker-compose.yml or docker-stack.yml file, but does not start containers based on those images.

``docker-compose.yml`` や ``docker-stack.yml`` で定義されたサービスに関連するイメージを取得しますが、それらイメージを元にしたコンテナは起動しません。

.. For example, suppose you have this docker-compose.yml file from the Quickstart: Compose and Rails sample.

たとえば、 :doc:`クイックスタート: Comose と Rails </sample/rails>` サンプルにある ``docker-compose.yml`` ファイルがあるとします。

.. code-block:: yaml

   version: '2'
   services:
     db:
       image: postgres
     web:
       build: .
       command: bundle exec rails s -p 3000 -b '0.0.0.0'
       volumes:
         - .:/myapp
       ports:
         - "3000:3000"
       depends_on:
         - db

.. If you run docker-compose pull ServiceName in the same directory as the docker-compose.yml file that defines the service, Docker pulls the associated image. For example, to call the postgres image configured as the db service in our example, you would run docker-compose pull db.

``docker-compose.yml`` ファイルがあるのと同じディレクトリで ``docker-compose pull サービス名`` を実行すると、Docker は関連付けられたイメージを取得します。たとえば、例では ``db`` サービスとして指定されている ``postgres`` サービスを取得するには、 ``docker-compose pull db`` を実行します。

.. code-block:: bash

   $ docker-compose pull db
   Pulling db (postgres:latest)...
   latest: Pulling from library/postgres
   cd0a524342ef: Pull complete
   9c784d04dcb0: Pull complete
   d99dddf7e662: Pull complete
   e5bff71e3ce6: Pull complete
   cb3e0a865488: Pull complete
   31295d654cd5: Pull complete
   fc930a4e09f5: Pull complete
   8650cce8ef01: Pull complete
   61949acd8e52: Pull complete
   527a203588c0: Pull complete
   26dec14ac775: Pull complete
   0efc0ed5a9e5: Pull complete
   40cd26695b38: Pull complete
   Digest: sha256:fd6c0e2a9d053bebb294bb13765b3e01be7817bf77b01d58c2377ff27a4a46dc
   Status: Downloaded newer image for postgres:latest

.. seealso:: 

   docker-compose pull
      https://docs.docker.com/compose/reference/pull/

