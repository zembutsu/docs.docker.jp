.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/volume_ls/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/volume_ls.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/volume_ls.md
.. check date: 2016/06/16
.. Commits on Mar 25, 2016 8e9305ef946843ce2f8ef47909d6a866eab5dfa8
.. -------------------------------------------------------------------

.. volume ls

=======================================
volume ls
=======================================

.. code-block:: bash

   使い方: docker volume ls [オプション]
   
   ボリュームの一覧
   
     -f, --filter=[]      次の状況に応じて出力フィルタ:
                          - dangling=<boolean> ボリュームが参照されているかどうか
                          - driver=<string> ボリュームのドライバ名
                          - name=<string> ボリューム名
     --help               使い方の表示
     -q, --quiet          ボリューム名のみ表示

.. Lists all the volumes Docker knows about. You can filter using the -f or --filter flag. The filtering format is a key=value pair. To specify more than one filter, pass multiple flags (for example, --filter "foo=bar" --filter "bif=baz")

.. Docker が把握している全てのボリュームを表示します。 ``-f`` か ``--filter`` フラグを使ってフィルタできます。フィルタリングの形式は ``key=value`` のペアです。１つまたは複数のフィルタを指定するには、複数のフラグを通します（例： ``--filter "foo=bar" --filter "bif=baz"`` ）。

.. There is a single supported filter dangling=value which takes a boolean of true or false.

.. ``dangling=value`` フィルタのみ ``true`` か ``false`` を指定します。


.. Lists all the volumes Docker knows about. You can filter using the -f or --filter flag. Refer to the filtering section for more information about available filter options.

Docker が把握している全てのボリュームを表示します。 ``-f`` か ``--filter`` フラグを使ってフィルタできます。利用可能なフィルタ・オプションに関する情報は :ref:`volume-filtering` のセクションをご覧ください。

.. Example output:

出力例：

.. code-block:: bash

   $ docker volume create --name rose
   rose
   $docker volume create --name tyler
   tyler
   $ docker volume ls
   DRIVER              VOLUME NAME
   local               rose
   local               tyler

.. Filtering

.. _volume-filtering:

フィルタリング
====================

.. The filtering flag (-f or --filter) format is of "key=value". If there is more than one filter, then pass multiple flags (e.g., --filter "foo=bar" --filter "bif=baz")

フィルタリング・フラグ（ ``-f`` か ``--filter`` ）は「key=value」の形式です。フィルタが複数ある場合は、複数回指定します（例： ``--filter "foo=bar" --filter "bif=baz"`` ）。

.. The currently supported filters are:

現時点でサポートしているフィルタ：

..    dangling (boolean - true or false, 0 or 1)
    driver (a volume driver's name)
    name (a volume's name)

* ダングリング（ブール値 - true か false か 0 か 1 ）
* ドライバ（ボリュームのドライバ名）
* 名前（ボリューム名）

.. dangling

ダングリング
--------------------

.. The dangling filter matches on all volumes not referenced by any containers

``dangling`` フィルタはコンテナから参照されていない（dangling＝宙ぶらりんな）ボリュームに一致します。

.. code-block:: bash

   $ docker run -d  -v tyler:/tmpwork  busybox
   f86a7dd02898067079c99ceacd810149060a70528eff3754d0b0f1a93bd0af18
   $ docker volume ls -f dangling=true
   DRIVER              VOLUME NAME
   local               rosemary

.. driver

ドライバ
----------

.. The driver filter matches on all or part of a volume's driver name.

``driver`` フィルタはボリュームのドライバ名の全てまたは一部に一致します。

.. The following filter matches all volumes with a driver name containing the local string.

以下のフィルタはドライバ名に ``local`` 文字列を含む全てのボリュームを表示します。

.. code-block:: bash

   $ docker volume ls -f driver=local
   DRIVER              VOLUME NAME
   local               rosemary
   local               tyler

.. name

名前
----------

.. The name filter matches on all or part of a volume's name.

``name`` フィルタはボリューム名の全てまたは一部に一致します。

.. The following filter matches all volumes with a name containing the rose string.

以下のフィルタはボリューム名に ``rose`` 文字列を含む全てのボリュームを表示します。

.. code-block:: bash

   $ docker volume ls -f name=rose
   DRIVER              VOLUME NAME
   local               rosemary

関連情報
==========

* :doc:`volume_create`
* :doc:`volume_inspect`
* :doc:`volume_rm`
* :doc:`/engine/userguide/containers/dockervolumes`

.. seealso:: 

   volume ls
      https://docs.docker.com/engine/reference/commandline/volume_ls/
