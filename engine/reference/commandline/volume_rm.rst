.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/volume_rm/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/volume_rm.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_volume_rm.yaml
.. check date: 2022/04/05
.. Commits on Aug 21, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker volume rm

=======================================
docker volume rm
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _volume_rm-description:

説明
==========

.. Remove one or more volumes

1つまたは複数のボリュームを削除します。

.. API 1.21+
   Open the 1.21 API reference (in a new window)
   The client and daemon API must both be at least 1.25 to use this command. Use the docker version command on the client to check your client and daemon API versions.

【API 1.21+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.25 <https://docs.docker.com/engine/api/v1.21/>`_ の必要があります。クライアントとデーモン API のバージョンを調べるには、 ``docker version`` コマンドを使います。


.. _volume_rm-usage:

使い方
==========

.. code-block:: bash

   $ docker volume rm [OPTIONS] VOLUME [VOLUME...]

.. Extended description
.. _volume_rm-extended-description:

補足説明
==========

.. Removes one or more volumes. You cannot remove a volume that is in use by a container.

１つまたは複数のボリュームを削除できます。コンテナが使用中のボリュームは削除できません。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <volume_rm-examples>` をご覧ください。

.. _volume_rm-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--force`` , ``-f``
     - 
     - 【API 1.25+】確認のプロンプトを表示しない

.. Examples
.. _volume_rm-examples:

使用例
==========

.. code-block:: bash

   $ docker volume rm hello
   
   hello



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

   docker volume rm
      https://docs.docker.com/engine/reference/commandline/volume_rm/
