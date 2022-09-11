.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/events/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/reference/events.md
   doc version: 1.13
      https://github.com/docker/compose/commits/master/docs/reference/events.md
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/compose/reference/events.md
.. check date: 2022/04/08
.. Commits on Jan 28, 2022 b6b19516d0feacd798b485615ebfee410d9b6f86
.. -------------------------------------------------------------------

.. events

.. _compose-events:

=======================================
docker-compose events
=======================================

.. code-block:: bash

   使い方: docker-compose events [オプション] [サービス...]
   
   オプション:
       --json      json オブジェクトでイベントの出力をストリーム

.. Stream container events for every container in the project.

プロジェクト内の各コンテナのイベントを表示します。

.. With the --json flag, a json object will be printed one per line with the format:

``--json`` フラグを使うと、各行を JSON オブジェクトとして表示します。

.. code-block:: json

   {
       "time": "2015-11-20T18:01:03.615550",
       "type": "container",
       "action": "create",
       "id": "213cf7...5fc39a",
       "service": "web",
       "attributes": {
           "name": "application_web_1",
           "image": "alpine:edge"
       }
   }


.. The events that can be received using this can be seen here.

このコマンドを使って表示できるイベントは、 :ref:`こちら <docker_events-object-types>` で確認できます。

.. seealso:: 

   docker-compose events
      https://docs.docker.com/compose/reference/events/
