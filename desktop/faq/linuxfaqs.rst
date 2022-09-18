.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/desktop/faqs/linuxfaqs/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/desktop/faqs/linuxfaqs.md
.. check date: 2022/09/18
.. Commits on Jul 28, 2022 22c2d4f57d202aaf8d799ca46ca6d92632e9f2fd
.. -----------------------------------------------------------------------------


.. Frequently asked questions for Linux
.. _desktop-frequently-asked-questions-for-linux:

==================================================
よくある質問と回答 Linux 版
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Where does Docker Desktop store Linux containers and images?
.. _desktop-linux-where-does-docker-desktop-store-linux-containers-and-images:

Docker Desktop は Linux コンテナとイメージをどこに保存しますか？
----------------------------------------------------------------------

.. Docker Desktop stores Linux containers and images in a single, large “disk image” file in the Linux filesystem. This is different from Docker on Linux, which usually stores containers and images in the /var/lib/docker directory on the host’s filesystem.

Docker Desktop は Linux コンテナとイメージを、 Linux ファイルシステム内で、1つの大きな「ディスクイメージ」ファイルに保存します。これは、通常 ``/var/lib/docker`` ディレクトリにコンテナとイメージを保存する Linux 上の Docker とは異なります。

.. Where is the disk image file?
.. _desktop-linux-where-is-the-disk-image-file:

ディスクイメージのファイルはどこですか？
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. To locate the disk image file, select Preferences from the Docker Dashboard then Advanced from the Resources tab.

ディスクイメージファイルを探すには、 Docker ダッシュボードから **Preferences** を選び、 **Resources** タブから **Advanced** を探します。

.. The Advanced tab displays the location of the disk image. It also displays the maximum size of the disk image and the actual space the disk image is consuming. Note that other tools might display space usage of the file in terms of the maximum file size, and not the actual file size.

**Advanced** タブにはディスクイメージの場所を表示します。また、ディスクイメージの最大容量と、ディスクイメージが使用している実際の容量を表示します。他のツールでは、実際のファイル容量ではなく、最大ファイル容量としてディスク使用量が表示される場合があるので、ご注意ください。

.. What if the file is too big?
.. _desktop-linux-what-if-the-file-is-too-big:

ファイルが大きすぎる場合は、どうしたらいいでしょうか？
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. If the disk image file is too big, you can:

ディスクイメージが大きすぎる場合、次のことができます：

..  Move it to a bigger drive
    Delete unnecessary containers and images
    Reduce the maximum allowable size of the file

* より大きなドライブにディスクイメージを移動する
* 不要なコンテナとイメージを削除する
* ファイルに割り当て可能な最大容量を減らす

.. How do I move the file to a bigger drive?
.. _desktop-linux-how-do-i-move-the-file-to-a-bigger-drive:

大きなドライブにファイルを移動する方法は？
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. To move the disk image file to a different location:

ディスクイメージファイルを別の場所に移動するには、次のように実行します：

..  Select Preferences then Advanced from the Resources tab.
    In the Disk image location section, click Browse and choose a new location for the disk image.
    Click Apply & Restart for the changes to take effect.

1. **Preferences** を選び、 **Resources** タブから **Advanced** を選ぶ
2. **Disk image location** セクション内で、 **Browse** をクリックし、ディスクイメージの新しい場所を選ぶ
3. 変更を反映するには、 **Apply & Restart** をクリック

.. Do not move the file directly in Finder as this can cause Docker Desktop to lose track of the file.

Finder を使ってファイルを直接移動しないでください。移動してしまうと、 Docker Desktop がファイルを追跡できなくなります。

.. How do I delete unnecessary containers and images?
.. _docker-desktop-how-do-i-delete-unnecessary-containers-and-images:

不要なコンテナとイメージをどうやって削除しますか？
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. Check whether you have any unnecessary containers and images. If your client and daemon API are running version 1.25 or later (use the docker version command on the client to check your client and daemon API versions), you can see the detailed space usage information by running:

