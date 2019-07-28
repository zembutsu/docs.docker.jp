.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/userguide/storagedriver/imagesandcontainers/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/userguide/storagedriver/imagesandcontainers.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/userguide/storagedriver/imagesandcontainers.md
.. check date: 2016/04/16
.. Commits on May 14, 2016 d0ab1c360f5af7b92ab3f414e42ad817e0bd3059
.. ---------------------------------------------------------------------------

.. title: About images, containers, and storage drivers

.. _about-images-containers-and-storage-drivers:

==================================================
イメージ、コンテナ、ストレージ・ドライバについて
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. To use storage drivers effectively, you must understand how Docker builds and
   stores images. Then, you need an understanding of how these images are used by
   containers. Finally, you'll need a short introduction to the technologies that
   enable both images and container operations.

ストレージ・ドライバを効率よく利用するためには、Docker がどのようにしてイメージをビルドし保存するのかを理解しておく必要があります。
さらにそのイメージをコンテナがどのように利用するのかを理解しておくことも重要です。
つまりイメージとコンテナの双方の操作を可能とする技術に関して、おおまかに知っておく必要があります。

.. Understanding how Docker manages the data within your images and containers will
   help you understand the best way to design your containers and Dockerize your
   applications, and avoid performance problems along the way.

Docker がイメージ内やコンテナ内にてデータをどのように管理するのかを理解しておけば、コンテナ作りやアプリケーション Docker 化の最良な方法、さらに稼動時のパフォーマンス低下を回避する方法が身につくはずです。

.. ## Images and layers

イメージとレイヤ
====================

.. A Docker image is built up from a series of layers. Each layer represents an
   instruction in the image's Dockerfile. Each layer except the very last one is
   read-only. Consider the following Dockerfile:

Docker イメージは一連のレイヤから構成されます。
個々のレイヤは、そのイメージの Dockerfile 内にある 1 つの命令に対応づいています。
一番最後にあるレイヤを除き、これ以外はすべて読み込み専用のレイヤです。
たとえば以下のような Dockerfile を考えてみます。

.. ```conf
   FROM ubuntu:15.04
   COPY . /app
   RUN make /app
   CMD python /app/app.py
   ```
.. code-block:: yaml

   FROM ubuntu:15.04
   COPY . /app
   RUN make /app
   CMD python /app/app.py

.. This Dockerfile contains four commands, each of which creates a layer.  The
   `FROM` statement starts out by creating a layer from the `ubuntu:15.04` image.
   The `COPY` command adds some files from your Docker client's current directory.
   The `RUN` command builds your application using the `make` command. Finally,
   the last layer specifies what command to run within the container.

この Dockerfile には 4 つのコマンドがあります。
コマンドのそれぞれが 1 つのレイヤを生成します。
まずは ``FROM`` 命令によって ``ubuntu:15.04`` イメージから 1 つのレイヤが生成されるところから始まります。
``COPY`` 命令は Docker クライアントのカレントディレクトリから複数のファイルを追加します。
``RUN`` 命令は ``make`` コマンドを実行してアプリケーションをビルドします。
そして最後のレイヤが、コンテナ内にて実行するべきコマンドを指定しています。

.. Each layer is only a set of differences from the layer before it. The layers are
   stacked on top of each other. When you create a new container, you add a new
   writable layer on top of the underlying layers. This layer is often called the
   "container layer". All changes made to the running container, such as writing
   new files, modifying existing files, and deleting files, are written to this thin
   writable container layer. The diagram below shows a container based on the Ubuntu
   15.04 image.

各レイヤは、その直前のレイヤからの差異だけを保持します。
そしてレイヤは順に積み上げられていきます。
新しいコンテナを生成したときには、それまで存在していたレイヤ群の最上部に、新たな書き込み可能なレイヤが加えられます。
このレイヤは「コンテナ・レイヤ」と呼ばれることがあります。
実行中のコンテナに対して実行される変更処理すべて、たとえば新規ファイル生成、既存ファイル修正、ファイル削除といったことは、その薄い皮のような書き込み可能なコンテナ・レイヤに対して書き込まれます。
以下の図は Ubuntu 15.04 イメージに基づいて生成されたコンテナを表わしています。

.. ![Docker image layers](images/container-layers.jpg)

.. image:: ./images/container-layers.png
   :scale: 60%
   :alt: Docker イメージレイヤ

.. A _storage driver_ handles the details about the way these layers interact with
   each other. Different storage drivers are available, which have advantages
   and disadvantages in different situations.

**ストレージドライバー** というものは、そういった各レイヤーが互いにやり取りできるようにします。
さまざまなストレージドライバーが利用可能であり、利用状況に応じて一長一短があります。

.. ## Container and layers

.. _container-and-layers:

コンテナとレイヤ
====================

