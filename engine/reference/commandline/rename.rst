.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/rename/
.. SOURCE:
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/rename.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_rename.yaml
.. check date: 2022/03/21
.. Commits on Aug 22, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker rename

=======================================
docker rename
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _docker_rename-description:

説明
==========

.. Rename a container

コンテナの名前を変更します。

.. _docker_rename-usage:

使い方
==========

.. code-block:: bash

   $ docker rename CONTAINER NEW_NAME

.. Extended description
.. _docker_rename-extended-description:

補足説明
==========

.. The docker rename command renames a container.

``docker rename`` コマンドは、コンテナの名前を変更します。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <docker_rename-examples>` をご覧ください。

.. Examples
.. _docker_rename-examples:

使用例
==========

.. code-block:: bash

   $ docker rename my_container my_new_container


親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI の基本コマンド

.. seealso:: 

   docker rename
      https://docs.docker.com/engine/reference/commandline/rename/
