.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/restart/
.. SOURCE:
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/restart.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_restart.yaml
.. check date: 2022/03/21
.. Commits on Aug 22, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker restart

=======================================
docker restart
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _docker_restart-description:

説明
==========

.. Restart one or more containers

1つまたは複数のコンテナを :ruby:`再起動 <restart>` します。

.. _docker_restart-usage:

使い方
==========

.. code-block:: bash

   $ docker restart [OPTIONS] CONTAINER [CONTAINER...]

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <docker_restart-examples>` をご覧ください。

.. _docker_restart-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--time`` , ``-t``
     - ``10``
     - コンテナを :ruby:`強制停止 <kill>` するまで待機する秒数


.. Examples
.. _docker_restart-examples:

使用例
==========

.. code-block:: bash

   $ docker restart my_container


親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI の基本コマンド


.. seealso:: 

   docker restart
      https://docs.docker.com/engine/reference/commandline/resatart/

