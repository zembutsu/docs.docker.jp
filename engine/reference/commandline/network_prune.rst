.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/network_prune/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/network_prune.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_network_prune.yaml
.. check date: 2022/03/29
.. Commits on Aug 21, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker network prune

=======================================
docker network prune
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _network_prune-description:

説明
==========

.. Remove all unused networks
使用していないネットワークを全て削除します。

.. Remove one or more networks

1つまたは複数のネットワークを削除します。

.. API 1.21+
   Open the 1.21 API reference (in a new window)
   The client and daemon API must both be at least 1.21 to use this command. Use the docker version command on the client to check your client and daemon API versions.

【API 1.21+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.21 <https://docs.docker.com/engine/api/v1.21/>`_ の必要があります。クライアントとデーモン API のバージョンを調べるには、 ``docker version`` コマンドを使います。

.. _network_prune-usage:

使い方
==========

.. code-block:: bash

   $ docker network prune [OPTIONS]

.. Extended description
.. _network_prune-extended-description:

補足説明
==========

.. Remove all unused networks. Unused networks are those which are not referenced by any containers.

使用していないネットワークを全て削除します。使用していないネットワークとは、どのコンテナあらも参照されていないネットワークを指します。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <network_prune-examples>` をご覧ください。

.. _network_prune-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--filter``
     - 
     - フィルタ値を指定（例： ``until=<timestamp>`` ）
   * - ``--force`` , ``-f``
     - 
     - 確認のプロンプトを表示しない

.. Examples
.. _network_prune-examples:

使用例
==========

.. code-block:: bash

   $ docker network prune
   WARNING! This will remove all custom networks not used by at least one container.
   Are you sure you want to continue? [y/N] y
   Deleted Networks:
   n1
   n2

.. Filtering
.. _network_prune-filtering:
フィルタリング
--------------------

.. The filtering flag (--filter) format is of “key=value”. If there is more than one filter, then pass multiple flags (e.g., --filter "foo=bar" --filter "bif=baz")

フィルタリングのフラグ（ ``--filter`` ）書式は「key=value」です。複数のフィルタがある場合は、フラグを複数回渡します（例 ``--filter "foo=bar" --filter "bif=baz"`` ）。

.. The currently supported filters are:

現在サポートしているフィルタは、こちらです。

..  until (<timestamp>) - only remove networks created before given timestamp
    label (label=<key>, label=<key>=<value>, label!=<key>, or label!=<key>=<value>) - only networks  containers with (or without, in case label!=... is used) the specified labels.

* until （ ``<timestamp>`` まで ） - 指定したタイムスタンプより前に作成したネットワークのみ削除します。
* label （ ``label=<key>`` 、  ``label=<key>=<value>`` 、 ``label!=<key>`` 、 ``label!=<key>=<value>`` ） - 指定したラベルのネットワークのみ削除します（または、 ``label!=...`` が使われる場合は、ラベルがない場合 ）

.. The until filter can be Unix timestamps, date formatted timestamps, or Go duration strings (e.g. 10m, 1h30m) computed relative to the daemon machine’s time. Supported formats for date formatted time stamps include RFC3339Nano, RFC3339, 2006-01-02T15:04:05, 2006-01-02T15:04:05.999999999, 2006-01-02Z07:00, and 2006-01-02. The local timezone on the daemon will be used if you do not provide either a Z or a +-00:00 timezone offset at the end of the timestamp. When providing Unix timestamps enter seconds[.nanoseconds], where seconds is the number of seconds that have elapsed since January 1, 1970 (midnight UTC/GMT), not counting leap seconds (aka Unix epoch or Unix time), and the optional .nanoseconds field is a fraction of a second no more than nine digits long.

``until`` でフィルタできるのは Unix タイムスタンプ、日付形式のタイムスタンプ、あるいはデーモンが動作しているマシン上の時刻からの相対時間を、 Go duration 文字列（例： ``10m`` 、 ``1h3-m`` ）で計算します。日付形式のタイムスタンプがサポートしているのは、RFC3339Nano 、 RFC3339 、 ``2006-01-02T15:04:05`` 、 ``2006-01-02T15:04:05.999999999`` 、 ``2006-01-02Z07:00`` 、 ``2006-01-02`` です。タイムスタンプの最後にタイムゾーンオフセットとして ``Z`` か ``+-00:00`` が指定されなければ、デーモンはローカルのタイムゾーンを使います。Unix タイムスタンプを 秒[.ナノ秒] で指定すると、秒数は 1970 年 1 月 1 日（UTC/GMT 零時）からの経過時間ですが、うるう秒（別名 Unix epoch や Unix time）を含みません。また、オプションで、9桁以上  .ナノ秒 フィールドは省略されます。

.. The label filter accepts two formats. One is the label=... (label=<key> or label=<key>=<value>), which removes networks with the specified labels. The other format is the label!=... (label!=<key> or label!=<key>=<value>), which removes networks without the specified labels.

``label`` フィルタは2つの形式に対応します。1つは ``label=...`` （ ``label=<key>`` または ``label=<key>=<value>`` ）であり、指定したラベルを持つネットワークを削除します。もう1つの形式は ``label!=...`` （ ``label!=<key>`` または ``label!=<key>=<value>`` ）であり、指定たラベルがないネットワークを削除します。

.. The following removes networks created more than 5 minutes ago. Note that system networks such as bridge, host, and none will never be pruned:

以下は5分以上前に作成されたコンテナを削除します。 ``bridge`` 、 ``host`` 、 ``none`` といったシステム・ネットワークは削除できませんので、ご注意ください。

.. code-block:: bash

   $ docker network ls
   
   NETWORK ID          NAME                DRIVER              SCOPE
   7430df902d7a        bridge              bridge              local
   ea92373fd499        foo-1-day-ago       bridge              local
   ab53663ed3c7        foo-1-min-ago       bridge              local
   97b91972bc3b        host                host                local
   f949d337b1f5        none                null                local
   
   $ docker network prune --force --filter until=5m
   
   Deleted Networks:
   foo-1-day-ago
   
   $ docker network ls
   
   NETWORK ID          NAME                DRIVER              SCOPE
   7430df902d7a        bridge              bridge              local
   ab53663ed3c7        foo-1-min-ago       bridge              local
   97b91972bc3b        host                host                local
   f949d337b1f5        none                null                local


.. Parent command

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker network <network>`
     - ネットワークを管理


.. Related commands

関連コマンド
====================

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker network connect <network_connect>`
     - コンテナをネットワークに接続
   * - :doc:`docker network craete <network_create>`
     - ネットワーク作成
   * - :doc:`docker network disconnect <network_disconnect>`
     - ネットワークからコンテナを切断
   * - :doc:`docker network inspect <network_inspect>`
     - 1つまたは複数ネットワークの情報を表示
   * - :doc:`docker network ls <network_ls>`
     - ネットワーク一覧表示
   * - :doc:`docker network prune <network_prune>`
     - 使用していないネットワークを全て削除
   * - :doc:`docker network rm <network_rm>`
     - 1つまたは複数ネットワークの削除


.. seealso:: 

   docker network prune
      https://docs.docker.com/engine/reference/commandline/network_prune/
