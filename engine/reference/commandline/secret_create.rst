.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/secret_create/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/secret_create.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_secret_create.yaml
.. check date: 2022/04/02
.. Commits on Aug 21, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker secret create

=======================================
docker secret create
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _secret_create-description:

説明
==========

.. Create a secret from a file or STDIN as content

ファイルもしくは STDIN（標準入力）を内容としてシークレットを作成します。

.. API 1.25+
   Open the 1.25 API reference (in a new window)
   The client and daemon API must both be at least 1.25 to use this command. Use the docker version command on the client to check your client and daemon API versions.
   Swarm This command works with the Swarm orchestrator.


- 【API 1.25+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.25 <https://docs.docker.com/engine/api/v1.25/>`_ の必要があります。クライアントとデーモン API のバージョンを調べるには、 ``docker version`` コマンドを使います。
- 【Swarm】このコマンドは Swarm オーケストレータと動作します。


.. _secret_create-usage:

使い方
==========

.. code-block:: bash

   $ docker secret COMMAND

.. Extended description
.. _secret_create-extended-description:

補足説明
==========

.. Creates a secret using standard input or from a file for the secret content.

ファイルもしくは STDIN（標準入力）を内容としてシークレットを作成します。



.. docker secret create [OPTIONS] SECRET [file|-]

:ruby:`シークレット <secret>` を管理します。

..    Note
    This is a cluster management command, and must be executed on a swarm manager node. To learn about managers and workers, refer to the Swarm mode section in the documentation.

.. note::

   これはクラスタ管理コマンドであり、 swarm manager ノードで実行する必要があります。manager と worker について学ぶには、ドキュメント内の :doc:`Swarm モードのセクション </engine/swarm/index>` を参照ください。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <secret_create-examples>` をご覧ください。


.. _secret_create-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--driver`` , ``-d``
     - 
     - 【API 1.31+】ドライバの選択
   * - ``--label`` , ``-l``
     - 
     - ラベルの選択
   * - ``--template-driver``
     - 
     - 【API 1.37+】 テンプレート・ドライバ


.. _secret_create-examples:

使用例
==========

.. Create a secret
.. _secret_create-create-a-secret:

シークレットを作成
--------------------

.. code-block:: bash

   $ printf "my super secret password" | docker secret create my_secret -
   
   onakdyv307se2tl7nl20anokv
   
   $ docker secret ls
   
   ID                          NAME                CREATED             UPDATED
   onakdyv307se2tl7nl20anokv   my_secret           6 seconds ago       6 seconds ago

.. Create a secret with a file
.. _secret_create-create-a-secret-with-a-file:

ファイルでシークレットを作成
------------------------------

.. code-block:: bash

   $ docker secret create my_secret ./secret.json
   
   dg426haahpi5ezmkkj5kyl3sn
   
   $ docker secret ls
   
   ID                          NAME                CREATED             UPDATED
   dg426haahpi5ezmkkj5kyl3sn   my_secret           7 seconds ago       7 seconds ago

.. Create a secret with labels
.. _secret_create-create-a-secret-with-labels:

.. code-block:: bash

   $ docker secret create \
     --label env=dev \
     --label rev=20170324 \
     my_secret ./secret.json
   
   eo7jnzguqgtpdah3cm5srfb97

.. code-block:: bash

  $ docker secret inspect my_secret
  
   [
       {
           "ID": "eo7jnzguqgtpdah3cm5srfb97",
           "Version": {
               "Index": 17
           },
           "CreatedAt": "2017-03-24T08:15:09.735271783Z",
           "UpdatedAt": "2017-03-24T08:15:09.735271783Z",
           "Spec": {
               "Name": "my_secret",
               "Labels": {
                   "env": "dev",
                   "rev": "20170324"
               }
           }
       }
   ]


.. Parent command

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker secret <secret>`
     - Docker シークレットを管理


.. Related commands

関連コマンド
====================

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker secret create<secret_create>`
     - ファイルもしくは STDIN（標準入力）を内容としてシークレットを作成
   * - :doc:`docker secret inspect<secret_inspect>`
     - 1つまたは複数シークレットの詳細情報を表示
   * - :doc:`docker secret ls<secret_ls>`
     - シークレット一覧
   * - :doc:`docker secret rm<secret_rm>`
     - 1つまたは複数のシークレットを削除


.. seealso:: 

   docker secret create
      https://docs.docker.com/engine/reference/commandline/secret_create/
