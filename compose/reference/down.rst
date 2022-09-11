.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/down/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/reference/down.md
   doc version: 1.13
      https://github.com/docker/compose/commits/master/docs/reference/down.md
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/compose/reference/down.md
.. check date: 2022/04/08
.. Commits on Jan 28, 2022 b6b19516d0feacd798b485615ebfee410d9b6f86
.. -------------------------------------------------------------------

.. down

.. _compose-down:

=======================================
docker-compose down
=======================================


.. code-block:: bash

   使い方: down [オプション]
   
   オプション:
       --rmi type          イメージの削除。type は次のいずれか: 
                           'all': あらゆるサービスで使う全イメージを削除
                           'local': image フィールドにカスタム・タグのないイメージだけ削除
       -v, --volumes       Compose ファイルの `volumes` セクションの名前付きボリュームを削除
                           また、コンテナがアタッチした匿名ボリュームも削除
       --remove-orphans    Compose ファイルで定義していないサービス用のコンテナも削除
       -t, --timeout TIMEOUT   シャットダウンのタイムアウト秒を指定（デフォルト: 10）

.. Stops containers and removes containers, networks, volumes, and images created by up.

コンテナを停止し、 ``up`` で作成したコンテナ、ネットワーク、ボリューム、イメージを削除します。

.. By default, the only things removed are:

デフォルトでは、以下のものだけ削除します。

..    Containers for services defined in the Compose file
    Networks defined in the networks section of the Compose file
    The default network, if one is used

* Compose ファイル内で定義したサービス用のコンテナ
* Compose ファイルの ``network`` セクションで定義したネットワーク
* default ネットワーク（を使っている場合）

.. Networks and volumes defined as external are never removed.

``external`` として定義したネットワークとボリュームは決して削除しません。

.. Anonymous volumes are not removed by default. However, as they don’t have a stable name, they will not be automatically mounted by a subsequent up. For data that needs to persist between updates, use host or named volumes.

:ruby:`匿名ボリューム <anonymous volume>` はデフォルトでは削除されません。ですが、これらは決まった名前では無いため、その後に ``up`` しても（削除されなかった匿名ボリュームは）自動的にマウントされません。アップデートをしている間でも保持が必要なデータには、ホストボリュームや名前付きボリュームを使います。


.. seealso:: 

   docker-compose down
      https://docs.docker.com/compose/reference/down/

