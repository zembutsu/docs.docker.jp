.. -*- coding: utf-8 -*-
.. https://docs.docker.com/engine/reference/commandline/push/
.. doc version: 1.9
.. check date: 2015/12/27
.. -----------------------------------------------------------------------------

.. push

=======================================
push
=======================================

.. code-block:: bash

   Usage: docker push [OPTIONS] NAME[:TAG]
   
   Push an image or a repository to the registry
   
     --disable-content-trust=true   Skip image signing
     --help=false                   Print usage

.. Use docker push to share your images to the Docker Hub registry or to a self-hosted one.

``docker push`` を使い、イメージを `Docker Hub <https://hub.docker.com/>`_ レジストリや、自分で作成したレジストリで共有できるようになります。


