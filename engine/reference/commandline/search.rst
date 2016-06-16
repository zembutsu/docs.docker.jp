.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/search/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/search.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/search.md
.. check date: 2016/06/16
.. Commits on Jun 14, 2016 8eca8089fa35f652060e86906166dabc42e556f8
.. -------------------------------------------------------------------

.. search

=======================================
search
=======================================

.. code-block:: bash

   使い方: docker search [オプション] 単語
   
   Docker Hub のイメージを検索
   
     --filter=[]          次の条件をもとに出力をフィルタ：
                          - is-automated=(true|false)
                          - is-official=(true|false)
                          - stars=<数値> - イメージが持っている最新のスター「数」
     --help               使い方の表示
     --limit=25           出力結果の最大数
     --no-trunc           トランケート (truncate) を出力しない

.. Search Docker Hub for images

`Docker Hub <https://hub.docker.com/>`_ のイメージを検索します。

.. See Find Public Images on Docker Hub for more details on finding shared images from the command line.

共有イメージをコマンドラインで調べる詳細は、 :ref:`Docker Hub で公開イメージを探す <searching-for-images>` をご覧ください。

..     Note: Search queries will only return up to 25 results

.. note::

   検索結果は 25 件までしか表示しません。

.. Examples

例
==========

.. Search images by name

イメージ名で検索
--------------------

.. This example displays images with a name containing 'busybox':

この例は ``busybox`` を含むイメージを表示します。

.. code-block:: bash

   $ docker search busybox
   NAME                             DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
   busybox                          Busybox base image.                             316       [OK]       
   progrium/busybox                                                                 50                   [OK]
   radial/busyboxplus               Full-chain, Internet enabled, busybox made...   8                    [OK]
   odise/busybox-python                                                             2                    [OK]
   azukiapp/busybox                 This image is meant to be used as the base...   2                    [OK]
   ofayau/busybox-jvm               Prepare busybox to install a 32 bits JVM.       1                    [OK]
   shingonoide/archlinux-busybox    Arch Linux, a lightweight and flexible Lin...   1                    [OK]
   odise/busybox-curl                                                               1                    [OK]
   ofayau/busybox-libc32            Busybox with 32 bits (and 64 bits) libs         1                    [OK]
   peelsky/zulu-openjdk-busybox                                                     1                    [OK]
   skomma/busybox-data              Docker image suitable for data volume cont...   1                    [OK]
   elektritter/busybox-teamspeak    Leightweight teamspeak3 container based on...   1                    [OK]
   socketplane/busybox                                                              1                    [OK]
   oveits/docker-nginx-busybox      This is a tiny NginX docker image based on...   0                    [OK]
   ggtools/busybox-ubuntu           Busybox ubuntu version with extra goodies       0                    [OK]
   nikfoundas/busybox-confd         Minimal busybox based distribution of confd     0                    [OK]
   openshift/busybox-http-app                                                       0                    [OK]
   jllopis/busybox                                                                  0                    [OK]
   swyckoff/busybox                                                                 0                    [OK]
   powellquiring/busybox                                                            0                    [OK]
   williamyeh/busybox-sh            Docker image for BusyBox's sh                   0                    [OK]
   simplexsys/busybox-cli-powered   Docker busybox images, with a few often us...   0                    [OK]
   fhisamoto/busybox-java           Busybox java                                    0                    [OK]
   scottabernethy/busybox                                                           0                    [OK]
   marclop/busybox-solr

.. Display non-truncated description (--no-trunc)

説明を省略せずに表示（ ``--no-trunc`` ）
----------------------------------------k

.. This example displays images with a name containing 'busybox', at least 3 stars and the description isn't truncated in the output:

この例は ``busybox`` を含むイメージを表示します。少なくとも３つのスターがあるイメージを、説明を省略せずに表示します。

.. code-block:: bash

   $ docker search --stars=3 --no-trunc busybox
   NAME                 DESCRIPTION                                                                               STARS     OFFICIAL   AUTOMATED
   busybox              Busybox base image.                                                                       325       [OK]       
   progrium/busybox                                                                                               50                   [OK]
   radial/busyboxplus   Full-chain, Internet enabled, busybox made from scratch. Comes in git and cURL flavors.   8                    [OK]

.. Limit search results (--limit)

検索結果の上限（ ``--limit`` ）
================================

.. The flag --limit is the maximium number of results returned by a search. This value could be in the range between 1 and 100. The default value of --limit is 25.

``--limit`` は検索結果で表示する最大行数です。この値は 1 から 100 までの範囲で指定が必要です。デフォルトの ``--limit`` 値は 25 です。

.. Filtering

フィルタリング
====================

.. The filtering flag (-f or --filter) format is a key=value pair. If there is more than one filter, then pass multiple flags (e.g. --filter "foo=bar" --filter "bif=baz")

フィルタリング・フラグ（ ``-f`` か ``--filter`` ）は ``キー=値`` ペアの形式です。複数のフィルタを指定するには、フラグを複数回使います（例： ``--filter "foo=bar" --filter "bif=baz"``  ）。

.. The currently supported filters are:

現在サポートしているフィルタは次の通りです：

..    stars (int - number of stars the image has)
    is-automated (true|false) - is the image automated or not
    is-official (true|false) - is the image official or not

* stars （整数 - イメージが持つスター数）
* is-automated（true|false）- イメージが自動構築されたかどうか
* is-officieal（true|false）- イメージが公式かどうか

.. stars

stars
----------

.. This example displays images with a name containing 'busybox' and at least 3 stars:

この例は名前に ``busybox`` を含み、３つ以上のスターを持つイメージを表示します。

.. code-block:: bash

   $ docker search --filter stars=3 busybox
   NAME                 DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
   busybox              Busybox base image.                             325       [OK]       
   progrium/busybox                                                     50                   [OK]
   radial/busyboxplus   Full-chain, Internet enabled, busybox made...   8                    [OK]

is-automated
--------------------

.. This example displays images with a name containing 'busybox' and are automated builds:

この例は名前に ``busybox`` を含み、自動構築されたイメージを表示します。

.. code-block:: bash

   $ docker search --filter is-automated busybox
   NAME                 DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
   progrium/busybox                                                     50                   [OK]
   radial/busyboxplus   Full-chain, Internet enabled, busybox made...   8                    [OK]

is-official
--------------------

.. This example displays images with a name containing 'busybox', at least 3 stars and are official builds:

この例は名前に ``busybox`` を含み、３つ以上のスターを持つ公式ビルド・イメージを表示します。

.. code-block:: bash

   $ docker search --filter "is-automated=true" --filter "stars=3" busybox
   NAME                 DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
   progrium/busybox                                                     50                   [OK]
   radial/busyboxplus   Full-chain, Internet enabled, busybox made...   8                    [OK]

.. seealso:: 

   search
      https://docs.docker.com/engine/reference/commandline/search/
