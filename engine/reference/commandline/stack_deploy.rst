.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/stack_deploy/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/stack_deploy.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_stack_deploy.yaml
.. check date: 2022/04/09
.. Commits on Jul 2, 2021 590463d6ce75c5ad02358998efee34a9fd358f6b
.. -------------------------------------------------------------------

.. docker stack deploy

=======================================
docker stack depoy
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _stack_deploy-description:

説明
==========

.. Deploy a new stack or update an existing stack

 新しいスタックをデプロイするか、既存のスタックを更新します。

.. API 1.25+
   Open the 1.25 API reference (in a new window)
   The client and daemon API must both be at least 1.25 to use this command. Use the docker version command on the client to check your client and daemon API versions.

【API 1.25+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.25 <https://docs.docker.com/engine/api/v1.25/>`_ の必要があります。クライアントとデーモン API のバージョンを調べるには、 ``docker version`` コマンドを使います。


.. _stack_deploy-usage:

使い方
==========

.. code-block:: bash

   $ docker stack deploy [OPTIONS] STACK

.. Extended description
.. _stack_deploy-extended-description:

補足説明
==========

.. Create and update a stack from a compose file on the swarm.

``compose`` ファイルから読み込んだスタックを、 swarm 上に作成または更新します。

..    Note
    This is a cluster management command, and must be executed on a swarm manager node. To learn about managers and workers, refer to the Swarm mode section in the documentation.

.. note::

   これはクラスタ管理コマンドであり、 swarm manager ノードで実行する必要があります。manager と worker について学ぶには、ドキュメント内の :doc:`Swarm モードのセクション </engine/swarm/index>` を参照ください。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <stack_deploy-examples>` をご覧ください。

.. _stack_deploy-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--compose-file`` , ``-c``
     - 
     - 【API 1.25+】 Compose ファイルのパスか、 ``-`` で標準入力から読み込む
   * - ``--namespaces``
     - 
     - 【deprecated】【Kubernetes】使用する Kubernetes 名前空間
   * - ``--prune``
     - 
     - 【API 1.27+】【Swarm】参照されていないサービスを削除
   * - ``--resolve-image``
     - ``always``
     - イメージのダイジェスト値とサポートしているプラットフォームを、レジストリに照会（ ``always`` | ``changed`` | ``never`` ）
   * - ``--with-registry-auth``
     - 
     - 【Swarm】Swarm エージェントにレジストリの認証情報を送信
   * - ``--kubeconfig``
     - 
     - 【非推奨】【Kubernetes】Kubernetes 設定ファイル
   * - ``--orchestrator``
     - 
     - 【非推奨】使用するオーケストレータ（ swarm | kubernetes | all）

.. _stack_deploy-examples:

使用例
==========

Compose ファイル
--------------------

.. The deploy command supports compose file version 3.0 and above.

``deploy`` コマンドは compose ファイル形式 ``3.0`` 以上をサポートします。

.. code-block:: bash

   $ docker stack deploy --compose-file docker-compose.yml vossibility
   
   Ignoring unsupported options: links
   
   Creating network vossibility_vossibility
   Creating network vossibility_default
   Creating service vossibility_nsqd
   Creating service vossibility_logstash
   Creating service vossibility_elasticsearch
   Creating service vossibility_kibana
   Creating service vossibility_ghollector
   Creating service vossibility_lookupd

.. The Compose file can also be provided as standard input with --compose-file -:

また、  ``--compose-file -`` を使えば、Compose ファイルを標準入力経由でも指定できます。

.. code-block:: bash

   $ cat docker-compose.yml | docker stack deploy --compose-file - vossibility
   
   Ignoring unsupported options: links
   
   Creating network vossibility_vossibility
   Creating network vossibility_default
   Creating service vossibility_nsqd
   Creating service vossibility_logstash
   Creating service vossibility_elasticsearch
   Creating service vossibility_kibana
   Creating service vossibility_ghollector
   Creating service vossibility_lookupd

.. If your configuration is split between multiple Compose files, e.g. a base configuration and environment-specific overrides, you can provide multiple --compose-file flags.

基本となる設定ファイルと、環境変数を上書きする設定ファイルのように、複数の Compose ファイルに設定が分割されている場合は、複数の ``--compose-file`` フラグを指定できます。

.. code-block:: bash

   $ docker stack deploy --compose-file docker-compose.yml -c docker-compose.prod.yml vossibility
   
   Ignoring unsupported options: links
   
   Creating network vossibility_vossibility
   Creating network vossibility_default
   Creating service vossibility_nsqd
   Creating service vossibility_logstash
   Creating service vossibility_elasticsearch
   Creating service vossibility_kibana
   Creating service vossibility_ghollector
   Creating service vossibility_lookupd

.. You can verify that the services were correctly created:

サービスが正しく作成されているかどうか、確認できます。

.. code-block:: bash

   $ docker service ls
   
   ID            NAME                               MODE        REPLICAS  IMAGE
   29bv0vnlm903  vossibility_lookupd                replicated  1/1       nsqio/nsq@sha256:eeba05599f31eba418e96e71e0984c3dc96963ceb66924dd37a47bf7ce18a662
   4awt47624qwh  vossibility_nsqd                   replicated  1/1       nsqio/nsq@sha256:eeba05599f31eba418e96e71e0984c3dc96963ceb66924dd37a47bf7ce18a662
   4tjx9biia6fs  vossibility_elasticsearch          replicated  1/1       elasticsearch@sha256:12ac7c6af55d001f71800b83ba91a04f716e58d82e748fa6e5a7359eed2301aa
   7563uuzr9eys  vossibility_kibana                 replicated  1/1       kibana@sha256:6995a2d25709a62694a937b8a529ff36da92ebee74bafd7bf00e6caf6db2eb03
   9gc5m4met4he  vossibility_logstash               replicated  1/1       logstash@sha256:2dc8bddd1bb4a5a34e8ebaf73749f6413c101b2edef6617f2f7713926d2141fe
   axqh55ipl40h  vossibility_vossibility-collector  replicated  1/1       icecrime/vossibility-collector@sha256:f03f2977203ba6253988c18d04061c5ec7aab46bca9dfd89a9a1fa4500989fba


.. Parent command

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker stack <stack>`
     - Docker stack を管理

.. Related commands

関連コマンド
====================

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker stack deploy<stack_deploy>`
     - 新しいスタックをデプロイするか、既存のスタックを更新
   * - :doc:`docker stack ls<stack_ls>`
     - スタックを一覧表示
   * - :doc:`docker stack ps<stack_ps>`
     - スタック内のタスクを一覧表示
   * - :doc:`docker stack rm<stack_rm>`
     - 1つまたは複数スタックを削除
   * - :doc:`docker stack services<stack_services>`
     - タスク内のサービスを一覧表示


.. seealso:: 

   docker stack deploy
      https://docs.docker.com/engine/reference/commandline/stack_deploy/
