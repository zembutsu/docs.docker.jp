.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/kill/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/reference/kill.md
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/reference/kill.md
.. check date: 2016/04/28
.. Commits on Aug 25, 2015 59d4f304ee3bf4bb20ba0f5e0ad6c4a3ff1568f3
.. -------------------------------------------------------------------

.. kill

.. _compose-kill:

=======================================
kill
=======================================

.. code-block:: bash

   使い方: kill [オプション] [サービス...]
   
   オプション:
   -s SIGNAL         コンテナに送信するシグナル。デフォルトのシグナルは SIGKILL

.. Forces running containers to stop by sending a SIGKILL signal. Optionally the signal can be passed, for example:

``SIGKILL`` シグナルを送信し、実行中のコンテナを強制停止します。次のように、オプションでシグナルを渡すこともできます。

.. code-block:: bash

   $ docker-compose kill -s SIGINT

.. seealso:: 

   kill
      https://docs.docker.com/compose/reference/kill/
