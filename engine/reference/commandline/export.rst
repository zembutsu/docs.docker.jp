.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/export/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/export.md
   doc version: 1.10
      https://github.com/docker/docker/commits/master/docs/reference/commandline/export.md
.. check date: 2016/02/19
.. -------------------------------------------------------------------

.. export

=======================================
export
=======================================

.. code-block:: bash

   Usage: docker export [OPTIONS] CONTAINER
   
   Export the contents of a container's filesystem as a tar archive
   
     --help             Print usage
     -o, --output=""    Write to a file, instead of STDOUT

.. The docker export command does not export the contents of volumes associated with the container. If a volume is mounted on top of an existing directory in the container, docker export will export the contents of the underlying directory, not the contents of the volume.

``docker export`` コマンドは、コンテナに関連づけられているボリュームに含まれる内容を出力しません。もしボリュームがコンテナ内にある既存ディレクトリの上位にマウントされている場合は、 ``docker export`` は *配下にある* ディレクトリ出力しますが、ボリュームの内容は含みません。

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
