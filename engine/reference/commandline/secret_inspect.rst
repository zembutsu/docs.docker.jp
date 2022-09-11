.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/secret_inspect/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/secret_inspect.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_secret_inspect.yaml
.. check date: 2022/04/02
.. Commits on Oct 7, 2021 ed135fe151ad43ca1093074c8fbf52243402013a
.. -------------------------------------------------------------------

.. docker secret inspect

=======================================
docker secret inspect
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _secret_inspect-description:

説明
==========

.. Display detailed information on one or more secrets

1つまたは複数シークレットの詳細情報を表示します。

.. API 1.25+
   Open the 1.25 API reference (in a new window)
   The client and daemon API must both be at least 1.25 to use this command. Use the docker version command on the client to check your client and daemon API versions.
   Swarm This command works with the Swarm orchestrator.


- 【API 1.25+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.25 <https://docs.docker.com/engine/api/v1.25/>`_ の必要があります。クライアントとデーモン API のバージョンを調べるには、 ``docker version`` コマンドを使います。
- 【Swarm】このコマンドは Swarm オーケストレータと動作します。


.. _secret_inspect-usage:

使い方
==========

.. code-block:: bash

   $ docker secret inspect [OPTIONS] SECRET [SECRET...]

.. Extended description
.. _secret_inspect-extended-description:

補足説明
==========

.. Inspects the specified secret.

指定したシークレットを調べます。

.. By default, this renders all results in a JSON array. If a format is specified, the given template will be executed for each result.

デフォルトでは、JSON アレイ形式で結果を表示します。フォーマットを指定すると、指定のテンプレートでそれぞれの結果を表示します。

.. Go’s text/template package describes all the details of the format.

Go 言語の `text/template <https://golang.org/pkg/text/template/>`_ パッケージに、フォーマットの詳細全てがあります。

.. For detailed information about using configs, refer to store configuration data using Docker Configs.

設定を使うための詳細情報は、 :doc:`Docker Config を使って設定データを保管 </engine/swarm/configs>` を参照ください。

..    Note
    This is a cluster management command, and must be executed on a swarm manager node. To learn about managers and workers, refer to the Swarm mode section in the documentation.

.. note::

   これはクラスタ管理コマンドであり、 swarm manager ノードで実行する必要があります。manager と worker について学ぶには、ドキュメント内の :doc:`Swarm モードのセクション </engine/swarm/index>` を参照ください。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <secret_inspect-examples>` をご覧ください。


.. _secret_inspect-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--format`` , ``-f``
     - 
     - 指定した Go テンプレートで出力
   * - ``--pretty``
     - 
     - 人間が見やすい形式で情報を表示


.. _secret_inspect-examples:

使用例
==========

.. Inspect a secret by name or ID
.. _inspect-a-secret-by-name-or-id:

名前か ID でシークレットを調査
------------------------------

.. You can inspect a secret, either by its name, or ID

シークレットを名前もしくは ID のどちらかで調べられます。

.. For example, given the following config:

例えば、次のようなシークレットがあるとします。

.. code-block:: bash

   $ docker secret ls
   
   ID                          NAME                CREATED             UPDATED
   eo7jnzguqgtpdah3cm5srfb97   my_secret           3 minutes ago       3 minutes ago

.. code-block:: bash

   $ docker secret inspect secret.json

.. The output is in JSON format, for example:

出力は、以下のような JSON 形式です。

.. code-block:: json

  [
     {
       "ID": "eo7jnzguqgtpdah3cm5srfb97",
       "Version": {
         "Index": 17
       },
       "CreatedAt": "2017-03-24T08:15:09.735271783Z",
       "UpdatedAt": "2017-03-24T08:15:09.735271783Z",
       "Spec": {
         "Name": "my_secret",
         "Labels": {
           "env": "dev",
           "rev": "20170324"
         }
       }
     }
   ]


.. Formatting
.. _secret_inspect-formatting:

書式
==========

.. You can use the --format option to obtain specific information about a secret. The following example command outputs the creation time of the secret.

--format オプションを使い、特定のシークレットを取得できます。以下のコマンド例は、シークレットを作成した時間の情報を出力します。

.. code-block:: bash

   $ docker secret inspect --format='{{.CreatedAt}}' eo7jnzguqgtpdah3cm5srfb97
   
   2017-03-24 08:15:09.735271783 +0000 UTC



.. Parent command

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker secret <secret>`
     - Docker シークレットを管理


.. Related commands

関連コマンド
====================

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker secret create<secret_create>`
     - ファイルもしくは STDIN（標準入力）を内容としてシークレットを作成
   * - :doc:`docker secret inspect<secret_inspect>`
     - 1つまたは複数シークレットの詳細情報を表示
   * - :doc:`docker secret ls<secret_ls>`
     - シークレット一覧
   * - :doc:`docker secret rm<secret_rm>`
     - 1つまたは複数のシークレットを削除


.. seealso:: 

   docker secret inspect
      https://docs.docker.com/engine/reference/commandline/secret_inspect/
