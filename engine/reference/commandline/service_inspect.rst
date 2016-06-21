.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/service_inspect/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/service_inspect.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/service_inspect.md
.. check date: 2016/06/21
.. Commits on Jun 20, 2016 daedbc60d61387cb284b871145b672006da1b6de
.. -------------------------------------------------------------------

.. service inspect

.. _reference-service-inspect:

=======================================
service inspect
=======================================

.. code-block:: bash

   使い方:  docker service inspect [オプション] サービス [サービス...]
   
   サービスの調査（Inspect）
   
   オプション:
     -f, --format string   指定した go テンプレートの書式で出力
         --help            使い方の表示
     -p, --pretty          人間が読みやすい形式で情報を表示

.. Inspects the specified service. This command has to be run targeting a manager node.

指定したサービスを調査します。このコマンドの実行対象はマネージャ・ノードです。

.. By default, this renders all results in a JSON array. If a format is specified, the given template will be executed for each result.

デフォルトでは、全てを JSON アレイ形式で返します。書式を指定したら、指定したテンプレートで各結果を処理します。

.. Go's text/template package describes all the details of the format.

全ての書式に関する詳細は、Go 言語の `text/template <http://golang.org/pkg/text/template/>`_ にあります。

.. Examples

例
=========-

.. Inspecting a service by name or ID

名前か ID でサービスを調査
------------------------------

.. You can inspect a service, either by its name, or ID

名前か ID のどちらかを指定し、サービスを調査できます。

.. For example, given the following service;

たとえば、次のサービスがあるとします。

.. code-block:: bash

   $ docker service ls
   ID            NAME      REPLICAS  IMAGE         COMMAND
   dmu1ept4cxcf  redis     3/3       redis:3.0.6

.. Both docker service inspect redis, and docker service inspect dmu1ept4cxcf produce the same result:

``docker service inspect redis`` と ``docker service inspect dmu1ept4cxcf`` は、どちらも同じ結果を生成します。

.. code-block:: bash

   $ docker service inspect redis
   [
       {
           "ID": "dmu1ept4cxcfe8k8lhtux3ro3",
           "Version": {
               "Index": 12
           },
           "CreatedAt": "2016-06-17T18:44:02.558012087Z",
           "UpdatedAt": "2016-06-17T18:44:02.558012087Z",
           "Spec": {
               "Name": "redis",
               "TaskTemplate": {
                   "ContainerSpec": {
                       "Image": "redis:3.0.6"
                   },
                   "Resources": {
                       "Limits": {},
                       "Reservations": {}
                   },
                   "RestartPolicy": {
                       "Condition": "any",
                       "MaxAttempts": 0
                   },
                   "Placement": {}
               },
               "Mode": {
                   "Replicated": {
                       "Replicas": 1
                   }
               },
               "UpdateConfig": {},
               "EndpointSpec": {
                   "Mode": "vip"
               }
           },
           "Endpoint": {
               "Spec": {}
           }
       }
   ]

.. code-block:: bash

   $ docker service inspect dmu1ept4cxcf
   [
       {
           "ID": "dmu1ept4cxcfe8k8lhtux3ro3",
           "Version": {
               "Index": 12
           },
           ...
       }
   ]

.. Inspect a service using pretty-print

読みやすい形式でサービスを調査
------------------------------

.. You can print the inspect output in a human-readable format instead of the default JSON output, by using the --pretty option:

``--pretty`` オプションを使えば、デフォルトの JSON 出力ではなく、人間が読みやすい書式で調査結果を表示できます。

.. code-block:: bash

   $ docker service inspect --pretty frontend
   ID:     c8wgl7q4ndfd52ni6qftkvnnp
   Name:       frontend
   Labels:
    - org.example.projectname=demo-app
   Mode:       REPLICATED
    Replicas:      5
   Placement:
    Strategy:  Spread
   UpdateConfig:
    Parallelism:   0
   ContainerSpec:
    Image:     nginx:alpine
   Resources:
   Reservations:
   Limits:
   Ports:
    Name =
    Protocol = tcp
    TargetPort = 443
    PublishedPort = 4443

.. Finding the number of tasks running as part of a service

サービスを形成する実行中のタスク数を調べる
--------------------------------------------------

.. The --format option can be used to obtain specific information about a service. For example, the following command outputs the number of replicas of the "redis" service.

サービスに関する特定の情報を取得するには、``--format`` オプションが使えます。たとえば、次のコマンドは「redis」サービスのレプリカ数を表示します。

.. code-block:: bash

   $ docker service inspect --format='{{.Spec.Mode.Replicated.Replicas}}' redis
   10

関連情報
----------

* :doc:`service_create`
* :doc:`service_ls`
* :doc:`service_rm`
* :doc:`service_scale`
* :doc:`service_tasks`
* :doc:`service_update`

.. seealso:: 

   service inspect
      https://docs.docker.com/engine/reference/commandline/service_inspect/

