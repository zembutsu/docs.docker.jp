.. -*- coding: utf-8 -*-
.. https://docs.docker.com/engine/reference/commandline/diff/
.. doc version: 1.9
.. check date: 2015/12/26
.. -----------------------------------------------------------------------------

.. diff

=======================================
diff
=======================================

.. code-block:: bash

   Usage: docker diff [OPTIONS] CONTAINER
   
   Inspect changes on a container's filesystem
   
     --help=false        Print usage

.. List the changed files and directories in a container᾿s filesystem There are 3 events that are listed in the diff:

コンテナのファイルシステム上で、変更したファイルやディレクトリの一覧を表示します。

.. A - Add
  D - Delete
  C - Change

* ``A`` - 追加（Add）
* ``D`` - 削除（Delete）
* ``C`` - 変更（Change）

.. For example:

実行例：

.. code-block:: bash

   $ docker diff 7bb0e258aefe
   
   C /dev
   A /dev/kmsg
   C /etc
   A /etc/mtab
   A /go
   A /go/src
   A /go/src/github.com
   A /go/src/github.com/docker
   A /go/src/github.com/docker/docker
   A /go/src/github.com/docker/docker/.git
   ....

