.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/load/
.. SOURCE:
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/load.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_load.yaml
.. check date: 2022/03/21
.. Commits on Aug 22, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker load

=======================================
docker load
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _docker_load-description:

説明
==========

.. Load an image from a tar archive or STDIN

tar アーカイブか STDIN （標準入力）からイメージを :ruby:`取り込み <load>` ます。

.. _docker_load-usage:

使い方
==========

.. code-block:: bash

   $ docker load [OPTIONS]

.. Extended description
.. _docker_load-extended-description:

補足説明
==========

.. Load an image or repository from a tar archive (even if compressed with gzip, bzip2, or xz) from a file or STDIN. It restores both images and tags.

ファイルもしくは標準入力を通して、tar アーカイブ（ gzip 、 bzip2 、 xz で圧縮している場合も）からイメージやリポジトリを取り込みます。イメージとタグの両方が復元されます。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <docker_load-examples>` をご覧ください。

.. _docker_load-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--input`` , ``-i``
     - 
     - 標準入力の代わりに、 tar アーカイブのファイルから読み込む
   * - ``--quiet`` , ``-q``
     - 
     - 取り込みの出力を抑制

.. Examples
.. _docker_load-examples:

使用例
==========

.. code-block:: bash

    $ docker image ls
    REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
    
    $ docker load < busybox.tar.gz
    Loaded image: busybox:latest
    
    $ docker images
    REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
    busybox             latest              769b9341d937        7 weeks ago         2.489 MB
    
    $ docker load --input fedora.tar
    Loaded image: fedora:rawhide
    Loaded image: fedora:20
    
    $ docker images
    REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
    busybox             latest              769b9341d937        7 weeks ago         2.489 MB
    fedora              rawhide             0d20aec6529d        7 weeks ago         387 MB
    fedora              20                  58394af37342        7 weeks ago         385.5 MB
    fedora              heisenbug           58394af37342        7 weeks ago         385.5 MB
    fedora              latest              58394af37342        7 weeks ago         385.5 MB



親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI の基本コマンド


.. seealso:: 

   docker load
      https://docs.docker.com/engine/reference/commandline/load/

