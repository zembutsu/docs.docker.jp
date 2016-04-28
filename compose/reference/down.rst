.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/down/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/reference/down.md
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/reference/down.md
.. check date: 2016/04/28
.. Commits on Apr 12, 2016 3722bb38c66b3c3500e86295a43aafe14a050b50
.. -------------------------------------------------------------------

.. down

.. _compose-down:

=======================================
down
=======================================

.. Stop containers and remove containers, networks, volumes, and images
.. created by `up`. Only containers and networks are removed by default.

コンテナを停止し、 ``up`` で作成されたコンテナ・ネットワーク・ボリューム・イメージを削除します。デフォルトではコンテナとネットワークのみ削除します。


.. code-block:: bash

   Usage: down [options]
   
   Options:
       --rmi type          Remove images. Type must be one of:
                           'all': Remove all images used by any service.
                           'local': Remove only images that don't have a custom tag
                           set by the `image` field.
       -v, --volumes       Remove named volumes declared in the `volumes` section
                           of the Compose file and anonymous volumes
                           attached to containers.
       --remove-orphans    Remove containers for services not defined in the
                           Compose file

.. Stops containers and removes containers, networks, volumes, and images created by up.

コンテナを停止し、 ``up`` によって作成されたコンテナ、ネットワーク、ボリューム、イメージを削除します。

.. By default, the only things removed are:

デフォルトでは以下のものだけ削除します。

..    Containers for services defined in the Compose file
    Networks defined in the networks section of the Compose file
    The default network, if one is used

* Compose ファイル内で定義したサービス用のコンテナ
* Compose ファイルの ``network`` セクションで定義したネットワーク
* default ネットワーク（を使っている場合）

.. Networks and volumes defined as external are never removed.

``external`` として定義したネットワークとボリュームは決して削除しません。

.. seealso:: 

   down
      https://docs.docker.com/compose/reference/down/

