.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/load/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/load.md
   doc version: 1.11
      https://github.com/docker/docker/commits/master/docs/reference/commandline/load.md
.. check date: 2016/04/26
.. Commits on Mar 25, 2016 610ec8c7396ea4cc20465b99cf326684c82d23ff
.. -------------------------------------------------------------------

.. load

=======================================
load
=======================================

.. code-block:: bash

   使い方: docker load [オプション]
   
   tar アーカイブまたは STDIN （標準入力）からイメージを読み込む
   
     --help             使い方の表示
     -i, --input=""     STDIN ではなく、tar アーカイブ・ファイルから読み込む。tar は gzip、bzip、 xz で圧縮されている場合がある
     -q, --quiet        読み込み時に出力を抑制。オプションを指定しなければ、進捗バーを表示
   
.. Loads a tarred repository from a file or the standard input stream. Restores both images and tags.

ファイルか標準入力のストリームから tar 化されたリポジトリを読み込み（load）ます。イメージとタグを復元します。

.. code-block:: bash

   $ docker images
   REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
   $ docker load < busybox.tar.gz
   $ docker images
   REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
   busybox             latest              769b9341d937        7 weeks ago         2.489 MB
   $ docker load --input fedora.tar
   $ docker images
   REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
   busybox             latest              769b9341d937        7 weeks ago         2.489 MB
   fedora              rawhide             0d20aec6529d        7 weeks ago         387 MB
   fedora              20                  58394af37342        7 weeks ago         385.5 MB
   fedora              heisenbug           58394af37342        7 weeks ago         385.5 MB
   fedora              latest              58394af37342        7 weeks ago         385.5 MB
   
.. seealso:: 

   load
      https://docs.docker.com/engine/reference/commandline/load/

