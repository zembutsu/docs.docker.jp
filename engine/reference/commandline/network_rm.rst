.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/network_rm/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/network_rm.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_network_rm.yaml
.. check date: 2022/03/29
.. Commits on Aug 21, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker network rm

=======================================
docker network rm
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _network_rm-description:

説明
==========

.. Remove one or more networks

1つまたは複数のネットワークを削除します。

.. API 1.21+
   Open the 1.21 API reference (in a new window)
   The client and daemon API must both be at least 1.21 to use this command. Use the docker version command on the client to check your client and daemon API versions.

【API 1.21+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.21 <https://docs.docker.com/engine/api/v1.21/>`_ の必要があります。クライアントとデーモン API のバージョンを調べるには、 ``docker version`` コマンドを使います。

.. _network_rm-usage:

使い方
==========

.. code-block:: bash

   $ docker network rm NETWORK [NETWORK...]

.. Extended description
.. _network_rm-extended-description:

補足説明
==========

.. Removes a network by name or identifier. To remove a network, you must first disconnect any containers connected to it.

ネットワーク名か ID を指定して削除します。ネットワークを削除するには、接続中の全てのコンテナとの接続を切断しなくてはいけません。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <network_rm-examples>` をご覧ください。

.. Examples
.. _network_rm-examples:

使用例
==========

.. Remove a network
.. _network_rm-remove-a-network:

ネットワークを削除
--------------------

.. To remove the network named ‘my-network’:

``my-network`` という名前のネットワークを削除します。

.. code-block:: bash

   $ docker network rm my-network

.. Remove multiple networks
.. _network_rm-remove-multiple-networks:
複数のネットワークを削除
------------------------------

.. To delete multiple networks in a single docker network rm command, provide multiple network names or ids. The following example deletes a network with id 3695c422697f and a network named my-network:

複数のネットワークを削除する場合は、 ``docker network rm`` コマンドで複数のネットワーク名や ID を指定できます。以下の例はネットワーク ID ``3695c422697f`` とネットワーク名 ``my-network`` を削除します。

.. code-block:: bash

   $ docker network rm 3695c422697f my-network

.. When you specify multiple networks, the command attempts to delete each in turn. If the deletion of one network fails, the command continues to the next on the list and tries to delete that. The command reports success or failure for each deletion.

複数のネットワークを指定すると、コマンドは削除したネットワークの情報を返します。もしも、あるネットワークの情報削除に失敗すると、コマンドはリスト上の次にあるネットワークを削除しようとします。コマンドは削除に成功したか失敗したかを表示します。



.. Parent command

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker network <network>`
     - ネットワークを管理


.. Related commands

関連コマンド
====================

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker network connect <network_connect>`
     - コンテナをネットワークに接続
   * - :doc:`docker network craete <network_create>`
     - ネットワーク作成
   * - :doc:`docker network disconnect <network_disconnect>`
     - ネットワークからコンテナを切断
   * - :doc:`docker network inspect <network_inspect>`
     - 1つまたは複数ネットワークの情報を表示
   * - :doc:`docker network ls <network_ls>`
     - ネットワーク一覧表示
   * - :doc:`docker network prune <network_prune>`
     - 使用していないネットワークを全て削除
   * - :doc:`docker network rm <network_rm>`
     - 1つまたは複数ネットワークの削除


.. seealso:: 

   docker network rm
      https://docs.docker.com/engine/reference/commandline/network_rm/
