.. -*- coding: utf-8 -*-
.. https://docs.docker.com/compose/reference/kill/
.. doc version: 1.9
.. check date: 2016/01/18
.. -----------------------------------------------------------------------------

.. kill

.. _compse-kill:

=======================================
kill
=======================================

.. code-block:: bash

   Usage: kill [options] [SERVICE...]
   
   Options:
   -s SIGNAL         SIGNAL to send to the container. Default signal is SIGKILL.

.. Forces running containers to stop by sending a SIGKILL signal. Optionally the signal can be passed, for example:

``SIGKILL`` シグナルを送信し、実行中のコンテナを強制停止します。次のように、オプションでシグナルを渡すこともできます。

.. code-block:: bash

   $ docker-compose kill -s SIGINT
