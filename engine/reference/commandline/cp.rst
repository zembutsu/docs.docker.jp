.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/cp/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/cp.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/cp.md
.. check date: 2016/06/14
.. Commits on May 24, 2016 cb1635c9cf4813c95a1c72dd35b13e8acebfbfb6
.. -------------------------------------------------------------------

.. cp

=======================================
cp
=======================================

.. code-block:: bash

   使い方: docker cp [オプション] コンテナ:パス ローカル・パス|-
          docker cp [オプション] ローカル・パス|- コンテナ:パス
   
   コンテナとローカル・ファイルシステム間でファイルとフォルダをコピーする
   
     --help              使い方の表示

.. In the first synopsis form, the docker cp utility copies the contents of PATH from the filesystem of CONTAINER to the LOCALPATH (or stream as a tar archive to STDOUT if - is specified).

概要の１つめは、 ``コンテナ`` のファイルシステム上の ``パス`` にある内容を ``ローカルのパス`` にコピーするために、 ``docker cp`` が役立ちます。

.. In the second synopsis form, the contents of LOCALPATH (or a tar archive streamed from STDIN if - is specified) are copied from the local machine to PATH in the filesystem of CONTAINER.

概要の２つめは、 ``ローカルパス`` （あるいは ``STDIN`` で ``-`` で指定した tar アーカイブを流し込み）に含まれる内容を、ローカルマシン上から ``コンテナ`` のファイルシステム上の ``パス`` にコピーします。

.. You can copy to or from either a running or stopped container. The PATH can can be a file or directory. The docker cp command assumes all CONTAINER:PATH values are relative to the / (root) directory of the container. This means supplying the initial forward slash is optional; The command sees compassionate_darwin:/tmp/foo/myfile.txt and compassionate_darwin:tmp/foo/myfile.txt as identical. If a LOCALPATH value is not absolute, is it considered relative to the current working directory.

コピーはコンテナが実行中でも停止中でも可能です。 ``パス`` とはファイルまたはディレクトリです。 ``docker cp`` コマンドは、全ての ``コンテナ:パス`` 値をコンテナ内の ``/`` （ルート）ディレクトリとみなします。つまり、転送先の冒頭にスラッシュを付けるのはオプションです。つまり、コマンド ``compassionate_darwin:/tmp/foo/myfile.txt`` と ``compassionate_darwin:tmp/foo/myfile.txt`` は同一です。 ``ローカルパス`` の値は絶対パスではなく、現在の作業ディレクトリからの相対パスとみなされます。

.. Behavior is similar to the common Unix utility cp -a in that directories are copied recursively with permissions preserved if possible. Ownership is set to the user and primary group on the receiving end of the transfer. For example, files copied to a container will be created with UID:GID of the root user. Files copied to the local machine will be created with the UID:GID of the user which invoked the docker cp command. If you specify the -L option, docker cp follows any symbolic link in the SRC_PATH. docker cp does not create parent directories for DEST_PATH if they do not exist.

動作は一般的な Unix ユーティリティ ``cp -a`` に似ています。可能であればパーミッションと一緒に、ディレクトリも再帰的にコピーします。所有者の権限は、転送終了時にユーザとプライマリ・グループが指定されます。例えば、ファイルをコンテナにコピーすると、 ``UID:GID`` は root ユーザとして作成されます。ファイルをローカルのマシン上にコピーする時は、 ``docker cp`` コマンドを実行したユーザの ``UID:GID`` が作成されます。もしも ``docker cp`` で ``-L`` オプションを指定すると、 ``送信元パス`` のシンボリック・リンクをフォローします。 ``docker cp`` は ``送信先パス`` が存在しなければ、親ディレクトリを作成しません。

.. Assuming a path separator of /, a first argument of SRC_PATH and second argument of DST_PATH, the behavior is as follows:

パスは ``/`` で分離され、 １つめの引数は ``送信元のパス`` 、２つめの引数は ``送信先のパス`` とみなされます。次のように動作します。

..    SRC_PATH specifies a file
        DST_PATH does not exist
            the file is saved to a file created at DST_PATH
        DST_PATH does not exist and ends with /
            Error condition: the destination directory must exist.
        DST_PATH exists and is a file
            the destination is overwritten with the contents of the source file
        DST_PATH exists and is a directory
            the file is copied into this directory using the basename from SRC_PATH
    SRC_PATH specifies a directory
        DST_PATH does not exist
            DST_PATH is created as a directory and the contents of the source directory are copied into this directory
        DST_PATH exists and is a file
            Error condition: cannot copy a directory to a file
        DST_PATH exists and is a directory
            SRC_PATH does not end with /.
                the source directory is copied into this directory
            SRC_PATH does end with /.
                the content of the source directory is copied into this directory

