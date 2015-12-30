.. -*- coding: utf-8 -*-
.. https://docs.docker.com/engine/userguide/storagedriver/imagesandcontainers/
.. doc version: 1.9
.. check date: 2015/12/29
.. -----------------------------------------------------------------------------

.. Understand images, containers, and storage driver

.. _understand-images-containers-and-storage-driver:

==================================================
イメージ、コンテナ、ストレージ・ドライバの理解
==================================================

.. To use storage drivers effectively, you must understand how Docker builds and stores images. Then, you need an understanding of how these images are used in containers. Finally, you’ll need a short introduction to the technologies that enable both images and container operations.

ストレージ・ドライバを効率的に使うには、Docker がどのようにイメージを構築・保管するかの理解が必須です。それから、これらのイメージがコンテナでどのように使われているかの理解が必要になります。最後は、イメージとコンテナの両方を操作するための技術に対する短い紹介（イントロダクション）が必要となるでしょう。

.. Images and containers rely on layers

イメージとコンテナはレイヤに依存
========================================

.. Docker images are a series of read-only layers that are stacked on top of each other to form a single unified view. The first image in the stack is called a base image and all the other layers are stacked on top of this layer. The diagram below shows the Ubuntu 15:04 image comprising 4 stacked image layers.

Docker イメージは読み込み専用（read-only）のレイヤが組（セット）になっているもので、それぞれのレイヤが層（スタック）として積み重なり、１つに統合された形に見えるものです。この１番目の層を *ベース・イメージ (base imae)* と呼び、他の全てのレイヤは、このベース・イメージのレイヤ上に積み重なります。次の図は、 Ubuntu 15:04 イメージが４つのイメージ・レイヤを組みあわせて構成されているのが分かります。

.. image:: ./images/image-layers.png
   :scale: 60%
   :alt: イメージ層

.. When you make a change inside a container by, for example, adding a new file to the Ubuntu 15.04 image, you add a new layer on top of the underlying image stack. This change creates a new image layer containing the newly added file. Each image layer has its own universal unique identifier (UUID) and each successive image layer builds on top of the image layer below it.

コンテナ内部に変更を加えた時を考えます。例えば、Ubuntu 15.04 イメージ上に新しくファイルを追加すると、下にあるイメージ層の上に、新しいレイヤを追加します。この変更は、新しく追加したファイルを含む新しいレイヤを作成します。各イメージ・レイヤは自身の UUID（universal unique identifier）を持っており、下の方にあるイメージの上に、連続したイメージ・レイヤを構築します。

.. Containers (in the storage context) are a combination of a Docker image with a thin writable layer added to the top known as the container layer. The diagram below shows a container running the Ubuntu 15.04 image.

コンテナ（ストレージの内容を含みます）は Docker イメージと薄い書き込み可能なレイヤとを連結したものです。この書き込み可能なレイヤは一番上にあり、 *コンテナ・レイヤ（container layer）* と呼ばれます。以下の図は ubuntu 15.04 イメージの実行状態です。

.. image:: ./images/container-layers.png
   :scale: 60%
   :alt: コンテナ・レイヤとイメージ

.. The major difference between a container and an image is this writable layer. All writes to the container that add new or modifying existing data are stored in this writable layer. When the container is deleted the writeable layer is also deleted. The image remains unchanged.

コンテナとイメージとの主な違いは、書き込み可能なレイヤ（writable layer）です。全てのコンテナに対する書き込み、つまり、新しいファイルの追加や既存のデータに対する変更は、この書き込み可能なレイヤに保管されます。コンテナが書き込み可能なレイヤを削除すると、コンテナも削除されます。イメージは変更されないままです。

.. Because each container has its own thin writable container layer and all data is stored this container layer, this means that multiple containers can share access to the same underlying image and yet have their own data state. The diagram below shows multiple containers sharing the same Ubuntu 15.04 image.

それぞれのコンテナは、自分自身で書き込み可能なレイヤを持つので、全てのデータは対象のコンテナレイヤに保管されます。つまり、複数のコンテナが根底にあるイメージを共有アクセスすることができ、それぞれのコンテナ自身がデータをも管理できることを意味します。次の図は複数のコンテナが同じ Ubuntu 15.04 イメージを共有しているものです。

.. image:: ./images/sharing-layers.png
   :scale: 60%
   :alt: レイヤの共有

