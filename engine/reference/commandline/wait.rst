.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/wait/
.. SOURCE:
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/wait.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_wait.yaml
.. check date: 2022/03/27
.. Commits on Aug 22, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker wait

=======================================
docker wait
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _docker_wait-description:

説明
==========

.. Block until one or more containers stop, then print their exit codes

1つまたは複数コンテナが停止するまでブロックし、終了コードを表示します。

.. _docker_wait -usage:

使い方
==========

.. code-block:: bash

   $ docker wait CONTAINER [CONTAINER...]

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <docker_wait-examples>` をご覧ください。

.. Examples
.. _docker_wait-examples:

使用例
==========

.. Start a container in the background.

バックグラウンドでコンテナを起動します。

.. code-block:: bash

   $ docker run -dit --name=my_container ubuntu bash

.. Run docker wait, which should block until the container exits.

``docker wait`` を実行すると、コンテナが終了するまでブロックします。

.. code-block:: bash

   $ docker wait my_container

.. In another terminal, stop the first container. The docker wait command above returns the exit code.

他のターミナルで、1つめのコンテナを停止します。先ほどの ``docker wait`` コマンドは終了コードを返します。

.. code-block:: dockerfile

   $ docker stop my_container

.. This is the same docker wait command from above, but it now exits, returning 0.

こちらは先ほど同じ ``docker wait`` コマンドですが、終了し、 ``0`` を返します。

.. code-block:: dockerfile

   $ docker wait my_container
   0


親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI の基本コマンド


.. seealso:: 

   docker wait
      https://docs.docker.com/engine/reference/commandline/wait/
