.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/save/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/save.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/save.md
.. check date: 2016/06/16
.. Commits on Mar 22, 2016 5a701c3e4cd63f0b17b4fe9ab13c8cbe0ea5d353
.. -------------------------------------------------------------------

.. save

=======================================
save
=======================================

.. code-block:: bash

   使い方: docker save [オプション] イメージ [イメージ...]
   
   １つまたは複数のイメージを tar アーカイブに保存（デフォルトは STDOUT にストリーム）
   
     --help             使い方の表示
     -o, --output=""    STDOUT（標準出力）の代わりに、ファイルへ書き込む

.. Produces a tarred repository to the standard output stream. Contains all parent layers, and all tags + versions, or specified repo:tag, for each argument provided.

tar 化されたリポジトリを、標準出力のストリームに出力します。ここには全ての親レイヤが含まれ、全てのタグとバージョンだけでなく、 ``リポジトリ名:タグ`` が指定されれば、それぞれの引数に応じて出力します。

.. It is used to create a backup that can then be used with docker load

これはバックアップの作成のために利用でき、再度使うには ``docker load`` を指定します。

.. code-block:: bash

   $ docker save busybox > busybox.tar
   $ ls -sh busybox.tar
   2.7M busybox.tar
   $ docker save --output busybox.tar busybox
   $ ls -sh busybox.tar
   2.7M busybox.tar
   $ docker save -o fedora-all.tar fedora
   $ docker save -o fedora-latest.tar fedora:latest

.. It is even useful to cherry-pick particular tags of an image repository

イメージのリポジトリで、適切なタグを指定する場合にも便利でしょう。

.. code-block:: bash

   $ docker save -o ubuntu.tar ubuntu:lucid ubuntu:saucy

.. seealso:: 

   save
      https://docs.docker.com/engine/reference/commandline/save/