.. The major difference between a container and an image is the top writable layer.
   All writes to the container that add new or modify existing data are stored in
   this writable layer. When the container is deleted, the writable layer is also
   deleted. The underlying image remains unchanged.

コンテナとイメージの大きな違いは、最上部に書き込みレイヤがあるかどうかです。
コンテナに対して新たに加えられたり修正されたりしたデータは、すべてこの書き込みレイヤに保存されます。
コンテナが削除されると、その書き込みレイヤも同じく削除されます。
ただしその元にあったイメージは、変更されずに残ります。

.. Because each container has its own writable container layer, and all changes are
   stored in this container layer, multiple containers can share access to the same
   underlying image and yet have their own data state. The diagram below shows
   multiple containers sharing the same Ubuntu 15.04 image.

複数のコンテナを見た場合、そのコンテナごとに個々の書き込み可能なコンテナ・レイヤがあって、データ更新結果はそのコンテナ・レイヤに保存されます。
したがって複数コンテナでは、同一のイメージを共有しながらアクセスすることができ、しかも個々に見れば独自の状態を持つことができることになります。
以下の図は、Ubuntu 15.04 という同一のイメージを共有する複数コンテナを示しています。

.. ![](images/sharing-layers.jpg)

.. image:: ./images/sharing-layers.png
   :scale: 60%
   :alt: レイヤの共有

.. > **Note**: If you need multiple images to have shared access to the exact
   > same data, store this data in a Docker volume and mount it into your
   > containers.

.. note::

   複数イメージを必要としていて、さらに同一のデータを共有してアクセスしたい場合は、そのデータを Docker ボリュームに保存して、コンテナ内でそれをマウントします。

.. Docker uses storage drivers to manage the contents of the image layers and the
   writable container layer. Each storage driver handles the implementation
   differently, but all drivers use stackable image layers and the copy-on-write
   (CoW) strategy.

Docker はストレージ・ドライバを利用して、イメージ・レイヤと書き込み可能なコンテナ・レイヤの各内容を管理します。
さまざまなストレージ・ドライバでは、異なる実装によりデータを扱います。
しかしどのようなドライバであっても、積み上げ可能な（stackable）イメージ・レイヤを取り扱い、コピー・オン・ライト（copy-on-write; CoW）方式を採用します。

.. ## Container size on disk

.. _container-size-on-disk:

ディスク上のコンテナ・サイズ
=============================

.. To view the approximate size of a running container, you can use the `docker ps -s`
   command. Two different columns relate to size.

稼働中コンテナの概算サイズを確認するには ``docker ps -s`` コマンドを実行します。
サイズに関連した 2 つのデータがカラム表示されます。

.. - `size`: the amount of data (on disk) that is used for the writable layer of
     each container

* ``size``: （ディスク上の）データ総量。
  各コンテナの書き込みレイヤが利用するデータ部分です。

.. - `virtual size`: the amount of data used for the read-only image data
     used by the container. Multiple containers may share some or all read-only
     image data. Two containers started from the same image share 100% of the
     read-only data, while two containers with different images which have layers
     in common share those common layers. Therefore, you can't just total the
     virtual sizes. This will over-estimate the total disk usage by a potentially
     non-trivial amount.

* ``virtual size``: コンテナにおいて利用されている読み込み専用のイメージデータと、コンテナの書き込みレイヤの ``size`` を足し合わせたデータ総量。
  複数コンテナにおいては、読み込み専用イメージデータの全部または一部を共有しているかもしれません。
  1 つのイメージをベースとして作った 2 つのコンテナでは、読み込み専用データを 100% 共有します。
  一方で 2 つの異なるイメージが一部に共通するレイヤを持っていて、そこからそれぞれに 2 つのコンテナを作ったとすると、共有するのはその共通レイヤ部分のみです。
  したがって ``virtual size`` は単純に足し合わせで計算できるものではありません。
  これはディスク総量を多く見積もってしまい、その量は無視できないほどになることがあります。

.. The total disk space used by all of the running containers on disk is some
   combination of each container's `size` and the `virtual size` values. If
   multiple containers have exactly the same `virtual size`, they are likely
   started from the same exact image.

起動しているコンテナすべてが利用するディスク総量は、各コンテナの ``size`` と ``virtual size`` を適宜組み合わせた値になります。
複数コンテナが同一の ``virtual size`` になっていたら、各コンテナは同一のイメージをベースにしていると考えられます。

.. This also does not count the following additional ways a container can take up
   disk space:

またコンテナがディスク領域を消費するものであっても、以下に示す状況はディスク総量の算定には含まれません。

.. - Disk space used for log files if you use the `json-file` logging driver. This
     can be non-trivial if your container generates a large amount of logging data
     and log rotation is not configured.
   - Volumes and bind mounts used by the container.
   - Disk space used for the container's configuration files, which are typically
     small.
   - Memory written to disk (if swapping is enabled).
   - Checkpoints, if you're using the experimental checkpoint/restore feature.

