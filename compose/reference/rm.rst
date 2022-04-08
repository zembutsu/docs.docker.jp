.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/rm/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/reference/rm.md
   doc version: 1.13
      https://github.com/docker/compose/commits/master/docs/reference/rm.md
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/compose/reference/rm.md
.. check date: 2022/04/09
.. Commits on Jan 28, 2022 b6b19516d0feacd798b485615ebfee410d9b6f86
.. -------------------------------------------------------------------

.. docker-compose rm

.. _docker-compose-rm:

=======================================
docker-compose rm
=======================================

.. code-block:: bash

   使い方: docker-compose rm [オプション] [サービス...]
   
   オプション:
       -f, --force   確認なく削除する
       -v            コンテナにアタッチしているアノニマス・ボリュームも削除
       -s, --stop    削除前に、必要であればコンテナを停止
       -a, --all     docker-compose run で作成した一度だけのコンテナを全て削除
                     docker-compose run

.. Removes stopped service containers.

停止済みのサービス・コンテナを削除します。

.. (1.10)
.. By default, volumes attached to containers will not be removed. You can see all volumes with docker volume ls.
.. デフォルトでは、コンテナにアタッチしているボリュームは削除されません。全てのボリュームは ``docker volume ls`` で確認できます。

.. (1.11)
.. By default, anonymous volumes attached to containers will not be removed. You can override this with -v. To list all volumes, use docker volume ls.

.. (20.10)
.. By default, anonymous volumes attached to containers are not removed. You can override this with -v. To list all volumes, use docker volume ls.

デフォルトでは、コンテナにアタッチしている匿名ボリューム（anonymous volume）を削除しません。ボリュームを削除するには ``-v`` オプションを使います。全てのボリュームを表示するには ``docker volume ls`` を使います。

.. Any data which is not in a volume will be lost.

（明示的に削除しなければ）ボリューム内にあるデータは失われません。

.. Running the command with no options also removes one-off containers created by docker-compose up or docker-compose run:

実行時にオプションを付けなければ、 ``docker-compose up`` や ``docker-compose run`` によって作成された1回限り実行するコンテナも削除します。

.. code-block:: bash

   $ docker-compose rm
   Going to remove djangoquickstart_web_run_1
   Are you sure? [yN] y
   Removing djangoquickstart_web_run_1 ... done

.. seealso:: 

   docker-compose rm
      https://docs.docker.com/compose/reference/rm/
