.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/port/
.. SOURCE:
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/port.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_port.yaml
.. check date: 2022/03/21
.. Commits on Aug 22, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker port

=======================================
docker port
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _docker_port-description:

説明
==========

.. List port mappings or a specific mapping for the container

ポート :ruby:`割り当て <mapping>` の一覧か、特定のコンテナに対する :ruby:`割り当て <mapping>` を表示します。

.. _docker_port-usage:

使い方
==========

.. code-block:: bash

   $ docker port CONTAINER [PRIVATE_PORT[/PROTO]]

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <docker_port-examples>` をご覧ください。

.. Examples
.. _docker_port-examples:

使用例
==========

.. Show all mapped ports
.. _docker_port-show-all-mapped-port:

割り当てポートを全て表示
------------------------------

.. You can find out all the ports mapped by not specifying a PRIVATE_PORT, or just a specific mapping:

``プライベート・ポート`` や、特定の割り当て状況を指定しなければ、全てのポートの割り当て状況（マッピング）を確認できます。

.. code-block:: bash

   $ docker ps
   CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS                                            NAMES
   b650456536c7        busybox:latest      top                 54 minutes ago      Up 54 minutes       0.0.0.0:1234->9876/tcp, 0.0.0.0:4321->7890/tcp   test
   
   $ docker port test
   7890/tcp -> 0.0.0.0:4321
   9876/tcp -> 0.0.0.0:1234
   
   $ docker port test 7890/tcp
   0.0.0.0:4321
   
   $ docker port test 7890/udp
   2014/06/24 11:53:36 Error: No public port '7890/udp' published for test
   
   $ docker port test 7890
   0.0.0.0:4321

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI の基本コマンド

.. seealso:: 

   docker port
      https://docs.docker.com/engine/reference/commandline/port/

