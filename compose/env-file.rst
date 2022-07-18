.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/env-file/
.. SOURCE: 
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/env-file.md
   doc version: v20.10
      https://github.com/docker/docker.github.io/blob/master/compose/env-file.md
.. check date: 2022/07/17
.. Commits on Jun 3, 2022 d49af6a4495f653ffa40292fd24972b2df5ac0bc
.. ----------------------------------------------------------------------------

.. Declare default environment variables in file
.. _declare-default-environment-variables-in-file:

=====================================================
ファイルでデフォルトの環境変数を設定
=====================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Compose supports declaring default environment variables in an environment file named .env placed in the project directory. Docker Compose versions earlier than 1.28, load the .env file from the current working directory, where the command is executed, or from the project directory if this is explicitly set with the --project-directory option. This inconsistency has been addressed starting with +v1.28 by limiting the default .env file path to the project directory. You can use the --env-file commandline option to override the default .env and specify the path to a custom environment file.

Compose はプロジェクトのディレクトリ内にある ``.env`` という名前の :ruby:`環境ファイル <environment file>` 内で、デフォルトの環境変数の設定をサポートします。 Docker Compose バージョン ``1.28`` 未満では、コマンドを実行する現在の作業ディレクトリ内にある ``.env`` ファイルを読み込みます。または、 ``--project-directory`` オプションを明示する場合は、プロジェクトのディレクトリにあるファイルを読み込みます。この矛盾を解消するため、 ``v1.28`` 以上からは、プロジェクトのディレクトリにあるデフォルトの ``.env`` のみに制限しています。 ``--env-file`` コマンドライン オプションを使えば、デフォルトの ``.env`` を上書きでき、さらに任意の環境ファイルのパスを指定できます。

.. The project directory is specified by the order of precedence:

プロジェクト ディレクトリは優先順位によって決まります

..  --project-directory flag
    Folder of the first --file flag
    Current directory

* ``--project-directory`` フラグ
* １つめの ``--file`` フラグがあるフォルダ
* 現在のディレクトリ

.. Syntax rules
.. _compose-env-file-syntax-rules:
構文ルール
==========

.. The following syntax rules apply to the .env file:

``.env`` ファイルは、以下の構文ルールを適用します。

..  Compose expects each line in an env file to be in VAR=VAL format.
    Lines beginning with # are processed as comments and ignored.
    Blank lines are ignored.
    There is no special handling of quotation marks. This means that they are part of the VAL.

* Compose は ``env`` ファイルの各行を ``変数=値`` 形式と想定
* ``#`` で始まる行はコメントとみなし、無視する
* 空白行を無視する
* 引用記号には特別な処理を行わない。つまり **引用記号は値の一部** とみなす

.. Compose file and CLI variables
.. _compose-file-and-cli-variables:
Compose ファイルと CLI 変数
==============================

.. The environment variables you define here are used for variable substitution in your Compose file, and can also be used to define the following CLI variables:

このファイルで定義した環境変数は、 Compose ファイル内で :ref:`変数展開 <compose-file-v3-variable-substitution>` されます。また、以下の :doc:`CLI 変数` の定義も使えます。

* ``COMPOSE_API_VERSION``
* ``COMPOSE_CONVERT_WINDOWS_PATHS``
* ``COMPOSE_FILE``
* ``COMPOSE_HTTP_TIMEOUT``
* ``COMPOSE_PROFILES``
* ``COMPOSE_PROJECT_NAME``
* ``COMPOSE_TLS_VERSION``
* ``DOCKER_CERT_PATH``
* ``DOCKER_HOST``
* ``DOCKER_TLS_VERIFY

..  Notes
        Values present in the environment at runtime always override those defined inside the .env file. Similarly, values passed via command-line arguments take precedence as well.
        Environment variables defined in the .env file are not automatically visible inside containers. To set container-applicable environment variables, follow the guidelines in the topic Environment variables in Compose, which describes how to pass shell environment variables through to containers, define environment variables in Compose files, and more.

.. note::

   * ``.env`` ファイル内で定義された環境変数の値は、実行時に常に上書きされます。同様に、コマンドラインの引数で渡された値も優先されます（上書きされます）。
   * ``.env`` ファイル内で定義された環境変数は、コンテナ内から自動的に見えません。コンテナ内で利用できる環境変数を指定するには、 :doc:`Compose での環境変数 <environement-variables>` のトピックにあるガイドラインをご覧ください。こちらには、シェル上の環境変数をコンテナ内に渡す方法や、 Compose ファイルでの環境変数の定義方法などの説明があります。


.. More Compose documentation
ほかの Compose ドキュメント
==============================

..  User guide
    Installing Compose
    Getting Started
    Command line reference
    Compose file reference
    Sample apps with Compose

* :doc:`ユーザガイド <index>`
* :doc:`Compose のインストール <install>`
* :doc:`始めましょう <gettingstarted>`
* :doc:`コマンドライン リファレンス <reference/index>`
* :doc:`Compose ファイル リファレンス <compose-file>`
* :doc:`Compose のサンプルアプリ <samples-for-compose>`


.. seealso:: 

   Declare default environment variables in file | Docker Documentation
      https://docs.docker.com/compose/env-file/