.. A storage driver is responsible for enabling and managing both the image layers and the writeable container layer. How a storage driver accomplishes these behaviors can vary. Two key technologies behind Docker image and container management are stackable image layers and copy-on-write (CoW).

ストレージ・ドライバは、イメージ・レイヤと書き込み可能なコンテナ・レイヤの両方を有効化・管理する責任があります。ストレージ・ドライバは様々な方法で処理をします。Docker イメージとコンテナ管理という２つの重要な技術の裏側にあるのは、積み上げ可能なイメージ・レイヤとコピー・オン・ライト（CoW）です。

.. The copy-on-write strategy

.. _the-copy-on-write-strategy:

コピー・オン・ライト方式
==============================

.. Sharing is a good way to optimize resources. People do this instinctively in daily life. For example, twins Jane and Joseph taking an Algebra class at different times from different teachers can share the same exercise book by passing it between each other. Now, suppose Jane gets an assignment to complete the homework on page 11 in the book. At that point, Jane copy page 11, complete the homework, and hand in her copy. The original exercise book is unchanged and only Jane has a copy of the changed page 11.

共有とはリソース最適化のための良い手法です。人々はこれを日常生活通で無意識に行っています。例えば双子の Jane と Joseph が代数学のクラスを受けるとき、回数や先生が違っても、同じ教科書を相互に共有できます。あるとき、Jane が本のページ11にある宿題を片付けようとしています。その時  Jane はページ11をコピーし、宿題を終えたら、そのコピーを提出します。Jane はページ 11 のコピーに対する変更を加えただけであり、オリジナルの教科書には手を加えていません。

.. Copy-on-write is a similar strategy of sharing and copying. In this strategy, system processes that need the same data share the same instance of that data rather than having their own copy. At some point, if one process needs to modify or write to the data, only then does the operating system make a copy of the data for that process to use. Only the process that needs to write has access to the data copy. All the other processes continue to use the original data.

コピー・オン・ライト（copy-on-write、cow）とは、共有とコピーのストラテジ（訳者注：方針、戦略の意味、ここでは方式と訳します）に似ています。このストラテジは、システム・プロセスが自分自身でデータのコピーを持つより、同一インスタンス上にあるデータ共有を必要とするものとします。書き込む必要があるプロセスのみが、データのコピーにアクセスできます。その他のプロセスは、オリジナルのデータを使い続けられます。

.. Docker uses a copy-on-write technology with both images and containers. This CoW strategy optimizes both image disk space usage and the performance of container start times. The next sections look at how copy-on-write is leveraged with images and containers thru sharing and copying.

Docker はコピー・オン・ライト技術をイメージとコンテナの両方に使います。この CoW 方式はイメージのディスク使用量とコンテナ実行時のパフォーマンスの両方を最適化します。次のセクションでは、イメージとコンテナの共有とコピーにおいて、コピー・オン・ライトがどのように動作してるのかを見てきます。

.. Sharing promotes smaller images

.. _sharing-promotes-smaller-images:

共有を促進する小さなイメージ
------------------------------

.. This section looks at image layers and copy-on-write technology. All image and container layers exist inside the Docker host’s local storage area and are managed by the storage driver. It is a location on the host’s filesystem.

このセクションではイメージレイヤとコピー・オン・ライト技術を見ていきます。全てのイメージとコンテナ・レイヤは Docker ホスト上の *ローカル・ストレージ領域* に存在し、ストレージ・ドライバによって管理されます。ストレージ領域の場所とは、ホストのファイルシステム上です。

.. The Docker client reports on image layers when instructed to pull and push images with docker pull and docker push. The command below pulls the ubuntu:15.04 Docker image from Docker Hub.

``docker pull`` と ``docker push`` でイメージ取得・送信する各命令の実行時、Docker クライアントはイメージ・レイヤについて報告します。以下のコマンドは、 Docker Hub から ``ubuntu:15.04`` Docker イメージを取得（pull）しています。

.. code-block:: bash

   $ docker pull ubuntu:15.04
   15.04: Pulling from library/ubuntu
   6e6a100fa147: Pull complete
   13c0c663a321: Pull complete
   2bd276ed39d5: Pull complete
   013f3d01d247: Pull complete
   Digest: sha256:c7ecf33cef00ae34b131605c31486c91f5fd9a76315d075db2afd39d1ccdf3ed
   Status: Downloaded newer image for ubuntu:15.04

