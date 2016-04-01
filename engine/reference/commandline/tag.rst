.. *- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/tag/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/tag.md
   doc version: 1.10
      https://github.com/docker/docker/commits/master/docs/reference/commandline/tag.md
.. check date: 2016/02/25
.. Commits on Jan 27, 2016 e310d070f498a2ac494c6d3fde0ec5d6e4479e14
.. -------------------------------------------------------------------

.. tag

=======================================
tag
=======================================

.. code-block:: bash

   Usage: docker tag [OPTIONS] IMAGE[:TAG] [REGISTRYHOST/][USERNAME/]NAME[:TAG]
   
   Tag an image into a repository
   
     --help               Print usage

.. You can group your images together using names and tags, and then upload them to Share Images via Repositories.

自分のイメージを名前やタグを使ってグループ化し、 :ref:`リポジトリを通してイメージを共有 <contributing-to-docker-hub>` するためアップロードできます。

.. seealso:: 

   tag
      https://docs.docker.com/engine/reference/commandline/tag/
