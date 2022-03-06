.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/commit/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/cli/blob/master/docs/reference/commandline/commit.md
.. check date: 2022/03/05
.. Commits on May 22, 2016 ea98cf74aad3c2633268d5a0b8a2f80b331ddc0b
.. -------------------------------------------------------------------

.. docker commit

=======================================
docker commit
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

説明
==========

.. Create a new image from a container’s changes

コンテナに対する変更から、新しいイメージを作成。

使い方
==========

.. code-block:: bash

   $ docker commit [OPTIONS] CONTAINER [REPOSITORY[:TAG]]

詳細説明
==========

.. It can be useful to commit a container’s file changes or settings into a new image. This allows you debug a container by running an interactive shell, or to export a working dataset to another server. Generally, it is better to use Dockerfiles to manage your images in a documented and maintainable way. Read more about valid image names and tags.

コンテナ上でのファイル変更や設定を、新しいイメージに収容（commit；コミット）するために役立ちます。これにより、インタラクティブなシェル上でコンテナをデバッグ用に動かしたり、作業中のデータセットを他のサーバに持っていくために出力したりできます。通常は、イメージを管理するためには、文書化されメンテナンスのしやすい Dockerfile を使うのが望ましい方法です。 :doc:`詳細はイメージ名とタグについてをご覧ください <tag>` 。

.. The commit operation will not include any data contained in volumes mounted inside the container.

コンテナ内でマウントされているボリュームに含まれるデータは、コミット対象に含まれません。

.. By default, the container being committed and its processes will be paused while the image is committed. This reduces the likelihood of encountering data corruption during the process of creating the commit. If this behavior is undesired, set the ‘--pause’ option to false.

コミット対象のコンテナとそこに動作するプロセスは、イメージコミット処理の間は、デフォルトで一時停止します。これにより、コミットの作成中にデータの破損が発生する可能性が低くなります。この動作が望ましくない場合は、 ``--pause`` オプションを false に設定してください。

.. The --change option will apply Dockerfile instructions to the image that is created. Supported Dockerfile instructions: CMD|ENTRYPOINT|ENV|EXPOSE|LABEL|ONBUILD|USER|VOLUME|WORKDIR

``--change`` オプションは ``Dockerfile`` の命令でイメージが作られる時のみ適用されます。対応している ``Dockerfile`` 命令は、 ``CMD`` 、 ``ENTRYPOINT`` 、 ``ENV`` 、 ``EXPOSE`` 、 ``LABEL`` 、 ``ONBUILD`` 、 ``USER`` 、 ``VOLUME`` 、 ``WORKDIR`` です。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <commit-examples>` をご覧ください。

.. _commit-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--author`` , ``-a``
     - 
     - 作者（例「John Hannibal Smith <hannibal@a-team.com>」）
   * - ``--change`` , ``-c``
     - 
     - Dockerfile 命令をイメージの作成時に適用
   * - ``--message`` , ``-m``
     - 
     - メッセージをコミット
   * - ``--pause`` , ``-p``
     - ``true``
     - コミット通はコンテナを一時停止

.. _commit-examples:

使用例
==========

.. Commit a container

.. _commit-a-container:

コンテナのコミット
^^^^^^^^^^^^^^^^^^^^

.. code-block:: bash

   $ docker ps
   
   CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS              NAMES
   c3f279d17e0a        ubuntu:12.04        /bin/bash           7 days ago          Up 25 hours                            desperate_dubinsky
   197387f1b436        ubuntu:12.04        /bin/bash           7 days ago          Up 25 hours                            focused_hamilton

.. code-block:: bash

   $ docker commit c3f279d17e0a  svendowideit/testimage:version3
   
   f5283438590d

.. code-block:: bash

   $ docker images
   
   REPOSITORY                        TAG                 ID                  CREATED             SIZE
   svendowideit/testimage            version3            f5283438590d        16 seconds ago      335.7 MB



.. Commit a container with new configurations

.. _commit-a-container-with-new-configurations:

新しい設定でコンテナをコミット
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: bash

   $ docker ps
   
   CONTAINER ID       IMAGE               COMMAND             CREATED             STATUS              PORTS              NAMES
   c3f279d17e0a        ubuntu:12.04        /bin/bash           7 days ago          Up 25 hours                            desperate_dubinsky
   197387f1b436        ubuntu:12.04        /bin/bash           7 days ago          Up 25 hours                            focused_hamilton

.. code-block:: bash

   $ docker inspect -f "{{ .Config.Env }}" c3f279d17e0a
   
   [HOME=/ PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin]

.. code-block:: bash

   $ docker commit --change "ENV DEBUG=true" c3f279d17e0a  svendowideit/testimage:version3
   
   f5283438590d

.. code-block:: bash

   $ docker inspect -f "{{ .Config.Env }}" f5283438590d
   
   [HOME=/ PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin DEBUG=true]



.. Commit a container with new CMD and EXPOSE instructions

.. _commit-a-container-with-new-cmd-and-expose-instructions:

新しい ``CMD`` と ``EXPOSE`` 命令で、コンテナをコミット
============================================================

.. code-block:: bash

   $ docker ps
   ID                  IMAGE               COMMAND             CREATED             STATUS              PORTS
   c3f279d17e0a        ubuntu:12.04        /bin/bash           7 days ago          Up 25 hours
   197387f1b436        ubuntu:12.04        /bin/bash           7 days ago          Up 25 hours

.. code-block:: bash

   $ docker commit --change='CMD ["apachectl", "-DFOREGROUND"]' -c "EXPOSE 80" c3f279d17e0a  svendowideit/testimage:version4
   f5283438590d

.. code-block:: bash

   $ docker run -d svendowideit/testimage:version4
   89373736e2e7f00bc149bd783073ac43d0507da250e999f3f1036e0db60817c0

.. code-block:: bash

   $ docker ps
   ID                  IMAGE               COMMAND                 CREATED             STATUS              PORTS
   89373736e2e7        testimage:version4  "apachectl -DFOREGROU"  3 seconds ago       Up 2 seconds        80/tcp
   c3f279d17e0a        ubuntu:12.04        /bin/bash               7 days ago          Up 25 hours
   197387f1b436        ubuntu:12.04        /bin/bash               7 days ago          Up 25 hours

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI の基本コマンド


.. seealso:: 

   docker commit
      https://docs.docker.com/engine/reference/commandline/commit/


