.. *- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/events/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/reference/events.md
   doc version: 1.10
      https://github.com/docker/compose/commits/master/docs/reference/events.md
.. check date: 2016/03/07
.. Commits on Jan 9, 2016 d1d3969661f549311bccde53703a2939402cf769
.. -------------------------------------------------------------------

.. events

.. _compose-events:

=======================================
events
=======================================

.. code-block:: bash

   Usage: events [options] [SERVICE...]

   Options:
       --json      Output events as a stream of json objects

.. Stream container events for every container in the project.

プロジェクト内の各コンテナのイベントを表示します。

.. With the --json flag, a json object will be printed one per line with the format:

``--json`` フラグを使うと、各行を JSON オブジェクトとして表示します。

.. code-block:: json

   {
       "service": "web",
       "event": "create",
       "container": "213cf75fc39a",
       "image": "alpine:edge",
       "time": "2015-11-20T18:01:03.615550",
   }
