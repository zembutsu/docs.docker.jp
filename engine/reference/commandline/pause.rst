.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/pause/
.. SOURCE:
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/pause.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_pause.yaml
.. check date: 2022/03/21
.. Commits on Aug 22, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker pause

=======================================
docker pause
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _docker_pause-description:

説明
==========

.. Pause all processes within one or more containers

1 つまたは複数のコンテナ内部で実行しているプロセスを、全て :ruby:`一時停止 <pause>` します。

.. _docker_pause-usage:

使い方
==========

.. code-block:: bash

   $ docker pause CONTAINER [CONTAINER...]

.. Extended description
.. _docker_pause-extended-description:

補足説明
==========

.. The docker pause command suspends all processes in the specified containers. On Linux, this uses the freezer cgroup. Traditionally, when suspending a process the SIGSTOP signal is used, which is observable by the process being suspended. With the freezer cgroup the process is unaware, and unable to capture, that it is being suspended, and subsequently resumed. On Windows, only Hyper-V containers can be paused.



.. See the freezer cgroup documentation for further details.

``docker pause`` コマンドは、指定されたコンテナ内のプロセスをすべてサスペンド（実行停止）します。Linux の場合は freezer cgroup が利用されます。従来より、プロセスの一時停止には ``SIGSTOP`` シグナルが用いられ、そのプロセスの停止によって確認できます。freezer cgroup を用いた場合、一時停止やその後の再開に、プロセスは認識できず、またそのような状態を把握できません。Windows の場合は Hyper-V コンテナのみが一時停止できます。

.. See the cgroups freezer documentation for further details.

更に詳しい情報は `freezer cgroup のドキュメント <https://www.kernel.org/doc/Documentation/cgroup-v1/freezer-subsystem.txt>`_ をご覧ください。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <docker_pause-examples>` をご覧ください。

.. Examples
.. _docker_pause-examples:

使用例
==========

.. code-block:: bash

   $ docker pause my_container


親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI の基本コマンド


.. seealso:: 

   docker pause
      https://docs.docker.com/engine/reference/commandline/pause/
