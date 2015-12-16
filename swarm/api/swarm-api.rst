.. https://docs.docker.com/swarm/api/swarm-api/
.. doc version: 1.9
.. check date: 2015/12/16

.. Docker Swarm API

==============================
Docker Swarm API
==============================

.. The Docker Swarm API is mostly compatible with the Docker Remote API. This document is an overview of the differences between the Swarm API and the Docker Remote API.

Docker Swarm API は :doc:`Docker リモート API </reference/api/docker_remote_api>` と大部分に互換性があります。このドキュメントは、Swarm API と Docker リモート API 間の違いに関する概要です。

.. Missing endpoints

エンドポイントがない場合
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

* ``GET "/images/json"`` : ``–filter node=<Node name>`` を使うことで、特定のノードのイメージ情報を表示します。

* ``POST "/containers/create"`` : ``HostConfig`` の ``CpuShares`` 設定で、コンテナに対する CPU コアの割当数を指定します。


Docker Swarm ドキュメント目次
==============================

* :doc:`ユーザ・ガイド </swarm/index>`
* :doc:`ディスカバリ・オプション </swarm/discovery>`
* :doc:`スケジュール・ストラテジ </swarm/scheduler/strategy>`
* :doc:`スケジューラ・フィルタ </swarm/scheduler/filter>`
