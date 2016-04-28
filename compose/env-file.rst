.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/env-file/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/env-file.md
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/env-file.md
.. check date: 2016/04/28
.. Commits on Mar 25, 2016 b99037b4a61e10c9377dd707e35860cec298a268
.. ----------------------------------------------------------------------------

.. Environment file

.. _environment-file:

=====================================================
環境ファイル
=====================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Compose supports declaring default environment variables in an environment file named .env and placed in the same folder as your compose file.

Compose はファイル名 ``.env`` という環境ファイルを通して、デフォルトの環境変数を定義できます。このファイルは :doc:`compose ファイル <compose-file>` と同じディレクトリに置きます。

.. Compose expects each line in an env file to be in VAR=VAL format. Lines beginning with # (i.e. comments) are ignored, as are blank lines.

Compose は環境ファイルの各行を ``変数=値`` 形式とみなします。 ``#`` で始まる行（例：コメント）は無視し、空白行として扱います。

..     Note: Values present in the environment at runtime will always override those defined inside the .env file. Similarly, values passed via command-line arguments take precedence as well.

.. note::

   実行時に環境変数を指定すると、常に ``.env`` ファイル中で定義した変数を上書きします。同様にコマンドラインの引数で値を指定した場合も、指定した値を優先します。

.. Those environment variables will be used for variable substitution in your Compose file, but can also be used to define the following CLI variables:

これらの環境変数は Compose ファイル内で :ref:`変数展開 <compose-file-variable-substitution>` のために使いますが、以下のように :doc:`CLI 変数 </compose/reference/envvars>` 用にも使えます。

* ``COMPOSE_API_VERSION``
* ``COMPOSE_FILE``
* ``COMPOSE_HTTP_TIMEOUT``
* ``COMPOSE_PROJECT_NAME``
* ``DOCKER_CERT_PATH``
* ``DOCKER_HOST``
* ``DOCKER_TLS_VERIFY``

.. More Compose documentation

他の Compose ドキュメント
==============================

* :doc:`/compose/index`
* :doc:`/compose/reference/index`
* :doc:`/compose/compose-file`


.. seealso:: 

   Environment file
      https://docs.docker.com/compose/env-file/

