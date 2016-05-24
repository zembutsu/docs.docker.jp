.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/rm/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/reference/rm.md
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/reference/rm.md
.. check date: 2016/04/28
.. Commits on Apr 12, 2016 3722bb38c66b3c3500e86295a43aafe14a050b50
.. -------------------------------------------------------------------

.. rm

.. _compose-rm:

=======================================
rm
=======================================

.. code-block:: bash

   使い方: rm [オプション] [サービス...]
   
   オプション:
       -f, --force   確認なく削除する
       -v            コンテナにアタッチしているアノニマス・ボリュームも削除
       -a, --all     docker-compose run で作成した一度だけのコンテナを全て削除
                     docker-compose run

.. Removes stopped service containers.

停止済みのサービス・コンテナを削除します。

.. (1.10)
.. By default, volumes attached to containers will not be removed. You can see all volumes with docker volume ls.
.. デフォルトでは、コンテナにアタッチしているボリュームは削除されません。全てのボリュームは ``docker volume ls`` で確認できます。

.. (1.11)
.. By default, anonymous volumes attached to containers will not be removed. You can override this with -v. To list all volumes, use docker volume ls.

デフォルトでは、コンテナにアタッチしている匿名ボリューム（anonymous volume）を削除しません。ボリュームを削除するには ``-v`` オプションを使います。全てのボリュームを表示するには ``docker volume ls`` を使います。


.. Any data which is not in a volume will be lost.

（明示的に削除しなければ）ボリューム内にあるデータは失われません。

.. seealso:: 

   rm
      https://docs.docker.com/compose/reference/rm/
