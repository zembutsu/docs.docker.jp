.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/import/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/import.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/import.md
.. check date: 2016/06/16
.. Commits on Feb 19, 2016 cdc7f26715fbf0779a5283354048caf9faa1ec4a
.. -------------------------------------------------------------------

.. import

=======================================
import
=======================================

.. code-block:: bash

   使い方: docker import ファイル|URL|- [リポジトリ[:タグ]]
   
   空のファイルシステム・イメージを作成し、tar ボールの内容を読み込む（import）
   tar ボールの形式は (.tar, .tar.gz, .tgz, .bzip, .tar.xz, .txz)
   オプションで、取り込み後にタグ付け
   
     -c, --change=[]     イメージ読み込み時に Dockerfile の命令を追加変更
     --help              使い方を表示
     -m, --message=      イメージを取り込み時、コミット用のメッセージを設定

.. You can specify a URL or - (dash) to take data directly from STDIN. The URL can point to an archive (.tar, .tar.gz, .tgz, .bzip, .tar.xz, or .txz) containing a filesystem or to an individual file on the Docker host. If you specify an archive, Docker untars it in the container relative to the / (root). If you specify an individual file, you must specify the full path within the host. To import from a remote location, specify a URI that begins with the http:// or https:// protocol.

``URL`` か ``-`` （ダッシュ）の指定、あるいは ``STDIN`` （標準入力）から直接データを取り込みます。 ``URL`` はアーカイブ（ .tar、.tar.gz、.tgz、.bzip、.tar.xz、txz）に含まれる圧縮ファイルシステムや、Docker ホスト上の個々のファイルを指定します。アーカイブを指定したら、 Docker はコンテナの ``/`` （ルート）以下の相対パスとして展開します。個々のファイルを指定する場合、ホスト上のフルパスを指定する必要があります。リモートの場所から import する場合、 ``URI`` の形式は、 ``http://`` か ``https://`` プロトコルで始まる必要があります。

.. The --change option will apply Dockerfile instructions to the image that is created. Supported Dockerfile instructions: CMD|ENTRYPOINT|ENV|EXPOSE|ONBUILD|USER|VOLUME|WORKDIR

``--change`` オプションが適用されるのは ``Dockerfile`` 命令でイメージの作成時です。サポートされている ``Dockerfile`` の命令は、 ``CMD`` ``ENTRYPOINT`` ``ENV`` ``EXPOSE`` ``ONBUID`` ``USER`` ``VOLUME`` ``WORKDIR`` です。

.. Examples

.. _import-examples:

例
==========

.. Import from a remote location:

**リモートから取り込む：**

.. This will create a new untagged image.

新しいタグ付けされていないイメージを作成します。

.. code-block:: bash

   $ docker import http://example.com/exampleimage.tgz

.. Import from a local file:

**ローカル・ファイルを取り込む：**

.. Import to docker via pipe and STDIN.

``STDIN`` のパイプ経由で Docker に取り込みます。

.. code-block:: bash

   $ cat exampleimage.tgz | docker import - exampleimagelocal:new

.. Import with a commit message.

コミット・メッセージを付けて取り込みます。

.. code-block:: bash

   $ cat exampleimage.tgz | docker import --message "New image imported from tarball" - exampleimagelocal:new

.. Import to docker from a local archive.

ローカルのアーカイブから取り込みます。

.. code-block:: bash

   $ docker import /path/to/exampleimage.tgz

.. Import from a local directory:

**ローカルのディレクトリを取り込む：**

.. code-block:: bash

   $ sudo tar -c . | docker import - exampleimagedir

.. Import from a local directory with new configurations:

**新しい設定でローカルのディレクトリを取り込む：**

.. code-block:: bash

   $ sudo tar -c . | docker import --change "ENV DEBUG true" - exampleimagedir

.. Note the sudo in this example -- you must preserve the ownership of the files (especially root ownership) during the archiving with tar. If you are not root (or the sudo command) when you tar, then the ownerships might not get preserved.

この例では ``sudo`` を使っているのに気をつけてください。これは、tar アーカイブを処理する時にファイル（特に root ）の所有権を保持するためです。root でなければ（あるいは sudo を使わなければ）、tar の利用時に権限を得られない可能性があります。

.. seealso:: 

   import
      https://docs.docker.com/engine/reference/commandline/import/

