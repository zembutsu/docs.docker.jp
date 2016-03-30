.. *- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/push/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/push.md
   doc version: 1.10
      https://github.com/docker/docker/commits/master/docs/reference/commandline/push.md
.. check date: 2016/02/25
.. Commits on Dec 24, 2015 e6115a6c1c02768898b0a47e550e6c67b433c436
.. -------------------------------------------------------------------

.. push

=======================================
push
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. code-block:: bash

   Usage: docker push [OPTIONS] NAME[:TAG]
   
   Push an image or a repository to the registry
   
     --disable-content-trust=true   Skip image signing
     --help                         Print usage

.. Use docker push to share your images to the Docker Hub registry or to a self-hosted one.

``docker push`` を使い、イメージを `Docker Hub <https://hub.docker.com/>`_ レジストリや、自分で作成したレジストリで共有できるようになります。


.. Killing the docker push process, for example by pressing CTRL-c while it is running in a terminal, will terminate the push operation.

``docker push`` プロセスを停止するには、ターミナルで実行中に ``CTRL-c`` を押すると、push 処理を中断します。

.. seealso:: 

   push
      https://docs.docker.com/engine/reference/commandline/push/
