.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/volume_inspect/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/volume_inspect.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_volume_inspect.yaml
.. check date: 2022/04/05
.. Commits on Oct 7, 2021 ed135fe151ad43ca1093074c8fbf52243402013a
.. -------------------------------------------------------------------

.. docker volume inspect

=======================================
docker volume inspect
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _volume_inspect-description:

説明
==========

.. Display detailed information on one or more volumes

1つまたは複数ボリュームの詳細情報を表示します。

.. API 1.21+
   Open the 1.21 API reference (in a new window)
   The client and daemon API must both be at least 1.25 to use this command. Use the docker version command on the client to check your client and daemon API versions.

【API 1.21+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.25 <https://docs.docker.com/engine/api/v1.21/>`_ の必要があります。クライアントとデーモン API のバージョンを調べるには、 ``docker version`` コマンドを使います。


.. _volume_inspect-usage:

使い方
==========

.. code-block:: bash

   $ docker volume inspect [OPTIONS] VOLUME [VOLUME...]

.. Extended description
.. _volume_inspect-extended-description:

補足説明
==========

.. Returns information about a volume. By default, this command renders all results in a JSON array. You can specify an alternate format to execute a given template for each result. Go’s text/template package describes all the details of the format.

ボリュームに関する情報を返します。デフォルトでは、コマンドは JSON 配列の形式です。実行テンプレートを個々に指定し、別のフォーマットを指定できます。Go 言語の `text/template <http://golang.org/pkg/text/template/>`_ パッケージに、フォーマットの詳細に関する全てが記述されています。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <volume_inspect-examples>` をご覧ください。

.. _volume_inspect-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--format`` , ``-f``
     - 
     - 指定した Go テンプレートを使って出力を整形


.. Examples
.. _volume_inspect-examples:

使用例
==========

.. code-block:: bash

   $ docker volume create myvolume
   
   myvolume


.. The output is in JSON format, for example:

次の例は、 JSON 形式の出力です。

.. code-block:: json

   [
     {
       "CreatedAt": "2020-04-19T11:00:21Z",
       "Driver": "local",
       "Labels": {},
       "Mountpoint": "/var/lib/docker/volumes/8140a838303144125b4f54653b47ede0486282c623c3551fbc7f390cdc3e9cf5/_data",
       "Name": "myvolume",
       "Options": {},
       "Scope": "local"
     }
   ]

.. Use the --format flag to format the output using a Go template, for example, to print the Mountpoint property:

``--format`` フラグを使うと、 Go テンプレートを使ってアウトプットを整形します。たとえば、 ``Mountpoint`` プロパティを表示します。

.. code-block:: bash

   $ docker volume inspect --format '{{ .Mountpoint }}' myvolume
   
   /var/lib/docker/volumes/myvolume/_data


.. Parent command

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <volume>`
     - ボリュームを管理


.. Related commands

関連コマンド
====================

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker volume create<volume_create>`
     - ボリュームの作成
   * - :doc:`docker volume inspect<volume_inspect>`
     - 1つまたは複数ボリュームの詳細情報を表示
   * - :doc:`docker volume ls<volume_ls>`
     - ボリューム一覧表示
   * - :doc:`docker volume prune<volume_prune>`
     - 使用していないローカルボリュームを削除
   * - :doc:`docker volume rm<volume_rm>`
     - 1つまたは複数ボリュームを削除


.. seealso:: 

   docker volume inspect
      https://docs.docker.com/engine/reference/commandline/volume_inspect/
