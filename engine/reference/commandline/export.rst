.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/export/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/export.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/export.md
.. check date: 2016/06/16
.. Commits on Jun 14, 2016 8eca8089fa35f652060e86906166dabc42e556f8
.. -------------------------------------------------------------------

.. export

=======================================
export
=======================================

.. code-block:: bash

   使い方: docker export [オプション] コンテナ
   
   コンテナのファイルシステム内容を tar アーカイブとして出力
   
     --help             使い方の表示
     -o, --output=""    STDOUT（標準出力）ではなくファイルに書き出し

.. The docker export command does not export the contents of volumes associated with the container. If a volume is mounted on top of an existing directory in the container, docker export will export the contents of the underlying directory, not the contents of the volume.

``docker export`` コマンドは、コンテナに関連づけられているボリュームに含まれる内容を出力しません。もしボリュームがコンテナ内にある既存ディレクトリの上位にマウントされている場合は、 ``docker export`` は *配下にある* ディレクトリを出力しますが、ボリュームの内容は含みません。

.. Refer to Backup, restore, or migrate data volumes in the user guide for examples on exporting data in a volume.

詳細はユーザ・ガイドの :ref:`データ・ボリュームのバックアップ、移行、レストア <backup-restore-or-migrate-data-volumes>` にある、ボリューム上のデータの出力についてをご覧ください。

.. Examples

.. _examples:

例
==========

.. code-block:: bash

   $ docker export red_panda > latest.tar

.. Or

または

.. code-block:: bash

   $ docker export --output="latest.tar" red_panda

.. seealso:: 

   export
      https://docs.docker.com/engine/reference/commandline/export/
