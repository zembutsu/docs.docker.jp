.. *- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/search/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/search.md
   doc version: 1.10
      https://github.com/docker/docker/commits/master/docs/reference/commandline/search.md
.. check date: 2016/02/25
.. Commits on Jan 27, 2016 e310d070f498a2ac494c6d3fde0ec5d6e4479e14
.. -------------------------------------------------------------------

.. search

=======================================
search
=======================================

.. code-block:: bash

   Usage: docker search [OPTIONS] TERM
   
   Search the Docker Hub for images
   
     --automated          Only show automated builds
     --help               Print usage
     --no-trunc           Don't truncate output
     -s, --stars=0        Only displays with at least x stars

.. Search Docker Hub for images

`Docker Hub <https://hub.docker.com/>`_ のイメージを検索します。

.. See Find Public Images on Docker Hub for more details on finding shared images from the command line.

共有イメージをコマンドラインで調べる詳細は、 :ref:`Docker Hub で公開イメージを探す <searching-for-images>` をご覧ください。

..     Note: Search queries will only return up to 25 results

.. note::

   検索結果は 25 件までしか表示しません。

