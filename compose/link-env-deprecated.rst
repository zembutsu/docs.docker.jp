.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/link-env-deprecated/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/link-env-deprecated.md
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/link-env-deprecated.md
.. check date: 2016/04/28
.. Commits on Feb 3, 2016 cf24c36c5549a2a87952da27c6e3d35974687e1c
.. ----------------------------------------------------------------------------

.. title: Link environment variables (superseded)

.. _link-environment-variables-superseded:

=======================================
リンク時の環境変数（機能修正）
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. > **Note**: Environment variables are no longer the recommended method for connecting to linked services. Instead, you should use the link name (by default, the name of the linked service) as the hostname to connect to. See the [docker-compose.yml documentation](compose-file.md#links) for details.
   >
   > Environment variables will only be populated if you're using the [legacy version 1 Compose file format](compose-file.md#versioning).

.. note::

   リンクされているサービスに接続する方法として、環境変数を用いることは推奨されなくなりました。
   その代わりに、接続するホスト名としてリンク名（デフォルトはリンクされているサービス名）を用いてください。
   詳しくは :doc:`docker-compose.yml ドキュメント <compose-file-links>` を参照してください。
   
   環境変数は :ref:`かつての Compose ファイルフォーマットバージョン 1 <compose-file-versioning>` においてのみ定義されます。

.. Compose uses [Docker links](/engine/userguide/networking/default_network/dockerlinks.md)
   to expose services' containers to one another. Each linked container injects a set of
   environment variables, each of which begins with the uppercase name of the container.

Compose は :doc:`Docker links </engine/userguide/networking/default_network/dockerlinks>` を利用して、サービスのコンテナをその他のコンテナに対して情報を公開します。
リンクされたコンテナは複数の環境変数を提供します。
各環境変数は、コンテナ名を大文字にしたものが先頭につきます。

.. To see what environment variables are available to a service, run `docker-compose run SERVICE env`.

サービスにおいて利用可能な環境変数を見るには、``docker-compose run SERVICE env`` を実行します。

.. <b><i>name</i>\_PORT</b><br>
   Full URL, e.g. `DB_PORT=tcp://172.17.0.5:5432`

.. raw:: html

   <b><i>name</i>_PORT</b>

完全な  URL。
たとえば ``DB_PORT=tcp://172.17.0.5:5432``

.. <b><i>name</i>\_PORT\_<i>num</i>\_<i>protocol</i></b><br>
   Full URL, e.g. `DB_PORT_5432_TCP=tcp://172.17.0.5:5432`

.. raw:: html

   <b><i>name</i>_PORT_<i>num</i>_<i>protocol</i></b>

完全な  URL。
たとえば ``DB_PORT_5432_TCP=tcp://172.17.0.5:5432``

.. <b><i>name</i>\_PORT\_<i>num</i>\_<i>protocol</i>\_ADDR</b><br>
   Container's IP address, e.g. `DB_PORT_5432_TCP_ADDR=172.17.0.5`

.. raw:: html

   <b><i>name</i>_PORT_<i>num</i>_<i>protocol</i>_ADDR</b>

コンテナーの IP アドレス。
たとえば ``DB_PORT_5432_TCP_ADDR=172.17.0.5``

.. <b><i>name</i>\_PORT\_<i>num</i>\_<i>protocol</i>\_PORT</b><br>
   Exposed port number, e.g. `DB_PORT_5432_TCP_PORT=5432`

.. raw:: html

   <b><i>name</i>_PORT_<i>num</i>_<i>protocol</i>_PORT</b>

公開されているポート番号。
たとえば ``DB_PORT_5432_TCP_PORT=5432``

.. <b><i>name</i>\_PORT\_<i>num</i>\_<i>protocol</i>\_PROTO</b><br>
   Protocol (tcp or udp), e.g. `DB_PORT_5432_TCP_PROTO=tcp`

.. raw:: html

   <b><i>name</i>_PORT_<i>num</i>_<i>protocol</i>_PROTO</b>

プロトコル（tcp または udp）。
たとえば ``DB_PORT_5432_TCP_PROTO=tcp``

.. <b><i>name</i>\_NAME</b><br>
   Fully qualified container name, e.g. `DB_1_NAME=/myapp_web_1/myapp_db_1`

.. raw:: html

   <b><i>name</i>_NAME</b>

完全修飾コンテナ名。
たとえば ``DB_1_NAME=/myapp_web_1/myapp_db_1``

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

   Link environment variables (superseded)
      https://docs.docker.com/compose/link-env-deprecated/

