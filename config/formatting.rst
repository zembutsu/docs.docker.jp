.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/config/formatting/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/config/formatting.md
   doc version: 19.03
.. check date: 2020/06/21
.. Commits on Apr 13, 2020 7f66d7783f886cf4aa50c81b9f85869b7ebf6874
.. ---------------------------------------------------------------------------

.. Format command and log output

.. _format-command-and-log-output:

============================================================
format コマンドとログ出力
============================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Docker uses Go templates which you can use to manipulate the output format of certain commands and log drivers.

Docker は `Go テンプレート <https://golang.org/pkg/text/template/>`_ を使い、様々なコマンドやログ・ドライバの出力を操作できます。

.. Docker provides a set of basic functions to manipulate template elements. All of these examples use the docker inspect command, but many other CLI commands have a --format flag, and many of the CLI command references include examples of customizing the output format.

Docker は基本的な機能群として、操作可能なテンプレートを提供します。以下の例ではすべて ``docker inspect`` コマンドを使っていますが、他の CLI コマンドも ``--format`` フラグを持ち、多くの CLI コマンドリファレンス中でも、出力形式をカスタマイスする例があります。

.. Join

Join
==========

.. join concatenates a list of strings to create a single string. It puts a separator between each element in the list.

``join`` 連結子は１行の中で要素を一覧表示します。セパレータはリスト中の各要素を分割します。

::

   docker inspect --format '{{join .Args " , "}}' container


table
==========

.. table specifies which fields you want to see its output.

``table`` は、どのフィールドを表示したいか指定します。

::

   docker image list --format "table {{.ID}}\t{{.Repository}}\t{{.Tag}}\t{{.Size}}"


json
==========

.. json encodes an element as a json string.

``json`` は要素を JSON 文字列としてエンコードします。

::

   docker inspect --format '{{json .Mounts}}' container

Lower
==========

.. Lower turns a string into its lower case representation.

``lower`` は文字列を小文字に変換して表示します。

::

   docker inspect --format "{{lower .Name}}" container

split
==========

.. `plit slices a string into a list of strings separated by a separator.

``split`` は文字列をセパレータの文字列で分割して表示します。

::

   docker inspect --format '{{split .Image ":"}}'

title
==========

.. title capitalizes the first character of a string.

``title`` は行の初めの文字列を大文字に変化して表示します。

::

   docker inspect --format "{{title .Name}}" container


upper
==========

.. upper transforms a string into its uppercase representation.

``upper``  は文字列をすべて大文字に変換して表示します。

::

   docker inspect --format "{{upper .Name}}" container


println
==========

.. println prints each value on a new line.

``println`` は各値を新しい列に表示します。

::

   docker inspect --format='{{range .NetworkSettings.Networks}}{{println .IPAddress}}{{end}}' container

.. To find out what data can be printed, show all content as json:

.. hint::

   どのようなデータを表示可能かどうか調べるためには、全ての内容を json として表示します。

   ::
   
      docker container ls --format='{{json .}}'



.. seealso:: 
   Format command and log output
      https://docs.docker.com/config/formatting/
