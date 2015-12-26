.. -*- coding: utf-8 -*-
.. https://docs.docker.com/engine/reference/commandline/cp/
.. doc version: 1.9
.. check date: 2015/12/26
.. -----------------------------------------------------------------------------

.. cp

=======================================
cp
=======================================

.. code-block:: bash

   Usage: docker cp [OPTIONS] CONTAINER:PATH LOCALPATH|-
          docker cp [OPTIONS] LOCALPATH|- CONTAINER:PATH
   
   Copy files/folders between a container and the local filesystem
   
     --help=false        Print usage

.. In the first synopsis form, the docker cp utility copies the contents of PATH from the filesystem of CONTAINER to the LOCALPATH (or stream as a tar archive to STDOUT if - is specified).

１つめの概要は、 ``コンテナ`` のファイルシステム上の ``パス`` にある内容を ``ローカルのパス`` にコピーするためには、 ``docker cp`` が役立ちます。

.. In the second synopsis form, the contents of LOCALPATH (or a tar archive streamed from STDIN if - is specified) are copied from the local machine to PATH in the filesystem of CONTAINER.

２つめの概要は、 ``ローカルパス`` （あるいは ``STDIN`` で ``-`` で指定した tar アーカイブを流し込み）に含まれる内容を、ローカルマシン上から ``コンテナ`` のファイルシステム上の ``パス`` にコピーします。

.. You can copy to or from either a running or stopped container. The PATH can be a file or directory. The docker cp command assumes all CONTAINER:PATH values are relative to the / (root) directory of the container. This means supplying the initial forward slash is optional; The command sees compassionate_darwin:/tmp/foo/myfile.txt and compassionate_darwin:tmp/foo/myfile.txt as identical. If a LOCALPATH value is not absolute, is it considered relative to the current working directory.

コピーはコンテナが実行中でも停止中でも可能です。 ``パス`` とはファイルまたはディレクトリです。 ``docker cp`` コマンドは、全ての ``コンテナ:パス`` 値はコンテナ内の ``/`` （ルート）ディレクトリとみなします。つまり、転送先の冒頭にスラッシュを付けるのはオプションです。つまり、コマンド ``compassionate_darwin:/tmp/foo/myfile.txt`` と ``compassionate_darwin:tmp/foo/myfile.txt`` は同一です。 ``ローカルパス``の値は絶対パスで歯無く、現在の作業ディレクトリからの相対パスとみなされます。

.. Behavior is similar to the common Unix utility cp -a in that directories are copied recursively with permissions preserved if possible. Ownership is set to the user and primary group on the receiving end of the transfer. For example, files copied to a container will be created with UID:GID of the root user. Files copied to the local machine will be created with the UID:GID of the user which invoked the docker cp command.

動作は一般的な Unix ユーティリティ ``cp -a`` に似ています。可能であればパーミッションと一緒に、ディレクトリは再帰的にコピーされます。所有者の権限は、転送終了時にユーザとプライマリ・グループが指定されます。例えば、ファイルをコンテナにコピーすると、 ``UID:GID`` は root ユーザとして作成されます。ファイルをローカルのマシン上にコピーするときは、 ``docker cp`` コマンドを実行したユーザの ``UID:GID`` が作成されます。

.. Assuming a path separator of /, a first argument of SRC_PATH and second argument of DST_PATH, the behavior is as follows:

パスは ``/`` で分離され、 １つめの引数は ``送信元のパス`` 、２つめの引数は ``送信先のパス`` と見なされます。次のように動作します。

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
   * `送信元ディレクトリを対象のディレクトリにコピー
  * ``送信元のパス`` が ``/`` で終わらない場合
   * `送信元ディレクトリの* 内容* を対象のディレクトリにコピー

.. The command requires SRC_PATH and DST_PATH to exist according to the above rules. If SRC_PATH is local and is a symbolic link, the symbolic link, not the target, is copied.

コマンドで使う ``送信元のパス`` と ``送信先のパス`` は上記のルールに従う必要があります。 ``送信元のパス`` がローカル上かつシンボリックリンクの場合は、その対象ではなくシンボリックリンクがコピーされます。

.. A colon (:) is used as a delimiter between CONTAINER and PATH, but : could also be in a valid LOCALPATH, like file:name.txt. This ambiguity is resolved by requiring a LOCALPATH with a : to be made explicit with a relative or absolute path, for example:

コロン（ ``:`` ）は ``コンテナ`` と ``パス`` のデリミタ（区切り文字）として使われますが、 ``:`` は ``file:name.txt`` のように有効な ``ローカルのパス`` としても使われます。この曖昧さを解決するには、 ``ローカルパス`` で ``:`` を明確な絶対パス・相対パスの指定に使います。例：

.. code-block:: bash

   `/path/to/file:name.txt` or `./file:name.txt`

.. It is not possible to copy certain system files such as resources under /proc, /sys, /dev, and mounts created by the user in the container.

``/proc`` 、 ``/sys`` 、 ``/dev``配下にあるリソースのような特定のシステムファイルはコピーできません。これらはコンテナの中にマウントされます。

.. Using - as the first argument in place of a LOCALPATH will stream the contents of STDIN as a tar archive which will be extracted to the PATH in the filesystem of the destination container. In this case, PATH must specify a directory.

``ローカルパス`` の１番目の引数に ``-`` を使うと、tar アーカイブからの内容を ``STDIN`` （標準入力）としてストリーム（流し込み）ます。これにより、対象となるコンテナのファイルシステムにある ``パス`` に展開します。

.. Using - as the second argument in place of a LOCALPATH will stream the contents of the resource from the source container as a tar archive to STDOUT.

``ローカルパス`` の２番目の引数に ``-`` を使うと、基となるコンテナのリソースに含まれる内容が、tar アーカイブとして ``STDOUT`` （標準出力）にストリームします。
