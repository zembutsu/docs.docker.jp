.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/node_inspect/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/node_inspect.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_node_inspect.yaml
.. check date: 2022/03/29
.. Commits on Oct 12, 2021 ed135fe151ad43ca1093074c8fbf52243402013a
.. -------------------------------------------------------------------

.. docker node inspect

=======================================
dokcer node inspect
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _node_inspect-description:

説明
==========

.. Display detailed information on one or more nodes

1つまたは複数ノードの詳細情報を表示します。

.. API 1.24+
   Open the 1.24 API reference (in a new window)
   The client and daemon API must both be at least 1.24 to use this command. Use the docker version command on the client to check your client and daemon API versions.
   Swarm This command works with the Swarm orchestrator.

【API 1.24+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.24 <https://docs.docker.com/engine/api/v1.24/>`_ の必要があります。クライアントとデーモン API のバージョンを調べるには、 ``docker version`` コマンドを使います。

【Swarm】このコマンドは Swarm オーケストレータで動作します。


.. _node_inspect-usage:

使い方
==========

.. code-block:: bash

   $ docker node inspect [OPTIONS] self|NODE [NODE...]

.. Extended description
.. _node_inspect-extended-description:

補足説明
==========

.. Returns information about a node. By default, this command renders all results in a JSON array. You can specify an alternate format to execute a given template for each result. Go's text/template package describes all the details of the format.

ノードに関する情報を返します。デフォルトでは、このコマンドはすべて JSON アレイで返します。あるいは、結果ごとにテンプレートを指定し、別の書式で表示できます。書式については Go 言語の `text/template <http://golang.org/pkg/text/template/>`_ パッケージの説明をご覧ください。

..    Note
    This is a cluster management command, and must be executed on a swarm manager node. To learn about managers and workers, refer to the Swarm mode section in the documentation.