* ロギング・ドライバ ``json-file`` を利用している場合に、そのログファイルが利用するディスク量。
  コンテナにおいてログ出力を大量に行っていて、ログローテーションを用いていない場合には、このディスク量は無視できないものになります。
* コンテナが利用するボリュームやバインドマウント。
* コンテナの設定ファイルが利用するディスク領域。
  そのデータ容量は少ないのが普通です。
* （スワップが有効である場合に）ディスクに書き込まれるメモリデータ。
* 試験的な checkpoint/restore 機能を利用している場合のチェックポイント。

.. ## The copy-on-write (CoW) strategy

.. _the-copy-on-write-cow-strategy:

コピー・オン・ライト方式
==============================

.. Copy-on-write is a strategy of sharing and copying files for maximum efficiency.
   If a file or directory exists in a lower layer within the image, and another
   layer (including the writable layer) needs read access to it, it just uses the
   existing file. The first time another layer needs to modify the file (when
   building the image or running the container), the file is copied into that layer
   and modified. This minimizes I/O and the size of each of the subsequent layers.
   These advantages are explained in more depth below.

コピーオンライト（copy-on-write; CoW）は、ファイルの共有とコピーを最も効率よく行う方式です。
イメージ内の下の方にあるレイヤに、ファイルやディレクトリが存在していた場合に、別のレイヤ（書き込みレイヤを含む）からの読み込みアクセスが必要であるとします。
このときには、当然のことながら存在しているそのファイルを利用します。
そのファイルを修正する必要のある別のレイヤがあったとすると、これを初めて修正するとき（イメージがビルドされたときやコンテナが起動したときなど）、そのファイルはレイヤにコピーされた上で修正されます。
こうすることで入出力を最小限に抑え、次に続くレイヤの各サイズも増やさずに済みます。
この利点に関しては、さらに詳しく後述します。

.. ### Sharing promotes smaller images

.. _sharing-promotes-smaller-images:

共有によりイメージサイズはより小さく
-------------------------------------

.. When you use `docker pull` to pull down an image from a repository, or when you
   create a container from an image that does not yet exist locally, each layer is
   pulled down separately, and stored in Docker's local storage area, which is
   usually `/var/lib/docker/` on Linux hosts. You can see these layers being pulled
   in this example:

``docker pull`` を実行してリポジトリからイメージをプルするとき、あるいはイメージから新たにコンテナを生成するにあたってそのイメージがまだローカルに生成されていないとき、各レイヤはプルによって個別に取得されて、Docker のローカル保存領域、たとえば Linux では通常 ``/var/lib/docker/`` に保存されます。
取得された各レイヤは、以下の例のようにして確認することができます。

.. ```bash
   $ docker pull ubuntu:15.04
   
   15.04: Pulling from library/ubuntu
   1ba8ac955b97: Pull complete
   f157c4e5ede7: Pull complete
   0b7e98f84c4c: Pull complete
   a3ed95caeb02: Pull complete
   Digest: sha256:5e279a9df07990286cce22e1b0f5b0490629ca6d187698746ae5e28e604a640e
   Status: Downloaded newer image for ubuntu:15.04
   ```
.. code-block:: bash

   $ docker pull ubuntu:15.04
   
   15.04: Pulling from library/ubuntu
   1ba8ac955b97: Pull complete
   f157c4e5ede7: Pull complete
   0b7e98f84c4c: Pull complete
   a3ed95caeb02: Pull complete
   Digest: sha256:5e279a9df07990286cce22e1b0f5b0490629ca6d187698746ae5e28e604a640e
   Status: Downloaded newer image for ubuntu:15.04

.. Each of these layers is stored in its own directory inside the Docker host's
   local storage area. To examine the layers on the filesystem, list the contents
   of `/var/lib/docker/<storage-driver>/layers/`. This example uses `aufs`, which
   is the default storage driver:

各レイヤは、Docker ホストのローカル保存領域内にて、それぞれのディレクトリ配下に保存されます。
ファイルシステム上のレイヤデータを確認するなら、``/var/lib/docker/<storage-driver>/layers/`` の内容を一覧表示します。
以下はデフォルトのストレージ・ドライバである ``aufs`` の例です。

.. ```bash
   $ ls /var/lib/docker/aufs/layers
   1d6674ff835b10f76e354806e16b950f91a191d3b471236609ab13a930275e24
   5dbb0cbe0148cf447b9464a358c1587be586058d9a4c9ce079320265e2bb94e7
   bef7199f2ed8e86fa4ada1309cfad3089e0542fec8894690529e4c04a7ca2d73
   ebf814eccfe98f2704660ca1d844e4348db3b5ccc637eb905d4818fbfb00a06a
   ```
