.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/swarm_update/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/swarm_update.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/swarm_update.md
.. check date: 2016/06/16
.. Commits on Jun 14, 2016 9acf97b72a4d5ff7b1bcad36fb19b53775f01596
.. -------------------------------------------------------------------

.. Warning: this command is part of the Swarm management feature introduced in Docker 1.12, and might be subject to non backward-compatible changes.

.. warning::

  このコマンドは Docker 1.12 で導入された Swarm 管理機能の一部です。それと、変更は下位互換性を考慮していない可能性があります。

.. swarm update

=======================================
swarm update
=======================================

.. code-block:: bash

   使い方:  docker swarm update [オプション]
   
   Swarm を更新
   
   オプション:
         --auto-accept value               自動受け入れポリシー (worker, manager or none)
         --dispatcher-heartbeat duration   ハートビート間隔を指定 (デフォルト 5s)
         --help                            使い方の表示
         --secret string                   クラスタにノード追加時に必要なシークレット値を指定
         --task-history-limit int          タスク履歴の保持上限数 (デフォルト 10)

.. Updates a Swarm cluster with new parameter values. This command must target a manager node.

新しいパラメータ値で Swarm クラスタを更新します。このコマンドはマネージャ・ノード上で実行する必要があります。

.. code-block:: bash

   $ docker swarm update --auto-accept manager

関連情報
----------

* :doc:`swarm_init`
* :doc:`swarm_join`
* :doc:`swarm_update`

.. seealso:: 

   swarm update
      https://docs.docker.com/engine/reference/commandline/swarm_update/