.. note::

   これはクラスタ管理コマンドであり、 swarm manager ノードで実行する必要があります。manager と worker について学ぶには、ドキュメント内の :doc:`Swarm モードのセクション </engine/swarm/index>` を参照ください。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <node_inspect-examples>` をご覧ください。

.. _node_inspect-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--format`` , ``-f``
     - 
     - 指定した Go テンプレートを使って出力を整形
   * - ``--pretty``
     - 
     - 人間が読みやすい形式で情報を表示


.. _node_inspect-examples:

使用例
==========

.. Inspect a node
.. _node_inspect-inspect-a-node:
ノードを調査
--------------------

.. code-block:: bash

   $ docker node inspect swarm-manager

.. code-block:: json

   [
     {
       "ID": "e216jshn25ckzbvmwlnh5jr3g",
       "Version": {
         "Index": 10
       },
       "CreatedAt": "2017-05-16T22:52:44.9910662Z",
       "UpdatedAt": "2017-05-16T22:52:45.230878043Z",
       "Spec": {
         "Role": "manager",
         "Availability": "active"
       },
       "Description": {
         "Hostname": "swarm-manager",
         "Platform": {
           "Architecture": "x86_64",
           "OS": "linux"
         },
         "Resources": {
           "NanoCPUs": 1000000000,
           "MemoryBytes": 1039843328
         },
         "Engine": {
           "EngineVersion": "17.06.0-ce",
           "Plugins": [
             {
               "Type": "Volume",
               "Name": "local"
             },
             {
               "Type": "Network",
               "Name": "overlay"
             },
             {
               "Type": "Network",
               "Name": "null"
             },
             {
               "Type": "Network",
               "Name": "host"
             },
             {
               "Type": "Network",
               "Name": "bridge"
             },
             {
               "Type": "Network",
               "Name": "overlay"
             }
           ]
         },
         "TLSInfo": {
           "TrustRoot": "-----BEGIN CERTIFICATE-----\nMIIBazCCARCgAwIBAgIUOzgqU4tA2q5Yv1HnkzhSIwGyIBswCgYIKoZIzj0EAwIw\nEzERMA8GA1UEAxMIc3dhcm0tY2EwHhcNMTcwNTAyMDAyNDAwWhcNMzcwNDI3MDAy\nNDAwWjATMREwDwYDVQQDEwhzd2FybS1jYTBZMBMGByqGSM49AgEGCCqGSM49AwEH\nA0IABMbiAmET+HZyve35ujrnL2kOLBEQhFDZ5MhxAuYs96n796sFlfxTxC1lM/2g\nAh8DI34pm3JmHgZxeBPKUURJHKWjQjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMB\nAf8EBTADAQH/MB0GA1UdDgQWBBS3sjTJOcXdkls6WSY2rTx1KIJueTAKBggqhkjO\nPQQDAgNJADBGAiEAoeVWkaXgSUAucQmZ3Yhmx22N/cq1EPBgYHOBZmHt0NkCIQC3\nzONcJ/+WA21OXtb+vcijpUOXtNjyHfcox0N8wsLDqQ==\n-----END CERTIFICATE-----\n",
           "CertIssuerSubject": "MBMxETAPBgNVBAMTCHN3YXJtLWNh",
           "CertIssuerPublicKey": "MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAExuICYRP4dnK97fm6OucvaQ4sERCEUNnkyHEC5iz3qfv3qwWV/FPELWUz/aACHwMjfimbcmYeBnF4E8pRREkcpQ=="
         }
       },
       "Status": {
         "State": "ready",
         "Addr": "168.0.32.137"
       },
       "ManagerStatus": {
         "Leader": true,
         "Reachability": "reachable",
         "Addr": "168.0.32.137:2377"
       }
     }
   ]

.. Specify an output format🔗
.. _node_inspect-specify-an-output-format:
出力形式の指定
--------------------

.. code-block:: bash

   $ docker node inspect --format '{{ .Manager.Raft.Status.Leader }}' self
   
   false

.. Use --format=pretty or the --pretty shorthand to pretty-print the output:

``--format=pretty`` か ``--prety`` 省略形を使うと、出力を読みやすくします。

.. code-block:: bash

   $ docker node inspect --format=pretty self
   ID:                     e216jshn25ckzbvmwlnh5jr3g
   Hostname:               swarm-manager
   Joined at:              2017-05-16 22:52:44.9910662 +0000 utc
   Status:
    State:                 Ready
    Availability:          Active
    Address:               172.17.0.2
   Manager Status:
    Address:               172.17.0.2:2377
    Raft Status:           Reachable
    Leader:                Yes
   Platform:
    Operating System:      linux
    Architecture:          x86_64
   Resources:
    CPUs:                  4
    Memory:                7.704 GiB
   Plugins:
     Network:              overlay, bridge, null, host, overlay
     Volume:               local
   Engine Version:         17.06.0-ce
   TLS Info:
    TrustRoot:
   -----BEGIN CERTIFICATE-----
   MIIBazCCARCgAwIBAgIUOzgqU4tA2q5Yv1HnkzhSIwGyIBswCgYIKoZIzj0EAwIw
   EzERMA8GA1UEAxMIc3dhcm0tY2EwHhcNMTcwNTAyMDAyNDAwWhcNMzcwNDI3MDAy
   NDAwWjATMREwDwYDVQQDEwhzd2FybS1jYTBZMBMGByqGSM49AgEGCCqGSM49AwEH
   A0IABMbiAmET+HZyve35ujrnL2kOLBEQhFDZ5MhxAuYs96n796sFlfxTxC1lM/2g
   Ah8DI34pm3JmHgZxeBPKUURJHKWjQjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMB
   Af8EBTADAQH/MB0GA1UdDgQWBBS3sjTJOcXdkls6WSY2rTx1KIJueTAKBggqhkjO
   PQQDAgNJADBGAiEAoeVWkaXgSUAucQmZ3Yhmx22N/cq1EPBgYHOBZmHt0NkCIQC3
   zONcJ/+WA21OXtb+vcijpUOXtNjyHfcox0N8wsLDqQ==
   -----END CERTIFICATE-----
    Issuer Public Key: MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAExuICYRP4dnK97fm6OucvaQ4sERCEUNnkyHEC5iz3qfv3qwWV/FPELWUz/aACHwMjfimbcmYeBnF4E8pRREkcpQ==
    Issuer Subject:    MBMxETAPBgNVBAMTCHN3YXJtLWNh


.. Parent command

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker node <node>`
     - Swarm ノードを管理


.. Related commands

関連コマンド
====================

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker node demote<node_demote>`
     - swarm 内の manager から1つまたは複数のノードを :ruby:`降格 <demote>`
   * - :doc:`docker node inspect<node_inspect>`
     - 1つまたは複数ノードの詳細情報を表示
   * - :doc:`docker node ls<node_ls>`
     - swarm 内のノードを一覧表示
   * - :doc:`docker node promote<node_promote>`
     - swarm 内の1つまたは複数のノードを manager に :ruby:`昇格 <promote>`
   * - :doc:`docker node ps<node_ps>`
     - 1つまたは複数のノード上で実行しているタスク一覧を表示。デフォルトは現在のノード上
   * - :doc:`docker node rm<node_rm>`
     - swarm 内の1つまたは複数のノードを削除
   * - :doc:`docker node update<node_update>`
     - ノードを更新


.. seealso:: 

   dokcer node inspect
      https://docs.docker.com/engine/reference/commandline/node_inspect/

