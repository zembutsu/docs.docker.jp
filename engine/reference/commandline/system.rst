.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/system/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/system.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_system.yaml
.. check date: 2022/04/03
.. Commits on Mar 23, 2018 cb157b3318eac0a652a629ea002778ca3d8fa703
.. -------------------------------------------------------------------

.. docker system

=======================================
docker system
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _system-description:

説明
==========

.. Manage Docker

Docker を管理します。

.. _system-usage:

使い方
==========

.. code-block:: bash

   $ docker system COMMAND

.. Extended description
.. _system-extended-description:

補足説明
==========

.. Manage Docker.

Docker を管理します。

.. Parent command

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI のベースコマンド。


.. Child commands

子コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker system df<system_df>`
     - docker のディスク使用量を表示
   * - :doc:`docker system events<system_events>`
     - サーバからリアルタタイムのイベントを取得
   * - :doc:`docker system info<system_info>`
     - 幅広いシステム情報を表示
   * - :doc:`docker system prune<system_prune>`
     - 使用されていないデータを削除


.. seealso:: 

   docker system
      https://docs.docker.com/engine/reference/commandline/system/
