.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/secret_rm/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/secret_rm.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_secret_rm.yaml
.. check date: 2022/04/02
.. Commits on Aug 21, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker secret ls

=======================================
docker secret rm
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _secret_rm-description:

説明
==========

.. Remove one or more secrets

1つまたは複数のシークレットを削除します。

.. API 1.25+
   Open the 1.25 API reference (in a new window)
   The client and daemon API must both be at least 1.25 to use this command. Use the docker version command on the client to check your client and daemon API versions.
   Swarm This command works with the Swarm orchestrator.


- 【API 1.25+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.25 <https://docs.docker.com/engine/api/v1.25/>`_ の必要があります。クライアントとデーモン API のバージョンを調べるには、 ``docker version`` コマンドを使います。
- 【Swarm】このコマンドは Swarm オーケストレータと動作します。


.. _secret_rm-usage:

使い方
==========

.. code-block:: bash

   $ docker secret rm SECRET [SECRET...]

.. Extended description
.. _secret_rm-extended-description:

補足説明
==========

.. Removes the specified secrets from the swarm.

swarm から指定したシークレットを削除します。

.. For detailed information about using secrets, refer to manage sensitive data with Docker secrets.

シークレットの利用に関する詳細情報は、 :doc:`Docker シークレットで機微データを管理 </engine/swarm/secrets>` をご覧ください。

..    Note
    This is a cluster management command, and must be executed on a swarm manager node. To learn about managers and workers, refer to the Swarm mode section in the documentation.

.. note::

   これはクラスタ管理コマンドであり、 swarm manager ノードで実行する必要があります。manager と worker について学ぶには、ドキュメント内の :doc:`Swarm モードのセクション </engine/swarm/index>` を参照ください。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <secret_rm-examples>` をご覧ください。

.. _secret_rm-examples:

使用例
==========

.. code-block:: bash

   $ docker secret rm secret.json
   sapth4csdo5b6wz2p5uimh5xg

..    Warning
    Unlike docker rm, this command does not ask for confirmation before removing a secret.

.. warning::

   ``docker rm`` とは異なり、このコマンドはシークレットを削除する前に確認を表示しません。


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

   docker secret rm
      https://docs.docker.com/engine/reference/commandline/secret_rm/