.. From the output, you’ll see that the command actually pulls 4 image layers. Each of the above lines lists an image layer and its UUID. The combination of these four layers makes up the ubuntu:15.04 Docker image.

この出力を見ると、このコマンドが実際には４つのイメージ・レイヤを取得したのが分かります。上記のそれぞれの行が、イメージとその UUID です。これらの４つのレイヤーの組み合わせにより、 ``ubuntu:15.04`` Docker イメージを作り上げています。

.. The image layers are stored in the Docker host’s local storage area. Typically, the local storage area is in the host’s /var/lib/docker directory. Depending on which storage driver the local storage area may be in a different location. You can list the layers in the local storage area. The following example shows the storage as it appears under the AUFS storage driver:

イメージ・レイヤは Docker ホスト上のローカル・ストレージ領域に保管されます。典型的なローカル・ストレージ領域の場所は、ホスト上の ``/var/lib/docker``  ディレクトリです。ストレージ・ドライバの種類により、ローカル・ストレージ領域の場所は変わる場合があります。以下の例では、 AUFS ストレージ・ドライバが使うディレクトリを表示しています。

.. code-block:: bash

   $ sudo ls /var/lib/docker/aufs/layers
   013f3d01d24738964bb7101fa83a926181d600ebecca7206dced59669e6e6778  2bd276ed39d5fcfd3d00ce0a190beeea508332f5aec3c6a125cc619a3fdbade6
   13c0c663a321cd83a97f4ce1ecbaf17c2ba166527c3b06daaefe30695c5fcb8c  6e6a100fa147e6db53b684c8516e3e2588b160fd4898b6265545d5d4edb6796d

.. If you pull another image that shares some of the same image layers as the ubuntu:15.04 image, the Docker daemon recognize this, and only pull the layers it hasn’t already stored. After the second pull, the two images will share any common image layers.

もし、別のイメージを ``pull`` （取得）するとき、そのイメージが ``ubuntu:15.04`` イメージと同じイメージ・レイヤが共通している場合、Docker デーモンはこの状況を認識し、まだ手許に取得していないイメージのみをダウンロードします。それから、２つめのイメージを取得すると、この２つのイメージは、共通のイメージ・レイヤとして共有されるようになります。

.. You can illustrate this now for yourself. Starting the ubuntu:15.04 image that you just pulled, make a change to it, and build a new image based on the change. One way to do this is using a Dockerfile and the docker build command.

これで、自分自身で実例を示して説明できるでしょう。 ``ubuntu:15.04`` イメージを使うため、まずは取得（pull）し、変更を加え、その変更に基づく新しいイメージを構築します。この作業を行う方法の１つが、 Dockerfile と ``docker build`` コマンドを使う方法です。

..    In an empty directory, create a simple Dockerfile that starts with the ubuntu:15.04 image.

1. 空っぽのディレクトリに、 ``Dockerfile`` を作成し、ubuntu:15.04 イメージから始める記述をします。

.. code-block:: bash

   FROM ubuntu:15.04

..    Add a new file called “newfile” in the image’s /tmp directory with the text “Hello world” in it.

2. 「newfile」 という名称の新規ファイルを、イメージの ``/tmp``  ディレクトリに作成します。ファイル内には「Hello world」の文字も入れます。

.. When you are done, the Dockerfile contains two lines:

作業が終われば、 ``Dockerfile`` は次の２行になっています。

.. code-block:: bash

   FROM ubuntu:15.04
   
   RUN echo "Hello world" > /tmp/newfile

..    Save and close the file.

3. ファイルを保存して閉じます。

..    From a terminal in the same folder as your Dockerfile, run the following command:

4. ターミナルから、作成した Dockerfile と同じディレクトリ上で以下のコマンドを実行します。

.. code-block:: bash

   $ docker build -t changed-ubuntu .
   Sending build context to Docker daemon 2.048 kB
   Step 0 : FROM ubuntu:15.04
    ---> 013f3d01d247
   Step 1 : RUN echo "Hello world" > /tmp/newfile
    ---> Running in 2023460815df
    ---> 03b964f68d06
   Removing intermediate container 2023460815df
   Successfully built 03b964f68d06

