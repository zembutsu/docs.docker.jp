.. *- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/network_ls/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/network_ls.md
   doc version: 1.10
      https://github.com/docker/docker/commits/master/docs/reference/commandline/network_ls.md
.. check date: 2016/02/25
.. Commits on Feb 19, 2016 cdc7f26715fbf0779a5283354048caf9faa1ec4a
.. -------------------------------------------------------------------

.. network ls

=======================================
network ls
=======================================

.. code-block:: bash

   Usage:  docker network ls [OPTIONS]
   
   Lists all the networks created by the user
     -f, --filter=[]       Filter output based on conditions provided
     --help                Print usage
     --no-trunc            Do not truncate the output
     -q, --quiet           Only display numeric IDs

.. Lists all the networks the Engine daemon knows about. This includes the networks that span across multiple hosts in a cluster, for example:

Docker エンジンの ``daemon`` が把握している全てのネットワーク一覧を表示します。ネットワークには、複数のホストによるクラスタ上にまたがるネットワークも含まれます。

.. code-block:: bash

   $ sudo docker network ls
   NETWORK ID          NAME                DRIVER
   7fca4eb8c647        bridge              bridge
   9f904ee27bf5        none                null
   cf03ee007fb4        host                host
   78b03ee04fc4        multi-host          overlay

.. Use the --no-trunc option to display the full network id:

``--no-trunk`` オプションを使うと、完全なネットワーク ID を表示します。

.. code-block:: bash

   docker network ls --no-trunc
   NETWORK ID                                                         NAME                DRIVER
   18a2866682b85619a026c81b98a5e375bd33e1b0936a26cc497c283d27bae9b3   none                null                
   c288470c46f6c8949c5f7e5099b5b7947b07eabe8d9a27d79a9cbf111adcbf47   host                host                
   7b369448dccbf865d397c8d2be0cda7cf7edc6b0945f77d2529912ae917a0185   bridge              bridge              
   95e74588f40db048e86320c6526440c504650a1ff3e9f7d60a497c4d2163e5bd   foo                 bridge    
   63d1ff1f77b07ca51070a8c227e962238358bd310bde1529cf62e6c307ade161   dev                 bridge

.. Filtering

.. _network-ls-filtering:

フィルタリング
====================

.. The filtering flag (-f or --filter) format is a key=value pair. If there is more than one filter, then pass multiple flags (e.g. --filter "foo=bar" --filter "bif=baz"). Multiple filter flags are combined as an OR filter. For example, -f type=custom -f type=builtin returns both custom and builtin networks.

フィルタリング・フラグ（ ``-f`` または ``--filter`` ）の書式は ``key=value`` のペアです。フィルタを何回もしたい場合は、複数のフラグを使います（例： ``-filter "foo=bar" --filter "bif=baz"`` ）。複数のフィルタを指定すると、 ``OR`` （同一条件）フィルタとして連結されます。例えば、 ``-f type=custom -f type=builtin`` は ``custom`` と ``builtin``  ネットワークの両方を返します。

.. The currently supported filters are:

現時点でサポートされているフィルタは、次の通りです。

..    id (network’s id)
    name (network’s name)
    type (custom|builtin)

* ID （ネットワークID）
* 名前（ネットワーク名）
* タイプ（custom|builtin）

.. Type

type
==========

.. The type filter supports two values; builtin displays predefined networks (bridge, none, host), whereas custom displays user defined networks.

``type`` フィルタは２つの値をサポートしています。 ``builtin`` は定義済みネットワーク（ ``bridge`` 、``none`` 、 ``host`` ）を表示します。 ``custom`` はユーザ定義ネットワークを表示します。

.. The following filter matches all user defined networks:

以下のフィルタはユーザ定義ネットワークを全て表示します。

.. code-block:: bash

   $ docker network ls --filter type=custom
   NETWORK ID          NAME                DRIVER
   95e74588f40d        foo                 bridge
   63d1ff1f77b0        dev                 bridge

.. By having this flag it allows for batch cleanup. For example, use this filter to delete all user defined networks:

このフラグを指定すると、バッチ処理でクリーンアップできます。例えば、全てのユーザ定義をネットワークを削除するには、次のようにします。

.. code-block:: bash

   $ docker network rm `docker network ls --filter type=custom -q`

.. A warning will be issued when trying to remove a network that has containers attached.

コンテナがアタッチされているネットワークを削除しようとすると、警告が表示されます。

.. Name

name
----------

.. The name filter matches on all or part of a network’s name.

``name`` フィルタはネットワーク名の一部もしくは全体に一致します。

.. The following filter matches all networks with a name containing the foobar string.

以下のフィルタは ``foobar`` 文字列を含む全てのネットワーク名でフィルタします。

.. code-block:: bash

   $ docker network ls --filter name=foobar
   NETWORK ID          NAME                DRIVER
   06e7eef0a170        foobar              bridge

.. You can also filter for a substring in a name as this shows:

次のように、部分一致でもフィルタできます。

.. code-block:: bash

   $ docker network ls --filter name=foo
   NETWORK ID          NAME                DRIVER
   95e74588f40d        foo                 bridge
   06e7eef0a170        foobar              bridge


.. ID

id
----------

.. The id filter matches on all or part of a network’s ID.

``id`` フィルタはネットワーク ID の一部もしくは全体と一致します。

.. The following filter matches all networks with an ID containing the 63d1ff1f77b0... string.

以下のフィルタは、コンテナ ID が ``63d1ff1f77b0...`` 文字列に一致する全てのネットワークを表示します。

.. code-block:: bash

   $ docker network ls --filter id=63d1ff1f77b07ca51070a8c227e962238358bd310bde1529cf62e6c307ade161
   NETWORK ID          NAME                DRIVER
   63d1ff1f77b0        dev                 bridge

.. You can also filter for a substring in an ID as this shows:

次のように ID の部分一致でもフィルタできます。

.. code-block:: bash

   $ docker network ls --filter id=95e74588f40d
   NETWORK ID          NAME                DRIVER
   95e74588f40d        foo                 bridge
   
   $ docker network ls --filter id=95e
   NETWORK ID          NAME                DRIVER
   95e74588f40d        foo                 bridge

.. Related information

.. _network-ls-related-information:

関連情報
==========

..    network disconnect
    network connect
    network create
    network inspect
    network rm
    Understand Docker container networks

* :doc:`network disconnect <network_disconnect>`
* :doc:`network connect <network_connect>`
* :doc:`network create <network_create>`
* :doc:`network inspect <network_inspect>`
* :doc:`network rm <network_rm>`
* :doc:`Docker コンテナ・ネットワークの理解 </engine/userguide/networking/dockernetworks>`