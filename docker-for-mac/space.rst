.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/docker-for-mac/space/
   doc version: 19.03
      https://github.com/docker/docker.github.io/blob/master/docker-for-mac/space.md
.. check date: 2020/06/10
.. Commits on Jan 22, 2020 1cd461644b1dca9019df269bb1906bc3d364231d
.. -----------------------------------------------------------------------------

.. Disk utilization in Docker for Mac

.. _disk-utilization-in-docker-for-mac:

==================================================
Docker for Mac におけるディスク使用
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Docker Desktop stores Linux containers and images in a single, large “disk image” file in the Mac filesystem. This is different from Docker on Linux, which usually stores containers and images in the /var/lib/docker directory.

Docker Desktop で Linux コンテナとイメージを保管するのは、Mac ファイルシステム内の単一の大きな「ディスク・イメージ」ファイルです。これは Linux 上の Docker が :code:`/var/lib/docker` ディレクトリにコンテナとイメージを保管するのと異なります。

.. Where is the disk image file?

.. _mac-where-is-the-disk-image-file:

ディスクイメージファイルはどこに？
==================================================

.. To locate the disk image file, select the Docker icon and then Preferences > Resources > Advanced.

ディスクイメージファイルの場所をさがすには、 Docker アイコンから **Preferences > Resources > Advanced** を選択します。

.. Disk preferences

.. The **Advanced** tab displays the location of the disk image. It also displays the maximum size of the disk image and the actual space the disk image is consuming. Note that other tools might display space usage of the file in terms of the maximum file size, and not the actual file size.

**Advanced** タブに、ディスクイメージの場所が表示されています。
またディスクイメージの最大サイズや、現在消費しているディスクイメージ容量も表示されています。
なおファイルの利用容量のことを最大ファイルサイズと表現しているツールがありますが、実際のファイルサイズとして表現していないから誤りです。


.. If the file is too big

.. _mac-if-the-file-is-too-big:

ファイルが大きすぎる場合
==================================================

.. If the disk image file is too big, you can:

ディスクイメージファイルが大きすぎる場合、次の対処ができます：

..    move it to a bigger drive,
    delete unnecessary containers and images, or
    reduce the maximum allowable size of the file.

* より大きなドライブに移動
* 不要なコンテナやイメージを削除、あるいは
* ファイルに割り当て可能な最大サイズを減らす

.. Move the file to a bigger drive

.. _move-the-file-to-a-bigger-drive:

大きなドライブにファイルを移動
--------------------------------------------------

.. To move the disk image file to a different location:

ディスクイメージファイルを別の場所に移動するには：

..    Select Preferences > Resources > Advanced.

1. **Preferences > Resources > Advanced** を選択

..    In the Disk image location section, click Browse and choose a new location for the disk image.

2. **Disk image locaition**  セクション内で、 **Browse**  をクリックし、ディスクイメージの新しい場所を選択

..    Click Apply & Restart for the changes to take effect.

3. 設定を反映するには **Apply & Restart**  をクリックします。

.. Do not move the file directly in Finder as this can cause Docker Desktop to lose track of the file.

（macOS の）Finder でファイルディレクトリを移動しないでください。移動しても、 Docker Desktop はファイルを追跡できません。

.. Delete unnecessary containers and images

.. _mac-delete-unnecessary-containers-and-images:

不要なコンテナやイメージを削除
--------------------------------------------------

.. Check whether you have any unnecessary containers and images. If your client and daemon API are running version 1.25 or later (use the docker version command on the client to check your client and daemon API versions), you can see the detailed space usage information by running:

不要なコンテナやイメージがないかどうか確認します。クライアントとデーモン API がバージョン 1.25 以降で動いていれば（クライアントで :code:`docker version` コマンドを実行し、クライアントとデーモンの API バージョンを確認できます ）、次のコマンド実行によって詳細な容量の利用状況が分かります。

.. code-block:: bash

   docker system df -v

.. Alternatively, to list images, run:

あるいは、イメージ一覧を表示します。

.. code-block:: bash

   $ docker image ls

.. and then, to list containers, run:

そして、次にコンテナ一覧を表示します。

.. code-block:: bash

   $ docker container ls -a

.. If there are lots of redundant objects, run the command:

もしも不要なものが大量にあれば、次のコマンドを実行します。

.. code-block:: bash

   $ docker system prune

.. This command removes all stopped containers, unused networks, dangling images, and build cache.

このコマンドは停止済みコンテナ、使用していないネットワーク、派生イメージ、構築キャッシュをすべて削除します。

.. It might take a few minutes to reclaim space on the host depending on the format of the disk image file:

ホストに依存するディスクイメージファイル形式によっては、容量改善のために数分の時間がかかることもあります。

..    If the file is named Docker.raw: space on the host should be reclaimed within a few seconds.
    If the file is named Docker.qcow2: space will be freed by a background process after a few minutes.

* ファイル名が :code:`Docker.raw` ：ホスト上のスペース改善は数秒以内に終わります。
* ファイル名が :code:`Docker.qcow2` ：バックグラウンド処理が進行し、数分後に空き容量が増えます。

.. Space is only freed when images are deleted. Space is not freed automatically when files are deleted inside running containers. To trigger a space reclamation at any point, run the command:


容量の解放は、イメージを削除した時のみです。実行中のコンテナ内でファイルを削除しても、自動的に空き容量は解放されません。任意のタイミングで容量を確保をしたければ、次のコマンドを実行します。

.. code-block:: bash

   $ docker run --privileged --pid=host docker/desktop-reclaim-space

.. Note that many tools report the maximum file size, not the actual file size. To query the actual size of the file on the host from a terminal, run:

多くのツールでは、実際に使用しているファイルサイズではなく、ファイルが確保するサイズを表示する場合があるため、注意してください。ホスト上のファイルが実際に使用している容量を確認するには、ターミナル上で次のコマンドを実行します：

.. code-block:: bash

   $ cd ~/Library/Containers/com.docker.docker/Data
   $ cd vms/0/data
   $ ls -klsh Docker.raw
   2333548 -rw-r--r--@ 1 username  staff    64G Dec 13 17:42 Docker.raw

.. In this example, the actual size of the disk is 2333548 KB, whereas the maximum size of the disk is 64 GB.

この例では、ディスクの実際のサイズは :code:`2333548` KB ですが、最大のディスクサイズは :code:`64` GB です。

.. Reduce the maximum size of the file

.. _mac-reduce-the-maximum-size-of-the-file:

ファイルに割り当て可能な最大サイズを減らす
--------------------------------------------------

.. To reduce the maximum size of the disk image file:

ディスクイメージファイルの最大サイズを減らすには：

..    Select the Docker icon and then select Preferences > Resources > Advanced.

1. Docker アイコンから **Preferences > Resoruces > Advanced** を選択

..    The Disk image size section contains a slider that allows you to change the maximum size of the disk image. Adjust the slider to set a lower limit.

2. **Disk image size** セクションで、スライダーを調整。この変更によって、ディスクイメージに割り当てる最大容量を変更できる。スライダーを下限にセット

..    Click Apply & Restart.

3. **Apply & Restart**  をクリック

.. When you reduce the maximum size, the current disk image file is deleted, and therefore, all containers and images will be lost.

最大容量を変更すると、使用中のディスクイメージファイルは削除されます。つまり、全てのコンテナとイメージは失われます。


.. seealso:: 

   Disk utilization in Docker for Mac
      https://docs.docker.com/docker-for-mac/space/
