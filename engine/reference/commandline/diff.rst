.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/diff/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/diff.md
   doc version: 1.10
      https://github.com/docker/docker/commits/master/docs/reference/commandline/diff.md
.. check date: 2016/02/19
.. -------------------------------------------------------------------

.. diff

=======================================
diff
=======================================

.. code-block:: bash

   Usage: docker diff [OPTIONS] CONTAINER
   
   Inspect changes on a container's filesystem
   
     --help              Print usage

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

.. seealso:: 

   diff
      https://docs.docker.com/engine/reference/commandline/diff/
