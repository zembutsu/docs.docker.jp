.. -*- coding: utf-8 -*-
.. https://docs.docker.com/engine/reference/commandline/tag/
.. doc version: 1.9
.. check date: 2015/12/27
.. -----------------------------------------------------------------------------

.. tag

=======================================
tag
=======================================

.. code-block:: bash

   Usage: docker tag [OPTIONS] IMAGE[:TAG] [REGISTRYHOST/][USERNAME/]NAME[:TAG]
   
   Tag an image into a repository
   
     -f, --force=false    Force
     --help=false         Print usage

.. You can group your images together using names and tags, and then upload them to Share Images via Repositories.

自分のイメージを名前やタグを使ってグループ化し、 :doc:`レポジトリを通してイメージを共有 <contributing-to-docker-hub>` するためアップロードできます。
