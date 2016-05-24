.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/link-env-deprecated/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/link-env-deprecated.md
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/link-env-deprecated.md
.. check date: 2016/04/28
.. Commits on Feb 3, 2016 cf24c36c5549a2a87952da27c6e3d35974687e1c
.. ----------------------------------------------------------------------------

.. Link environment variables reference:

.. _link-environment-variables-reference:

=======================================
リンク環境変数リファレンス
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Note: Environment variables are no longer the recommended method for connecting to linked services. Instead, you should use the link name (by default, the name of the linked service) as the hostname to connect to. See the docker-compose.yml documentation for details.

.. note::

   サービスをリンクで接続する手法としては、環境変数の使用は推奨されなくなりました。そのかわりに、接続するホスト名として、名前を使ったリンクが可能です（デフォルトではサービスの名前でリンクします）。詳細は :ref:`docker-compose.yml ドキュメント <compose-file-links>` をご覧ください。

.. Environment variables will only be populated if you’re using the legacy version 1 Compose file format.

.. note::

   環境変数を（Composeで自動的に扱えるように）は、 :ref:`過去の Compose ファイル形式バージョン１ <compose-file-version-1>` を使う場合のみです。

.. Compose uses Docker links to expose services’ containers to one another. Each linked container injects a set of environment variables, each of which begins with the uppercase name of the container.

Compose はサービスのコンテナを他に公開するために、 :doc:`Docker リンク機能 </engine/userguide/networking/default_network/dockerlinks>` を使います。リンクされた各コンテナは環境変数のセットを持ます。環境変数は各コンテナ名を大文字にしたもので始まります。

.. To see what environment variables are available to a service, run docker-compose run SERVICE env.

どのような環境変数が設定されているかを確認するには、 ``docker-compose run サービス名 env`` を実行します。

**name_PORT**

.. Full URL, e.g. DB_PORT=tcp://172.17.0.5:5432

全ての URL です。例： ``DB_PORT=tcp://172.17.0.5:5432``

**name_PORT_num_protocol**

.. Full URL, e.g. DB_PORT_5432_TCP=tcp://172.17.0.5:5432

全ての URL です。例： ``DB_PORT_5432_TCP=tcp://172.17.0.5:5432``

**name_PORT_num_protocol_ADDR**

.. Container’s IP address, e.g. DB_PORT_5432_TCP_ADDR=172.17.0.5

コンテナの IP アドレスです。例： ``DB_PORT_5432_TCP_ADDR=172.17.0.5``

**name_PORT_num_protocol_PORT**

.. Exposed port number, e.g. DB_PORT_5432_TCP_PORT=5432

公開するポート番号です。例： ``DB_PORT_5432_TCP_PORT=5432``

**name_PORT_num_protocol_PROTO**

.. Protocol (tcp or udp), e.g. DB_PORT_5432_TCP_PROTO=tcp

プロトコル（tcp か udp ）を指定します。例： ``DB_PORT_5432_TCP_PROTO=tcp``

**name_NAME**

.. Fully qualified container name, e.g. DB_1_NAME=/myapp_web_1/myapp_db_1

コンテナの完全修飾名（fully qualified container name）を指定します。例： ``DB_1_NAME=/myapp_web_1/myapp_db_1``

.. Related Information

関連情報
==========

..    User guide
    Installing Compose
    Command line reference
    Compose file reference

* :doc:`/compose/index`
* :doc:`/compose/install`
* :doc:`/compose/reference/index`
* :doc:`/compose/compose-file`

.. seealso:: 

   Link environment variables reference
      https://docs.docker.com/compose/link-env-deprecated/

