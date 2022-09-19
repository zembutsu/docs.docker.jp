.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/node_update/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/node_update.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_node_update.yaml
.. check date: 2022/03/31
.. Commits on Aug 21, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker node update

=======================================
docker node update
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _node_update-description:

説明
==========

.. Update a node

ノードを更新します。

.. API 1.24+
   Open the 1.24 API reference (in a new window)
   The client and daemon API must both be at least 1.24 to use this command. Use the docker version command on the client to check your client and daemon API versions.
   Swarm This command works with the Swarm orchestrator.

【API 1.24+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.24 <https://docs.docker.com/engine/api/v1.24/>`_ の必要があります。クライアントとデーモン API のバージョンを調べるには、 ``docker version`` コマンドを使います。

【Swarm】このコマンドは Swarm オーケストレータで動作します。


.. _node_update-usage:

使い方
==========

.. code-block:: bash

   $ docker node update [OPTIONS] NODE

.. Extended description
.. _node_update-extended-description:

補足説明
==========

.. Update metadata about a node, such as its availability, labels, or roles.

ノードに関するメタデータである avaiability、labels、roles を更新します。

..    Note
    This is a cluster management command, and must be executed on a swarm manager node. To learn about managers and workers, refer to the Swarm mode section in the documentation.

.. note::

   これはクラスタ管理コマンドであり、 swarm manager ノードで実行する必要があります。manager と worker について学ぶには、ドキュメント内の :doc:`Swarm モードのセクション </engine/swarm/index>` を参照ください。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <node_update-examples>` をご覧ください。

.. _node_update-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--availability``
     - 
     - ノードの可用性（ ``active`` | ``pause`` | ``drain`` ）
   * - ``--label-add``
     - 
     - ノードラベルの追加や更新（ key=value ）
   * - ``--label-rm``
     - 
     - ノードのラベルが存在する場合に削除
   * - ``--role``
     - 
     - ノードの役割（ ``worker`` | ``manager`` ）


.. _node_update-examples:

使用例
==========

.. Add label metadata to a node
.. _node_update-add-label-metadata-to-a-node:
ノードに label メタデータを追加
----------------------------------------

.. Add metadata to a swarm node using node labels. You can specify a node label as a key with an empty value:

ノード・ラベルを使い、swarm ノードにメタデータを追加します。ノード・ラベル には、値を持たないキーを指定できます。

.. code-block:: bash

   $ docker node update --label-add foo worker1

.. To add multiple labels to a node, pass the --label-add flag for each label:

ノードに複数のラベルを指定するには、ラベルごとに ``--label-add`` フラグを渡します。

.. code-block:: bash

   $ docker node update --label-add foo --label-add bar worker1

.. When you create a service, you can use node labels as a constraint. A constraint limits the nodes where the scheduler deploys tasks for a service.

:doc:`サービスの作成 <service_craete>` 時、制約に関するノード・ラベルを指定できます。ノードの制約によって、スケジューラがどのノードにサービス用のタスクをデプロイするかを制限します。

.. For example, to add a type label to identify nodes where the scheduler should deploy message queue service tasks:

たとえば、メッセージキューのサービスタスクをスケジューラにデプロイさせたいノードを区別するため、 ``type`` ラベルを追加します。

.. code-block:: bash

   $ docker node update --label-add type=queue worker1

.. The labels you set for nodes using docker node update apply only to the node entity within the swarm. Do not confuse them with the docker daemon labels for dockerd.

``docker node update`` を使ってノードにラベルを指定できるのは、ノードが swarm 内に所属している場合のみです。 :doc:`dockerd <dockerd>` 用の docker デーモンのラベルと混同しないでください。

.. For more information about labels, refer to apply custom metadata.

ラベルに関する詳しい情報は :doc:`カスタム・メタデータの適用 </engine/userguide/labels-custom-metadata>` をご覧ください。

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

   docker node update
      https://docs.docker.com/engine/reference/commandline/node_update/

