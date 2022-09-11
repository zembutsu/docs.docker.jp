.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/rmi/
.. SOURCE:
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/rmi.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_rmi.yaml
.. check date: 2022/03/23
.. Commits on Aug 22, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker rmi

=======================================
docker rmi
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _docker_rmi-description:

説明
==========

.. Remove one or more images

1つまたは複数の :ruby:`イメージ <image>` を :ruby:`削除 <remove>` します。

.. _docker_rmi-usage:

使い方
==========

.. code-block:: bash

   $ docker rmi [OPTIONS] IMAGE [IMAGE...]

.. Extended description
.. _docker_rmi-extended-description:

補足説明
==========

.. Removes (and un-tags) one or more images from the host node. If an image has multiple tags, using this command with the tag as a parameter only removes the tag. If the tag is the only one for the image, both the image and the tag are removed.

ホスト・ノード上の1つまたは複数のイメージを :ruby:`削除 <remove>` （かつ、 :ruby:`タグ削除 <un-tag>` ）します。イメージに複数のタグがある場合は、このコマンドのパラメータとしてタグを使うと、そのタグのみ削除します。タグが1つのイメージに対してしかない場合は、イメージとタグの両方を削除します。

.. This does not remove images from a registry. You cannot remove an image of a running container unless you use the -f option. To see all images on a host use the docker image ls command.

これは、レジストリからはイメージを削除しません。また、 ``-f`` オプションを使わない限り、実行中のコンテナからイメージを削除できません。ホスト上にある全てのイメージを表示するには、 ``docker image ls`` コマンドを使います。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <docker_rmi-examples>` をご覧ください。

.. _docker_rmi-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--force`` , ``-f``
     - 
     - イメージの強制削除
   * - ``--no-prune``
     - 
     - タグの付いていない親イメージを削除しない


.. Examples
.. _docker_rmi-examples:

使用例
==========

.. You can remove an image using its short or long ID, its tag, or its digest. If an image has one or more tags referencing it, you must remove all of them before the image is removed. Digest references are removed automatically when an image is removed by tag.

ショート ID かロング ID、タグ、digest を使ってイメージを削除できます。イメージがタグによって参照されている場合、イメージを削除する前にそれらの削除が必要です。Digest の参照値はイメージのタグを削除する時、自動的に削除されます。

.. code-block:: bash

   $ docker images
   REPOSITORY                TAG                 IMAGE ID            CREATED             SIZE
   test1                     latest              fd484f19954f        23 seconds ago      7 B (virtual 4.964 MB)
   test                      latest              fd484f19954f        23 seconds ago      7 B (virtual 4.964 MB)
   test2                     latest              fd484f19954f        23 seconds ago      7 B (virtual 4.964 MB)
   
   $ docker rmi fd484f19954f
   Error: Conflict, cannot delete image fd484f19954f because it is tagged in multiple repositories, use -f to force
   2013/12/11 05:47:16 Error: failed to remove one or more images
   
   $ docker rmi test1
   Untagged: test1:latest
   $ docker rmi test2
   Untagged: test2:latest
   
   $ docker images
   REPOSITORY                TAG                 IMAGE ID            CREATED             SIZE
   test                      latest              fd484f19954f        23 seconds ago      7 B (virtual 4.964 MB)
   $ docker rmi test
   Untagged: test:latest
   Deleted: fd484f19954f4920da7ff372b5067f5b7ddb2fd3830cecd17b96ea9e286ba5b8
   
.. If you use the -f flag and specify the image’s short or long ID, then this command untags and removes all images that match the specified ID.

``-f`` フラグでイメージのショート ID かロング ID を指定したら、このコマンド対象の ID に一致するイメージは全てのタグを外し、削除されます。

.. code-block:: bash

   $ docker images
   REPOSITORY                TAG                 IMAGE ID            CREATED             SIZE
   test1                     latest              fd484f19954f        23 seconds ago      7 B (virtual 4.964 MB)
   test                      latest              fd484f19954f        23 seconds ago      7 B (virtual 4.964 MB)
   test2                     latest              fd484f19954f        23 seconds ago      7 B (virtual 4.964 MB)
   
   $ docker rmi -f fd484f19954f
   Untagged: test1:latest
   Untagged: test:latest
   Untagged: test2:latest
   Deleted: fd484f19954f4920da7ff372b5067f5b7ddb2fd3830cecd17b96ea9e286ba5b8

.. An image pulled by digest has no tag associated with it:

取得したイメージがタグ付けされていなくても、digest を確認できます。

.. code-block:: bash

   $ docker images --digests
   REPOSITORY                     TAG       DIGEST                                                                    IMAGE ID        CREATED         SIZE
   localhost:5000/test/busybox    <none>    sha256:cbbf2f9a99b47fc460d422812b6a5adff7dfee951d8fa2e4a98caa0382cfbdbf   4986bf8c1536    9 weeks ago     2.43 MB

.. To remove an image using its digest:

digest を使ってイメージを削除するには、次のようにします。

.. code-block:: bash

   $ docker rmi localhost:5000/test/busybox@sha256:cbbf2f9a99b47fc460d422812b6a5adff7dfee951d8fa2e4a98caa0382cfbdbf
   Untagged: localhost:5000/test/busybox@sha256:cbbf2f9a99b47fc460d422812b6a5adff7dfee951d8fa2e4a98caa0382cfbdbf
   Deleted: 4986bf8c15363d1c5d15512d5266f8777bfba4974ac56e3270e7760f6f0a8125
   Deleted: ea13149945cb6b1e746bf28032f02e9b5a793523481a0a18645fc77ad53c4ea2
   Deleted: df7546f9f060a2268024c8a230d8639878585defcc1bc6f79d2728a13957871b


親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI の基本コマンド

.. seealso:: 

   docker rmi
      https://docs.docker.com/engine/reference/commandline/rmi/

