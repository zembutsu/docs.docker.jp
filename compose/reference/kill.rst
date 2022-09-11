.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/kill/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/reference/kill.md
   doc version: 1.13
      https://github.com/docker/compose/commits/master/docs/reference/kill.md
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/compose/reference/kill.md
.. check date: 2022/04/08
.. Commits on Jan 28, 2022 b6b19516d0feacd798b485615ebfee410d9b6f86
.. -------------------------------------------------------------------

.. docker-compose kill
.. _docker-compose-kill:

=======================================
docker-compose kill
=======================================

.. code-block:: bash

   使い方: docker-compose kill [オプション] [サービス...]
   
   オプション:
   -s SIGNAL         コンテナに送信するシグナル。デフォルトのシグナルは SIGKILL

.. Forces running containers to stop by sending a SIGKILL signal. Optionally the signal can be passed, for example:

``SIGKILL`` シグナルを送信し、実行中のコンテナを強制停止します。次のように、オプションでシグナルを渡すこともできます。

.. code-block:: bash

   $ docker-compose kill -s SIGINT

.. seealso:: 

   docker-compose kill
      https://docs.docker.com/compose/reference/kill/