..        Note: The period (.) at the end of the above command is important. It tells the docker build command to use the current working directory as its build context.

.. note::

   上記のコマンドの末尾にあるピリオド（.）は重要です。これは ``docker build`` コマンドに対して、現在の作業用ディレクトリを構築時のコンテキスト（内容物）に含めると伝えるものです。

..    The output above shows a new image with image ID 03b964f68d06.

上記の結果、新しいイメージのイメージ ID が ``03b964f68d06`` だと分かります。

..     Run the docker images command to verify the new image is in the Docker host’s local storage area.

5. ``docker images`` コマンドを実行し、Docker ホスト上のローカル・ストレージ領域に、新しいイメージが作成されているかどうかを確認します。

.. code-block:: bash

   REPOSITORY          TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
   changed-ubuntu      latest              03b964f68d06        33 seconds ago      131.4 MB
   ubuntu  

..    Run the docker history command to see which image layers were used to create the new changed-ubuntu image.

6. ``docker history`` コマンドを実行すると、何のイメージによって新しい ``changed-ubuntu`` イメージが作成されたか分かります。

.. code-block:: bash

   $ docker history changed-ubuntu
   IMAGE               CREATED              CREATED BY                                      SIZE                COMMENT
   03b964f68d06        About a minute ago   /bin/sh -c echo "Hello world" > /tmp/newfile    12 B                
   013f3d01d247        6 weeks ago          /bin/sh -c #(nop) CMD ["/bin/bash"]             0 B                 
   2bd276ed39d5        6 weeks ago          /bin/sh -c sed -i 's/^#\s*\(deb.*universe\)$/   1.879 kB            
   13c0c663a321        6 weeks ago          /bin/sh -c echo '#!/bin/sh' > /usr/sbin/polic   701 B               
   6e6a100fa147        6 weeks ago          /bin/sh -c #(nop) ADD file:49710b44e2ae0edef4   131.4 MB            

..     The docker history output shows the new 03b964f68d06 image layer at the top. You know that the 03b964f68d06 layer was added because it was created by the echo "Hello world" > /tmp/newfile command in your Dockerfile. The 4 image layers below it are the exact same image layers the make up the ubuntu:15.04 image as their UUIDs match.

``docker history`` の出力から、新しい ``03b964f68d06 `` イメージ・レイヤが一番上にあることがわかります。先ほどの ``Dockerfile`` で、 ``echo "Hello world" > /tmp/newfile`` コマンドでファイルを追加しましたので、 ``03b964f68d06`` レイヤにこのファイルが追加されたものだと分かっています。そして、４つのイメージ・レイヤは、先ほど ubuntu:15.04 イメージを構築する時に使った UUID と一致していることがわかります。

..    List the contents of the local storage area to further confirm.

7. ローカル・ストレージ領域の内容を、更に確認します。

.. code-block:: bash

   $ sudo ls /var/lib/docker/aufs/layers
   013f3d01d24738964bb7101fa83a926181d600ebecca7206dced59669e6e6778  2bd276ed39d5fcfd3d00ce0a190beeea508332f5aec3c6a125cc619a3fdbade6
   03b964f68d06a373933bd6d61d37610a34a355c168b08dfc604f57b20647e073  6e6a100fa147e6db53b684c8516e3e2588b160fd4898b6265545d5d4edb6796d
   13c0c663a321cd83a97f4ce1ecbaf17c2ba166527c3b06daaefe30695c5fcb8c

..    Where before you had four layers stored, you now have 5.

ここには幾つのレイヤが保管されているでしょうか。ここでは５つです。

.. Notice the new changed-ubuntu image does not have its own copies of every layer. As can be seen in the diagram below, the new image is sharing it’s four underlying layers with the ubuntu:15.04 image.

新しい ``changed-ubuntu`` イメージは各レイヤのコピーを自分自身で持っていないことをに注意してください。下図にあるように、``ubuntu:15.04`` イメージの下にある４つのレイヤを、新しいイメージでも共有しているのです。

.. image:: ./images/saving-space.png
   :scale: 60%
   :alt: レイヤの共有

.. The docker history command also shows the size of each image layer. The 03b964f68d06 is only consuming 13 Bytes of disk space. Because all of the layers below it already exist on the Docker host and are shared with the ubuntu15:04 image, this means the entire changed-ubuntu image only consumes 13 Bytes of disk space.

