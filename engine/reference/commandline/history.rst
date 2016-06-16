.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/history/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/history.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/history.md
.. check date: 2016/06/16
.. Commits on Dec 24, 2015 e6115a6c1c02768898b0a47e550e6c67b433c436
.. -------------------------------------------------------------------

.. history

=======================================
history
=======================================

.. code-block:: bash

   使い方: docker history [オプション] イメージ
   
   イメージの履歴を表示
   
     -H, --human=true     サイズと日付を人が読みやすい形式で表示
     --help               使い方の表示
     --no-trunc=false     トランケート（truncate）を出力しない
     -q, --quiet=false    整数値の ID のみ表示

.. To see how the docker:latest image was built:

``docker:latest`` イメージをどのように構築したかを確認します。

.. code-block:: bash

   $ docker history docker
   IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
   3e23a5875458        8 days ago          /bin/sh -c #(nop) ENV LC_ALL=C.UTF-8            0 B
   8578938dd170        8 days ago          /bin/sh -c dpkg-reconfigure locales &&    loc   1.245 MB
   be51b77efb42        8 days ago          /bin/sh -c apt-get update && apt-get install    338.3 MB
   4b137612be55        6 weeks ago         /bin/sh -c #(nop) ADD jessie.tar.xz in /        121 MB
   750d58736b4b        6 weeks ago         /bin/sh -c #(nop) MAINTAINER Tianon Gravi <ad   0 B
   511136ea3c5a        9 months ago                                                        0 B                 Imported from -

.. To see how the docker:apache image was added to a container’s base image:

``docker:scm`` イメージが何のコンテナ・ベース・イメージから作られたかを確認します。

.. code-block:: bash

   $ docker history docker:scm
   IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
   2ac9d1098bf1        3 months ago        /bin/bash                                       241.4 MB            Added Apache to Fedora base image
   88b42ffd1f7c        5 months ago        /bin/sh -c #(nop) ADD file:1fd8d7f9f6557cafc7   373.7 MB
   c69cab00d6ef        5 months ago        /bin/sh -c #(nop) MAINTAINER Lokesh Mandvekar   0 B
   511136ea3c5a        19 months ago                                                       0 B                 Imported from -

.. seealso:: 

   history
      https://docs.docker.com/engine/reference/commandline/history/


