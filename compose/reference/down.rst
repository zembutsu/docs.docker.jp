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

コンテナを停止し、 ``up`` で作成したコンテナ・ネットワーク・ボリューム・イメージを削除します。デフォルトではコンテナとネットワークのみ削除します。


.. code-block:: bash

   使い方: down [オプション]
   
   オプション:
       --rmi type          イメージの削除。type は次のいずれか: 
                           'all': あらゆるサービスで使う全イメージを削除
                           'local': image フィールドにカスタム・タグのないイメージだけ削除
       -v, --volumes       Compose ファイルの `volumes` セクションの名前付きボリュームを削除
                           また、コンテナがアタッチしたアノニマス・ボリュームも削除
       --remove-orphans    Compose ファイルで定義していないサービス用のコンテナも削除

.. Stops containers and removes containers, networks, volumes, and images created by up.

コンテナを停止し、 ``up`` で作成したコンテナ、ネットワーク、ボリューム、イメージを削除します。

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

