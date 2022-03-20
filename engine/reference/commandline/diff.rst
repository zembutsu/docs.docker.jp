.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/diff/
.. SOURCE:
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/diff.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_diff.yaml
.. check date: 2022/03/20
.. Commits on Aug 22, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker diff

=======================================
docker diff
=======================================

.. seealso:: 

   :doc:`docker container diff <container_diff`

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _docker_diff-description:

説明
==========

.. Inspect changes to files or directories on a container’s filesystem

コンテナのファイルシステム上で、ファイルやディレクトリの変更を調査します。

.. _docker_diff-usage:

使い方
==========

.. code-block:: bash

   $ docker diff CONTAINER

.. Extended description
.. _docker_diff-extended-description:

補足説明
==========

.. List the changed files and directories in a container᾿s filesystem since the container was created. Three different types of change are tracked:

コンテナを作成後、コンテナのファイルシステム上で、変更したファイルやディレクトリの一覧を表示します。3つの異なる変更を追跡します。

.. list-table::
   :header-rows: 1

   * - 記号
     - 説明
   * - ``A``
     - ファイルまたはディレクトリが :ruby:`追加 <added>` された
   * - ``D``
     - ファイルまたはディレクトリが :ruby:`削除 <deleted>` された
   * - ``C``
     - ファイルまたはディレクトリが :ruby:`変更 <changed>` された

.. You can use the full or shortened container ID or the container name set using docker run --name option.

利用できるのは、コンテナ ID の全て、もしくは短縮形、あるいは ``docker run --name`` オプションで設定したコンテナ名です。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <docker_diff-examples>` をご覧ください。

.. Examples
.. _docker_diff-examples:

使用例
==========

.. Inspect the changes to an nginx container:

``nginx`` コンテナに対する変更を調査します：

.. code-block:: bash

    $ docker diff 1fdfd1f54c1b
    C /dev
    C /dev/console
    C /dev/core
    C /dev/stdout
    C /dev/fd
    C /dev/ptmx
    C /dev/stderr
    C /dev/stdin
    C /run
    A /run/nginx.pid
    C /var/lib/nginx/tmp
    A /var/lib/nginx/tmp/client_body
    A /var/lib/nginx/tmp/fastcgi
    A /var/lib/nginx/tmp/proxy
    A /var/lib/nginx/tmp/scgi
    A /var/lib/nginx/tmp/uwsgi
    C /var/log/nginx
    A /var/log/nginx/access.log
    A /var/log/nginx/error.log


親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI の基本コマンド


.. seealso:: 

   docker diff
      https://docs.docker.com/engine/reference/commandline/docker diff/
