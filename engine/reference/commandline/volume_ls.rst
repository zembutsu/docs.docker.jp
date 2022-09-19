.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/volume_ls/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/volume_ls.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_volume_ls.yaml
.. check date: 2022/04/05
.. Commits on Apr 2, 2022 098129a0c12e3a79398b307b38a67198bd3b66fc
.. -------------------------------------------------------------------

.. docker volume ls

=======================================
docker volume ls
=======================================


.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _volume_ls-description:

説明
==========

.. List volumes

ボリュームを一覧表示します。

.. API 1.21+
   Open the 1.21 API reference (in a new window)
   The client and daemon API must both be at least 1.25 to use this command. Use the docker version command on the client to check your client and daemon API versions.

【API 1.21+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.25 <https://docs.docker.com/engine/api/v1.21/>`_ の必要があります。クライアントとデーモン API のバージョンを調べるには、 ``docker version`` コマンドを使います。


.. _volume_ls-usage:

使い方
==========

.. code-block:: bash

   $ docker volume ls [OPTIONS]

.. Extended description
.. _volume_ls-extended-description:

補足説明
==========

.. List all the volumes known to Docker. You can filter using the -f or --filter flag. Refer to the filtering section for more information about available filter options.


Docker が把握している全てのボリュームを表示します。 ``-f`` か ``--filter`` フラグを使ってフィルタできます。利用可能なフィルタ・オプションに関する情報は :ref:`volume_ls-filtering` のセクションをご覧ください。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <volume_ls-examples>` をご覧ください。

.. _volume_ls-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--filter`` , ``-f``
     - 
     - フィルタ値を指定（例 ``dangling=true`` ）
   * - ``--format``
     - 
     - Go テンプレートを使ってボリュームを整形して表示
   * - ``--quiet`` , ``-q``
     - 
     - ボリューム名のみ表示

.. Examples
.. _volume_ls-examples:

使用例
==========

.. Create a volume
.. _volume_ls-create-a-volume:
ボリューム作成
--------------------

.. code-block:: bash

   $ docker volume create rosemary
   
   rosemary
   
   $ docker volume create tyler
   
   tyler
   
   $ docker volume ls
   
   DRIVER              VOLUME NAME
   local               rosemary
   local               tyler


.. Filtering
.. _volume_ls-filtering:

フィルタリング
====================

.. The filtering flag (-f or --filter) format is of "key=value". If there is more than one filter, then pass multiple flags (e.g., --filter "foo=bar" --filter "bif=baz")

フィルタリング・フラグ（ ``-f`` か ``--filter`` ）は「key=value」の形式です。フィルタが複数ある場合は、複数回指定します（例： ``--filter "foo=bar" --filter "bif=baz"`` ）。

.. The currently supported filters are:

現時点でサポートしているフィルタ：

..    dangling (boolean - true or false, 0 or 1)
    driver (a volume driver's name)
    name (a volume's name)

* dangling（ブール値 - true か false か 0 か 1 ）
* driver（ボリュームのドライバ名）
* label （ ``label=<key>`` か ``label=<key>=<value>`` ）
* 名前（ボリューム名）

.. dangling
.. _docker_ls-dangling:
dangling
^^^^^^^^^^

.. The dangling filter matches on all volumes not referenced by any containers

``dangling`` フィルタはコンテナから参照されていない（dangling＝宙ぶらりんな）ボリュームに一致します。

.. code-block:: bash

   $ docker run -d  -v tyler:/tmpwork  busybox
   
   f86a7dd02898067079c99ceacd810149060a70528eff3754d0b0f1a93bd0af18
   $ docker volume ls -f dangling=true
   DRIVER              VOLUME NAME
   local               rosemary

.. driver
.. _docker_ls-driver:
driver
^^^^^^^^^^

.. The driver filter matches on all or part of a volume's driver name.

``driver`` フィルタはボリュームのドライバ名の全てまたは一部に一致します。

.. The following filter matches all volumes with a driver name containing the local string.

以下のフィルタはドライバ名に ``local`` 文字列を含む全てのボリュームを表示します。

.. code-block:: bash

   $ docker volume ls -f driver=local
   
   DRIVER              VOLUME NAME
   local               rosemary
   local               tyler


.. label
.. _volume_ls-label:
label
^^^^^^^^^

.. The label filter matches volumes based on the presence of a label alone or a label and a value.

``label`` フィルタは、 ``label`` 単体か ``label`` と値の存在に基づくボリュームに一致します。

.. First, let’s create some volumes to illustrate this;

これを説明するためには、まず、いくつかのボリュームを作成しましょう。

.. code-block:: bash

   $ docker volume create the-doctor --label is-timelord=yes
   
   the-doctor
   $ docker volume create daleks --label is-timelord=no
   
   daleks

.. The following example filter matches volumes with the is-timelord label regardless of its value.

以下のフィルタ例は、値が何であろうとも ``is-timelord`` ラベルを持つボリュームに一致します。

.. code-block:: bash

   $ docker volume ls --filter label=is-timelord
   
   DRIVER              VOLUME NAME
   local               daleks
   local               the-doctor

.. As the above example demonstrates, both volumes with is-timelord=yes, and is-timelord=no are returned.

先ほどのデモでは、 ``is-timelord=yes`` と ``is-timelord=no`` の両方のボリュームが結果に出ました。

.. Filtering on both key and value of the label, produces the expected result:

ラベルの ``key`` と ``value`` 両方でフィルタすると、期待通りに表示します。

.. code-block:: bash

   $ docker volume ls --filter label=is-timelord=yes
   
   DRIVER              VOLUME NAME
   local               the-doctor

.. Specifying multiple label filter produces an “and” search; all conditions should be met;

複数のラベルフィルタを指定すると、「and」で検索します。つまり、全ての条件に一致するものです。

.. code-block:: bash

   $ docker volume ls --filter label=is-timelord=yes --filter label=is-timelord=no
   
   DRIVER              VOLUME NAME


.. name
.. _volume_ls-name:
name
^^^^^^^^^^

.. The name filter matches on all or part of a volume's name.

``name`` フィルタはボリューム名の全てまたは一部に一致します。

.. The following filter matches all volumes with a name containing the rose string.

以下のフィルタはボリューム名に ``rose`` 文字列を含む全てのボリュームを表示します。

.. code-block:: bash

   $ docker volume ls -f name=rose
   DRIVER              VOLUME NAME
   local               rosemary

.. Formatting
.. _volume_ls-formatting:
表示形式
----------

.. The formatting option (--format) pretty prints configs output using a Go template.

出力形式のオプション（ ``--format`` ）は Go テンプレートを用いて出力を調整し、表示を整えます。

.. Valid placeholders for the Go template are listed below:

有効な Go テンプレートの placeholder は以下の通りです。

.. list-table::
   :header-rows: 1

   * - placeholder
     - 説明
   * - ``.Name``
     - ボリューム名
   * - ``.Driver``
     - ボリュームドライバ
   * - ``.Scope``
     - ボリュームの範囲（local, global）
   * - ``.Mountpoint``
     - ホスト上のボリュームのマウントポイント
   * - ``.Labels``
     - ボリュームに割り当てられた全てのラベル
   * - ``.Label``
     - 対象ボリュームに対するラベルの値を指定。例 ``{{.Label "project.version"}}``


.. When using the --format option, the config ls command will either output the data exactly as the template declares or, when using the table directive, will include column headers as well.

``--format`` オプションを使うと、 ``config ls`` コマンドはテンプレート宣言通りに正確にデータを出力するか、 ``table`` ディレクティブによってヘッダ列も同様に表示するかのいずれかです。

.. The following example uses a template without headers and outputs the ID and Name entries separated by a colon (:) for all images:

以下の例では、ヘッダのないテンプレートを使いますが、全てのイメージに対して ``ID`` と ``Driver`` の項目をコロン ``:`` で分けて表示します。

.. code-block:: bash

   $ docker volume ls --format "{{.Name}}: {{.Driver}}"
   
   vol1: local
   vol2: local
   vol3: local



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

   docker volume ls
      https://docs.docker.com/engine/reference/commandline/volume_ls/
