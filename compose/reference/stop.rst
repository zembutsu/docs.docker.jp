.. *- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/stop/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/reference/stop.md
   doc version: 1.10
      https://github.com/docker/compose/commits/master/docs/reference/stop.md
.. check date: 2016/03/07
.. Commits on Jul 28, 2015 7eabc06df5ca4a1c2ad372ee8e87012de5429f05
.. -------------------------------------------------------------------

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
