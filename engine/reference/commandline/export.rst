.. -*- coding: utf-8 -*-
.. https://docs.docker.com/engine/reference/commandline/export/
.. doc version: 1.9
.. check date: 2015/12/26
.. -----------------------------------------------------------------------------

.. export

=======================================
export
=======================================

.. code-block:: bash

   Usage: docker export [OPTIONS] CONTAINER
   
   Export the contents of a container's filesystem as a tar archive
   
     --help=false       Print usage
     -o, --output=""    Write to a file, instead of STDOUT

.. The docker export command does not export the contents of volumes associated with the container. If a volume is mounted on top of an existing directory in the container, docker export will export the contents of the underlying directory, not the contents of the volume.

``docker export`` コマンドは、コンテナに関連づけられているボリュームに含まれる内容を出力しません。もしボリュームがコンテナ内の既存のディレクトリの上位にマウントされている場合は、 ``docker export`` は *配下にある* ディレクトリ出力しますが、ボリュームの内容は含みません。

.. Refer to Backup, restore, or migrate data volumes in the user guide for examples on exporting data in a volume.

詳細はユーザ・ガイドの :doc:`データ・ボリュームのバックアップ、移行、レストア <backup-restore-or-migrate-data-volumes>` の、ボリューム上のデータの出力をご覧ください。

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
