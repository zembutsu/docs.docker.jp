.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/logout/
.. SOURCE:
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/logout.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_logout.yaml
.. check date: 2022/03/21
.. Commits on Aug 22, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker logout

=======================================
docker logout
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _docker_logout-description:

説明
==========

.. Log out from a Docker registry

Docker レジストリから :ruby:`ログアウト <log out>` します。

.. _docker_logout-usage:

使い方
==========

.. code-block:: bash

   $ docker logout [SERVER]

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <docker_logout-examples>` をご覧ください。

.. Examples
.. _docker_logout-examples:

使用例
==========

.. code-block:: bash

   $ docker logout localhost:8080


親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI の基本コマンド

.. seealso:: 

   docker logout
      https://docs.docker.com/engine/reference/commandline/logout/
