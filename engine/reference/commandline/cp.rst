.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/cp/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/cp.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_cp.yaml
.. check date: 2022/03/20
.. Commits on Aug 21, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker cp

=======================================
docker cp
=======================================

.. seealso:: 

   :doc:`docker container cp <container_cp>`

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _docker_cp-description:

説明
==========

.. Copy files/folders between a container and the local filesystem

コンテナとローカルファイルシステム間で、ファイルやフォルダを :ruby:`コピー <copy>` します。

.. _docker_cp-usage:

使い方
==========

.. code-block:: bash

   $ docker cp [OPTIONS] CONTAINER:SRC_PATH DEST_PATH|-
   docker cp [OPTIONS] SRC_PATH|- CONTAINER:DEST_PATH

.. Extended description
.. _docker_cp-extended-description:

補足説明
==========

.. The docker cp utility copies the contents of SRC_PATH to the DEST_PATH. You can copy from the container’s file system to the local machine or the reverse, from the local filesystem to the container. If - is specified for either the SRC_PATH or DEST_PATH, you can also stream a tar archive from STDIN or to STDOUT. The CONTAINER can be a running or stopped container. The SRC_PATH or DEST_PATH can be a file or directory.

``docker cp`` は ``SRC_PATH`` を ``DEST_PATH`` にコピーする機能です。コンテナのファイルシステムからローカルマシンにコピーできるだけでなく、逆にローカルのファイルシステムからコンテナへもコピーできます。 ``SRC_PATH`` や ``DEST_PATH`` にかわり、どちらかに ``-`` を指定すると、 ``STDIN`` から ``STDOUT``` へ、あるいは、 ``STDOUT`` から ``STDIN`` へ tar アーカイブとしてストリーミングします。 ``CONTAINER`` は、実行中もしくは停止中のコンテナです。 ``SRC_PATH`` や ``DEST_PATH`` はファイルかディレクトリです。

.. The docker cp command assumes container paths are relative to the container’s / (root) directory. This means supplying the initial forward slash is optional; The command sees compassionate_darwin:/tmp/foo/myfile.txt and compassionate_darwin:tmp/foo/myfile.txt as identical. Local machine paths can be an absolute or relative value. The command interprets a local machine’s relative paths as relative to the current working directory where docker cp is run.

``docker cp`` コマンドでは、コンテナ内のパスとは、コンテナの ``/`` （ルート）ディレクトリからの相対パスとみなします。これが意味するのは、コピー先のパス冒頭にスラッシュを付けるのはオプションです。つまり、コマンド ``compassionate_darwin:/tmp/foo/myfile.txt`` と ``compassionate_darwin:tmp/foo/myfile.txt`` は同じです。ローカルマシン上のパスは、絶対パスと相対パスどちらも指定できます。ローカルマシン上の相対パスとは、 ``docker cp`` を実行した現在の作業ディレクトリからの相対パスです。

.. The cp command behaves like the Unix cp -a command in that directories are copied recursively with permissions preserved if possible. Ownership is set to the user and primary group at the destination. For example, files copied to a container are created with UID:GID of the root user. Files copied to the local machine are created with the UID:GID of the user which invoked the docker cp command. However, if you specify the -a option, docker cp sets the ownership to the user and primary group at the source. If you specify the -L option, docker cp follows any symbolic link in the SRC_PATH. docker cp does not create parent directories for DEST_PATH if they do not exist.

``cp`` コマンドの挙動は Unix の ``cp -a`` コマンドと似ています。これは、パーミッションを可能であれば維持しながら、ディレクトリを再帰的にコピーします。コピー先でも同じユーザとプライマリ・グループの所有権が設定されます。例えば、コンテナにコピーするファイルは、 root ユーザの ``UID:GID`` として作成されます。ローカルマシンへコピーするファイルは、 ``docker cp`` コマンドを実行したユーザの ``UID:GID`` として作成されます。ですが、 ``-a``  オプションを指定する場合、 ``docker cp`` はコピー元のユーザとプライマリ・グループの所有権を設定します。 ``-L`` オプションを指定する場合は、 ``docker cp`` は ``SRC_PATH`` （ :ruby:`コピー元 <source>` のパス）内にあるシンボリックリンクも維持します。 ``docker cp`` は ``DEST_PATH`` （ :ruby:`コピー先 <destination>` のパス）の親ディレクトリが存在しない場合、その親ディレクトリを作成 *しません* 。

.. Assuming a path separator of /, a first argument of SRC_PATH and second argument of DST_PATH, the behavior is as follows:

前提として、パスは ``/`` 記号で分けられ、1つめの引数は ``SRC_PATH`` 、2つめの引数は ``DEST_PATH`` とした場合、次のように動作します。

..    SRC_PATH specifies a file
        DEST_PATH does not exist
            the file is saved to a file created at DEST_PATH
        DEST_PATH does not exist and ends with /
            Error condition: the destination directory must exist.
        DEST_PATH exists and is a file
            the destination is overwritten with the source file’s contents
        DEST_PATH exists and is a directory
            the file is copied into this directory using the basename from SRC_PATH
    SRC_PATH specifies a directory
        DEST_PATH does not exist
            DEST_PATH is created as a directory and the contents of the source directory are copied into this directory
        DEST_PATH exists and is a file
            Error condition: cannot copy a directory to a file
        DEST_PATH exists and is a directory
            SRC_PATH does not end with /. (that is: slash followed by dot)
                the source directory is copied into this directory
            SRC_PATH does end with /. (that is: slash followed by dot)
                the content of the source directory is copied into this directory


* ``SRC_PATH`` でファイルを指定する場合

   * ``DEST_PATH`` が存在しない場合

      * ``DEST_PATH`` にファイルを作成し、ファイルを保存する

   * ``DEST_PATH`` が存在せず、最後に ``/`` がある場合

      * エラーが発生：コピー先ディレクトリが存在しなくてはいけない

   * ``DEST_PATH`` が存在し、ファイルである場合

      * コピー元にあるファイルで、コピー先のファイル内容を上書きする

   * ``DEST_PATH`` が存在し、ディレクトリの場合

      * ``SRC_PATH`` にある名前を使い、対象のディレクトリにファイルをコピー

* ``SRC_PATH`` でディレクトリを指定する場合

   * ``DEST_PATH`` が存在しない場合

      * ``DEST_PATH`` にディレクトリを作成し、コピー元ディレクトリ内にある *内容* をコピーする

   * ``DEST_PATH`` が存在し、ファイルである場合

      * エラーが発生：ディレクトリをファイルにコピーできない

   * ``DEST_PATH`` が存在し、ディレクトリの場合

      * ``SRC_PATH`` が ``/.`` （スラッシュの後にドットが続く）で終わらない場合

         * コピー元ディレクトリを対象のディレクトリにコピー

      * ``SRC_PATH`` が ``/.`` （スラッシュの後にドットが続く）で終わる場合

         * コピー元ディレクトリ内にある *内容* を対象のディレクトリにコピー

.. The command requires SRC_PATH and DEST_PATH to exist according to the above rules. If SRC_PATH is local and is a symbolic link, the symbolic link, not the target, is copied by default. To copy the link target and not the link, specify the -L option.

コマンドで使う ``SRC_PATH`` と ``DEST_PATH`` は上記のルールに従う必要があります。 ``SRC_PATH`` がローカルで、かつ、シンボリックリンクの場合、シンボリックリンクではなくリンク先の実体をコピーします。この動作がデフォルトです。リンク先の対象ではなく、リンクそのものをコピーするには、 ``-L`` オプションを指定します。

.. A colon (:) is used as a delimiter between CONTAINER and its path. You can also use : when specifying paths to a SRC_PATH or DEST_PATH on a local machine, for example file:name.txt. If you use a : in a local machine path, you must be explicit with a relative or absolute path, for example:

コロン（ ``:`` ）記号は、 ``CONTAINER`` （コンテナ名）とコンテナ内のパスを :ruby:`区切る文字 <delimiter>` として使います。また、 ``file:name.txt`` のように、 ``:`` はローカルマシン上で ``SRC_PATH`` や ``DEST_PATH`` の指定にも使えます。ローカルマシン上のパスで ``:`` を使う場合は、次のように相対パスまたは絶対パスで明示する必要があります。

.. code-block:: bash

   `/path/to/file:name.txt` or `./file:name.txt`

.. It is not possible to copy certain system files such as resources under /proc, /sys, /dev, tmpfs, and mounts created by the user in the container. However, you can still copy such files by manually running tar in docker exec. Both of the following examples do the same thing in different ways (consider SRC_PATH and DEST_PATH are directories):

.. It is not possible to copy certain system files such as resources under /proc, /sys, /dev, tmpfs, and mounts created by the user in the container. However, you can still copy such files by manually running tar in docker exec. For example (consider SRC_PATH and DEST_PATH are directories):

``/proc`` 、 ``/sys`` 、 ``/dev`` 、 :ref:`tmpfs <mount-tmpfs>` 配下にあるリソースのような、特定のシステムファイルはコピーできません。ですが、 ``docker exec`` で ``tar`` を手動で実行すると、コピーできます。以下の例は、異なる手法で同じ処理を行います（ ``SRC_PATH`` と ``DEST_PATH`` はディレクトリと想定します）。

.. code-block:: bash

   $ docker exec CONTAINER tar Ccf $(dirname SRC_PATH) - $(basename SRC_PATH) | tar Cxf DEST_PATH -

.. code-block:: bash

   $ tar Ccf $(dirname SRC_PATH) - $(basename SRC_PATH) | docker exec -i CONTAINER tar Cxf DEST_PATH -

.. Using - as the SRC_PATH streams the contents of STDIN as a tar archive. The command extracts the content of the tar to the DEST_PATH in container’s filesystem. In this case, DEST_PATH must specify a directory. Using - as the DEST_PATH streams the contents of the resource as a tar archive to STDOUT.

``SRC_PATH`` に ``-`` を指定すると、tar アーカイブとして ``STDIN`` （標準入力）に内容を出力（ストリーミング）します。このコマンドにより、コンテナのファイルシステム上にある ``DEST_PATH`` へ tar の内容を展開します。 ``DEST_PATH`` に ``-`` を指定すると、 tar アーカイブを ``STDOUT`` （標準出力）に出力（ストリーミング）します。


.. _docker_cp-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--archive`` , ``-a``
     - 
     - アーカイブ・モード（全ての uid/gid 情報をコピー）
   * - ``--follow-link`` , ``-L``
     - 
     - SRC_PATH にあるシンボリックリンクを常にコピー


親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI の基本コマンド


.. seealso:: 

docker cp
  https://docs.docker.com/engine/reference/commandline/cp/
