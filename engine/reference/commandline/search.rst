.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/search/
.. SOURCE:
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/search.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_search.yaml
.. check date: 2022/03/26
.. Commits on Oct 13, 2021 373ec2cf37bd5ef812b65a8f5c43e81001a61c8c
.. -------------------------------------------------------------------

.. docker search

=======================================
docker search
=======================================


.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _docker_search-description:

説明
==========

.. Search the Docker Hub for images

Docker Hub のイメージを検索します。

.. _docker_search-usage:

使い方
==========

.. code-block:: bash

   $ docker search [OPTIONS] TERM

.. Extended description
.. _docker_search-extended-description:

補足説明
==========

.. Search Docker Hub for images

``Docker Hub`` のイメージを検索します。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <docker_search-examples>` をご覧ください。

.. _docker_save-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--filter`` , ``-f``
     - 
     - 指定した状況に基づいてフィルタ
   * - ``--format``
     - 
     - Go テンプレートを使って検索結果を整形
   * - ``--limit``
     - ``25``
     - 検索結果の最大数
   * - ``--no-trunc``
     - 
     - 出力を省略しない


.. Examples
.. _docker_search-examples:

使用例
==========

.. Search images by name
.. _docker_search-search-images-by-name:
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
.. _docker_search-display-non-truncated-description:
説明を省略せずに表示（ ``--no-trunc`` ）
------------------------------------------

.. This example displays images with a name containing 'busybox', at least 3 stars and the description isn't truncated in the output:

この例は ``busybox`` を含むイメージを表示します。少なくとも３つのスターがあるイメージを、説明を省略せずに表示します。

.. code-block:: bash

   $ docker search --stars=3 --no-trunc busybox
   NAME                 DESCRIPTION                                                                               STARS     OFFICIAL   AUTOMATED
   busybox              Busybox base image.                                                                       325       [OK]       
   progrium/busybox                                                                                               50                   [OK]
   radial/busyboxplus   Full-chain, Internet enabled, busybox made from scratch. Comes in git and cURL flavors.   8                    [OK]

.. Limit search results (--limit)
.. _docker_search-limit-search-results:

検索結果の上限（ ``--limit`` ）
----------------------------------------

.. The flag --limit is the maximium number of results returned by a search. This value could be in the range between 1 and 100. The default value of --limit is 25.

``--limit`` は検索結果で表示する最大行数です。この値は 1 から 100 までの範囲で指定が必要です。デフォルトの ``--limit`` 値は 25 です。

.. Filtering

フィルタリング
^^^^^^^^^^^^^^^^^^^^

.. The filtering flag (-f or --filter) format is a key=value pair. If there is more than one filter, then pass multiple flags (e.g. --filter "foo=bar" --filter "bif=baz")

フィルタリング・フラグ（ ``-f`` か ``--filter`` ）は ``キー=値`` ペアの形式です。複数のフィルタを指定するには、フラグを複数回使います（例： ``--filter "foo=bar" --filter "bif=baz"``  ）。

.. The currently supported filters are:

現在サポートしているフィルタは次の通りです：

..    stars (int - number of stars the image has)
    is-automated (true|false) - is the image automated or not
    is-official (true|false) - is the image official or not

* stars （整数 - イメージが持つスター数）
* is-automated（true|false）- イメージが自動構築されたかどうか
* is-official（true|false）- イメージが公式かどうか

.. stars

stars
^^^^^^^^^^


.. This example displays images with a name containing 'busybox' and at least 3 stars:

この例は名前に ``busybox`` を含み、３つ以上のスターを持つイメージを表示します。

.. code-block:: bash

   $ docker search --filter stars=3 busybox
   NAME                 DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
   busybox              Busybox base image.                             325       [OK]       
   progrium/busybox                                                     50                   [OK]
   radial/busyboxplus   Full-chain, Internet enabled, busybox made...   8                    [OK]

is-automated
^^^^^^^^^^^^^^^^^^^^

.. This example displays images with a name containing 'busybox' and are automated builds:

この例は名前に ``busybox`` を含み、自動構築されたイメージを表示します。

.. code-block:: bash

   $ docker search --filter is-automated busybox
   NAME                 DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
   progrium/busybox                                                     50                   [OK]
   radial/busyboxplus   Full-chain, Internet enabled, busybox made...   8                    [OK]

is-official
^^^^^^^^^^^^^^^^^^^^

.. This example displays images with a name containing 'busybox', at least 3 stars and are official builds:

この例は名前に ``busybox`` を含み、３つ以上のスターを持つ公式ビルド・イメージを表示します。

.. code-block:: bash

   $ docker search --filter is-official=true --filter stars=3 busybox
   NAME                 DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
   progrium/busybox                                                     50                   [OK]
   radial/busyboxplus   Full-chain, Internet enabled, busybox made...   8                    [OK]

.. Format the output
出力形式
----------

.. The formatting option (--format) pretty-prints search output using a Go template.

表示形式のオプション（ ``--format`` ）は Go テンプレートを使って検索結果を整形します。

.. Valid placeholders for the Go template are:

Go テンプレートで有効な placeholder は、こちらです。

.. list-table::
   :header-rows: 1
   
   * - プレースホルダ
     - 説明
   * - ``.Name``
     - イメージ名
   * - ``.Description``
     - イメージの説明
   * - ``.StarCount``
     - イメージの star 数
   * - ``.IsOfficial``
     - "OK" イメージが :ruby:`公式 <official>`
   * - ``.IsAutomated``
     - "OK" 自動構築されたイメージ

.. When you use the --format option, the search command will output the data exactly as the template declares. If you use the table directive, column headers are included as well.

``--format`` オプションを使うと、 ``search`` コマンドはテンプレートで宣言した通りに、データを確実に出力します。 ``table`` 命令を使う場合、列ヘッダも同様に表示します。

.. The following example uses a template without headers and outputs the Name and StarCount entries separated by a colon (:) for all images:

以下の例は、ヘッダの無いテンプレートを使い、 ``Name`` と ``StarCount`` エントリを、コロン（ ``:`` ）で区切って、全てのイメージを表示します。

.. code-block:: bash

   $ docker search --format "{{.Name}}: {{.StarCount}}" nginx
   nginx: 5441
   jwilder/nginx-proxy: 953
   richarvey/nginx-php-fpm: 353
   million12/nginx-php: 75
   webdevops/php-nginx: 70
   h3nrik/nginx-ldap: 35
   bitnami/nginx: 23
   evild/alpine-nginx: 14
   million12/nginx: 9
   maxexcloo/nginx: 7

.. This example outputs a table format:

この例は、表形式の出力です。

.. code-block:: bash

   $ docker search --format "table {{.Name}}\t{{.IsAutomated}}\t{{.IsOfficial}}" nginx
   NAME                                     AUTOMATED           OFFICIAL
   nginx                                                        [OK]
   jwilder/nginx-proxy                      [OK]
   richarvey/nginx-php-fpm                  [OK]
   jrcs/letsencrypt-nginx-proxy-companion   [OK]
   million12/nginx-php                      [OK]
   webdevops/php-nginx                      [OK]


親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI の基本コマンド

.. seealso:: 

   docker search
      https://docs.docker.com/engine/reference/commandline/search/
