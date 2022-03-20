.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/export/
.. SOURCE
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/export.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_export.yaml
.. check date: 2022/03/20
.. Commits on Aug 22, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker export

=======================================
docker export
=======================================

.. seealso:: 

   :doc:`docker container export <container_export>`

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _docker_export-description:

説明
==========

.. Export a container’s filesystem as a tar archive

コンテナのファイルシステムを tar アーカイブとして :ruby:`出力 <export>` します。

.. _docker_export-usage:

使い方
==========

.. code-block:: bash

   $ docker export [OPTIONS] CONTAINER

.. Extended description
.. _docker_export-extended-description:

補足説明
==========

.. The docker export command does not export the contents of volumes associated with the container. If a volume is mounted on top of an existing directory in the container, docker export will export the contents of the underlying directory, not the contents of the volume.

``docker export`` コマンドは、コンテナに関連づけられているボリュームに含まれる内容を出力しません。もしボリュームがコンテナ内の既存ディレクトリ上をマウントしている場合は、 ``docker export`` は *元々あった* ディレクトリ内容を出力しますが、ボリュームの内容は出力しません。

.. Refer to Backup, restore, or migrate data volumes in the user guide for examples on exporting data in a volume.

詳細はユーザ・ガイドの :ref:`データ・ボリュームのバックアップ、移行、レストア <backup-restore-or-migrate-data-volumes>` にある、ボリューム上のデータの出力についてをご覧ください。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <docker_export-examples>` をご覧ください。


.. _docker_export-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--output`` , ``-o``
     - 
     - 標準出力の代わりに、ファイルに書き出す

.. Examples
.. _docker_export-examples:

使用例
==========

.. Each of these commands has the same result.

どちらのコマンドも、結果は同じです。

.. code-block:: bash

   $ docker export red_panda > latest.tar

.. code-block:: bash

   $ docker export --output="latest.tar" red_panda


親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI の基本コマンド


.. seealso:: 

   docker export
      https://docs.docker.com/engine/reference/commandline/export/
