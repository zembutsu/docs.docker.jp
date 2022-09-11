.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/tag/
.. SOURCE:
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/tag.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_tag.yaml
.. check date: 2022/03/27
.. Commits on Aug 22, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker tag

=======================================
docker tag
=======================================

.. _docker_tag-description:

説明
==========

.. Create a tag TARGET_IMAGE that refers to SOURCE_IMAGE

:ruby:`対象イメージ <TARGET_IMAGE>` に :ruby:`元イメージ <SOURCE_IMAGE>` を参照する :ruby:`タグ <tag>` を作成します。

.. _docker_tag-usage:

使い方
==========

.. code-block:: bash

   $ docker tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]

.. Extended description
.. _docker_tag-extended-description:

補足説明
==========

.. An image name is made up of slash-separated name components, optionally prefixed by a registry hostname. The hostname must comply with standard DNS rules, but may not contain underscores. If a hostname is present, it may optionally be followed by a port number in the format :8080. If not present, the command uses Docker's public registry located at registry-1.docker.io by default. Name components may contain lowercase characters, digits and separators. A separator is defined as a period, one or two underscores, or one or more dashes. A name component may not start or end with a separator.

イメージ名は、構成名をスラッシュ記号で区切る構成です。オプションで先頭にレジストリのホスト名を追加します。ホスト名は標準 DNS ルールに完全に従う必要がありますが、アンダースコア記号は使えません。ホスト名を使う場合は、オプションでポート番号を ``:8000`` の形式で指定できます。ホストの指定が無ければ、デフォルトで Docker の公開レジストリのある ``registry-1.docker.io`` を使います。構成名は（アルファベット）小文字、数字、セパレータ（分離記号）を含みます。セパレータの定義はピリオド、１つか２つのアンダースコア、複数のダッシュです。セパレータは、コンポーネント名の始めと終わりで使えません。

.. A tag name must be valid ASCII and may contain lowercase and uppercase letters, digits, underscores, periods and dashes. A tag name may not start with a period or a dash and may contain a maximum of 128 characters.

タグ名に含められるのは有効な ASCII 文字で、（アルファベット）小文字と大文字、数字、アンダースコア、ピリオド、ダッシュです。タグ名はピリオドやダッシュで開始できません。そして最大で 128 文字です。

.. You can group your images together using names and tags, and then upload them to Share Images via Repositories.

自分自身でイメージを名前とタグでグループ化し、 アップロード後は :ref:`リポジトリを通したイメージを共有 <contributing-to-docker-hub>` できます。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <docker_tag-examples>` をご覧ください。

.. Examples
.. _docker_stop-examples:

使用例
==========

.. Tagging an image referenced by ID
.. _docker_tag-tagging-an-image-referenced-by-id:

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


親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI の基本コマンド

.. seealso:: 

   docker tag
      https://docs.docker.com/engine/reference/commandline/tag/
