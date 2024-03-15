.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/start/
.. SOURCE:
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/start.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_start.yaml
.. check date: 2022/03/27
.. Commits on Aug 22, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker start

=======================================
docker start
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _docker_save-description:

説明
==========

.. Start one or more stopped containers

1つまたは複数の停止したコンテナを起動します。

.. _docker_save-usage:

使い方
==========

.. code-block:: bash

   $ docker start [OPTIONS] CONTAINER [CONTAINER...]

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <docker_start-examples>` をご覧ください。

.. _docker_start-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--attach`` , ``-a``
     - 
     - 標準入出力にアタッチし、シグナルを転送
   * - ``--checkpoint``
     - 
     - 【experimental (daemon)】このチェックポイントを修復
   * - ``--checkpoint-dir``
     - 
     - 【experimental (daemon)】任意のチェックポイント保存ディレクトリを使用
   * - ``--detach-keys``
     - 
     - コンテナからデタッチするためのキー手順を上書き
   * - ``--interactive`` , ``-i``
     - 
     - コンテナの標準入力にアタッチ

.. Examples
.. _docker_start-examples:

使用例
==========

.. code-block:: bash

   $ docker start my_container


親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI の基本コマンド


.. seealso:: 

   docker start
      https://docs.docker.com/engine/reference/commandline/start/
