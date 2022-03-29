.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/network_ls/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/network_ls.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_network_ls.yaml
.. check date: 2022/03/29
.. Commits on Aug 21, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker network ls

=======================================
docker network ls
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _network_ls-description:

説明
==========

.. List networks

ネットワークを一覧表示します。

.. API 1.21+
   Open the 1.21 API reference (in a new window)
   The client and daemon API must both be at least 1.21 to use this command. Use the docker version command on the client to check your client and daemon API versions.

【API 1.21+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.21 <https://docs.docker.com/engine/api/v1.21/>`_ の必要があります。クライアントとデーモン API のバージョンを調べるには、 ``docker version`` コマンドを使いミズ会う。

.. _network_ls-usage:

使い方
==========

.. code-block:: bash

   $ docker network ls [OPTIONS]

.. Extended description
.. _network_ls-extended-description:

補足説明
==========

.. Lists all the networks the Engine daemon knows about. This includes the networks that span across multiple hosts in a cluster, for example:

Docker エンジンの ``daemon`` が把握している全てのネットワーク一覧を表示します。ネットワークには、複数のホストによるクラスタ上にまたがるネットワークも含まれます。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <network_ls-examples>` をご覧ください。

.. _network_ls-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--filter`` , ``-f``
     - 
     - フィルタの値を指定（例： ``driver=bridge`` ）
   * - ``--format``
     - 
     - Go テンプレートを使ってコンテナの出力を整形
   * - ``--no-trunc``
     - 
     - 出力を省略しない
   * - ``--quiet`` , ``-q``
     - 
     - ネットワーク ID のみ表示

.. Examples
.. _network_ls-examples:

使用例
==========

.. List all networks
.. _network_ls-list-all-networks:
全てのネットワークを一覧表示
------------------------------



.. code-block:: bash

   $ docker network ls
   NETWORK ID          NAME                DRIVER          SCOPE
   7fca4eb8c647        bridge              bridge          local
   9f904ee27bf5        none                null            local
   cf03ee007fb4        host                host            local
   78b03ee04fc4        multi-host          overlay         swarm

.. Use the --no-trunc option to display the full network id:

``--no-trunk`` オプションを使うと、完全なネットワーク ID を表示します。

.. code-block:: bash

   $ docker network ls --no-trunc
   NETWORK ID                                                         NAME                DRIVER           SCOPE
   18a2866682b85619a026c81b98a5e375bd33e1b0936a26cc497c283d27bae9b3   none                null             local
   c288470c46f6c8949c5f7e5099b5b7947b07eabe8d9a27d79a9cbf111adcbf47   host                host             local
   7b369448dccbf865d397c8d2be0cda7cf7edc6b0945f77d2529912ae917a0185   bridge              bridge           local
   95e74588f40db048e86320c6526440c504650a1ff3e9f7d60a497c4d2163e5bd   foo                 bridge           local
   63d1ff1f77b07ca51070a8c227e962238358bd310bde1529cf62e6c307ade161   dev                 bridge           local

.. Filtering
.. _network_ls-filtering:

フィルタリング
--------------------

.. The filtering flag (-f or --filter) format is a key=value pair. If there is more than one filter, then pass multiple flags (e.g. --filter "foo=bar" --filter "bif=baz"). Multiple filter flags are combined as an OR filter. For example, -f type=custom -f type=builtin returns both custom and builtin networks.

フィルタリング・フラグ（ ``-f`` または ``--filter`` ）の書式は ``key=value`` のペアです。フィルタを何回もしたい場合は、複数のフラグを使います（例： ``-filter "foo=bar" --filter "bif=baz"`` ）。複数のフィルタを指定したら、 ``OR`` （同一条件）フィルタとして連結されます。例えば、 ``-f type=custom -f type=builtin`` は ``custom`` と ``builtin``  ネットワークの両方を返します。

.. The currently supported filters are:

現時点でサポートしているフィルタは、次の通りです。

..    id (network’s id)
    label (label=<key> or label=<key>=<value>)
    name (network’s name)
    type (custom|builtin)

* driver
* id （ネットワークID）
* label （ ``label=<キー>`` または ``label=<キー>=<値>`` ）
* name（ネットワーク名）
* scope （ ``swarm`` | ``global`` | ``local`` ）
* type（ ``custom`` | ``builtin`` ）

.. Driver
driver
^^^^^^^^^^

.. The driver filter matches networks based on their driver.

ネットワークが基盤するドライバ名でフィルタします。

.. The following example matches networks with the bridge driver:

以下の例は、 ``bridge`` ドライバに一致するネットワークです。

.. code-block:: bash

   $ docker network ls --filter driver=bridge
   NETWORK ID          NAME                DRIVER            SCOPE
   db9db329f835        test1               bridge            local
   f6e212da9dfd        test2               bridge            local

.. ID
id
^^^^^^^^^^

.. The id filter matches on all or part of a network’s ID.

``id`` フィルタはネットワーク ID の一部もしくは全体と一致します。

.. The following filter matches all networks with an ID containing the 63d1ff1f77b0... string.

以下のフィルタは、コンテナ ID が ``63d1ff1f77b0...`` 文字列に一致する全てのネットワークを表示します。

.. code-block:: bash

   $ docker network ls --filter id=63d1ff1f77b07ca51070a8c227e962238358bd310bde1529cf62e6c307ade161
   NETWORK ID          NAME                DRIVER           SCOPE
   63d1ff1f77b0        dev                 bridge           local

.. You can also filter for a substring in an ID as this shows:

次のように ID の部分一致でもフィルタできます。

.. code-block:: bash

   $ docker network ls --filter id=95e74588f40d
   NETWORK ID          NAME                DRIVER          SCOPE
   95e74588f40d        foo                 bridge          local
   
   $ docker network ls --filter id=95e
   NETWORK ID          NAME                DRIVER          SCOPE
   95e74588f40d        foo                 bridge          local

.. Label
ラベル
^^^^^^^^^^

.. The label filter matches network based on the presence of a label alone or a label and a value.

``label`` フィルタは ``label`` だけ、あるいは ``label`` と値に一致する条件のネットワークでフィルタします。

.. The following filter matches networks with the usage label regardless of its value.

以下のフィルタはラベルの値が ``usage`` に一致するネットワークを表示します。

.. code-block:: bash

   $ docker network ls -f "label=usage"
   NETWORK ID          NAME                DRIVER         SCOPE
   db9db329f835        test1               bridge         local
   f6e212da9dfd        test2               bridge         local

.. The following filter matches networks with the usage label with the prod value.

以下のフィルタは ``usage`` ラベルの値が ``prod`` の値に一致するネットワークを表示します。

.. code-block:: bash

   $ docker network ls -f "label=usage=prod"
   NETWORK ID          NAME                DRIVER        SCOPE
   f6e212da9dfd        test2               bridge        local

.. Name
名前
^^^^^^^^^^

.. The name filter matches on all or part of a network’s name.

``name`` フィルタはネットワーク名の一部もしくは全体に一致します。

.. The following filter matches all networks with a name containing the foobar string.

以下のフィルタは ``foobar`` 文字列を含む全てのネットワーク名でフィルタします。

.. code-block:: bash

   $ docker network ls --filter name=foobar
   NETWORK ID          NAME                DRIVER       SCOPE
   06e7eef0a170        foobar              bridge       local

.. You can also filter for a substring in a name as this shows:

次のように、部分一致でもフィルタできます。

.. code-block:: bash

  $ docker network ls --filter name=foo
  NETWORK ID          NAME                DRIVER       SCOPE
  95e74588f40d        foo                 bridge       local
  06e7eef0a170        foobar              bridge       local


.. Scope
スコープ
^^^^^^^^^^

.. The scope filter matches networks based on their scope.
``scope`` フィルタはネットワーク範囲（scope）に基づいてフィルタします。

.. The following example matches networks with the swarm scope:

以下の例は ``swarm`` スコープに一致するネットワーク名でフィルタします。

.. code-block:: bash

   $ docker network ls --filter scope=swarm
   NETWORK ID          NAME                DRIVER              SCOPE
   xbtm0v4f1lfh        ingress             overlay             swarm
   ic6r88twuu92        swarmnet            overlay             swarm

.. The following example matches networks with the local scope:

以下の例は ``local`` スコープに一致するネットワーク名でフィルタします。

.. code-block:: bash

   $ docker network ls --filter scope=local
   NETWORK ID          NAME                DRIVER              SCOPE
   e85227439ac7        bridge              bridge              local
   0ca0e19443ed        host                host                local
   ca13cc149a36        localnet            bridge              local
   f9e115d2de35        none                null                local

.. Type
タイプ
^^^^^^^^^^

.. The type filter supports two values; builtin displays predefined networks (bridge, none, host), whereas custom displays user defined networks.

``type`` フィルタは２つの値をサポートしています。 ``builtin`` は定義済みネットワーク（ ``bridge`` 、``none`` 、 ``host`` ）を表示します。 ``custom`` はユーザ定義ネットワークを表示します。

.. The following filter matches all user defined networks:

以下のフィルタはユーザ定義ネットワークを全て表示します。

.. code-block:: bash

   $ docker network ls --filter type=custom
   NETWORK ID          NAME                DRIVER       SCOPE
   95e74588f40d        foo                 bridge       local
   63d1ff1f77b0        dev                 bridge       local

.. By having this flag it allows for batch cleanup. For example, use this filter to delete all user defined networks:

このフラグを指定したら、バッチ処理でクリーンアップできます。例えば、全てのユーザ定義ネットワークを削除するには、次のようにします。

.. code-block:: bash

   $ docker network rm `docker network ls --filter type=custom -q`

.. A warning will be issued when trying to remove a network that has containers attached.

コンテナがアタッチされているネットワークを削除しようとしたら、警告が表示されます。

.. _network_ls-formatting:
表示形式
----------

.. The formatting options (--format) pretty-prints networks output using a Go template.

表示形式のオプション（ ``--format`` ）は、Go テンプレートを使ってネットワーク出力を整形します。

.. Valid placeholders for the Go template are listed below:

Go テンプレートで有効なプレースホルダは以下の通りです。


.. list-table::
   :header-rows: 1

   * - placeholder
     - 説明
   * - ``.ID``
     - ネットワーク ID
   * - ``.Name``
     - ネットワーク名
   * - ``.Driver``
     - ネットワーク・ドライバ
   * - ``.Scope``
     - ネットワーク範囲（ ``local``, ``global`` ）
   * - ``.IPv6``
     - ネットワーク上で IPv6 を有効化するかどうか
   * - ``.Internal``
     - ネットワークが内部用かどうか
   * - ``.Labels``
     - ネットワークに割り当てられたラベル全て
   * - ``.Label``
     - ネットワークに指定されたラベルの値。例 ``{{.Label "project.version"}}``
   * - ``.CreatedAt``
     - ネットワークが作成された時刻

.. When using the --format option, the network ls command will either output the data exactly as the template declares or, when using the table directive, includes column headers as well.

``--format`` オプションを指定すると、 ``network ls`` コマンドはテンプレートで宣言した通りにデータを出力するか、 ``table`` 命令を使えばカラム列も同様に表示するかのどちらかです。

.. The following example uses a template without headers and outputs the ID and Driver entries separated by a colon (:) for all networks:

以下の例はヘッダ無しのテンプレートを使い、全てのネットワークに対する ``ID`` と ``Driver`` のエントリをコロン（ ``:`` ）で区切って出力します。

.. code-block:: bash

   $ docker network ls --format "{{.ID}}: {{.Driver}}"
   afaaab448eb2: bridge
   d1584f8dc718: host
   391df270dc66: null

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

   docker network ls
      https://docs.docker.com/engine/reference/commandline/network_ls/
