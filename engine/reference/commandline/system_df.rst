.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/system_df/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/system_df.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_system_df.yaml
.. check date: 2022/04/03
.. Commits on Aug 21, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker system df

=======================================
docker system df
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _system_df-description:

説明
==========

.. Show docker disk usage

docker のディスク使用量を表示します。

.. API 1.25+
   Open the 1.25 API reference (in a new window)
   The client and daemon API must both be at least 1.26 to use this command. Use the docker version command on the client to check your client and daemon API versions.

【API 1.25+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.26 <https://docs.docker.com/engine/api/v1.25/>`_ の必要があります。クライアントとデーモン API のバージョンを調べるには、 ``docker version`` コマンドを使います。


.. _system_df-usage:

使い方
==========

.. code-block:: bash

   $ docker system df [OPTIONS]

.. Extended description
.. _system_df-extended-description:

補足説明
==========

.. The docker system df command displays information regarding the amount of disk space used by the docker daemon.

``docker system df`` コマンドは docker デーモンによって使用されているディスク容量に関する情報を表示します。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <system_df-examples>` をご覧ください。


.. Options
.. _system_df-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--format``
     - 
     - Go テンプレートを使って出力を整形
   * - ``--verbose`` , ``-v``
     - 
     - 使用量の詳細情報を表示


.. Examples
.. _system_df-examples:

使用例
==========

.. By default the command will just show a summary of the data used:

デフォルトのコマンドは、使用しているデータの概要のみを表示します。

.. code-block:: bash

   $ docker system df
   
   TYPE                TOTAL               ACTIVE              SIZE                RECLAIMABLE
   Images              5                   2                   16.43 MB            11.63 MB (70%)
   Containers          2                   0                   212 B               212 B (100%)
   Local Volumes       2                   1                   36 B                0 B (0%)

.. A more detailed view can be requested using the -v, --verbose flag:

``-v`` か ``--verbose`` フラグを使い、より詳しい情報を表示します。

.. code-block:: bash

   $ docker system df -v
   
   Images space usage:
   
   REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE                SHARED SIZE         UNIQUE SIZE         CONTAINERS
   my-curl             latest              b2789dd875bf        6 minutes ago       11 MB               11 MB               5 B                 0
   my-jq               latest              ae67841be6d0        6 minutes ago       9.623 MB            8.991 MB            632.1 kB            0
   <none>              <none>              a0971c4015c1        6 minutes ago       11 MB               11 MB               0 B                 0
   alpine              latest              4e38e38c8ce0        9 weeks ago         4.799 MB            0 B                 4.799 MB            1
   alpine              3.3                 47cf20d8c26c        9 weeks ago         4.797 MB            4.797 MB            0 B                 1
   
   Containers space usage:
   
   CONTAINER ID        IMAGE               COMMAND             LOCAL VOLUMES       SIZE                CREATED             STATUS                      NAMES
   4a7f7eebae0f        alpine:latest       "sh"                1                   0 B                 16 minutes ago      Exited (0) 5 minutes ago    hopeful_yalow
   f98f9c2aa1ea        alpine:3.3          "sh"                1                   212 B               16 minutes ago      Exited (0) 48 seconds ago   anon-vol
   
   Local Volumes space usage:
   
   NAME                                                               LINKS               SIZE
   07c7bdf3e34ab76d921894c2b834f073721fccfbbcba792aa7648e3a7a664c2e   2                   36 B
   my-named-vol                                                  

..    SHARED SIZE is the amount of space that an image shares with another one (i.e. their common data)
    UNIQUE SIZE is the amount of space that is only used by a given image
    SIZE is the virtual size of the image, it is the sum of SHARED SIZE and UNIQUE SIZE

* ``SHARED SIZE`` はイメージが他のイメージと共有している容量（例：それらに共通するデータ）
* ``UNIQUE SIZE`` は対象のイメージのみが使っている容量
* ``SIZE`` イメージの仮想容量であり、 ``SHARED SIZE`` と ``UNIQUE SIZE`` の合計

..     Note
    Network information is not shown because it does not consume disk space.

.. note::

   ネットワーク情報はディスク容量を消費しないため、表示しません。


.. Parent command

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker system<system>`
     - Docker を管理


.. Related commands

関連コマンド
====================

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker system df<system_df>`
     - docker のディスク使用量を表示
   * - :doc:`docker system events<system_events>`
     - サーバからリアルタタイムのイベントを取得
   * - :doc:`docker system info<system_info>`
     - 幅広いシステム情報を表示
   * - :doc:`docker system prune<system_prune>`
     - 使用されていないデータを削除


.. seealso:: 

   docker system df
      https://docs.docker.com/engine/reference/commandline/system_df/
