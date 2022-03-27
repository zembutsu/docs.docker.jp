.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/save/
.. SOURCE:
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/save.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_save.yaml
.. check date: 2022/03/26
.. Commits on Aug 22, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker save

=======================================
docker save
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _docker_save-description:

説明
==========

.. Save one or more images to a tar archive (streamed to STDOUT by default)

1つまたは複数のイメージを tar アーカイブに保存（デフォルトでは STDOUT にストリーミング）

.. _docker_save-usage:

使い方
==========

.. code-block:: bash

   $ docker save [OPTIONS] IMAGE [IMAGE...]

.. Extended description
.. _docker_save-extended-description:

補足説明
==========

.. Produces a tarred repository to the standard output stream. Contains all parent layers, and all tags + versions, or specified repo:tag, for each argument provided.

tar 化されたリポジトリを、標準出力にストリーミングします。ここには全ての親レイヤが含まれ、全てのタグとバージョンだけでなく、 ``リポジトリ名:タグ`` が指定されれば、それぞれの引数に応じて出力します。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <docker_save-examples>` をご覧ください。

.. _docker_save-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--output`` , ``-o``
     - 
     - STDOUT の代わりにファイルに書き出し


.. Examples
.. _docker_save-examples:

使用例
==========

.. Create a backup that can then be used with docker load.
.. _docker_save-create-a-backup-that-can-then-be-used-with-docker-load:
``docker load`` で利用できるバックアップを作成
--------------------------------------------------

.. code-block:: bash

   $ docker save busybox > busybox.tar
   
   $ ls -sh busybox.tar
   
   2.7M busybox.tar
   
   $ docker save --output busybox.tar busybox
   
   $ ls -sh busybox.tar
   
   2.7M busybox.tar
   
   $ docker save -o fedora-all.tar fedora
   
   $ docker save -o fedora-latest.tar fedora:latest

.. Save an image to a tar.gz file using gzip
.. _docker_save-save-an-image-to-a-tar.gz-file-using-gzip:
gzip を使って tar.gz ファイルにイメージを保存
--------------------------------------------------

.. You can use gzip to save the image file and make the backup smaller.

.. code-block:: bash

   $ docker save myimage:latest | gzip > myimage_latest.tar.gz

.. Cherry-pick particular tags
.. _docker_save-cherry-pick-particular-tags:
特定のタグを選択
-----------------------

.. You can even cherry-pick particular tags of an image repository.

イメージのリポジトリで、適切なタグの指定もできます。

.. code-block:: bash

   $ docker save -o ubuntu.tar ubuntu:lucid ubuntu:saucy


親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI の基本コマンド

.. seealso:: 

   docker save
      https://docs.docker.com/engine/reference/commandline/save/

