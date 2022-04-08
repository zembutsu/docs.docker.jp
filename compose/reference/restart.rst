.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/restart/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/reference/restart.md
   doc version: 1.13
      https://github.com/docker/compose/commits/master/docs/reference/restart.md
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/compose/reference/restart.md
.. check date: 2022/04/09
.. Commits on Jan 28, 2022 b6b19516d0feacd798b485615ebfee410d9b6f86
.. -------------------------------------------------------------------

.. docker-compose restart
.. _docker-compose-restart:

=======================================
docker-compose restart
=======================================

.. code-block:: bash

   使い方: docker-compose restart [オプション] [サービス...]
   
   Options:
   -t, --timeout TIMEOUT      シャットダウンのタイムアウト秒数を指定 (デフォルト: 10)

.. Restarts all stopped and running services.

全ての停止中および実行中のサービスを再起動します。

.. If you make changes to your docker-compose.yml configuration these changes are not reflected after running this command.

``docker-compose.yaml`` 設定ファイルに変更を加えていたとしても、この再起動コマンドの実行後には反映されません。

.. For example, changes to environment variables (which are added after a container is built, but before the container’s command is executed) are not updated after restarting.

たとえば、変更されたｈ環境変数（コンテナの構築後、かつ、コンテナのコマンドを実行する前に追加されたもの）は、再起動後に反映されません。

.. If you are looking to configure a service’s restart policy, please refer to restart in Compose file v3 and restart in Compose v2. Note that if you are deploying a stack in swarm mode, you should use restart_policy, instead.

サービスの再起動ポリシーの設定変更を知りたい場合は、 Compose ファイル v3 の :ref:`compose-file-v3-restart` 、または、 Compose v2 の :ref:`compose-file-restart` をご覧ください。 :doc:`swarm モードに stack をデプロイする場合 </engine/reference/commandline/stack_deploy>` は、かわりに :ref:`restart_policy <compose-file-v3-restart_policy>` を使うべきです。

.. seealso:: 

   docker-compose restart
      https://docs.docker.com/compose/reference/restart/
