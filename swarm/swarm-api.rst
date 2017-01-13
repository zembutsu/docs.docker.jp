.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/swarm/swarm-api/
.. SOURCE: https://github.com/docker/swarm/blob/master/docs/swarm-api.md
   doc version: 1.11
      https://github.com/docker/swarm/commits/master/docs/swarm-api.md
.. check date: 2016/04/29
.. Commits on Mar 4, 2016 4b8ed91226a9a49c2acb7cb6fb07228b3fe10007
.. -------------------------------------------------------------------

.. Docker Swarm API

==============================
Docker Swarm API
==============================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. The Docker Swarm API is mostly compatible with the Docker Remote API. This document is an overview of the differences between the Swarm API and the Docker Remote API.

Docker Swarm API は :doc:`Docker リモート API </engine/reference/api/docker_remote_api>` と広範囲の互換性があります。このドキュメントは、Swarm API と Docker リモート API 間の違いに関する概要を説明します。

.. Missing endpoints

エンドポイントが無い場合
==============================

.. Some endpoints have not yet been implemented and will return a 404 error.

いくつかのエンドポイントは未実装のため、その場合は 404 エラーを返します。

.. code-block:: bash

   POST "/images/create" : "docker import" flow not implement

.. Endpoints which behave differently

異なる動作をするエンドポイント
==============================

* ``GET "/containers/{name:.*}/json"`` : ``Node`` 追加時の新しいフィールドです。

.. code-block:: json

   "Node": {
   	"Id": "ODAI:IC6Q:MSBL:TPB5:HIEE:6IKC:VCAM:QRNH:PRGX:ERZT:OK46:PMFX",
   	"Ip": "0.0.0.0",
   	"Addr": "http://0.0.0.0:4243",
   	"Name": "vagrant-ubuntu-saucy-64",
       },

* ``GET "/containers/{name:.*}/json"`` : ``HostIP`` が ``0.0.0.0`` の場合、実際のノード IP アドレスに置き換えます。

* ``GET "/containers/json"`` : コンテナ名の前にノード名が付きます。

* ``GET "/containers/json"`` : ``HostIP`` が ``0.0.0.0`` の場合、実際のノード IP アドレスに置き換えます。

* ``GET "/containers/json"`` : 公式 swarm イメージを使ってコンテナを起動した場合、デフォルトでは表示しません。表示するには ``all-1`` を使います。

* ``GET "/images/json"`` : ``--filter node=<Node name>`` を使うことで、特定のノードのイメージ情報を表示します。

* ``POST "/containers/create"`` : ``HostConfig`` の ``CpuShares`` 設定で、コンテナに対する CPU コアの割当数を指定します。


Docker Swarm ドキュメント目次
==============================

* :doc:`ユーザ・ガイド </swarm/index>`
* :doc:`ディスカバリ・オプション </swarm/discovery>`
* :doc:`スケジュール・ストラテジ </swarm/scheduler/strategy>`
* :doc:`スケジューラ・フィルタ </swarm/scheduler/filter>`

.. seealso:: 

   Docker Swarm API
      https://docs.docker.com/swarm/swarm-api/
