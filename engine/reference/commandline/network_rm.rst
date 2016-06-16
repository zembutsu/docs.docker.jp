.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/network_rm/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/network_rm.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/network_rm.md
.. check date: 2016/06/18
.. Commits on Feb 19, 2016 cdc7f26715fbf0779a5283354048caf9faa1ec4a
.. -------------------------------------------------------------------

.. network ls

=======================================
network rm
=======================================

.. code-block:: bash

   使い方:  docker network rm [オプション] 名前|ID
   
   ネットワークを削除
   
     --help             使い方の表示

.. Removes a network by name or identifier. To remove a network, you must first disconnect any containers connected to it.

ネットワーク名か ID を指定して削除します。ネットワークを削除するには、接続中の全てのコンテナとの接続を切断しなくてはいけません。

.. code-block:: bash

   $ docker network rm my-network

.. To delete multiple networks in a single docker network rm command, provide multiple network names or ids. The following example deletes a network with id 3695c422697f and a network named my-network:

複数のネットワークを削除する場合は、 ``docker network rm`` コマンドで複数のネットワーク名や ID を指定できます。以下の例はネットワーク ID ``3695c422697f`` とネットワーク名 ``my-network`` を削除します。

.. code-block:: bash

   $ docker network rm 3695c422697f my-network

.. When you specify multiple networks, the command attempts to delete each in turn. If the deletion of one network fails, the command continues to the next on the list and tries to delete that. The command reports success or failure for each deletion.

複数のネットワークを指定すると、コマンドは削除したネットワークの情報を返します。もしも、あるネットワークの情報削除に失敗すると、コマンドはリスト上の次にあるネットワークを削除しようとします。コマンドは削除に成功したか失敗したかを表示します。

.. Related information

.. _network-rm-related-information:

関連情報
==========

..    network disconnect
    network connect
    network create
    network ls
    network inspect
    Understand Docker container networks

* :doc:`network disconnect <network_disconnect>`
* :doc:`network connect <network_connect>`
* :doc:`network create <network_create>`
* :doc:`network ls <network_ls>`
* :doc:`network inspect <network_inspect>`
* :doc:`Docker コンテナ・ネットワークの理解 </engine/userguide/networking/dockernetworks>`

.. seealso:: 

   network rm
      https://docs.docker.com/engine/reference/commandline/network_rm/
