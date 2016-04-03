.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/save/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/save.md
   doc version: 1.10
      https://github.com/docker/docker/commits/master/docs/reference/commandline/save.md
.. check date: 2016/02/25
.. Commits on Dec 24, 2015 e6115a6c1c02768898b0a47e550e6c67b433c436
.. -------------------------------------------------------------------

.. save

=======================================
save
=======================================

.. code-block:: bash

   Usage: docker save [OPTIONS] IMAGE [IMAGE...]
   
   Save an image(s) to a tar archive (streamed to STDOUT by default)
   
     --help             Print usage
     -o, --output=""    Write to a file, instead of STDOUT

.. Produces a tarred repository to the standard output stream. Contains all parent layers, and all tags + versions, or specified repo:tag, for each argument provided.

tar 化されたリポジトリを、標準出力のストリームに出力します。ここには全ての親レイヤが含まれ、全てのタグとバージョンだけでなく、 ``repo:tag`` が指定されれば、それぞれの引数に応じて出力します。

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

イメージのリポジトリで適切なタグを指定する場合も便利でしょう。

.. code-block:: bash

   $ docker save -o ubuntu.tar ubuntu:lucid ubuntu:saucy

.. seealso:: 

   save
      https://docs.docker.com/engine/reference/commandline/save/

