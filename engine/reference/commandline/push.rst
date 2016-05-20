.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/push/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/push.md
   doc version: 1.11
      https://github.com/docker/docker/commits/master/docs/reference/commandline/push.md
.. check date: 2016/04/28
.. Commits on Mar 29, 2016 fb5ea0c0efec238aeeff7c5c3742a0e4eccff2c7
.. -------------------------------------------------------------------

.. push

=======================================
push
=======================================

.. code-block:: bash

   使い方: docker push [オプション] 名前[:タグ]
   
   イメージやリポジトリをレジストリに送信 (push)
   
     --disable-content-trust=true   イメージの署名をスキップ
     --help                         使い方の表示

.. Use docker push to share your images to the Docker Hub registry or to a self-hosted one.

``docker push`` を使うと、イメージを `Docker Hub <https://hub.docker.com/>`_ レジストリや、自分で作成したレジストリで共有できるようになります。


.. Killing the docker push process, for example by pressing CTRL-c while it is running in a terminal, will terminate the push operation.

``docker push`` プロセスを停止するには、ターミナルで実行中に ``CTRL-c`` を押すと、push 処理を中断します。

.. Registry credentials are managed by docker login.

レジストリの認証情報は :doc:`docker login <login>` で管理します。


.. seealso:: 

   push
      https://docs.docker.com/engine/reference/commandline/push/