.. code-block:: bash

   $ ls /var/lib/docker/aufs/layers
   1d6674ff835b10f76e354806e16b950f91a191d3b471236609ab13a930275e24
   5dbb0cbe0148cf447b9464a358c1587be586058d9a4c9ce079320265e2bb94e7
   bef7199f2ed8e86fa4ada1309cfad3089e0542fec8894690529e4c04a7ca2d73
   ebf814eccfe98f2704660ca1d844e4348db3b5ccc637eb905d4818fbfb00a06a

.. The directory names do not correspond to the layer IDs (this has been true since
   Docker 1.10).

ディレクトリ名はレイヤ ID に対応するものではありません。
（Docker 1.10 以前は対応づいていました。）

.. Now imagine that you have two different Dockerfiles. You use the first one to
   create an image called `acme/my-base-image:1.0`.

ここで 2 つの異なる Dockerfile を利用している状況を考えます。
1 つめの Dockerfile からは ``acme/my-base-image:1.0`` というイメージが作られるものとします。

.. ```conf
   FROM ubuntu:16.10
   COPY . /app
   ```
.. code-block:: yaml

   FROM ubuntu:16.10
   COPY . /app

.. The second one is based on `acme/my-base-image:1.0`, but has some additional
   layers:

2 つめの Dockerfile は ``acme/my-base-image:1.0`` をベースとして、さらにレイヤを追加するものとします。

.. ```conf
   FROM acme/my-base-image:1.0
   CMD /app/hello.sh
   ```
.. code-block:: yaml

   FROM acme/my-base-image:1.0
   CMD /app/hello.sh

.. The second image contains all the layers from the first image, plus a new layer
   with the `CMD` instruction, and a read-write container layer. Docker already
   has all the layers from the first image, so it does not need to pull them again.
   The two images will share any layers they have in common.

2 つめのイメージには 1 つめのイメージが持つレイヤがすべて含まれ、さらに ``CMD`` 命令による新たなレイヤと、読み書き可能なコンテナ・レイヤが加わっています。
Docker にとって 1 つめのイメージにおけるレイヤはすべて取得済であるため、再度プルによって取得する必要がありません。
2 つのイメージにおいて共通して存在しているレイヤは、すべて共有します。

.. If you build images from the two Dockerfiles, you can use `docker images` and
   `docker history` commands to verify that the cryptographic IDs of the shared
   layers are the same.

この 2 つの Dockerfile からイメージをビルドした場合、``docker image`` や ``docker history`` コマンドを使ってみると、共有されているレイヤに対する暗号化 ID は同一になっていることがわかります。

.. 1.  Make a new directory `cow-test/` and change into it.

1. 新規に ``cow-test/`` というディレクトリを生成して移動します。

   .. 2.  Within `cow-test/`, create a new file with the following contents:

2. ``cow-test/`` ディレクトリにて、以下の内容で新規ファイルを生成します。

   ..  ```bash
       #!/bin/sh
       echo "Hello world"
       ```
   .. code-block:: bash

      #!/bin/sh
      echo "Hello world"

   ..  Save the file, and make it executable:

   ファイルを保存して実行可能にします。

   ..  ```bash
       chmod +x hello.sh
       ```
   .. code-block:: bash

      chmod +x hello.sh

.. 3.  Copy the contents of the first Dockerfile above into a new file called
       `Dockerfile.base`.

3. 前述した 1 つめの Dockerfile の内容を、新規ファイル ``Dockerfile.base`` にコピーします。

.. 4.  Copy the contents of the second Dockerfile above into a new file called
       `Dockerfile`.

4. 前述した 2 つめの Dockerfile の内容を、新規ファイル ``Dockerfile`` にコピーします。

.. 5.  Within the `cow-test/` directory, build the first image.

5.  ``cow-test/`` ディレクトリ内にて 1 つめのイメージをビルドします。

   ..  ```bash
       $ docker build -t acme/my-base-image:1.0 -f Dockerfile.base .

       Sending build context to Docker daemon  4.096kB
       Step 1/2 : FROM ubuntu:16.10
        ---> 31005225a745
       Step 2/2 : COPY . /app
        ---> Using cache
        ---> bd09118bcef6
       Successfully built bd09118bcef6
       Successfully tagged acme/my-base-image:1.0
       ```
   .. code-block:: bash

      $ docker build -t acme/my-base-image:1.0 -f Dockerfile.base .

      Sending build context to Docker daemon  4.096kB
      Step 1/2 : FROM ubuntu:16.10
       ---> 31005225a745
      Step 2/2 : COPY . /app
       ---> Using cache
       ---> bd09118bcef6
      Successfully built bd09118bcef6
      Successfully tagged acme/my-base-image:1.0

