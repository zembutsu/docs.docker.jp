.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/volume_prune/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/volume_prune.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_volume_prune.yaml
.. check date: 2022/04/05
.. Commits on Aug 21, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker volume prune

=======================================
docker volume prune
=======================================


.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _volume_prune-description:

説明
==========

.. Remove all unused local volumes

使用していないローカルボリュームを削除します。

.. API 1.21+
   Open the 1.21 API reference (in a new window)
   The client and daemon API must both be at least 1.25 to use this command. Use the docker version command on the client to check your client and daemon API versions.

【API 1.21+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.25 <https://docs.docker.com/engine/api/v1.21/>`_ の必要があります。クライアントとデーモン API のバージョンを調べるには、 ``docker version`` コマンドを使います。


.. _volume_prune-usage:

使い方
==========

.. code-block:: bash

   $ docker volume prune [OPTIONS]

.. Extended description
.. _volume_prune-extended-description:

補足説明
==========

.. Remove all unused local volumes. Unused local volumes are those which are not referenced by any containers

未使用のローカルボリュームを全て削除します。未使用のボリュームとは、どのコンテナからも参照されていないボリュームです。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <volume_prune-examples>` をご覧ください。

.. _volume_prune-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--filter``
     - 
     - フィルタ値を指定（例 ``label=<label>`` ）
   * - ``--force`` , ``-f``
     - 
     - 確認のプロンプトを表示しない

.. Examples
.. _volume_prune-examples:

使用例
==========

.. code-block:: bash

   $ docker volume prune
   
   WARNING! This will remove all local volumes not used by at least one container.
   Are you sure you want to continue? [y/N] y
   Deleted Volumes:
   07c7bdf3e34ab76d921894c2b834f073721fccfbbcba792aa7648e3a7a664c2e
   my-named-vol
   
   Total reclaimed space: 36 B



.. Parent command

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <volume>`
     - ボリュームを管理


.. Related commands

関連コマンド
====================

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker volume create<volume_create>`
     - ボリュームの作成
   * - :doc:`docker volume inspect<volume_inspect>`
     - 1つまたは複数ボリュームの詳細情報を表示
   * - :doc:`docker volume ls<volume_ls>`
     - ボリューム一覧表示
   * - :doc:`docker volume prune<volume_prune>`
     - 使用していないローカルボリュームを削除
   * - :doc:`docker volume rm<volume_rm>`
     - 1つまたは複数ボリュームを削除

.. seealso:: 

   docker volume prune
      https://docs.docker.com/engine/reference/commandline/volume_prune/
