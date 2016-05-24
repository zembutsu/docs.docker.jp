.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/scale/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/reference/scale.md
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/reference/scale.md
.. check date: 2016/04/28
.. Commits on Aug 25, 2016 59d4f304ee3bf4bb20ba0f5e0ad6c4a3ff1568f3
.. -------------------------------------------------------------------

.. scale

.. _compose-scale:

=======================================
scale
=======================================

.. code-block:: bash

   使い方: scale [サービス=数値...]

.. Sets the number of containers to run for a service.

サービスを実行するコンテナ数を設定します。

.. Numbers are specified as arguments in the form service=num. For example:

数は ``service=数値`` の引数で指定します。実行例：

.. code-block:: bash

   $ docker-compose scale web=2 worker=3

.. seealso:: 

   scale
      https://docs.docker.com/compose/reference/scale/
