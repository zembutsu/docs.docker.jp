.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/unpause/
.. SOURCE:
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/unpause.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_unpause.yaml
.. check date: 2022/03/27
.. Commits on Aug 22, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker unpause

=======================================
docker unpause
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _docker_unpause-description:

説明
==========

.. Unpause all processes within one or more containers

1つまたは複数のコンテナに対する :ruby:`一時停止を解除 <unpause>` します。

.. _docker_unpause-usage:

使い方
==========

.. code-block:: bash

   $ docker unpause CONTAINER [CONTAINER...]

.. Extended description
.. _docker_unpause-extended-description:

補足説明
==========

.. The docker unpause command un-suspends all processes in the specified containers. On Linux, it does this using the freezer cgroup.

``docker unpause`` コマンドは、指定したコンテナ内にある全プロセスの一時停止を解除します。Linux では、この処理に freezer cgroup を使います。

.. See the freezer cgroup documentation for further details.

詳細は `freezer cgroup ドキュメント <https://www.kernel.org/doc/Documentation/cgroup-v1/freezer-subsystem.txt>`_ をご覧ください。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <docker_unpause-examples>` をご覧ください。

.. Examples
.. _docker_unpause-examples:

使用例
==========

.. code-block:: bash

   $ docker unpause my_container
   my_container

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI の基本コマンド

.. seealso:: 

   docker unpause
      https://docs.docker.com/engine/reference/commandline/unpause/
