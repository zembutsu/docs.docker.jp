.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/import/
.. SOURCE:
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/import.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_import.yaml
.. check date: 2022/03/20
.. Commits on Aug 22, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker import

=======================================
docker import
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _docker_import-description:

説明
==========

.. Import the contents from a tarball to create a filesystem image

ファイルシステム・イメージを作成するため、 tar ボールから内容を :ruby:`読み込み <import>` ます。

.. _docker_import-usage:

使い方
==========

.. code-block:: bash

   $ docker import [OPTIONS] file|URL|- [REPOSITORY[:TAG]]

.. Extended description
.. _docker_import-extended-description:

補足説明
==========

.. You can specify a URL or - (dash) to take data directly from STDIN. The URL can point to an archive (.tar, .tar.gz, .tgz, .bzip, .tar.xz, or .txz) containing a filesystem or to an individual file on the Docker host. If you specify an archive, Docker untars it in the container relative to the / (root). If you specify an individual file, you must specify the full path within the host. To import from a remote location, specify a URI that begins with the http:// or https:// protocol.

``URL`` か ``-`` （ダッシュ）の指定、あるいは ``STDIN`` （標準入力）から直接データを取り込みます。 ``URL`` はアーカイブ（ .tar、.tar.gz、.tgz、.bzip、.tar.xz、txz）に含まれる圧縮ファイルシステムや、Docker ホスト上の個々のファイルを指定します。アーカイブを指定した場合は、 Docker はコンテナの ``/`` （ルート）以下の相対パスとして展開します。個々のファイルを指定する場合、ホスト上のフルパスを指定する必要があります。リモートの場所から import する場合、 ``URI`` の形式は、 ``http://`` か ``https://`` プロトコルで始まる必要があります。

.. The --change option will apply Dockerfile instructions to the image that is created. Supported Dockerfile instructions: CMD|ENTRYPOINT|ENV|EXPOSE|ONBUILD|USER|VOLUME|WORKDIR

``--change`` オプションが適用されるのは ``Dockerfile`` 命令でイメージの作成時です。サポートされている ``Dockerfile`` の命令は、 ``CMD`` ``ENTRYPOINT`` ``ENV`` ``EXPOSE`` ``ONBUID`` ``USER`` ``VOLUME`` ``WORKDIR`` です。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <docker_import-examples>` をご覧ください。

.. _docker_import-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--change`` , ``-c``
     - 
     - イメージ作成時に Dockerfile 命令を追加
   * - ``--message`` , ``-m``
     - 
     - 読み込んだイメージにコミット・メッセージを設定
   * - ``--platform``
     - 
     - 【API 1.32+】サーバがマルチプラットフォームに対応している場合、プラットフォームを指定

.. Examples
.. _docker_import-examples:

使用例
==========

.. Import from a remote location
.. _docker_import-import-from-a-remote-location:

リモートの場所から読み込む
------------------------------

.. This will create a new untagged image.

これは、タグ付けされていない新しいイメージを作成します。

.. code-block:: bash

   $ docker import http://example.com/exampleimage.tgz

.. Import from a local file
.. _docker_import-import-from-a-local-file:

ローカルのファイルから読み込む
------------------------------

.. Import to docker via pipe and STDIN.

``STDIN`` とパイプを経由して、 Docker に読み込みます。

.. code-block:: bash

   $ cat exampleimage.tgz | docker import - exampleimagelocal:new

.. Import with a commit message.

コミット・メッセージを付けて読み込みます。

.. code-block:: bash

   $ cat exampleimage.tgz | docker import --message "New image imported from tarball" - exampleimagelocal:new

.. Import to docker from a local archive.

ローカルのアーカイブから docker に読み込みます。

.. code-block:: bash

   $ docker import /path/to/exampleimage.tgz

.. Import from a local directory
.. _docker_import-import-from-a-local-directory:

ローカルのディレクトリから読み込む
----------------------------------------

.. code-block:: bash

   $ sudo tar -c . | docker import - exampleimagedir

.. Import from a local directory with new configurations
.. _docker_import-import-from-a-local-directory-with-new-configurations:

新しい設定でローカルのディレクトリを読み込む
--------------------------------------------------

.. code-block:: bash

   $ sudo tar -c . | docker import --change "ENV DEBUG true" - exampleimagedir

.. Note the sudo in this example -- you must preserve the ownership of the files (especially root ownership) during the archiving with tar. If you are not root (or the sudo command) when you tar, then the ownerships might not get preserved.

この例では ``sudo`` を使っているのに気をつけてください。これは、tar アーカイブを処理する時にファイル（特に root ）の所有権を保持するためです。root でなければ（あるいは sudo を使わなければ）、tar の利用時に権限を得られない可能性があります。


親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI の基本コマンド


.. seealso:: 

   docker import
      https://docs.docker.com/engine/reference/commandline/import/

