.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/commit/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/commit.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/commit.md
.. check date: 2016/06/14
.. Commits on May 22, 2016 ea98cf74aad3c2633268d5a0b8a2f80b331ddc0b
.. -------------------------------------------------------------------

.. commit

=======================================
commit
=======================================

.. code-block:: bash

   使い方: docker commit [オプション] コンテナ [リポジトリ[:タグ]]
   
   コンテナの変更を元に新しいイメージを作成
   
     -a, --author=""     作者 (例 "John Hannibal Smith <hannibal@a-team.com>")
     -c, --change=[]     イメージをコミット時の Dockerfile 命令を追加指定
     --help              使い方を表示
     -m, --message=""    コミット・メッセージ
     -p, --pause=true    コンテナをコミット時に一時停止（pause)する

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. It can be useful to commit a container’s file changes or settings into a new image. This allows you debug a container by running an interactive shell, or to export a working dataset to another server. Generally, it is better to use Dockerfiles to manage your images in a documented and maintainable way. Read more about valid image names and tags.

コンテナのファイル変更や設定を、新しいイメージに収容（commit；コミット）するために便利です。これにより、インタラクティブなシェル上でコンテナをデバッグ用に動かしたり、作業中のデータセットを他のサーバに持っていくため出力したりできます。通常は、イメージを管理するためには、文書化されメンテナンスのしやすい Dockerfile を使うのが望ましい方法です。 :doc:`詳細はイメージ名とタグについてをご覧ください <tag>` 。

.. The commit operation will not include any data contained in volumes mounted inside the container.

コンテナ内でマウントされているボリュームに含まれるデータは、コミット作業に含まれません。

.. By default, the container being committed and its processes will be paused while the image is committed. This reduces the likelihood of encountering data corruption during the process of creating the commit. If this behavior is undesired, set the ‘--pause’ option to false.

デフォルトでは、コンテナをコミットする時、その過程のいてイメージをコミットする間は一時的に停止します。これはコミットする糧において、データ破損が発生する可能性を減らします。この動作を理解しているのであれば、 ``--pause`` オプションを使って無効化もできます。

.. The --change option will apply Dockerfile instructions to the image that is created. Supported Dockerfile instructions: CMD|ENTRYPOINT|ENV|EXPOSE|LABEL|ONBUILD|USER|VOLUME|WORKDIR

``--cache`` オプションは ``Dockerfile`` の命令でイメージが作られる時のみ適用されます。対応している ``Dockerfile`` 命令は、 ``CMD`` 、 ``ENTRYPOINT`` 、 ``ENV`` 、 ``EXPOSE`` 、 ``LABEL`` 、 ``ONBUILD`` 、 ``USER`` 、 ``VOLUME`` 、 ``WORKDIR`` です。

.. Commit a container

.. _commit-a-container:

コンテナのコミット
====================

.. code-block:: bash

   $ docker ps
   ID                  IMAGE               COMMAND             CREATED             STATUS              PORTS
   c3f279d17e0a        ubuntu:12.04        /bin/bash           7 days ago          Up 25 hours
   197387f1b436        ubuntu:12.04        /bin/bash           7 days ago          Up 25 hours
   $ docker commit c3f279d17e0a  svendowideit/testimage:version3
   f5283438590d
   $ docker images
   REPOSITORY                        TAG                 ID                  CREATED             SIZE
   svendowideit/testimage            version3            f5283438590d        16 seconds ago      335.7 MB

.. Commit a container with new configurations

新しい設定でコンテナをコミット
==============================

.. code-block:: bash

   $ docker ps
   ID                  IMAGE               COMMAND             CREATED             STATUS              PORTS
   c3f279d17e0a        ubuntu:12.04        /bin/bash           7 days ago          Up 25 hours
   197387f1b436        ubuntu:12.04        /bin/bash           7 days ago          Up 25 hours
   $ docker inspect -f "{{ .Config.Env }}" c3f279d17e0a
   [HOME=/ PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin]
   $ docker commit --change "ENV DEBUG true" c3f279d17e0a  svendowideit/testimage:version3
   f5283438590d
   $ docker inspect -f "{{ .Config.Env }}" f5283438590d
   [HOME=/ PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin DEBUG=true]

.. Commit a container with new CMD and EXPOSE instructions

新しい ``CMD`` と ``EXPOSE`` 命令でコンテナをコミット
============================================================

.. code-block:: bash

   $ docker ps
   ID                  IMAGE               COMMAND             CREATED             STATUS              PORTS
   c3f279d17e0a        ubuntu:12.04        /bin/bash           7 days ago          Up 25 hours
   197387f1b436        ubuntu:12.04        /bin/bash           7 days ago          Up 25 hours
   
   $ docker commit --change='CMD ["apachectl", "-DFOREGROUND"]' -c "EXPOSE 80" c3f279d17e0a  svendowideit/testimage:version4
   f5283438590d
   
   $ docker run -d svendowideit/testimage:version4
   89373736e2e7f00bc149bd783073ac43d0507da250e999f3f1036e0db60817c0
   
   $ docker ps
   ID                  IMAGE               COMMAND                 CREATED             STATUS              PORTS
   89373736e2e7        testimage:version4  "apachectl -DFOREGROU"  3 seconds ago       Up 2 seconds        80/tcp
   c3f279d17e0a        ubuntu:12.04        /bin/bash               7 days ago          Up 25 hours
   197387f1b436        ubuntu:12.04        /bin/bash               7 days ago          Up 25 hours

.. seealso:: 

   commit
      https://docs.docker.com/engine/reference/commandline/commit/


