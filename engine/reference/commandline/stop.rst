.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/stop/
.. SOURCE:
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/stop.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_stop.yaml
.. check date: 2022/03/27
.. Commits on Aug 22, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker stop

=======================================
docker stop
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _docker_stop-description:

説明
==========

.. Stop one or more running containers

1つまたは複数の実行中コンテナを :ruby:`停止 <stop>` します。

.. _docker_stop-usage:

使い方
==========

.. code-block:: bash

   $ docker stop [OPTIONS] CONTAINER [CONTAINER...]

.. Extended description
.. _docker_stop-extended-description:

補足説明
==========

.. The main process inside the container will receive SIGTERM, and after a grace period, SIGKILL. The first signal can be changed with the STOPSIGNAL instruction in the container’s Dockerfile, or the --stop-signal option to docker run.

コンテナ内のメイン・プロセスが ``SIGTERM`` を受信し、一定期間の経過後、 ``SIGKILL`` を送信します。初めのシグナルは、コンテナの Dockerfile の ``STOPSIGNAL`` 命令で変更できます。あるいは ``docker run`` の ``--stop-signal`` オプションでも変更できます。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <docker_stop-examples>` をご覧ください。

.. _docker_stop-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--time`` , ``-t``
     - ``10``
     - 強制的に停止するまで、待機する秒数

.. Examples
.. _docker_stop-examples:

使用例
==========

.. code-block:: bash

   $ docker stop my_container


親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI の基本コマンド


.. seealso:: 

   docker stop
      https://docs.docker.com/engine/reference/commandline/stop/
