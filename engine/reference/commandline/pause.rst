.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/pause/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/pause.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/pause.md
.. check date: 2016/06/16
.. Commits on May 27, 2016 ee7696312580f14ce7b8fe70e9e4cbdc9f83919f
.. -------------------------------------------------------------------

.. command: docker pause

=======================================
docker pause
=======================================

.. description

.. _docker-pause-description:

説明
====================

1 つまたは複数のコンテナ内部で実行されているプロセスを一時停止します。

.. usage

.. _docker-pause-usage:

利用方法
====================

.. docker pause CONTAINER [CONTAINER...]

.. code-block:: bash

   docker pause コンテナ [コンテナ...]

.. extended-description

.. _docker-pause-extended-description:

追加説明
====================

.. The `docker pause` command suspends all processes in the specified containers.
   On Linux, this uses the freezer cgroup. Traditionally, when suspending a process
   the `SIGSTOP` signal is used, which is observable by the process being suspended.
   With the freezer cgroup the process is unaware, and unable to capture,
   that it is being suspended, and subsequently resumed. On Windows, only Hyper-V
   containers can be paused.

``docker pause`` コマンドは、指定されたコンテナ内のプロセスをすべて実行停止します。
Linux の場合は freezer cgroup が利用されます。
従来よりプロセスの一時停止には ``SIGSTOP`` シグナルが用いられ、そのプロセスの停止によって確認できます。
freezer cgroup を用いた場合、一時停止されたこと、およびその後に再開されることに、プロセスは気づくことがなく、またそういう状態を把握することもできません。
Windows の場合は Hyper-V コンテナのみが一時停止できます。

.. See the cgroups freezer documentation for further details.

更に詳しい詳細については `cgroup freezer ドキュメント <https://www.kernel.org/doc/Documentation/cgroup-v1/freezer-subsystem.txt>`_ をご覧ください。

.. For example uses of this command, refer to the [examples section](#examples) below.

本コマンドの利用例については、以下に示す :ref:`利用例 <docker-pause-examples>` を参照してください。

.. examples

.. _docker-pause-examples:

利用例
====================

.. ```bash
   $ docker pause my_container
   ```

.. code-block:: bash

   $ docker pause my_container

.. seealso:: 

   pause
      https://docs.docker.com/engine/reference/commandline/pause/