また、``docker history`` コマンドは各イメージ・レイヤのサイズも表示します。 ``03b964f68d06`` は 13 バイトのディスク容量しか使いません。なぜなら、下層のレイヤにあたるものは Docker ホスト上に存在しており、これらは ``ubuntu:15.04`` イメージとして共有されているものです。つまり ``changed-ubuntu``  イメージが消費するディスク容量は 13 バイトのみです。

.. This sharing of image layers is what makes Docker images and containers so space efficient.

このイメージ・レイヤの共有こそが、効率的に Docker イメージとコンテナの領域を扱います。

.. Copying makes containers efficient

.. _copying-maked-containers-efficient:

コンテナを効率的にコピーする
------------------------------

.. You learned earlier that a container a Docker image with a thin writable, container layer added. The diagram below shows the layers of a container based on the ubuntu:15.04 image:

先ほど学んだように、Docker イメージのコンテナとは、書き込み可能なコンテナ・レイヤを追加したものです。以下の図は ``ubuntu:15.04`` をコンテナのベースと下レイヤを表示しています。

.. image:: ./images/container-layers.png
   :scale: 60%
   :alt: コンテナ・レイヤとイメージ

.. All writes made to a container are stored in the thin writable container layer. The other layers are read-only (RO) image layers and can’t be changed. This means that multiple containers can safely share a single underlying image. The diagram below shows multiple containers sharing a single copy of the ubuntu:15.04 image. Each container has its own thin RW layer, but they all share a single instance of the ubuntu:15.04 image:

コンテナに対する全ての書き込みは、書き込み可能なコンテナ・レイヤに保管されます。他のレイヤは読み込み専用（read-only、RO）のイメージ・レイヤであり、変更できません。つまり、複数のコンテナが下層にある１つのイメージを安全に共有できるのです。以下の図は、複数のコンテナが ``ubuntu:15.04`` イメージのコピーを共有しています。各コンテナは自分自身で読み書き可能なレイヤを持っていますが、どれもが ubuntu:15.04 イメージという単一のインスタンス（イメージ）を共有しています。

.. image:: ./images/sharing-layers.png
   :scale: 60%
   :alt: レイヤの共有

.. When a write operation occurs in a container, Docker uses the storage driver to perform a copy-on-write operation. The type of operation depends on the storage driver. For AUFS and OverlayFS storage drivers the copy-on-write operation is pretty much as follows:

コンテナの中で書き込み作業が発生すると、Dockre はストレージ・ドライバでコピー・オン・ライト処理を実行します。この主の操作はストレージ・ドライバに依存します。AUFS と OverlayFS ストレージ・ドライバは、コピー・オン・ライト処理を、おおよそ次のように行います。

..    Search through the layers for the file to update. The process starts at the top, newest layer and works down to the base layer one-at-a-time.
    Perform a “copy-up” operation on the first copy of the file that is found. A “copy up” copies the file up to the container’s own thin writable layer.
    Modify the copy of the file in container’s thin writable layer.

* レイヤ上のファイルが更新されていないか確認します。まずこの手順が新しいレイヤに対して行われ、以降は１つ１つのベースになったレイヤを辿ります。
* はじめてファイルのコピーが見つかると、「コピー開始」（copy-up）処理を行います。「コピー開始」とは、コンテナ自身が持つ薄い書き込み可能なレイヤから、ファイルをコピーすることです。
* コンテナの薄い書き込み可能なレイヤに *ファイル* を *コピー* してから、（そのファイルに）変更を加えます。

.. BTFS, ZFS, and other drivers handle the copy-on-write differently. You can read more about the methods of these drivers later in their detailed descriptions.

BTFS、ZFS 、その他のドライバは、コピー・オン・ライトを異なった方法で処理します。これらのドライバの手法については、後述するそれぞれの詳細説明をご覧ください。

.. Containers that write a lot of data will consume more space than containers that do not. This is because most write operations consume new space in the containers thin writable top layer. If your container needs to write a lot of data, you can use a data volume.

たくさんのデータが書き込まれたコンテナは、何もしないコンテナに比べて多くのディスク容量を消費します。これは書き込み操作の発生によって、コンテナの薄い書き込み可能なレイヤの上に、更に新しい領域を消費するためです。もしコンテナが多くのデータを使う必要があるのであれば、データ・ボリュームを使うこともできます。