不要なコンテナとイメージを持っているかどうかを調べます。クライアントとデーモン API がバージョン 1.25 以上で実行している場合（ ``docker version`` コマンドを使い、クライアントとデーモン API のバージョンを確認できます）、次のように実行して詳細な容量の使用情報を表示できます：

.. code-block:: bash

   $ docker system df -v

.. Alternatively, to list images, run:

または、イメージ一覧を表示するには、次のように実行します：

.. code-block:: bash

   $ docker image ls

.. and then, to list containers, run:

それから、コンテナ一覧を表示するため、次のように実行します：

.. code-block:: bash

   $ docker container ls -a

.. If there are lots of redundant objects, run the command:

不要なオブジェクトがたくさんある場合、次のコマンドを実行します：

.. code-block:: bash

   $ docker system prune

.. This command removes all stopped containers, unused networks, dangling images, and build cache.

このコマンドは、停止中のコンテナ、使われていないネットワーク、宙吊りイメージと構築キャッシュを全て削除します。

.. It might take a few minutes to reclaim space on the host depending on the format of the disk image file:

ホストが依存しているディスクイメージのファイル形式によっては、容量の確保に数分ほど必要な場合があります。

..  If the file is named Docker.raw: space on the host should be reclaimed within a few seconds.
    If the file is named Docker.qcow2: space will be freed by a background process after a few minutes.

* ファイル名が ``Docker.raw`` の場合：ホスト上の空きは数秒以内に確保できる
* ファイル名が ``Docker.qcow2`` の場合：バックグラウンドのプロセスとして容量を確保するため、数分かかる

.. Space is only freed when images are deleted. Space is not freed automatically when files are deleted inside running containers. To trigger a space reclamation at any point, run the command:

イメージが削除された時にのみ、容量が解放されます。実行しているコンテナ内でファイルを削除しても、自動的に空き容量として解放されません。容量確保をいつでも行いたい場合は、次のコマンドを実行します。

.. code-block:: bash

   $ docker run --privileged --pid=host docker/desktop-reclaim-space

.. Note that many tools report the maximum file size, not the actual file size. To query the actual size of the file on the host from a terminal, run:

ツールでは、実際のファイル容量ではなく、最大ファイル容量としてディスク使用量が表示される場合があるので、ご注意ください。ホスト上での実際の容量を確認するには、ターミナルから次のように実行します。

.. code-block:: bash

   $ cd ~/.docker/desktop/vms/0/data
   $ ls -klsh Docker.raw
   2333548 -rw-r--r--@ 1 username  staff    64G Dec 13 17:42 Docker.raw

.. In this example, the actual size of the disk is 2333548 KB, whereas the maximum size of the disk is 64 GB.

この例では、ディスクの最大容量は ``64`` GB ですが、ディスクの実際の容量は ``2333548``  KB です。

.. How do I reduce the maximum size of the file?
.. _desktop-linux-how-do-i-reduce-the-maximum-size-of-the-file:

ファイルの最大容量を減らすには、どうしたらいいでしょうか？
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. To reduce the maximum size of the disk image file:

ディスクイメージファイルの最大容量を減らすには、次のようにします。

..  Select Preferences then Advanced from the Resources tab.
    The Disk image size section contains a slider that allows you to change the maximum size of the disk image. Adjust the slider to set a lower limit.
    Click Apply & Restart.

1. **Preferences** を選び、 **Resources** タブから **Advanced** を選ぶ
2. **Disk image location** セクション内で、 ディスクイメージの最大容量を変更できます。スライダーを下限に調整します。
3. 変更を反映するには、 **Apply & Restart** をクリック

.. When you reduce the maximum size, the current disk image file is deleted, and therefore, all containers and images will be lost.

最大容量を減らす場合は、現在のディスクイメージは削除されます。つまり、全てのコンテナとディレクトリは失われます。

.. seealso:: 

   Frequently asked questions for Linux
      https://docs.docker.com/desktop/faqs/linuxfaqs/
