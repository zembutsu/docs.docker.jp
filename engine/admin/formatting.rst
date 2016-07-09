.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/admin/formatting/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/admin/formatting.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/admin/formatting.md
.. check date: 2016/07/09
.. Commits on Jun 22, 2016 01f9cbc3663cf134ca427e4f8b98bba637f6655e
.. ---------------------------------------------------------------------------

.. Formatting reference

.. _formatting-reference:

============================================================
フォーマット・リファレンス
============================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Docker uses Go templates to allow users manipulate the output format of certain commands and log drivers. Each command a driver provides a detailed list of elements they support in their templates:

Docker は `Go テンプレート <https://golang.org/pkg/text/template/>`_ を使い、様々なコマンドやログ・ドライバの出力を操作できます。各コマンドはテンプレートを使って要素の詳細を表示できます。

..    Docker Images formatting
    Docker Inspect formatting
    Docker Log Tag formatting
    Docker Network Inspect formatting
    Docker PS formatting
    Docker Volume Inspect formatting
    Docker Version formatting

* :ref:`docker images の形式 <images-formatting>`
* :ref:`docker inspect の形式 <inspect-examples>`
* :doc:`docker log タグの形式 </engine/admin/logging/log_tags>`
* :doc:`docker network inspect の形式 </engine/reference/commandline/network_inspect>`
* :ref:`docker ps の形式 <ps-formatting>`
* :doc:`docker volume inspect の形式 </engine/reference/commandline/network_inspect>`
* :ref:`docker version の形式 <version-examples>`

.. Template functions

.. _template-functions:

テンプレート関数
====================

.. Docker provides a set of basic functions to manipulate template elements. This is the complete list of the available functions with examples:

Docker はテンプレート要素を操作する基本的な関数セットを提供しています。以下は利用可能な関数のと例の一覧です。

.. Join

Join
----------

.. Join concatenates a list of strings to create a single string. It puts a separator between each element in the list.

Join 連結子は１行の中で要素を一覧表示します。セパレータはリスト中の各要素を分割します。

.. code-block:: bash

   $ docker ps --format '{{join .Names " or "}}'

.. Json

Json
----------

.. Json encodes an element as a json string.

Json は要素を JSON 文字列としてエンコードします。

.. code-block:: bash

   $ docker inspect --format '{{json .Mounts}}' container

.. Lower

Lower
----------

.. Lower turns a string into its lower case representation.

Lower は文字列を小文字で返します。

.. code-block:: bash

   $ docker inspect --format "{{lower .Name}}" container

.. Split

Split
----------

.. Split slices a string into a list of strings separated by a separator.

文字列をセパレータの文字列で分割して表示します。

.. code-block:: bash

   # docker inspect --format '{{split (join .Names "/") "/"}}' container

Title
----------

.. Title capitalizes a string.

文字列を大文字で始めます。

.. code-block:: bash

   $ docker inspect --format "{{title .Name}}" container

Upper
----------

.. Upper turms a string into its upper case representation.

文字列をすべて大文字にします。

.. code-block:: bash

   $ docker inspect --format "{{upper .Name}}" container

.. seealso:: 
   Formatting reference
      https://docs.docker.com/engine/admin/formatting/