.. A copy-up operation can incur a noticeable performance overhead. This overhead is different depending on which storage driver is in use. However, large files, lots of layers, and deep directory trees can make the impact more noticeable. Fortunately, the operation only occurs the first time any particular file is modified. Subsequent modifications to the same file do not cause a copy-up operation and can operate directly on the file’s existing copy already present in container layer.

コピー開始処理は、顕著なパフォーマンスのオーバヘッド（処理時間の増加）を招きます。このオーバヘッドは、利用するストレージ・ドライバによって異なります。しかし、大きなファイル、多くのレイヤ、深いディレクトリ・ツリーが顕著な影響を与えます。幸いにも、これらの処理が行われるのは、何らかのファイルに対する変更が初めて行われた時だけです。同じファイルに対する変更が再度行われても、コピー開始処理は行われず、コンテナ・レイヤ上に既にコピーしてあるファイルに対して変更を加えます。

.. Let’s see what happens if we spin up 5 containers based on our changed-ubuntu image we built earlier:

先ほど構築した ``changed-ubuntu`` イメージの元となる５つのコンテナに対し、何が起こっているのか見ていきましょう。

..    From a terminal on your Docker host, run the following docker run command 5 times.

1. Docker ホスト上のターミナルで、 次のように ``docker run`` コマンドを５回実行します。

.. code-block:: bash

   $ docker run -dit changed-ubuntu bash
   75bab0d54f3cf193cfdc3a86483466363f442fba30859f7dcd1b816b6ede82d4
   $ docker run -dit changed-ubuntu bash
   9280e777d109e2eb4b13ab211553516124a3d4d4280a0edfc7abf75c59024d47
   $ docker run -dit changed-ubuntu bash
   a651680bd6c2ef64902e154eeb8a064b85c9abf08ac46f922ad8dfc11bb5cd8a
   $ docker run -dit changed-ubuntu bash
   8eb24b3b2d246f225b24f2fca39625aaad71689c392a7b552b78baf264647373
   $ docker run -dit changed-ubuntu bash
   0ad25d06bdf6fca0dedc38301b2aff7478b3e1ce3d1acd676573bba57cb1cfef

.. This launches 5 containers based on the changed-ubuntu image. As the container is created, Docker adds a writable layer and assigns it a UUID. This is the value returned from the docker run command.

これは ``changed-ubuntu`` イメージを元に、５つのコンテナを起動します。コンテナを作成すると、Docker は書き込みレイヤを追加し、そこに UUID を割り当てます。この値は、 ``docker run`` コマンドを実行して返ってきたものです。

..    Run the docker ps command to verify the 5 containers are running.

2. ``docker ps`` コマンドを実行し、５つのコンテナが実行中なのを確認します。

.. code-block:: bash

   $ docker ps
    CONTAINER ID        IMAGE               COMMAND             CREATED              STATUS              PORTS               NAMES
   0ad25d06bdf6        changed-ubuntu      "bash"              About a minute ago   Up About a minute                       stoic_ptolemy
   8eb24b3b2d24        changed-ubuntu      "bash"              About a minute ago   Up About a minute                       pensive_bartik
   a651680bd6c2        changed-ubuntu      "bash"              2 minutes ago        Up 2 minutes                            hopeful_turing
   9280e777d109        changed-ubuntu      "bash"              2 minutes ago        Up 2 minutes                            backstabbing_mahavira
   75bab0d54f3c        changed-ubuntu      "bash"              2 minutes ago        Up 2 minutes                            boring_pasteur

..    The output above shows 5 running containers, all sharing the changed-ubuntu image. Each CONTAINER ID is derived from the UUID when creating each container.

上記の結果から、 ``changed-ubuntu`` イメージを全て共有する５つのコンテナが実行中だと分かります。それぞれの ``CONTAINER ID`` は各コンテナ作成時の UUID から与えられています。

..    List the contents of the local storage area.

3. ローカル・ストレージ領域のコンテナ一覧を表示します。

