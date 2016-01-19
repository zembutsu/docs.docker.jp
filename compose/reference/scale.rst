.. -*- coding: utf-8 -*-
.. https://docs.docker.com/compose/reference/scale/
.. doc version: 1.9
.. check date: 2016/01/19
.. -----------------------------------------------------------------------------

.. scale

.. _compse-scale:

=======================================
scale
=======================================

.. code-block:: bash

   Usage: scale [SERVICE=NUM...]

.. Sets the number of containers to run for a service.

サービスを実行するコンテナ数を設定します。

.. Numbers are specified as arguments in the form service=num. For example:

数は ``service=数値`` の引数で指定します。実行例：

.. code-block:: bash

   $ docker-compose scale web=2 worker=3