* ``送信元のパス`` でファイルを指定する

 * ``送信先のパス`` が存在しない

  * ``送信先のパス`` にファイルを作成し、ファイルを保存する

 * ``送信先のパス`` が存在せず、最後に ``/`` がある場合

  * エラーが発生：送信先ディレクトリが存在しなくてはいけない

 * ``送信先のパス`` が存在し、ファイルである場合

  * 送信元にあるファイルで、送信先のファイル内容を上書きする

 * ``送信先のパス`` が存在し、ディレクトリの場合

  * ``送信元のパス`` にある名前をもとに、対象のディレクトリにファイルをコピー

* ``送信元のパス`` でディレクトリを指定する

 * ``送信先のパス`` が存在しない

  * ``送信先のパス`` にディレクトリを作成し、送信元ディレクトリに含まれる *内容* をコピーする

 * ``送信先のパス`` が存在し、ファイルである場合

  * エラーが発生：ディレクトリをファイルにコピーできない

 * ``送信先のパス`` が存在し、ディレクトリの場合

  * ``送信元のパス`` が ``/`` で終わる場合

   * ``送信元ディレクトリ`` を対象のディレクトリにコピー

  * ``送信元のパス`` が ``/`` で終わらない場合

   * ``送信元ディレクトリ`` の *内容* を対象のディレクトリにコピー

.. The command requires SRC_PATH and DST_PATH to exist according to the above rules. If SRC_PATH is local and is a symbolic link, the symbolic link, not the target, is copied.

コマンドで使う ``送信元のパス`` と ``送信先のパス`` は上記のルールに従う必要があります。 ``送信元のパス`` がローカル上かつシンボリックリンクの場合は、その対象ではなくシンボリックリンクがコピーされます。

.. A colon (:) is used as a delimiter between CONTAINER and PATH, but : could also be in a valid LOCALPATH, like file:name.txt. This ambiguity is resolved by requiring a LOCALPATH with a : to be made explicit with a relative or absolute path, for example:

コロン（ ``:`` ）は ``コンテナ`` と ``パス`` のデリミタ（区切り文字）として使われますが、 ``:`` は ``file:name.txt`` のように有効な ``ローカルのパス`` としても使われます。この曖昧さを解決するには、 ``ローカルパス`` で ``:`` を明確な絶対パス・相対パスの指定に使います。例：

.. code-block:: bash

   `/path/to/file:name.txt` or `./file:name.txt`

.. It is not possible to copy certain system files such as resources under /proc, /sys, /dev, tmpfs, and mounts created by the user in the container. However, you can still copy such files by manually running tar in docker exec. For example (consider SRC_PATH and DEST_PATH are directories):

``/proc`` 、 ``/sys`` 、 ``/dev`` 、 :ref:`tmpfs <mount-tmpfs>` 配下にあるリソースのように、特定のシステムファイルはコピーできません。これらはコンテナの中にマウントします。ただし、 ``docker exec``  で ``tar`` を時h手動実行し、ファイルをコピー可能です。例（ ``送信元のパス`` と ``送信先のパス`` はディレクトリと見なします）：

.. code-block:: bash

   $ docker exec foo tar Ccf $(dirname 送信元パス) - $(basename 送信元パス) | tar Cxf 送信先パス -

.. or

あるいは

.. code-block:: bash

   $ tar Ccf $(dirname 送信元パス) - $(basename 送信元パス) | docker exec -i foo tar Cxf 送信先パス -

.. Using - as the SRC_PATH streams the contents of STDIN as a tar archive. The command extracts the content of the tar to the DEST_PATH in container’s filesystem. In this case, DEST_PATH must specify a directory. Using - as the DEST_PATH streams the contents of the resource as a tar archive to STDOUT.

``送信元のパス`` に ``-`` を使うと、 ``STDIN`` （標準入力）を tar アーカイブの内容として流し込みます。このコマンドにより、対象となるコンテナ上にあるファイルシステムの  ``送信先パス`` に展開します。この場合、 ``送信先パス`` にはディレクトリを指定する必要があります。 ``送信先パス`` に ``-`` を使うと、tar アーカイブを ``STDOUT`` （標準出力）します。

.. Using - as the first argument in place of a LOCALPATH will stream the contents of STDIN as a tar archive which will be extracted to the PATH in the filesystem of the destination container. In this case, PATH must specify a directory.

``ローカルパス`` の１番めの引数に ``-`` を使うと、tar アーカイブからの内容を ``STDIN`` （標準入力）としてストリーム（流し込み）ます。これにより、対象となるコンテナのファイルシステムにある ``パス`` に展開します。元となるコンテナのリソースに含まれる内容が、tar アーカイブとして ``STDOUT`` （標準出力）にストリーム出力します。

.. seealso:: 

   cp
      https://docs.docker.com/engine/reference/commandline/cp/
