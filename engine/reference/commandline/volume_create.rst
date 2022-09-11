.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/volume_create/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/volume_create.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_volume_create.yaml
.. check date: 2022/04/05
.. Commits on Oct 7, 2021 ed135fe151ad43ca1093074c8fbf52243402013a
.. -------------------------------------------------------------------

.. docker volume create

=======================================
docker volume create
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _volume_create-description:

説明
==========

.. Create a volume

ボリュームを作成します。

.. API 1.21+
   Open the 1.21 API reference (in a new window)
   The client and daemon API must both be at least 1.25 to use this command. Use the docker version command on the client to check your client and daemon API versions.

【API 1.21+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.25 <https://docs.docker.com/engine/api/v1.21/>`_ の必要があります。クライアントとデーモン API のバージョンを調べるには、 ``docker version`` コマンドを使います。


.. _volume_create-usage:

使い方
==========

.. code-block:: bash

   $ docker volume create [OPTIONS] [VOLUME]

.. Extended description
.. _volume_create-extended-description:

補足説明
==========

.. Creates a new volume that containers can consume and store data in. If a name is not specified, Docker generates a random name.

コンテナが利用し、データを保管するための新しいボリュームを作成します。名前を指定しなければ、 Docker はランダムな名称を生成します。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <volume_create-examples>` をご覧ください。

.. _volume_create-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--driver`` , ``-d``
     - ``local``
     - ボリューム・ドライバ名を指定
   * - ``--label``
     - 
     - ボリュームにメタデータを指定
   * - ``--name``
     - 
     - ボリューム名を指定
   * - ``--opt`` , ``-o``
     - 
     - ドライバ固有のオプションを指定

.. Examples
.. _volume_create-examples:

使用例
==========

.. Create a volume and then configure the container to use it:

ボリュームを作成し、コンテナが使えるようにするには、次の例のように実行します。

.. code-block:: bash

   $ docker volume create hello
   
   hello
   
   $ docker run -d -v hello:/world busybox ls /world

.. The mount is created inside the container’s /world directory. Docker does not support relative paths for mount points inside the container.

これはコンテナ内の ``/world`` ディレクトリにマウントを作成します。Docker はコンテナ内のマウントポイントに、相対パスの指定をサポートしません。

.. Multiple containers can use the same volume in the same time period. This is useful if two containers need access to shared data. For example, if one container writes and the other reads the data.

複数のコンテナが同時に同じボリュームを利用できます。２つのコンテナが共有データにアクセスする場合に便利です。例えば、一方のコンテナがデータを書き込み、もう一方がデータを読み込めます。

.. Volume names must be unique among drivers. This means you cannot use the same volume name with two different drivers. If you attempt this docker returns an error:

ボリューム名はドライバ間でユニークである必要があります。つまり２つの異なったドライバで、同じボリューム名を使うことはできません。実行しようとしても、 ``docker`` はエラーを返します。

.. code-block:: bash

   A volume named  "hello"  already exists with the "some-other" driver. Choose a different volume name.

.. If you specify a volume name already in use on the current driver, Docker assumes you want to re-use the existing volume and does not return an error.

現在のドライバが既に使用しているボリューム名を指定する場合は、Docker は既存のボリュームを再利用するとみなし、エラーを返しません。

.. Driver specific options
.. _volume_create-driver-specific-options:

ドライバ固有のオプション
------------------------------

.. Some volume drivers may take options to customize the volume creation. Use the -o or --opt flags to pass driver options:

ボリューム・ドライバによっては、ボリューム作成のカスタマイズのためにオプションが使えます。 ``-o`` か ``--opt`` フラグでドライバにオプションを渡します。

.. code-block:: bash

   $ docker volume create --driver fake \
       --opt tardis=blue \
       --opt timey=wimey \
       foo

.. These options are passed directly to the volume driver. Options for different volume drivers may do different things (or nothing at all).

これらのオプションは各ボリューム・ドライバに直接渡されます。オプションはボリューム・ドライバごとに別々の動作をします（あるいは何もしないかもしれません）。

.. The built-in local driver on Windows does not support any options.

Windows の内蔵 ``local`` ドライバは、オプションをサポートしていません。

.. The built-in local driver on Linux accepts options similar to the linux mount command. You can provide multiple options by passing the --opt flag multiple times. Some mount options (such as the o option) can take a comma-separated list of options. Complete list of available mount options can be found here.

Linux の内蔵 ``local`` ドライバは、linux の ``mount`` コマンドと似たオプションに対応します。 ``--opt`` フラグを複数回使い、複数のオプションを指定できます。いくつかの ``mount`` オプションは（ ``o`` オプションなど）、オプションをカンマで区切る形式です。mount オプションで利用可能なリスト一覧は、 `こちら <https://man7.org/linux/man-pages/man8/mount.8.html>`_ にあります。

.. For example, the following creates a tmpfs volume called foo with a size of 100 megabyte and uid of 1000.

たとえば、以下は ``tmpfs`` ボリュームを作成しますが、名前は ``foo`` 、容量は 100 MB、 ``uid`` は 1000 です。

.. code-block:: bash

   $ docker volume create --driver local \
       --opt type=tmpfs \
       --opt device=tmpfs \
       --opt o=size=100m,uid=1000 \
       foo

.. Another example that uses btrfs:

``btrfs`` を使う他の例です。

.. code-block:: bash

   $ docker volume create --driver local \
       --opt type=btrfs \
       --opt device=/dev/sda2 \
       foo

.. Another example that uses nfs to mount the /path/to/dir in rw mode from 192.168.1.1:

他の例としては、 ``192.168.1.1`` から ``/path/to/dir`` を ``rw`` モードとして、``nfs`` を使ってマウントします。

.. code-block:: bash

   $ docker volume create --driver local \
       --opt type=nfs \
       --opt o=addr=192.168.1.1,rw \
       --opt device=:/path/to/dir \
       foo


.. Parent command

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <volume>`
     - ボリュームを管理


.. Related commands

関連コマンド
====================

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker volume create<volume_create>`
     - ボリュームの作成
   * - :doc:`docker volume inspect<volume_inspect>`
     - 1つまたは複数ボリュームの詳細情報を表示
   * - :doc:`docker volume ls<volume_ls>`
     - ボリューム一覧表示
   * - :doc:`docker volume prune<volume_prune>`
     - 使用していないローカルボリュームを削除
   * - :doc:`docker volume rm<volume_rm>`
     - 1つまたは複数ボリュームを削除


.. seealso:: 

   docker volume create
      https://docs.docker.com/engine/reference/commandline/volume_create/