.. 6.  Build the second image.

6. 2 つめのイメージをビルドします。

   ..  ```bash
       $ docker build -t acme/my-final-image:1.0 -f Dockerfile .

       Sending build context to Docker daemon  4.096kB
       Step 1/2 : FROM acme/my-base-image:1.0
        ---> bd09118bcef6
       Step 2/2 : CMD /app/hello.sh
        ---> Running in a07b694759ba
        ---> dbf995fc07ff
       Removing intermediate container a07b694759ba
       Successfully built dbf995fc07ff
       Successfully tagged acme/my-final-image:1.0
       ```
   .. code-block:: bash

      $ docker build -t acme/my-final-image:1.0 -f Dockerfile .

      Sending build context to Docker daemon  4.096kB
      Step 1/2 : FROM acme/my-base-image:1.0
       ---> bd09118bcef6
      Step 2/2 : CMD /app/hello.sh
       ---> Running in a07b694759ba
       ---> dbf995fc07ff
      Removing intermediate container a07b694759ba
      Successfully built dbf995fc07ff
      Successfully tagged acme/my-final-image:1.0

.. 7.  Check out the sizes of the images:

7. 2 つのイメージのサイズを確認します。

   ..  ```bash
       $ docker images

       REPOSITORY                                            TAG                          IMAGE ID            CREATED             SIZE
       acme/my-final-image                                   1.0                          dbf995fc07ff        58 seconds ago      103MB
       acme/my-base-image                                    1.0                          bd09118bcef6        3 minutes ago       103MB
       ```
   .. code-block:: bash

      $ docker images

      REPOSITORY                                            TAG                          IMAGE ID            CREATED             SIZE
      acme/my-final-image                                   1.0                          dbf995fc07ff        58 seconds ago      103MB
      acme/my-base-image                                    1.0                          bd09118bcef6        3 minutes ago       103MB

.. 8.  Check out the layers that comprise each image:

