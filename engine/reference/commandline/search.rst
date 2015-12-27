.. -*- coding: utf-8 -*-
.. https://docs.docker.com/engine/reference/commandline/search/
.. doc version: 1.9
.. check date: 2015/12/27
.. -----------------------------------------------------------------------------

.. search

=======================================
search
=======================================

.. code-block:: bash

   Usage: docker search [OPTIONS] TERM
   
   Search the Docker Hub for images
   
     --automated=false    Only show automated builds
     --help=false         Print usage
     --no-trunc=false     Don't truncate output
     -s, --stars=0        Only displays with at least x stars

.. Search Docker Hub for images

`Docker Hub <https://hub.docker.com/>`_ のイメージを検索します。

.. See Find Public Images on Docker Hub for more details on finding shared images from the command line.

共有イメージをコマンドラインで調べる詳細は、 :doc:`Docker Hub で公開イメージを探す <searching-for-images> をご覧ください。

..     Note: Search queries will only return up to 25 results

.. note::

   検索結果は 25 件までしか表示しません。

