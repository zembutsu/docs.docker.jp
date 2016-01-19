.. -*- coding: utf-8 -*-
.. https://docs.docker.com/compose/reference/stop/
.. doc version: 1.9
.. check date: 2016/01/19
.. -----------------------------------------------------------------------------

.. stop

.. _compse-stop:

=======================================
stop
=======================================

.. code-block:: bash

   Usage: stop [options] [SERVICE...]
   
   Options:
   -t, --timeout TIMEOUT      Specify a shutdown timeout in seconds (default: 10).

.. Stops running containers without removing them. They can be started again with docker-compose start.

稼働中のコンテナを停止しますが、削除しません。 ``docker-compose start`` コマンドで、再起動できます。