8. それぞれのイメージに含まれるレイヤを確認します。

   ..  ```bash
       $ docker history bd09118bcef6
       IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
       bd09118bcef6        4 minutes ago       /bin/sh -c #(nop) COPY dir:35a7eb158c1504e...   100B                
       31005225a745        3 months ago        /bin/sh -c #(nop)  CMD ["/bin/bash"]            0B                  
       <missing>           3 months ago        /bin/sh -c mkdir -p /run/systemd && echo '...   7B                  
       <missing>           3 months ago        /bin/sh -c sed -i 's/^#\s*\(deb.*universe\...   2.78kB              
       <missing>           3 months ago        /bin/sh -c rm -rf /var/lib/apt/lists/*          0B                  
       <missing>           3 months ago        /bin/sh -c set -xe   && echo '#!/bin/sh' >...   745B                
       <missing>           3 months ago        /bin/sh -c #(nop) ADD file:eef57983bd66e3a...   103MB      
       ```
   .. code-block:: bash

      $ docker history bd09118bcef6
      IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
      bd09118bcef6        4 minutes ago       /bin/sh -c #(nop) COPY dir:35a7eb158c1504e...   100B                
      31005225a745        3 months ago        /bin/sh -c #(nop)  CMD ["/bin/bash"]            0B                  
      <missing>           3 months ago        /bin/sh -c mkdir -p /run/systemd && echo '...   7B                  
      <missing>           3 months ago        /bin/sh -c sed -i 's/^#\s*\(deb.*universe\...   2.78kB              
      <missing>           3 months ago        /bin/sh -c rm -rf /var/lib/apt/lists/*          0B                  
      <missing>           3 months ago        /bin/sh -c set -xe   && echo '#!/bin/sh' >...   745B                
      <missing>           3 months ago        /bin/sh -c #(nop) ADD file:eef57983bd66e3a...   103MB      

   ..  ```bash
       $ docker history dbf995fc07ff

       IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
       dbf995fc07ff        3 minutes ago       /bin/sh -c #(nop)  CMD ["/bin/sh" "-c" "/a...   0B                  
       bd09118bcef6        5 minutes ago       /bin/sh -c #(nop) COPY dir:35a7eb158c1504e...   100B                
       31005225a745        3 months ago        /bin/sh -c #(nop)  CMD ["/bin/bash"]            0B                  
       <missing>           3 months ago        /bin/sh -c mkdir -p /run/systemd && echo '...   7B                  
       <missing>           3 months ago        /bin/sh -c sed -i 's/^#\s*\(deb.*universe\...   2.78kB              
       <missing>           3 months ago        /bin/sh -c rm -rf /var/lib/apt/lists/*          0B                  
       <missing>           3 months ago        /bin/sh -c set -xe   && echo '#!/bin/sh' >...   745B                
       <missing>           3 months ago        /bin/sh -c #(nop) ADD file:eef57983bd66e3a...   103MB  
       ```
   .. code-block:: bash

      $ docker history dbf995fc07ff

      IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
      dbf995fc07ff        3 minutes ago       /bin/sh -c #(nop)  CMD ["/bin/sh" "-c" "/a...   0B                  
      bd09118bcef6        5 minutes ago       /bin/sh -c #(nop) COPY dir:35a7eb158c1504e...   100B                
      31005225a745        3 months ago        /bin/sh -c #(nop)  CMD ["/bin/bash"]            0B                  
      <missing>           3 months ago        /bin/sh -c mkdir -p /run/systemd && echo '...   7B                  
      <missing>           3 months ago        /bin/sh -c sed -i 's/^#\s*\(deb.*universe\...   2.78kB              
      <missing>           3 months ago        /bin/sh -c rm -rf /var/lib/apt/lists/*          0B                  
      <missing>           3 months ago        /bin/sh -c set -xe   && echo '#!/bin/sh' >...   745B                
      <missing>           3 months ago        /bin/sh -c #(nop) ADD file:eef57983bd66e3a...   103MB  

   ..  Notice that all the layers are identical except the top layer of the second
       image. All the other layers are shared between the two images, and are only
       stored once in `/var/lib/docker/`. The new layer actually doesn't take any
       room at all, because it is not changing any files, but only running a command.

    ほぼすべてのレイヤが同一であって、ただ 2 つめのイメージの最上位レイヤだけが違うのがわかります。
    これを除けば、すべてのレイヤが 2 つのイメージ間で共有されているので、各レイヤは ``/var/lib/docker/`` には一度しか保存されません。
    新たにできたレイヤは、まったくと言ってよいほどに容量をとっていません。
    というのも、そのレイヤは何かのファイルを変更するわけでなく、単にコマンドを実行するだけのものであるからです。

   ..  > **Note**: The `<missing>` lines in the `docker history` output indicate
       > that those layers were built on another system and are not available
       > locally. This can be ignored.

   .. note::

      ``docker history`` の出力において ``<missing>`` として示される行は、そのレイヤが他のシステムにおいてビルドされていることを示しています。
      したがってローカルシステム上では利用することができません。
      この表示は無視して構いません。

.. ### Copying makes containers efficient

.. _copying-makes-containers-efficient:

コピーによりコンテナーを効率的に
---------------------------------

.. When you start a container, a thin writable container layer is added on top of
   the other layers. Any changes the container makes to the filesystem are stored
   here. Any files the container does not change do not get copied to this writable
   layer. This means that the writable layer is as small as possible.

コンテナを起動すると、それまであったレイヤの最上部に、書き込み可能な薄いコンテナ・レイヤが加えられます。
コンテナがファイルシステムに対して行った変更は、すべてそこに保存されます。
コンテナが変更を行っていないファイルは、その書き込みレイヤにはコピーされません。
つまり書き込みレイヤは、できるだけ容量が小さく抑えられることになります。

.. When an existing file in a container is modified, the storage driver performs a
   copy-on-write operation. The specifics steps involved depend on the specific
   storage driver. For the default `aufs` driver and the `overlay` and `overlay2`
   drivers, the copy-on-write operation follows this rough sequence:

コンテナ内にあるファイルが修正されると、ストレージ・ドライバはコピー・オン・ライト方式により動作します。
そこで実行される各処理は、ストレージ・ドライバによってさまざまです。
``aufs``, ``overlay``, ``overlay2`` といったドライバの場合、だいたい以下のような順にコピー・オン・ライト方式による処理が行われます。

.. *  Search through the image layers for the file to update. The process starts
      at the newest layer and works down to the base layer one layer at a time.
      When results are found, they are added to a cache to speed future operations.

* 更新するべきファイルをイメージ・レイヤ内から探します。
  この処理は最新のレイヤから始まって、ベース・レイヤに向けて順に降りていき、一度に 1 つのレイヤを処理していきます。
  ファイルが見つかるとこれをキャッシュに加えて、次回以降の処理スピードを上げることに備えます。

.. *  Perform a `copy_up` operation on the first copy of the file that is found, to
      copy the file to the container's writable layer.

* 見つかったファイルを初めてコピーするときには ``copy_up`` という処理が行われます。
  これによってそのファイルをコンテナの書き込みレイヤにコピーします。

.. *  Any modifications are made to this copy of the file, and the container cannot
      see the read-only copy of the file that exists in the lower layer.

* 修正が発生すると、コピーを行ったそのファイルが処理されます。
  つまりコンテナは、下位のレイヤ内に存在している読み込み専用のそのファイルを見にいくことはありません。

.. Btrfs, ZFS, and other drivers handle the copy-on-write differently. You can
   read more about the methods of these drivers later in their detailed
   descriptions.

Btrfs, ZFS といったドライバにおけるコピー・オン・ライト方式は、これとは異なります。
そのようなドライバが行う手法の詳細は、後述するそれぞれの詳細説明を参照してください。

.. Containers that write a lot of data will consume more space than containers
   that do not. This is because most write operations consume new space in the
   container's thin writable top layer.

データを大量に書き込むようなコンテナは、そういった書き込みを行わないコンテナに比べて、データ領域をより多く消費します。
コンテナの最上位にある書き込み可能な薄いレイヤ上に対して書き込み処理を行うことは、たいていが新たなデータ領域を必要とするためです。

.. > **Note**: for write-heavy applications, you should not store the data in
   > the container. Instead, use Docker volumes, which are independent of the
   > running container and are designed to be efficient for I/O. In addition,
   > volumes can be shared among containers and do not increase the size of your
   > container's writable layer.

.. note::

   書き込みが頻繁に行われるアプリケーションにおいては、コンテナ内にデータを保存するべきではありません。
   かわりに Docker ボリュームを利用してください。
   Docker ボリュームは起動されるコンテナからは独立していて、効率的な入出力を行うように設計されています。
   さらにボリュームは複数のコンテナ間での共有が可能であり、書き込みレイヤのサイズを増加させることもありません。

.. A `copy_up` operation can incur a noticeable performance overhead. This overhead
   is different depending on which storage driver is in use. Large files,
   lots of layers, and deep directory trees can make the impact more noticeable.
   This is mitigated by the fact that each `copy_up` operation only occurs the first
   time a given file is modified.

``copy_up`` 処理は際立った性能のオーバーヘッドを招きます。
このオーバーヘッドは、利用しているストレージ・ドライバによってさまざまです。
大容量ファイル、多数のレイヤ、深いディレクトリ階層といったものが、さらに影響します。
``copy_up`` 処理は対象となるファイルが初めて修正されたときにだけ実行されるので、オーバーヘッドはそれでも最小限に抑えられています。

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

.. This launches 5 containers based on the changed-ubuntu image. As each container is created, Docker adds a writable layer and assigns it a random UUID. This is the value returned from the docker run command.

これは ``changed-ubuntu`` イメージを元に、５つのコンテナを起動します。コンテナを作成したことで、Docker は書き込みレイヤを追加し、そこにランダムな UUID を割り当てます。この値は、 ``docker run`` コマンドを実行して返ってきたものです。

..    Run the docker ps command to verify the 5 containers are running.

2. ``docker ps`` コマンドを実行し、５つのコンテナが実行中なのを確認します。

.. code-block:: bash

   $ docker ps
   CONTAINER ID    IMAGE             COMMAND    CREATED              STATUS              PORTS    NAMES
   0ad25d06bdf6    changed-ubuntu    "bash"     About a minute ago   Up About a minute            stoic_ptolemy
   8eb24b3b2d24    changed-ubuntu    "bash"     About a minute ago   Up About a minute            pensive_bartik
   a651680bd6c2    changed-ubuntu    "bash"     2 minutes ago        Up 2 minutes                 hopeful_turing
   9280e777d109    changed-ubuntu    "bash"     2 minutes ago        Up 2 minutes                 backstabbing_mahavira
   75bab0d54f3c    changed-ubuntu    "bash"     2 minutes ago        Up 2 minutes                 boring_pasteur

..    The output above shows 5 running containers, all sharing the changed-ubuntu image. Each CONTAINER ID is derived from the UUID when creating each container.

上記の結果から、 ``changed-ubuntu`` イメージを全て共有する５つのコンテナが実行中だと分かります。それぞれの ``コンテナ ID`` は各コンテナ作成時の UUID から与えられています。

..    List the contents of the local storage area.

3. ローカル・ストレージ領域のコンテナ一覧を表示します。

.. code-block:: bash

   $ sudo ls containers
   0ad25d06bdf6fca0dedc38301b2aff7478b3e1ce3d1acd676573bba57cb1cfef  9280e777d109e2eb4b13ab211553516124a3d4d4280a0edfc7abf75c59024d47
   75bab0d54f3cf193cfdc3a86483466363f442fba30859f7dcd1b816b6ede82d4  a651680bd6c2ef64902e154eeb8a064b85c9abf08ac46f922ad8dfc11bb5cd8a
   8eb24b3b2d246f225b24f2fca39625aaad71689c392a7b552b78baf264647373

（訳者注：上記コマンドは、 ``/var/lib/docker`` ディレクトリで実行してください。）

.. Docker’s copy-on-write strategy not only reduces the amount of space consumed by containers, it also reduces the time required to start a container. At start time, Docker only has to create the thin writable layer for each container. The diagram below shows these 5 containers sharing a single read-only (RO) copy of the changed-ubuntu image.

Docker のコピー・オン・ライト方式により、コンテナによるディスク容量の消費を減らすだけではなく、コンテナ起動時の時間も短縮します。起動時に、Docker はコンテナごとに薄い書き込み可能なレイヤを作成します。次の図は ``changed-ubuntu`` イメージの読み込み専用のコピーを、５つのコンテナで共有しています。

.. image:: ./images/shared-uuid.png
   :scale: 60%
   :alt: レイヤの共有

.. If Docker had to make an entire copy of the underlying image stack each time it started a new container, container start times and disk space used would be significantly increased.

もし新しいコンテナを開始する度に元になるイメージ・レイヤ全体をコピーするのであれば、コンテナの起動時間とディスク使用量が著しく増えてしまうでしょう。

.. Data volumes and the storage driver

.. _data-volumes-and-the-storage-driver:

データ・ボリュームとストレージ・ドライバ
========================================

.. When a container is deleted, any data written to the container that is not stored in a data volume is deleted along with the container. A data volume is directory or file that is mounted directly into a container.
.. コンテナの削除し、コンテナに対して書き込まれたあらゆるデータを削除します。しかし、 *データ・ボリューム* の保管内容は、コンテナと一緒に削除されません。データ・ボリュームは、コンテナ内に直接マウントするファイルかディスク容量です。

.. When a container is deleted, any data written to the container that is not stored in a data volume is deleted along with the container.

コンテナを削除したら、コンテナに対して書き込まれたあらゆるデータが削除されます。しかし、 *データ・ボリューム (data volume)* の保存内容は、コンテナと一緒に削除しません。

.. Data volumes are not controlled by the storage driver. Reads and writes to data volumes bypass the storage driver and operate at native host speeds. You can mount any number of data volumes into a container. Multiple containers can also share one or more data volumes.
.. データ・ボリュームはストレージ・ドライバによって管理されません。データ・ボリュームに対する読み書きは、ストレージ・ドライバを迂回し、ネイティブなホストの速度で操作できます。コンテナ内に複数のデータ・ボリュームをマウントできます。複数のコンテナが１つまたは複数のデータ・ボリュームをマウントできます。

.. A data volume is a directory or file in the Docker host’s filesystem that is mounted directly into a container. Data volumes are not controlled by the storage driver. Reads and writes to data volumes bypass the storage driver and operate at native host speeds. You can mount any number of data volumes into a container. Multiple containers can also share one or more data volumes.

データ・ボリュームとは、コンテナが直接マウントするディレクトリまたはファイルであり、Docker ホストのファイルシステム上に存在します。データ・ボリュームはストレージ・ドライバが管理しません。データ・ボリュームに対する読み書きはストレージ・ドライバをバイパス（迂回）し、ホスト上の本来の速度で処理されます。コンテナ内に複数のデータ・ボリュームをマウントできます。１つまたは複数のデータ・ボリュームを、複数のコンテナで共有もできます。

.. The diagram below shows a single Docker host running two containers. Each container exists inside of its own address space within the Docker host’s local storage area (/var/lib/docker/...). There is also a single shared data volume located at /data on the Docker host. This is mounted directly into both containers.

以下の図は、１つの Docker ホストから２つのコンテナを実行しているものです。Docker ホストのローカル・ストレージ領域（ ``/var/lib/docker/...`` ）の中に、それぞれのコンテナに対して割り当てられた領域が存在しています。また、Docker ホスト上の ``/data`` に位置する共有データ・ボリュームもあります。このディレクトリは両方のコンテナからマウントされます。

.. image:: ./images/shared-volume.png
   :scale: 60%
   :alt: 共有ボリューム

.. The data volume resides outside of the local storage area on the Docker host further reinforcing its independence from the storage driver’s control. When a container is deleted, any data stored in shared data volumes persists on the Docker host.

データ・ボリュームは Docker ホスト上のローカル・ストレージ領域の外に存在しており、ストレージ・ドライバの管理から独立して離れています。コンテナを削除したとしても、Docker ホスト上の共有データ・ボリュームに保管されたデータに対して、何ら影響はありません。

.. For detailed information about data volumes Managing data in containers.

データ・ボリュームに関する更に詳しい情報は、 :doc:`コンテナでデータを管理する </engine/userguide/containers/dockervolumes>` をご覧ください。

.. Related information

関連情報
==========

.. _volume-related-information:

..    Select a storage driver
    AUFS storage driver in practice
    Btrfs storage driver in practice
    Device Mapper storage driver in practice

* :doc:`selectadriver`
* :doc:`aufs-driver`
* :doc:`btrfs-driver`
* :doc:`device-mapper-driver`

.. seealso:: 

   Understand images, containers, and storage drivers
      https://docs.docker.com/engine/userguide/storagedriver/imagesandcontainers/
