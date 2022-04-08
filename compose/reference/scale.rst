.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/scale/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/reference/scale.md
   doc version: 1.13
      https://github.com/docker/compose/commits/master/docs/reference/scale.md
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/compose/reference/scale.md
.. check date: 2022/04/09
.. Commits on Jan 28, 2022 b6b19516d0feacd798b485615ebfee410d9b6f86
.. -------------------------------------------------------------------

.. docker-compose scale
.. _docker-compose-scale:

=======================================
docker-compose scale
=======================================

.. This command is deprecated. Use the up command with the --scale flag instead. Beware that using up with the --scale flag has some subtle differences with the scale command, as it incorporates the behaviour of the up command.

. warning::

   **このコマンドは非推奨です。** かわりに、:doc:`up <up>` コマンドで ``--scale`` を付けてください。注意として、 ``up`` の ``--scale`` フラグの使用は、 ``scale`` コマンドとの `微妙な違い <https://github.com/docker/compose/issues/5251>`_ がありますが、 ``up`` コマンドと組み合わせた挙動になります。


.. code-block:: bash

   使い方: docker-compose scale [オプション] [SERVICE=NUM...]
   
   オプション:
     -t, --timeout TIMEOUT      シャットダウンのタイムアウト秒を指定（デフォルト: 10）


.. Sets the number of containers to run for a service.

サービスを実行するコンテナ数を設定します。

.. Numbers are specified as arguments in the form service=num. For example:

数は ``service=数値`` の引数で指定します。実行例：

.. code-block:: bash

   $ docker-compose scale web=2 worker=3

.. Tip: Alternatively, in Compose file version 3.x, you can specify replicas under the deploy key as part of a service configuration for Swarm mode. The deploy key and its sub-options (including replicas) only works with the docker stack deploy command, not docker-compose up or docker-compose run.

.. tip::

   もう1つの方法として、 :doc:`Compose ファイル形式バージョン v3 </compose/compose-file/compose-file-v3>` では、 :doc:`Swarm モード </engine/swarm/index>` 対応設定の一部として、 :ref:`deploy <compose-file-v3-deploy>` キー以下の :ref:`replicas <compose-file-v3-replicas>` で指定できます。 ``deploy`` キーとサブオプション（ ``replicas`` を含みます）は、 ``docker stack deploy`` コマンドを使った時のみ機能しますが、 ``docker-compose up`` や ``docker-compose run`` では動作しません。


.. seealso:: 

   docker-compose scale
      https://docs.docker.com/compose/reference/scale/