.. code-block:: bash

   $ sudo ls containers
   0ad25d06bdf6fca0dedc38301b2aff7478b3e1ce3d1acd676573bba57cb1cfef  9280e777d109e2eb4b13ab211553516124a3d4d4280a0edfc7abf75c59024d47
   75bab0d54f3cf193cfdc3a86483466363f442fba30859f7dcd1b816b6ede82d4  a651680bd6c2ef64902e154eeb8a064b85c9abf08ac46f922ad8dfc11bb5cd8a
   8eb24b3b2d246f225b24f2fca39625aaad71689c392a7b552b78baf264647373

.. Docker’s copy-on-write strategy not only reduces the amount of space consumed by containers, it also reduces the time required to start a container. At start time, Docker only has to create the thin writable layer for each container. The diagram below shows these 5 containers sharing a single read-only (RO) copy of the changed-ubuntu image.

Docker のコピー・オン・ライト方式により、コンテナによるディスク容量の消費を減らすだけではなく、コンテナ起動時の時間も短縮します。起動時に、Docker は各コンテナごとに薄い書き込み可能なレイヤを作成します。次の図は ``changed-ubuntu`` イメージの読み込み専用のコピーを、５つのコンテナで共有しているものです。

.. If Docker had to make an entire copy of the underlying image stack each time it started a new container, container start times and disk space used would be significantly increased.

もし新しいコンテナを開始するたびに元になるイメージ層全体をコピーしているのであれば、コンテナの起動時間とディスク使用量が著しく増えてしまうでしょう（訳者注：実際にはそうではありません。）。

.. Data volumes and the storage driver

.. _data-volumes-and-the-storage-driver:

データ・ボリュームとストレージ・ドライバ
========================================

.. When a container is deleted, any data written to the container that is not stored in a data volume is deleted along with the container. A data volume is directory or file that is mounted directly into a container.

コンテナの削除し、コンテナに対して書き込まれたあらゆるデータが削除されます。しかし、 *データ・ボリューム* の保管内容は、コンテナと一緒に削除されません。データ・ボリュームは、コンテナ内に直接マウントするファイルかディスク容量です。

.. Data volumes are not controlled by the storage driver. Reads and writes to data volumes bypass the storage driver and operate at native host speeds. You can mount any number of data volumes into a container. Multiple containers can also share one or more data volumes.

データ・ボリュームはストレージ・ドライバによって管理されません。データ・ボリュームに対する読み書きは、ストレージ・ドライバを迂回し、ネイティブなホストの速度で操作できます。コンテナ内に複数のデータ・ボリュームをマウントできます。複数のコンテナが１つまたは複数のデータ・ボリュームをマウントできます。

.. The diagram below shows a single Docker host running two containers. Each container exists inside of its own address space within the Docker host’s local storage area. There is also a single shared data volume located at /data on the Docker host. This is mounted directly into both containers.

以下の図は、１つの Docker ホストから２つのコンテナを実行しているものです。Docker ホストのローカル・ストレージ領域の中に、それぞれのコンテナに対して割り当てられた領域が存在しています。また、Docker ホスト上の ``/data`` に位置する共有データ・ボリュームもあります。このディレクトリは両方のコンテナからマウントされます。

.. image:: ./images/shared-volume.png
   :scale: 60%
   :alt: 共有ボリューム

.. The data volume resides outside of the local storage area on the Docker host further reinforcing its independence from the storage driver’s control. When a container is deleted, any data stored in shared data volumes persists on the Docker host.

データ・ボリュームは Docker ホスト上のローカル・ストレージ領域の外に存在しており、ストレージ・ドライバの管理から独立して離れています。コンテナを削除したとしても、Docker ホスト上の共有データ・ボリュームに保管されたデータに対して、何ら影響はありません。

.. For detailed information about data volumes Managing data in containers.

データ・ボリュームに関する更に詳しい情報は、 :doc:`コンテナでデータを管理する </engine/userguide/dockervolumes>` をご覧ください。

.. Related information

関連情報
==========

.. _volume-related-information:

..    Select a storage driver
    AUFS storage driver in practice
    Btrfs storage driver in practice
    Device Mapper storage driver in practice

* :doc:`ストレージ・ドライバの選択 </engine/userguide/storagedriver/selectadriver>`
* :doc:`AUFS ストレージ・ドライバを使う <aufs-driver>`
* :doc:`Btrfs ストレージ・ドライバを使う <btrfs-driver>`
* :doc:`Device Mapper ストレージ・ドライバを使う <device-mapper-driver>`
