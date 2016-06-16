.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/tag/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/tag.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/tag.md
.. check date: 2016/06/16
.. Commits on Jun 14, 2016 8eca8089fa35f652060e86906166dabc42e556f8
.. -------------------------------------------------------------------

.. tag

=======================================
tag
=======================================

.. code-block:: bash

   使い方: docker tag [オプション] 名前[:タグ] 名前[:タグ]
   
   リポジトリ内のイメージにタグ付け
   
     --help               使い方の表示

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. An image name is made up of slash-separated name components, optionally prefixed by a registry hostname. The hostname must comply with standard DNS rules, but may not contain underscores. If a hostname is present, it may optionally be followed by a port number in the format :8080. If not present, the command uses Docker's public registry located at registry-1.docker.io by default. Name components may contain lowercase characters, digits and separators. A separator is defined as a period, one or two underscores, or one or more dashes. A name component may not start or end with a separator.

イメージ名は、構成名をスラッシュ記号で区切る構成です。オプションで先頭にレジストリのホスト名を追加します。ホスト名は標準 DNS ルールに完全に従う必要がありますが、アンダースコア記号は使えません。ホスト名を使う場合は、オプションでポート番号を ``:8000`` の形式で指定できます。ホストの指定が無ければ、デフォルトで Docker の公開レジストリのある ``registry-1.docker.io`` を使います。構成名は（アルファベット）小文字、数字、セパレータ（分離記号）を含みます。セパレータの定義はピリオド、１つか２つのアンダースコア、複数のダッシュです。セパレータは、コンポーネント名の始めと終わりで使えません。

.. A tag name may contain lowercase and uppercase characters, digits, underscores, periods and dashes. A tag name may not start with a period or a dash and may contain a maximum of 128 characters.

タグ名に含まれるのは（アルファベット）小文字と大文字、数字、アンダースコア、ピリオド、スラッシュです。タグ名はピリオドやダッシュで開始できません。そして最大で 128 文字です。

.. You can group your images together using names and tags, and then upload them to Share Images via Repositories.

自分自身でイメージを名前とタグでグループ化し、 アップロード後は :ref:`リポジトリを通したイメージを共有 <contributing-to-docker-hub>` できます。

.. Examples

例
==========

.. Tagging an image referenced by ID

ID を参照してイメージをタグ付け
----------------------------------------

.. To tag a local image with ID "0e5574283393" into the "fedora" repository with "version1.0":

ローカルにある ID 「0e5574283393」イメージを、「fedora」リポジトリの「version 1.0」とタグ付けします。

.. code-block:: bash

   docker tag 0e5574283393 fedora/httpd:version1.0

.. Tagging an image referenced by Name

名前を参照してイメージをタグ付け
----------------------------------------

.. To tag a local image with name "httpd" into the "fedora" repository with "version1.0":

ローカルにある名前が 「httpd」のイメージを、「fedora」リポジトリの「version 1.0」とタグ付けします。

.. code-block:: bash

   docker tag httpd fedora/httpd:version1.0

.. Note that since the tag name is not specified, the alias is created for an existing local version httpd:latest.

タグ名を指定しなければ、既存のローカル・バージョンのエイリアス ``httpd:latest`` が作成されるのでご注意ください。

.. Tagging an image referenced by Name and Tag

名前とタグを参照してイメージをタグ付け
----------------------------------------

.. To tag a local image with name "httpd" and tag "test" into the "fedora" repository with "version1.0.test":

ローカルにある名前が 「httpd」でタグが「test」イメージを、「fedora」リポジトリの「version 1.0.test」とタグ付けします。

.. code-block:: bash

   docker tag httpd:test fedora/httpd:version1.0.test

.. Tagging an image for a private repository

プライベート・リポジトリにイメージをタグ付け
--------------------------------------------------

.. To push an image to a private registry and not the central Docker registry you must tag it with the registry hostname and port (if needed).

Docker Hub ではなくプライベート・レジストリにイメージを送信するには、レジストリのホスト名とポート（必要があれば）でのタグ付けが必要です。

.. code-block:: bash

   docker tag 0e5574283393 myregistryhost:5000/fedora/httpd:version1.0


.. seealso:: 

   tag
      https://docs.docker.com/engine/reference/commandline/tag/
